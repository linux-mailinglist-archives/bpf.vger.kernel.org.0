Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC4E06FA
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfJVPEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 11:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJVPEz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 11:04:55 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1ADEEC0718BE
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 15:04:54 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id y28so3032156ljn.2
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 08:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xJGk6uan1ZIuqGbQBXV9h17MqXLpVElE9vMJY+LBj1Y=;
        b=QZnd4xS2qGFUMzVl8RtKP9ElsvZBgAO6r69aKgAbLRmyNaSouH4UXYX4pJrPAiOce6
         prIc+JNseArix4pF5wQ4Q/VYwSz5TVzf8NiQQAD7CUMqtGfkRwA1NqBnn3f+n1FEtIoe
         6hbVXj5FewixtUkv0hlubhFMmn9JEc7Qz00BQPtr4OHUpfOUr8qWJABrU23KJEviW/zD
         H7x3cS/PjK2l4kTUve32G3yvm2rmvRGWrh9S65cpwrVpinvheZdYyigT6sPvMLC+z8oZ
         lbSO/FdvHa5CnA6msZMUMdS3o3sqJ+0s4+a4nCwlxXnAqO/VC7QfvoKOn3nfuN2OZqB8
         pvMg==
X-Gm-Message-State: APjAAAUX/XBmfJJp8EFdd7+mmj0MxIThA2IP41If/GB+2Yx+ETJTWkUI
        i+/rEqOu3cdT26p8AqnKpjQgT5SzIbkNSEXOVvFAUd0mw2IjQksvPGG0Xt2KDqRNE9+od99+ybk
        2ozw23b67dEdB
X-Received: by 2002:a19:ac46:: with SMTP id r6mr19187684lfc.127.1571756692596;
        Tue, 22 Oct 2019 08:04:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyVq8WjcETo4/R4+WNYN+Vimr6YNZtwwo/G6ni+fGmsD2pkZfvQDflimgCjBWGUS9aMknI0Ug==
X-Received: by 2002:a19:ac46:: with SMTP id r6mr19187667lfc.127.1571756692344;
        Tue, 22 Oct 2019 08:04:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q16sm8113438lfb.74.2019.10.22.08.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:04:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1B6B71804B6; Tue, 22 Oct 2019 17:04:51 +0200 (CEST)
Subject: [PATCH bpf-next 3/3] libbpf: Add pin option to automount BPF
 filesystem before pinning
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 22 Oct 2019 17:04:51 +0200
Message-ID: <157175669103.112621.7847833678119315310.stgit@toke.dk>
In-Reply-To: <157175668770.112621.17344362302386223623.stgit@toke.dk>
References: <157175668770.112621.17344362302386223623.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

While the current map pinning functions will check whether the pin path is
contained on a BPF filesystem, it does not offer any options to mount the
file system if it doesn't exist. Since we now have pinning options, add a
new one to automount a BPF filesystem at the pinning path if that is not
already pointing at a bpffs.

The mounting logic itself is copied from the iproute2 BPF helper functions.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |    5 ++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aea3916de341..f527224bb211 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -37,6 +37,7 @@
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/vfs.h>
@@ -4072,6 +4073,35 @@ int bpf_map__unpin(struct bpf_map *map, const char *path)
 	return 0;
 }
 
+static int mount_bpf_fs(const char *target)
+{
+	bool bind_done = false;
+
+	while (mount("", target, "none", MS_PRIVATE | MS_REC, NULL)) {
+		if (errno != EINVAL || bind_done) {
+			pr_warning("mount --make-private %s failed: %s\n",
+				   target, strerror(errno));
+			return -1;
+		}
+
+		if (mount(target, target, "none", MS_BIND, NULL)) {
+			pr_warning("mount --bind %s %s failed: %s\n",
+				   target, target, strerror(errno));
+			return -1;
+		}
+
+		bind_done = true;
+	}
+
+	if (mount("bpf", target, "bpf", 0, "mode=0700")) {
+		fprintf(stderr, "mount -t bpf bpf %s failed: %s\n",
+			target, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
 static int get_pin_path(char *buf, size_t buf_len,
 			struct bpf_map *map, struct bpf_object_pin_opts *opts,
 			bool mkdir)
@@ -4102,6 +4132,23 @@ static int get_pin_path(char *buf, size_t buf_len,
 		err = make_dir(path);
 		if (err)
 			return err;
+
+		if (OPTS_GET(opts, mount_bpf_fs, false)) {
+			struct statfs st_fs;
+			char *cp;
+
+			if (statfs(path, &st_fs)) {
+				char errmsg[STRERR_BUFSIZE];
+
+				cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+				pr_warning("failed to statfs %s: %s\n", path, cp);
+				return -errno;
+			}
+			if (st_fs.f_type != BPF_FS_MAGIC &&
+			    mount_bpf_fs(path)) {
+				return -EINVAL;
+			}
+		}
 	}
 
 	len = snprintf(buf, buf_len, "%s/%s", path, bpf_map__name(map));
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2131eeafb18d..76b9a6cc7063 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -143,8 +143,11 @@ struct bpf_object_pin_opts {
 	 * and this type used for all maps instead.
 	 */
 	enum libbpf_pin_type override_type;
+
+	/* Whether to attempt to mount a BPF FS if it's not already mounted */
+	bool mount_bpf_fs;
 };
-#define bpf_object_pin_opts__last_field override_type
+#define bpf_object_pin_opts__last_field mount_bpf_fs
 
 LIBBPF_API int bpf_object__pin_maps(struct bpf_object *obj, const char *path);
 LIBBPF_API int bpf_object__unpin_maps(struct bpf_object *obj,

