Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D669D3428B4
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 23:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSWaL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 18:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhCSWaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 18:30:09 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E3C061760;
        Fri, 19 Mar 2021 15:30:09 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id l14so7291521ybe.2;
        Fri, 19 Mar 2021 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpEj/SJix1SGN/SicFa/cydF2U4SLXAJlcq8rZdgk58=;
        b=T7whLr8MaK3S4lmngxaqtx9iXNaGqdL+qkJfQmc/gOvnsPoRh5dnDs0iOSc5qW2ocK
         4hc6g2bFna/lrYbq6XOMDX19ZFXX2JftmtJgs3mGm+PWWbY6nLbLWrYNzdKhvcHNOkCe
         Uu4jwNMgvA6DCQd1xX8CBHJ50xdMJeYZf1lMcOVekNGfAst26LRPoqv1V9yewjqyWhU8
         +fEraOvevf96F/VbYVipt2ytcgNIZyn++u9YBEYllxCdRsA3p3ml34QEmrV5VdfwZF/a
         L1WcXem8VOZTPFDG1MUNajYzzeC6X3tEWJnUQGmpSFHCP+NUGXIc+0ksvscXWzR/mtKW
         0IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpEj/SJix1SGN/SicFa/cydF2U4SLXAJlcq8rZdgk58=;
        b=TKYEyJMfiZcaObKkZMHaJIGNu7RsPKs/47AmvAT1xyqpAyUJ0Hh0NcR0mLznl5RjaR
         ahrEpGr+ZkaLQ/DAlAlT9KueqrcQb+szi4Yj+bIUJL+Hxs81tTXwVVYfOixjrcTk02kD
         NUklMlWEyJnREJydsuOjm3lxmzw6kOVvCcKG7QoAZ4V9Hbl9z1c0wdJ5Fh4e7tgr4hFy
         z1/etLD/2TR4yHXP2Qv9p6wf8FmabqEuiI7q6/te9J1zhNra3FcaGm3oDIBkKDfzdOcy
         BpwT5WqtEm69fW7Az2JtQdT01S6WzaH13emGiOYb8N72cttiz6nKfOqhauqIL7NEedNP
         MrLQ==
X-Gm-Message-State: AOAM530mXafWktfN+DxBt1H+ubQcQ3CDEHXjabqFPvNUB1VuUGMowS7W
        EtJtekwU8Rvu/7XSkbd41Oi5XoEoJinFXVUCM20=
X-Google-Smtp-Source: ABdhPJwS3u01eLdNhcxk6vrQjW5pKrHRTxlpyiUMULzyXRertZLAzR5aZ19ioZV6efDytviZj1gkaHiE9HYPCRz8Rcw=
X-Received: by 2002:a25:37c1:: with SMTP id e184mr9550190yba.260.1616193007971;
 Fri, 19 Mar 2021 15:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210316011336.4173585-1-kafai@fb.com> <20210316011348.4175708-1-kafai@fb.com>
 <CAEf4Bzb57BrVOHRzikejK1ubWrZ_cd2FCS6BW6_E-2KuzJGrPg@mail.gmail.com>
 <20210318233907.r5pxtpe477jumjq6@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzZx+1bN0VazE5t5_z8X+GXFZUmiLbpxZ-WfM_mLba0OYg@mail.gmail.com>
 <20210319052943.lt3mfmjd4iozvf6i@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzbFOQ-45Oo_rdPfHnpSjCDcdDhspGNyRK2_zJjP49VhJw@mail.gmail.com> <20210319221950.5cd3ub3gpjcztzmt@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210319221950.5cd3ub3gpjcztzmt@kafai-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Mar 2021 15:29:57 -0700
