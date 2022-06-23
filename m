Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D585571A5
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 06:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiFWEkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 00:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbiFWEPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 00:15:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20B43AE1
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 21:15:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u12so38392150eja.8
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XqaeoKxO25KFagg5Ozue/XbCJT1yNS3NZ8bCAzbaK/E=;
        b=bPbyYVfnw6IWc9u6Jxxvb0sg4UNtVMXIz8wndaV5i95hZebrQfA/OkYbRykLjwhmN4
         zhVqP1mnDrEf+uBCh/if5HsJvTYFej8PKYqlMnQLIFmtwIdggWHwx+OA9kzJtMymAMsH
         D1UI2k8pBHkWJrKAatZcoMnoFokGzi6h/7/1aifftA+WcnYi401K9OwohgQ/PjbmoiBK
         ICVplijuWTcwaNkExLVf5d0NUbXSVnKGjseuonZV/VCttpU0vm+zxtjWveP8mSp/s+Qx
         PAJV7jRIv1QDRW6yqgumWUYEvJo8jJrxLQtJ4bz6fw32qNcubf4BKyCu4w01M/BPtyBb
         ZF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XqaeoKxO25KFagg5Ozue/XbCJT1yNS3NZ8bCAzbaK/E=;
        b=vr4lXXvJt5uF2W5Z0wH/oeftlyUx1gws+Ty7uPDjmyNc7g4+lY6CfuZUflm6oCJmQA
         4LQjrsS9gyOW7ps0HpPazguvLpmrT5iEovsBAiXW0ouqQ0Ds06QwB61nPR2akfsBR1oC
         IdgGFGTI3qi4NXtmnI2IZIshCTRlmORmyuii8a1+1Aj9BIB1Thf31LPkKb6KQ1NtlAmL
         +SPoHfrFcWZCDebhc/HtnJaf/iA1JN3eXpIgqn+0WPimM3g1sEWMCnEeilEefG91dUp2
         hxzPcURt8T3eWNorUQW5Ns0SuU0AfTvXXHQ0bMcwVaiU3Lx6XfFGUa2ba/kFkSl3dp8b
         GMZA==
X-Gm-Message-State: AJIora9DA0OEDxRGy99J44GeAxKZJDlT3NrbXeetSmID5RcOyKtJGptV
        cJoRDctVjxBnnqt/7MS8jW1x1Y8hm7MzFJeP/QE=
X-Google-Smtp-Source: AGRyM1ucDWZM8aGEHYf9OLwiP+V0JAagjWYoZho9Gcw5goQz10H5fgntD2l/sLtNegA383Iy8m+Ws6A0/vd4LC9DLgs=
X-Received: by 2002:a17:907:ea5:b0:722:d031:cf3d with SMTP id
 ho37-20020a1709070ea500b00722d031cf3dmr6252414ejc.226.1655957712248; Wed, 22
 Jun 2022 21:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173506.860578-1-deso@posteo.net> <20220622173506.860578-2-deso@posteo.net>
In-Reply-To: <20220622173506.860578-2-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Jun 2022 21:15:01 -0700
Message-ID: <CAEf4Bzbe-r+G00Zy-wTFE+Y765BtmaTNHYdjoXc91XNwzuJWWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Move core "types_are_compat" logic
 into relo_core.c
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 10:35 AM Daniel M=C3=BCller <deso@posteo.net> wrote=
:
>
> This change merges the two existing implementations of the
> bpf_core_types_are_compat() function into relo_core.c, inheriting the
> recursion tracking from the kernel and the usage of
> btf_kind_core_compat() from libbpf. The kernel is left untouched and
> will be adjusted subsequently.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---

I don't feel very strongly about this, but given we are consolidating
kernel and libbpf code, I think it makes sense to do it in one patch.

>  tools/lib/bpf/libbpf.c    | 72 +-----------------------------------
>  tools/lib/bpf/relo_core.c | 78 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/relo_core.h |  2 +
>  3 files changed, 81 insertions(+), 71 deletions(-)
>

[...]

> -       default:
> -               pr_warn("unexpected kind %s relocated, local [%d], target=
 [%d]\n",
> -                       btf_kind_str(local_type), local_id, targ_id);
> -               return 0;
> -       }
> +       return bpf_core_types_are_compat_recur(local_btf, local_id, targ_=
btf, targ_id, INT_MAX);

INT_MAX seems like an overkill, let's just hard-code 32 just like we
have for a local recursion limit here?

>  }
>

[...]

>  /*
>   * Turn bpf_core_relo into a low- and high-level spec representation,
>   * validating correctness along the way, as well as calculating resultin=
g
> diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
> index 7df0da0..b8998f 100644
> --- a/tools/lib/bpf/relo_core.h
> +++ b/tools/lib/bpf/relo_core.h
> @@ -68,6 +68,8 @@ struct bpf_core_relo_res {
>         __u32 new_type_id;
>  };
>
> +int bpf_core_types_are_compat_recur(const struct btf *local_btf, __u32 l=
ocal_id,
> +                                   const struct btf *targ_btf, __u32 tar=
g_id, int level);

Just leave it called __bpf_core_types_are_compat like in kernel, it is
clearly an "internal" version of bpf_core_types_are_compat(), so it's
more proper naming convention.


>  int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_i=
d,
>                               const struct btf *targ_btf, __u32 targ_id);
>
> --
> 2.30.2
>
