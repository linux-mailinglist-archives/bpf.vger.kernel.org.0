Return-Path: <bpf+bounces-38067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B36195EE91
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 12:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70681F22C06
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3D71494DC;
	Mon, 26 Aug 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUTn5898"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176F146017
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668673; cv=none; b=PTesyP/khcuBN2JoHFqSh9JhoLLZ6djjERaUbJ9yjESlL4XkiUiGHq9QeU7Iels98r0KNdnhEAmztDfFIhmtQT+R6UeAPMhOerI2x46k84YMejVyJBxvvw/hQsQAio4Z6eNrZX7Wscs80uxAKDup0jJgtzK9psPoAOkUdst+MwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668673; c=relaxed/simple;
	bh=sPEcrJTwenHdVc/Yfnd8nSY6Fjv0xAC8DC3jZl33GvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fFifRKX2CS0BYVX+/RwfPSD9OPFYpxGyZeB+xfDwbdoWgfKj+JWQU4X38poywymvOL7XBRsI4NSjfuwIm14RX+cgPQ8g6g4/iJPGZFBOWxoDRJlh35JMqhN0rcwBeg6CY8oAW9bIT477SFX+T+2LuJryfXb9llUjXs/VEO/Nwlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUTn5898; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F40DC51401;
	Mon, 26 Aug 2024 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724668672;
	bh=sPEcrJTwenHdVc/Yfnd8nSY6Fjv0xAC8DC3jZl33GvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NUTn5898+wFjuV2k1z3xgymggw45/n9c7Mu/tCzpIzQZBPlxDUuaJKGQemJ9W6V1T
	 jdWolTPNWJOYlZ21F3Zn8S0H/B3sJbTB0CdtF+u9ZeMG0e353iALVgZBOV8mi6mQVY
	 D08+Vyvib6R9DtMTOJNAsYK36MUClrDiM6mye/pCJZFyD2trHQBUtf3T8VZ7zV2/XS
	 MvT0/UPtcSwxwuWWZ9ibaCKgR/0DBjVhRjNQquqt8VKfQ1wKMJp2i3kNbTszlNi+Ae
	 nYdAkwWzEv9ky3WbYXM56tii4stF0gB5sJzL87ZZwK8mLPQX0RKg5xX9fdeptf1GKg
	 scScJweFXcCEA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Leon Hwang
 <hffilwlqm@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>
Subject: Re: [PATCH bpf-next 0/2] bpf, arm64: Simplify jited prologue/epilogue
In-Reply-To: <20240826071624.350108-1-xukuohai@huaweicloud.com>
References: <20240826071624.350108-1-xukuohai@huaweicloud.com>
Date: Mon, 26 Aug 2024 10:37:33 +0000
Message-ID: <mb61pplpvo9hu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> From: Xu Kuohai <xukuohai@huawei.com>
>
> The arm64 jit blindly saves/restores all callee-saved registers, making
> the jited result looks a bit too compliated. For example, for an empty
> prog, the jited result is:
>
>    0:   bti jc
>    4:   mov     x9, lr
>    8:   nop
>    c:   paciasp
>   10:   stp     fp, lr, [sp, #-16]!
>   14:   mov     fp, sp
>   18:   stp     x19, x20, [sp, #-16]!
>   1c:   stp     x21, x22, [sp, #-16]!
>   20:   stp     x26, x25, [sp, #-16]!
>   24:   mov     x26, #0
>   28:   stp     x26, x25, [sp, #-16]!
>   2c:   mov     x26, sp
>   30:   stp     x27, x28, [sp, #-16]!
>   34:   mov     x25, sp
>   38:   bti j 		// tailcall target
>   3c:   sub     sp, sp, #0
>   40:   mov     x7, #0
>   44:   add     sp, sp, #0
>   48:   ldp     x27, x28, [sp], #16
>   4c:   ldp     x26, x25, [sp], #16
>   50:   ldp     x26, x25, [sp], #16
>   54:   ldp     x21, x22, [sp], #16
>   58:   ldp     x19, x20, [sp], #16
>   5c:   ldp     fp, lr, [sp], #16
>   60:   mov     x0, x7
>   64:   autiasp
>   68:   ret
>
> Clearly, there is no need to save/restore unused callee-saved registers.
> This patch does this change, making the jited image to only save/restore
> the callee-saved registers it uses.
>
> Now the jited result of empty prog is:
>
>    0:   bti jc
>    4:   mov     x9, lr
>    8:   nop
>    c:   paciasp
>   10:   stp     fp, lr, [sp, #-16]!
>   14:   mov     fp, sp
>   18:   stp     xzr, x26, [sp, #-16]!
>   1c:   mov     x26, sp
>   20:   bti j		// tailcall target
>   24:   mov     x7, #0
>   28:   ldp     xzr, x26, [sp], #16
>   2c:   ldp     fp, lr, [sp], #16
>   30:   mov     x0, x7
>   34:   autiasp
>   38:   ret
>
> Xu Kuohai (2):
>   bpf, arm64: Get rid of fpb
>   bpf, arm64: Avoid blindly saving/restoring all callee-saved registers
>

Acked-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay Mohan

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZsxa7hQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nTYrAQCOFfSHVX6+u8xLTQWxqf99QWDFuI0Y
G15E57BDE7BLYwEAj0SUSBgdyObJaKXXmWLl9mMK6+EDR99KBGz0ryg5LQw=
=vhV4
-----END PGP SIGNATURE-----
--=-=-=--

