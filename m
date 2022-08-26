Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D605A1FF2
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 06:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiHZEiD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 00:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiHZEiB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 00:38:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0CCE302
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 21:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC1FCB82F77
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 04:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FA7C43470
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 04:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661488676;
        bh=sfzUtsC57m9rJH+tGRl0Bup4dHifRRD72v5i+xAdkv0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pfcc1Hwai3tYuyD5GdaZb5va9yQVpmqD3364nM4qnEZ3UUmeOQOB7pIwg8VKXC4+O
         M4S3/q4ofSDChNEwxJZ+LFxHS7M4QZApDqzyVnrOTA9TYwggP1PzjAGHiJUsZf2JI1
         rOjuemvaZMDSy8c7gq9JcNHKKH6bser/FUmqqjax7JqDaNkq0z2y6V6EQ747kz2cET
         d3b8LD7Ukx2YF72EQ/cKYiFxVpfS11qcgMdecdFNiK2Zgq70NuQlEyJf3bUmb38gLZ
         ykCE7fEYWijKEwZ4KXAKv0Xn7JW3/8p1jj0UZSElkzTVJYaQNTRqnkD8sf5MH6Bd2A
         Mhe1IVH0yGOQA==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-334dc616f86so8452947b3.8
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 21:37:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo11dBz8bABkQ0HV85gWphA2u99hmRh0QGvNXNqb4wVa8VilNn28
        8MMtpyodW582EN5kSZlCGk6+q0PSsBtmZyXcdbU=
X-Google-Smtp-Source: AA6agR7zYLTDjiKCUAyPw5jTHg4EUO+TIdP27bkMRYubuLfZLmDNn6TH+uDJGYcB8Wwmg2rGQ8TNdcWxbrjsaS8rinA=
X-Received: by 2002:a05:6902:110d:b0:670:b10b:d16e with SMTP id
 o13-20020a056902110d00b00670b10bd16emr6107437ybu.259.1661488675533; Thu, 25
 Aug 2022 21:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220808140626.422731-1-jolsa@kernel.org> <20220808140626.422731-11-jolsa@kernel.org>
 <20220824012237.h57uimu2m3medkz5@macbook-pro-3.dhcp.thefacebook.com>
 <YweedGDaL7yI382D@krava> <CAADnVQKVnSu-wDiVk6E3mU9J_LGC+0ou63T8TUv-J=BSCZf6iQ@mail.gmail.com>
In-Reply-To: <CAADnVQKVnSu-wDiVk6E3mU9J_LGC+0ou63T8TUv-J=BSCZf6iQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 Aug 2022 21:37:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW66-Od4wHB8vMPT0cB3oueHq57B6cd9TYAhoA+CDnyH1w@mail.gmail.com>
Message-ID: <CAPhsuW66-Od4wHB8vMPT0cB3oueHq57B6cd9TYAhoA+CDnyH1w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 10/17] bpf: Add support to attach program to
 multiple trampolines
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 10:44 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 9:08 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Aug 23, 2022 at 06:22:37PM -0700, Alexei Starovoitov wrote:
> > > On Mon, Aug 08, 2022 at 04:06:19PM +0200, Jiri Olsa wrote:
> > > > Adding support to attach program to multiple trampolines
> > > > with new attach/detach interface:
> > > >
> > > >   int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp,
> > > >                                   struct bpf_tramp_id *id)
> > > >   int bpf_trampoline_multi_detach(struct bpf_tramp_prog *tp,
> > > >                                   struct bpf_tramp_id *id)
> > > >
> > > > The program is passed as bpf_tramp_prog object and trampolines to
> > > > attach it to are passed as bpf_tramp_id object.
> > > >
> > > > The interface creates new bpf_trampoline object which is initialized
> > > > as 'multi' trampoline and stored separtely from standard trampolines.
> > > >
> > > > There are following rules how the standard and multi trampolines
> > > > go along:
> > > >   - multi trampoline can attach on top of existing single trampolines,
> > > >     which creates 2 types of function IDs:
> > > >
> > > >       1) single-IDs - functions that are attached within existing single
> > > >          trampolines
> > > >       2) multi-IDs  - functions that were 'free' and are now taken by new
> > > >          'multi' trampoline
> > > >
> > > >   - we allow overlapping of 2 'multi' trampolines if they are attached
> > > >     to same IDs
> > > >   - we do now allow any other overlapping of 2 'multi' trampolines
> > > >   - any new 'single' trampoline cannot attach to existing multi-IDs IDs.
> > > >
> > > > Maybe better explained on following example:
> > > >
> > > >    - you want to attach program P to functions A,B,C,D,E,F
> > > >      via bpf_trampoline_multi_attach
> > > >
> > > >    - D,E,F already have standard trampoline attached
> > > >
> > > >    - the bpf_trampoline_multi_attach will create new 'multi' trampoline
> > > >      which spans over A,B,C functions and attach program P to single
> > > >      trampolines D,E,F
> > > >
> > > >    - A,B,C functions are now 'not attachable' by any trampoline
> > > >      until the above 'multi' trampoline is released
> > >
> > > This restriction is probably too severe.
> > > Song added support for trampoline and KLPs to co-exist on the same function.
> > > This multi trampoline restriction will resurface the same issue.
> > > afiak this restriction is only because multi trampoline image
> > > is the same for A,B,C. This memory optimization is probably going too far.
> > > How about we keep existing logic of one tramp image per function.
> > > Pretend that multi-prog P matches BTF of the target function,
> > > create normal tramp for it and attach prog P there.
> > > The prototype of P allows six u64. The args are potentially rearding
> > > garbage, but there are no safety issues, since multi progs don't know BTF types.
> > >
> > > We still need sinle bpf_link_multi to contain btf_ids of all functions,
> > > but it can point to many bpf tramps. One for each attach function.
> > >
> > > iirc we discussed something like this long ago, but I don't remember
> > > why we didn't go that route.
> > > arch_prepare_bpf_trampoline is fast.
> > > bpf_tramp_image_alloc is fast too.
> > > So attaching one multi-prog to thousands of btf_id-s should be fast too.
> > > The destroy part is interesting.
> > > There we will be doing thousands of bpf_tramp_image_put,
> > > but it's all async now. We used to have synchronize_rcu() which could
> > > be the reason why this approach was slow.
> > > Or is this unregister_fentry that slows it down?
> > > But register_ftrace_direct_multi() interface should have solved it
> > > for both register and unregister?
> >
> > I think it's the synchronize_rcu_tasks at the end of each ftrace update,
> > that's why we added un/register_ftrace_direct_multi that makes the changes
> > for multiple ips and syncs once at the end
>
> hmm. Can synchronize_rcu_tasks be made optional?
> For ftrace_direct that points to bpf tramps is it really needed?
>
> > un/register_ftrace_direct_multi will attach/detach multiple multiple ips
> > to single address (trampoline), so for this approach we would need to add new
> > ftrace direct api that would allow to set multiple ips to multiple trampolines
> > within one call..
>
> right
>
> > I was already checking on that and looks doable
>
> awesome.
>
> > another problem might be that this update function will need to be called with
> > all related trampoline locks, which in this case would be thousands
>
> sure. but these will be newly allocated trampolines and
> brand new mutexes, so no contention.

I guess we still need to lock existing tr->mutex in some cases? Say, we
have 3 functions, A, B, C, and A already have tr_A. If we want to attach
tr_multi for all three, we still need to lock tr_A->mutex, no?

Thanks,
Song

> But thousands of cmpxchg-s will take time. Would be good to measure
> though. It might not be that bad.
