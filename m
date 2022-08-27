Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B35A34CD
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 07:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiH0FPz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 01:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0FPz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 01:15:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A443E2C7B
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 22:15:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a36so509867edf.5
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 22:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1gEsTEokvlmnRP9KVOY6L2hAow+ft60Gs2mLNFeDzpM=;
        b=oEOo1kIrHTExxfgWq3XHrNFi6WE/jCKJTzIna5yPee+MMULHJpJNYa3IqkNZcaDeLO
         L+CCV/Wck7h3L+eUK67y3fRyZWChuOqThUpQXlRxBAkR9GJ4xmIFn+HKCrrTMTO1jpic
         /QT89JgmwOxPDjGZzQtU8tjSupH+h6elgBGamWkiEcl8UOopy0MHTA9CEi1WgSkz6hfc
         c/wNgEWLYU9KqRZSwyqTKkTR2yxPQwDF5T6SyWSX4HVDAy1H55bne7rkkONLZWPJbfvV
         z0+/ET/5GtiOU79CGIge5fta8DX5YK+Ifu+BTVC6H0Qcva9XdOaUCCu5CLOW0JwhSpfr
         Gm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1gEsTEokvlmnRP9KVOY6L2hAow+ft60Gs2mLNFeDzpM=;
        b=tfXG/qnhK0CGh6XdX2x93UAzA6aJJdsaIAZ+psJMEjuw4rNwH1kbR0e2RGj3RPcW1B
         4DhB8pUXmPgsXvff1G1s5cYFTVrCMdz35ePERhjWKBTuKpq1/UCeCNlhu8Qy3LSYl/6Z
         0uTvDQPQ76+OqRIl9fCL3veUjqKLqfh5n/WE2Ed0PBmSecnDx++VIiFtLM1Xjau2+13s
         BHOyRpA4j904rhP9xBvgMX5jMxaG+BLSfi9V7A4Xe1s5t6l2C6V9sQhxFzt9uLFIl5yd
         MIEN0SsKMSt/7anKyWSiuZKvZJ/RoWl7UJqSLsCp5PWfXohBoYCBDOeSFAFFmZOvj4Fc
         ETjg==
X-Gm-Message-State: ACgBeo32L6nvsHSXTbqEiDiyW/s0AMFAwLEXz0XR+ueR+/c68a0Nkmp2
        EGAHt/AeQYea73sJGcysPEXqX08CM2J8GIQMDp4=
X-Google-Smtp-Source: AA6agR4a3pb5xIaLOAeoj0A2YToDPHTaaOVNng8RdEyWVtDaFQuGY8oN/ELHjdZizOjlGakLkFYgzzWksbMPcYKFIAk=
X-Received: by 2002:aa7:d993:0:b0:447:ed34:14a2 with SMTP id
 u19-20020aa7d993000000b00447ed3414a2mr4464225eds.260.1661577351925; Fri, 26
 Aug 2022 22:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220808140626.422731-1-jolsa@kernel.org> <20220808140626.422731-11-jolsa@kernel.org>
 <20220824012237.h57uimu2m3medkz5@macbook-pro-3.dhcp.thefacebook.com>
 <YweedGDaL7yI382D@krava> <CAADnVQKVnSu-wDiVk6E3mU9J_LGC+0ou63T8TUv-J=BSCZf6iQ@mail.gmail.com>
 <CAEf4Bzbb9TTndGt4yStGZNoebPcYHFkLSRVZKYvh8c+k5aH9Ag@mail.gmail.com> <YwjWtwehPIXwVtm1@krava>
