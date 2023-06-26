Return-Path: <bpf+bounces-3445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0873E116
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB421C20927
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE4A93D;
	Mon, 26 Jun 2023 13:53:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D18F6A
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 13:53:15 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66E7BB
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 06:53:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-991ef0b464cso71143666b.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687787592; x=1690379592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haPLkETrM+ZQUOb9s6tW86VwAXOxjmLfduUvuf7UeTw=;
        b=hSm3KpiiaqwoQNai9AT1mQCASLV9As4eY2ppWqeZdl7uYpHf7ECXFaXIKrFJvkx++c
         pYlCiw6lPrNO7hxRGk8ObSNf01LBEKjPfCUoPBbqd6gkHZJD3EA1XFJi1a+yL0981lX/
         Pf6zmc4Es7W3d8QLuL80aNUA+eVX4QA4+bSkRb5YXJzQIeXaN5w228inaidPOIk8EDsj
         zGccuKiUA67dveaDG44NGjIpAeNjYVwipI+B8XS11axTZLHoQDEDr2ZZYCpSilC731CK
         4A+8DD8qp3rxF7q8bA/isbcdFlFqiD961TESe0a8YdwrNGekC1hxxpY5+BSW00wsjAhK
         vEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787592; x=1690379592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haPLkETrM+ZQUOb9s6tW86VwAXOxjmLfduUvuf7UeTw=;
        b=hLyhlCY98K1iKXWFgGz3yQICcmQMTKcI/B+4Otmf0TaXtjscm2roNDSnXmt3+6+6CB
         9TRnqWNQ7WbtnzmwPQGiiTRT8dYp5bIbWmJpUHyR/5jK0iu/p1GmPQH2drZPBuWm3uoK
         M2PckcOt6MLmjXCAKTIC1NredDWxlrZkDICrj9zCIiyA7T/j69bAeSyrTz/c/NxBe5ES
         2xklfhOaMFLhXiG6hUrW7kKNCIUEWmkFyk546GoI18sCknuwb1obYTBZRuiCFpXuF+b6
         L7UACUh/od1M1nuACZllSic5HaLGvD67DNXGWMCjrAiaDhskm9DAS0SxvJi1j02nVO5u
         bjZQ==
X-Gm-Message-State: AC+VfDw60w2opJqWtpTb5SnUvmYMSTWUXsKsIUKBdAvHmRR6ALwn/07/
	3sQjw//OXejnSnhyYm2pq2s=
X-Google-Smtp-Source: ACHHUZ7Y58IO3zAdst2WkZTs1rBRurUS67g1pirEKRb1BAkvWE1QrrsFx2SoKiivAs80Zi9tipAHUw==
X-Received: by 2002:a17:907:86a0:b0:991:edf7:48e9 with SMTP id qa32-20020a17090786a000b00991edf748e9mr1018763ejc.7.1687787591909;
        Mon, 26 Jun 2023 06:53:11 -0700 (PDT)
Received: from krava (net-93-65-241-219.cust.vodafonedsl.it. [93.65.241.219])
        by smtp.gmail.com with ESMTPSA id bt15-20020a170906b14f00b009887f4e0291sm3279735ejb.27.2023.06.26.06.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 06:53:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 Jun 2023 15:53:08 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: Re: [PATCH] libbpf: kprobe.multi: feedback function counts by kernel
 traced
Message-ID: <ZJmYRMGue8LvvchL@krava>
References: <20230625021816.1734617-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625021816.1734617-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 25, 2023 at 10:18:16AM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> When tracking functions through kprobe.multi, the number of tracked
> functions cannot be directly obtained. Sometimes in order to calculate
> this value, it is necessary to recalculate according to the pattern in
> the program. This is unnecessary. It is calculated by libbpf feedback
> through opts.cnt value, which can save resources. Example at [1].
> 
> [1] https://github.com/JackieLiu1/ketones/blob/master/src/funccount/funccount.c#L317
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 3 ++-
>  tools/lib/bpf/libbpf.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fca5d2e412c5..ed3f1202c570 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10506,7 +10506,7 @@ static void kprobe_multi_resolve_reinit(struct kprobe_multi_resolve *res)
>  struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  				      const char *pattern,
> -				      const struct bpf_kprobe_multi_opts *opts)
> +				      struct bpf_kprobe_multi_opts *opts)
>  {
>  	LIBBPF_OPTS(bpf_link_create_opts, lopts);
>  	struct kprobe_multi_resolve res = {
> @@ -10582,6 +10582,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  	}
>  	link->fd = link_fd;
>  	free(res.addrs);
> +	OPTS_SET(opts, cnt, res.cnt);

hum I'm not sure it's good idea to use opts for output values

there's ongoing patchset adding possibility to get this
info/value via BPF_OBJ_GET_INFO_BY_FD syscall [1]

jirka

[1] https://lore.kernel.org/bpf/20230623141546.3751-1-laoar.shao@gmail.com/

>  	return link;
>  
>  error:
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 0b7362397ea3..f860dacc6add 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -527,7 +527,7 @@ struct bpf_kprobe_multi_opts {
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  				      const char *pattern,
> -				      const struct bpf_kprobe_multi_opts *opts);
> +				      struct bpf_kprobe_multi_opts *opts);
>  
>  struct bpf_ksyscall_opts {
>  	/* size of this struct, for forward/backward compatibility */
> -- 
> 2.25.1
> 

