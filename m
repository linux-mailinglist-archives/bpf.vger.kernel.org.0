Return-Path: <bpf+bounces-34913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64A9326B1
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 14:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F2FB210E8
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2F919AA58;
	Tue, 16 Jul 2024 12:36:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593417C23D;
	Tue, 16 Jul 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133403; cv=none; b=Sn1TiaitTPI8dVrg4oYPMP0Ew80GAw5WatellAbMFAkSfIx6Fd6OYBV5RZ9eVd3sOCnwrnDCJC79GHDmdgMK2T5Yjqdh6c6fDlFevxgY9H0zbmkRa+EvkWxLuCKLOjwQH5WSgYUKU7mv+WIN2B6rxCa02IEs/1txQbsQr6TN/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133403; c=relaxed/simple;
	bh=W7n5vfMLjSj98w//EJCKimU18gg1EXqJ4tB4oYgfrjU=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7fzhmaKptNceR3HnTvLXzSKAtPtz7lp23S5uFXb5FqbQdyfE+khlEx2UZhMn59oaW7YSCiJa8FcjdL6Qv78UmqDlGawCMxzkABQIMrjXxK7wNZrG0OItLu+6m1Gs1eqckHYb3vpRdgFUVIfBQ0ps+P+9sYCSw0zbbcadxMySUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=amazon.com; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
X-Amazon-filename: signature.asc
X-IronPort-AV: E=Sophos;i="6.09,211,1716249600"; 
   d="asc'?scan'208";a="415104187"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 12:36:39 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:44857]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.12.239:2525] with esmtp (Farcaster)
 id fd760f37-0450-4c56-abc8-1c20c3b32b70; Tue, 16 Jul 2024 12:36:38 +0000 (UTC)
X-Farcaster-Flow-ID: fd760f37-0450-4c56-abc8-1c20c3b32b70
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 16 Jul 2024 12:36:34 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 16 Jul 2024 12:36:32 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Tue, 16 Jul 2024 12:36:32 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id B580F20AC8; Tue, 16 Jul 2024 12:36:31 +0000 (UTC)
From: Puranjay Mohan <puranjay@kernel.org>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Russell King <russell.king@oracle.com>, Alan Maguire
	<alan.maguire@oracle.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	<stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.10] arm64/bpf: Remove 128MB limit for BPF JIT programs
In-Reply-To: <20240701114659.39539-1-pjy@amazon.com>
References: <20240701114659.39539-1-pjy@amazon.com>
Date: Tue, 16 Jul 2024 12:36:29 +0000
Message-ID: <mb61py1617bua.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha512;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


+CC Greg

