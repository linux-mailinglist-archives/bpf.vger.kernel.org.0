Return-Path: <bpf+bounces-2985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5866737D46
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E90B281490
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8B48BF8;
	Wed, 21 Jun 2023 08:33:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029342AB2B
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 08:33:01 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E007319BB
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 01:32:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51bdf83a513so62144a12.2
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687336371; x=1689928371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6ruWiVQ3+aiztMR39hgm666Sj0K9gobE+uDsAP9obc=;
        b=cZlz8KF+hWdUJLSkZYPAo1IBmA5kBGuuWssYjzAGxK1HMo6JUJAXCIC8cmk8+6J5C+
         Unt3giTmGGvnpVknFKSw1xJHGguazvwFtTYLrQPBUUg4gt9xfrSMZ7Abm9uX01wrkA/s
         MODWBlMeQNW+wfZufTvpZ/o/Cw4Vgekw2v+r8ou4YZ59e1ZkLPtYvNA2qJNw/kAfmGR1
         7Brayw4fFQ0Bh+ZQSrNdEYYHY3AnO0pIrSDHYlCdJzk2EW36D7eVxLrZg4UWHmfUxgMm
         T1S14ErC7AFhMHuO6jpVZe/1q8oZdGPQz28ulZcwAL0zpwklSiarI1Aigv9oEP5rgGO9
         PSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687336371; x=1689928371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6ruWiVQ3+aiztMR39hgm666Sj0K9gobE+uDsAP9obc=;
        b=Ez7Saaifg6CvActhRFjVDcFkZAq4cYppC/gPLSHCs8ElaI1Kvsp1WTThV3a1bMplVO
         YaWAbWf2kdFxwhUU9tMllIq0YMpk8ZYeArV+noArlqg2RPkalODa8zKdqUJEZTAi5+wj
         pRbqEFqouAddB4oiZNuWiaZOCV5dAcj8uxvy8Rq8PP1jhYbPQ4IEROvhJLRChs/FXj80
         C1qbKfjIzpEA8Z5OTZJf8A+QNqec7r91dFTHLxLRto+fxb9VRHJVqyYIuIWKX7c3/grs
         XiD4Guhf1YF8Czo6r3JecugTj0u8iOIJeduNa2UizNKFDVja/nypNV7Zf2DQ8UZ9ZNnh
         XXog==
X-Gm-Message-State: AC+VfDxbWA54AddpSZnR4WJVkNb++kfsF3NgRZuBCv5RUBvhRHDC/9Hy
	L2KSHx+JJbTgEFnWIV1MXe8=
X-Google-Smtp-Source: ACHHUZ4eVh+1bTdW/NstuRUdax7sZzHdKmcasF+9VEEm+mUUfr2Vnk7bzibVEVWUWmj0elPhkiRgDg==
X-Received: by 2002:aa7:c998:0:b0:51a:43ad:1402 with SMTP id c24-20020aa7c998000000b0051a43ad1402mr8232724edt.30.1687336370988;
        Wed, 21 Jun 2023 01:32:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id g2-20020a170906594200b00977cad140a8sm2742308ejr.218.2023.06.21.01.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 01:32:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 21 Jun 2023 10:32:48 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
Message-ID: <ZJK1sPAsH0gtBJQA@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-2-jolsa@kernel.org>
 <20230620171115.ebel6f7kjeyy4msn@MacBook-Pro-8.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620171115.ebel6f7kjeyy4msn@MacBook-Pro-8.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 10:11:15AM -0700, Alexei Starovoitov wrote:
> On Tue, Jun 20, 2023 at 10:35:27AM +0200, Jiri Olsa wrote:
> > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > +			   unsigned long entry_ip,
> > +			   struct pt_regs *regs)
> > +{
> > +	struct bpf_uprobe_multi_link *link = uprobe->link;
> > +	struct bpf_uprobe_multi_run_ctx run_ctx = {
> > +		.entry_ip = entry_ip,
> > +	};
> > +	struct bpf_prog *prog = link->link.prog;
> > +	struct bpf_run_ctx *old_run_ctx;
> > +	int err = 0;
> > +
> > +	might_fault();
> > +
> > +	rcu_read_lock_trace();
> > +	migrate_disable();
> > +
> > +	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
> > +		goto out;
> 
> bpf_prog_run_array_sleepable() doesn't do such things.
> Such 'proteciton' will actively hurt.
> The sleepable prog below will block all kprobes on this cpu.
> please remove.

ok makes sense, can't recall the reason why I added it

jirka

> 
> > +
> > +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > +
> > +	if (!prog->aux->sleepable)
> > +		rcu_read_lock();
> > +
> > +	err = bpf_prog_run(link->link.prog, regs);
> > +
> > +	if (!prog->aux->sleepable)
> > +		rcu_read_unlock();
> > +
> > +	bpf_reset_run_ctx(old_run_ctx);
> > +
> > +out:
> > +	__this_cpu_dec(bpf_prog_active);
> > +	migrate_enable();
> > +	rcu_read_unlock_trace();
> > +	return err;

