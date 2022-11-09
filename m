Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A4623764
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 00:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKIXVd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 18:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKIXVb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 18:21:31 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9283A2098F
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 15:21:30 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m22so763547eji.10
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 15:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n1SZ3vzt0YGsq/zYmDVYLVKEUEtkCdkOpIfEHyLK3Ak=;
        b=lWXkIjVux6st7WW6u9GQbJkOaI1OdYPGahsDdtCwINaAIgn02fn56S/cbQIf6uz09a
         1xXD64ef0EJO6ZlcY/O8RzN6YRbVZKpCrF1ZJN9XRqK+R6+efdnWyU91y1voIU0s1R0P
         kF2sIS6s8t5ac6fRw//jbyvcwy9r7wWL6qcYbeOHks5qJmHDnsi40PQjwDSKMxO8dUhR
         7D8yb5nkKuq3sg6RBd8fylTcJuQOTFViqKAjcL0Tgqrw+W6nIVwNHol9SuplJOBlDEV3
         DDhhpnkcGj7BkHi3Yn+/l0qReBB/Tb4k07Ra5ZQdhV22Hf4I+GaL9UCTciQWyzb78VRy
         SCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1SZ3vzt0YGsq/zYmDVYLVKEUEtkCdkOpIfEHyLK3Ak=;
        b=o0quuMCWXqJs5QEfFL4nemvMFRCoUxmGtFY0TfhdCJ1xbS7kzYnzboLyYWO0v46g2M
         nK+rGIz+6OpkhHfsakWYXoq9W7ZisAeQ2DyDKe9Esd7vCVP07DW5Ktncm1920e8JGw9z
         ZOtkF27OR/akwB/s2e3IcoiUvEQhMu7WoGh9GktqTG6796B/W2KykWG8fbQ8nJxzBgM1
         ON59HN2f7M+kCT9HOfeXbgvceXTTABZROitLrwcQSjMIKp2FIrDGPKsJKICjjXQDyjjO
         EVjobnuU04YbRFecNX5rxT4zL4foUY273B8XzHBMoZUGjaqLKvFiipnYmUHu7ZaVLda5
         c91g==
X-Gm-Message-State: ANoB5plleh1MkLOngQZFT2GRiAGfpHmVplOZMxQUyJQTwszQtazmk1up
        Nrs93yw/sGd1wqEmwstamjQQmvbgcbsURI62KwBmIHBS
X-Google-Smtp-Source: AA0mqf5gec10grR7somgidRKcV+oxuxEKDeIHXWfbZ0pmGIom4uXweKdAFpxABB9/MMJa0MV8Rj9G6MAJIuwjtsR7zc=
X-Received: by 2002:a17:906:4e86:b0:7ae:8d01:81f8 with SMTP id
 v6-20020a1709064e8600b007ae8d0181f8mr4050097eju.115.1668036088936; Wed, 09
 Nov 2022 15:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-7-memxor@gmail.com>
 <CAEf4BzZRaN_zd07jvtom6QJEEDGmFQTLJy4BM1bKi1MH5+n5QA@mail.gmail.com>
 <20221109000016.np325iqjjegvdose@apollo> <CAEf4BzZ0h4yda0_M8+wgpsHAgm_J5oeUtaxm8V-jqy3gNjFWdg@mail.gmail.com>
 <CAADnVQL1ZojMCzt5FZU5Di2m6W3JYTrGZHBLoMQCinQfyL=4Og@mail.gmail.com>
