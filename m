Return-Path: <bpf+bounces-42346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9EE9A30D0
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 00:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84631F23A5A
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22701D86CD;
	Thu, 17 Oct 2024 22:35:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54E1D5CF9
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204501; cv=none; b=c8WertTU4OITlqZGR+Wws8vf6GJLd/sgTO4mhd+s3sY26A1AXZUevV7E9bC8i+mJro2lK1knZcXjnY6vxsWm3+CqRKAAk8/H/Z9UgFAMMjU5/fgw4Gs4+9I5QYmgyDdbNhFN9bqlaJkvDG+yddau647VvLB10qIWGKiBLS27MNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204501; c=relaxed/simple;
	bh=VcnctrvCSyfUYO4bV0b6c6dSLokLMsgvou7rqVScEkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJq4r/R7u+RGmCYobuthCP6k5ttD8JqkKAbyqY4Y5uYpM0G2hIe01AM2BPC0YqsMQw5KlvbOuens7AzPrfs4Gj3eB4IoP770++8xzGney3HqfWnC23azV/WlSkn6ZSGLokGcT5j5Kgc02ycO0bdtm96kMTmXVpM/vVeXGy9AK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EE9A6A2F07AE; Thu, 17 Oct 2024 15:31:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v5 2/9] bpf: Support private stack for struct_ops programs
Date: Thu, 17 Oct 2024 15:31:48 -0700
Message-ID: <20241017223148.3176403-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017223138.3175885-1-yonghong.song@linux.dev>
References: <20241017223138.3175885-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add 'priv_stack_allowed()' callback function in bpf_verifier_ops. If the
callback function returns true, the struct_ops are eligible to
use private stack. Otherwise, normal kernel stack is used.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6ad8ace7075a..a789cd2f5d6a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -988,6 +988,7 @@ struct bpf_verifier_ops {
 	int (*btf_struct_access)(struct bpf_verifier_log *log,
 				 const struct bpf_reg_state *reg,
 				 int off, int size);
+	bool (*priv_stack_allowed)(void);
 };
=20
 struct bpf_prog_offload_ops {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a12f5e823284..a14857015ad4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5995,6 +5995,8 @@ static bool bpf_enable_private_stack(struct bpf_ver=
ifier_env *env)
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 		return true;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return env->ops->priv_stack_allowed && env->ops->priv_stack_allowed();
 	case BPF_PROG_TYPE_TRACING:
 		if (env->prog->expected_attach_type !=3D BPF_TRACE_ITER)
 			return true;
--=20
2.43.5


