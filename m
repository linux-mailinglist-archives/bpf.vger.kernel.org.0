Return-Path: <bpf+bounces-36509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979C7949B00
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4492826B9
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5948170A3C;
	Tue,  6 Aug 2024 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WthMckJr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1CB170A11
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982374; cv=none; b=mHfG2Y4y0oVSrHjsuWnaSO6nCBD1e+7uZA8xMerldSH+UaB+46htxazRvLd/Op52lfWik0CxsLNRfU99DOEl1QbdP6E4sB/uG3jkJL7C7FAD08TOIjF4VFov2Rje3gUAmTkAayv8LNZGsAChMJFKybbEY6b9x2Cr5YXeyoa8skI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982374; c=relaxed/simple;
	bh=tzSvYBm1naySL+KWk4+IVYZ+ybESf26oVnnJVWXEoWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GlmoxZB/8mJexQPV4fJWVo4xljynULNN6N+CfYrQIstIjJRvvhuu3Dqc/vUI8CSZEFpfHBHrVS/owsQQw86K8FEO7O+xJwUxUYIlpvghRlVJPmw69Ix/rU6T8+p4QTRTOzuCS57iiW78uvrr5tBy1Faw37FvSMJ2Z+rMiZmMIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WthMckJr; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6510c0c8e29so11553427b3.0
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982370; x=1723587170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2S8p1p5zMMaDJD+AYczMDXXwTPV5iPU0icg4puupcpc=;
        b=WthMckJrlOlYZDIwG6s6m96SMz6y29hQfIEGeu8z4k8ohnhAs4EH7SCkX/pxsy/l3/
         rtWwNWpIl/IETTKa9gNAXz2IZySDFwpxgGpDaw/4HwA7KbJIkeTPDm+7ZHKesV/J8QtH
         mzcTMw2KhMtlw6Xa221Y6QSJTivfs2F47b+jb4WQnn/I1On9XQ+6MqCi36XWnGMpYWm5
         eopr/x/VQ6AT+DH5KFz/D/xedjsQ8KtyBCF+7xDzTcymproO2jXcm2krzcOfNmmQLrHI
         5hhC3IUMlAZaQ3n9I8J8VX85GnU5wvmOUua+OraE5dCRHH/hehKKi4XYnAYIWO/RSUYt
         iDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982370; x=1723587170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2S8p1p5zMMaDJD+AYczMDXXwTPV5iPU0icg4puupcpc=;
        b=rNFo/UmxvQ3YBOOYfmqTbjIc9sIY3/PPy6T84xcc1B16AYJ1OZstikzyZmsnOh6cCZ
         33mweL5f0dS3fL5geyCxKvHCuzpFFuXo8Mr1dAzWC1DQS3IsMmnf9TlHsh9cOL+THsRM
         4w7HsLH6zXbqC/q/dR7NWrblufPeBbO484BFLQb78Q1XoRe/ZQL9kIdhCO5UZFoqmUq3
         1yN9CB0g3FrlEdljTElPecFDZgA88cgAduCoBRLlKtFI0aQYfmcFfdbEoyYbLdwV8+mF
         0YSFKj2hfU5cTlJ61j2oWpB0mVtNt3ZkYNxseG5rXqMtb5Wxs543xyJJdWaB8u8YKR8y
         osSw==
X-Gm-Message-State: AOJu0YxqW5OefsbzntOO/N5ZVPHAOLnyo0Z7NhVcHXG7AiRW7p7XxqZu
	Tq50sJ+XteYJPbkP1QxDS6wjzx+RjTNb+ispYJDrHGyV+CaHc8I3qJXrGYx8
X-Google-Smtp-Source: AGHT+IFYcuTJQmrOJlsavs2fHRwd4gZUcLf74fiWsfB4oQhkd/Bdk4ldl6Onfz8BUipKYnwAOF94lA==
X-Received: by 2002:a0d:ed86:0:b0:649:8f00:525d with SMTP id 00721157ae682-689638f3970mr174416637b3.35.1722982369992;
        Tue, 06 Aug 2024 15:12:49 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d138b6sm16990017b3.88.2024.08.06.15.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:12:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/6] monitor network traffic for flaky test cases
Date: Tue,  6 Aug 2024 15:12:37 -0700
Message-Id: <20240806221243.1806879-1-thinker.li@gmail.com>
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


