Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CD9687C04
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjBBLQ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 06:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjBBLP7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 06:15:59 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2189FA1
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 03:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ks0m6kj6jGeSpPPlyQyEjH8B3dqXW541S9xFSRkDv0E=; b=n/VAYIX/HwGC2FEpT7COSydONe
        uZc6xpDQlvQSDhpckjnqTSeS1Be0pvCi/o+Y+YdPi2x4pLvUIHftKs7kd0M4Zctjr9KHx58r3kYFu
        AH6xEmyGceuC4S4ORx/HaKBXSYHaYA5ik90ddV+wPBDh85pOGOJ02riK64b4fLNdyhvcUM5ScRHlA
        BNy48nXbz0QGfwzxvYwdnaU0JeCCa8f9fiRXlifQi+Koy3g5y6dHH5UcXbp+5Ht4WUZQBhBtY1z27
        zAgv+uUAdPPbSjYFxSR2Fg3XgxT8T3mNXpMQHJgn1jNcdDiOwd3U3SbFai98siGzOjjNZln0i2hlS
        uNVKr8rw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pNXZK-000Jh6-UE; Thu, 02 Feb 2023 12:15:54 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pNXZK-000IZ9-8a; Thu, 02 Feb 2023 12:15:54 +0100
Subject: Re: [bpf-next v2] bpftool: profile online CPUs instead of possible
To:     tong@infragraf.org, bpf@vger.kernel.org, quentin@isovalent.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20230201122404.4256-1-tong@infragraf.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fb4004dd-597a-e741-27cc-b0cd03bc2172@iogearbox.net>
Date:   Thu, 2 Feb 2023 12:15:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230201122404.4256-1-tong@infragraf.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26800/Thu Feb  2 09:47:56 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/1/23 1:24 PM, tong@infragraf.org wrote:
> From: Tonghao Zhang <tong@infragraf.org>
> 
> The number of online cpu may be not equal to possible cpu.
> bpftool prog profile, can not create pmu event on possible
> but on online cpu.
> 
> $ dmidecode -s system-product-name
> PowerEdge R620
> $ cat /sys/devices/system/cpu/online
> 0-31
> $ cat /sys/devices/system/cpu/possible
> 0-47
> 
> BTW, we can disable CPU dynamically:
> $ echo 0 > /sys/devices/system/cpu/cpuX/online
> 
> If CPU is offline, perf_event_open will return ENODEV.
> To fix this issue, check the value returned and skip
> offline CPU.
> 
> Signed-off-by: Tonghao Zhang <tong@infragraf.org>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> ---
> v1:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230117044902.98938-1-tong@infragraf.org/
> https://patchwork.kernel.org/project/netdevbpf/patch/20230117044902.98938-2-tong@infragraf.org/
> ---
>   tools/bpf/bpftool/prog.c | 36 ++++++++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index cfc9fdc1e863..f48067cb0496 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -2233,10 +2233,36 @@ static void profile_close_perf_events(struct profiler_bpf *obj)
>   	profile_perf_event_cnt = 0;
>   }
>   
> +static int profile_open_perf_event(int mid, int cpu, int map_fd)
> +{
> +	int pmu_fd;
> +
> +	pmu_fd = syscall(__NR_perf_event_open, &metrics[mid].attr,
> +			 -1/*pid*/, cpu, -1/*group_fd*/, 0);
> +	if (pmu_fd < 0) {
> +		if (errno == ENODEV) {
> +			p_info("cpu %d may be offline, skip %s metric profiling.",
> +				cpu, metrics[mid].name);
> +			profile_perf_event_cnt++;
> +			return 0;
> +		}
> +		return -1;
> +	}
> +
> +	if (bpf_map_update_elem(map_fd,
> +				&profile_perf_event_cnt,
> +				&pmu_fd, BPF_ANY) ||
> +	    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0))
> +		return -1;

This leaks pmu_fd here, no? We should close fd on error as the later call to
profile_close_perf_events() only closes those which are in profile_perf_events[]
array.

> +	profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
> +	return 0;
> +}
> +
>   static int profile_open_perf_events(struct profiler_bpf *obj)
>   {
>   	unsigned int cpu, m;
> -	int map_fd, pmu_fd;
> +	int map_fd;
>   
>   	profile_perf_events = calloc(
>   		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
> @@ -2255,17 +2281,11 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
>   		if (!metrics[m].selected)
>   			continue;
>   		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
> -			pmu_fd = syscall(__NR_perf_event_open, &metrics[m].attr,
> -					 -1/*pid*/, cpu, -1/*group_fd*/, 0);
> -			if (pmu_fd < 0 ||
> -			    bpf_map_update_elem(map_fd, &profile_perf_event_cnt,
> -						&pmu_fd, BPF_ANY) ||
> -			    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0)) {
> +			if (profile_open_perf_event(m, cpu, map_fd)) {
>   				p_err("failed to create event %s on cpu %d",
>   				      metrics[m].name, cpu);
>   				return -1;
>   			}
> -			profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
>   		}
>   	}
>   	return 0;
> 

