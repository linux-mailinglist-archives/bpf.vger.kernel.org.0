Return-Path: <bpf+bounces-51975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DACFA3C714
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 19:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24EC16B475
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B19214814;
	Wed, 19 Feb 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ9QfjrM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9BB2147E8
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988629; cv=none; b=Hghy2MK5T6yD0yT0UgZU+Y4tif69105hd2Ng3MxQnNBVr2FC4N/e5YyRnDTGgRuZZ/bgtzNf7+ZhUtQk+MQkDZdW42yU3rJnXCpdljI1t8M8mTDQ7JbAvLMjjEZahaay3eqv2zbsvmDNqbG6M5TGCd/JeJwpcppmEy/fVcS+HZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988629; c=relaxed/simple;
	bh=5BtvbKsKHt9b0Y39tIlyW9DtXNDFvWAipRyOWiY59kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaMpFwVolYKqTGi+ZxkrVy8X42InsLsszlADMPrx63P8I3/jMYmdDRHOxAnvG5nTGq+Bo8eJvhcMOafKcIYYonbxrRy87qQO6maV3j5szA74wkKXYH8dpCLq7wMf+GoeNkcD3NgJuXnf69k2ESb2z1mJv//Vt2x9YtzbACOmJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ9QfjrM; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so43856a12.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739988626; x=1740593426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sLnlVjlL8HlJnQjIxe17VDwzm64zLYy+/bDeq7vL2Y=;
        b=VJ9QfjrMlbbpTt9e9ruFZzSmoi5iN6JIC8Zi3EFB4vFUjOEbEWFb6lAsOrV5Yimhuo
         MtHkvr1KaFs/yj9RHQGZ8NdBR/eKB9Jb9ZBIT7ccVimMJF5E+Yu4bANeLF1W3zbRQXuN
         sE8RGpQ0sEz4sZPyJNiN3yS+Hksv08E1d6v1NZoJRkwj6fe3FxPflzLOS1xGbVBQ4DtM
         Ryvm10LWB1NkIhmd/OOt/7ewF34+GBr53dumnABKqJDWhGmeIxlGCDMsHiw0zMG9+Zop
         brAYtQMRI8uQ6tj5Mxrv2Y2wEBxGGMIvft6YrJ7uIrn1d2NR0KOCjt4nWmbB2H2Dy/T0
         8mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739988626; x=1740593426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sLnlVjlL8HlJnQjIxe17VDwzm64zLYy+/bDeq7vL2Y=;
        b=RDE5WvzzAblsV3gagtgrLRUn5JR79R4S5jpk0NUVpN5wRzR9fPWJNdOMgWasIoRvt/
         jlSjynLf/vTYrd5FBA7nJxVpAZYNO+sExM1Ww6U16t2zmleGT+i1dBH0GmXaxDutwQNK
         HFIg5hfQF4Td5qU14XVvZPgyFqiF23GynmPKFV5RgQ88uTRWGIuhgtiFHLJdsU1mERs5
         e5EknSG+VGsX1Sh4uwloICYxCpRHq6SYPusHyOZC+FA9pa0nl4oBdl+Dk7UT6tEAqX/Q
         qowZUSP7M+iCcSIu7Mcp/CxrL6+/mnvbhDcn18u1lQwO/d8sOSF0VEqfEqEygeDTnmyf
         vd4A==
X-Gm-Message-State: AOJu0YwT1eUfgIzJUE+y1N+8blXY8HWbEEe7JCB1h39R90QIUd6+PiUW
	qaTMxohEGKy7zKRQIfZZFS+445ysrlF8OsI6Quap5dsZLalwAXYAjdXrEbKeCAXYHEZS0XxgetY
	GCnlvzwPFTlSsRilw8PlNUWXwLelB2SSsKtI=
X-Gm-Gg: ASbGnctKFSs0IHXRj1Iojj6ULjCqtIVJRFMr3C9dPhUlqG6X5raSsP2n/+z/VRg8BLe
	xWrgR0l/aksjahg5Dw3g4F/hF28OF8RU3t3dgbNwNUEEQB5w9yTGBHDh/FE6iIV6wjAcJXJFLtB
	b5PO2OQ4u3GS1/2u+RYA==
