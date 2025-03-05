Return-Path: <bpf+bounces-53268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B58A4F379
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C92E16F721
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06E3148855;
	Wed,  5 Mar 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhq0i/xL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC613D8B2;
	Wed,  5 Mar 2025 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137650; cv=none; b=ThnHym03FQx4Ej82dnjiM/zeXU5ko0b6PYAb4bVxpbdu8zswuWUA4g9R1QGA70eEYXlWrMAQYhHQP1JmvipDJrXLszEo+YoW2HgNuuRgRJW4XlWFqxculYXiVLmt1Vq9iSvNtouUTuRH3DM6a6OZLB7X5NrrBQeiV24KQEr9ZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137650; c=relaxed/simple;
	bh=xqfh+/z+RQyzw3ZjPbcTSHPRwuHVteqzMjyMDRsSiD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYMOxTpLIB/WfEeNCMCKaF7AuBoUrpgfm1U02Gph19JzzTWDw9UCyrLzrfJeQcEXJBTCL1PM7uMNSmvoFPgGfxT7hivchh2jM1ne1egCXEQ92Droxct5T/4rk9MVj0YuzesOWSbNGshYjD0BlT5Yj2DOGi34yWZvwVtmNxGLE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhq0i/xL; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6ef7c9e9592so48173097b3.1;
        Tue, 04 Mar 2025 17:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741137647; x=1741742447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHYZyJk9t+dccX+FpypbsuXH5wnniLUKk++ZCb3Oz18=;
        b=dhq0i/xLN+xPsYhZcVVd3qpliCAqRJiMobRUSMtjahZN6dPIg7EN4NRPTlOOMN7HSe
         1tOqPNvpx1zuWQaF8Oua03XQ/v916NlzhPiQtfRyOtXoUEeI4EVTzt9xe567QoMlNY+6
         PrwOH9fuA30/eS35dY9BEIn+UrN1N1ialPRN69oa/OCBX7X4WoL8joS0bSXnNM3G4Ifv
         Gnhiw4Vs+mAYaOye6op90SqzGMHA6S1HkOJl0i/AhvGHazSH84iwOt50yRPDexGu6pAA
         4+7aOHgQZ626Lnp4/s198CooS/gMsr7N3nv+doVo8MeupupFw8OQbkYjGrUrB70ecPZd
         5BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741137647; x=1741742447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHYZyJk9t+dccX+FpypbsuXH5wnniLUKk++ZCb3Oz18=;
        b=dGha9FJzQhAyVTCmUuIcw5dNdmYzH1cbfBpQ+HxLqze++yPMaybHcF0OqNvbNIr3uk
         9sPHJueUyWK/0ySn2T9klXFacIzLKFhaL5XTtNRYuBEZAgv0mumz7OOSGqcoh3a9vPvV
         M/DH0WxWkjPpTiZxK8rB68KVqt4ANtmt6w6C/kFsNhscTUu15bnBc//85P62fuo7NS9N
         sPcDotLOZ5xA/3PsqykEjGjXL0vEsIBz6c+mtk0ZeL0tS9ysQQHy6Tj8XhwUB571D7ro
         NUcPJ47M8AUqKbj/Uy9A7cFKmDs7s+TP1vu2OoaUScf1R8K4POJDjE4fDvsVdajDkOzD
         Nqlg==
X-Forwarded-Encrypted: i=1; AJvYcCUxt1jnbJ/z3l51hYcoCjFcP3IrQDXHAUFBwzrRiu+1PWvtpha4YkIJ1s67asP6WbY6vKlSYyskInZLSceRArY51JAC@vger.kernel.org, AJvYcCV3eaYKI2RRbELMbRqR57l3yKuDrZKYuiTOiAXSCdsUtN68kr9qB9NBi9wfdXFlRJ8fqMOLOwLE@vger.kernel.org, AJvYcCVJe4coz8a/kwiyCstaIvutZgg6iKedzV7hETjD5xsIG9fhEJ9JrVp1P7GCvXUSRjKQYHcOmmxDa2J5K1Xh@vger.kernel.org, AJvYcCXHziYkDdC27rheADELsYR8PKsq5kz1m5nkX4yaFALCWUJBcfh/eYQeDeLKw/ZosyTniqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+KIdiQzMbWgOHr5Y6DeGTZxomMRjW32sQkGg14g66RXJIA5y
	RTMX+w68JayjX+IXqPrmCNEUp28expJ7qU1WcdtymXHmO9gfx/DOJfQHvM5lx/wMuECQSREs1Sj
	AmKZEp1U/qRxzLqun6iAyzEw9FOE=
X-Gm-Gg: ASbGncuwbqhZnNl2Fx/rymm2xASjcIYqjdXBxD4f1T5zmY0XB9u5p+FfTJBFzVog/rN
	u0NPLp8KhIQX/dwpPu/xxKs+nlhtc3PYPXci6ZTPN/vmrzbFS6jkAvg3+9QnffIIJAC1oINCGND
	HT1iPK/hGYSQBlwlymQNx0HmNPcA==
