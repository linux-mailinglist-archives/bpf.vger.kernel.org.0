Return-Path: <bpf+bounces-5666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714BC75DA35
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 07:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A9528267C
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878578F66;
	Sat, 22 Jul 2023 05:23:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EB38BEC
	for <bpf@vger.kernel.org>; Sat, 22 Jul 2023 05:23:00 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C338010E5
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:57 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-579ef51428eso30318297b3.2
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690003376; x=1690608176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot1YhCt8WquigjQTD31vi3Dy8oQwbSHNVM/Jan86rVY=;
        b=Z8rAFJEH4D5/3UMlLMZFDTzXgTe77ZWmO9mpyDAm3FXmXbXiuxDtOI5iQTdQJ1Brqx
         r2J6nlgLYC7Pq6gN9YXpQUxk0QhVPYC2IzaTgs2g5BO96jstHZiBsf71h4auXvbehYyF
         laxq8ykslr9gmv8uVVQd95V4SQyWfronM4sXyIIHj9K9k6qmkXJ/UbWwdbmd9XXMGYCz
         vOOYDEmCSr54wyDmeu7gTZn2Iqx0llP1iMLvhIB1P9akP+CFoqWWY/bLB1P6N7yzyRK2
         hdiAxGt3qNE4+FxPT+tURXwVcuU2twoojfm8csadKiRYq0B82U0/GdDKsx5ndxM3yOl2
         pN0w==
X-Gm-Message-State: ABy/qLZ5hGWYkcyficrlZYBNlcB6bCsRjyCrv+7NXqYWcecuaOon47eK
	2gOUM/l3vXkxBFgU5taR8LDM1Q/ifThjQA==
X-Google-Smtp-Source: APBJJlGoDCxpCNpvarOv0mdeHeUdil/v8U1cRPo1E+tK8xlwvRtvv6XugweDrmCnA1QpPmcJjPGdJw==
X-Received: by 2002:a81:6a45:0:b0:56f:ff55:2b7d with SMTP id f66-20020a816a45000000b0056fff552b7dmr2408899ywc.17.1690003376474;
        Fri, 21 Jul 2023 22:22:56 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c289:3eeb:eb78:fe3b])
        by smtp.gmail.com with ESMTPSA id y191-20020a0dd6c8000000b00577335ea38csm1397829ywd.121.2023.07.21.22.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 22:22:56 -0700 (PDT)
From: kuifeng@meta.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [RFC bpf-next 4/5] bpf: Prevent BPF programs from access the buffer pointed by user_optval.
Date: Fri, 21 Jul 2023 22:22:47 -0700
Message-Id: <20230722052248.1062582-5-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722052248.1062582-1-kuifeng@meta.com>
References: <20230722052248.1062582-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

Since the buffer pointed by ctx->user_optval is in user space, BPF programs
in kernel space should not access it directly.  They should use
bpf_copy_from_user() and bpf_copy_to_user() to move data between user and
kernel space.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 kernel/bpf/cgroup.c   |  4 +--
 kernel/bpf/verifier.c | 66 +++++++++++++++++++++----------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index f42e76501e1c..88f3a48ca8d2 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2482,12 +2482,12 @@ static bool cg_sockopt_is_valid_access(int off, int size,
 	case offsetof(struct bpf_sockopt, user_optval):
 		if (size != sizeof(__u64))
 			return false;
-		info->reg_type = PTR_TO_PACKET;
+		info->reg_type = PTR_TO_PACKET | MEM_USER;
 		break;
 	case offsetof(struct bpf_sockopt, user_optval_end):
 		if (size != sizeof(__u64))
 			return false;
-		info->reg_type = PTR_TO_PACKET_END;
+		info->reg_type = PTR_TO_PACKET_END | MEM_USER;
 		break;
 	case offsetof(struct bpf_sockopt, flags):
 		if (size != sizeof(__u32))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53e133525dc1..93463731ccc3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13188,7 +13188,7 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	 * dst_reg->off is known < MAX_PACKET_OFF, therefore it fits in a u16.
 	 */
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == type && reg->id == dst_reg->id)
+		if (base_type(reg->type) == type && reg->id == dst_reg->id)
 			/* keep the maximum range already checked */
 			reg->range = max(reg->range, new_range);
 	}));
