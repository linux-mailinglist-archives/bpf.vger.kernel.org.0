Return-Path: <bpf+bounces-32512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80490E9E5
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 13:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F3A28A828
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8613DDD9;
	Wed, 19 Jun 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHdlM58h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9784DF8
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796998; cv=none; b=tE7ScA6wGPExY0LosGW/PUJVLuPdjLau8C1rXAPMdYM+LQwB5y0fkh3PT7CqxvuWTx3sy5gyOM6IkXfk+hL/IC9R3IFnBq6R21q/1PaQ+T9WcvLweLOJGzXCF6L5klG6RktoOi3fazb3LGuiPUsC+5TPTNhOdIB5pxqcVhvESpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796998; c=relaxed/simple;
	bh=97sMBZk5qUV+tf8kCiuIKhTzJz127xFhJAW3iqxir7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6c2BpvHg1ioOBgBQkipTx/XwC+osIgLNtm67lVYxkJTm5AZAz3kYB/tn55G8lMqhKcbW9NjWQhiF1vcHRVIVH//hM5OZjvpiNVCb5k/dnXJInZAFSoa7alKrILa3ui0+d1t0kzdKh1kxVpuq/TR4aTfqDpd8woVNnx3Q3u2jrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHdlM58h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55451C32786;
	Wed, 19 Jun 2024 11:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718796997;
	bh=97sMBZk5qUV+tf8kCiuIKhTzJz127xFhJAW3iqxir7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mHdlM58hGtY/bySs03UDX6rfW4tidfuvssI8JHi+DocTLjDzz65i7JQW83K/4aKXB
	 QyX/JohcykCtIL1yL0tZ9KJvMnkM+1EcE7MPDhp+leY9izj5j5SJ1X/APzTmM/2/yz
	 y61LdSJ+xKDMZtL2Qn769oRV0edxBrg0qeIAwGq8na0giR84XSqdi3h3L/LAkI4o4v
	 B0hHoO7C2vhBeQyBmBszPzUAIEdEBS5d6/7qd3Vo0iYzbDJkU5w+BVvhXcEwSc4cba
	 +Ro8tlksKSJkoPSpts7Hcpf0Um1zYW5xwdT7hfHUAirA9taPb63AVw71BYrulyGaUX
	 fKWuTuSSQ9FGg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Dave
 Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Rishabh
 Iyer <rishabh.iyer@berkeley.edu>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Subject: Re: [PATCH bpf-next v2 0/2] Zero overhead PROBE_MEM
In-Reply-To: <20240619092216.1780946-1-memxor@gmail.com>
References: <20240619092216.1780946-1-memxor@gmail.com>
Date: Wed, 19 Jun 2024 11:36:20 +0000
Message-ID: <mb61pzfrhxiyz.fsf@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> BPF programs that are loaded by privileged users (with CAP_BPF and
> CAP_PERFMON) are allowed to be non-confidential. This means that they
> can read arbitrary kernel memory, and also communicate kernel pointers
> through maps and other channels of communication from BPF programs to
> applications running in userspace.
>
> This is a critical use case for applications that implement kernel
> tracing, and observability functionality using BPF programs, and
> provides users with much needed visibility and context into a running
> kernel.
>
> There are two supported methods of such kernel memory "probing", using
> bpf_probe_read_kernel (and related) helpers, or using direct load
> instructions of untrusted kernel memory (e.g. arguments to tracepoint
> programs, through bpf_core_cast casting, etc.).
>
> For direct load instructions on untrusted kernel pointers, the verifier
> converts these to PROBE_MEM loads, and the JIT handles these loads by
> adding a bounds check and handling exceptions on page faults (when
> reading invalid kernel memory).
>
> So far, the implementation of PROBE_MEM (particularly on x86) has relied
> on bounds check because it needs to protect the BPF program from reading
> user addresses.  Loads for such addresses will lead to a kernel panic
> due to panic in do_user_addr_fault, because the page fault on accessing
> userspace address in kernel mode will be unhandled.
>
> This patch instead proposes to do exception handling in
> do_user_addr_fault when user addresses are accessed by a BPF program,
> and when SMAP is enabled on x86. This would obviate the need for the BPF
> JIT to emit bounds checking for PROBE_MEM load instructions, and any
> invalid memory accesses (either for user addresses or unmapped kernel
> addresses) will be handled by the page fault handler.
>
> This set does not grant programs any additional privileges than those
> they already had. Instead, it optimizes the common case of doing loads
> on valid kernel memory, while shifting the cost to cases where invalid
> kernel memory is accessed without sanitization by a program.
>
> Changelog:
> ----------
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20240515233932.3733815-1-memxor@gmail.com
>
>  * Rebase on bpf-next
>
> Kumar Kartikeya Dwivedi (2):
>   x86: Perform BPF exception fixup in do_user_addr_fault
>   bpf, x86: Skip bounds checking for PROBE_MEM with SMAP
>
>  arch/x86/mm/fault.c         | 11 +++++++++++
>  arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
>
> base-commit: f6afdaf72af7583d251bd569ded8d7d1eeb849c2
> --=20
> 2.43.0

We can also do something like this for ARM64 when PAN(Privileged Access
Never) is available. And if we are doing it then for RISC-V we can
remove this bounds checking completely because RISC-V always traps when
kernel accesses userspace addresses outside of uaccess routines.

But I am curious to know what other developers think about this.


Acked-by: Puranjay Mohan <puranjay@kernel.org>


Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZnLCtRQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2neg5AP9n2G7o48XylHgMWIUKffZ9d/r/uEMn
GliTMy3EfvBZ3gD+KDqfcoFd+7VsU58okBChoj9UXEcx9FUCnLt7m5CscQM=
=2gES
-----END PGP SIGNATURE-----
--=-=-=--

