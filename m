Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9C674CEE
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 07:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjATGBP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 01:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjATGBN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 01:01:13 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C819518CA;
        Thu, 19 Jan 2023 22:01:09 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id jr19so2208825qtb.7;
        Thu, 19 Jan 2023 22:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cN6BtsvLB2Tckg44mumtgxFtviJ5L3OzknDmFCnQGqY=;
        b=MkEvmD0hNL99ig+Ald1uxCdA5+3HfK+Wmefvgit1B1SbnPnVuH2dMDUOHxNyUdsS1d
         idQDQ+28pmFGiOTgOLLRM1eaxn+u1ED4l1vlFkarxHVxdfqGWFvNsrCloeTIQS0L6vkJ
         +2yUldGwUUb4MZDjmGf2OO+PDIfj11TEqAVKnCU6fbkp1qUMisfRxrfQ97Ib1OvtxIIz
         Fa9nRX7wKEW8w+cyltFV6SqnsCehJIThZPDujDzf91YAauezjddtZwq/1SAft74W2GY7
         2zrltY6Hbae77lp6egYXIpkMnv8lkW63Mur+XbNwYG46Bz0CH8iqaYSj3/tsOV/Rh4/T
         qa4w==
X-Gm-Message-State: AFqh2kqQ4EPCOEZuYh3+eyv8kiTngyJU7DciBIfxcNBodOcUUwFWh4El
        v7JFiSco08bU/9FvqJNyM9c=
X-Google-Smtp-Source: AMrXdXtvNnQajLkirmG4WkmFMalaxNfTWFlu8gHsNsE18ynoyauLhrM6YSn8aEIJZIPkzQx782ZMwA==
X-Received: by 2002:ac8:718d:0:b0:3b0:11a1:3140 with SMTP id w13-20020ac8718d000000b003b011a13140mr15959656qto.43.1674194468834;
        Thu, 19 Jan 2023 22:01:08 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id m3-20020a05620a24c300b007055dce4cecsm1889102qkn.97.2023.01.19.22.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 22:01:08 -0800 (PST)
Date:   Fri, 20 Jan 2023 00:01:12 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 7/8] bpf/docs: Document cpumask kfuncs in a new
 file
Message-ID: <Y8ouKFjxMnu0Gspo@maniforge.lan>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-8-void@manifault.com>
 <20230120055906.m4pkchwawfxhj6ze@MacBook-Pro-6.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120055906.m4pkchwawfxhj6ze@MacBook-Pro-6.local.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 09:59:06PM -0800, Alexei Starovoitov wrote:
> On Thu, Jan 19, 2023 at 05:58:32PM -0600, David Vernet wrote:
> > +
> > +For example:
> > +
> > +.. code-block:: c
> > +
> > +	/**
> > +	 * A trivial example tracepoint program that shows how to
> > +	 * acquire and release a struct bpf_cpumask *.
> > +	 */
> > +	SEC("tp_btf/task_newtask")
> > +	int BPF_PROG(task_acquire_release_example, struct task_struct *task, u64 clone_flags)
> > +	{
> > +		struct bpf_cpumask *cpumask, *acquired;
> > +
> > +		cpumask = bpf_cpumask_create();
> > +		if (!cpumask)
> > +			return 1;
> > +
> > +		acquired = bpf_cpumask_acquire(cpumask);
> > +		bpf_cpumask_release(cpumask);
> > +		bpf_cpumask_acquire(acquired);
> > +
> > +		return 0;
> > +	}
> 
> As the first example in the doc it was... alarming :)
> I've read it as it says that bpf_cpumask_acquire has to be called on
> freshly created cpumask before it can be used.

That's fair, I treated this example like a testcase :-)

> I've started to doubt by code reading skills of the previous patches :)
> A basic example is probably necessary to introduce the concept.
> Or this example should have bpf_cpumask_set_cpu right after create and
> more alu ops after release with comments to demonstrate the point.

Makes sense. I'll update the examples to be more clear and reflect
realistic use cases.
