Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FBC66F57
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2019 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfGLM4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jul 2019 08:56:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43831 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfGLM4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jul 2019 08:56:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so6423541lfm.10
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2019 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U8JelDTPii7RGHoiquSk+sGR/pDg+4xXvLkAF8ahtZQ=;
        b=fUDrB8kE/v6rR4yK6uhfirbeXC0QgR/e4Qn7VKWDnDmoLIgARPcO6Yk7mSoja0IY7M
         oFmlnk8fcuuAcdymYl2MLqHImYntORMmfudAdzSZZ9zjrbsoHKpNGDgGEj3z/Hbc5MuL
         MGYVBHdbVZVPXzwUfBTSwimpycfWgGG+uPoLuyAQcoUZjNLPkQ2ZEDkYOGWftOTzQr5x
         WmMhU7R9NzZ4pBHW2AfKChkhlBaEzgvRsd1PTjo4xZKzYOdxBCCgVvdoXaqaoqJaKhQo
         4BWWxr6hENhq99VO7An0RkIEQQZ6FKq5cYu/+EuNSUyhoKTBzFfte/sxpoftIazguxnb
         Zj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U8JelDTPii7RGHoiquSk+sGR/pDg+4xXvLkAF8ahtZQ=;
        b=V53WF0ORXvB9TyB78H4ThT/d1iU3hEabdYk7YhKl1NqK8CSNlJcPRxq/FdIKo8jISz
         GlDI1yx3peOBy01VneJPVu50UNOR8/KqyMgLs7tKH/lHC1v4XAuA9OJaZCmTy8tYuyBp
         pnmgEhRBrfnIJknn9HPgqY6hnrFG6XP3nBQFE3CjPNK65obNBKpCC8J19spgI2EaOwcF
         RWI/6Gix1fyai2MJwA3Ow+w6ytQkRzQyIzQxUEpVG72YsO/b9/h268QiMDuMU5oQZeVp
         Km1wFcgtgJbIFoCFd7gFG8ThJaEy67G+Z2MghNLDcV5cHgf2PleOxy7iIEaBPLABICCs
         driw==
X-Gm-Message-State: APjAAAV6ry/LubqBXpG826WVK+Z/0yyYc4t/01FWsyjt/yG/UKDYB6/c
        bqidYSYPv8OurUmqJdAzKY+ctWyKeM+wjs0fquaZPQ==
X-Google-Smtp-Source: APXvYqw97l1oeAA2+th/9cKGGPMGUMu4Ml9+uL71lRvQVwbk2RAIAa9B6Jp9obemUhw5bFYiue963wi+HIWBf7wLYYo=
X-Received: by 2002:a05:6512:29a:: with SMTP id j26mr771352lfp.44.1562936174798;
 Fri, 12 Jul 2019 05:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190709040007.1665882-1-andriin@fb.com> <b4b00fad-3f99-c36a-a510-0b281a1f2bd7@fb.com>
In-Reply-To: <b4b00fad-3f99-c36a-a510-0b281a1f2bd7@fb.com>
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Fri, 12 Jul 2019 13:56:03 +0100
Message-ID: <CAH+k93ExQpYy+g+WUNvv+bDDzDcJR-2WYongJqv4WbMcPV=sRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix ptr to u64 conversion warning on
 32-bit platforms
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 9 Jul 2019 at 05:30, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/8/19 9:00 PM, Andrii Nakryiko wrote:
> > On 32-bit platforms compiler complains about conversion:
> >
> > libbpf.c: In function =E2=80=98perf_event_open_probe=E2=80=99:
> > libbpf.c:4112:17: error: cast from pointer to integer of different
> > size [-Werror=3Dpointer-to-int-cast]
> >    attr.config1 =3D (uint64_t)(void *)name; /* kprobe_func or uprobe_pa=
th */
> >                   ^
> >
> > Reported-by: Matt Hart <matthew.hart@linaro.org>
> > Fixes: b26500274767 ("libbpf: add kprobe/uprobe attach API")
> > Tested-by: Matt Hart <matthew.hart@linaro.org>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>
>

How do we get this merged? I see the build failure has now propagated
up to mainline :(

> > ---
> >   tools/lib/bpf/libbpf.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ed07789b3e62..794dd5064ae8 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -4126,8 +4126,8 @@ static int perf_event_open_probe(bool uprobe, boo=
l retprobe, const char *name,
> >       }
> >       attr.size =3D sizeof(attr);
> >       attr.type =3D type;
> > -     attr.config1 =3D (uint64_t)(void *)name; /* kprobe_func or uprobe=
_path */
> > -     attr.config2 =3D offset;                 /* kprobe_addr or probe_=
offset */
> > +     attr.config1 =3D ptr_to_u64(name); /* kprobe_func or uprobe_path =
*/
> > +     attr.config2 =3D offset;           /* kprobe_addr or probe_offset=
 */
> >
> >       /* pid filter is meaningful only for uprobes */
> >       pfd =3D syscall(__NR_perf_event_open, &attr,
> >
