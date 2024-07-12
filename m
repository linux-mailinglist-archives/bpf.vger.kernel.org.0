Return-Path: <bpf+bounces-34706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE6693022C
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 00:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6269FB20DF0
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E56A347;
	Fri, 12 Jul 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdmBOtXp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D840870;
	Fri, 12 Jul 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720823974; cv=none; b=bUe3jlwQhyACMQS7qVH59Eydh0FSDL3RRSO4vRVgDe1zx7F22P0wGPGGpMj2ImbOoTB/t3iETgKXRRSC6ZR7e3quzMcpOI1rqPe1LO34YOzg+urin9da5DAUVP7AMPE/B+AjY5K/LjKmHhpx96UO9q9t11yaCtygj2afVjXWsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720823974; c=relaxed/simple;
	bh=YR6e95qWKNK/3cZ3WYhqUY3n4USd1+bl0Wn5VWR6PV8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBWxilCQN1z3tqVXiApVuE+t70cpnLm/Y6N+SlD0Cw9OKfsmTofuaf8mEc6K/pnyrIwwgIi9x5FjGp1WB5TziKiIAUfWzoxFWByjt1vsznUYy+VmsH5kurKyvuUrCc3b8Zj7JMbferY2dmml9b4uMQlfWX2XB5NvfBBqvUoYmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdmBOtXp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c25beae1so284172466b.2;
        Fri, 12 Jul 2024 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720823971; x=1721428771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CV4MWNGj/jtOVQdvN2+NhX25AtQ3SQ1usq+AOzbBUP0=;
        b=MdmBOtXpe3RzTyNarimDnrzIUz5rvJHZst5p5Yv7Ku92917h5VjsZbvnb+8r3q9lj3
         MQ416OhHpcmv+UfELkCpyqjffcUTqhB1MNS7SIP6lTPiplcb6OTdL2O+8mdJoGcP5ONC
         0yW7GNJ6dreZL2BHUSf2wkInYtGWqyQacJj6rAFQ0nxZ53qOWA9UX1vta53JAfeTpqF1
         RjdHJ6WCqQC+zi2QdrkC9R61lyw3N934idcN6RLGjWuAjEt441zTVuqitBueO3TgGAIJ
         vo672lCvU84BNZBefccoCNQwHFIEc5o1enkEnKfh8gi/KMivmROdztpIUsIUj47Ks3sw
         I7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720823971; x=1721428771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV4MWNGj/jtOVQdvN2+NhX25AtQ3SQ1usq+AOzbBUP0=;
        b=FiDj0zlcb1QfqNbwUmh/Dc6KbS7fJpTwoQbCITi4x9tS55xV0zVXwVnYJtHgfOdoz+
         HeN00D04V2CmEPLC/IhbrFDhOXRalZLBK6Qrife5p/U+XCd9T9fCWVfBgqxwTaesfc9+
         PF9Eq4DOF+vr1kwYPwnhHapxFDJdh88sZJTQqvibh8jMF+aiqLwxlCb5lLlja+/DM01W
         clu44QerS3uCH/tPyIQXdNqPxBaT8SMYTHA+7W/vWQzdkclrNHdFn4JbY0b9wpxg5B9O
         cXnfbMg4K73bkF16zjendKyK0OiM2okp8JjO2vbPn+NbVEY0rdzrIv3B7AEzt/AsfRti
         pKWA==
X-Forwarded-Encrypted: i=1; AJvYcCVsjN8pQgcwGTwlWqhBLb3i6GP80U2r4sfx2Zu4U4m0f9iDOBsKbiO2LnTBQ6LTUqlG1D/aBhWy1y9mRMo/XwKrGL5a2E0UPtuTdA/NOVrTRooNgVW+I6KyfOA7zNxMdrbY56kEP0SADevHEYTKQtLggBVhS5GN8amk
X-Gm-Message-State: AOJu0Yz3u+9oh4dbUR0uLdspbkCIolI4xo/QPkJ3BpbSssgSWF/waZeq
	4K4xqY2QMYpZoZFLbhxvPRGV/xa6GWW4ASZbWwZrjHQE4Yvqszim
