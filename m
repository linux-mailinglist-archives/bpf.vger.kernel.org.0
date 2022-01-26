Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA449C379
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 07:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiAZGJJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 01:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiAZGJI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 01:09:08 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A22BC06161C;
        Tue, 25 Jan 2022 22:09:08 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id d188so12141369iof.7;
        Tue, 25 Jan 2022 22:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2k+VBwnoAu7zrK/2JxJvrqmOxK+GQTmPPwm5yc4XQnc=;
        b=frOff+Sc9Qxfe8lDCB0e7JbIL3yDoIAzzM4ibk26rgdBY/UL0WyH+CuBRKi1dOAOuf
         uyBjW3CDLnhj+hRFvnOv8AwtXZwHwggXOssKqym/yOmlebfH3EkK5RMk1Gc+0lxbP0QS
         59LsdOP6hMfSRWxY/likgM/7jGx4yiWySXSSWW91pRnlfPPTVvvgi0Zr5O8yRzb6KSiL
         M5jHsUs0Kgh9Glo0J9uAoVv2CaJamWsiRvcclw/FeJuX5btu2EZEznVgVAQ/Vpm3YsV5
         ATFwFhrAWzkUOoR/Ljz1UeBlRfkL63OTa3ETBRvdwVxYpaRmNCSw6afqm2jeBlsZdV04
         W/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2k+VBwnoAu7zrK/2JxJvrqmOxK+GQTmPPwm5yc4XQnc=;
        b=fvX4qqDaMo0LRurJrsTKPuuwfYcxrL6Bp4AO+tcIHNj5sPz9qsFWhoByOQn5oWor3Q
         tzUWRRZteznTUV7/w7yGCAxYGPzZHVt7b638piiNcffUDWWnjU88E0TixObSp1GEnt+r
         e8dYbU43WBfIIid1d7E4/KuFLxcBYq8KdZrmMcmBvFMZc9x3bS/bfeMlgUFHKlebNO8A
         sBGchBc+uC7urN2VKHDXmjkkRMNy00Pw2Vzk7dBVnn/gjsIzJDoz+yBkesfqBCw06JLj
         ttgMpF42Ua88vrEt3pnfDB4RMrQCKvNNxvJbjUh7MO7c3SZqgHzwf7venBSa4wWmSJOH
         WYAQ==
X-Gm-Message-State: AOAM532GptPDTIG6qmtHE2SF44QN8LwytJPBXTW/KjzJatIXnPxM0+Pb
        Wvdk5pYyuDyXIyfhxGltuPUsZWr/S2oFjb5Xbss=
X-Google-Smtp-Source: ABdhPJyuGN8whsuBoBB54UejQLUhJGdCaHGQvMJbPep6fAwND7BJ4xwrlWBuOXM25+cCFtcd+dOMAmABOiNZqD3pUfo=
X-Received: by 2002:a5d:9f01:: with SMTP id q1mr12844673iot.144.1643177347794;
 Tue, 25 Jan 2022 22:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20220126040509.1862767-1-kuifeng@fb.com> <20220126040509.1862767-5-kuifeng@fb.com>
In-Reply-To: <20220126040509.1862767-5-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 25 Jan 2022 22:08:56 -0800
Message-ID: <CAEf4BzYWFZZG5ry-A4M0Pt7+aZ+C2pFb54AzYDQCPHgR2rU4kQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 4/4] libbpf: Update libbpf to a new revision.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 8:07 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Replace deprecated APIs with new ones.
> ---

