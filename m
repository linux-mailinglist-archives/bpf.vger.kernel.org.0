Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF985275D3F
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIWQVR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIWQVQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 12:21:16 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE2C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 09:21:16 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id j76so204737ybg.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myy0HA7+uiqlJDacB3giSw/qE/5Sw7aO+uRmnAb+oVo=;
        b=sk62LhXSsfweDZSYKuDhZYodC+fA0FbdmxBS3TYFEaJTTTS8kdxc5Rd7dxsrub7PyF
         Jtf0lYqOWU7EeojccF/902XTU3uo4vcd+XaCqA3XgN/BepFll53W+9UGbsh4jEgQLeNp
         bTqE/KTuQnm7MrncAA7v4AYTKb0mu8lpMJdHf9cckwdmXeErPxRJkP6w0DbiBmnBzIcY
         SaaO8HLTFLGrwCMr9P8D1Psaq6C5I+4fIl65zx5m5RcWixBa3yUM9beNwBKZvsQozyPl
         AVRjv3pJiAff4wakdG+KPDLhOWUpVp9C540q3zM1oh7MAgSBPtFO7EelJSn2snx3S55R
         oYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myy0HA7+uiqlJDacB3giSw/qE/5Sw7aO+uRmnAb+oVo=;
        b=LpAj+VQEvy6Q2ycTA8sF6Rk7ZB5uvTX8y5QcxMDofOydGMoMyOAnQ8YWrRvv5mpTDR
         tqgiD/Sx/VxJ06olUtkaBQ52KVVWl0Q9dKHlJ/cVSgxBLhepmsYxC4SciPL81c5HeGkB
         e8iBA3IQ9r40JmXiqYSrg1hulFz0ZkmFA2Uf9AFlCTlqWLp6cAr/BrPzbEzN9qoM5pQu
         DMUS3w5qAT6ICDCiKkyRFZgHZR68WhTrtvgPz06d+6ZOplRAQnMOvWQCGaYZ1kd9r1Jh
         4r5qHP8UT2XylCTYFcgfxFUxch4DQmtTLRd5PSD6tS3y1yFF6BsshGjvHlACq2CvCmwE
         nLvg==
X-Gm-Message-State: AOAM533tROMNH5z2WhCiuyJPDsc8fhLhVw1Cm1/O2kY5Ev6UcvYtf3B8
        TLuW2rglfZDVzg9wWYqXQ0Q/4DCSZOe+Asnleb8=
X-Google-Smtp-Source: ABdhPJzsqeXMEB7BF+psEEf2UGwK7HnRWstrDAFRDL49Qn5N739kZZLKNtLC6RFrFg4vQOd9TxYDEf21GXd+NFaunFo=
X-Received: by 2002:a25:4446:: with SMTP id r67mr1007519yba.459.1600878075946;
 Wed, 23 Sep 2020 09:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <80d19887-5b77-a442-5207-a2685cdd1f83@fb.com> <CACAyw9-zry08xTRGUHCh8VSp0eF9cFQjGiur0jDnA-YMaZ=Niw@mail.gmail.com>
In-Reply-To: <CACAyw9-zry08xTRGUHCh8VSp0eF9cFQjGiur0jDnA-YMaZ=Niw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Sep 2020 09:21:04 -0700
Message-ID: <CAEf4BzYteTG41ST2dJ+kVdroB8ACQbYf1avBRjZHt+Qzt=o8Zw@mail.gmail.com>
Subject: Re: Help testing llvm patch to generate verifier friendly code
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 9:15 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Wed, 23 Sep 2020 at 08:17, Yonghong Song <yhs@fb.com> wrote:
> >
> > Hi,
> >
> > I have spent some time to add additional logic in llvm BPF backend
> > in order to generate verifier friendly code.
> >
> > The first patch is:
> >    https://reviews.llvm.org/D87153
> > which moves CORE relocation builtin handling from in late IR
> > optimization (after inlining and major optimizations)
> > to in early IR optimization (before inlining and any optimizations).
> > The reason is to prevent harmful CSEs.
> >
> > But this change may change how compiler do optimizations.
> > The patch can pass bpf selftests in latest bpf-next.
> > Andrii helped it can also pass bcc/libbpf-tools.
> >
> > If your code uses COREs, esp. having a lot of subroutines
> > and/or loops, it would be good to give a try with new patch
> > to see whether there are any issues or not. In my case,
> > for one of our internal applications with lots of subroutines
> > and loops, inlining all subroutines and unrolling all loops
> > will cause register spills which cannot be handled by
> > the verifier, while existing llvm won't have issue.
>
> Hi Yonghong,
>
> We currently don't use CORE (outside of bcc, etc.), so there isn't
> much I can test I guess? Please let me know if there is something I
> can do for your follow up patches.
>

It would still be good if you could test all three Clang/LLVM patches
Yonghong referenced. The latter two are not CO-RE-specific. Thanks!

And pedantic nit: BCC doesn't use CO-RE, it just does runtime
compilation using local kernel headers with exact memory layout of
kernel structs.

> Best
> Lorenz
>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
