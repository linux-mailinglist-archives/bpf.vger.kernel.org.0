Return-Path: <bpf+bounces-46814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9539C9F0329
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 04:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA9F169914
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A84156997;
	Fri, 13 Dec 2024 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyKFo3Nw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B177102;
	Fri, 13 Dec 2024 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061282; cv=none; b=HYth9itI/o0UvUJcK9K3ijjaAQAwj5Or19VMrpGmdXd6D+EcirduDXrhX0edZ8vK+Dm47feEjiub01wG0l9YFCvct+k/RUPCUzw0XK0Kt7C/iACwOWs48MQlxgpGaC+1Cb8MfJO2ke6HOKOZZMUeOUIKlF7+d0SWM4JsTtQtaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061282; c=relaxed/simple;
	bh=YA9jKWE/ISkrlRMxcODx/+zBUNNSFek0LMti2lEDhX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bblUv7bzLFY4Ei+JkgHVCPVTZJl8AFu7gxY3wTmBUbT5kyPXE6PHbyhrsNnoiRelHdLSumkCB+zGb2qahe7Ax80KbTUE1JqQzVk2PI8nkrRH2QmjGNSnbWFYCakmkJVcV9uy83oiAdP1B6l2yBP64xtc4Ql0oDMUm5lS1g10yng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyKFo3Nw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21644e6140cso12024165ad.1;
        Thu, 12 Dec 2024 19:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734061280; x=1734666080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pB7aEF7ip1sZGAqzqJyRFdDgYaaSCnzEvd2juJvYCmA=;
        b=RyKFo3Nwh5T9exd7/gVmN5vETy9Bkdi2kbRt/jkcXbCGQY+yG5VAgJsqBWkF++t1o1
         VQpPhomkDJgXfDR3TsH6LnfRWwVzxZG1g5Lf1eQK7huuvxeh+tVKDws+NfRSYubU3hvs
         AnR97O22HU37v83dAFgCjRqrerCz+mqEJZ+Qvd5alU/Bjei1BpanYEE8WfsEmclgZBTs
         DJ1zg4bSOHfcvie/f1S2XfsTD/gDVaAKNReV7+4o29memG9a50vbmlcSEh+eRBxU+VOw
         2L4YmEIndLYQhPkauXP3/WND8VE2B1QZWsbdzqynsOtj/EpLjU9xBp405bjz5n4ICVKs
         MR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734061280; x=1734666080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pB7aEF7ip1sZGAqzqJyRFdDgYaaSCnzEvd2juJvYCmA=;
        b=R7tKQyhbtfb6mFyf3RhAsh+3sUh07ZDaTrI5sbs46+LlZl1ZBsxqTqiDfKtTCNDyOl
         Vv6daIrC/1jiBOz0YW2Vb+mff5lWGkQuPKn7doFoc5kj29zaN2Q9YmnUzlsfb8+ym/vN
         ozJwvP3wnBaM897KzNLMGwHhNVN6cIBKcwCLfYQbB9EoRHTLggdLqtLFxZNAqPFP7BD1
         e6XNyB6APG+I7nyRrpwn+0Vw+D9bXPUKwiGCW1L8JPN+aE92o6twpUgGH+sFAJtsc968
         Hs3BJV5dAwvbMpUyT71frUwAlRfP9FvHgVBqPU82ejBMeekvfiqgmUoX9Laxxx2STAgC
         Rx9Q==
X-Gm-Message-State: AOJu0YzUKneDt0EcPDYaBdhnahElrfPJ1l9pFt7p/hTL7hkq8LwAw2wA
	PNd8LrA1oS6T+d/+DNJ9s1+7UlHGdvECYDvuHhlWZp0dr1XgSp2bgZ3WRw==
X-Gm-Gg: ASbGncu01OkB7j0MY7q8tZhQMhqyU7Q1Dz8KUHVt4jqz2JTiUFR/Diy+FmVYpYPKpcV
	VDFHx0C7yEfkOhdRQbjd1yqCQkN25PzItp45In4g6QDs6DJzlL1k2jWZTxOZ2iEBphnWazPu4hk
	U1RVYHltDXlYUQn9ReynayxZmsgtc7uPA/oY3EJfROh00Vli0lPa2KkW+qC+D3FWcq5ycw/c+fV
	0MM7BwWScalwR8/AQka4fj+3X0W7l4q4KRb1ORh7rR9W6OfyEPrvraMmD1bC8SpGoEdtFNwJawJ
	Fl7EMNE0AA==
X-Google-Smtp-Source: AGHT+IHBG04BnoBpdc+ILkWpW6f09vqxteaezq6GhxWCopdRWXYDu2osUFNKGPwx/iBwBImYKwbkvg==
X-Received: by 2002:a17:902:eccd:b0:216:7ee9:222c with SMTP id d9443c01a7336-218929f2129mr17648835ad.7.1734061279597;
        Thu, 12 Dec 2024 19:41:19 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:a642:75a1:c5bb:c287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163725faf4sm89526435ad.196.2024.12.12.19.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:41:19 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf v3 0/4] bpf: a bug fix and test cases for bpf_skb_change_tail()
Date: Thu, 12 Dec 2024 19:40:53 -0800
Message-Id: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

This patchset fixes a bug in bpf_skb_change_tail() helper and adds test
cases for it, as requested by Daniel and John.

---
v3: switched to TCX prog attaching API
    switched to UDP from TCP for TC test
    cleaned up TC test code

v2: added a test case for TC where offsets are positive
    fixed a typo in 1/4 patch description
    reduced buffer size in the sockmap test case

Cong Wang (4):
  bpf: Check negative offsets in __bpf_skb_min_len()
  selftests/bpf: Add a BPF selftest for bpf_skb_change_tail()
  selftests/bpf: Introduce socket_helpers.h for TC tests
  selftests/bpf: Test bpf_skb_change_tail() in TC ingress

 net/core/filter.c                             |  21 +-
 .../selftests/bpf/prog_tests/socket_helpers.h | 394 ++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  51 +++
 .../bpf/prog_tests/sockmap_helpers.h          | 385 +----------------
 .../selftests/bpf/prog_tests/tc_change_tail.c |  62 +++
 .../bpf/progs/test_sockmap_change_tail.c      |  40 ++
 .../selftests/bpf/progs/test_tc_change_tail.c | 106 +++++
 7 files changed, 669 insertions(+), 390 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_change_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_change_tail.c

-- 
2.34.1


