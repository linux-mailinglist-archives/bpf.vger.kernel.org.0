Return-Path: <bpf+bounces-35408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132CC93A57E
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0F7282BD0
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4DD1586F6;
	Tue, 23 Jul 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW6V08ar"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6A157A4F
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759085; cv=none; b=RDSGjGyj8b2RdmmVOY5QK49EXhAIowHzQmcukxKGs7yHdMU40EPBJuN8TfKtKmAwoA+G//kcIE1p18jdhzvJXCmJ09DE08mByxdfuQhDLLg+vkfZI9+/05FqzMG5gRFqR2IL1PrFz0n9l7seGsWw2HEHBEm0ffpHVDxwThwp5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759085; c=relaxed/simple;
	bh=1DeCLsZ3wEwOkSVPKsb29rUPiP5XIoyTncWblYzekyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DIEbj/LwgXA7k3DHXJCIV3GZXTffjjB7ePgscYQNGTL8qsvQ0uVLrBoXI+UjDfoSXQZsTvdEnk8lxF47cv2mR7cZIzHMNvvT/cu5EprwTVnmCLf5cAJ+9P/oSz8Cq1vsgmFJDSulBPNsPUU9yqEonsN6AW3mTRRr7KgNWRAetO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW6V08ar; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-65f7bd30546so1000227b3.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721759083; x=1722363883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2/a3WpNHFYH4h6UB5PQVauPpUe6edUN8Is5/23saelc=;
        b=BW6V08arL/cLSDfTau50XMiFoJECe6uk6QhqAf0/UqPN3MZI5PHefbef+CRObtQvu2
         ObToaWLoIakBntDGK8eZ3hDUDu49wb5GR81FTd8b5HIve445ue1hSKS663PRQFTcgZlg
         65r+1u6S9x3/IOoi3mbsSKM4kgtd+9Fh03tGvwosz1H+sxp6RoyrZxBBWeyHrYFJKuGx
         bDMemVpEZILrMSvII//Zwl2KKwyZ2GOmqJgt3s8VURJgFSez/cZnoAhBXFVEzNylcYCQ
         URmnJiX78lwCG9Tv//HxjNRDWDX4dwxqhRvnmv0sSYzNdVkrkWfRIlmpnaaVJq30Dwin
         M57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759083; x=1722363883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/a3WpNHFYH4h6UB5PQVauPpUe6edUN8Is5/23saelc=;
        b=rtwt/s8Skm0djLfv2HkmzzkrKG8VovTWt4l61WP8PWbleEyfAwmWOiUUWOCreGt8VL
         0ik/jAmDEWMr8O0I4XhpdSbOSvsIUn+IQXP6tjxOIS/MWsWtOcuyXjalH1dB91oIa5UT
         8DNdA3NYVqZejnHOWhKiBok/MmNgMSP5iDxzQ9/MZYBVtL0objxyXy2uuGyAagTomv/8
         aMuSwvC+7gDwPybsQzx1E8EkMWs0iklUIxO/x55F+bxKmOOiM/NhDAnV55Rqf26yApHX
         b9OTX6cCWsXz5wCzQjbFzgx8UMGypGlodZxD0CA3F7Uebd+q1CDwL/67xIHMD8UftVL0
         Dmcw==
X-Gm-Message-State: AOJu0Yx1Sj6KojLRKVjp2IBbCM1HZQLu1ApQ84qAjW1jKij6KeW3TXqx
	yHnYwXhD5i2mrE3WQxRhSlIWArzGxb9YyEYbVUucma+4I1xDPEDTWLmVesv5
X-Google-Smtp-Source: AGHT+IEC7P3OqOlAEiWpLwj8dfz58jSJrNpd6+QDASP0juYmmvR9w0A4wZuJoDrw3EAdWeeJ6vpRww==
X-Received: by 2002:a05:690c:4781:b0:627:7592:ced7 with SMTP id 00721157ae682-66e9059516emr22065627b3.10.1721759082714;
        Tue, 23 Jul 2024 11:24:42 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e02a:b5d8:6984:234c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6695293fd9csm20637577b3.69.2024.07.23.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:24:42 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 0/4] monitor network traffic for flaky test cases
Date: Tue, 23 Jul 2024 11:24:35 -0700
Message-Id: <20240723182439.1434795-1-thinker.li@gmail.com>
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
    Packet file: packets-2172-86.log
    #280/87  select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK 

The above block is the log of a test case. It shows every packets of a
connection. The captured packets are stored in the file called
packets-2172-86.log.

The following block is an example that monitors the network traffic of
a test case. This test is running in the network namespace
"testns". You can pass NULL to traffic_monitor_start() if the entire
test, from traffic_monitor_start() to traffic_monitor_stop(), is
running in the same namespace.

    struct tmonitor_ctx *tmon;
    
    ...
    tmon = traffic_monitor_start("testns");
    ASSERT_TRUE(tmon, "traffic_monitor_start");
    
    ... test ...
    
    traffic_monitor_stop(tmon);

traffic_monitor_start() may fail, but we just ignore it since the
failure doesn't affect the following main test.

This feature is enabled only if BPF selftests are built with
TRAFFIC_MONITOR variable being defined. For example,

    make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf

This command will enable traffic monitoring for BPF selftests. That
means we have to turn it on to get the log at CI.

---

Changes from v1:

 - Initialize log_fd in traffic_monitor_start().

 - Remove redundant including.

v1: https://lore.kernel.org/all/20240713055552.2482367-5-thinker.li@gmail.com/

Kui-Feng Lee (4):
  selftests/bpf: Add traffic monitor functions.
  selftests/bpf: Monitor traffic for tc_redirect/tc_redirect_dtime.
  selftests/bpf: Monitor traffic for sockmap_listen.
  selftests/bpf: Monitor traffic for select_reuseport.

 tools/testing/selftests/bpf/Makefile          |   5 +
 tools/testing/selftests/bpf/network_helpers.c | 382 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  16 +
 .../bpf/prog_tests/select_reuseport.c         |   7 +
 .../selftests/bpf/prog_tests/sockmap_listen.c |   8 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |   5 +
 6 files changed, 423 insertions(+)

-- 
2.34.1


