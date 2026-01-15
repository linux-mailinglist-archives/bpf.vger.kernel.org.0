Return-Path: <bpf+bounces-79158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5C9D28FE4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 23:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DA5D30155B8
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 22:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E616326D76;
	Thu, 15 Jan 2026 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZ1oOGbM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68A32B989
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515747; cv=pass; b=bt6V8DsxjWaYWcom0Z8XMvctHSnj+lxeKy6UdHiiWbGQvippQ9nnYWNuFkY1qBdZoVFF+kQ5Kontw4eEN8A/XTSUSZ0Nd/bHh/wtsZUwSaIyIm+U6I4tzbFTQE2ScMqU40yyUYcfiehoNUT6vwIDlZ1tTKkhYFg3pFnvIWbwy+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515747; c=relaxed/simple;
	bh=VIy1Q8milCuilP3slxmurMD3rEK+67+tZNWfcYAVup8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUSSuGpTH/laNaTzXUYjomaDQkkX7ZVIoscnQ7hi82D1LQkGbiNQaclZZCEJYgwx5dR3Smn0HC01hM5WVPR/63IL05XdRcZRzu8tMdQqO+ahbMuPw4uRIoDn+uBHJn+hm9GEdQQzJydd1Iodt+uISbp8wIcybQFmeTdy/Fq5m6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZ1oOGbM; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12448c4d404so590192c88.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 14:22:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768515745; cv=none;
        d=google.com; s=arc-20240605;
        b=OguUdV0EXEBbxpoHJp4trXNPaV+qrKVkXvrNPwOZJ96CT9Npn1siIJ8wpIQFuYOqew
         qpSyDP8lzKDadbKaE535XSgrsk0pCDMzh6AnD5fPvr1AU2EnO0XKsK6EwLpAO4VcQ5wP
         m5CWm5cJ6s31oFDFpjZ/W3axJYgnyrWq5cJ9irD5ai8ukW/NPrVGwf7ebRE+NTcPACWk
         YYqPJEe+XHCn9ufCX4ZkTKMUWjm37HygMLdBFSHqAoeP3HDzFB4VCdnZkJBU2QZRLLa2
         fFq4q6/fPiYZaAb1E4LOoeKL1wFgEEd5afh6LWjtJ65rfa0xny+ky/cNlOujcXrAl01m
         eEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bOdEX2nl6dOcolz0WUJ8w7YaXy8Vlz+kPHYpmxNadlo=;
        fh=C3/co0Nq1M4oVsuyX0JlZaSUsrhODhKB0J+dEQ9QwFM=;
        b=JnEOu+kUXaYMJIJ73gqOBudhxXHJBCQu2417hKeq/BPoxkoUgJYQMxnG0tyyEoVSAd
         wKDPhsWVdtiwAgyKaAvq5l1Zo4OXpmvgCv/Y7IfRwNrVFq8k2BuZSWv7vDSia89WE0qd
         QgUznujWoxEJUevVkPljrZP65ZawT/h4KE9h6zMwjTckz5cT5Eouj+ohBRRuuxYkCx9t
         vIfw9/xGde9MnRB/LbAE0h+bomk6YDaeCXrag0IuS2VRykVvPS3LCE+BdhJ3DkQL0r3z
         H6uzgPZMEzgXQcpzjEy4zAKl8xo7JTF/yraQtGqtFf3xiFJo9NF4fF9hoFnJ08v1tpaB
         9YkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768515745; x=1769120545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOdEX2nl6dOcolz0WUJ8w7YaXy8Vlz+kPHYpmxNadlo=;
        b=VZ1oOGbMVLIzXyhEmApyz5uPjOGLnvTSGXwTHZYjyk10UcRW4sM0pFKTV6XWZKhvK1
         FOLggbKzjMYb20yYn2CmDFmu72G3NL1IqU9W8DCt86q8x17NjBD0CrXKM4/N3D0vsMEV
         Ln3ptiPAKE6voYCFcRJj+2MDUAVsrSiSsF4VKF+N9pMYobgLfMtVYGz061eKzWyEMqx/
         OCeP8eWgihn7Z6BhaEREKB/oWdDcMqHB9FrJsmRZRFSlDeSP7XwN+YTEDz4A05/IfzjY
         P44W3aKJ4OfUrX6qEhwf8wOWMlHDgg/OKXmo6VoHCY9T1B2Ftl8NNIv7pi9KDlRgpOh5
         oMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515745; x=1769120545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bOdEX2nl6dOcolz0WUJ8w7YaXy8Vlz+kPHYpmxNadlo=;
        b=LjtxHY2ebKlYwM6f9PGU6X0fB9j1rLjFMrnRek+tjyxR8fj4GktEr8ojFKWjyRHkJC
         p1C5yFIlXqMjoml2DHooN9+NzDAMens0HI8nGRLn4BzYMB7xzO+vU5idPnThyNDuzvnL
         OafA3o2wKpXmPknDb3zzMHpkw8YpcaitEJhNGKsflPOCSWSfDM97rU1IP2Y/a9Px5r/j
         9qZdC94yJUGwdb20xpl39Jx3N1o1Y1zI/BGkM5wokH0JnPEXOpDGJkmkHXKJYw4A5TpW
         5Awi51XGHQQS+hCClM5RHfeliN8F6zco8kuXH/3FlOUEO+vgrIZmUy97Qo/PtN/MmEbo
         Khfw==
