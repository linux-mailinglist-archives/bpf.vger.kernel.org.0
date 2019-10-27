Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBC2E656A
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2019 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfJ0UxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Oct 2019 16:53:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbfJ0UxV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Oct 2019 16:53:21 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B9EA4ACA7
        for <bpf@vger.kernel.org>; Sun, 27 Oct 2019 20:53:20 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id m7so1519231lje.11
        for <bpf@vger.kernel.org>; Sun, 27 Oct 2019 13:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LPiWhS+g/ovqClLwPSMJfIyTqzArOrHKO9TMIvpx0NE=;
        b=jjRIaE0Jyt3K/fRODR+G6bhOSQ9C2bJtVDGXHnwV1Gm1MIbAHT3C9lU/cmBfu7hCAe
         cmK5luU1SU7Lwnj4ZvJk3f4Hfb83HTxD7kmyXbTB9kSQqTHar/dLReNMpsNPac/lbpi2
         TrORT7dQIaOOVcG/9JH/MsmOKSuZRSkUDLNZEmTjZyxO8PCwGdMlUjxUSKkLd7i92QNy
         XqgNvqRirZFB/n0QzA9a1LgL/qcfTKEj7+9OWN5ifDnsH8x6RpbiTO5yEoAeWtzTvEgl
         2eSz2Suq4jhEo8AQ/r0Jk88aPZWcAjcq1qK13iesHH4aPb+meiy3l4Q96GY0ZnWc7Llo
         Ye9w==
X-Gm-Message-State: APjAAAVVHiQUrFnucUhR9fEa18tqwv2ggK7yk8Sal+R2jrZ9w+OSX2sP
        OPfKwlORu08bOGp0p9YOfJ1OYQvEgmPE1AVNefwigWuzishu1rYtrJV9fMKKw+BPoNiGBlowPeu
        dPRuKM2zaSxtR
X-Received: by 2002:ac2:4248:: with SMTP id m8mr9159478lfl.94.1572209598675;
        Sun, 27 Oct 2019 13:53:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzi8JShYQ9iQV+jV7t1EuBO9ihvHYC9nsbBjTwnHhiEGJRLOhBnKF9PKpacncvpOAf5Vgqr5Q==
X-Received: by 2002:ac2:4248:: with SMTP id m8mr9159466lfl.94.1572209598496;
        Sun, 27 Oct 2019 13:53:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 87sm3368296ljs.23.2019.10.27.13.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 13:53:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9E7E41818B7; Sun, 27 Oct 2019 21:53:16 +0100 (CET)
Subject: [PATCH bpf-next v3 1/4] libbpf: Fix error handling in
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
Date:   Sun, 27 Oct 2019 21:53:16 +0100
Message-ID: <157220959657.48922.16752743945805670312.stgit@toke.dk>
In-Reply-To: <157220959547.48922.6623938299823744715.stgit@toke.dk>
References: <157220959547.48922.6623938299823744715.stgit@toke.dk>
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

