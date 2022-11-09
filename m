Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04D36230F7
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 18:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiKIRCa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 12:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKIRBm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 12:01:42 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C128E00
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 09:00:24 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v17so17669615plo.1
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxyBOn9hQW/NhbY1uLO06rY4rFVK41c4HUwzwgZJ10w=;
        b=Y9/7NJWLpMRJIyhsgj6C11xhm5n0uLu5QwrvUgtkEqd6eifQ/v63X8Vc6NqjNLtOsB
         8mVGqIz0e+xnVy7KEJ0AordH4OvKowGyDhCnGbG1FYIxx1FSn+a5dssTc+bHdsV+I9Jy
         OSU0HccQP6k9apvasvZXS98SxnUKEl+dqi+5++oTcXAm/FS+u36UlkT7N6w/nYtIT5Fl
         izbkzIF1R5Fw/xAj6MxiRuBby5zm6rqW3zdMCyjhHZs+3dUxO5lYhbhcTFAABp10FsMD
         HIcgO78+Dsoh+psh01GFw2TrHWHx41u1AmGam0VVnUhkvA39qI1qVS3i5/hCkKCNrlcc
         PauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxyBOn9hQW/NhbY1uLO06rY4rFVK41c4HUwzwgZJ10w=;
        b=U/xmei+kocAUObq9jr1caLs5SBmZvk0odgd9XMwrFyq+XchXK0dbdCQ1hdFbay4Fii
         np86cSBU7rhPYNpENiwAL23Wlvu3VsrQxTfFp44sjzuEt/UCI2ZJA1x8izqxmkjmMTVx
         CRZ1njfskkr8ZGYO8cuDiE1zoXdYkCJc7tThB5Ds5tMJyNg7Eg3sAUqqzpzZzBNokOJr
         PdGJSqdW36BkGqdfuh6/0EFu9adPlIsOKyBTbK69QY9iYbddu/pRikDqTDQkTbpLp1L+
         TgEbNBWtFq+B0WqoQ7iHCYjxMbUMkY4q2mDgShWU563X66Sm/XRXvdaVlVU+hqB/2vwE
         HA9w==
X-Gm-Message-State: ACrzQf3aPDmG0LGg+oBpE+MJ5InEFxk6Z4roljP6gAw/ctvl+1C4+HME
        K1l+0ocD2Zixe8zY/YzZtno3JE//dgvdgw==
X-Google-Smtp-Source: AMsMyM67K1ppszZXza16rzUyusFOYktZHXEaXD2SwgTA2RZprjnhPUNRkyhrtlicO6xTdzsP5uQpCw==
X-Received: by 2002:a17:90b:4d91:b0:213:f1b:dab5 with SMTP id oj17-20020a17090b4d9100b002130f1bdab5mr61678788pjb.95.1668013223990;
        Wed, 09 Nov 2022 09:00:23 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709027e8b00b00186f81a074fsm9271800pla.290.2022.11.09.09.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:00:23 -0800 (PST)
Date:   Wed, 9 Nov 2022 22:30:17 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v5 06/25] bpf: Introduce local kptrs
Message-ID: <20221109170017.jvutgcd6qrsuvrsg@apollo>
References: <20221107230950.7117-1-memxor@gmail.com>
 <20221107230950.7117-7-memxor@gmail.com>
 <CAEf4BzZRaN_zd07jvtom6QJEEDGmFQTLJy4BM1bKi1MH5+n5QA@mail.gmail.com>
 <20221109000016.np325iqjjegvdose@apollo>
 <CAEf4BzZ0h4yda0_M8+wgpsHAgm_J5oeUtaxm8V-jqy3gNjFWdg@mail.gmail.com>
 <CAADnVQL1ZojMCzt5FZU5Di2m6W3JYTrGZHBLoMQCinQfyL=4Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL1ZojMCzt5FZU5Di2m6W3JYTrGZHBLoMQCinQfyL=4Og@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 07:02:11AM IST, Alexei Starovoitov wrote:
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
>
> In commit logs we can just say that this is
> a pointer to an object allocated by the bpf program.
> It's crystal clear definition whereas "local kptr" is nonsensical.
>

Ok, I'll drop the naming everywhere.

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
>

There's also the option of simply using __kptr and __kptr_ref for these (without
__local tag in BPF maps) and doing two stage name lookup for the types. Kernel
BTF takes precedence, if not found there, then it searches program BTF for a
local type. It would probably the simplest for users.

struct map_value {
	struct nf_conn __kptr_ref *ct; // kernel
	struct foo __kptr_ref *f; // local
	struct task_struct __kptr_ref *t; // kernel
	struct bar __kptr_ref *b; // local
}

We can revisit this again once the post the follow up to store them in maps.
