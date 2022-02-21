Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2214BEC0C
	for <lists+bpf@lfdr.de>; Mon, 21 Feb 2022 21:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiBUUqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 15:46:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiBUUqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 15:46:12 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1135237F4
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 12:45:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d187so9892133pfa.10
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 12:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bllUG5h4lz3G5OVvCkGLTSiG3LBMXWNhzzoCnsvsi3Y=;
        b=FCjNSZhpyf+0XFPlGv2rhLfK7D66JbtK9OwFXcMfYhCqYsaZeCq0MVHo8PpM2lEnfn
         vTkEI/hxgis9yqkZD2Be9I3wtO4cqWr5+rjeJZwlQ2pk/7YYqs0IVB+mfUQt4V8vh8Zk
         P5Q/SayZj7hIQ2ofzOiuud5oG4a0gTeGHSm4gOgSPbBO03eaT/bnUO0FSgXJgQFHICDj
         D8/SZoIHRlvg86jOSDKCyug5YyZy/7H+bElfY3TZo1FXUpat8oTi0XHrZEzTUG15y8GA
         nKZfq6sMgTzYkLruwrxtiy0tig7F4mBWFGQ2ZxDFHnEkr1QlM/btzPfAp25tg6FH1qJ3
         FMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bllUG5h4lz3G5OVvCkGLTSiG3LBMXWNhzzoCnsvsi3Y=;
        b=lQy9ajiMmvEStcYo4fs+5PP05MG2DH+Jxz+8VoW/+qPk+V/rBSOezABtDUL9+WxnRX
         oBMpRDySLXrgy9Iqw3Q5v44Cqe0MfOcUj7iIPn9ZEu1AbLiBLhH34RvlfV1vriGhuRIf
         BCrH/iBfK9d9fXv4luuEcLOgQwCI7k7BJIvmyPC3Pq5fX7g8YXFaYGKRn1EK7QLXF+tj
         X8tuvZWuN020xnIqI7wNZJCiTc8YXvW4hqez0HBnwYOo5gDrQdSZfArj+jKGspf0sAK6
         CQyiFwf3pZhPf32G3WBiMPJoX+00TNuRUcHY1IVdf+6eLZYa/+QrfvbbzQ4DMnFETdop
         O0ng==
X-Gm-Message-State: AOAM533bBF/zri/5ImpFJDBoPILCvQPKya2kqrUMM7u4wzDqFMBlVvqO
        UWbZzsloKX2KthdYoIMlXY2LC7uIXtyaPFkEbxvLbysC
X-Google-Smtp-Source: ABdhPJyeJHwGCJQHKzGq4f3jtoM2C06BcllnWkEx987igMo6ik/f+sK9aUtt9pCOpZ61QtDg7LXawAblhRTzQ+i/8RE=
X-Received: by 2002:a05:6a00:809:b0:4f1:14bb:40b1 with SMTP id
 m9-20020a056a00080900b004f114bb40b1mr10302467pfk.69.1645476348241; Mon, 21
 Feb 2022 12:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20220219113744.1852259-1-memxor@gmail.com> <20220219121035.c6c5dmvbchzaqqak@apollo.legion>
 <20220220021808.surwmx5jhosasi2d@ast-mbp.dhcp.thefacebook.com> <20220220025931.6rhvlii4i4emumik@apollo.legion>
