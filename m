Return-Path: <bpf+bounces-13393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23AA7D8E59
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE252822F3
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847638C1A;
	Fri, 27 Oct 2023 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJj3fLkY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5F881F
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:01:12 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BD81AC
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27d0a173e61so1443714a91.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386470; x=1698991270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOAetODyKAZtmGq4juMfnsuGXFtx5PudQ3Ii+cytJu4=;
        b=eJj3fLkY8d1stknlMy8/hkmqd11u/bovm9XNtqxF1AMjDRB7SwBTbRXRhE9QdMvmWP
         GGUeQnNk7AGO3kgPpVo6fpHaStm32ZlMrQEhtrZ6pWPSrqWVX3G/M57ZWVH4hw1kp//1
         yzALvPgkxHPt72k0pcUwnBJ9sxghWDhxD0SmSQ0lyQlZ1oNiTb3OQGs7T+y8vDTM9aXC
         O+gU7n+V75px/c41OnomMbn2tKys8LG52aUS6dlKNd4cZcaO38J01NdTXBRq5Eqz49Qm
         NE/A+hxW03KhwbBCfgNMJz/2e1Cu6cLHqXoQ8RGS0CjD9tS5hbvE4M21XsZgobWKwMJU
         xcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386470; x=1698991270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOAetODyKAZtmGq4juMfnsuGXFtx5PudQ3Ii+cytJu4=;
        b=KZYfIYkuiOF+63R6zGXCovpQApZzaVIZP7F4HgkHb7317/VMoQ3dnN4gBtHl9KDgQF
         pimmkfEb3aDgwR9IufRkvb6eQ7SrnGS1wDNut5fDRp+C7iJBu62V7WS+pBKeSIWAMJrv
         mD6ebhUflUOxYtgd4yUPFxS6M3xGpZXkP3aSA+IR/vfTLohvsrb6Sgel52Wo/XZU26Dq
         Cd1T8gvekf7Zmv27/9mxGEyNr6BtZ5h2fqKrky/VTRP7/qmaU860KbH1Mk+CXldIJaN1
         zpDboa7t5KQso0IBQBUuM/F3j+qViLNAtlb7PeZfysMqHH6xk78by2zsez5aIfYq9YSc
         waQQ==
X-Gm-Message-State: AOJu0YzSQMn0XBz/JxASjqR7+1VYcd46wAiuwcdcAHHbwfqjX8I/J8Zp
	lvPycrbEwVkowd3a8RiC8Fc=
X-Google-Smtp-Source: AGHT+IFKkk/FmkDvRFb2t82GndS2qIQ4DB43yNCvuipJTQpVhZ7laCMccD98YMenu6lbOguM6Rr73Q==
X-Received: by 2002:a17:90a:2d83:b0:27d:2abc:f9c1 with SMTP id p3-20020a17090a2d8300b0027d2abcf9c1mr1598389pjd.20.1698386469984;
        Thu, 26 Oct 2023 23:01:09 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.47])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a1fc200b00277337818afsm1113667pjz.0.2023.10.26.23.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:01:09 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/8] LoongArch: Add more instruction opcodes and emit_* helpers
Date: Thu, 26 Oct 2023 18:43:30 +0000
Message-Id: <20231026184337.563801-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026184337.563801-1-hengqi.chen@gmail.com>
References: <20231026184337.563801-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds more instruction opcodes and their corresponding
emit_* helpers which will be used in later patches.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/include/asm/inst.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 71e1ed4165c8..5350ae9ee380 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -65,6 +65,8 @@ enum reg2_op {
 	revbd_op	= 0x0f,
 	revh2w_op	= 0x10,
 	revhd_op	= 0x11,
+	extwh_op	= 0x16,
+	extwb_op	= 0x17,
 };
 
 enum reg2i5_op {
@@ -556,6 +558,8 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 DEF_EMIT_REG2_FORMAT(revb2h, revb2h_op)
 DEF_EMIT_REG2_FORMAT(revb2w, revb2w_op)
 DEF_EMIT_REG2_FORMAT(revbd, revbd_op)
+DEF_EMIT_REG2_FORMAT(extwh, extwh_op)
+DEF_EMIT_REG2_FORMAT(extwb, extwb_op)
 
 #define DEF_EMIT_REG2I5_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
@@ -607,6 +611,9 @@ DEF_EMIT_REG2I12_FORMAT(lu52id, lu52id_op)
 DEF_EMIT_REG2I12_FORMAT(andi, andi_op)
 DEF_EMIT_REG2I12_FORMAT(ori, ori_op)
 DEF_EMIT_REG2I12_FORMAT(xori, xori_op)
+DEF_EMIT_REG2I12_FORMAT(ldb, ldb_op)
+DEF_EMIT_REG2I12_FORMAT(ldh, ldh_op)
+DEF_EMIT_REG2I12_FORMAT(ldw, ldw_op)
 DEF_EMIT_REG2I12_FORMAT(ldbu, ldbu_op)
 DEF_EMIT_REG2I12_FORMAT(ldhu, ldhu_op)
 DEF_EMIT_REG2I12_FORMAT(ldwu, ldwu_op)
@@ -685,9 +692,12 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 	insn->reg3_format.rk = rk;					\
 }
 
+DEF_EMIT_REG3_FORMAT(addw, addw_op)
 DEF_EMIT_REG3_FORMAT(addd, addd_op)
 DEF_EMIT_REG3_FORMAT(subd, subd_op)
 DEF_EMIT_REG3_FORMAT(muld, muld_op)
+DEF_EMIT_REG3_FORMAT(divd, divd_op)
+DEF_EMIT_REG3_FORMAT(modd, modd_op)
 DEF_EMIT_REG3_FORMAT(divdu, divdu_op)
 DEF_EMIT_REG3_FORMAT(moddu, moddu_op)
 DEF_EMIT_REG3_FORMAT(and, and_op)
@@ -699,6 +709,9 @@ DEF_EMIT_REG3_FORMAT(srlw, srlw_op)
 DEF_EMIT_REG3_FORMAT(srld, srld_op)
 DEF_EMIT_REG3_FORMAT(sraw, sraw_op)
 DEF_EMIT_REG3_FORMAT(srad, srad_op)
+DEF_EMIT_REG3_FORMAT(ldxb, ldxb_op)
+DEF_EMIT_REG3_FORMAT(ldxh, ldxh_op)
+DEF_EMIT_REG3_FORMAT(ldxw, ldxw_op)
 DEF_EMIT_REG3_FORMAT(ldxbu, ldxbu_op)
 DEF_EMIT_REG3_FORMAT(ldxhu, ldxhu_op)
 DEF_EMIT_REG3_FORMAT(ldxwu, ldxwu_op)
-- 
2.34.1


