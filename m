Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A52251D74
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 18:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHYQsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 12:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgHYQst (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 12:48:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD8C061574
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 09:48:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so14595829ljc.10
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BVDGRS6YqPaUyu13bhF+7WAL0ig8ig+6/cwGkM6YGDU=;
        b=MqYbAZZ2x5+MfpcQBpHuAJ3USAVKSahgsUTZJHngPeY4uwmVhZIUMrEQHHq31caov9
         yyTofUr2p2DLkpSvaGd4iFj6hbQdDn+VCUlKlBPJg7DhYwmMW3Ja9UIxDN6NwB0WbVtt
         SCcxu57oD+38sDoW2uFJZ/q+eiZpGqPFfziICTXZ4gGIPclPPUq/YebkAXo4sdvemxMY
         RU7MAuiaNB8HTSY866neUgovRtcyxh/sNMOpnE2h2YrR57aCgaPNY/y/E4D1rQE76CBT
         7QXFy6Ii74/giqUdYyyHOi9VIXPZ6/wt/WQim/2exMuoaw43yjwGOamQmUHLQi3k9Kei
         dKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BVDGRS6YqPaUyu13bhF+7WAL0ig8ig+6/cwGkM6YGDU=;
        b=RG2KcvtC8rQhHU2o2jyn/cLYr8HY7B9ldLBCrii+z8JVDA8rgviqfTbxeYTRAcecjz
         bN18lzrv3b7rsC9tiHh/oeaeRLfJViIRHhSUK/y4C/RbYsgmlKn9d0qQcYmbLjpkqfVt
         XtY5JgCZW1twQEPK3Eeh+Uo2RXpvfYq1XH21um1jWatGM731nCgTNr8v02U/obvX0sO7
         z7sZ+92himJnM9oblYW7Afoo5089mLaVb40Uec/T51HOLqahdSAbl+5UqfHT5j+botwV
         nUD2RzMFObhPvhEOp3Yrx1qE6134TfraFADXT/FBvdina9FSI48akvXq1WXXSBQLMzPD
         9QZA==
X-Gm-Message-State: AOAM533Lir5yDRWkmYbbwfjPeIqTyw2bsKEgYbqINTTnOoPFbfRXTpV8
        BtVpZ8ijjvt7jqc37u+jnZplhFDIms2wevfa2DE=
X-Google-Smtp-Source: ABdhPJwu/RwDcHt464YLge6TW5LSDN1VHepf/0UqJTLR7STD4RTUrzazSPD3NAQgszLH3Gl0PZ8fUSm7o/3Fh/z7WrU=
X-Received: by 2002:a05:651c:82:: with SMTP id 2mr5336412ljq.2.1598374127469;
 Tue, 25 Aug 2020 09:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR83MB0275B96730F50564861C3C55FB570@AM0PR83MB0275.EURPRD83.prod.outlook.com>
In-Reply-To: <AM0PR83MB0275B96730F50564861C3C55FB570@AM0PR83MB0275.EURPRD83.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Aug 2020 09:48:36 -0700
Message-ID: <CAADnVQ+BpWg5aFMG2QV1OWvPgzrwqpPO+9fJ6NfwEPLp3Gp6Mw@mail.gmail.com>
Subject: Re: Clang | llc incorrect jumps
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 25, 2020 at 9:34 AM Kevin Sheldrake
<Kevin.Sheldrake@microsoft.com> wrote:
>
> Hello
>
> I've got some odd behaviour and I'd like to ask if anyone could spare a f=
ew moments to offer suggestions of what my error might be?  Maybe there is =
a different mailing list that this would be more appropriate to send to?
>
> I'm building a relatively complex eBPF program that attaches to the raw t=
racepoints, sys_enter and sys_exit, compiled with clang and llc using the s=
ame switches and includes as the kernel samples (kernel v5.3 on ubuntu 18.0=
4), loaded using the latest libbpf git sources.  The sys_exit program is qu=
ite big at 55045 instructions (unrolled loops so the same code will run on =
kernel v5.1) and contains illegal jumps.  Everything is inlined - using __a=
ttribute__((always_inline)) - and the programs themselves have the __attrib=
ute__((flatten)) applied.  The verifier complains:
> jump out of range from insn 15 to -10500
>
> If I remove one section of code, unrelated to where the illegal jumps are=
, reducing the overall size to 24480 instructions, the illegal jumps disapp=
ear.  If I reenable that section of code and remove a different section of =
code, also unrelated to the illegal jumps, reducing the overall size to 474=
44 instructions, the illegal jumps disappear again.

I suspect it's a bug in llvm. It doesn't have a check that the branch
target fits into 16-bits.
It simply does:
llvm/lib/Target/BPF/MCTargetDesc/BPFAsmBackend.cpp
    Value =3D (uint16_t)((Value - 8) / 8);
    support::endian::write<uint16_t>(&Data[Fixup.getOffset() + 2], Value,
                                     Endian);
Could you add a log around that line to double check that's the case?
May be you could send a patch to add an assert there?
It will help others avoid this debugging.

In the past we've talked about extending BPF ISA with 32-bit
unconditional jump instruction.
But no one didn't come around to actually implementing it.
Once we have such insn llvm should be able to detect this 16-bit overflow
and use this new jmp insn.