X-Google-Smtp-Source: AGHT+IEUFgZnl6Hm/lrUNqrNCPW/Rgad0I4A7NRpQso6+OmPGRY6t9+y0nrp+PzU9oYzztzRMxurMDXN8Jy0BacmWdM=
X-Received: by 2002:a05:690c:3690:b0:6fb:a376:3848 with SMTP id
 00721157ae682-6fda315fdfbmr21998337b3.34.1741137647462; Tue, 04 Mar 2025
 17:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-2-dongml2@chinatelecom.cn> <20250303165454.GB11590@noisy.programming.kicks-ass.net>
 <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>
 <20250304053853.GA7099@noisy.programming.kicks-ass.net> <20250304061635.GA29480@noisy.programming.kicks-ass.net>
 <CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com>
 <20250304094220.GC11590@noisy.programming.kicks-ass.net> <6F9EF5C3-4CAE-4C5E-B70E-F73462AC7CA0@zytor.com>
In-Reply-To: <6F9EF5C3-4CAE-4C5E-B70E-F73462AC7CA0@zytor.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 5 Mar 2025 09:19:09 +0800
X-Gm-Features: AQ5f1JovIrYFizMaqP4MsodnwT5N7qb6QoTLb6VyR_6OCJq8SQkboYm5nSKxxpw
Message-ID: <CADxym3busXZKtX=+FY_xnYw7e1CKp5AiHSasZGjVJTdeCZao-g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
To: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, samitolvanen@google.com, 
	kees@kernel.org, dongml2@chinatelecom.cn, akpm@linux-foundation.org, 
	riel@surriel.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:53=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On March 4, 2025 1:42:20 AM PST, Peter Zijlstra <peterz@infradead.org> wr=
ote:
> >On Tue, Mar 04, 2025 at 03:47:45PM +0800, Menglong Dong wrote:
> >> We don't have to select FUNCTION_ALIGNMENT_32B, so the
> >> worst case is to increase ~2.2%.
> >>
> >> What do you think?
> >
> >Well, since I don't understand what you need this for at all, I'm firmly
> >on the side of not doing this.
> >
> >What actual problem is being solved with this meta data nonsense? Why is
> >it worth blowing up our I$ footprint over.
> >
> >Also note, that if you're going to be explaining this, start from
> >scratch, as I have absolutely 0 clues about BPF and such.
>
> I would appreciate such information as well. The idea seems dubious on th=
e surface.

Ok, let me explain it from the beginning. (My English is not good,
but I'll try to describe it as clear as possible :/)

Many BPF program types need to depend on the BPF trampoline,
such as BPF_PROG_TYPE_TRACING, BPF_PROG_TYPE_EXT,
BPF_PROG_TYPE_LSM, etc. BPF trampoline is a bridge between
the kernel (or bpf) function and BPF program, and it acts just like the
trampoline that ftrace uses.

Generally speaking, it is used to hook a function, just like what ftrace
do:

foo:
    endbr
    nop5  -->  call trampoline_foo
    xxxx

In short, the trampoline_foo can be this:

trampoline_foo:
    prepare a array and store the args of foo to the array
    call fentry_bpf1
    call fentry_bpf2
    ......
    call foo+4 (origin call)
    save the return value of foo
    call fexit_bpf1 (this bpf can get the return value of foo)
    call fexit_bpf2
    .......
    return to the caller of foo

We can see that the trampoline_foo can be only used for
the function foo, as different kernel function can be attached
different BPF programs, and have different argument count,
etc. Therefore, we have to create 1000 BPF trampolines if
we want to attach a BPF program to 1000 kernel functions.

The creation of the BPF trampoline is expensive. According to
my testing, It will spend more than 1 second to create 100 bpf
trampoline. What's more, it consumes more memory.

If we have the per-function metadata supporting, then we can
create a global BPF trampoline, like this:

trampoline_global:
    prepare a array and store the args of foo to the array
    get the metadata by the ip
    call metadata.fentry_bpf1
    call metadata.fentry_bpf2
    ....
    call foo+4 (origin call)
    save the return value of foo
    call metadata.fexit_bpf1 (this bpf can get the return value of foo)
    call metadata.fexit_bpf2
    .......
    return to the caller of foo

(The metadata holds more information for the global trampoline than
I described.)

Then, we don't need to create a trampoline for every kernel function
anymore.

Another beneficiary can be ftrace. For now, all the kernel functions that
are enabled by dynamic ftrace will be added to a filter hash if there are
more than one callbacks. And hash lookup will happen when the traced
functions are called, which has an impact on the performance, see
__ftrace_ops_list_func() -> ftrace_ops_test(). With the per-function
metadata supporting, we can store the information that if the callback is
enabled on the kernel function to the metadata, which can make the performa=
nce
much better.

The per-function metadata storage is a basic function, and I think there
may be other functions that can use it for better performance in the featur=
e
too.

(Hope that I'm describing it clearly :/)

Thanks!
Menglong Dong

