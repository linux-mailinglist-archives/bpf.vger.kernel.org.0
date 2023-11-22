Return-Path: <bpf+bounces-15709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D67F5354
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBF6B20E43
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297FA20325;
	Wed, 22 Nov 2023 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxwaB/kv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8501AE
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 14:23:38 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c1c48d7226so297031a12.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700691817; x=1701296617; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d9Z0zE07XUIxOa6vpdef3ArNyljMDifNTElQJ7RMUJ0=;
        b=CxwaB/kvRZmzl/8wOkpABlUaYG7LVfz288QuboezCX0ehj8YRCRbL5D79IrPtEBaMk
         /iP+jB3JhBgGDO4ajSnAeFNkfS1dAweLYB1LvH84wFp9PjdHOakGdutgmqQkxeXGXSQ/
         TPd5lw6Jrr04FI5TnetS2DpH6+1W4UWSCFZ3K177c6wGux723uitJ/gRsLFe62NeXXQN
         TItsLcN4U4IQeSYTbZZP+z4VQGwJuAENgdtCFGMQ34KHdSzu3LURwPmC8jcxO6DEVZ3a
         uzsScNBeWnjxruNpZf9XVFuW+c48VgkwO/+KU/ZVrSPxq2VNyEhpRJtR+g6TXHSoTizt
         586w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691817; x=1701296617;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9Z0zE07XUIxOa6vpdef3ArNyljMDifNTElQJ7RMUJ0=;
        b=piGfDHPmOQFr5ulUvkmhGA2l3T5HasrWuR2G3Uo9ELBBLGKASuIJnQm4rx/3ydZiIP
         lNlKyYmoI39I4Kqo1vf3rj7Dxx6c+IWSNbzTd3Kpu9kWLHh8Vf81XtJITgdJ91W/atus
         eGXYlWoA7BlyOf7jqfCcz24QJ6Yt+0YZyFpSB3bF7g+eWuqhJsxPQZZGXzNWGNJdmti4
         XtNETGJ3/CQ0QAV/guXdLkCWP3xjZlkD1cfTJcm7dGIfvQr3lcY5vrNJXTmrBBsAtuAB
         GhAuEJ6gMeRB8iXE2nPnL0SB+YwRWwURGOdYTJx4VSpQ3xQa5k3OwI1ugpiLZjzCPS3B
         SM7w==
X-Gm-Message-State: AOJu0Yzt2xkSBqwFPB+CYmkVkgbduV9Oi+cFuE4RTu9q299B9fTjxKIi
	eH4cYxYYqbPoyaqJ9DLCaLISQzrRAK9mVNhG4FCcHNhMnfSzJbeQDPTFs+Dw6e68Ngsiz49clcL
	RYYFNphu3uHhjVady2XaWHrolYkWINxtIX8odnWjqU/U1DytQgQ==
X-Google-Smtp-Source: AGHT+IFqwaSuj3OPgIroBPt2rOC2Kuja+f/S+zxDQcsYHu2Duc5oSE+HQptrJbGQA/MKDNFU6x8V2Q8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:4047:0:b0:5c2:2f9:c374 with SMTP id
 n68-20020a634047000000b005c202f9c374mr643470pga.9.1700691817358; Wed, 22 Nov
 2023 14:23:37 -0800 (PST)
Date: Wed, 22 Nov 2023 14:23:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122222335.1799186-1-sdf@google.com>
Subject: [PATCH bpf-next v2 1/2] bpftool: mark orphaned programs during prog show
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
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
        xlated 0B  not jited  memlock 4096B orphaned

[0]: https://lore.kernel.org/all/CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com/

Fixes: ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/prog.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 7ec4f5671e7a..a4f23692c187 100644
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
+		printf(" orphaned");
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


