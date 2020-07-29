Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896FF2326DC
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 23:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgG2Vgj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 17:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Vgi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 17:36:38 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C9CC061794
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 14:36:38 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a15so13317287ybs.8
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 14:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hks4MCAKgB6L+nbHkV7Ct82sx8/+k/eljZjT3djlW6g=;
        b=MDnYIUktIRO11QXdrsdR7zes9ZF5DVlWOia07cjTtsKdVmgfmK8z2Pyvp2bJPp/7p6
         yb6oDBxfj7gipvxM5NY/DiFstVcboe5/PJCM8tIOA5KhTr8ba0Ku2XPIqR0lVHJH+kRx
         p1LmzxFMG2PHRjV5LiEtBWR23F3U2D9aO+zfgYPATV9pNoFdgNuud8We4peEwvJZ5eq3
         r53zE1EiX1xQEgA/RtJhart0HLtyfCjGsi7RwTrP8d9SSsN9PR+KDOzUWW0slT2Ee5s/
         rMx7R8tH3ZSxzEX74PupiMy6nkNfKEc+A2BonjJGYJzYvQIyYk3NqpYaoy1OcGydp9WZ
         GXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hks4MCAKgB6L+nbHkV7Ct82sx8/+k/eljZjT3djlW6g=;
        b=AwezA+PM3tGezWLNLCFMN20jCoH6oQRVigd+JRXhJCtMb6C4h6FDLH0Bbf8uwb91z8
         IlqzKhbyj4xpcjkN8E/SnT0kCRHHufpK/NoK9UphTLDI0ujYTQq/9AFvG+yd8z74WmAb
         Zeg97aFhXEMTVfLV9caQNFpdwMj5nopGi/gXdJZZ9HvnQ6V/KntHmdsHQlEkfV5sdEfj
         ee8qQ+McmlMlDsbBbcbt1tkHI14C7Ifl8Mfvq+GjWev5zh6CwW1r6C2fBLwPlLhINOkd
         haKenVWFor8TPhNp4NusNfbtK2tWSJBpX6YuRygmwn/s8sK7+E0ejjmYu+2dgKACofIq
         c8wA==
X-Gm-Message-State: AOAM531uLjPU2gwOmp1P5wUo2QSD/75vo5XvBwX46l9QZ8Sy5tHwWeTt
        4uIEs8gfPWG1+PnQ+J0mwb5rIVtg1k+1LLgxTnRjOEYi
X-Google-Smtp-Source: ABdhPJwfFXUfHNbsYySp0uRSShhASj7D+iROkex4YfJhcyKCTNbh6Giwffi7uiE5jm33F8ZTtDEMqDaI/6HdjZJslxk=
X-Received: by 2002:a25:ba0f:: with SMTP id t15mr6632871ybg.459.1596058597539;
 Wed, 29 Jul 2020 14:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200728120059.132256-1-iii@linux.ibm.com> <20200728120059.132256-4-iii@linux.ibm.com>
 <CAEf4BzaSJp-fOn2MG_8Fc2mo9ji5gZBLn2xCGyCiAmPbHkqSQQ@mail.gmail.com>
 <bea74a32-746c-c310-67c8-477dcd442fb3@iogearbox.net> <CAEf4BzZtsOF0iuWrtBn7Up2zZFv79PvF5TC1RukBxQBxpN4pFQ@mail.gmail.com>
 <b6cbb797-02c4-d904-5231-54608706f99d@iogearbox.net>
In-Reply-To: <b6cbb797-02c4-d904-5231-54608706f99d@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 29 Jul 2020 14:36:26 -0700
Message-ID: <CAEf4Bzarzp1a_XBy33ULKaYmh0muHtDAr61EZNUEd2rJrZ3j7g@mail.gmail.com>
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

