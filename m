Return-Path: <bpf+bounces-68315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE19BB56A07
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 17:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8C23B8A40
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3602C325F;
	Sun, 14 Sep 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do6tqcjd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160029CE1
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862533; cv=none; b=HjevtF/isNgieUqJlc7dZMyo8aD5vwg5BLQIp1u9nRprJaH4odbYQtEi73BlAX6+IFxgevxjtucuJLI9k6qreRNYpVXhJ/CZLY+lEEw1viqxVjSzNRI+z4GaxKe99Dc+cL0AfJOU2WL/U+Mb5qfq/6pJI12+73AGBBACwGCWo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862533; c=relaxed/simple;
	bh=EUskILJDWQS/BLrvo8xXjbEZnklxdq5QBULKCZDPA08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hMBmdtwdpntvJHT79IPgoCw2Ys4tiPpGA9nLMmiPSZCe0PlbyL7NXziZZvib+yCdTrKCtPjA3r/tgpVF3leOgLO3GgR6Z59ZWQ59jTv8cKvagGb0hxuwrP2awCi3qKRygQXnRfpILHJGg45VfhETBRpA0bAUO6VtIW6Qv224OJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do6tqcjd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so2203429f8f.2
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757862530; x=1758467330; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=558XoSP8tLE4E7qklCsbEZm+68aFXNaiC9zmsiHseSU=;
        b=do6tqcjdBEFwXyS34zPPQQygBdKf5iDsICdbSCew/WlPphA8DHNDlLizXXEyaqVTtQ
         TuBHEVQC8Au7mCoj9/JSVT4UWrea5S8piN1rjtIPnK2z5h1Dvhn9LG8IDD+coeXMmtki
         Hlnhbdgzb0QZN+KlILR3uQKWT515eKpNLqQJpfodcymeKeGy2io4ie1oebsHz/pWW1Nk
         aBxVY5SuqZWkZJQ0fRW6NXqoxLbH0CXPTijYFMYnsNTusuuqRA1AYVQAX75PY7aAqrHR
         +4ipdhrcZY1If26ukKAXjARfkO5TvMqRc27zUcXqtronOraLxRZA4Q8Wg9Jz9lHxqFmE
         KsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757862530; x=1758467330;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=558XoSP8tLE4E7qklCsbEZm+68aFXNaiC9zmsiHseSU=;
        b=oQoeoD/WqsK0F6dKbooFrXxqfpVk0I73XMILV7CcKdxRVTxBhvfFlACBJBpAWbOYUe
         jhdFL50ENsEzqfqcZ8oPmXneMhCX06XWt56yXM4GRFmP/L1/WYHHj9nNkh/OqydUZwgr
         YsdJTO/uqiUdoxn6uvbf7Rc/+mPlfz5p9o3r3+wR/U7ZYxjxPfloEjwGni0cF+VAoqOi
         7zphd2Zqi9LUmAtXg0mMlXIbSdgEREFeiWcIkg0NE5QIzJCqo0fmUDjWZhzbFKx1IFDy
         p7o5oFGhkMevhjQj50t/s0YxvWzYix1ll8xj0m+2Ajf+bz9zJCHBvWt84AuFdHN+iEAE
         UAzg==
X-Gm-Message-State: AOJu0Yx4sxrpBiEgFbsXzHuuaz4OH/k5e0fmcB1P2PzQWj2ksOACnkoZ
	PtNKVAfYWJB7JWIaCAedf+G86G2gH3YH0O4D9o0z2Zv8BbJatVyF3RQ6h0FlP83/
X-Gm-Gg: ASbGncsCejHgHQMKoUIIoKb735N883Kejf5WFO48FQXoKlHOwGwdvJqJZQegEONInX7
	10xfENMRyAHWdS/R4OgWaYEU45JQ1lbLmTdnt8hWLnvXWS1IAk7AvvyIuAXNVTD2+RoXalfytiS
	INxKzq56M4SN+GcuJDOBfm6JHI5z5cJ25b+s4F/TdYMN+eEuqWDlu+5saf81W9srMZ/JYzBuhXI
	YkZ7uG+iSoBi3G+2nEPoRvuzZqjRp/kzE3I10rhL4yrfHw8sKmTwDTZqQNSzLtuf2gb0Zelji1U
	tV4h9Mlwehx/FifUsVmKHNQ0PbjEfw15aDWNGBj06wEA56PEtx1rRGneSC9zstEE9Aj3mAa9Bfm
	LjRg3yBOxAnWFoRrA9hoB4XbBN3bVO2H3B4R/ARafJXQdaE1/CupHIyF6jCUqjwWWZ66iPt59gw
	WNhjOPRLSzWxUTGul/Y/zeWHhctX+ZVA==
X-Google-Smtp-Source: AGHT+IFm2C3pEqBvzg8TSO1xqCqgjrNqerc+i9Q40ktAKDnIaBGOGN3D5WtyQO8zpn+RkEIM7JahLw==
X-Received: by 2002:adf:a143:0:b0:3e9:ee54:af6a with SMTP id ffacd0b85a97d-3e9ee63fe79mr1383375f8f.45.1757862529727;
        Sun, 14 Sep 2025 08:08:49 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00829f05581a33a178.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:829f:558:1a33:a178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0185be34sm78555575e9.4.2025.09.14.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 08:08:48 -0700 (PDT)
Date: Sun, 14 Sep 2025 17:08:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v2 0/4] bpf: Support non-linear skbs for
 BPF_PROG_TEST_RUN
Message-ID: <cover.1757862238.git.paul.chaignon@gmail.com>
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

Changes in v2:
  - Made the linear size configurable via ctx->data_end, as suggested
    by Amery.
  - Reworked the selftests to allow testing the configurable linear
    size.
  - Fix warnings reported by kernel test robot on first commit.
  - Rebased.

Paul Chaignon (4):
  bpf: Refactor cleanup of bpf_prog_test_run_skb
  bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
  selftests/bpf: Support non-linear flag in test loader
  selftests/bpf: Test direct packet access on non-linear skbs

 include/uapi/linux/bpf.h                      |   4 +
 net/bpf/test_run.c                            | 120 ++++++++++++------
 tools/include/uapi/linux/bpf.h                |   4 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 .../bpf/progs/verifier_direct_packet_access.c |  54 ++++++++
 tools/testing/selftests/bpf/test_loader.c     |  20 ++-
 6 files changed, 168 insertions(+), 38 deletions(-)

-- 
2.43.0


