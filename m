Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2938C43CFC5
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 19:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhJ0RfZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhJ0RfZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 13:35:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D34C061570;
        Wed, 27 Oct 2021 10:32:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so2606664pjb.4;
        Wed, 27 Oct 2021 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQBChEkhtFQMuVjrFTDIhbaj31TO4xmGXKwKQGnOWcs=;
        b=ZDGmGwDo5RnuiecC7SBBClnFGTmBM/X2+jXUwkHeS89LA+if+glDQ1k3g/oQbxMSO+
         qJvuRchbUG9K37AHQSUmMk64bc/ADd6X37t7h1caaxzpSGEEsz6qFEAwbRZA8Yqvhyym
         ozqgzOMJ8MOk8q38hLIc2R/pHU6ZZa8c3YlWTRtrMljJcRxeMPRYcurKGIMFStHyVF0X
         21/kQA69RsVDmUocBED3+c5GxGt7GsqBSElCwG8xZa+K+wX6s+xsAh7CZ1DRfkjNs+Se
         QTMSS+3BfDQKNTOVxgrvNo6nSQCekKgFxn/+r3kWBXAlHLYDLBW45DkD554Jvwsm+fIF
         7IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQBChEkhtFQMuVjrFTDIhbaj31TO4xmGXKwKQGnOWcs=;
        b=zUE8SEyTbzFHofeapKAO4nn5/qIDbUanTZOr+ADcC39MnfTvFx6fz/O+hsWWIK5QyA
         YLR2g/Sto+wysb5tBR+FgLLCfdLx8tmSkJI+1dEJ+qfaKGv4NejyTseKtbOGL6JhvgDt
         JYMWo+po3mPDF10ugntsTMzVw586MyZ0CxBHSmUItVuvOXrXgv/O+4nAZI+GAYTNlIyd
         zTw/rtQcH/XT9gD+a8WpZbaTyWBeIfiVXjG50NNZSMG837kUZlhBzNzRCUTnSoe9Yo+4
         4wPBc+q8CdkNqTFNm5aZgVzqGKi4s3oWxjLJm8ms/pDqKCoUWRM0Njwe2TxDIsyr1U6S
         ZKGA==
X-Gm-Message-State: AOAM5331I0Fv3wOikj15mJ6kcJRx1e8LXT5LSA0BCCnT+vieTHLC3XGs
        vRIF9HOuB/NCOSHAn21mdLx9INyrDoptP4Lv22o=
X-Google-Smtp-Source: ABdhPJxJ9RcQO8lR5LgHho8LtnEICkSPFV9VreN0Owub71aRxlP/jMdoV1d9HHQ+U032S5WPmcKI5c5vbHTJIRjb5g4=
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr7349063pjj.138.1635355979040;
 Wed, 27 Oct 2021 10:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211026120132.613201817@infradead.org> <CAADnVQJaiHWWnVcaRN43DcNgqktgKs3i1P3uz4Qm8kN7bvPCCg@mail.gmail.com>
 <YXhMv6rENfn/zsaj@hirez.programming.kicks-ass.net> <CAADnVQ+w_ww3ZR_bJVEU-PxWusT569y0biLNi=GZJNpKqFzNLA@mail.gmail.com>
 <20211026210509.GH174703@worktop.programming.kicks-ass.net>
 <CAADnVQ+NA2J3Lxvb8Y31yaubM6ntx5LtoSEaLziZ1b8qiY4oYQ@mail.gmail.com> <YXkVGSG3BkMUEaKH@hirez.programming.kicks-ass.net>
In-Reply-To: <YXkVGSG3BkMUEaKH@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 27 Oct 2021 10:32:47 -0700
Message-ID: <CAADnVQL0tnF+8Wch1Uq3nH3Bi+Ogo2uK4gqY46o7E4A+Dx+Mhg@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
To:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 26, 2021 at 02:05:55PM -0700, Alexei Starovoitov wrote:
>
> > Please post it. CI cannot pull it from the repo.
>
> Done:
>
>   https://lore.kernel.org/bpf/20211027085243.008677168@infradead.org/T/#t

Perfect. Thanks!
Looks like vger got into 'delete all users' mode.
Looks like my and many other emails were automatically unsubscribed
from many mailing lists.
bpf@vger, netdev@vger, linux-kernel@vger user count looks very low
compared to a few weeks ago.
I doubt all these users decided to unsubscribe themselves.

Anyway looks like BPF CI doesn't see the patchset yet for some reason
(we're debugging),
but I've tested your patchset manually the same way CI would do
and reviewed most of the patches.
Please add:
Acked-by: Alexei Starovoitov <ast@kernel.org>
to bpf patches 16 and 17
and
Tested-by: Alexei Starovoitov <ast@kernel.org>
for the whole set.

Thanks!
