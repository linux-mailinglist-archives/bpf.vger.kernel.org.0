Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75576CCE08
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 01:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC1XbS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 19:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC1XbP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 19:31:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA4130E8
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:31:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t10so56176216edd.12
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680046273; x=1682638273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXmwc8t7ikSkf6ahxjLbISqioESLK/kYDUK1ZXp3QJM=;
        b=YMg0+knSFT9Vf3RayOE8hLNfmpuOfmEw2qYQq+fHxpLhe6QRJtiK0wbTYdHHgUhjiH
         v/USw2/a9rCUz1Ujm4VLJTJoFQNipw74Vf/9r3EP9FI0l7YkpczpGoU6I4X+ns+DmOT2
         zWKjHQGp0xWdoikbe/P/E6pgRs73JeaI/znH08SAPrCqoGzdXtjkcGmZzMCiIS+jrC4W
         asAVzmwel8Dfz76aj5weDSEWlT4WZyn3z9A9NNytw4srcUiJvICTWHA7aYgVQS9SeMpa
         JU4bPQUZKpA5TMkPZ7YDVuqywZLb81kKtufmoDGdF8IaoLr9+Ig29S/dr4L7Umsro4yY
         uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680046273; x=1682638273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXmwc8t7ikSkf6ahxjLbISqioESLK/kYDUK1ZXp3QJM=;
        b=YFxt7PnxSpkimKd0mZ57lwfnNS2VcA2xgJZN4+TYaxW1mBgzmIvzMjqWgD3HtcXvpy
         IiHEFLU+mlrx9jO2dZvj/QHEp1M8bgomqdBnq1ZRn1T7x57qLhDEgy7DOC+egunXkwUf
         ErY/2hQAwPgS6R8+P7y0w/xxEKOM64LOu4NXuNdlM4ahYUG8CJ/Y50+OIZiQ0p7+H+fe
         sNbQ737jdJ6T3Tju6+wErWdVHZZteIXls2zeiX8R3U6bwBg9fQ82sntl5Z6BiB8v5s/G
         JKQgtkEiGr/tQX63evH0wE0u5f6K3/IceQYU+WWS7mfbxVx0lK8TTNdBPMIl/5AC1+82
         xFOA==
X-Gm-Message-State: AAQBX9c3N/HAi6Ns9Uu7JTSHtRDlArvOaUy1b/BZ0CnSIcKh7CgYv7at
        SADUv68MGt4TQm053lj/4e6r0dh4tgMlpk1VdZI=
X-Google-Smtp-Source: AKy350Y/MrP0Jenrp5rKkQTs8mbLRVSRltN11I1dGIgSAg5nC94lAilGivpvK4sILOSVVOdp3McBEhcN0L06jF2z6e8=
X-Received: by 2002:a17:907:7f19:b0:926:8f9:735d with SMTP id
 qf25-20020a1709077f1900b0092608f9735dmr9533859ejc.3.1680046272695; Tue, 28
 Mar 2023 16:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <359ea18b-5996-afea-b81e-32f13f134852@iogearbox.net>
 <b69f211724dd9d1acdb896ca1b97109065ab28b0.camel@gmail.com>
 <CAEf4BzZtC88nCXvBBdd-6dox1rDMfwqKZBY2CtON05fi0fGzFQ@mail.gmail.com> <bd3389fcad0dc8555ed3cf42b69f717cbea380b6.camel@gmail.com>
In-Reply-To: <bd3389fcad0dc8555ed3cf42b69f717cbea380b6.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 28 Mar 2023 16:31:01 -0700
Message-ID: <CAADnVQK6XVzNmjbY9wO4tve_93je7zvGUHHVX3EsYQpo4CFGiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 3:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-03-28 at 15:24 -0700, Andrii Nakryiko wrote:
> [...]
> >
> > > # Simplistic tests (14 files)
> > >
> > > Some tests are just simplistic and it is not clear if moving those to=
 inline
> > > assembly really makes sense, for example, here is `basic_call.c`:
> > >
> > >     {
> > >         "invalid call insn1",
> > >         .insns =3D {
> > >         BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, 0, 0, 0, 0),
> > >         BPF_EXIT_INSN(),
> > >         },
> > >         .errstr =3D "unknown opcode 8d",
> > >         .result =3D REJECT,
> > >     },
> > >
> >
> > For tests like this we can have a simple ELF parser/loader that
> > doesn't use bpf_object__open() functionality. It's not too hard to
> > just find all the FUNC ELF symbols and fetch corresponding raw
> > instructions. Assumption here is that we can take those assembly
> > instructions as is, of course. If there are some map references and
> > such, this won't work.
>
> Custom elf parser/loader is interesting.
> However, also consider how such tests look in assembly:
>
>     SEC("socket")
>     __description("invalid call insn1")
>     __failure __msg("unknown opcode 8d")
>     __failure_unpriv
>     __naked void invalid_call_insn1(void)
>     {
>             asm volatile ("                                 \
>             .8byte %[raw_insn];                             \
>             exit;                                           \
>     "       :
>             : __imm_insn(raw_insn, BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_=
X, 0, 0, 0, 0))
>             : __clobber_all);
>     }
>
> I'd say that original is better.

+1

> Do you want to get rid of ./test_verifier binary?

All this work looks like a diminishing return.
It's ok to keep test_verifier around.
All new asm test can already go into test_progs and in some rare cases
test_verifier will be a better home for them.
