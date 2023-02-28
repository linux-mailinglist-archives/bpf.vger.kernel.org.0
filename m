Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAC6A52A5
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 06:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjB1F2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 00:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjB1F2d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 00:28:33 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34CEB
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 21:28:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s26so35002299edw.11
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 21:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9pCEqz9Mk89/ubh7qAYx/yENPy3qYGaMmU6TMK+Z6Q=;
        b=MEXxKZ92zxKuEj7Qjydj7AAmCI3ajTKd4vPv5I2IV4PUy691JhMFJnDAj5+RPCyr2d
         Gzf9r4ASHX35+63iJ0zsuOeTfZoqO5GCZf5DZksA8qz8Y0p1s4Pk4Pt4AE2bm6aSDv54
         lirSivP5h/+iSnBYh3OLSXOJ5HnuKDceYtmhacwmR7atEFMrHeNI9n0rykxxWNqSUXnR
         4dPbS9uIrnAOAKqo+yDBZGFU+b9tPeYBTH+SdkWuZiwM4FHTelQ/DFqPTM9fA1fRGJ1A
         uCPolHl/hoDgYNev1ge8O3Gj3WmgT+Y6g+L+OhtvQUAy1X63Y9hscjjydYOvDt5DPjqB
         jSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9pCEqz9Mk89/ubh7qAYx/yENPy3qYGaMmU6TMK+Z6Q=;
        b=UjUxXBTwdAUvaIYlIj/dia6iDaj6fH/Daxumlny5XsUaW64Fe7O7RT9rPwWeFzekW4
         fgE378innELSCk4SopYWu6tW9xW2A9zc+dxGCXXpmCgBG8Z3IJjPtYPNbOW4ecIGvosL
         ASZR/Q9h7b3Ey390K6QUEh4Q9n5Fpdi2ptcV0YKAVEhKV53RYhQhbdPzXN1P7cz0pdgW
         hPDMX/1tbpw6oFBUkFgCwmyS7u21zWMi88j+e5CVoMW1QaZr+falcDgS4C96Wexm0gdP
         qGh26Uv0O0h7kjzH6qja21aMXYHSKfcvUOFCaHYpmRYX/IfdVwWoax3A04/yRBUDsi1A
         dfnA==
X-Gm-Message-State: AO0yUKVY3QVt14j2PyAfbddHq2NizwTN6FzrRdv0PNJD/xvujc/SrPwX
        w75QcHDYl9S51yiOG5BgPc+zfaycx6bhalWLRj4RG3KRWEk=
X-Google-Smtp-Source: AK7set+z43sDBV343C4IiLmQt4TdUUB/PYW7ZjoQMpN80wKU03Dhyq52iLK3cXTKF5sYkxgdnbdvVHkrRP9moIjX0T4=
X-Received: by 2002:a17:906:4ad5:b0:8e5:411d:4d09 with SMTP id
 u21-20020a1709064ad500b008e5411d4d09mr608413ejt.15.1677562110023; Mon, 27 Feb
 2023 21:28:30 -0800 (PST)
MIME-Version: 1.0
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
 <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com> <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
 <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com> <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
 <d6f9fe3faa4aef62227420fc41f2e896f4d7eb2a.camel@gmail.com>
 <CAEf4BzZUySu10OnsdoyTVXYS_2Ggn2i5KA177RA=v75oquq9TQ@mail.gmail.com>
 <199e5475333f49eeebfee6e34571638e4dd9d737.camel@gmail.com>
 <CAEf4BzbGA=wSeoPpg+mKp-nh7qRPb6Bp+DfWgvSaWtPaWC7+nA@mail.gmail.com>
 <a6e526ec1408ec4c833b19f8d482ace57dc30c11.camel@gmail.com> <CAADnVQLrvEzabkJjerAwdOgbnA=ERYinYqboN2--jqaeDm4Ygg@mail.gmail.com>
In-Reply-To: <CAADnVQLrvEzabkJjerAwdOgbnA=ERYinYqboN2--jqaeDm4Ygg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 21:28:17 -0800
Message-ID: <CAEf4Bza-GGjpDbUHtoVto+P9hWi7TFf1-SPqdLm4SiBSXFbONw@mail.gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
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

On Mon, Feb 27, 2023 at 6:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 27, 2023 at 4:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > I still think that presence of a literal string "bty_type_tag" might
> > make some grepping easier but whatever. If there are no further
> > objections I'll post the changes using "btf:type_tag" literal tomorrow.
> > Andrii, thanks for the input.
>
> I don't think there is precedent for using ':' inside DW_AT_name.

I don't think there are any restrictions on string pointed to be
DW_AT_name. It is used when describing source code location (so
definitely has '/' on Linux, and ":/" on Windows). But I just checked
Rust-emitted DWARF:

0x0002825e:   DW_TAG_pointer_type
                DW_AT_type      (0x00026fc9
"core::option::Option<alloc::string::String>")
                DW_AT_name      ("*const
core::option::Option<alloc::string::String>")
                DW_AT_address_class     (0x00000000)

So I'm not too bothered about this. After all, it's just a string.

But `btf:<something>` allows us to generalize this to other
annotations, e.g., we can have "msan:initialized" or something, and it
will be done in C using some generic __attribute__((annotate("msan",
"initialized"))).

> Can we actually use the same "btf_type_tag" name?
> Aren't we gonna use a different container than DW_TAG_LLVM_annotation ?

I think that was the point to reuse existing DW_TAG_LLVM_annotation
(and I assume from GCC's side it would be called
DW_TAG_GNU_annotation, but it will use the same ID, so effectively we
might as well call it just DW_TAG_annotation), so using "btf_type_tag"
becomes ambiguous.

>
> Since we're picking a standard across gcc and llvm it will be
> some common DW_TAG_... with the same number, no ?
> I forgot what we agreed on during office hours.
