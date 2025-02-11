Return-Path: <bpf+bounces-51143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B21A30B19
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 13:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432D71882C4C
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697671FE453;
	Tue, 11 Feb 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ1u2tNT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2671FCFFE;
	Tue, 11 Feb 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275491; cv=none; b=kMYKfkJMNXfmx1a9wwWE1gLq23n+t//+WvHnccA4p5nV7UoYIQdvsBb+lUHoMarf7Ho5nscV/HBXst8oaTDvvnCjkg0+RAc2u9PrYsPmTS2W5XRlMlnYOZ0qDYmc/IR32cB6xwhtoVltQlZ4Eqs4qkQJGgI8bfVnF8M38wdGiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275491; c=relaxed/simple;
	bh=6Wt4nC7Btuucsbn3pfSL7zYf9Rhv/+wfTFRIBzdDFb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKw7pKok26F8Hbwr1RB0/L8ADHTMJImU8whwuqbfF0baOrO0KF9oiERkxU9H826A7oKExj7ovzJaAT9LfvyP20vLtAIUFWYvxhTt0fb8Q1B0viaj1BKRGb7SQua2aZLDSsiTHbDbZmeC37OCDVWD1SutdhhI+a61nD2X5GzBsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ1u2tNT; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6ef7c9e9592so42989267b3.1;
        Tue, 11 Feb 2025 04:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275488; x=1739880288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO8SnT16ipU2VJWLGEvtBFy/dT+aFWYknBux6Pff2Wk=;
        b=kZ1u2tNTGuH4uAS0+aNlPgtSIL86suACIR+ZCIpriC6TpLQ3ewzUdWsmib9QyFWQ1I
         k0LbYCp9qCyzM57HAO4cM7ReqQTZPTf6aveLW1P28bJJ0s/vZBu3HAsjbAljDhE4IjoW
         tGZd1jMMgTD/JaBfVEnrldtTyyd+1sPdUMesrAL2nsSmqnc2+rgVAi4EQTD6D/CnUQJL
         93GVlBv+t6FHT20gB93oADTAmrCJg/IFonj3gMxzgYOrJlJOKD1dgI4UaTwvaX8hvQoA
         6fSjzRnT5GjtJrsMZkBWSCQLltlIPSloGf+YOLPMRwZ/br8nJwhf4SOLxL3bHcRWI59y
         9F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275488; x=1739880288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO8SnT16ipU2VJWLGEvtBFy/dT+aFWYknBux6Pff2Wk=;
        b=Mg7il+UUM2wZ51HBK6zUgUo0RDZoy8R+QYCgMen5LWlN07zj9ipQaCVefpdw7KyGqV
         HhTNUpH1ikLPlpj/eD0kLfsiEGYGrf44m7vZFZiwpwMtbgYuj+x0GQyi0Q4hyopLgG91
         EV3Zg8l+eXbcoIYt9tUmrrzzf5H9xRhD8/BsQVzXwSnf9AMOu70eM7QyN1JCeD6IrY+X
         PNCRd7WrINI2A/i+ajHP9o8w7T1TOfFlGMYhveNTVttlsqhTNyYfy+RLcgUxLH7x+r5T
         7iMbWzxQfhmJCUjzXlCyQnjxOL3dCisDqzN4K6w0H9LpPjuQV8yKLeuT5FjYhBl/pBl0
         dPag==
X-Forwarded-Encrypted: i=1; AJvYcCWse4bZRFvPMwNKl5FGzV9zqfJF+we3KaVZgXGFGMUdJSG5kxqn1XeYxa9PrbAcC6AUWRUzC7QK0g8Tm5aC@vger.kernel.org, AJvYcCXAmcWH3rAx8WfUCDMciTxUBhhyo8D0WkuFjnQewloaTWXBFJXI1KOPoxiVWhMJQzd5OWltrr9DXEQsnyi2XRPWbCaE@vger.kernel.org, AJvYcCXHpJLD7LdZl5WfHdeBlay4WXIdXdaziv10hUf/BkJTJlxbLpU4HyqAZLa85b0esE58O0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQs3c1DSMMUk0a/VmXDr6rHBb+NdY5wAkoEKYfRez/XICIuQc
	NnOzwV4Y80xAu2zmnxUxg8ImrDeXySs7MH5gxz0bd5f4c6EbMhidyq8bY9hA5ZDtnOb8S9B4zW8
	LmY6bwLm/0LCQC5ygOXpAqvSQzvc=
