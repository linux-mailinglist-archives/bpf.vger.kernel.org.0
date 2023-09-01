Return-Path: <bpf+bounces-9115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D572578FEB1
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 16:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0264F1C20D0A
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A1BE7E;
	Fri,  1 Sep 2023 14:02:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B5BE6E
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 14:02:08 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4D510EB
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 07:02:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52bca2e8563so2547389a12.2
        for <bpf@vger.kernel.org>; Fri, 01 Sep 2023 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693576925; x=1694181725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EGHyFIQOIEK13YMhIl8MMpxRDhJLEgOrc3ojqV/pZ3o=;
        b=gzJpFS7S1VzGFKa2IkT3hU6fwNA2Vtyfgork/TklCU5MmAYoy8osF2xNRUEtlWQjUs
         GKz8DjQg8UP1O5Vzvd5xLH+7b7p6oemp1Jll4zjyOsF7jcmF84w/ZoyToCKw5irShkR4
         zeWso/pVvLqDNP53gxYMp7vL2QJa4q5ANv5ODrUd4Tbq5MAM73A7d4Yzit0lzqgaM3NZ
         bv0TonvFIU0oh/h9yZk+vmGdYBN5v5VGnG5wZjnlLxaY+wRRbVUr3xMUyKQN4D93hjjB
         gbzyltWg9CHkYZFoqh6BfdDBEylFCrdCtnCnsfe8/BRV/61RknwOzSUjEmsY92yoxHnt
         RfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693576925; x=1694181725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGHyFIQOIEK13YMhIl8MMpxRDhJLEgOrc3ojqV/pZ3o=;
        b=M57I7WO6v6wdq2uPDh/iJxYMqys/Gl7hL+mhXly0ULjMyBRnwZVUjEwRrnOrx0yQs2
         f6w2lzXsnNQw6tSaiQKFu/x7rbNLGbQzPmPKGKnUpCVMdCukC/jkr5R5OUPv2ljUhp76
         IM0HO/72d38qinTP2M+dCT2zPSFLWjPURe1PLzua4C3/eooSCc5VIUYVbe6F5fDYCL2C
         NOWwyOEmEaHHNKFsd0bm5oNrbD7ow8V4TuQXeHXp/ovTrOjvLkOlv0dakheJRNH0NcNe
         VqKZPJPruN6zBWPO2bVLsfU23L2vMEWi3qAmqghbRA757YbBKAb543pluVvnWrWp3NbG
         Meww==
X-Gm-Message-State: AOJu0YzzpLV09O31GHi/cTQOcsJ1z0hBXn1v6GpaxTt3uQoaLUzKjUij
	TUxr28CFvSV2I3AbmCzR4WYHzcH3T9Ff6A==
X-Google-Smtp-Source: AGHT+IFpe6IEOva7s7Gu19lFuvU9SNWBSY/8+6Jmcf605t7C7mx0x+Vi9slmkqndRKXoQYOqPSY1RQ==
X-Received: by 2002:aa7:da45:0:b0:523:c19d:a521 with SMTP id w5-20020aa7da45000000b00523c19da521mr1935944eds.40.1693576924011;
        Fri, 01 Sep 2023 07:02:04 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v23-20020aa7d817000000b00521f4ee396fsm2107277edq.12.2023.09.01.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:02:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Sep 2023 16:02:00 +0200
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Kui-Feng Lee <kuifeng@fb.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] bpf: Invoke __bpf_prog_exit_sleepable_recur() on
 recursion in kern_sys_bpf().
Message-ID: <ZPHu2OeYCckX8gKJ@krava>
References: <20230830080405.251926-1-bigeasy@linutronix.de>
 <20230830080405.251926-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830080405.251926-2-bigeasy@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 10:04:04AM +0200, Sebastian Andrzej Siewior wrote:
> If __bpf_prog_enter_sleepable_recur() detects recursion then it returns
> 0 without undoing rcu_read_lock_trace(), migrate_disable() or
> decrementing the recursion counter. This is fine in the JIT case because
> the JIT code will jump in the 0 case to the end and invoke the matching
> exit trampoline (__bpf_prog_exit_sleepable_recur()).
> 
> This is not the case in kern_sys_bpf() which returns directly to the
> caller with an error code.
> 
> Add __bpf_prog_exit_sleepable_recur() as clean up in the recursion case.
> 
> Fixes: b1d18a7574d0d ("bpf: Extend sys_bpf commands for bpf_syscall programs.")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a2aef900519c2..c925c270ed8b4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5307,6 +5307,7 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
>  		run_ctx.saved_run_ctx = NULL;
>  		if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
>  			/* recursion detected */
> +			__bpf_prog_exit_sleepable_recur(prog, 0, &run_ctx);
>  			bpf_prog_put(prog);
>  			return -EBUSY;
>  		}
> -- 
> 2.40.1
> 