Message-ID: <CAEf4Bza6Fiv+AFJc9-L=S6Duvm7wyyjvqoDGEED3TDTmwiZvVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/15] bpf: btf: Support parsing extern func
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 19, 2021 at 3:19 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Mar 19, 2021 at 02:27:13PM -0700, Andrii Nakryiko wrote:
> > On Thu, Mar 18, 2021 at 10:29 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Thu, Mar 18, 2021 at 09:13:56PM -0700, Andrii Nakryiko wrote:
> > > > On Thu, Mar 18, 2021 at 4:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > >
> > > > > On Thu, Mar 18, 2021 at 03:53:38PM -0700, Andrii Nakryiko wrote:
> > > > > > On Tue, Mar 16, 2021 at 12:01 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > > > >
> > > > > > > This patch makes BTF verifier to accept extern func. It is used for
> > > > > > > allowing bpf program to call a limited set of kernel functions
> > > > > > > in a later patch.
> > > > > > >
> > > > > > > When writing bpf prog, the extern kernel function needs
> > > > > > > to be declared under a ELF section (".ksyms") which is
> > > > > > > the same as the current extern kernel variables and that should
> > > > > > > keep its usage consistent without requiring to remember another
> > > > > > > section name.
> > > > > > >
> > > > > > > For example, in a bpf_prog.c:
> > > > > > >
> > > > > > > extern int foo(struct sock *) __attribute__((section(".ksyms")))
> > > > > > >
> > > > > > > [24] FUNC_PROTO '(anon)' ret_type_id=15 vlen=1
> > > > > > >         '(anon)' type_id=18
> > > > > > > [25] FUNC 'foo' type_id=24 linkage=extern
> > > > > > > [ ... ]
> > > > > > > [33] DATASEC '.ksyms' size=0 vlen=1
> > > > > > >         type_id=25 offset=0 size=0
> > > > > > >
> > > > > > > LLVM will put the "func" type into the BTF datasec ".ksyms".
> > > > > > > The current "btf_datasec_check_meta()" assumes everything under
> > > > > > > it is a "var" and ensures it has non-zero size ("!vsi->size" test).
> > > > > > > The non-zero size check is not true for "func".  This patch postpones the
> > > > > > > "!vsi-size" test from "btf_datasec_check_meta()" to
> > > > > > > "btf_datasec_resolve()" which has all types collected to decide
> > > > > > > if a vsi is a "var" or a "func" and then enforce the "vsi->size"
> > > > > > > differently.
> > > > > > >
> > > > > > > If the datasec only has "func", its "t->size" could be zero.
> > > > > > > Thus, the current "!t->size" test is no longer valid.  The
> > > > > > > invalid "t->size" will still be caught by the later
> > > > > > > "last_vsi_end_off > t->size" check.   This patch also takes this
> > > > > > > chance to consolidate other "t->size" tests ("vsi->offset >= t->size"
> > > > > > > "vsi->size > t->size", and "t->size < sum") into the existing
> > > > > > > "last_vsi_end_off > t->size" test.
> > > > > > >
> > > > > > > The LLVM will also put those extern kernel function as an extern
> > > > > > > linkage func in the BTF:
> > > > > > >
> > > > > > > [24] FUNC_PROTO '(anon)' ret_type_id=15 vlen=1
> > > > > > >         '(anon)' type_id=18
> > > > > > > [25] FUNC 'foo' type_id=24 linkage=extern
> > > > > > >
> > > > > > > This patch allows BTF_FUNC_EXTERN in btf_func_check_meta().
> > > > > > > Also extern kernel function declaration does not
> > > > > > > necessary have arg name. Another change in btf_func_check() is
> > > > > > > to allow extern function having no arg name.
> > > > > > >
> > > > > > > The btf selftest is adjusted accordingly.  New tests are also added.
> > > > > > >
> > > > > > > The required LLVM patch: https://reviews.llvm.org/D93563
> > > > > > >
> > > > > > > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > > > > > > ---
> > > > > >
> > > > > > High-level question about EXTERN functions in DATASEC. Does kernel
> > > > > > need to see them under DATASEC? What if libbpf just removed all EXTERN
> > > > > > funcs from under DATASEC and leave them as "free-floating" EXTERN
> > > > > > FUNCs in BTF.
> > > > > >
> > > > > > We need to tag EXTERNs with DATASECs mainly for libbpf to know whether
> > > > > > it's .kconfig or .ksym or other type of externs. Does kernel need to
> > > > > > care?
> > > > > Although the kernel does not need to know, since the a legit llvm generates it,
> > > > > I go with a proper support in the kernel (e.g. bpftool btf dump can better
> > > > > reflect what was there).
> > > >
> > > > LLVM also generates extern VAR with BTF_VAR_EXTERN, yet libbpf is
> > > > replacing it with fake INTs.
> > > Yep. I noticed the loop in collect_extern() in libbpf.
> > > It replaces the var->type with INT.
> > >
> > > > We could do just that here as well.
> > > What to replace in the FUNC case?
> >
> > if we do that, I'd just replace them with same INTs. Or we can just
> > remove the entire DATASEC. Now it is easier to do with BTF write APIs.
> > Back then it was a major pain. I'd probably get rid of DATASEC
> > altogether instead of that INT replacement, if I had BTF write APIs.
> Do you mean vsi->type = INT?

yes, that's what existing logic does for EXTERN var

>
> >
> > >
> > > Regardless, supporting it properly in the kernel is a better way to go
> > > instead of asking the userspace to move around it.  It is not very
> > > complicated to support it in the kernel also.
> > >
> > > What is the concern of having the kernel to support it?
> >
> > Just more complicated BTF validation logic, which means that there are
> > higher chances of permitting invalid BTF. And then the question is
> > what can the kernel do with those EXTERNs in BTF? Probably nothing.
> > And that .ksyms section is special, and purely libbpf convention.
> > Ideally kernel should not allow EXTERN funcs in any other DATASEC. Are
> > you willing to hard-code ".ksyms" name in kernel for libbpf's sake?
> > Probably not. The general rule, so far, was that kernel shouldn't see
> > any unresolved EXTERN at all. Now it's neither here nor there. EXTERN
> > funcs are ok, EXTERN vars are not.
> Exactly, it is libbpf convention.  The kernel does not need to enforce it.
> The kernel only needs to be able to support the debug info generated by
> llvm and being able to display/dump it later.
>
> There are many other things in the BTF that the kernel does not need to

Curious, what are those many other things?

> know.  It is there for debug purpose which the BTF is used for.  Yes,
> the func call can be discovered by instruction dump.  It is also nice to
> see everything in one ksyms datasec also during btf dump.
>
> If there is a need to strip everything that the kernel does not need
> from the BTF, it can all be stripped in another "--strip-debug" like
> option.

Where does this "--strip-debug" option go? Clang, pahole, or bpftool?
Or am I misunderstanding what you are proposing?

>
> To support EXTERN var, the kernel part should be fine.  I am only not
> sure why it has to change the vs->size and vs->offset in libbpf?

vs->size and vs->offset are adjusted to match int type. Otherwise
kernel BTF validation will complain about DATASEC size mismatch.

>
>
> >
> > >
> > > > If anyone would want to know all the kernel functions that some BPF
> > > > program is using, they could do it from the instruction dump, with
> > > > proper addresses and kernel function names nicely displayed there.
> > > > That's way more useful, IMO.
