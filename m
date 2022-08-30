Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96745A5883
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 02:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiH3Apa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 20:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH3Ap3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 20:45:29 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9D28E0B
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:45:27 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id v15so2414489iln.6
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1zd5fGejGBpLUlBIRwzL372LVmPzuZvwZU6P0C6+moM=;
        b=KJpC+Bmqj6/chPsq80fD+zf9kx327cXXgcZ/gOiuYwY7suFbWVxJ3yvcgofXKOBGuT
         2aqtn54EUOUpYr7vQWnebmsubIJQAKNPn8Rf/TIPIET2zaqHnDrUCE0qppaVNeJ6rQlN
         XBtuGvhuPe5DbHN2Iv3pQkL7BVwuPYk9d7ziVO+oo+QVJq1vNcuSNHNxV/AV1SjuNI9o
         gVQG7JQKwDMrceDfeqWh9esOO2BbbbiEE8+puhcoxagY6Fx4HABeowBolgJ9SI8WU18q
         E8f4z2V3V1vTGV03VrGA7SGuBV07obetFGxVAO/zs5tnznbeOPUgG+t1HiutjbO7QQWc
         423A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1zd5fGejGBpLUlBIRwzL372LVmPzuZvwZU6P0C6+moM=;
        b=3WwLc181R/gUT0TMCb80/GdsgdCET7dJcseUUwVQkiV7+tv5z/e2D3e8WQBKj0BlkE
         g5tcLC3fXC4eFclgqLMcFTrzUy3cuipQYTcaO3s0IuYM/Cif+pL/DfBn17JkmOJipMVv
         RkgCYqTFPhX25Cm6jjbr2gRvQZA0uD/zd+exmkJMH5W0RIObbMYnv+dgRhh0RQEoTV0d
         GuawFWLpgW2ozRWcQkQQaaFcJctSFYWAjS6SdeFZWHTO2htMVNTUd6e01aiMfpZ6PCto
         Igv7qf7rcLvvD0Knd5F5MyPjx0eTOJ1QoSeqFV41HoMo3CqwiskD7PrBmIygC0lbaxgJ
         ebgA==
X-Gm-Message-State: ACgBeo37HuYrPRhr7weUcyhZCic35DWsTgKNN9LpWOMojztkm92fwdDH
        47iiVYWi0NvLgyY2kK2yG8PWbKVQIvyCdfCEx2k=
X-Google-Smtp-Source: AA6agR7VpLlQmVc343ftgT78n4HUG9H4+NzwXwQUUDDHzJxIGihUZAnJOe5xq1NAy8XcJKLrOK38oysJJU/3EFkBCJs=
X-Received: by 2002:a05:6e02:168d:b0:2ea:f6b7:d954 with SMTP id
 f13-20020a056e02168d00b002eaf6b7d954mr4460038ila.216.1661820327046; Mon, 29
 Aug 2022 17:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com> <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
 <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com> <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
 <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com> <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
 <CAP01T76MUhBcWyTnCBMZ9e0xV3i00XZQBjVAnYrVab_Hgqhx5w@mail.gmail.com> <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
In-Reply-To: <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 30 Aug 2022 02:44:51 +0200
Message-ID: <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, 30 Aug 2022 at 02:26, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 29, 2022 at 5:20 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, 30 Aug 2022 at 01:45, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Aug 29, 2022 at 4:18 PM Delyan Kratunov <delyank@fb.com> wrote:
> > > >
> > > > >
> > > > > It is not very precise, but until those maps are gone it delays
> > > > > release of the allocator (we can empty all percpu caches to save
> > > > > memory once bpf_map pinning the allocator is gone, because allocations
> > > > > are not going to be served). But it allows unit_free to be relatively
> > > > > less costly as long as those 'candidate' maps are around.
> > > >
> > > > Yes, we considered this but it's much easier to get to pathological behaviors, by
> > > > just loading and unloading programs that can access an allocator in a loop. The
> > > > freelists being empty help but it's still quite easy to hold a lot of memory for
> > > > nothing.
> > > >
> > > > The pointer walk was proposed to prune most such pathological cases while still being
> > > > conservative enough to be easy to implement. Only races with the pointer walk can
> > > > extend the lifetime unnecessarily.
> > >
> > > I'm getting lost in this thread.
> > >
> > > Here is my understanding so far:
> > > We don't free kernel kptrs from map in release_uref,
> > > but we should for local kptrs, since such objs are
> > > not much different from timers.
> > > So release_uref will xchg all such kptrs and free them
> > > into the allocator without touching allocator's refcnt.
> > > So there is no concurrency issue that Kumar was concerned about.
> >
> > Haven't really thought through whether this will fix the concurrent
> > kptr swap problem, but then with this I think you need:
> > - New helper bpf_local_kptr_xchg(map, map_value, kptr)
>
> no. why?
> current bpf_kptr_xchg(void *map_value, void *ptr) should work.
> The verifier knows map ptr from map_value.
>
> > - Associating map_uid of map, map_value
> > - Always doing atomic_inc_not_zero(map->usercnt) for each call to
> > local_kptr_xchg
> > 1 and 2 because of inner_maps, 3 because of release_uref.
> > But maybe not a deal breaker?
>
> No run-time refcnts.

How is future kptr_xchg prevented for the map after its usercnt drops to 0?
If we don't check it at runtime we can xchg in non-NULL kptr after
release_uref callback.
For timer you are taking timer spinlock and reading map->usercnt in
timer_set_callback.

Or do you mean this case can never happen with your approach?

> All possible allocators will be added to map->used_allocators
> at prog load time and allocator's refcnt incremented.
> At run-time bpf_kptr_xchg(map_value, ptr) will be happening
> with an allocator A which was added to that map->used_allocators
> already.
