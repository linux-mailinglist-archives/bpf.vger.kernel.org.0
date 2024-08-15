Return-Path: <bpf+bounces-37283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A79538AE
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 19:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728901C24410
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14C1BB6B5;
	Thu, 15 Aug 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClkeYTdN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18DF1B4C26
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741208; cv=none; b=h6iVT1E8Mw9GSphVEz1amFBY/J8B9NBugIzCThpIL11CvEi1tEhS2V3SgX8t5tBiliVtQY4rt2FbPEqu6sJ3X+WfZIGtEHd5DeqQZywJmSvulKD9YI2aOsmOGG//jdcoPGA9h3QwJpDUhfEE1Kyo+T9hRhvIU/Ymyx1BJkiENLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741208; c=relaxed/simple;
	bh=HnNKhSll/OFNHhdysnjI4D4PKWcr+axIkzG+M/Iluog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5i1HIIgLHee0q1i20lUViMwr1BIMxLhIA4I6UZYEVezdHj4t/swWHcbscFNvRAu8R11JTrnmaT1dFVzS6JBJUK+azbiXILXepkkgrMnYvj5lECrFs7g/kRRNrBWJeJ7lcBRiVffeoR5bU7ZR4IzoSfRFYLCFa04O5AeKh5xHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClkeYTdN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-699ac6dbf24so11108337b3.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723741206; x=1724346006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJNN84yrd3Ua+liQUZL7ww2nXsj2bIPWj7nL2oYkAkQ=;
        b=ClkeYTdNGa+VBoH5kGDZnYcr5JyKpYh8hFT/lknIKdt4PPznEmU7s5ffyriMu1Alw2
         aGkz3Sg+4BiLWNH+Q/1g+dzs74JdznXG0pr/IqtY1Orhn7/b87RLGvxN7uBcqM9aVwR3
         o7WrCLppzjHSkX0OkWUCgMwNGAkU7xCXrgADL9Ic76I3wN2V2IVonZ75h7dADZz4wlK2
         9OGeFH1/TpxzAa4FEOa2O2JcV0ii/W8SnmTtvMcERa38KLExHZJlvR3WcNsq9TlKTOJ0
         LdUoyc1CR+P2pLgY88TsWyJsJfYapYz5oSTllOWjljlkFhAqbfLobYQPm1hifeRQGylb
         +ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723741206; x=1724346006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJNN84yrd3Ua+liQUZL7ww2nXsj2bIPWj7nL2oYkAkQ=;
        b=cdE2m9yna8YOHn6IOq6DNEL2z1+6AEOg4ezg8T4FgzWrwcuwIqiae0w7xi4HYTCDxc
         spvmrLVdpZdU6tyUYemR4mtj/hD1YmRbu8AXqEOsof9i7OOhSSjxWYpfhD2+X7+nD5MU
         V50dENAPhzveUbZE/JxZALHDQoVVf2t2QoFdGk7RPbkTLc10+KJXQe0hSh2nOuYIcP06
         UcLEGtCEaD27JkgsnJnWu1tkCpGU2YVuG9KS7ETgDq47gGG0fvtHAJga34YP/qMpMs3X
         L4yR2IRmnZDAH6d7I3AuZoDZ82K/ucr3L8+uXMyQeIIW2vXm28V6aYpBSAwnStSYxIO8
         GRrA==
X-Forwarded-Encrypted: i=1; AJvYcCVBPDSIK0qBQkLcurJebDsPqOVNbF3myZVQLIl0PHJrHelAEFkKuj8tzfegQjS2JwMjTIoauUd0W+lZwpWgLG+1fKiu
X-Gm-Message-State: AOJu0Yy8F4yM7EVGEala3YtqQfSlrLybnrf0tTeLxULFQC0oJstTBr3R
	1KwMJBpnkF/jQ0lsFy4IN5znPhYgvghZRZQFDmBeKoRDzeDKgYo1
X-Google-Smtp-Source: AGHT+IFHCupg9jGHhGt581fALYRtAhxSB+akmkipM05XalICnjfsRfJICk4HfVo3qA0+x70/EjW6sg==
X-Received: by 2002:a05:690c:f94:b0:6ae:1e27:c994 with SMTP id 00721157ae682-6b1b6ebe997mr2820127b3.3.1723741205398;
        Thu, 15 Aug 2024 10:00:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:84bb:1197:3c63:740b? ([2600:1700:6cf8:1240:84bb:1197:3c63:740b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9d8273fesm3092667b3.116.2024.08.15.10.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 10:00:04 -0700 (PDT)
Message-ID: <4d5df47c-df63-4253-ae8d-139d035a80ce@gmail.com>
Date: Thu, 15 Aug 2024 10:00:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 0/6] monitor network traffic for flaky test
 cases
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, sdf@fomichev.me, geliang@kernel.org
Cc: kuifeng@meta.com
References: <20240815053254.470944-1-thinker.li@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240815053254.470944-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following link [1] is the collection of test results with a PR to
enable traffic monitor on CI. Since "-m" is a new option, we can not
enable it on CI before this patchset has been landed, or it will break
all tests.

At the very end of the "Run selftests" section, you will see lines like

'''
Artifact tmon-logs-x86_64-gcc-test_progs has been successfully uploaded! 
Final size is 125359 bytes. Artifact ID is 1816543551
Artifact download URL: 
https://github.com/kernel-patches/vmtest/actions/runs/10407067642/artifacts/1816543551
'''

The developers may download packet files by following the link and
analyze packets with tcpdump or wireshark.


[1] 
https://github.com/kernel-patches/vmtest/actions/runs/10407067642/job/28821826062?pr=280



On 8/14/24 22:32, Kui-Feng Lee wrote:
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
>      lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 68, SYN
>      lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 60, SYN, ACK
>      lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 60, ACK
>      lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, ACK
>      lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 52, FIN, ACK
>      lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, RST, ACK
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
> Changes from v7:
> 
>   - Remove ":" with "__" from the file names of traffic logs. ':' would
>     cause an error of the upload-artifact action of github.
> 
>   - Move remove_netns() to avoid a forward declaration.
> 
> Changes from v6:
> 
>   - Remove unnecessary memcpy for addresses.
> 
>   - Make packet messages similar to what tcpdump prints.
> 
>   - Check return value of inet_ntop().
> 
>   - Remove duplicated errno in messages.
> 
>   - Print arphdr_type for not handled packets.
> 
>   - Set dev "lo" in make_netns().
> 
>   - Avoid stacking netns by moving traffic_monitor_start() to earlier
>     position.
> 
>   - Remove the word "packet" from packet messages.
> 
>   - Replace pipe with eventfd (wake_fd) to synchronize background threads.
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
> v6: https://lore.kernel.org/all/20240807183149.764711-1-thinker.li@gmail.com/
> v7: https://lore.kernel.org/all/20240810023534.2458227-2-thinker.li@gmail.com/
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
>   tools/testing/selftests/bpf/network_helpers.c | 504 ++++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |  20 +
>   .../bpf/prog_tests/select_reuseport.c         |  37 +-
>   .../selftests/bpf/prog_tests/sockmap_listen.c |   8 +
>   .../selftests/bpf/prog_tests/tc_redirect.c    |  33 +-
>   tools/testing/selftests/bpf/test_progs.c      | 174 +++++-
>   tools/testing/selftests/bpf/test_progs.h      |   6 +
>   8 files changed, 731 insertions(+), 55 deletions(-)
> 

