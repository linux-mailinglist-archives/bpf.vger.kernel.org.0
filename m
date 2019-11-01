Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C503EC0D1
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2019 10:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfKAJxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Nov 2019 05:53:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbfKAJxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Nov 2019 05:53:01 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 959F6A8BB
        for <bpf@vger.kernel.org>; Fri,  1 Nov 2019 09:53:00 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id v16so1642093ljh.11
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2019 02:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LPiWhS+g/ovqClLwPSMJfIyTqzArOrHKO9TMIvpx0NE=;
        b=G1gLnYyYTyxIb8EbmVGq4aHwwUR2bao4xDCZLMAHJPRhoE+B1zIF2LHFJoFqQZe8v7
         JUpMjG3oMjty44Pq0dOZcJ5/ylyFi5W1P5dF2AsRdeHi5iytZ/Z+biaGm3MN0reUogdg
         5VZfoeHvHtCW2KQDtFPLhiTyO8vyNvzxtH3W3p1MdRX120Y9qGrnoUijfrzCsgY4cGLh
         vYWG5b0ft9f1Z5B9JGZy6jSb2DMQ2ipJ6UdnS6HIkz0IE3cFSd3BF6mD+tqC1KH3XXDm
         Roq9Glo6GZkR6IHSUVb0V+iQL41EX7xadvPGr+v8e0weYpsYvfQCXPMBUrBn7zOxDNfb
         JZfg==
X-Gm-Message-State: APjAAAVzlIXFRRR8ypM8Yur6xpXuQeDvjqtkVZdOkaBSFI6LsJdMrEX/
        EZ+NtrckQr6Y6d2BjsFVtWffQoDLRWYd8bU3H4PXSSqn/lCUWdr31XT22UdXt3Q74xMNg70F3ia
        98HED6Lk9R1q3
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr2755119lji.164.1572601979123;
        Fri, 01 Nov 2019 02:52:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTJWY/eKdr47xq3OwOc1hxUXj2ATogaaQlMIR/ar6+bh9CUyfuK/khRhBAVTl11eBQLc/Lng==
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr2755104lji.164.1572601978986;
        Fri, 01 Nov 2019 02:52:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id j2sm2600198lfb.77.2019.11.01.02.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 02:52:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B037F1818B6; Fri,  1 Nov 2019 10:52:57 +0100 (CET)
Subject: [PATCH bpf-next v5 1/5] libbpf: Fix error handling in
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
Date:   Fri, 01 Nov 2019 10:52:57 +0100
Message-ID: <157260197757.335202.2270188893036283879.stgit@toke.dk>
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

