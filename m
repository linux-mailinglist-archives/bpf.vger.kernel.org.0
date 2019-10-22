Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4ABE06F5
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfJVPEx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 11:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731403AbfJVPEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 11:04:53 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1238D81DE3
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 15:04:53 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id m22so3030178ljj.6
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 08:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ciExPCFqbR9qQgmZV4xDFev7Gp7/55hrZ+Rtlv4Pddc=;
        b=m3LOHXY60lPjr/o6dzYbfCQ2FV0/Gm0LfaP2xnw/N8baAPrfd2M9aokueiikOE3Pxq
         v2LeBLUJ+XKC6/sALp5FGxjuX5b4xPNCIcL5Mtt7NkLk/R+gWBMR+9c7JDv2LNJClm6m
         4zAti80fYHVq3WWj9FMqnTLNJHY2B6C7ZvdZJ7pd9fCE/inbVbcoMUkhapvtyAVwGTUD
         ExT303sQoWcH3ui1N32jfzFBTFLdiQ4cClnl1apAFdi8/aXHR086cpZL01xdZnDwNraJ
         iwrLcdM/WWN/BS10D1jEaFxqiKGaQ/3MVN/zbsLWN3o3i941OzFh5+A/Tp3YWqtBcfpB
         zIUQ==
X-Gm-Message-State: APjAAAV/eiQljUmNVexKfRny+Nf4KySRfZ8CJpsHSPibmTwtkEe3/Dts
        5WLkStXZwgTz/9fppgrh+aYBmeI6BvCKHett30u9hoDrDCK0y+oHOd5ZW8HDOVF8qh6t5gopXMa
        0b1cZQe9Brf8+
X-Received: by 2002:a2e:8908:: with SMTP id d8mr19025689lji.197.1571756690910;
        Tue, 22 Oct 2019 08:04:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7vNGAEIRBCXlFRJrH7E+cl6/B4SiDQnHCiElKEwEgKHr9MGr1VZ2TLspbxCScv2r0xdJtvw==
X-Received: by 2002:a2e:8908:: with SMTP id d8mr19025666lji.197.1571756690540;
        Tue, 22 Oct 2019 08:04:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v203sm9947341lfa.25.2019.10.22.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:04:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DD84C1804B6; Tue, 22 Oct 2019 17:04:48 +0200 (CEST)
Subject: [PATCH bpf-next 1/3] libbpf: Store map pin path in struct bpf_map
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 22 Oct 2019 17:04:48 +0200
Message-ID: <157175668879.112621.10917994557478417780.stgit@toke.dk>
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

When pinning a map, store the pin path in struct bpf_map so it can be
re-used later for un-pinning. This simplifies the later addition of per-map
pin paths.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cccfd9355134..b4fdd8ee3bbd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -226,6 +226,7 @@ struct bpf_map {
 	void *priv;
 	bpf_map_clear_priv_t clear_priv;
 	enum libbpf_map_type libbpf_type;
+	char *pin_path;
 };
 
 struct bpf_secdata {
@@ -1929,6 +1930,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	if (err)
 		goto err_close_new_fd;
 	free(map->name);
+	zfree(&map->pin_path);
 
 	map->fd = new_fd;
 	map->name = new_name;
@@ -4022,6 +4024,7 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 		return -errno;
 	}
 
+	map->pin_path = strdup(path);
 	pr_debug("pinned map '%s'\n", path);
 
 	return 0;
@@ -4031,6 +4034,9 @@ int bpf_map__unpin(struct bpf_map *map, const char *path)
 {
 	int err;
 
+	if (!path)
+		path = map->pin_path;
+
 	err = check_path(path);
 	if (err)
 		return err;
@@ -4044,6 +4050,7 @@ int bpf_map__unpin(struct bpf_map *map, const char *path)
 	if (err != 0)
 		return -errno;
 	pr_debug("unpinned map '%s'\n", path);
+	zfree(&map->pin_path);
 
 	return 0;
 }
@@ -4088,17 +4095,10 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 
 err_unpin_maps:
 	while ((map = bpf_map__prev(map, obj))) {
-		char buf[PATH_MAX];
-		int len;
-
-		len = snprintf(buf, PATH_MAX, "%s/%s", path,
-			       bpf_map__name(map));
-		if (len < 0)
-			continue;
-		else if (len >= PATH_MAX)
+		if (!map->pin_path)
 			continue;
 
-		bpf_map__unpin(map, buf);
+		bpf_map__unpin(map, NULL);
 	}
 
 	return err;
@@ -4248,6 +4248,7 @@ void bpf_object__close(struct bpf_object *obj)
 
 	for (i = 0; i < obj->nr_maps; i++) {
 		zfree(&obj->maps[i].name);
+		zfree(&obj->maps[i].pin_path);
 		if (obj->maps[i].clear_priv)
 			obj->maps[i].clear_priv(&obj->maps[i],
 						obj->maps[i].priv);