X-Forwarded-Encrypted: i=1; AJvYcCXn0LsGwObIIMxa5ydHgklubqULT2M/A6xH3g07//rOKm5kjLtu2v/8aBM2l721cYbps/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWQNceNyltrOAdoRRnZ37OCNIQZKWP/P91sCCnQ0H8MsEfzW1
	MynMxf4+SL18W2upkgT9Wcmer0nTpq0vAXK9R3YrdxIT0YKfFJlapVqdZBQ/c9yVwODZ3HwA/5h
	3Dd/vvim2rFmgy8QtBHPhwN7RUJhDM/iahi3H++5Q
X-Gm-Gg: AY/fxX4iQBG2RJDB4ToLeom4/ihhpGwmsOEKCbnUAbij0878tQr7+NjNLMYuHOO4Lv+
	jwUjDkrSCHFgoeFV8+7BpKN4FPxK5IL37Frn5KhWwSgILylMO2BodQwDXKuUnJDWr+q39+zW9Th
	6MJtugSSkgzP9tyByWzKs8+AtvEjw4XPh72RrbAwrzjMX9DDtitAntA/vwcInIUKUM7WNHC0ZFt
	Fe1LMpj8u/HFmW3OlifWAGIzp715fvOBqDo1Rz8/ZuKxd1iV1JI4cHDFj7Ky33XdMWeQ4jE/hOM
	yfj7M2lQzG62oWKpij1bLjEKVNg=
X-Received: by 2002:a05:7022:e14:b0:119:e55a:9bf5 with SMTP id
 a92af1059eb24-1244a72e2e9mr1494822c88.17.1768515744755; Thu, 15 Jan 2026
 14:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114183808.2946395-1-alan.maguire@oracle.com>
 <20260114183808.2946395-2-alan.maguire@oracle.com> <CAEf4BzZruKmtcwK+V_qT8RcaXpp3=GXaZaiQtK4OchSR8Ye4Yg@mail.gmail.com>
 <5886e8c8-7646-4686-91b7-185cc953be20@oracle.com> <CANpmjNPJfmN57BsZknURkPG+1__1CsxW3zk+gpWS83c1diKstg@mail.gmail.com>
 <7b09d0ce-9d4a-439a-969a-24b808f76b30@oracle.com> <b0d768b9-5a5a-461b-b931-850b56dc5d9b@oracle.com>
In-Reply-To: <b0d768b9-5a5a-461b-b931-850b56dc5d9b@oracle.com>
From: Marco Elver <elver@google.com>
Date: Thu, 15 Jan 2026 23:21:48 +0100
X-Gm-Features: AZwV_QhxEQCOVcP-xcRaB1IQCYlDSafBs6LO8-dUaPHDwRtZD3H7XVo0smqjG0A
Message-ID: <CANpmjNPuDq9rXGPSu4x=ACEzz2vESpddHhY98PDiAbjj2vXK-Q@mail.gmail.com>
Subject: Re: KCSCAN and duplicate types in BTF [was Re: [PATCH bpf v2 1/2]
 libbpf: BTF dedup should ignore modifiers in type equivalence checks)]
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org, yonghong.song@linux.dev, 
	nilay@linux.ibm.com, ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, bvanassche@acm.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 at 22:44, Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 15/01/2026 19:11, Alan Maguire wrote:
