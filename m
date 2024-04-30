Return-Path: <bpf+bounces-28287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E68B800F
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D0F1F22D0D
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B2B194C96;
	Tue, 30 Apr 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXDmZTRo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D149184139;
	Tue, 30 Apr 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502884; cv=none; b=HHcdN4JrKFTdNUmhCn+dH2WWgdZ4faRupQkGh38/EeBUIo7HA7h4ox3oBd1on3aM3/dB/7QnAQbX1z9BBNcnqkiXuTV29XjY1K4t9U9VQUW4RqU20GF1lqSQGn9kijjlhxp1vRQXM3cuxBqLJ43l/Da83fhG4F0hCDR1AaiMvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502884; c=relaxed/simple;
	bh=HPzjuRJ5yCLBNuv1aWWG9npK5939ao9xZ9NGuQ/3nUI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMZDpYrjbVPNlcKeXYzvYNaVjth3VwI4AKvcdZEcvP6lx+4F7AoBQCjDhzTFFiAUv/obqEGZ6IWw5F0OPAGDvAsQjw2qNnC7eUwIG4/qp2JMR+MFZz5Vxd1LXdt3eB2rSfL58PSPqljj0y3a/NmWtVyeqM/C4EG/8mSApUJk+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXDmZTRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60731C2BBFC;
	Tue, 30 Apr 2024 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714502883;
	bh=HPzjuRJ5yCLBNuv1aWWG9npK5939ao9xZ9NGuQ/3nUI=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=lXDmZTRouHLCs4AdMqtuDYka9dsVcqIW1NW+vdeMs8J0ylDQMwhfA5I4PM+uVm+Xm
	 s6rr3M61nsxv1ffqEI8k0X6v9oJ7YeZdmJj2kz0688kVEsd5ydMRjYBeZGKFfSjL6Q
	 yFSXUq1KiUZU4684hU59BKpvKPwvdOYlt94xrPoyl88wPUay5Z8AUXpScb/OfSl1i5
	 chH8ORZ4moLQgAklWzQXpZYrAXAGSHxdqKntBpOzpGrfYiFA3tJL8EDj2CP++8VRub
	 4zSfvqkpMcV2PP88PQJ8Zf+HUljRxgSJ6MWy29q8WyJfKSJlrUYEUqAzK7nc8ZUcD4
	 vY5teNHhL4haA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai
 <xukuohai@huawei.com>, Florent Revest <revest@chromium.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] bpf, arm64: inline
 bpf_get_smp_processor_id() helper
In-Reply-To: <20240429131647.50165-3-puranjay@kernel.org>
References: <20240429131647.50165-1-puranjay@kernel.org>
 <20240429131647.50165-3-puranjay@kernel.org>
Date: Tue, 30 Apr 2024 18:48:00 +0000
Message-ID: <mb61pzfta1ycf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> As ARM64 JIT now implements BPF_MOV64_PERCPU_REG instruction, inline
> bpf_get_smp_processor_id().
>
> ARM64 uses the per-cpu variable cpu_number to store the cpu id.

While implementing this on the RISC-V JIT[1], I realized that reading the
cpu_number from the per-cpu variable is not the best way to do this on
arm64.

arm64 now has the cpu number in the thread_info and reading that would
be more efficient.

Implementation in this patch is emitting:

; int cpu =3D bpf_get_smp_processor_id();
mov     x7, #0xffff8000ffffffff
movk    x7, #0x8207, lsl #16=20=20=20
movk    x7, #0x2008=20=20=20=20=20=20=20=20=20=20=20=20
mrs     x10, tpidr_el1=20=20=20=20=20=20=20=20=20
add     x7, x7, x10=20=20=20=20=20=20=20=20=20=20=20=20
ldr     w7, [x7]=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

If we do this in the JIT like I did for RISC-V[1]
We can emit:

; int cpu =3D bpf_get_smp_processor_id();
mrs     x10, sp_el0
ldr     w7, [x10, #24]

This gives ~ 10% improvement on glob-arr-inc and hash-inc compared to
3-4 % which this patch is providing.=20

I will send v5 using this approach.

[1] https://lore.kernel.org/all/20240430175834.33152-3-puranjay@kernel.org/

> Here is how the BPF and ARM64 JITed assembly changes after this commit:
>
>                                          BPF
>          		                =3D=3D=3D=3D=3D
>               BEFORE                                       AFTER
>              --------                                     -------
>
> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_smp=
_processor_id();
> (85) call bpf_get_smp_processor_id#229032       (18) r0 =3D 0xffff8000820=
72008
>                                                 (bf) r0 =3D &(void __perc=
pu *)(r0)
>                                                 (61) r0 =3D *(u32 *)(r0 +=
0)
>
> 				      ARM64 JIT
> 				     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>               BEFORE                                       AFTER
>              --------                                     -------
>
> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_smp=
_processor_id();
> mov     x10, #0xfffffffffffff4d0                mov     x7, #0xffff8000ff=
ffffff
> movk    x10, #0x802b, lsl #16                   movk    x7, #0x8207, lsl =
#16
> movk    x10, #0x8000, lsl #32                   movk    x7, #0x2008
> blr     x10                                     mrs     x10, tpidr_el1
> add     x7, x0, #0x0                            add     x7, x7, x10
>                                                 ldr     w7, [x7]
>
> Performance improvement using benchmark[1]
>
>              BEFORE                                       AFTER
>             --------                                     -------
>
> glob-arr-inc   :   23.817 =C2=B1 0.019M/s      glob-arr-inc   :   24.631 =
=C2=B1 0.027M/s [+ 3.41%]
> arr-inc        :   23.253 =C2=B1 0.019M/s      arr-inc        :   23.742 =
=C2=B1 0.023M/s [+ 2.10%]
> hash-inc       :   12.258 =C2=B1 0.010M/s      hash-inc       :   12.625 =
=C2=B1 0.004M/s [+ 3.00%]
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef


Thanks,
Puranjay

