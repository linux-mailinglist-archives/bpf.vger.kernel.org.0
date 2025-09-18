Return-Path: <bpf+bounces-68823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6233B8616B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B5918934A7
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE68220F3F;
	Thu, 18 Sep 2025 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClQ5msBg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5FD34BA38
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213966; cv=none; b=QKJglfxbiZJofwQaJumG2PdOvU2/kmitlgTfIystOPY1BYeq0ZRWzE+7BCkl2WeZzGeviPA+TlFt8rrE+nzUfe3C6oew6kT3LdbebECNU2C8NLaUDw/KfkMMIfg2J3mkwZ+6/S18WpwPI1rxY9zUyJAXp8ZfSQFIp0bx8o3/LpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213966; c=relaxed/simple;
	bh=8LYbcXr/+XHpm38r5jjnqbhILiCAJUmlbeUEVMBcyXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c67jUHfwazRnLOR1IMdvuYsCtjMknjj5CFIWmi1o3fjHeM2ANcW+kFo2z35d7lgwOJLRNhtsirKV+8WfFO/FjqWA9whIQ0c2Is96mVgZwFlu3QWqODJnI9FfEPp6Z3K4/YTqUS1U2bvlvO6IPNrpK8LUJuVtzSlE8WbpHrzj2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClQ5msBg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso7829235e9.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758213963; x=1758818763; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJFGe2cUHDlRVwVGwNX+f0oXKgApUFAhcUeWwI7FA+o=;
        b=ClQ5msBgP31F94xKtzAm2G+APonRA9FynpmCW3d4XJUyshen1EKhicqxH3cyrs/ulD
         O0kIm0ilXxWRZvAzmX+aUG3rP3LmgqYcr+j02zsPudn0lkMHVi6dEkp9YoMXsdxQ2MKL
         kRHg1iS1L8A075rSINQlO6nCY5/1j/Ull30kYXO7bodmSPZCVgYnwV2GJgl8UeZ1c/iO
         N3Brkk+QoPJHlsjy5Ls6BK8fAl06rJo2weRBqojmuAQplhpDlsVwXcTETn/lyIcJvTK7
         7gPMvd8WVWX2aW/TxpK0ETEwJWBAH1qSybKFJQgm9xArzpMNNsVJGHCBMqXHSAv4I3du
         Pelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758213963; x=1758818763;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJFGe2cUHDlRVwVGwNX+f0oXKgApUFAhcUeWwI7FA+o=;
        b=Lm4l5zV4j6C1DdNWRBzJXSVIJ90/eeKqW/2mZtYbcOBn8rc8+0uVBVViUDMlaKVLzI
         hO/1kdbn4enn082l452i/kkUBieVGnW2wbdHSX7WerrFg4t1Xf758lGQ5cSivUjvl81h
         iugiQKxJoCmte8DRA0zD7ZoWVcQuDUJUhVhMNAZ3zutEhe5Qzwg8mGjYm9xFml/0CN7R
         LJSa68QRayU7tcGbPbLoq5d5ZxacVoQxNWlwkbaf0SGL6fwlFfB57/YoiVLDjciPX3da
         ilI6GXt0tq+khFLeqMnmT36bkJa/MwoYH6sA7s/0XEFd2l4ByLM32zR4gwh4xtytQb/H
         T2Lw==
X-Gm-Message-State: AOJu0YxQukAuVvic9YKpISI2i7VFrk/1yhXXNaB2Lfz8K4EaDLoZ0oIF
	fVKR+zkj2cehurMGunUkuAmhfgeok7KLVALAzGn704tX/Xv/XMFBvuDj6mOB4NYT
X-Gm-Gg: ASbGncsP5ogLSSaPFpuIyKidoKWEAsZTwTDz481Wy3CCApHAEjvKrlyzzlFQ7KVhVNr
	C0r7tZumVU3uzdJTNDNKtiD4q87hmk542/9JJVyxt1Q/uYH5meruvISMWm6PRfzmpv0vxYkOTM1
	52BdlI77aUUyoQ7DRvKxJpx5hD91tGEJQ0NHGOxAmsfjPzTM4XWpZrbrJg3zHtmEBRAVwzJ067/
	uyppp5YTifE6TQhOfkeXMo9fkye+DmH6OGJs3g5/9Y/M/PLw2NlITSQl+4/5v/Tsd9aIAl3QAQL
	MTS5i4x/zPhYk8UPAa4Vr9Og156vsqfguqeIIbIvbn3KtiosMx8fpzAX1GbjSra+KgtSAcOMPMm
	DV6LxEMwym/TsBL2Dye2TVHR4XsEXx0cHvOVspcMMOn8EvJIFcB6arvcaFE/t0hU6bl3/3cie49
	gHmwVV3ZS8OCBJ+ItbWH58vHGIIGqC1k8wtAvT3A==
X-Google-Smtp-Source: AGHT+IEvftHXaxOodJCxlx27ZzJ2dDvp5DE5gqYdOiIlhapnTfaKrX3307Y+9/eWZSC1TTkO9Sr8gw==
X-Received: by 2002:a05:600c:1c87:b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-46201f8aa4bmr61988575e9.2.1758213962306;
        Thu, 18 Sep 2025 09:46:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c3e9035ed76de3f3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c3e9:35e:d76d:e3f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07412111sm4352483f8f.28.2025.09.18.09.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:46:01 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:45:59 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v3 0/5] bpf: Support non-linear skbs for
 BPF_PROG_TEST_RUN
Message-ID: <cover.1758213407.git.paul.chaignon@gmail.com>
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

 net/bpf/test_run.c                            | 124 ++++++++++++------
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../bpf/progs/verifier_direct_packet_access.c |  54 ++++++++
 tools/testing/selftests/bpf/test_loader.c     |  19 ++-
 4 files changed, 162 insertions(+), 39 deletions(-)

-- 
2.43.0


