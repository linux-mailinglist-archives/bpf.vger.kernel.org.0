Return-Path: <bpf+bounces-16128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06277FCEE2
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E217C1C210D0
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE3BDDB2;
	Wed, 29 Nov 2023 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcwLzSvB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682B391
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:12:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54bb5ebbb35so1697127a12.1
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701238338; x=1701843138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ67tSq4xtt4ChTJc4i2bSrwwP59iBdHhC8wXv9Q4VM=;
        b=AcwLzSvBO8tmlNAgSVufAHLVgyd27euXKwfZeEmlHK91GzdBs73kizyNEdGzp1Qnsb
         bRu6EdBZTRJgOb6WpRyOHLSgSl9ACP4SbaR6ttjD2VQC6YjfvCkwSVZRL4Cyrn7HjY7p
         qCE3KOcnGQveedcQQwG3suPC/mvzrORI+CtPAzNYPOL+E2P6G4KaAe0efWG19Hi8UuNE
         yobGGbIMjFkPHzmoqBJ+/WwPtsZqprLtHwCuMBnXoNtxCeF9xn6d2/0+71k3SRGIqNtn
         f7lkCE4Q7j54I/CdS7NoKCskAOwuuBiwcJKOApV8lRuLsbCIxcGRUs0v+4XnEoQ7AwBF
         CwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701238338; x=1701843138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZ67tSq4xtt4ChTJc4i2bSrwwP59iBdHhC8wXv9Q4VM=;
        b=F4sElkT0M4GQXWrqsIJdHhU715GX0vSCEpkEHgUNTKR/TBHv68uLNJmkONz1WyEu2c
         /l9lH/I86X6QFZlD0Wo4f2AyYJ9DposYwJa02fa8Yt0Mevv5CzntJIMBgVv2uS8HBLx3
         /2bNlw3GsKodiaMOUWADmcUEoOFiNqQ+d3E+umapueqCuDTKqvDpPGtAs5vmxvbCkrKa
         bI0K5yWV6tyh9cj6Z1/yRO77elzelW0PgGmKK4Icaq4HNpOQBgY4R2eEV2eXygQ/qrO9
         UgFVAi4m9Wb4kv7Z1xhXxqTi9dd+VxRA0ftTebw1gm5LhY1TA7cK9U1/sSfKXUvQgeTV
         YpXA==
X-Gm-Message-State: AOJu0Yw2RxJ5FDRpxNwCxngBODQbL1DuCqFJf5zpqowVAhOSRcXNQYzH
	q3C/6+N9yNOi7eIFdT3hs49+oyv1Q+6mA2RV6156yIDT
X-Google-Smtp-Source: AGHT+IEIwTcHBBwpST5hgHgLgs7wzYjybr6OoqWgCANi59el8kZsY9950q3Z3szsXRnule9VLjwopjCnI8kogvfyacE=
X-Received: by 2002:a17:906:161b:b0:9e3:fc27:9356 with SMTP id
 m27-20020a170906161b00b009e3fc279356mr9650757ejd.51.1701238337644; Tue, 28
 Nov 2023 22:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
 <20231126015045.1092826-3-andreimatei1@gmail.com> <de2946da3720afdde07aadcda1992e3f877cca70.camel@gmail.com>
 <CABWLseviz4j=KhkbX7P8soj5dkBjbg3bP08joF+y43+TFEKX0Q@mail.gmail.com> <e7e59071c1f4009a7d15539f227ef7d92337937e.camel@gmail.com>
In-Reply-To: <e7e59071c1f4009a7d15539f227ef7d92337937e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Nov 2023 22:12:05 -0800
Message-ID: <CAEf4BzbnLVw-4-o02maULGUnWbyEwHNQQxNLTM7f_fsWbrVdRg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: new verifier tests for stack access
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 4:55=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-11-27 at 22:15 -0500, Andrei Matei wrote:
> > On Mon, Nov 27, 2023 at 8:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Sat, 2023-11-25 at 20:50 -0500, Andrei Matei wrote:
> > > > This patch adds tests for the previous patch, checking the tracking=
 of
