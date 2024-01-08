Return-Path: <bpf+bounces-19185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EF8826FCA
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 14:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CED71C22328
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650BD45954;
	Mon,  8 Jan 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccOaIgJc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6145946
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ccbded5aa4so19644361fa.1
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704720515; x=1705325315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40cXEfsT3AQZRZjpinyQmxm4bk5f/1kPx03yy0k5fSs=;
        b=ccOaIgJckE6PvI+rAsIA0JK8wZ+e4Ao+RdnKK9k+a9QYjwNZO3NoD95keLnthXgjKZ
         Bt59gUYwieiz3ZiUpLc1AXd+HEeNjcrFGxupGBYxYkIyVeM6eylhuiDIcSRfKckkip+D
         TGhLAKGqBemKCFzFrFSbWHDJeJVDiaks91frWhScu9E3bwwB57iRLOP3RT293GsPG8Sr
         XZKrt6fXMhvdjgjApqFZ3mwlOtK1727dZ897MA8DPF2/CsX7fXTPahyDZOwUlFoQb2Lx
         +p2mgVSeXtxNIASqZNOxpZNXGorUJiQfj7I517OTOPddanYSTqA+q9NqlZm1VIhkkyTo
         5Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704720515; x=1705325315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40cXEfsT3AQZRZjpinyQmxm4bk5f/1kPx03yy0k5fSs=;
        b=DzanLJFocWmd2l3wEydzbh4IaXhMFA1FLZvuQ2+2P1nBlFWnGQFL8gqhvji7fvH35Q
         /8O1CV2x3djv3p8dtFQvg9k5PSMvgF5P9USTa2kZX2VhH74xaeFT03Ox6TcKRkcIBYOu
         riyc3eIQXZ1BOz/y+yzCh3ynyyKT2cLkP8NUH8OuPGziFWo0jH5YoiE2nf1GBZeJn/V6
         0xvBMgkekQbIxMikTsEbk4qUA34J4ya5yi4hysVlFOpKYtXl2Txn+HpksLo4je1UKlDt
         OQfB0e2CO99tvOAD0KPFHwnWppV8B1kzA/BEagxHV5oYzUvfIm8/BfSYomgi6JXFcGOe
         F5gA==
X-Gm-Message-State: AOJu0YzKTBJH/fGoxfJqTq2UwBoybVu0PEbj1Yp/h7L56DZJ3X1G4wIe
	2+D7b2gPqHaDDz8wtbzfnc7Br4zDou8=
X-Google-Smtp-Source: AGHT+IEkejAEIFcD4bD2WxXUfgo1CKUvQgGfGRJavVHXZqlx2TDzNmusE31cBIauJItMfVJ29NwbDQ==
X-Received: by 2002:a2e:a37a:0:b0:2cc:e85b:7075 with SMTP id i26-20020a2ea37a000000b002cce85b7075mr1669306ljn.4.1704720514646;
        Mon, 08 Jan 2024 05:28:34 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z3-20020a2ebe03000000b002cd3e2fc054sm1171458ljq.57.2024.01.08.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:28:34 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	zenczykowski@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next 1/3] bpf: simplify try_match_pkt_pointers()
