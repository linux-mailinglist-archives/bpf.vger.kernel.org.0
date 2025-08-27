Return-Path: <bpf+bounces-66646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA1CB380B7
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A347A9ED4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE834DCCD;
	Wed, 27 Aug 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8qKZoa0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFBB28F1
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293567; cv=none; b=ltNTShmfVvRmXlxLEsRIFF7mjysPfHvS9TgKpuEmjAu/FOWLffR6Lb7PA+Q35ue3JYAO9lUXPydg/TtADVh2/pbbONpYSm+uhPrXRYARw/PRIU1zKnv23bC5ru8HgdmYskk/7dnV3lw9pEbRNH+XYNY9P2i7iXpm1OK4Ekjbwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293567; c=relaxed/simple;
	bh=ddBCvL3X83QlTd+5WQd87vKRmMu0/T6UgLHIyN93SB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Da1CqI1TxwIEgvsoC7Ae11CIovg4YDecMearR3UzeD3eDGz/I9TBj1X/r05robXNEfvujLBzSjufns8fQX1mrzmBcYnY5c58MJGiHDXvP86h7cUxkYmdQ7M/2MmvVDiN5vj4lriJD3qmQjBz8uPCwVdfGH6CMEcHndM2R70HPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8qKZoa0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so3660391a12.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756293565; x=1756898365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=93FWKoT6dFc5J2SoWMKbByMa7GuFs+3MAuu7ATorRVc=;
        b=U8qKZoa03r2VDE2TeuikSTY/HpXAU+zdAdrTZozw4niyGXvCBJ+P1jn+DQrdhlYRef
         gKdS9TzqTJmjizjovqpyKDffD7gFIXpXHZ6vFJ6A+vI0tOAIKuq2mZSY25uKEj49kjrA
         BTctuo/13kdZ79IMj4Lm+rjqmCfA/uxdags+qbfz6crPUkGYoarYBfjqUNICe7rJgXy2
         BxlLp+PPDw1iTjYmN5JAbLH/cwdATmSr87qvgD0Fh0ZpUKY+8qIvLYDl3VczACGI0U1z
         4m1D8m0fpIVsOtLs2QFH3+2E+IOqAQ0wWffT+51Pu8JcwZKqR6zEfQDagL21iwOHz9zk
         eSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756293565; x=1756898365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93FWKoT6dFc5J2SoWMKbByMa7GuFs+3MAuu7ATorRVc=;
        b=c34XR9Y3kCZQSjzjJpvuaIlKqnXIDXDJQAHpLZLDtypv8X9Nunv3Y2lJ8F1P6hc6BE
         ZJMrCW3bpvMZzepl82AeMQYT7XpoDgfJ7BNclVNn+fIdc3uwa1CoIo+GT+leLOFsISdg
         EFQVEjSHUx6lS7nbBURE3V2eDQWB4N5BGMCoHQSBjhBXDzhlKC/IubfJfMPKA5qSVy1T
         TxsqPF7/BANpOSD+laiyBLNcV6w745PNHJuUXtCnw0WH7P6FNxbd2LgS9YjqQBQmRcvl
         GUBXrRIFxHmNqL7KtsyLmdTpi0OO/XZTiSuEcyA38TYFwv2VqoaxSCQ8AsU5NAcb54Kh
         nwug==
X-Gm-Message-State: AOJu0Yx0oG7QUGZIPLpK1leYQZNLeKFkolu0zYmVE6HqdA/msiyrPxnA
	tfzcSOLT5cwkpTKQoffV6rHdr8peehus59XWQ1KBFV7F+6mN4gFF1ZXI
X-Gm-Gg: ASbGncuC5KwVwtXEJZ9hNxxU3SVVcSVF0/t+yur1WJTJ/LLW/qIOhG9EACO2Eooior6
	F+du7CGPP7g2MMJAQN1miraXKrOzcRGnS+LpO0OSVc/SaaHxv4DOe1Zk1SfmGmvhkknF5Lq/HsL
	E0ULCosdxUTVSkUrBidMXQDY6FmUQpMydIt9UnIt2USvhSlP8wvFzn1IXA5S7JyaWQh7fmRDfZi
	52jxthJUPUjnbibuADLeO5TKBcaKllUODIju23opZO1KADD16n/eG5GNmqg8OE5Ji2iYbqSGxQ6
	frl5ym1sPL8clPrUMcu1Q3UHlOZaoZJxijHi54D6YiedHAzZ1yyRR6CY0OO+T4JNSKFKYdIe8/a
	jHHg5S0s6O025LCQa5tQr7w5GOuwGrFYwhsIJsCQN
X-Google-Smtp-Source: AGHT+IGHMyUCOUNe3WdFTytTI7vDD/W3K7K34Nd4VIqs9KdtpdHS1TLuZl4AOc0Ub0c52sQDgDVmBw==
X-Received: by 2002:a17:902:ce82:b0:246:4de6:5cc0 with SMTP id d9443c01a7336-2464de66f6fmr233640965ad.53.1756293565298;
        Wed, 27 Aug 2025 04:19:25 -0700 (PDT)
Received: from devbox.. ([43.132.141.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f8a3335sm1829729a91.13.2025.08.27.04.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 04:19:24 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	jianghaoran@kylinos.cn,
	duanchenghao@kylinos.cn,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	vincent.mc.li@gmail.com
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 0/3] LoongArch: Fix BPF trampoline related issues
Date: Wed, 27 Aug 2025 09:47:30 +0000
Message-ID: <20250827094733.426839-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following two selftest cases triggers oops on LoongArch:

    $ ./test_progs -a ns_bpf_qdisc -a tracing_struct

This small series tries to fix/workaround these issues.
See individual commit for details.

While at it, remove a duplicated flags check in __arch_prepare_bpf_trampoline().

v1 -> v2:
* collect Acked-by/Tested-by tags
* update sign_extend() in patch 2 as suggested by Huacai

Hengqi Chen (3):
  LoongArch: BPF: Remove duplicated flags check
  LoongArch: BPF: Sign extend struct ops return values properly
  LoongArch: BPF: No support of struct argument in trampoline programs

 arch/loongarch/net/bpf_jit.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

--
2.43.5

