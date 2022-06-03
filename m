Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8C53D2CA
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 22:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347308AbiFCUYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 16:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbiFCUYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 16:24:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB52643ED1
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 13:24:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j10so14266388lfe.12
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qM7bCJYhzq0l3pgaLwDADlstMYTVzqGxQwjlJkQSm8=;
        b=cwRyAm+XVh7kHbnIgAa97juKWAL0K/7Ge/KarrQWAaRKn+ocopzMDsJ9M27YlB3SpL
         BcdH+wRU5VMw4UNI2WUH0PE9DD+piM1W6LYj8aCwLRNDF+BhjRB4BLKJC5wm7L9wddQ9
         8tlS6O5IN/M88XzmGyjXSnJM5oYMdPewvktopa22icWGvwcfUF1ig+oXJlT77Shng4Kg
         34HZQ/8QAnORh6fpAyaEp/PcGfwhKrKpFp5fNQTFkjUdLWwYLgzqNtSoKxnneTTGv7Zo
         DHk/r05vDVXNNGosFHGFo6WAZjzzlaMcKg6aKsf/Nz9aUyj6+fiYzL9aC0K1URcHbcnw
         KLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qM7bCJYhzq0l3pgaLwDADlstMYTVzqGxQwjlJkQSm8=;
        b=Y8OR8Kqs/y2AJ4iG899KMeY3UzDM2u+8FIr888GbnZXiNIx9z5QkZuqgN7TqDPHLvO
         PUfA0ZBU4/90uBpXW0km/SWHaA7ZLVePUgk7tWs0f8u+M9x2I8BfGBKqtGLgoVpQ2zhd
         PWYS/9B/opwMy79SocaIn/yMCgbja8uuSa7jGlbhM/s4CeTYwsEdrbsiidKtRQFJW9LX
         N1oS2bxqFJjrBZ9jMoPCHy5Q7HfEU9lEUCa9cojaUIoCX4dqLX8HXR6RNlTc80cOMnM5
         KjPfWH8q/VYcvUi9HNVt/EmfSjEtHputxhsMEa4smLlsfoFV6WaJC/ieoyW9YHMEApHC
         LdWA==
X-Gm-Message-State: AOAM530G2VqaTayW87eErwW+0R3AKQTZCAenXGo3rltTB6DKtFi9t/Rh
        yTdfi5/VXWfJGeVPjpedkjZCmLMYjhuw+Nx+ow4=
X-Google-Smtp-Source: ABdhPJwF3PNj5ck2i/+ZXEXbgGIJ4u1ZuuyjizRzTcXFoIvmfY6wHr90T7jWXQio2ZnvRvUJR7DoBWE427YXmGO+gdY=
X-Received: by 2002:a05:6512:b2a:b0:479:12f5:91ba with SMTP id
 w42-20020a0565120b2a00b0047912f591bamr5622413lfu.443.1654287881318; Fri, 03
 Jun 2022 13:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220603015855.1187538-1-yhs@fb.com> <20220603020019.1193442-1-yhs@fb.com>
 <CAADnVQJgH6X66Rg0Z5v8pTsnfZBsHeaEko6rYv=ON6RQ+2FVPA@mail.gmail.com> <CAEf4BzY3Xyc68Be64O36EXFwYeXho0U0ExGuPwEc-F_Bok4DHg@mail.gmail.com>
In-Reply-To: <CAEf4BzY3Xyc68Be64O36EXFwYeXho0U0ExGuPwEc-F_Bok4DHg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Jun 2022 13:24:29 -0700
Message-ID: <CAEf4BzZHCN6yHQNy1x7Wq=mvKBp6XBjtJXArKTxjQPBX=3kVCQ@mail.gmail.com>
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

On Fri, Jun 3, 2022 at 1:22 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 3, 2022 at 8:14 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jun 3, 2022 at 4:00 AM Yonghong Song <yhs@fb.com> wrote:
> > > +
> > > +SEC("raw_tracepoint/sys_enter")
> > > +int test_core_enum64val(void *ctx)
> > > +{
> > > +#if __has_builtin(__builtin_preserve_enum_value)
> > > +       struct core_reloc_enum64val_output *out = (void *)&data.out;
> > > +       enum named_unsigned_enum64 named_unsigned = 0;
> > > +       enum named_signed_enum64 named_signed = 0;
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
> Hm... doesn't seem so. I pulled Yonghong's patches locally, built the
> very latest Clang, rebuilt selftests from scratch and I get the same
> error.
>
> Yonghong, do you get the same error in your setup? If not, what am I
> missing in mine?

and confirming that Clang doesn't generate ENUM64:


$ tools/build/bpftool/bootstrap/bpftool btf dump file
btf__core_reloc_enum64val___diff.o
[1] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[2] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
        'x' type_id=1
[3] FUNC 'preserce_ptr_sz_fn' type_id=2 linkage=global
[4] STRUCT 'core_reloc_enum64val___diff' size=16 vlen=2
        'f1' type_id=5 bits_offset=0
        'f2' type_id=6 bits_offset=64
[5] ENUM 'named_unsigned_enum64___diff' encoding=UNSIGNED size=8 vlen=3
        'UNSIGNED_ENUM64_VAL1___diff' val=4294967295
        'UNSIGNED_ENUM64_VAL2___diff' val=4294967295
        'UNSIGNED_ENUM64_VAL3___diff' val=4294967295
[6] ENUM 'named_signed_enum64___diff' encoding=UNSIGNED size=4 vlen=3
        'SIGNED_ENUM64_VAL1___diff' val=4294967195
        'SIGNED_ENUM64_VAL2___diff' val=4294967094
        'SIGNED_ENUM64_VAL3___diff' val=4294966993
[7] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
        'x' type_id=4
[8] FUNC 'f' type_id=7 linkage=global


>
>
> > CI will pick up newer clang sooner or later,
> > but the users will be confused.
> > The patch 17/18 that updates README certainly helps,
> > but I was wondering whether we can do a similar trick
> > to what Andrii did in libbpf and make the error more human readable?
