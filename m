Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7A2C342A
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 23:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbgKXWnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 17:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgKXWnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 17:43:21 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E02C0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 14:43:19 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so406498lfh.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0xubkNCkw4Vey+QtA2TkTMu7JWGpT7l/+KeZsc8pdQ=;
        b=fOsQCiYotoZNPIvufitAqF0ghtGmLiTOY7Tuk0BOZuVX5azFIxb7GqFIBFKTMKHQVu
         nNc6CyxIfPTkQ70U0fphFGVVcvdKMeFMOQBtamx9rFoX0HjcCoLjY9wspx5hLhOh2ops
         thLwP8uQ4a840SJ4EBrquyjxV1+LAQ0THB8A29Z/mTlYu0TMu2MlwuTxjOeUB7uaLK9X
         86W3qwF1eHTwho6kFsPzm9TZhPBobOVMlrA6AhlbaP+Vs/alaZO1oUAzIfbW/gt89dlh
         JvO+Ky/iq+9Q4Cciuaql63HXAPFjrEZylh/zTCaWyGu2JaR3TKBHED8td+c81O+/SobY
         hslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0xubkNCkw4Vey+QtA2TkTMu7JWGpT7l/+KeZsc8pdQ=;
        b=dUAqJDohmsMhVyJTx3d05X8Gs09VeVdkColgRrKOUG01Db1dUDmm6SsX39yEhFXJuJ
         igb+1T/lJjo4UqwHo/TrSajei23DeOhBZxggavM6IVXXIlVLb8Rsn0SMLqxNnyqtWLnV
         b2Hfk5ary+1OYcpG6XY8L+2mA/31V2odJCB1NFbgUvYAPBWXxjMaRL8ZIjbbo67g2jtE
         3qIEXff+NW7+wS+Jz5oP7hk0Azw4cDl4MHLwk8A3AQQTQP8w/dkhDnCdAvTEObrRsg28
         SxMs6g8SqbzHGGMTTCoRZ2Py5ngVv7Co0B4RrI+MFHvPl4GUKi+VgApc2qI190MNdadY
         dhVw==
X-Gm-Message-State: AOAM533F9RbYWDTyLsVh2faaGBviTO08Ki3SQVaqn+JvE3hbaFKPZW1P
        HE+bbocGEx7ghNOpzklNY+oMDAkGJW1OlGhzDzs=
X-Google-Smtp-Source: ABdhPJyTanD5ENswnyzSP7HOQF2qI5fSIACme6LApYXAz1kdDGr6Q1WF+AijnNkreRzixmobLnj3jUEXrwrlDPtD3WM=
X-Received: by 2002:a19:2390:: with SMTP id j138mr139681lfj.390.1606257797967;
 Tue, 24 Nov 2020 14:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20201123173202.1335708-1-jackmanb@google.com> <20201123173202.1335708-4-jackmanb@google.com>
 <20201124065004.pdgjfkqvzywb5l2c@ast-mbp> <20201124112130.GD1883487@google.com>
In-Reply-To: <20201124112130.GD1883487@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Nov 2020 14:43:06 -0800
Message-ID: <CAADnVQ+RiyCLvgygY3PEMmQ1b9v19ZEw8qC-ajBcbyi6DkhCow@mail.gmail.com>
Subject: Re: [PATCH 3/7] bpf: Rename BPF_XADD and prepare to encode other
 atomics in .imm
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 24, 2020 at 3:21 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Mon, Nov 23, 2020 at 10:50:04PM -0800, Alexei Starovoitov wrote:
> > On Mon, Nov 23, 2020 at 05:31:58PM +0000, Brendan Jackman wrote:
> > > A subsequent patch will add additional atomic operations. These new
> > > operations will use the same opcode field as the existing XADD, with
> > > the immediate discriminating different operations.
> > >
> > > In preparation, rename the instruction mode BPF_ATOMIC and start
> > > calling the zero immediate BPF_ADD.
> > >
> > > This is possible (doesn't break existing valid BPF progs) because the
> > > immediate field is currently reserved MBZ and BPF_ADD is zero.
> > >
> > > All uses are removed from the tree but the BPF_XADD definition is
> > > kept around to avoid breaking builds for people including kernel
> > > headers.
> > >
> > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > ---
> > >  Documentation/networking/filter.rst           | 27 +++++++++-------
> > >  arch/arm/net/bpf_jit_32.c                     |  7 ++---
> > >  arch/arm64/net/bpf_jit_comp.c                 | 16 +++++++---
> > >  arch/mips/net/ebpf_jit.c                      | 11 +++++--
> > >  arch/powerpc/net/bpf_jit_comp64.c             | 25 ++++++++++++---
> > >  arch/riscv/net/bpf_jit_comp32.c               | 20 +++++++++---
> > >  arch/riscv/net/bpf_jit_comp64.c               | 16 +++++++---
> > >  arch/s390/net/bpf_jit_comp.c                  | 26 +++++++++-------
> > >  arch/sparc/net/bpf_jit_comp_64.c              | 14 +++++++--
> > >  arch/x86/net/bpf_jit_comp.c                   | 30 +++++++++++-------
> > >  arch/x86/net/bpf_jit_comp32.c                 |  6 ++--
> >
> > I think this massive rename is not needed.
> > BPF_XADD is uapi and won't be removed.
> > Updating documentation, samples and tests is probably enough.
>
> Ack, will tone down my agression against BPF_XADD! However the majority
> of these changes are to various JITs, which do need to be updated, since
> they need to check for nonzero immediate fields. Do you think I should
> keep the renames where we're touching the code anyway?

Ahh. The JITs need to check for imm==0 and enotsupp the rest?
Right. In such case updating all JITs at once is necessary.
I was hoping to avoid touching all of them to minimize the chance of
merge conflicts.
Looks like it's inevitable. I think it's fine then.
