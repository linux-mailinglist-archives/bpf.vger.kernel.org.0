Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB3665F36
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 16:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjAKPe6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 11 Jan 2023 10:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbjAKPep (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 10:34:45 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599A81A04E;
        Wed, 11 Jan 2023 07:34:43 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id ud5so37813375ejc.4;
        Wed, 11 Jan 2023 07:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2VLOWtd0IgkRxHp6V/NmwaljU6/IouUI04AHYWfdKQ=;
        b=ANw59025NOHpmMQM3DLfgg1wXoYkR6klxfVuM8eODIBNXOj4/a3kz+dTt1KivvG+9J
         ZFZn/7GWvC/dLBNb+nX7Z4aJhSqmzCsGZTxLd2pJP7dXA20gOVr7xPAzQ5pbCFjFvOK+
         efbHC4ZK1Xe3UYbYoagEWY2gNKhim2qqzzs//BAsK7dA/vx+Dk9bc306Ca0uHp+wEzpo
         RFRL92ZqTk27wpMnWZ1RDZ1LY0n3I3FiuDWD3tR59TfW+vDniP4Pe9l5qAy5fJNC6/is
         iYxfBoKrHdm7xX9w5icWcAPKtoBf7lfYZpsU7f5eZDezVadIcMiob/7GaThShm0m5FfI
         JshA==
X-Gm-Message-State: AFqh2krLr+g2pKXtPepT1BcFURq3WoWsRJo2EXrmwAdZmst7WnmEPJq0
        /vcIkeIej7aI+VQoEdL/sb2dPjNM41I5+MAu
X-Google-Smtp-Source: AMrXdXvvhifH+H6ddlIYZSCk8MvBdBm1zhkgZBg/Q4kZg2UzZ5tT/EYhXXDe0Y5OciGnrAFkSQPpcw==
X-Received: by 2002:a17:907:7094:b0:844:1d1d:1fa with SMTP id yj20-20020a170907709400b008441d1d01famr68813211ejb.23.1673451281395;
        Wed, 11 Jan 2023 07:34:41 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a20-20020a17090680d400b007c4f32726c4sm6305246ejx.133.2023.01.11.07.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:34:40 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id az20so18706052ejc.1;
        Wed, 11 Jan 2023 07:34:39 -0800 (PST)
X-Received: by 2002:a17:906:49d3:b0:7c0:a321:8df2 with SMTP id
 w19-20020a17090649d300b007c0a3218df2mr6486438ejv.308.1673451279436; Wed, 11
 Jan 2023 07:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20230111152050.559334-1-yakoyoku@gmail.com>
In-Reply-To: <20230111152050.559334-1-yakoyoku@gmail.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 11 Jan 2023 10:34:03 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-hOFT34_TBD_YwUNsOjdJv_O=VAL7ojXmEqQ6ybOp8Jg@mail.gmail.com>
Message-ID: <CAEg-Je-hOFT34_TBD_YwUNsOjdJv_O=VAL7ojXmEqQ6ybOp8Jg@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Eric Curtin <ecurtin@redhat.com>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 10:21 AM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Version 1.24 of pahole has the capability to exclude compilation units
> (CUs) of specific languages [1] [2]. Rust, as of writing, is not
> currently supported by pahole and if it's used with a build that has
> BTF debugging enabled it results in malformed kernel and module
> binaries [3]. So it's better for pahole to exclude Rust CUs until
> support for it arrives.
>
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=49358dfe2aaae4e90b072332c3e324019826783f [1]
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4 [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]
>
> Co-developed-by: Eric Curtin <ecurtin@redhat.com>
> Signed-off-by: Eric Curtin <ecurtin@redhat.com>
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> ---
> V2 -> V3: Enable pahole option upon comparing with version 1.24
> V1 -> V2: Removed dependency on auto.conf
>
>  init/Kconfig            | 2 +-
>  lib/Kconfig.debug       | 9 +++++++++
>  scripts/pahole-flags.sh | 4 ++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 694f7c160c9c..360aef8d7292 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1913,7 +1913,7 @@ config RUST
>         depends on !MODVERSIONS
>         depends on !GCC_PLUGINS
>         depends on !RANDSTRUCT
> -       depends on !DEBUG_INFO_BTF
> +       depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE

Does the order matter here? I'd rather it prefer a fixed pahole and
disable BTF only if we can't use pahole properly.


>         select CONSTRUCTORS
>         help
>           Enables Rust support in the kernel.
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ea4c903c9868..d473d491e709 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -364,6 +364,15 @@ config PAHOLE_HAS_BTF_TAG
>           btf_decl_tag) or not. Currently only clang compiler implements
>           these attributes, so make the config depend on CC_IS_CLANG.
>
> +config PAHOLE_HAS_LANG_EXCLUDE
> +       def_bool PAHOLE_VERSION >= 124
> +       help
> +         Support for the --lang_exclude flag which makes pahole exclude
> +         compilation units from the supplied language. Used in Kbuild to
> +         omit Rust CUs which are not supported in version 1.24 of pahole,
> +         otherwise it would emit malformed kernel and module binaries when
> +         using DEBUG_INFO_BTF_MODULES.
> +
>  config DEBUG_INFO_BTF_MODULES
>         def_bool y
>         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 0d99ef17e4a5..1f1f1d397c39 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -19,5 +19,9 @@ fi
>  if [ "${pahole_ver}" -ge "122" ]; then
>         extra_paholeopt="${extra_paholeopt} -j"
>  fi
> +if [ "${pahole_ver}" -ge "124" ]; then
> +       # see PAHOLE_HAS_LANG_EXCLUDE
> +       extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> +fi
>
>  echo ${extra_paholeopt}
> --
> 2.39.0
>


--
真実はいつも一つ！/ Always, there's only one truth!
