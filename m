Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749AA3A32D3
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 20:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFJSRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 14:17:11 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:42499 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhFJSRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 14:17:10 -0400
Received: by mail-lj1-f171.google.com with SMTP id r16so6168020ljk.9
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6+5qvZMt+S1ao1mEsv4LDBVlBQ4z3XhfhG4lSaYBvQ=;
        b=htozv7O2BpTanC806x0h5ENZRG/qcCgARMmlUFYp8cBGJVWP+a8h0vZt31qkxNxx66
         tdOdQICwAiP52KRLMu4I5tSJkHCqcCQqb0p3r7+NC9VNdB4Wu4j0PC04Lw07P74QSwmD
         6wMcoFpsejStlFSbRdqkZhbDnMk5umeKwuGnDRyeXLPB/VdYUQygGpD2szHcRQPlf1EE
         K39EYiS9EfntYXhOV5fuk0s3WwPDwZZjurnZHiBUNjFZ9LDvjGifaqebvihK2XvuocZC
         6aYX4WO89Jj0Jp0eR/t55DmrVSwHB8Fd8NuM61l68YQCmNfFb0AxLo5H/eiKRYKzu6VH
         Jj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6+5qvZMt+S1ao1mEsv4LDBVlBQ4z3XhfhG4lSaYBvQ=;
        b=NVAj+HnWwrRxNExRDRQstVqyid4NKWY/OY1hT3xHkWlmpXuKzOHPiBHjmNNjOh9fpP
         NnX8d7oZ2b4xKqOMOYG7e06ofVby15WVIaRpex7c05Y0zJnt+LQINhM/rdB76/tPZ4Ju
         iL8c7C39b8s67LMtk7hmcF0O+GENnnh2bMkHiB0YbaSMsGSCdde+eWUC43nVenwbvmUM
         se0iPqnLSfDhBgzfv3c+3XpuB2XET+lqyUCEtWiPtl2uRMDHCybUumiC8Tid5bRgR7Dq
         xeLCNkXZWqroGt96lwV4HgVUGRKluh9VdBY6LX/Zp4xdk+z4MoKOxn0913u2L4pOSvXp
         Q0Tw==
X-Gm-Message-State: AOAM532YYrAQv0YRy932qgpthwT2n10LkHCFtF30cnXZCKz9YpHq4gFQ
        g6k/w8nwP7irr1daWGJKQ5ygcfl9DcWB30r2hdU=
X-Google-Smtp-Source: ABdhPJzzl8JdXQgzZ0xIqj0hRJXdMZ4xoYAcIsxYxOhKZ1ilfAdnb11kKSHIhhw8UTA95FrALQCtvdXfosc7w1TWlgU=
X-Received: by 2002:a05:651c:28e:: with SMTP id b14mr3112716ljo.486.1623348853030;
 Thu, 10 Jun 2021 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
 <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com>
 <CACAyw99QydcWBeE3T_4g5QzuDyfb_MEpR1V0EzEwbY=R-s202w@mail.gmail.com>
 <CAEf4BzZftL2q9qAoeXsO87-Wx9AbF8A1mLnBAtBrGo=XSx996g@mail.gmail.com>
 <CACAyw9-mHGrvrWozqngJ8X4qzqxB8Yku+AaL_Rv8RZhLXPRwJQ@mail.gmail.com>
 <CAEf4BzYz19hg6H4jieEzZQR1e3R3OOkLBiQLzCxQM+=cvQTGow@mail.gmail.com> <CACAyw99m8rbE5L9LAowYwvAkza+twuet2tdas2eotsf3uWgGTQ@mail.gmail.com>
In-Reply-To: <CACAyw99m8rbE5L9LAowYwvAkza+twuet2tdas2eotsf3uWgGTQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Jun 2021 11:14:01 -0700
Message-ID: <CAADnVQJu0gbKXLYQ_whsh0sENkxR7E3XOuVfAFrPkyXhQtdG1g@mail.gmail.com>
Subject: Re: Portability of bpf_tracing.h
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 10, 2021 at 7:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:

> > > The idea of basing this on unique fields in types is neat, the
> > > downside I see is that we encode the logic in the BPF bitstream. If in
> > > the future struct pt_regs is changed, code breaks and we can't do much
> >
> > If pt_regs fields are renamed all PT_REGS-related stuff, provided by
> > libbpf in bpf_tracing.h will break as well and will require
> > re-compilation of BPF application.
>
> I'm thinking more along the lines of, if a PT_REGS definition changes
> so that the unique field isn't unique anymore. The BPF is still valid,
> but the logic that determines the platform isn't.

struct pt_regs is uapi on every arch.
They cannot change. New registers can be added :) but the chance is
close to zero.
