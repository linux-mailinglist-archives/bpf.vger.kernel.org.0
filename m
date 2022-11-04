Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89E61A56E
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKDXL1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiKDXLZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86F545097;
        Fri,  4 Nov 2022 16:11:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x2so9722402edd.2;
        Fri, 04 Nov 2022 16:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=07hdorLZjfDrmmF0RIbb3F6VZW1gi/vfnv07L0QVxCY=;
        b=WGnqy424lfhHz+aAINFGSq6ODp0Gxck7vR2Ozdh6FTng/CdZ3be+yNRvZcLesqvChY
         sJ/uivYjdfggdG/gPt3ivWw/YFAINSigm6FeXoLG6YmjT6hHadCiw+NXcijVYdamn6Qn
         R5+qfhwsI5mTWdCLGvJQIKjXX0iluZUYNeEziVDeI+/eT0YWV8xb7RYQljPf5OX276rI
         B+vRvHIolq9eTv7wmT3LP1Hr7FLqFLRiGWtY/74ZP1se7mZIXPMnEC7mVT0FYcVrY5Mw
         Elh6j9HuiXqWVfGVAvobSAMV6E6CoHoNIuULwItXm97lqWgMgkRVcNB7S3YE6WV6OXvz
         DEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07hdorLZjfDrmmF0RIbb3F6VZW1gi/vfnv07L0QVxCY=;
        b=bn7O+VzuLQ88rKt5KhbclRxYRAoIRlwxYhsKUXYPnfOtzqgCLXLdN5vrMLZ/AtXiLb
         sagbnQKZ6WW9r6t8OMqpespcayteCCgbD2g+2y/O8MEt0rB9W8InaVxc1wMMgi5o4rL2
         tC996GkHcLAmLfuDrYQKi4fFwpQ8BiT6knOxW5FM85TxDLvyMtXnR0mvMtJcEfIKDYKE
         SygFcrtTmVKc/jxmZrOAmo97neDyG9vUoI5qS41Vnpc4EIIJnPM8TRysgA30y6pW6B6d
         rcEkLTnAVjHi0k2SDA87GBw048huFwqF4a6EnvekbZgE7DAOEc8+YfBH3Vl/cDYn81Il
         d+AQ==
X-Gm-Message-State: ACrzQf1WX1o9KDCU6wJdbkaRmfF9lkE8BUWDOZSZRYSV5ATgn5g21vQZ
        tkgNNcHpXS4Al0uvc0Or5/z+tDx2eu8hVpHiVvA=
X-Google-Smtp-Source: AMsMyM5tCCKtcvEZQVkGHI7Qpz8ptEcCXCTV7R+VBHSElTu5gB69+R6ssVG1t04JvlRDGUBKK212FD7pLPLa1DW/tW0=
X-Received: by 2002:aa7:c2ca:0:b0:461:89a6:2281 with SMTP id
 m10-20020aa7c2ca000000b0046189a62281mr39520308edp.260.1667603482360; Fri, 04
 Nov 2022 16:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221104123913.50610-1-bagasdotme@gmail.com>
In-Reply-To: <20221104123913.50610-1-bagasdotme@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 16:11:10 -0700
Message-ID: <CAEf4Bzau0QuBiNsXoMq_QRV+_MTyodQsvW7O2kbScgmVmbuXkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Documentation: bpf: escape underscore in BPF
 type name prefix
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 4, 2022 at 5:39 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Sphinx reported unknown target warning:
>
> Documentation/bpf/bpf_design_QA.rst:329: WARNING: Unknown target name: "bpf".
>
> The warning is caused by BPF type name prefix ("bpf_") which is written
> without escaping the trailing underscore.
>
> Escape the underscore to fix the warning. While at it, wrap the
> containing paragraph in less than 80 characters.
>
> Fixes: 9805af8d8a5b17 ("bpf: Document UAPI details for special BPF types")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/bpf/bpf_design_QA.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Applied, thanks. But would the other similar case be problematic?

$ rg 'bpf_\b'
bpf_design_QA.rst
329:NOTE: BPF subsystem specially reserves the 'bpf_' prefix for type names, in
331:avoid defining types with 'bpf_' prefix to not be broken in future
releases. In
333:with 'bpf_' prefix.

libbpf/libbpf_naming_convention.rst
12:following prefixes: ``bpf_``, ``btf_``, ``libbpf_``, ``btf_dump_``,
59:described above should have ``libbpf_`` prefix, e.g.


> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
> index 4e4af398607b58..17e774d96c5e4b 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst
> @@ -326,11 +326,11 @@ size, type, and alignment, or any other user visible API or ABI detail across
>  kernel releases. The users must adapt their BPF programs to the new changes and
>  update them to make sure their programs continue to work correctly.
>
> -NOTE: BPF subsystem specially reserves the 'bpf_' prefix for type names, in
> +NOTE: BPF subsystem specially reserves the 'bpf\_' prefix for type names, in
>  order to introduce more special fields in the future. Hence, user programs must
> -avoid defining types with 'bpf_' prefix to not be broken in future releases. In
> -other words, no backwards compatibility is guaranteed if one using a type in BTF
> -with 'bpf_' prefix.
> +avoid defining types with 'bpf\_' prefix to not be broken in future releases.
> +In other words, no backwards compatibility is guaranteed if one using a type
> +in BTF with 'bpf\_' prefix.
>
>  Q: What is the compatibility story for special BPF types in local kptrs?
>  ------------------------------------------------------------------------
>
> base-commit: f71b2f64177a199d5b1d2047e155d45fd98f564a
> --
> An old man doll... just what I always wanted! - Clara
>