Date: Mon,  8 Jan 2024 15:28:00 +0200
Message-ID: <20240108132802.6103-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108132802.6103-1-eddyz87@gmail.com>
References: <20240108132802.6103-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce number of cases handled in try_match_pkt_pointers()
to <pkt_data> <op> <pkt_end> or <pkt_meta> <op> <pkt_data>
by flipping opcode.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 104 ++++++++++--------------------------------
 1 file changed, 24 insertions(+), 80 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index adbf330d364b..918e6a7912e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14677,6 +14677,9 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 				   struct bpf_verifier_state *this_branch,
 				   struct bpf_verifier_state *other_branch)
 {
+	int opcode = BPF_OP(insn->code);
+	int dst_regno = insn->dst_reg;
+
 	if (BPF_SRC(insn->code) != BPF_X)
 		return false;
 
@@ -14684,90 +14687,31 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	if (BPF_CLASS(insn->code) == BPF_JMP32)
 		return false;
 
-	switch (BPF_OP(insn->code)) {
+	if (dst_reg->type == PTR_TO_PACKET_END ||
+	    src_reg->type == PTR_TO_PACKET_META) {
+		swap(src_reg, dst_reg);
+		dst_regno = insn->src_reg;
+		opcode = flip_opcode(opcode);
+	}
+
+	if ((dst_reg->type != PTR_TO_PACKET ||
+	     src_reg->type != PTR_TO_PACKET_END) &&
+	    (dst_reg->type != PTR_TO_PACKET_META ||
+	     !reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)))
+		return false;
+
+	switch (opcode) {
 	case BPF_JGT:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
-		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
-			/* pkt_data' > pkt_end, pkt_meta' > pkt_data */
-			find_good_pkt_pointers(this_branch, dst_reg,
-					       dst_reg->type, false);
-			mark_pkt_end(other_branch, insn->dst_reg, true);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
-			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
-			/* pkt_end > pkt_data', pkt_data > pkt_meta' */
-			find_good_pkt_pointers(other_branch, src_reg,
-					       src_reg->type, true);
-			mark_pkt_end(this_branch, insn->src_reg, false);
-		} else {
-			return false;
-		}
-		break;
-	case BPF_JLT:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
-		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
-			/* pkt_data' < pkt_end, pkt_meta' < pkt_data */
-			find_good_pkt_pointers(other_branch, dst_reg,
-					       dst_reg->type, true);
-			mark_pkt_end(this_branch, insn->dst_reg, false);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
-			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
-			/* pkt_end < pkt_data', pkt_data > pkt_meta' */
-			find_good_pkt_pointers(this_branch, src_reg,
-					       src_reg->type, false);
-			mark_pkt_end(other_branch, insn->src_reg, true);
-		} else {
-			return false;
-		}
-		break;
 	case BPF_JGE:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
-		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
-			/* pkt_data' >= pkt_end, pkt_meta' >= pkt_data */
-			find_good_pkt_pointers(this_branch, dst_reg,
-					       dst_reg->type, true);
-			mark_pkt_end(other_branch, insn->dst_reg, false);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
-			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
-			/* pkt_end >= pkt_data', pkt_data >= pkt_meta' */
-			find_good_pkt_pointers(other_branch, src_reg,
-					       src_reg->type, false);
-			mark_pkt_end(this_branch, insn->src_reg, true);
-		} else {
-			return false;
-		}
+		/* pkt_data >/>= pkt_end, pkt_meta >/>= pkt_data */
+		find_good_pkt_pointers(this_branch, dst_reg, dst_reg->type, opcode == BPF_JGE);
+		mark_pkt_end(other_branch, dst_regno, opcode == BPF_JGT);
 		break;
+	case BPF_JLT:
 	case BPF_JLE:
-		if ((dst_reg->type == PTR_TO_PACKET &&
-		     src_reg->type == PTR_TO_PACKET_END) ||
-		    (dst_reg->type == PTR_TO_PACKET_META &&
-		     reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) {
-			/* pkt_data' <= pkt_end, pkt_meta' <= pkt_data */
-			find_good_pkt_pointers(other_branch, dst_reg,
-					       dst_reg->type, false);
-			mark_pkt_end(this_branch, insn->dst_reg, true);
-		} else if ((dst_reg->type == PTR_TO_PACKET_END &&
-			    src_reg->type == PTR_TO_PACKET) ||
-			   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
-			    src_reg->type == PTR_TO_PACKET_META)) {
-			/* pkt_end <= pkt_data', pkt_data <= pkt_meta' */
-			find_good_pkt_pointers(this_branch, src_reg,
-					       src_reg->type, true);
-			mark_pkt_end(other_branch, insn->src_reg, false);
-		} else {
-			return false;
-		}
+		/* pkt_data </<= pkt_end, pkt_meta </<= pkt_data */
+		find_good_pkt_pointers(other_branch, dst_reg, dst_reg->type, opcode == BPF_JLT);
+		mark_pkt_end(this_branch, dst_regno, opcode == BPF_JLE);
 		break;
 	default:
 		return false;
-- 
2.43.0


