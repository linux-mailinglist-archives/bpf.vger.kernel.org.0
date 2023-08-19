Return-Path: <bpf+bounces-8115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B497816EC
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 05:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD561C20E8E
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C5111A;
	Sat, 19 Aug 2023 03:01:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38051110
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 03:01:53 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2F3C35
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:52 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58d40c2debeso16765357b3.2
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692414111; x=1693018911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERGZmDTVNCHO73ma9l5QDuJvsMPY41RqRGvwz3K7XZc=;
        b=mXfd86ABs1iFt2ciPxo6EDoTEwMYYYUS0PRZ8JGRIykYX3cuXZC4cyXsRfr23696PA
         H3AO5+ko/J865OQmS4jQamXP+Irgm3W3uhR+DWZXuiB3mqyjo6BhV2/K/1ApeI5XS6/w
         Aov8WuQrwVAHUR9Wbl8n9JXdzQYE9a1EWFy8Y9EOiO2lZTlDD97z0xhViKHDXR09x0NU
         9oYK6A1F3sww0XmYGgJz5kMqgFjLX+6EUvjVFNpzLb8ttzJKZ2EnMC+MvcH3NYVgXndM
         YMrt2ciFEo2m7nyB6oq+Gv9jKeFkMVRbDDpXVXsG8DUtEZE674AlGh0QQcYEfbvjbeDD
         eWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414111; x=1693018911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERGZmDTVNCHO73ma9l5QDuJvsMPY41RqRGvwz3K7XZc=;
        b=P7eJU8wJOclIMKmM0eYgY3ol//UayYzfspROrDbiX/o+TjcoDYyKafIFj1fpXYMVoA
         +KQ0FzVZPlG3sC0AKM3JnPBD1QZ+hrWD37nuUfVp2iDgkynawl38PJFUTe6JIMj+3CLS
         fyo6wiyN9PZWsO1TP57arVid2XzeVhB2DbEoMc2SQ8JAyyXVmvyvBKuNfSupsVyBxa0k
         v/x9Yzd0abg5AmadHTOsEHoeZvdeMJNMvS/p9vqS734c/WDUasloYahw76GOIr6A+65A
         BhHdnMSor7N96iWmIiNqbRAOE/aS4+S9zHOAhbg5EMOk3ORky0rQMfv9EMfoDjbu9AzY
         /62w==
X-Gm-Message-State: AOJu0YywksvmAlkBTEJuNhdOQ0uUjllAE8T03NllwGfl82iDm1TFWXNb
	rJRwOnCFFljWiRvn/pQPauaChc3s+v6xAw==
