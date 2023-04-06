Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1393F6D8D3F
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 04:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDFCHD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 22:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjDFCHC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 22:07:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49D83;
        Wed,  5 Apr 2023 19:07:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u20so24877696pfk.12;
        Wed, 05 Apr 2023 19:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680746820; x=1683338820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Rf3PHs8KjBgpl/umsUn/fdSXQuYHufE9WGmk03k/JU=;
        b=j3jtfXtvhVAKNQfLBlij2RhIOlp3p5bSvfOKI6hYJiTQwOcG6+kgTS8PmVey62ppBp
         tcZHPGTx1usrZiNKNLfiNVBSFzvXOKknJnQgoza13+tPgLUg7RbQAVCT70ziTHp+R8+B
         KT6mYk02LUKIZHKlzH8agqeQP/4QBnptgU3LRW47MFKoS1FYGrfITIDaq7ZqxvH9hzWx
         acVjbbUsck5YdnLfH0HlokLCj22jF9lw0yWAIdgeU/PnGs9JgeJ9eqqHtvDXAQtFY+V/
         RdXd1gvOSlwN1IZozoEh8uqvk39HWrIaXvPMcrExpoKwT1T3VO0Jh+eRDh2fT+3/ajSy
         1Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680746820; x=1683338820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rf3PHs8KjBgpl/umsUn/fdSXQuYHufE9WGmk03k/JU=;
        b=MTMw2UBNFXmnA1KyWQxzHsAdYuepQcUIC3CLGpeWflnL+UXDlfBDyOfDtCDrUU31gu
         2q0xuI5N8qeOXHdfH7iYjaWvKCG7He6q+BSfsJQ/9BNZGnZ5HaBQPIlAaRZngQ0KiW6H
         4Gi+dvjZnBkH7tQ2PF6JxrNnkhd7hFEsDVqxt0NKI4rfbVI22NpEAyOB6JFEtfpHPa1v
         GpUgiKT3GGlJVO672eMlepkLWspoKE871eQFKsmoib51bxpNVDcFwNRCRR40WKLnHOzv
         J+/65EJ2jRmUhoVdZxRyH7SyDF9/ukLOAH4lxWghzWuOx9igXmLaLKCK7DRaHLcX9Ycy
         6WEA==
X-Gm-Message-State: AAQBX9c9JwdPuph/0LoVK19EQKrkPMLpV6B95Dc33un3BezMVkysVaN9
        lId2Ko9BBWCTcyZUPhhGg5g=
X-Google-Smtp-Source: AKy350YNMnHsTTwPcNZMUK3JrrSsNlq0+gpd+HJdkIysLkBIX1vtEfLRrYZWHa92wANcy28RRLnvIg==
X-Received: by 2002:aa7:98da:0:b0:5cd:229e:f1d8 with SMTP id e26-20020aa798da000000b005cd229ef1d8mr7815653pfm.4.1680746820055;
        Wed, 05 Apr 2023 19:07:00 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:f79f])
        by smtp.gmail.com with ESMTPSA id j4-20020a62e904000000b005a8173829d5sm72258pfh.66.2023.04.05.19.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:06:59 -0700 (PDT)
Date:   Wed, 5 Apr 2023 19:06:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
Message-ID: <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
 <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
 <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
 <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 04, 2023 at 10:59:55AM +0800, Yafang Shao wrote:
