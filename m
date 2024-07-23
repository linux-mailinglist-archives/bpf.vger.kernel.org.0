Return-Path: <bpf+bounces-35433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EA93A905
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 00:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E104BB22519
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4644143C52;
	Tue, 23 Jul 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs61u+eL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C92561B
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772078; cv=none; b=D9cN4Z7Hrn3Ol/f+Rfdx/k/It+nEvLmQx4pgo0FVVhnpduJYFI7gd98Jqh7IWafH7kj49RJWYrJPW2UpUIyFzA+k8UcziSinhdvbavi9Ot8FEsWOAnczZHoBCefTwwyYoUh2SWuBV1IAgGUNOqSd8xOQyoL9GQhERzf/EMmHAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772078; c=relaxed/simple;
	bh=oN5KMSWCI0t8fZZAQKUkWwULPM8+VvuDhu53I4czMgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERcSOO7WAbfHUQIvVyoQJ04G7e0HQ7E3woQm2tXPpmPSALeQaW5fYMuQcLEb3yWgy50qTJ1kYa4UryLVfrjJ0ptSv+EVaCPvHw8WvYb6DroUQXjaZhP51vJ99/GrQlw0NDDjoQhplBSDwjqCLB6SttmLItKFa9HyHmCyyaQNgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs61u+eL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-663dd13c0bbso58707147b3.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721772076; x=1722376876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/UtStTVgaNxWA3UJlwaNzZ4H2ZfLQ8LA6dKWn3Od48=;
        b=Zs61u+eL7k4YFFc2so58URthQBYkxoyeFsimxPjZOEOLif9ZdKubo1sx20J4UbqL67
         SDAZZEn6DH5FAxuQ0CcFrwxCyQZ7jtxwpKpVjWh0RYsPe952Qv8MzQeGpKv0wNt26rTK
         qt3gwUe3Lpdr9kWWH2bIhNoTbS+SlQ9dHAOoeqAVITLiYavmRXytawBxL6osCzH0uE0S
         RaXQ8lmtxDi5Uj1THc7QJTstx/LvzxiJnQF2Xu0CeBj8BA+zbuVPA52g4SdDImrFKEUi
         Jc7LmSg4ugyP6dkFZ88g9hMuumipV0gyrThE6YDkZ6fv3eQE8K2mTIc6MFoCyhQh3lra
         DtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721772076; x=1722376876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/UtStTVgaNxWA3UJlwaNzZ4H2ZfLQ8LA6dKWn3Od48=;
        b=QAaiAB6tzRSklib9T+hNelN8rgOizXTOWcoThwmXI5CtkdMlJj/Bp8WLPRoEZ22m3J
         RtT8sp61ewGojx2pGRQqmAzAOrSWF+cF46sCp74LdcDW4Y2qqNlhE7GklQ7T9yksdQbk
         UKp9oC9AutT1P9flIW9r/NcpMbUTwINcJdB6xjqn7SWxEp4UdrsYQt1kXnRQw0hUU/B+
         Bd5Q4qwt3vVpMeZPekykSdunjn5P9MMWg9MftQD/YKI+K/tM3o0HC8xPgMSroVgIdQSm
         XJhjYerzs5eadOOWvkbLSK3dCAu6oNzLA7WO/NhwZb0BzexYg7YDA7PZu0m+CGSVNEvd
         mVEw==
X-Forwarded-Encrypted: i=1; AJvYcCUv7Zhnty6brKyIJU3w/he2rdrTYCjaUBfL2qremZi6RgVuD1ewniOUHTtmoi9923GPwrmLxCaMXZXjsBkN6uldAGsd
X-Gm-Message-State: AOJu0YwKmvnV3nVhjSufBqiWfJ0+jw68/C1xYUDxdzm3k/PU5BoVlzbm
	Q7kOXU5VF2qM/QetbYKHhjn4tUntXOD/8MHHcRuoScS40BR0+9XN
X-Google-Smtp-Source: AGHT+IFdiKrFOmRPwq4BaC8R1ig3Td254voac4xRcsqqVHdsOid8Jb1It0Z1FpIuAXeIYzTcVHYzrQ==
X-Received: by 2002:a05:690c:f07:b0:647:e079:da73 with SMTP id 00721157ae682-67279fc942cmr3425947b3.10.1721772075339;
        Tue, 23 Jul 2024 15:01:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8343:a788:55dc:60a4? ([2600:1700:6cf8:1240:8343:a788:55dc:60a4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-669545a11b3sm21425477b3.143.2024.07.23.15.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 15:01:14 -0700 (PDT)
Message-ID: <20f70821-de1f-4ff1-be0f-e298091bda6f@gmail.com>
Date: Tue, 23 Jul 2024 15:01:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/4] monitor network traffic for flaky test
 cases
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, sdf@fomichev.me
Cc: kuifeng@meta.com
References: <20240723182439.1434795-1-thinker.li@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240723182439.1434795-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/24 11:24, Kui-Feng Lee wrote:
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
>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, SYN, ACK
>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, FIN, ACK
>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, RST, ACK
>      Packet file: packets-2172-86.log
>      #280/87  select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK
> 
> The above block is the log of a test case. It shows every packets of a
> connection. The captured packets are stored in the file called
> packets-2172-86.log.
> 
> The following block is an example that monitors the network traffic of
> a test case. This test is running in the network namespace
> "testns". You can pass NULL to traffic_monitor_start() if the entire
> test, from traffic_monitor_start() to traffic_monitor_stop(), is
> running in the same namespace.
> 
>      struct tmonitor_ctx *tmon;
>      
>      ...
>      tmon = traffic_monitor_start("testns");
>      ASSERT_TRUE(tmon, "traffic_monitor_start");
>      
>      ... test ...
>      
>      traffic_monitor_stop(tmon);
> 
> traffic_monitor_start() may fail, but we just ignore it since the
> failure doesn't affect the following main test.
> 
> This feature is enabled only if BPF selftests are built with
> TRAFFIC_MONITOR variable being defined. For example,
> 
>      make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf
> 
> This command will enable traffic monitoring for BPF selftests. That
> means we have to turn it on to get the log at CI.
> 
> ---
> 
> Changes from v1:
> 
>   - Initialize log_fd in traffic_monitor_start().
> 
>   - Remove redundant including.

Sorry for not updating changes correctly.
No more tcpdump, it moves to use call pcap directly
in a background thread.  Packets are wrote to a packet file.
In the log, it prints parsed information of TCP or UDP packets.
For other packets,  just print a string "Packet captured" to indicate
a packet has been captured.

> 
> v1: https://lore.kernel.org/all/20240713055552.2482367-5-thinker.li@gmail.com/
> 
> Kui-Feng Lee (4):
>    selftests/bpf: Add traffic monitor functions.
>    selftests/bpf: Monitor traffic for tc_redirect/tc_redirect_dtime.
>    selftests/bpf: Monitor traffic for sockmap_listen.
>    selftests/bpf: Monitor traffic for select_reuseport.
> 
>   tools/testing/selftests/bpf/Makefile          |   5 +
>   tools/testing/selftests/bpf/network_helpers.c | 382 ++++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |  16 +
>   .../bpf/prog_tests/select_reuseport.c         |   7 +
>   .../selftests/bpf/prog_tests/sockmap_listen.c |   8 +
>   .../selftests/bpf/prog_tests/tc_redirect.c    |   5 +
>   6 files changed, 423 insertions(+)
> 

