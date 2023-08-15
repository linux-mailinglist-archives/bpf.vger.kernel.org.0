Return-Path: <bpf+bounces-7834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDBA77D14E
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01C41C20D3C
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A6217ACA;
	Tue, 15 Aug 2023 17:47:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2B13AFD
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:47:35 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1DBD1
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:34 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c68c79befso2364737b3.3
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692121653; x=1692726453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/2JyvcyhL1PSGWJNY4OwCKZqkgCbGc65Bo2s3xjWGI=;
        b=JGaq3RzEycmmjL1UsWRuKT/rmCvjfThTvPj0bSOciqpbztJfvs5FCksvyD3cbh0dUO
         7vqND2fEkbvpxEkMXwh6KL3RE3uaWKGj0KP6RSA/V38ZgbJ97uDX1s/J8B/wIjofuXJx
         +YVXYy1I+DDZaXqje7mqKFxChIXt2ujlNREMlOEyTtIBH9cVQ7S6BOZLLhg/rP2weL1e
         c/9U9l7yrBT+pjv68m7p7CLUk59fkvW0E49jTbgxiiSlTGzkJJQMFK0hZ8fvq2avLYXW
         S/HPdGYzs7QKqmlX3EQ/FgkqJzrVJICmUpY9vO4F3x/vdKAjMV6d8Fe86GrdMbyhYKH2
         kAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121653; x=1692726453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/2JyvcyhL1PSGWJNY4OwCKZqkgCbGc65Bo2s3xjWGI=;
        b=Q7Zdvw0NcxwYCbpOMepq1pwHPVNJ0PdUpVtxFjQeP2uwl7jcpMh0HRjUS3+k7Cs5Gs
         5JVBOd1iewWXkADkvfpjCNUKL/9jM7obV1xaWYxY0g/9SXLMlxQSF04g9t2uAjTiRF5q
         X/oTZXzwlGtrkSC2wGG2NUS3k1JPTPemI4RXf4M2ntX4l7y86lBdSuHLNlF5/F7edFcH
         ryXkTZV3gkA22Y/oDgNobP5la5hw1u86N/jh3z7lOxAOLA7ZMimkj8F6GHyshiOMBhDe
         0HcFc7sWawgOROpY0b564Jihl+EMFc8sLGIU6Su8aziCUI6+JAvHNKjmF+EvWObP3htJ
         Qggg==
X-Gm-Message-State: AOJu0YyG/pF60B8HK8dpZRoWv/CnGe+hTJfDVxUriFYTQEL/O6d5XGkr
	dcXdoQXdJ9PSujAwl5m4DcgIRF9g+VfJQw==
X-Google-Smtp-Source: AGHT+IH4U3d1wB5eAg8x772p6ltXlqvLqt8ZNl8tns2kdLoxvqzk3luwcxFwYqkR/9b5dsGmzkB2YA==
X-Received: by 2002:a0d:e609:0:b0:589:fb73:d282 with SMTP id p9-20020a0de609000000b00589fb73d282mr6325207ywe.37.1692121653314;
        Tue, 15 Aug 2023 10:47:33 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:84ee:9e38:88fa:8a7b])
        by smtp.gmail.com with ESMTPSA id o128-20020a0dcc86000000b00577139f85dfsm3509404ywd.22.2023.08.15.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 10:47:32 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 3/5] bpf: Prevent BPF programs from access the buffer pointed by user_optval.
Date: Tue, 15 Aug 2023 10:47:10 -0700
Message-Id: <20230815174712.660956-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815174712.660956-1-thinker.li@gmail.com>
References: <20230815174712.660956-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Since the buffer pointed by ctx->user_optval is in user space, BPF programs
in kernel space should not access it directly.  They should use
bpf_copy_from_user() and bpf_copy_to_user() to move data between user and
kernel space.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/cgroup.c   | 16 +++++++++--
 kernel/bpf/verifier.c | 66 +++++++++++++++++++++----------------------
 2 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b977768a28e5..425094e071ba 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2494,12 +2494,24 @@ static bool cg_sockopt_is_valid_access(int off, int size,
 	case offsetof(struct bpf_sockopt, optval):
 		if (size != sizeof(__u64))
 			return false;
-		info->reg_type = PTR_TO_PACKET;
+		if (prog->aux->sleepable)
+			/* Prohibit access to the memory pointed by optval
+			 * in sleepable programs.
+			 */
+			info->reg_type = PTR_TO_PACKET | MEM_USER;
+		else
+			info->reg_type = PTR_TO_PACKET;
 		break;
 	case offsetof(struct bpf_sockopt, optval_end):
 		if (size != sizeof(__u64))
 			return false;
-		info->reg_type = PTR_TO_PACKET_END;
+		if (prog->aux->sleepable)
+			/* Prohibit access to the memory pointed by
+			 * optval_end in sleepable programs.
+			 */
+			info->reg_type = PTR_TO_PACKET_END | MEM_USER;
+		else
+			info->reg_type = PTR_TO_PACKET_END;
 		break;
 	case offsetof(struct bpf_sockopt, retval):
 		if (size != size_default)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61be432b9420..936a171ea976 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13373,7 +13373,7 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	 * dst_reg->off is known < MAX_PACKET_OFF, therefore it fits in a u16.
 	 */
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == type && reg->id == dst_reg->id)
+		if (base_type(reg->type) == type && reg->id == dst_reg->id)
 			/* keep the maximum range already checked */
 			reg->range = max(reg->range, new_range);
 	}));
@@ -13926,84 +13926,84 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 
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


