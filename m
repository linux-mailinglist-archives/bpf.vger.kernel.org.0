Return-Path: <bpf+bounces-78759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B097D1B78E
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 22:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00733301330B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119934F486;
	Tue, 13 Jan 2026 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUxBuetq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2B2F0673
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340923; cv=none; b=TE59SgGqgkya+JSvaNKm//Uq49Oxx/AzNjCgogzCCciGOkUYgWXcdnMvABBgSUFNSzNahNMyR8RaH9Z4QLcRVTme8NOSh2D30BH1jAnX7BRUwhjY8yzUsGlPXpu+iWzOQDuivgbKu1XibW+0tmaxTI5BAgMmj3VjWgJgrM5RObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340923; c=relaxed/simple;
	bh=aErz8emqgeCpQtkjg9AsSfwVcW8uVHHhVnL68m3sTbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZVKk3ObGDC2/guR2oMcbAjkIAFXbkxTdLfBcdlN34eWFRGQnGhUigaCMpznJZRoDL9OkWC8tIgOELV3pBJ3ShNAu9BERVzDUnOEniAqHrGsxMFbet7AoDao1nVvbpNUjQiBJkcyLQjiA7wCd4NKLRvaqtfs5cSeEBBjukVnaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUxBuetq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c718c5481so4371061a91.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 13:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768340922; x=1768945722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RFNh+HDYy9tOBUkdGcS+1QynsmwkEBfw+8yeTkYEJ8=;
        b=bUxBuetq0IYgpZJLdO6a8EZApFFdAT6mm60HH9JPPZgs/yAc8hN52uG1F2meDpTZvs
         QZohlYXb4D8xVEhwjn8DAJ1Oxiqo+vc8p2tHySEnlRiILxkCr8KPIfzyi1Q5QvJxmQmN
         Rn2L0nZpu5zdEUIOWOrnz64Pzw8YdTnQDK710ogRCbiqxoohsacjDcC5WwHC4PtylOd4
         DkNLrsFDMwr993untC8JJuvGRCfy37jdNSGybnqaOmQgHzyDDnbDrW6SmWYYhIUy3wfg
         JorcdGTcHIM6OI7Og95Dpoy44jvSxeho2e7ADGuFn90q4cB/y+WHcKQmvrENuMssnCZn
         Oz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768340922; x=1768945722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4RFNh+HDYy9tOBUkdGcS+1QynsmwkEBfw+8yeTkYEJ8=;
        b=VnzvM/tImYXSDzMZbrvwoyUAAKHsTs6LdU9IasKdBfoiL2lVomNrLRPFOPeVRCPKnB
         bgsBG68k7uCEQ2mTEbdBHra1NtHt+tngVRQXbvK5koYEbplp33ToE9xsHpKDvL3woJyk
         z9gxNQi4q3hWaYjAQ82u1lWs/QFhWhTAbNzikfRV6V1WTImbUgCPTdMc75sEWMH0u7Tr
         spBOJh7Hn8IrBqv5Y/iXjDPUpOT/qQZyqZbgfdJnIW1BWTYWQlP94gaQJeBeOwtps6G1
         U25Eu5hbzH/PjoPSLYJKQMl5llzhYTE5ezrmQNJ0cZtMPJeJ0aTIg46Vd1PKWPxyhWOc
         JHYg==
X-Forwarded-Encrypted: i=1; AJvYcCVocgOzmq/28TPz5OMVBixqiROV9IDAx5HwYw2K8YT74fzHOxBmJer2iTQJ4nnBVfT3HBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhvaA2SrwyVZ0+rA5qCEg5bRT61UPZKtem63sZYfzuulCU2rh
	Eon6ETV4S9cJGAWaFu6aqpxiHDQYewWT8ar0blvuhfJd1uytQfwg81ShxYenDiX4Jgybi0Hca+8
	q0qAL94rH3IRn4QK+uN0GQvR+5KuztcI=
X-Gm-Gg: AY/fxX67DoH3Kod20g5cK3IctENkf7oZVbiE/h6WEVv3E3Moay69Abh+H3qHkja//on
	yGPJ5DUH0u3Yg5/VolYTk1t9jGh2J8sYsyYfdBQCTmGi5SOEihG+UMeGaa8wUSbAwW1X0zUD4+Z
	9o98J9wqhCj9MOiITMghM/eSkJgHB2s8eMFBltJSZsEFjKIKYsQyDiq104cH/0IUOxcrE+hJhSl
	kEiv7zP00We/1tbiahlQu47bjD/yHY134b/igp1nsXaw3yi/jRAEFSxKyFeUGS4Vj2PIq4U684n
	ygzAElFCzuA+X2hkUnk4iQ==
