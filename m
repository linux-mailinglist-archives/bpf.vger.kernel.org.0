Return-Path: <bpf+bounces-28116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3048B5EA3
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC07E1F22D5E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577083CD9;
	Mon, 29 Apr 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD12vM3y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287014A8D
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407147; cv=none; b=aV5Ob+rKqjYuAozeapCNnZ1ToJ4y0xcjBzrMfmWa39RNeOJOFs45MAZbQmKhEMsvJSac6anQ97nukGC1YMDlFDbMhOcfvO2XwR7nteMuL+/aT+VYtgb6bSC0zyM5YRcOl54U9NgMEnEJvoAeOe0qcR0eWU2Ut2Oc4R4UpKFZtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407147; c=relaxed/simple;
	bh=D+h5PPeiZ2TrTwKL0bvkfSbF2Z1lQGDQ74rzuogoBwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2kEmmpwhMguRMq/nyIFDUTJSmLiLSYi0SrdVmTEoH8NKWmWYmjWmpbBj8KRwzFLyOdJMt+237TQxdoXnDaYtwfYbqBaNORNFBqLOmB1ZKc4Bf5tCQG0CVtjXvde15dl2y4asBJCwDmgiu64ED2zVU6WyDdRc02mnbne8n+cw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD12vM3y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2990776a12.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714407145; x=1715011945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9AAmlqGCXBvfkk5Wu0lxKPwRFjVZ8TOZsg5MP6VRyk=;
        b=RD12vM3yGoojYYFNNFD8qw6fshmfIoM8MA9iSLMwB2WSbgJ6G2xdTJ6iFDNcUPPnVy
         +6Rc+7TqRWgQV6y72DpaDNm+b3rC2/7UepJdku3OHF7EhQk0oMHPnN6W3Ky4QIWWLela
         n3ygsDKNTu6g0qJzuwlI7TTa/YTHGrztixel21ucHPa5vwh3+QycG0YyWRfnX0KZyzaQ
         d6oSQcikGm0MnhdM326+QIdoD9ueU6LNA4RbclbjP5DhUNdwHd1/lhAN+hQt1vA8VyR9
         eoKJP0e6xXVwW5w/invwBaFxh/yd3soYkXmY2eX9aBf6GCkUYNyQASvNWXk6S7d1ljXe
         /xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714407145; x=1715011945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9AAmlqGCXBvfkk5Wu0lxKPwRFjVZ8TOZsg5MP6VRyk=;
        b=DIR0Jm9TyJvCBYKvOXtlSJWc5WbXrlYODWdRaLYaDwm6zXqv1qSN4FVZRvurZJgFe/
         n1++pvQs0fsRz/IaLtFZ+FtraZhUcOWuicw0AikWWNZlWLqnq7ZElkDh6NWyjOtYAKBt
         bH8QmRQJQkm7LDBXDi0J744CuaEfF5DkTdYlK1yXDKsTiSArbYTnH8T6hHYzcKQhEEoB
         P9X1gZ31jXIKvqKlqdeFSAciv6VeD7BFopB6KMqgZxgNlzVP0S64oqKS5riAkiWle4rA
         ULup872kCiLw1jVqcYrtF/VIGy4Yjpg+NMzNmzsgT27Q5EKRwaTuA1ssftacUT6CuH/B
         unig==
X-Gm-Message-State: AOJu0YzNdB9cQGTHbpRrr0q+/Jkl0OEsri7xWFEXBri5KbGy1u2xlbdN
	KTw2j0CXWmp4YSGPyNBQ9DVJJBmVOnTRAWFFHxHv6MqY25kdD6iLyWOZYS8zrhrLiV0GLQk9PI+
	pNf5UNn7xrtqJ9Wudo0h9yEJbx2f++3NQ
X-Google-Smtp-Source: AGHT+IGl4vlVJQFJA/3riPbue/nT23wwPO4oeYYDQ/kV5tFD9V6PMolymflpurDE5eImngXm5lg9eW9apxDJJJiTchA=
X-Received: by 2002:a17:90a:68cd:b0:2ad:1e60:502a with SMTP id
 q13-20020a17090a68cd00b002ad1e60502amr10067995pjj.38.1714407144981; Mon, 29
 Apr 2024 09:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426092214.16426-1-jose.marchesi@oracle.com>
 <CAEf4BzY14jZkUUgkZb3A88KguX6=7pJLhNZ3T1H-Hde7raLb6A@mail.gmail.com>
 <87h6fo0zq7.fsf@oracle.com> <87zftdwbrr.fsf@oracle.com>
