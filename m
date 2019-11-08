Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB6F59EF
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 22:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfKHVdK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 16:33:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732101AbfKHVdK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 16:33:10 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B87B36898
        for <bpf@vger.kernel.org>; Fri,  8 Nov 2019 21:33:09 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id z26so1552972ljn.5
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 13:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1DCfcPMRcQE3dnKy41Mo12+FWrfPcDfte0JBBQdKuN0=;
        b=ieWHdGkcAIcnMrRCgV0rvbogO3Oqma30N5ZeRdlU0DbKNh5qDFiGBu53sMDndS+RJd
         2CcI6tOkI4QnsgVfcStoyTnzz5+74FHReB1VNJCLg7p7IXsLfYxpALgrUzwRIg/Q+hTi
         s98AeqmaE+GQuQf6TI8cgQhnOYxcLn23SCtQpLCo935JbrBFmCGJiFUq5BprhFfhFXnl
         UBJoyOiBNR4pyJo1P5AUT8UX9SYf6apaTW0TUIcFlAi/3sEa77OKZfHcx7KcJiEieGRY
         Iacn4gnUDdSKfESbilUFvJRC5z64sCL19G/cn66OllnrY6tXcER8BePFYxwR0RZg9NrN
         RtCA==
X-Gm-Message-State: APjAAAUsSN1BNF+tKBJBWiZiKwtphYhDtFITloL3S7/m4y0Jbp854s+7
        Bn8dsT2WTWg2IZCNoD2p5SXt5WJ3CoUUXJrE44HYf/k0Pg6eVnVTQVRanOCWPIzldegTDKzLPqA
        h5MlbKy5KR2Yn
X-Received: by 2002:ac2:53b0:: with SMTP id j16mr864820lfh.187.1573248788087;
        Fri, 08 Nov 2019 13:33:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBKajnrxB/C/5vx2Dim1kbcAJDwar/EJHcoIc5lMigwPb7LmYVBFm7ZvLXAigv6LmfQtKRrg==
X-Received: by 2002:ac2:53b0:: with SMTP id j16mr864809lfh.187.1573248787927;
        Fri, 08 Nov 2019 13:33:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id m28sm2935592ljc.96.2019.11.08.13.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:33:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 53ADF1800CB; Fri,  8 Nov 2019 22:33:06 +0100 (CET)
Subject: [PATCH bpf-next v2 1/6] libbpf: Unpin auto-pinned maps if loading
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
Date:   Fri, 08 Nov 2019 22:33:06 +0100
Message-ID: <157324878624.910124.5124587166846797199.stgit@toke.dk>
In-Reply-To: <157324878503.910124.12936814523952521484.stgit@toke.dk>
References: <157324878503.910124.12936814523952521484.stgit@toke.dk>
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
Acked-by: Song Liu <songliubraving@fb.com>
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

