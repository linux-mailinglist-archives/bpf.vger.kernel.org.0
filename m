Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95533B0841
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhFVPK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhFVPK1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 11:10:27 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D61BCC061574
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=qNCCJxY+hmMYxqKJdnBPg968MFkKt6qsLW
        IrkmqAq/s=; b=VtzTML8Wqf5D5G9Nt2msWhux/c3pm5K0H0O928u9QEaHSN342g
        mS2OlpVOJIavBLsfFF4SmaKDSTPOXzT0G84b/ibSzD8a6Gomx2X7ZGDFVsLzokDb
        pYWFVtAhJSqpCaHZAxhj1I0bU8yMq4O6Rkm9fO5klxzei3BtiIQoUsPUQ=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBHTobW_NFgyM0bAQ--.5615S2;
        Tue, 22 Jun 2021 23:08:06 +0800 (CST)
Date:   Tue, 22 Jun 2021 23:02:29 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: BPF calls to modules?
Message-ID: <20210622230229.07f5c557@xhacker>
In-Reply-To: <56086fb4-3fdb-9e81-227c-721934fe2cb4@ghiti.fr>
References: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
        <CAEf4Bzbt1wvJ=J7Fb6TWUS52j11k3w_b+KpZPCMdsBRUTSsyOw@mail.gmail.com>
        <30629163-4a65-43f6-c620-9611e45815c4@ghiti.fr>
        <CAADnVQ+vcdO2SLnEeo5R4=8bTrkQiv-x2Ejcg08OsoZJJ4RXhw@mail.gmail.com>
        <56086fb4-3fdb-9e81-227c-721934fe2cb4@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygBHTobW_NFgyM0bAQ--.5615S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8tF4xKF13WFWxurWruFg_yoW5WFyUpa
        yrCa1UGF48ArWxAFn2qws7XF12kFyxXrZ8WF15Gw13ur909r1kKF48tw15ur9Fyr4I9w1Y
        gr4Ut3sFv34UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
        JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU56UDtUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alex,

On Tue, 22 Jun 2021 09:31:33 +0200
Alex Ghiti <alex@ghiti.fr> wrote:

> Hi Alexei,
>=20
> Le 22/06/2021 =C3=A0 02:28, Alexei Starovoitov a =C3=A9crit=C2=A0:
> > On Sun, Jun 20, 2021 at 11:43 PM Alex Ghiti <alex@ghiti.fr> wrote: =20
> >>
> >> Hi,
> >>
> >> Le 18/06/2021 =C3=A0 19:32, Andrii Nakryiko a =C3=A9crit : =20
> >>> On Fri, Jun 18, 2021 at 2:13 AM Alex Ghiti <alex@ghiti.fr> wrote: =20
> >>>>
> >>>> Hi guys,
> >>>>
> >>>> First, pardon my ignorance regarding BPF, the following might be sil=
ly.
> >>>>
> >>>> We were wondering here
> >>>> https://patchwork.kernel.org/project/linux-riscv/patch/2021061500492=
8.2d27d2ac@xhacker/
> >>>> if BPF programs that now have the capability to call kernel functions
> >>>> (https://lwn.net/Articles/856005/) can also call modules function or
> >>>> vice-versa? =20
> >>>
> >>> Not yet, but it was an explicit design consideration and there was
> >>> public interest just recently. So I'd say this is going to happen
> >>> sooner rather than later.
> >>> =20
> >>>>
> >>>> The underlying important fact is that in riscv, we are limited to 2GB
> >>>> offset to call functions and that restricts where we can place modul=
es
> >>>> and BPF regions wrt kernel (see Documentation/riscv/vm-layout.rst for
> >>>> the current possibly wrong layout).
> >>>>
> >>>> So should we make sure that modules and BPF lie in the same 2GB regi=
on? =20
> >>>
> >>> Based on the above and what you are explaining about 2GB limits, I'd
> >>> say yes?.. Or alternatively those 2GB restrictions might perhaps be
> >>> lifted somehow? =20
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
> >> kernel or module call will always emit a BPF_CALL? =20
> >=20
> > Are those questions for riscv bpf JIT experts? =20
>=20
> Yes more or less, sorry about that, I added Bjorn in cc in case he wants=
=20
> to intervene. But I think my last question is relevant: Is there then=20
> any guarantee that a kernel or module call will always emit a BPF_CALL?=20

Just my humble opinion: not always, but some kernel/module functions may
call BPF. The problem is we dunno where the kernel or module functions
sit.

> Because that would mean that we don't need to place BPF close to modules=
=20
> since BPF_CALL are JITed into an absolute branch in riscv.
>=20
> Sorry to bother,
>=20
> Thanks you for your time,
>=20
> Alex
>=20
> > Like 'relative or absolute' depends on arch.
> > On x86-64 BPF_CALL is JITed into single x86 call instruction that
> > has 32-bit immediate which is PC relative.
> > Every JIT picks what's the best for that particular arch.
> >  =20


