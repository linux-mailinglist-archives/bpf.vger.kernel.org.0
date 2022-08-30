Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196355A64D7
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiH3Ndy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiH3Ndx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 09:33:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5ED9E93
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 06:33:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs25so14271039wrb.2
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4Xzmly2VXzYLFnlkqo9YsSvrz1tmikNREb7p3AF7Jgs=;
        b=Rv7Z7yMfdEnua+5b0wfLqIbckYloVUNGwFAj0h2xnI594kQK46t9bNsCiWilFuPeqU
         jNRjZvlfU/g2QbUNd2gXjJtthQ9qluWHjhXqHZpIdcoUM7wF6lsfLp+8/+PScMtslYXa
         gpLPcQDFLKxE4TnohIEHX9Rivc/TpDIbiJ19QbIfku/Z5x7BYEvenV5Lc4buZT87YJ64
         jjaiFLAPQd9/qGol6Gu9l/dOKB5heXF3Y1XJDdYZOhMfM8lvEdwQbSPJs866xutJ+EG/
         muJtfifXiVBU95z0B3N3J4+3P8GHIMNQUPp/mVw9ltVIIqWMWbY79BqIaTfbVFnTsrj3
         9muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4Xzmly2VXzYLFnlkqo9YsSvrz1tmikNREb7p3AF7Jgs=;
        b=tmn+ivEC/HEdiI97dIcQDVtW+9PoBLzrlGcDyZnWysH1fTi7i2J3HbwJEy+KmMyx50
         uNljBZiWtKqsPZfy7rkFH0JiptyzQ04U+jxAfNhKqV+mGelunrrcehqt1HGXeZts1uSD
         BFcelyK+6XY61JIXFaKVkmTnz9BSctJgNohyTdOY2WknaTpLX94rGO1+BZjRvMsLR18e
         yVqdxTAg/TZBe/8akSFO45Z15egKWSrjo7DvcCOVrCIoUPO0miH6iy0+JoTkyc2s52ac
         y70zjOa40Fb0+6aAXHUW/ZHHf2mHHYM3yltsHcIVXrZnxejkEtwtpvHQUuzttbgPsqF3
         /6cg==
X-Gm-Message-State: ACgBeo2gW3wdIIlpopgcgrgTse3i86VOjtfHHhjEoVQJTfWfnIRLGanf
        RN2a8flbnCyNRjXwbhKH8+mm7g==
X-Google-Smtp-Source: AA6agR65is+WY116w4cgPNcQhMjv9XUkVK8cVkUJ4Hd3c9Pz3t/b4cfwsmI+bXIfJQQiClEeyGVNdw==
X-Received: by 2002:a5d:588d:0:b0:225:9818:668d with SMTP id n13-20020a5d588d000000b002259818668dmr8714366wrf.100.1661866429233;
        Tue, 30 Aug 2022 06:33:49 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b003a5c064717csm13752196wmq.22.2022.08.30.06.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:33:48 -0700 (PDT)
Message-ID: <016bdefd-ff75-35ca-52a5-0e058e0a5d04@isovalent.com>
Date:   Tue, 30 Aug 2022 14:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for querying cgroup_iter
 link
Content-Language: en-GB
To:     Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
References: <20220829231828.1016835-1-haoluo@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220829231828.1016835-1-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 30/08/2022 00:18, Hao Luo wrote:
> Support dumping info of a cgroup_iter link. This includes
> showing the cgroup's id and the order for walking the cgroup
> hierarchy. Example output is as follows:
> 
>> bpftool link show
> 1: iter  prog 2  target_name bpf_map
> 2: iter  prog 3  target_name bpf_prog
> 3: iter  prog 12  target_name cgroup  cgroup_id 72  order self_only
> 
>> bpftool -p link show
> [{
>         "id": 1,
>         "type": "iter",
>         "prog_id": 2,
>         "target_name": "bpf_map"
>     },{
>         "id": 2,
>         "type": "iter",
>         "prog_id": 3,
>         "target_name": "bpf_prog"
>     },{
>         "id": 3,
>         "type": "iter",
>         "prog_id": 12,
>         "target_name": "cgroup",
>         "cgroup_id": 72,
>         "order": "self_only"
>     }
> ]
> 
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  tools/bpf/bpftool/link.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 7a20931c3250..9e8d14d0114d 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -83,6 +83,29 @@ static bool is_iter_map_target(const char *target_name)
>  	       strcmp(target_name, "bpf_sk_storage_map") == 0;
>  }
>  
> +static bool is_iter_cgroup_target(const char *target_name)
> +{
> +	return strcmp(target_name, "cgroup") == 0;
> +}
> +
> +static const char *cgroup_order_string(__u32 order)
> +{
> +	switch (order) {
> +	case BPF_CGROUP_ITER_ORDER_UNSPEC:
> +		return "order_unspec";
> +	case BPF_CGROUP_ITER_SELF_ONLY:
> +		return "self_only";
> +	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
> +		return "descendants_pre";
> +	case BPF_CGROUP_ITER_DESCENDANTS_POST:
> +		return "descendants_post";
> +	case BPF_CGROUP_ITER_ANCESTORS_UP:
> +		return "ancestors_up";
> +	default: /* won't happen */
> +		return "";

I wonder if that one should be "unknown", in case another option is
added in the future, so we can spot it and address it?

> +	}
> +}
> +
>  static void show_iter_json(struct bpf_link_info *info, json_writer_t *wtr)
>  {
>  	const char *target_name = u64_to_ptr(info->iter.target_name);
> @@ -91,6 +114,12 @@ static void show_iter_json(struct bpf_link_info *info, json_writer_t *wtr)
>  
>  	if (is_iter_map_target(target_name))
>  		jsonw_uint_field(wtr, "map_id", info->iter.map.map_id);
> +
> +	if (is_iter_cgroup_target(target_name)) {
> +		jsonw_lluint_field(wtr, "cgroup_id", info->iter.cgroup.cgroup_id);
> +		jsonw_string_field(wtr, "order",
> +				   cgroup_order_string(info->iter.cgroup.order));
> +	}
>  }
>  
>  static int get_prog_info(int prog_id, struct bpf_prog_info *info)
> @@ -208,6 +237,12 @@ static void show_iter_plain(struct bpf_link_info *info)
>  
>  	if (is_iter_map_target(target_name))
>  		printf("map_id %u  ", info->iter.map.map_id);
> +
> +	if (is_iter_cgroup_target(target_name)) {
> +		printf("cgroup_id %llu  ", info->iter.cgroup.cgroup_id);
> +		printf("order %s  ",
> +		       cgroup_order_string(info->iter.cgroup.order));
> +	}
>  }
>  
>  static int show_link_close_plain(int fd, struct bpf_link_info *info)

Looks good to me, thank you!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

