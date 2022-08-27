Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF05A3792
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiH0MQ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 08:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiH0MQu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 08:16:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8793B8E0EB
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 05:16:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id az27so4708210wrb.6
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=o0Xw6RhERDfUrLIsn4mIdP92Ho6DCAqzaU9+YAKFmhw=;
        b=CKGYW4u+kTHIc7vyyquE9GZlhgdu5rd8l4g2mnxRe3xJGosP2A75HtnvBOakmijKaC
         atwle4DYPyLyh3My6QEzd+IEQFfMzihMPYaE2mJD6akfY/VehKcQepxNMiPS1frJRVtI
         6ISpTJ3u7pkWJ6KRD5yX9MhqGAjzfA0EqJwPojsDyKyovIdj/q/W5yuoHbA5DUJmEkdG
         3DnD9PERoikextNjDl28zokrWHwWuBJCUScDL21fHQ0+CGyVdv1v20V5Gwm8lzdgdhi5
         cXbQ7Hzx4qMNPQHCtnjOjTp2If/FBQf43cOU1+lubvhsEE1KMtCS0ZOVyLdKQvl+K/dQ
         troQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=o0Xw6RhERDfUrLIsn4mIdP92Ho6DCAqzaU9+YAKFmhw=;
        b=rm6IvU/Ty3XHvKaVcorqPTP3nLTAo1SxXa1EQll1nWzfOVQF9c16u7f3DkBTsrJwIV
         M4mUNfcEIau9sJd2WkJDNKJKTPOuc76sz80djhWSA8cpePkIVCUWoVMyCZxU2BVncaFJ
         Cj0oBwdf3UbJNBklZ/bRkXftqJEVWYZeFNMqBpyS6PmAwHCnV7k5A2IduWA1wSARQtTs
         xRKj2Y7wNmDLklunsFIYzsmYSfVDE6oNjl6fwQ/M2ucrnshzG2MVmriV4cBFosUZ4REq
         c23a/4RidH0sFjLn4fo3LyB2o8juYo1B8Ldg4TyqRWxTgBlF7tHGi/OnYm0JBufykomz
         DpmA==
X-Gm-Message-State: ACgBeo108ffYdpU5RA80uhHWUCoxmEgS63f1p1vxcp+hMmAp9pi85TLG
        Xm00Gb/P9vPEZlD8pF7nExQ=
X-Google-Smtp-Source: AA6agR4AqJCVa5d+GuMSZOhb/zD5JmDQOxfou69wfRnkXQdOOVWv0oeSgaalAehbOmXbU8cfvWnHSw==
X-Received: by 2002:a5d:6da5:0:b0:222:4634:6a4e with SMTP id u5-20020a5d6da5000000b0022246346a4emr2147749wrs.172.1661602606980;
        Sat, 27 Aug 2022 05:16:46 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id n123-20020a1c2781000000b003a5b788993csm2546321wmn.42.2022.08.27.05.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:16:46 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 27 Aug 2022 14:16:44 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC PATCH bpf-next 10/17] bpf: Add support to attach program to
 multiple trampolines
Message-ID: <YwoLLF8pv2wG173K@krava>
References: <20220808140626.422731-1-jolsa@kernel.org>
 <20220808140626.422731-11-jolsa@kernel.org>
 <20220824012237.h57uimu2m3medkz5@macbook-pro-3.dhcp.thefacebook.com>
 <YweedGDaL7yI382D@krava>
 <CAADnVQKVnSu-wDiVk6E3mU9J_LGC+0ou63T8TUv-J=BSCZf6iQ@mail.gmail.com>
 <CAEf4Bzbb9TTndGt4yStGZNoebPcYHFkLSRVZKYvh8c+k5aH9Ag@mail.gmail.com>
 <YwjWtwehPIXwVtm1@krava>
 <CAEf4BzbFmEtMub1+rm-1NH5H_XRCWJ3BChG6OpdMHxncgFjh1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbFmEtMub1+rm-1NH5H_XRCWJ3BChG6OpdMHxncgFjh1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 10:15:40PM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 26, 2022 at 7:20 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 07:35:44PM -0700, Andrii Nakryiko wrote:
