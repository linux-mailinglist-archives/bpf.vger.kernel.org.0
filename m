Return-Path: <bpf+bounces-34629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A149A92F6A4
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CB61F24DCB
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 08:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FE33BBE2;
	Fri, 12 Jul 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KzsLVO1G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA48801
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771300; cv=none; b=abCAq0iZlAmu/pDKrfI2SBWRIW279lD9+B1By8bR35jhASWh/oVj0FTQ69FGTfC/RqfopVWDjzCidHTFpnUDZ6ptNxZbcR9WaRcFluO7HH4FzmqP2dBUbNzEr2rS/RDUMu646NYCK03nTPz4sxt+KsalEf8/nOE4Dcng7vzVcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771300; c=relaxed/simple;
	bh=UEqnkVGvrjwB0eOnHy8QaG95mDIuwov6z7HrWMcwRZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jg65/w9ezahzFdPhIiD/KLhln9Nie/yKCo85nLLhwrd3pXW/88lO+0rwTwaKnTJ3rFBagFd5G+LxxN81PUEdSYuq3GFbrncNZYYJHfgmGJJSNH0I7Je+g9ckXr2vDuYVOwsuCCNv1/yLzx/dF5nMBEAJP/9ZIj7e5yK9MH7J83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KzsLVO1G; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77c349bb81so205971366b.3
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720771297; x=1721376097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85Vroh6o1AJc57S5SB1Osch/futnKt1i+fE+PkxElpM=;
        b=KzsLVO1GHwGYklEeqw6PEM8Pf0fXDvMbTdquFzqGvcKrQ3eygju2eNYdepS7R7rqz1
         PMlube3YGz5Gw+uwSrc4RmRRxKlBPDUZ3fFcZD/mhU4TXAtDyJJGT6v/fA53gih4p+mP
         Uy+cpEKGmc/0/fTywIL09GnyructcNWTSgA9gOMvveEAise6RKmVFkvUmM8nJCwK9g4q
         zUE4fqyqhdCfABEveYKPDTN734taXFazpLMLt6nQsopO0e611VZ+uBw7cogC2Z9kKFkr
         EDrxpKaNTlhbYZbhn55+Mmle2gIGMo6M9fOSkDQ6vjxsHiTQWuNarUGHdpFTI5EnhSHK
         EBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720771297; x=1721376097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85Vroh6o1AJc57S5SB1Osch/futnKt1i+fE+PkxElpM=;
        b=l4qhl2ANgVeh00CUkfIETW4iBFsqR5UGTlljCxmpDNZAyWstWi7ilr/aPlHH/crbzW
         wnJ+v6wyQL7W//4N7ZdlDanIdv7knt0jtN9eaL2VqGle7Od1zj2u5cTijgrzgMLeg/7P
         I5js7bklL0/G6/CgDHMnCJVDFdAFveRM4UI0bREuoaHnkyvwOqvHdvLiF1PfvB62PshN
         iLzupQtvufcJPNX2bV8T87SDZ8WbVW9jqce2/qbZUAG864T2geqEFFpqyWyVAd6J+87B
         thbWvF7wSzLj60shHU0AlTiAOnOHYSlJohomPwGC1YijAvy4At7ZTCyH/jcy/zNmlV6n
         lucQ==
X-Gm-Message-State: AOJu0YxQd2d0T0PchttgK/3ARECPIxpydWsSnYq6r6mzCF9GX6bORoPL
	c8ZP9yTjDlZt60R4d9431ATvBkuD3GAAbz506HadOVnsSlBlYKC85XiReSVgj31uU3XdCCAW9fE
	MvB0=
X-Google-Smtp-Source: AGHT+IHEgVNe05NzMD7RCxTz+i9KVExa0ytUbHPNFz4/atGmuRwtDI6VxDhyKT0MA0jmB+M3TFYtjg==
X-Received: by 2002:a17:907:7da8:b0:a77:da14:8409 with SMTP id a640c23a62f3a-a780b88665amr867259766b.48.1720771296888;
        Fri, 12 Jul 2024 01:01:36 -0700 (PDT)
Received: from localhost ([2401:e180:8873:3610:b5e2:cfc7:c3d8:6a2b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd5281f4sm846813a91.26.2024.07.12.01.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:01:35 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 1/3] bpf: fix overflow check in adjust_jmp_off()
Date: Fri, 12 Jul 2024 16:01:24 +0800
Message-ID: <20240712080127.136608-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712080127.136608-1-shung-hsi.yu@suse.com>
References: <20240712080127.136608-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adjust_jmp_off() incorrectly used the insn->imm field for all overflow check,
which is incorrect as that should only be done or the BPF_JMP32 | BPF_JA case,
not the general jump instruction case. Fix it by using insn->off for overflow
check in the general case.

Fixes: 5337ac4c9b80 ("bpf: Fix the corner case with may_goto and jump to the 1st insn.")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0263fb5ca4b..cf2eb07ddf28 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18852,7 +18852,7 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
 		} else {
 			if (i + 1 + insn->off != tgt_idx)
 				continue;
-			if (signed_add16_overflows(insn->imm, delta))
+			if (signed_add16_overflows(insn->off, delta))
 				return -ERANGE;
 			insn->off += delta;
 		}
-- 
2.45.2


