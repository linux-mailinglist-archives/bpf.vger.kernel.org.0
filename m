Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD496CCE99
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 02:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjC2ALx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 20:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2ALw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 20:11:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E671706
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 17:11:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so56622573edd.5
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 17:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680048709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XMESKKm22cnyU83dN6hEuuAJnzyo7N01UxVhc2r2Rc=;
        b=dOwMBzMR+URf7CZNUx1rcvmZP/ITeV59x45J6adgiFx6AHiEvQjKXc6TQyHBcUXKSp
         BIlGG/f6TVwR0ARuVxpWT0l+IUENUc5fkVTUtWhlI7FINy1MB72u9Ol7Z8yCUHb70Mtn
         9osTjkZcPUu4US5qRkC2/5LzyikY2qCEdLKTf0TH1+YZWITSutxy1Fe3uDpF9YbPBymy
         vIzmMcmnjlnoqUCTBpsgMWI+xprtuTgwVo2IcQaCV2ldE21fvwnOpE9s54ksfQc14y+u
         W8XzeZQ6fQVaBqwytPQUM/BHOXQKJh3xEwDdT8fcXOOKzhiBb1rkhdBrP8aPKBwQLe9f
         B1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680048709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XMESKKm22cnyU83dN6hEuuAJnzyo7N01UxVhc2r2Rc=;
        b=6jleLbNDdtSivMxJoOWn/EUTwM7MBUuG/Z5ZMzu+EUr/ktUyb0YDa2dpTispsm9Z84
         gCw8oGsXLqxe6fd0z9YW8zO0O0ad1G9sIkgAj86818OUhvb/7wlK2DK8XLppYjknTlw8
         gPIqoyECV/sJwC+DunmMC5dpb8owMsP1vsViHgTW1CBOnGXPQK2Q/+nN7OEEWKL4wE1G
         CLbkn3nd4tkm0f7yRiFqYdPbkF8YcuYsZ18ErYou6kxMuNakvid9fpkjYF3VVe1djwWP
         bAvn+/Tb1fma2jncaLUn1zlAWTTntKgdXAT1FvNYGyPmt7NwNQLHYn7AMVPRytbkItZd
         3BeQ==
X-Gm-Message-State: AAQBX9fQGRxde97jMG1KBzA2+Zh+AmVW64E7nxbWuQzFr8lywvU8toqE
        KPrh1XWmzYp1S9j3kMvHHGR7xahH7OBNoOIJ/QI=
X-Google-Smtp-Source: AKy350YfiseQJlmt3VTQh9gV6aHeV6LXH6tFI6iJ/oNvP1uQA+HoqKsb7mK2yOfACyx4BS5zT1U5A0roecWCOebTogE=
X-Received: by 2002:a17:906:81da:b0:92f:b329:cb75 with SMTP id
 e26-20020a17090681da00b0092fb329cb75mr294964ejx.5.1680048709544; Tue, 28 Mar
 2023 17:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <359ea18b-5996-afea-b81e-32f13f134852@iogearbox.net>
 <b69f211724dd9d1acdb896ca1b97109065ab28b0.camel@gmail.com>
 <CAEf4BzZtC88nCXvBBdd-6dox1rDMfwqKZBY2CtON05fi0fGzFQ@mail.gmail.com>
 <bd3389fcad0dc8555ed3cf42b69f717cbea380b6.camel@gmail.com> <CAADnVQK6XVzNmjbY9wO4tve_93je7zvGUHHVX3EsYQpo4CFGiw@mail.gmail.com>
In-Reply-To: <CAADnVQK6XVzNmjbY9wO4tve_93je7zvGUHHVX3EsYQpo4CFGiw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Mar 2023 17:11:37 -0700
Message-ID: <CAEf4BzZq7TrgCFQKw16Afp5va7iaijabBbWhd=FqbFFm3sm62Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
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

On Tue, Mar 28, 2023 at 4:31=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 28, 2023 at 3:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Tue, 2023-03-28 at 15:24 -0700, Andrii Nakryiko wrote:
> > [...]
> > >
> > > > # Simplistic tests (14 files)
> > > >
> > > > Some tests are just simplistic and it is not clear if moving those =
to inline
> > > > assembly really makes sense, for example, here is `basic_call.c`:
> > > >
> > > >     {
> > > >         "invalid call insn1",
> > > >         .insns =3D {
> > > >         BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, 0, 0, 0, 0),
> > > >         BPF_EXIT_INSN(),
> > > >         },
> > > >         .errstr =3D "unknown opcode 8d",
> > > >         .result =3D REJECT,
> > > >     },
> > > >
> > >
> > > For tests like this we can have a simple ELF parser/loader that
> > > doesn't use bpf_object__open() functionality. It's not too hard to
> > > just find all the FUNC ELF symbols and fetch corresponding raw
> > > instructions. Assumption here is that we can take those assembly
> > > instructions as is, of course. If there are some map references and
> > > such, this won't work.
> >
> > Custom elf parser/loader is interesting.
> > However, also consider how such tests look in assembly:
> >
> >     SEC("socket")
> >     __description("invalid call insn1")
> >     __failure __msg("unknown opcode 8d")
> >     __failure_unpriv
> >     __naked void invalid_call_insn1(void)
> >     {
> >             asm volatile ("                                 \
> >             .8byte %[raw_insn];                             \
> >             exit;                                           \
> >     "       :
> >             : __imm_insn(raw_insn, BPF_RAW_INSN(BPF_JMP | BPF_CALL | BP=
F_X, 0, 0, 0, 0))
> >             : __clobber_all);
> >     }
> >
> > I'd say that original is better.
>
> +1
>
> > Do you want to get rid of ./test_verifier binary?
>
> All this work looks like a diminishing return.
> It's ok to keep test_verifier around.
> All new asm test can already go into test_progs and in some rare cases
> test_verifier will be a better home for them.

I definitely don't want us to go crazy and just reimplement
test_verifier.c inside test_progs, of course. But I do see value of
getting rid of test_verifier as a separate test runner (and hopefully
most of 1.7K lines of code in test_verifier.c). I do agree that these
bad/raw instructions are not the most readable alternative, though.

But taking those few tests with invalid instructions and patterns
(using BPF_RAW_INSN() macro and others) and writing them as explicit
test_progs' test with bpf_prog_load() seems like a better alternative.
test_progs has much better integration with BPF CI, and not having to
remember to run test_verifier locally seems like a win.
