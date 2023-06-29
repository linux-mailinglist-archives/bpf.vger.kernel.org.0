Return-Path: <bpf+bounces-3739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7053E742816
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC2A1C20993
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01652125D3;
	Thu, 29 Jun 2023 14:16:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B8290C
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 14:16:15 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7DA3A98
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 07:16:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so3240165e9.2
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688048172; x=1690640172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnggJLEooORauNWD67oJF7JXQHMI9K9YXdX6F/RZOJQ=;
        b=g5gk0C/ZKz2hpVxU4SCX4GicxiqzLgMCXTWdMdOKuXsUt5945XeIuNVEkYZtg9oiTm
         kSj2LHSOWjDAVmttyzJ1RBJxlTDOX1Qfuaz3mUkRt2GVpeMg8tRhqcGuVQSo3ERj1mWX
         1jWPrlyjjzSSn7KW/RXp8pqUD8RiUixgd8I8+Q8KKH44sdjhjLdbzaKJpRBYG1tTCu/f
         CAAD/ADs0ea21W4H+VYlT6isugQvrWbpfwxgtDG06YHSIlxmR1yyhe4drTQZDoxZUgjj
         4s7DQTEK/pLAJo4DBS/L/XR+kUdpMRbDkFWzRXxKKMxkbvQ9x9KDwQDf3q40psTWUDtB
         dBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688048172; x=1690640172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnggJLEooORauNWD67oJF7JXQHMI9K9YXdX6F/RZOJQ=;
        b=eOCvHQXDjXds/5cB3WxYtj4T8iwuEQVnrp1fBBHtdG1aC5nZn77eXx6LgwJ0dFubcH
         EGhXrAMUEvYvV14YYeLiByjt3UQ2Dqx6HgGGKaoicYtKPl0S1rbW+dyROtAxs/lI4kQy
         SGevvC3qsKS95wPAKfD/lZpPcLdwmAGHmKzDnjWryABsx/PQIQ0sf5wpoqgk1CtL6i+E
         8tTwetXyNV/8uDO/+jiLtISU2vF6jMSSU35qJ6u7ykdj80iY9FZYYdKVDTk7qKakoVfu
         H9+tgACU7XTvQuNkxRapPtBKV6aFaX3KP0eLUjScyMosmgcGm04Jw5A72HjBOz0/cZsE
         uzJQ==
X-Gm-Message-State: AC+VfDxco9AL/f5cUYad3Uo84CNDGgZ0VEx4E7vvuwnVGJx5dJEN0XlH
	nSg8Y3yIsjeaBXA+kCH/YX/Zdw==
X-Google-Smtp-Source: ACHHUZ7yE4qOZ9diD0gbwmgOP06bfaMhc7JaUDstQlcDjiXZgdxrPh9h1yxzWEBCB/UurYD7fCA5WQ==
X-Received: by 2002:adf:f98c:0:b0:313:f5fd:62af with SMTP id f12-20020adff98c000000b00313f5fd62afmr8264285wrr.18.1688048171855;
        Thu, 29 Jun 2023 07:16:11 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:48c4:4b87:cc05:b4fb? ([2a02:8011:e80c:0:48c4:4b87:cc05:b4fb])
        by smtp.gmail.com with ESMTPSA id u18-20020adfeb52000000b003113943bb66sm15910802wrn.110.2023.06.29.07.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 07:16:11 -0700 (PDT)
Message-ID: <37060d32-3f4f-f524-5e52-ec9ec066915a@isovalent.com>
Date: Thu, 29 Jun 2023 15:16:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 7/9] bpftool: add BTF dump "format meta" to
 dump header/metadata
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-8-alan.maguire@oracle.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230616171728.530116-8-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks Alan, and apologies for the late review!

2023-06-16 18:17 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> Provide a way to dump BTF metadata info via bpftool; this
> consists of BTF size, header fields and kind layout info
> (if available); for example
> 
> $ bpftool btf dump file vmlinux format meta
> size 4966513   
> magic 0xeb9f      
> version 1         
> flags 0x0         
> hdr_len 24        
> type_len 2929900   
> type_off 0         
> str_len 2036589   
> str_off 2929900   
> 
> ...or for vmlinux with kind layout, crc:
> 
> $ bpftool btf dump file vmlinux format meta
> size 5034496   
> magic 0xeb9f      
> version 1         
> flags 0x1         
> hdr_len 40        
> type_len 2973628   
> type_off 0         
> str_len 2060745   
> str_off 2973628   
> kind_layout_len 80        
> kind_layout_off 5034376   
> crc 0xb6a5171f  
> base_crc 0x0         
> kind 0    flags 0x0    info_sz 0    elem_sz 0   
> kind 1    flags 0x0    info_sz 4    elem_sz 0   
> kind 2    flags 0x0    info_sz 0    elem_sz 0   
> kind 3    flags 0x0    info_sz 12   elem_sz 0   
> kind 4    flags 0x0    info_sz 0    elem_sz 12
> ...
> 
> JSON output is also supported:
> 
> $ bpftool -j btf dump file vmlinux format meta
> {"size":4904369,{"header":"magic":60319,"version":1,"flags":0,"hdr_len":24,"type_len":2893508,"type_off":0,"str_len":2010837,"str_off":2893508}}

