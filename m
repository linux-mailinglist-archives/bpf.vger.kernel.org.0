Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C26ED2BE
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjDXQoY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjDXQoY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:44:24 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A11844B1;
        Mon, 24 Apr 2023 09:44:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b980e16b27bso3381109276.2;
        Mon, 24 Apr 2023 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682354662; x=1684946662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKXf0cNAKb6gq2MuqWLjiv+ti6kg7FN3aSwzR4hbx2U=;
        b=nf6rkWdOPXFKzUX3S+iTvB/fe+NaIdyPTHSVP5LFUd/vkq/C8VDwWT44X2xN+QVl7B
         Td3HBvRPpFzSQtkYxIFU96dCOeFvARfnvBtbPAzItZUU9ziRdy3gBowHfqyP13YR/Ajj
         1JjtgILx0J5ltAKj8hT7hYTxXhUcxWWGxc4SqiLNfvDbABVgN37QR4Rq4MWH4iApf8dz
         IQIGwfpKoE8gL/3bphhDgkBS1PhYcDeGEPw2otP234DWXCY0MAle5PDlBPpOer94UUp9
         gEetm8nVe1k/fqy88yh4uHnXZYP64sVB30yeIJlkL5+zMcAK68T5IiDEjS+DJBIde32P
         bTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354662; x=1684946662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKXf0cNAKb6gq2MuqWLjiv+ti6kg7FN3aSwzR4hbx2U=;
        b=W3zGMlSj845JfudNsRUp3pCu56kLF2Jq7OX4wgJPNJTCaQeB6ezIcNjPAYGLHw2yt/
         9QoPtkevLUiDzrNZkc+Z+ZndP+Dy01nEJM77VwT7EwpITDfWRqzA5IWS6KdXLV64/+a4
         65wSSOLyuAgylUEuaqOh+oiTgjmVai3s72Y7r3HlTAd5Il82VQilvC4zDf1+anb9Xnu6
         bbxU/0K3QoMpCTzWqqCpTlm0Rg1fDFxmeTbRWCRUQFbtVKxoFCU3oqOzw4QyJToGCbWg
         Gr+D/dGo2CDI5l5ROlajNvR6wNkWBlcFvfrM0swqmIZvf3emvpvY6X9B67J74yUuv3Xu
         MJWw==
X-Gm-Message-State: AAQBX9e61u2bJAIRtFxo9shzHQUKF0iy9VZgzXGg4SYbteRtlkalU6M1
        b2Pol9XFY3Rg6tH4hAHnBhQ=
X-Google-Smtp-Source: AKy350bDyrtP17MOTW6EJmVaMdUiH/URzoiigdPqpoqt0ErN6nxGBIQhytSuOWM10W2l37Ca0o6iHQ==
X-Received: by 2002:a25:1885:0:b0:b92:3f59:26e with SMTP id 127-20020a251885000000b00b923f59026emr8625058yby.41.1682354662203;
        Mon, 24 Apr 2023 09:44:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:1f41:aa7b:6a04:e9ee? ([2600:1700:6cf8:1240:1f41:aa7b:6a04:e9ee])
        by smtp.gmail.com with ESMTPSA id j1-20020a258b81000000b00b923b9e0a82sm2944946ybl.45.2023.04.24.09.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 09:44:21 -0700 (PDT)
Message-ID: <f804fd67-87a9-4762-7e31-23abacdf6086@gmail.com>
Date:   Mon, 24 Apr 2023 09:44:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2] bpftool: Dump map id instead of value for
 map_of_maps types
Content-Language: en-US
To:     Xueming Feng <kuro@kuroa.me>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424090935.52707-1-kuro@kuroa.me>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230424090935.52707-1-kuro@kuroa.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/24/23 02:09, Xueming Feng wrote:
> When using `bpftool map dump` in plain format, it is usually
> more convenient to show the inner map id instead of raw value.
> Changing this behavior would help with quick debugging with
> `bpftool`, without disrupting scripted behavior. Since user
> could dump the inner map with id, and need to convert value.
> 
> Signed-off-by: Xueming Feng <kuro@kuroa.me>
> ---
> Changes in v2:
>    - Fix commit message grammar.
> 	- Change `print_uint` to only print to stdout, make `arg` const, and rename
> 	  `n` to `arg_size`.
>    - Make `print_uint` able to take any size of argument up to `unsigned long`,
> 		and print it as unsigned decimal.
> 
> Thanks for the review and suggestions! I have changed my patch accordingly.
> There is a possibility that `arg_size` is larger than `unsigned long`,
> but previous review suggested that it should be up to the caller function to
> set `arg_size` correctly. So I didn't add check for that, should I?
> 
>   tools/bpf/bpftool/main.c | 15 +++++++++++++++
>   tools/bpf/bpftool/main.h |  1 +
>   tools/bpf/bpftool/map.c  |  9 +++++++--
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 08d0ac543c67..810c0dc10ecb 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -251,6 +251,21 @@ int detect_common_prefix(const char *arg, ...)
>   	return 0;
>   }
>   
> +void print_uint(const void *arg, unsigned int arg_size)
> +{
> +	const unsigned char *data = arg;
> +	unsigned long val = 0ul;
> +
> +	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +		memcpy(&val, data, arg_size);
> +	#else
> +		memcpy((unsigned char *)&val + sizeof(val) - arg_size,
> +		       data, arg_size);
> +	#endif

Is it possible that arg_size is bigger than sizeof(val)?

> +
> +	fprintf(stdout, "%lu", val);
> +}
> +
>   void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
>   {
>   	unsigned char *data = arg;
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0ef373cef4c7..0de671423431 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
>   
>   bool is_prefix(const char *pfx, const char *str);
>   int detect_common_prefix(const char *arg, ...);
> +void print_uint(const void *arg, unsigned int arg_size);
>   void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
>   void usage(void) __noreturn;
>   
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index aaeb8939e137..f5be4c0564cf 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>   		}
>   
>   		if (info->value_size) {
> -			printf("value:%c", break_names ? '\n' : ' ');
> -			fprint_hex(stdout, value, info->value_size, " ");
> +			if (map_is_map_of_maps(info->type)) {
> +				printf("id:%c", break_names ? '\n' : ' ');
> +				print_uint(value, info->value_size);
> +			} else {
> +				printf("value:%c", break_names ? '\n' : ' ');
> +				fprint_hex(stdout, value, info->value_size, " ");
> +			}
>   		}
>   
>   		printf("\n");
