Return-Path: <bpf+bounces-46055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319929E32BC
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 05:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB39B28520
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84000157A6C;
	Wed,  4 Dec 2024 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjPld0df"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8934545
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 04:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287684; cv=none; b=GGFPlUIf1/pt08tVA1MbG5hBdzfPEA+01WN/vhSWfqYb0/heIFawFFAZfD2Bx0/+6ULtm0jqNTgxoHw0fZGJOoQARJC0q1SB4BbG5+ZYQo7Oh5UGFTfWfSm38MyOvjLNfPHd6iAONJQovsuREHaVKaqQjURhV0JjE2Eis3+sV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287684; c=relaxed/simple;
	bh=haScB8cqzauxNIXvuT3jtYnm+L579cmr7tMGmf4UQUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pln0RHIdxinvKr3UURDK/SZSnJzQcheF7o4eF6U+2ReuK3LPCDooOoUO6yVs8/TAQ/X6jDxjN3PNe3Rw6sJz0EElYOzA802yFanAlsOGWPE1ONNRSC+jTpkd8u1gbO1Gy0k2GkETtO/Snm5NcxPBsF3VZx9/IYpTuUjLyQ2fpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjPld0df; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so2578785e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 20:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733287679; x=1733892479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOZHQ6tkf8f8jqFYmtUTdfNaIXQsxIFDTOQfmDLM1yU=;
        b=HjPld0df5sBS+jWPt+ZLx+W3OBMoI/4jqADs2HkMFxrtTirOHFZ/Q1osMnajjNEp9T
         vz/2G4rgAzMYIXsgSXRP+VA5erePos5xKAkGBbHaWbUA3QxvvLkiPL/oPm9styYHDHDm
         wjH/miWMiSgx01Mjv8QPu3kVX7P7IQG/xWONQvfJOtbz5jksAd8VcYDRkmh5JX6t50ih
         hMwPnVF5MLsTY95kzeIwj6tktWqZHF2XnQJxbtTxg6yaK899Tq+wgLW/DijehODJDcPe
         Y932NO6w19MywVq9zASQ7nfLmfKlWCNDutvndK3H/fmGptbBdREBENBF700xKA8JCokC
         ymKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733287679; x=1733892479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOZHQ6tkf8f8jqFYmtUTdfNaIXQsxIFDTOQfmDLM1yU=;
        b=RkGlGhWEKL+NbQUf5Q8tB32FUdHg5Tne/07tKWpkmiFp15LYmVOFFJbhC5j+f0y/rQ
         YH0tu07DFwuYuju4PcNm1v2APWaH2KUCniAe14lsUpcmVR6t9N0LrIYQu76Lk39Uu4kW
         rLVbvo4o+SS/XchamBmxekTVsW0gbembE7FhRxySu7rUPVwajQiKpA/DWLSmpzUtBT1w
         Uh2gD7704eUEMRvipuGZrPi1goHR5BlucUpkZQKD/P1M4jrAYlceP+nE0qO4EmYtlbTi
         4iQL0zRQbLGYUXcc+cScjnrA7plLhKFNSDzBRHZc9jMXzACFs+CnUEVJvMJR1xmlDJlh
         8kkg==
X-Gm-Message-State: AOJu0YyaKFQdIh2UwmVUZhz+CnF2+lbIrDKYtU8VJqRYyLSvZHKR+YUn
	ocHR8kClz53CWt7yCpF8RibQDhktQbf5q2Bpl53avuQMMMrUJUYu2Pnas2EwDyk=
X-Gm-Gg: ASbGncuUyAGrK1tcT+7nnyM2tvOe3xmn7Yeq6b0J0sGcas1NOxc4Bda29iqabbaDi3b
	KC+SRI4M3hUI8b9dHThoYNyl4q9uUSRftj1wSZ6lqHNqwjsdaWMbJNXjex3l53SOiDiBpQ4mv7D
	St5V0XCPCdT49z3QCq0xs+VCvPQnKIhfZXpzFh1+jkFbhG2vnpX46tXDNXPwynfH6xDNZoDT3Cc
	4XbmWdtCCpsHX9D6YPb4cJsMWNKWOn9wZFrQwunCP/rma1dIF2UVpyBu8t3c7UyseQgUkdYxN2g
	/g==
X-Google-Smtp-Source: AGHT+IE0R/51zStxscm+5JekatfphzzLBnw1GIXzIYTV5nipjglLjE0VXAOtULxC2YxP4QjOC0wt/Q==
X-Received: by 2002:a05:600c:1ca2:b0:431:55f3:d34e with SMTP id 5b1f17b1804b1-434d0d7b758mr38824595e9.15.1733287678837;
        Tue, 03 Dec 2024 20:47:58 -0800 (PST)
