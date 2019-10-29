Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F79E9013
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 20:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfJ2Tj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 15:39:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731874AbfJ2Tj0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 15:39:26 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5610283F4C
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 19:39:26 +0000 (UTC)
Received: by mail-lf1-f71.google.com with SMTP id o9so2808614lfd.7
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 12:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LPiWhS+g/ovqClLwPSMJfIyTqzArOrHKO9TMIvpx0NE=;
        b=d1HcpKVt4Fh+uWNAeVoy8nDludQqvP4volBrP8msFNBs3hJ0Hyh+MszGG0YlYV8Oq5
         GkUUzSL5mtLDJ/ZA6IGr7zK3wdKXAXC5xLyeJ6Mvjx0xwEdhuSCgvi6HvLds66VDNEwn
         65xDLLKlpuQ4Y6kQ6aALfK1m70zpXefluCrYluDnaAUhGv74CfiJd6xvnXcqiAbFFV4f
         88LKBQR6T2uriXQ/8hq2agpTzXPMko+BzrDBbS0p4lXy+BDfLqJnUiqlEMT2Sq4C7YOA
         NwiVrkZtVr8PchWOYy0sTB/jDgPDrihiWcVb4PXZpFvWTajmbXHdZsqCiJh4ImaO4JV/
         TA+Q==
X-Gm-Message-State: APjAAAVTogzoAsZVKyh3N0a8pEUaK4oKRxom+WsDsQxoK+iziyVXSXfr
        EwobFzDeKtbgegjp9WUNSEPA2SBdqN3ZUl4cDIpahjdI4VjRRn2TlVzqA2L5itrjBXYhIxlisdA
        2VFMaMGNyB+DQ
X-Received: by 2002:ac2:4345:: with SMTP id o5mr3631979lfl.60.1572377964888;
        Tue, 29 Oct 2019 12:39:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMtcJVCtlnDhQq+M5sg9TChG3Lg5XCf4EMz9f1Cdt0Fj4mIl2t0qRso0wFvtsBe650jMVFoA==
X-Received: by 2002:ac2:4345:: with SMTP id o5mr3631969lfl.60.1572377964732;
        Tue, 29 Oct 2019 12:39:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id e26sm6729632ljj.76.2019.10.29.12.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:39:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 753B21818B7; Tue, 29 Oct 2019 20:39:23 +0100 (CET)
Subject: [PATCH bpf-next v4 1/5] libbpf: Fix error handling in
 bpf_map__reuse_fd()
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 29 Oct 2019 20:39:23 +0100
Message-ID: <157237796332.169521.11748939884129413578.stgit@toke.dk>
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

bpf_map__reuse_fd() was calling close() in the error path before returning
an error value based on errno. However, close can change errno, so that can
lead to potentially misleading error messages. Instead, explicitly store
errno in the err variable before each goto.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d71631a01926..ce5ef3ddd263 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1916,16 +1916,22 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 		return -errno;
 
 	new_fd = open("/", O_RDONLY | O_CLOEXEC);
-	if (new_fd < 0)
+	if (new_fd < 0) {
+		err = -errno;
 		goto err_free_new_name;
+	}
 
 	new_fd = dup3(fd, new_fd, O_CLOEXEC);
-	if (new_fd < 0)
+	if (new_fd < 0) {
+		err = -errno;
 		goto err_close_new_fd;
+	}
 
 	err = zclose(map->fd);
-	if (err)
+	if (err) {
+		err = -errno;
 		goto err_close_new_fd;
+	}
 	free(map->name);
 
 	map->fd = new_fd;
@@ -1944,7 +1950,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	close(new_fd);
 err_free_new_name:
 	free(new_name);
-	return -errno;
+	return err;
 }
 
 int bpf_map__resize(struct bpf_map *map, __u32 max_entries)