This is not valid JSON. I suspect that instead of:

	{"size":4904369,{"header":"magic":60319, ...

you meant the following?:

	{"size":4904369,"header":{"magic":60319,

Could you please also provide a JSON example with the kind_layouts?

> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>  tools/bpf/bpftool/btf.c                   | 93 ++++++++++++++++++++++-
>  2 files changed, 92 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 085bf18f3659..4c186d4efb35 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -937,7 +937,7 @@ _bpftool()
>                              return 0
>                              ;;
>                          format)
> -                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
> +                            COMPREPLY=( $( compgen -W "c raw meta" -- "$cur" ) )
>                              ;;
>                          *)
>                              # emit extra options
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..56f40adcc161 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -504,6 +504,90 @@ static int dump_btf_c(const struct btf *btf,
>  	return err;
>  }
>  
> +static int dump_btf_meta(const struct btf *btf)
> +{
> +	const struct btf_header *hdr;
> +	const struct btf_kind_layout *k;
> +	const void *data;
> +	__u32 data_sz;
> +	__u8 i, nr_kinds;
> +
> +	data = btf__raw_data(btf, &data_sz);
> +	if (!data)
> +		return -ENOMEM;
> +	hdr = data;
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);   /* btf metadata object */
> +		jsonw_uint_field(json_wtr, "size", data_sz);
> +		jsonw_start_object(json_wtr);

... /* header object */

> +		jsonw_name(json_wtr, "header");

I think we need to swap the above two lines to fix the JSON.

> +		jsonw_uint_field(json_wtr, "magic", hdr->magic);
> +		jsonw_uint_field(json_wtr, "version", hdr->version);
> +		jsonw_uint_field(json_wtr, "flags", hdr->flags);
> +		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
> +		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
> +		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
> +		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
> +		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
> +	} else {
> +		printf("size %-10d\n", data_sz);
> +		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10d\n",
> +		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
> +		printf("type_len %-10d\ntype_off %-10d\n", hdr->type_len, hdr->type_off);
> +		printf("str_len %-10d\nstr_off %-10d\n", hdr->str_len, hdr->str_off);
> +	}
> +
> +	if (hdr->hdr_len < sizeof(struct btf_header) ||
> +	    hdr->kind_layout_len == 0 || hdr->kind_layout_len == 0) {
> +		if (json_output) {
> +			jsonw_end_object(json_wtr); /* header object */
> +			jsonw_end_object(json_wtr); /* metadata object */
> +		}
> +		return 0;
> +	}
> +
> +	if (json_output) {
> +		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len);
> +		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_off);
> +		jsonw_uint_field(json_wtr, "crc", hdr->crc);
> +		jsonw_uint_field(json_wtr, "base_crc", hdr->base_crc);
> +		jsonw_end_object(json_wtr); /* end header object */
> +
> +		jsonw_start_object(json_wtr);
> +		jsonw_name(json_wtr, "kind_layouts");

It seems to me we have the same JSON error here as for the header.

> +		jsonw_start_array(json_wtr);
> +	} else {
> +		printf("kind_layout_len %-10d\nkind_layout_off %-10d\n",
> +		       hdr->kind_layout_len, hdr->kind_layout_off);
> +		printf("crc 0x%-10x\nbase_crc 0x%-10x\n",
> +		       hdr->crc, hdr->base_crc);
> +	}
> +
> +	k = (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
> +	nr_kinds = hdr->kind_layout_len / sizeof(*k);
> +	for (i = 0; i < nr_kinds; i++) {
> +		if (json_output) {
> +			jsonw_start_object(json_wtr);
> +			jsonw_name(json_wtr, "kind_layout");

And here?

> +			jsonw_uint_field(json_wtr, "kind", i);
> +			jsonw_uint_field(json_wtr, "flags", k[i].flags);
> +			jsonw_uint_field(json_wtr, "info_sz", k[i].info_sz);
> +			jsonw_uint_field(json_wtr, "elem_sz", k[i].elem_sz);
> +			jsonw_end_object(json_wtr);
> +		} else {
> +			printf("kind %-4d flags 0x%-4x info_sz %-4d elem_sz %-4d\n",
> +			       i, k[i].flags, k[i].info_sz, k[i].elem_sz);
> +		}
> +	}
> +	if (json_output) {
> +		jsonw_end_array(json_wtr);
> +		jsonw_end_object(json_wtr); /* end kind layout */
> +		jsonw_end_object(json_wtr); /* end metadata object */
> +	}
> +
> +	return 0;
> +}
> +

There's a number of locations where we split between two functions for
JSON and plain output, for better clarity. So we could have
dump_btf_meta_plain() and dump_btf_meta_json(). I think it would be
easier to read, but don't feel strongly so also OK if you prefer to keep
the current form to avoid duplicating the logics.

Thanks for adding all those items I asked on v1!

