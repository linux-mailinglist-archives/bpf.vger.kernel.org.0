Return-Path: <bpf+bounces-36161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3B943673
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C3128467F
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6C538DE4;
	Wed, 31 Jul 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHUyeq9Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493C74BF5
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454306; cv=none; b=hmWQpcClnaJfBMCNofdj4PoicS/L1b5xN7qEMkWOAwUVdBUc0xinjXxb1HC/QWNOyCS11tRMp1fCDflimJR1PlPcwQ0nkJaAawhKa9PKq9OgZmz0RWI3xTD802jQDiw2ri7yE3v5XpuYOd413wEpGTC6XUbXyAcGBWRzkfxWBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454306; c=relaxed/simple;
	bh=b76o2jWNZpusGxsHDzM4WQn01YnZP+t2hIpXq9pL6pE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QsDvo6ptIMy06aDCBY7lLy7Eji+mKMXLDa2UpHon5MT9Usk2Gtla2FZ1MmqNk01SaTopAix5R4blghWUZvhzXbwQ1rUIbk1xXETcka+puhP5wigfDuj0O8wB0h5g3oMzyb7tI40boqDdlCnHPCTbsIgpP3oye5mSwU/lSnpd//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHUyeq9Z; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-661369ff30aso47296267b3.2
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722454304; x=1723059104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMQOILerZgGh8UjxtvS/neLtcuw862vdaZvUYPfsVhg=;
        b=AHUyeq9Zk5JATWb1HVjeQQJelQ7jfM2mtB3e17Cuyd8LRJ2i0Zu2YxMFWUNy7FIHgi
         w4hyMOcC9vj9cj05sAaVDuDQg3HSJRQCZLhTiwKRDnDV15Eop2gbtKZvUkksfAW1qrCR
         XPYbQsWqGEAF0cMfiMtZ1HP86R7mwqdvFrS27FYgr0JQpn6fDHcfgLur48ildzncyIf2
         phZjdnaFhNiKUxIiccfFDEUUhuPRBVwcTa6Uj6HoOcjAbedJYzED6O8vsJL6ZHDPqeop
         tzt6uzOJQle41edLzwonh1X5Jtm/fM8zT0phg4awetnMnbdZqLOIGZgSr/+AmYlvR19v
         n1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722454304; x=1723059104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMQOILerZgGh8UjxtvS/neLtcuw862vdaZvUYPfsVhg=;
        b=CUDBWQSAWaj0YD0Y95q6tPSM47DyO69WY5T9AMu+7EuOlQxjRblaLsvc2rzp64ahKS
         i5gmx9Ue/tAxOkWphpkvcYRKjXro+7yR7xQWuTQVr2PjNPN5IaubHZYAVAbgf0SzoqpV
         +abjXDlB/dm4tfjMan9GMRQC6Pqv+RGSxh7KideNsuU5kBdMmFNT/P3mPQvSz1K6C7w9
         m+HoHYBOcdogxABHXL8VAd7dE9E9pluOdYfUKRabDrX/V4xe9tYDRu2lEl7feSdHV3XP
         oPiWf1xd0KAetH4D9D1o4WuwKAT1RD2CoxAVV2E5G4JKaMxBe5IuGBeXdfueBuFmJZTS
         znCA==
X-Gm-Message-State: AOJu0YwXj8BpNcFg+XCRJvJfOZlH/UZbTIT2drcrNfIZy7bCZw09s1Hr
	1PtqYsDRn6xRiWF8r4k/pW8036AQf2hEgrgmlk3dFXw7ZWiD+h+KFhMiKFsT
X-Google-Smtp-Source: AGHT+IFWr/khknyJhvjyEmv705ZnPCzoHJ9M/wqrGdU9aPAxwbn88Q/yFlujPr+6956uFjdHSaS/wg==
X-Received: by 2002:a0d:f2c1:0:b0:632:12b:8315 with SMTP id 00721157ae682-6874cffcb91mr2090557b3.22.1722454303796;
        Wed, 31 Jul 2024 12:31:43 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c6db:9dfe:1d13:3b2e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024ab1sm30891597b3.91.2024.07.31.12.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:31:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/6] monitor network traffic for flaky test cases
Date: Wed, 31 Jul 2024 12:31:34 -0700
Message-Id: <20240731193140.758210-1-thinker.li@gmail.com>
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

    IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
    IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, SYN, ACK
    IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
    IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
    IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, FIN, ACK
    IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, RST, ACK
    Packet file: packets-2172-86-select_reuseport:sockhash-test.log
    #280/87  select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK 

The above block is the log of a test case. It shows every packets of a
connection. The captured packets are stored in the file called
packets-2172-86-select_reuseport:sockhash-test.log.

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

netns_new() will create a network namespace named "test". By passing
"true" as the 2nd argument, it will set the network namespace of the
current process to "test".netns_free() will destroy the namespace, and
the process will leave the "test" namespace if the struct netns_obj
returned by netns_new() is created with "true" as the 2nd argument. If
the name of the test matches the patterns given by the "-m" option,
the traffic monitor will be enabled for the "test" namespace as well.

The packet files are located in the directory "/tmp/tmon_pcap/". The
directory is intended to be compressed as a file so that developers
can download it from the CI.

This feature is enabled only if BPF selftests are built with
TRAFFIC_MONITOR variable being defined. For example,

    make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf

This command will enable traffic monitoring for BPF selftests. That
means we have to turn it on to get the log at CI.

---

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

Kui-Feng Lee (6):
  selftests/bpf: Add traffic monitor functions.
  selftests/bpf: Add the traffic monitor option to test_progs.
  selftests/bpf: netns_new() and netns_free() helpers.
  selftests/bpf: Monitor traffic for tc_redirect.
  selftests/bpf: Monitor traffic for sockmap_listen.
  selftests/bpf: Monitor traffic for select_reuseport.

 tools/testing/selftests/bpf/Makefile          |   5 +
 tools/testing/selftests/bpf/network_helpers.c |  26 +
 tools/testing/selftests/bpf/network_helpers.h |   2 +
 .../bpf/prog_tests/select_reuseport.c         |  39 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c |   9 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |  33 +-
 tools/testing/selftests/bpf/test_progs.c      | 597 +++++++++++++++++-
 tools/testing/selftests/bpf/test_progs.h      |  22 +
 8 files changed, 678 insertions(+), 55 deletions(-)

-- 
2.34.1