X-Google-Smtp-Source: AGHT+IEOSV0QoV98F3GsVXX48mec6EcQvby0wmKkMPe+yPbM2jfzacXaRDV5bBcXgzK49b6RKYw4PA==
X-Received: by 2002:a0d:d80f:0:b0:589:e7ab:d4e5 with SMTP id a15-20020a0dd80f000000b00589e7abd4e5mr1013887ywe.0.1692414111165;
        Fri, 18 Aug 2023 20:01:51 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a059:9262:e315:4c20])
        by smtp.gmail.com with ESMTPSA id o199-20020a0dccd0000000b005704c4d3579sm903897ywd.40.2023.08.18.20.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:01:50 -0700 (PDT)
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
Subject: [RFC bpf-next v4 4/6] bpf: Prevent BPF programs from access the buffer pointed by user_optval.
Date: Fri, 18 Aug 2023 20:01:41 -0700
Message-Id: <20230819030143.419729-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819030143.419729-1-thinker.li@gmail.com>
References: <20230819030143.419729-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Since the buffer pointed by ctx->optval can be in user space, BPF programs
in kernel space should not access it directly. They should use kfuncs
provided later to access data.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/cgroup.c   | 16 ++++++-
 kernel/bpf/verifier.c | 98 +++++++++++++++++++++----------------------
 2 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b4f37960274d..1b2006dac4d5 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2495,12 +2495,24 @@ static bool cg_sockopt_is_valid_access(int off, int size,
 	case offsetof(struct bpf_sockopt, optval):
 		if (size != sizeof(__u64))
 			return false;
-		info->reg_type = PTR_TO_PACKET;
+		if (prog->aux->sleepable)
+			/* Prohibit access to the memory pointed by optval
+			 * in sleepable programs.
+			 */
+			info->reg_type = PTR_TO_AUX | MEM_USER;
+		else
+			info->reg_type = PTR_TO_AUX;
 		break;
 	case offsetof(struct bpf_sockopt, optval_end):
 		if (size != sizeof(__u64))
 			return false;
-		info->reg_type = PTR_TO_PACKET_END;
+		if (prog->aux->sleepable)
+			/* Prohibit access to the memory pointed by
+			 * optval_end in sleepable programs.
+			 */
+			info->reg_type = PTR_TO_AUX_END | MEM_USER;
+		else
+			info->reg_type = PTR_TO_AUX_END;
 		break;
 	case offsetof(struct bpf_sockopt, retval):
 		if (size != size_default)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 05ab2c7f8798..83731e998b09 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13403,7 +13403,7 @@ static void find_good_pkt_aux_pointers(struct bpf_verifier_state *vstate,
 	 * dst_reg->off is known < MAX_PACKET_OFF, therefore it fits in a u16.
 	 */
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == type && reg->id == dst_reg->id)
+		if (base_type(reg->type) == type && reg->id == dst_reg->id)
 			/* keep the maximum range already checked */
 			reg->range = max(reg->range, new_range);
 	}));
@@ -13958,100 +13958,100 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 
 	switch (BPF_OP(insn->code)) {
 	case BPF_JGT:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_AUX &&
-		     src_reg->type == PTR_TO_AUX_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
+		if ((base_type(dst_reg->type) == PTR_TO_PACKET &&
+		     base_type(src_reg->type) == PTR_TO_PACKET_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_AUX &&
+		     base_type(src_reg->type) == PTR_TO_AUX_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' > pkt_end, pkt_meta' > pkt_data */
 			find_good_pkt_aux_pointers(this_branch, dst_reg,
-						   dst_reg->type, false);
+						   base_type(dst_reg->type), false);
 			mark_pkt_aux_end(other_branch, insn->dst_reg, true);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
-			   (dst_reg->type == PTR_TO_AUX_END &&
-			    src_reg->type == PTR_TO_AUX) ||
+		} else if ((base_type(dst_reg->type) == PTR_TO_PACKET_END &&
+			    base_type(src_reg->type) == PTR_TO_PACKET) ||
+			   (base_type(dst_reg->type) == PTR_TO_AUX_END &&
+			    base_type(src_reg->type) == PTR_TO_AUX) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    base_type(src_reg->type) == PTR_TO_PACKET_META)) {
 			/* pkt_end > pkt_data', pkt_data > pkt_meta' */
 			find_good_pkt_aux_pointers(other_branch, src_reg,
-						   src_reg->type, true);
+						   base_type(src_reg->type), true);
 			mark_pkt_aux_end(this_branch, insn->src_reg, false);
 		} else {
 			return false;
 		}
 		break;
 	case BPF_JLT:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_AUX &&
