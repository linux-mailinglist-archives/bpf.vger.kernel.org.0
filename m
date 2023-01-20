Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB9A6758C6
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 16:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjATPf4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjATPfz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 10:35:55 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C2BCC5EC
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 07:35:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso1357140wmb.0
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MvvkE0Ftb9zF+tL5k+QFwG+Dp+qVUYtim52OsRxGXo=;
        b=n7dEKLtxlzcdnGyTTYLGLc14ZOLhY8IeVUsMg5G8HOTnjBX8W52vgJC+h/rMK60nn5
         S5lhhauZ/DcjY0eaWHOwYkpXI1SV7/knGZXmD+FdcAkA3W6Zj+d1Ed01Ht9vwU4hRJYE
         nDB0ssdexh0TSnOP5zoiBTvZE+32a+FH/GC/hfLLVa2XIVGhEGjCiuqsMLhk9r9K7HCJ
         d1mh7cIizbMl+NcMrqzphnfgA9i3JWejMUXTJMLonoYQ5Vnq4CBRSfYNdwqRmQPkNmdb
         PfyyFj3inPZbi5xpNB4r8UO8k6lnXtcenapxGWBJURlrsoJDiTOx9k46CS/Le4Mwg45b
         bX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MvvkE0Ftb9zF+tL5k+QFwG+Dp+qVUYtim52OsRxGXo=;
        b=DB/kehqN7iEVuep5xcJR2G7lUbLRGBRPd0bol4ZpDr9e0IllACjX7mID20jieanTWd
         /OW5brOHt8Ee2asT/aQkJG1aZOMNfihD+MYmwdIPamOSsLudQtk5sL4aQl9qaknv8nKx
         ToRJDzjt1qnx7evO4gbcYcKf9GEAo2G3y0unTBCJ8l4zHw1S2R7q6VRVYeASA+LSFrbW
         uOsATbzkSA88P/2RNAyf+lxC0TRdV07qwK7o++5/U0YnRqvz0Wn2v413oXeWskJE5ycJ
         zbFW76HXZZdnH3FICmxd1RR4Tp2F2CfKUuzT/vFtl4Zmr6F2OFpOtJnW9+C61aGKoNm4
         M5Qg==
X-Gm-Message-State: AFqh2krV8ixi4BIrW5zOE8I3rZhRMsOfc+uEAxxfMDnMwztq5djpIxuo
        MvbEmqw8qw0gLlWXrjSxkESBxg==
