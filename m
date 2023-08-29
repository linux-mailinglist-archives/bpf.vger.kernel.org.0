Return-Path: <bpf+bounces-8928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A297578C9CD
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 18:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C572281243
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2577917AB2;
	Tue, 29 Aug 2023 16:42:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A8156E9
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 16:42:53 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6CD19A
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 09:42:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50078e52537so7143180e87.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693327370; x=1693932170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBhVN52GjQ3Wc5CaihQFAXZivJOduc6K1vFjB58b7SM=;
        b=aYg9Afk/pRDHGOxfyXahAVB0Z5KWhXFxvjajAJMC0xzJStBIg32NrQ1gS9BLlZy/ly
         OPBiR+UDJ0x660gjUCIkFiWI9sgP2Va+4Thd2XFA7VcHL0CGYEeZ9d+0iVhNOKt/SH8a
         odp2lT6OaHBVSjB0ApFuqGP/B3uTJET6RZ+vV65RDsP7WOnSK0C5Nmz1dxFrCTv6SYra
         cRBzlJd/F6gzY5Xc/AuxDPbSau4mIOzcZNx4CZgE73QNDYXgm57ifhkA30bDKqFqnsq/
         B10Nd1PhTaw8XpzXjlfGDZmoHs63BdL4R5LJdC6+ePjwVbogNmbm0CZrmlMtm9SejwP5
         Hvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327370; x=1693932170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBhVN52GjQ3Wc5CaihQFAXZivJOduc6K1vFjB58b7SM=;
        b=LOhpfa1xhYyjCOyFcvmZtOHxUsF0myrOgWGB5LSjWhktKdCrt8ByS7n+qZ1Y4RRlsl
         n9kxWUlNNaqaFfXNDhsDi2gZtcl52yjyTMStpflRyUFDE0gEWEbVtFtw3P8EO4AEpQaN
         6VPy0KNDA7HV9nRto1hIyymu156vCi13CnXbO/C1hKmkq45mDhhdSHTxgmvdZF0Eqo5a
         I6fxRlQ3pnboY10aKVf0Gd9ofvWGGLw8ueYMxapaUvChGpueG3HfX9D5Suus+0Y5lu44
         AA4wmcof7C/KjdC+N/d4SOX3DgeoAVM4HDjuDHjrKNtr42oOt+NKzl/ynOBiFxN6Q8Gh
         DeBw==
X-Gm-Message-State: AOJu0YwVcvOmZIyc/R04VfYJ28rXzkMQDjI1C813MTUiJEWgdq2Wu7G1
	+IpWsgFWQZTINshQN/IZRRu9pg==
X-Google-Smtp-Source: AGHT+IHaVdIw2ZIwTKyxmgbCm32ruisnb+G1NRZk1+pUcxXzFy2/9PVWOupoxR4GiwwXMw/H7FNbQw==
X-Received: by 2002:a05:6512:3613:b0:500:8c19:d8c6 with SMTP id f19-20020a056512361300b005008c19d8c6mr14988217lfs.58.1693327370439;
        Tue, 29 Aug 2023 09:42:50 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:716a:ac4c:a6ab:1706? ([2a02:8011:e80c:0:716a:ac4c:a6ab:1706])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c00c200b003fe17901fcdsm17623300wmm.32.2023.08.29.09.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:42:50 -0700 (PDT)
Message-ID: <1524610f-547d-48f6-bc71-671357e32ff3@isovalent.com>
Date: Tue, 29 Aug 2023 17:42:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 10/12] bpftool: Display missed count for kprobe
 perf link
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Hou Tao <houtao1@huawei.com>, Daniel Xu <dxu@dxuuu.xyz>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-11-jolsa@kernel.org>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230828075537.194192-11-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/08/2023 08:55, Jiri Olsa wrote:
> Adding 'missed' field to display missed counts for kprobes
> attached by perf event link, like:
> 
>   # bpftool link
>   5: perf_event  prog 82
>           kprobe ffffffff815203e0 ksys_write
>   6: perf_event  prog 83
>           kprobe ffffffff811d1e50 scheduler_tick missed 682217
> 
>   # bpftool link -jp
>   [{
>           "id": 5,
>           "type": "perf_event",
>           "prog_id": 82,
>           "retprobe": false,
>           "addr": 18446744071584220128,
>           "func": "ksys_write",
>           "offset": 0,
>           "missed": 0
>       },{
>           "id": 6,
>           "type": "perf_event",
>           "prog_id": 83,
>           "retprobe": false,
>           "addr": 18446744071580753488,
>           "func": "scheduler_tick",
>           "offset": 0,
>           "missed": 693469
>       }
>   ]
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/link.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 7387e51a5e5c..d65129318f82 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -302,6 +302,7 @@ show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
>  	jsonw_string_field(wtr, "func",
>  			   u64_to_ptr(info->perf_event.kprobe.func_name));
>  	jsonw_uint_field(wtr, "offset", info->perf_event.kprobe.offset);
> +	jsonw_uint_field(wtr, "missed", info->perf_event.kprobe.missed);
>  }
>  
>  static void
> @@ -686,6 +687,8 @@ static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
>  	printf("%s", buf);
>  	if (info->perf_event.kprobe.offset)
>  		printf("+%#x", info->perf_event.kprobe.offset);
> +	if (info->perf_event.kprobe.missed)
> +		printf(" missed %llu", info->perf_event.kprobe.missed);
>  	printf("  ");
>  }
>  

Same comment as for the previous patch: double space between fields in
plain output please. Thanks!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

