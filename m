Return-Path: <bpf+bounces-53445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38AA540EE
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 04:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B744E7A2A22
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 02:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9DA194A6B;
	Thu,  6 Mar 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr4+n0iP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F6192B8F;
	Thu,  6 Mar 2025 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230001; cv=none; b=uMrqGpiCOXRxTN4+D9ejxCsdILj23jW+glPTUs//ZkXTHNe0waKUBMuPDEHABPqENDf4Vg1eQ/HF6xR8kVYGJ+DFnhCjde69r1N8cNCOIyzDFLUhoUIPhkzS+9ATN3lY6PjKFXp4EZF31RUVumXtDRnasYbj37CmeW7jjfLjpaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230001; c=relaxed/simple;
	bh=61tMRzNOM/5QWusjnzUN8wPxi9LPAafyPlmyDrpfEP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI/9v1x3SE2EiN1w7Ui/Qj9KcTOoSxi3qK1JIQuDZJYpj2OiIuh/MFosxV7CAT7k6VOnV9zMy6Gzqqj2ZsDKiWwp5m3vn0lBKLQnPYFoKVTmJm1Grqz5xFm0YG9/dvnoSiaPqwJdre7hhHZPyetgnype/jGMKyoMzhGcEvGVARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr4+n0iP; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6f679788fd1so1438407b3.2;
        Wed, 05 Mar 2025 18:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741229998; x=1741834798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Jsf4FJkD/oQcph6Un/Rvp8XZNnCIvEKvX+i6GNumRQ=;
        b=Qr4+n0iPgWdR1cXqJ9eWI4FM9271xlh9iV7xZ/zIKX3v/OVucwnZAkq5y7y/KuGKdA
         3/FuFZD6BzbacsAXsQwOgUXGUJZtmxHK8ObippSiy4dMw81oiCDsqdgQ/32oZKYfK6Yk
         0Msr11zx/OSChlCorbQlnfShfvnJAVbQQ4QBewNDUrS6svY0aaP4XXda7Y1uPT4cRzBc
         0l/2MDynHa8+CUWPKpwGDrGxNBXN4mDoiF0JNUZOpWIy+qZpLefevMBlI1S4Eeg0sDnd
         qU8s+e4bIhvtnmdzEDOZce3fjPI/WyUSrOEAXHkyBL7H7iIXVpyPlODig524uBD71ElN
         Lp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741229998; x=1741834798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Jsf4FJkD/oQcph6Un/Rvp8XZNnCIvEKvX+i6GNumRQ=;
        b=BRvS6MfyrZ4Fz2dWODUz8SP4lu55kgF8oizY645eg/aVCzFbse/xY0ebFpYVA2hWRn
         DuKnX+DzlP3kvr2uH2MzuH/OH2LTS/y0Nh5Ix+i7rz0njhO0fvQ+ncJw47rI7CcWcL7x
         dlN/n1XrwA2B4M1I/qUq3OkfyA0ohIPF5PX3WMueCg8uB3kxkYofRLzyzDzyg+BiXyij
         vHczzACDa6KOeXqrVM4ULYXfSFgHVKZdclf4zJ5zO++URb5JgFw40Olt7jpffKO1NXrk
         +OxjbxyJwTPnvk1l69ulKPxOOSxx+5eoWiMXptjpo/ZlAr3on6qcPq1HWf1xCG0OkNmV
         YgMA==
