Return-Path: <bpf+bounces-1431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E29F715CD0
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 13:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196EF281153
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 11:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD017AA1;
	Tue, 30 May 2023 11:16:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C262174F9
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 11:16:08 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C790CE5
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 04:16:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso45700905e9.2
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685445360; x=1688037360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIDStQE3nec2i+wSQ4dsovyE2XM+xYcuWVSWWXEg+Zs=;
        b=DrZCFfpooFLS6q4mXn8Q/BXzUit80D3PWrYOVbvQM9rVVEJmObYPAUR289qq4ODKxA
         gPUOPRhBc1KIv87htfqzwgLswexDv3I8jxZIpsZ6+1UNT+7yjZhpzl7wj/OmFU3CSnuj
         8Re8/lSwjdYjmLqZOWWvDf1kmvhIAfaYS7QTIFXZlXyLVU+vHxnXJGhD/SJFwbd7qi4A
         LIpB6SPIGeKYOdYtj/CPbL419YLruPeygwmEe46Qxc9+BvpJ/vJY6/ZRm0yAKJCHV2/6
         00GliNO8wqwyrv5YDpXx/Z9QOe6a9VMQtyTGkN/nehm7swEfEdFUveyNpqUVe72JpHpt
         yOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445360; x=1688037360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIDStQE3nec2i+wSQ4dsovyE2XM+xYcuWVSWWXEg+Zs=;
        b=GX1E+pl1kgnQfDc1XnkMA1kPx2DbAGsJp+Wh4haJf8FGX/VK6WzEdSl5qtP4ZR0VLX
         LvP2lpBTHuvAeRQp8ubxdGMFpuZr3XkSBX8CBCgXJKIIX/euMOkzyOPyeycFadUjJw3l
         29ZXZ0Cz2cBlr3SRzaKfs25KzOUVBeFOGwGkL3WZJg+cEHYBkv0K7R6llVbRGg3cnUzf
         q0QoybnnLmNH4OgY/wg8406NG44rWFD2Ir/a6UcJ5nsA5KOVvtFLcpqSrASx1STBOllB
         gmt0GQ6ibyFlpaSexkzYaEM2cKFIp8f4J8zYwtpNNWeq1QYmwHZlBIZrLdoKqnBGtCZu
         VdXQ==
X-Gm-Message-State: AC+VfDzigT31zdR0y35YuFY5M53Jj7mrw97maFqHp0hKnyyomE/sDW5l
	gTL4nDJOHbgiB4s5TdL55D8tZZN7Ot6oWhDlZki0wg==
X-Google-Smtp-Source: ACHHUZ6fy/Pxf6mL9qXV5h4f/a18hNsRd37CC9f+pzopXWTqyIUuAnBcL7+38p342qzAQ+X/SAvEZA==
X-Received: by 2002:a7b:c387:0:b0:3f4:e4a2:9f7f with SMTP id s7-20020a7bc387000000b003f4e4a29f7fmr1545447wmj.36.1685445360260;
        Tue, 30 May 2023 04:16:00 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:59fe:2129:2c:905? ([2a02:8011:e80c:0:59fe:2129:2c:905])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003eddc6aa5fasm20687152wmd.39.2023.05.30.04.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 04:16:00 -0700 (PDT)
Message-ID: <313a276f-aab9-42ed-e835-32261c25bb39@isovalent.com>
Date: Tue, 30 May 2023 12:15:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC PATCH bpf-next 3/8] bpftool: Show probed function in
 kprobe_multi link info
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20230528142027.5585-1-laoar.shao@gmail.com>
 <20230528142027.5585-4-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230528142027.5585-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-28 14:20 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> Show the already expose kprobe_multi link info in bpftool. The result as