@@ -13741,84 +13741,84 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 
 	switch (BPF_OP(insn->code)) {
 	case BPF_JGT:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
+		if ((base_type(dst_reg->type) == PTR_TO_PACKET &&
+		     base_type(src_reg->type) == PTR_TO_PACKET_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' > pkt_end, pkt_meta' > pkt_data */
 			find_good_pkt_pointers(this_branch, dst_reg,
-					       dst_reg->type, false);
+					       base_type(dst_reg->type), false);
 			mark_pkt_end(other_branch, insn->dst_reg, true);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
+		} else if ((base_type(dst_reg->type) == PTR_TO_PACKET_END &&
+			    base_type(src_reg->type) == PTR_TO_PACKET) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    base_type(src_reg->type) == PTR_TO_PACKET_META)) {
 			/* pkt_end > pkt_data', pkt_data > pkt_meta' */
 			find_good_pkt_pointers(other_branch, src_reg,
-					       src_reg->type, true);
+					       base_type(src_reg->type), true);
 			mark_pkt_end(this_branch, insn->src_reg, false);
 		} else {
 			return false;
 		}
 		break;
 	case BPF_JLT:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
+		if ((base_type(dst_reg->type) == PTR_TO_PACKET &&
+		     base_type(src_reg->type) == PTR_TO_PACKET_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' < pkt_end, pkt_meta' < pkt_data */
 			find_good_pkt_pointers(other_branch, dst_reg,
-					       dst_reg->type, true);
+					       base_type(dst_reg->type), true);
 			mark_pkt_end(this_branch, insn->dst_reg, false);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
+		} else if ((base_type(dst_reg->type) == PTR_TO_PACKET_END &&
+			    base_type(src_reg->type) == PTR_TO_PACKET) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    base_type(src_reg->type) == PTR_TO_PACKET_META)) {
 			/* pkt_end < pkt_data', pkt_data > pkt_meta' */
 			find_good_pkt_pointers(this_branch, src_reg,
-					       src_reg->type, false);
+					       base_type(src_reg->type), false);
 			mark_pkt_end(other_branch, insn->src_reg, true);
 		} else {
 			return false;
 		}
 		break;
 	case BPF_JGE:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
+		if ((base_type(dst_reg->type) == PTR_TO_PACKET &&
+		     base_type(src_reg->type) == PTR_TO_PACKET_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' >= pkt_end, pkt_meta' >= pkt_data */
 			find_good_pkt_pointers(this_branch, dst_reg,
-					       dst_reg->type, true);
+					       base_type(dst_reg->type), true);
 			mark_pkt_end(other_branch, insn->dst_reg, false);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
+		} else if ((base_type(dst_reg->type) == PTR_TO_PACKET_END &&
+			    base_type(src_reg->type) == PTR_TO_PACKET) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    base_type(src_reg->type) == PTR_TO_PACKET_META)) {
 			/* pkt_end >= pkt_data', pkt_data >= pkt_meta' */
 			find_good_pkt_pointers(other_branch, src_reg,
-					       src_reg->type, false);
+					       base_type(src_reg->type), false);
 			mark_pkt_end(this_branch, insn->src_reg, true);
 		} else {
 			return false;
 		}
 		break;
 	case BPF_JLE:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
+		if ((base_type(dst_reg->type) == PTR_TO_PACKET &&
+		     base_type(src_reg->type) == PTR_TO_PACKET_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' <= pkt_end, pkt_meta' <= pkt_data */
 			find_good_pkt_pointers(other_branch, dst_reg,
-					       dst_reg->type, false);
+					       base_type(dst_reg->type), false);
 			mark_pkt_end(this_branch, insn->dst_reg, true);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
+		} else if ((base_type(dst_reg->type) == PTR_TO_PACKET_END &&
+			    base_type(src_reg->type) == PTR_TO_PACKET) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    base_type(src_reg->type) == PTR_TO_PACKET_META)) {
 			/* pkt_end <= pkt_data', pkt_data <= pkt_meta' */
 			find_good_pkt_pointers(this_branch, src_reg,
-					       src_reg->type, true);
+					       base_type(src_reg->type), true);
 			mark_pkt_end(other_branch, insn->src_reg, false);
 		} else {
 			return false;
-- 
2.34.1


