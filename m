Return-Path: <bpf+bounces-36594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6F594AF1E
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769961F2212E
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B413CFBC;
	Wed,  7 Aug 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw0LD5JJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4777119
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053058; cv=none; b=bd08GtXdeNklZwSwoktgsj6iDl9Lt00fex0FgcJTTTd9vlDhAircOvpHBVrG9cgfNPI835Ia+F3B9YDDerbdYv5rY6WfDU8iTi6nHT7rjWd+ba0YjgjDfuiz98pp2QAHb5qZyKrD5kijH6WrZ2C6j1WEauajXq9zd3Whg2ip/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053058; c=relaxed/simple;
	bh=0u6T9VFpGbEdF64loVlPQ7aCxgUN5txUOiykpx9E4zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uyRIiouPh+aEzwwU4m6mOqVTKfmZyGgNsblShnj/tX/2iazm597xlY3gxzd5nrTpJibSk0MucImxrW0n5q47thLPXkZJEKKtV66yG4Oj5Kh1fDHRLdRaqXw2coz70M5aXV1O1wWauP+tkd7U3t//H74AIKcSOqi5WtcuoBb3XxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw0LD5JJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65f9708c50dso1011667b3.2
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053055; x=1723657855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoBRTy6frzYZG2lhG/TNm6TvKYgV6PwNxiul7Gzo+1U=;
        b=Zw0LD5JJeq4Y7GS9+4+oNm2EuUPkNWJWa2Z1McfJ+qAsiFnBLir2t4apJYlkmPakXu
         AbTdh4moM+zl0Hr+4QVmJTDbZUv6rtwJQEbMcYsPJ7RvZUV7iljq4chftwHcMKWduOCC
         StePZLexToqDWpLbVtzNImUPdYHtPiMJagq5wLgnMmlVahabVIPzDNRG3qBp6KMA0HyT
         uBkXUjKmRtaeyb5/upuvWYC6lx1uE4btA5qyt/BOn9Aakqvy16orI2m6uFGAUxk5NXuf
         KpOlXV7YNt4t/47xNaXfjF1Vz9xi688fZ30EX/zZWv7sUqIGRxzuK7mAQhqgmmOwYNS7
         s48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053055; x=1723657855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoBRTy6frzYZG2lhG/TNm6TvKYgV6PwNxiul7Gzo+1U=;
        b=L4h1E5t3csUdYNbWKqyoJW+1Tqu02MFP8d/vLYARkxu3bfryriC8VGEsGhK7rwnlsL
         of5CB/VZx8jc8g1W8bIKhY2DXWnqour5Nilruf3wHDcgBF86Az1bNlrLUDA5ot3Oz6O0
         Z5LQWCLZ1/+vCKHLyi9AQj9H3QzPFv5wPwJ3Z+dUOPpUr6TKUrQQrk3dsTrhaOTPqxul
         9Gn3E/Mh9AW0H0N1qyWyIteX4irT4bBgnw6Dl4hEjTSUXmyBzgurWXh3AtbirO6K72kV
         rjhMirAPqF5MfXQmUT+rPCHuDnQ5YFSxEGxmGNsPENVyOCNrvOZDsve3WuGg6nFzqCpP
         gHPA==
X-Gm-Message-State: AOJu0Yw+E8CRYqfKj1F6dUNuI79FXv1yPIRTN2GcPs+f+P5rCrTPgLtH
	p7kP6z6HB2jzmNtofBHwYITHl5W5vBgplSr8FXo5sPs8lnIp55+sQ8HHneTP
X-Google-Smtp-Source: AGHT+IEfm+3pieg+9jfBrHswt2WcmhZNB45K7O8ZnB8uQ2olQHV7Witzi9HgFXvXATuGbXxvQPv2TQ==
X-Received: by 2002:a81:a786:0:b0:699:7a7a:1853 with SMTP id 00721157ae682-6997a7a18b2mr29518267b3.5.1723053055504;
        Wed, 07 Aug 2024 10:50:55 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68fcd1727f3sm14988727b3.90.2024.08.07.10.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:50:55 -0700 (PDT)
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
Subject: [RFC bpf-next v6 0/6] monitor network traffic for flaky test cases
Date: Wed,  7 Aug 2024 10:50:46 -0700
Message-Id: <20240807175052.674250-1-thinker.li@gmail.com>
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


