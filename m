Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4213671A80
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjARLZS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 06:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjARLYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 06:24:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA53756D
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 02:41:53 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n7so7400836wrx.5
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 02:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yCBSiBaMnPBt6XCHGYi+xBWbtYNbT5WrPAhRjvrZBc=;
        b=luTXF2+RWO7DcOokLrdb00iXeYZfn9FivP0lSnbm3PmAWiLKNSlceBha0XzoHpfA8B
         ojk6ZZ4fcyqTd2UBvcg+4nr5daq1IXuAIYxmBX+8pbbQZKphPT3T/MJ6izB6LxVxQECg
         0CACVvc85mJa+G+NxZSmXMtzNC+ua6jUdgV+ATeQfM6BIpTaUjO+ZS0+HNI1ZqegTnMo
         06I5my4OPYe/i9S7rbElPDtOvmDY9Ob7wSRkDRM/JKJlkN0Wrw9+jOJzVTXOAk3L+WGD
         uEQPTZkhmLHtpSShg66hY2eYqxjeFeTukBtZxbqDyStggGD+C2DXVMHyJuME7f7opc5y
         mWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yCBSiBaMnPBt6XCHGYi+xBWbtYNbT5WrPAhRjvrZBc=;
        b=8K6GF6Urvr+9rwiVttDyIxvYvYOQrM6azRLn0kItJpL7KSJrdKJbVcMbT19o34PK6I
         r2NzN/QiRnGxg9OqdY+WhOZdz5J5+N2rA3wPfTC/hTRR4G9zfVipdDXyZHTA9cmkjx3X
         DVY7S0w632qcB4YhzBgZYVuSo7ErhdmtBVmATwMOiHpLlUGM9wtnUm7h8esntF3W47iV
         wbPetXlRCsRgcgxCFd4YiRF4juqWDL9ytt8KXdhKVOYZLtFUan2Rjv3yDtw8zJCRRD3A
         rRPLCkxOH5rH6BXAn0lpEtcL7vgv8MkoDcPOkc4GzsnjcVf/9cbuwZEZXScb6Tcc+hS+
         hYYQ==
X-Gm-Message-State: AFqh2kot7I5sqMlxPWP45hJzOvlflz4YQPpnSZq2MWbBYnq/Gldf6faF
        15GW1zILlIQ01XfPBShu6ydcTQ==
X-Google-Smtp-Source: AMrXdXvD5Fl1QjN+isToC8Ex3iZlZ3YirqMxmqMyC73NDJu52kWwlSjc/fc0G9cKnMTjoyVDkQbrxQ==
X-Received: by 2002:adf:f2c4:0:b0:2be:3503:2dcf with SMTP id d4-20020adff2c4000000b002be35032dcfmr663224wrp.44.1674038511936;
        Wed, 18 Jan 2023 02:41:51 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d62c7000000b002bbeda3809csm25089432wrv.11.2023.01.18.02.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 02:41:51 -0800 (PST)
Message-ID: <ff7263e3-fcd0-8257-a0ce-f5bf94546d52@isovalent.com>
Date:   Wed, 18 Jan 2023 10:41:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [bpf-next v1 1/2] libbpf: introduce new API
 libbpf_num_online_cpus
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
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230117044902.98938-1-tong@infragraf.org>
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
> Adding a new API libbpf_num_online_cpus() that helps user with
> fetching online CPUs number.
> 
> It's useful in system which number of online CPUs is different with
> possible CPUs.
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
>  tools/lib/bpf/libbpf.c   | 47 ++++++++++++++++++++++++++++++----------
>  tools/lib/bpf/libbpf.h   |  7 ++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 27d9faa80471..b84904f79ffd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12192,30 +12192,53 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz)
>  	return parse_cpu_mask_str(buf, mask, mask_sz);
>  }
>  
> -int libbpf_num_possible_cpus(void)
> +static int num_cpus(const char *fcpu)
>  {
> -	static const char *fcpu = "/sys/devices/system/cpu/possible";
> -	static int cpus;
> -	int err, n, i, tmp_cpus;
> +	int err, n, i, cpus;
>  	bool *mask;
>  
> -	tmp_cpus = READ_ONCE(cpus);
> -	if (tmp_cpus > 0)
> -		return tmp_cpus;
> -
>  	err = parse_cpu_mask_file(fcpu, &mask, &n);
>  	if (err)
>  		return libbpf_err(err);
>  
> -	tmp_cpus = 0;
> +	cpus = 0;
>  	for (i = 0; i < n; i++) {
>  		if (mask[i])
> -			tmp_cpus++;
> +			cpus++;
>  	}
>  	free(mask);
>  
> -	WRITE_ONCE(cpus, tmp_cpus);
> -	return tmp_cpus;
> +	return cpus;
> +}
> +
> +int libbpf_num_online_cpus(void)
> +{
> +	static int online_cpus;
> +	int cpus;
> +
> +	cpus = READ_ONCE(online_cpus);
> +	if (cpus > 0)
> +		return cpus;

The number of online CPUs can change over time, I don't think you can
READ_ONCE()/WRITE_ONCE().

> +
> +	cpus = num_cpus("/sys/devices/system/cpu/online");
> +
> +	WRITE_ONCE(online_cpus, cpus);
> +	return cpus;
> +}
> +
> +int libbpf_num_possible_cpus(void)
> +{
> +	static int possible_cpus;
> +	int cpus;
> +
> +	cpus = READ_ONCE(possible_cpus);
> +	if (cpus > 0)
> +		return cpus;
> +
> +	cpus = num_cpus("/sys/devices/system/cpu/possible");
> +
> +	WRITE_ONCE(possible_cpus, cpus);
> +	return cpus;
>  }
>  
>  static int populate_skeleton_maps(const struct bpf_object *obj,
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 898db26e42e9..e433575ff865 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1332,6 +1332,13 @@ LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>   */
>  LIBBPF_API int libbpf_num_possible_cpus(void);
>  
> +/**
> + * @brief **libbpf_num_online_cpus()** is a helper function to get the
> + * number of online CPUs that the host kernel supports and expects.
> + * @return number of online CPUs; or error code on failure
> + */
> +LIBBPF_API int libbpf_num_online_cpus(void);
> +
>  struct bpf_map_skeleton {
>  	const char *name;
>  	struct bpf_map **map;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 11c36a3c1a9f..384fb6333f3f 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -381,6 +381,7 @@ LIBBPF_1.1.0 {
>  		user_ring_buffer__reserve;
>  		user_ring_buffer__reserve_blocking;
>  		user_ring_buffer__submit;
> +		libbpf_num_online_cpus;
>  } LIBBPF_1.0.0;

Libbpf v1.1.0 has shipped, so this would now go to the 1.2.0 block below.

>  
>  LIBBPF_1.2.0 {

Thanks, but I'm not sure retrieving the number of online CPUs, without
the list of those in use, is enough for fixing bpftool profiling
feature. Please see my answer on the second patch.

Quentin
