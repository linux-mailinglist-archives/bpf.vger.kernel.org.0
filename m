Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BBD43BC58
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 23:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbhJZV1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 17:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbhJZV1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 17:27:01 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707DCC061767
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 14:24:37 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i65so1059545ybb.2
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6O5vbr72GKDlarVqLODX1PC787jPL/Yv8hW6xR71VDM=;
        b=bBxwS/tZFnQZgPCvdzEx+88Lk632snOXJM5ZohNsG41vIM7WRzDZBk1Hu1th6DXWSX
         F2KQofb8QL+TWOwZPTuXm9AIG5HLdI9Y4FsdCnCNpSk2BXbbXc7EcGuJ8p3Q08IIWDLO
         7CJ47pjaPwTDYc10U7MXbi25dyTe1IepKGsF88wnzSIm42lK9QWQPQ7A/cwwzgaiBaCO
         USNdKfiBbgCbGVMzORpmI26h/S+9oPeUcycsVRWENJI5b3vzDcXPmxdpU32UclDa5ST9
         QNQ3tyOBRUxQfhMOKdx4xUzXvGQXRl48UJvMMVje8fm/y6clgfwO57Qwu55nzhBPedRI
         915g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6O5vbr72GKDlarVqLODX1PC787jPL/Yv8hW6xR71VDM=;
        b=hF2exfzk2QtyIciA8mHe5LQxGp8H6xIGVoYteAzU8+1v2yc7iqo0gWK9MTX+vmmPG9
         8MfTE5vI0zyBxKpkMlMIeCBzHsm2ATOuqdtEqRLgLGJHq+bHfoMKDFGqQmilJMEvPEes
         Y57zPwS2mlDIFT+HhoVql++gctlvO/FEfzjqbM2dfRGYfxWXOQXaRMyd169+QEqr3CFg
         ftVxpYalcXRGoxUNQ5YD5xEzhkLUfntBlcfFXEBEUggwahQR3SFvh14PdpEVT6tc5pKU
         hdWE+g5ujqEZsslE5tnyaP5TVE4Lr80XQ1t/4YhXWKgqONhG3dlnFyEr9Ie4yeJqWeUq
         A8FQ==
X-Gm-Message-State: AOAM530v2qTVbdtPa9DnB0OHhQYo54J766E3qL8qdKSjteIFtCWqeZnl
        AnQxtEScQrIygTU/fOBeuzORXSMeJxjedMhDNlACkKbZtxY=
X-Google-Smtp-Source: ABdhPJwFdxK4q99Kr33oeW6QFucd/skGlXegm2tjPw1WyWDWw9qOeSfj/mp8qgLHKNBXcdbupgRvz7hdtD3ZhajYPJA=
X-Received: by 2002:a25:b19b:: with SMTP id h27mr1184606ybj.225.1635283476663;
 Tue, 26 Oct 2021 14:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com> <20211025231256.4030142-3-haoluo@google.com>
 <20211026034854.3ozkpaxaok7hk6kn@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbvXQ1qpGazNKCBhzUUPmmfe9d9icDtf++weJkJmme0aw@mail.gmail.com>
 <CAADnVQJQuZ9pP_T_ZDgoeTnqfPcRMcKM_BshBTpmsZiRmzWMgA@mail.gmail.com>
 <CAEf4Bzb2LdZrYVP+h5HxKS+H5tj-s7h_4xir_c3+bihaU5z_yQ@mail.gmail.com> <CAADnVQKo+jrFO4FVm=rm8q--hkHwBe9-iwDrdBzWW_aFxQ5KxA@mail.gmail.com>