X-Gm-Gg: ASbGncuRV0pWRvClUPJc3khijpCCXLIW9/F/l+FGADXFoeoX20dC1v3mwzIa5fSIi21
	tva8WOKJW6d4LebX4g1n2vfAl3hxIEJd9BZ75pKXcMllBwb8q2YJe/a1kn3kshIiuuZsFULbw
X-Google-Smtp-Source: AGHT+IHtSdXC7ZtV2Ed6hUfajj0EnxP7utuSYP2YFYYwL2uyHELEZFAoSHY4VCaPSEKoOxnqq1AdvlcHGZElCXVW2kU=
X-Received: by 2002:a05:690c:7090:b0:6f9:a75f:f24c with SMTP id
 00721157ae682-6f9b292290bmr166160997b3.29.1739275487875; Tue, 11 Feb 2025
 04:04:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210104034.146273-1-dongml2@chinatelecom.cn> <20250210180528.01118537@gandalf.local.home>
In-Reply-To: <20250210180528.01118537@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 11 Feb 2025 20:03:38 +0800
X-Gm-Features: AWEUYZmnELjF1StF4AcDURsFuI1lRxT_YhnfHUB1G1q0zztCipvIP3UCAsWKhu8
Message-ID: <CADxym3YzTc8wyAndNP4OpK8JSLWkpCAMgJox49ioUBXrov1h=w@mail.gmail.com>
Subject: Re: [RFC PATCH] x86: add function metadata support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: alexei.starovoitov@gmail.com, x86@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, dongml2@chinatelecom.cn, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:05=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 10 Feb 2025 18:40:34 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > With CONFIG_CALL_PADDING enabled, there will be 16-bytes(or more) paddi=
ng
> > space before all the kernel functions. And some kernel features can use
> > it, such as MITIGATION_CALL_DEPTH_TRACKING, CFI_CLANG, FINEIBT, etc.
>
> Please start your change log off with why you are doing this. Then you ca=
n
> go into the details of what you are doing.
>
> Explain what and how kernel features can use this.

Yeah, you are right, and I'll add the following messages to the
starting of the log:

For now, there isn't a way to set and get per-function metadata with
a low overhead, which is not convenient for some situations. Take
BPF trampoline for example, we need to create a trampoline for each
kernel function, as we have to store the information about the function,
such as BPF progs, function arg count, etc, to the trampoline. The
performance cost and memory consumption can be higher to create
these trampolines. With per-function metadata storage support, we
can store the BPF progs, function arg count, etc, to the metadata, and
create a global BPF trampoline for all the kernel functions. In the global
trampoline, we can get the information that we need from the function
metadata through the ip (function address) with almost no overhead.

Another beneficiary can be ftrace. For now, all the kernel functions that
are enabled by dynamic ftrace will be added to a filter hash. And hash
lookup will happen when then traced functions are called, which has an
impact on the performance, see
__ftrace_ops_list_func() -> ftrace_ops_test(). With the per-function metada=
ta
support, we can store the information that if the ftrace ops is enabled on =
the
kernel function to the metadata.

>
> >
> > In this commit, we add supporting to store per-function metadata in the
>
> Don't ever say "In this commit" in a change long. We know this is a commi=
t.
> The above can be written like:
>
> "Support per-function metadata storage.." Although that should be after y=
ou
> explain why this is being submitted.

Okay, looks much better!

