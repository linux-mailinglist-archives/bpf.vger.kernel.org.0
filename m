Return-Path: <bpf+bounces-68648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42804B7C3F2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AA8463859
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EE32DF6F8;
	Wed, 17 Sep 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efU4Sbx7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD228002B
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101478; cv=none; b=QNtlWgNtE1vfej+tf1xUv01BHSjK2TzIC3EJxSswOdBn4uPNqWq/Sc69q0+EWA55CpjxLAnZduPH1Z0NC8ua2qkQgDETjB5Umfcina256Bi9WEjBpIIHWPtoMvmxeATmYqHqWgQbs6O2ZHP8/ygrThup/8pbG0ufwdL5bKDkZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101478; c=relaxed/simple;
	bh=HwnIzq5v+BGCO/6Uhary+9iSdgxz864kepa7zMnx7Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDRFQSXWELan2h1vyrWTD3EnuuOIJuRd1RY4WLg2zkNCC0zXrFDYRQENb+jUZqraAOgt0onJpw0o11uxw6y3TENPTZArAh4rby2lA+/tHGjni8k+vgAidi9LAixFco+JCioWOeu3ERZt+PEyWgPv/kbV/NbErtdicEC8dSh322o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efU4Sbx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8192C116D0
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 09:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758101477;
	bh=HwnIzq5v+BGCO/6Uhary+9iSdgxz864kepa7zMnx7Ts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=efU4Sbx7pCycUuAmCsp51D4vHkkvWIo9UyM22cktOJN6E1+fsLUPiVG1G519f7GUG
	 FawWzFfX59D/LHvLzM8ItaPGJBtOkmq7/KX7OX6DKjUwqHpy5YXTw0789mrpJ9Ufbi
	 cXl686qbjm8LPainEwAdAOJJE0AhUK+teHyO4jCNySyY58cqs9oLddGofD4g+cGFlP
	 R5C8pBoiZ3mQzZRALEOuknXoPIz5O6QUEFwiJml06duV+QrGEzyAckS6zb5UdIBavD
	 w0vQMbD/sQWkAjjX8xkrlHt+ZZ8p8wXAB5CiqeVWNsFa2nwCDvqIKmDC8LgJMdVXsJ
	 y6Skl44TK7FsA==
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso3821717f8f.2
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 02:31:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YybNReIe05Nmi+xcQXbi/pKiq7tPxuKDER5hkAXR938INzkK8Nf
	lvCIkiqoQWFAl36/4EfHPCqd+NKe2owdDF0Hwsh34/HbH4KOIg8pnSPMhhQQ8XBl6bAIzeWMkpy
	4YNc543IhYm8WyNLnXLJtcwmsgjwoBHLsDSaWr7tB
X-Google-Smtp-Source: AGHT+IEXq4eS531qPurqJ5IF5MFTa9SzJb8qOJtpthJUucdpEsqKMLImSP74fNaAkhLbL3bHNkiGPdVRu2KVVh17F1Q=
X-Received: by 2002:a05:6000:430d:b0:3ec:ce37:3a6a with SMTP id
 ffacd0b85a97d-3ecdf9c87ffmr1560072f8f.22.1758101476074; Wed, 17 Sep 2025
 02:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKMdfmZo0520HqP_4tBDd5UVf8UY7r5CycjbGQu+8tcGge99g@mail.gmail.com>
In-Reply-To: <CACKMdfmZo0520HqP_4tBDd5UVf8UY7r5CycjbGQu+8tcGge99g@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 17 Sep 2025 11:31:05 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7X2uU=c7Qd+LUKnQbzSMyypnUu_WCMZ=8eX6ThXn_L6g@mail.gmail.com>
X-Gm-Features: AS18NWCDVA5YUNKBkEenaDlgPT611slznX6SIVfes4lnYrXJwR92eRNJ5aSHDdI
Message-ID: <CACYkzJ7X2uU=c7Qd+LUKnQbzSMyypnUu_WCMZ=8eX6ThXn_L6g@mail.gmail.com>
Subject: Re: [PATCH v2] docs/bpf: clarify ret handling in LSM BPF programs
To: Ariel Silver <arielsilver77@gmail.com>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:52=E2=80=AFPM Ariel Silver <arielsilver77@gmail.=
com> wrote:
>
> v2: Fixed trailing whitespace (reported by checkpatch.pl)
>
> Docs currently suggest that all attached BPF LSM programs always run
> and that ret simply carries the previous return code. In reality,
> execution stops as soon as one program returns non-zero. This is
> because call_int_hook() breaks out of the loop when RC !=3D 0, so later
> programs are not executed.
>
> Signed-off-by: arielsilver77@gmail.com <arielsilver77@gmail.com>
> ---
>  Documentation/bpf/prog_lsm.rst | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/bpf/prog_lsm.rst b/Documentation/bpf/prog_lsm.=
rst
> index ad2be02f3..92bfb64c2 100644
> --- a/Documentation/bpf/prog_lsm.rst
> +++ b/Documentation/bpf/prog_lsm.rst
> @@ -66,21 +66,17 @@ example:
>
>     SEC("lsm/file_mprotect")
>     int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
> -            unsigned long reqprot, unsigned long prot, int ret)
> +            unsigned long reqprot, unsigned long prot)
>     {
> -       /* ret is the return value from the previous BPF program
> -        * or 0 if it's the first hook.
> -        */
> -       if (ret !=3D 0)
> -           return ret;
> -

This is correct as of today, the return value is checked implicitly by
the generated trampoline and the next program in the chain is only
called if this is zero as BPF LSM programs use the modify return
trampoline:

in invoke_bpf_mod_ret:

/* mod_ret prog stored return value into [rbp - 8]. Emit:
* if (*(u64 *)(rbp - 8) !=3D 0)
* goto do_fexit;
*/
/* cmp QWORD PTR [rbp - 0x8], 0x0 */
EMIT4(0x48, 0x83, 0x7d, 0xf8); EMIT1(0x00);

Acked-by: KP Singh <kpsingh@kernel.org>

