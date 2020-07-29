Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B158232781
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 00:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgG2WR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 18:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgG2WR7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 18:17:59 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D32C061794
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 15:17:59 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id q16so11174359ybk.6
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNvJJpQ2jzLmsquNZf56bmlrRlCF1f7gg34A24JP6mI=;
        b=D9ah000tAYRt7PnbpS1+SdxMp3Gyhg1bfLQOA7VHxrvlBjPUHJ6lPv8IlaS3/LbvJI
         RbqPhv4FB81jRbG6Der3DP9ygQXEhNWxgQrWrNa3IPiit3qyLHSVKiCbalD0jFeA9xcw
         kce2qU/DziL5upK7SgGRsHpLNIomyMZZ0QS83eqKw213NbnN5psrzlGyUmOzEr7JWcnZ
         wJCUaskwC1EgoMTZ9RLSS519zdwRD82z0wn4OiLZ573ROAIMZIRhUUd8j8J9NiqTu2mU
         YISqCF7SVUBkwNxE0Xe0z33NiZ6iKZE5TJAUMsynpccddXSqLwWmC+5XVdSAJ0BkxZPw
         ufOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNvJJpQ2jzLmsquNZf56bmlrRlCF1f7gg34A24JP6mI=;
        b=gKvYuVANXu6sIEy6V7ya+vjkpnwn4mCo/NCiU4hTQUxpFo/gPPQNG/aT4pTKPR+z1F
         NsMeTw+suO2GiuIhZloj3wZ9/2Zbsjc3NjB8pnE6I+1mS71c5XGH4UHBzRNZMztftOy3
         9tfguXkpHVsVnUvUQNYF6IcKrAqpADu5zcqXfG7kK9DzQhWo//TGOPVNfW1LAPPSXHOL
         NEz45+4cMkn6P/ODk5JSvYQFnEjprO5J5aD+o896sgLYQ9XUcgrTItu6m6+fuqKriHbe
         R0chIdksObHYXApJAce15WiWYeYKA3W6d/iWs5UBCIRkvwOeJKlm1xz9XjUtvwVZQt6y
         owlQ==
X-Gm-Message-State: AOAM53371WYN2r+iPxkJYiDMEAv/BSZ1NAyE/BOVmPo+qx7z53ISVMqy
        rR/4oOXXkngOrephxtAJN3ZhLV1HiiyGcQ2shPw=
X-Google-Smtp-Source: ABdhPJwzHPXNKYB2etrKIYdx/v8yW8y5wrdglvirvP2lEz+rSijV04VYo8P64Dtn3iQH/rCI22WDLX90oxWqsjCoL3M=
X-Received: by 2002:a25:ba0f:: with SMTP id t15mr6870873ybg.459.1596061078354;
 Wed, 29 Jul 2020 15:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200728120059.132256-1-iii@linux.ibm.com> <20200728120059.132256-4-iii@linux.ibm.com>
 <CAEf4BzaSJp-fOn2MG_8Fc2mo9ji5gZBLn2xCGyCiAmPbHkqSQQ@mail.gmail.com>
 <bea74a32-746c-c310-67c8-477dcd442fb3@iogearbox.net> <CAEf4BzZtsOF0iuWrtBn7Up2zZFv79PvF5TC1RukBxQBxpN4pFQ@mail.gmail.com>
 <b6cbb797-02c4-d904-5231-54608706f99d@iogearbox.net> <CAEf4Bzarzp1a_XBy33ULKaYmh0muHtDAr61EZNUEd2rJrZ3j7g@mail.gmail.com>
 <f96ed8e0-66d2-fef5-14a4-8930a1ef759e@iogearbox.net> <CAEf4BzbD=e8x8BEBCic+5DHcCewZUfp1h3JSj5zRQ9i2KW1-dQ@mail.gmail.com>
 <6177128b-bef5-7445-bf00-8051f8efa3bc@iogearbox.net>
