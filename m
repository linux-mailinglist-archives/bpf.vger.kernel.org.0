Return-Path: <bpf+bounces-74430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C4C5940D
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 18:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD64F11B4
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854673002BD;
	Thu, 13 Nov 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfmSONC5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFE2F3608
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055431; cv=none; b=KQMXTecTq00+q/aH4J+Mnu4ADpZxPm+RWm8CXADXQRpgTqtgaQJTYYlm4mYr2mrB0fFm7FguZQ6eyb7tkEeFpheCF3aZuC6WnAnZYHEGJ8DVqtgit4PHS/Dry9a6rcSFt0stJv/k1MV12ffFU83GN2QtnR5TzCNfURmwxA5oJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055431; c=relaxed/simple;
	bh=z10O3j/8GoaA9cou2j1MyFLH4uxgDzyACMLShJ/hd2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQqkzxzP+mv5qs9ENl7jwcx8aaU484cnDcW8vNyu40eiaXCI1nat6z1cyFiofX9md5nsQmkHhHOSq9LcHeB9Bs1CuU79llMEzuI9WJrFPzrHWUn6S0V0svkuQE2c/pvGv+NM3y6foJGb+9GLFIpXilIVoweRzwvNlrWs4O5GGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfmSONC5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47728f914a4so7400875e9.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 09:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763055427; x=1763660227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj1Gqs3nM+ixdoLbw4xBV6RsmvT4bhXgtp/k4VuMzRE=;
        b=XfmSONC5T2Bih8cfiMvo4CLgt3AUE0ZR1JxvEplooMWlVdA6RaHiXtcVmUAlmoyhg5
         rJzXQ+cGGiY2lIoRtAWevpTM1SI+5d+2xNw/hQixDbIvMyGOlseBtRtwo5Nj7hYEoYg8
         +6Q2uNfMMHghkYCt8y4C9k+2oqeZTYtSMpIMs9IPzPLdBJxvrl2VilQpUM2rPMpgdI/e
         CcWw/79R3a7YMZzQmtTaQxMCVFWYO1ohwqmRujLR5AE4cHw1RngTTvtIEQVr5FA96XYC
         s5PJYTzsB6cTGZyIng0S7d4UhgFZ6Ju+W26vAlyPCwsZWCVka3BPj57++eBI6SLdGKJU
         522Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763055427; x=1763660227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj1Gqs3nM+ixdoLbw4xBV6RsmvT4bhXgtp/k4VuMzRE=;
        b=K+LFBA5Zvul2Y16CrqKGo3n3XkRl4uyTvwEUBOXun5sIwJduUMqhT+NL3UGXIzHgq1
         OCZVKCtc+0kknpj53bIDDGHFJZ8WrTp+S4bN41zBvW/4dnH7YnKJYA/DxkJChVfnEa0z
         JWtKA9EkZ1iinG3D0yd25Osdqa863do+5GLCNsz/t5wexAiwlNoDGpA5UFjG8pC+ZVnw
         7H2JOWdk+R4P1mHQ4Owhukge6HdZAv+ZwYJ2iSKFh4ZD5AA8cECbd+A1DPIGRSLNinIB
         wqRjDfPdITWHzO5lDnIJgdwbt3MN8jex6YqcHSbASX0wInYOPTcrIy0NtD3bUEnrT2s7
         V3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXlhW0qXvgdY5CU8vBA0VSwzUxoPnr6ALARM3DrpKFVteh1Y7tMyoOkLcmf9qV/tL2gN6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzibi6isrQNzXaV5RWdB2GfRIxIWnyzMC1PwBb4Z9tOwsZ4ppOd
	i2fz0tvHjHRLekiYz1LAIxvokmGU3s0SObyrwV63S+9zVjUoM6gWSChDChFIUSRDp5ruM14Boj2
	QP/rjMMTdMleoUazuqom2kl4nbCX1wsI=
X-Gm-Gg: ASbGncvZP9qH1DpPMyzxXI35yv7JW9INjPAKHzLWCmmQAbpWfbeLJSC8/I80IZpX9ay
	NEQAHX4dqZ8pf+QWhmDH1vh3Jqdpb3fq6o2xQ+L3WNPhxiqaFLiDBlALhyHAciqIW7KnGZ3slCP
	ihitjIQRaAmgR3L8VB6dJYjIKxI3DU9/LPXnZZJKOONipZXGDEQ46TrlKapakldisMbxtbEYYdd
	H/rmT5ANLifYkUwVHCcWAv6Kq1rcCoZG4PZQLqXppJ11DBju1Lhk/0svnesBev9ftxx8X9U38YK
	gJKDGc1pP5Q=
X-Google-Smtp-Source: AGHT+IHyQqQ2zkM+hiLaEkMsF1hyAuJIGSZF40lFJN/FPLUmdcx/IX7AY2M8enll470JmD5fHEykpfb5HFoFffQz3z8=
X-Received: by 2002:a05:600c:4fc4:b0:475:de12:d3b2 with SMTP id
 5b1f17b1804b1-4778feaa9f4mr3332035e9.36.1763055427196; Thu, 13 Nov 2025
 09:37:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111170424.286892-1-yonghong.song@linux.dev> <a9ebf236-78c8-439a-b427-cb817efe23ae@oracle.com>
