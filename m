Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3293345B421
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhKXGFr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbhKXGFq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC0C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:37 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iq11so1602871pjb.3
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTegrFeQUsJNIDjRXMXL7gGijpoXlGRG/0EFG/ERKU0=;
        b=GjLJGDxUZlXOIo/OjgMqe13zTm+eK5Z4hjIy7d3WJV6X07TuFbYyGG8pqGu+jQNVpw
         FD8SxiFyOYZx7NNgIRRCi0tAKiBb1flOPtFXzLOiyJ4rxlWgcOXGGavf1VtcpEkbgadj
         RbjfZKkyzrWiGZYKgtsmyc0J+fB40two4I5ZouN6EWiQJwvZg4aj17QBjfggFTn5SYzA
         3QhB03NJBzqGm/DypmjBOketwovlTpSOdEDGvtRD553NS+ofYwQPPRWF0A5vNXZcBsgj
         wDQcqjx4qYUwdFnoZL1MPhuJk6IVOxaeLuGZ3s9Evp/Dt7resr2NF8kTURArJERBVezn
         oxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTegrFeQUsJNIDjRXMXL7gGijpoXlGRG/0EFG/ERKU0=;
        b=J8iAY1vWDWTZeQLe6QCo4voj+whuInGQzfIeL0T2ICPC8OtMZqRCyD7KkkgcCxxKzN
         IZkhnq7xs7PBjxUUqB53cuoq6AdnMbS2fOfK6qO0mKTqQ+dzoNT+HqzOpuDFjAU4jC+E
         ojGKa+u3hUADyQaN6EBdHOkXcea7lqPiUkwRI6KvBXKdJfeSIYRUlCmuapStrsoV2BUn
         saVkcMqxso43Kj2P4EOZr5SK84UmDUtgjKLNNqGl8mKFfWnhQpFenpLuXEqMcLJ4pb7p
         tE36+iXemCiGW/TApLpnTZY/7cG6VApfIG7qL+68q6aajx2Rm8RlopTNKznguONxB50U
         lvAw==
X-Gm-Message-State: AOAM530/qN1siAVLlq3OkVKGG2P68j6c2SeElKhGt6R+blUup7z+9MPG
        vNLVElpd5zreIxwXCmVhhIB2xwhQmJQ=
X-Google-Smtp-Source: ABdhPJwL4roWVJblTNFyNBiYe4xYiSDQYnnkTG2lceQGtKO2Rz9agwXOqnfB8DND/4WrYJ8/LYSWFw==
X-Received: by 2002:a17:90b:33c8:: with SMTP id lk8mr5077068pjb.97.1637733757437;
        Tue, 23 Nov 2021 22:02:37 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id a13sm17377179pfv.99.2021.11.23.22.02.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:37 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 09/16] libbpf: Support init of inner maps in light skeleton.
Date:   Tue, 23 Nov 2021 22:02:02 -0800
Message-Id: <20211124060209.493-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
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

