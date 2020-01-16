Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B686713F756
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 20:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbgAPTLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 14:11:11 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40069 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437423AbgAPTLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 14:11:10 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so9590853qvb.7;
        Thu, 16 Jan 2020 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OEZx2MjoszDi5bRMEvk6at9kqk898GlGBhsPS60YZE=;
        b=oAu9qaet49v37A1VgP0LaeMPw44TNjd+84DuWb1JRGRrE+ukvBC3pxHmRLEd9/cHlT
         DNiDww2RsL5wRM9Pah171TlZcCeGVVQh42LFK10TVFblyeHmSeu9P/z06XX2gy+UBiSb
         eFJF2CJfbOD2fWQK/Wg+I79B3/+W8MA2ruE2Bo5AfdR+le6U1yjWROe0+k5Kph9vB/yR
         3OjJu+9TPR2me7OzueGwlEqPFXT+mgE3fGrk2kgeT6DiIwyFgZHgzn2If1rs/Fk/WT//
         q9DTjBW0P8MLUenVyMzJKX8iq/BMb9s9iIMhF+uoDtcfi9AlvQCWx5QSO/1OW4lhMcmf
         ji8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OEZx2MjoszDi5bRMEvk6at9kqk898GlGBhsPS60YZE=;
        b=r8slrELBPZawiYrBSQRHUk2jaRRpAxbAoBRvlFOQtqDk0ILNHYzz1kzc+pXm17aabL
         uY4e0FWXKVfpNMYpPZVow7VBKMe53TmgZB8RvnExEp/oSWCSFUF201Pn5uA5SIcQ7Xym
         e9+SMpo9TX/ZPugUQblepRkL3+dS0aVoJtbm2+0Iz6C9EyajveOKayNj870XO3SxzTg1
         MTqLlBPe8sgf4zKWkb3aOZp1YFu3XkUjfnSakapyvsv8/cEtCnmAJqaXn0yBUzbYcxdD
         E+kTRStXAHuLLJIxYWlrwWSIItGCrzTDAJRBdfFaODoTVeDcnWRtuuirL47AHD5hL+te
         T4GQ==
X-Gm-Message-State: APjAAAUe6WwtDnutuLXDiuKD+UhXNpYv4j63pBzviJ3VJ3PSD3V4qqmA
        YC/V3vtkuClR/V+PoDOxOE3IzLATFrroelbErKA=
X-Google-Smtp-Source: APXvYqw9FIgttSCmKhfwxg+gCy9NRY9si3en5ZFJS6VWOz3YlihoKUoN8mv6ZMAfLxb1JV1nrGcclF7WKhszpNDXPE8=
X-Received: by 2002:ad4:514e:: with SMTP id g14mr4208129qvq.196.1579201868349;
 Thu, 16 Jan 2020 11:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20200115171333.28811-1-kpsingh@chromium.org> <20200115171333.28811-9-kpsingh@chromium.org>
 <CAEf4BzZodr3LKJuM7QwD38BiEH02Cc1UbtnGpVkCJ00Mf+V_Qg@mail.gmail.com> <20200116124955.GD240584@google.com>
In-Reply-To: <20200116124955.GD240584@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Jan 2020 11:10:57 -0800
Message-ID: <CAEf4BzYa+m0OCZXqnNsab+q3+HLboL45eRdBrGdZD+6Z4CRSiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/10] tools/libbpf: Add support for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 16, 2020 at 4:49 AM KP Singh <kpsingh@chromium.org> wrote:
>
> Thanks for the review Andrii!
>
> I will incorporate the fixes in the next revision.
>
> On 15-Jan 13:19, Andrii Nakryiko wrote:
> > On Wed, Jan 15, 2020 at 9:13 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > * Add functionality in libbpf to attach eBPF program to LSM hooks
> > > * Lookup the index of the LSM hook in security_hook_heads and pass it in
> > >   attr->lsm_hook_index
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > ---
> > >  tools/lib/bpf/bpf.c      |   6 +-
> > >  tools/lib/bpf/bpf.h      |   1 +
> > >  tools/lib/bpf/libbpf.c   | 143 ++++++++++++++++++++++++++++++++++-----
> > >  tools/lib/bpf/libbpf.h   |   4 ++
> > >  tools/lib/bpf/libbpf.map |   3 +
> > >  5 files changed, 138 insertions(+), 19 deletions(-)
> > >

[...]

> >
> > > +{
> > > +       struct btf *btf = bpf_find_kernel_btf();
> >
> > ok, it's probably time to do this right. Let's ensure we load kernel
> > BTF just once, keep it inside bpf_object while we need it and then
> > release it after successful load. We are at the point where all the
> > new types of program is loading/releasing kernel BTF for every section
> > and it starts to feel very wasteful.
>
> Sure, will give it a shot in v3.

thanks!

[...]

> >
> > > +               if (!strcmp(btf__name_by_offset(btf, m->name_off), name))
> > > +                       return j + 1;
> >
> > I looked briefly through kernel-side patch introducing lsm_hook_index,
> > but it didn't seem to explain why this index needs to be (unnaturally)
> > 1-based. So asking here first as I'm looking through libbpf changes?
>
> The lsm_hook_idx is one-based as it makes it easy to validate the
> input. If we make it zero-based it's hard to check if the user
> intended to attach to the LSM hook at index 0 or did not set it.

Think about providing FDs. 0 is a valid, though rarely
intended/correct value. Yet we don't make all FD arguments
artificially 1-based, right? This extra +1/-1 translation just makes
for more confusing interface, IMO. If user "accidentally" guessed type
signature of very first hook, well, so be it... If not, BPF verifier
will politely refuse. Seems like enough protection.

>
> We are then up to the verifier to reject the loaded program which
> may or may not match the signature of the hook at lsm_hook_idx = 0.
>
> I will clarify this in the commit log as well.
>

[...]