-		     src_reg->type == PTR_TO_AUX_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
+		if ((base_type(dst_reg->type) == PTR_TO_PACKET &&
+		     base_type(src_reg->type) == PTR_TO_PACKET_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_AUX &&
+		     base_type(src_reg->type) == PTR_TO_AUX_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' < pkt_end, pkt_meta' < pkt_data */
 			find_good_pkt_aux_pointers(other_branch, dst_reg,
-						   dst_reg->type, true);
+						   base_type(dst_reg->type), true);
 			mark_pkt_aux_end(this_branch, insn->dst_reg, false);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
-			   (dst_reg->type == PTR_TO_AUX_END &&
-			    src_reg->type == PTR_TO_AUX) ||
+		} else if ((base_type(dst_reg->type) == PTR_TO_PACKET_END &&
+			    base_type(src_reg->type) == PTR_TO_PACKET) ||
+			   (base_type(dst_reg->type) == PTR_TO_AUX_END &&
+			    base_type(src_reg->type) == PTR_TO_AUX) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    base_type(src_reg->type) == PTR_TO_PACKET_META)) {
 			/* pkt_end < pkt_data', pkt_data > pkt_meta' */
 			find_good_pkt_aux_pointers(this_branch, src_reg,
-						   src_reg->type, false);
+						   base_type(src_reg->type), false);
 			mark_pkt_aux_end(other_branch, insn->src_reg, true);
 		} else {
 			return false;
 		}
 		break;
 	case BPF_JGE:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_AUX &&
-		     src_reg->type == PTR_TO_AUX_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
+		if ((base_type(dst_reg->type) == PTR_TO_PACKET &&
+		     base_type(src_reg->type) == PTR_TO_PACKET_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_AUX &&
+		     base_type(src_reg->type) == PTR_TO_AUX_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' >= pkt_end, pkt_meta' >= pkt_data */
 			find_good_pkt_aux_pointers(this_branch, dst_reg,
-						   dst_reg->type, true);
+						   base_type(dst_reg->type), true);
 			mark_pkt_aux_end(other_branch, insn->dst_reg, false);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
-			   (dst_reg->type == PTR_TO_AUX_END &&
-			    src_reg->type == PTR_TO_AUX) ||
+		} else if ((base_type(dst_reg->type) == PTR_TO_PACKET_END &&
+			    base_type(src_reg->type) == PTR_TO_PACKET) ||
+			   (base_type(dst_reg->type) == PTR_TO_AUX_END &&
+			    base_type(src_reg->type) == PTR_TO_AUX) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    base_type(src_reg->type) == PTR_TO_PACKET_META)) {
 			/* pkt_end >= pkt_data', pkt_data >= pkt_meta' */
 			find_good_pkt_aux_pointers(other_branch, src_reg,
-						   src_reg->type, false);
+						   base_type(src_reg->type), false);
 			mark_pkt_aux_end(this_branch, insn->src_reg, true);
 		} else {
 			return false;
 		}
 		break;
 	case BPF_JLE:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_AUX &&
-		     src_reg->type == PTR_TO_AUX_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
+		if ((base_type(dst_reg->type) == PTR_TO_PACKET &&
+		     base_type(src_reg->type) == PTR_TO_PACKET_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_AUX &&
+		     base_type(src_reg->type) == PTR_TO_AUX_END) ||
+		    (base_type(dst_reg->type) == PTR_TO_PACKET_META &&
 		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
 			/* pkt_data' <= pkt_end, pkt_meta' <= pkt_data */
 			find_good_pkt_aux_pointers(other_branch, dst_reg,
-						   dst_reg->type, false);
+						   base_type(dst_reg->type), false);
 			mark_pkt_aux_end(this_branch, insn->dst_reg, true);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
-			   (dst_reg->type == PTR_TO_AUX_END &&
-			    src_reg->type == PTR_TO_AUX) ||
+		} else if ((base_type(dst_reg->type) == PTR_TO_PACKET_END &&
+			    base_type(src_reg->type) == PTR_TO_PACKET) ||
+			   (base_type(dst_reg->type) == PTR_TO_AUX_END &&
+			    base_type(src_reg->type) == PTR_TO_AUX) ||
 			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
+			    base_type(src_reg->type) == PTR_TO_PACKET_META)) {
 			/* pkt_end <= pkt_data', pkt_data <= pkt_meta' */
 			find_good_pkt_aux_pointers(this_branch, src_reg,
-						   src_reg->type, true);
+						   base_type(src_reg->type), true);
 			mark_pkt_aux_end(other_branch, insn->src_reg, false);
 		} else {
 			return false;
-- 
2.34.1


