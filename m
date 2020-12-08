Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534852D1FE6
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 02:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgLHBVQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 20:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgLHBVP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 20:21:15 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FE0C061749
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 17:20:35 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a8so6093016lfb.3
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 17:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BmtVsQqnINsFwvPpz6bilW9GVmwDOVUGp8/e8LSo2Bo=;
        b=kCmg0jViHrZp8YKEeimO3Ik/X8YtW1bL/TYY4LmH64csfv41CCp9sWMLM1llpy5D1V
         EvDsEoZdJQ9+4db0h7R6koKpyybFBc9IxNzjfpejYixjjsuHP8KozOLP66Ht8eYba6mP
         5TH8Aw+t9pgb00fie4Ena/DTfL6qPb0m9mluyFUQQw+ynTXuCvqykkoe2vSI4wGZK0dN
         5Y4hwL+AeybxyyVu3yAOoytByqNPygmUN/339fA46bfQqOtlzGBtm/4P7AxriDLjnmTV
         tRz/JjVegau66pDFKG+E57DbAP5M5ED6GhkIH05+yj/kT6vwbEeWGBvgGK/93E4U5bG2
         5RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BmtVsQqnINsFwvPpz6bilW9GVmwDOVUGp8/e8LSo2Bo=;
        b=n/ZVbBb+dVqNfpx0moDHfrJ3M4/7R1LmYrkdxgGwxSj8vFE4G2uL+93X25qh2XfR6f
         nnNV/emsarGID6KLy2hVGgo6CxsQy12TRoyo42N7sWFNTNlTZ3Vq3hSMcop+s+2htro4
         dGP+c8nqBON6mdfc7lhMNdd8z7Vg9/UHFpd9DlLl3jgq4l/ifLGcxFFYu2YpHy73PXR6
         FIfLEn028BOwsA5p4uqj7g97+zNG78ld4R6x7bbTn+og5mP6kb4NxPYpod46M8lZOMvp
         tHHBGylaUULeibWmUQh78oO2yZqcMJ9URGyIqub8Qb6AvmAdwFuUf6TFdbXvAOVAY7lo
         LOCg==
X-Gm-Message-State: AOAM532OqTXq7k/GTDxKOs7jg2W9sSSGADmBJsiTca1UJh9BSFyTQcrq
        q5nBIUVsZxHXdWBSJNixNxB/KMwFPNACYknGaaA=
X-Google-Smtp-Source: ABdhPJwfR6HE2F7+tvV0r4cR5hrbshyepnljtsvUNH0iTNFxjVDZtRiR3lOtPwu1FDXlfetH7zawvIxNxVFbA8vwO/0=
X-Received: by 2002:ac2:520f:: with SMTP id a15mr6286463lfl.263.1607390433800;
 Mon, 07 Dec 2020 17:20:33 -0800 (PST)
MIME-Version: 1.0
References: <87lfeebwpu.fsf@toke.dk> <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
 <87r1o59aoc.fsf@toke.dk> <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk> <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
 <878sa9619d.fsf@toke.dk> <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
 <874kkx5zl5.fsf@toke.dk> <CAADnVQLGY26QfiZm8WvoeNJmBYOgVz_h-SjHLgoYqw=P4M4fLg@mail.gmail.com>
 <87tusxi7jx.fsf@toke.dk>
In-Reply-To: <87tusxi7jx.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Dec 2020 17:20:22 -0800
Message-ID: <CAADnVQK3ZoWsfdFK7ykNbg2=XAJn_1OoxL9TGFDkPugk0psWYg@mail.gmail.com>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 7, 2020 at 2:18 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Mon, Dec 7, 2020 at 8:51 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >>
> >> > On Mon, Dec 7, 2020 at 8:15 AM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> >> >>
> >> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >> >>
> >> >> > On Mon, Dec 7, 2020 at 3:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
> >> >> >>
> >> >> >> Wait, what? This is a regression that *breaks people's programs*=
 on
> >> >> >> compiler versions that are still very much in the wild! I mean, =
fine if
> >> >> >> you don't want to support new features on such files, but then s=
urely we
> >> >> >> can at least revert back to the old behaviour?
> >> >> >
> >> >> > Those folks that care about compiling with old llvm would have to=
 stick
> >> >> > to whatever loader they have instead of using libbpf.
> >> >> > It's not a backward compatibility breakage.
> >> >>
> >> >> What? It's a change in libbpf that breaks loading of existing BPF o=
bject
> >> >> files that were working (with libbpf) before. If that's not a backw=
ard
> >> >> compatibility break then that term has lost all meaning.
> >> >
> >> > The user space library is not a kernel.
> >> > The library will change its interface. It will remove functions, fea=
tures, etc.
> >> > That's what .map is for.
> >>
> >> Right, OK, so how do I use .map to get the old behaviour here? That's
> >> all I'm asking for, really...
> >
> > Fix old llvm. The users would have to upgrade either from llvm 7.x to
> > 7.x+1 or to llvm 10+.
>
> Right, so by "we keep a stable interface" you mean "we expect you to
> upgrade your entire toolchain every time you update the library". Gotcha!

No. It means that libbpf is not going to have a workaround for every possib=
le
llvm bug that was fixed over the years.
libbpf already does a ton of fixups for things that users can actually hit.
