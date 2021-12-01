Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A734654D7
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbhLASQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352196AbhLASOe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:14:34 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF19C061756
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:11 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y8so18352623plg.1
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4rMfK6neMwhgriI/J6F8bhbT9hfxo5D8J1Y+YO7YQQ=;
        b=J3aM2L17J5yW+IgJy7DGXHOpHjIVxCT3K6XZfHMEN62lJsVYSJjBCA8Q5xMsu8EVlo
         RBFwN2WDcRFBVk7hGMdh8crtUjS8gGsmOUXr8THi/jXwEQ+PET5yFx2TbmcYEl4dSjgW
         wX3ImvNvz+ad6WMOBlmDNH7iWJVCPncRhhTExGPFnCv414XrpIxPxPq0GbiuGdj2N4js
         Crr5tJrP2PTD6AYq653ST1NJLnC6m/eZH30fZDVZ+Evtv5Vkg3G44YiJqMoBON9tapao
         8CzZiGqbKawzf5NJ98dHez9ynRlosAibD1CChWs3jtG+DV+wyEfF+H2pctVleAxlI51C
         Caag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4rMfK6neMwhgriI/J6F8bhbT9hfxo5D8J1Y+YO7YQQ=;
        b=jgePj2qsAPwskJ1FmMvq7THLYX84pzBhRbiCUzR+5kgVObRuSwsXknk2RYF0brkyc9
         O0PX3NZX3aoQT1/W+LRTbkeFQUoki0wwt+oWecqMAxB5QwfyFzD+APlD+SUKx16ln+06
         zzcVusAZpZmPDSoZU7SLwf6xTATTJ7Q6PjTFA027O9hf1muu79nRfeOdLtWoCCdVNKMZ
         ijrE6DX77tk2mTI2doNdK1ncIctRpbPaoj5kgL739H0o5YcnsqnY+P1UtVbnEV9XwP9Y
         tO+Jw9eA8VgO4/PvJ8A03qRCpVyaOxZvdMU2m0gqtFQIlnXcm/u/r2XFwuRvdYFuqe2g
         Cnuw==
X-Gm-Message-State: AOAM53159mQSZkCzwObSbnX2Lx6s/z4GJVUmNo/ADA+/a7ln6CkrE/xR
        iusjIG9TDaZi3ldqNWUEUTo=
X-Google-Smtp-Source: ABdhPJyN6NF7IAA8d1Aq3x4rGNqJwTAgCN23+y0lQJGZZugGsBLF8GIK15UzE+2YWVGedoALrLWDMA==
X-Received: by 2002:a17:902:d703:b0:144:e012:d550 with SMTP id w3-20020a170902d70300b00144e012d550mr9415756ply.38.1638382271156;
        Wed, 01 Dec 2021 10:11:11 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id i5sm328035pgo.36.2021.12.01.10.11.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:10 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 10/17] libbpf: Support init of inner maps in light skeleton.
Date:   Wed,  1 Dec 2021 10:10:33 -0800
Message-Id: <20211201181040.23337-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
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
index 9d57fa84664b..9dd5f76692ef 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -67,5 +67,6 @@ void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum b
 void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
 			    bool is_typeless, int kind, int insn_idx);
 void bpf_gen__record_relo_core(struct bpf_gen *gen, const struct bpf_core_relo *core_relo);
+void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int key, int inner_map_idx);
 
 #endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 87d385e892ab..ed0e949790da 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1053,6 +1053,33 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
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
index 831c12e00813..1341ce539662 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4971,9 +4971,9 @@ static int init_map_in_map_slots(struct bpf_object *obj, struct bpf_map *map)
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

