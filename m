Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A35D6E5637
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 03:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDRBKV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 21:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRBKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 21:10:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFBB40C8
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:10:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sz19so11944484ejc.2
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681780218; x=1684372218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUvjvpuTG5JeSrPw/WP68rnSass5zHO1SkYjpewDm18=;
        b=A/OWZddWSjjBlSGTPbYkBGdBlWdQl0Q6X799MhjQtBKvikMwenKZcv80+S/Lb+4tA/
         gdGJCuwgM2JTB1yvzlq2LV6TVlw4k1Or0LemFE1C8IB7Sf2vkXKmrhBC4AUaTLYSKAxn
         VviqQVUQgE/+5KNlWevaZfJhilQXFVrWJjN5oHYIreb1e8jlEspO6e4wpdyrVz0vbxl5
         OO6NmS8WjmmVs0PrY+Tf9j/PAW6ZufyBZaAnK/JkYNEAvTRDEixf3fhRceK/6GFJCsBL
         QWc7YQhogYj66VOD2/Op8oN1bxidSi8CTCjaHGqip8Mivc9l1VLj5y5JOIvQfdIWyqG0
         k1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681780218; x=1684372218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUvjvpuTG5JeSrPw/WP68rnSass5zHO1SkYjpewDm18=;
        b=NjHR3F4GkCwMxF18nU+T/P54+wcvv014GIA07ivbDPu/qrHISomnTIoboWa7SHBUGZ
         y6zSi4ulPuDCraDnV3++8fdWt9ubDUMcuc6eRDMibcHS//ZfDPxSNFZLodOfZ1zPuxMy
         ggkl+u6drbq0fQEhFckOsztAoJLWzsocsSDmoZtAhkHU0vesOQoFIlO6zWnh5+TKimFX
         Q/QKZ+XrAgEHpwzCVINo8JE96FZ3vUDWP1qyYvxPgTvmeGaw7rUOXv/tyvTkn+NLimGc
         N9kmJhPW1iZwt/fglFDrIOixpgqbQ+6Dr78KK+vdO6/hp00Gpd6uAusDQobUPPyV6Xx3
         uL+w==
X-Gm-Message-State: AAQBX9eHKNSFPhqpUv+770TtUhLQ0cA3yrVlL/2fgtMUyagA/yWc0t9Z
        2pQuhn/5zsy8G4aNsEm94rI/Yoac3KsKNUzmEIjZtq7e8TU=
X-Google-Smtp-Source: AKy350aFrICIyNMvsU2rvo7H1ttNiTK2M/UmSsAxrZu+BWPkgBGqmZkeYsGKSO/M5nwCG/CEb7bD5UWAr+82ZVvNLn0=
X-Received: by 2002:a17:906:cb0f:b0:94f:99:858c with SMTP id
 lk15-20020a170906cb0f00b0094f0099858cmr3815705ejb.3.1681780217990; Mon, 17
 Apr 2023 18:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230418002148.3255690-1-andrii@kernel.org> <20230418002148.3255690-4-andrii@kernel.org>
In-Reply-To: <20230418002148.3255690-4-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 17 Apr 2023 18:10:06 -0700
Message-ID: <CAADnVQK-JjutrU-TMCh6f9qfcY_9T2mr59+Lzcw5us8KwDEmug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] libbpf: improve handling of unresolved kfuncs
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
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

On Mon, Apr 17, 2023 at 5:22=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>                                 insn[0].imm =3D ext->ksym.kernel_btf_id;
>                                 insn[0].off =3D ext->ksym.btf_fd_idx;
> -                       } else { /* unresolved weak kfunc */
> -                               insn[0].imm =3D 0;
> -                               insn[0].off =3D 0;
> +                       } else { /* unresolved weak kfunc call */
> +                               poison_kfunc_call(prog, i, relo->insn_idx=
, insn,
> +                                                 relo->ext_idx, ext);

With that done should we remove:
    /* skip for now, but return error when we find this in fixup_kfunc_call=
 */
    if (!insn->imm)
          return 0;
in check_kfunc_call()...

and  if (!func_id && !offset) in add_kfunc_call() ?

That was added in commit a5d827275241 ("bpf: Be conservative while
processing invalid kfunc calls")
