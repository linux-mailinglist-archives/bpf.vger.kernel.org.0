Return-Path: <bpf+bounces-34735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8802930727
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF971C2141D
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8801814388E;
	Sat, 13 Jul 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPypyj5j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C30143872
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720898956; cv=none; b=FJzOIkIjqvAvC3RJphziicFebg2jlcPGpm6TkbUUkMfgFGDZ5a/tHF8nCmzaTn8prd8ZwgQO+WrBJOxwta7wprL/Vsxu1+2FDihlAAEXQgBfRUjZV2Qh0ZP6DjGXipX5nAEnkt1EQUC50nYc6jgIPMblCOXe9DuiqAQgsfNcDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720898956; c=relaxed/simple;
	bh=PQtN2wwOMiXG5eVzLqT1pvyomVvPfXUzpk6/IE4Aws8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eL+8mzmb3Hfv1kdP0chUzHaP7uU3gdD7O5iYgxtiaeec9A4T9cyTl0uEk35W1opQ5tOG5zQTplJq+i2a3cYpx1rjR7tteq0TRCVAZ1LYc/8a6dz6bD4dzowVP4CcRWHBQiJ6jntLR8Pfv1ZB55VJp9gBJKc5lDBXgqpQEAzqTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPypyj5j; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03db345b0cso3046400276.1
        for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720898953; x=1721503753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cos6j/oLhWjAJgvmyoW5pt0GUNwd8lyxB9ebrw5EMDA=;
        b=mPypyj5ja0HQchezsrhYpjeklAolqdtlm31YnplMceBYtgTSslgWdSBBQ7u/AC54sT
         wx+Zm8Bsx6qRW4EyT95itLLlpFRKYdlHV0UIfwgO9BNeKakACBaCQGvlsCmjBearWhc0
         IiqYsO+6SqYVsUDpsPkI8qnedZggoseKXGBTRI0L2/M+qF0pPfVgIUOyOINf7zdPbZHh
         noS8Kfx4bDbrkncz0aGQ/+KDxgDJxjaNPyGCDRgN2H1lCOUaqJlMMdk5LcQ4b87g/mCi
         Vylian7q139/ATzOYzlCnrvrhXGg7AHXUdetDcHOwcIEp/L6NSvfT0ihGfJkL3FQB/nk
         NPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720898953; x=1721503753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cos6j/oLhWjAJgvmyoW5pt0GUNwd8lyxB9ebrw5EMDA=;
        b=e53yMwvHLk80g1ie09h6TmGxN1qraOfd2fk1tNy/U1GPsyYn7JHraFasyAoOziNCfr
         JCxAAMzpVtqxLCKGsaNfX2k5JFZRRh1Sh8OMdrltuh84iR2OqqNgABAjXEyAjpxOMLHW
         Um4ExhCbmODPTQJ6715pvUIokLophcVJ+MlAXGsXTI6wSC5xW2U64yRmDaUcdDfJYter
         cO/SGCziDnttoVjxATkxXGaXJ0Cv1fnTVzuEEWp7fR/dFzQeR9ZoGZPcHaaZossTG5Mh
         fFUy7G539x8ZSAKXv32W8hE7Y2mSjT0+0bDLoe3EUlX7X4m4nESyb+hdmyM88e/RTbY1
         esUA==
X-Forwarded-Encrypted: i=1; AJvYcCUnMaIBkdV3TTIgBCMAAfK8gjYnnI9dJO0HQCW6yD+ibZ4264yVn6QF3JTZvkrkN3Uq36WlVdJsRGiijqGrT26AhXRL
X-Gm-Message-State: AOJu0YxvUUfVkh5RVYPirZLzLBEEvV4Q7rPxCGqVSpM2wZJuXDflEer9
	mTDDkMRO2KqcvuNXma1qF6KZttgLER6HAXZ8cdTnR8+URSjionZp
X-Google-Smtp-Source: AGHT+IHiYDPmKhe7WJD30bKP+M2ltRicil95PQ8qm12DlkPKHgYnVUcCcgwxs7XESsHV46bVT18n+w==
X-Received: by 2002:a5b:6c7:0:b0:e03:629d:b826 with SMTP id 3f1490d57ef6-e041b03bb4emr17568518276.7.1720898952501;
        Sat, 13 Jul 2024 12:29:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:e255:ddbb:187:14df? ([2600:1700:6cf8:1240:e255:ddbb:187:14df])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05a46736b4sm289005276.33.2024.07.13.12.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 12:29:12 -0700 (PDT)
Message-ID: <431b9131-4888-4dde-8e3f-bf5514cc8da1@gmail.com>
Date: Sat, 13 Jul 2024 12:29:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] monitor network traffic for flaky test cases
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240713055552.2482367-1-thinker.li@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240713055552.2482367-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It fails on CI. Looks like we don't have tcpdump installed on CI!


On 7/12/24 22:55, Kui-Feng Lee wrote:
> Run tcpdump in the background for flaky test cases related to network
> features.
> 
> We have some flaky test cases that are difficult to debug without
> knowing what the traffic looks like. With the log printed by tcpdump,
> the CI log may help developers to fix these flaky test cases.
> 
> This patch set monitors a few test cases. Recently, they have been
> showing flaky behavior. If these test cases fail, they will report a
> traffic log.
> 
> At the beginning and the end of a traffic log, there are additional
> traffic packets used for synchronization between the test cases and
> the tcpdump process. These packets consist of UDP packets sent to
> 127.0.0.241:4321 and ICMP unreachable messages for this
> destination. For instance, the first two and the last two packets
> serve as synchronization packets in the following log.
> 
>      15:04:08.586368 lo    In  IP 127.0.0.1.58904 > 127.0.0.241.4321: UDP, length 5
>      15:04:08.586435 lo    In  IP 127.0.0.241 > 127.0.0.1: ICMP 127.0.0.241 udp port 4321 unreachable, length 41
>      15:04:08.704526 lo    In  IP6 ::1.52053 > ::1.45070: UDP, length 8
>      15:04:08.722785 lo    In  IP 127.0.0.1.51863 > 127.0.0.241.4321: UDP, length 15
>      15:04:08.722856 lo    In  IP 127.0.0.241 > 127.0.0.1: ICMP 127.0.0.241 udp port 4321 unreachable, length 51
> 
> The IP address 127.0.0.241 is used for synchronization, so the
> loopback interface "lo" should be up in the network namespace where
> the test is being conducted. While not ideal, this should suffice for
> testing purposes.
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
>      /* Report the traffic log only if there is one or more errors. */
>      if (env.subtest_state->error_cnt)
>          traffic_monitor_report(tmon);
>      traffic_monitor_stop(tmon);
> 
> traffic_monitor_start() may fail, but we just ignore it since the
> failure doesn't affect the following test.  This tracking feature
> takes another 60ms for each test with qemu on my test environment.
> 
> Kui-Feng Lee (4):
>    selftests/bpf: Add traffic monitor functions.
>    selftests/bpf: Monitor traffic for tc_redirect/tc_redirect_dtime.
>    selftests/bpf: Monitor traffic for sockmap_listen.
>    selftests/bpf: Monitor traffic for select_reuseport.
> 
>   tools/testing/selftests/bpf/network_helpers.c | 244 ++++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |   5 +
>   .../bpf/prog_tests/select_reuseport.c         |   9 +
>   .../selftests/bpf/prog_tests/sockmap_listen.c |  10 +
>   .../selftests/bpf/prog_tests/tc_redirect.c    |   7 +
>   5 files changed, 275 insertions(+)
> 