> On Tue, Apr 4, 2023 at 6:50 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 03, 2023 at 11:05:25AM +0800, Yafang Shao wrote:
> > > On Mon, Apr 3, 2023 at 7:37 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Mar 28, 2023 at 11:47:31AM +0800, Yafang Shao wrote:
> > > > > On Tue, Mar 28, 2023 at 3:04 AM Song Liu <song@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, Mar 26, 2023 at 2:22 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > > > >
> > > > > > > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
> > > > > > > to FDs, that's intended for BPF's security model[1]. Not only does it
> > > > > > > prevent non-privilidged users from getting other users' bpf program, but
> > > > > > > also it prevents the user from iterating his own bpf objects.
> > > > > > >
> > > > > > > In container environment, some users want to run bpf programs in their
> > > > > > > containers. These users can run their bpf programs under CAP_BPF and
> > > > > > > some other specific CAPs, but they can't inspect their bpf programs in a
> > > > > > > generic way. For example, the bpftool can't be used as it requires
> > > > > > > CAP_SYS_ADMIN. That is very inconvenient.
> > > > > >
> > > > > > Agreed that it is important to enable tools like bpftool without
> > > > > > CAP_SYS_ADMIN. However, I am not sure whether we need a new
> > > > > > namespace for this. Can we reuse some existing namespace for this?
> > > > > >
> > > > >
> > > > > It seems we can't.
> > > >
> > > > Yafang,
> > > >
> > > > It's a Nack.
> > > >
> > > > The only thing you've been trying to "solve" with bpf namespace is to
> > > > allow 'bpftool prog show' iterate progs in the "namespace" without CAP_SYS_ADMIN.
> > > > The concept of bpf namespace is not even close to be thought through.
> > >
> > > Right, it is more likely a PoC in its current state.
> > >
> > > > Others pointed out the gaps in the design. Like bpffs. There are plenty.
> > > > Please do not send patches like this in the future.
> > >
> > > The reason I sent it with an early state is that I want to get some
> > > early feedback from the community ahead of the LSF/MM/BPF workshop,
> > > then I can improve it based on these feedbacks and present it more
> > > specifically at the workshop. Then the discussion will be more
> > > effective.
> > >
> > > > You need to start with describing the problem you want to solve,
> > > > then propose _several_ solutions, describe their pros and cons,
> > > > solicit feedback, present at the conferences (like LSFMMBPF or LPC),
> > > > and when the community agrees that 1. problem is worth solving,
> > > > 2. the solution makes sense, only then work on patches.
> > > >
> > >
> > > I would like to give a short discussion on the BPF namespace if
> > > everything goes fine.
> >
> > Not in this shape of BPF namespace as done in this patch set.
> > We've talked about BPF namespace in the past. This is not it.
> >
> > > > "In container environment, some users want to run bpf programs in their containers."
> > > > is something Song brought up at LSFMMBPF a year ago.
> > > > At that meeting most of the folks agreed that there is a need to run bpf
> > > > in containers and make sure that the effect of bpf prog is limited to a container.
> > > > This new namespace that creates virtual IDs for progs and maps doesn't come
> > > > close in solving this task.
> > >
> > > Currently in our production environment, all the containers running
> > > bpf programs are privileged, that is risky. So actually the goal of
> > > the BPF namespace is to make them (or part of them) non-privileged.
> > > But some of the abilities of these bpf programs will be lost in this
> > > procedure, like the debug-bility with bpftool, so we need to fix it.
> > > Agree with you that this goal is far from making bpf programs safely
> > > running in a container environment.
> >
> > I disagree that allowing admin to run bpftool without sudo is a task
> > worth solving. The visibility of bpf progs in a container is a different task.
> > Without doing any kernel changes we can add a flag to bpftool to let
> > 'bpftool prog show' list progs that were loaded by processes in the same cgroup.
> > bpftool already does prog->pid mapping with bpf iterators.
> > It can filter by cgroup just as well.
> 
> IIUC, at least we need bellow change in the kernel,

No. The user should just 'sudo bpftool ...' instead.

> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3705,9 +3705,6 @@ static int bpf_obj_get_next_id(const union bpf_attr *attr,
>         if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >= INT_MAX)
>                 return -EINVAL;
> 
> -       if (!capable(CAP_SYS_ADMIN))
> -               return -EPERM;
> -
>         next_id++;
>         spin_lock_bh(lock);
>         if (!idr_get_next(idr, &next_id))
> 
> Because the container doesn't have CAP_SYS_ADMIN enabled, while they
> only have CAP_BPF and other required CAPs.
> 
> Another possible solution is that we run an agent in the host, and the
> user in the container who wants to get the bpf objects info in his
> container should send a request to this agent via unix domain socket.
> That is what we are doing now in our production environment.  That
> said, each container has to run a client to get the bpf object fd.

None of such hacks are necessary. People that debug bpf setups with bpftool
can always sudo.

> There are some downsides,
> -  It can't handle pinned bpf programs
>    For pinned programs, the user can get them from the pinned files
> directly, so he can use bpftool in his case, only with some
> complaints.
> -  If the user attached the bpf prog, and then removed the pinned
> file, but didn't detach it.
>    That happened. But this error case can't be handled.
> - There may be other corner cases that it can't fit.
> 
> There's a solution to improve it, but we also need to change the
> kernel. That is, we can use the wasted space btf->name.
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b7e5a55..59d73a3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5542,6 +5542,8 @@ static struct btf *btf_parse(bpfptr_t btf_data,
> u32 btf_data_size,
>                 err = -ENOMEM;
>                 goto errout;
>         }
> +       snprintf(btf->name, sizeof(btf->name), "%s-%d-%d", current->comm,
> +                        current->pid, cgroup_id(task_cgroup(p, cpu_cgrp_id)));

Unnecessary.
comm, pid, cgroup can be printed by bpftool without changing the kernel.
