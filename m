Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ABF539A48
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 02:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbiFAAIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 20:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241043AbiFAAIq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 20:08:46 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130AA2A27B
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 17:08:45 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id o8so30951uap.6
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 17:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yteoLweHKDK2Hqjj6LqnuFv4wwAEf+6ik3YLIbd0RQ=;
        b=MtXcocZblObtiPBgP4bVslYH++km84uG1zdqG0NLfseTahk3b7vQ8a0y8YmyosrW98
         i5TgPZhj0eIVKwDKfSIK/NxH7n7ga9sK1SL+8aAvn6+P9Bg/dBO6ebN2TaM/cUroBEPp
         SerFL4AtEMnXhlVGmzT3ga46b0D3NM7NmsGC3y+laI9G0RXM5WeaG1aQkr6wov/mukst
         0UO/r9zVi7UUXfTGh5I+sdnnSBWsdImfEXtkit1lSzJXtui1V4lgCJU9NsoSZLr0Ck7X
         sX6J2pjeEsSjZN3V6XUL2gWHfj8zvyXoZ6377QVqKfJszv6cL0S9pPdJx4wS2gKLilvg
         p56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yteoLweHKDK2Hqjj6LqnuFv4wwAEf+6ik3YLIbd0RQ=;
        b=KalioY8Sets2wdtcC+R/age4y0rbh6vEM7jaRCd2rp2926w9d+AwTgPImu2Cx4Ft7W
         QFSfiF7Zdvo2fZuG6lN8c+zFaHk8sPgucd8Ywfb03XBN8MhIdz9agnjUt0WMToWpyZeg
         cJm4POBLTt0JZWsfB+01wWWmdHn6z24Q++WQWWhH264GMxZMUDa0kerB2MpUtLe6BFud
         JLu/CWpJb+zAbBdrz0kxxDP27kGmkBAMjYrYI6a4ZSOl6Lw0uEnFXXc4dVUpJK3xUmdt
         X9FSrQh0PUnLYt0WbYD5ENXeEZMezvLP/e7v3WODYP5g8f93K/echd+UIgwtbTduoLyO
         XprQ==
X-Gm-Message-State: AOAM531AqOM6r1JyJzdoY68zwnelwWarg94Z9vN+0a5H99/qoivKAJNR
        LEOFJqCJGD5wUgnGrVYLaBS95wr5v0IlA03vFK0=
X-Google-Smtp-Source: ABdhPJyLJLFYK2LW4btXTajUKUvrcfRJQa/lfKHZth6ByA6NIBysFpf1smbYIFUb9rjvIK9pUJWoVBf0n0nPHy/X9wU=
X-Received: by 2002:ab0:604a:0:b0:362:911f:fe65 with SMTP id
 o10-20020ab0604a000000b00362911ffe65mr22492736ual.107.1654042124132; Tue, 31
 May 2022 17:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220526185432.2545879-1-yhs@fb.com> <20220526185540.2551209-1-yhs@fb.com>
In-Reply-To: <20220526185540.2551209-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 May 2022 17:08:32 -0700
Message-ID: <CAEf4BzZBNfee7zpg2bN-XqQQjQrn4ufq_53pmYqbaWb+jiwcjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 13/18] selftests/bpf: Test new enum kflag and
 enum64 API functions
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

On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add tests to use the new enum kflag and enum64 API functions
> in selftest btf_write.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/btf_helpers.c     |  25 +++-
>  .../selftests/bpf/prog_tests/btf_write.c      | 126 +++++++++++++-----
>  2 files changed, 114 insertions(+), 37 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
> index b5941d514e17..1c1c2c26690a 100644
> --- a/tools/testing/selftests/bpf/btf_helpers.c
> +++ b/tools/testing/selftests/bpf/btf_helpers.c
> @@ -26,11 +26,12 @@ static const char * const btf_kind_str_mapping[] = {
>         [BTF_KIND_FLOAT]        = "FLOAT",
>         [BTF_KIND_DECL_TAG]     = "DECL_TAG",
>         [BTF_KIND_TYPE_TAG]     = "TYPE_TAG",
> +       [BTF_KIND_ENUM64]       = "ENUM64",
>  };
>
>  static const char *btf_kind_str(__u16 kind)
>  {
> -       if (kind > BTF_KIND_TYPE_TAG)
> +       if (kind > BTF_KIND_ENUM64)
>                 return "UNKNOWN";
>         return btf_kind_str_mapping[kind];
>  }
> @@ -139,14 +140,32 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
>         }
>         case BTF_KIND_ENUM: {
>                 const struct btf_enum *v = btf_enum(t);
> +               const char *fmt_str;
>
> -               fprintf(out, " size=%u vlen=%u", t->size, vlen);
> +               fmt_str = btf_kflag(t) ? "\n\t'%s' val=%d" : "\n\t'%s' val=%u";
> +               fprintf(out, " encoding=%s size=%u vlen=%u",
> +                       btf_kflag(t) ? "SIGNED" : "UNSIGNED", t->size, vlen);
>                 for (i = 0; i < vlen; i++, v++) {
> -                       fprintf(out, "\n\t'%s' val=%u",
> +                       fprintf(out, fmt_str,
>                                 btf_str(btf, v->name_off), v->val);
>                 }
>                 break;
>         }
> +       case BTF_KIND_ENUM64: {
> +               const struct btf_enum64 *v = btf_enum64(t);
> +               const char *fmt_str;
> +
> +               fmt_str = btf_kflag(t) ? "\n\t'%s' val=%lld" : "\n\t'%s' val=%llu";
> +
> +               fprintf(out, " encoding=%s size=%u vlen=%u",
> +                       btf_kflag(t) ? "SIGNED" : "UNSIGNED", t->size, vlen);
> +               for (i = 0; i < vlen; i++, v++) {
> +                       fprintf(out, fmt_str,
> +                               btf_str(btf, v->name_off),
> +                               ((__u64)v->val_hi32 << 32) | v->val_lo32);

nit: btf_enum64_value()?

> +               }
> +               break;
> +       }
>         case BTF_KIND_FWD:
>                 fprintf(out, " fwd_kind=%s", btf_kflag(t) ? "union" : "struct");
>                 break;

[...]
