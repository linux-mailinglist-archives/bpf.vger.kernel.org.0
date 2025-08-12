Return-Path: <bpf+bounces-65420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C651B22250
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 11:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABEE7AE55D
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24582E54A9;
	Tue, 12 Aug 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Jl5Y9VlQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A432E7641
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989454; cv=none; b=JK6c8ixgD0HcwEcHp2WUTboj+oyYtr61O8bBAP9WlH06QMt9yUXTPkIKaRIF92KxOhvMdovodi0akVPxzb3mBCa1QRwSOOQotU7xjv3+me2xKDO74nOvjrr957X+guTcEJ2xUg5rRmxxh/tbYy1EnlKzrCpcfrj1f6PqURukEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989454; c=relaxed/simple;
	bh=jX+YEQB0b2jg/94uudyOzj3RkscIhZDeVVogCJzZ67M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrLdkxRXWyZ3aR7vCIaJlEY9mpUMMXrmCBgoe3/sPPsV0cS/NKeJ9jhJm4vcJlV3vy1ISML6r3B3My7vnbgwypMVrmk1awJub7N5eXhMZ3eNIxwld+DmqKS2oDcw0bmAFzmXEn7yD4rcisLBHNFYUn6zOnsd/TGgotbNBV7ASs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Jl5Y9VlQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459ea4f40afso9381505e9.2
        for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754989451; x=1755594251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkDi9sQ4u1Zsf5AcaPzYnSO2sPwb0elGC7q2l8b77oI=;
        b=Jl5Y9VlQtRQgQ0wZapz6JmbwaoLFP6lFy1uOBPSW6zPTVaSiKkYXXB5/Yhgdk1f51I
         aGHyOg6b4cD8a3Kr7Ltqg58lvN+v4yVURDZMvVqtbPkIaw3tKOPS79iH014g3A5A0JkP
         Wxlpf89JlXrZlcWb8ktgo63426JPiVwEdADeP2uBM7vGnck3b1cZCsZme+0fdyfH0amo
         4TJtqmOuYApTj/a32MhsDZ6q9cKshyt/wnYvQlLGX42XnybAOXYgbsRvjsQPwNYum9TN
         OsFDUVTpnM5jppqVIzV4necufmbZruyzAhpGOmYdU+A3roIz1SWpvAEgdYX+XbURfzjB
         HqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989451; x=1755594251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkDi9sQ4u1Zsf5AcaPzYnSO2sPwb0elGC7q2l8b77oI=;
        b=Y3NaGcNBHc5VQ1DXTsZJARsdt0lXsCqzLImvIepa7LguFfpLN44egR7q2luFl79zAJ
         9KKw4CANYtsF3STaqb9BulrA3HANCed656XShsOxxwDqNWf0DPw/lXKdnlz3b/fyJp5x
         WhnQNtxM4j3ASXR6NPUfaXWHxRzOAD0f3pdk7MX2YDx8ed6uidep3HkFWnoJER5awhiD
         QOHNDMxNFQM/HyCANyA4OS2THbLeLL2HhPsVBMoLd7BFG2t4wyDtN3cXIqKHHoMUr68A
         uYjlTYL5Y15wrYVeepz1A7ebBTO5fzl+H5PU2Z9Znu/1JjSE+NykpIZdIxGO4Ch8yIdQ
         ultg==
X-Gm-Message-State: AOJu0YzX519lN+yCZGuoJFPuzZl6K92AOCTEUiLh55VwV/AJ8YLBXanH
	OQaTxMO2iHPLt9BKeoFIabduyE8UVvFW3v3DRqJtuj56QC2Tt/4liL7DL9eqtZx1ZpZSo0exdgn
	a17KM
X-Gm-Gg: ASbGncsPRL8NWqMGyljIQ7fN5Ujt0BxZ6UQE5JSi92/yf8gIvf1fuecLK7r/U8bNHvp
	Ho1dBDKhij3346goRqYWEH1PSMr5CL+HBisZVJZpRA2P3zSyXTGcIhLwhIWCGOZIvPooOChmRHq
	EJLknvbxBq9NJc1RYNxxj8emFLFfYEwgQKIoeihIgtwDTEiiLx2jVXs/d6s4qD2sCuiLXvLT2MS
	oyEgBtorB1/dDZMtadeEmdXH+ANNP6bixM7yZiFruSRozsPY5DP/BSlEs7IWVDgatYe48/02QJY
	8w1vME6cLBPCZgUsHJGUKYLobsWSyQNoGfqlRJJiloLWx7ZpWWEcDMew1Sq194Y03gxwdvG0mm5
	PIp7n1EhA25K0JhnbKROutx95guvAtQ==
X-Google-Smtp-Source: AGHT+IFBefRRbVz8mjWqcsAPH9QQgYekCVsZTS4QORs3XTzsM/mOl+JX5+dSUj2YaHIFPPZ1EW6gKQ==
X-Received: by 2002:a05:600c:608c:b0:458:a753:f3a1 with SMTP id 5b1f17b1804b1-45a1404e5b0mr2724695e9.3.1754989450650;
        Tue, 12 Aug 2025 02:04:10 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a053a9019sm104340625e9.21.2025.08.12.02.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:04:10 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: bpf@vger.kernel.org
Cc: stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id
Date: Tue, 12 Aug 2025 11:02:56 +0200
Message-ID: <20250812090256.757273-4-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

emit_ld is wrong, because thread_info.cpu is 32-bit, not xlen-bit wide.
The struct currently has a hole after cpu, so little endian accesses
seemed fine.

Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 6e1554d89681..9883a55d61b5 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1763,7 +1763,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		 */
 		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
 			/* Load current CPU number in R0 */
-			emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
+			emit_lw(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
 			break;
 		}
-- 
2.50.0


