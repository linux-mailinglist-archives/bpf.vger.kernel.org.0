Return-Path: <bpf+bounces-22188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB8B858849
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 23:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10EA28BFCB
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C0146917;
	Fri, 16 Feb 2024 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK+4Jckj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91E1420B8
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120798; cv=none; b=b0mutOxLPaChsK9sHFtHWQc4sxTVhw0grkb2aD+6KixhTcUsxp+3GVFWtuyVrGCDOQY455+QsAS88ylpa/In+QhyeefSNc3GK/v5/cNdvvFFVXJPGq8L26FoXm6ipA2xsj+Hkt1boW9D185Y1njQaoYYi3Ei+Y/V4wAIlCi63tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120798; c=relaxed/simple;
	bh=utvIg8r9qXT3h4YOfpYBfr1G9hACotrBF0lws97HELQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xc0AqFqnkBTw5OSfDO4akGqLt9F9uvOyvRYqYDLj93G/EXUW52CG+QGb5QI63DATaAwrlOu7Yx6EKboBTRq4Xak5MurStM9hF+hjOAzg1h+5Lpf0aNb1JiOKQ7tFPiXUc8m9Sr5OuVn2o3bTlHnAlVFuTuc5bmNWpgxQoCaj7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK+4Jckj; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so3749508a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 13:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708120795; x=1708725595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FIWjajWCUuvjD6fSgfJ99FdPBiLxJmHn0+9z9qcgpYQ=;
        b=RK+4JckjWS166Zf4v2/C3svrFf0cXXQA2FcVq+jyoPzEQh39RXGTuwQMr2nMoacCIv
         NE7Xdapr91fBAKaUAh7GAJhkKfj4AX0shQD+lHu1Xy5xLKxH+kaVW81ZDIUW2+pt9KLe
         4Adtr5OZRcYMODNItfGiYPK5FaKDhbDo5w0C8eIGJTF+yC+gIzIpz02h5QlJbjuGkyhA
         nFP1iSCCRBIZBxij7ueawF1jCIukU4dMH3YqbqfDGNIxFeaqxiS6gxFNitNYwZqeNZqs
         Oq8YOjSUqv2/27XX/oXpZXDVi6HizvdBFdDVcOLVgINmujA0Yd0MdIGCEgpqMd27IKK1
         x/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708120795; x=1708725595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIWjajWCUuvjD6fSgfJ99FdPBiLxJmHn0+9z9qcgpYQ=;
        b=phRlipGPVnwWVEbwgM7flfHuk2Vz91kxEqVQ5CIuopI5/R8E6L5TSN2AO2KR7iJHjG
         5OHNp4aYd4ZirIWuyns5eg7mTh5k9SiRuidbHt/wen9m4q4ih4H518v2lz9ShbZu/fzE
         DzPZ6IDhmjbPSw8P1w1M0KbzjvLVAwxU7VbRrV1k9INnrIYEXy416J82L9CqjrZssvFD
         Jp3k+SUnq9FnbTZ4NMVIZpX+hjWo25TFJYi8TF1L3mmBkXgCj7eyiTJuw7Iv5ay4HPGm
         fwb4yuQFbDs/VvZhrEsP85mxveJ2QsNaQ7cq3dNKKqo59FcS+ueQrEDnba+FpyJKKfVa
         DFnA==
X-Gm-Message-State: AOJu0YypFoe+2iag/w7/u9xggUcNE6QDaBleoOxEScHDOBh08aKXnCkr
	86wCFNhzLsWAWlPUvEa1ZEl76/YWL2JfwVm30nd+Ek7d7epMlwh+X9QiSaDidpGQH7u+6L40wtT
	5NCt9xcx58361RMsz3ElCaf7f+m0=
X-Google-Smtp-Source: AGHT+IFLmgPQsTdR/F09tqnZ1eywXhh9FVpOK421gsjIjLnzU/mE+OeCPWIi0CtsLqsM0cMd45yylCZHj4LzmCjgfGE=
X-Received: by 2002:aa7:d845:0:b0:564:16b0:1c63 with SMTP id
 f5-20020aa7d845000000b0056416b01c63mr398511eds.21.1708120795420; Fri, 16 Feb
 2024 13:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-8-memxor@gmail.com>
 <956ffbdd1998236db4c576606729303034fe121a.camel@gmail.com>
In-Reply-To: <956ffbdd1998236db4c576606729303034fe121a.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Feb 2024 22:59:18 +0100
Message-ID: <CAP01T7454ab6aUh_iE90qFLOUj+iL9uTUTy1Gbh1yzkh5-qrRw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/14] bpf: Use hidden subprog trampoline for bpf_throw
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 23:11, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:
> > When we perform a bpf_throw kfunc call, callee saved registers in BPF
> > calling convention (R6-R9) may end up getting saved and clobbered by
> > bpf_throw. Typically, the kernel will restore the registers before
> > returning back to the BPF program, but in case of bpf_throw, the
> > function will never return. Therefore, any acquired resources sitting in
> > these registers will end up getting destroyed if not saved on the
> > stack, without any cleanup happening for them.
>
> Could you please paraphrase this description a bit?
> It took me a while to figure out the difference between regular bpf
> calls and kfunc calls. Something like:
>
>   - For regular bpf subprogram calls jit emits code that pushes R6-R9 to stack
>     before jumping into callee.
>   - For kfunc calls jit emits instructions that do not guarantee that
>     R6-R9 would be preserved on stack. E.g. for x86 kfunc call is translated
>     as "call" instruction, which only pushes return address to stack.
>

Will rephrase like this, thanks for the suggestions.

> --
>
> Also, what do you think about the following hack:
> - declare a hidden kfunc "bpf_throw_r(u64 r6, u64 r7, u64 r8, u64 r9)";
> - replace all calls to bpf_throw() with calls to bpf_throw_r()
>   (r1-r5 do not have to be preserved anyways).
> Thus avoid necessity to introduce the trampoline.
>

I think we can do such a thing as well, but there are other tradeoffs.

Do you mean that R6 to R9 would be copied to R1 to R5? We will have to
special case such calls in each architecture's JIT, and add extra code
to handle it, since fixups from the verifier would also need to pass
the 6th argument, the cookie value to the bpf_throw call, which can't
fit in the 5 argument limit for existing kfuncs. I did contemplate
this solution but then decided against it for these reasons.

One of the advantages of this bpf_throw_tramp stuff is that it does
not increase code size for all callees, by doing the saving only when
subprog is called. We can do something similar for bpf_throw_r, but it
would be in architecture specific code in JIT or some arch_bpf_throw_r
instead.

Let me know if you suggested something different than what I understood above.

> [...]
>
>

