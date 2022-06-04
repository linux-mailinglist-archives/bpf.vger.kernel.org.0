Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D981653D646
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 11:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiFDJew (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jun 2022 05:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiFDJev (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jun 2022 05:34:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0493F5007D
        for <bpf@vger.kernel.org>; Sat,  4 Jun 2022 02:34:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o10so12942119edi.1
        for <bpf@vger.kernel.org>; Sat, 04 Jun 2022 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dJpa1t9xEVh84iLXqhmSr0eTd2LkEIVgZpVw7qWhSY=;
        b=SMtZIZJtjIIluboxh5NYEl4/2RusJN+dTFmnRbU1ywEopGj7IoJ7aLIKSEYZu/X8cb
         eoPlhH+J7Yj6Q7tkm9KmsXrR1pfK70lW2fpUqxHobDL3H1DePD4pJHFbjwwwHyaFH6kO
         ZdDxZDUX5r5NKLXP6cw0EZzHrzJQp2Yk5v3Ij04BDXUyDadaN9uwPsz+EVxDQGRN5jUN
         uViOibzLTaONfbkvDPgxpbcNlg+euk1cVKG0NJFLrClTwNIEc5hT3M0QhdKuUo6C2S4b
         2PSXe/ZMaUFkxqK/84CQZIAs05hhGs7BliMSZPEwzILFXGNYwjFc2DlRZ5NE+2INiuRm
         jF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dJpa1t9xEVh84iLXqhmSr0eTd2LkEIVgZpVw7qWhSY=;
        b=dLRJYxCk8zfWkS1w17STb1x3OQ9sfPfUVzjeMRzCsHxFbqPzyGXz8LveGQr5cuvt7C
         oCuz4NPGKnanYKCtsPas+alBWkJI2guvgtBVJ4vKnjowbDb6pGxSTffQE2uA5HdPgvYI
         CPewiZx/tbxrOxcDSc8rX04wHAhEgkrY3LTqKICC+c8mZw0N1c+hdhnZDh1fv6m54g2P
         4u+bKIA7h/buJUsTwHySKrtCMRr9yRbeNuXv7uLAmPJtfLpdK1FFoAfFoH/jnds0+GYF
         Ck3t1OHVAQtZVZOxLF2e0cv7eTeHgQCiQHsJIrvEjr4xrWCm25exErlqIVIT/sKLLT0t
         qGEQ==
X-Gm-Message-State: AOAM532//4hlWMAKu/EFthekmpq7M2UlJAhmWZ/Ng2IFU9wT/oJ2c9Rb
        riNDGGE3UQbNO6VUeKACzXEGIkb5MX1C7qMjDqkSbWQYfl4=
X-Google-Smtp-Source: ABdhPJyTyNaV/bUgWvx1VNHhzK6dpYoZd3fKm7yb5wtBVJhDtCZ0mMnjKCD/NPU1GdrQUE29vq2y8hkFaaJ3Lb6BkoA=
X-Received: by 2002:a05:6402:3490:b0:42f:b592:f364 with SMTP id
 v16-20020a056402349000b0042fb592f364mr3791110edc.66.1654335287502; Sat, 04
 Jun 2022 02:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220603015855.1187538-1-yhs@fb.com> <20220603020019.1193442-1-yhs@fb.com>
 <CAADnVQJgH6X66Rg0Z5v8pTsnfZBsHeaEko6rYv=ON6RQ+2FVPA@mail.gmail.com> <dfbe2c95-b6d7-1e26-4c3d-9ae7513235d0@fb.com>
In-Reply-To: <dfbe2c95-b6d7-1e26-4c3d-9ae7513235d0@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 4 Jun 2022 11:34:34 +0200
Message-ID: <CAADnVQKxkY2+guT8BD4+3JQarJ+iwHiegLiD9bMAT=MAaMw9OA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 16/18] selftests/bpf: Add a test for enum64
 value relocations
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

On Sat, Jun 4, 2022 at 4:51 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 6/3/22 8:14 AM, Alexei Starovoitov wrote:
> > On Fri, Jun 3, 2022 at 4:00 AM Yonghong Song <yhs@fb.com> wrote:
> >> +
> >> +SEC("raw_tracepoint/sys_enter")
> >> +int test_core_enum64val(void *ctx)
> >> +{
> >> +#if __has_builtin(__builtin_preserve_enum_value)
> >> +       struct core_reloc_enum64val_output *out = (void *)&data.out;
> >> +       enum named_unsigned_enum64 named_unsigned = 0;
> >> +       enum named_signed_enum64 named_signed = 0;
> >
> > libbpf: prog 'test_core_enum64val': relo #0: unexpected insn #0
> > (LDIMM64) value: got 8589934591, exp 18446744073709551615 ->
> > 18446744073709551615
> > libbpf: prog 'test_core_enum64val': relo #0: failed to patch insn #0: -22
> > libbpf: failed to perform CO-RE relocations: -22
> > libbpf: failed to load object 'test_core_reloc_enum64val.o'
> >
> > Is it failing in CI because clang is too old?
>
> Yes, the failure is due to that the llvm patch to support enum64
> is not merged. The llvm patch is not merged because otherwise
> people using latest compiler (with llvm patch) may fail to
> latest libbpf.
>
> > CI will pick up newer clang sooner or later,
> > but the users will be confused.
> > The patch 17/18 that updates README certainly helps,
> > but I was wondering whether we can do a similar trick
> > to what Andrii did in libbpf and make the error more human readable?
>
> I think the above information is what current libbpf did for
> relocation errors.
>
> Unless I missed something, Andrii's commit 9fdc4273b8da ("libbpf: Fix up
> verifier log for unguarded failed CO-RE relos") is to improve kernel
> verifier log w.r.t. relocation failures.

Right. I was referring to the spirit of that commit.
libbpf can probably print more user friendly message and point out
that enum64 is potentially missing in the clang?
