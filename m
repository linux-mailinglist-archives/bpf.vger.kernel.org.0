Return-Path: <bpf+bounces-67278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F195B41E64
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5C17B98B5
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFAA28640C;
	Wed,  3 Sep 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chha8Jgg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898428467D
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901146; cv=none; b=VL4IjM/bEPG8J1FcXZBLW54BK8K4kvNcRV22B41jWKV64D0Rg+/88ONFxvrI3r/k7SHavs/I0d7560ekVwgqQjmr7v5CEQIi+5M9UOQHVM9MSH2LcqajcecLfp0dSVXpMwQUTc1ZUtB4cSfZ1Ta9+h7XztIeUwhOUmPu86FeLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901146; c=relaxed/simple;
	bh=f8N5DIYzoUBoEio1+AEddeH7BI1EjC+5LFt8y7V6Q/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XoSmiKMT9LG647Im/0GoMrBIPgQqirCqlwCKMElp56zOBbAfgRMuzF4r097rS8RgPnvFmOAdYCynP6D5X/m7114xtQ7y6DEUypY6OICulE4H8SGw+54aK/5SvIk7jrmUAH6PjUrA5XMen1p7u9OM7WtvMwp7EX6Mqwfg/gc97ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Chha8Jgg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772843b6057so361141b3a.3
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901144; x=1757505944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Qykk0xQthpe0RRYOkXWUZrDmHJY/as+WNnOR6DEJK4=;
        b=Chha8JggRt9SkzjGGfJoEhkNRF7x42whOtCGpT5fyU6orIkbRnWr1GM3mPpPEiNoIz
         xPem222n26fTQ5SsfRC+Vr99HdDJbpYOL9wk0N4LXyOEyb9edyELOC2aL5NPkDjR5VTt
         qDONtF7QrEf4EBpUx+Wq0dL1CIGTqHmN6AMxdK2g2zji9BNV1ikEB1FiBNDPRN9U7swS
         oDfY3OiI9Qs8tb+G89i9xlaWsTUdJkpws2MSH07Y+n64gMrtwsvNetAsFJXyDO7DZoma
         WPNgAUgiKL796jQ4JqEaC8wL8l5Sb21F/FZKj3rX43+s7r68vYjM9Lcr6Zut0yxci4i0
         WMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901144; x=1757505944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Qykk0xQthpe0RRYOkXWUZrDmHJY/as+WNnOR6DEJK4=;
        b=T/8IK4Y7EmbG4+QUaitvu4QzMTpSKR/DZyUiX0MtWy1q9zb3RlAW79Q+jn7IrAEtGP
         z6xtIROprfaNTZICJNPqqhyAWh2ORmBy5Qvv287Aj+jFTDK879oftINdXKlUnhLs4iBq
         oKonx9rSR3e8uZq3rfMWXGYVUogcnpme8BPYcnx8GUTE8jGaMtbwF2kyx9oKLjZEd78d
         cdi8ppHUGbxSl4TywtaR6CdrUaeqTEcnfqgZC34I2bCdulIZIhXoAgVQUwafzRMkF6vQ
         Y5F+3FX4qkA4hed49EvPUwDJfE0nrXQCyYjGaGbS2dBTHwAcGON2fJwaPOoj1/jBAWMT
         M2bg==
X-Forwarded-Encrypted: i=1; AJvYcCXaXsIQspCY2MXDjx/y8KVmWfDWZ1XcucPcP5k5T5ci2o2E73x15SuNM/VmPJW7d0tCXeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcChmgjqB8eKnMju5xeEAaAYx8NcwHp2qRHr762x7GbX2DOYg
	0ts0Px5OxWwBSf94j3u3Fcyl0LBfoCNff1OUXW997h0ete0XnXIQORoS
X-Gm-Gg: ASbGncshBUTXTwaMmOLk33e1yiYoaWnJrExejHz26idK/KUERqr9VKuQJkSIAzb/Lfg
	50G9o/F2Ft1VAs0SR8dRkMKKyI4VB4hsNr+fXKpdPIFYiGts0WBt7Q/A/E6UboYCXVWoB7MaKHf
	+iM8MBBbzzq4eQLoSOnA+yjlL6z883zd6hWTLjx90tbVrghbr4JNjD0lHeshB5DYzA4BIr+yKZo
	lNBtobwWCd3b+MTsOMkDMZ1SmQvIZkvVBXj4pgIlDUi+K/0sYDT2OIH44MG/PAq3v8nEsvonDZh
	80Jkg3yV/hnN2MUp0VEOKJ4xzw9r/NcOFepIaZBgaYwIOZW6dvw/YZqJMCqMulOhG3nVRKFHiJL
	0QBc4NQuFOegCcMSXpfRvqHYO5v0KsKkm2ufPdgOmxzPp3ooAGpo=
X-Google-Smtp-Source: AGHT+IF9pVOHyDnykUAgAHhoztq3yyto5TS2UIr0a5IaKVOEo/rPYlHUXdNXwZG9HhNFzr/X66iUUQ==
X-Received: by 2002:a17:902:f642:b0:248:6860:80dd with SMTP id d9443c01a7336-2494485d541mr217919425ad.1.1756901143664;
        Wed, 03 Sep 2025 05:05:43 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16615899b3a.92.2025.09.03.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:05:43 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	hejinyang@loongson.cn
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 0/8] LoongArch: Fix BPF trampoline related issues
Date: Wed,  3 Sep 2025 07:01:05 +0000
Message-ID: <20250903070113.42215-1-hengqi.chen@gmail.com>
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

This series tries to fix/workaround these issues.
See individual commit for details.

v3 -> v4:
* Completely rework of previous version
* Fix more subtle issues

Hengqi Chen (8):
  LoongArch: BPF: Remove duplicated flags check
  LoongArch: BPF: Remove duplicated bpf_flush_icache()
  LoongArch: BPF: No support of struct argument in trampoline programs
  LoongArch: BPF: No text_poke() for kernel text
  LoongArch: BPF: Don't assume trampoline size is page aligned
  LoongArch: BPF: Make trampoline size stable
  LoongArch: BPF: Make error handling robust in
    arch_prepare_bpf_trampoline()
  LoongArch: BPF: Sign extend struct ops return values properly

 arch/loongarch/net/bpf_jit.c | 67 +++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 16 deletions(-)

--
2.43.5

