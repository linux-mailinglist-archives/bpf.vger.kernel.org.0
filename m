Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FAB6CCE7C
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 02:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjC2AIL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 20:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjC2AIL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 20:08:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC6410F5
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 17:08:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eh3so56501371edb.11
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 17:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680048488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Zl/jYh9C5G5fQVe6bm1MFDnLMe4wsi9oWQhAlApUbY=;
        b=kOIJWsgsnKJim+BGry+rsyo8DWLZAJWzQUfYiD0Q/wyy+/vpWWTWGRBy0vk+bV4qA6
         kXuMf29ujSOt/pz/Hm85vtL9i2VU8pty+E2K/HjPgHYPo2dvM4tUuPPwB6BKFO5XvhiZ
         TNBTmCvpRhyI6We8jgWmc0YnYQinfhDF6BIfybuN7uyn94vwPihBCvkC+kWslkhmwW0c
         wV/apzl9q1hiACaWG9IsG8E1x0EUUOjh2PnkcCJ/o6N/qPTmQg2dk1Kr8BvDvZ/h+3Nw
         iNKhK9SJyMzNA9yr4iCQD2OjsGUs4ZIwYJLatGqYP4pifDYmGk6t36TNaNFa5AYm4jzd
         ohsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680048488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Zl/jYh9C5G5fQVe6bm1MFDnLMe4wsi9oWQhAlApUbY=;
        b=IgJ71LfdlSXThxRDzrloBbCp6AX2Aif2YpI84oEZ+oIThQRaXmW6inv0WvKGpTVQva
         qSsJVJ2k9rGXj/MOnxqLZ1AO6WpFpeRh/cYWCVzJhwjshvMgOdisbJQjUhyRC2UYjras
         1Dy10sM6Qai1/lebsJZxC77mABE8RkypW2xgft+5SDtrF5xG9VlVPc7UqBrE15j27671
         eHnVfAuAzdSlYTtuwxkK0OCgtnYFQhKuJpjdnBmB09JgRJ+QdUBwtki2WWkMVFF2yFiA
         PVmYy9GqoP8Ud24Plt+nxiV9aqwEGfoKCbV6ltLm8JZ7kvtP/C7MwwmtYPD9sXzcrraY
         LpTw==
X-Gm-Message-State: AAQBX9fKlGepp0DHa1p8GKvAmXp4+MwNqWIMT/eRzfplt2R/qNB2DbdJ
        rduQPU4GFeB1R9wyIh625VnkDUzXa/+kQYG6liN1ixsV
X-Google-Smtp-Source: AKy350bYybnvnVFHftQy3addNEKxnh4jsN31ZRgkjKBANBg7zvRCZk3xudyoElXjQ7JjVfGCKqTFSKuZKZRDbABvckU=
X-Received: by 2002:a17:906:6692:b0:944:70f7:6fae with SMTP id
 z18-20020a170906669200b0094470f76faemr4381762ejo.5.1680048487888; Tue, 28 Mar
 2023 17:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <359ea18b-5996-afea-b81e-32f13f134852@iogearbox.net>
 <b69f211724dd9d1acdb896ca1b97109065ab28b0.camel@gmail.com>
 <CAEf4BzZtC88nCXvBBdd-6dox1rDMfwqKZBY2CtON05fi0fGzFQ@mail.gmail.com> <bd3389fcad0dc8555ed3cf42b69f717cbea380b6.camel@gmail.com>
In-Reply-To: <bd3389fcad0dc8555ed3cf42b69f717cbea380b6.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Mar 2023 17:07:55 -0700
Message-ID: <CAEf4BzbSgsat0K3fUw9wej2THmGY6J4x4R_riPqVPD8kccGQqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
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
> Do you want to get rid of ./test_verifier binary?
> If so, we can move such tests under ./test_progs w/o converting to
> inline assembly.

Ideally, both test_verifier as a separate test runner to unify
everything in test_progs "framework", which is much better integrated
into BPF CI. But it would also be nice to get rid of almost 2k lines
of code in test_verifier.c. But it's "ideally", it depends on how much
new hacky code would be necessary to achieve this. No strong feelings
here.

>
> [...]
> >
> > > # Pseudo-call instructions (9 files)
> > >
> > > An object file might contain several BPF programs plus some functions=
 used from