In-Reply-To: <6177128b-bef5-7445-bf00-8051f8efa3bc@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 29 Jul 2020 15:17:19 -0700
Message-ID: <CAEf4BzYdGSRnVV392FK07JQj_H7GYkR+OPs3x877wBjgFB5W4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Use bpf_probe_read_kernel
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 29, 2020 at 3:12 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/30/20 12:05 AM, Andrii Nakryiko wrote:
> > On Wed, Jul 29, 2020 at 2:54 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 7/29/20 11:36 PM, Andrii Nakryiko wrote:
> >>> On Wed, Jul 29, 2020 at 2:01 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>>> On 7/29/20 6:06 AM, Andrii Nakryiko wrote:
> >>>>> On Tue, Jul 28, 2020 at 2:16 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>>>>> On 7/28/20 9:11 PM, Andrii Nakryiko wrote:
> >>>>>>> On Tue, Jul 28, 2020 at 5:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >>>>>>>>
> >>>>>>>> Yet another adaptation to commit 0ebeea8ca8a4 ("bpf: Restrict
> >>>>>>>> bpf_probe_read{, str}() only to archs where they work") that makes more
> >>>>>>>> samples compile on s390.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >>>>>>>
> >>>>>>> Sorry, we can't do this yet. This will break on older kernels that
> >>>>>>> don't yet have bpf_probe_read_kernel() implemented. Met and Yonghong
> >>>>>>> are working on extending a set of CO-RE relocations, that would allow
> >>>>>>> to do bpf_probe_read_kernel() detection on BPF side, transparently for
> >>>>>>> an application, and will pick either bpf_probe_read() or
> >>>>>>> bpf_probe_read_kernel(). It should be ready soon (this or next week,
> >>>>>>> most probably), though it will have dependency on the latest Clang.
> >>>>>>> But for now, please don't change this.
> >>>>>>
> >>>>>> Could you elaborate what this means wrt dependency on latest clang? Given clang
> >>>>>> releases have a rather long cadence, what about existing users with current clang
> >>>>>> releases?
> >>>>>
> >>>>> So the overall idea is to use something like this to do kernel reads:
> >>>>>
> >>>>> static __always_inline int bpf_probe_read_universal(void *dst, u32 sz,
> >>>>> const void *src)
> >>>>> {
> >>>>>        if (bpf_core_type_exists(btf_bpf_probe_read_kernel))
> >>>>>            return bpf_probe_read_kernel(dst, sz, src);
> >>>>>        else
> >>>>>            return bpf_probe_read(dst, sz, src);
> >>>>> }
> >>>>>
> >>>>> And then use bpf_probe_read_universal() in BPF_CORE_READ and family.
> >>>>>
> >>>>> This approach relies on few things:
> >>>>>
> >>>>> 1. each BPF helper has a corresponding btf_<helper-name> type defined for it
> >>>>> 2. bpf_core_type_exists(some_type) returns 0 or 1, depending if
> >>>>> specified type is found in kernel BTF (so needs kernel BTF, of
> >>>>> course). This is the part me and Yonghong are working on at the
> >>>>> moment.
> >>>>> 3. verifier's dead code elimination, which will leave only
> >>>>> bpf_probe_read() or bpf_probe_read_kernel() calls and will remove the
> >>>>> other one. So on older kernels, there will never be unsupoorted call
> >>>>> to bpf_probe_read_kernel().
> >>>>>
> >>>>> The new type existence relocation requires the latest Clang. So the
> >>>>> way to deal with older Clangs would be to just fallback to
> >>>>> bpf_probe_read, if we detect that Clang is too old and can't emit
> >>>>> necessary relocation.
> >>>>
> >>>> Okay, seems reasonable overall. One question though: couldn't libbpf transparently
> >>>> fix up the selection of bpf_probe_read() vs bpf_probe_read_kernel()? E.g. it would
> >>>> probe the kernel whether bpf_probe_read_kernel() is available and if it is then it
> >>>> would rewrite the raw call number from the instruction from bpf_probe_read() into
> >>>> the one for bpf_probe_read_kernel()? I guess the question then becomes whether the
> >>>> original use for bpf_probe_read() was related to CO-RE. But I think this could also
> >>>> be overcome by adding a fake helper signature in libbpf with a unreasonable high
> >>>> number that is dedicated to probing mem via CO-RE and then libbpf picks the right
> >>>> underlying helper call number for the insn. That avoids fiddling with macros and
> >>>> need for new clang version, no (unless I'm missing something)?
> >>>
> >>> Libbpf could do it, but I'm a bit worried that unconditionally
> >>> changing bpf_probe_read() into bpf_probe_read_kernel() is going to be
> >>> wrong in some cases. If that wasn't the case, why wouldn't we just
> >>> re-purpose bpf_probe_read() into bpf_probe_read_kernel() in kernel
> >>> itself, right?
> >>
> >> Yes, that is correct, but I mentioned above that this new 'fake' helper call number
> >> that libbpf would be fixing up would only be used for bpf_probe_read{,str}() inside
> >> bpf_core_read.h.
> >>
> >> Small example, bpf_core_read.h would be changed to (just an extract):
> >>
> >> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
> >> index eae5cccff761..4bddb2ddf3f0 100644
> >> --- a/tools/lib/bpf/bpf_core_read.h
> >> +++ b/tools/lib/bpf/bpf_core_read.h
> >> @@ -115,7 +115,7 @@ enum bpf_field_info_kind {
> >>     * (local) BTF, used to record relocation.
> >>     */
> >>    #define bpf_core_read(dst, sz, src)                                        \
> >> -       bpf_probe_read(dst, sz,                                             \
> >> +       bpf_probe_read_selector(dst, sz,                                                    \
> >>                          (const void *)__builtin_preserve_access_index(src))
> >>
> >>    /*
> >> @@ -124,7 +124,7 @@ enum bpf_field_info_kind {
> >>     * argument.
> >>     */
> >>    #define bpf_core_read_str(dst, sz, src)                                            \
> >> -       bpf_probe_read_str(dst, sz,                                         \
> >> +       bpf_probe_read_str_selector(dst, sz,                                        \
> >>                              (const void *)__builtin_preserve_access_index(src))
> >>
> >>    #define ___concat(a, b) a ## b
> >>
> >> And bpf_probe_read_{,str_}selector would be defined as e.g. ...
> >>
> >> static long (*bpf_probe_read_selector)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) -1;
> >> static long (*bpf_probe_read_str_selector)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) -2;
> >>
> >> ... where libbpf would do the fix up to either 4 or 45 for insn->imm. But it's still
> >> confined to usage in bpf_core_read.h when the CO-RE macros are used.
> >
> > Ah, I see. Yeah, I suppose that would work as well. Do you prefer me
> > to go this way?
>
> I would suggest we should try this path given this can be used with any clang version
> that has the BPF backend, not just latest upstream git.

Sure, sounds good.

>
> Thanks,
> Daniel
