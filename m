Return-Path: <bpf+bounces-36608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D27394AFC9
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5010F1C21810
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96F13DB9B;
	Wed,  7 Aug 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxibiDLR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBD74076
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055516; cv=none; b=X0Wc7yL6YqcWNOq2iGF4SCcejdsKHwXWAo57IX1n+t0ntISa7kNyC9umUAWZMLD9XHMouKnBKdd33C9RlVqFK7jhjUnhCIWAgUhoshgd5fmjv2pSGIAxqApG7CTgvhk/hz05Eke9Y/+HMw3VX3Y2jUjIdE/yuXEfGV2vD5v291k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055516; c=relaxed/simple;
	bh=0u6T9VFpGbEdF64loVlPQ7aCxgUN5txUOiykpx9E4zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nHDaQP9ht/h4A+0UcMcnIZoCYFWmp1XxJl296R4T/o5jkDWQEQq61vM27l/fX6PWnBcwnYV3MN11boIBtf2AAdlADV5f4zYOa7IvjO+n24nh7jEDYMpAZs/GI4o0xoRDfXSZ0Kr3GjsFj5C+6mMzfQty6BxS7V4hV6ZBPyJGxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxibiDLR; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5eec95a74so103474eaf.1
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723055513; x=1723660313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoBRTy6frzYZG2lhG/TNm6TvKYgV6PwNxiul7Gzo+1U=;
        b=QxibiDLRnrRnjIoirawQO4X9EF/njfzTDk4+1Iioep0xy0I4y52BkeZroVdUl9Sgnq
         TC8wGMIE0ALPQ79B0dRUxlO2nKozj3z29z9q1Al2nd5re9y5e6FZNjJHFs7rAYo8f/Q2
         OetASY2SaGBF0Ly1JaVL/7wht7c6sKKHQuBO67CppJ0BQTAF61B08gm05ZeKMyK+tCre
         ibaKrdMEZAVBkBtYqDhmj2l6vJ3r4s1fNwwc2/lx83mKRmcR011SUACd8JZV+qDx6mY9
         nOlibyEjt1bKRrRb2S3x1x4euDDUUCcvBp+FrEB0mjrv8zc7mp+Af5ucueNfLuBC9qw6
         ykyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055513; x=1723660313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoBRTy6frzYZG2lhG/TNm6TvKYgV6PwNxiul7Gzo+1U=;
        b=RTe598gUDjuJqxYP0jof4TyfA15p92YGZ2SunuJ6yLrOtPK6VGnqVMScH26WEFqqZj
         sSuDw+MeCny6/gEzOv7MhpxujkKxwdbT2PZgd4D00yelfXCmMOE5AgNkvUuvX+bcHagn
         etRbz9PLez+lvNZ58L8jrVyCFhQladnsJn436uPUsKrhs3a0bhocINKznwmzxHilWLIc
         2ByMr8Ot9C8ov1FXovTIDWzarG7chgqMi0uOu8N3I/KzL13+SzSFXE4qjEzBDtM3aubd
         SV1NJHUN6gkj1O4sHj8y2DF0zChew9ONCglqrTHpBCewk2xZcVAuCxSGrDPBCbDbYYCI
         HNcQ==
X-Gm-Message-State: AOJu0YzsEaONq3Zmry1oNQbJSK8wS5iUelGWcXHDEIFotCra6a6b5mMc
	3bFI8DfNqp+z04yOHGxW30zqqREmN7IKz6V31ecGy1xN+3ERoZJnvWt1dqoI
X-Google-Smtp-Source: AGHT+IG13gb8qc42iGl6zZ0M0ScFKJV9h7QdDWiZq2NSkA6Mf6EehuiSY8RBx6kV2clF1YGl7JNB+Q==
X-Received: by 2002:a05:6358:7598:b0:1a2:5c3a:f0f4 with SMTP id e5c5f4694b2df-1af3ba64344mr2450711955d.10.1723055513338;
        Wed, 07 Aug 2024 11:31:53 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f4188a9sm20106447b3.2.2024.08.07.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:31:53 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v6 0/6] monitor network traffic for flaky test cases
Date: Wed,  7 Aug 2024 11:31:43 -0700
Message-Id: <20240807183149.764711-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capture packets in the background for flaky test cases related to
network features.

We have some flaky test cases that are difficult to debug without
knowing what the traffic looks like. Capturing packets, the CI log and
packet files may help developers to fix these flaky test cases.

