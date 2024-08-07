Return-Path: <bpf+bounces-36606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D7794AFAE
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958F21C2129A
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83013A25F;
	Wed,  7 Aug 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/vGAPb4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5363CB
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055287; cv=none; b=rGrsg7JkXEdzWqjhdMtW6MXAL/1Ec1WBgdWmWWnZqweQ2ITobiLBg6RG9Jf7wVl6nmPqpFlEBznv/Aw9B4cnmuOLZUBDgy3pIWktMx2BsrHh9XiInZtDFa86XBbhIkCvdkhwty2p7RlVZHvE58QyLAI3mL28WzpkAXl2FdodJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055287; c=relaxed/simple;
	bh=n8xaW6pDt2bcRkZXiIsApruVhjwlsMJ6uNJ08bzik+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qb2aJs+R2wARNxr5AjOkAf/cUwzL68sDfow4/wJAHSXXe2bxmvbUkrfnV7LzjWyaHa4s4UDR4pkdepw6UJg1ZhOUyPHxnm/iu0+CGV0US25veaGi+XEsB8IC4w0LT6YtQsRm8pPTh7rSzEZ1otnr+KMsKXMOEBOnJ1gXU+R1Vk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/vGAPb4; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0bf9c7f4f2so123803276.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723055284; x=1723660084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55N3UlV0wDjstWDe2sCG161mLBaU5xDTmYI15mhUMWA=;
        b=d/vGAPb4ZdJlebb1bj6ybuqrLYPRE/GSHDf41Ue/0CbYkK3uXPk9KfhWWvhCmtLY7I
         NvoLU+WX7Wg4WH0mZEVicxIziSF4g2DkrxcMCdG2FPvthAwOjoBIABAWMOOWmHBOyB3q
         ubLKPnGazMAuMBP8hujI3nFo3VDeJxNwjqV/jmer9R7bzBXLLzobv8aP9fkS430E/jBG
         8BgEihSP828HAGIkUcix1d/T8HPl6XLLJmJmQABu/FFdceExnkz6+QEie/mgduxXbsJt
         nBAuc28jbxN1Y9d/lM2jwe0Xs7nPdih1r6jjsU1yvqXfc71mL0LEMqLdxcRkHuBCmhtm
         513Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055284; x=1723660084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55N3UlV0wDjstWDe2sCG161mLBaU5xDTmYI15mhUMWA=;
        b=OJv84A6GuBvoqhsxNcUoQvzJhGww4/OYj+74xxl4p3p4zalu/NEUbQZZlBR1aFWnJ9
         oeWcD3K1MtC85z+PIHWOuC6nW+U5GJHhOuvbEcDPmDN1K2YP2dPkphHiHh9k77eL3ADO
         B+KIu1mSzklOSa748d/Nr9QjriqCOT6DzNfAgrfoWU4orSvJSdjESlkatXzi/QGruZSr
         tocc35cv2hv1ZIlcxDespcE9dJEDJVgoeE7R1vB0mPmHt5Xt7MtNHjuJoGymOGWjy6eJ
         HKD2jxpnd2U0Efxon3MoBRbWcFCxiQZeKlXgXYt6RUY10x/mDJHlXQIqrv5kOZMRIgVl
         kM4w==
X-Forwarded-Encrypted: i=1; AJvYcCXNypmRh1VjyORU58ly2/jYnPP1RwLU7vSXnTIeYtzgaXbqYcHPh8OfVMt2wb242OT8sKhaJHOSn/nQYpdnLG0SMDWq
X-Gm-Message-State: AOJu0YyYJ3BMnu+GiHPJ6lx02kZXTqO8OX0xGXdmIVDqvV86JWnExIYn
	u9HY9RMNZF9+p6dcL1uM7cAstXpeBPn5Z7b2hN/67nCXYuuBJts3
X-Google-Smtp-Source: AGHT+IGSe9blhBqBmLaV7ZCCmEFmIc2k2/ND5WNJ7BwcM6jhNIosyx/i2NDwJS73bpE7RBRQ7UmHFw==
X-Received: by 2002:a05:6902:1884:b0:e0b:cdc8:b175 with SMTP id 3f1490d57ef6-e0bde1f57ccmr23276626276.1.1723055284438;
        Wed, 07 Aug 2024 11:28:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:fb5f:452b:3dfd:192? ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be55642fdsm2211041276.44.2024.08.07.11.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 11:28:03 -0700 (PDT)
Message-ID: <e1e2706e-0bff-49ae-91f0-cfeb6fd30312@gmail.com>
Date: Wed, 7 Aug 2024 11:28:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v6 0/6] monitor network traffic for flaky test
 cases
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, sdf@fomichev.me, geliang@kernel.org
Cc: kuifeng@meta.com
References: <20240807175052.674250-1-thinker.li@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240807175052.674250-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for marking this patch as RFC by a mistake.
This is not a RFC.
I will resend it again.