> > On 15/01/2026 18:55, Marco Elver wrote:
> >> On Thu, 15 Jan 2026 at 19:36, Alan Maguire <alan.maguire@oracle.com> w=
rote:
> >>>
> >>> On 15/01/2026 17:50, Andrii Nakryiko wrote:
> >>>> On Wed, Jan 14, 2026 at 10:38=E2=80=AFAM Alan Maguire <alan.maguire@=
oracle.com> wrote:
> >>>>>
> >>>>> We see identical type problems in [1] as a result of an occasionall=
y
> >>>>> applied volatile modifier to kernel data structures. Such things ca=
n
> >>>>> result from different header include patterns, explicit Makefile
> >>>>> rules, and in the KCSAN case compiler flags.  As a result consider
> >>>>> types with modifiers const, volatile and restrict as equivalent
> >>>>> for dedup equivalence testing purposes.
> >>>>>
> >>>>> Type tag is excluded from modifier equivalence as it would be possi=
ble
> >>>>> we would end up with the type without the type tag annotations in t=
he
> >>>>> final BTF, which could potentially lead to information loss.
> >>>>>
> >>>>> Importantly we do not update the hypothetical map for matching type=
s;
> >>>>> this allows us to match in both directions where the canonical has
> >>>>> the modifier _and_ when it does not.  This bidirectional matching i=
s
> >>>>> important because in some cases we need to favour the modifier,
> >>>>> and in other cases not.  Consider split BTF; if the base BTF has
> >>>>> a struct containing a type without modifier and the split has the
> >>>>> modifier, we want to deduplicate and have base type as canonical.
> >>>>> Also if a type has a mix of modifier and non-modifier qualified
> >>>>> types we want it to deduplicate against a possibly different mix.
> >>>>> See the following selftest for examples of these cases.
> >>>>>
> >>>>> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638=
d@linux.ibm.com/
> >>>>>
> >>>>> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> >>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>>> ---
> >>>>>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++---------
> >>>>>  1 file changed, 26 insertions(+), 9 deletions(-)
> >>>>>
> >>>>
> >>>> Alan,
> >>>>
> >>>> I do not like this approach and I do not want to teach BTF dedup to
> >>>> ignore random volatiles. Let's either work with KCSAN folks to fix
> >>>> __data_racy discrepancy or add some option to pahole to strip
> >>>> volatiles (but not by default, only if KCSAN is enabled in Kconfig)
> >>>> before dedup (and thus we can't do that in resolve_btfids,
> >>>> unfortunately; it has to go into pahole).
> >>>>
> >>>
> >>> Okay, I think the former would be the better path if possible; cc'ed =
Marco
> >>> who introduced __data_racy with commit
> >>>
> >>> 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qual=
ifier")
> >>>
> >>>
> >>> ...and Bart is already on the cc list. Feel free to include anyone
> >>> else who might be able to help here.
> >>>
> >>> The background here is that in generating BPF Type Format (BTF)
> >>> info for kernels we are hitting a problem since a few structures
> >>> use __data_racy annotations for fields and these structures are compi=
led
> >>> into both KCSAN and non-KCSAN objects. The result is some have a vola=
tile
> >>> modifier and some do not, and we wind up with a bunch of duplicated
> >>> core kernel data structures as a result of the differences, and this
> >>> creates problems for BTF generation.
> >>>
> >>> Perhaps one way out of this would be to have an unconditional __data_=
racy
> >>> definition specific for struct fields
> >>>
> >>> #define __data_racy_field       volatile
> >>>
> >>> ...and use it for the two cases below?
> >>>
> >>> By having that defined regardless of whether KCSAN was enabled or not=
,
> >>> and using it for struct fields (while leaving variables intact) we
> >>> can sidestep the problem from the BTF side. Would that work from the
> >>> KCSAN side and for the fields in question in general?
> >>>
> >>>> Furthermore, it seems like __data_racy is meant to be used with
> >>>> *variables*, not as part of *field* declaration ([0]), so perhaps it
> >>>> was a mistake to add those to fields. Note, there are just *TWO*
> >>>> fields with __data_racy:
> >>>>
> >>>> include/linux/blkdev.h
> >>>> 498:    unsigned int __data_racy rq_timeout;
> >>>>
> >>>> include/linux/backing-dev-defs.h
> >>>> 174:    unsigned long __data_racy ra_pages;
> >>>>
> >>>
> >>> Not sure, the original commit above gives a struct field annotation
> >>> as an example. Anyway hopefully we can find a workable solution.
> >>
> >> By "KCSAN enabled or not", I assume you mean in KCSAN kernels only? We
> >
> > I should have clarified this, sorry; I meant _within_ a KCSAN kernel wh=
ere
> > some objects opt out of KCSAN with KCSAN_SANITIZE like
> >
> > KCSAN_SANITIZE_slab_common.o :=3D n
> >
> >> should _not_ define __data_racy as volatile outside KCSAN kernels, as
> >> that's not what __data_racy is for and would have other unintended
> >> consequences. KCSAN just knows to treat "volatile" specially, which is
> >> why it's used like it is here, but otherwise explicit volatile
> >> variables are a no-no in general.
> >>
> >> Right now we have this in include/linux/compiler_types.h:
> >>
> >> #ifdef __SANITIZE_THREAD__
> >> ... other defs that should remain untouched ...
> >> # define __data_racy volatile
> >> #else
> >> ...
> >> # define __data_racy
> >> #endif
> >>
> >> But perhaps that should be moved to a separate #ifdef block:
> >>
> >> #ifdef CONFIG_KCSAN
> >> # define __data_racy volatile
> >> #else
> >> # define __data_racy
> >> #endif
> >>
> >> ... with an explanation why (consistent definitions across
> >> instrumented and uninstrumented source files), and why it's benign for
> >> uninstrumented code in KCSAN kernels (behaviour unchanged, but subtle
> >> performance loss, although it's an already instrumented kernel so
> >> performance is moot anyway). I think that should work, but it needs
> >> some testing.
> >>
> >> Could you test something like that?
> >>
> >
> > I'm pretty sure that would work; let me try it out. Thanks!
> >
>
> yep, the below change resolved the problem. I can submit it with a
> Suggested-by: from you if that works? Thanks!

