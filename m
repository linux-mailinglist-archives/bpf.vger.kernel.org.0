Return-Path: <bpf+bounces-55630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C34DA83842
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 07:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069BD3B1EB3
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 05:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718701F2BA4;
	Thu, 10 Apr 2025 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dsoXoiGe"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B64D8C8;
	Thu, 10 Apr 2025 05:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744262904; cv=none; b=hiXoFOE3qC8FTm803/X0DYm+0Lgw1YvfdkzybQkkmqsAo9P/oVs2JNi3Q5q/NqIYtVW3RptF/6XqIfOI4f7a25iZFgYlVUEdpL9q1FGfbzxd/jvGTqt0201xcIGDORBiNHcQUChkdtsed4Yqr7NGnIoP2sQ/Ec54/mS1rpTH9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744262904; c=relaxed/simple;
	bh=r13HzLnnnGYMiA3liGPYfe/3ZdAJuSzluQ91kjJQ0Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oBhRqjgANIrU7gQDIr0iN06DwJBU8926AwQUm0G4KtbQQNTQynRZP+QYCAh7ECDNUCJ/NU8Md8xFx8Jn6ysjTcxcJwuTL+YtXzp0C32dkhR8KrQd4uoJVNfbOGaTdExEnY+idPgQlwC1+RGups01f3S/UGPWG3E2JKMoRk9/eDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dsoXoiGe; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9QsxC
	LTiTjSTysgAZSg7DSX0ieMGdtT108G49aJTHBA=; b=dsoXoiGe+sEOEYuQsxM/8
	tCixFnVWVFhtfWUey7LjAfrfFoyXPpmayTPEF6Ku9E74Kph6btfkKzacGxFY2Zkr
	GDPg9g8djt4hD4BloUPHju+cBZXuNxdojpW+2CXsuUUSWA3EqeN76Or1FEroDXS0
	+z7qm1/olSQrIGnK4kRbAM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCXZjO5VvdnzwkJFQ--.14350S2;
	Thu, 10 Apr 2025 13:27:23 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Fix event name too long error
Date: Thu, 10 Apr 2025 13:27:12 +0800
Message-Id: <20250410052712.206785-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXZjO5VvdnzwkJFQ--.14350S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW7Ww47Gw4xJw1rtw1UKFg_yoW8uw4rpF
	s0yr9Ykr1Yqa12qFZxGr4Fkw1Fkas7GryUKrZrAry3WrsxZ3yUXa1IkFs09r1aq3ykC34a
	vwsa9ry3JF97Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiThUreGf3UTe3pQAAss

From: Feng Yang <yangfeng@kylinos.cn>

If the event name is too long, it will cause an EINVAL error.

The kernel error path is
probes_write
    trace_parse_run_command
        create_or_delete_trace_uprobe
            trace_uprobe_create
                trace_probe_create
                    __trace_uprobe_create
                        traceprobe_parse_event_name
                            else if (len >= MAX_EVENT_NAME_LEN)
Requires less than 64 bytes.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b2591f5cab65..8e48ba99f06c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12227,6 +12227,16 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	return libbpf_err_ptr(err);
 }
 
+static const char *get_last_part(const char *path)
+{
+	const char *last_slash = strrchr(path, '/');
+
+	if (last_slash != NULL)
+		return last_slash + 1;
+	else
+		return path;
+}
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
@@ -12241,7 +12251,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	size_t ref_ctr_off;
 	int pfd, err;
 	bool retprobe, legacy;
-	const char *func_name;
+	const char *func_name, *binary_name;
 
 	if (!OPTS_VALID(opts, bpf_uprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
@@ -12254,6 +12264,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	if (!binary_path)
 		return libbpf_err_ptr(-EINVAL);
 
+	binary_name = get_last_part(binary_path);
 	/* Check if "binary_path" refers to an archive. */
 	archive_sep = strstr(binary_path, "!/");
 	if (archive_sep) {
@@ -12318,7 +12329,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 			return libbpf_err_ptr(-EINVAL);
 
 		gen_uprobe_legacy_event_name(probe_name, sizeof(probe_name),
-					     binary_path, func_offset);
+					     binary_name, func_offset);
 
 		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
-- 
2.43.0


