Return-Path: <bpf+bounces-36256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB99456C0
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 05:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1954B22B2D
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 03:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C77BA47;
	Fri,  2 Aug 2024 03:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTAe71nZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A81CA85
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722570890; cv=none; b=LFDhN5i1fmNg7VuuexHa4tlClRgMFvhHJNRGJV2idHJntrFZ1krhlD+cc880ESS8angguV9q0KYjT/1UqgsCU9/V6iNLvU1tWGpZj0huXl/7RXq60U5SK11UE+Inny8NIi91QsTGtNuUfnM7NO1mCzCDYhGPVU40DXX3ajgEG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722570890; c=relaxed/simple;
	bh=BAjZFg9Va8y6adZrnox1lbLAORr6ywZjETc7VwHojgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVjnLTbTq/Ha3rLa1BNzEnC5ITH8MaNy7V0GLDfgqjpHjb6dPlcY+nGM3wLujcnzCBUszWnHShmE2dWDb9q5VJI5OvQ7k2Iicax2CEUmAHKrigZG+IDHj6N31zWiNcd0eyVFmEilqV431ZWCiivPhMlAtAH2i/iqCFqHZrNBqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTAe71nZ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-65fe1239f12so53243917b3.0
        for <bpf@vger.kernel.org>; Thu, 01 Aug 2024 20:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722570888; x=1723175688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l02FDIghrvfFyL6BhjoeZHCOXR8r2RCZLIop4czwAcU=;
        b=dTAe71nZCoqkoYprKYIFK2z6QWCuSJY+Wd/0Wwb4kPp3KwIbSR0NgCQ5jishS+1+bF
         ss4NlKrDSnxDcwgDjlayevaQDM4BRS0RPkNigsAVx1mOO5gwzNBukqXSHtFMQA0Ygoio
         9QsJUF4bJlIMT6GnGwXuA4qEs0ViJH/sWjRXOcdpdC3XznXY/yvSFdltFJ3jpZirX3Om
         ZTPC8YRRe1lPamzEqLbQP9vhur0kW+N4Qehnu0waJfKIAJI6pt8lAzh0BTUo1cihlash
         3Z6o8Bw/tkXzKF+dAu4O3JXh6dZZoTmS7cCbOV7OxQ8qrgyE4J4OP21/1EQ40ygF96Vb
         fD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722570888; x=1723175688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l02FDIghrvfFyL6BhjoeZHCOXR8r2RCZLIop4czwAcU=;
        b=ByFymBHJeHPvVEphQ0cvg44qQkpz08x4wTDipSj/qajLSck+ikA5iVtDxLjiFAB7n3
         zmhLFtZrO6+fv7p9iXOSctvCiuIIg12o/WyRv+UMCCE0NAvU5J2nCUZSkqFk77nLqRcB
         +qNdfS8j1F2zt5VXAVwJsCHX6Bb2XsGzsvz8ESc3AL6JFaN8tbnnwJRsSemG+jFi2OEF
         V6whh3+NtsQi1X3s8ElUzHgbVxZqeB4MB6eFGeaw/hpREwbdMNNbdatx7odJF2vkRsQ1
         0ne9u21mE/WO86dqtATi0asXX3EY+Dl5Cy2PCpAkbBYgdiIj0upDwbSr3IVCClehTAnd
         lNmw==
X-Gm-Message-State: AOJu0Yz6DbNSawE/4yVXPApI94ZUeYEIuoII5QAjE4PWZ0ete1x7x9ay
	6wttIgl29anjU0tJT0IOvjarK6ITIMfJeRFXOhqTBKE9KeW4dslJ
X-Google-Smtp-Source: AGHT+IEKjfEfCL9cdO9iPOyvC7xvBu6ow9U3ECOHfaLkSZUGHZCqtwzv6nXzUyvW+IOH1cq2HjCYMQ==
X-Received: by 2002:a0d:f701:0:b0:65f:d27d:3f6a with SMTP id 00721157ae682-6895f9e5ebbmr25693917b3.7.1722570887944;
        Thu, 01 Aug 2024 20:54:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:10ed:40b:8a2e:9686? ([2600:1700:6cf8:1240:10ed:40b:8a2e:9686])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d0ffa9sm1234927b3.94.2024.08.01.20.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 20:54:47 -0700 (PDT)
Message-ID: <b653ccb5-1c20-4e68-b9cb-abc2dbb14018@gmail.com>
Date: Thu, 1 Aug 2024 20:54:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Stanislav Fomichev <sdf@fomichev.me>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com> <Zqqnqfh7uwpufMR_@mini-arch>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <Zqqnqfh7uwpufMR_@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/31/24 14:07, Stanislav Fomichev wrote:
> On 07/31, Kui-Feng Lee wrote:
>> Add functions that capture packets and print log in the background. They
>> are supposed to be used for debugging flaky network test cases. A monitored
>> test case should call traffic_monitor_start() to start a thread to capture
>> packets in the background for a given namespace and call
>> traffic_monitor_stop() to stop capturing. (Or, option '-m' implemented by
>> the later patches.)
>>
>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, SYN, ACK
>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, FIN, ACK
>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, RST, ACK
>>      Packet file: packets-2172-86-select_reuseport:sockhash-test.log
>>      #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK
>>
>> The above is the output of an example. It shows the packets of a connection
>> and the name of the file that contains captured packets in the directory
>> /tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.
>>
>> This feature only works if TRAFFIC_MONITOR variable has been passed to
>> build BPF selftests. For example,
>>
>>    make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf
>>
>> This command will build BPF selftests with this feature enabled.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile     |   5 +
>>   tools/testing/selftests/bpf/test_progs.c | 432 +++++++++++++++++++++++
>>   tools/testing/selftests/bpf/test_progs.h |  16 +
>>   3 files changed, 453 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 774c6270e377..0a3108311be7 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -41,6 +41,11 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
>>   LDFLAGS += $(SAN_LDFLAGS)
>>   LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>>   
>> +ifneq ($(TRAFFIC_MONITOR),)
>> +LDLIBS += -lpcap
>> +CFLAGS += -DTRAFFIC_MONITOR=1
>> +endif
> 
> Optionally: can make this more automagical with the following:
> 
> LDLIBS += $(shell pkg-config --libs 2>/dev/null)
> CFLAGS += $(shell pkg-config --cflags 2>/dev/null)
> CFLAGS += $(shell pkg-config --exists libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")

Sure! I will try it!