> follows,
> 
> $ bpftool link show
> 2: kprobe_multi  prog 11
>         func_cnt 4  addrs ffffffffaad475c0 ffffffffaad47600
>                           ffffffffaad47640 ffffffffaad47680
>         pids trace(10936)
> 
> $ bpftool link show -j
> [{"id":1,"type":"perf_event","prog_id":5,"bpf_cookie":0,"pids":[{"pid":10658,"comm":"trace"}]},{"id":2,"type":"kprobe_multi","prog_id":11,"func_cnt":4,"addrs":[18446744072280634816,18446744072280634880,18446744072280634944,18446744072280635008],"pids":[{"pid":10936,"comm":"trace"}]},{"id":120,"type":"iter","prog_id":266,"target_name":"bpf_map"},{"id":121,"type":"iter","prog_id":267,"target_name":"bpf_prog"}]
> 
> $ bpftool link show  | grep -A 1 "func_cnt" | \
>   awk '{if (NR == 1) {print $4; print $5;} else {print $1; print $2} }' | \
>   awk '{"grep " $1 " /proc/kallsyms" | getline f; print f;}'
> ffffffffaad475c0 T schedule_timeout_interruptible
> ffffffffaad47600 T schedule_timeout_killable
> ffffffffaad47640 T schedule_timeout_uninterruptible
> ffffffffaad47680 T schedule_timeout_idle

Looks nice, thank you!

The address is a useful addition, but I feel like most of the time, this
is the actual function name that we'd like to see. We could maybe print
it directly in bpftool, what do you think? We already parse
/proc/kallsyms elsewhere (to get the address of __bpf_call_base()). If
we can parse the file only once for all func_cnt function, the overhead
is maybe acceptable?

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 2d78607..76f1bb2 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -218,6 +218,20 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>  		jsonw_uint_field(json_wtr, "map_id",
>  				 info->struct_ops.map_id);
>  		break;
> +	case BPF_LINK_TYPE_KPROBE_MULTI:
> +		const __u64 *addrs;
> +		__u32 i;
> +
> +		jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
> +		if (!info->kprobe_multi.count)
> +			break;

I'd as well avoid having conditional entries in the JSON output. Let's
just keep 0 and empty array in this case?

> +		jsonw_name(json_wtr, "addrs");
> +		jsonw_start_array(json_wtr);
> +		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> +		for (i = 0; i < info->kprobe_multi.count; i++)
> +			jsonw_lluint(json_wtr, addrs[i]);
> +		jsonw_end_array(json_wtr);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -396,6 +410,24 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  	case BPF_LINK_TYPE_NETFILTER:
>  		netfilter_dump_plain(info);
>  		break;
> +	case BPF_LINK_TYPE_KPROBE_MULTI:
> +		__u32 indent, cnt, i;
> +		const __u64 *addrs;
> +
> +		cnt = info->kprobe_multi.count;
> +		if (!cnt)
> +			break;
> +		printf("\n\tfunc_cnt %d  addrs", cnt);
> +		for (i = 0; cnt; i++)
> +			cnt /= 10;
> +		indent = strlen("func_cnt ") + i + strlen("  addrs");
> +		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> +		for (i = 0; i < info->kprobe_multi.count; i++) {
> +			if (i && !(i & 0x1))
> +				printf("\n\t%*s", indent, "");
> +			printf(" %0*llx", 16, addrs[i]);
> +		}
> +		break;
>  	default:
>  		break;
>  	}
> @@ -417,7 +449,9 @@ static int do_show_link(int fd)
>  {
>  	struct bpf_link_info info;
>  	__u32 len = sizeof(info);
> +	__u64 *addrs = NULL;
>  	char buf[256];
> +	int count;
>  	int err;
>  
>  	memset(&info, 0, sizeof(info));
> @@ -441,12 +475,28 @@ static int do_show_link(int fd)
>  		info.iter.target_name_len = sizeof(buf);
>  		goto again;
>  	}
> +	if (info.type == BPF_LINK_TYPE_KPROBE_MULTI &&
> +	    !info.kprobe_multi.addrs) {
> +		count = info.kprobe_multi.count;
> +		if (count) {
> +			addrs = malloc(count * sizeof(__u64));

Nit: calloc() instead?

> +			if (!addrs) {
> +				p_err("mem alloc failed");
> +				close(fd);
> +				return -1;
> +			}
> +			info.kprobe_multi.addrs = (unsigned long)addrs;
> +			goto again;
> +		}
> +	}
>  
>  	if (json_output)
>  		show_link_close_json(fd, &info);
>  	else
>  		show_link_close_plain(fd, &info);
>  
> +	if (addrs)
> +		free(addrs);
>  	close(fd);
>  	return 0;
>  }

The other bpftool patch (perf_event link) looks good to me.

Thanks,
Quentin

