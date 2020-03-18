Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6322189F87
	for <lists+bpf@lfdr.de>; Wed, 18 Mar 2020 16:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCRPXc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Mar 2020 11:23:32 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36013 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRPXb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Mar 2020 11:23:31 -0400
Received: by mail-vk1-f193.google.com with SMTP id m131so5434691vkh.3;
        Wed, 18 Mar 2020 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FIZR9zNeI105db6KUPnQEP9FoziaF4rTuJr7IfEBA0k=;
        b=rwjYB3xh9woWZvobt7cB6CGcCipWsmk5GqRtjXPFht1ersDi+or7ClLOtiTyWYg/MY
         0mFY3FeHrGUx+D2dDIOKwEQQk5WuhyBNCeYGrOyU1Muiem5WP5fV0H4y1aaANz/qtX7B
         P2nv593BwTETTLyYrCwCQhFC2U/1alcBGTdodbsWG2PTZJPBjBpYLUhoIgRrD8fpLxZN
         X6TmLNgIuDnN6BJsJsfez7YBPLq4GW3dW6eBvpuL9V0d7XP7lHOmDlCjI6jAqqgp2mc3
         hP1DJi7HFQ2cfb9S2XEYb8O7ngVAG+utxnAU46cjZXgWjaZtRVY2mKFVOzmMERDTYb3j
         eRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FIZR9zNeI105db6KUPnQEP9FoziaF4rTuJr7IfEBA0k=;
        b=XzWNrwN0h+yxhlA7s4nmPO/ARNtS4b4GxkxVVNpFsw9J+nmtojGcUll1ut9Q7vBVxS
         bAEi+qcekHavX90b+OZuU9bSqBs7x8iuay4cFRMcecCx3Wwx1DtAW1PNLL0byxZHZqb6
         QU693vKyJ5TcKJlhYIzl2+6MyAhliqGDKsdIdHqmWIYBspKU7/O9NUjmf7OkaDcgeerw
         mvdhw21c3Nz47tsy0Oi7oh0fA+yqs6CPK+Hvn3Tc5qMrFISVNp3lUjfQJnwUV2g8Me3A
         ryxvmCDtncE1UjE7cRZReuNXSqoPWZNdEQWOOKQUeZ4f+1h5IyJdV4DcEVUTbFEL5ZkU
         fiPA==
X-Gm-Message-State: ANhLgQ19aUzpYq0pz1kGwa51c3D5YnqBkLzVvNrN+CoGyd2md2w/RCLC
        UCg1XrOa4u3ZX66ugVrX3+5fv353aAEAPa2YenI=
X-Google-Smtp-Source: ADFU+vs/eWg6h178MsGfSIDwQVvSxlrVLgK5AFmv6/2U2tKxvalBcoUbebPLYCdO1gnTcHvBQlIRI2P2X3562doKtvk=
X-Received: by 2002:a1f:6182:: with SMTP id v124mr3710291vkb.48.1584545010105;
 Wed, 18 Mar 2020 08:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200316163646.2465-1-a.s.protopopov@gmail.com>
 <202003161423.B51FDA8083@keescook> <CAGn_itw594Q_-4gC8=3jjRGF-wx90GeXMWBAz54X-UEer9pbtA@mail.gmail.com>
 <202003171314.387F3F187D@keescook> <CAGn_itz7jgoP5J1pjJ7BLaeh4my=JY2yQ7T8ssoYrqPOWvwKug@mail.gmail.com>
 <202003172058.3CB0D95@keescook>
In-Reply-To: <202003172058.3CB0D95@keescook>
From:   Anton Protopopov <a.s.protopopov@gmail.com>
Date:   Wed, 18 Mar 2020 11:23:19 -0400
Message-ID: <CAGn_itwAPUR8D2=f_Yq1PNnpDnAihg36WrbfsGBO90T39jkPTA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: allow BPF_MOD ALU instructions
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=D1=81=D1=80, 18 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 00:06, Kees Cook <=
keescook@chromium.org>:
>
> On Tue, Mar 17, 2020 at 09:11:57PM -0400, Anton Protopopov wrote:
> > =D0=B2=D1=82, 17 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 16:21, Kees Co=
ok <keescook@chromium.org>:
> > >
> > > On Mon, Mar 16, 2020 at 06:17:34PM -0400, Anton Protopopov wrote:
> > > > and in every case to walk only a corresponding factor-list. In my c=
ase
> > > > I had a list of ~40 syscall numbers and after this change filter
> > > > executed in 17.25 instructions on average per syscall vs. 45
> > > > instructions for the linear filter (so this removes about 30
> > > > instructions penalty per every syscall). To replace "mod #4" I
> > > > actually used "and #3", but this obviously doesn't work for
> > > > non-power-of-two divisors. If I would use "mod 5", then it would gi=
ve
> > > > me about 15.5 instructions on average.
> > >
> > > Gotcha. My real concern is with breaking the ABI here -- using BPF_MO=
D
> > > would mean a process couldn't run on older kernels without some trick=
s
> > > on the seccomp side.
> >
> > Yes, I understood. Could you tell what would you do exactly if there
> > was a real need in a new instruction?
>
> I'd likely need to introduce some kind of way to query (and declare) the
> "language version" of seccomp filters. New programs would need to
> declare the language level (EINVAL would mean the program must support
> the original "v1", ENOTSUPP would mean "kernel doesn't support that
> level"), and the program would have to build a filter based on the
> supported language features. The kernel would assume all undeclared
> seccomp users were "v1" and would need to reject BPF_MOD. All programs
> declaring "v2" would be allowed to use BPF_MOD.
>
> It's really a lot for something that isn't really needed. :)

Right :) Thanks for the explanations!

> > > Since the syscall list is static for a given filter, why not arrange =
it
> > > as a binary search? That should get even better average instructions
> > > as O(log n) instead of O(n).
> >
> > Right, thanks! This saves about 4 more instructions for my case and
> > works 1-2 ns faster.
>
> Excellent!
>
> > > Though frankly I've also been considering an ABI version bump for add=
ing
> > > a syscall bitmap feature: the vast majority of seccomp filters are ju=
st
> > > binary yes/no across a list of syscalls. Only the special cases need
> > > special handling (arg inspection, fd notification, etc). Then these
> > > kinds of filters could run as O(1).
>
> *This* feature wouldn't need my crazy language version idea, but it
> _would_ still need to be detectable, much like how RET_USER_NOTIF was
> added.
>
> --
> Kees Cook
