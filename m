Return-Path: <bpf+bounces-65418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD58B22259
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 11:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F31B618CC
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A62E7174;
	Tue, 12 Aug 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fIm1c6c+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0169D2E7163
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989452; cv=none; b=cRFpcIxY/U66NbiMSvW6dusEYDqH4MM4qT9/PBAmTnHAYRCPa4U4i7hlW0Gw1A/Iucj2qcXDBHwXT2nPkRECStMmZ+soVkWPsxpIzaZ7YlxtaIfx+62o5PMCU0hhNOMDFnH3g2dAebKk9kiCba805JlokQohmVL+MufQgJqOyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989452; c=relaxed/simple;
	bh=SfGibH3LYjDwJHPtxge+VGyiVYm3yPEC0dBeNwgapkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BRaFOCAPOkhYSO5nxjEDRQV7GMKS96mxP5rNvG530lOjVWl/LVuVI/j5IYseVomxkEctk9W5DTNBua766qrTd/2+G4NeMPwh2iTqcAiGPcf/Z+XPErY5rkesFWuVzOWLWAjEONBC1KHqfz33ZCjUjBpnAQTmzIKXzApLXJ/b1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fIm1c6c+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78f33204eso653587f8f.3
        for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754989448; x=1755594248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtp0f/XAF/TX0R94lrjgjIgA7neAmWsQ9XVPNzUOsGo=;
        b=fIm1c6c+R4j3BnKlboyp4GFsLEWpuy27plShoPaY5Izhj00+/gj9ETSOBbn/cYgbQi
         5vIXAXojoVLzda/PyRxVfNTeTkakew6au45UwGTCdzmtRfhrPVmRJHXKnv1lNkELztu2
         fovR1IUQZPrYxG38jldFOYGFU+pgw8x0OK1jWL3N67XpsU8yTSVSSVocvv/XGPdiQKmC
         8MXUFcka/pPh3z9BFF1YmzrTuZulsOqzaC3chCyBavvqNlkVSKkgxtV4Wt/Swq5lszTb
         Mnc3uLLru+H9CJzpEZtDcPQr8Ioqb4BcouhJdyxIDhK3k8v4DvB1PJazLv+Ctcw/0WG2
         yM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989448; x=1755594248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtp0f/XAF/TX0R94lrjgjIgA7neAmWsQ9XVPNzUOsGo=;
        b=Mlbnb5hVzTJFqbMfwAMCnM7jOcUkKTNpXMQEJx/jxKloch83jfybTU3E1NGZX9EJ4e
         wTNMlp+Ckrec92pYYBSPOXIUsgU+ZZGYa0ILV5Edwe+eC7lR6+KYIamL6Riqb6PTbmLx
         xiSo3uipbccdhVgrQmZ2sW9C3QAVDHvoon6NxDnV3RfX+rOFJo+SmkTgVSvB8ncpgSZr
         z5lClrKjQq9Z83AvmIDcfYRi7apIct0+1BJMv8WofJcdwwWnrcbqeeKdT/JYdimOyctx
         x4qtjs20WO540O6pfv4cwtfkDxwubAr3yjBfNY8jRUlo1babRCq3fl5DjmMcgvVQAa54
         46QA==
X-Gm-Message-State: AOJu0YzNCiaYlZYDS71I1DRX5eA0KBF4u4maRPiEg5gYSy/3Sb3HcU6X
	StT/KoWXX2QO0MHriGm1FsermLsf48oL6WxdXVLja/i/5oRGfy/siIM5/YRaEnaQ6kqYIchKPZt
	iFmbm
X-Gm-Gg: ASbGnctNyBmLXMOPdRl65ChI1XLoBJY+yLtOMRbUrpUTGOGJdrSdrBNpN1L2FMFsjjz
	Tz9iaoqEDAEPIHfkkLnAnuuCi37J1eGSEhYQoyv8b3fZaOGgUIoLMEu8i2/7/u22vt9Gj0Df9DH
	mIIkbiIAI0j3Ci9TEwORa+ZbcYiY15S8iITsQhI4C9pleNSNtqs+5BcbzqQTmOOnrpOnub3CQlf
	Sok10e+/RmjK/QnL3BTsyF4frwlYZfa3PpsVcEeVoH2ROY1uA6kw8FNXHsafinyZPfIx3hdZVPq
	BObtNIMLSvPwCnwSOa/hQIUeI3hhGTIyjN15e7sdGMX7Fz/mNaRUD2dj1IZ8ZRBDBDahGGmGec6
	JNfBvgzOyrsUq1R/nW7/e8SfUxpAyFQ==
X-Google-Smtp-Source: AGHT+IH6MhMdd/azBMg6FFj7maPvuhuBI0aLHfN/OOEfRoWpInAXZIecXHTDdNehcRNL9lr4GrhaQA==
X-Received: by 2002:a05:6000:230a:b0:3b7:889c:69d5 with SMTP id ffacd0b85a97d-3b91538ea0emr120027f8f.12.1754989447868;
        Tue, 12 Aug 2025 02:04:07 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3ac574sm43479697f8f.5.2025.08.12.02.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:04:07 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH 0/2] riscv, bpf: fix reads of thread_info.cpu
Date: Tue, 12 Aug 2025 11:02:54 +0200
Message-ID: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

These patches are related to a recently queued series [1] that fixes the
same bugs in normal code.  That series finishes with a patch that would
have exposed the BPF bugs, but luckily it won't get merged until v6.18.

I don't know enough about BPF to verify that it emits the correct code
now, so any pointers are welcome.

1: https://lore.kernel.org/linux-riscv/20250725165410.2896641-3-rkrcmar@ventanamicro.com/

Radim Krčmář (2):
  riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
  riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id

 arch/riscv/net/bpf_jit_comp64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.50.0


