Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E530A628B2C
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 22:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiKNVNr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 16:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbiKNVNq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 16:13:46 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925DD108D
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:13:44 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id b9so15005979ljr.5
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXLCmwb3jvnRfMWSEdkyyplnXpiy8NjMQ5nl1+DWeII=;
        b=YJ6hjFZS+orBItD9kasUmRHEJFxM+MPbcNrxuFHsXEEMHrsuUnjIXKu04+q4X1zHSG
         E0cReVeDo78BhErYlm8yWad71Z9BZQlTGCpw5SQnT9HT9Y31RtpC4LSJOzWkJTr7R3aO
         E+lLoJwS//pVtE49pIGtgjA6ohg7rpfp827hORCQw71Hesu/Uulk4HdXHHrorjq2rOnW
         5DzGYZLWhXi0GJJo1EGQZShm7/Zo6Yb+1Vu6UIvGUBLHu7/FkkK8fw0wuyMHnvt1ocJk
         vX6eP0L72VOxqvPNq8CTmofxToNjkNbS0QU27LbuldQu9O8nXdDhsbG3LlA8Ly02kS2p
         cN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXLCmwb3jvnRfMWSEdkyyplnXpiy8NjMQ5nl1+DWeII=;
        b=ZX7ScNL152eiVZDmyATNFf5gItWqg+kWG+uks960TPFxHCMbEaS7h5f8rIo3OKPvic
         9/c8KhK36x7KzmAzEL9JFlD9ZWH+/TlOxfpjE0+iaOwSQ8QPofiRWQ5CDZR9YezX4EwK
         p8ZlG0s5wZ/1iz7vXbJW6vJHZpSw7RgWJNRshsnLWusROyobh8enuA6iHlnGcBzuN/I+
         Dlx9tty9/W1WYJ+b1hGTJorTkNaOMk31gbY5k4ijNL+n3R2IZjmcVa/HhowdTvEXDw5i
         v5LWWuzFZTLhifyhrJM1BXmHQUgLFARH1uHCBcxR2BqQ/4tD5BeivwkPgDHjEhy8G/nW
         j6Qg==
X-Gm-Message-State: ANoB5plTDPv+klREIyKAprTszQ9UWELPUNHe9sysLLe94bQOUXhTKCdi
        7KDLuS7QW4QWtCC7TYalv7A=
X-Google-Smtp-Source: AA0mqf6m7VrU1c3r42KK7LeeMibfQKYqnErwv2/13pvye/K7Zmg9+VsIFsMrFnb5Z9H6PT9En3b2Mw==
X-Received: by 2002:a2e:a885:0:b0:26d:f589:4120 with SMTP id m5-20020a2ea885000000b0026df5894120mr5291605ljq.206.1668460422697;
        Mon, 14 Nov 2022 13:13:42 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d6-20020a19f246000000b004acb2adfa21sm1950875lfk.297.2022.11.14.13.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:13:42 -0800 (PST)
Message-ID: <e001c117fc2f7c202e34a68007abdd4f7744c0e1.camel@gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Yonghong Song <yhs@meta.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
Date:   Mon, 14 Nov 2022 23:13:40 +0200
In-Reply-To: <67c5d476-b8f4-9007-ca00-a8a9c111c826@meta.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
         <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
         <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com>
         <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
         <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
         <806f02669ee8930a2f5c5e3f2d5cb0b3166832bb.camel@gmail.com>
         <67c5d476-b8f4-9007-ca00-a8a9c111c826@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2022-11-13 at 23:52 -0800, Yonghong Song wrote:
>=20
> On 11/11/22 1:55 PM, Eduard Zingerman wrote:
> > On Fri, 2022-10-28 at 11:56 -0700, Yonghong Song wrote:
> > > > > [...]
> > > >=20
> > > > Ok, could we change the problem to detecting if some type is define=
d.
> > > > Would it be possible to have something like
> > > >=20
> > > > #if !__is_type_defined(struct abc)
> > > > struct abc {
> > > > };
> > > > #endif
> > > >=20
> > > > I think we talked about this and there were problems with this
> > > > approach, but I don't remember details and how insurmountable the
> > > > problem is. Having a way to check whether some type is defined woul=
d
> > > > be very useful even outside of -target bpf parlance, though, so may=
be
> > > > it's the problem worth attacking?
> > >=20
> > > Yes, we discussed this before. This will need to add additional work
> > > in preprocessor. I just made a discussion topic in llvm discourse
> > >=20
> > > https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-define=
d-type/66268
> > >=20
> > > Let us see whether we can get some upstream agreement or not.
> >=20
> > I did a small investigation of this feature.
> >=20
> > The main pre-requirement is construction of the symbol table during
> > source code pre-processing, which implies necessity to parse the
> > source code at the same time. It is technically possible in clang, as
> > lexing, pre-processing and AST construction happens at the same time
> > when in compilation mode.
> >=20
> > The prototype is available here [1], it includes:
> > - Change in the pre-processor that adds an optional callback
> >    "IsTypeDefinedFn" & necessary parsing of __is_type_defined
> >    construct.
> > - Change in Sema module (responsible for parsing/AST & symbol table)
> >    that installs the appropriate "IsTypeDefinedFn" in the pre-processor
> >    instance.
> >=20
> > However, this prototype builds a backward dependency between
> > pre-processor and semantic analysis. There are currently no such
> > dependencies in the clang code base.
> >=20
> > This makes it impossible to do pre-processing and compilation
> > separately, e.g. consider the following example:
> >=20
> > $ cat test.c
> >=20
> >    struct foo { int x; };
> >   =20
> >    #if __is_type_defined(foo)
> >      const int x =3D 1;
> >    #else
> >      const int x =3D 2;
> >    #endif
> >   =20
> > $ clang -cc1 -ast-print test.c -o -
> >=20
> >    struct foo {
> >        int x;
> >    };
> >    const int x =3D 1;
> >=20
> > $ clang -E test.c -o -
> >=20
> >    # ... some line directives ...
> >    struct foo { int x; };
> >    const int x =3D 2;
>=20
> Is it any chance '-E' could output the same one as '-cc1 -ast-print'?
> That is, even with -E we could do some semantics analysis
> as well, using either current clang semantics analysis or creating
> an minimal version of sema analysis in preprocessor itself?

