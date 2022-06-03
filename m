Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59D953D2C2
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 22:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiFCUWi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 16:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiFCUWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 16:22:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080E43AE4
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 13:22:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so8184274lfg.5
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 13:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3bA4yL0NJpInWz7xJtqcVHSp7+2UptmviV08quXtLU=;
        b=EDY2nPMrHX5MksK/Fo2XBxVkauGOZRUCfJkwxFBk+FXxretFB1twhYqSxNNx7gBlvL
         BC7vhOwNPyg4ze4lqezqXpRtUqTJqdjRo7x1bg15iW6QLHUPf6jS9ZkerQfC0abxEwxi
         n8SymZYQwcBOOSFMgn6IEEoqA3oKbopUXKDUwKlW8RfuLbeNBZYs4Kf95wC3A8+2zmVu
         PEczUugOzOAWOlqYlSkJ9uWetqFk7rWTMagV/kPXei9GZXIVQBRNQwyVHmIuCOdzy9XK
         LrU1EBIKpx05GCxyUr/64Vz3ngoolV0AXV+NRsKOg3uF3WML2JTzRQ4pvTcENm2276+k
         WKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3bA4yL0NJpInWz7xJtqcVHSp7+2UptmviV08quXtLU=;
        b=v2fx35TInWvCfDPUfrNc+BjuQA/3xwBd3OHJJuZQL/efYc32BSVguItP4hRC/wji88
         7YQ8XsujkkjZY9wjTBkj+zYmOatyz7imkZe+6BDlviJ7IBDaHMVvpJC6uUiITJDTRWqo
         j0WDkhk/dHRQFDwbcQhppsTBqi1Bs9DlQ0kWkj93fNMGRQmRz1S9F2E/6vC33kmOwLsD
         GO14Pg9h5xkN5jNiyo0tugzsnV1xubBOenekL7Qosd/lUQtFpUg28Ve3PbvDlVPgs+Bq
         1p4mQdUSt1EKdTKhhWhKPs8nKdlkY22OLIrA4a3jEMwCPu+V8388x/1HkIjRwEy3kDuL
         gzFg==
X-Gm-Message-State: AOAM5323okO1NjYZnfkxfLuwNtfb1fObNFn640iSOH46E0LEppJTGGgy
        9Z7nkSSwNJtNpIpDiAQneXJwmLLsLj6219XQVUoF9kIM
X-Google-Smtp-Source: ABdhPJy3JkxVFE8HUEyZUIIgWRrO8nPaTJGFm+VrXi5TDmNLAW8QqCHOvcyWFyRnPTniuYwGjoMmn5niz01PSpc68Ug=
X-Received: by 2002:a05:6512:2625:b0:478:5a51:7fe3 with SMTP id
 bt37-20020a056512262500b004785a517fe3mr7622668lfb.158.1654287753889; Fri, 03
 Jun 2022 13:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220603015855.1187538-1-yhs@fb.com> <20220603020019.1193442-1-yhs@fb.com>
 <CAADnVQJgH6X66Rg0Z5v8pTsnfZBsHeaEko6rYv=ON6RQ+2FVPA@mail.gmail.com>
In-Reply-To: <CAADnVQJgH6X66Rg0Z5v8pTsnfZBsHeaEko6rYv=ON6RQ+2FVPA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Jun 2022 13:22:22 -0700
Message-ID: <CAEf4BzY3Xyc68Be64O36EXFwYeXho0U0ExGuPwEc-F_Bok4DHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 16/18] selftests/bpf: Add a test for enum64
 value relocations
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Fri, Jun 3, 2022 at 8:14 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 3, 2022 at 4:00 AM Yonghong Song <yhs@fb.com> wrote:
> > +
> > +SEC("raw_tracepoint/sys_enter")
> > +int test_core_enum64val(void *ctx)
> > +{
> > +#if __has_builtin(__builtin_preserve_enum_value)
> > +       struct core_reloc_enum64val_output *out = (void *)&data.out;
> > +       enum named_unsigned_enum64 named_unsigned = 0;
> > +       enum named_signed_enum64 named_signed = 0;
>
> libbpf: prog 'test_core_enum64val': relo #0: unexpected insn #0
> (LDIMM64) value: got 8589934591, exp 18446744073709551615 ->
> 18446744073709551615
> libbpf: prog 'test_core_enum64val': relo #0: failed to patch insn #0: -22
> libbpf: failed to perform CO-RE relocations: -22
> libbpf: failed to load object 'test_core_reloc_enum64val.o'
>
> Is it failing in CI because clang is too old?

Hm... doesn't seem so. I pulled Yonghong's patches locally, built the
very latest Clang, rebuilt selftests from scratch and I get the same
error.

Yonghong, do you get the same error in your setup? If not, what am I
missing in mine?


> CI will pick up newer clang sooner or later,
> but the users will be confused.
> The patch 17/18 that updates README certainly helps,
> but I was wondering whether we can do a similar trick
> to what Andrii did in libbpf and make the error more human readable?
