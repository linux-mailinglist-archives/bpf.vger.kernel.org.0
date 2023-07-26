Return-Path: <bpf+bounces-5926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4FF76331A
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 12:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8803B1C211AB
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B0ABE60;
	Wed, 26 Jul 2023 10:04:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADCBE4F
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 10:04:16 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8045CA2;
	Wed, 26 Jul 2023 03:04:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98377c5d53eso1031182766b.0;
        Wed, 26 Jul 2023 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690365852; x=1690970652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MCuWwaZ7TdF8D1Ie2goQfYf55lAVpjlrYTzYjccrw34=;
        b=diGBCz7oPf/bDJ9aDchYTrXPDvcoT+0ZAgZe6yQUBL1994yphP7MwObibIOrMc4qOx
         P0fnFQi8vWVo84qxQ+dqclp4Vy3VwvMb5JV+3OuXbJQA0wdrcMKZuQuzo5ZN6w9oGl8H
         XWO0CUeTDsk9VHyMIkagkaEhwTrb9SHOcbhGRi9DRIz9l60f85aEmI98F+urZ6y2Xj8F
         wQKu299+iZuZczWht5WjbjX6wLJfwyAK/Qhs0NdTozeza7Ou7kOoHKu7zO5ug4Zxookx
         ZE7/JVIC2dF0zqLrGl38SjvIYWGwbSjtbzCOZU73w8t/ozvvN+3wuWcxkO7eVmuRFxLP
         yvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690365852; x=1690970652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCuWwaZ7TdF8D1Ie2goQfYf55lAVpjlrYTzYjccrw34=;
        b=FdGYj9nzWRWp51UTSzLh978XgNZFRoFsmJ+HaVW1GIvvw+y6hgwOQiBR64OJdZf/IA
         A9TE+YlE8FcmWhugoOHlZDAZrR1MDW+eb5WQOJulr2K+LvyHNirkM+pryCqxL983RwH8
         NYDeh+RHQkV53oemKhnJOjq7qDoNiR6aGF9OEF/44lhOpIdtjnspyt/96A+SkuLBn7sX
         kSREmQhLoNtryhgjx2mgZNixdhIHeKqhefrkAyvMS780jcQk209PnrwOZdtQJ9+NkwiB
         RlQCA/AsTGsij29vaVFPSMyIf7YO+qS9WttmpeN7iqEan3MzY6OsANBoesbRVWmllrrA
         U1oQ==
X-Gm-Message-State: ABy/qLZQuImoVUdIRRh9UsR2CQPZfmsZvKOpDVrX8wbaTmfdpFfxptsT
	mX5N7h1I9pby+kMWBFHRxFMc5NWf0iE=
X-Google-Smtp-Source: APBJJlFg45KuD2tCJFGPOvHDAH1FlWJ/V7VrrhZB2VnHoepTjgimdn+mEmnKL8WbmP2lELLSHCifHA==
X-Received: by 2002:a17:906:539a:b0:994:5396:e32c with SMTP id g26-20020a170906539a00b009945396e32cmr1233328ejo.3.1690365851680;
        Wed, 26 Jul 2023 03:04:11 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id re2-20020a170906d8c200b0098e78ff1a87sm9363918ejb.120.2023.07.26.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 03:04:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Jul 2023 12:04:08 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Yonghong Song <yhs@fb.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Message-ID: <ZMDvmLdZSLi2QqB+@krava>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 10:25:34AM +0900, Masami Hiramatsu wrote:
> Hello,
> (I resend this because kconfig was too big)
> 
> I found that BTF is not generated for gcc-built kernel with that latest
> pahole (v1.25).

hi,
I can't reproduce on my setup with your .config

does 'bpftool btf dump file ./vmlinux' show any error?

is there any error in the kernel build output?

> When I'm using the distro origin pahole (v1.22) it works. (I also checked
> v1.23 and v1.24, both partially generated BTF)
> 
> e.g.
> 
> # echo 'f kfree $arg*' >> /sys/kernel/tracing/dynamic_events
> sh: write error: Invalid argument
> 
> # cat /sys/kernel/tracing/error_log 
> [   21.595724] trace_fprobe: error: BTF is not available or not supported
>   Command: f kfree $arg*
>                    ^
> [   21.596032] trace_fprobe: error: Invalid $-valiable specified
>   Command: f kfree $arg*
>                    ^
> 
> / # strings /sys/kernel/btf/vmlinux | grep kfree

hm, if you have this file present, you have BTF in

> kfree_on_online
> maybe_kfree_parameter
> trace_event_raw_rcu_invoke_kfree_bulk_callback
> trace_event_data_offsets_rcu_invoke_kfree_bulk_callback
> btf_trace_rcu_invoke_kfree_bulk_callback
> early_boot_kfree_rcu
> __bpf_trace_rcu_invoke_kfree_bulk_callback
> perf_trace_rcu_invoke_kfree_bulk_callback
> trace_event_raw_event_rcu_invoke_kfree_bulk_callback
> trace_raw_output_rcu_invoke_kfree_bulk_callback
> __probestub_rcu_invoke_kfree_bulk_callback
> __traceiter_rcu_invoke_kfree_bulk_callback
> kfree_rcu_cpu_work
> kfree_rcu_cpu
> kfree_rcu_batch_init
> kfree_rcu_scheduler_running
> kfree_rcu_shrink_scan
> kfree_rcu_shrink_count
> kfree_rcu_monitor
> kfree_rcu_work
> 
> 
> Here is the gcc version which I'm using.
> 
> gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04.1)

I tried with gcc (GCC) 13.1.1 20230614 (Red Hat 13.1.1-4)
and latest pahole (master branch)

> 
> I also attached the kernel config file.
> 
> What is the recommended combination of the tools?
> Should I use Clang to build the kernel for BTF?

should work fine with both gcc and clang

jirka

> 
> Thank you,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