On 8/7/24 10:50, Kui-Feng Lee wrote:
> Capture packets in the background for flaky test cases related to
> network features.
> 
> We have some flaky test cases that are difficult to debug without
> knowing what the traffic looks like. Capturing packets, the CI log and
> packet files may help developers to fix these flaky test cases.
> 
> This patch set monitors a few test cases. Recently, they have been
> showing flaky behavior.
> 
>      IPv4 TCP packet: 127.0.0.1:48423 -> 127.0.0.1:40991, len 68, ifname lo (In), SYN
>      IPv4 TCP packet: 127.0.0.1:40991 -> 127.0.0.1:48423, len 60, ifname lo (In), SYN, ACK
>      IPv4 TCP packet: 127.0.0.1:48423 -> 127.0.0.1:40991, len 60, ifname lo (In), ACK
>      IPv4 TCP packet: 127.0.0.1:40991 -> 127.0.0.1:48423, len 52, ifname lo (In), ACK
>      IPv4 TCP packet: 127.0.0.1:48423 -> 127.0.0.1:40991, len 52, ifname lo (In), FIN, ACK
>      IPv4 TCP packet: 127.0.0.1:40991 -> 127.0.0.1:48423, len 52, ifname lo (In), RST, ACK
>      TCP packet: 127.0.0.1:33695 -> 127.0.0.1:40467, len 52, ifname lo, RST, ACK
>      Packet file: packets-2173-86-select_reuseport:sockhash_IPv4_TCP_LOOPBACK_test_detach_bpf-test.log
>      #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK
> 
> The above block is the log of a test case. It shows every packet of a
> connection. The captured packets are stored in the file called
> packets-2173-86-select_reuseport:sockhash_IPv4_TCP_LOOPBACK_test_detach_bpf-test.log.
> 
> We have a set of high-level helpers and a test_progs option to
> simplify the process of enabling the traffic monitor. netns_new() and
> netns_free() are helpers used to create and delete namespaces while
> also enabling the traffic monitor for the namespace based on the
> patterns provided by the "-m" option of test_progs. The value of the
> "-m" option is a list of patterns used to enable the traffic monitor
> for a group of tests or a file containing patterns. CI can utilize
> this option to enable monitoring.
> 
> traffic_monitor_start() and traffic_monitor_stop() are low-level
> functions to start monitoring explicitly. You can have more controls,
> however high-level helpers are preferred.
> 
> The following block is an example that monitors the network traffic of
> a test case in a network namespace.
> 
>      struct netns_obj *netns;
>      
>      ...
>      netns = netns_new("test", true);
>      if (!ASSERT_TRUE(netns, "netns_new"))
>          goto err;
>      
>      ... test ...
>      
>      netns_free(netns);
> 
> netns_new() will create a network namespace named "test" and bring up
> "lo" in the namespace. By passing "true" as the 2nd argument, it will
> set the network namespace of the current process to
> "test".netns_free() will destroy the namespace, and the process will
> leave the "test" namespace if the struct netns_obj returned by
> netns_new() is created with "true" as the 2nd argument. If the name of
> the test matches the patterns given by the "-m" option, the traffic
> monitor will be enabled for the "test" namespace as well.
> 
> The packet files are located in the directory "/tmp/tmon_pcap/". The
> directory is intended to be compressed as a file so that developers
> can download it from the CI.
> 
> This feature is enabled only if libpcap is available when building
> selftests.
> 
> ---
> 
> Changes from v5:
> 
>   - Remove "-m" completely if traffic monitor is not enabled.
> 
> Changes from v4:
> 
>   - Use pkg-config to detect libpcap, and enable traffic monitor if
>     there is libpcap.
> 
>   - Move traffic monitor functions back to network_helper.c, and pass
>     extra parameters to traffic_monitor_start().
> 
>   - Use flockfile() & funlockfile() to avoid log interleaving.
> 
>   - Show "In", "Out", "M" ... for captured packets.
> 
>   - Print a warning message if the user pass a "-m" when libpcap is not
>     available.
> 
>   - Bring up dev lo in netns_new().
> 
> Changes from v3:
> 
>   - Rebase to the latest tip of bpf-next/for-next
> 
>   - Change verb back to C string.
> 
> Changes from v2:
> 
>   - Include pcap header files conditionally.
> 
>   - Move the implementation of traffic monitor to test_progs.c.
> 
>   - Include test name and namespace as a part of names of packet files.
> 
>   - Parse and print ICMP(v4|v6) packets.
> 
>   - Add netns_new() and netns_free() to create and delete network
>     namespaces.
> 
>     - Make tc_redirect, sockmap_listen and select_reuseport test in a
>       network namespace.
> 
>   - Add the "-m" option to test_progs to enable traffic monitor for the
>     tests matching the pattern. CI may use this option to enable
>     monitoring for a given set of tests.
> 
> Changes from v1:
> 
>   - Move to calling libpcap directly to capture packets in a background
>     thread.
> 
>   - Print parsed packet information for TCP and UDP packets.
> 
> v1: https://lore.kernel.org/all/20240713055552.2482367-5-thinker.li@gmail.com/
> v2: https://lore.kernel.org/all/20240723182439.1434795-1-thinker.li@gmail.com/
> v3: https://lore.kernel.org/all/20240730002745.1484204-1-thinker.li@gmail.com/
> v4: https://lore.kernel.org/all/20240731193140.758210-1-thinker.li@gmail.com/
> v5: https://lore.kernel.org/all/20240806221243.1806879-1-thinker.li@gmail.com/
> 
> Kui-Feng Lee (6):
>    selftests/bpf: Add traffic monitor functions.
>    selftests/bpf: Add the traffic monitor option to test_progs.
>    selftests/bpf: netns_new() and netns_free() helpers.
>    selftests/bpf: Monitor traffic for tc_redirect.
>    selftests/bpf: Monitor traffic for sockmap_listen.
>    selftests/bpf: Monitor traffic for select_reuseport.
> 
>   tools/testing/selftests/bpf/Makefile          |   4 +
>   tools/testing/selftests/bpf/network_helpers.c | 494 ++++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |  20 +
>   .../bpf/prog_tests/select_reuseport.c         |  37 +-
>   .../selftests/bpf/prog_tests/sockmap_listen.c |   8 +
>   .../selftests/bpf/prog_tests/tc_redirect.c    |  33 +-
>   tools/testing/selftests/bpf/test_progs.c      | 177 ++++++-
>   tools/testing/selftests/bpf/test_progs.h      |   6 +
>   8 files changed, 724 insertions(+), 55 deletions(-)
> 

