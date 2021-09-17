Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E434100FF
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244311AbhIQV7I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhIQV7I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:59:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFADC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so8829797pjb.1
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZDr6uQZ5qL+FPm0A39sNcwLZoGCoPIgWRIJ0aPpoH0=;
        b=PjQiNdcr13U3UEf663kwHgbFF01mcxFUpQCLKrWKejwxdC8zSBw5CFFzO6opcwEc71
         maKQFB/1vNUhzQ53sV9qM+lTEGABZ7kqAbyX1PSags3/M0r0sZbkAzQNAFkbN6g4SEct
         Uuh0gFNqZIqUESTc2tqPpTzOIkP9h+/XcPvX9R8uc6fcoSuulAqLGS4fJ8Pnk5FEamug
         FJW7x3L2RzggIr0TyBqqrUe9NXdsxiJHjQV6n60scQVAZYwl9KMAPnwx3350JQMpqjx8
         fZRM0FwizOz3jB3JTXLXWLvf4uR09c6iOOwRdBJZE6nDjVUNlHCmPXlEF6ik+9jtdmQz
         ISMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZDr6uQZ5qL+FPm0A39sNcwLZoGCoPIgWRIJ0aPpoH0=;
        b=MF9zov74DA7bfyg5KoPVM4s1Ij+HTESDGXoEgGjwJt9GR2/pl5lZTMfppoUM4/QAdc
         HY6clQev+JraQnliB7zKa8Fy+PT2oMDfo1rgeVo9vQHvGL49ddKQpvzyQOpLq30cXlTh
         ZxwuXanZRRSMW/vKrbIJFri0mrlw7FV0wWk6aUF5brPoLTr7QLNyHsVw9TDUqOnDrYUk
         xzhWwciJyPGKviFRJHmAQzdSuzBvr+R2ih27K9ghNaty3wMRQc5F1ADZFFmdV/TKf6jK
         ow9bJNs9lylYaiYye5h+gOiC4fNqY5lCpJjAULmRvcXGH4C3/ey+8QeGp7B8LpHs88oA
         6Odw==
X-Gm-Message-State: AOAM5304cJ7vRQ+w9lxFnUTqvxD5jHQOT7Tyarg1wiRDH5HR4mtDb6TA
        0zruDi2Erp1GLmPoxcaVOk4=
X-Google-Smtp-Source: ABdhPJymdlGA2W5lHkEyxtX1TmMnGuowdkIlQjrvJEaG8UXxTMv1OrOyaJV42vMPC7MZNQJnwLSEig==
X-Received: by 2002:a17:902:ab54:b0:13c:9118:8520 with SMTP id ij20-20020a170902ab5400b0013c91188520mr11317162plb.44.1631915865118;
        Fri, 17 Sep 2021 14:57:45 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id y3sm7479438pge.44.2021.09.17.14.57.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:44 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 07/10] libbpf: Support init of inner maps in light skeleton.
Date:   Fri, 17 Sep 2021 14:57:18 -0700
Message-Id: <20210917215721.43491-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add ability to initialize inner maps in light skeleton.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |  1 +
 tools/lib/bpf/gen_loader.c       | 31 +++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c           |  6 +++---
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 1b27faf71080..e7f6ad53aed6 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -49,5 +49,6 @@ void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, int kind, int
 struct bpf_core_relo;
 void bpf_gen__record_relo_core(struct bpf_gen *gen, const struct bpf_core_relo *core_relo,
 			       int insn_idx);
+void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int key, int inner_map_idx);
 
 #endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 28ecd932713b..35f51d837320 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -763,6 +763,37 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
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
+	move_stack2blob(gen, attr_field(map_update_attr, map_fd), 4,
+			stack_off(map_fd[outer_map_idx]));
+	emit_rel_store(gen, attr_field(map_update_attr, key), key);
+
+	emit(gen, BPF_MOV64_REG(BPF_REG_1, BPF_REG_10));
+	emit(gen, BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, stack_off(map_fd[inner_map_idx])));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_2, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, attr_field(map_update_attr, value)));
+	emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 0));
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
index ed2c4f6661fe..b4ebe19c4f6c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4693,9 +4693,9 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
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

