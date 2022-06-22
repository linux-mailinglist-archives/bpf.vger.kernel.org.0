Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F03553FF4
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 03:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355309AbiFVBRh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 21:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiFVBRf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 21:17:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B24031513
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 18:17:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k127so9462707pfd.10
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 18:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KAysJOCMi0bv17OYU+i1GNhggWE5A+KygazE38/Iyj0=;
        b=Fdv7BabVyuzv3SGc5QFZUJ1YtCDHYy1xuFjYzbQZBsgGbpT1SUOtbTtIooByoaO6iO
         vxJ/yGjMCc5/fRpJX2TOtDqLBbM4mlOy35VhuUXxJ1m4Gc9DHiGyu4vSl7jcg0fHwFBH
         ks11rFJ3qcNWuGI0Ug0uhBxs8pepVaRqCttCBW1UAQzk9D4Pj2xQ3APtkmf25BBCHDe/
         C3gIdNb04CR/v+EyMMznSPrrB5n32XfUlBuAbDBD5CRzFCC3csHOZN9D4PglQK6AfVAe
         VkGxAimbepWxRONUzWXVL3uuvR8aS7QvlRDnTAjGNSm7jouslgFMCzbEIeiEmt0R3ZbQ
         vlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KAysJOCMi0bv17OYU+i1GNhggWE5A+KygazE38/Iyj0=;
        b=GUPRFf1ZHW6jtKV6drRMYSlsXHkr93fs4igNxLBz2lugcb/iQRygJZnuIQwFNPAf2e
         Nkec//ixDGltSkktgnaZxfPIUqoRbEGwV7N2o0fSEvgFCvbaEMFKFlc9vmunCc+x6tMb
         9wyt3hANFdeoQ1q/KMpTL5yGin8kv5TBmcTr1m6/D6wicQN5xgpcSl3lEfCFD7Waz2it
         2o2F3BZsQEs6lI35DfOWpszm3jCZ3qzrwgXOBqfTID6fzvK2+XS5OFAgpZgp60mUISbJ
         1FuakN+GUNNgIwKUZucR22Wxu/6BaHDJSRGzdVMbf2a1+EXWOhyrvFIAbFBsbEEqKp6/
         6QNA==
X-Gm-Message-State: AJIora/CbF4dNQ/xi/ciH/GvF9n3Vs/B9KPchzjt9vkRj/kyjKdUpXLK
        Q/d9eqgi0B3fdiCCc4p88nY=
X-Google-Smtp-Source: AGRyM1vaH+0NRa0FImX0vGcOMilrObCFscdRtN4+NIcKZ+D4cF1T+JRg1PaI0bwNjyXCA5UgfKSZJw==
X-Received: by 2002:a05:6a00:2349:b0:51c:29c0:82f6 with SMTP id j9-20020a056a00234900b0051c29c082f6mr32992464pfj.32.1655860653650;
        Tue, 21 Jun 2022 18:17:33 -0700 (PDT)
Received: from localhost ([2405:201:6014:d0c0:79de:f3f4:353c:8616])
        by smtp.gmail.com with ESMTPSA id o17-20020a170903301100b0016223016d79sm7947301pla.90.2022.06.21.18.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 18:17:33 -0700 (PDT)
Date:   Wed, 22 Jun 2022 06:47:29 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Allow kfuncs to be used in LSM
 programs
Message-ID: <20220622011729.abw56td3w27v55ft@apollo.legion>
References: <20220621012811.2683313-1-kpsingh@kernel.org>
 <20220621012811.2683313-4-kpsingh@kernel.org>
 <20220621123646.wxdx4lzk3cgnknjr@apollo.legion>
 <CAADnVQJ9+gpU-92Umj9Cu0TznFHNHxn67WbQAo+62iWNA+2cCA@mail.gmail.com>
 <CACYkzJ4oyHxh_MwVbazGD5+068JGcMCcP9yUbLsnMoOa8X=rXQ@mail.gmail.com>
 <20220621173545.g74htfbjabx7lk4a@apollo.legion>
 <20220621201157.q7rqsqmghpjnxe5b@macbook-pro-3.dhcp.thefacebook.com>
 <CACYkzJ7N+u_n56f=GBcxd-UgejHF+yidndSq6OnBF47MS80iog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ7N+u_n56f=GBcxd-UgejHF+yidndSq6OnBF47MS80iog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 01:55:29AM IST, KP Singh wrote:
