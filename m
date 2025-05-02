Return-Path: <bpf+bounces-57279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC7DAA7AB7
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 22:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D1B7B59A6
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA1A1FBC8C;
	Fri,  2 May 2025 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIQrkyd/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0C1E5018;
	Fri,  2 May 2025 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216987; cv=none; b=hOE2VG9ryOxVQZiyOIZB10VivGBAGSlrJBTI42yLFBTpkHjB1gJklCv1D8c/iUsv5FGYQcBXmlvtet9h/5coA4j9uJKA1lawnvQSf446XfCxDPV+x2gX/Zz9ARSkfQsoPwWC2uXaF/nYDqWZL3GsyGexpbgGMnbE9Pb+GZGQW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216987; c=relaxed/simple;
	bh=By0nI/Uah9tzUoQmwxi/mBhuqe3pZYV+eYsD7oVllnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqJ9O878lKzkswfRbsh0map7rmz2US2wa8MCtru6KPtllmBKHpFAJez1UavdvR9q+GmAMbTsN3WUUOZOeWZ6w2MV30JyRODvCM7L/0i4UHbqWxpkYI4FDDlh0n0wmtw5Jy705Vb720uk+0CV/buvpvCPTTxjCG5ePOVu15vJ1fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIQrkyd/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-227914acd20so30129685ad.1;
        Fri, 02 May 2025 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746216985; x=1746821785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LL5lYrGOsN1TXJBXHfkfn0mVSZaxvHWW419ORusS2B0=;
        b=WIQrkyd/9DFlL3NSMs5QtJ8i4y4OtWaDwbPHLbMtrKRU4MHay70aUS9ge2M0VtxQAg
         elL2EUsd+YA8FCNfz3W3TYEleRP56EAg7I42LBCiBgLFZHN97Bhp1tOb5Gmow6lWHwEe
         KQqq1xzhvmKaEUVMUT249jVWA1ZqBubmulFJqIYmQEzNQhRiIAtkENedSzqxXyeipWWt
         N6anydeZZ/WquqtbOFISo33Uz8ede2lJhb8Ceq2yaJprWJpOUMiOJJw6QuCWFnf1/5i5
         sIO6vkK7RPAMVLMiKjFdgf7t/bTxTczi1uiZuSeIIkgcjxZZ5Z9sgUixBTx4cb5MDKXB
         NYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746216985; x=1746821785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL5lYrGOsN1TXJBXHfkfn0mVSZaxvHWW419ORusS2B0=;
        b=jOpYMSgZcueOqk41eeXRRO195wnUthxE9NIC5lU3++bZnGvDb8zmvX3A8sBZZe/VFl
         Qgqa6URGLJMT1vhdu67DbYCyhDTmRLezKKxIc+s58iOmZLPUf1QB/xl2ZfaVf0h0rS6t
         v94UXxgxXf64aW8mOnx0st7EARgE23EiY3StRmTp6hENN4Idrq9pxUTRT9e778eD4mgb
         waxOUnCWO+u93VlZ8nctmp+U0rHSNq+ik23ev4MRStKDVVgED1t/m0+2zkCe79KkTX5H
         LxCNPdtCOavDAfUQNyCzoP2LeSdXOyZberqW8RO8aB6e2bl3vKhrECvRml6yJjRuvp5j
         hGdw==
X-Gm-Message-State: AOJu0YwRu1+uSSVztnXIhYzCeLQ5bHbri5+eNxUsTvScFas8JtSghh3u
	qeg3AseOWC4uUsdVadhxzWQeNpN1U4EbEeA+c++m4rgGNIaLeNqRXfus2A==
X-Gm-Gg: ASbGncvvHUjVNIBcdpEi8hccilxA0Q3qjvZyyp7qF+qplTKXR0f1uo9JvG3ncC32+dR
	CAKlTbyDyo5CBKeb/2DgmaxkaiND7o5mGsR6EhIdEFZM6QI5zfnnQ6AsjpdwCX2jzDNjWe8u2Xd
	5NVZmZVlPNWjnre2GwrfJghC3X70Ehe9l95Xj8hulo7jpJ58IQMfg74JGE4Tm4VItb3J1mOa53D
	c4cwSpyTyB7e87OgaCLPCKmGN0FIRQ23NTUnLalHQ0imNpwaW1SuufFFORJRGXMxzCKdiEzqTJP
	39e2+Z0RTHx5falSYUzznBG8TYaMspwn
X-Google-Smtp-Source: AGHT+IFoHN90qk9yu6USUPG3BMDit02CbQz1zzIzbK91aT4z2GTJ0Y8cylM2G2fUBOCh07eWxNa71Q==
X-Received: by 2002:a17:902:f745:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-22e1001e466mr64113505ad.2.1746216985566;
        Fri, 02 May 2025 13:16:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e173b584csm6415385ad.16.2025.05.02.13.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:16:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v2 0/5] Fix bpf qdisc bugs and clean up
Date: Fri,  2 May 2025 13:16:19 -0700
Message-ID: <20250502201624.3663079-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes the following bugs in bpf qdisc and clean up the
selftest.

- A null-pointer dereference can happen in qdisc_watchdog_cancel() if
  the timer is not initialized when 1) .init is not defined by user so
  init prologue is not generated. 2) .init fails and qdisc_create()
  calls .destroy

- bpf qdisc fails to attach to mq/mqprio when being set as the default
  qdisc due to failed qdisc_lookup() in init prologue

v2
- Rebase to bpf-next/net
- Fix erroneous commit messages
- Fix and simplify selftests cleanup
  v1: https://lore.kernel.org/bpf/20250501223025.569020-1-ameryhung@gmail.com/

Amery Hung (5):
  bpf: net_sched: Fix bpf qdisc init prologue when set as default qdisc
  selftests/bpf: Test setting and creating bpf qdisc as default qdisc
  bpf: net_sched: Make some Qdisc_ops ops mandatory
  selftests/bpf: Test attaching a bpf qdisc with incomplete operators
  selftests/bpf: Cleanup bpf qdisc selftests

 net/sched/bpf_qdisc.c                         |  24 +++-
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 120 +++++++++++++-----
 .../selftests/bpf/progs/bpf_qdisc_common.h    |   6 -
 .../bpf/progs/bpf_qdisc_fail__incompl_ops.c   |  41 ++++++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      |   9 ++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        |   6 +
 6 files changed, 161 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c

-- 
2.47.1


