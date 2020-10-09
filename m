Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8056C289147
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgJISjX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730773AbgJISjX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:39:23 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63274C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 11:39:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c3so7992856ybl.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HiG3p+lctJx5RBOH7Hq1XzlaHJPJF6nNcCCdyAfHbN0=;
        b=eatqDnlXR7g3P0ptDHiMCr0Cuj3Sg8f2eoTawwEzIN3erJ2IlXIdt+oy6RlrDiAexV
         S8zDZtuUqEc45OOmkVTMoWco83wVYBi6vIaBDIINz8lxRkUX9cAaD+9DWTvJM2QBiiHE
         jgw51zyOMtvxbT2gP04td30QbRuDCsRLo3T1m3w86BuIJaHYytNomauqCh4Ieu2wApQT
         Wr/M6KeCYNWMgtdtHwW09sSIs31w8xKMcDcuKk9Nxd4GktyV/l11B5bF2tLuoJVkbldA
         D7103waiQY972Kju+flHBCeL2yvWE2ZxjvSHjPGxUALIzIaioiRKL2c46BSG61wjb1qr
         K3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HiG3p+lctJx5RBOH7Hq1XzlaHJPJF6nNcCCdyAfHbN0=;
        b=AZ1oHkPvMNjnUokGgC2g4tLtfI//fENwxQ2BDYiO+tEPE8KgejRxaLhuvMKyo9zR+3
         qNCgMfAcLTmfutBs3CqoeArumiIRGc45jURvKAwdMHelwyzGIY+c/t5Ii7BQJ7gSzxud
         ocDb+/ED+UUCS7VWN5SmIn6V97HTjyM+kP76ingiig3svKHtTpcntKAODoBtBWU2We6V
         Zbt1dsgImtkiTfoBkZYWeFS6QdEPaHBqdHQnKBVR6Mgw9q/xlDT10/fjIq1ZiRjmgcr5
         PB05NgjyNcNiX96dNYTGrfmfqi7ewpEwRM/1bIHv7GVuQL+wGRLUne1tP89CHiK4snXs
         J8tg==
X-Gm-Message-State: AOAM530e1lkNGUu2KWx0LVYflqCAULjFq0pCIN0CUSddop7JvGANspCS
        V7sQaHSrgK1uup2uvEU8PHcjKUqN5QXMSx1OHbDtVfgwXTc=
X-Google-Smtp-Source: ABdhPJxZasunHfmKJFhjlAOKl//IMoDsTUCNwdx+jSrwwHTrbrzs2msoerb9jnZApaumGNOlvjI0mov4Nk8ld8Ig+bk=
X-Received: by 2002:a25:2a4b:: with SMTP id q72mr12943221ybq.27.1602268762663;
 Fri, 09 Oct 2020 11:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAMy7=ZW6B+aHN-3dAf7-=kK8WpMZ0NmEmeVh67jVPrjsryx9sQ@mail.gmail.com>
In-Reply-To: <CAMy7=ZW6B+aHN-3dAf7-=kK8WpMZ0NmEmeVh67jVPrjsryx9sQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Oct 2020 11:39:11 -0700
Message-ID: <CAEf4BzYJQ_RZgy8YCPxfF+QEkx9W+jeu-3O3CX+vEqTFtOT2Fw@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 11:33 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:21 =D7=9E=D7=90=D7=
=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On 10/9/20 8:09 PM, Yaniv Agman wrote:
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=D7=90=
=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >>
> > >> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> > >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > >>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >>>>
> > >>>> [ Cc +Yonghong ]
> > >>>>
> > >>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> > >>>>> Pulling the latest changes of libbpf and compiling my application=
 with it,
> > >>>>> I see the following error:
> > >>>>>
> > >>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
> > >>>>> unknown register name 'r0' in asm
> > >>>>>                         : "r0", "r1", "r2", "r3", "r4", "r5");
> > >>>>>
> > >>>>> The commit which introduced this change is:
> > >>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> > >>>>>
> > >>>>> I'm not sure if I'm doing something wrong (missing include?), or =
this
> > >>>>> is a genuine error
> > >>>>
> > >>>> Seems like your clang/llvm version might be too old.
> > >>>
> > >>> I'm using clang 10.0.1
> > >>
> > >> Ah, okay, I see. Would this diff do the trick for you?
> > >
> > > Yes! Now it compiles without any problems!
> >
> > Great, thx, I'll cook proper fix and check with clang6 as Yonghong ment=
ioned.
> >
>
> Thanks!
> Does this happen because I'm first compiling using "emit-llvm" and
> then using llc?

So this must be the reason, but I'll wait for Yonghong to confirm.

> I wish I could use bpf target directly, but I'm then having problems
> with includes of asm code (like pt_regs and other stuff)

Are you developing for a 32-bit platform? Or what exactly is the
problem? I've been trying to solve problems for 32-bit arches recently
by making libbpf smarter, that relies on CO-RE though. Is CO-RE an
option for you?

[...]