In-Reply-To: <YwjWtwehPIXwVtm1@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Aug 2022 22:15:40 -0700
Message-ID: <CAEf4BzbFmEtMub1+rm-1NH5H_XRCWJ3BChG6OpdMHxncgFjh1w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 10/17] bpf: Add support to attach program to
 multiple trampolines
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 7:20 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 07:35:44PM -0700, Andrii Nakryiko wrote:
> > On Thu, Aug 25, 2022 at 10:44 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Aug 25, 2022 at 9:08 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Tue, Aug 23, 2022 at 06:22:37PM -0700, Alexei Starovoitov wrote:
> > > > > On Mon, Aug 08, 2022 at 04:06:19PM +0200, Jiri Olsa wrote:
> > > > > > Adding support to attach program to multiple trampolines
> > > > > > with new attach/detach interface:
> > > > > >
> > > > > >   int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp,
> > > > > >                                   struct bpf_tramp_id *id)
> > > > > >   int bpf_trampoline_multi_detach(struct bpf_tramp_prog *tp,
> > > > > >                                   struct bpf_tramp_id *id)
> > > > > >
> > > > > > The program is passed as bpf_tramp_prog object and trampolines to
> > > > > > attach it to are passed as bpf_tramp_id object.
> > > > > >
> > > > > > The interface creates new bpf_trampoline object which is initialized
> > > > > > as 'multi' trampoline and stored separtely from standard trampolines.
> > > > > >
> > > > > > There are following rules how the standard and multi trampolines
> > > > > > go along:
> > > > > >   - multi trampoline can attach on top of existing single trampolines,
> > > > > >     which creates 2 types of function IDs:
> > > > > >
> > > > > >       1) single-IDs - functions that are attached within existing single
> > > > > >          trampolines
> > > > > >       2) multi-IDs  - functions that were 'free' and are now taken by new
> > > > > >          'multi' trampoline
> > > > > >
> > > > > >   - we allow overlapping of 2 'multi' trampolines if they are attached
> > > > > >     to same IDs
> > > > > >   - we do now allow any other overlapping of 2 'multi' trampolines
> > > > > >   - any new 'single' trampoline cannot attach to existing multi-IDs IDs.
> > > > > >
> > > > > > Maybe better explained on following example:
> > > > > >
> > > > > >    - you want to attach program P to functions A,B,C,D,E,F
> > > > > >      via bpf_trampoline_multi_attach
> > > > > >
> > > > > >    - D,E,F already have standard trampoline attached
> > > > > >
> > > > > >    - the bpf_trampoline_multi_attach will create new 'multi' trampoline
> > > > > >      which spans over A,B,C functions and attach program P to single
> > > > > >      trampolines D,E,F
> > > > > >
> > > > > >    - A,B,C functions are now 'not attachable' by any trampoline
> > > > > >      until the above 'multi' trampoline is released
> > > > >
> > > > > This restriction is probably too severe.
> > > > > Song added support for trampoline and KLPs to co-exist on the same function.
> > > > > This multi trampoline restriction will resurface the same issue.
> > > > > afiak this restriction is only because multi trampoline image
> > > > > is the same for A,B,C. This memory optimization is probably going too far.
> > > > > How about we keep existing logic of one tramp image per function.
> > > > > Pretend that multi-prog P matches BTF of the target function,
> > > > > create normal tramp for it and attach prog P there.
> > > > > The prototype of P allows six u64. The args are potentially rearding
> > > > > garbage, but there are no safety issues, since multi progs don't know BTF types.
> > > > >
> > > > > We still need sinle bpf_link_multi to contain btf_ids of all functions,
> > > > > but it can point to many bpf tramps. One for each attach function.
> > > > >
> > > > > iirc we discussed something like this long ago, but I don't remember
> > > > > why we didn't go that route.
> > > > > arch_prepare_bpf_trampoline is fast.
> > > > > bpf_tramp_image_alloc is fast too.
> > > > > So attaching one multi-prog to thousands of btf_id-s should be fast too.
> > > > > The destroy part is interesting.
> > > > > There we will be doing thousands of bpf_tramp_image_put,
> > > > > but it's all async now. We used to have synchronize_rcu() which could
> > > > > be the reason why this approach was slow.
> > > > > Or is this unregister_fentry that slows it down?
> > > > > But register_ftrace_direct_multi() interface should have solved it
> > > > > for both register and unregister?
> > > >
> > > > I think it's the synchronize_rcu_tasks at the end of each ftrace update,
> > > > that's why we added un/register_ftrace_direct_multi that makes the changes
> > > > for multiple ips and syncs once at the end
> > >
> > > hmm. Can synchronize_rcu_tasks be made optional?
> > > For ftrace_direct that points to bpf tramps is it really needed?
> > >
> > > > un/register_ftrace_direct_multi will attach/detach multiple multiple ips
> > > > to single address (trampoline), so for this approach we would need to add new
> > > > ftrace direct api that would allow to set multiple ips to multiple trampolines
> > > > within one call..
> > >
> > > right
> > >
> > > > I was already checking on that and looks doable
> > >
> > > awesome.
> > >
> > > > another problem might be that this update function will need to be called with
> > > > all related trampoline locks, which in this case would be thousands
> > >
> > > sure. but these will be newly allocated trampolines and
> > > brand new mutexes, so no contention.
> > > But thousands of cmpxchg-s will take time. Would be good to measure
> > > though. It might not be that bad.
> >
> > What about the memory overhead of thousands of trampolines and
> > trampoline images? Seems very wasteful to create one per each attach,
> > when each attachment in general will be identical.
> >
> >
> > If I remember correctly, last time we were also discussing creating a
> > generic BPF trampoline that would save all 6 input registers,
> > regardless of function's BTF signature. Such BPF trampoline should
> > support calling both generic fentry/fexit programs and typed ones,
> > because all the necessary data is stored on the stack correctly.
> >
> > For the case when typed (non-generic) BPF trampoline is already
> > attached to a function and now we are attaching generic fentry, why
> > can't we "upgrade" existing BPF trampoline to become generic, and then
> > just add generic multi-fentry program to its trampoline image? Once
> > that multi-fentry is detached, we might choose to convert trampoline
> > back to typed BPF trampoline (i.e., save only necessary registers, not
> > all 6 of them), but that's more like an optimization, it doesn't have
> > to happen.
> >
> > Or is there something that would make such generic trampoline impossible?
> >
> > If we go with this approach, then each multi-fentry attachment will be
> > creating minimum amount of trampolines, determined by all the
> > combinations of attached programs at that point. If after we attach
> > multi-fentry to some set of functions we need to attach another
> > multi-fentry or typed fentry, we'd potentially need to split
> > trampolines and create a bit more of them. But while that sounds a bit
> > complicated, we do all that under locks so there isn't much problem in
> > doing that, no?
> >
> > But in general, I agree with Alexei that this restriction on not being
> > able to attach to a function once multi-attach trampoline is attached
> > to it is a really-really bad restriction in production, where we can't
> > control exactly what BPF apps run and in which order.
>
> ah ok.. attaching single trampoline on top of attached multi trampoline
> should be possible to add.. as long as one side of the problem is single
> trampoline it should be doable, I'll check
>
> leaving the restriction only to attaching one multi trampoline over
> another (not equal) attached multi trampoline
>
> would that be acceptable?

I guess I'm missing what's fundamentally different between
multi-trampoline + single trampoline vs multi-tramp + multi-tramp?
Multi-tramp is already saving all registers, so can "host" other
generic fentry/fexit. So why this multi + multi restriction?

>
> >
> > P.S. I think this generic typeless BPF trampoline is a useful thing in
> > itself and we are half-way there already with bpf_get_func_ip() and
> > bpf_get_func_arg_cnt() helpers and storing such "parameters" on the
> > stack, so tbh, we can probably split the problem into two and try to
> > address a somewhat simpler and more straightforward generic BPF
> > trampoline first. Such generic type-less BPF trampoline will make
> > fentry a better and more generic alternative to kprobe, by being less
> > demanding about specifying BTF ID (even if we don't care about input
> > argument types) yet faster to trigger than kprobe.
>
> yes, with the help of those helpers the only 'generic' thing for
> trampoline is its BTF type
>
> jirka
