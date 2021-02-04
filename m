Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97F30EB6E
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 05:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhBDELB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 23:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhBDEK5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 23:10:57 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79A2C0613D6;
        Wed,  3 Feb 2021 20:10:16 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n2so1816356iom.7;
        Wed, 03 Feb 2021 20:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdsC8p1CrAuIgu1LnHXezXC9Y86s+XAREfxzayR83GY=;
        b=krMKODC55QYVmWqtgw52HhxMySD05GNegsBwOhA8Px7R4LONfrlHJxgjCKFW1XoMP4
         gyWuGmEwkM9ennz4exRymA364kJyES/dlra8l2Amcszx4Lch0rDEZDPAro4gebcJx2N5
         JAHK1bMZgCgXFohBXcnMeIO5NZlE6BV3+3B2rlOsTUgFAs9Au7iGuavUWOGh2SIeWAw/
         lsz62fq47CNtZiXRc+obcyGidAWMwxG7t2F6oAMy9kM1sxL/w5yWiquDMe8eBGGJ6iq2
         j+ydd1/KHaP6qT4MXbIMkDwHbutpxyabztQkX9WgBcAdkKbnCK4Wik5ulIZFMSpbjHCs
         9VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdsC8p1CrAuIgu1LnHXezXC9Y86s+XAREfxzayR83GY=;
        b=JSa9bz3qflXFq1K/V/L/8Kypyaf1vOZE4OGTr6PRcvZMgI7Hr6Udc+2o5uNGE7gnHY
         LxIpC/zd83VHCJ12QeCHAqMfG4eJVVqOXU7fh5DsmYdOcBaURlq2H0Xm18bRs/tU8rkh
         Pao335PmeAi1yMn727JCqObauePxD/Ij+MDKhUy/1dNZX1R+Nu5SqVMTxMTz2IbmbDxv
         O54Cm9Hlcck7O8jZm+VOZplKGnPBHAVjbsTcS65MRrIDdThK79aO9TK3DStm7CpK+HmW
         2JrZ96mKcMPlYwtSGRfHUOMTeh12WO7oDP4Ux+eJvYjx5N0PMmoBuCgBf3QnR2ZTuf38
         zbpA==
X-Gm-Message-State: AOAM530chqDjhubHCQmfML0a+pOEf/0Vup0nyTRtuuBgNLmsVwOc3xHi
        +NcJEdH0qHfUwVPwKZ+bqSzCHeSLHaEP8dS2v5o=
X-Google-Smtp-Source: ABdhPJwCtR1oWXYfEW+NKVhGvy2eNbJ7jZi5CHIFOsRRO4hHvOA0apBA8KHtm56Kbe3HlmjaZuQAFp6BYLaQsNC3TPM=
X-Received: by 2002:a02:82c7:: with SMTP id u7mr6216212jag.46.1612411816152;
 Wed, 03 Feb 2021 20:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210201172530.1141087-5-gprocida@google.com>
In-Reply-To: <20210201172530.1141087-5-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 20:10:03 -0800
Message-ID: <CAEf4Bzb6bKVo3NeVUr3Zb9+is0XbeOn+xLXtHv-GA_cWGVZfnA@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 4/4] btf_encoder: Align .BTF section/segment to
 8 bytes
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

On Mon, Feb 1, 2021 at 9:26 AM Giuliano Procida <gprocida@google.com> wrote:
>
> This is to avoid misaligned access to BTF type structs when
> memory-mapping ELF sections.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index 048a873..ae99a93 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -755,7 +755,13 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>          * This actually happens in practice with vmlinux which has .strtab
>          * after .shstrtab, resulting in a (small) hole the size of the original
>          * .shstrtab.
> +        *
> +        * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
> +        * nice if we could fetch this value from somewhere. The BTF
> +        * specification does not discuss alignment and its trailing string
> +        * table is not currently padded to any particular alignment.
>          */
> +       const size_t btf_alignment = 8;
>
>         /*
>          * First we look if there was already a .BTF section present and
> @@ -847,8 +853,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>         elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
>
>         /* Update .BTF section in the SHT */
> -       size_t new_btf_offset = high_water_mark;
> -       size_t new_btf_size = raw_btf_size;
> +       size_t new_btf_offset = roundup(high_water_mark, btf_alignment);
> +       size_t new_btf_size = roundup(raw_btf_size, btf_alignment);
>         GElf_Shdr btf_shdr_mem;
>         GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
>         if (!btf_shdr) {
> @@ -856,6 +862,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>                         __func__, elf_errmsg(elf_errno()));
>                 goto out;
>         }
> +       btf_shdr->sh_addralign = btf_alignment;

if we set just this and let libelf do the layout, would libelf ensure
8-byte alignment of .BTF section inside the ELF file?

>         btf_shdr->sh_entsize = 0;
>         btf_shdr->sh_flags = SHF_ALLOC;
>         if (dot_btf_offset)
> @@ -926,6 +933,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>                 pht[phnum].p_memsz = pht[phnum].p_filesz = btf_shdr->sh_size;
>                 pht[phnum].p_vaddr = pht[phnum].p_paddr = 0;
>                 pht[phnum].p_flags = PF_R;
> +               pht[phnum].p_align = btf_alignment;
>                 void *phdr = gelf_newphdr(elf, phnum+1);
>                 if (!phdr) {
>                         fprintf(stderr, "%s: gelf_newphdr failed: %s\n",
> --
> 2.30.0.365.g02bc693789-goog
>
