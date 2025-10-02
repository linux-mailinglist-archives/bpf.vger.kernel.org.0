Return-Path: <bpf+bounces-70188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B948BBB38A3
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 12:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670AD167E4F
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F54305070;
	Thu,  2 Oct 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhLk+2io"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20272ED869
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399438; cv=none; b=iqHG1ejHPSM3ASWkxoAPdBnhOon5haIUqWl01MswhePGiP8cS7UPlBu6rTdpY1OBBBTNdZpe3Xf72BJVbnoctFUl17d2VNq5s9NQYebyxX6Rs5+uRHxuxGCfGArPXE6m0zBhOCORl1VgF0fDnOoAHjK6p9FjawNyT2ZaJV1um50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399438; c=relaxed/simple;
	bh=SHPweq2ZVBTsaiJT4LUYnDueMqlLJMEVwG+hAp0ok/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kIEWRdvtEYSaGgRoGzevzkKsgMVdAvgPXNi94V6RZJZwcaAe8YwuEChOTnOfsC6gKtJO2ZQmMLBk7J7EPT9KRuzvJAuTs61xQqd12XcIr2Wnfd7vso0Emn34yE6KKN9VhWbWQt22AYyhETJd6MTp/6hrwOxlT8KBBh8V2XGLMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhLk+2io; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so2831685e9.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399435; x=1760004235; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wjw1cl1WGV/upybH0m18YkdaKxUMYJb0pDw09XtzoEU=;
        b=QhLk+2iojqMVJitfkxe7sv4gz0eXjHp9vXe1HpKW+M0jkhUXvl3AhU/5vIhDozQqhf
         UvsruvXYMU3GJuOmXWAzDOJBnyoqmHlHid/J8gPzPOGlnIdIbIVp05/X4bE6yPHbJVFF
         N8eb92O1t5K2bQ0YGZdUmeWy6Y1TEss/ctUmYbzdOqv7lVctG2osOS5+jSA2RdGYqgyk
         EYtcJBX2p5fW4YV2Ef0mIdgHdWDDZq4dWJ+o3qxHv66+TK7XyeNZZA0NlXY9Gvkig/Mp
         VrGXNUdVfeQuvzA+GmvC6i36yTiGs7MGoo2JK4jIfVtBRcAe7RCCWCwmt3lQbEHISDQP
         2v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399435; x=1760004235;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjw1cl1WGV/upybH0m18YkdaKxUMYJb0pDw09XtzoEU=;
        b=Irbv68YJLGwBz3hHEx5cbT/Lnr2DC1QTDruBQ1lKp4/o44XLfTV3jjXb2Gm7xIBnEd
         VnveVWVyrHNzRJyLVevONYsRG6lMec6iCRyrNkJPVEcsIi33EthzjF1LK2Wb3FsMCG8E
         D9Q6sjiDEWP5/rLinFo9CcF7gz0PHA0DIGriffzWAqoeRKn2DPKbmXhr//MVUUguu3pY
         SWtboGvAYA1foXDgRvSSPj1W66t5b0l99XOegWQk8T3Twjj3ZuUJx9tOgM/2AoJ/6Qzn
         HbbUpscBWq1Er7tVjEBIxbDCe2+0DqZldoqDu8gr33EEr1m5rc/eKl+7u3nIcz8goosl
         INHQ==
X-Gm-Message-State: AOJu0YwxAexNifPL5mpki/v/GBD8RQQAX38zR5lAyFT2W5iJtR9foRJf
	YXiw8iLpZqcMuIRSmlYWRNOsai8PpAaeEVCY3JVDQj+21tCVOGuAkYclw8MyDsXu
X-Gm-Gg: ASbGncu1rolSgCzgjbWebiTPjtnzRNvbtAH0IvsLHNAAZ2B9sDOSjjV4Uw4YpYFOF54
	kWZTXMETEcSy7CT5a8IPpoYvCFDL9wLibadv0rHbqLm6oCHvi+d5WrrFb2R5Hq1QxN7wpulkvYo
	Qy3LYk1H/U+HDvH8xvKtcckdLahw6l7KIJ6HSZQHdclETSTJovv/jsIRtGcrIlUJXmXtFOzY/F9
	37valjHi+4stbKYFOQViJ0zxpc1Mxd9OvkQRQ0VjLTsIXLE8mhArDDvuDfNmghi7VDxAcnXitoG
	3cEDh0jMUEGbQR0F7kYO2voO+MTbBJsG6zw8XnfxH+EM96WnVai1AJEBMDdJlxRStpCpXFHR239
	4MlDeJ4FNc2dk5gBAcrwl6m+nYDGR154Q1frl388iOfnV4pp5qmO9s3Tze0mTlKKgRiZfBlQHp9
	zmNjzLagVaIvPox6nz22t2ruCGiKS3HbJ+qpj9qqTQH40=
X-Google-Smtp-Source: AGHT+IHkoi0u1oMyJZKi4tbFwqEBIgVYPSoh8U9zR9O7wKeC3CEIuU6Tqp1Z8z7OycZFO5BDKev9gA==
X-Received: by 2002:a05:600c:1c95:b0:46e:6c40:7377 with SMTP id 5b1f17b1804b1-46e6c409098mr11612195e9.35.1759399435158;
        Thu, 02 Oct 2025 03:03:55 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000a5ae04ae4e6e63e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:a5a:e04a:e4e6:e63e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4afb3asm52689405e9.6.2025.10.02.03.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:03:54 -0700 (PDT)
Date: Thu, 2 Oct 2025 12:03:52 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v5 0/5] Support non-linear skbs for BPF_PROG_TEST_RUN
Message-ID: <cover.1759397353.git.paul.chaignon@gmail.com>
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

 net/bpf/test_run.c                            | 107 ++++++++++++++----
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../bpf/progs/verifier_direct_packet_access.c |  54 +++++++++
 tools/testing/selftests/bpf/test_loader.c     |  19 +++-
 4 files changed, 157 insertions(+), 27 deletions(-)

-- 
2.43.0


