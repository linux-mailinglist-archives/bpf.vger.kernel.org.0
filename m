Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5564362D
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 21:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiLEU63 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 15:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLEU63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 15:58:29 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497C124BD5;
        Mon,  5 Dec 2022 12:58:28 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id c14so9106106qvq.0;
        Mon, 05 Dec 2022 12:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKSZDvvj4y+FgTJIWp9ara8T05reUdcNFRC0BuUz1cU=;
        b=wHhHkQEm9ITMWaFtiQ95khs3hyOBtqq72Vdb5ViUDi61PNVTS8jR3Tmq0yAavulvLJ
         qxyWlGYbbWkiD9rYReEjWD1qMCtYAeIoyN8QbsLquSS3oSv+rehoX9JtF0TYhKQaF5Cf
         nan0pK6kMrGiZu47JdDsiwLutwtpZu1JWn+UXGCPfNU7CDq2WRgvnPdWd7QdN54Gq/FX
         EgssKkzG/PrnDUwM/2DlQ69gk6SJqo9KG5Kn1EDajAygb46aK1g2WJP6TgdCyjCWRyt7
         uY2i4t4yI9xmJA8Fvmt6G5Vw8shWyBwE+5lzAK1N6iI5w1+ZyX8WKNAUQyowxphkE/yq
         oqyQ==
X-Gm-Message-State: ANoB5plyUCgsBxZA0B1Z3z27ioXgO2WppS29/INIaRki7ipm9zuotU28
        eIafZz6UK+oJF4WoJuyQ/6E=
X-Google-Smtp-Source: AA0mqf5xT6wrJ8QVhgWOkD9oTNpZOqmsPy8ic4AmdnaKx1T1wKll5nHsPQSEbua1KMYIUy4gHgNcuw==
X-Received: by 2002:ad4:52ca:0:b0:4bb:cb21:df19 with SMTP id p10-20020ad452ca000000b004bbcb21df19mr64587648qvs.85.1670273907051;
        Mon, 05 Dec 2022 12:58:27 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:cc23])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a424900b006fc2f74ad12sm13380266qko.92.2022.12.05.12.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:58:26 -0800 (PST)
Date:   Mon, 5 Dec 2022 14:58:22 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, F@maniforge.lan
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/2] bpf/docs: Document struct task_struct *
 kfuncs
Message-ID: <Y45bbn+5vDPgM12z@maniforge.lan>
References: <20221202220736.521227-1-void@manifault.com>
 <20221202220736.521227-2-void@manifault.com>
 <20221203021500.okerdcfwhgykrxxg@macbook-pro-6.dhcp.thefacebook.com>
 <Y44X5uQ0tJoCvQ96@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y44X5uQ0tJoCvQ96@maniforge.lan>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 05, 2022 at 10:10:14AM -0600, David Vernet wrote:
> > > +.. code-block:: c
> > > +
> > > +	SEC("tp_btf/task_newtask")
> > > +	int BPF_PROG(task_get_pid_example, struct task_struct *task, u64 clone_flags)
> > > +	{
> > > +		struct task_struct *lookup;
> > > +
> > > +		lookup = bpf_task_from_pid(task->pid);
> > > +		if (!lookup)
> > > +			/* A task should always be found, as %task is a tracepoint arg. */
> > > +			return -ENOENT;
> > > +
> > > +		if (lookup->pid != task->pid) {
> > > +			/* The pid of the lookup task should be the same as the input task. */
> > 
> > I suspect both "errors" are actually possible in practice,
> > since bpf_task_from_pid is using init_pid_ns.
> > But this taskd might be in different pid_ns. See task_active_pid_ns.
> > Probably worth mentioning this aspect of bpf_task_from_pid.
> 
> Yep, agreed. Will add

Actually, I don't think either error can ever happen. p->pid is globally
unique, and always uses the init_pid_ns. See [0] where p->pid is set,
and [1] for the implementation of pid_nr(). So I think the existing
example is actually correct, though I'll still add some comments to
explain that the kfunc only works for p->pid / the init_pid_ns.

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/fork.c#n2326
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/pid.h#n181
