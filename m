Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B605234F1F6
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 22:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhC3UIi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 16:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbhC3UI2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 16:08:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B36C061762
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 13:08:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ce10so26683447ejb.6
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VAXHfn9dQxBfFXvU1OjkPCS/kAWoQ1l2jM4WMCM4u0=;
        b=bJWAqBO6f1ZUVALag6L7ET901FctnxqZ9OlmaLXXa1Auy9H5jknIObFimdQvDTSLYt
         opkxLDix8dTzxm8Km8q/aj1XixWhNV8qWGmCvpqlEIdFcZ7hozWJYIAiEOhdKfFpT5Sk
         U1zZb/4Z39HJoHOvhrzrE1TpVWZhvqlI7afwVGtlYQ8IydLZSRGyUdLLCFsqBZEl+Lpz
         Mb7+Si8KdxQBku9gbpvXzcQiZlBWuIisNJLJ6lrxKKvZjcyTOeHlrqtj9mTehRL5HCqK
         Dn8oZ+3g9qV8CeFeKn/LUIq7+Gj9pSWvoGI8oHNc+S1iwhwRSohFmH5JQRbK1iFwpQQu
         EDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VAXHfn9dQxBfFXvU1OjkPCS/kAWoQ1l2jM4WMCM4u0=;
        b=F4SDQReytPZOVOZRtz4sIVGtls++BN8fXe4zMPGnmrh7KRfaGGH9A+XmyPIMaeaynj
         ndImRYSv0NC+QISAJV+iCh3Jy0tPyILH8/TA2gKOhZ8czHGsKbwgLX1bIWMhdkxrEuuk
         Q/Xwz/z6ssrjtEdcWYtTGcaxI6c0qk5wZuJxPsUWq9tT9njb+oF5k8FtTaU9FCGjVcp7
         xC76hQIl89g00jHO4QtSOZyGWdgLPMpvqLuE4oCvYWABcF4lpp7lhL8j6BnEn8EWdZar
         8Dz7D9OJ8k/GuKbEi1NYlvflVrc+BA9GJrNV2IaAa9SwPDUtMkNpGQCmvMkRLS13TqQn
         Bt6w==
X-Gm-Message-State: AOAM532hQvINTvuBzY3btnzjSISMiWFSATA9H5oMi7DchBc6/ADsio0J
        PtsHobsfSRK8oUhS9zw2OVV3lrcTgXdmYSljb4HT
X-Google-Smtp-Source: ABdhPJw42M2s+TiyvPYMIQNtiV0S6pLgNZOk6ZHKJBgwFXRBT4y41l5eIexwPc/zT1cEiD/tKUvYBcG1l85MJsoxBwc=
X-Received: by 2002:a17:906:d114:: with SMTP id b20mr34882691ejz.449.1617134906146;
 Tue, 30 Mar 2021 13:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210328201400.1426437-1-yhs@fb.com> <20210328201415.1428856-1-yhs@fb.com>
In-Reply-To: <20210328201415.1428856-1-yhs@fb.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 30 Mar 2021 13:08:15 -0700
Message-ID: <CAGG=3QUxQ+xfY9n8n+5QrTPAR4TDp=_TNfXtnKY32YZXH9WBaA@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 3/3] dwarf_loader: permit merging all dwarf
 cu's for clang lto built binary
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 28, 2021 at 1:14 PM Yonghong Song <yhs@fb.com> wrote:
>
> For vmlinux built with clang thin-lto or lto, there exist
> cross cu type references. For example, the below can happen:
>   compile unit 1:
>      tag 10:  type A
>   compile unit 2:
>      ...
>        refer to type A (tag 10 in compile unit 1)
> I only checked a few but have seen type A may be a simple type
> like "unsigned char" or a complex type like an array of base types.
>
> To resolve this issue, the tag DW_AT_producer of the first
> DW_TAG_compile_unit is checked. If the binary is built
> with clang lto, all debuginfo dwarf cu's will be merged
> into one pahole cu which will resolve the above
> cross-cu tag reference issue. To test whether a binary
> is built with clang lto or not, The "clang version"
> and "-flto" will be checked against DW_AT_producer string
> for the first 5 debuginfo cu's. The reason is that
> a few linux files disabled lto for various reasons.
>
> Merging cu's will create a single cu with lots of types, tags
> and functions. For example with clang thin-lto built vmlinux,
> I saw 9M entries in types table, 5.2M in tags table. The
> below are pahole wallclock time for different hashbits:
> command line: time pahole -J vmlinux
>       # of hashbits            wallclock time in seconds
>           15                       460
>           16                       255
>           17                       131
>           18                       97
>           19                       75
>           20                       69
>           21                       64
>           22                       62
>           23                       58
>           24                       64
>
> The problem is with hashtags__find(), esp. the loop
>     uint32_t bucket = hashtags__fn(id);
>     const struct hlist_head *head = hashtable + bucket;
>     hlist_for_each_entry(tpos, pos, head, hash_node) {
>             if (tpos->id == id)
>                     return tpos;
>     }
>
> Say we have 9M types and (1 << 15) buckets, that means each bucket
> will have roughly 64 elements. So each lookup will traverse
> the loop 32 iterations on average.
>
> If we have 1 << 21 buckets, then each buckets will have 4 elements,
> and the average number of loop iterations for hashtags__find()
> will be 2.
>
> Note that the number of hashbits 24 makes performance worse
> than 23. The reason could be that 23 hashbits can cover 8M
> buckets (close to 9M for the number of entries in types table).
> Higher number of hash bits allocates more memory and becomes
> less cache efficient compared to 23 hashbits.
>
> This patch picks # of hashbits 21 as the starting value
> and will try to allocate memory based on that, if memory
> allocation fails, we will go with less hashbits until
> we reach hashbits 15 which is the default for
> non merge-cu case.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  dwarf_loader.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index aa6372a..a51391e 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -51,6 +51,7 @@ struct strings *strings;
>  #endif
>
>  static uint32_t hashtags__bits = 15;
> +static uint32_t max_hashtags__bits = 21;
>
>  static uint32_t hashtags__fn(Dwarf_Off key)
>  {
> @@ -2484,6 +2485,115 @@ static int cus__load_debug_types(struct cus *cus, struct conf_load *conf,
>         return 0;
>  }
>
> +static bool cus__merging_cu(Dwarf *dw)
> +{
> +       uint8_t pointer_size, offset_size;
> +       Dwarf_Off off = 0, noff;
> +       size_t cuhl;
> +       int cnt = 0;
> +
> +       /*
> +        * Just checking the first cu is not enough.
> +        * In linux, some C files may have LTO is disabled, e.g.,
> +        *   e242db40be27  x86, vdso: disable LTO only for vDSO
> +        *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
> +        * Fortunately, disabling LTO for a particular file in a LTO build
> +        * is rather an exception. Iterating 5 cu's to check whether
> +        * LTO is used or not should be enough.
> +        */
> +       while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
> +                           &offset_size) == 0) {
> +               Dwarf_Die die_mem;
> +               Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl, &die_mem);
> +
> +               if (cu_die == NULL)
> +                       break;
> +
> +               if (++cnt > 5)
> +                       break;
> +
> +               const char *producer = attr_string(cu_die, DW_AT_producer);
> +               if (strstr(producer, "clang version") != NULL &&
> +                   strstr(producer, "-flto") != NULL)