Received: from localhost (fwdproxy-cln-037.fbsv.net. [2a03:2880:31ff:25::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e4a54b71sm11623876f8f.79.2024.12.03.20.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:47:58 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf v4 0/5] Fixes for stack with allow_ptr_leaks
Date: Tue,  3 Dec 2024 20:47:52 -0800
Message-ID: <20241204044757.1483141-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; h=from:subject; bh=haScB8cqzauxNIXvuT3jtYnm+L579cmr7tMGmf4UQUU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT97GMl0rEnG2IVoHMGmuk10UQisZlnIFemtlS7Lb LcQen4mJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/exgAKCRBM4MiGSL8RyonhEA C/wGrs0Rl/mW3cka2emXn2FDmA2XRUHKpgtmA+c6GT6Hr+1QGSZANOdC5I99lL9Ds1TCC6X3gNyYA4 gAqU48h3P6z71V0Yo2nmcrtcL88T2l4bk10FlZbAqgPQzJJ1LJgAksEvX3TQD9gZ6+RuWw54Cmspri dbYEPyi57SSCluUfUUca8b/h0yiqEFWBzU4RDGecdTl8ZYAtJu7KlZ14ZtSkcjsZUmbHKO5U6Volw1 SgyxH+5Wfr34DHE08ID0DSvp2mG5fino52eJSN2m9+q7XFkSptgk7U1l1XRRcjieu6R6lLRf3HTws4 mnzVWrY6jxwWAim3icMh6eb0jBmNtVNFoUI+uO8+TsaVItCvRH/VkloH2E38Kzgtgsv/FMz/VhOYhL AvRAkcYlDE9/ibhKpTwuBpwp1yeFsoy3saX395g7YwDu9IOq0Z9gvxLFACMIOqZ4Uc8wtHq/FbGBMV AsT+bbsHReAhPJhexFzGfO+rgjtrxftP0jnhiQUvqT32B0PD/orSaCzoPA+GMBK9+FkM72qxvs6JXl YLEaGZ62Zzi9kQYBj7VwTToi7zC2E8nBmBE8BzeEx13exfxIURFasdJAiCuAnD4qCPBIgBfs6xJ5Xt eF5J1aZitx9uf1ZBaxGojLe0xfq5Kz9fRzyEBIIBSioNeDSNL0aPxstGWmkQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Two fixes for usability/correctness gaps when interacting with the stack
without CAP_PERFMON (i.e. with allow_ptr_leaks = false). See the commits
for details. I've verified that the tests fail when run without the fixes.

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20241202083814.1888784-1-memxor@gmail.com

 * Address Andrii's comments
   * Fix bug paperered over by missing CAP_NET_ADMIN in verifier_mtu
     test
   * Add warning when undefined CAP_ constant is specified, and fail
     test
   * Reorder annotations to be more clear
   * Verify that fixes fail without patches again
 * Add Acked-by from Andrii

v2 -> v3
v2: https://lore.kernel.org/bpf/20241127212026.3580542-1-memxor@gmail.com

 * Address comments from Eduard
   * Fix comment for mark_stack_slot_misc
   * We can simply always return early when stype == STACK_INVALID
   * Drop allow_ptr_leaks conditionals
   * Add Eduard's __caps_unpriv patch into the series
   * Convert test_verifier_mtu to use it
   * Move existing tests to __caps_unpriv annotation and verifier_spill_fill.c
   * Add Acked-by from Eduard

v1 -> v2
v1: https://lore.kernel.org/bpf/20241127185135.2753982-1-memxor@gmail.com

 * Fix CI errors in selftest by removing dependence on BPF_ST

Eduard Zingerman (1):
  selftests/bpf: Introduce __caps_unpriv annotation for tests

Kumar Kartikeya Dwivedi (3):
  bpf: Don't mark STACK_INVALID as STACK_MISC in mark_stack_slot_misc
  selftests/bpf: Add test for reading from STACK_INVALID slots
  selftests/bpf: Add test for narrow spill into 64-bit spilled scalar

Tao Lyu (1):
  bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots

 kernel/bpf/verifier.c                         | 10 ++--
 .../selftests/bpf/prog_tests/verifier.c       | 19 +-------
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 12 +++++
 .../selftests/bpf/progs/verifier_mtu.c        |  4 +-
 .../selftests/bpf/progs/verifier_spill_fill.c | 35 ++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 46 +++++++++++++++++++
 6 files changed, 104 insertions(+), 22 deletions(-)


base-commit: 5a6ea7022ff4d2a65ae328619c586d6a8909b48b
-- 
2.43.5