> > > > the maximum stack size and checking that accesses to uninit stack m=
emory
> > > > are allowed.
> > > >
> > > > They are a separate patch for review purposes; whoever merges them =
can
> > > > consider squashing.
> > > >
> > > > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > > > ---
> > >
> > > I think the strategy now is to add new tests using inline assembly,
> > > e.g. as a part of verifier_* tests in test_progs.
> >
> > Thanks, I'll try that. I see in some of the verifier tests that you
> > have converted to test_progs hints that they were converted
> > "automatically". I'm curious what tool you've used, if any.
>
> I wrote a small tree-sitter based tool for this:
> https://github.com/eddyz87/verifier-tests-migrator
>
> > Do you have any thoughts on how a test could assert the maximum stack
> > depth? test_verifier has access to the verifier verifier log and
> > parses it out of there; do you know how I could achieve the same in
> > test_progs?
>
> Could be done like in the patch below (set log level so that stack
> depth is printed, match stack depth message):
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/t=
ools/testing/selftests/bpf/progs/verifier_basic_stack.c
> index 069c3f91705c..e85ac95c8dd3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
> @@ -27,7 +27,7 @@ __naked void stack_out_of_bounds(void)
>
>  SEC("socket")
>  __description("uninitialized stack1")
> -__success
> +__success __log_level(4) __msg("stack depth 8")
>  __failure_unpriv __msg_unpriv("invalid indirect read from stack")
>  __naked void uninitialized_stack1(void)
>  {
>
> > For the curiosity of someone who doesn't know  much about this code
> > base - how come we moved from test_verifier, which seems a bit more
> > unit-test-y, do the higher level test_progs? Is it because of the
> > nicer assembly syntax?
>
> Yes, ability to use assembly syntax is the main (sole?) driver.

Not just that, test_progs by itself is a much nicer test runner for
debugging tests. It's easier to get log_level 2 logs, for example.
It's much easier to select a subset of tests to run. Plus by having
these BPF programs compiled as stand-alone .bpf.o objects, we can use
veristat to test them, bypassing test_progs altogether.

> In fact, tests that use annotations from bpf_misc.h and are registered
> in tools/testing/selftests/bpf/prog_tests/verifier.c provide almost
> the same functionality as test_verifier:
> - interface:
>   - select test to run using filter, e.g.:
>     ./test_progs -a 'verifier_basic_stack/uninitialized stack1'
>     ./test_progs -a 'verifier_basic_stack/uninitialized stack1 @unpriv'
>   - see verifier log for the test, e.g.:
>     ./test_progs -vvv -a 'verifier_basic_stack/uninitialized stack1'
> - test expectations:
>   - use __success / __failure to mark expected test outcome;
>   - use __msg to search for expected messages in the log;
>   - use __log_level to specify log level when program is loaded;
>   - use __flags to enable additional knobs, e.g. BPF_F_TEST_STATE_FREQ;
>   - use __retval if test program has to be executed;
>   - use _unpriv suffix to specify any of the above for when test is
>     executed in unprivileged mode.
>   See comments in tools/testing/selftests/bpf/progs/bpf_misc.h for detail=
s.
> - plus clang generates BTF and CO-RE relocations for us,
>   with test_verifier one has to write these things "by hand"
>   (which is only truly needed in tests for CO-RE/BTF).
>
> The only drawback is compilation time, because all test_progs/*.c
> files depend on all *.bpf.o files. Locally I mitigate this by using
> ccache: make CC=3D'ccache clang' LLVM=3D1 -j14 test_progs .
> I probably need to look at what could be done in the makefile one day.

I think if we make a push to use BPF skeletons in all tests, we should
be able to get proper dependencies between prog_tests/xxx.c and its
corresponding progs/yyy.bpf.o file(s). And at which point we should be
able to teach Makefile to only recompile relevant test files.

>
> Unfortunately neither test_verifier nor test_progs are true unit tests.

