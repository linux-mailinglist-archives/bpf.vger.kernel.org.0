Return-Path: <bpf+bounces-70503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A182BC1836
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 15:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DF03AED88
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB082E0921;
	Tue,  7 Oct 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntbdK+HT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515192556E
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844196; cv=none; b=HEpC2prfUEJc0SUjtYVO1wQapZ7Q6LKyhVfjrvahDPgbw6cWWuz+vjGzlRGZezQSghOj4IW3zilugzi2iqpCV1b7CdAHL7Go/G6wGoDyoTQvrcOMHU9srE2pTWT8MJOR42OWx4pul+NyNQp444f/pYP5a2B5pMVsd8dIG1ldwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844196; c=relaxed/simple;
	bh=8XkJQMBgYTGjpDEyHfPr16bBxLH4rujJIpTn2mn9Rew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kgol64TqAoRAIrYQMUKX6MGMYntj0vWtKUk+6pRfr3B8D/5TDcxwqdXkSg3VFaRvZm82rvXbACnF5zI8Wt8eMCkHHHB7FAzbGBM/GlJv4eI/g5BXRhpz6MccN0LrIak2ujhCj3EdZqIKTpizeXNZvG1fFbMXQRak5NfNiYrtRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntbdK+HT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ece1102998so4018947f8f.2
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759844193; x=1760448993; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iS1VjB5LCmmHhLloRP+J+56P+Q1corL8JdL1K1IOp6A=;
        b=ntbdK+HTiNt5pq+wi7UA9rCJo3VnigWVszYx6FYdvPhthCGMPWE25i/FfPZnYebHWo
         rANx+jmLIlJg1E1+wBGfSyvhjjLJp38CD50Is3HHm5WJwFcQcGZXRhixudm9CTIm0x9V
         iOT3adyWITrWphEGGWeYo5E8t0bX3fWT7Dqlv3OOQuWL/V22ChjWfM3JjZYOB2LQNSdT
         YnygEmU7mRepMuYUqNJ810EnD2y6tKOJA1b4zQ85mGN5mNprHYhtaX7p7zkzvFjasonK
         0LQ2CqwVpeDEsGdqa77uauYbXmjvb/TGD+fz/Wbsc3lHFGsrCKM3IRsaonQkhmVxlPfr
         vbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844193; x=1760448993;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iS1VjB5LCmmHhLloRP+J+56P+Q1corL8JdL1K1IOp6A=;
        b=d3NOIloEDyXFCk18JzBc+RDK2ZOZr6MsfmKRxhNqCW3cnYwqSKL/ZqiTP9FDyq5293
         +9NEA8Q8Za+x6mB/5YyJVVTwcLa20yt9ZXQNQzq0SUaofA+6lb/e2F4WviTRP1bKrxuJ
         efhwVv+59iqzMnDcDJQJTDNj0sIPXF5PaM2H2Ksk7sUDakiLiSvEoNcR4fJfkbTS97An
         UBANnCUemnB5EaisVN+n0WOOWIB4iBAvkg0mkJ7YARF+3Q1/iZoFA8CRTQVQTOq7MvR5
         dnl9hnYvXF2J4t5CCzZ/F2TbHl6wE41cN1UkBM3mRduNccr+AE6otR7Pjh4VCNBItfYI
         8PiA==
X-Gm-Message-State: AOJu0YwKNfXUcuABKxgC0Jucb4abmomt9+ZA2owpfG3Kwt0XQKGD2xk+
	s/Uhh8aVWqZZGQk1wXE6Fd9TEzv6Lz/y6jFuCQmHzqk2IoQzuRBrXAlKKv1qFEqO
X-Gm-Gg: ASbGncskE+ET9IbtLuGz/dihRy9UzZx4bYDYoI4ipHBEC+qHFzj692rxbSAB2TjKj2C
	GZMO7OPxnPNWx46w8bHfONWyQT8eVP6V1ZjJTOuHnJUjSrP4cPSYuVCirWjmbnSbIQ5cHgkzc7U
	mamsEZkiml9SlGMZOGlfl3FMiRF7qIaf1kZX1T69iPIPgcN3ZBLDDOXIYtP4Zf7vsi8Bb44bOFp
	qeLzuOAVdP12X6YWsDxKHkV/kAvpLXmTgDZTd/7w27c+8bBGpXBpLjRXzZ/Np9JXOxcUSOQk11p
	uH3vIt0IWxBOgNaMujD11/z0Gf3Xg/qggWQr6bdHUba9aQ5ss/sCeTPP7gaCFOEz3E6QpULc3Ao
	yyvvzKU9xvOOz/WLzgXcJ85VEPCbrnwDC16xQZP0LgNNn7gq+bvNcWfEnmJ1ZIARePK1hvTiOE4
	WbriSjhEsnb0u2cqSwzxfsWHSZKUcWKiTytWl35tk4rlfjeQ==
X-Google-Smtp-Source: AGHT+IHGLAOeTzEqg6EVZP4pP9PziCvscD03s0KTJYwRGZnC5qgO5gpq3QGvnqqwt7T9IxvLBMCW5A==
X-Received: by 2002:a05:6000:659:10b0:425:7165:3d3e with SMTP id ffacd0b85a97d-42571653df2mr7299479f8f.60.1759844192360;
        Tue, 07 Oct 2025 06:36:32 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0079f574fca42e1d7a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:79f5:74fc:a42e:1d7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ac750sm25791558f8f.24.2025.10.07.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:36:31 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:36:29 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v6 0/5] Support non-linear skbs for BPF_PROG_TEST_RUN
Message-ID: <cover.1759843268.git.paul.chaignon@gmail.com>
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

 net/bpf/test_run.c                            | 122 ++++++++++++++----
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../bpf/progs/verifier_direct_packet_access.c |  59 +++++++++
 tools/testing/selftests/bpf/test_loader.c     |  19 ++-
 4 files changed, 175 insertions(+), 29 deletions(-)

-- 
2.43.0


