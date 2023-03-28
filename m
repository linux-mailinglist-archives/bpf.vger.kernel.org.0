Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229B86CCD95
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 00:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjC1Wjp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 18:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjC1Wj0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 18:39:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A015359C
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:39:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er13so14905763edb.9
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680043141;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UwNszxtbNOipD0Kt/k46DWZpdNLRBNcKLfvmmzQtHao=;
        b=WWa3vbZrZtmtNxaBfHK+aWh0DbUV5/uolRDh4KcVSH1Uyb76A1bI9S2NXxPpacjP6L
         hBG0NoNe9Nl7q2qkgnqmXnQJy6uCRq7Mcv0wiBugxicYr6ePEjPf3oW3DVttve4h/zNU
         ymxO9KSgOkquww1MpWRsfeLD+8OlhIX2WYBEKJq5HG/BDWl5HoLBdAgicOYjf+Z5YK75
         Lk5YS6W9lG9xrIBu5RKUd29Hh6bRP5bKtn9dXvlmeOkYtS90iR2KAw3N/zw1aT7v7BT9
         Y5JRVX9h0NbIj9UQMGut7TgKCjsplejlC7y3f39iJ63h7q4GykLc4gp0cjOhGGgUSEMw
         iYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680043141;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwNszxtbNOipD0Kt/k46DWZpdNLRBNcKLfvmmzQtHao=;
        b=fNxVp/uo0kGCqWUF24lkjNl8V1kEGjMiHpEKQYfvpmb1kAEjWWfPS1nYdCaEFiK+v2
         oDUQ7vouFoqT1leexNO1kyRPrDPZHr2wHHrt3U9dZWOQ1w6rgQUmzXDMoM4tqTuFyZhK
         e5qXBBmW5JbWdi+FuaSIi4W4tSrV5mxrkfNhwWnRvtxiCRrWTGj+E5sn+BZp1Ps2M9EI
         KwmOK4Sl7ubn7OQZXb0GifoP8FXjW9quyJV9QuEwxYeQwvAOTqDaJkl5TR+U0ooZyPMN
         ICKNv6OHoi4FYJFcEbLIDtpNqQk1+9zatagyrO3vHOlaWYgl7TQ5RQTY5AwFIIsAnEUy
         6wHA==
X-Gm-Message-State: AAQBX9dXkPnDYPlR1CCD4MWJvUPs6ehbvrLtPmzXyhNtklKe2P+ZpaS7
        c8QoC1r1jn46pYpiJFKMGSY=
X-Google-Smtp-Source: AKy350aSWxWVYtShaoPwMCBd010GO9taQwqKS4ESXOd4BdbllkdEQj0CLY9He9iwFMI35EcPDn/3EA==
X-Received: by 2002:a17:906:fc1e:b0:92b:f3c3:7c5f with SMTP id ov30-20020a170906fc1e00b0092bf3c37c5fmr16656368ejb.53.1680043141191;
        Tue, 28 Mar 2023 15:39:01 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r17-20020a50aad1000000b005024459f431sm2974604edc.70.2023.03.28.15.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:39:00 -0700 (PDT)
Message-ID: <bd3389fcad0dc8555ed3cf42b69f717cbea380b6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
Date:   Wed, 29 Mar 2023 01:38:59 +0300
In-Reply-To: <CAEf4BzZtC88nCXvBBdd-6dox1rDMfwqKZBY2CtON05fi0fGzFQ@mail.gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
         <359ea18b-5996-afea-b81e-32f13f134852@iogearbox.net>
         <b69f211724dd9d1acdb896ca1b97109065ab28b0.camel@gmail.com>
         <CAEf4BzZtC88nCXvBBdd-6dox1rDMfwqKZBY2CtON05fi0fGzFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-03-28 at 15:24 -0700, Andrii Nakryiko wrote:
[...]
>=20
> > # Simplistic tests (14 files)
> >=20
> > Some tests are just simplistic and it is not clear if moving those to i=
nline
> > assembly really makes sense, for example, here is `basic_call.c`:
> >=20
> >     {
> >         "invalid call insn1",
> >         .insns =3D {
> >         BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, 0, 0, 0, 0),
> >         BPF_EXIT_INSN(),
> >         },
> >         .errstr =3D "unknown opcode 8d",
> >         .result =3D REJECT,
> >     },
> >=20
>=20
> For tests like this we can have a simple ELF parser/loader that
> doesn't use bpf_object__open() functionality. It's not too hard to
> just find all the FUNC ELF symbols and fetch corresponding raw
> instructions. Assumption here is that we can take those assembly
> instructions as is, of course. If there are some map references and
> such, this won't work.

