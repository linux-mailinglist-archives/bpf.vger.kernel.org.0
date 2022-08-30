Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1F65A58CE
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 03:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiH3BFw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 21:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH3BFu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 21:05:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A0719BA
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:05:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id cu2so19179449ejb.0
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D8NbDKQD4Y9w9/6S2GJj5laC4LroI2PSOnNOq807UPI=;
        b=c2hecjWvwORo3Ubwxi0q7MK1nXoE1oOOb1kBq97W8jv3Tt1owIO9lmmajKYul3sB3e
         Myp1Lg8etbGIzaAz4RpxGR9uY2N2sMGVJqWcdkHN/S44WdFyTijFSvtDcuezsTLAxpPb
         T9lchddORfPY7ykpbK4pMr/m0sKRvvew0veEs2JixiD+L+eBS0X1kJWFWV8SgWjwMbv4
         KenIJAjxrP+p+ephxVLLoN6BI7ud8EDejcv07dYxtuByzAwRDgzG51EPgcy8eOhTJJsC
         W8apt7CYDYlpU+YjHpQ3pARnrClrZR2n9B6FDTd2Ju5IBFnEltN5otX9VSGCWI0wqzAp
         xk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D8NbDKQD4Y9w9/6S2GJj5laC4LroI2PSOnNOq807UPI=;
        b=mele+jLOfe/XWEVj8rL86La6O7+XesnfcEnH0U/FgPd4m0shJ+nZza5t4AOTOwrCkN
         9hLHw8JZrR0U8DRrrQpp8SYY16JHiH+3lme10NWIZ/L0B0bKZ6Vj+NYvgn7qpNtn81Xa
         J/9o2YY4/lIGKorV0vyhSVHMtjxTZPoosjI/y48wHD47L3gcwk5yYPaYlaEZMbmdA2xK
         r6SEB/H6jDOjiVzhdi7fIUyV3h6tnnK0SX2oAYuPrl4GhXMRzPwzbsOfTz6UqcqcoNtY
         DYsL3CIqbKVCr6dT/L0SCHOZR9sei/kDcmiF8oVLv4ACQcmClhFoltL0pzAVDO2CxgTn
         JCsA==
X-Gm-Message-State: ACgBeo3zho3798ZEYPPKs7uwfYnfIUsZUHfHoFKy8TtOJ8xDyKjcvQtW
        MKE6KGx1QaUW/8cVvvWxOUuoorhnipdk2Uoab6gw51xmWM0=
X-Google-Smtp-Source: AA6agR5RMVawYxZ1QAQDB7liOw60E0ILrQiaSSi4XiTZ3tPectXC/hcLiFgNGpQaZAuR3e3bHtVkpvWckdoGtZdTQPw=
X-Received: by 2002:a17:906:3a15:b0:73d:80bf:542c with SMTP id
 z21-20020a1709063a1500b0073d80bf542cmr15468205eje.633.1661821547810; Mon, 29
 Aug 2022 18:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com> <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
 <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com> <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
 <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com> <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
 <CAP01T76MUhBcWyTnCBMZ9e0xV3i00XZQBjVAnYrVab_Hgqhx5w@mail.gmail.com>
 <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com> <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
In-Reply-To: <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 18:05:36 -0700
Message-ID: <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Delyan Kratunov <delyank@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Mon, Aug 29, 2022 at 5:45 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 30 Aug 2022 at 02:26, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Aug 29, 2022 at 5:20 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Tue, 30 Aug 2022 at 01:45, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 29, 2022 at 4:18 PM Delyan Kratunov <delyank@fb.com> wrote:
> > > > >
> > > > > >
> > > > > > It is not very precise, but until those maps are gone it delays
> > > > > > release of the allocator (we can empty all percpu caches to save
> > > > > > memory once bpf_map pinning the allocator is gone, because allocations
> > > > > > are not going to be served). But it allows unit_free to be relatively
> > > > > > less costly as long as those 'candidate' maps are around.
> > > > >
> > > > > Yes, we considered this but it's much easier to get to pathological behaviors, by
> > > > > just loading and unloading programs that can access an allocator in a loop. The
> > > > > freelists being empty help but it's still quite easy to hold a lot of memory for
> > > > > nothing.
> > > > >
> > > > > The pointer walk was proposed to prune most such pathological cases while still being
> > > > > conservative enough to be easy to implement. Only races with the pointer walk can
> > > > > extend the lifetime unnecessarily.
> > > >
> > > > I'm getting lost in this thread.
> > > >
> > > > Here is my understanding so far:
> > > > We don't free kernel kptrs from map in release_uref,
> > > > but we should for local kptrs, since such objs are
> > > > not much different from timers.
> > > > So release_uref will xchg all such kptrs and free them
> > > > into the allocator without touching allocator's refcnt.
> > > > So there is no concurrency issue that Kumar was concerned about.
> > >
> > > Haven't really thought through whether this will fix the concurrent
> > > kptr swap problem, but then with this I think you need:
> > > - New helper bpf_local_kptr_xchg(map, map_value, kptr)
> >
> > no. why?
> > current bpf_kptr_xchg(void *map_value, void *ptr) should work.
> > The verifier knows map ptr from map_value.
> >
> > > - Associating map_uid of map, map_value
> > > - Always doing atomic_inc_not_zero(map->usercnt) for each call to
> > > local_kptr_xchg
> > > 1 and 2 because of inner_maps, 3 because of release_uref.
> > > But maybe not a deal breaker?
> >
> > No run-time refcnts.
>
> How is future kptr_xchg prevented for the map after its usercnt drops to 0?
> If we don't check it at runtime we can xchg in non-NULL kptr after
> release_uref callback.
> For timer you are taking timer spinlock and reading map->usercnt in
> timer_set_callback.

Sorry I confused myself and others with release_uref.
I meant map_poke_untrack-like call.
When we drop refs from used maps in __bpf_free_used_maps
we walk all elements.
Similar idea here.
When prog is unloaded it cleans up all objects it allocated
and stored into maps before dropping refcnt-s
in prog->used_allocators.