In-Reply-To: <87zftdwbrr.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 09:12:12 -0700
Message-ID: <CAEf4BzYOJRH7NMhy_kkMynWyz+mEh7ivkX05bq1bYv9aXLEg=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid casts from pointers to enums in bpf_tracing.h
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 12:03=E2=80=AFPM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> >> Also please check CI failures ([0]).
> >>
> >>   [0] https://github.com/kernel-patches/bpf/actions/runs/8846180836/jo=
b/24291582343
> >
> > How weird.  This means something is going on in my local testing
> > environment.
>
> Ok, I think I know what is going on: the CI failures had nothing to do
> with the patch changes per-se, but with the fact the patch changes
> bpf_tracing.h and a little problem in the build system.
>
> If I change tools/lib/bpf/bpf_tracing.h in bpf-next master, then
> execute:
>
>  $ cd bpf-next/
>  $ git clean -xf
>  $ cd tools/testing/selftests/bpf/
>  $ ./vmtest.sh -- ./test_progs
>
> in tools/testing/sefltests/bpf, I get this:
>
>   make[2]: *** No rule to make target '/home/jemarch/gnu/src/bpf-next/too=
ls/testing/selftests/bpf/tools/build/libbpflibbpfbpf_helper_defs.h', needed=
 by '/home/jemarch/gnu/src/bpf-next/tools/testing/selftests/bpf/tools/build=
/libbpf/include/bpf/libbpfbpf_helper_defs.h'.  Stop.
>
>
> Same thing happens if I have a built tree and I do `make' in
> tools/testing/selftests/bpf.
>
> In tools/lib/bpf/Makefile there is:
>
>   BPF_HELPER_DEFS       :=3D $(OUTPUT)bpf_helper_defs.h
>
> which assumes OUTPUT always has a trailing slash, which seems to be a
> common expectation for OUTPUT among all the Makefiles.
>
> In tools/bpf/runqslower/Makefile we find:
>
>   BPFTOOL_OUTPUT :=3D $(OUTPUT)bpftool/
>   DEFAULT_BPFTOOL :=3D $(BPFTOOL_OUTPUT)bootstrap/bpftool
>   [...]
>   $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(=
BPFOBJ_OUTPUT)
>         $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=3D$(BPFOBJ_=
OUTPUT) \
>                     DESTDIR=3D$(BPFOBJ_OUTPUT) prefix=3D $(abspath $@) in=
stall_headers
>
> which is ok because BPFTOOL_OUTPUT is defined with a trailing slash.
>
> However in tools/testing/selftests/bpf/Makefile an explicit value for
> BPFTOOL_OUTPUT is specified, that lacks a trailing slash:
>
>   $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPU=
T)
>         $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower      =
      \
>                     OUTPUT=3D$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=3D$(VMLINUX=
_BTF)     \
>                     BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/          =
        \
>                     BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf                  =
        \
>                     BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR)      =
          \
>                     EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'       =
        \
>                     EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)' &&                  =
        \
>                     cp $(RUNQSLOWER_OUTPUT)runqslower $@
>
> This results in a malformed
>
>   BPF_HELPER_DEFS       :=3D $(OUTPUT)bpf_helper_defs.h
>
> in tools/lib/bpf/Makefile.
>
> The patch below fixes this, but there are other many possible fixes
> (like changing tools/bpf/runqslower/Makefile in order to pass
> OUTPUT=3D$(BPFOBJ_OUTPUT)/, or changing tools/lib/bpf/Makefile to use
> $(OUTPUT)/bpf_helper_defs.h) and I don't know which one you would
> prefer.
>
> Also, since the involved rules have not been changed recently, I am
> wondering why this is being noted only now.  Is people using another
> set-up/workflow that somehow doesn't trigger this?

Let's fix runqslower submake rule, yes, but I think it's irrelevant
here. Failures that CI caught were in samples/bpf
(samples/bpf/tracex2.bpf.c), while this is runqslower rule.

The reason you haven't caught it is because selftests/bpf/Makefile
doesn't build samples/bpf, but our BPF CI does have an extra step to
build samples/bpf.

>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index ca8b73f7c774..665a5c1e9b8e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -274,7 +274,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) =
$(RUNQSLOWER_OUTPUT)
>         $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower      =
      \
>                     OUTPUT=3D$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=3D$(VMLINUX=
_BTF)     \
>                     BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/          =
        \
> -                   BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf                  =
        \
> +                   BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf/                 =
        \
>                     BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR)      =
          \
>                     EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'       =
        \
>                     EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)' &&                  =
        \