X-Received: by 2002:a17:90b:56d0:b0:34e:63c1:4a08 with SMTP id
 98e67ed59e1d1-35109129c68mr482532a91.20.1768340921572; Tue, 13 Jan 2026
 13:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109101325.47721-1-alan.maguire@oracle.com>
 <CAEf4Bzaysi-ji0Q2m=6Fc0YTPnrKVOPDNoQW9Y6rB03R4Pe3aw@mail.gmail.com> <9594c48f-1651-4448-b8e1-5a8a07f64108@oracle.com>
In-Reply-To: <9594c48f-1651-4448-b8e1-5a8a07f64108@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 13:48:29 -0800
X-Gm-Features: AZwV_QgW1RHhSdmoO18Yw2tx5X-Xm6B2-eAoZ0pUuLrW8TZ3qu5iJrQRXsHy0_0
Message-ID: <CAEf4BzZzPRwEYqDotyHPTY9Djnk+PC1aBXeKKH2gtRqnp6e=VQ@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: BTF dedup should ignore modifiers in type
 equivalence checks
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, nilay@linux.ibm.com, 
	bvanassche@acm.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:05=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 09/01/2026 17:28, Andrii Nakryiko wrote:
> > On Fri, Jan 9, 2026 at 2:14=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >>
> >> We see identical type problems in [1] as a result of an occasionally
> >> applied volatile modifier to kernel data structures. Such things can
> >> result from different header include patterns, explicit Makefile
> >> rules etc.  As a result consider types with modifiers const, volatile
> >> and restrict as equivalent for dedup equivalence testing purposes.
> >>
> >> Type tag is excluded from modifier equivalence as it would be possible
> >> we would end up with the type without the type tag annotations in the
> >> final BTF, which could potentially lead to information loss.
> >
> > Hold on... I'm not a fan of just randomly ignoring modifiers in BTF
> > dedup. If we think volatile is not important, let pahole just drop it.
>
> It's important to stress that the final BTF representation doesn't ignore
> the volatile modifier; in fact it is included in the final BTF for the tw=
o
> cases where __data_racy is used in a structure (in structs backing_dev_in=
fo
> and request_queue). See my response to the AI bot for the reason we weigh=
t
> towards choosing the more complete type as canonical.

I'm probably very slow, but I don't see how we actually consciously
pick a fuller type definition as canonical. You have symmetrical
single-level modifier stripping for both canon and cand types. So I
don't see what prevents us from saying that `int` is the canonical
type for `volatile int` and never really have `volatile int` in a type
chain anymore.

Symmetry that you mentioned doesn't help here either, because we will
declare success on the first lucky match, regardless of which side is
volatile on (candidate or canonical).

So if we at all do this, we need to only strip modifiers on the
canonical side, so that cand=3D`volatile int` never matches canon=3D`int`,
but eventually they flip order and cand=3D`int` does match to `volatile
int`.

But even that gives me pause, because hypot_map on successful type
graph match will stop being "hypothetical" and will be real
(btf_dedup_merge_hypot_map), and so all `int`'s within that
compilation unit will suddenly become "volatile int".

It's just a mess. If volatile is not important, I'd rather have pahole
strip it out completely for the kernel (as an extra option). *That* I
can at least reason about in terms of consequences. While with your
patch I can't convince myself we are not introducing subtle problems.

>
> > I think BTF dedup itself shouldn't be randomly ignoring information
> > like this.
> >
> > Better yet, of course, is to fix kernel headers to not have mismatched
> > type definitions, no?
> >
>
> Of course, but these are not mutually exclusive activities. Some issues
> like [1] admit to such a fix fairly easily.
>
> In this specific case however the __data_racy annotation definition depen=
ds
> on __SANITIZE_THREAD__ which is set via compiler flag, and there are case=
s
> where KCSAN is deliberately disabled; from scripts/Makefile.lib:
>
> #
> # Enable KCSAN flags except some files or directories we don't want to ch=
eck
> # (depends on variables KCSAN_SANITIZE_obj.o, KCSAN_SANITIZE)
> #
> ifeq ($(CONFIG_KCSAN),y)
> _c_flags +=3D $(if $(patsubst n%,, \
>         $(KCSAN_SANITIZE_$(target-stem).o)$(KCSAN_SANITIZE)$(is-kernel-ob=
ject)), \
>         $(CFLAGS_KCSAN))
> # Some uninstrumented files provide implied barriers required to avoid fa=
lse
> # positives: set KCSAN_INSTRUMENT_BARRIERS for barrier instrumentation on=
ly.
> _c_flags +=3D $(if $(patsubst n%,, \
>         $(KCSAN_INSTRUMENT_BARRIERS_$(target-stem).o)$(KCSAN_INSTRUMENT_B=
ARRIERS)n), \
>         -D__KCSAN_INSTRUMENT_BARRIERS__)
> endif
>
> So there's nothing to fix for such cases; for some objects, disabling KCS=
AN is
> intentional. Since some core .o like mm slab/slub files disable KCSAN, th=
e
> non-volatile fields proliferate widely.
>
> [1] https://lore.kernel.org/netdev/20251121181231.64337-1-alan.maguire@or=
acle.com/

