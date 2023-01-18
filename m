Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F81671A87
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 12:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjARL0v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 06:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjARLYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 06:24:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A515837B48
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 02:41:57 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j34-20020a05600c1c2200b003da1b054057so1074526wms.5
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 02:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgGy7VZXmHRuoUnB6hQe3Q3Kgauh1ddIbldihbQu6PY=;
        b=dqb+D75YhAaZYS95pL6Eozeng2FpAv4ZjrCjnLkDVqB9rVh27puXp2sERdt7zhD6A3
         rjBpkKpSYh72EdXS2E22Fo8ESoCw5IXWRU63fg+mcZ1M4tfw6WKc5Cib8NSrwU3a0Ixx
         y5UVkp4CmjSz47ufGzENYw74sK9RXaV59oIkjW85fbD3XBrU/1e+Y4Bv4c6W+srm8tmr
         v6ThTXhRxt6dYR8JFjiIfSPs83Rd8b92zq8GRcclJMQnuQNpv2R4m3RXN5RFhDgO6NY6
         rJGlByaXbZtO01Mc7qaKOvwvRlGX2O7cQW2B42kUx37d3HNcNKBmCPk8UWbYD3w7GjN9
         96xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgGy7VZXmHRuoUnB6hQe3Q3Kgauh1ddIbldihbQu6PY=;
        b=rI7SBcglHo9fdFM0IYTyF88/kJIgYppuf76gy4E+OuRSATXSs7jRsAcHwHELWYjCjS
         PbObzjaeWAHZYNLt9C4WkZDZbli22/EDfjywPyRo1yPNxYYseJjsrFq2ETh2Rghs3yBK
         k6Hj5k3X84ommOc6+M8Ml/eBnjkRKfGyaVbHgVpLK4tl22RJlUFYFKaSb9icAUt6Z0hD
         vgjPnMtPLF/t0BYCfRZ49ZOKMK5CcMylHwcxvzx0x3DcBkOasGbddPWAtxRRvXIhVN+9
         th0pXxXirkLPKla+SPmB+SgKrRFGIOTAPgPZcCSyeqCUBDBkjO4Ew3RIZmONVArZxO8f
         sU6g==
X-Gm-Message-State: AFqh2kqVZJ8mptvBmeAbNm7x+qL2T6XrpSDst4AJzOSU9CehI5nh/z/y
        kZc9ADnM1Jo+XV9xtw5IKZdbzA==
X-Google-Smtp-Source: AMrXdXtyOaJW59cahS/P5zvkuxEMnkiVyzTCLrUppeFCApClnt+TEu/zIEeme1xZ24PcV3sMJl0g6w==
X-Received: by 2002:a05:600c:4e03:b0:3da:2870:7dc7 with SMTP id b3-20020a05600c4e0300b003da28707dc7mr2135047wmq.24.1674038516232;
        Wed, 18 Jan 2023 02:41:56 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id fk6-20020a05600c0cc600b003c6b70a4d69sm1537480wmb.42.2023.01.18.02.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 02:41:55 -0800 (PST)
Message-ID: <64b7fb86-5757-13ec-acf3-ab7ded978cd4@isovalent.com>
Date:   Wed, 18 Jan 2023 10:41:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [bpf-next v1 2/2] bpftool: profile online CPUs instead of
 possible
Content-Language: en-GB
To:     tong@infragraf.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230117044902.98938-2-tong@infragraf.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-01-17 12:49 UTC+0800 ~ tong@infragraf.org
> From: Tonghao Zhang <tong@infragraf.org>
> 
> The number of online cpu may be not equal to possible cpu.
> bpftool prog profile, can not create pmu event on possible
> but not online cpu.

s/not/on/ ?

> 
> $ dmidecode -s system-product-name
> PowerEdge R620
> $ cat /sys/devices/system/cpu/online
> 0-31
> $ cat /sys/devices/system/cpu/possible
> 0-47
> 
> To fix this issue, use online cpu instead of possible, to
> create perf event and other resource.
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
>  tools/bpf/bpftool/prog.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index cfc9fdc1e863..08b352dd799e 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -2056,6 +2056,7 @@ static int profile_parse_metrics(int argc, char **argv)
>  
>  static void profile_read_values(struct profiler_bpf *obj)
>  {
> +	__u32 possible_cpus = libbpf_num_possible_cpus();
>  	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
>  	int reading_map_fd, count_map_fd;
>  	__u64 counts[num_cpu];
> @@ -2080,7 +2081,7 @@ static void profile_read_values(struct profiler_bpf *obj)
>  		profile_total_count += counts[cpu];
>  
>  	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
> -		struct bpf_perf_event_value values[num_cpu];
> +		struct bpf_perf_event_value values[possible_cpus];
>  
>  		if (!metrics[m].selected)
>  			continue;
> @@ -2321,7 +2322,7 @@ static int do_profile(int argc, char **argv)
>  	if (num_metric <= 0)
>  		goto out;
>  
> -	num_cpu = libbpf_num_possible_cpus();
> +	num_cpu = libbpf_num_online_cpus();
>  	if (num_cpu <= 0) {
>  		p_err("failed to identify number of CPUs");
>  		goto out;

Thanks, but it doesn't seem to be enough to solve the issue. How did you
test it? With your series applied locally, I'm trying the following
(Intel x86_64, CPUs: 0..7):

	# echo 0 > /sys/devices/system/cpu/cpu2/online
	# ./bpftool prog profile id 1525 duration 1 cycles instructions
	Error: failed to create event cycles on cpu 2

It seems that we're still trying to open the perf events on the offline
CPU in profile_open_perf_events(), because even though we try to use
fewer of the possible CPUs we're still referencing them in order by
their index. So it works if I only disabled the last CPUs instead (#7,
then #6, ...), but to work with _any_ CPU disabled, we would need to
retrieve the list of online CPUs.