> > > On Thu, Aug 25, 2022 at 10:44 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Aug 25, 2022 at 9:08 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > On Tue, Aug 23, 2022 at 06:22:37PM -0700, Alexei Starovoitov wrote:
> > > > > > On Mon, Aug 08, 2022 at 04:06:19PM +0200, Jiri Olsa wrote:
> > > > > > > Adding support to attach program to multiple trampolines
> > > > > > > with new attach/detach interface:
> > > > > > >
> > > > > > >   int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp,
> > > > > > >                                   struct bpf_tramp_id *id)
> > > > > > >   int bpf_trampoline_multi_detach(struct bpf_tramp_prog *tp,
> > > > > > >                                   struct bpf_tramp_id *id)
> > > > > > >
> > > > > > > The program is passed as bpf_tramp_prog object and trampolines to
> > > > > > > attach it to are passed as bpf_tramp_id object.
> > > > > > >
> > > > > > > The interface creates new bpf_trampoline object which is initialized
> > > > > > > as 'multi' trampoline and stored separtely from standard trampolines.
> > > > > > >
> > > > > > > There are following rules how the standard and multi trampolines
> > > > > > > go along:
> > > > > > >   - multi trampoline can attach on top of existing single trampolines,
> > > > > > >     which creates 2 types of function IDs:
> > > > > > >
> > > > > > >       1) single-IDs - functions that are attached within existing single
> > > > > > >          trampolines
> > > > > > >       2) multi-IDs  - functions that were 'free' and are now taken by new
> > > > > > >          'multi' trampoline
> > > > > > >
> > > > > > >   - we allow overlapping of 2 'multi' trampolines if they are attached
> > > > > > >     to same IDs
> > > > > > >   - we do now allow any other overlapping of 2 'multi' trampolines
> > > > > > >   - any new 'single' trampoline cannot attach to existing multi-IDs IDs.
> > > > > > >
> > > > > > > Maybe better explained on following example:
> > > > > > >
> > > > > > >    - you want to attach program P to functions A,B,C,D,E,F
> > > > > > >      via bpf_trampoline_multi_attach
> > > > > > >
> > > > > > >    - D,E,F already have standard trampoline attached
> > > > > > >
> > > > > > >    - the bpf_trampoline_multi_attach will create new 'multi' trampoline
> > > > > > >      which spans over A,B,C functions and attach program P to single
> > > > > > >      trampolines D,E,F
> > > > > > >
> > > > > > >    - A,B,C functions are now 'not attachable' by any trampoline
> > > > > > >      until the above 'multi' trampoline is released
> > > > > >
> > > > > > This restriction is probably too severe.
> > > > > > Song added support for trampoline and KLPs to co-exist on the same function.
> > > > > > This multi trampoline restriction will resurface the same issue.
> > > > > > afiak this restriction is only because multi trampoline image
> > > > > > is the same for A,B,C. This memory optimization is probably going too far.
> > > > > > How about we keep existing logic of one tramp image per function.
> > > > > > Pretend that multi-prog P matches BTF of the target function,
> > > > > > create normal tramp for it and attach prog P there.
> > > > > > The prototype of P allows six u64. The args are potentially rearding
> > > > > > garbage, but there are no safety issues, since multi progs don't know BTF types.
> > > > > >
> > > > > > We still need sinle bpf_link_multi to contain btf_ids of all functions,
> > > > > > but it can point to many bpf tramps. One for each attach function.
> > > > > >
> > > > > > iirc we discussed something like this long ago, but I don't remember
> > > > > > why we didn't go that route.
> > > > > > arch_prepare_bpf_trampoline is fast.
> > > > > > bpf_tramp_image_alloc is fast too.
> > > > > > So attaching one multi-prog to thousands of btf_id-s should be fast too.
> > > > > > The destroy part is interesting.
> > > > > > There we will be doing thousands of bpf_tramp_image_put,
> > > > > > but it's all async now. We used to have synchronize_rcu() which could
> > > > > > be the reason why this approach was slow.
> > > > > > Or is this unregister_fentry that slows it down?
> > > > > > But register_ftrace_direct_multi() interface should have solved it
> > > > > > for both register and unregister?
> > > > >
> > > > > I think it's the synchronize_rcu_tasks at the end of each ftrace update,
> > > > > that's why we added un/register_ftrace_direct_multi that makes the changes
> > > > > for multiple ips and syncs once at the end
> > > >
> > > > hmm. Can synchronize_rcu_tasks be made optional?
> > > > For ftrace_direct that points to bpf tramps is it really needed?
> > > >
> > > > > un/register_ftrace_direct_multi will attach/detach multiple multiple ips
> > > > > to single address (trampoline), so for this approach we would need to add new
> > > > > ftrace direct api that would allow to set multiple ips to multiple trampolines
> > > > > within one call..
> > > >
> > > > right
> > > >
> > > > > I was already checking on that and looks doable
> > > >
> > > > awesome.
> > > >
> > > > > another problem might be that this update function will need to be called with
> > > > > all related trampoline locks, which in this case would be thousands
> > > >
> > > > sure. but these will be newly allocated trampolines and
> > > > brand new mutexes, so no contention.
> > > > But thousands of cmpxchg-s will take time. Would be good to measure
> > > > though. It might not be that bad.
> > >
> > > What about the memory overhead of thousands of trampolines and
> > > trampoline images? Seems very wasteful to create one per each attach,
> > > when each attachment in general will be identical.
> > >
> > >
> > > If I remember correctly, last time we were also discussing creating a
> > > generic BPF trampoline that would save all 6 input registers,
> > > regardless of function's BTF signature. Such BPF trampoline should
> > > support calling both generic fentry/fexit programs and typed ones,
> > > because all the necessary data is stored on the stack correctly.
> > >
> > > For the case when typed (non-generic) BPF trampoline is already
> > > attached to a function and now we are attaching generic fentry, why
> > > can't we "upgrade" existing BPF trampoline to become generic, and then
> > > just add generic multi-fentry program to its trampoline image? Once
> > > that multi-fentry is detached, we might choose to convert trampoline
> > > back to typed BPF trampoline (i.e., save only necessary registers, not
> > > all 6 of them), but that's more like an optimization, it doesn't have
> > > to happen.
> > >
> > > Or is there something that would make such generic trampoline impossible?
> > >
> > > If we go with this approach, then each multi-fentry attachment will be
> > > creating minimum amount of trampolines, determined by all the
> > > combinations of attached programs at that point. If after we attach
> > > multi-fentry to some set of functions we need to attach another
> > > multi-fentry or typed fentry, we'd potentially need to split
> > > trampolines and create a bit more of them. But while that sounds a bit
> > > complicated, we do all that under locks so there isn't much problem in
> > > doing that, no?
> > >
> > > But in general, I agree with Alexei that this restriction on not being
> > > able to attach to a function once multi-attach trampoline is attached
> > > to it is a really-really bad restriction in production, where we can't
> > > control exactly what BPF apps run and in which order.
> >
> > ah ok.. attaching single trampoline on top of attached multi trampoline
> > should be possible to add.. as long as one side of the problem is single
> > trampoline it should be doable, I'll check
> >
> > leaving the restriction only to attaching one multi trampoline over
> > another (not equal) attached multi trampoline
> >
> > would that be acceptable?
> 
> I guess I'm missing what's fundamentally different between
> multi-trampoline + single trampoline vs multi-tramp + multi-tramp?
> Multi-tramp is already saving all registers, so can "host" other
> generic fentry/fexit. So why this multi + multi restriction?

