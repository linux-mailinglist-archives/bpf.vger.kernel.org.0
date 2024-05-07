Return-Path: <bpf+bounces-28959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD50E8BEEBD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D19281199
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695A573531;
	Tue,  7 May 2024 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bONYswX2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF571B5C;
	Tue,  7 May 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116434; cv=none; b=LSEHpN2huQR2D6hTcovqGDIQHYq6XfsZc3caICt1imfCuXonm9qId5UpYI8TpcfXP61xiuPbKVn5IaB1db83geyGcxVOAQfYjTALyODrtIhSTNYlFcaS65h5IBR7Fw57cG/DAf1Zsx8hDGKAH+FY32YkAU82nVFk0LXcKnJ2KFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116434; c=relaxed/simple;
	bh=+CnbgeoeyKY+pUuJ0UF7xYamzyyRqgzkqxZgusuLnDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOqpX2ebvWFOaL/hZ8fbxjZPk6ED/saTR9kUZP6UCRbiUAwY9nGy2dS+zSWTEtxcYIYwCP0pwZtxQblFzLVktU/BBl+nwtduKbdhWTD8Ni+B+Ucv3FHQ9vpAibLdO25wz/FG5Ea9FIaXY3EJDuoeYQMBLnkbVWHTcYqFsJfqdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bONYswX2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a599a298990so987332766b.2;
        Tue, 07 May 2024 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715116431; x=1715721231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=001STfTEIi9HG/YmKeuC4M5zLrVfd9BrqAqYYhpSj4w=;
        b=bONYswX2ppKbReLeWZAEjal2mQUvqusaGPRp/6m+VUWN0EBK7SR0CZ8jpyDKAw8ory
         Vo7m9bX0SrI48uhSZdb9QwfDEEq8UySRVGWlf6pAglD7Xl9qbWzBMo8ku2K/FBxBYvry
         TEpqRC2op5chW/oQw3lq6FGw0EKhGSNAfzCDQHkjmhwjJG90quqp0wQegTOYF7ZzKMwt
         5pSRKHECtMlF2igVTsCKTKfiULA7f0WEALmtX3onbpTDyuj6D9WVVz6AKIHH/gS+/0Z8
         hs3llCScXJ+08Yzbidtaij8WwTAVF/xRbQMt85HGiM+SLTebo8WWu4MXX88hB35MeA/U
         7atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715116431; x=1715721231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=001STfTEIi9HG/YmKeuC4M5zLrVfd9BrqAqYYhpSj4w=;
        b=PPp+1DFFNvyy3TMo+LQSMEB1OCpxVp7AKJRuMxBqxkCDX22+B89fSBJlAl358hAEuB
         PFckt/OELtq0pySlQUxtsAwgCe3dZ3RWuae73GEfuEzbqQPDTgHPVqb9qlDblJS4CWZx
         ZqD5IV6NsVjPTMLrBqvrmRhLThbzswVzgVSZDhp67tYYw2NAbn4mHikZFjy3KTCiVzve
         5bNCJ+FXYETYLc7kZJC9ss/5jeIBmiIFhvzXYrcXdzyHG97mv103f/7Au8+5qHFtsQwN
         h1omLfwfaPE+IDiro+MX0b1eyZ64cqdWzsXG1ydt356TqMzlhOTF4U4AH+PsIlEmc4j7
         53cg==
X-Forwarded-Encrypted: i=1; AJvYcCXJq+sUASN17pmNbCQYUyLOK/tCkVquN7AF4LHvYP22OC4765UNfO0Q3JeB5qqc4e64zsDe7AuORW6RMmAQeSB91QWiiEJptrqj60crjdavHx5gAijjDGHsyG7D7NVxYd+4
X-Gm-Message-State: AOJu0Yx9pD9O7YzQ0KOPaWQ1awWIAtebh3owAPv34tTCZM/gBJT2AdZX
	E/ckyFozl5+Dp/xO1WezxVgS1phPs7WRIwVHbhqTuQ7v2658qlM/12NLnpCKgV9xcgPvebdEcmf
	zhmjrHGG3YSKrRXzOWuuXlhGgCOQ=
X-Google-Smtp-Source: AGHT+IHUGHnTRvMm9X123h02dodWBa2lkQmyUK9LajySIV8MnBD2b3k0S5vzr0OYU7IClNLHReNJd2boG1X34tX28K0=
X-Received: by 2002:a17:906:7c55:b0:a59:ae39:bfba with SMTP id
 a640c23a62f3a-a59fb959b4bmr40169466b.34.1715116430642; Tue, 07 May 2024
 14:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502151854.9810-1-puranjay@kernel.org> <20240502151854.9810-4-puranjay@kernel.org>
In-Reply-To: <20240502151854.9810-4-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 14:13:33 -0700
Message-ID: <CAEf4BzYxgvJ7fq3N_05yNtv09Tvkw9D2UtYC4Zqud71qWHeh9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/4] arm64, bpf: add internal-only MOV
 instruction to resolve per-CPU addrs
To: Puranjay Mohan <puranjay@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Zi Shen Lim <zlim.lnx@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huawei.com>, 
	Florent Revest <revest@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 8:19=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> From: Puranjay Mohan <puranjay12@gmail.com>
>
> Support an instruction for resolving absolute addresses of per-CPU
> data from their per-CPU offsets. This instruction is internal-only and
> users are not allowed to use them directly. They will only be used for
> internal inlining optimizations for now between BPF verifier and BPF
> JITs.
>
> Since commit 7158627686f0 ("arm64: percpu: implement optimised pcpu
> access using tpidr_el1"), the per-cpu offset for the CPU is stored in
> the tpidr_el1/2 register of that CPU.
>
> To support this BPF instruction in the ARM64 JIT, the following ARM64
> instructions are emitted:
>
> mov dst, src            // Move src to dst, if src !=3D dst
> mrs tmp, tpidr_el1/2    // Move per-cpu offset of the current cpu in tmp.
> add dst, dst, tmp       // Add the per cpu offset to the dst.
>
> To measure the performance improvement provided by this change, the
> benchmark in [1] was used:
>
> Before:
> glob-arr-inc   :   23.597 =C2=B1 0.012M/s
> arr-inc        :   23.173 =C2=B1 0.019M/s
> hash-inc       :   12.186 =C2=B1 0.028M/s
>
> After:
> glob-arr-inc   :   23.819 =C2=B1 0.034M/s
> arr-inc        :   23.285 =C2=B1 0.017M/s
> hash-inc       :   12.419 =C2=B1 0.011M/s
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/arm64/include/asm/insn.h |  7 +++++++
>  arch/arm64/lib/insn.c         | 11 +++++++++++
>  arch/arm64/net/bpf_jit.h      |  6 ++++++
>  arch/arm64/net/bpf_jit_comp.c | 14 ++++++++++++++
>  4 files changed, 38 insertions(+)

Catalin, Will, Zi,

Any objections to landing these patches into the bpf-next tree? Can we
get some acks from ARM64 folks? Thanks!

>
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.=
h
> index db1aeacd4cd9..8de0e39b29f3 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -135,6 +135,11 @@ enum aarch64_insn_special_register {
>         AARCH64_INSN_SPCLREG_SP_EL2     =3D 0xF210
>  };
>

[...]

