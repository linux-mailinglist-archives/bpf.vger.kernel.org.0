Return-Path: <bpf+bounces-17399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EC180CA4E
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B56C1F211B7
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293783C071;
	Mon, 11 Dec 2023 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuFfpIDE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F869AF
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:56:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c4846847eso7944545e9.1
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702299360; x=1702904160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U7ApvoSsCYqHVwLdXDuGRwWD8jY9JrY8ru0zWAgnE2M=;
        b=MuFfpIDE336ZCaZqS1FHwZWLLreh7c8u7LGEfj2QiUSMldQcaZsqPk/0xOU1cIB1x+
         SF0OowtyKEg9WzmJKogHU6ss42xcbMoBvZ3Ilmsgo36bQ/ZabfGH+9/69lsbMdlJV4wa
         cdmYzh6DwJRcBKsR6nLvvPQqMGu/kdyUb+S2mbtsm8LOwjDYDIzFQgyTc0af+3veKnFu
         5m5VHfwRPCVdl56nh6vXD5P2bb7cpNOq6qaUD4W4iMg2N2B3MN0TdglI/OGWsZX8hT7H
         5oSzR6wM4vO0WN6Bmi5p4YK0b/PER0fKAvyZcyExbUYI/Ct1jU7P9vmXuYKs3HxrZ6Pr
         i98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702299360; x=1702904160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7ApvoSsCYqHVwLdXDuGRwWD8jY9JrY8ru0zWAgnE2M=;
        b=RrEBR3pw+UBN4SiyWB+0e1O+HyAjdHAEi6SVXrvygADyaFZYPOEfSYXArzEnks/+SZ
         jfX17BTgIhIEtI2aEfSrqkhCIxMK55nrcXK3P2awqQ4XmTlJb0OuPb8R3DiFpBRSX7iR
         bhTKVmn75wp/lsghNTMUX2N0HT9rRwshDGBwH/0Uq0qzmKJnJ7MFV9u8kfVwkj7AToSX
         bnYM5UowQriQsdtO25NRI9GxZ6xk7f0cdxFTONf8ldy3WRCvwdnIM0qKkZYg3fUtajK6
         IGMZFoNVIU+bxWei9oby/GDBxmTNyOZzFe4cW0lrPDNnvAGSVPGxqY9QN8HTf36vFWz3
         1eIQ==
X-Gm-Message-State: AOJu0YwP4Fw7SFPj6gbs5hgJV8EpLiz5m8+WgDQskMqfPw8eI+BmW2b/
	t3m34GueQqdWFqh8I03nrHA=
X-Google-Smtp-Source: AGHT+IH5SzG0SYlIHMiEdrLWWnVBqhaCc1VjflqaTxY+6k7qAKMz9mpT7Z0Zg46q7yR3fO+wBTQo2Q==
X-Received: by 2002:a05:600c:2184:b0:40c:2b13:95f8 with SMTP id e4-20020a05600c218400b0040c2b1395f8mr2082963wme.141.1702299360378;
        Mon, 11 Dec 2023 04:56:00 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0040c45cabc34sm4683192wmo.17.2023.12.11.04.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:55:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Dec 2023 13:55:57 +0100
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next 1/4] bpf: Use __GFP_NOWARN for kvcalloc when
 attaching multiple uprobes
Message-ID: <ZXcG3aSs2g_gfw9Z@krava>
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
 <20231211112843.4147157-2-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211112843.4147157-2-houtao@huaweicloud.com>

On Mon, Dec 11, 2023 at 07:28:40PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> An abnormally big cnt may be passed to link_create.uprobe_multi.cnt,
> and it will trigger the following warning in kvmalloc_node():
> 
> 	if (unlikely(size > INT_MAX)) {
> 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> 		return NULL;
> 	}
> 
> Fix the warning by using __GFP_NOWARN when invoking kvzalloc() in
> bpf_uprobe_multi_link_attach().
> 
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Closes: https://lore.kernel.org/bpf/CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  kernel/trace/bpf_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 774cf476a892..07b9b5896d6c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3378,7 +3378,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  	err = -ENOMEM;
>  
>  	link = kzalloc(sizeof(*link), GFP_KERNEL);
> -	uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> +	uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL | __GFP_NOWARN);
>  
>  	if (!uprobes || !link)
>  		goto error_free;
> -- 
> 2.29.2
> 