In-Reply-To: <CAADnVQKo+jrFO4FVm=rm8q--hkHwBe9-iwDrdBzWW_aFxQ5KxA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 Oct 2021 14:24:18 -0700
Message-ID: <CAEf4BzYkM043BR9Vabj5khZ7-eBh31PM2FxF1jfpm7n_v_a=iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 12:23 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 26, 2021 at 11:45 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Oct 26, 2021 at 10:59 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Oct 25, 2021 at 10:14 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > Instead of adding new types,
> > > > > can we do something like this instead:
> > > > >
> > > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > > index c8a78e830fca..5dbd2541aa86 100644
> > > > > --- a/include/linux/bpf_verifier.h
> > > > > +++ b/include/linux/bpf_verifier.h
> > > > > @@ -68,7 +68,8 @@ struct bpf_reg_state {
> > > > >                         u32 btf_id;
> > > > >                 };
> > > > >
> > > > > -               u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > > > > +               u32 rd_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > > > > +               u32 wr_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > > >
> > > > This seems more confusing, it's technically possible to express a
> > > > memory pointer from which you can read X bytes, but can write Y bytes.
> > >
> > > I'm fine it being a new flag instead of wr_mem_size.
> > >
> > > > I actually liked the idea that helpers will be explicit about whether
> > > > they can write into a memory or only read from it.
> > > >
> > > > Apart from a few more lines of code, are there any downsides to having
> > > > PTR_TO_MEM vs PTR_TO_RDONLY_MEM?
> > >
> > > because it's a churn and non scalable long term.
> > > It's not just PTR_TO_RDONLY_MEM.
> > > It's also ARG_PTR_TO_RDONLY_MEM,
> > > and RET_PTR_TO_RDONLY_MEM,
> > > and PTR_TO_RDONLY_MEM_OR_NULL
> > > and *_OR_BTF_ID,
> > > and *_OR_BTF_ID_OR_NULL.
> > > It felt that expressing readonly-ness as a flag in bpf_reg_state
> > > will make it easier to get right in the code and extend in the future.
> >
> > That's true, but while it's easy to add a flag to bpf_reg_state, it's
> > not easy to do the same for BPF helper input (ARG_PTR_xxx) and output
> > (RET_PTR_xxx) restrictions. So unless we extend ARG_PTR and RET_PTR
> > with flags, it seems more consistent to keep the same pure enum
> > approach for reg_state.
> >
> > > May be we will have a kernel vs user flag for PTR_TO_MEM in the future.
> > > If we use different name to express that we will have:
> > > PTR_TO_USER_RDONLY_MEM and
> > > PTR_TO_USER_MEM
> > > plus all variants of ARG_* and RET_* and *_OR_NULL.
> > > With a flag approach it will be just another flag in bpf_reg_state.
> >
> > All true, but then maybe we should rethink how we do all those enums.
> > And instead of having all the _OR_NULL variants, it should be
> > ARG_NULLABLE/REG_NULLABLE/RET_NULLABLE flag that can be or-ed with the
> > basic set of register/input/output type enums? Same for ARG_RDONLY
> > flag. Same could technically be done for USER vs KERNEL memory in the
> > future.
>
> Exactly. OR_NULL is such a flag and we already struggled to
> differentiate that flag with truly_not_equal_to_NULL and may_be_NULL.
> That's why all bpf_skc* helpers have additional run-time !NULL check.
>
> ARG_NULLABLE/REG_NULLABLE/RET_NULLABLE would make it cleaner.
> And ARG_RDONLY would fit that model well.
>
> > It's definitely a bunch of code changes, but if we are worried about
> > an explosion of enum values, it might be the right move?
> >
> > On the other hand, if there are all those different variations and
> > each is handled slightly differently, we'll have to have different
> > logic for each of them. And whether it's an enum + flags, or a few
> > more enumerators, doesn't change anything fundamentally. I feel like
> > enums make code discovery a bit simpler in practice, but it's
> > subjective.
>
> I think it's a bit of a mess already.
> ARG_PTR_TO_BTF_ID has may_be_NULL flag.
> Just like ARG_PTR_TO_BTF_ID_SOCK_COMMON.
> but RET_PTR_TO_BTF_ID doesn't.
> PTR_TO_BTF_ID doesn't have that may_be_NULL assumption either.
>
> imo cleaning up OR_NULL will be very nice.
> RDONLY would be an addition on top.
> We can probably fold UNINIT as a flag too.
>
> All that will be a big change, but I think it's worth it.

Yep, agree.
