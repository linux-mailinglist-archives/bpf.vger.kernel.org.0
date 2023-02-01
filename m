Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4EC685DBC
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 04:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBADNW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 31 Jan 2023 22:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBADNW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 22:13:22 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B1538B4C
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 19:13:17 -0800 (PST)
X-QQ-mid: bizesmtp76t1675221182t3b6vzbd
Received: from smtpclient.apple ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 01 Feb 2023 11:12:58 +0800 (CST)
X-QQ-SSF: 0100000000000080B000000A0000000
X-QQ-FEAT: 5YpjqYAtZvCZjsmiZwKCLTjXcjwSe6gMFLt+N3heMILxdxg5pZBTkRDy8SDXN
        Jee3jlXvCSqFS37zXPTCmZxbvm7agtuVWnLehr0bAAXPTi6cSoYEDb4OdqhbT3gH2GmmwwA
        CiADg/p1ioIuI4bKWpzxmTy15qohYdxeTFLhHWL7Mju4H6SighD+m2recNZMj5wjPvbNDNl
        cnMU4/qmUcx40Ml88xOdhVzMqPeLQb/JeQKnSqk/xf7j5pTcGLheB6kKZ3f6Jmwv9dejSi0
        jvenDwNb3gStCjJX2I4oTecP+XvWL4/z7nSGu9zFDjBvQZJwIsUKEr1vgo2d4LkTIFieUQ+
        avjlZVLVmleM/nQr5pBAIgKYirBFiiCtocSmAO5
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [bpf-next v1 2/2] bpftool: profile online CPUs instead of
 possible
From:   Tonghao Zhang <tong@infragraf.org>
In-Reply-To: <19047565-6f8e-8615-e555-434e5c126c25@isovalent.com>
Date:   Wed, 1 Feb 2023 11:12:54 +0800
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B4E4B970-996A-4C3F-87C5-A478956370C8@infragraf.org>
References: <20230117044902.98938-1-tong@infragraf.org>
 <20230117044902.98938-2-tong@infragraf.org>
 <64b7fb86-5757-13ec-acf3-ab7ded978cd4@isovalent.com>
 <12D2AAAD-14CC-43EC-889B-6E625756C18F@infragraf.org>
 <19047565-6f8e-8615-e555-434e5c126c25@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jan 20, 2023, at 11:35 PM, Quentin Monnet <quentin@isovalent.com> wrote:
