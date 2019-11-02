Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10285ECE46
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2019 12:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKBLJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Nov 2019 07:09:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfKBLJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Nov 2019 07:09:43 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEFF881DE7
        for <bpf@vger.kernel.org>; Sat,  2 Nov 2019 11:09:42 +0000 (UTC)
Received: by mail-lf1-f69.google.com with SMTP id c27so2387845lfj.19
        for <bpf@vger.kernel.org>; Sat, 02 Nov 2019 04:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+jW/dYJDkzLVOL6DU4ltxW50kXMoliTBfkWe79st4dg=;
        b=JyJnmOdRiv1vTpqhWewkC4XRp5KahsHbux37OS83KpUm5GpVFjHCpFMceuXlig4Rzi
         QYM04jnpGt7tzf2YddhfwFRlXtCfsOP3mQwlUj0keqBcYmvWH2cyIk9ErHfXCangcKOt
         z2F/vdL/pq0JTIWLsCAB7cprJ6Km5QKdT+JWN1yZynNf0y+pH8R7F+WC7/oJ9htWxL1+
         ZgNCGfP7s0XZEixzpkNpQev2iaplZjCQ1jL19NSAE2ZEKaQftBbNqdVWmLeLLgU3OgP5
         Wkjf9O1xRKByzgjwm8i3BeW/JWRiFw7HFxgWy8beP2xBp92njww05AnRxpxh0UYagyjR
         /PJQ==
X-Gm-Message-State: APjAAAUqfsEJYPLyOVJIZHpQajfd/YaxhMLOGwGFRexzrXEtQg+3P0sg
        mUmZBB+HJSaaJPZ6tu98tzm9g8ABnuFJZXd6TQFFSOM5PhjniSGF9oR9EAXxwhF8i3l6DpDQ4Z0
        pJCcV3asgybDr
X-Received: by 2002:a05:6512:509:: with SMTP id o9mr4645280lfb.28.1572692981378;
        Sat, 02 Nov 2019 04:09:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+48NugI9YBWke0e+oIaErIpjpA1Q/p8a982e3H8fnv+gKrAZP4YoEkMetZSaXBIFbmCA6Eg==
X-Received: by 2002:a05:6512:509:: with SMTP id o9mr4645275lfb.28.1572692981200;
        Sat, 02 Nov 2019 04:09:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id z20sm3012111ljj.85.2019.11.02.04.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 04:09:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E0FC91818B6; Sat,  2 Nov 2019 12:09:39 +0100 (CET)
Subject: [PATCH bpf-next v6 3/5] libbpf: Move directory creation into _pin()
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
Date:   Sat, 02 Nov 2019 12:09:39 +0100
Message-ID: <157269297985.394725.5882630952992598610.stgit@toke.dk>
In-Reply-To: <157269297658.394725.10672376245672095901.stgit@toke.dk>
References: <157269297658.394725.10672376245672095901.stgit@toke.dk>
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
index 15a7950c3522..dba2c1c56880 100644
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

