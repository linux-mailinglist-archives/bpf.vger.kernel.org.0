Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A7F5C1A
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 01:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfKIAA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 19:00:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfKIAA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 19:00:59 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BB7AC04BE1B
        for <bpf@vger.kernel.org>; Sat,  9 Nov 2019 00:00:58 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id i27so1596733ljb.17
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 16:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=20AKLAE94/qKVgi0tHebMZo1VYkzyGlF9GnXfKUXVeg=;
        b=j/9Smwu6qLzfkmzh9Q6q60vFwhPQy6T0t9s+khUiDhbsc4qIH9oKep2VUdShtvFndW
         HsXwCa/pJiR9THMsTGSHN/VLC6gP4U9T8A4TojV0FFheM7ksNYMsSvqZxFa1mW+Fhrom
         YWwk4WrV5oSm/8aw5aIh11qwvIwYCLMt1B4DzZxMM9Y1DMtMZrKbxAzwOdXwQnouYIGa
         Tv4FZqxYHHlN7M12scqYvMB0CqPyf9h3HkGmlSP/CLSu86q8P5hMJQA7CIEeuyIR2x8A
         o6+6UBL3vR/mDbM7tAKcWzpv2p+BMHHDs9DFflKzsDJf8r8d+meNeDGASQhN/DvvPpKV
         8ZdA==
X-Gm-Message-State: APjAAAUkS8X/02hQyKnwlMhR3jGN2crQMD6gkesnJ/1LSkZcgxxvJNOf
        PGawpfCQDp7sV4PtzhbrqUeA7P4t6KaViWmhEGaJaSEpx1rkTMqDE2VSBzuMppjIZXjnw847w6z
        BrNudAdVCab9t
X-Received: by 2002:a2e:9695:: with SMTP id q21mr5343103lji.206.1573257657183;
        Fri, 08 Nov 2019 16:00:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxNqebQ4/h7kuRCjbMEruO8XhbCQpmYwygPiHeJfrC+8cHtOivuhVctp5qfTWG65CPumGL1w==
X-Received: by 2002:a2e:9695:: with SMTP id q21mr5343095lji.206.1573257657007;
        Fri, 08 Nov 2019 16:00:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id t12sm3042374lfc.73.2019.11.08.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 16:00:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D5EE51800CE; Sat,  9 Nov 2019 01:00:55 +0100 (CET)
Subject: [PATCH bpf-next v3 1/6] libbpf: Unpin auto-pinned maps if loading
 fails
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Sat, 09 Nov 2019 01:00:55 +0100
Message-ID: <157325765579.27401.11576433476621158813.stgit@toke.dk>
In-Reply-To: <157325765467.27401.1930972466188738545.stgit@toke.dk>
References: <157325765467.27401.1930972466188738545.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Since the automatic map-pinning happens during load, it will leave pinned
maps around if the load fails at a later stage. Fix this by unpinning any
pinned maps on cleanup. To avoid unpinning pinned maps that were reused
rather than newly pinned, add a new boolean property on struct bpf_map to
keep track of whether that map was reused or not; and only unpin those maps
that were not reused.

Fixes: 57a00f41644f ("libbpf: Add auto-pinning of maps when loading BPF objects")
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index be4af95d5a2c..a70ade546a73 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -229,6 +229,7 @@ struct bpf_map {
 	enum libbpf_map_type libbpf_type;
 	char *pin_path;
 	bool pinned;
+	bool reused;
 };
 
 struct bpf_secdata {
@@ -1995,6 +1996,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	map->def.map_flags = info.map_flags;
 	map->btf_key_type_id = info.btf_key_type_id;
 	map->btf_value_type_id = info.btf_value_type_id;
+	map->reused = true;
 
 	return 0;
 
@@ -4026,7 +4028,7 @@ int bpf_object__unload(struct bpf_object *obj)
 int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 {
 	struct bpf_object *obj;
-	int err;
+	int err, i;
 
 	if (!attr)
 		return -EINVAL;
@@ -4047,6 +4049,11 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 
 	return 0;
 out:
+	/* unpin any maps that were auto-pinned during load */
+	for (i = 0; i < obj->nr_maps; i++)
+		if (obj->maps[i].pinned && !obj->maps[i].reused)
+			bpf_map__unpin(&obj->maps[i], NULL);
+
 	bpf_object__unload(obj);
 	pr_warn("failed to load object '%s'\n", obj->path);
 	return err;