On Wed, Jul 29, 2020 at 2:01 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/29/20 6:06 AM, Andrii Nakryiko wrote:
> > On Tue, Jul 28, 2020 at 2:16 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 7/28/20 9:11 PM, Andrii Nakryiko wrote:
> >>> On Tue, Jul 28, 2020 at 5:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >>>>
> >>>> Yet another adaptation to commit 0ebeea8ca8a4 ("bpf: Restrict
> >>>> bpf_probe_read{, str}() only to archs where they work") that makes more
> >>>> samples compile on s390.
> >>>>
> >>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >>>
> >>> Sorry, we can't do this yet. This will break on older kernels that
> >>> don't yet have bpf_probe_read_kernel() implemented. Met and Yonghong
> >>> are working on extending a set of CO-RE relocations, that would allow
> >>> to do bpf_probe_read_kernel() detection on BPF side, transparently for
> >>> an application, and will pick either bpf_probe_read() or
> >>> bpf_probe_read_kernel(). It should be ready soon (this or next week,
> >>> most probably), though it will have dependency on the latest Clang.
> >>> But for now, please don't change this.
> >>
> >> Could you elaborate what this means wrt dependency on latest clang? Given clang
> >> releases have a rather long cadence, what about existing users with current clang
> >> releases?
> >
> > So the overall idea is to use something like this to do kernel reads:
> >
> > static __always_inline int bpf_probe_read_universal(void *dst, u32 sz,
> > const void *src)
> > {
> >      if (bpf_core_type_exists(btf_bpf_probe_read_kernel))
> >          return bpf_probe_read_kernel(dst, sz, src);
> >      else
> >          return bpf_probe_read(dst, sz, src);
> > }
> >
> > And then use bpf_probe_read_universal() in BPF_CORE_READ and family.
> >
> > This approach relies on few things:
> >
> > 1. each BPF helper has a corresponding btf_<helper-name> type defined for it
> > 2. bpf_core_type_exists(some_type) returns 0 or 1, depending if
> > specified type is found in kernel BTF (so needs kernel BTF, of
> > course). This is the part me and Yonghong are working on at the
> > moment.
> > 3. verifier's dead code elimination, which will leave only
> > bpf_probe_read() or bpf_probe_read_kernel() calls and will remove the
> > other one. So on older kernels, there will never be unsupoorted call
> > to bpf_probe_read_kernel().
> >
> > The new type existence relocation requires the latest Clang. So the
> > way to deal with older Clangs would be to just fallback to
> > bpf_probe_read, if we detect that Clang is too old and can't emit
> > necessary relocation.
>
> Okay, seems reasonable overall. One question though: couldn't libbpf transparently
> fix up the selection of bpf_probe_read() vs bpf_probe_read_kernel()? E.g. it would
> probe the kernel whether bpf_probe_read_kernel() is available and if it is then it
> would rewrite the raw call number from the instruction from bpf_probe_read() into
> the one for bpf_probe_read_kernel()? I guess the question then becomes whether the
> original use for bpf_probe_read() was related to CO-RE. But I think this could also
> be overcome by adding a fake helper signature in libbpf with a unreasonable high
> number that is dedicated to probing mem via CO-RE and then libbpf picks the right
> underlying helper call number for the insn. That avoids fiddling with macros and
> need for new clang version, no (unless I'm missing something)?

Libbpf could do it, but I'm a bit worried that unconditionally
changing bpf_probe_read() into bpf_probe_read_kernel() is going to be
wrong in some cases. If that wasn't the case, why wouldn't we just
re-purpose bpf_probe_read() into bpf_probe_read_kernel() in kernel
itself, right?

But fear not about old Clang support. The bpf_core_type_exists() will
use a new built-in, and I'll be able to detect its presence with
__has_builtin(X) check in Clang. So it will be completely transparent
to users in the end.

>
> > If that's not an acceptable plan, then one can "parameterize"
> > BPF_CORE_READ macro family by re-defining bpf_core_read() macro. Right
> > now it's defined as:
> >
> > #define bpf_core_read(dst, sz, src) \
> >      bpf_probe_read(dst, sz, (const void *)__builtin_preserve_access_index(src))
> >
> > Re-defining it in terms of bpf_probe_read_kernel is trivial, but I
> > can't do it for BPF_CORE_READ, because it will break all the users of
> > bpf_core_read.h that run on older kernels.
> >
> >
> >>
> >>>>    tools/lib/bpf/bpf_core_read.h | 51 ++++++++++++++++++-----------------
> >>>>    tools/lib/bpf/bpf_tracing.h   | 15 +++++++----
> >>>>    2 files changed, 37 insertions(+), 29 deletions(-)
> >>>>
> >>>
> >>> [...]
> >>>
> >>
>
