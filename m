Return-Path: <bpf+bounces-6034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898D07643FB
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 04:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25147281FC3
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6AC17F5;
	Thu, 27 Jul 2023 02:50:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC6E399
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 02:50:14 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FE81BCB
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 19:50:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a5ad44dc5aso443550b6e.3
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206; t=1690426212; x=1691031012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QspNxTEi/qT/BgadxTLzSVy271O3r6BuXIduCGxDThQ=;
        b=efxZRhLkLzlA3ccwQazCze+AE3jhUxZF0vLhd6J+9iDsHnSAmrjU9K3DluO7dKZHwB
         UxKYuDcrzLjb653pZPNHt0WYWdq+GR9OxaSW8kKZaItiAGblEU13aSjDND8Syk4dtVCH
         nwcRaQ1IqmcJGUYMecWRwdVX5vpousJa/f448=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690426212; x=1691031012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QspNxTEi/qT/BgadxTLzSVy271O3r6BuXIduCGxDThQ=;
        b=DjspxP3fTOWCdPtVRdzNGrymJ0jxqlkuwnvZdvRdxvAbd4hoA5gB053cFUaWoOdj67
         SOjDvVrMU/lmKSH20IGlJE1CwlLNuQNvrr5npgtfSryqemUdtwxdAy/f5qtRt6w4NtLh
         H299JRN3wE95tXPidsbf9e2PH/Y0YKkSevOuGS+tmYg08aFrrGSUOF7eQrkgCY+Hk0+w
         RKnyH0JyxymAhbnk7xZt7kL3DvezuDKFRmscLn3s6I55roQRJJ6rqXw0tUld+faa9X1w
         bGUuzyCKbzUib7cNSos3wO71J7px+WmfATqbVCWclvuXOqQVhyJDa5tFPswu7C3x2+Kk
         pT0Q==
X-Gm-Message-State: ABy/qLaNsGJiSnf2OM8KfapoooInxHBbmu+eojGvD2qw5mJFhVW9P4F3
	16ZR/PSeohWP8d8QSV6jE3OXdZYIu7PUGTJx0YohPg==
X-Google-Smtp-Source: APBJJlEXoJUhxPgiBoapPWNXWPOoG4MBDEOp2OM0y2T2xlmygi47Kcm0f/Z4g8ETBkWfrszT1jJT8A==
X-Received: by 2002:a05:6808:1a92:b0:3a1:ed1b:9541 with SMTP id bm18-20020a0568081a9200b003a1ed1b9541mr1443669oib.40.1690426211687;
        Wed, 26 Jul 2023 19:50:11 -0700 (PDT)
Received: from marth.. (75-172-111-252.tukw.qwest.net. [75.172.111.252])
        by smtp.gmail.com with ESMTPSA id f25-20020a633819000000b0055bf13811f5sm240782pga.15.2023.07.26.19.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:50:11 -0700 (PDT)
From: Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To: bpf@vger.kernel.org
Cc: Luke Nelson <luke.r.nels@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Xi Wang <xi.wang@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] riscv/bpf: Fix truncated immediate warning in rv_s_insn
Date: Wed, 26 Jul 2023 19:49:31 -0700
Message-Id: <20230727024931.17156-1-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sparse warns that a cast in rv_s_insn truncates bits from the constant
0x7ff to 0xff.  The warning originates from the use of a constant offset
of -8 in a store instruction in bpf_jit_comp64.c:

  emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);

rv_sd then calls rv_s_insn, with imm11_0 equal to (u16)(-8), or 0xfff8.

Here's the current implementation of rv_s_insn:

  static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, u8 opcode)
  {
          u8 imm11_5 = imm11_0 >> 5, imm4_0 = imm11_0 & 0x1f;

          return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) |
                 (imm4_0 << 7) | opcode;
  }

imm11_0 is a signed 12-bit immediate offset of the store instruction. The
instruction encoding requires splitting the immediate into bits 11:5 and
bits 4:0. In this case, imm11_0 >> 5 = 0x7ff, which then gets truncated
to 0xff when cast to u8, causing the warning from sparse. However, this is
not actually an issue because the immediate offset is signed---truncating
upper bits that are all set to 1 has no effect on the value of the
immediate.

There is another subtle quirk with this code, which is imm11_5 is
supposed to be the upper 7 bits of the 12-bit signed immediate, but its
type is u8 with no explicit mask to select out only the bottom 7 bits.
This happens to be okay here because imm11_5 is the left-most field in
the instruction and the "extra" bit will be shifted out when imm11_5 is
shifted left by 25.

This commit fixes the warning by changing the type of imm11_5 and imm4_0
to be u32 instead of u8, and adding an explicit mask to compute imm11_5
instead of relying on truncation + shifting.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307260704.dUElCrWU-lkp@intel.com/
In-Reply-To: <202307260704.dUElCrWU-lkp@intel.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
Cc: Xi Wang <xi.wang@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/riscv/net/bpf_jit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 2717f5490428..e159c6e3ff43 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -238,7 +238,7 @@ static inline u32 rv_i_insn(u16 imm11_0, u8 rs1, u8 funct3, u8 rd, u8 opcode)

 static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, u8 opcode)
 {
-	u8 imm11_5 = imm11_0 >> 5, imm4_0 = imm11_0 & 0x1f;
+	u32 imm11_5 = (imm11_0 >> 5) & 0x7f, imm4_0 = imm11_0 & 0x1f;

 	return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) |
 		(imm4_0 << 7) | opcode;
--
2.34.1


