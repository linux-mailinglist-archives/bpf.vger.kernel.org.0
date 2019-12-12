Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4154E11CA87
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfLLKXD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:03 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:46282 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbfLLKXD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:03 -0500
Received: by mail-lj1-f173.google.com with SMTP id z17so1618941ljk.13
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z9bKATTNavD/GsjKBfQiZ4h4LxYRoVlRyKN9L3mPaVY=;
        b=u/RQ5QVRRJ/RcXPGrPeqkaQkIt+SmsnxhkNxjvg5GWCVfCV+mHyuCg/ohqknp57iME
         u8NGKB6qQkkxJSlSKoGm8Xu+Q4F+OJQEqydg2zeBPCO+tUYr8M2eO3At81gRByUOZ53S
         tthMrGEhr5JuWCfpIsucK7JHA3YBiH9UkszWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z9bKATTNavD/GsjKBfQiZ4h4LxYRoVlRyKN9L3mPaVY=;
        b=ZEc2Xbn5F9XacwMI/Ggp6Gegp66b1lInG/wWF8E6bfzJcSC2qRxbb8SnCClbwym21J
         2uDeuJ5z9XDOqsVuutpLk2ullpkhEsgzzip9ZgdqGq6YMgUlGtycy9bAKOfjTDEZnEeV
         hjRw8q+LKwbSmrRugs7wxwSE6Bbghbts4MSSRjrAboCu99A+N3mSXc3ZHUXOxxI57+6W
         RdIq8DIs8MWFftRRAWeCSZg8l3TYZ6MmOBjLJ/wNvyP2/7fRLqBVxpTFvUFiphcpuNgB
         hcTXS3Rckcab5U/XXR5DUgQ8MXRgB1Fd2E4jRhXUn1pUv0Jv571Fp1GlyYpCFzZZ29JH
         xMmw==
X-Gm-Message-State: APjAAAXIbdh//EDXpfFHqO6/CCG32a6VkMeHYuog8wTPgtYZt7GnbOqj
        HQ1mJ3LgV270e7U+6CnW50ZyCkRi+8ZIhg==
X-Google-Smtp-Source: APXvYqwVwdLvCdAW/rI+qSXjMGeAhbjOaYzbhTwjDTvfdYBs7qC9AhKpPLFodp2eGtaX/lXCMig6iw==
X-Received: by 2002:a2e:998a:: with SMTP id w10mr5400016lji.241.1576146180648;
        Thu, 12 Dec 2019 02:23:00 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id w1sm2617787lfe.96.2019.12.12.02.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:00 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 00/10] Switch reuseport tests for test_progs framework
Date:   Thu, 12 Dec 2019 11:22:49 +0100
Message-Id: <20191212102259.418536-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change has been suggested by Martin Lau [0] during a review of a
related patch set that extends reuseport tests [1].

Patches 1 & 2 address a warning due to unrecognized section name from
libbpf when running reuseport tests. We don't want to carry this warning
into test_progs.

Patches 3-8 massage the reuseport tests to ease the switch to test_progs
framework. The intention here is to show the work. Happy to squash these,
if needed.

Patches 9-10 do the actual move and conversion to test_progs.

Output from a test_progs run after changes pasted below.

Thanks,
Jakub

[0] https://lore.kernel.org/bpf/20191123110751.6729-1-jakub@cloudflare.com/T/#m607d822caeb1eb5db101172821a78cc3896ff1c3
[1] https://lore.kernel.org/bpf/20191123110751.6729-1-jakub@cloudflare.com/T/#m55881bae9fb6e34837d07a0c0a7ffbc138f8d06f

