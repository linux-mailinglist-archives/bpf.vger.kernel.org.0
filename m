Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4659B315258
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 16:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhBIPFw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 10:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhBIPFq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 10:05:46 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865BCC061788
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 07:05:06 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id j10so649232vkp.12
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 07:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqBgjcT0HDiN7R25+1pySnD3cCRdc9IrNXLFBdUJpzs=;
        b=mxcYYc5PMQ+JcFBfFkhF1UcjyGjF98qjWNbnG3h+mn0AzTocQB4/jQtwSwkL+3fqSV
         p+jtouum2Xsiz+ZUPpBPCsKGFo0MSbidsLTzUwn++FrzvF8cvCVCqZWnqz/mT6L26iEm
         Km+q6cu/qhq/zR/OxcINUn3YXj3HkPVsIKs5+KG8llXVSNMUG36xFl9zYGMf/tjAzr7j
         LJo8tom1tb8DtF4LITGPZKPSMPJ1F5dgSdhq2/cH8F3mFqApgf1ZDVRLiiI8DdRBw9XK
         0OBljyteEWdi6+A+tEGNOnKgHO4L1yUVlLtomTDXaZxI0cu1NmLIJbJb0kn0vmR7af6G
         65Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqBgjcT0HDiN7R25+1pySnD3cCRdc9IrNXLFBdUJpzs=;
        b=a1bTfiOvlNXQ/WjOkmqBYjB6hSAbuj98SWg0e/mNPBPDkY+EjUQsDUvf5i6QTDOh6l
         qXUwekT2NQv+pAC8c21GYm4GAcaO51+xx4YkSgxRPtiU1rM4QaARHfHMTBP6AF3fzGnQ
         NBJ5yDq6RgM66svHaQlStIhp1CCa3FG73/grJxh0yiZK/6N98O6R3/ZEaXeiARO/w8xE
         Ju+L/Zx/Y3/eOj3BCgncJer0L2NdamOKp+BnE3GxOjYvMRs90aKLiXndxvCrup+IHXF+
         5sTfgePITuPi5SmUzUMIzb/eOT5d9Dy35chuZdbIi6CACetXQ9cX4QX6EIzryqE2qFQf
         OTlg==
X-Gm-Message-State: AOAM5327rvDaPKjkhmGhcg1acwqjV3+88qVeZjb87oEXCvlunbvqvocr
        7xD8oCZIEPBpVYMQM2IZrRZ3Utalc4VdCzwPgQrETA==
X-Google-Smtp-Source: ABdhPJxzmdiQ1eKVNWIJX4MOHaWmd63Ro1q3sQ/S9gf7SZgrWWYN1qbRds2Vn6mrN9D6h0E10VrYT1QxAnwftW/BrCc=
X-Received: by 2002:a1f:a643:: with SMTP id p64mr13408320vke.15.1612883105432;
 Tue, 09 Feb 2021 07:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-5-gprocida@google.com> <CAEf4BzbF00jVMcVf1uQXM3QuHAeJYyV807KFeJoMOwnXdHbf7Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbF00jVMcVf1uQXM3QuHAeJYyV807KFeJoMOwnXdHbf7Q@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 9 Feb 2021 15:04:31 +0000
Message-ID: <CAGvU0Hkq+7-Kw0+dHAAVLXWyy5LDcCfVWeB7dz+sS3cdZ8hGTQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 4/5] btf_encoder: Add .BTF section using libelf
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

On Mon, 8 Feb 2021 at 22:29, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > pahole -J uses libelf directly when updating a .BTF section. However,
> > it uses llvm-objcopy to add .BTF sections. This commit switches to
> > using libelf for both cases.
> >
> > This eliminates pahole's dependency on llvm-objcopy. One unfortunate
> > side-effect is that vmlinux actually increases in size. It seems that
> > llvm-objcopy modifies the .strtab section, discarding many strings. I
> > speculate that is it discarding strings not referenced from .symtab
> > and updating the references therein.
> >
> > Layout is left completely up to libelf and existing section offsets
> > are likely to change.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
>
> Logic looks correct. One nit below.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >  libbtf.c | 127 +++++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 81 insertions(+), 46 deletions(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 4ae7150..9f4abb3 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -698,6 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
> >
> >  static int btf_elf__write(const char *filename, struct btf *btf)
> >  {
> > +       const char dot_BTF[] = ".BTF";
>
> it's a constant, so more appropriate name would be DOT_BTF, but that
> "dot_" notation in the name of the variable throws me off, honestly.
> libbpf is using BTF_SEC_NAME for this, which IMO makes more sense as a
> name for the constant
>

Ack. Changed. I'll wait a day for further comments before reposting.

Thanks again,
Giuliano.

>
> >         GElf_Ehdr ehdr;
> >         Elf_Data *btf_data = NULL;
> >         Elf *elf = NULL;
> > @@ -705,6 +706,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >         uint32_t raw_btf_size;
> >         int fd, err = -1;
> >         size_t strndx;
> > +       void *str_table = NULL;
> >
> >         fd = open(filename, O_RDWR);
> >         if (fd < 0) {
>
> [...]