X-Forwarded-Encrypted: i=1; AJvYcCU/jAU/Mf+zwyL7O0/aYe2PZmuOr5lHecs1zPuqx77CrCaPF0P1TUKeb8faptTrERYfIi8=@vger.kernel.org, AJvYcCWLbAWw9WsTx6RCSAguXgkB93Cb70MjFOrr3bgPHAZdLmXCcMJJYOHG2CtWLVtPuIzei0EmDOPH@vger.kernel.org, AJvYcCWue2EBo974zXxRN4oYMPUiq6eDQTijIkp/zElbg5c+LP9Jn/N774g46IGNQr3LQlIihevKzZ8DUqFWdC5HiyJiOXrt@vger.kernel.org, AJvYcCXWfqmVm5+mZ6ZNYjZs78XtK6V9hlVb9nNuChyRa+SBSYaZdbUUlElTGRHCZmaBaAnIV7sBVbjyCjm8tHYb@vger.kernel.org
X-Gm-Message-State: AOJu0YzAR0Ny3nL6uZtngW42NGf0d8/fujMfv5AesKO4ZfBWzuLQrweX
	2lAhaDsHwu6llzqHlwcyOrIaBGqW0EuQHZj3CkBxkX1Y6qhn/V69+7JKB4nK7uL5iL9DUMuORPO
	/Vqma25G4WIKTxUqUbhiNrcGXkIE=
X-Gm-Gg: ASbGncsbA09TZx8JGtW5BoHzFpTQrCY4by0xBLyvuVUR6aZhn+DbgeQOI0XSzZY8pDB
	sNwBhsMJqFs6kskpSVw/btVfcjwayOjVL47qLSzadp0L8Vzf/eNz411zc7EkgPPp3/68ML12Ap0
	h1x3o0tq3KvzqwwyrnPzRZ0l1GBA==
X-Google-Smtp-Source: AGHT+IFeoYjcATqNsYPiuA+luhOQkjmbzDn/LQX+nvbyZv2699UHF1GDqeNPtOjeUYjHowLaxUhtHEMTkQhU0GT/F40=
X-Received: by 2002:a05:690c:680f:b0:6fb:1e5a:fcd8 with SMTP id
 00721157ae682-6fda31222edmr79126807b3.28.1741229998289; Wed, 05 Mar 2025
 18:59:58 -0800 (PST)
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
 <CADxym3busXZKtX=+FY_xnYw7e1CKp5AiHSasZGjVJTdeCZao-g@mail.gmail.com> <20250305100306.4685333a@gandalf.local.home>
In-Reply-To: <20250305100306.4685333a@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 6 Mar 2025 10:58:18 +0800
X-Gm-Features: AQ5f1Jq_Oa1dQKvMfe98EdRc4mzdybzOfF6-Dlq5oONytu-pPWGY-R6eybChn8I
Message-ID: <CADxym3ZB_eQny=-aO4AwrHiwT264NXitdKwjRUYrnGJ2tH=Qwg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, mark.rutland@arm.com, 
	alexei.starovoitov@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
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

