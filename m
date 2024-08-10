Return-Path: <bpf+bounces-36811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD57E94DA24
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 04:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F9928228F
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 02:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9936F06A;
	Sat, 10 Aug 2024 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWOHwAmq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5A27452
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257340; cv=none; b=bOQQBQT+nVx1dn65pkkyfvsOpf8Aa4Ws7ep2rA9tE+BLMSTqeBRCtkSu+ZDjALGnjEBXn7upfVltspdlm3iBINV281w3XUNkRmQCxsJTUdBIJQHVU+9IO8LZtKPQi0qbpH7ZhH550Tj8EC/Bf66P3Lg8aKaHzrtJJyD461w42Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257340; c=relaxed/simple;
	bh=KUvReP7A09Oxok+vgcfBw7PXk/X7/IK4r6TrlvQOe8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktlcWWiOCjIYFiFa69F1tUCN43boI/7QLED/07OM4suYaA5ycNLcB2ANvDjKoLgrhjr9H+xyCxZKLdqi57YPQAmAU3wL8Z/TFQV+x1AT6xBEqo8Or0FxUX5+rgNv3KNP6+VGrden54JwEZUGQ805E2pQIrDb2H8yyfbQ7Yn60wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWOHwAmq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66ca5e8cc51so27071277b3.1
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 19:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723257338; x=1723862138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uttkt0M/mFbYSdVLyu6ju8Ll7Lr4+ozJfR1Q9MRQmDg=;
        b=mWOHwAmqLjzNpItX2WBe/W3YSq5KfQmfDVvWIboSpFXJEnoX00F2D1kMtnxleAMh+1
         o0LkJl1SwmWD7GXpHL8vF4a7h9+VhjICAwAaNCSpiElEKXTs1BdvN/FNGOsrU5YnAKHW
         QT51ktAn+Cyx6Qo9q0eGZDWIa50oxp9l51H0FfwQ17ihXU9HT93ymuejNk6+0eK+BVjW
         RJF2eyvUyjezCMcdojvbf+PKiTT9VzjARAIWVi1XnehiP191CAHSlcqJce2IE2nS9q8S
         mXnrcEci+ix8vsOVvfi/Saqm0Xpfk0CCZe0LnL7jnTL76AFKKg25HATv7yFItKICBi2G
         ckkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723257338; x=1723862138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uttkt0M/mFbYSdVLyu6ju8Ll7Lr4+ozJfR1Q9MRQmDg=;
        b=AW0GZvIzRA1BMF1kREzoNPOBcbH7DCT2mJgD8sgau3bcf35FKv5XaFckoXxD6iwPGd
         w+XaQCguNpWGEbFDkI6Gtgne4cEkLd+f3BE5vxFn2bv9buzwXgyGQ5I/IA9dODzHeiS5
         4n5P6wi/M4x9lQaX+Z08ESq/0gHRLMrb1qR5ygMynwH7AcdSDJWH+r5nfKWqwtsYYvL+
         20B1BKanxfh9WaNKrj+a3mVUUU6ytWk7CpZFd+Hm3u1VROX9NdE8ZotR7mfYkYEppR1O
         3w5Iy2n2KoQHpXEjYwoLmUPFrYeRr1QDAnXDcGWsVwJbm/cBTftbbRJUnoBKwkBSv2pg
         q7wA==
X-Gm-Message-State: AOJu0YxNFxOnOyj8I3dUvla48SSBU/vFub0PmDQTtclnXhx5dnAsoknM
	GYxoiwdYun8mK9+Ykm4s9/O/B00gEDsFAOerrhfhxnLsLngoHxv688y6eDgX
X-Google-Smtp-Source: AGHT+IFWAPWg7xxiH/eTEsC6MeYgaOMN+HVMvDYiXCi7GFDgFgkJS4iuz5ciV0SowV1CrwhMH4+W/A==
X-Received: by 2002:a05:690c:428b:b0:686:1240:621a with SMTP id 00721157ae682-69ec89aecddmr35934487b3.31.1723257337597;
        Fri, 09 Aug 2024 19:35:37 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b371sm1280147b3.114.2024.08.09.19.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 19:35:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 0/6] monitor network traffic for flaky test cases
Date: Fri,  9 Aug 2024 19:35:28 -0700
Message-Id: <20240810023534.2458227-1-thinker.li@gmail.com>
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

    lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 68, SYN
    lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 60, SYN, ACK
    lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 60, ACK
    lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, ACK
    lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 52, FIN, ACK
    lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, RST, ACK
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

Changes from v6:

 - Remove unnecessary memcpy for addresses.

 - Make packet messages similar to what tcpdump prints.

 - Check return value of inet_ntop().

 - Remove duplicated errno in messages.

 - Print arphdr_type for not handled packets.

 - Set dev "lo" in make_netns().

 - Avoid stacking netns by moving traffic_monitor_start() to earlier
   position.

 - Remove the word "packet" from packet messages.

 - Replace pipe with eventfd (wake_fd) to synchronize background threads.

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
v6: https://lore.kernel.org/all/20240807183149.764711-1-thinker.li@gmail.com/

Kui-Feng Lee (6):
  selftests/bpf: Add traffic monitor functions.
  selftests/bpf: Add the traffic monitor option to test_progs.
  selftests/bpf: netns_new() and netns_free() helpers.
  selftests/bpf: Monitor traffic for tc_redirect.
  selftests/bpf: Monitor traffic for sockmap_listen.
  selftests/bpf: Monitor traffic for select_reuseport.

 tools/testing/selftests/bpf/Makefile          |   4 +
 tools/testing/selftests/bpf/network_helpers.c | 506 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  20 +
 .../bpf/prog_tests/select_reuseport.c         |  37 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c |   8 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |  33 +-
 tools/testing/selftests/bpf/test_progs.c      | 174 +++++-
 tools/testing/selftests/bpf/test_progs.h      |   6 +
 8 files changed, 733 insertions(+), 55 deletions(-)

-- 
2.34.1