---8<---
bash-5.0# ./test_progs -t select_reuseport
#33/1 IPv4/TCP LOOPBACK test_err_inner_map:OK
#33/2 IPv4/TCP LOOPBACK test_err_skb_data:OK
#33/3 IPv4/TCP LOOPBACK test_err_sk_select_port:OK
#33/4 IPv4/TCP LOOPBACK test_pass:OK
#33/5 IPv4/TCP LOOPBACK test_syncookie:OK
#33/6 IPv4/TCP LOOPBACK test_pass_on_err:OK
#33/7 IPv4/TCP LOOPBACK test_detach_bpf:OK
#33/8 IPv4/TCP INANY test_err_inner_map:OK
#33/9 IPv4/TCP INANY test_err_skb_data:OK
#33/10 IPv4/TCP INANY test_err_sk_select_port:OK
#33/11 IPv4/TCP INANY test_pass:OK
#33/12 IPv4/TCP INANY test_syncookie:OK
#33/13 IPv4/TCP INANY test_pass_on_err:OK
#33/14 IPv4/TCP INANY test_detach_bpf:OK
#33/15 IPv6/TCP LOOPBACK test_err_inner_map:OK
#33/16 IPv6/TCP LOOPBACK test_err_skb_data:OK
#33/17 IPv6/TCP LOOPBACK test_err_sk_select_port:OK
#33/18 IPv6/TCP LOOPBACK test_pass:OK
#33/19 IPv6/TCP LOOPBACK test_syncookie:OK
#33/20 IPv6/TCP LOOPBACK test_pass_on_err:OK
#33/21 IPv6/TCP LOOPBACK test_detach_bpf:OK
#33/22 IPv6/TCP INANY test_err_inner_map:OK
#33/23 IPv6/TCP INANY test_err_skb_data:OK
#33/24 IPv6/TCP INANY test_err_sk_select_port:OK
#33/25 IPv6/TCP INANY test_pass:OK
#33/26 IPv6/TCP INANY test_syncookie:OK
#33/27 IPv6/TCP INANY test_pass_on_err:OK
#33/28 IPv6/TCP INANY test_detach_bpf:OK
#33/29 IPv4/UDP LOOPBACK test_err_inner_map:OK
#33/30 IPv4/UDP LOOPBACK test_err_skb_data:OK
#33/31 IPv4/UDP LOOPBACK test_err_sk_select_port:OK
#33/32 IPv4/UDP LOOPBACK test_pass:OK
#33/33 IPv4/UDP LOOPBACK test_syncookie:OK
#33/34 IPv4/UDP LOOPBACK test_pass_on_err:OK
#33/35 IPv4/UDP LOOPBACK test_detach_bpf:OK
#33/36 IPv6/UDP LOOPBACK test_err_inner_map:OK
#33/37 IPv6/UDP LOOPBACK test_err_skb_data:OK
#33/38 IPv6/UDP LOOPBACK test_err_sk_select_port:OK
#33/39 IPv6/UDP LOOPBACK test_pass:OK
#33/40 IPv6/UDP LOOPBACK test_syncookie:OK
#33/41 IPv6/UDP LOOPBACK test_pass_on_err:OK
#33/42 IPv6/UDP LOOPBACK test_detach_bpf:OK
#33 select_reuseport:OK
Summary: 1/42 PASSED, 0 SKIPPED, 0 FAILED
--->8---


Jakub Sitnicki (10):
  libbpf: Recognize SK_REUSEPORT programs from section name
  selftests/bpf: Let libbpf determine program type from section name
  selftests/bpf: Use sa_family_t everywhere in reuseport tests
  selftests/bpf: Add helpers for getting socket family & type name
  selftests/bpf: Unroll the main loop in reuseport test
  selftests/bpf: Run reuseport tests in a loop
  selftests/bpf: Propagate errors during setup for reuseport tests
  selftests/bpf: Pull up printing the test name into test runner
  selftests/bpf: Move reuseport tests under prog_tests/
  selftests/bpf: Switch reuseport tests for test_progs framework

 tools/lib/bpf/libbpf.c                        |   1 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../select_reuseport.c}                       | 514 ++++++++++--------
 .../bpf/progs/test_select_reuseport_kern.c    |   2 +-
 4 files changed, 292 insertions(+), 227 deletions(-)
 rename tools/testing/selftests/bpf/{test_select_reuseport.c => prog_tests/select_reuseport.c} (54%)

-- 
2.23.0

