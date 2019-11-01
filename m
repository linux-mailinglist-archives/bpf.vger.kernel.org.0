Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 485D1EC0D3
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2019 10:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKAJxE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Nov 2019 05:53:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbfKAJxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Nov 2019 05:53:04 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4252683F4C
        for <bpf@vger.kernel.org>; Fri,  1 Nov 2019 09:53:03 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id z15so1655232ljz.4
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2019 02:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9a3/goG98IKkbA6Zt7zLzrgcFHb9x1nP73Y0D8/2iQA=;
        b=TZNMyWngLVJV2ACC4q4HDC7AyrLEwje+k80AYnm+0zEK8WIEG6L/8yJzM8EBjHD0L7
         UBrr1NXXf4sgUYps+qCpaNRn4L8N/u+uDXkwbN9fq1FUGnoNbeuFcweiSht2j1QR1Ns8
         EjfCxBNdo14b1X/kyvR0tvSg58aaLdwj/7hq3by+cqOvoF+M+faYJe2Fsdi3jruyyPk9
         DLiayXo7eZxEpB7irTEubgvXdXp0IYyNb4WnQiSbqlQ4nhEi9Oes1KRIIuAMQc0c8EUN
         qrlmJsE4enN8DB11MJM2IEx38H0uReClKLQIrySIHvY9Yw4G2hf1KvlUwF0A/kYEmACO
         /GHQ==
X-Gm-Message-State: APjAAAV0q95meUMwBOmOItDrjNi9ds24/t53IjMWnxc90zHSYLX8DdcG
        LftVrVN+Y5vStBFMEMdD67pjAkBXTWXvpFfN6XeKjdnXcr7wNYWodXJMTlyQAMEs3QZYHVGxuFN
        GIO4RQtYEOrSi
X-Received: by 2002:ac2:420a:: with SMTP id y10mr6571671lfh.65.1572601981586;
        Fri, 01 Nov 2019 02:53:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/LEN241ScHBfT7jH5hm0N5wrZLdiBiIY4iXbovbPcXwbNZVr5COMruFonmjbhnIO65UGz/w==
X-Received: by 2002:ac2:420a:: with SMTP id y10mr6571658lfh.65.1572601981380;
        Fri, 01 Nov 2019 02:53:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id g7sm2387377lfb.4.2019.11.01.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 02:53:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0270F1818B6; Fri,  1 Nov 2019 10:52:59 +0100 (CET)
Subject: [PATCH bpf-next v5 3/5] libbpf: Move directory creation into _pin()
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
Date:   Fri, 01 Nov 2019 10:52:59 +0100
Message-ID: <157260197987.335202.3234179306306983855.stgit@toke.dk>
In-Reply-To: <157260197645.335202.2393286837980792460.stgit@toke.dk>
References: <157260197645.335202.2393286837980792460.stgit@toke.dk>
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

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |   61 +++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index af40905a9280..0f1ebecad4d4 100644
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

