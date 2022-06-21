Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7226F5538F3
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 19:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiFURfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 13:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiFURfx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 13:35:53 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6539F2C673
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 10:35:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g186so13758940pgc.1
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 10:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h+Uz1nAl8kE61rL93ViU6yTD8YAGxaTbU2QySnrXqPw=;
        b=lojaSoyPCR2wS7A6+ybVvSi6OrjPjmtqBAbQdOdHg63TEk6zSWXcTzaDFyuy3uROFj
         qW8EZjJhSRb3E4zpAeB7wECkElZAvSc20gxr0uKqKEaNNL32lSeI0YsuCWq4seDaKjry
         296t1EcRyyy6CrDHzE95pzJGzZ3ACXkD6jm1h8SCTsjbFpPNKVQdTLhNIW0xfSYYZXTd
         5eQeHQSz025qpy0uxahbVJnKgab0dANukPKZoQgEK51y6kWIGsz2IEAe3aSMz+ejEYGP
         twUpW+O0vlXymn2asyn0q0uu6HRO5VmELBC3Nc0C0KKQBtxGf4jHPtn+7S1xb4e0LRtb
         WVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h+Uz1nAl8kE61rL93ViU6yTD8YAGxaTbU2QySnrXqPw=;
        b=ct/NgbPh+ZAA0rdoLcTZlNCfM8V/iUIR4JURx3gQRYnoKtr/NzQsGO6jPC8FyXd42I
         zYUd/Bb8cgBSkZfNNUbbpi0u7B4sv64aIWemIrVwyFrA8nNj5DAEIUf+PcxC1kDF1Mkk
         QVqO4yK/6x9Qj2s2mWHuknJXSSUBB2d2pcZGJ5C3cPoEAdV+iUlOfcv5btfjW5yB/qZM
         eg2f+Tp86FgkpSKGy1q6naWT4TZOVVyoAEricH/tB+KQsGffOtc/jwZZ17EUvzg5tUGl
         oNcTF2ip1WZproPxbrN4ikEErWpSDOvJaHGXamp6oE/WmK1mzujDlKwIcA4KUx18HL7u
         M8UA==
X-Gm-Message-State: AJIora8QbwWAYVK2p9xVPGdQV9v89nzNX1Hj5rxBdMOd9i2OeUNKFt62
        GBN4Yu4aBsdaTUw4lglgTYI=
X-Google-Smtp-Source: AGRyM1vrLT+NXOwuBSMJCBHBFymZh3Wvc4FBqmbw1PoCKSJXt2CE+HahSu0eEgiOUbg7HMwCAiD77A==
X-Received: by 2002:a05:6a00:114e:b0:51b:8ff5:e05a with SMTP id b14-20020a056a00114e00b0051b8ff5e05amr31129019pfm.37.1655832951817;
        Tue, 21 Jun 2022 10:35:51 -0700 (PDT)
Received: from localhost ([2405:201:6014:d0c0:79de:f3f4:353c:8616])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902714f00b00168c1668a49sm10851504plm.85.2022.06.21.10.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 10:35:51 -0700 (PDT)
Date:   Tue, 21 Jun 2022 23:05:45 +0530
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
Message-ID: <20220621173545.g74htfbjabx7lk4a@apollo.legion>
References: <20220621012811.2683313-1-kpsingh@kernel.org>
 <20220621012811.2683313-4-kpsingh@kernel.org>
 <20220621123646.wxdx4lzk3cgnknjr@apollo.legion>
 <CAADnVQJ9+gpU-92Umj9Cu0TznFHNHxn67WbQAo+62iWNA+2cCA@mail.gmail.com>
 <CACYkzJ4oyHxh_MwVbazGD5+068JGcMCcP9yUbLsnMoOa8X=rXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ4oyHxh_MwVbazGD5+068JGcMCcP9yUbLsnMoOa8X=rXQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 09:45:15PM IST, KP Singh wrote:
> On Tue, Jun 21, 2022 at 6:01 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 5:36 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Tue, Jun 21, 2022 at 06:58:09AM IST, KP Singh wrote:
> > > > In preparation for the addition of bpf_getxattr kfunc.
> > > >
> > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> [...]
>
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -7264,6 +7264,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
> > > >       case BPF_PROG_TYPE_STRUCT_OPS:
> > > >               return BTF_KFUNC_HOOK_STRUCT_OPS;
> > > >       case BPF_PROG_TYPE_TRACING:
> > > > +     case BPF_PROG_TYPE_LSM:
> > > >               return BTF_KFUNC_HOOK_TRACING;
> > >
> > > Should we define another BTF_KFUNC_HOOK_LSM instead? Otherwise when you register
> > > for tracing or lsm progs, you write to the same hook instead, so kfunc enabled
> > > for tracing progs also gets enabled for lsm, I guess that is not what user
> > > intends when registering kfunc set.
> >
> > It's probably ok for this case.
> > We might combine BTF_KFUNC_HOOK* into fewer hooks and
>
> I did this intentionally. We do this similarly for helpers too and we
> unfortunately, we do realize that LSM hooks are not there in all
> places (esp. where one is auditing stuff).
>
> So in reality one does use a combination of LSM and tracing hooks
> with the policy decision coming from the LSM hook but the state
> gets accumulated from different hooks.
>
>
> > scope them by attach_btf_id.
> > Everything is 'tracing' like at the end.
> > Upcoming hid-bpf is 'tracing'. lsm is 'tracing'.
> > but we may need to reduce the scope of kfuncs
> > based on attach point or based on argument type.
> > tc vs xdp don't need to be separate sets.
> > Their types (skb vs xdp_md) are different, so only
> > right kfuncs can be used, but bpf_ct_release() is needed
> > in both tc and xdp.
> > So we could combine tc and xdp into 'btf_kfunc_hook_networking'
> > without compromising the safety.
> > acquire vs release ideally would be indicated with btf_tag,
> > but gcc still doesn't have support for btf_tag and we cannot
> > require the kernel to be built with clang.
> > acquire, release, sleepable, ret_null should be flags on a kfunc
> > instead of a set. It would be easier to manage and less boilerplate
>
> +1 This would be awesome, I gave it a shot to use btf_tag but hit this
> feature gap in GCC.
>
> - KP
>
> > code. Not clear how to do this cleanly.
> > export_symbol approach is a bit heavy and requires name being unique
> > across kernel and modules.
> > func name mangling or typedef-ing comes to mind. not so clean either.

How does this approach look to 'tag' a kfunc?

https://godbolt.org/z/jGeK6Y49K

Then we find the function whose symbol should be emitted and available in BTF
with the prefix (__kfunc_name_) and read off the tag values. Due to the extern
inline it should still inline the definition, so there is no overhead at
runtime.

As you see in godbolt, __foobar_1_2 symbol is visible, with 1 and 2 being tag
values. Substituting tag name with underlying value makes parsing easier. We
can have fixed number of slots and keep others as 0 (ignore).

It can be extended to also tag arguments, which I already did before at [0], but
never sent out. Then we don't need the suffixes or special naming of arguments
to indicate some tag.

e.g.

bpf_ct_release will be:

KFUNC_CALL_0(void, bpf_ct_release, __kfunc_release,
	     KARG(struct nf_conn *, nfct, __ptr_ref))
{
	...
}

__kfunc_acquire and __kfunc_ret_null will go in the same place as __kfunc_release.

We may also allow tagging as ptr_to_btf_id or ptr_to_mem etc. to force passing a
certain register type and avoid ambiguity.

 [0]: https://gist.github.com/kkdwivedi/7839cc9e4f002acc3e15350b1b86c88c

--
Kartikeya
