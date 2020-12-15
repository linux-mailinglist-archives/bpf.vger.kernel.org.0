Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6512DB559
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 21:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgLOUpU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 15:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLOUpS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 15:45:18 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FF0C06179C
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 12:44:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ga15so29641066ejb.4
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmPmSDCNdb0S99NxrxVQxRR9GorQHDjKAsu98tgUB6E=;
        b=eUyyizdJ3i3ElWIZd9jWH7sDdLZk71BJ2PCtRNyYOaCIUj7e1YkfDQscpiHJnDHpUR
         vjginfAW6bdMZS9H4MbwyAgHPnGW+uHlDBttkYXZetXuKQB8BIH2AEUw8mY39exGN3e/
         f6sQFyQ/1ntqXT4nECsslm8n2Dao4miCXODwqtdPSLJ16+IjLjLZgQNMDZR876u+IGdW
         yKBtPDMQhsjEtWUTXIjC4Og80fCq/CbVnJwA/4RGFE2h/F46J5MsSo5Hzwjv0F2uqUn+
         T/WSXAtZI3ftYRcleKPFtWQ5JetPGqXa4Hw0sEJ68B4DkTu8xuZlsY1lSLxYHKqJbUB4
         x0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmPmSDCNdb0S99NxrxVQxRR9GorQHDjKAsu98tgUB6E=;
        b=TY3vrffepOTf84g49gMP+X8/L2VN/nril5RcjbfmpgjDjunWsqpY5cst/OTSgjaZLw
         EhuSZ3glFcWT3GYgM+WqbOmZS7aBjcVuFj6Ecrlnp1+QccXv9Q11OzM6T3TiZwUynI5V
         mdXbFoJPQLF7/JeTvIWwlkKcsvBdhldUsdBAvdZ5gzjl4OSchnYgeJ/yeKCRVynZfgAO
         QH2+upUCL1RzhlgNPXedwdeK79ZskfwPmdU46CZoAp8Y0AsZsCrdkngSFEInyw/c0eDE
         5K23jCFK6XymdJ6wvTpRfGJjmnNtx1UqfaWJ21ARYeshdL+GERtYudtdqw8ce8nlsrrI
         uX3A==
X-Gm-Message-State: AOAM532aozXm4RGtws6p7fdyskzkp88x7xyGEBrfj+S0vhPjYhTJCLhD
        Y1roPDsHo4xjZQEqCwOEh8AK5D7qi9z5Yl/ZPEY=
X-Google-Smtp-Source: ABdhPJxL/XwqJoXWLGvrG42ZT51DeLt+zvVxqkqYmHXbkRk1No4JArqp8eHVJZtGDqhstHrcpNZ4oOhyllaFmL5x8us=
X-Received: by 2002:a17:906:2f95:: with SMTP id w21mr1300159eji.238.1608065076693;
 Tue, 15 Dec 2020 12:44:36 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3EH2tS=LnAoRfYsnO-zs5qaO7GuHDhw03==t+B_C8Gf2w@mail.gmail.com>
 <CAEf4Bza4P51cGFN4zgTBr5nt_3tcoeGQ-QfP5CjoGx2scJP5-g@mail.gmail.com>
 <CANaYP3Euo8XYsDtqgoESLT_VRPGDKEyR8c0Wf3z1r_+nvS+ffw@mail.gmail.com> <CAEf4Bzb3ShNmD=_6XqUfL7DSDd_3rDcuuPN0Y4u8qVK2uOUsAA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb3ShNmD=_6XqUfL7DSDd_3rDcuuPN0Y4u8qVK2uOUsAA@mail.gmail.com>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Tue, 15 Dec 2020 22:44:00 +0200
Message-ID: <CANaYP3GetBKUPDfo6PqWnm3xuGs2GZjLF8Ed51Q1=Emv2J-dKg@mail.gmail.com>
Subject: Re: libbpf CO-RE read_user{,_str} macros
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 8:47 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 15, 2020 at 4:50 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> >
> > On Tue, Dec 15, 2020 at 3:26 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Dec 14, 2020 at 1:58 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> > > >
> > > > Hello there,
> > > > libbpf provides BPF_CORE_READ macros for reading struct members in a
> > > > CO-RE compatible way. By default those macros reduct to the relevant
> > > > bpf_probe_read_kernel functions. As far as I could tell, there are no
> > > > variants of this macros that wrap the _user variants of the read
> > > > functions. Are there any plans to support ones?
> > >
> > > BPF_CORE_READ() are using BPF CO-RE and thus emit relocations, which
> > > will be adjusted by libbpf to match kernel struct layouts by using
> > > kernel's BTF(s). Because of this, having xxx_user() variants doesn't
> > > make much sense, because libbpf can't relocate field offsets against
> > > user-space types (as there is no BTF for user-space applications,
> > > typically). Which is why there are no BPF_CORE_READ_USER()-like
> > > macros.
> > >
> > > What's your use case, though? There might be a valid one that we are
> > > not aware of, so please provide more details. Thanks.
> > Currently my use case is tracing syscall pointer arguments (For
> > example, "connect" has a "struct sockaddr *" argument).
>
> So if it's a kernel-defined data structure provided from user-space,
> then it has to be part of a stable UAPI type definitions, right? In
> such a case, you shouldn't need CO-RE, because the layout is stable.
> So it's still unclear why you'd need BPF_CORE_READ for that?..
I may be completely off, but can't struct offsets and members change
across different architectures?
>
>
> Or is it because of the convenience of doing BPF_CORE_READ(s, field1,
> field2, field3) instead of a sequence of bpf_probe_read_user() calls?
> That's a different angle of BPF_CORE_READ() and we should clarify the
> desired functionality you are looking for.
>
>
> > >
> > > > Thanks,
> > > > Gilad Reti.
