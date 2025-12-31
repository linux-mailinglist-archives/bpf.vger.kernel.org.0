Return-Path: <bpf+bounces-77560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B9CEB059
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 03:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD857301C3D4
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 02:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA928C862;
	Wed, 31 Dec 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMLhB/M2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18934C97
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767146683; cv=none; b=krjGO+E5p5tRb2ac2OmpTaEVzZePVQG+Me5anTTqLidnYDH1n/ljNdOdm1ChUf2v71gM7MrNIKtkiaCo+4ysfd/9QK1LiGHmnXzMX8id/n7SvxcpbOgjw0p0J+KbvlTtotup9elah/s/h/eihw4MtIinb2TLPdRbrK8XX/yUJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767146683; c=relaxed/simple;
	bh=hx/IHa/T/kTYxE4ncCqV9kVU1/SwpT6L+rU1MvWvGoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUQ2FHdzVCJWXfac8RopX6FrHsUYBRp0dxs1mteAHxzjbDFMpDYP9ZHhwZoWi7QlbNHoIhV99H7t4AIyjksm0+tusImNDu8fG0khr9HKqRRWb+9qOUZpcZ8AKyR0MFimgZ9U4ouTh9TXz81U8OUP5I2l//c9iaoObbFeyVVK03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMLhB/M2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso5185319f8f.2
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 18:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767146680; x=1767751480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUc5FiL+2gLRfi+r+bNROA/9D4gSk/btssUBdeBxA+g=;
        b=aMLhB/M2N3A2bwVRzHseNrhXpQbKCKNkbykQURF/pZHGaqM2Vg+jwDNyGTU/dBBxYX
         tVQqBRpjlNHC5+pQ7lhW9V9aP087JJhZXFj+wyAcbLoxQExF2pzwKTyRwX8qc4wU5RDp
         w7LaPzi/1NxMxH1z3SEPiDRWsIDf3Hy9I/eRTNR7KhLqlVNK91SDweJNew4F7FMKGnB5
         pgxm4UpRhPmz43eSVLgFMOsZaIFXmHrpy3hsUEMmbgOXZPlMLuhsDPAYENLyJFvagAlE
         qZLwuEGDYEdV4umeKbCkA+qdEFts+TNnGetSaWkT69fN4vLcKEybJXv+YmodSJ5zcOMz
         LtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767146680; x=1767751480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUc5FiL+2gLRfi+r+bNROA/9D4gSk/btssUBdeBxA+g=;
        b=oaRMU8+KnkY2piLdabSgg6G5Atq/yK9GNEPRotRe1txi7aOoKZNUWdjCjYh9vfnl79
         uVq9Nv8XNw8GpU+K2nIUmFdSIeUPGvDecV4YNr1FWhZxV25XM6aQ6umngZNdC6Es08vQ
         wgYsIkbfc6GZWR3b+AcpAQP51h22fb3ua5gr1/FIkpeEq0kMOHa4FbjsXW6t+cgmtHoo
         QAHhHfjf3dWrIU5sy9XbKOFltobQhR3HJztNaPR51AmVX8KqGf6xBWvoqEFpEEjMvtis
         tTBYXvkSf8yvPE82ALcVIiGTCSYW8ptv3U6nTkLzn36HUa9HvmEBYbGNfpIfSrrLRlYl
         LYIA==
X-Gm-Message-State: AOJu0Ywhqi49GuB1dSW/pgu5ja4b+7QBbkn2Xs47NXsOOiwCcnjTHlLa
	SwSzdIacCgRx1pWDrw8o36YuthFymadGON/l38AZsrMC4Ym6YL1NFYrddhMgMJHEPQpZnwhwjaT
	pVsRf1rL/4FqTxEnNsPbgicH5xW+PeTA=
X-Gm-Gg: AY/fxX4MQ27H9FMss9YPjF8EzDROyRznamwyDPSegbttwb3eai86ix95s8NQUcGUQvC
	jcv9Rzi07WlwXTo+IoSEy1bTJlc/k0q+HPK1B7hJRxvfwyXA66zpgEv9N7rZmHKaJSJtPdexd1O
	mm6XimOq6rJKzxFeiGHg19a321KPBW2pxQc5aNTuY6LTMGRG3WhygrVarr+yq6RYlXDC4nw9QRO
	ENvbo4/onnUu5FuqRikUeeZRIaKxgG9lEz23GRRbXJ/jkT1nAUOmvggyISei5eeVExncChOyLCP
	wben15Trkniz1T1/1IvmwxrbkzRZ
X-Google-Smtp-Source: AGHT+IFcleih/JwENEfpDz20UDvWYCcsYDcUmPTeL4HBgUtNIDpAteui/cvPcjRRz+UNMRf4gbw+pnLMt2BmzcUXrtg=
X-Received: by 2002:a5d:5d0e:0:b0:42f:bad7:af55 with SMTP id
 ffacd0b85a97d-4324e4c70fbmr42189311f8f.6.1767146679901; Tue, 30 Dec 2025
 18:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224192448.3176531-1-puranjay@kernel.org> <20251224192448.3176531-7-puranjay@kernel.org>
In-Reply-To: <20251224192448.3176531-7-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Dec 2025 18:04:28 -0800
X-Gm-Features: AQt7F2r5EVLtYnhfZbzpmCFSrNudRhebwhDn_8ddqAFSOshQ6YoDAr3VBkW9JVQ
Message-ID: <CAADnVQ+F-KZyOeAGhs=8v5jck=T8yH4SCsRdVYt0AOCzK6gg=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] selftests: bpf: fix test_kfunc_dynptr_param
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 11:25=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> As verifier now assumes that all kfuncs only takes trusted pointer
> arguments, passing 0 (NULL) to a kfunc that doesn't mark the argument as
> __nullable or __opt will be rejected with a failure message of: Possibly
> NULL pointer passed to trusted arg<n>
>
> Pass a non-null value to the kfunc to test the expected failure mode.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c =
b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> index 061befb004c2..11e57002ea43 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -48,7 +48,7 @@ SEC("?lsm.s/bpf")
>  __failure __msg("arg#0 expected pointer to stack or const struct bpf_dyn=
ptr")
>  int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned i=
nt size, bool kernel)
>  {
> -       unsigned long val =3D 0;
> +       unsigned long val =3D 1;

1 as a pointer looks odd here.
Let's not introduce an oddity here that people will be tempted to copy past=
e.
Make it a real pointer that is not ptr_to_stack and not CONST_PTR_TO_DYNPTR=
.
static struct bpf_dynptr val;
may do ?

>         return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
>                                           (struct bpf_dynptr *)val, NULL)=
;
> --
> 2.47.3
>