Sema drives consumption of tokens from Preprocessor. Calls to
Preprocessor are done on a parsing recursive descent. Extracting a
stream of tokens would require an incremental parser instead.

A minimal version of such parser is possible to implement for C.
It might be the case that matching open / closing braces and
identifiers following 'struct' / 'union' / 'enum' keywords might be
almost sufficient but I need to try to be sure (e.g. it is more
complex for 'typedef').

I can work on it but I don't think there is a chance to upstream this work.

Thanks,
Eduard

>=20
> >=20
> > Note that __is_type_defined is computed to different value in the
> > first and second calls. This is so because semantic analysis (AST,
> > symbol table) is not done for -E.
> >=20
> > It also breaks that C11 standard which clearly separates
> > pre-processing and semantic analysis phases, see [2] 5.1.1.2.
> >=20
> > So, my conclusion is as follows: this is technically possible in clang
> > but has no chance to reach llvm upstream.
> >=20
> > Thanks,
> > Eduard
> >=20
> > [1] https://github.com/llvm/llvm-project/compare/main...eddyz87:llvm-pr=
oject:is-type-defined-experiment
> > [2] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf
> >=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > BTW, I suggest splitting libbpf btf_dedup and btf_dump changes =
into a
> > > > > > separate series and sending them as non-RFC sooner. Those impro=
vements
> > > > > > are independent of all the header guards stuff, let's get them =
landed
> > > > > > sooner.
> > > > > >=20
> > > > > > > After some discussion with Alexei and Yonghong I'd like to re=
quest
> > > > > > > your comments regarding a somewhat brittle and partial soluti=
on to
> > > > > > > this issue that relies on adding `#ifndef FOO_H ... #endif` g=
uards in
> > > > > > > the generated `vmlinux.h`.
> > > > > > >=20
> > > > > >=20
> > > > > > [...]
> > > > > >=20
> > > > > > > Eduard Zingerman (12):
> > > > > > >      libbpf: Deduplicate unambigous standalone forward declar=
ations
> > > > > > >      selftests/bpf: Tests for standalone forward BTF declarat=
ions
> > > > > > >        deduplication
> > > > > > >      libbpf: Support for BTF_DECL_TAG dump in C format
> > > > > > >      selftests/bpf: Tests for BTF_DECL_TAG dump in C format
> > > > > > >      libbpf: Header guards for selected data structures in vm=
linux.h
> > > > > > >      selftests/bpf: Tests for header guards printing in BTF d=
ump
> > > > > > >      bpftool: Enable header guards generation
> > > > > > >      kbuild: Script to infer header guard values for uapi hea=
ders
> > > > > > >      kbuild: Header guards for types from include/uapi/*.h in=
 kernel BTF
> > > > > > >      selftests/bpf: Script to verify uapi headers usage with =
vmlinux.h
> > > > > > >      selftests/bpf: Known good uapi headers for test_uapi_hea=
ders.py
> > > > > > >      selftests/bpf: script for infer_header_guards.pl testing
> > > > > > >=20
> > > > > > >     scripts/infer_header_guards.pl                | 191 +++++
> > > > > > >     scripts/link-vmlinux.sh                       |  13 +-
> > > > > > >     tools/bpf/bpftool/btf.c                       |   4 +-
> > > > > > >     tools/lib/bpf/btf.c                           | 178 ++++-
> > > > > > >     tools/lib/bpf/btf.h                           |   7 +-
> > > > > > >     tools/lib/bpf/btf_dump.c                      | 232 +++++=
-
> > > > > > >     .../selftests/bpf/good_uapi_headers.txt       | 677 +++++=
+++++++++++++
> > > > > > >     tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++
> > > > > > >     .../selftests/bpf/prog_tests/btf_dump.c       |  11 +-
> > > > > > >     .../bpf/progs/btf_dump_test_case_decl_tag.c   |  39 +
> > > > > > >     .../progs/btf_dump_test_case_header_guards.c  |  94 +++
> > > > > > >     .../bpf/test_uapi_header_guards_infer.sh      |  33 +
> > > > > > >     .../selftests/bpf/test_uapi_headers.py        | 197 +++++
> > > > > > >     13 files changed, 1816 insertions(+), 12 deletions(-)
> > > > > > >     create mode 100755 scripts/infer_header_guards.pl
> > > > > > >     create mode 100644 tools/testing/selftests/bpf/good_uapi_=
headers.txt
> > > > > > >     create mode 100644 tools/testing/selftests/bpf/progs/btf_=
dump_test_case_decl_tag.c
> > > > > > >     create mode 100644 tools/testing/selftests/bpf/progs/btf_=
dump_test_case_header_guards.c
> > > > > > >     create mode 100755 tools/testing/selftests/bpf/test_uapi_=
header_guards_infer.sh
> > > > > > >     create mode 100755 tools/testing/selftests/bpf/test_uapi_=
headers.py
> > > > > > >=20
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >=20
> >=20