>
> > function padding, and previous discussion can be found in [1]. Generall=
y
> > speaking, we have two way to implement this feature:
> >
> > 1. create a function metadata array, and prepend a 5-bytes insn
> > "mov %eax, 0x12345678", and store the insn to the function padding.
> > And 0x12345678 means the index of the function metadata in the array.
> > By this way, 5-bytes will be consumed in the function padding.
> >
> > 2. prepend a 10-bytes insn "mov %rax, 0x12345678aabbccdd" and store
> > the insn to the function padding, and 0x12345678aabbccdd means the addr=
ess
> > of the function metadata.
> >
> > Compared with way 2, way 1 consume less space, but we need to do more w=
ork
> > on the global function metadata array. And in this commit, we implement=
ed
> > the way 1.
> >
> > In my research, MITIGATION_CALL_DEPTH_TRACKING will consume the tail
> > 9-bytes in the function padding, and FINEIBT+CFI_CLANG will consume
> > the head 7-bytes. So there will be no space for us if
> > MITIGATION_CALL_DEPTH_TRACKING and CFI_CLANG are both enabled. So I hav=
e
> > following logic:
> > 1. use the head 5-bytes if CFI_CLANG is not enabled
> > 2. use the tail 5-bytes if MITIGATION_CALL_DEPTH_TRACKING is not enable=
d
> > 3. compile the kernel with extra 5-bytes padding if
> >    MITIGATION_CALL_DEPTH_TRACKING and CFI_CLANG are both enabled.
> >
> > In the third case, we compile the kernel with a function padding of
> > 21-bytes, which means the real function is not 16-bytes aligned any mor=
e.
> > And in [2], I tested the performance of the kernel with different paddi=
ng,
> > and it seems that extra 5-bytes don't have impact on the performance.
> > However, it's a huge change to make the kernel function unaligned in
> > 16-bytes, and I'm sure if there are any other influence. So another cho=
ice
> > is to compile the kernel with 32-bytes aligned if there is no space
> > available for us in the function padding. But this will increase the te=
xt
> > size ~5%. (And I'm not sure with method to use.)
> >
> > The beneficiaries of this feature can be BPF and ftrace. For BPF, we ca=
n
> > implement a "dynamic trampoline" and add tracing multi-link supporting
> > base on this feature. And for ftrace, we can optimize its performance
> > base on this feature.
> >
> > This commit is not complete, as the synchronous of func_metas is not
> > considered :/
> >
> > Link: https://lore.kernel.org/bpf/CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=
=3DxuiP7pr4PO6USPA@mail.gmail.com/ [1]
> > Link: https://lore.kernel.org/bpf/CADxym3af+CU5Mx8myB8UowdXSc3wJOqWyH4o=
yq+eXKahXBTXyg@mail.gmail.com/ [2]
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  arch/x86/Kconfig          |  15 ++++
> >  arch/x86/Makefile         |  17 ++--
> >  include/linux/func_meta.h |  17 ++++
> >  kernel/trace/Makefile     |   1 +
> >  kernel/trace/func_meta.c  | 184 ++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 228 insertions(+), 6 deletions(-)
> >  create mode 100644 include/linux/func_meta.h
> >  create mode 100644 kernel/trace/func_meta.c
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 6df7779ed6da..0ff3cb74cfc0 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2510,6 +2510,21 @@ config PREFIX_SYMBOLS
> >       def_bool y
> >       depends on CALL_PADDING && !CFI_CLANG
> >
> > +config FUNCTION_METADATA
> > +     bool "Enable function metadata support"
> > +     select CALL_PADDING
> > +     default y
> > +     help
> > +       This feature allow us to set metadata for kernel functions, and
>
> Who's "us"?

The user of this feature? Maybe change it to:

Support per-function metadata storage......

Just like what you suggest above :/

>
> > +       get the metadata of the function by its address without any
> > +       costing.
> > +
> > +       The index of the metadata will be stored in the function paddin=
g,
> > +       which will consume 5-bytes. The spare space of the padding
> > +       is enough for us with CALL_PADDING and FUNCTION_ALIGNMENT_16B i=
f
> > +       CALL_THUNKS or CFI_CLANG not enabled. Or, we need extra 5-bytes
> > +       in the function padding, which will increases text ~1%.
> > +
> >  menuconfig CPU_MITIGATIONS
> >       bool "Mitigations for CPU vulnerabilities"
> >       default y
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 5b773b34768d..05689c9a8942 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -240,13 +240,18 @@ ifdef CONFIG_MITIGATION_SLS
> >  endif
> >
> >  ifdef CONFIG_CALL_PADDING
> > -PADDING_CFLAGS :=3D -fpatchable-function-entry=3D$(CONFIG_FUNCTION_PAD=
DING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
> > -KBUILD_CFLAGS +=3D $(PADDING_CFLAGS)
> > -export PADDING_CFLAGS
> > +  __padding_bytes :=3D $(CONFIG_FUNCTION_PADDING_BYTES)
> > +  ifneq ($(and $(CONFIG_FUNCTION_METADATA),$(CONFIG_CALL_THUNKS),$(CON=
FIG_CFI_CLANG)),)
> > +    __padding_bytes :=3D $(shell echo $(__padding_bytes) + 5 | bc)
> > +  endif
> > +
> > +  PADDING_CFLAGS :=3D -fpatchable-function-entry=3D$(__padding_bytes),=
$(__padding_bytes)
> > +  KBUILD_CFLAGS +=3D $(PADDING_CFLAGS)
> > +  export PADDING_CFLAGS
>
> Arm64 and other archs add meta data before the functions too. Can we have
> an effort to perhaps share these methods?

I have not done research on arm64 yet. AFAIK, arm64 insn is 16-bytes aligne=
d,
so the way we process can be a little different here, as making kernel func=
tion
non 16-bytes aligned can have a huge influence.

And I'm hesitant about 2 points, as I described in the commit log:
1. prepend 5-bytes insn or 10-bytes? 10-bytes will be much simpler
    in coding, but consume more padding space.
2. add extra 5/10 bytes padding, or select FUNCTION_ALIGNMENT_32B?
   The latter can make the text size bigger, but less influential.

Does anyone have any idea about the choice above? I would
appreciate hearing some advice here :/

And yes, when the final solution is determined, the other arch
(at least arm64) can support this feature too.

>
> >
> > -PADDING_RUSTFLAGS :=3D -Zpatchable-function-entry=3D$(CONFIG_FUNCTION_=
PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
> > -KBUILD_RUSTFLAGS +=3D $(PADDING_RUSTFLAGS)
> > -export PADDING_RUSTFLAGS
> > +  PADDING_RUSTFLAGS :=3D -Zpatchable-function-entry=3D$(__padding_byte=
s),$(__padding_bytes)
> > +  KBUILD_RUSTFLAGS +=3D $(PADDING_RUSTFLAGS)
> > +  export PADDING_RUSTFLAGS
> >  endif
> >
> >  KBUILD_LDFLAGS +=3D -m elf_$(UTS_MACHINE)
> > diff --git a/include/linux/func_meta.h b/include/linux/func_meta.h
> > new file mode 100644
> > index 000000000000..840cbd858c47
> > --- /dev/null
> > +++ b/include/linux/func_meta.h
>
> If this is x86 only, why is this in generic code?
>
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_FUNC_META_H
> > +#define _LINUX_FUNC_META_H
> > +
> > +#include <linux/kernel.h>
> > +
> > +struct func_meta {
> > +     int users;
> > +     void *func;
> > +};
> > +
> > +extern struct func_meta *func_metas;
> > +
> > +struct func_meta *func_meta_get(void *ip);
> > +void func_meta_put(void *ip, struct func_meta *meta);
> > +
> > +#endif
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index 057cd975d014..4042c168dcfc 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
>
> Same here.
>
> > @@ -106,6 +106,7 @@ obj-$(CONFIG_FTRACE_RECORD_RECURSION) +=3D trace_re=
cursion_record.o
> >  obj-$(CONFIG_FPROBE) +=3D fprobe.o
> >  obj-$(CONFIG_RETHOOK) +=3D rethook.o
> >  obj-$(CONFIG_FPROBE_EVENTS) +=3D trace_fprobe.o
> > +obj-$(CONFIG_FUNCTION_METADATA) +=3D func_meta.o
> >
> >  obj-$(CONFIG_TRACEPOINT_BENCHMARK) +=3D trace_benchmark.o
> >  obj-$(CONFIG_RV) +=3D rv/
> > diff --git a/kernel/trace/func_meta.c b/kernel/trace/func_meta.c
> > new file mode 100644
> > index 000000000000..9ce77da81e71
> > --- /dev/null
> > +++ b/kernel/trace/func_meta.c
>
> Unless this file will support arm64 meta data and other architectures
> besides x86, then it should not be in the kernel/trace directory.

Yeah, I am planning to support arm64 metadata (maybe in
the next commit?). Some code in this file is x86 related, and
I should move them to the arch/x86 directory :/

Thanks!
Menglong Dong

>
> -- Steve
>
>
> > @@ -0,0 +1,184 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/slab.h>
> > +#include <linux/memory.h>
> > +#include <linux/func_meta.h>
> > +#include <linux/text-patching.h>
> > +

