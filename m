Return-Path: <bpf+bounces-8927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF278C9C9
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 18:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBE528102D
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 16:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5C517AA5;
	Tue, 29 Aug 2023 16:41:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB08156E9
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 16:41:02 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033CD185
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 09:41:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1663186f8f.0
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693327259; x=1693932059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flIyU5+ekSCGeJ0Sn30AlMcV2ygjAmhzNfNnvismiAM=;
        b=TXt7J3msfrj3IURs/h14nBGcuwhfgsoPuF1Su+YgVlXEyw+gyMUmcOeq53eE7f6zfM
         uO7cXMaZgiRsiZRQs7Bdl0ZHjgv4p97OZNthom2aXzTFDK+KY4b0ygD5PFxVNpmpq+H/
         cbxYNla3f8JUv3QY9gDp+SA8vyKOUEyP+ReZ5d23WS8nWN3DXsUZCT9EwrS0SOkdYlEC
         Sb6iuZ5Lmtc8C2nHQta0HfpiEANAf6ctWBe9NEATYPnuUUvwwPshEklAO+j1elucFfGe
         Fnf5qWjrlGhDnFNxc/799dYApfV8tmkjga+9d3+3OrYrrgXlzQ4w6oqKcX1IEjv3vmBd
         kazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327259; x=1693932059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flIyU5+ekSCGeJ0Sn30AlMcV2ygjAmhzNfNnvismiAM=;
        b=OjbjhVPG0elr5syOlHeme2kCtqbNlIg7IML8hQH5WYFYB8uw+CxIbpPisab8u3KuLy
         5UhoTf/gnWsWzJdA7zvRMr2dZS3Mbj0OH/GMEVGMydPVGT9qPFHNNazmU2Mt0flhOgTc
         MayzG7MzTog3pz0vklXUkanG8QWQAPhkgLwKt9EVEA3QsISY7bCsnM10WVtS5U3ilu7V
         1JwQbpq0HejLBO5QvP631VWJRX9ga7lcxTY7cI/7pImtNZrAtHF8RFN3gCnQppEK8/3Z
         j2pss44gs4M0K4oMTE/WyQhuWoil7uA90RxwYKf++UonN52oYMkATZZHgTIB2OyGGfEr
         2+bQ==
X-Gm-Message-State: AOJu0Yz1hA83Jhhzef/1Y3/0cloTiazJkTuhUDbKmERvaCM2TYfK7Ytn
	w3mfX56h8326S4IEEC+jGiBaPQ==
X-Google-Smtp-Source: AGHT+IEut/xfV60rimQiS5teuoaes6TdQJNPcCtV+4JDEcpkWw/tq36bRXyjs4m11r1w2VTL1580dg==
X-Received: by 2002:adf:ee41:0:b0:317:6220:ac13 with SMTP id w1-20020adfee41000000b003176220ac13mr21792132wro.32.1693327259423;
        Tue, 29 Aug 2023 09:40:59 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:716a:ac4c:a6ab:1706? ([2a02:8011:e80c:0:716a:ac4c:a6ab:1706])
        by smtp.gmail.com with ESMTPSA id q9-20020adfea09000000b0031c5ee51638sm14241985wrm.109.2023.08.29.09.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:40:58 -0700 (PDT)
Message-ID: <26a20b9f-839a-4748-9cf4-4eac1e46ce00@isovalent.com>
Date: Tue, 29 Aug 2023 17:40:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 09/12] bpftool: Display missed count for
 kprobe_multi link
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Hou Tao <houtao1@huawei.com>, Daniel Xu <dxu@dxuuu.xyz>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-10-jolsa@kernel.org>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230828075537.194192-10-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/08/2023 08:55, Jiri Olsa wrote:
> Adding 'missed' field to display missed counts for kprobes
> attached by kprobe multi link, like:
> 
>   # bpftool link
>   5: kprobe_multi  prog 76
>           kprobe.multi  func_cnt 1 missed 1
>           addr             func [module]
>           ffffffffa039c030 fp3_test [fprobe_test]
> 
>   # bpftool link -jp
>   [{
>           "id": 5,
>           "type": "kprobe_multi",
>           "prog_id": 76,
>           "retprobe": false,
>           "func_cnt": 1,
>           "missed": 1,
>           "funcs": [{
>                   "addr": 18446744072102723632,
>                   "func": "fp3_test",
>                   "module": "fprobe_test"
>               }
>           ]
>       }
>   ]
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/link.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 0b214f6ab5c8..7387e51a5e5c 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -265,6 +265,7 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  	jsonw_bool_field(json_wtr, "retprobe",
>  			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);
>  	jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
> +	jsonw_uint_field(json_wtr, "missed", info->kprobe_multi.missed);
>  	jsonw_name(json_wtr, "funcs");
>  	jsonw_start_array(json_wtr);
>  	addrs = u64_to_ptr(info->kprobe_multi.addrs);
> @@ -640,7 +641,9 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>  		printf("\n\tkretprobe.multi  ");
>  	else
>  		printf("\n\tkprobe.multi  ");
> -	printf("func_cnt %u  ", info->kprobe_multi.count);
> +	printf("func_cnt %u", info->kprobe_multi.count);
> +	if (info->kprobe_multi.missed)
> +		printf(" missed %llu", info->kprobe_multi.missed);

Nit: If you respin, please conserve the double space at the beginning of
"  missed %llu", to visually help separate from the previous field in
the plain output.

Looks good otherwise, thanks!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

>  	addrs = (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
>  	qsort(addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
>  


