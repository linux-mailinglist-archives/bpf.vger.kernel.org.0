Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4406EF9D1
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjDZSJi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjDZSJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 14:09:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215157DAF
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 11:09:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517bb01bac9so5361628a12.0
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682532575; x=1685124575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Uh2mmnVVJ4a3YubCjfRfDulVq2Jba+qSmT/b6yIxAs=;
        b=osODbhIuvZbiilm5k41lEBCIpF+2bjdNngs9yJ69ASoSp0mkLim9WSVUdwje/8tr5i
         HmMPiDYgQqTZBG32JnrCzkZGEuzGpSZM7yEe9KPv/kZO2gxoNtSOHOPQW5UP88cK2PZf
         Qwmcmst7lvejXEkmSaeNANdT4Ee0RfJoy5rl7VEvRZIiWtmCOd1t5aw/lIORX7zwZLMJ
         rgUGAqHAaa0KpuA9XRhut2KK5ktNRxuFdXz1oYScRjlSRjWOB8D9uE+D4S/FkyYPSGf5
         KWr29x+jdYburVG77gPumvGH0bIo2S4xhuk8St7/bosyN+RqsYYnghYwM63OhXH3nhuw
         9ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682532575; x=1685124575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Uh2mmnVVJ4a3YubCjfRfDulVq2Jba+qSmT/b6yIxAs=;
        b=HlC7r5AFVVIJRZHyiuBQE+MynyVl5si/AHhdS+soK2ouvChUdb2CeQNY5OpK3g/wG1
         ONWUqAIqmCAsrfe688P75OMJcu8hdxEk1pInDh0nzxLU8gQ6YTU5eoAF6C9FmXPApq5z
         cLDO8RJukkvz6iWMIRKLXTSqFonWyBX9JEp7InN80UbaWJygYkkiAwac3TsysjfzkAZq
         thRvbyq6MtlCtp+x3GZRwt7NHWzvMyMArIZj2lATvY5O2XiVggQbTPKs4qdOMaFHTO33
         8kyc7sSXmS7ON9EiBYa8H+iPzcof0eKAl2aB9tM2AW24eIoCdrHZ4n79CLB6z6nzZU79
         tRKQ==
X-Gm-Message-State: AAQBX9dB8KPbCrDquoqQHwtorp4DJtL/pACP1bX3hX4eCGPPJ+y2GpFN
        UlxovRvwSwJLswoPxTkRih2bVwY3y2PkSMi8rM4Cnw==
X-Google-Smtp-Source: AKy350bo2EXi/GPhUdDywMbKveB0ZREOFdSr+ni/Dkeic/U/tYVwuh5NI4QQDvifIZ2NmLc/laZEexd7Qk8qd0BeBJo=
X-Received: by 2002:a17:90b:304:b0:240:f8a6:55c7 with SMTP id
 ay4-20020a17090b030400b00240f8a655c7mr21701568pjb.20.1682532575398; Wed, 26
 Apr 2023 11:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230426055030.3743074-1-yhs@fb.com>
In-Reply-To: <20230426055030.3743074-1-yhs@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Apr 2023 11:09:24 -0700
Message-ID: <CAKwvOdnXh0e0F=_5nuVcMNsHAkqkc+K5FrOmktFZ76z3X_zHug@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: Fix a dwarf type DW_ATE_unsigned_1024
 to btf encoding issue
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 10:50=E2=80=AFPM Yonghong Song <yhs@fb.com> wrote:
>
> Nick Desaulniers reported an issue ([1]) where an 128-byte sized type
> (DW_ATE_unsigned_1024) cannot be encoded into BTF with failure message
> likes below:
>   $ pahole -J reduced.o
>   [2] INT DW_ATE_unsigned_1024 Error emitting BTF type
>   Encountered error while encoding BTF.
> See [1] for how to reproduce the issue.
>
> The failure is due to currently BTF int type only supports upto 16
> bytes (__int128) and in this case the dwarf int type is 128-byte.
>
> The DW_ATE_unsigned_1024 is not a normal type for variable/func
> declaration etc. It is used in DW_AT_location. There are two
> ways to resolve this issue.
>   (1). If btf encoding is expected, remove all dwarf int types
>        where btf encoding will failure, e.g., non-power-of-2
>        bytes, or greater than 16 bytes.
>   (2). do a sanitization in btf_encoder ([2]).
>
> This patch uses method (2) since it is a simple fix in btf_encoder.
> I checked my local built vmlinux with latest
> bpf-next. There is only one instance of DW_ATE_unsigned_24 (used in
> DW_AT_location) so I expect irregular int types should be very rare.
>
>   [1] https://github.com/libbpf/libbpf/pull/680
>   [2] commit 7d8e829f636f ("btf_encoder: Sanitize non-regular int base ty=
pe")
>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Thanks, this fixed the above reported error for me.  My report is just
forwarded from Satya.

Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

I don't know if that change has other implications for unusual byte sizes.

We might need to consider at some point waiting to validate
DW_TAG_base_type until we know that they're not used outside of
DW_AT_location expressions.

> ---
>  btf_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 65f6e71..1aa0ad0 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -394,7 +394,7 @@ static int32_t btf_encoder__add_base_type(struct btf_=
encoder *encoder, const str
>          * these non-regular int types to avoid libbpf/kernel complaints.
>          */
>         byte_sz =3D BITS_ROUNDUP_BYTES(bt->bit_size);
> -       if (!byte_sz || (byte_sz & (byte_sz - 1))) {
> +       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16) {
>                 name =3D "__SANITIZED_FAKE_INT__";
>                 byte_sz =3D 4;
>         }
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