so I did not find good generic solution for multi trampoline being attached
on top of already attached multi trampolines

say we have following multi trampolines:

  multi_a [1,2,3] P1 
  multi_b [4,5,6] P2

and want to add another multi trampoline:

  multi_c [1,4,7] P3

you end up with 5 new trampolines: 

  multi_1 [1]   P1,P3
  multi_2 [2,3] P1
  multi_3 [4]   P2,P3
  multi_4 [5,6] P2
  multi_5 [7]   P3

pain points were:
  - lookup for intersection on top of BTF ids, doable but tricky
    https://lore.kernel.org/bpf/20211118112455.475349-20-jolsa@kernel.org/

  - splitting existing trampolines and rollback in case of error,
    because the image update and ip are 2 separate things but we
    do them together
    https://lore.kernel.org/bpf/20211118112455.475349-20-jolsa@kernel.org/

  - trampoline can't be stored and managed in link, because it can
    be split into multiple new trampolines, so I added new layer
    to keep them
    https://lore.kernel.org/bpf/20211118112455.475349-14-jolsa@kernel.org/

  - all this must be locked.. all involved trampolines or one big lock

  - any new attachment of single trampoline is possibly splitting existing
    multi trampoline

  - when multi_c trampoline is detached we don't roll back to get original
    multi_a and multi_b - we keep the split trampolines, so each new attachment
    is making more trampolines and makes the new attachment possibly slower


the RFC for this is here:
  https://lore.kernel.org/bpf/20211118112455.475349-1-jolsa@kernel.org/

it did not bring too much attention so I simplified it down to the current
version ;-)

so far I could not think of better way than start with basic functionality
and add/rethink the complex multi/multi stuff later if needed, hopefully
with some better idea how to do that


note this was no problem for kprobe_multi which uses fprobe/ftrace_ops code
that takes care of this - we just say this function should be called from
set of ips and ftrace machinery does all the merging with existing attachments

but bpf trampolines use ftrace direct interface, which only attaches
trampoline to given function without any other logic 

jirka
