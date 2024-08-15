Return-Path: <bpf+bounces-37243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7F89528F7
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 07:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271B7283EEE
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 05:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D866514533C;
	Thu, 15 Aug 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6qQvh4B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB72EAE5
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699980; cv=none; b=fegh3wKQXap5qqZev3mWXBAv7QavZcowTFRZgVWR7F+vqCD4SiPEACOyzgiaV2+3S+H3iXogD5IBBjWprkkIHOJDWtulFohhaSLSEz4GWFS9VT9hZMFU9DAXA+poXhC17NmTt8h7aBWCgTqyBrUPH9YLtS7daZ5GvG3QSufb8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699980; c=relaxed/simple;
	bh=ohys6YqEWVm1Hp2WLM8mubPVrVoEnMbXrXyJ0F3BFqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GzTausfc/o5D9aPt+WK0/QakfW1qxygDp5OCNsPOzjKK/pfU10x1r8PDqVyFZO6B4iDk1x+aZy+APv6RbKhvBIH7RXkhNcZUJPwywO4kts9i4WOrRJdraL2JEjnGXDXC9OyrSjWnVsZe3WNs8fQ+6B55j3UiidLQ+KoI3ImKpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6qQvh4B; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e116a5c3922so651639276.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 22:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723699977; x=1724304777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYbiaUhKIpaygUNt3A8Ah5cc9UL+0zmYk9wt2jIfURQ=;
        b=H6qQvh4BjivE9D3OLyFbns3/G3kFLYoi9X2Hap6x/d3Zfw9ySLsTAfmoPWLIQoktqz
         XyCr2JwKtohKyqLH9Rrsvixk7ux+aaGenpTqmLonFV+j/IkOOnY0tdsu81YMUapreaoU
         IluQ9K4AOxRgTwqemN1CR3OHls3LjL2QBQl7+isrXyK5Ae+aNDKjK12CLLXtYNvMU5fw
         dSRqmA77VMTd80V4xvF4TckodLOctL4waX2EHt6doLHEJzWZ5EdtYBY6icvdx8t4pR79
         S3a9cwLG0Vgq5xi5Ef85WiuVBj9hDblsE4JP7F6KUc12T1Nee+xP/lUeBMIixI8KDFlT
         j/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723699977; x=1724304777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYbiaUhKIpaygUNt3A8Ah5cc9UL+0zmYk9wt2jIfURQ=;
        b=kxd6O/pSjgOMtlyxkq+z27SMk4NbBzByRPkuOBszqgF2Vt6JLx0qGd+hrJVlgkfxw5
         r8Dvq4RZZJ2BK9u2hQTgaby20iSHN3UbbGAueW+3qHiKc2VcwpKb065DAsoDE8d7wWC/
         Knniw20QL87A755t02ok9haLEM9K3W9R35LXjztYPZ1Ub42EaRL9jaxjdZ1xkLwkF+zG
         se4Bis2J/9u6djX88v6Hrv2C0FSL7it1XsywfcGdfiW41svc7r9oQuDoh1qpWDvhww0M
         V1D2VNXW4b2kc/BgtuXvmVl7cjGFXKmzAZq3wArlDhrSFz16Z6zyo7UwMFX4khVRK8pT
         O6+g==
X-Gm-Message-State: AOJu0YzAEWmQaN2h1uiFMCXSc6MpDjwMIEv/ywi4HgY3mBfff1/lT8zf
	k4RZttrzed3Ds/BVk7558FmRjih15ffHwvtAq+6x9AbQT70JSeduqGOMoRZy
X-Google-Smtp-Source: AGHT+IFN30s9TOWaynKBfVHBqcjq0NtY+y1QE/ZGpkFNM2w6+aIOSHAF73jOLOjqvkp9xDIdUYQeFw==
X-Received: by 2002:a05:6902:707:b0:e11:6cec:e9b3 with SMTP id 3f1490d57ef6-e116cecf136mr2549939276.35.1723699977548;
        Wed, 14 Aug 2024 22:32:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:11c4:fddc:768f:9072])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9da160c7sm1482307b3.118.2024.08.14.22.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 22:32:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 0/6] monitor network traffic for flaky test cases
Date: Wed, 14 Aug 2024 22:32:48 -0700
Message-Id: <20240815053254.470944-1-thinker.li@gmail.com>
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

Changes from v7:

 - Remove ":" with "__" from the file names of traffic logs. ':' would
   cause an error of the upload-artifact action of github.

 - Move remove_netns() to avoid a forward declaration.

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
v7: https://lore.kernel.org/all/20240810023534.2458227-2-thinker.li@gmail.com/

Kui-Feng Lee (6):
  selftests/bpf: Add traffic monitor functions.
  selftests/bpf: Add the traffic monitor option to test_progs.
  selftests/bpf: netns_new() and netns_free() helpers.
  selftests/bpf: Monitor traffic for tc_redirect.
  selftests/bpf: Monitor traffic for sockmap_listen.
  selftests/bpf: Monitor traffic for select_reuseport.

 tools/testing/selftests/bpf/Makefile          |   4 +
 tools/testing/selftests/bpf/network_helpers.c | 504 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  20 +
 .../bpf/prog_tests/select_reuseport.c         |  37 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c |   8 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |  33 +-
 tools/testing/selftests/bpf/test_progs.c      | 174 +++++-
 tools/testing/selftests/bpf/test_progs.h      |   6 +
 8 files changed, 731 insertions(+), 55 deletions(-)

-- 
2.34.1


