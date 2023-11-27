Return-Path: <bpf+bounces-15957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15A7FA8DE
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F658B210B5
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE93C6AC;
	Mon, 27 Nov 2023 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgqw2zp7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230E019A
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:20:59 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cc08c794d6so3690655b3a.1
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 10:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701109258; x=1701714058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydnfnbaZl9nHPWkOGgpx08lDV2EyFsRWeCshoFltBsk=;
        b=jgqw2zp7PVomoZXT5TJe3T2CHV1TnX1ONNnGUQfLI7zof8V7SZaWWDjFDN594jmbGz
         fwrCbt/x3zQKP/2O2lsAQ/lw6UjuBorc9zsKM2Cm3fXJXCnE90fMOJShzi6tx42JkTn+
         oF1nmQ8UjlvJyqdE+hAYbBag9xMoYI05NQ++23Hlz2822HpuUwS3p2hmjLdajMgFXArU
         wwjomTzKRynFD7VLYL44FQH5r+Qv9NHHPc3ROlnFFO0Ku9FP42oPkMM8Emx6UoeNpZLb
         DpAGwyxxJNJ2pvz3Mu4LlbILFDWXgxC3RgvZwJCptWlt35PZ4cmwO0gyQB7lNQTyZqKM
         B8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109258; x=1701714058;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydnfnbaZl9nHPWkOGgpx08lDV2EyFsRWeCshoFltBsk=;
        b=jJU4ZxXd/r/uj6RRiNTkqcUl8Wn2ACfZVFlcXmWjXzHe6IXd12Rj4khUYmCAIWR6h0
         drBSjJzSVsxGxI5ZLC512zKNjXJMFYWorR9iuJyMTQSF1qib1RyAGAkRWZwn502jY1FA
         WCDiwl5paFuZsdylG8cUjzCKO0t8kHP5d8V4763AYN/QdHwal5hKJzGF9WyeOPSYDRkw
         xDbAk5H3tZdbk95w/IW0eEz92rYuwQuOco1kpe80qLWH67FdWwaTQrLCO3fMaA7yvEit
         g4MzEZkq+RNI4GBcpoePNgPe2sCTaDuqypblRfm4vShT/xH0ZYYHd26YoLwqNxB+8SG+
         HrEg==
X-Gm-Message-State: AOJu0YzfMX05ypoT+iCX0yl36LVO1SkjFh6LttX4yeVX74corBtOGJyv
	mD7GlSNTgluvteei8aJXXfTmL5ofDhQZIoqDLuaBhpr1WnIlJ9gJtX0yoHRpvufKkYa/KSz4RxI
	nO8kxgnUWvIRE3BVcaV6GjJ2Pn6DYPgYwgTUB4/yi7XTQ3Z6Y5Q==
X-Google-Smtp-Source: AGHT+IFd+h3OIGKdssuh0l88ywYzoEwmOkvycRbvs1c01oZllUn+hNLFXFkXBPGEh0wjRNXJKDbOx6s=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3911:b0:6c3:9efc:6833 with SMTP id
 fh17-20020a056a00391100b006c39efc6833mr3215705pfb.2.1701109258550; Mon, 27
 Nov 2023 10:20:58 -0800 (PST)
Date: Mon, 27 Nov 2023 10:20:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127182057.1081138-1-sdf@google.com>
Subject: [PATCH bpf-next v3 1/2] bpftool: mark orphaned programs during prog show
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
idr when the offloaded/bound netdev goes away. I was supposed to
take a look and check in [0], but apparently I did not.

Martin points out it might be useful to keep it that way for
observability sake, but we at least need to mark those programs as
unusable.

Mark those programs as 'orphaned' and keep printing the list when
we encounter ENODEV.

0: unspec  tag 0000000000000000
        xlated 0B  not jited  memlock 4096B  orphaned

[0]: https://lore.kernel.org/all/CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com/

v3:
* use two spaces for "  orphaned" (Quentin)

Cc: netdev@vger.kernel.org
Fixes: ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/prog.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 7ec4f5671e7a..feb8e305804f 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -442,7 +442,7 @@ static void print_prog_header_json(struct bpf_prog_info *info, int fd)
 		jsonw_uint_field(json_wtr, "recursion_misses", info->recursion_misses);
 }
 
-static void print_prog_json(struct bpf_prog_info *info, int fd)
+static void print_prog_json(struct bpf_prog_info *info, int fd, bool orphaned)
 {
 	char *memlock;
 
@@ -461,6 +461,7 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 		jsonw_uint_field(json_wtr, "uid", info->created_by_uid);
 	}
 
+	jsonw_bool_field(json_wtr, "orphaned", orphaned);
 	jsonw_uint_field(json_wtr, "bytes_xlated", info->xlated_prog_len);
 
 	if (info->jited_prog_len) {
@@ -527,7 +528,7 @@ static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
 	printf("\n");
 }
 
-static void print_prog_plain(struct bpf_prog_info *info, int fd)
+static void print_prog_plain(struct bpf_prog_info *info, int fd, bool orphaned)
 {
 	char *memlock;
 
@@ -554,6 +555,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 		printf("  memlock %sB", memlock);
 	free(memlock);
 
+	if (orphaned)
+		printf("  orphaned");
+
 	if (info->nr_map_ids)
 		show_prog_maps(fd, info->nr_map_ids);
 
@@ -581,15 +585,15 @@ static int show_prog(int fd)
 	int err;
 
 	err = bpf_prog_get_info_by_fd(fd, &info, &len);
-	if (err) {
+	if (err && err != -ENODEV) {
 		p_err("can't get prog info: %s", strerror(errno));
 		return -1;
 	}
 
 	if (json_output)
-		print_prog_json(&info, fd);
+		print_prog_json(&info, fd, err == -ENODEV);
 	else
-		print_prog_plain(&info, fd);
+		print_prog_plain(&info, fd, err == -ENODEV);
 
 	return 0;
 }
-- 
2.43.0.rc1.413.gea7ed67945-goog