LGTM with few nits below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c | 20 ++++++++++----------
>  btf_loader.c  |  2 +-
>  lib/bpf       |  2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 56a76f5d7275..a31dbe3edc93 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -172,7 +172,7 @@ __attribute ((format (printf, 5, 6)))
>  static void btf__log_err(const struct btf *btf, int kind, const char *name,
>                          bool output_cr, const char *fmt, ...)
>  {
> -       fprintf(stderr, "[%u] %s %s", btf__get_nr_types(btf) + 1,
> +       fprintf(stderr, "[%u] %s %s", btf__type_cnt(btf),
>                 btf_kind_str[kind], name ?: "(anon)");
>
>         if (fmt && *fmt) {
> @@ -203,7 +203,7 @@ static void btf_encoder__log_type(const struct btf_encoder *encoder, const struc
>         out = err ? stderr : stdout;
>
>         fprintf(out, "[%u] %s %s",
> -               btf__get_nr_types(btf), btf_kind_str[kind],
> +               btf__type_cnt(btf) - 1, btf_kind_str[kind],
>                 btf__printable_name(btf, t->name_off));
>
>         if (fmt && *fmt) {
> @@ -449,10 +449,10 @@ static int btf_encoder__add_field(struct btf_encoder *encoder, const char *name,
>         int err;
>
>         err = btf__add_field(btf, name, type, offset, bitfield_size);
> -       t = btf__type_by_id(btf, btf__get_nr_types(btf));
> +       t = btf__type_by_id(btf, btf__type_cnt(btf) - 1);
>         if (err) {
>                 fprintf(stderr, "[%u] %s %s's field '%s' offset=%u bit_size=%u type=%u Error emitting field\n",
> -                       btf__get_nr_types(btf), btf_kind_str[btf_kind(t)],
> +                       btf__type_cnt(btf) - 1, btf_kind_str[btf_kind(t)],
>                         btf__printable_name(btf, t->name_off),
>                         name, offset, bitfield_size, type);
>         } else {
> @@ -899,9 +899,9 @@ static int btf_encoder__write_raw_file(struct btf_encoder *encoder)
>         const void *raw_btf_data;
>         int fd, err;
>
> -       raw_btf_data = btf__get_raw_data(encoder->btf, &raw_btf_size);
> +       raw_btf_data = btf__raw_data(encoder->btf, &raw_btf_size);
>         if (raw_btf_data == NULL) {
> -               fprintf(stderr, "%s: btf__get_raw_data failed!\n", __func__);
> +               fprintf(stderr, "%s: btf__raw_data failed!\n", __func__);
>                 return -1;
>         }
>
> @@ -976,7 +976,7 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
>                 }
>         }
>
> -       raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> +       raw_btf_data = btf__raw_data(btf, &raw_btf_size);
>
>         if (btf_data) {
>                 /* Existing .BTF section found */
> @@ -1043,10 +1043,10 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>                 btf_encoder__add_datasec(encoder, PERCPU_SECTION);
>
>         /* Empty file, nothing to do, so... done! */
> -       if (btf__get_nr_types(encoder->btf) == 0)
> +       if (btf__type_cnt(encoder->btf) - 1 == 0)

btf__type_cnt() == 1 ?

>                 return 0;
>
> -       if (btf__dedup(encoder->btf, NULL, NULL)) {
> +       if (btf__dedup(encoder->btf, NULL)) {
>                 fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
>                 return -1;
>         }
> @@ -1403,7 +1403,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>
>  int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>  {
> -       uint32_t type_id_off = btf__get_nr_types(encoder->btf);
> +       uint32_t type_id_off = btf__type_cnt(encoder->btf) - 1;
>         struct llvm_annotation *annot;
>         int btf_type_id, tag_type_id;
>         uint32_t core_id;
> diff --git a/btf_loader.c b/btf_loader.c
> index b61cadd55127..d9d59aa889a0 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -399,7 +399,7 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
>         uint32_t type_index;
>         int err;
>
> -       for (type_index = 1; type_index <= btf__get_nr_types(btf); type_index++) {
> +       for (type_index = 1; type_index <= btf__type_cnt(btf) - 1; type_index++) {

nit: type_index < btf__type_cnt(btf) would be more natural


>                 const struct btf_type *type_ptr = btf__type_by_id(btf, type_index);
>                 uint32_t type = btf_kind(type_ptr);
>
> diff --git a/lib/bpf b/lib/bpf
> index 94a49850c5ee..393a058d061d 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 94a49850c5ee61ea02dfcbabf48013391e8cecdf
> +Subproject commit 393a058d061d49d5c3055fa9eefafb4c0c31ccc3
> --
> 2.30.2
>
