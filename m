Return-Path: <bpf+bounces-70654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1F9BC964E
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34FF64ED325
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ADD2E9759;
	Thu,  9 Oct 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcMmgzAQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D461DE8B3
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018364; cv=none; b=c7iBjKOuSxHaZhMPa/nPoWVrHLs1vi6pbteFzcBrxNtHpDBcuHyOkWCOnzzYfchQZPHs41jKpwLfkJuroSkIy7u09NfZXcx0ZOQRb2KCkzErEqYOSu3m0FwqyHfBKNViRPQpcDaLPcIm2OzdGeUJ9Ui/3a371ThsF3kroYfV7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018364; c=relaxed/simple;
	bh=jE5kzln8wXnOsGtIXaqQhyKPsoF+WxQCdYE02MpTMKw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OICYOvhQCP+A2TQG389xt1KjOwdL57shnpMF2fkbK1C73p89doM1I0NLWKCPR65Xu4gvN8UKnQqvhrNG/M+CLo0qtiFZuqLFwXTpsB2lvYL8ZVcCaUW9NqM8swmXQVIRGjSh03Vk82nGYVcBgojHBmiU2nPfgS4oBWRQkttoX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcMmgzAQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso7134745e9.3
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018361; x=1760623161; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6/cbpqWn4TuvMZDPJZTxVlc/kx6+7ZLIvq1LaUqTgk=;
        b=lcMmgzAQYn1pjvMzwU2GKfAeRkQg/E2cTJ8DEZ5isJXihHj9RVX2AyAyd5z72lzDo0
         nmX572iDn4c4APd9QfgRKAGJaLS2Y165HrO4JHn+CtnfFTc/vqfiHM14rvbkQyWYYife
         e/Qed23tRUpncg327ChpQn9H20cKv91hpY+kJv+SrLjwgvPBKhpyHrt87h7GKBxSbBum
         Yl0zVoIy8x872KzTdvI5op8KwBlW9DWFCsgyj1n2WKdwZVW4hh5U+Ae/ATQalvp94emA
         q0yLfuL1LwhFAwGRhrI/I+AXWO7Eu9NMOPJNydjpEI4F/2n51NxHlDh6UzAyetsoW6ZS
         9gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018361; x=1760623161;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6/cbpqWn4TuvMZDPJZTxVlc/kx6+7ZLIvq1LaUqTgk=;
        b=mv9yeRbzKliAqbVt3WP1SmDlS//8K3cHw2WKK+PtKoH2cklq3fbQYEnWYtYIadQrHM
         ifUOW8u5h/Is6uWjxJQhO7axDcoxDRmumXXnZzI7pme4cmr4FKXovplLaUKf74Qalv37
         SvtZp0R3a5kfWNUGRrzBzsIHf6+XScG2WYxaHbxxKOHyPHul+JAxBNtvZDLz6XsmylT+
         Y8/9rTVAL7pVadil+h3FZe2GrHaVL8sWOfjHImEEOYcycLy4xYO7jPNLQkZNVyrXb8dg
         HOrsxCCUo+UuvOtWLO7Ac8c6654z6JQzXZBvUIBoOQ1G4I5qmvdhkpujiLxnSmNHYngw
         15AQ==
X-Gm-Message-State: AOJu0Yyaaqm55ZIXiz3S022R5i2QhYu1nfc80jPN7/6f+Y21DF1ZRjdF
	sIrQARSzQxom1JiYS0nx9gMMH5Rra8vjXYhN3NNOSxDj7u0Aja2Dg1VIwtoSqQ==