Instead of checking for flags, which can be a bit brittle, would it
make more sense to scan the abbreviations to see if there are any
"sec_offset" encodings used for type attributes to indicate that LTO
was used?

Thank you for improving on my hacky patch! :-)

-bw

> +                       return true;
> +
> +               off = noff;
> +       }
> +
> +       return false;
> +}
> +
> +static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
> +                                    Dwfl_Module *mod, Dwarf *dw, Elf *elf,
> +                                    const char *filename,
> +                                    const unsigned char *build_id,
> +                                    int build_id_len,
> +                                    struct dwarf_cu *type_dcu)
> +{
> +       uint8_t pointer_size, offset_size;
> +       struct dwarf_cu *dcu = NULL;
> +       Dwarf_Off off = 0, noff;
> +       struct cu *cu = NULL;
> +       size_t cuhl;
> +
> +       while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
> +                           &offset_size) == 0) {
> +               Dwarf_Die die_mem;
> +               Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl, &die_mem);
> +
> +               if (cu_die == NULL)
> +                       break;
> +
> +               if (cu == NULL) {
> +                       cu = cu__new("", pointer_size, build_id, build_id_len,
> +                                    filename);
> +                       if (cu == NULL || cu__set_common(cu, conf, mod, elf) != 0)
> +                               return DWARF_CB_ABORT;
> +
> +                       dcu = malloc(sizeof(struct dwarf_cu));
> +                       if (dcu == NULL)
> +                               return DWARF_CB_ABORT;
> +
> +                       /* Merged cu tends to need a lot more memory.
> +                        * Let us start with max_hashtags__bits and
> +                        * go down to find a proper hashtag bit value.
> +                        */
> +                       uint32_t default_hbits = hashtags__bits;
> +                       for (hashtags__bits = max_hashtags__bits;
> +                            hashtags__bits >= default_hbits;
> +                            hashtags__bits--) {
> +                               if (dwarf_cu__init(dcu) == 0)
> +                                       break;
> +                       }
> +                       if (hashtags__bits < default_hbits)
> +                               return DWARF_CB_ABORT;
> +
> +                       dcu->cu = cu;
> +                       dcu->type_unit = type_dcu;
> +                       cu->priv = dcu;
> +                       cu->dfops = &dwarf__ops;
> +                       cu->language = attr_numeric(cu_die, DW_AT_language);
> +               }
> +
> +               Dwarf_Die child;
> +               if (dwarf_child(cu_die, &child) == 0) {
> +                       if (die__process_unit(&child, cu) != 0)
> +                               return DWARF_CB_ABORT;
> +               }
> +
> +               off = noff;
> +       }
> +
> +       /* process merged cu */
> +       if (cu__recode_dwarf_types(cu) != LSK__KEEPIT)
> +               return DWARF_CB_ABORT;
> +       if (finalize_cu_immediately(cus, cu, dcu, conf)
> +           == LSK__STOP_LOADING)
> +               return DWARF_CB_ABORT;
> +
> +       return 0;
> +}
> +
>  static int cus__load_module(struct cus *cus, struct conf_load *conf,
>                             Dwfl_Module *mod, Dwarf *dw, Elf *elf,
>                             const char *filename)
> @@ -2518,6 +2628,15 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>                 }
>         }
>
> +       if (cus__merging_cu(dw)) {
> +               res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
> +                                               build_id, build_id_len,
> +                                               type_cu ? &type_dcu : NULL);
> +               if (res)
> +                       return res;
> +               goto out;
> +       }
> +
>         while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
>                             &offset_size) == 0) {
>                 Dwarf_Die die_mem;
> @@ -2557,6 +2676,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>                 off = noff;
>         }
>
> +out:
>         if (type_lsk == LSK__DELETE)
>                 cu__delete(type_cu);
>
> --
> 2.30.2
>
