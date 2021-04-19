Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B43364DCC
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 00:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhDSWrp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 18:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhDSWro (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 18:47:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2A1A613AA
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 22:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618872433;
        bh=+yGM8k3N1hvfgbB3yripFKTduuYlrssXdmGk19osRPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YEJkR0fK6u9xLa7OA+SCjjQWeTPRqG7jDkMqZnVRDYRq8eBvOfupr2wtLWbQktJZI
         4btIs3Cg+LyoweGOjrOFtQ4bMF2deRYGGkDUb7pJsxPfdHNfgAvLxQcvae4pGDfuyc
         dMXRlW2CsA50RtQA8aVk6k0Wc2BSUxg5k4MaocKkICWez6c7GuI6qq3IjrTzc6yPmx
         mmQD3UHaSdyRJwXKuLMaBx+ris/zuwERgToPql+bnzq+z+L9PzHhGqzXxasJK1mBg+
         Y6WzoCiFcYieDlxmEIzDMeHKBJ3IdmuwlsYpvHG6Um4kn95MbNmaMf4avLC6ILF1/t
         hE0wddmLr29bQ==
Received: by mail-lj1-f169.google.com with SMTP id a5so4285837ljk.0
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 15:47:12 -0700 (PDT)
X-Gm-Message-State: AOAM531FFbNjYCo8trlGoIKvjEivrkzvHK5tUdgtp9kDieW+B0PTRV7x
        tz8QgGKVrYZGcwK5umChkMFi3fs370pilIDc7Pf4cw==
X-Google-Smtp-Source: ABdhPJypBmFQJq4PLzpKb0UDiaqSFGE/v6VhrBiEwAwvXdSUSQ4riFJm9UydkC3BES/9hm6gidEPC1dMOkUrNddbWTY=
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr13082013ljp.425.1618872431155;
 Mon, 19 Apr 2021 15:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210414195147.1624932-1-jolsa@kernel.org> <20210414195147.1624932-2-jolsa@kernel.org>
 <CAEf4BzagYcy-UxbgXGC81B=K02-wUctvUSTFDySsR6B0cJdwaA@mail.gmail.com>
In-Reply-To: <CAEf4BzagYcy-UxbgXGC81B=K02-wUctvUSTFDySsR6B0cJdwaA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 20 Apr 2021 00:47:00 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5osRepe1ruPH1cr6jCsyiwa78CU=TWRN0WyNh=CX+UDA@mail.gmail.com>
Message-ID: <CACYkzJ5osRepe1ruPH1cr6jCsyiwa78CU=TWRN0WyNh=CX+UDA@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 1/7] bpf: Allow trampoline re-attach for
 tracing and lsm programs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 16, 2021 at 1:22 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 14, 2021 at 5:44 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently we don't allow re-attaching of trampolines. Once
> > it's detached, it can't be re-attach even when the program
> > is still loaded.
> >
> > Adding the possibility to re-attach the loaded tracing and
> > lsm programs.
> >
> > Fixing missing unlock with proper cleanup goto jump reported
> > by Julia.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks!

Acked-by: KP Singh <kpsingh@kernel.org>