On Wed, Mar 5, 2025 at 11:02=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 5 Mar 2025 09:19:09 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > Ok, let me explain it from the beginning. (My English is not good,
> > but I'll try to describe it as clear as possible :/)
>
> I always appreciate those who struggle with English having these
> conversations. Thank you for that, as I know I am horrible in speaking an=
y
> other language. (I can get by in German, but even Germans tell me to swit=
ch
> back to English ;-)
>
> >
> > Many BPF program types need to depend on the BPF trampoline,
> > such as BPF_PROG_TYPE_TRACING, BPF_PROG_TYPE_EXT,
> > BPF_PROG_TYPE_LSM, etc. BPF trampoline is a bridge between
> > the kernel (or bpf) function and BPF program, and it acts just like the
> > trampoline that ftrace uses.
> >
> > Generally speaking, it is used to hook a function, just like what ftrac=
e
> > do:
> >
> > foo:
> >     endbr
> >     nop5  -->  call trampoline_foo
> >     xxxx
> >
> > In short, the trampoline_foo can be this:
> >
> > trampoline_foo:
> >     prepare a array and store the args of foo to the array
> >     call fentry_bpf1
> >     call fentry_bpf2
> >     ......
> >     call foo+4 (origin call)
>
> Note, I brought up this issue when I first heard about how BPF does this.
> The calling of the original function from the trampoline. I said this wil=
l
> cause issues, and is only good for a few functions. Once you start doing
> this for 1000s of functions, it's going to be a nightmare.
>
> Looks like you are now in the nightmare phase.
>
> My argument was once you have this case, you need to switch over to the
> kretprobe / function graph way of doing things, which is to have a shadow
> stack and hijack the return address. Yes, that has slightly more overhead=
,
> but it's better than having to add all theses hacks.
>
> And function graph has been updated so that it can do this for other user=
s.
> fprobes uses it now, and bpf can too.

Yeah, I heard that the kretprobe is able to get the function
arguments too, which benefits from the function graph.

Besides the overhead, another problem is that we can't do
direct memory access if we use the BPF based on kretprobe.

>
> >     save the return value of foo
> >     call fexit_bpf1 (this bpf can get the return value of foo)
> >     call fexit_bpf2
> >     .......
> >     return to the caller of foo
> >
> > We can see that the trampoline_foo can be only used for
> > the function foo, as different kernel function can be attached
> > different BPF programs, and have different argument count,
> > etc. Therefore, we have to create 1000 BPF trampolines if
> > we want to attach a BPF program to 1000 kernel functions.
> >
> > The creation of the BPF trampoline is expensive. According to
> > my testing, It will spend more than 1 second to create 100 bpf
> > trampoline. What's more, it consumes more memory.
> >
> > If we have the per-function metadata supporting, then we can
> > create a global BPF trampoline, like this:
> >
> > trampoline_global:
> >     prepare a array and store the args of foo to the array
> >     get the metadata by the ip
> >     call metadata.fentry_bpf1
> >     call metadata.fentry_bpf2
> >     ....
> >     call foo+4 (origin call)
>
> So if this is a global trampoline, wouldn't this "call foo" need to be an
> indirect call? It can't be a direct call, otherwise you need a separate
> trampoline for that.
>
> This means you need to mitigate for spectre here, and you just lost the
> performance gain from not using function graph.

Yeah, you are right, this is an indirect call here. I haven't done
any research on mitigating for spectre yet, and maybe we can
convert it into a direct call somehow? Such as, we maintain a
trampoline_table:
    some preparation
    jmp +%eax (eax is the index of the target function)
    call foo1 + 4
    return
    call foo2 + 4
    return
    call foo3 + 4
    return

(Hmm......Is the jmp above also an indirect call?)

And in the trampoline_global, we can call it like this:

    mov metadata.index %eax
    call trampoline_table

I'm not sure if it works. However, indirect call is also used
in function graph, so we still have better performance. Isn't it?

Let me have a look at the code of the function graph first :/

Thanks!
Menglong Dong

>
>
> >     save the return value of foo
> >     call metadata.fexit_bpf1 (this bpf can get the return value of foo)
> >     call metadata.fexit_bpf2
> >     .......
> >     return to the caller of foo
> >
> > (The metadata holds more information for the global trampoline than
> > I described.)
> >
> > Then, we don't need to create a trampoline for every kernel function
> > anymore.
> >
> > Another beneficiary can be ftrace. For now, all the kernel functions th=
at
> > are enabled by dynamic ftrace will be added to a filter hash if there a=
re
> > more than one callbacks. And hash lookup will happen when the traced
> > functions are called, which has an impact on the performance, see
> > __ftrace_ops_list_func() -> ftrace_ops_test(). With the per-function
> > metadata supporting, we can store the information that if the callback =
is
> > enabled on the kernel function to the metadata, which can make the perf=
ormance
> > much better.
>
> Let me say now that ftrace will not use this. Looks like too much work fo=
r
> little gain. The only time this impacts ftrace is when there's two
> different callbacks tracing the same function, and it only impacts that
> function. All other functions being traced still call the appropriate
> trampoline for the callback.
>
> -- Steve
>
> >
> > The per-function metadata storage is a basic function, and I think ther=
e
> > may be other functions that can use it for better performance in the fe=
ature
> > too.
> >
> > (Hope that I'm describing it clearly :/)
>