X-Google-Smtp-Source: AGHT+IEAnbb8PRUYlmVCmmu0XJ+yJVkU2QMJ2jtemSmWY/zcN4R0utqbyWulRI3mlWV6p+AZqa7+Dw==
X-Received: by 2002:a17:906:384b:b0:a77:b664:c078 with SMTP id a640c23a62f3a-a780b6b1935mr781846566b.27.1720823970896;
        Fri, 12 Jul 2024 15:39:30 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc52sm379188166b.4.2024.07.12.15.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 15:39:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 13 Jul 2024 00:39:28 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, Kyle Huey <me@kylehuey.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, acme@kernel.org, andrii.nakryiko@gmail.com,
	elver@google.com, khuey@kylehuey.com, mingo@kernel.org,
	namhyung@kernel.org, peterz@infradead.org, robert@ocallahan.org,
	yonghong.song@linux.dev, mkarsten@uwaterloo.ca, kuba@kernel.org,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
Message-ID: <ZpGwoGW51sp8vutX@krava>
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2>
 <ZpGrstyKD-PtWyoP@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpGrstyKD-PtWyoP@krava>

On Sat, Jul 13, 2024 at 12:18:26AM +0200, Jiri Olsa wrote:
> On Fri, Jul 12, 2024 at 09:53:53AM -0700, Joe Damato wrote:
> > Greetings:
> > 
> > (I am reposting this question after 2 days and to a wider audience
> > as I didn't hear back [1]; my apologies it just seemed like a
> > possible bug slipped into 6.10-rc1 and I wanted to bring attention
> > to it before 6.10 is released.)
> > 
> > While testing some unrelated networking code with Martin Karsten (cc'd on
> > this email) we discovered what appears to be some sort of overflow bug in
> > bpf.
> > 
> > git bisect suggests that commit f11f10bfa1ca ("perf/bpf: Call BPF handler
> > directly, not through overflow machinery") is the first commit where the
> > (I assume) buggy behavior appears.
> 
> heya, nice catch!
> 
> I can reproduce.. it seems that after f11f10bfa1ca we allow to run tracepoint
> program as perf event overflow program 
> 
> bpftrace's bpf program returns 1 which means that perf_trace_run_bpf_submit
> will continue to execute perf_tp_event and then:

also bpftrace should perhaps return 0 in tracepoint programs
and cut the extra processing in any case

cc-ing Viktor

jirka


> 
>   perf_tp_event
>     perf_swevent_event
>       __perf_event_overflow
>         bpf_overflow_handler
> 
> bpf_overflow_handler then executes event->prog on wrong arguments, which
> results in wrong 'work' data in bpftrace output
> 
> I can 'fix' that by checking the event type before running the program like
> in the change below, but I wonder there's probably better fix
> 
> Kyle, any idea?
> 
> > 
> > Running the following on my machine as of the commit mentioned above:
> > 
> >   bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] = count(); }'
> > 
> > while simultaneously transferring data to the target machine (in my case, I
> > scp'd a 100MiB file of zeros in a loop) results in very strange output
> > (snipped):
> > 
> >   @[11]: 5
> >   @[18]: 5
> >   @[-30590]: 6
> >   @[10]: 7
> >   @[14]: 9
> > 
> > It does not seem that the driver I am using on my test system (mlx5) would
> > ever return a negative value from its napi poll function and likewise for
> > the driver Martin is using (mlx4).
> > 
> > As such, I don't think it is possible for args->work to ever be a large
> > negative number, but perhaps I am misunderstanding something?
> > 
> > I would like to note that commit 14e40a9578b7 ("perf/bpf: Remove #ifdef
> > CONFIG_BPF_SYSCALL from struct perf_event members") does not exhibit this
> > behavior and the output seems reasonable on my test system. Martin confirms
> > the same for both commits on his test system, which uses different hardware
> > than mine.
> > 
> > Is this an expected side effect of this change? I would expect it is not
> > and that the output is a bug of some sort. My apologies in that I am not
> > particularly familiar with the bpf code and cannot suggest what the root
> > cause might be.
> > 
> > If it is not a bug:
> >   1. Sorry for the noise :(
> 
> your report is great, thanks a lot!
> 
> jirka
> 
> 
> >   2. Can anyone suggest what this output might mean or how the
> >      script run above should be modified? AFAIK this is a fairly
> >      common bpftrace that many folks run for profiling/debugging
> >      purposes.
> > 
> > Thanks,
> > Joe
> > 
> > [1]: https://lore.kernel.org/bpf/Zo64cpho2cFQiOeE@LQ3V64L9R2/T/#u
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c6a6936183d5..0045dc754ef7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9580,7 +9580,7 @@ static int bpf_overflow_handler(struct perf_event *event,
>  		goto out;
>  	rcu_read_lock();
>  	prog = READ_ONCE(event->prog);
> -	if (prog) {
> +	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT) {
>  		perf_prepare_sample(data, event, regs);
>  		ret = bpf_prog_run(prog, &ctx);
>  	}

