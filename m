Return-Path: <bpf+bounces-9342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219427941B2
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 18:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CE01C20A4F
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30D10961;
	Wed,  6 Sep 2023 16:51:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057DEDB
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 16:51:17 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5805A199A
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 09:51:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso8025525e9.0
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1694019074; x=1694623874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ejDyG0G8Cg0H0kbIYUw5xAxosbv0Ty12ePHI4DBqLE=;
        b=Et0t2omefLdFBbFoh+urrMc7Cay6PbrYZmyDHirDwMyKgU+cF4yySB2LhyH058Plvm
         pWenPqJgLzajHokn8u5hNjF27rPSVhP8EAGAsLeyK7t3z8TL3z/J01FQWEVcpC8zp/Dd
         wsd7VZkYc/ma/1NjonLf1Jbuao/Gq/hiBvEVjUax258JqUFzLsl963hG9uCEaF8xF9p0
         wLaagv/hQO9xD0PDiGGJYcgMlMxYfGSBmYBx89AqPRzjG5QVenTAmkRk7FRYIbLVG9Gk
         1MuCN34V/HrTcfjsOjw9IsoNGWBYO8JaKql2ceLWpLcYXa6f/BIPUBMlz9aOGLILdTGP
         NXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694019074; x=1694623874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ejDyG0G8Cg0H0kbIYUw5xAxosbv0Ty12ePHI4DBqLE=;
        b=C3MfNfZk//VGOifgQTONqeMDc+4oqa2Ec7kcXCrJmmOPYscUcYj+KRiGvQ1y6vv6Oq
         smMip8WZ8XdK4amNpPwujTtpmank8RGVVl1kPChEqb2F4ao8xNdI90NeUfM52sSFjYQU
         LsYBkDD74J0bP4YzSqs8XXVwaj3D9Hpf/3RPKdqWfFx2ILFrdvM5ja77WR6fnIWeuiiu
         tW/dLwNpcp65me9xWaFEQd6cvmi/iBLe6JMIk9/zLW6pxb5HZTCvJY8KbarGEiVEUc97
         QOPlBhhYOrWgcjA6P3y4KeDUepqFYTCH+7NcjTDBfau//scNutsPRch1kc2pdx173yu2
         6rkQ==
X-Gm-Message-State: AOJu0Yx5rZ0SxwauI4IRCuCRmZgllt5pndksJlzcr30WVf6YxmCF1nbg
	FtJMo4zfrTemUo+qnoQd4lYfZw==
X-Google-Smtp-Source: AGHT+IH+UcjC3sdMaLIkgu5mijqESQ05o18y1EZXbAi39Yh3dsnpKXpeCBq41kgDTp0odEGYJbI0vw==
X-Received: by 2002:adf:ed46:0:b0:319:6b14:555c with SMTP id u6-20020adfed46000000b003196b14555cmr188949wro.3.1694019073663;
        Wed, 06 Sep 2023 09:51:13 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:1b23:31ee:4837:15ce? ([2a02:8011:e80c:0:1b23:31ee:4837:15ce])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b003fee65091fdsm27711wml.40.2023.09.06.09.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 09:51:13 -0700 (PDT)
Message-ID: <3145d302-5ab2-4cd8-974c-6ae1fe436328@isovalent.com>
Date: Wed, 6 Sep 2023 17:51:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: fix -Wcast-qual warning
Content-Language: en-GB
To: Denys Zagorui <dzagorui@cisco.com>, alastorze@fb.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20230906111717.2876511-1-dzagorui@cisco.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230906111717.2876511-1-dzagorui@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/09/2023 12:17, Denys Zagorui wrote:
> This cast was made by purpose for older libbpf where the
> bpf_object_skeleton field is void * instead of const void *
> to eliminte a warning (as i understand

s/eliminte/eliminate/

> -Wincompatible-pointer-types-discards-qualifiers) but this
> cast introduces another warnging (-Wcast-qual) for libbpf

s/warnging/warning/

> where data field is const void *
> 
> It makes sense for bpftool to be in sync with libbpf from
> kernel sources
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/bpf/bpftool/gen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 2883660d6b67..04c47745b3ea 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
>  	codegen("\
>  		\n\
>  									    \n\
> -			s->data = (void *)%2$s__elf_bytes(&s->data_sz);	    \n\
> +			s->data = %2$s__elf_bytes(&s->data_sz);		    \n\
>  									    \n\
>  			obj->skeleton = s;				    \n\
>  			return 0;					    \n\

If I follow correctly, the cast was added in bpftool in a6cc6b34b93e
("bpftool: Provide a helper method for accessing skeleton's embedded ELF
data"), which mentions indeed:

    The assignment to s->data is cast to void * to ensure no warning is
    issued if compiled with a previous version of libbpf where the
    bpf_object_skeleton field is void * instead of const void *

but in libbpf, s->data's type had already been changed since commit
08a6f22ef6f8 ("libbpf: Change bpf_object_skeleton data field to const
pointer"), part of libbpf 0.6, is this correct?

If this is the case then the commit makes sense to me, I think it's OK
to have a warning with libbpf < 1.0 if it helps suppressing one when
loading skeletons with the current version of the lib.

Thanks,
Quentin