X-Google-Smtp-Source: AMrXdXtT+ZkGK3DEV4Pcr0Ko3hmLmG8Tr2ZIc7nNmgYgz4uU+iBUmWT0DC6F6ar0ZCGEDsQgpDwWDw==
X-Received: by 2002:a05:600c:214f:b0:3cf:7197:e67c with SMTP id v15-20020a05600c214f00b003cf7197e67cmr14716991wml.25.1674228907928;
        Fri, 20 Jan 2023 07:35:07 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:206a:3601:e166:48b6? ([2a02:8011:e80c:0:206a:3601:e166:48b6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003dafb0c8dfbsm2921920wmi.14.2023.01.20.07.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:35:07 -0800 (PST)
Message-ID: <19047565-6f8e-8615-e555-434e5c126c25@isovalent.com>
Date:   Fri, 20 Jan 2023 15:35:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [bpf-next v1 2/2] bpftool: profile online CPUs instead of
 possible
Content-Language: en-GB
To:     Tonghao Zhang <tong@infragraf.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20230117044902.98938-1-tong@infragraf.org>
 <20230117044902.98938-2-tong@infragraf.org>
 <64b7fb86-5757-13ec-acf3-ab7ded978cd4@isovalent.com>
 <12D2AAAD-14CC-43EC-889B-6E625756C18F@infragraf.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <12D2AAAD-14CC-43EC-889B-6E625756C18F@infragraf.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-01-19 16:22 UTC+0800 ~ Tonghao Zhang <tong@infragraf.org>
>> On Jan 18, 2023, at 6:41 PM, Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> 2023-01-17 12:49 UTC+0800 ~ tong@infragraf.org
>>> From: Tonghao Zhang <tong@infragraf.org>
>>>
>>> The number of online cpu may be not equal to possible cpu.
>>> bpftool prog profile, can not create pmu event on possible
>>> but not online cpu.
>>
>> s/not/on/ ?
>>
>>>
>>> $ dmidecode -s system-product-name
>>> PowerEdge R620
>>> $ cat /sys/devices/system/cpu/online
>>> 0-31
>>> $ cat /sys/devices/system/cpu/possible
>>> 0-47
>>>
>>> To fix this issue, use online cpu instead of possible, to
>>> create perf event and other resource.
>>>
>>> Signed-off-by: Tonghao Zhang <tong@infragraf.org>
>>> Cc: Quentin Monnet <quentin@isovalent.com>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>> Cc: Song Liu <song@kernel.org>
>>> Cc: Yonghong Song <yhs@fb.com>
>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>> Cc: KP Singh <kpsingh@kernel.org>
>>> Cc: Stanislav Fomichev <sdf@google.com>
>>> Cc: Hao Luo <haoluo@google.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>> tools/bpf/bpftool/prog.c | 5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>>> index cfc9fdc1e863..08b352dd799e 100644
>>> --- a/tools/bpf/bpftool/prog.c
>>> +++ b/tools/bpf/bpftool/prog.c
>>> @@ -2056,6 +2056,7 @@ static int profile_parse_metrics(int argc, char **argv)
>>>
>>> static void profile_read_values(struct profiler_bpf *obj)
>>> {
>>> +	__u32 possible_cpus = libbpf_num_possible_cpus();
>>> 	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
>>> 	int reading_map_fd, count_map_fd;
>>> 	__u64 counts[num_cpu];
>>> @@ -2080,7 +2081,7 @@ static void profile_read_values(struct profiler_bpf *obj)
>>> 		profile_total_count += counts[cpu];
>>>
>>> 	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>>> -		struct bpf_perf_event_value values[num_cpu];
>>> +		struct bpf_perf_event_value values[possible_cpus];
>>>
>>> 		if (!metrics[m].selected)
>>> 			continue;
>>> @@ -2321,7 +2322,7 @@ static int do_profile(int argc, char **argv)
>>> 	if (num_metric <= 0)
>>> 		goto out;
>>>
>>> -	num_cpu = libbpf_num_possible_cpus();
>>> +	num_cpu = libbpf_num_online_cpus();
>>> 	if (num_cpu <= 0) {
>>> 		p_err("failed to identify number of CPUs");
>>> 		goto out;
>>
>> Thanks, but it doesn't seem to be enough to solve the issue. How did you
>> test it? With your series applied locally, I'm trying the following
>> (Intel x86_64, CPUs: 0..7):
>>
>> 	# echo 0 > /sys/devices/system/cpu/cpu2/online
>> 	# ./bpftool prog profile id 1525 duration 1 cycles instructions
>> 	Error: failed to create event cycles on cpu 2
>>
>> It seems that we're still trying to open the perf events on the offline
>> CPU in profile_open_perf_events(), because even though we try to use
>> fewer of the possible CPUs we're still referencing them in order by
> Hi
> Thanks for your review and comment.
> I don’t test the case that one cpu is offline which is not last CPU.
>> their index. So it works if I only disabled the last CPUs instead (#7,
>> then #6, ...), but to work with _any_ CPU disabled, we would need to
>> retrieve the list of online CPUs.
>>
> Yes, In other way, to fix it, we can use the errno return by open_perf_event. If errno is ENODEV, we can skip this cpu to profile? 
> The patch fix this issue.
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 620032042576..deec7196b48c 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -55,6 +55,24 @@ void p_err(const char *fmt, ...)
>  	va_end(ap);
>  }
> 
> +void p_warn(const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);
> +		jsonw_name(json_wtr, "warning");
> +		jsonw_vprintf_enquote(json_wtr, fmt, ap);
> +		jsonw_end_object(json_wtr);
> +	} else {
> +		fprintf(stderr, "Warn: ");
> +		vfprintf(stderr, fmt, ap);
> +		fprintf(stderr, "\n");
> +	}
> +	va_end(ap);
> +}
> +
>  void p_info(const char *fmt, ...)
>  {
>  	va_list ap;
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index a84224b6a604..e62edec9e13a 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -86,6 +86,7 @@ extern struct btf *base_btf;
>  extern struct hashmap *refs_table;
> 
>  void __printf(1, 2) p_err(const char *fmt, ...);
> +void __printf(1, 2) p_warn(const char *fmt, ...);
>  void __printf(1, 2) p_info(const char *fmt, ...);
> 
>  bool is_prefix(const char *pfx, const char *str);
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index cfc9fdc1e863..d9363ba01ec0 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -2233,10 +2233,36 @@ static void profile_close_perf_events(struct profiler_bpf *obj)
>  	profile_perf_event_cnt = 0;
>  }
> 
> +static int profile_open_perf_event(int mid, int cpu, int map_fd)
> +{
> +	int pmu_fd;
> +
> +	pmu_fd = syscall(__NR_perf_event_open, &metrics[mid].attr,
> +			 -1/*pid*/, cpu, -1/*group_fd*/, 0);
> +	if (pmu_fd < 0) {
> +		if (errno == ENODEV) {
> +			p_warn("cpu %d may be offline, skip %s metric profiling.",
> +				cpu, metrics[mid].name);

Nit: I think it's fine to keep this at the info level (p_info()).

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
> +
> +	profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
> +	return 0;
> +}
> +
>  static int profile_open_perf_events(struct profiler_bpf *obj)
>  {
>  	unsigned int cpu, m;
> -	int map_fd, pmu_fd;
> +	int map_fd;
> 
>  	profile_perf_events = calloc(
>  		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
> @@ -2255,17 +2281,11 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
>  		if (!metrics[m].selected)
>  			continue;
>  		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
> -			pmu_fd = syscall(__NR_perf_event_open, &metrics[m].attr,
> -					 -1/*pid*/, cpu, -1/*group_fd*/, 0);
> -			if (pmu_fd < 0 ||
> -			    bpf_map_update_elem(map_fd, &profile_perf_event_cnt,
> -						&pmu_fd, BPF_ANY) ||
> -			    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0)) {
> +			if (profile_open_perf_event(m, cpu, map_fd)) {
>  				p_err("failed to create event %s on cpu %d",
>  				      metrics[m].name, cpu);
>  				return -1;
>  			}
> -			profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
>  		}
>  	}
>  	return 0;
> 
> 
> ----
> Best Regards, Tonghao <tong@infragraf.org>
> 

I haven't tested this patch, but yes, looks like it should address the
issue. Could you submit a proper v2, please?

Quentin
