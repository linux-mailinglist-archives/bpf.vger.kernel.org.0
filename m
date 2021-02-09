Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F231525B
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 16:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhBIPHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 10:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhBIPG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 10:06:58 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E3C061788
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 07:06:18 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id z3so6895997vsn.9
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 07:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbTXuOBblU9jPQgm8MRCYvaknfLBOXYdW6zn/C5UsN4=;
        b=g/Bp8tCC+w+JRa9cSdlGPUAvUtCoqGkBlEfY1+vOAFxvIGs7DjlKloprbuxuxF5h9u
         Gef1X9bSr41acjjYqEEn/POZS54oqzEyIGXl5EbHqEjBZguUxuFRzcCO5egLwpSxCoMc
         dk1WYzkGF0G3b6dc2FVDPpzbwxilHHlDVDoL/kLgmswz2m0pUz4Pvcx3Ktb83zxvw4OZ
         2KnAQSskFdQbV+G/GjXouzw9Ls/cP5stTdUfuxLEfTiIxHj9CE/0C3n8kGuBGxmBSk+S
         H0jd7NON01AGegEToSoLwVq1BJS84nIx5elUDZDWnMiy550CFlQrmjzYotNYVHeZ05aG
         xP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbTXuOBblU9jPQgm8MRCYvaknfLBOXYdW6zn/C5UsN4=;
        b=FeyqteFXyGuTw6R/Wleri95aChPiL492HPkedCVJGYbw+an3tTe57JuOkRNlU/mVd0
         vHhCdggP6Jzo+zyE0lFpXsyFQ07mC+pNQ96iB+P/uTEGvE9cYjatjs0Kt91/RhJCY4xb
         BwJgSWj40wgqqWM019k0MgUVMkEO2Xy5eVLxAAc6UI8lxhsnfVW7DhQGJVv9g6wBEuRX
         hcYfj7fO3f5TUiRnvAIHEyuNaOG4wcFSSAekobLuxxg8h50hQZi1Rh95YpKDb6wWK8qr
         NTGd1XNA+tipZOscswcm5Sb6O8Wd26rjJUvrGS1rJW+JQtoqm2fZrzN6JgydKQS4l6jt
         yf2w==
X-Gm-Message-State: AOAM530b/1PL5BnwBKZNKP5MiJlS8u+AM+KAyja6GdJZkfz38DwLy/3i
        G2joEBvkaPSu9VdbXkgzWtjBjOoAof4Qs9Kj4Wkx5Q==
X-Google-Smtp-Source: ABdhPJxhv1/QRVdi6XCilq9+IFSXqAjlels0Dy9hn4GDFSmN3+hX4k6pNhxQyVDMM4aboLB11aWrWNo+3Q4Gk5bskyQ=
X-Received: by 2002:a67:1142:: with SMTP id 63mr13478014vsr.24.1612883176546;
 Tue, 09 Feb 2021 07:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-6-gprocida@google.com> <CAEf4Bza+mCKjva7BnChhFugjnE0mHzmfB4XErnmoZtkh6+jBpw@mail.gmail.com>
In-Reply-To: <CAEf4Bza+mCKjva7BnChhFugjnE0mHzmfB4XErnmoZtkh6+jBpw@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 9 Feb 2021 15:05:42 +0000
Message-ID: <CAGvU0HmnzjGvgaQ8VHfFgEO4n12a+ik7vEh6Fkgj1Z=RvWJM8g@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 5/5] btf_encoder: Align .BTF section to 8 bytes
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

On Mon, 8 Feb 2021 at 22:30, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > This is to avoid misaligned access to BTF type structs when
> > memory-mapping ELF objects.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
>
> I trust you did verify that it actually works in cases where
> previously .BTF was mis-aligned?
>

Yes. :-)

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >  libbtf.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 9f4abb3..6754a17 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -744,6 +744,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >                 goto out;
> >         }
> >
> > +       /*
> > +        * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
> > +        * nice if we could fetch this value from somewhere. The BTF
> > +        * specification does not discuss alignment and its trailing string
> > +        * table is not currently padded to any particular alignment.
> > +        */
> > +       const size_t btf_alignment = 8;
> > +
> >         /*
> >          * First we check if there is already a .BTF section present.
> >          */
> > @@ -821,6 +829,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >                 elf_error("elf_getshdr(btf_scn) failed");
> >                 goto out;
> >         }
> > +       btf_shdr.sh_addralign = btf_alignment;
> >         btf_shdr.sh_entsize = 0;
> >         btf_shdr.sh_flags = 0;
> >         if (dot_btf_offset)
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
