Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451605537B0
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353823AbiFUQPc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 12:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343787AbiFUQPb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 12:15:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98A0B7F5
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63BEEB81A66
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19461C341C0
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655828128;
        bh=TYOQVC81i1HRW1lBhNwIWE8YieYYuN3TwzrOliYk9T0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KADR8SqQQlJ4CqLi9tZLcDH5lkJ3snQ0QVWWYRaB6Osda+lITckhznY3oylk7ymMS
         cGGkFCZsWBMTK6X7+T4NHat+ZeOYjdBLmIqIRhXYFr8oEabReJltuTemi8MQeYrR2X
         WrN4S1DbTKJ+ig1jeceO0ie2IlPSCreWZ/XM6FFokhtUfc5DEewauOTYQdqPI4sMBk
         u/LS2FT0gdHV8lytW46Hr1TBD91ZKg9ga/taCWc8yF8kS1e6itORYZVw6TTmTcvQVH
         GVKTa4Y0O33ma2jquj0R1GWrFcPIz6pVgCK0/a7ye4TSKy3UCsAeHfhT1ZOJm5vFPp
         msr1hkg+kNVpQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3178acf2a92so102021717b3.6
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:15:28 -0700 (PDT)
X-Gm-Message-State: AJIora9pRebDDor6ndlcVGgB1v6fKjfOKGn+efzM/hDmw5e07C19UzJS
        4QZrLagQCI1lZEWU+pBjbse5QK35iBTQPYXT+3XtmQ==
X-Google-Smtp-Source: AGRyM1u7U/wp2bnVIcHuu3W55klvnwuA15ni/KaGRDqrs81ESJCzawl/4FRZoKUPysBDKFh8ylxrh9Snaj0Lfdxl6JQ=
X-Received: by 2002:a81:5296:0:b0:318:14f8:11fc with SMTP id
 g144-20020a815296000000b0031814f811fcmr4103457ywb.210.1655828127163; Tue, 21
 Jun 2022 09:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220621012811.2683313-1-kpsingh@kernel.org> <20220621012811.2683313-4-kpsingh@kernel.org>
 <20220621123646.wxdx4lzk3cgnknjr@apollo.legion> <CAADnVQJ9+gpU-92Umj9Cu0TznFHNHxn67WbQAo+62iWNA+2cCA@mail.gmail.com>
In-Reply-To: <CAADnVQJ9+gpU-92Umj9Cu0TznFHNHxn67WbQAo+62iWNA+2cCA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 21 Jun 2022 18:15:15 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4oyHxh_MwVbazGD5+068JGcMCcP9yUbLsnMoOa8X=rXQ@mail.gmail.com>
Message-ID: <CACYkzJ4oyHxh_MwVbazGD5+068JGcMCcP9yUbLsnMoOa8X=rXQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Allow kfuncs to be used in LSM programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 6:01 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 5:36 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 06:58:09AM IST, KP Singh wrote:
> > > In preparation for the addition of bpf_getxattr kfunc.
> > >
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>

[...]

> > > +++ b/kernel/bpf/btf.c
> > > @@ -7264,6 +7264,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
> > >       case BPF_PROG_TYPE_STRUCT_OPS:
> > >               return BTF_KFUNC_HOOK_STRUCT_OPS;
> > >       case BPF_PROG_TYPE_TRACING:
> > > +     case BPF_PROG_TYPE_LSM:
> > >               return BTF_KFUNC_HOOK_TRACING;
> >
> > Should we define another BTF_KFUNC_HOOK_LSM instead? Otherwise when you register
> > for tracing or lsm progs, you write to the same hook instead, so kfunc enabled
> > for tracing progs also gets enabled for lsm, I guess that is not what user
> > intends when registering kfunc set.
>
> It's probably ok for this case.
> We might combine BTF_KFUNC_HOOK* into fewer hooks and

I did this intentionally. We do this similarly for helpers too and we
unfortunately, we do realize that LSM hooks are not there in all
places (esp. where one is auditing stuff).

So in reality one does use a combination of LSM and tracing hooks
with the policy decision coming from the LSM hook but the state
gets accumulated from different hooks.


> scope them by attach_btf_id.
> Everything is 'tracing' like at the end.
> Upcoming hid-bpf is 'tracing'. lsm is 'tracing'.
> but we may need to reduce the scope of kfuncs
> based on attach point or based on argument type.
> tc vs xdp don't need to be separate sets.
> Their types (skb vs xdp_md) are different, so only
> right kfuncs can be used, but bpf_ct_release() is needed
> in both tc and xdp.
> So we could combine tc and xdp into 'btf_kfunc_hook_networking'
> without compromising the safety.
> acquire vs release ideally would be indicated with btf_tag,
> but gcc still doesn't have support for btf_tag and we cannot
> require the kernel to be built with clang.
> acquire, release, sleepable, ret_null should be flags on a kfunc
> instead of a set. It would be easier to manage and less boilerplate

+1 This would be awesome, I gave it a shot to use btf_tag but hit this
feature gap in GCC.

- KP

> code. Not clear how to do this cleanly.
> export_symbol approach is a bit heavy and requires name being unique
> across kernel and modules.
> func name mangling or typedef-ing comes to mind. not so clean either.
