Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5253D6A73EB
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 19:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCAS62 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 13:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCAS62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 13:58:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04115167;
        Wed,  1 Mar 2023 10:58:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ec43so57963957edb.8;
        Wed, 01 Mar 2023 10:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677697106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBjCNneDRsPF8dkKpcPzpmUYB01L8NaBTycrTsX7pTc=;
        b=OmHKGDbM2zn4VITTatvLA41so0i1ivE7z63MuQyZR+gPFHYoO2tcrtxFf54SPQbihy
         FUYTyeemzOhamVZOir1A8Pm6wQwn+JjlWzFkhooELit7/DR+0qRvQe4zgTHw9bqcjSB3
         776njY3pfolar3FZiZ+xPnBMyuhhZwMeyLtzlaMPznX1CaLKLPd5GS+18FbHZUODxQCI
         3ZCBijg/Ne8OBv7X9HHaVYku7yye7s4C7+p1dXEjluuTOnnQx98aJkBZ/8Y8dNISJiTF
         eaZR07W36HQUaMzMbMZppBthnQ1Zc4iRq8RS2j4r0jBAFj7AHlkKAdX6CVIS6zQnzife
         BVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677697106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBjCNneDRsPF8dkKpcPzpmUYB01L8NaBTycrTsX7pTc=;
        b=kXcaZFrVeT0QHiym7aBgB6jBrMqFmh8deob8z/pHCrPJabtrjabwKXk1hF1euVbqhE
         R54yzsDo/FqcnUlzbdNU1IeufL1GxdIo2sJnlnVQLEHAWP4kP+lCGQ5XpWKeUeayVc2y
         p6CxxkdIE35g3XA2q6JY8SShjYhKsK9Xr1VM/fnPZeVJJ8ffVh/hOre0NMuw/uyY4dJQ
         wUx+N412p4OXQ2vTW85AOW78Kk4yTaIEewG5WzR3WChwkOzghyhiuDcFBNlxtqPHS1Vv
         NhKD2XRu0lY3+cgUq2y4vCSTdKAgBtjJoD8aBhclEzAaM5LTffJbFSz0zRtUL5L6wzf+
         sx4A==
X-Gm-Message-State: AO0yUKUobGCQTrG639n8os1OQftwHMp2k+lS33rgcguRaCyQTDuV6G/D
        k+EUYd9uKXRL1pwM4E7KEVygTWUj8CpBcuzdis8=
X-Google-Smtp-Source: AK7set8j4yqn0+EAZiHRN9YqOv3TEcmFoML0hbTACrXVL+onXcGd0XL20Vg0ZbVQgCqb95Hb95a8bk+bCOHSGpP9I+I=
X-Received: by 2002:a17:906:76d9:b0:8b1:28f6:8ab3 with SMTP id
 q25-20020a17090676d900b008b128f68ab3mr3840089ejn.15.1677697105632; Wed, 01
 Mar 2023 10:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20230228202357.2766051-1-eddyz87@gmail.com>
In-Reply-To: <20230228202357.2766051-1-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Mar 2023 10:58:13 -0800
Message-ID: <CAEf4BzaOe7wZPudEO04vOsrXaYrkmmuVfnCYAMbvm2LVaPw3tw@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: Fix for BTF id drift caused by
 adding unspecified types
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 12:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Recent changes to handle unspecified types (see [1]) cause BTF ID drift.
>
> Specifically, the intent of commits [2], [3] and [4] is to render
> references to unspecified types as void type.
> However, as a consequence:
> - in `die__process_unit()` call to `cu__add_tag()` allocates `small_id`
>   for unspecified type tags and adds these tags to `cu->types_table`;
> - `btf_encoder__encode_tag()` skips generation of BTF entries for
>   `DW_TAG_unspecified_type` tags.
>
> Such logic causes ID drift if unspecified type is not the last type
> processed for compilation unit. `small_id` of each type following
> unspecified type in the `cu->types_table` would have its BTF id off by -1=
.
> Thus, rendering references established on recode phase invalid.
>
> This commit reverts `unspecified_type` id/tag tracking.
> Instead, the following is done:
> - `small_id` for unspecified type tags is set to 0, thus reference to
>   unspecified type tag would render BTF id of a `void` on recode phase;
> - unspecified type tags are not added to `cu->types_table`.
>
> This change also happens to fix issue reported in [5], the gist of
> that issue is that the field `encoder->unspecified_type` is set but
> not reset by function `btf_encoder__encode_cu()`. Thus, the following
> sequence of events might occur when BTF encoding is requested:
> - CU with unspecified type is processed:
>   - unspecified type id is 42
>   - encoder->unspecified_type is set to 42
> - CU without unspecified type is processed next using the same
>   `encoder` object:
>   - some `struct foo` has id 42 in this CU
>   - the references to `struct foo` are set 0 by function
>     `btf_encoder__tag_type()`.
>
> [1] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/
> [2] bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning =
routines as void")
> [3] cffe5e1f75e1 ("core: Record if a CU has a DW_TAG_unspecified_type")
> [4] 75e0fe28bb02 ("core: Add DW_TAG_unspecified_type to tag__is_tag_type(=
) set")
> [5] https://lore.kernel.org/bpf/Y%2FP1yxAuV6Wj3A0K@google.com/
>
> Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returni=
ng routines as void")
> Fixes: 52b25808e44a ("btf_encoder: Store type_id_off, unspecified type in=
 encoder")
> Tested-by: KP Singh <kpsingh@kernel.org>
> Reported-by: Matt Bobrowski <mattbobrowski@google.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Looks like a sensible approach to me.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c  |  8 --------
>  dwarf_loader.c | 25 +++++++++++++++++++------
>  dwarves.h      |  8 --------
>  3 files changed, 19 insertions(+), 22 deletions(-)
>

[...]
