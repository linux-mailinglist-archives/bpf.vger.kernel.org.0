Return-Path: <bpf+bounces-35957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C85940220
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 02:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474932835C9
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 00:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA891361;
	Tue, 30 Jul 2024 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs7k3Bpc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AA804
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299274; cv=none; b=p9kJpjqONoYCO1aBYVMEEt1mDwAHZxmy9UJ/Cqk9eT8X6R/3C/HsV6EUTUNVnG9b6+cFmFMGB5GCIv6BWI6Cr8Q3VQZbPfx4y4RhsOahZvk3r5aLOHf3C/EqDIT+Dk7hMuHOzITt80dJgnr6HgMtJkteC5pPnbpp5ox6x4UbN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299274; c=relaxed/simple;
	bh=k+ilD9VRY6UEsDh70uEBBfpgL6N1jlvv5X2Jte/39UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CBDTELdjL+s9L4WxUj3Il3wAfK6IM2/522vpLL186uTAa3Nw8xuRUEzEaaJ+kAc+dACAIW8xG22DinqI8fdnz+Osp003H+gz3drQUzBgwA8bNqZIQvwOovGsTb3LzRhinzVLEfhf4qQ2cmb7YrKxC+tcU1QRvBSOU1fxBpcXukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs7k3Bpc; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-67b709024bfso28512047b3.3
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 17:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299271; x=1722904071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0F6ZcmR276RYvZlAcIW0YnwkkBr8bYVcmz4nWJEInWw=;
        b=Hs7k3Bpc4nwZ2sTYPCnv+PsLpsFhO9LJTFLnOqGpD9SK+uJLxyOZEUnj71dNFD3MO2
         fi8uBFhT62pcijUiTRQJEkBwZwdzpv56soS3IUJJgxm02s2MBvS9NQzEbcfTFcX3XENx
         znuhMdvu1Sxn7ofQzQP+PUEHmhR0mAPlvXl+++D4Fq6K7zGpy/GKdu1s2hPgtoBVuvLk
         CNQG6PXp/Xog2TGk8lIf679sHawVK6lNdXr4sEdILqyz5+OCqgOQAxyvtz6i8eOfaHM+
         ZRq/VKTSPIQAXyPWUEgZkyjQ8GaJADu/Zr/0inKd2NPNCEYv/GUHTlYi0bCeBpqfTz69
         8H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299271; x=1722904071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F6ZcmR276RYvZlAcIW0YnwkkBr8bYVcmz4nWJEInWw=;
        b=b2EkpifqW3jC1lt//QubS01SYwMmuFVWQhjvJXFiBjuEojUHdj1C+a4X7doB7Er21K
         CeLBtagOELl+HB+Mv30mv/NEZ8gTpM0GGjU2MWI9llpwwNg7XqGRZ4WbQpp2SDSsEmR1
         ixulTKthQV1YhSlbI2HVkV3Z/AGg4xuTySvOMT/AdEvyM3OkGBtrU4Iay6Nh2fCBFt6k
         Feyt/6i409EtKTyhkLjC9mm2IbGXaecasV4Z8VivlIwo6QpDykLEfVSu9jfc92yCcpiZ
         +NwJ2U7HvI5Z+EaNV1IUJu0s8cetxEgcJeOWnl5glFMHbB/lvoL+eNhr7P6QH2msIyaw
         8EuQ==
X-Gm-Message-State: AOJu0YzngZu7j9o1Bty+Qyz/TAyRar9sqzkgiOo3rkVnoQMJb+O7ElNt
	xZ4/QTJQYeVA5KA8McXXIlSMCEEbNXqF58y/EotDPk5SiGcQA8STgrGhKiGN
X-Google-Smtp-Source: AGHT+IFygGBPYBrtvrnYxBpUqYrUPWzD598WhtzBLivakQEhFz9eEi3c4xq6menbYf/fR+7BjPoBMQ==
X-Received: by 2002:a0d:ffc2:0:b0:65c:2536:bea2 with SMTP id 00721157ae682-67a072baa14mr106497707b3.19.1722299271215;
        Mon, 29 Jul 2024 17:27:51 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5695:a85f:7b5f:e238])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44c698sm23052177b3.135.2024.07.29.17.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:27:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/6] monitor network traffic for flaky test cases
Date: Mon, 29 Jul 2024 17:27:39 -0700
Message-Id: <20240730002745.1484204-1-thinker.li@gmail.com>
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
 .../selftests/bpf/prog_tests/tc_redirect.c    |  48 +-
 tools/testing/selftests/bpf/test_progs.c      | 597 +++++++++++++++++-
 tools/testing/selftests/bpf/test_progs.h      |  22 +
 8 files changed, 688 insertions(+), 60 deletions(-)

-- 
2.34.1


