Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D092DB606
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 22:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgLOVsa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 16:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbgLOVsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 16:48:25 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB276C0617A6
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 13:47:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 82so13478297yby.6
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 13:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qX1Ok1n0v/SV+xNE2gIZeCW8Di4zZBrpOUn6WQ3XCZ8=;
        b=O1QEK6fHkMkh+PQ6SRGDOFmA8ivm8NE6ECabUWqUrUAmbT8GRAv6TIPFCwtt9JvEEq
         jmFKqFR0T1bMJ5jWCtYmt6ojJb+4j+jHU0zlQqeXb8i+Hf0i15DWQn1h1PeSMTZ0p04t
         1L2IyHPrGU+eu7ZEAkpcCOKTupwicXfLIJd2LrlbNsWPfemFFe1yCKp7syOtuDL+b8P8
         VTbh+5pMjTTTjsJSEt64RfX+uz0JGQUNr5xguv5KtllKq5DvANfwxuF/6HKVfn8iBXDf
         5rOjc/RHDAZbPpGtGH+R3O/ix+XEX3ZCn0dW2GuM7awEj3ZvrMAxcmovLfJBARChz/WU
         UGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qX1Ok1n0v/SV+xNE2gIZeCW8Di4zZBrpOUn6WQ3XCZ8=;
        b=RQKVbQFEu5scFumcRLz9L5Qn60t16w18nSmu9WDlm0GpXskvvnXo2iShX/PYcjsW0G
         AHHUDhTAzKb1fSO9z+MXg27kzUPGcJkWPSsWDdR8Ad5r29mXACuzd43Kxp/rlwOoNdhX
         xgiw3DEgMS4p9pNn/SqWOaM+o8+0h+J6YtVdjbzsx23urTnv5th7TplqsIb+PFMPeXlJ
         KJzF6QWstfOBQtnEdsOn+rYhTI4NsiDMUIDESQj+SYTK+c588b7Yv8KWGfjAf5fB1j2m
         D1a7dLxtNPdv2gY5QsRRvbaleT/5ypDW22C8UBo1UXY2cXxYu+/NyTThihhBfCPEte2a
         jyIg==
X-Gm-Message-State: AOAM531oaXSkpawJkdFs7KQzRWvDAoWF0lyoTkek42ti7L1ZGfOQwPG+
        UOHnRh+/uLo9UVCU6ShuDI1akbxaqRMgR5Iajng=
X-Google-Smtp-Source: ABdhPJw9Zhg3nFg8b2CMFrGXGturI7GcSLyKEYfAJcWTv7bssdLSZapm29abIgF+F00gYmzQ+8U8+DRPzWSazCylV54=
X-Received: by 2002:a25:f505:: with SMTP id a5mr45048224ybe.425.1608068863908;
 Tue, 15 Dec 2020 13:47:43 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3EH2tS=LnAoRfYsnO-zs5qaO7GuHDhw03==t+B_C8Gf2w@mail.gmail.com>
 <CAEf4Bza4P51cGFN4zgTBr5nt_3tcoeGQ-QfP5CjoGx2scJP5-g@mail.gmail.com>
 <CANaYP3Euo8XYsDtqgoESLT_VRPGDKEyR8c0Wf3z1r_+nvS+ffw@mail.gmail.com>
 <CAEf4Bzb3ShNmD=_6XqUfL7DSDd_3rDcuuPN0Y4u8qVK2uOUsAA@mail.gmail.com> <CANaYP3GetBKUPDfo6PqWnm3xuGs2GZjLF8Ed51Q1=Emv2J-dKg@mail.gmail.com>
In-Reply-To: <CANaYP3GetBKUPDfo6PqWnm3xuGs2GZjLF8Ed51Q1=Emv2J-dKg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Dec 2020 13:47:32 -0800
Message-ID: <CAEf4BzZdFB_PgB4sYLn5xcNY5DDihWwZ8_0WvrLJL7zGETD4iQ@mail.gmail.com>
Subject: Re: libbpf CO-RE read_user{,_str} macros
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 12:44 PM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> On Tue, Dec 15, 2020 at 8:47 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Dec 15, 2020 at 4:50 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> > >
> > > On Tue, Dec 15, 2020 at 3:26 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 14, 2020 at 1:58 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> > > > >
> > > > > Hello there,
> > > > > libbpf provides BPF_CORE_READ macros for reading struct members in a
> > > > > CO-RE compatible way. By default those macros reduct to the relevant
> > > > > bpf_probe_read_kernel functions. As far as I could tell, there are no
> > > > > variants of this macros that wrap the _user variants of the read
> > > > > functions. Are there any plans to support ones?
> > > >
> > > > BPF_CORE_READ() are using BPF CO-RE and thus emit relocations, which
> > > > will be adjusted by libbpf to match kernel struct layouts by using
> > > > kernel's BTF(s). Because of this, having xxx_user() variants doesn't
> > > > make much sense, because libbpf can't relocate field offsets against
> > > > user-space types (as there is no BTF for user-space applications,
> > > > typically). Which is why there are no BPF_CORE_READ_USER()-like
> > > > macros.
> > > >
> > > > What's your use case, though? There might be a valid one that we are
> > > > not aware of, so please provide more details. Thanks.
> > > Currently my use case is tracing syscall pointer arguments (For
> > > example, "connect" has a "struct sockaddr *" argument).
> >
> > So if it's a kernel-defined data structure provided from user-space,
> > then it has to be part of a stable UAPI type definitions, right? In
> > such a case, you shouldn't need CO-RE, because the layout is stable.
> > So it's still unclear why you'd need BPF_CORE_READ for that?..
> I may be completely off, but can't struct offsets and members change
> across different architectures?

Hm.. that's an interesting angle, certainly across 32-bit and 64-bit
architectures UAPI structs can have different layouts and it's
possible to write and compile a single BPF program that would work on
both. You'll most likely still have to compile twice (once for each
architecture) due to the user-space part. But I think there is a use
case or BPF_CORE_READ_USER() macro, so I don't mind adding it, let's
just figure out the best way to do this. Thanks for elaborating!

> >
> >
> > Or is it because of the convenience of doing BPF_CORE_READ(s, field1,
> > field2, field3) instead of a sequence of bpf_probe_read_user() calls?
> > That's a different angle of BPF_CORE_READ() and we should clarify the
> > desired functionality you are looking for.
> >
> >
> > > >
> > > > > Thanks,
> > > > > Gilad Reti.
