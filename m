Return-Path: <bpf+bounces-61759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9790AEBDBB
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 18:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B222188D0A5
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 16:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609332EA17A;
	Fri, 27 Jun 2025 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jq6rD8SK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D72E8E02
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042656; cv=none; b=QW6udsCIzALHZSYp1Dq+oyC2KZYMTg4baUNdfG0kzXymd+RdtKg5Cl62gPHCt6TLHFid+Bza+fWUXzyUo16jng5u8Ht3pBTJ2K6iBV02AP1gaCDz+ZnGjs0yvUR3INS00CkSSXs5u627bJLyB+cC5OWpoM1C/laio3fle9UAdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042656; c=relaxed/simple;
	bh=9s1eA5KwrVKwd9rWss4PkqOIrDE9CSV2z3UbUlBIJKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdXdMe4r2NElW0g+9ZQJWI/fMgkWuIg8so8jyfOFDI1qBsgqYkkWvmuZ4nS6qKJeFTBR5bcfMWrQlCBJ4uvBJI53Jo8CpniiPFqzvl2584R4t6cGYFhmQu3ha77Fm5bEk8UhPASDbx7iIJlrCXl02SGUQ5Jh3NHUCnL0cCMZOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jq6rD8SK; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so11565ab.0
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751042654; x=1751647454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s1eA5KwrVKwd9rWss4PkqOIrDE9CSV2z3UbUlBIJKE=;
        b=jq6rD8SKGMCuNrME36sTI/KFxTM6BEo9gz10KGTulZJX15CnBpQeqPwEfLgn7UvNM5
         z5eYtyWDfBRa+paGJaoZrIC0+xhm/fixddafEGda+guF9nWAEK3SqurXBqHh99Fx5XnW
         h3OuI80idTCaK0tp9DnCEktDZWr8eRJPpa1S+8RX9gtYeXOw7lk9ofRil0r2suRga7Fo
         JuGNUv5p8OtosmXC/4z0UQ3YZkS3Mmk0ea+XSJnvu20K+8BRtR3hlFxW6QGsTlHzHOUZ
         qgGlHEVwanPmkQBqpnqpH6vRV3S9M6B3ZfqQGQd+fHUu2qROuwUtF5NpJbpI2/ssibdS
         y+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751042654; x=1751647454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s1eA5KwrVKwd9rWss4PkqOIrDE9CSV2z3UbUlBIJKE=;
        b=prTWDB7jQG8k9QxL3d3XZ2FUuB2Zk/tP+iVIfJd1nf8N7CXXJHCT9Wz+vs/47hDxAC
         t704p9SXtL8ZJcJlblP46gvwQaFeuc5DazAEasIYcABLR8nndf2LPTcmgBZOo1jR7JEL
         yz49bww5sKQ7MLUqO9JdJ2HfdipTv81FKdlyaMPfuQXs/02XGnXlx9rJWpZ1CGcP6+N7
         s5YMhv91/H5qd8LdE+kKFdiokuFWU+KZa2fq8NUkgVgS2s2nU60ILDLHoEAEuYI7NsPW
         xxdd736/0BQoC+hewfcPcnDWW5LutFBq8IJEA/CAZN/uK57uorXe+ZMO2Zd5+0pTgWym
         HuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoc/4B+I2rWcHzFbIJKBgvrDHJBNgosHCWbCW9yM2jAOtt5vzt1oCGrNe6y8dXBN30Zoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeCV86v2gbvL8bwVcdr0xJFeZ0cJnkjCaLIH1ksCD407GhvFk
	9Edz0sDZV7fN3NGYTC7pYWgz0gJ2SwsuFwNtMMPsUnqrqlyBZVZa09fIHSWeVQRfr1dlYmxLG87
	s8PqZnf1nqlvAC0aPk12xusTZWByzbD+uom1cDG7Q
X-Gm-Gg: ASbGnctIzWKVGsPpnZwSsESq3SUiM8ZZxTyQ0H7C0kwwBeSOTVoYfIdXgZEdvHNTV3k
	3tm9xV1Xf50xf9UYIevW99ISoushoJ/YifdNZnoUzaFECoVlY1AjR2WgtGF4HNEurNQDUJh8z6W
	HeaiF/X+DTlxnmpOYUtWtiqCC2oZF+243jOY7kXaFS+lcL
