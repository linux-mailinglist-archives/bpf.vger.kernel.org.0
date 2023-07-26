Return-Path: <bpf+bounces-5914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C8762F0F
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091F22819E3
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5EA925;
	Wed, 26 Jul 2023 08:02:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0B9469
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 08:02:20 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F20C6E82;
	Wed, 26 Jul 2023 01:02:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-986d8332f50so995466466b.0;
        Wed, 26 Jul 2023 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690358525; x=1690963325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxYHfTTWC0VbYCKBrhIb3PnqWpEpbOJPVI+cSJ6lXqM=;
        b=XdoFUAw4biFlh1aW9Tx8YK5TjLabaDk3jclus9v8TlRqMpnmddMDVaohw3/vXv2Ili
         1GQpj46+WdIQ8EP74ir6gi8o1fAereonW5jeNJdztHcyKygh+HbgXqIcusFT7QMCsXRc
         FOaZiZrgnG+oTe5dC+Dz/008dsk9vkCMRDN9gz+Q7HgXqzLljN5oohw4x8ZrMcDhwveS
         jhTJBioXifHwn9xyNmUHnvU52uC6DheA96xWi8rdeK5XxNZtD4AT39gH59/Q5rr6UF8F
         PkP2mm7W+/NO/6h+WIo0REDSbwwaKN7PVR+bVaRO7Nu0mOw4GrpsaFlNCPukWgpenD0E
         2tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358525; x=1690963325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxYHfTTWC0VbYCKBrhIb3PnqWpEpbOJPVI+cSJ6lXqM=;
        b=hRAdltGW+HhlcSc3+zvzQon6UXMQxt02Cvh0bsygHMraXxTLwAT9Wy1I5+JvfuB0Xm
         lsLqR8QVRCzqR0wQ7yed4v7Mm5qAt6p3eIyhY4BdsH4p58EYhj39XH9T8UYZLaavTfPs
         P66uJuYkElajLdUEHzlYdqk5g7WyV4C/t5eLXeCIW9KGGSegExm0hNkT26pv+Cjpnl82
         IaVWHDn/BfK2j2erGbmz7MCNs8A2yQsvr1GpbJ1VXxUquJqqbMvhjPKh0aWDFhCQatmP
         s+qRT2s677byKSahudsi5QuZXtM2Nsg79S7LwEVdfMn4wDeBsUzjHfeg9WSEcOGiq9mu
         T/iw==
X-Gm-Message-State: ABy/qLbFTvppYnmundEe6vizcP3Ag2vorDINAWG+y1oUHkQGFuiAbaG9
	naDj7GTS40qOp3zJvpAwkSc=
X-Google-Smtp-Source: APBJJlH5CXkcSv884ZCnEtxbnf11x/Lo3BDZrMn4lSL1x/rqyUTcQXo4W3Zx/wkfE/GJRI2vqxbPhA==
X-Received: by 2002:a17:906:5396:b0:993:f6c8:300f with SMTP id g22-20020a170906539600b00993f6c8300fmr1010800ejo.15.1690358524845;
        Wed, 26 Jul 2023 01:02:04 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id lg23-20020a170906f89700b0098733a40bb7sm9314330ejb.155.2023.07.26.01.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 01:02:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Jul 2023 10:02:02 +0200
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] kallsyms: rework symbol lookup return codes
Message-ID: <ZMDS+lM/V5t1qD0D@krava>
References: <20230724135327.1173309-1-arnd@kernel.org>
 <20230724135327.1173309-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724135327.1173309-2-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 03:53:02PM +0200, Arnd Bergmann wrote:

SNIP

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 05c0024815bf9..bc0eed24a5873 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6965,7 +6965,7 @@ allocate_ftrace_mod_map(struct module *mod,
>  	return mod_map;
>  }
>  
> -static const char *
> +static int
>  ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>  			   unsigned long addr, unsigned long *size,
>  			   unsigned long *off, char *sym)
> @@ -6986,21 +6986,18 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>  			*size = found_func->size;
>  		if (off)
>  			*off = addr - found_func->ip;
> -		if (sym)
> -			strscpy(sym, found_func->name, KSYM_NAME_LEN);
> -
> -		return found_func->name;
> +		return strlcpy(sym, found_func->name, KSYM_NAME_LEN);

hi,
any reason not to call the original strscpy in here?

jirka

>  	}
>  
> -	return NULL;
> +	return 0;
>  }
>  
> -const char *
> +int
>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
>  		   unsigned long *off, char **modname, char *sym)
>  {
>  	struct ftrace_mod_map *mod_map;
> -	const char *ret = NULL;
> +	int ret;
>  
>  	/* mod_map is freed via call_rcu() */
>  	preempt_disable();
> -- 
> 2.39.2
> 

