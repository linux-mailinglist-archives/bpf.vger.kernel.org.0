Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADF83B0B60
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 19:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhFVR2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVR2W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 13:28:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE6C061574
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 10:26:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h15so18651852lfv.12
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0ykvj3V6MJaK2WmlftY81Jo8AUEdmBvWqmeD2T+cJ3w=;
        b=kdM2HvsREN2rgajxQxFUcWAuUzLdmo8RQktQx0ZijUqWnjMElOAsSTU+nT8e/7oo15
         1fFXesYGM7oBAhL1gdU20FGOXquese6xFWm/d1tlmIcI6TryUu8HOUjnNX2k1gOZPiWp
         Roc3XrhLRVhlsi3HZyPum+nZ6EKq9kBHTfD/ILlxYRIxCCgE3TmXTbadL/q6Bk4ryb4q
         FETZemsFPbQlXXR+PcBaZQfCFjW2rKgfBNMu657wkwhzl9YhbN6wWNqF5WcVMh8pyjnY
         qzBv3xydgUTdmj7/vh2gZKdUkHNAb3ZJQ/Yeegp60xOz9O+9xTQ4Oj/+VrT3VGfmIBlz
         cZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ykvj3V6MJaK2WmlftY81Jo8AUEdmBvWqmeD2T+cJ3w=;
        b=YjCDrieB4F/EM5GtRIW7o7DC1pwrDh72Cq5sUITXO11WdSZ/S+NRKoEx9pJvkPkVV7
         rBI5kAbQVrnX9OLPeD0wuN+AdNTw8zvL7B34ZkVJgYYIh4USQfOoEAGvMl+WKowfTEHc
         aO8/7dtTWMTYbC9jXML7HqlLTwBcG5ImnqqeTzsu6Tov3ZDlG1sEPdhcQwRF22yLabuk
         oWTO6v7gq4IntdX0HK0g174xVarYqchPpw01Apw/RfOo0iLMnKqXNUGs7ZzbAfSEdkU2
         y3rEJbjFpwPVA0yISGnyYEcTWnL0LcbdyLgbJJlT75RWP2x1ai8ei91Tjiu57rvbNrbY
         4xiQ==
X-Gm-Message-State: AOAM531EQlpxrvIWTwnlk2Cv21RbMf44brZeDCptl1MlZDM8DDGLwWMv
        nxYtmL/wp9xT+Wc0JlPjshVFba0UfY/CjD+g/E0WsN+1
X-Google-Smtp-Source: ABdhPJxqUL13M/qA6awEWA+bZ/DVxulRpZ9VKvoPfzbq9iu7lZhDXVBUIXRJQ3xG6136f1podyoFDQPRg4XNM+WAY3A=
X-Received: by 2002:ac2:4e82:: with SMTP id o2mr3867058lfr.38.1624382763180;
 Tue, 22 Jun 2021 10:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
 <CAEf4Bzbt1wvJ=J7Fb6TWUS52j11k3w_b+KpZPCMdsBRUTSsyOw@mail.gmail.com>
 <30629163-4a65-43f6-c620-9611e45815c4@ghiti.fr> <CAADnVQ+vcdO2SLnEeo5R4=8bTrkQiv-x2Ejcg08OsoZJJ4RXhw@mail.gmail.com>
 <56086fb4-3fdb-9e81-227c-721934fe2cb4@ghiti.fr>
In-Reply-To: <56086fb4-3fdb-9e81-227c-721934fe2cb4@ghiti.fr>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 22 Jun 2021 10:25:51 -0700
Message-ID: <CAADnVQJLwQhFZbNqA4jfJiqvKV2E8crOYns6oTCeDFeKoSmgBQ@mail.gmail.com>
Subject: Re: BPF calls to modules?
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 22, 2021 at 12:31 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Alexei,
>
> Le 22/06/2021 =C3=A0 02:28, Alexei Starovoitov a =C3=A9crit :
> > On Sun, Jun 20, 2021 at 11:43 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >>
> >> Hi,
> >>
> >> Le 18/06/2021 =C3=A0 19:32, Andrii Nakryiko a =C3=A9crit :
> >>> On Fri, Jun 18, 2021 at 2:13 AM Alex Ghiti <alex@ghiti.fr> wrote:
> >>>>
> >>>> Hi guys,
> >>>>
> >>>> First, pardon my ignorance regarding BPF, the following might be sil=
ly.
> >>>>
> >>>> We were wondering here
> >>>> https://patchwork.kernel.org/project/linux-riscv/patch/2021061500492=
8.2d27d2ac@xhacker/
> >>>> if BPF programs that now have the capability to call kernel function=
s
> >>>> (https://lwn.net/Articles/856005/) can also call modules function or
> >>>> vice-versa?
> >>>
> >>> Not yet, but it was an explicit design consideration and there was
> >>> public interest just recently. So I'd say this is going to happen
> >>> sooner rather than later.
> >>>
> >>>>
> >>>> The underlying important fact is that in riscv, we are limited to 2G=
B
> >>>> offset to call functions and that restricts where we can place modul=
es
> >>>> and BPF regions wrt kernel (see Documentation/riscv/vm-layout.rst fo=
r
> >>>> the current possibly wrong layout).
> >>>>
> >>>> So should we make sure that modules and BPF lie in the same 2GB regi=
on?
> >>>
> >>> Based on the above and what you are explaining about 2GB limits, I'd
> >>> say yes?.. Or alternatively those 2GB restrictions might perhaps be
> >>> lifted somehow?
> >>
> >>
> >> Actually we have this limit when we have PC-relative branch which is o=
ur
> >> current code model. To better understand what happened, I took a look =
at
> >> our JIT implementation and noticed that BPF_CALL are implemented using
> >> absolute addressing so for this pseudo-instruction, the limit I evoked
> >> does not apply. How are the kernel (and modules) symbol addresses
> >> resolved? Is it relative or absolute? Is there then any guarantee that=
 a
> >> kernel or module call will always emit a BPF_CALL?
> >
> > Are those questions for riscv bpf JIT experts?
>
> Yes more or less, sorry about that, I added Bjorn in cc in case he wants
> to intervene. But I think my last question is relevant: Is there then
> any guarantee that a kernel or module call will always emit a BPF_CALL?
> Because that would mean that we don't need to place BPF close to modules
> since BPF_CALL are JITed into an absolute branch in riscv.

I don't understand what you mean with this question.
BPF_CALL is a BPF instruction to call from bpf prog. Not into bpf prog.
When kernel or module calls into JITed bpf prog
they use indirect call insn of the given arch.
In case of bpf dispatcher there is a generated asm code that uses jmp
by register
or retpoline style.
So JITed bpf progs not only 'called' into.
From bpf prog the helpers and kernel funcs are called via BPF_CALL.
And this bpf insn has 32-bit offset requirement across archs. So all callab=
le
functions have to be in the same 4G region. So far that was the case
for all archs.
If riscv is going to separate things by more than 4G it will cause
plenty of headaches
for riscv JIT.
