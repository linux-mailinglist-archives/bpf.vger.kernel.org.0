Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB266B1DB1
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 09:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCIISL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 03:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCIIRv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 03:17:51 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC70420A2D;
        Thu,  9 Mar 2023 00:14:22 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id n18so1053128ybm.10;
        Thu, 09 Mar 2023 00:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678349619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57n/+LRRePFei+PwepmtWg52Mbl3H508qcWE1bJ1n8Q=;
        b=P9LtjoQu1DvX9A7HMv9CDKOFrd+Sn6iBl85R0e/rBAUtKr3mz/e1x7rRh4sccuDBFx
         94rdxoZxOY34KJtYSMNNdpsWB74IEzblhrO0powjy5gg93WtG8Yt6LrfufCp4q7KnHA7
         k7jdIt5IPlJbwmIPRykCnvSmgC6DjFmjrVnyS2oCdHwMqUaDAHPpcBMBFJSsACpTM/zM
         Ymi0k8DFahDMXTfJWU701i1IJEClhCBdbR2pXS42EOiGUIJatg4+ek0/OZYXBaFgL3PH
         p80fFHeJvNtRa0L45/r1gc1y61xDL2xKrUjUSyiDfy+myvFqsUAhZljyjjq/XhBM9xcB
         UzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678349619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57n/+LRRePFei+PwepmtWg52Mbl3H508qcWE1bJ1n8Q=;
        b=cR2A919EIh1rULntTRoMaZ3YXKrnKeRWZnQEh+ckL/nUwgOQi1gZX6AzUsBMKUvqPr
         sJ47Sm8x73YAvb2VsVNvNCkX3DB2OLsF9ZWvfQUYlyxZ6oqCRnzEYMWkzNzEK8yLWQP0
         75unFGM0zjCNaEV0EvJt0314EpzmlGqxkOPP7GBeZQbEWcPjT9sH2mUMqHOOtQOS3Chx
         yeXLkee16RjByiQGOau1hni3ANpwXtc9bHq57oBEOPZc5jREB8+VaWsYB42ITy52ufok
         4Q8+kIiIFVezw8u++lIyC9epH//en3ax95SklEs3vjfmqZA6H+szFMiI9jWREonWic9B
         30GQ==
X-Gm-Message-State: AO0yUKX/BSP3FIIxxPV1tEIGqcB7f2bBybpZtscwilprTwYYJzCVRvaF
        WzU08/KiN6OEfHZ0hMErrtELfsEl8hBBD88hdcU=
X-Google-Smtp-Source: AK7set+pn50q0Ebz4sv6D+0H35hXEv+QeO9rvQNcMPWOgnWCDY2Gg9fn/GNcFvCYxZ5D792KYM5d5HDidsHFjNM+S0o=
X-Received: by 2002:a25:8d88:0:b0:b17:e69b:b82a with SMTP id
 o8-20020a258d88000000b00b17e69bb82amr3823298ybl.8.1678349619399; Thu, 09 Mar
 2023 00:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20230301154953.641654-1-joannelkoong@gmail.com>
 <20230301154953.641654-11-joannelkoong@gmail.com> <CAADnVQJCYcPnutRvjJgShAEokfrXfC4DToPOTJRuyzA1R64mBg@mail.gmail.com>
 <CAJnrk1YNMoTEaWA6=wDS3iV4sV0A-5Afnn+p50hEvX8jR6GLHw@mail.gmail.com>
 <20230308015500.6pycr5i4nynyu22n@heavy> <CAJnrk1Y1ONmEJpwDqGzCUmyrkDf9s_HpDhR5mW=6fNKM6PiXew@mail.gmail.com>
 <c27727cfabced2b9207eabbba71bed158ca35eec.camel@linux.ibm.com>