> On Tue, Jun 21, 2022 at 10:12 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 11:05:45PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > On Tue, Jun 21, 2022 at 09:45:15PM IST, KP Singh wrote:
> > > > On Tue, Jun 21, 2022 at 6:01 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jun 21, 2022 at 5:36 AM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 21, 2022 at 06:58:09AM IST, KP Singh wrote:
> > > > > > > In preparation for the addition of bpf_getxattr kfunc.
> > > > > > >
> > > > > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > >
> > > > [...]
> > > >
> > > > > > > +++ b/kernel/bpf/btf.c
> > > > > > > @@ -7264,6 +7264,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
> > > > > > >       case BPF_PROG_TYPE_STRUCT_OPS:
> > > > > > >               return BTF_KFUNC_HOOK_STRUCT_OPS;
> > > > > > >       case BPF_PROG_TYPE_TRACING:
> > > > > > > +     case BPF_PROG_TYPE_LSM:
> > > > > > >               return BTF_KFUNC_HOOK_TRACING;
> > > > > >
> > > > > > Should we define another BTF_KFUNC_HOOK_LSM instead? Otherwise when you register
> > > > > > for tracing or lsm progs, you write to the same hook instead, so kfunc enabled
> > > > > > for tracing progs also gets enabled for lsm, I guess that is not what user
> > > > > > intends when registering kfunc set.
> > > > >
> > > > > It's probably ok for this case.
> > > > > We might combine BTF_KFUNC_HOOK* into fewer hooks and
> > > >
> > > > I did this intentionally. We do this similarly for helpers too and we
> > > > unfortunately, we do realize that LSM hooks are not there in all
> > > > places (esp. where one is auditing stuff).
> > > >
> > > > So in reality one does use a combination of LSM and tracing hooks
> > > > with the policy decision coming from the LSM hook but the state
> > > > gets accumulated from different hooks.
> > > >
> > > >
> > > > > scope them by attach_btf_id.
> > > > > Everything is 'tracing' like at the end.
> > > > > Upcoming hid-bpf is 'tracing'. lsm is 'tracing'.
> > > > > but we may need to reduce the scope of kfuncs
> > > > > based on attach point or based on argument type.
> > > > > tc vs xdp don't need to be separate sets.
> > > > > Their types (skb vs xdp_md) are different, so only
> > > > > right kfuncs can be used, but bpf_ct_release() is needed
> > > > > in both tc and xdp.
> > > > > So we could combine tc and xdp into 'btf_kfunc_hook_networking'
> > > > > without compromising the safety.
> > > > > acquire vs release ideally would be indicated with btf_tag,
> > > > > but gcc still doesn't have support for btf_tag and we cannot
> > > > > require the kernel to be built with clang.
> > > > > acquire, release, sleepable, ret_null should be flags on a kfunc
> > > > > instead of a set. It would be easier to manage and less boilerplate
> > > >
> > > > +1 This would be awesome, I gave it a shot to use btf_tag but hit this
> > > > feature gap in GCC.
> > > >
> > > > - KP
> > > >
> > > > > code. Not clear how to do this cleanly.
> > > > > export_symbol approach is a bit heavy and requires name being unique
> > > > > across kernel and modules.
> > > > > func name mangling or typedef-ing comes to mind. not so clean either.
> > >
> > > How does this approach look to 'tag' a kfunc?
> > >
> > > https://godbolt.org/z/jGeK6Y49K
> > >
> > > Then we find the function whose symbol should be emitted and available in BTF
> > > with the prefix (__kfunc_name_) and read off the tag values. Due to the extern
> > > inline it should still inline the definition, so there is no overhead at
> > > runtime.
> >
> > No run-time overhead, but code size duplication is prohibitive.
> > Both functions will have full body.
> > We can hack around with another noinline function that both will call,
> > but it's getting ugly.
> >

You can just make the __foobar_1_2 noinline instead: https://godbolt.org/z/zT18h81T6

but anyway...

> > > As you see in godbolt, __foobar_1_2 symbol is visible, with 1 and 2 being tag
> > > values. Substituting tag name with underlying value makes parsing easier. We
> > > can have fixed number of slots and keep others as 0 (ignore).
> > >
> > > It can be extended to also tag arguments, which I already did before at [0], but
> > > never sent out. Then we don't need the suffixes or special naming of arguments
> > > to indicate some tag.
> > >
> > > e.g.
> > >
> > > bpf_ct_release will be:
> > >
> > > KFUNC_CALL_0(void, bpf_ct_release, __kfunc_release,
> > >            KARG(struct nf_conn *, nfct, __ptr_ref))
> > > {
> > >       ...
> > > }
> >
> > -struct nf_conn *
> > -bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
> > -                 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
> > +KFUNC_CALL_5(struct nf_conn *, bpf_skb_ct_lookup,
> > +            KARG(struct __sk_buff *, skb_ctx, PTR_TO_CTX),
> > +            KARG(struct bpf_sock_tuple *, bpf_tuple, PTR_TO_MEM),
> > +            KARG(u32, tuple__sz, SIZE),
> > +            KARG(struct bpf_ct_opts *, opts, PTR_TO_MEM),
> > +            KARG(u32, opts__sz, SIZE))
> >
> > I think it's too ugly for majority of kernel folks to accept.
>
> I agree. It's quite a creative idea :D
>
> but will pollute the symbol table a lot.
>
> > We will have a lot more kfuncs than we have now. Above code will be
> > present in many different subsystems. The trade-off is not worth it.
> > __sz suffix convention works. Similar approach can be used.
> > This is orthogonal discussion anyway.
> >
> > Back to kfunc tagging.
> > How about we use
> >   BTF_SET_START8(list)
> >   BTF_ID_FLAGS(func, bpf_xdp_ct_lookup, ACQUIRE | RET_NULL)
> >   BTF_ID_FLAGS(func, bpf_ct_release, RELEASE)
> >   BTF_SET_END8(list)
>
> SGTM. Kumar is this something you can send a patch for?
>
> Also, while we are at it, it would be great documenting what these sets
> are in:
>

Yes, the resolve_btfids method looks ok to me. I will send a patch for both of
these things.

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/btf.h#n31
>
> - KP
>
>
>
>
> >
> > where BTF_SET_START8 macro will do "__BTF_ID__set8__" #name
> > so that resolve_btfid side knows that it needs to ignore 4 bytes after btf_id
> > when it's doing set sorting.
> > The kernel side btf_id_set_contains() would need to call bsearch()
> > with sizeof(u64) instead of sizeof(u32).
> >
> > The verifier side will be cleaner and faster too.
> > Instead of two bsearch calls (that are about to become 3 calls with sleepable set):
> >                 rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> >                                                 BTF_KFUNC_TYPE_RELEASE, func_id);
> >                 kptr_get = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> >                                                      BTF_KFUNC_TYPE_KPTR_ACQUIRE, func_id);
> > It will be a single call plus flag check.

--
Kartikeya