X-Google-Smtp-Source: AGHT+IEL4xwiX+k5jCIAGbXA/MxZW+b05uXGrQl5zyiDlelGvks7L0d6wU4uAdxX74Krb6STv+5CQY3y7Rri9/fkoK8=
X-Received: by 2002:a17:906:315b:b0:ab6:d47a:9b20 with SMTP id
 a640c23a62f3a-abb70c310a8mr1545551866b.31.1739988625776; Wed, 19 Feb 2025
 10:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-2-memxor@gmail.com>
 <CAADnVQ+TBG+yAxtY1Q5D6HnhbvgusUVrzyRm7-8oF7wYw+Nqfw@mail.gmail.com>
In-Reply-To: <CAADnVQ+TBG+yAxtY1Q5D6HnhbvgusUVrzyRm7-8oF7wYw+Nqfw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 19 Feb 2025 19:09:49 +0100
X-Gm-Features: AWEUYZkUyZCKjYE_pssAmDAMmwfdBSkA7pvAIwkEbvv0u5O26f54miZEBpWs3Tg
Message-ID: <CAP01T74tZudfS8huoz=sP4UkEgs5ipkz9Qjf=6XNVzJvGOFLgQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2025 at 18:41, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 19, 2025 at 4:51=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > For the bpf_dynptr_slice_rdwr kfunc, the verifier may return a pointer
> > to the underlying packet (if the requested slice is linear), or copy ou=
t
> > the data to the buffer passed into the kfunc. The verifier performs
> > symbolic execution assuming the returned value is a PTR_TO_MEM of a
> > certain size (passed into the kfunc), and ensures reads and writes are
> > within bounds.
>
> sounds like
> check_kfunc_mem_size_reg() -> check_mem_size_reg() ->
> check_helper_mem_access()
>    case PTR_TO_STACK:
>       check_stack_range_initialized()
>          clobber =3D true
>              if (clobber) {
>                   __mark_reg_unknown(env, &state->stack[spi].spilled_ptr)=
;
>
> is somehow broken?
>
> ohh. It might be:
> || !is_kfunc_arg_optional(meta->btf, buff_arg)
>
> This bit is wrong then.
> When arg is not-null check_kfunc_mem_size_reg() should be called.
> The PTR_TO_STACK abuse is a small subset of issues
> if check_kfunc_mem_size_reg() is indeed not called.

The condition looks ok to me.

The condition to do check_mem_size_reg is !null || !opt.
So when it's null, and it's opt, it will be skipped.
When it's null, and it's not opt, the check will happen.
When arg is not-null, the said function is called, opt does not matter then=
.
So the stack slots are marked misc.

In our case we're not passing a NULL pointer in the selftest.

The problem occurs once we spill to that slot _after_ the call, and
then do a write through returned mem pointer.

The final few lines from the selftest do the dirty thing, where r0 is
aliasing fp-8, and r1 =3D 0.

+ *(u64 *)(r10 - 8) =3D r8; \
+ *(u64 *)(r0 + 0) =3D r1; \
+ r8 =3D *(u64 *)(r10 - 8); \
+ r0 =3D *(u64 *)(r8 + 0); \

The write through r0 must re-mark the stack, but the verifier doesn't
know it's pointing to the stack.
push_stack was the conceptually cleaner/simpler fix, but it apparently
isn't good enough.

Remarking the stack on write to PTR_TO_MEM, or invalidating PTR_TO_MEM
when r8 is spilled to fp-8 first time after the call are two options.
Both have some concerns (first, the misaligned stack access is not
caught, second PTR_TO_MEM may outlive stack frame).

I don't recall if there was a hardware/JIT specific reason to care
about stack access alignment or not (on some architectures), but
otherwise we can over approximately mark at 8-byte granularity for any
slot(s) that overlap with the buffer to cover such a case. The second
problem is slightly trickier, which makes me lean towards invalidating
returned PTR_TO_MEM when stack slot is overwritten or frame is
destroyed.

