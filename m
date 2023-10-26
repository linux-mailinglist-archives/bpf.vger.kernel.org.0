Return-Path: <bpf+bounces-13392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF77D8E58
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B97B21354
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695079DC;
	Fri, 27 Oct 2023 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+kZ9+VO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1766FA9
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:01:07 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECBB1B2
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-564b6276941so1492881a12.3
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386465; x=1698991265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajH5Why6tK/hgiFX9v98XyW+N+EsawtY8k6RA/o7xr8=;
        b=F+kZ9+VO7+kHFG0E4jccwkTYZ1Da5XjPZV0BvUx+Y+JIvjE0L753RKQayLr7lVFV3b
         I0zbRDrHP+Am7ou2x6EI4Of+CctCg0DdK074KTi+UCOgk4DIVHHnn2MkiLwsoUCqosIZ
         J4iI1y6CuDHQvQ2ieBJpSkpVa0OJQ9jnBoLATQ9Efeoxe2KiAg+uamkGruXdWFrnKD+T
         VJTsabpGZvmWeec2M6g+RVtbXF7D1xA6eZPfDOwmI2IqZCEc+y/eksJZhuv6Ee0ZbBNt
         0tksDMSS6RXl6uVBZQjOgy1ZMg3qfk7X3hz2x7M71NalANwZ78BuKASlFOE1DgVReaDx
         ebBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386465; x=1698991265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajH5Why6tK/hgiFX9v98XyW+N+EsawtY8k6RA/o7xr8=;
        b=XVdUY8CJ+c9biOSiR3OsyTqFZJMdaGCbtSknJ0MPzABc+ZvyYyDFSseFZRB6ddkZGI
         CRDzQX/bcU7gK0L4ZOv8LXHJvzjsL2BBRxnJSyxbHq1Df+cq44kbVi7a5AV67Je88ri6
         qX+w7XCgxCg41XTWvzVOOGS/qJs9A5CQwtw2TK65OptURB4Rq35ktwT80nPIVm2OwHRs
         /4lX0i+w8xl0WAzBkOsV670Na5WRNvhnNpJLuZxp3NnL8TbB4gbxB15Lsi8R6bX15C1e
         KKIhaGtOjsv/l8hJASswrkyxa3SofCd7Op0paxExfWsOKNwUETkLeFkL0axzRAwesVyK
         AdSw==
X-Gm-Message-State: AOJu0Yy0BYQ7zGnjPgMT+SKVPzBf38o+3RgK+nabkUPHC8UXowDMWHGa
	+eKJHRnTksHj4WA0FQk3HjE=
X-Google-Smtp-Source: AGHT+IHOweALGGGzNW5IfCHZvYctz11Ua6jUkpdtKnAq4NlFLXIr0OlxPqnBeyhcq63cvV/knoxAoQ==
X-Received: by 2002:a17:90a:f686:b0:26b:e27:8bc2 with SMTP id cl6-20020a17090af68600b0026b0e278bc2mr1653779pjb.45.1698386465039;
        Thu, 26 Oct 2023 23:01:05 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.47])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a1fc200b00277337818afsm1113667pjz.0.2023.10.26.23.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:01:04 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/8] bpf: Support cpu v4 instructions for LoongArch
Date: Thu, 26 Oct 2023 18:43:29 +0000
Message-Id: <20231026184337.563801-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset adds support for cpu v4 instructions for LoongArch.
For details, see the proposal ([0]) and its implementation in BPF core ([1]). 

  [0]: https://lore.kernel.org/bpf/4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta.com/
  [1]: https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev/

Hengqi Chen (8):
  LoongArch: Add more instruction opcodes and emit_* helpers
  LoongArch: BPF: Support sign-extension load instructions
  LoongArch: BPF: Support sign-extension mov instructions
  LoongArch: BPF: Support unconditional bswap instructions
  LoongArch: BPF: Support 32-bit offset jmp instructions
  LoongArch: BPF: Support signed div instructions
  LoongArch: BPF: Support signed mod instructions
  selftests/bpf: Enable cpu v4 tests for LoongArch

 arch/loongarch/include/asm/inst.h             |  13 ++
 arch/loongarch/net/bpf_jit.c                  | 143 ++++++++++++++----
 .../selftests/bpf/progs/test_ldsx_insn.c      |   3 +-
 .../selftests/bpf/progs/verifier_bswap.c      |   3 +-
 .../selftests/bpf/progs/verifier_gotol.c      |   3 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   3 +-
 .../selftests/bpf/progs/verifier_movsx.c      |   3 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |   3 +-
 8 files changed, 137 insertions(+), 37 deletions(-)

-- 
2.34.1