> From: Russell King <russell.king@oracle.com>
>
> [ Upstream commit b89ddf4cca43f1269093942cf5c4e457fd45c335 ]
>
> Commit 91fc957c9b1d ("arm64/bpf: don't allocate BPF JIT programs in module
> memory") restricts BPF JIT program allocation to a 128MB region to ensure
> BPF programs are still in branching range of each other. However this
> restriction should not apply to the aarch64 JIT, since BPF_JMP | BPF_CALL
> are implemented as a 64-bit move into a register and then a BLR instructi=
on -
> which has the effect of being able to call anything without proximity
> limitation.
>
> The practical reason to relax this restriction on JIT memory is that 128M=
B of
> JIT memory can be quickly exhausted, especially where PAGE_SIZE is 64KB -=
 one
> page is needed per program. In cases where seccomp filters are applied to
> multiple VMs on VM launch - such filters are classic BPF but converted to
> BPF - this can severely limit the number of VMs that can be launched. In a
> world where we support BPF JIT always on, turning off the JIT isn't alway=
s an
> option either.
>
> Fixes: 91fc957c9b1d ("arm64/bpf: don't allocate BPF JIT programs in modul=
e memory")
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Russell King <russell.king@oracle.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Link: https://lore.kernel.org/bpf/1636131046-5982-2-git-send-email-alan.m=
aguire@oracle.com
> [Replace usage of in_bpf_jit() with is_bpf_text_address()]
> Signed-off-by: Puranjay Mohan <pjy@amazon.com>
> ---
>  arch/arm64/include/asm/extable.h | 9 ---------
>  arch/arm64/include/asm/memory.h  | 5 +----
>  arch/arm64/kernel/traps.c        | 2 +-
>  arch/arm64/mm/extable.c          | 3 ++-
>  arch/arm64/mm/ptdump.c           | 2 --
>  arch/arm64/net/bpf_jit_comp.c    | 7 ++-----
>  6 files changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/ex=
table.h
> index b15eb4a3e6b20..840a35ed92ec8 100644
> --- a/arch/arm64/include/asm/extable.h
> +++ b/arch/arm64/include/asm/extable.h
> @@ -22,15 +22,6 @@ struct exception_table_entry
>=20=20
>  #define ARCH_HAS_RELATIVE_EXTABLE
>=20=20
> -static inline bool in_bpf_jit(struct pt_regs *regs)
> -{
> -	if (!IS_ENABLED(CONFIG_BPF_JIT))
> -		return false;
> -
> -	return regs->pc >=3D BPF_JIT_REGION_START &&
> -	       regs->pc < BPF_JIT_REGION_END;
> -}
> -
>  #ifdef CONFIG_BPF_JIT
>  int arm64_bpf_fixup_exception(const struct exception_table_entry *ex,
>  			      struct pt_regs *regs);
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/mem=
ory.h
> index 505bdd75b5411..eef03120c0daf 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -44,11 +44,8 @@
>  #define _PAGE_OFFSET(va)	(-(UL(1) << (va)))
>  #define PAGE_OFFSET		(_PAGE_OFFSET(VA_BITS))
>  #define KIMAGE_VADDR		(MODULES_END)
> -#define BPF_JIT_REGION_START	(KASAN_SHADOW_END)
> -#define BPF_JIT_REGION_SIZE	(SZ_128M)
> -#define BPF_JIT_REGION_END	(BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
>  #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
> -#define MODULES_VADDR		(BPF_JIT_REGION_END)
> +#define MODULES_VADDR		(_PAGE_END(VA_BITS_MIN))
>  #define MODULES_VSIZE		(SZ_128M)
>  #define VMEMMAP_START		(-VMEMMAP_SIZE - SZ_2M)
>  #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 563d07d3904e4..e9cc15414133f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -913,7 +913,7 @@ static struct break_hook bug_break_hook =3D {
>  static int reserved_fault_handler(struct pt_regs *regs, unsigned int esr)
>  {
>  	pr_err("%s generated an invalid instruction at %pS!\n",
> -		in_bpf_jit(regs) ? "BPF JIT" : "Kernel text patching",
> +		"Kernel text patching",
>  		(void *)instruction_pointer(regs));
>=20=20
>  	/* We cannot handle this */
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index aa0060178343a..9a8147b6878b9 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -5,6 +5,7 @@
>=20=20
>  #include <linux/extable.h>
>  #include <linux/uaccess.h>
> +#include <linux/filter.h>
>=20=20
>  int fixup_exception(struct pt_regs *regs)
>  {
> @@ -14,7 +15,7 @@ int fixup_exception(struct pt_regs *regs)
>  	if (!fixup)
>  		return 0;
>=20=20
> -	if (in_bpf_jit(regs))
> +	if (is_bpf_text_address(regs->pc))
>  		return arm64_bpf_fixup_exception(fixup, regs);
>=20=20
>  	regs->pc =3D (unsigned long)&fixup->fixup + fixup->fixup;
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 807dc634bbd24..ba6d1d89f9b2a 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -41,8 +41,6 @@ static struct addr_marker address_markers[] =3D {
>  	{ 0 /* KASAN_SHADOW_START */,	"Kasan shadow start" },
>  	{ KASAN_SHADOW_END,		"Kasan shadow end" },
>  #endif
> -	{ BPF_JIT_REGION_START,		"BPF start" },
> -	{ BPF_JIT_REGION_END,		"BPF end" },
>  	{ MODULES_VADDR,		"Modules start" },
>  	{ MODULES_END,			"Modules end" },
>  	{ VMALLOC_START,		"vmalloc() area" },
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 18627cbd6da4e..2a47165abbe5e 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1145,15 +1145,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_p=
rog *prog)
>=20=20
>  u64 bpf_jit_alloc_exec_limit(void)
>  {
> -	return BPF_JIT_REGION_SIZE;
> +	return VMALLOC_END - VMALLOC_START;
>  }
>=20=20
>  void *bpf_jit_alloc_exec(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
> -				    BPF_JIT_REGION_END, GFP_KERNEL,
> -				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> -				    __builtin_return_address(0));
> +	return vmalloc(size);
>  }
>=20=20
>  void bpf_jit_free_exec(void *addr)
> --=20
> 2.40.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZpZpTxQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nRhaAP9Nuu68cfxKp8A7G2ZWurpQd9n9dcus
U/4aCK0askqnYgEA6Oq+nM1tOovIPsXyQrTnEAn2d/kWvRHu/LoMQaNfqg8=
=5di0
-----END PGP SIGNATURE-----
--=-=-=--

