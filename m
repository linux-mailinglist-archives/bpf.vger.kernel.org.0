Return-Path: <bpf+bounces-34954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C99340AA
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 18:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9FF1F247BB
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61534181CFA;
	Wed, 17 Jul 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vahf7Qxu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986C224FA
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234503; cv=none; b=fW8QLLhm7jvmzf5Bon6gilTCPE7QyvvL+zANeG8m8dSp0iZK5rBSxmfJPPQ8JWjAaGGa/a5PsikCjs0GMU9Ne5yjiq9OJ+VnYuxQt2zCYGDpbo5M8LLY7VmoDSgjJG0hB7pktgUQBYY1i0zyLq08pinfj5pV7PjsQkoOEqD17/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234503; c=relaxed/simple;
	bh=RaxBQssol/Q80rjniMG0eV/TikMPIDTS//0IVYneofE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+eV9rhInubO9Y59K79QUFUnT1KkLQtG3i7mQbluMxWLU/o1deB9O70qGOqrD8t1aAtS5TrT3+TJXyJMBdkStMBkZaCM/OHXoya2A5WzD2vUriaucmJ2GVLWi2IQTeL5bTQ1xIdRsD7w6Wp4qyNOoBb41PL8l7msJi+foD6SEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vahf7Qxu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso6079719b3a.3
        for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721234502; x=1721839302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkZzuR3WOS4/7n3pGxuvLp2Wl4vT2Mu/Lg4NREt+ovU=;
        b=Vahf7Qxu4eLBWYBpQBxhMclf7ml0tmD8xNKE9O8wkGJuDerV/+HBntvG/FZUXPVzTg
         dVK9hhKY30Q3hQNwDbHOifE59JpnGGiJGeV++it5JEo6wC7NRiwkdu9yDp9JSVvkIbki
         zolzCIKIbGWuV4zlk854kcSftKbVzFYTqh4VWwuyGoTnNAnFgREk+/OCtZAM5LWb41uy
         xHa3ofg7+QTnisOIDJAlwcI70Wy5x84T87EAffNJjo5qmDnaf/zq2RLR2yKTymn19gB9
         WJQNwiFDPTnZ4boKChtZIHFLGyk/FGbRk3ifN3uYmElp3IId0PKAc6dyaOMmS1LMqeW5
         pzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721234502; x=1721839302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkZzuR3WOS4/7n3pGxuvLp2Wl4vT2Mu/Lg4NREt+ovU=;
        b=jvaMDujZ65aouZUetWNCUcQ6MrkjRKCksTntQztM2H1/8Noi8J1SIbFBJsqd2sxCm0
         wWNyRW9io+3mI/ny53inJLhNYiHwiucjd5apD0YUikRqwF7t94higz1l4gfweW+NVxSP
         fLo9bVcRXpSP1YaqaOu14mh5CsY1azxQJPHgbRbROD8b2CIVF4QTb5vLc19QNcNyb5q6
         0wLoa66VdOVrUOOy9gU1hZaZmmHhT9SE+6OXzoOh29NzdDAp+3lFbmruWaekJdX7vjYO
         ZkiWqypdC0Ti8VdkhKUOLFR3JpENUxhD0vRFmO0aYBziRxLtQvh6rjvx7FQn6ZKVLnpH
         8fdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjvxfYzEi5FPjjBwwUFLkF5yRSEUO/jaFu7exArPNaI2IW37qXcwFouxjyL4AvWR7oP09vL5bkIgJnzxnqvCpszg0i
X-Gm-Message-State: AOJu0YxwRDl8OMVOVq34PSlRVB8XOsb46E4sF88qNmJXeLbIAYPuRaY9
	FLK8yCxumjYmuv1oeYjreQD5WQdVP6tygKmPWN1sDQw4iLhl1CqC4GTAhMn4YI8pCPdVPNX/zbv
	feaZ1W+w59TyaltIcQXgXEQ2z/mU=
X-Google-Smtp-Source: AGHT+IFo3tTKmBJk6Fy7GyB1XUkPcqa/r8xD4gpndyeMddRCIjvJdIN1FpRuEiA6ok1i+vU4tsYeGdcWUFFFOgmSy+s=
X-Received: by 2002:a05:6a21:32a1:b0:1be:c1c0:b8de with SMTP id
 adf61e73a8af0-1c3fddb404cmr2893914637.42.1721234501595; Wed, 17 Jul 2024
 09:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
 <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net> <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
 <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
 <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com>
 <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com>
 <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com>
 <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me>
 <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com> <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com>
