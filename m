Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CFC6AE56B
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 16:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCGPxZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 10:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCGPxY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 10:53:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A333E085;
        Tue,  7 Mar 2023 07:53:19 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o12so54073307edb.9;
        Tue, 07 Mar 2023 07:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678204398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbORSBmkQrLEmoZGhwNznCeqxIz2MuR1XxIOCZR3nXQ=;
        b=LHl+IqsRYoXaT/jnjjMST41FLhNvRXYr/KW4/+7fhr8jNjCvoT1m360Cu9uXCswPLi
         Pa1CxXAhTl2ejsNLh5d+GFeJVDcFPUtpmQsAd94963HrdPhMMmfZyCSGvIj3n3hfn7YO
         Kx16FzgAvsJvmOoSi1ZuTW7o5igQXS/2914sdW4cZewKl6/mYNDaVGAhqHA5tpM9jeOQ
         LA602Td0TnhJE+yBeeIJWMBBE1/EshZN7U4kVnywQEACivmW3y2GrouU7tR84FgwUf1b
         WFi/xQJ5HHlIeI0tinlqZ+HtP/KXX5HK43GHTSs3riKxS41Xr4uUK/x61aNsdRHF9Rm1
         E1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678204398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbORSBmkQrLEmoZGhwNznCeqxIz2MuR1XxIOCZR3nXQ=;
        b=5siOF7ktzXbnn7B0E3BGjTSkBECilT9JCBujOzpq9lbEmmudfCiKZobsPn8jWARBKu
         8Zn5yv50Bf+FzrvFLSqYEhbUff7xS5g+iTSNRxswinKitsh90Hqyg279xQfoMunq5KUA
         50ZNSSlN/PbZIufTm+CeAfmgqWvt9qxYPJ93qGYv37wkTZy+aDSxrdsDiNrkC96vXwnt
         nGLVXa9WFY90aazoHOFmIAWcONVT7sBBuN56vfkgUZcmTRH+H9NLzRT8R9kctf8AqiXN
         Os2dGCUsTlDiqKM3zS9rXukkAKx3jexnq7L+J31mXnBSin5It1IMHboFK+EfESpEzCAN
         oVvQ==
X-Gm-Message-State: AO0yUKVlgjoHs6EgX8SeZbjbudBDWpYyd5LqH5Gg2QC9Qfj+hDgiy+rS
        ap90OjZB5YJYUku4NNFSC7IbB+BpTOBZqyi65Dc=
X-Google-Smtp-Source: AK7set99z92G0FN+SKgWFgDLiv0SyLbzEnnFyaKA6fumwU4j834OdcY2abcOQ2uUeaELFijo76SjrETugT6WReZO6cg=
X-Received: by 2002:a17:906:5910:b0:8b1:78b8:4207 with SMTP id
 h16-20020a170906591000b008b178b84207mr7407686ejq.3.1678204398010; Tue, 07 Mar
 2023 07:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191f3a6@kernel.org>
In-Reply-To: <20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191f3a6@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 7 Mar 2023 07:53:06 -0800
Message-ID: <CAADnVQ+UOoDXYKyrw0FoSajeVOXO+2LAFv9Ouu5VPtMeF6vVuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Increase size of BTF_ID_LIST without
 CONFIG_DEBUG_INFO_BTF again
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>, patches@lists.linux.dev
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

On Tue, Mar 7, 2023 at 7:14=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> After commit 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and
> bpf_dynptr_slice_rdwr"), clang builds without CONFIG_DEBUG_INFO_BTF

please don't break commit subj into multiple lines.
I've fixed it manually this time while applying.

> warn:
>
>   kernel/bpf/verifier.c:10298:24: warning: array index 16 is past the end=
 of the array (that has type 'u32[16]' (aka 'unsigned int[16]')) [-Warray-b=
ounds]
>                                      meta.func_id =3D=3D special_kfunc_li=
st[KF_bpf_dynptr_slice_rdwr]) {
>                                                      ^                  ~=
~~~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/verifier.c:9150:1: note: array 'special_kfunc_list' declared=
 here
>   BTF_ID_LIST(special_kfunc_list)
>   ^
>   include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
>   #define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
>                             ^
>   1 warning generated.
>
> A warning of this nature was previously addressed by
> commit beb3d47d1d3d ("bpf: Fix a BTF_ID_LIST bug with
> CONFIG_DEBUG_INFO_BTF not set") but there have been new kfuncs added

and here.

> since then.
>
> Quadruple the size of the CONFIG_DEBUG_INFO_BTF=3Dn definition so that
> this problem is unlikely to show up for some time.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1810
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  include/linux/btf_ids.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 3a4f7cd882ca..00950cc03bff 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
>
>  #else
>
> -#define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
> +#define BTF_ID_LIST(name) static u32 __maybe_unused name[64];
>  #define BTF_ID(prefix, name)
>  #define BTF_ID_FLAGS(prefix, name, ...)
>  #define BTF_ID_UNUSED
>
> ---
> base-commit: 36e5e391a25af28dc1f4586f95d577b38ff4ed72
> change-id: 20230307-bpf-kfuncs-warray-bounds-c2040e8ee7ee
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