In-Reply-To: <a9ebf236-78c8-439a-b427-cb817efe23ae@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Nov 2025 09:36:53 -0800
X-Gm-Features: AWmQ_blADtHvNtGdjEpR5QH25QIjr-6XXTFbsmzK_SWAMXHYIwg_N0XkxIhYr68
Message-ID: <CAADnVQKr+9gneG4ZZHBKWjTo-AiqPCf_Mxv_sCi9acqEKkKShw@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/3] pahole: Replace or add functions with true
 signatures in btf
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Faust <david.faust@oracle.com>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:45=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 11/11/2025 17:04, Yonghong Song wrote:
> > Current vmlinux BTF encoding is based on the source level signatures.
> > But the compiler may do some optimization and changed the signature.
> > If the user tried with source level signature, their initial implementa=
tion
> > may have wrong results and then the user need to check what is the
> > problem and work around it, e.g. through kprobe since kprobe does not
> > need vmlinux BTF.
> >
> > The following is a concrete example for [1].
> > The original source signature:
> >   typedef struct {
> >         union {
> >                 void            *kernel;
> >                 void __user     *user;
> >         };
> >         bool            is_kernel : 1;
> >   } sockptr_t;
> >   typedef sockptr_t bpfptr_t;
> >   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> > After compiler optimization, the signature becomes:
> >   static int map_create(union bpf_attr *attr, bool uattr__coerce1) { ..=
. }
> >
> > In the above, uattr__coerce1 corresponds to 'is_kernel' field in sockpt=
r_t.
> > Here, the suffix '__coerce1' refers to the second 64bit value in
> > sockptr_t. The first 64bit value will be '__coerce0' if that value
> > is used instead.
> >
> > To do proper tracing, it would be good for the users to know the
> > changed signature. With the actual signature, both kprobe and fentry
> > should work as usual. This can avoid user surprise and improve
> > developer productivity.
> >
> > The llvm compiler patch [1] collects true signature and encoded those
> > functions in dwarf. pahole will process these functions and
> > replace old signtures with true signatures. Additionally,
> > new functions (e.g., foo.llvm.<hash>) can be encoded in
> > vmlinux BTF as well.
> >
> > Patches 1/2 are refactor patches. Patch 3 has the detailed explanation
> > in commit message and implements the logic to encode replaced or new
> > signatures to vmlinux BTF. Please see Patch 3 for details.
> >
>
>
> Thanks for sending the series Yonghong! I think the thing we need to
> discuss at a high level is this; what is the proposed relationship
> between source code and BTF function encoding? The approach we have
> taken thus far is to use source level as the basis for encoding, and as
> part of that we attempt to identify cases where the source-level
> expectations are violated by the compiled (optimized) code. We currently
> do not encode those cases as in the case of optimized-out parameters,
> source-level expectations of parameter position could lead to bad
> behaviour. There are probably cases we miss in this, but that is the
> intent at least.
>
> There are however cases where .isra-suffixed functions retain the
> expected parameter representations; in such cases we encode with the
> prefix name ("foo" not "foo.isra.0") as DWARF does.
>
> So in moving away from that, I think we need to make a clear decision
> and have handling in place. My practical worry is that users trying to
> write BPF progs cannot easily predict if a parameter is optimized out
> and so on, so it's hard to write stable BPF programs for such
> signatures. Less of a problem if using a high-level tracer I suppose.
>
> The approach I had been thinking about was to utilize BTF location
> information for such cases, but the RFC [1] didn't get around to
> implementing the support. So the idea would be have location info with
> parameter types and locations, but because we don't encode a function
> fentry can't be used (but kprobes still could as for inline sites). So
> under that scheme the foo.llvm.hash functions could still be called
> "foo" since we have address information for the sites we can match foo
> to foo.llvm.hash.
>
> Anyway I'd appreciate other perspectives here. We have implicitly tied
> BTF function encoding thus for to source-level representation for
> reasons of fentry safety, but we could potentially move away from that.
> Doing so though would I think at a minimum require machinery for fentry
> safety to preserved, but we could find other ways to flag this in the
> BTF function representation potentially. Thanks!

Looks like we have a big disconnect here.
To me BTF was never about the source, but about vmlinux final binary.
Compile flags, configs change both types and functions significantly.
For types it's easy to see in the vmlinux BTF how they got transformed
from the original types in the source. Some source types disappear
altogether. Similar situation with functions. They mutate.
Partial inling, function renames are all part of the same category.
BTF has to describe the final result, so that tracers/users can
actually debug/introspect the kernel they have and not an abstract
kernel source. pahole was conservative and removed functions that
don't match BTF. loc* set is going to bring back these functions
into BTF with their arguments. True signature support is complementary
and mandatory part to loc* set. We need both. Compiler has to
store the true signature in dwarf and pahole has to pass it to BTF
along with location of arguments and actual name of function symbol table.

Re: whether to strip .llvm or not, I think it's better to keep BTF
matching symbol table which is kallsyms. If it has .llvm suffix in kallsyms
it should have the same name in BTF. Tracing tools can attach
with "func_name.*" pattern. libbpf already supports it.
And thanks to BTF the fentry prog should match what is true
kernel function signature. What was the source signature is secondary.
The users cannot write their progs based on source, since such
source code doesn't exist in the binary, so nothing to trace.
While true signature with actual parameters is traceable.