In-Reply-To: <c27727cfabced2b9207eabbba71bed158ca35eec.camel@linux.ibm.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 9 Mar 2023 00:13:28 -0800
Message-ID: <CAJnrk1Za8KaAq4=v7X=YEHRu5jc3upR059AcY9eanr-v_9VSqg@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 10/10] selftests/bpf: tests for using dynptrs
 to parse skb and xdp buffers
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 8, 2023 at 6:24=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> On Tue, 2023-03-07 at 23:22 -0800, Joanne Koong wrote:
> > On Tue, Mar 7, 2023 at 5:55=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.=
com>
> > wrote:
> > >
> > > On Wed, Mar 01, 2023 at 08:28:40PM -0800, Joanne Koong wrote:
> > > > On Wed, Mar 1, 2023 at 10:08=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Mar 1, 2023 at 7:51=E2=80=AFAM Joanne Koong
> > > > > <joannelkoong@gmail.com> wrote:
> > > > > >
> > > > > > 5) progs/dynptr_success.c
> > > > > >    * Add test case "test_skb_readonly" for testing attempts
> > > > > > at writes
> > > > > >      on a prog type with read-only skb ctx.
> > > > > >    * Add "test_dynptr_skb_data" for testing that
> > > > > > bpf_dynptr_data isn't
> > > > > >      supported for skb progs.
> > > > >
> > > > > I added
> > > > > +dynptr/test_dynptr_skb_data
> > > > > +dynptr/test_skb_readonly
> > > > > to DENYLIST.s390x and applied.
> > > >
> > > > Thanks, I'm still not sure why s390x cannot load these programs.
> > > > It is
> > > > being loaded in the same way as other tests like
> > > > test_parse_tcp_hdr_opt() are loading programs. I will keep
> > > > looking
> > > > some more into this
> > >
> > > Hi,
> > >
> > > I believe the culprit is:
> > >
> > >     insn->imm =3D BPF_CALL_IMM(bpf_dynptr_from_skb_rdonly);
> > >
> > > s390x needs to know the kfunc model in order to emit the call (like
> > > i386), but after this assignment it's no longer possible to look it
> > > up in kfunc_tab by insn->imm. x86_64 does not need this, because
> > > its
> > > ABI is exactly the same as BPF ABI.
> > >
> > > The simplest solution seems to be adding an artificial kfunc_desc
> > > like this:
> > >
> > >     {
> > >         .func_model =3D desc->func_model,  /* model must be
> > > compatible */
> > >         .func_id =3D 0,                    /* unused at this point */
> > >         .imm =3D insn->imm,                /* new target */
> > >         .offset =3D 0,                     /* unused at this point */
> > >     }
> > >
> > > here and also after this assignment:
> > >
> > >     insn->imm =3D BPF_CALL_IMM(xdp_kfunc);
> > >
> > > What do you think?
> >
> > Ohh interesting! This makes sense to me. In particular, you're
> > referring to the bpf_jit_find_kfunc_model() call in bpf_jit_insn()
> > (in
> > arch/s390/net/bpf_jit_comp.c) as the one that fails out whenever
> > insn->imm gets set, correct?
>
> Precisely.
>
> > I like your proposed solution, I agree that this looks like the
> > simplest, though maybe we should replace the existing kfunc_desc
> > instead of adding it so we don't have to deal with the edge case of
> > reaching MAX_KFUNC_DESCS? To get the func model of the new insn->imm,
>
> I wonder whether replacement is safe? This would depend on the
> following functions returning the same value for the same inputs:
>
> - may_access_direct_pkt_data() - this looks ok;
> - bpf_dev_bound_resolve_kfunc() - I'm not so sure, any insights?

For the bpf_dev_bound_resolve_kfunc() case (in fixup_kfunc_call()), I
think directly replacing the kfunc_desc here is okay because
bpf_dev_bound_resolve_kfunc() is findingthe target device-specific
version of the kfunc (if it exists) to replace the generic version of
the kfunc with, and we're using that target device-specific version of
the kfunc as the new updated insn->imm to call

>
> If it's not, then MAX_KFUNC_DESCS indeed becomes a concern.
>
> > it seems pretty straightforward, it looks like we can just use
> > btf_distill_func_proto(). or call add_kfunc_call() directly, which
> > would do everything needed, but adds an additional unnecessary sort
> > and more overhead for replacing (eg we'd need to first swap the old
> > kfunc_desc with the last tab->descs[tab->nr_descs] entry and then
> > delete the old kfunc_desc before adding the new one). What are your
> > thoughts?
>
> Is there a way to find BTF by function pointer?
> IIUC bpf_dev_bound_resolve_kfunc() can return many different things,
> and btf_distill_func_proto() and add_kfunc_call() need BTF.
> A straightforward way that immediately comes to mind is to do kallsyms
> lookup and then resolve by name, but this sounds clumsy.
>

I'm not sure whether there's a way to find the function's BTF by its
pointer, but I think maybe we can use the vmlinux btf (which we can
get through the bpf_get_btf_vmlinux() api) to get the func proto?

>
>
> I've been looking into this in context of fixing (kfunc
> __bpf_call_base) not fitting into 32 bits on s390x. A solution that

Sorry, I'm not fully understanding - can you elaborate a little on
what the issue is? why doesn't the __bpf_call_base address fit on
s390x? my understanding is that s390x is a 64-bit architecture?

> would solve both problems that I'm currently thinking about is to
> associate
>
> struct {
>     struct btf_func_model *m;
>     unsigned long addr;
> } kfunc_callee;
>
> with every insn - during verification it could live in
> bpf_insn_aux_data, during jiting in bpf_prog, and afterwards it can
> be freed. Any thoughts about this?