> 
> 2023-01-19 16:22 UTC+0800 ~ Tonghao Zhang <tong@infragraf.org>
>>> On Jan 18, 2023, at 6:41 PM, Quentin Monnet <quentin@isovalent.com> wrote:
>>> 
>>> 2023-01-17 12:49 UTC+0800 ~ tong@infragraf.org
>>>> From: Tonghao Zhang <tong@infragraf.org>
>>>> 
>>>> The number of online cpu may be not equal to possible cpu.
>>>> bpftool prog profile, can not create pmu event on possible
>>>> but not online cpu.
>>> 
>>> s/not/on/ ?
>>> 
>>>> 
>>>> $ dmidecode -s system-product-name
>>>> PowerEdge R620
>>>> $ cat /sys/devices/system/cpu/online
>>>> 0-31
>>>> $ cat /sys/devices/system/cpu/possible
>>>> 0-47
>>>> 
>>>> To fix this issue, use online cpu instead of possible, to
>>>> create perf event and other resource.
>>>> 
>>>> Signed-off-by: Tonghao Zhang <tong@infragraf.org>
>>>> Cc: Quentin Monnet <quentin@isovalent.com>
>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>>> Cc: Song Liu <song@kernel.org>
>>>> Cc: Yonghong Song <yhs@fb.com>
>>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>>> Cc: KP Singh <kpsingh@kernel.org>
>>>> Cc: Stanislav Fomichev <sdf@google.com>
>>>> Cc: Hao Luo <haoluo@google.com>
>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>> ---
>>>> tools/bpf/bpftool/prog.c | 5 +++--
>>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>>>> index cfc9fdc1e863..08b352dd799e 100644
>>>> --- a/tools/bpf/bpftool/prog.c
>>>> +++ b/tools/bpf/bpftool/prog.c
>>>> @@ -2056,6 +2056,7 @@ static int profile_parse_metrics(int argc, char **argv)
>>>> 
>>>> static void profile_read_values(struct profiler_bpf *obj)
>>>> {
>>>> +	__u32 possible_cpus = libbpf_num_possible_cpus();
>>>> 	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
>>>> 	int reading_map_fd, count_map_fd;
>>>> 	__u64 counts[num_cpu];
>>>> @@ -2080,7 +2081,7 @@ static void profile_read_values(struct profiler_bpf *obj)
>>>> 		profile_total_count += counts[cpu];
>>>> 
>>>> 	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>>>> -		struct bpf_perf_event_value values[num_cpu];
>>>> +		struct bpf_perf_event_value values[possible_cpus];
>>>> 
>>>> 		if (!metrics[m].selected)
>>>> 			continue;
>>>> @@ -2321,7 +2322,7 @@ static int do_profile(int argc, char **argv)
>>>> 	if (num_metric <= 0)
>>>> 		goto out;
>>>> 
>>>> -	num_cpu = libbpf_num_possible_cpus();
>>>> +	num_cpu = libbpf_num_online_cpus();
>>>> 	if (num_cpu <= 0) {
>>>> 		p_err("failed to identify number of CPUs");
>>>> 		goto out;
>>> 
>>> Thanks, but it doesn't seem to be enough to solve the issue. How did you
>>> test it? With your series applied locally, I'm trying the following
>>> (Intel x86_64, CPUs: 0..7):
>>> 
>>> 	# echo 0 > /sys/devices/system/cpu/cpu2/online
>>> 	# ./bpftool prog profile id 1525 duration 1 cycles instructions
>>> 	Error: failed to create event cycles on cpu 2
>>> 
>>> It seems that we're still trying to open the perf events on the offline
>>> CPU in profile_open_perf_events(), because even though we try to use
>>> fewer of the possible CPUs we're still referencing them in order by
>> Hi
>> Thanks for your review and comment.
>> I don’t test the case that one cpu is offline which is not last CPU.
>>> their index. So it works if I only disabled the last CPUs instead (#7,
>>> then #6, ...), but to work with _any_ CPU disabled, we would need to
>>> retrieve the list of online CPUs.
>>> 
>> Yes, In other way, to fix it, we can use the errno return by open_perf_event. If errno is ENODEV, we can skip this cpu to profile? 
>> The patch fix this issue.
>> 
>> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
>> index 620032042576..deec7196b48c 100644
>> --- a/tools/bpf/bpftool/common.c
>> +++ b/tools/bpf/bpftool/common.c
>> @@ -55,6 +55,24 @@ void p_err(const char *fmt, ...)
>> 	va_end(ap);
>> }
>> 
>> +void p_warn(const char *fmt, ...)
>> +{
>> +	va_list ap;
>> +
>> +	va_start(ap, fmt);
>> +	if (json_output) {
>> +		jsonw_start_object(json_wtr);
>> +		jsonw_name(json_wtr, "warning");
>> +		jsonw_vprintf_enquote(json_wtr, fmt, ap);
>> +		jsonw_end_object(json_wtr);
>> +	} else {
>> +		fprintf(stderr, "Warn: ");
>> +		vfprintf(stderr, fmt, ap);
>> +		fprintf(stderr, "\n");
>> +	}
>> +	va_end(ap);
>> +}
>> +
>> void p_info(const char *fmt, ...)
>> {
>> 	va_list ap;
>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>> index a84224b6a604..e62edec9e13a 100644
>> --- a/tools/bpf/bpftool/main.h
>> +++ b/tools/bpf/bpftool/main.h
>> @@ -86,6 +86,7 @@ extern struct btf *base_btf;
>> extern struct hashmap *refs_table;
>> 
>> void __printf(1, 2) p_err(const char *fmt, ...);
>> +void __printf(1, 2) p_warn(const char *fmt, ...);
>> void __printf(1, 2) p_info(const char *fmt, ...);
>> 
>> bool is_prefix(const char *pfx, const char *str);
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index cfc9fdc1e863..d9363ba01ec0 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -2233,10 +2233,36 @@ static void profile_close_perf_events(struct profiler_bpf *obj)
>> 	profile_perf_event_cnt = 0;
>> }
>> 
>> +static int profile_open_perf_event(int mid, int cpu, int map_fd)
>> +{
>> +	int pmu_fd;
>> +
>> +	pmu_fd = syscall(__NR_perf_event_open, &metrics[mid].attr,
>> +			 -1/*pid*/, cpu, -1/*group_fd*/, 0);
>> +	if (pmu_fd < 0) {
>> +		if (errno == ENODEV) {
>> +			p_warn("cpu %d may be offline, skip %s metric profiling.",
>> +				cpu, metrics[mid].name);
> 
> Nit: I think it's fine to keep this at the info level (p_info()).
Ok
>> +			profile_perf_event_cnt++;
>> +			return 0;
>> +		}
>> +		return -1;
>> +	}
>> +
>> +	if (bpf_map_update_elem(map_fd,
>> +				&profile_perf_event_cnt,
>> +				&pmu_fd, BPF_ANY) ||
>> +	    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0))
>> +		return -1;
>> +
>> +	profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
>> +	return 0;
>> +}
>> +
>> static int profile_open_perf_events(struct profiler_bpf *obj)
>> {
>> 	unsigned int cpu, m;
>> -	int map_fd, pmu_fd;
>> +	int map_fd;
>> 
>> 	profile_perf_events = calloc(
>> 		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
>> @@ -2255,17 +2281,11 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
>> 		if (!metrics[m].selected)
>> 			continue;
>> 		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
>> -			pmu_fd = syscall(__NR_perf_event_open, &metrics[m].attr,
>> -					 -1/*pid*/, cpu, -1/*group_fd*/, 0);
>> -			if (pmu_fd < 0 ||
>> -			    bpf_map_update_elem(map_fd, &profile_perf_event_cnt,
>> -						&pmu_fd, BPF_ANY) ||
>> -			    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0)) {
>> +			if (profile_open_perf_event(m, cpu, map_fd)) {
>> 				p_err("failed to create event %s on cpu %d",
>> 				      metrics[m].name, cpu);
>> 				return -1;
>> 			}
>> -			profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
>> 		}
>> 	}
>> 	return 0;
>> 
>> 
>> ----
>> Best Regards, Tonghao <tong@infragraf.org>
>> 
> 
> I haven't tested this patch, but yes, looks like it should address the
> issue. Could you submit a proper v2, please?
Yes, v2 will be sent soon. I’m on vacation. So sorry reply you late.
> Quentin

----
Best Regards, Tonghao <tong@infragraf.org>