> > > different programs. In order to load a program from such file, `libbp=
f` creates
> > > a buffer and copies the program and all functions called from this pr=
ogram into
> > > that buffer. For each visited pseudo-call instruction `libbpf` requir=
es it to
> > > point to a valid function described in ELF header.
> > >
> > > However, this is not how `verifier/*.c` tests are written, for exampl=
e here is a
> > > translated fragment from `verifier/loops1.c`:
> > >
> > >     SEC("tracepoint")
> > >     __description("bounded recursion")
> > >     __failure __msg("back-edge")
> > >     __naked void bounded_recursion(void)
> > >     {
> > >             asm volatile ("                                 \
> > >             r1 =3D 0;                                         \
> > >             call l0_%=3D;                                     \
> > >             exit;                                           \
> > >     l0_%=3D:  r1 +=3D 1;                                        \
> > >             r0 =3D r1;                                        \
> > >             if r1 < 4 goto l1_%=3D;                           \
> > >             exit;                                           \
> > >     l1_%=3D:  call l0_%=3D;                                     \
> > >             exit;                                           \
> > >     "       ::: __clobber_all);
> > >     }
> > >
> > > There are several possibilities here:
> > > - split such tests into several functions during migration;
> > > - add a special flag for `libbpf` asking to allow such calls;
> > > - Andrii also suggested to try using `.section` directives inside inl=
ine
> > >   assembly block.
> > >
> > > This requires further investigation, I'll discuss it with Andrii some=
 time later
> > > this week or on Monday.
> >
> > So I did try this a few weeks ago, and yes, you can make this work
> > with assembly directives. Except that DWARF (and thus .BTF and
> > .BTF.ext) information won't be emitted, as it is emitted very
> > painfully and manually by C compiler as explicit assembly directives.
> > But we might work around that by clearing .BTF and .BTF.ext
> > information for such object files, perhaps. So tentatively this should
> > be doable.
>
> Could you please share an example?

I don't think I saved that. But I just looked at what asm Clang
produces from C code with -S argument.

>
> [...]
> > > # `.fill_helper` (5 files)
> > >
> > > Programs for some tests are generated programmatically by specifying
> > > `.fill_helper` function in the test description, e.g. `verifier/scale=
.c`:
> > >
> > >     {
> > >         "scale: scale test 1",
> > >         .insns =3D { },
> > >         .data =3D { },
> > >         .fill_helper =3D bpf_fill_scale,
> > >         .prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
> > >         .result =3D ACCEPT,
> > >         .retval =3D 1,
> > >     },
> > >
> > > Such tests cannot be migrated
> > > (but sometimes these are not the only tests in the file).
> >
> > We can just write these as explicitly programmatically generated
> > programs, probably. There are just a few of these, shouldn't be a big
> > deal.
>
> You mean move the generating function from test_verifier.c to some
> test under prog_tests/whatever.c, right?

yes, generating function + add bpf_prog_load()-based test around them

>
> > > # libbpf does not like some junk code (3 files)
> > >
> > > `libbpf` (and bpftool) reject some junk instructions intentionally en=
coded in
> > > the tests, e.g. empty program from `verifier/basic.c`:
> > >
> > >     SEC("socket")
> > >     __description("empty prog")
> > >     __failure __msg("last insn is not an exit or jmp")
> > >     __failure_unpriv
> > >     __naked void empty_prog(void)
> > >     {
> >
> > even if you add some random "r0 =3D 0" instruction? It won't change the
> > meaning of the test, but should work with libbpf.
>
> Random instruction should work.
>
> >
> > >             asm volatile ("" ::: __clobber_all);
> > >     }
> > >
> > > # Small log buffer (2 files)
> > >
> > > Currently `test_loader.c` uses 1Mb log buffer, while `test_verifier.c=
` uses 16Mb
> > > log buffer. There are a few tests (like in `verifier/bounds.c`) that =
exit with
> > > `-ESPC` for 1Mb buffer.
> > >
> > > I can either bump log buffer size for `test_loader.c` or wait until A=
ndrii's
> > > rotating log implementation lands.
> >
> > Just bump to 16MB, no need to wait on anything.
>
> Will do.
>
> [...]
