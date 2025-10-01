Return-Path: <bpf+bounces-70151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4307BB1CD5
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC501C21AD
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A18C31195D;
	Wed,  1 Oct 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8CzaaUW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19588271A7C
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354040; cv=none; b=ExvkEUQ6cLDKXCtHOrEv7zGrPTtdq0y7U/STiU4Yizx/gGxoX8gzmjD1HLITb4tIIG/ROlP9KWabbDjiOoA3XsK02ue1vAR/z5zUreXPu0rsZZir6ha0uD25PVR2bZa5lAiLnKZ+1bpx/tBcdCUQ4oWk0LJgsrzOEjaUbkalhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354040; c=relaxed/simple;
	bh=wfkKPXIiA0ELpDYDoY3gbJwJFTZUE7tjwF8HTvW9R+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=afJmxfBaXEvVoZb1VI/AvZBvm4nY2cV8fRht7LP2aVbwyEGb2WcxJbqLCPIINEmGPxX7eJIHC/nok/Jrp8GjdGO5jJ6mAEAVh1mOzx6BIYxN5ll2f1gvRm2kL7xxb3r6urWxNzXB9iX8JSgXPMym4qmpOwZ6NJ3phFpoL773KUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8CzaaUW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso177905f8f.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759354037; x=1759958837; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LU65d84Ez7KnVp99TUPVaXsE6/B01JESuHTjGhdBSxs=;
        b=Q8CzaaUWO/BuABLlaYE9TpoNThPdxHQu/KRCbuM7ESDXEWgKTrBLhCJZXpovAogSid
         bkTDp6oSWRz64XFw3rpwQjjkpLYRqV07HZ8wiL6cbPXLW61FGt9+9OVoa9Mm/9918R91
         /VSyzHf7trQyIRzPf9/i/GxJqm2WzqSMNy1TwXdazDvwFkgzTAV021H+8jR5JWt+5Wy0
         9p3DHTx2otP+yN9Xxmf8W6mXBU18eobtYkvoL+PRBFBeKFyYkrdViy/++5vTElaALvHE
         GMMbNt56YmHdkA77NgsjrzmoBLOAVOoARGKeyUu8LLqLaiLxVjJs23dydVwUgLj20Zgj
         3RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354037; x=1759958837;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LU65d84Ez7KnVp99TUPVaXsE6/B01JESuHTjGhdBSxs=;
        b=wIuq5FWA05Jw637RgVOb1Wxfy5YFf+4ofKZhjOkF+yL27aWZR3b2WNRTnApe8jt8Cr
         w1EYsW8eQwXYoq/6EbOq2IDFhtApbbg4al6ngT35F8BMWMssnHeivfkMYwlMAqONRjIf
         CBiLfRgfSjMxNFUgs3OCpeSB8Ak4aWwkAR1E1HyuJ8QxyqpvBFtoTyXRLz/4N3wQU0mJ
         yhqY9kDreNIbEeSXSiUSJAJj3xp2EvYr0Eb9hOYpRCBXPAW8BKUmkhp4dLqi42bEVppc
         CbbgrkcS3U7qkgk3UGyo5+OLcKVqnfi203wky8BzdnwOahgk+LBIPVdX0LL8drPxq3WI
         pSvQ==
X-Gm-Message-State: AOJu0YxZAt+6HgXw8q5Wul9hlPdZmHr3dLbtYZ9ogEl2tYRTNGNN3RuX
	qZdAA8JfI9hpllIo4lDmpICc/5U2gXSy1OUfmaDtnuXgorQN7hOorF1JoOKiDoV3
X-Gm-Gg: ASbGncs0sTagIyVKrCe1wJ/M42KSj32OP1mYj43dU2QK7t/NGrwIoKJGoP6m5irg6ao
	KW838OExjKOBi4JypQ6G7bmkNMlY0vASa0/kdHnayD+wnlrm2b7loB4VpRAA1E6l1zgv+jG5bop
	lYHxut2XBjSYpIAyzddRd0hwMXo+tFSFxWTJf+4Itt3ML9ewq/7ChKBauiQWPoen6HmMkkqOe0o
	HRrgsVKg7CNc27mN8I7t8KBpx5mgTy5WDvq89xlE3t2FS0x7oPT/AyFYTe4z1Gf0RSnhY0WjjT6
	IWnvUqdmojlRPdpxZHMazOlBXSEWWbvLSwzfOagNO0EmoDF/FGDogOAhTev80lEgnMM0unRSCXU
	v6cB8wnmT4gn7BlQi4X8QSlJBKCCw3oABC0J5MDCWEoWhb/yZYVZWeXyiHWAj3p0lkZZN/qZ5nv
	+8J6qcT2Ba5tKb9BN8xcuYI58EB4dRtpC+qiF2KbrYbrnj
X-Google-Smtp-Source: AGHT+IGmX7G2LN+2MEcrWuXA6ZV5eCm+KqmbV/7EYOAVoywJw4R2EboEYUiwkJNwtX9ox/lzLp36NQ==
X-Received: by 2002:a05:6000:18a6:b0:424:21ff:514c with SMTP id ffacd0b85a97d-4255782008emr3875732f8f.62.1759354037165;
        Wed, 01 Oct 2025 14:27:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006ac507786c22ef92.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6ac5:778:6c22:ef92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9719sm719589f8f.31.2025.10.01.14.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:27:15 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:27:14 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v4 0/5] Support non-linear skbs for BPF_PROG_TEST_RUN
Message-ID: <cover.1759341538.git.paul.chaignon@gmail.com>
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

 net/bpf/test_run.c                            | 105 +++++++++++++-----
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../bpf/progs/verifier_direct_packet_access.c |  54 +++++++++
 tools/testing/selftests/bpf/test_loader.c     |  19 +++-
 4 files changed, 155 insertions(+), 27 deletions(-)

-- 
2.43.0