This patch set monitors a few test cases. Recently, they have been
showing flaky behavior.

    IPv4 TCP packet: 127.0.0.1:48423 -> 127.0.0.1:40991, len 68, ifname lo (In), SYN
    IPv4 TCP packet: 127.0.0.1:40991 -> 127.0.0.1:48423, len 60, ifname lo (In), SYN, ACK
    IPv4 TCP packet: 127.0.0.1:48423 -> 127.0.0.1:40991, len 60, ifname lo (In), ACK
    IPv4 TCP packet: 127.0.0.1:40991 -> 127.0.0.1:48423, len 52, ifname lo (In), ACK
    IPv4 TCP packet: 127.0.0.1:48423 -> 127.0.0.1:40991, len 52, ifname lo (In), FIN, ACK
    IPv4 TCP packet: 127.0.0.1:40991 -> 127.0.0.1:48423, len 52, ifname lo (In), RST, ACK
    TCP packet: 127.0.0.1:33695 -> 127.0.0.1:40467, len 52, ifname lo, RST, ACK
    Packet file: packets-2173-86-select_reuseport:sockhash_IPv4_TCP_LOOPBACK_test_detach_bpf-test.log
    #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK

The above block is the log of a test case. It shows every packet of a
connection. The captured packets are stored in the file called
packets-2173-86-select_reuseport:sockhash_IPv4_TCP_LOOPBACK_test_detach_bpf-test.log.

We have a set of high-level helpers and a test_progs option to
simplify the process of enabling the traffic monitor. netns_new() and
netns_free() are helpers used to create and delete namespaces while
also enabling the traffic monitor for the namespace based on the
patterns provided by the "-m" option of test_progs. The value of the
"-m" option is a list of patterns used to enable the traffic monitor
for a group of tests or a file containing patterns. CI can utilize
this option to enable monitoring.

traffic_monitor_start() and traffic_monitor_stop() are low-level
functions to start monitoring explicitly. You can have more controls,
however high-level helpers are preferred.

The following block is an example that monitors the network traffic of
a test case in a network namespace.

    struct netns_obj *netns;
    
    ...
    netns = netns_new("test", true);
    if (!ASSERT_TRUE(netns, "netns_new"))
        goto err;
    
    ... test ...
    
    netns_free(netns);

netns_new() will create a network namespace named "test" and bring up
"lo" in the namespace. By passing "true" as the 2nd argument, it will
set the network namespace of the current process to
"test".netns_free() will destroy the namespace, and the process will
leave the "test" namespace if the struct netns_obj returned by
netns_new() is created with "true" as the 2nd argument. If the name of
the test matches the patterns given by the "-m" option, the traffic
monitor will be enabled for the "test" namespace as well.

The packet files are located in the directory "/tmp/tmon_pcap/". The
directory is intended to be compressed as a file so that developers
can download it from the CI.

This feature is enabled only if libpcap is available when building
selftests.

---

Changes from v5:

 - Remove "-m" completely if traffic monitor is not enabled.

Changes from v4:

 - Use pkg-config to detect libpcap, and enable traffic monitor if
   there is libpcap.

 - Move traffic monitor functions back to network_helper.c, and pass
   extra parameters to traffic_monitor_start().

 - Use flockfile() & funlockfile() to avoid log interleaving.

 - Show "In", "Out", "M" ... for captured packets.

 - Print a warning message if the user pass a "-m" when libpcap is not
   available.

 - Bring up dev lo in netns_new().

Changes from v3:

 - Rebase to the latest tip of bpf-next/for-next

 - Change verb back to C string.

Changes from v2:

 - Include pcap header files conditionally.

 - Move the implementation of traffic monitor to test_progs.c.

 - Include test name and namespace as a part of names of packet files.

 - Parse and print ICMP(v4|v6) packets.

 - Add netns_new() and netns_free() to create and delete network
   namespaces.

   - Make tc_redirect, sockmap_listen and select_reuseport test in a
     network namespace.

 - Add the "-m" option to test_progs to enable traffic monitor for the
   tests matching the pattern. CI may use this option to enable
   monitoring for a given set of tests.

Changes from v1:

 - Move to calling libpcap directly to capture packets in a background
   thread.

 - Print parsed packet information for TCP and UDP packets.

v1: https://lore.kernel.org/all/20240713055552.2482367-5-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240723182439.1434795-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20240730002745.1484204-1-thinker.li@gmail.com/
v4: https://lore.kernel.org/all/20240731193140.758210-1-thinker.li@gmail.com/
v5: https://lore.kernel.org/all/20240806221243.1806879-1-thinker.li@gmail.com/

Kui-Feng Lee (6):
  selftests/bpf: Add traffic monitor functions.
  selftests/bpf: Add the traffic monitor option to test_progs.
  selftests/bpf: netns_new() and netns_free() helpers.
  selftests/bpf: Monitor traffic for tc_redirect.
  selftests/bpf: Monitor traffic for sockmap_listen.
  selftests/bpf: Monitor traffic for select_reuseport.

 tools/testing/selftests/bpf/Makefile          |   4 +
 tools/testing/selftests/bpf/network_helpers.c | 494 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  20 +
 .../bpf/prog_tests/select_reuseport.c         |  37 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c |   8 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |  33 +-
 tools/testing/selftests/bpf/test_progs.c      | 177 ++++++-
 tools/testing/selftests/bpf/test_progs.h      |   6 +
 8 files changed, 724 insertions(+), 55 deletions(-)

-- 
2.34.1


