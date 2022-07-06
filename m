Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F15695C4
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 01:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiGFXXP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 19:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiGFXXL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 19:23:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185C2BB29
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 16:23:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so21073562edb.9
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0ZFkLPHJzfEYXmetfXf9lMt20DN6mMWrCB9iVapBS4=;
        b=VRNLmRhuPzknCE/58AeA5wYE/FE0RwkgkDron0lnlL8uTOJX5wCFBXan3bT+Gj8DBV
         PqrVg0reJw6m4buFrEN7BjhIh3DXPRF1sB21BCpza2RLAZNQfdh42mTPqwnkjc7FIGEm
         l94iUH0eaciOD68py/6rurX3WMGfXVfs3Xm/w+8F0fw71I+zIyCqwN0gkA9ysAodZBsC
         KmXpcF5y77I4+gw4DPhmJpiOe8T18/HeIkz6KX1Ti8Y6iGp0+nHy8alTVHZBr7NWy5ze
         W2K4TVY8gXUIWCkav6IBzw7HEtRRWMIPI3N2uOGxEnNw23CHERDrfwqoCFpSRJ+Jjzd2
         WFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0ZFkLPHJzfEYXmetfXf9lMt20DN6mMWrCB9iVapBS4=;
        b=rtH64HX1V7oWLIrCvFMW6O7spTc737CK839SHphINfOns0dTJcVbA1KNHlSoqCH1WT
         DWxwhj7r32h1Pvo86qlHdlQD1uBMfCzk+vBO2iTNLonm3JZbJY2xfYIRjfHTgCJpv1Aw
         izwOprgcfujlmTzDek1564jmAHunPGe9QHD7US4qeqLyuNmLMiVozJU200uzeMNLjvlt
         biWBunPlxPq6OVu5MUZZ+tvRtz/+7uqfBECWhNklccY48OHznfvTRbU9yVpvxyK/k4n4
         ONWHk73yLmFqnjG4kFk5ySSIh0uLowvsaOmuOdzsv2b56WO+AEetwtfyM0hf569BnkmK
         Epig==
X-Gm-Message-State: AJIora80mBc+k5pZ0YlUSIMQtCVK1kJY+d45sqYR9TRsijk7hg0dYCou
        3morpo3eLYsExBVImxGM4ZYNJHGT4Jrw/YcxGyzN3ASQ
X-Google-Smtp-Source: AGRyM1sl9m2uuD9+jE5b+KRE+yam2Lcab6zQrnxfA3ccMLJcM8hZA38bv3nM4Jo4A4fNpS+7wdd+cpFA4AvUTgO42yM=
X-Received: by 2002:a05:6402:2cd:b0:43a:70f7:1af2 with SMTP id
 b13-20020a05640202cd00b0043a70f71af2mr20127796edx.357.1657149788960; Wed, 06
 Jul 2022 16:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-2-laoar.shao@gmail.com>
 <CAADnVQJEK+Puyz8b4eUV3H7Z+OtrvHd4MU42OsPiBodMQxEw-g@mail.gmail.com>
 <YsXd2Tah+irhth9t@castle> <CAADnVQ+c_2Q6GxH3E0iD0RkOy2H2-UhuYL4V3v2BTQ6sZNxQAA@mail.gmail.com>
 <YsYSjAUGUkERUZ4q@castle>
In-Reply-To: <YsYSjAUGUkERUZ4q@castle>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 Jul 2022 16:22:50 -0700
Message-ID: <CAADnVQLiY=u2ii5g8ANRppzxfLGBrMSALtguNG=KdmGV8+xt0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
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

On Wed, Jul 6, 2022 at 3:54 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Wed, Jul 06, 2022 at 03:11:46PM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 6, 2022 at 12:09 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > On Wed, Jul 06, 2022 at 09:47:32AM -0700, Alexei Starovoitov wrote:
> > > > On Wed, Jul 6, 2022 at 8:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >
> > > > > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > > > > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > > > > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > > > > easily break the memcg limit by force charge. So it is very dangerous to
> > > > > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > > > > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > > > > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > > > > too much memory.
> > > > >
> > > > > We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> > > > > too memory expensive for some cases. That means removing __GFP_HIGH
> > > > > doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> > > > > it-avoiding issues caused by too much memory. So let's remove it.
> > > > >
> > > > > The force charge of GFP_ATOMIC was introduced in
> > > > > commit 869712fd3de5 ("mm: memcontrol: fix network errors from failing
> > > > > __GFP_ATOMIC charges") by checking __GFP_ATOMIC, then got improved in
> > > > > commit 1461e8c2b6af ("memcg: unify force charging conditions") by
> > > > > checking __GFP_HIGH (that is no problem because both __GFP_HIGH and
> > > > > __GFP_ATOMIC are set in GFP_AOMIC). So, if we want to fix it in memcg,
> > > > > we have to carefully verify all the callsites. Now that we can fix it in
> > > > > BPF, we'd better not modify the memcg code.
> > > > >
> > > > > This fix can also apply to other run-time allocations, for example, the
> > > > > allocation in lpm trie, local storage and devmap. So let fix it
> > > > > consistently over the bpf code
> > > > >
> > > > > __GFP_KSWAPD_RECLAIM doesn't cooperate well with memcg pressure neither
> > > > > currently. But the memcg code can be improved to make
> > > > > __GFP_KSWAPD_RECLAIM work well under memcg pressure if desired.
> > > >
> > > > Could you elaborate ?
> > > >
> > > > > It also fixes a typo in the comment.
> > > > >
> > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > >
> > > > Roman, do you agree with this change ?
> > >
> > > Yes, removing __GFP_HIGH makes sense to me. I can imagine we might want
> > > it for *some* bpf allocations, but applying it unconditionally looks wrong.
> >
> > Yeah. It's a difficult trade-off to make without having the data
> > to decide whether removing __GFP_HIGH can cause issues or not,
>
> Yeah, the change looks reasonable, but it's hard to say without giving
> it a good testing in (something close to) a production environment.
>
> > but do you agree that __GFP_HIGH doesn't cooperate well with memcg ?
> > If so it's a bug on memcg side, right?
>
> No. Historically we allowed high-prio allocations to exceed the memcg limit
> because otherwise there were too many stability and performance issues.
> It's not a memcg bug, it's a way to avoid exposing ENOMEM handling bugs all over
> the kernel code. Without memory cgroups GFP_ATOMIC allocations rarely fail
> and a lot of code paths in the kernel are not really ready for it (at least
> it was the case several years ago, maybe things are better now).
>
> But it was usually thought in the context of small(ish) allocations which do not
> change the global memory usage picture. Subsequent "normal" allocations are
> triggering reclaim/OOM, so from a user's POV the limit works as expected.
>
> But with the ownership model and size of bpf maps it's a different story:
> if a bpf map belongs to an abandoned cgroup, it might consume a lot of memory
> and there will be no "normal" allocations. So cgroup memory limit will be never
> applied. It's a valid issue, I agree with Yafang here.

Understood.

> > but we should probably
> > apply this band-aid on bpf side to fix the bleeding.
> > Later we can add a knob to allow __GFP_HIGH usage on demand from
> > bpf prog.
>
> Yes, it sounds like a good idea. I have to think what's the best approach
> here, it's not obvious for me.

Ok. Applied this patch for now.
