Return-Path: <bpf+bounces-66193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F73B2F7AE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119EC1896104
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF32765D1;
	Thu, 21 Aug 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpXKRF7y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193523D7D1
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778602; cv=none; b=I8IcNx1r57+t3lnV5Fd/ssNEUsw6TU79T1Ht7odbZTDc02DyOTd/23qwrgNdD61ct+qkJbAvbmq6+hHGqSKZLbLIkQSdmsEjlrvpPRZEMXTgu7r+VgGtg8SgYbO8zDqZ4mMn9k8DIaBZnpZ4KWLOWZtCic9/6u2r0DPQouqZNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778602; c=relaxed/simple;
	bh=D3bW53kccqh7kC5HvQO/ybJCH5XgtyaXneoTz1iI9o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQLLSd6hXOCkmm3gJpnKmFvlPkuEX+QrMsIbM5tr60FXG3gbWBAaBjWZkr37OvYEd4uMwEOHlIsXfh2SjLY113F8NsHT9ucSsENRWL4TpcgLdWtMFs3Sxxi/MBbw8sVfdwz8E1nDXrtNmAX4PRae5L5w007t7w8FBevzr4FW0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpXKRF7y; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323266d2d9eso741853a91.0
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755778600; x=1756383400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLc1SqMx88bxm5UNAuFakYImFc8qDW5ITO4vuXogwcM=;
        b=MpXKRF7yLWyjarnVUfVdLizh4lLOBoetu+tCMgDNfo3gjm+o/aTGcUnNcPUeBwcxRX
         mbpFk6OlWqrmyfXY52tHVLB1Rnkdp883rseCYTqScnsJExrOeUwrEIzlQIo3vZKAwu4z
         D5HGADXvxArI5mXa7DAQe01FuCVEkiwuS7fP06+mV2DYkEqzkXSasUwTXcEOtPEy0782
         Nmyd+69S4P1CNOYFB3RntoEPCivv+aq4BRYoYuW5Jt4gQl68xuWJ6rH3VDrKx6axRj3i
         ksRo9/drDheRS9PpfGyvxCvBQEGczdEDRRt/5MpRc/U+v5Wle7DDhjbzvWoEN6tHX3KZ
         +DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755778600; x=1756383400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLc1SqMx88bxm5UNAuFakYImFc8qDW5ITO4vuXogwcM=;
        b=W2x68h2R2Mp3h/PmgplLcgomtrsIZgsr9IYG3R+Zych3vDKj0OF1L5Vw9vnc3smneT
         52WQbUalP1JrLCJc183Hs8xQ08fn5g4LhnOq5zbsZAEGY2MLfcNVf1lepPco2m7VDa6i
         Q78jwqkKGMylyt6H7cL/I9FtBL5b3P/BrCbps6rMh/2XgJY3h5Sv0wAN8txUGVYuIeRN
         1YfuxdvO28VlMdjiIY8EZs7MSOACeTXxARnNAsgyuq4iACaohw4nt3vkZEfq6Ff/fove
         txLSiDrugOR2C6oUHlQSmGf/9mObkWfnC7El0DHCCogLMD+hV9Ni6KCXPSBJyj+6jLxi
         UJBQ==
X-Gm-Message-State: AOJu0YyVzRf7XTB3OANZYKyfqVTCUGqeGhhlc0mg6ny5gRYtkVjU4Z8Z
	OZEqqYOryDgVaAvfmqiRs95B7ydcjg5bfUsY2lqIwaShD6ndqnb4CbfhL2rdJL0ju54=
X-Gm-Gg: ASbGncsNl3C99Z18pPrpQN+e5kRZa6m8Uc03KTE0X+4rNvSho580MWi/91Z3/UHVDUV
	GUHq+gvaihvZ2TTyDsruG0cFM/9tntk2ZxyKJ9f6/VtqMdu0ea42uJwMBkGbh6gsq0tG1OuKiuW
	diigwRoP+lt2xOCAFjLPzS333+D6alYJ1LBO2xRh1/Lc6d5EKjWe2vZXDMs/0ZafD4cfSGZ+huY
	BILS4tB2B26lC60gwdPK64uMvFl76baaG0neZ+zihih5aXXjLWGp5nKFYEzUZuYwuIEA+coAdqe
	M42DmMIhO1EWjc0YT661vKHZKdndfIgWJYgUBQYgY6nOuzkltGeAg30QEmo1e4vLDPVtYvRKJm6
	/9dvX17pwqg+13Y0AhN3SqXVOIEMy15X6FZyHabOgMV1q9BCIsAU=
X-Google-Smtp-Source: AGHT+IHoaaMZA6T6APFg53tzmeaf2Zh5Zrn4FteT1P37Y2XdhOf2oT0PLT3bidCUN9QlazYmYrMhjg==
X-Received: by 2002:a17:90b:3d83:b0:323:39c0:8e74 with SMTP id 98e67ed59e1d1-324ed10c3camr3461899a91.24.1755778600188;
        Thu, 21 Aug 2025 05:16:40 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2c48337sm1745442a91.25.2025.08.21.05.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:16:39 -0700 (PDT)
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
Subject: [PATCH 0/3] LoongArch: Fix BPF trampoline related issues
Date: Thu, 21 Aug 2025 09:10:00 +0000
Message-ID: <20250821091003.404870-1-hengqi.chen@gmail.com>
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

Hengqi Chen (3):
  LoongArch: BPF: Remove duplicated flags check
  LoongArch: BPF: Sign extend struct ops return values properly
  LoongArch: BPF: No support of struct argument in trampoline programs

 arch/loongarch/net/bpf_jit.c | 54 +++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 10 deletions(-)

--
2.43.5

