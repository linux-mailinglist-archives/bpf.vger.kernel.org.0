Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA5E9018
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 20:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbfJ2Tjc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 15:39:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60565 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732161AbfJ2Tj3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 15:39:29 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73F984FCC7
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 19:39:28 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id z15so3470960ljz.4
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 12:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=watl5l9Hc46YHv00s/rDJEG+LS16wfTvsQLclqLIfjk=;
        b=VHye95Cz4oXkwi1lhFIE4siZFXTwJta0eZ9Kt2ZxNCiZKIhnSRuD+DZjxN23AL3Sjs
         LulBIam/03vLpiAcOnVefJ94W3KbRLQkU6EUI/YMG9FATN/7+ShtUm/vlLhCqHJ5wVmg
         3nqIR8G9lvdaVAwWb7lnCnGhfYfM2xYB6qfWvNA6HkSICrH2VQY5LWW8qXJ4xgPYbTMW
         pzfW9eWpBvCqVs2xzlW4xVumGEmcTRSAQD8WM0z1fFYdxcavKbKKXOKGpzxLx7VZ5u7Q
         KVJGCaHyZhANh29Ar1bu7T/YIVSBJE4b8z/saZpe1JTSCUGb4XzIwKCsHkl0PBKaUEk5
         TKlw==
X-Gm-Message-State: APjAAAU2GE8UQsw0FwHBlDc/jKK/fHU7i6UcEDnAo8QuyH9/y4Yixh2k
        bkk60b1iXUvGxqLY3E0ECiqJvTi5JEOzqGX2v9QHr+XS3x+j37GdSkWXsbSPE2uzNZDPgaJX1cn
        PckjIajSvMhRR
X-Received: by 2002:ac2:50d6:: with SMTP id h22mr3566422lfm.155.1572377966985;
        Tue, 29 Oct 2019 12:39:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwPzgQjRLlYKEVZPoRqPjxR1g+KN/ngPnt+jePTQXCAgJ63IeTBTEsOm0zasYKHntK6Cw6WOA==
X-Received: by 2002:ac2:50d6:: with SMTP id h22mr3566415lfm.155.1572377966798;
        Tue, 29 Oct 2019 12:39:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id c71sm15549598ljf.48.2019.10.29.12.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:39:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE6801818B7; Tue, 29 Oct 2019 20:39:25 +0100 (CET)
Subject: [PATCH bpf-next v4 3/5] libbpf: Move directory creation into _pin()
 functions
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 29 Oct 2019 20:39:25 +0100
Message-ID: <157237796564.169521.10850494774906637330.stgit@toke.dk>
In-Reply-To: <157237796219.169521.2129132883251452764.stgit@toke.dk>
References: <157237796219.169521.2129132883251452764.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The existing pin_*() functions all try to create the parent directory
before pinning. Move this check into the per-object _pin() functions
instead. This ensures consistent behaviour when auto-pinning is
added (which doesn't go through the top-level pin_maps() function), at the
cost of a few more calls to mkdir().

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |   61 +++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fd11f6aeb32c..895066393508 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3805,6 +3805,28 @@ int bpf_object__load(struct bpf_object *obj)
 	return bpf_object__load_xattr(&attr);
 }
 
+static int make_parent_dir(const char *path)
+{
+	char *cp, errmsg[STRERR_BUFSIZE];
+	char *dname, *dir;
+	int err = 0;
+
+	dname = strdup(path);
+	if (dname == NULL)
+		return -ENOMEM;
+
+	dir = dirname(dname);
+	if (mkdir(dir, 0700) && errno != EEXIST)
+		err = -errno;
+
+	free(dname);
+	if (err) {
+		cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
+		pr_warn("failed to mkdir %s: %s\n", path, cp);
+	}
+	return err;
+}
+
 static int check_path(const char *path)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
@@ -3841,6 +3863,10 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 	char *cp, errmsg[STRERR_BUFSIZE];
 	int err;
 
+	err = make_parent_dir(path);
+	if (err)
+		return err;
+
 	err = check_path(path);
 	if (err)
 		return err;
@@ -3894,25 +3920,14 @@ int bpf_program__unpin_instance(struct bpf_program *prog, const char *path,
 	return 0;
 }
 
-static int make_dir(const char *path)
-{
-	char *cp, errmsg[STRERR_BUFSIZE];
-	int err = 0;
-
-	if (mkdir(path, 0700) && errno != EEXIST)
-		err = -errno;
-
-	if (err) {
-		cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
-		pr_warn("failed to mkdir %s: %s\n", path, cp);
-	}
-	return err;
-}
-
 int bpf_program__pin(struct bpf_program *prog, const char *path)
 {
 	int i, err;
 
+	err = make_parent_dir(path);
+	if (err)
+		return err;
+
 	err = check_path(path);
 	if (err)
 		return err;
@@ -3933,10 +3948,6 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
 		return bpf_program__pin_instance(prog, path, 0);
 	}
 
-	err = make_dir(path);
-	if (err)
-		return err;
-
 	for (i = 0; i < prog->instances.nr; i++) {
 		char buf[PATH_MAX];
 		int len;
@@ -4059,6 +4070,10 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 		}
 	}
 
+	err = make_parent_dir(map->pin_path);
+	if (err)
+		return err;
+
 	err = check_path(map->pin_path);
 	if (err)
 		return err;
@@ -4153,10 +4168,6 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 		return -ENOENT;
 	}
 
-	err = make_dir(path);
-	if (err)
-		return err;
-
 	bpf_object__for_each_map(map, obj) {
 		char *pin_path = NULL;
 		char buf[PATH_MAX];
@@ -4243,10 +4254,6 @@ int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
 		return -ENOENT;
 	}
 
-	err = make_dir(path);
-	if (err)
-		return err;
-
 	bpf_object__for_each_program(prog, obj) {
 		char buf[PATH_MAX];
 		int len;

