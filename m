Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3762F3509
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 17:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfKGQwW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 11:52:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbfKGQwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 11:52:22 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1C3DC0568FD
        for <bpf@vger.kernel.org>; Thu,  7 Nov 2019 16:52:21 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id r13so620568ljk.18
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 08:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BDBuQGGuryZdFC2mytmeTsDW60yIijvjdJ6tk9Q7yvk=;
        b=BMxZjZe3rGKLI0vdopdYvYcdzv3PIs8ojJww0jBchEN7Zlj1J826E+PrKpAOluL4rL
         By0Cy2pQmmohoQEfpwx+piEWKORWyUmTblm98ltdnsD12RRmGb3EhEw/AXVO7ZyARXX4
         mJIdW6Wpw5Kk13oEelHS+3kfX+Wi+dRFIWVHt9ovi8cFSbDEE5m6FdZGF6E0ySCBT5Vm
         TGpOCnnB07EE1gBfWzXBryoUmgGQjdA6oB36FJh7dWrcTUAjfCC66rcLijR9Vxux7dpO
         cczUNTQn0oA+wLalpSpwcby2p54G/g3vMFvogLgLIbcIc2FJVS6HsNvblG79dulyOeki
         D0xg==
X-Gm-Message-State: APjAAAXPFRoN6OygqxhxUZg9e6Rt9Cdf+F7SrW7jtS8UPemvYTrndaSM
        VkKpjlNdt8DTTleJd4XmroO4s+god8jw6bAk46ITLvOt1IYLsoWXBvUWtbPZr/ccLIOZpODhMiL
        A9FZ973jFbsx2
X-Received: by 2002:ac2:4357:: with SMTP id o23mr3114241lfl.51.1573145540512;
        Thu, 07 Nov 2019 08:52:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyztUwKn0ZDDZvELT03Vq3JsK1NYnSFM8mYV+q5H4jaBst6pLfxQpAN2R7xa9dkCing0MwB8w==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr3114231lfl.51.1573145540322;
        Thu, 07 Nov 2019 08:52:20 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id m26sm1373508lfc.7.2019.11.07.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:52:19 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 42C881818B6; Thu,  7 Nov 2019 17:52:19 +0100 (CET)
Subject: [PATCH bpf-next 1/6] libbpf: Unpin auto-pinned maps if loading fails
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Thu, 07 Nov 2019 17:52:19 +0100
Message-ID: <157314553913.693412.16341111239421040141.stgit@toke.dk>
In-Reply-To: <157314553801.693412.15522462897300280861.stgit@toke.dk>
References: <157314553801.693412.15522462897300280861.stgit@toke.dk>
User-Agent: StGit/0.20
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
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index be4af95d5a2c..cea61b2ec9d3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -229,6 +229,7 @@ struct bpf_map {
 	enum libbpf_map_type libbpf_type;
 	char *pin_path;
 	bool pinned;
+	bool was_reused;
 };
 
 struct bpf_secdata {
@@ -1995,6 +1996,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	map->def.map_flags = info.map_flags;
 	map->btf_key_type_id = info.btf_key_type_id;
 	map->btf_value_type_id = info.btf_value_type_id;
+	map->was_reused = true;
 
 	return 0;
 
@@ -4007,15 +4009,18 @@ bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
 	return bpf_object__open_mem(obj_buf, obj_buf_sz, &opts);
 }
 
-int bpf_object__unload(struct bpf_object *obj)
+static int __bpf_object__unload(struct bpf_object *obj, bool unpin)
 {
 	size_t i;
 
 	if (!obj)
 		return -EINVAL;
 
-	for (i = 0; i < obj->nr_maps; i++)
+	for (i = 0; i < obj->nr_maps; i++) {
 		zclose(obj->maps[i].fd);
+		if (unpin && obj->maps[i].pinned && !obj->maps[i].was_reused)
+			bpf_map__unpin(&obj->maps[i], NULL);
+	}
 
 	for (i = 0; i < obj->nr_programs; i++)
 		bpf_program__unload(&obj->programs[i]);
@@ -4023,6 +4028,11 @@ int bpf_object__unload(struct bpf_object *obj)
 	return 0;
 }
 
+int bpf_object__unload(struct bpf_object *obj)
+{
+	return __bpf_object__unload(obj, false);
+}
+
 int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 {
 	struct bpf_object *obj;
@@ -4047,7 +4057,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 
 	return 0;
 out:
-	bpf_object__unload(obj);
+	__bpf_object__unload(obj, true);
 	pr_warn("failed to load object '%s'\n", obj->path);
 	return err;
 }