In-Reply-To: <CAADnVQL1ZojMCzt5FZU5Di2m6W3JYTrGZHBLoMQCinQfyL=4Og@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 15:21:16 -0800
Message-ID: <CAEf4BzYwqLJSugU4=Q=bwG++vDPxrBRXYjjSXk-pvq-ik9JCpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 06/25] bpf: Introduce local kptrs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 5:32 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 8, 2022 at 4:36 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 8, 2022 at 4:00 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > On Wed, Nov 09, 2022 at 04:59:41AM IST, Andrii Nakryiko wrote:
> > > > On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > > >
> > > > > Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
> > > > > program BTF. This is indicated by the presence of MEM_ALLOC type flag in
> > > > > reg->type to avoid having to check btf_is_kernel when trying to match
> > > > > argument types in helpers.
> > > > >
> > > > > Refactor btf_struct_access callback to just take bpf_reg_state instead
> > > > > of btf and btf_type paramters. Note that the call site in
> > > > > check_map_access now simulates access to a PTR_TO_BTF_ID by creating a
> > > > > dummy reg on stack. Since only the type, btf, and btf_id of the register
> > > > > matter for the checks, it can be done so without complicating the usual
> > > > > cases elsewhere in the verifier where reg->btf and reg->btf_id is used
> > > > > verbatim.
> > > > >
> > > > > Whenever walking such types, any pointers being walked will always yield
> > > > > a SCALAR instead of pointer. In the future we might permit kptr inside
> > > > > local kptr (either kernel or local), and it would be permitted only in
> > > > > that case.
> > > > >
> > > > > For now, these local kptrs will always be referenced in verifier
> > > > > context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> > > > > to such objects, as long fields that are special are not touched
> > > > > (support for which will be added in subsequent patches). Note that once
> > > > > such a local kptr is marked PTR_UNTRUSTED, it is no longer allowed to
> > > > > write to it.
> > > > >
> > > > > No PROBE_MEM handling is therefore done for loads into this type unless
> > > > > PTR_UNTRUSTED is part of the register type, since they can never be in
> > > > > an undefined state, and their lifetime will always be valid.
> > > > >
> > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > ---
> > > > >  include/linux/bpf.h              | 28 ++++++++++++++++--------
> > > > >  include/linux/filter.h           |  8 +++----
> > > > >  kernel/bpf/btf.c                 | 16 ++++++++++----
> > > > >  kernel/bpf/verifier.c            | 37 ++++++++++++++++++++++++++------
> > > > >  net/bpf/bpf_dummy_struct_ops.c   | 14 ++++++------
> > > > >  net/core/filter.c                | 34 ++++++++++++-----------------
> > > > >  net/ipv4/bpf_tcp_ca.c            | 13 ++++++-----
> > > > >  net/netfilter/nf_conntrack_bpf.c | 17 ++++++---------
> > > > >  8 files changed, 99 insertions(+), 68 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index afc1c51b59ff..75dbd2ecf80a 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -524,6 +524,11 @@ enum bpf_type_flag {
> > > > >         /* Size is known at compile time. */
> > > > >         MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
> > > > >
> > > > > +       /* MEM is of a type from program BTF, not kernel BTF. This is used to
> > > > > +        * tag PTR_TO_BTF_ID allocated using bpf_obj_new.
> > > > > +        */
> > > > > +       MEM_ALLOC               = BIT(11 + BPF_BASE_TYPE_BITS),
> > > > > +
> > > >
> > > > you fixed one naming confusion with RINGBUF and basically are creating
> > > > a new one, where "ALLOC" means "local kptr"... If we are stuck with
> > > > "local kptr" (which I find very confusing as well, but that's beside
> > > > the point), why not stick to the whole "local" terminology here?
> > > > MEM_LOCAL?
> > > >
> > >
> > > See the discussion about this in v4:
> > > https://lore.kernel.org/bpf/20221104075113.5ighwdvero4mugu7@apollo
> > >
> > > It was MEM_TYPE_LOCAL before. Also, better naming suggestions are always
> > > welcome, I asked the same in that message as well.
> >
> > Sorry, I haven't followed <v5. Don't have perfect name, but logically
> > this is BPF program memory. So "prog_kptr" would be something to
> > convert this, but I'm not super happy with such a name. "user_kptr"
> > would be too confusing, drawing incorrect "kernel space vs user space"
> > comparison, while both are kernel memory. It's BPF-side kptr, so
> > "bpf_kptr", but also not great.
>
> yep. I went through the same thinking process.
>
> > So that's why didn't suggest anything specific, but at least as far as
> > MEM_xxx flag goes, MEM_LOCAL_KPTR is better than MEM_ALLOC, IMO. It's
> > at least consistent with the official name of the concept it
> > represents.
>
> "local kptr" doesn't fit here.
> In libbpf, "local" is equally badly named.
> If "local" was a good name we wouldn't have had this discussion.
> So we need to fix it libbpf, but we should start with a proper
> name in the kernel.
> And "local kptr" is not it.
>
> We must avoid exhausting bikeshedding too.
> MEM_ALLOC is something we can use right now and
> as long as "local kptr" doesn't appear in docs, comments and
> commit logs we're good.
> We can rename MEM_ALLOC to something else later.

agreed

>
> In commit logs we can just say that this is
> a pointer to an object allocated by the bpf program.
> It's crystal clear definition whereas "local kptr" is nonsensical.
>
> Going back to the kptr definition.
> kptr was supposed to mean a pointer to a kernel object.
> In that light "pointer to an object allocated by the bpf prog"
> is something else.
> Maybe "bptr" ?
> In some ways bpf is a layer different from kernel space and user space.
> Some people joked that there is ring-0 for kernel, ring-3 for user space
> while bpf runs in ring-B.
> Two new btf_tags __bptr and __bptr_ref (or may be just one?)
> might be necessary as well to make it easier to distinguish
> kernel and bpf prog allocated objects.

bptr isn't terrific, but I don't have any good suggestions. bptr,
bpfptr, tptr (for "typed pointer" as opposed to untyped dynptr), all
kind of meh. I'm fine with whatever.

>
> > >
> > > It was just a bool in the RFC.
> > > But in https://lore.kernel.org/bpf/20220907233023.x3uclwlnjuhftvtb@macbook-pro-4.dhcp.thefacebook.com
> > > Alexei suggested passing reg instead.
> > > From the link:
> > > > imo it's cleaner to pass 'reg' instead of 'reg->btf',
> > > > so we don't have to pass another boolean.
> > > > And check type_is_local(reg) inside btf_struct_access().
> >
> > I sympathize with "too many input args" (especially if it's a bunch of
> > bools) argument, but see above, I find it increasingly harder to know
> > what parts of complex internal register state is used by helper
> > functions and which are not.
> >
> > And the fact that we have to construct a fake register state in some
> > case is a red flag to me. Pass enum bpf_reg_type type to avoid passing
> > true/false. Or let's invent a new enum. Or extend enum bpf_access_type
> > to have READ_NOPTR/WRITE_NOPTR or something like that. Don't know.
> >
> > This isn't a major issue, I can live with this just fine, but this
> > definitely doesn't feel like a clean approach.
>
> I think passing bpf_reg_state is a lesser evil _right_now_ and
> I prefer we proceed this way, since other works are blocked on
> this patch set.
> We did plenty of refactoring of the verifier in the past.
> There will be more in the future.

sure, not crucial
