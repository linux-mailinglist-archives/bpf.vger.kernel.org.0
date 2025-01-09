Return-Path: <bpf+bounces-48476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11FA0826E
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A099168E01
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666A204F73;
	Thu,  9 Jan 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FNrvGCyc"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207823C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459305; cv=none; b=FkeMt0fHzwjF332qpVfmaDmpX+SmQ6t72IYpAIcflmwriurt0fj2D27hmhAJ31SsMgdrrz5DdVibwyUT/KmZDiU6gPuHLWNFYNZu/QjMMvqOa0rTE3ViP4EEOO7nidKByD7Kwgwaw24fFoQtMp826dPt5mu9Bd5kh88MjV6d+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459305; c=relaxed/simple;
	bh=Np+EOIcknfqj3lg5wvt6H+B3QLO4Zfvo76LN1Th4LSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noR9F8MZdKp3MFSSjrUwubDEjkaFGZMIu5wNBJKHvzJYAGykUCpyLJBGZfthyOLlUvPhKMqL+0azRRqvAJD977oy8jVkoDgJxsCTkhpTN2eeyPk/qOeNZ8vP1aDSfy8oL9afxu5IKcRQY6FT3QiP6l6FDh3VFsnPs/kB58OnpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FNrvGCyc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2D816203E39C;
	Thu,  9 Jan 2025 13:48:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D816203E39C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459303;
	bh=RbG1pbaaPzLpzTccpbwSGCwXzsGQTogP63gGgbMtEIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNrvGCycos8h2l3BYSK3inLO7YIny919485zRcpEFcKMT7eCkSvdhPb1QUZi2eKw4
	 dmJE5cjwoMRG87wqKfgkyNva/r/7+F/VdHW3BAHh1LapSPF4YuHHLXG+GmroWFQtcA
	 od7N33bhUSjwX+l+92+34PzDQkDcvgCy9V5gHtMw=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 14/14] bpf: Augment BPF_PROG_LOAD to use in-kernel relocations
Date: Thu,  9 Jan 2025 13:43:56 -0800
Message-ID: <20250109214617.485144-15-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The basic algorithm here is to allow the user to supply a sysfs entry
corresponding to a previously in-kernel relocated elf object, and a
symbol name that they wish to load. From there the loader ignores any
supplied bpf instruction buffers and relies on the in-kernel
representation. However, maps and other associated file descriptors
passed in from userspace are handled as normal.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 56 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ea0401634e752..8159fe75cd359 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2740,9 +2740,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	struct bpf_prog *prog, *dst_prog = NULL;
 	struct btf *attach_btf = NULL;
 	struct bpf_token *token = NULL;
+	struct bpf_obj *obj = NULL;
+	struct bpf_prog_obj *prog_obj = NULL;
 	bool bpf_cap;
-	int err;
+	int err, i;
 	char license[128];
+	char symbol_name[32];
+	struct fd loader_fd;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
@@ -2855,8 +2859,40 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto put_token;
 	}
 
+	if (attr->prog_loader_fd) {
+		loader_fd = fdget(attr->prog_loader_fd);
+		if (!fd_file(loader_fd)) {
+			err = -EBADF;
+			goto put_token;
+		}
+
+		obj = fd_file(loader_fd)->private_data;
+
+		/* copy eBPF program symbol name from user space */
+		if (strncpy_from_bpfptr(symbol_name,
+					make_bpfptr(attr->symbol_loader_name, uattr.is_kernel),
+					sizeof(symbol_name) - 1) < 0)
+			goto put_token;
+
+		symbol_name[sizeof(symbol_name) - 1] = 0;
+
+		for (i = 0; i < obj->nr_programs; i++) {
+			if (strcmp(symbol_name, obj->progs[i].name) == 0) {
+				prog_obj = &obj->progs[i];
+				break;
+			}
+		}
+
+		if (!prog_obj)
+			goto put_token;
+	}
+
 	/* plain bpf_prog allocation */
-	prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
+	if (prog_obj)
+		prog = bpf_prog_alloc(bpf_prog_size(prog_obj->insn_cnt), GFP_USER);
+	else
+		prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
+
 	if (!prog) {
 		if (dst_prog)
 			bpf_prog_put(dst_prog);
@@ -2879,13 +2915,19 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	token = NULL;
 
 	prog->aux->user = get_current_user();
-	prog->len = attr->insn_cnt;
 
 	err = -EFAULT;
-	if (copy_from_bpfptr(prog->insns,
-			     make_bpfptr(attr->insns, uattr.is_kernel),
-			     bpf_prog_insn_size(prog)) != 0)
-		goto free_prog;
+	if (prog_obj) {
+		prog->len = prog_obj->insn_cnt;
+		memcpy(prog->insnsi, prog_obj->insn, prog_obj->insn_cnt * sizeof(struct bpf_insn));
+	} else {
+		prog->len = attr->insn_cnt;
+		if (copy_from_bpfptr(prog->insns,
+				     make_bpfptr(attr->insns, uattr.is_kernel),
+				     bpf_prog_insn_size(prog)) != 0)
+			goto free_prog;
+	}
+
 	/* copy eBPF program license from user space */
 	if (strncpy_from_bpfptr(license,
 				make_bpfptr(attr->license, uattr.is_kernel),
-- 
2.47.1


