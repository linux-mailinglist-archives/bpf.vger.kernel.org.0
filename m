Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4AA315244
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 16:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhBIPAt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 10:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhBIPAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 10:00:48 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA61C061788
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 07:00:07 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id e7so299050vkn.3
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jd+gJhImGti6AIxVxWopyTw6UqxPWnjSI4DVjzLVR6E=;
        b=lhR17nSUvinlmhCvYsz4FY3B4Cux7AooHwG8g85itqORb23kJY5eUqx9oyl48r5eLh
         boUM7BDlBB7wxXTbsEV53hsYbfHdW0eyEMJ2p25eOxHyoX59yA+kJDX2VuRRtAOVeoTf
         rlcQDr2DRJccAT61zXVUQMZxGyaYEo0UE6XOhMRTmZr5lwJHNKIkqLMtm5WoATGP6Vzm
         p91v4xwGkb1x+HK0tOI7DmH3xJkiBo+hmq8kVWYxvj29fCE7rmGwX/pf6c/va4zfuMd+
         soRqDJ1VvEzqEeVBUNpKR5hN/uLb0FvbJV6WA9U7uwJVH6zbxodOhJV4Er3YsEu7nrXw
         MJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jd+gJhImGti6AIxVxWopyTw6UqxPWnjSI4DVjzLVR6E=;
        b=jIEZMTLvK69sJYD2W2gy5rm2vZQ2ydNgELqG0KdUxvLpX5KaKuSXSeqaljHbo24t3q
         6aXjA9XFXPWiYevB01BsZTIKuJCxg8Pk1I3sxCiJ3wqN9x3Ct5mIeo27SdHKjKtU0pH/
         OAC/KPw+mzvSu+zdmBDpacfnuiE6HLDycXYgia5uhb7QKFKplbtMrR+EndP17Kt1AU25
         /fdh0WrSsjDNzDD9uXMRO43rkddj3yptNTXIdKQMAMedZdnO4Yhij9p4jEiJbMY4yvHA
         YAgJJ65OHI+xOLQzqurg9QNMvsoZ8rf6Q0kSCSo8FR/aMzhuNf44iJpMAaUsu7qJBkYz
         qYqg==
X-Gm-Message-State: AOAM532NWQbeMDsUXryFfRIU5R8bBla6hU5Vgs5PIkqFD/95WCw3Y79D
        d2wXPIVo5jgX+nh67OBpqA82r/5F/DQI6YbX4TFt3A==
X-Google-Smtp-Source: ABdhPJwCXA67wkBZYKXdc5emZFkSgv8Nh7HAp1gBxOUzQFi0CDeSDV67fYa2ntCR/sQVc9ITAFS/B/ebtYsaq0mnkho=
X-Received: by 2002:a1f:a2c2:: with SMTP id l185mr7701802vke.2.1612882806910;
 Tue, 09 Feb 2021 07:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-4-gprocida@google.com> <CAEf4BzY4URifNvvFFyM2KYURh0c7-=ftHfyR5AxXGE_ZMDMy2Q@mail.gmail.com>
In-Reply-To: <CAEf4BzY4URifNvvFFyM2KYURh0c7-=ftHfyR5AxXGE_ZMDMy2Q@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 9 Feb 2021 14:59:32 +0000
Message-ID: <CAGvU0H=gExkUbp4HXi==SoFe0JKgnC-VKBv0a0jEsrzV=eKJJA@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 3/5] btf_encoder: Traverse sections using a for-loop
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi.

On Mon, 8 Feb 2021 at 22:24, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > The pointer (iterator) scn can be made local to the loop and a more
> > general while-loop is not needed.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> >  libbtf.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index ace8896..4ae7150 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -700,7 +700,6 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >  {
> >         GElf_Ehdr ehdr;
> >         Elf_Data *btf_data = NULL;
> > -       Elf_Scn *scn = NULL;
> >         Elf *elf = NULL;
> >         const void *raw_btf_data;
> >         uint32_t raw_btf_size;
> > @@ -748,7 +747,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >          */
> >
> >         elf_getshdrstrndx(elf, &strndx);
> > -       while ((scn = elf_nextscn(elf, scn)) != NULL) {
>
> this is pretty "canonical" as far as libelf usage goes, I wouldn't
> touch this code, but it's up to Arnaldo
>

Ack.
In an intermediate version of the code, I got bitten when I used scn
by mistake instead of another pointer.
This wouldn't have compiled if scn had been scoped to the loop.

Giuliano.

>
> > +       for (Elf_Scn *scn = elf_nextscn(elf, NULL); scn; scn = elf_nextscn(elf, scn)) {
> >                 GElf_Shdr shdr;
> >                 if (!gelf_getshdr(scn, &shdr))
> >                         continue;
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
