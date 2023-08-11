Return-Path: <bpf+bounces-7516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58112778684
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846B61C21134
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C317F8;
	Fri, 11 Aug 2023 04:31:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48EE110C
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 04:31:36 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954F26AE
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:35 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-584034c706dso18496717b3.1
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691728294; x=1692333094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1On4WBu4ktBmJYsqyTQyB5Pq9dtHflwATbA7mIeMEbU=;
        b=IJGCDdoeDuPw/Cap1YoRIgfFaVp6B6Rtjbk1zyD2FbtMmEb8fD/yG6cwOUQw2vhVEU
         +kW1Nd5qDu/bn46HYdLJZNhl6GDYMaPkzDP794VhiKIZ11Pl4LAvsAVkArYYuW68jZ4S
         7tD+s+1fLkhTmkAcqAo54XXPK4/WwBwFlON7GxGRsYj/kxrq5fdKgxc1qRKDOVWdwKaV
         5iIvVM5sbFUta3ISe6i8Bg/iqLtKfntjYvlmKKEYaBBtIadWmd3KkCkLZ3lza8mzmjRw
         r0fbqnZODDzsJZ+NEBB9mNtFhx5FkzalsHviUgwsUV8JATdvjgtQH46FqgHgFWdcogPt
         iD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691728294; x=1692333094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1On4WBu4ktBmJYsqyTQyB5Pq9dtHflwATbA7mIeMEbU=;
        b=LzXz4Glg93rsOBXZkTG8nMJD/oa/keV/cQgsyyoRSAzXalY4RcnpAnpdZlPHcoeYeH
         6NGyUyeAVhX9dEBHeVzToDoH3DW5mslCZKDUlVI7qLSvniwTr1Q3LJHITUpmwjvAW7Mc
         YPZLDMviXN4jIgvoLHFV8cPKlbf/UamKg65RAIGzVPOuqxyQTj2Lar43rYAMnYf6iFm6
         uJNhNgFxUemZct0KbsM0LGxJQL8RpA13xg29sgH/wPNz6dfAgxgd/XGQBjKrcNVACfAL
         O+5yqv9Q5olmud6ETdnDvd7B+ukiVPvUtusc1mY3wmNrr8Z0NbbpeTYUXjWQHEjfw7ej
         2sQQ==
X-Gm-Message-State: AOJu0YyZ8xn56M7EODt3cSAy6hWihrbqbbDKYrqr+3XWfhO88aV/Yzcg
	bru9qbL7gOudwyukpGk2jx+ilSFDwfY0Tg==
X-Google-Smtp-Source: AGHT+IHnPlvPwIh6bmNDlCDyHLhZSXMLcy5+LpAvR4uCLRXB9i4+yTGRjK4e3CW/OYp42JDs2Tpr7A==
X-Received: by 2002:a81:524c:0:b0:56d:4f2e:6f83 with SMTP id g73-20020a81524c000000b0056d4f2e6f83mr867036ywb.4.1691728294321;
        Thu, 10 Aug 2023 21:31:34 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:16da:9387:4176:e970])
        by smtp.gmail.com with ESMTPSA id n15-20020a819c4f000000b00583e52232f1sm767961ywa.112.2023.08.10.21.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 21:31:34 -0700 (PDT)
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
Subject: [RFC bpf-next v2 2/6] bpf: Prevent BPF programs from access the buffer pointed by user_optval.
Date: Thu, 10 Aug 2023 21:31:23 -0700
Message-Id: <20230811043127.1318152-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811043127.1318152-1-thinker.li@gmail.com>
References: <20230811043127.1318152-1-thinker.li@gmail.com>
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

From: Kui-Feng Lee <kuifeng@meta.com>

Since the buffer pointed by ctx->user_optval is in user space, BPF programs
in kernel space should not access it directly.  They should use
bpf_copy_from_user() and bpf_copy_to_user() to move data between user and
kernel space.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/cgroup.c   | 16 +++++++++--
 kernel/bpf/verifier.c | 66 +++++++++++++++++++++----------------------
 2 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 59489d9619a3..5bf3115b265c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2509,12 +2509,24 @@ static bool cg_sockopt_is_valid_access(int off, int size,
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
index fbc0096693e7..ca27be76207a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13364,7 +13364,7 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	 * dst_reg->off is known < MAX_PACKET_OFF, therefore it fits in a u16.
 	 */
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == type && reg->id == dst_reg->id)
+		if (base_type(reg->type) == type && reg->id == dst_reg->id)
 			/* keep the maximum range already checked */
 			reg->range = max(reg->range, new_range);
 	}));
@@ -13917,84 +13917,84 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 
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


