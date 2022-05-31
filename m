Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BEE539A36
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 01:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiEaXum (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 19:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbiEaXuj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 19:50:39 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D829CF7C
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:50:39 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id q14so33879vsr.12
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ea0J7hW3PIvhrBKtpgP+gK0p5uIj4bTIowF770pNVpg=;
        b=g1FfMvxxKrMbtBog/PdwnjbrU/h8xkaH+fMDqkvs5mve3IiThTS1MvgYCQiyzcggNZ
         /ez+NIcF+17iaHq+xkDaxyF/prhvRTr3ktgVRGCLZjTsMIt5IlYzgjVQLFsLp58mkAip
         rwaRxo04M8NiLj5i9znnc9b6GBE+UYemrNutryKL3eJuxUCS1fxIgikTDqezI9Bauh6I
         If2IpBIOJt9jbz67hVyzXwPXPdl5HDPpfuOT8gBaed2RM/wDCKJglmJGo/tQqneypHWp
         YD1Ht8EetCeBD5LxST0HRKuNaLjUsyNfLCLzhKyAGhR1XlMsGQIdXb+M9pb8jQU0tv+g
         dFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ea0J7hW3PIvhrBKtpgP+gK0p5uIj4bTIowF770pNVpg=;
        b=r+yiDgSeATQ1nTjYx7coaQbYE/gApnrH0U67H3Nkh0VHL3iJ2hGkfG+QVdC5Uplkhn
         eAyk/rn0hbFyYw4dGC4FhgI7n29A1tahuwUgaolORqMUNk+yXgBR8ZMZzbjFtitMoIFz
         82U1LVyPpudWzCPG1plYdH/01nfI/CAQAZaSNAGNMv0sFQQsLhcoRbohWE2Z3lCCNL3M
         ZvItuYaKVTy7fU8huuKcYTaJqbMcKThcaTfuBgTdNCRI25kSn9mCj48Yew+MMist1bDs
         dgU9345P+gAt5BpQMtWxDD86DrIQ1jDN0M5ihw/hv111V0XTpm1lRebConJzSL8TKaG+
         M4KQ==
X-Gm-Message-State: AOAM531dixYzdrHm0bvplwrhKITyDdNEDWsYSuF3k0QM3zVHto2iTWJQ
        WT2FM+8YbdlmNjerA+u0fEjUFbS7WxOUDweAsNE=
X-Google-Smtp-Source: ABdhPJwTcIdlRchsVE6Q0g1mQxf2nyXBfwfVEnsruiP77eTkiUUS4V0Y6FB1Fg5g/YNAimuTLBsTcP+AljB9D26xF2Y=
X-Received: by 2002:a67:f745:0:b0:335:e652:c692 with SMTP id
 w5-20020a67f745000000b00335e652c692mr24338602vso.52.1654041038208; Tue, 31
 May 2022 16:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220526185432.2545879-1-yhs@fb.com> <20220526185503.2548083-1-yhs@fb.com>
In-Reply-To: <20220526185503.2548083-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 May 2022 16:50:25 -0700
Message-ID: <CAEf4BzaCiYvsfBLAqFKnciiL5QKKVqZp8enRbZTUUUekygCHUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/18] libbpf: Add enum64 deduplication support
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
> Add enum64 deduplication support. BTF_KIND_ENUM64 handling
> is very similar to BTF_KIND_ENUM.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.c | 62 +++++++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.h |  5 ++++
>  2 files changed, 65 insertions(+), 2 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index a41463bf9060..b22c648c69ff 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -531,6 +531,11 @@ static inline bool btf_is_type_tag(const struct btf_type *t)
>         return btf_kind(t) == BTF_KIND_TYPE_TAG;
>  }
>
> +static inline bool btf_type_is_any_enum(const struct btf_type *t)

btf_is_any_enum() for consistency with all other helpers?

The rest looks great!

> +{
> +       return btf_is_enum(t) || btf_is_enum64(t);
> +}
> +
>  static inline __u8 btf_int_encoding(const struct btf_type *t)
>  {
>         return BTF_INT_ENCODING(*(__u32 *)(t + 1));
> --
> 2.30.2
>
