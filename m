Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC8053D34A
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiFCVrO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 17:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiFCVrO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 17:47:14 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0CF13E10
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 14:47:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y15so4343146ljc.0
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 14:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gz9aWAAVuPeFCi4jRNvMcxjZE6wmpD5bwYNvUBgSrPk=;
        b=fAg5ccrY5eugh6fSs32eyOcdBgJ4PeL2i42ca2TSnWTnpkFZuRZ4VyYV5x5n/5es11
         dTpEQrFnnjbTWGKdZPS+1rCxI8nRGccBkp4FHNzGcK2c7mvlGAnzt+Z5psHDPmuqX7cm
         0MdR5Q7KB2nyJbiKSAJU1ddHnkkHsxbdM8leLrPxkJac8JoKqVhdLuTHmj3Qs7jjZeAx
         1sn/IkugFSBZPEW1k0Zp8xK5hYA4VOGcWsNTT5HPtxqmCckDzMyleq6SQGe+5lWHlPBt
         C7njl8QfDBGG1vp2qh0sYyeiKSrqpqR1uYRGSio79P/kgrncSEhQeccbGa+TDA1ivlOX
         1kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gz9aWAAVuPeFCi4jRNvMcxjZE6wmpD5bwYNvUBgSrPk=;
        b=DnUp7aSPRtGjESNLGhbhGeXLlt2gcg93IrQUOY3dx21QaRq72mXaWarzvV9sSfMT3u
         o6Orlo5ggCaoNIRD1CR3WguM0ZEOht0OtXxJ9nHyXSU4KUj725K3WMOS07nSLs6GfBb6
         7VMXTfMLHFfi5RNUdVQ4944MWvIlghy0dXvbDYlNeV0ZXbqtrRyOJPOafozPHFDnUt1p
         ruRpvNJVu/XOXfqjAo5ckEl+jZa7Ni907HPgSZhS/Pp/0rUzwj3NVykos1IPLDyZO+vO
         pHUL41z+e8mqsepRSuuZ5JeV7D1fKV7KPkkEW9mD3v+B+CtJHfEBhgqXI6MwCpAdufNo
         s8Sg==
X-Gm-Message-State: AOAM532I7Z4ykVFxVHzWx4YLb3GZ86sdip6u37CyND6VWUGwbW+0LnO8
        GLwa3loVNW3JuMA+jGnKhFHKd9mc69UpEuVgmbc=
X-Google-Smtp-Source: ABdhPJyUtbpjopY1pbryS41yDKf0MFdwU2fYoNtVYSLhJNOERioPK9fv7RbtYbKHB3dYzagFOrAHH6VYzLAc38R2cEM=
X-Received: by 2002:a2e:a7c5:0:b0:253:ee97:f9b7 with SMTP id
 x5-20020a2ea7c5000000b00253ee97f9b7mr33733886ljp.472.1654292830373; Fri, 03
 Jun 2022 14:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220603015855.1187538-1-yhs@fb.com> <20220603015931.1190807-1-yhs@fb.com>
In-Reply-To: <20220603015931.1190807-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Jun 2022 14:46:59 -0700
Message-ID: <CAEf4BzbTYs5BDH6GsMqvcWoSsKEhjdVw8TSsOPxyxMzG5OFkzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/18] libbpf: Add enum64 support for btf_dump
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 2, 2022 at 6:59 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add enum64 btf dumping support. For long long and unsigned long long
> dump, suffixes 'LL' and 'ULL' are added to avoid compilation errors
> in some cases.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.h      |   5 ++
>  tools/lib/bpf/btf_dump.c | 137 +++++++++++++++++++++++++++++----------
>  2 files changed, 108 insertions(+), 34 deletions(-)
>

LGTM, thanks for the fix!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index c7e8b1fdfe24..dcb3f575a281 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -566,6 +566,11 @@ static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
>         return (struct btf_enum64 *)(t + 1);
>  }

[...]