In-Reply-To: <20220220025931.6rhvlii4i4emumik@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Feb 2022 12:45:37 -0800
Message-ID: <CAADnVQJgM+y=hArN4+pNRGO6uM76spJ4Bi3fK7xAvnSHj_wFzw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 0/5] More fixes for crashes due to bad
 PTR_TO_BTF_ID reg->off
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Sat, Feb 19, 2022 at 6:59 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sun, Feb 20, 2022 at 07:48:08AM IST, Alexei Starovoitov wrote:
> > On Sat, Feb 19, 2022 at 05:40:35PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > On Sat, Feb 19, 2022 at 05:07:39PM IST, Kumar Kartikeya Dwivedi wrote:
> > > > A few more fixes for bad PTR_TO_BTF_ID reg->off being accepted in places, that
> > > > can lead to the kernel crashing. Noticed while making sure my own series for BTF
> > > > ID pointer in map won't allow stores for pointers with incorrect offsets.
> > > >
> > > > I include one example where d_path can crash even if you NULL check
> > > > PTR_TO_BTF_ID, and one example of how missing NULL check in helper taking
> > > > PTR_TO_BTF_ID (like bpf_sock_from_file) is a real problem, see the selftest
> > > > patch.
> > > >
> > > > The &f->f_path becomes NULL + offset in case f is NULL, circumventing NULL
> > > > checks in existing helpers. The only thing needed to trigger this finding an
> > > > object that embeds the object of interest, and then somehow obtaining a NULL
> > > > PTR_TO_BTF_ID to it (not hard, esp. due to exception handler for PROBE_MEM loads
> > > > writing 0 to destination register).
> > > >
> > > > However, for the case of patch 2, it is allowed in my series since the next load
> > > > of the bad pointer stored using:
> > > >   struct file *f = ...; // some pointer walking returning NULL pointer
> > > >   map_val->ptr = &f->f_path; // ptr being struct path *
> > > > ... would be marked as PTR_UNTRUSTED, so it won't be allowed to be passed into
> > > > the kernel, and hence can be permitted. In referenced case, the PTR_TO_BTF_ID
> > > > should not be NULL anyway. kptr_get style helper takes PTR_TO_MAP_VALUE in
> > > > referenced ptr case only, so the load either yields NULL or RCU protected
> > > > pointer.
> > > >
> > > > Tests for patch 1 depend on fixup_kfunc_btf_id in test_verifier, hence will be
> > > > sent after merge window opens, some other changes after bpf tree merges into
> > > > bpf-next, but all pending ones can be seen here [0]. Tests for patch 2 are
> > > > included, and try to trigger crash without the fix, but it's not 100% reliable.
> > > > We may need special testing helpers or kfuncs to make it thorough, but wanted to
> > > > wait before getting feedback.
> > > >
> > > > Issue fixed by patch 2 is a bit more broader in scope, and would require proper
> > > > discussion (before being applied) on the correct way forward, as it is
> > > > technically backwards incompatible change, but hopefully never breaks real
> > > > programs, only malicious or already incorrect ones.
> > > >
> > > > Also, please suggest the right "Fixes" tag for patch 2.
> > > >
> > > > As for patch 3 (selftest), please suggest a better way to get a certain type of
> > > > PTR_TO_BTF_ID which can be NULL or NULL+offset. Can we add kfuncs for testing
> > > > that return such pointers and make them available to e.g. TC progs, if the fix
> > > > in patch 2 is acceptable?
> > > >
> > > >   [0]: https://github.com/kkdwivedi/linux/commits/fixes-bpf-next
> > > >
> > >
> > > Looking at BPF CI [1], it seems it surfaces another problem I was seeing locally
> > > but couldn't craft a reliable test case for, that it forms a non-NULL but
> > > invalid pointer using pointer walking, in some cases RCU read lock provides
> > > protection for those cases, but not all (esp. if kernel doesn't clear the old
> > > pointer that was in use before, and has it sitting in some location). RDI (arg1)
> > > seems to be pointing somewhere behind the faulting address, which means the
> > > &f->f_path is bad.
> > >
> > > But this requires a larger discussion.
> > >
> > > In that case, PAGE_SIZE thing won't help. We may have to introduce a PTR_BPF_REF
> > > flag (e.g. set for ctx args of tracing progs, set based on BTF tagging in other
> > > places) which tells the verifier that the pointer for the duration of program
> > > will be valid, so it can be passed into helpers.
> > >
> > > So for cases like &f->f_path it will work, since file + off will still have
> > > PTR_BPF_REF set in reg state. In case of pointer walking, where dst_reg state
> > > is updated on walk, we may have to explicitly tag members where PTR_BPF_REF can
> > > be inherited if parent object has PTR_BPF_REF (i.e. ref to parent implies ref to
> > > child cases).
> > >
> > > Something like:
> > >
> > > struct foo {
> > >     ...
> > >     struct bar __bpf_ref *p;
> > >     struct baz *q;
> > >     ...
> > > }
> > >
> > > ... then if getting:
> > >
> > >     struct foo *f = ...; // PTR_TO_BTF_ID | PTR_BPF_REF
> > >     struct bar *p = f->p; // Inherits PTR_BPF_REF
> > >     struct baz *q = f->q; // Does not inherit PTR_BPF_REF
> > >
> > > Thoughts?
> > >
> > >   [1]: https://github.com/kernel-patches/bpf/runs/5258413028?check_suite_focus=true
> >
> > fd_array wasn't zero initialized at alloc time, so it contains garbage.
> > fd_array[63] read that garbage.
> > So patches 2 and 3 don't help.
> > The 'fixes' list for patch 3 is ridiculous. No need.
> > Pls drop patch 2 and in instead of
> > +#define bpf_ptr_is_invalid(p) (unlikely((unsigned long)(p) < PAGE_SIZE))
> > do static inline function that checks
> > if ((unsigned long)p < user_addr_max())
>
> This prevents this specific case, but what happens when PTR_TO_BTF_ID can be
> formed to an already freed object (which seems even more likely to me in
> sleepable progs, because typical RCU grace period won't wait for us)? Or even
> just reading from structures which don't clear pointers they have freed, but are
> themselves not freed (so exception handling zeroing dst reg won't kick in).

Right. The above check would prevent a class of issues, but not all of them.
If kernel code doesn't clear the pointer inside a struct after freeing it
it would lead to uaf.
Thankfully most of the code is rcu and typical rcu protected pointer
usage would replace the pointer before doing call_rcu() to clean it.
There are corner cases and we need to gradually close such holes.
My point is that it's not a bpf tree material. No need to
create panic and do a patch with gadzillion 'fixes' tags.
With bpf progs calling kfuncs there is a possibility of a crash.
We need to eliminate such possibilities when we can.
But we're not going to backport hundred patches to old kernels.
We will close one hole today and a year later another hole could be found.
We'll close it too, but we are not going to backport a year worth of
verifier patches.

> > and bails out.
> > bpf-next is fine.
> > Not sure whether patch 1 is strictly necessary after above change.
>
> It is still needed to prevent the var_off case.

Right. var_off should be prevented.