Looks good, thanks!

> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index d3318a3c2577..86111a189a87 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -303,6 +303,22 @@ struct ftrace_likely_data {
>  # define __no_kasan_or_inline __always_inline
>  #endif
>
> +#ifdef CONFIG_KCSAN
> +/*
> + * Type qualifier to mark variables where all data-racy accesses should =
be
> + * ignored by KCSAN. Note, the implementation simply marks these variabl=
es as
> + * volatile, since KCSAN will treat such accesses as "marked".
> + *
> + * Defined here because defining __data_racy as volatile for KCSAN objec=
ts only
> + * causes problems in BPF Type Format (BTF) generation since struct memb=
ers
> + * of core kernel data structs will be volatile in some objects and not =
in
> + * others.  Instead define it globally for KCSAN kernels.
> + */
> +# define __data_racy volatile
> +#else
> +# define __data_racy
> +#endif
> +
>  #ifdef __SANITIZE_THREAD__
>  /*
>   * Clang still emits instrumentation for __tsan_func_{entry,exit}() and =
builtin
> @@ -314,16 +330,9 @@ struct ftrace_likely_data {
>   * disable all instrumentation. See Kconfig.kcsan where this is mandator=
y.
>   */
>  # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumenta=
tion
> -/*
> - * Type qualifier to mark variables where all data-racy accesses should =
be
> - * ignored by KCSAN. Note, the implementation simply marks these variabl=
es as
> - * volatile, since KCSAN will treat such accesses as "marked".
> - */
> -# define __data_racy volatile
>  # define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
>  #else
>  # define __no_kcsan
> -# define __data_racy
>  #endif
>
>  #ifdef __SANITIZE_MEMORY__
>

