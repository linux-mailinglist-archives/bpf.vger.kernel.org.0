Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64416457AD2
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhKTDgX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbhKTDgX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:23 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07484C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so10018918pjb.1
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTegrFeQUsJNIDjRXMXL7gGijpoXlGRG/0EFG/ERKU0=;
        b=ni5cgC2xGEReQ+MO7YJoEFzKWqibjAJ0+L/gU28kGA7Vyyijrf3sfqnviovX2eexdE
         p0BMys8OBXhIE0DQfZqw2vYUdu+94QZLmh99CuMpM2XxrjxJgrwGrmKdChY4fk4NcU6N
         N3jQxUmZF4ex6oF2LqBxMULU/C6wLZ+6qe1CbzsoIeuh32+bwR9EQpkXmEnXF/8PVqSX
         SZnnf/mfXBeVC4dtVRbxjYGbh0SrkgzsdF5qz4pErLxopT19uLf+O2x9fDdHrjCFTVZa
         Ba0t+4ACOBxDFGhCHYpQ3mNEzAmjpihAUm5CGZUWy/xCLaOBBClX0+jTZxN+WeAY9nO6
         eouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTegrFeQUsJNIDjRXMXL7gGijpoXlGRG/0EFG/ERKU0=;
        b=tIjOTEtvmHpjsaRRnf98W8DaV9+moQZI44/t6EfoXmfcBDk2fPGDv6TyBXMayg8M61
         xZRFlBnpPVClpNBN6EQx4ovHvxauxOsgi8L+gmokL5nU3vlWBO8NiWgSQRRuAjq2S3eZ
         S1UBr+Xg70k82f7eWJQoEjjK+Zzg1PVJ30drSwQmUb3k+edCF1mUbOJOYqspI9Yl6DDQ
         +7enu2NGpkJp/43UY/a22iElK0qgTFL8+JRk1y3uDgciDz2FepBtkpmFy1MacraLtPR6
         QNf67jOV6P4LjBY4l2nCE+A/PEZpJxZYT2AAmu10bKGSXWZgw2BB0mVQrOw73aOk2Pe8
         M+sA==
X-Gm-Message-State: AOAM532+CHkfvwO/OkDGN4canjKYX2thsOa6bVXtrn2sWMTs5AJuHMkJ
        ei1vj86+luQIu07QVpX1uvMOl0/eAp8=
X-Google-Smtp-Source: ABdhPJzI4dGobTlv+QNqQ2OZxcx42tYWV8i+vDylilSz4Wx1iMS4LJ2/VME7hzFS4VADRXRDLOwmzQ==
X-Received: by 2002:a17:90b:1d8f:: with SMTP id pf15mr6229160pjb.180.1637379200565;
        Fri, 19 Nov 2021 19:33:20 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id t4sm1000904pfq.163.2021.11.19.19.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:33:20 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 08/13] libbpf: Support init of inner maps in light skeleton.
Date:   Fri, 19 Nov 2021 19:32:50 -0800
Message-Id: <20211120033255.91214-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add ability to initialize inner maps in light skeleton.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |  1 +
 tools/lib/bpf/gen_loader.c       | 27 +++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c           |  6 +++---
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 5cbc3e5d3e69..6d8447756509 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -64,5 +64,6 @@ void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum b
 void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
 			    bool is_typeless, int kind, int insn_idx);
 void bpf_gen__record_relo_core(struct bpf_gen *gen, const struct bpf_core_relo *core_relo);
+void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int key, int inner_map_idx);
 
 #endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 4e32fe1f68db..9066d1ae3461 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1063,6 +1063,33 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 	emit_check_err(gen);
 }
 
+void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int slot,
+				 int inner_map_idx)
+{
+	int attr_size = offsetofend(union bpf_attr, flags);
+	int map_update_attr, key;
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_size);
+	pr_debug("gen: populate_outer_map: outer %d key %d inner %d\n",
+		 outer_map_idx, slot, inner_map_idx);
+
+	key = add_data(gen, &slot, sizeof(slot));
+
+	map_update_attr = add_data(gen, &attr, attr_size);
+	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
+		       blob_fd_array_off(gen, outer_map_idx));
+	emit_rel_store(gen, attr_field(map_update_attr, key), key);
+	emit_rel_store(gen, attr_field(map_update_attr, value),
+		       blob_fd_array_off(gen, inner_map_idx));
+
+	/* emit MAP_UPDATE_ELEM command */
+	emit_sys_bpf(gen, BPF_MAP_UPDATE_ELEM, map_update_attr, attr_size);
+	debug_ret(gen, "populate_outer_map outer %d key %d inner %d",
+		  outer_map_idx, slot, inner_map_idx);
+	emit_check_err(gen);
+}
+
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx)
 {
 	int attr_size = offsetofend(union bpf_attr, map_fd);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dbb393768339..af413273c0fb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4977,9 +4977,9 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
 		targ_map = map->init_slots[i];
 		fd = bpf_map__fd(targ_map);
 		if (obj->gen_loader) {
-			pr_warn("// TODO map_update_elem: idx %td key %d value==map_idx %td\n",
-				map - obj->maps, i, targ_map - obj->maps);
-			return -ENOTSUP;
+			bpf_gen__populate_outer_map(obj->gen_loader,
+						    map - obj->maps, i,
+						    targ_map - obj->maps);
 		} else {
 			err = bpf_map_update_elem(map->fd, &i, &fd, 0);
 		}
-- 
2.30.2

