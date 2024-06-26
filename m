Return-Path: <bpf+bounces-33138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB378917ABB
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D0A1C21DE3
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87497161935;
	Wed, 26 Jun 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E/m4swjr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD60161314
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389907; cv=none; b=YJf8jGLiSpPs5xF+akOY04Sjz5GPvzMoTNV62tRYaI2F0/V+H2XEOWrmSz8eCOfwuB0azUl5ShoLFxXwJRWY42zJ/SKlHxMZ0EqQbKdd2/OjG5SFidI7CdJpJt3PlyXb8B/3RN9EDETtfe6D4cDV7Zqm+QywS0OSQ2iTxVM66zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389907; c=relaxed/simple;
	bh=1kWlGmkS836L4El5Oon+zyjOQtOGaM1Kyz+uLD2KG7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAXZP1LCSSviopDzCuC1uLvOCkiOrS8DpBsdEzmWJEqe5dktJVXLnY6OkHC68ktXlh5TB/n8egz4eXuTlf7qox2eaeWJuX7fOkmlKQm17vZ67auleV0Q9dfeukvzu7gD/TUPr2y59CdIaUOw/yZoG7mCqmfUHYCjXJvGXu2IDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E/m4swjr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso66442381fa.3
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719389903; x=1719994703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4a5xhdHDOpphV49N8LxW9kDtd2hiNqZaaQWvv6k7BAw=;
        b=E/m4swjruP5JGh2qx+IkiCVA80PjvlobeLENOg6KSD4J4LsH78srOZAgG4Fyqba2p1
         oDYuyGOxbpDioehMFKNz36vYprLH1SE4ZOKGr03WO3IolmOM5R94hQQ1B17zw6Sh7dqd
         kCLG5LJYvHQFfnYg4wSTICFiVe6GFVnODwM0jUSia2Fm+7slJ4G+nHRYd64+FjqDHe1b
         eSTVrAYZi7kFlG5cR4mUzl6jIAFS4YrYwfYIIq2HReC8702D0bMPq5AOQWmMYsXJLvFe
         cknsA28RN5octsMIdMV5gdcngEWs5PvpunKuylf6wcqLOsAcaRtGkFldjDw+swwBpG0i
         ueLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719389903; x=1719994703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a5xhdHDOpphV49N8LxW9kDtd2hiNqZaaQWvv6k7BAw=;
        b=pJuPb+TitvVHQPry/Y8CST3Wh2f/1Bc3K+QFD1Y8lARX73hkzGoFtkNdDkQMhskKnM
         NUz/OkLPW4kZmQvIzzELz77liFYXUo0VuPnND2d4nTPK94xbbiPFeeQOf18cI0XXENTx
         c+TxrlNBLgAgLJHiE3wyoTMbHPVkz8/pII/DiwLj9pt+OJu9zhPAb5ipRQBF8R/Rx3vR
         5ikrlIYB8UFjg698YI8KX/hDuGrUF2iC20qNeZBhOf6L4O8kKaiNxCfVKCs2koK528FE
         z/MQ1db4tY7Y32CU6MgMYwSa5p/qf7yM2OcyPe5WVEamm0EUU1t75K/m7LcvCLSeHSdh
         a4dA==
X-Forwarded-Encrypted: i=1; AJvYcCX/+LgaVpSrjovh9tyyT6OWbiyGBUw2oWfWMs6cCpI+TbhFAIXRzKddBA6346DTNzhiM6YacmT1cFbvs2WRiguK5lvJ
X-Gm-Message-State: AOJu0YyHh9aCjd2wb9owJspmkG0yD4oQ0UXp8fftOLdO50YnLK2OWPfb
	Yi+sE4Zr4/RcRVNTXJO/Ke8qXkJCedCWYnVMHOsjm71tWTkEqoViOicWwTJPQ8w=
X-Google-Smtp-Source: AGHT+IHVJ7ZeIx3A9n1K07RjOwzlBHAmVrAatLjc/i5oBAuRVkA0q7re2mdYuT8iRLwXGoTZDedQjA==
X-Received: by 2002:a05:651c:1a1e:b0:2ec:59b6:ad71 with SMTP id 38308e7fff4ca-2ec59b6ae47mr73713961fa.40.1719389903410;
        Wed, 26 Jun 2024 01:18:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70667a5d6dbsm7559160b3a.79.2024.06.26.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:18:22 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:18:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
Message-ID: <ZnvOwGk0cqpx4kkk@pathway.suse.cz>
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de>
 <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikxxxbwd.fsf@jogness.linutronix.de>

On Tue 2024-06-25 17:53:14, John Ogness wrote:
> On 2024-06-26, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> > On 2024/06/25 23:17, John Ogness wrote:
> >> On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> >>> syzbot is reporting circular locking dependency inside __bpf_prog_run(),
> >>> for fault injection calls printk() despite rq lock is already held.
> >>>
> >>> Guard __bpf_prog_run() using printk_deferred_{enter,exit}() (and
> >>> preempt_{disable,enable}() if CONFIG_PREEMPT_RT=n) in order to defer any
> >>> printk() messages.
> >> 
> >> Why is the reason for disabling preemption?
> >
> > Because since kernel/printk/printk_safe.c uses a percpu counter for deferring
> > printk(), printk_safe_enter() and printk_safe_exit() have to be called from
> > the same CPU. preempt_disable() before printk_safe_enter() and preempt_enable()
> > after printk_safe_exit() guarantees that printk_safe_enter() and
> > printk_safe_exit() are called from the same CPU.
> 
> Yes, but we already have cant_migrate(). Are you suggesting there are
> configurations where cant_migrate() is true but the context can be
> migrated anyway?

IMHO, we want to enter printk_safe only with preemption disabled.
Otherwise, printk() would stay deferred on the given CPU for any
task scheduled in this section.

Best Regards,
Petr

