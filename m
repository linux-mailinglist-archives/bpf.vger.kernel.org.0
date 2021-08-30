Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3D3FBE84
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 23:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbhH3VuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhH3VuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 17:50:21 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E785C061575
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 14:49:27 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id c206so10361683ybb.12
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l4vsVADyqylLjq+yst7to62G2ayuJ8a/8tJvFZ1OfIM=;
        b=nOYrhgQ8CEGCHS0GBBj8fxawyHd2lLH87YerKmOpLHnvTvRgT4iwCKFRUefwApvjPN
         9t+B4m7+viEdod8ImiRgxfAvzoAgMYqaWBQvYobMgXnIaTnW1eNdU05kk9hefs1MU8Vz
         jz+rqjiMs3K/R8+lTdGnXNwbrOuZB5hsQs6xGLgx1xvrVphZ4/mPIRoERz/KQApRmKkr
         8+UBbacszqlJsnZUYZD3tS8KcsO3kVrMV6YRpaFEcbU6/z2NN9BQiEpJ7r3uL8NMKe4r
         CAAAEIG6s+raj2n8iFqDtef0NGVYNZU+1siS/e6jNGNBM9NEm3RsyWNU4Ewes4j1dTjT
         Gu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l4vsVADyqylLjq+yst7to62G2ayuJ8a/8tJvFZ1OfIM=;
        b=EelMTzPaKBdM6gZbCKUaZLxdc8LoLbHnHJjoEz2POTXj/q1cZ4vz/AbkHs5WQ1Fwkt
         zFI8rjPKQP2RPAoHCK2g0jpYBdob/ayvVsi82bYpo7zYQfisNK+JovVUPt2Og4ZXYYlP
         q4LfY9gixP1Asfau+ucNcUQJyVrmlyxAkN2sbOCollzaDneppcltBQ4wuIjw1zh7Fnpj
         echXCXS2MdCeImCO3PBkwQyUPeJuNPDpQ7dwcScVyb2aUsB2MXmubqJW+DVR3WVmf8mm
         9e4CrVfAKQDA5fQj2L0WMvPJr2aKh8SuCUHwDCUhjo16syVl3Z2fYLk21w61L+PVxxyO
         dLpw==
X-Gm-Message-State: AOAM530Q7ZABsxfkR4p3FdVR48jqpdPI+TUzp5w4r9Ym1BvOe5eQk5yd
        61dbwl/j13DIXbsqzDqBsRHX2gX80i/iQxUwdVE=
X-Google-Smtp-Source: ABdhPJxX3Sct36aGLeeZyEt//dWptPZyEYd3/HdWfDlHBfCAWNaECRqMDpBgcEp4ea3L1xpBtuQ14aSMmRxGucWNCwI=
X-Received: by 2002:a25:ac7:: with SMTP id 190mr24978498ybk.260.1630360166319;
 Mon, 30 Aug 2021 14:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210826120953.11041-1-toke@redhat.com>
In-Reply-To: <20210826120953.11041-1-toke@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Aug 2021 14:49:15 -0700
Message-ID: <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 5:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> When .eh_frame and .rel.eh_frame sections are present in BPF object files=
,
> libbpf produces errors like this when loading the file:
>
> libbpf: elf: skipping unrecognized data section(32) .eh_frame
> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .eh_=
frame
>
> It is possible to get rid of the .eh_frame section by adding
> -fno-asynchronous-unwind-tables to the compilation, but we have seen
> multiple examples of these sections appearing in BPF files in the wild,
> most recently in samples/bpf, fixed by:
> 5a0ae9872d5c ("bpf, samples: Add -fno-asynchronous-unwind-tables to BPF C=
lang invocation")
>
> While the errors are technically harmless, they look odd and confuse user=
s.

These warnings point out invalid set of compiler flags used for
compiling BPF object files, though. Which is a good thing and should
incentivize anyone getting those warnings to check and fix how they do
BPF compilation. Those .eh_frame sections shouldn't be present in BPF
object files at all, and that's what libbpf is trying to say.

I don't know exactly in which situations that .eh_frame section is
added, but looking at our selftests (and now samples/bpf as well),
where we use -target bpf, we don't need
-fno-asynchronous-unwind-tables at all.

So instead of hiding the problem, let's use this as an opportunity to
fix those user's compilation flags instead.

> So let's make libbpf filter out those sections, by adding .eh_frame to th=
e
> filter check in is_sec_name_dwarf().
>
> v2:
> - Expand explanation in the commit message
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 88d8825fc6f6..b1dc97b95965 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2909,7 +2909,8 @@ static Elf_Data *elf_sec_data(const struct bpf_obje=
ct *obj, Elf_Scn *scn)
>  static bool is_sec_name_dwarf(const char *name)
>  {
>         /* approximation, but the actual list is too long */
> -       return strncmp(name, ".debug_", sizeof(".debug_") - 1) =3D=3D 0;
> +       return (strncmp(name, ".debug_", sizeof(".debug_") - 1) =3D=3D 0 =
||
> +               strncmp(name, ".eh_frame", sizeof(".eh_frame") - 1) =3D=
=3D 0);
>  }
>
>  static bool ignore_elf_section(GElf_Shdr *hdr, const char *name)
> --
> 2.33.0
>
