Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B307B3142CA
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 23:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBHWYY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 17:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBHWYX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 17:24:23 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9AC061786;
        Mon,  8 Feb 2021 14:23:43 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v5so7450874ybi.3;
        Mon, 08 Feb 2021 14:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+3ZvpwwkN2QLjczr9MRPPBg2cIzElo1qWeKDDaotpg=;
        b=Z30CvnUGWHy47kVNoAj8sFmW8Hoc9nucNVLLyT91OK1ioRReSJ9+bbH2HUaWV1Y4zS
         bm773jRE30YqzqjdVmkpvXZSuMLZSOnOXXC0/6NVonmrnuZVSUaYqDp7jyXDgZEEQYEW
         WuE7ywBHRnbNt53UgWzx/iw3ZDXttBCbpP5Rsim4WvkXMNeSwmN4lS2Sn0aXSDJu9bDF
         m7cp6ScKoThW9K/w/xAhfAzilphyvTSpVXCiNbiYU7VbgIqDPGNPZZ5ZCJ489sR4U1Oj
         CNKfG56I8I5hV5RkkVsBVG0pM7yysG7hKFRdr82N1dZJ//s8dXQT8VJ3wrUzNPnqx+V5
         1HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+3ZvpwwkN2QLjczr9MRPPBg2cIzElo1qWeKDDaotpg=;
        b=VSFjIegYXGICZRoDW37Ruzg3jLQLqP6n1XkokyozRwwUsUsr91w9G5oIzaE0/z/uZ+
         ZlrnFAc5nWg032Pob9fw5RMYIaLpoOPWubeff9RQpIX+Rlo6TKlYWtgK+CEaYtaPo8lp
         +dTZWwsjt1j8lAqHWa+MuW44wLphwOEYw6ACpFRwTWdjwFDV2yy106LrAFThD9HZyjEX
         EJe//SRcDMXPhOhhfSR6FaS1h7VaTkbmcsJXWCsVht63XhgVZry0hefR1iQzeP7Kq7kX
         kuKK9u+C7u6ZTtDJ4Pwd4Zah/69XpY4Xc9t7cpASNByk6g7uRFl9qXk8DczHMKqo60+Q
         FAFA==
X-Gm-Message-State: AOAM5339MCovDyUOJyzko/tDbnVR2UCW3NpS5w5+VYwlVXDozrihm4ae
        7ZtGKA9mgRSVBRL72FlnWxLz6kitgG6kSkilv/c=
X-Google-Smtp-Source: ABdhPJwQzdIHU1oWUiEP/k0pnht3XdPkNsRUnDrDFPbcfJWcwWukccWSxic9iTQ8RRSEuE1kuupr5zo2pidAlInFWno=
X-Received: by 2002:a25:9882:: with SMTP id l2mr26978057ybo.425.1612823022627;
 Mon, 08 Feb 2021 14:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-3-gprocida@google.com>
In-Reply-To: <20210205134221.2953163-3-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 14:23:31 -0800
Message-ID: <CAEf4BzZP8hWkBUKi15j3E+D63n9269viQyCagsHpJFm=DOE4Gg@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 2/5] btf_encoder: Do not use both structs and
 pointers for the same data
To:     Giuliano Procida <gprocida@google.com>
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

On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
>
> Many operations in the libelf API return a pointer to a user-provided
> struct (on success) or NULL (on failure).
>
> There are a couple of places in btf_elf__write where both structs and
> pointers to the same structs are used. Holding on to the pointers
> raises ownership and lifetime issues unncessarily and the code is

typo: unnecessarily

> cleaner with only a single access path for these data.
>
> The code now treats the returned pointers as booleans.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---

styling nits, but otherwise LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  libbtf.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index 7bc49ba..ace8896 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -698,8 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
>
>  static int btf_elf__write(const char *filename, struct btf *btf)
>  {
> -       GElf_Shdr shdr_mem, *shdr;
> -       GElf_Ehdr ehdr_mem, *ehdr;
> +       GElf_Ehdr ehdr;
>         Elf_Data *btf_data = NULL;
>         Elf_Scn *scn = NULL;
>         Elf *elf = NULL;
> @@ -727,13 +726,12 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>
>         elf_flagelf(elf, ELF_C_SET, ELF_F_DIRTY);
>
> -       ehdr = gelf_getehdr(elf, &ehdr_mem);
> -       if (ehdr == NULL) {
> +       if (!gelf_getehdr(elf, &ehdr)) {
>                 elf_error("elf_getehdr failed");
>                 goto out;
>         }
>
> -       switch (ehdr_mem.e_ident[EI_DATA]) {
> +       switch (ehdr.e_ident[EI_DATA]) {
>         case ELFDATA2LSB:
>                 btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
>                 break;
> @@ -751,10 +749,10 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>
>         elf_getshdrstrndx(elf, &strndx);
>         while ((scn = elf_nextscn(elf, scn)) != NULL) {
> -               shdr = gelf_getshdr(scn, &shdr_mem);
> -               if (shdr == NULL)
> +               GElf_Shdr shdr;

it's a good style to have an empty line between variable declaration
block and subsequent instructions


> +               if (!gelf_getshdr(scn, &shdr))
>                         continue;
> -               char *secname = elf_strptr(elf, strndx, shdr->sh_name);
> +               char *secname = elf_strptr(elf, strndx, shdr.sh_name);
>                 if (strcmp(secname, ".BTF") == 0) {
>                         btf_data = elf_getdata(scn, btf_data);
>                         break;
> --
> 2.30.0.478.g8a0d178c01-goog
>