X-Google-Smtp-Source: AGHT+IHvztp7L1kXPm4qHzp2aVdvq9iPLHibmjsOFDZjxgx47/40qOE255pl9PfqbsmBA2gt1yngKEvvPvtuRKfJNak=
X-Received: by 2002:a05:6e02:1a68:b0:3dc:88ca:5eb5 with SMTP id
 e9e14a558f8ab-3df53bb8ab1mr524965ab.1.1751042654180; Fri, 27 Jun 2025
 09:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com> <20250417230740.86048-7-irogers@google.com>
 <aF3Vd0C-7jqZwz91@google.com> <CAP-5=fV4x0q7YdeYJd6GAHXd48Qochpa-+jq5jsRJWK36v7rSA@mail.gmail.com>
In-Reply-To: <CAP-5=fV4x0q7YdeYJd6GAHXd48Qochpa-+jq5jsRJWK36v7rSA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Jun 2025 09:44:02 -0700
X-Gm-Features: Ac12FXxK697QImT-ty4XbntVKcoV6r674s1RbV5RKCu1qYoOEhu-OUGYgs394-o
Message-ID: <CAP-5=fXLUO3yvSmM4nSnNV_qQGGLP_XTcfPgOhgOkuaNnr3Hvw@mail.gmail.com>
Subject: Re: [PATCH v4 06/19] perf capstone: Support for dlopen-ing libcapstone.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:53=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jun 26, 2025 at 4:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Thu, Apr 17, 2025 at 04:07:27PM -0700, Ian Rogers wrote:
> > > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT=
,
> > > support dlopen-ing libcapstone.so and then calling the necessary
> > > functions by looking them up using dlsym. Reverse engineer the types
> > > in the API using pahole, adding only what's used in the perf code or
> > > necessary for the sake of struct size and alignment.
> >
> > I still think it's simpler to require capstone headers at build time an=
d
> > add LIBCAPSTONE_DYNAMIC=3D1 or something to support dlopen.
>
> I agree, having a header file avoids the need to declare the header
> file values. This is simpler. Can we make the build require
> libcapstone and libLLVM in the same way that libtraceevent is
> required? That is you have to explicitly build with NO_LIBTRACEEVENT=3D1
> to get a no libtraceevent build to succeed. If we don't do this then
> having LIBCAPSTONE_DYNAMIC will most likely be an unused option and
> not worth carrying in the code base, I think that's sad. If we require
> the libraries I don't like the idea of people arguing, "why do I need
> to install libcapstone and libLLVM just to get the kernel/perf to
> build now?" The non-simple, but still not very complex, approach taken
> here was taken as a compromise to get the best result (a perf that
> gets faster, BPF support, .. when libraries are available without
> explicitly depending on them) while trying not to offend kernel
> developers who are often trying to build on minimal systems.

Fwiw, a situation that I think is analogous (and was playing on my
mind while writing the code) is that we don't require python to build
perf and carry around empty-pmu-events.c:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/empty-pmu-events.c?h=3Dperf-tools-next
It would be simpler (in the code base and in general) to require
everyone building perf to have python.
Having python on a system seems less of a stretch than requiring
libcapstone and libLLVM.

If we keep the existing build approach, optional capstone and libLLVM
by detecting it as a feature, then just linking against the libraries
is natural. Someone would need to know they care about optionality and
enable LIBCAPSTONE_DYNAMIC=3D1. An average build where the libraries
weren't present would lose the libcapstone and libLLVM support. We
could warn about this situation but some people are upset about build
warnings, and if we do warn we could be pushing people into just
linking against libcapstone and libLLVM which seems like we'll fall
foul of the, "perf has too many library dependencies," complaint. We
could warn about linking against libraries when there is a _DYNAMIC
alternative like this available, but again people don't like build
warnings and they could legitimately want to link against libcapstone
or libLLVM.

Anyway, that's why I ended up with the code in this state, to best try
to play off all the different compromises and complaints that have
been dealt with in the past.

Thanks,
Ian