Custom elf parser/loader is interesting.
However, also consider how such tests look in assembly:

    SEC("socket")
    __description("invalid call insn1")
    __failure __msg("unknown opcode 8d")
    __failure_unpriv
    __naked void invalid_call_insn1(void)
    {
            asm volatile ("                                 \
            .8byte %[raw_insn];                             \
            exit;                                           \
    "       :
            : __imm_insn(raw_insn, BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X,=
 0, 0, 0, 0))
            : __clobber_all);
    }

I'd say that original is better.
Do you want to get rid of ./test_verifier binary?
If so, we can move such tests under ./test_progs w/o converting to
inline assembly.

[...]
>=20
> > # Pseudo-call instructions (9 files)
> >=20
> > An object file might contain several BPF programs plus some functions u=
sed from
> > different programs. In order to load a program from such file, `libbpf`=
 creates
> > a buffer and copies the program and all functions called from this prog=
ram into
> > that buffer. For each visited pseudo-call instruction `libbpf` requires=
 it to
> > point to a valid function described in ELF header.
> >=20
> > However, this is not how `verifier/*.c` tests are written, for example =
here is a
> > translated fragment from `verifier/loops1.c`:
> >=20
> >     SEC("tracepoint")
> >     __description("bounded recursion")
> >     __failure __msg("back-edge")
> >     __naked void bounded_recursion(void)
> >     {
> >             asm volatile ("                                 \
> >             r1 =3D 0;                                         \
> >             call l0_%=3D;                                     \
> >             exit;                                           \
> >     l0_%=3D:  r1 +=3D 1;                                        \
> >             r0 =3D r1;                                        \
> >             if r1 < 4 goto l1_%=3D;                           \
> >             exit;                                           \
> >     l1_%=3D:  call l0_%=3D;                                     \
> >             exit;                                           \
> >     "       ::: __clobber_all);
> >     }
> >=20
> > There are several possibilities here:
> > - split such tests into several functions during migration;
> > - add a special flag for `libbpf` asking to allow such calls;
> > - Andrii also suggested to try using `.section` directives inside inlin=
e
> >   assembly block.
> >=20
> > This requires further investigation, I'll discuss it with Andrii some t=
ime later
> > this week or on Monday.
>=20
> So I did try this a few weeks ago, and yes, you can make this work
> with assembly directives. Except that DWARF (and thus .BTF and
> .BTF.ext) information won't be emitted, as it is emitted very
> painfully and manually by C compiler as explicit assembly directives.
> But we might work around that by clearing .BTF and .BTF.ext
> information for such object files, perhaps. So tentatively this should
> be doable.

Could you please share an example?

[...]
> > # `.fill_helper` (5 files)
> >=20
> > Programs for some tests are generated programmatically by specifying
> > `.fill_helper` function in the test description, e.g. `verifier/scale.c=
`:
> >=20
> >     {
> >         "scale: scale test 1",
> >         .insns =3D { },
> >         .data =3D { },
> >         .fill_helper =3D bpf_fill_scale,
> >         .prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
> >         .result =3D ACCEPT,
> >         .retval =3D 1,
> >     },
> >=20
> > Such tests cannot be migrated
> > (but sometimes these are not the only tests in the file).
>=20
> We can just write these as explicitly programmatically generated
> programs, probably. There are just a few of these, shouldn't be a big
> deal.

You mean move the generating function from test_verifier.c to some
test under prog_tests/whatever.c, right?

> > # libbpf does not like some junk code (3 files)
> >=20
> > `libbpf` (and bpftool) reject some junk instructions intentionally enco=
ded in
> > the tests, e.g. empty program from `verifier/basic.c`:
> >=20
> >     SEC("socket")
> >     __description("empty prog")
> >     __failure __msg("last insn is not an exit or jmp")
> >     __failure_unpriv
> >     __naked void empty_prog(void)
> >     {
>=20
> even if you add some random "r0 =3D 0" instruction? It won't change the
> meaning of the test, but should work with libbpf.

Random instruction should work.

>=20
> >             asm volatile ("" ::: __clobber_all);
> >     }
> >=20
> > # Small log buffer (2 files)
> >=20
> > Currently `test_loader.c` uses 1Mb log buffer, while `test_verifier.c` =
uses 16Mb
> > log buffer. There are a few tests (like in `verifier/bounds.c`) that ex=
it with
> > `-ESPC` for 1Mb buffer.
> >=20
> > I can either bump log buffer size for `test_loader.c` or wait until And=
rii's
> > rotating log implementation lands.
>=20
> Just bump to 16MB, no need to wait on anything.

Will do.

[...]