In-Reply-To: <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Jul 2024 09:41:29 -0700
Message-ID: <CAEf4BzaLatHkXGZ5pmNSC+b5_iZKBeeGqkS-VE8SwXQySviUHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Daniel Borkmann <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 4:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sun, Jul 14, 2024 at 6:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.m=
e> wrote:
> > On Friday, July 12th, 2024 at 12:06 PM, Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > > So, bear with me for a moment please.
> > > We have 3 test_progs/smth.c files that depend on a few .bpf.o files a=
t runtime,
> > > but do not include skel files for those .bpf.o, namely:
> > > - core_reloc.c
> > > - verifier_bitfield_write.c
> > > - pinning.c
> >
> > Is this an exhaustive list, or did you mean it just as an example?
>
> My bad, I looked only at the tests that failed on CI, there are indeed
> more dependencies.
>
> On Mon, 2024-07-15 at 10:44 -0700, Andrii Nakryiko wrote:
> > But I think the right direction is to get rid of file-based loading of
> > .bpf.o in favor of a) proper skeleton usage (lots of work to rewrite
> > portions of file, so not very hopeful here) or b) a quick-fix-like
> > equivalent and pretty straightforward <skel>___elf_bytes() replacement
> > everywhere where we currently load the same bytes from file on the
> > disk.
>
> I don't really see a point in migrating tests to use skels or
> elf_bytes if such migration does not simplify the test case itself.

Hm... "simplify tests" isn't the goal of this change. The goal is to
speed up the build process (while not breaking dependencies). So I
don't see simplification of any kind as a requirement. I'd say we
shouldn't complicate tests (too much) just for this, but some light
changes seem fine to me.

> By test simplification I mean at-least removal of some
> bpf_object__find_{map,program}_by_name() calls.

Some tests are generic and need (or at least are more natural)
lookup-by-name kind of APIs. Sure we can completely rewrite tests, but
why?

>
> I looked through the grep results and sorted those into buckets:
> - test changes don't simplify anything:

[...]

> Given the large number of test cases that don't seem to benefit from
> skel rework, I think we would need to handle direct dependencies
> somehow, e.g.:
> - by writing down these dependencies in the makefile, or

meh, if we can avoid this

> - by adding "fake" #include <smth.skel.h>, or

sure, "good enough"

> - by adding "true" #include <smth.skel.h> and using elf_bytes, or

better, because we actually have compile-time check that those
skeletons are used (and all necessary skeletons are used)

and with minimal code and logic changes

> - by adding a catch-all clause in the makefile, e.g. making test
>   runner depend on all .bpf.o files.

do we actually need to rebuild final binary if we are still just
loading .bpf.o from disk? We are not embedding such .bpf.o (embedding
is what skeleton headers are adding), so why rebuild .bpf.o?


Actually thinking about this again, I guess, if we don't want to add
skel.h to track precise dependencies, we don't really need to do
anything extra for those progs/*.c files that are not used through
skeletons. We just need to make sure that they are rebuilt if they are
changed. The rest will work as is because test runner binary will just
load them from disk at the next run (and user space part doesn't have
to be rebuilt, unless it itself changed).

>
> On Mon, 2024-07-15 at 10:44 -0700, Andrii Nakryiko wrote:
> > see above, elf_bytes is a quick and dirty way to get rid of file
> > dependencies and turn them into .skel.h dependency without having to
> > change existing tests significantly (which otherwise would be tons of
> > work).
>
> I assume that the goal here is to encode dependencies via skel.h files
> inclusion. For bpf selftests presence of skel.h guarantees presence of
> the freshly built object file. Why bother with elf_bytes rework if
> just including the skel files would be sufficient?

see above, just because there is no guarantee that we use all the
dependencies and we didn't miss any. It's not a high risk, but it's
also trivial to switch to elf_bytes.

another side benefit of completely switching to .skel.h is that we can
stop copying all .bpf.o files into BPF CI, because test_progs will be
self-contained (thought that's not 100% true due to btf__* and maybe a
few files more, which is sad and a bit different problem)

>
>   ---
>
> The catch-all clause in the current makefile looks as follows:
>
>     $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:                      =
       \
>                      $(TRUNNER_BPF_PROGS_DIR)/%.c                       \
>                      $(TRUNNER_BPF_PROGS_DIR)/*.h                       \
>                          ...

keep in mind that we do want to rebuild .bpf.o if libbpf's BPF-side
headers changed, so let's make sure that stays (or happens, if we
don't do it already)

>
> This makes all .bpf.o files dependent on all BPF .c files.
> .bpf.o files rebuild is the main time consumer, at-least for me.
>
> I think that simply replacing this catch all by something like:
>
>     $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_BPF_OBJS)
>
> on top of v2 of this patch-set is a good stop gap solution:
> it is simple, explicit and brings most of the speedup.
> People rebuilding test_progs would only pay for compilation of BPF
> object files that had been changed.
>
> ---
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 557078f2cf74..11316ccb5556 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -628,13 +628,16 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
>         $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
>  endif
>
> +# some X.test.o files have runtime dependencies on Y.bpf.o files
> +$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_BPF_OBJS)
> +
>  $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                      \
>                              $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)           \
>                              $(RESOLVE_BTFIDS)                          \
>                              $(TRUNNER_BPFTOOL)                         \
>                              | $(TRUNNER_BINARY)-extras
>         $$(call msg,BINARY,,$$@)
> -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> +       $(Q)$$(CC) $$(CFLAGS) $$(filter-out %.bpf.o, $$(filter %.a %.o,$$=
^)) $$(LDLIBS) -o $$@
>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpft=
ool \
>                    $(OUTPUT)/$(if $2,$2/)bpftool