X-Gm-Gg: ASbGnctTotMGGOKKx87RfBTJsiImgVC3BGfWplU9OCM1fwU8mA8PfYewOpiel9XCBMe
	Tu8LpXlru7HE12UfBqxz9sOhFsP112nqfAkIcpjFAc92zXNBP/Ob2w80JaRd+cHEfub9DiucVR1
	ARUj56ZxdGm1DIZaxvlPCcJjIKKiUZ2uwEXO/q7wS3AmSbYI4RLhYxmc2xzyYnhhJnU65GABMez
	2pXY89KjRH5tpBbUX3og+PXxSP+Y8IbEZPYmW4ydBsrFj5apo1bH+qG816NonmMGyJbatMxb0YM
	ngpdnjsNajsWCYbSziqV8+pziJVRyooM50QAudR0Svoa4HWxewnj/PXmIlM+tdF7SI9dWGWsq8a
	oHdGGLKt/441a63KMlLf9fzd5ZLaRme0nIeU5c/sm99OPJ7zS4lF+QRCdQwUs1231VSTe/cw27k
	LBMskny4OhR2qQFoDaWCq83uA7FdQdCIvCWfkPGJaHSL8XcwRclb0vW5qS
X-Google-Smtp-Source: AGHT+IEWawXH6Y3G0gl8FAefuBCthxCQmmyYDvORnR9fSJajX9qnBLCah48xcAYdAi3amWH/70t/1Q==
X-Received: by 2002:a05:600d:8110:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-46fa9b01fb1mr57581035e9.30.1760018360413;
        Thu, 09 Oct 2025 06:59:20 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c0e35dsm88272005e9.8.2025.10.09.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:59:19 -0700 (PDT)
Date: Thu, 9 Oct 2025 15:59:18 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v7 0/5] Support non-linear skbs for BPF_PROG_TEST_RUN
Message-ID: <cover.1760015985.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset adds support for non-linear skbs when running tc programs
with BPF_PROG_TEST_RUN.

We've had multiple bugs in the past few years in Cilium caused by
missing calls to bpf_skb_pull_data(). Daniel suggested this new
BPF_PROG_TEST_RUN flag as a way to uncover these bugs in our BPF tests.

Changes in v7:
  - Refactor use of 'size' variable as suggested by Martin.
  - Support copying back the non-linear area to data_out.
  - Minor code changes for readability, suggested by Martin.
Changes in v6:
  - Disallow non-linear skb in prog_run_skb only for LWT programs
    instead of all non-L2 program types, on suggestion from Martin.
  - Reject non-null ctx->data and ctx->data_meta, as suggested by Amery.
  - Bound linear_size to 'PAGE_SIZE - headroom - tailroom' to be
    consistent with prog_run_xdp, as suggested by Martin.
  - Allocate exactly linear_size bytes in bpf_test_init, spotted by
    Martin.
  - Fix wrong conflict resolution on double-free fix, spotted by Amery.
  - Rebased.
Changes in v5:
  - Fix double free on data in first patch.
Changes in v4:
  - Per Martin's suggestion, follow the XDP code pattern and use
    bpf_test_init only to initialize the linear area. That way data is
    directly copied to the right areas and we avoid the call to
    __pskb_pull_tail.
  - Fixed outdated commit descriptions.
  - Rebased.
Changes in v3:
  - Dropped BPF_F_TEST_SKB_NON_LINEAR and used the ctx->data_end to
    determine if the user wants non-linear skb, as suggested by Amery.
  - Introduced a second commit with a bit of refactoring to allow for
    the above requested change.
  - Fix bug found by syzkaller on third commit.
  - Rebased.
Changes in v2:
  - Made the linear size configurable via ctx->data_end, as suggested
    by Amery.
  - Reworked the selftests to allow testing the configurable linear
    size.
  - Fix warnings reported by kernel test robot on first commit.
  - Rebased.

Paul Chaignon (5):
  bpf: Refactor cleanup of bpf_prog_test_run_skb
  bpf: Reorder bpf_prog_test_run_skb initialization
  bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
  selftests/bpf: Support non-linear flag in test loader
  selftests/bpf: Test direct packet access on non-linear skbs

 net/bpf/test_run.c                            | 141 +++++++++++++-----
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../bpf/progs/verifier_direct_packet_access.c |  59 ++++++++
 tools/testing/selftests/bpf/test_loader.c     |  19 ++-
 4 files changed, 182 insertions(+), 41 deletions(-)

-- 
2.43.0


