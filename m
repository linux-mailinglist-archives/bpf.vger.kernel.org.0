Return-Path: <bpf+bounces-78733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0738D1A0DE
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 17:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BA563012C4F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34E38A728;
	Tue, 13 Jan 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBjDKyux"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE773043D5
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319968; cv=none; b=OOH+DKDVHehs5+A5fo4IxFlrSIb/Mv55YdRH3/WVMmT1bjpJ8Cmn8oqud1tlWX5eAs96dG97lGnJAuoKkRhdYuthyEpLIfJxiGxX28wyUTED7IN8HN+FceB3dr0RNfMWbpyTbYZ6bg++/utHdgTuMz6l3uB/up2YtlcJMiK46NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319968; c=relaxed/simple;
	bh=H1N0nZPSCd6I+22Q5tt1+wvb9vg+1fgYFxwvwJBheOk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VUCoawV3HTPJN1LD3em6kutY4Opkv//GqJsKXXCXOtqh1+4w2Ke9H8WywIZVw+noxOOY5atABrnx7wN7oFrhyCuAl90fTUKuPA4CzWWfKyg2cnRuigqWUwtAGCD53bzsKjfm7bcmH1RVpAxDjBF/nO3/dQkb7G2zxGKrQECULFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBjDKyux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75AAC116C6;
	Tue, 13 Jan 2026 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768319968;
	bh=H1N0nZPSCd6I+22Q5tt1+wvb9vg+1fgYFxwvwJBheOk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IBjDKyuxKZg6GG/se+Nyr/8DRVqG0w3CDDMlqM4LC1/HhaSV/vGrHian4ZLfJJMlp
	 eJyr7U0nY3OJ4Qr7VSjmM+sanU+JouUWzPASDwHsaoFKD/HIcDEHdOuYDL8G3R7UDP
	 jfTCG/IoZ1MyFcPPVewwXMX8cXfVGgEPrIGePPk9Qr0mrg5/UkD7EYntZKh4ydfn30
	 +l+m+56W6GzBz7RTk1y03u8iArSkDYfNV5hueQ0mrDNjyB/4K3FbwM8BbfGvL+HMWi
	 N1emXOn1iCiqhjewDUqrk1cqKITEqhD0AHuWeULhIxckJzJbw8KM22nVoHO+g1PXhv
	 236nI8j0/rWog==
Content-Type: multipart/mixed; boundary="===============3638536524982155259=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a23915ffa77e55ed6fec6c202b60eff0661d729b2c25bc2de33fa52135edc9c9@mail.kernel.org>
In-Reply-To: <20260113152529.3217648-2-puranjay@kernel.org>
References: <20260113152529.3217648-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support negative offsets, BPF_SUB, and alu32 for linked register tracking
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 13 Jan 2026 15:59:27 +0000 (UTC)

--===============3638536524982155259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53635ea2e41b..8a4f00d237ee 100644

[ ... ]

> @@ -16821,7 +16836,7 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
>  			s32 saved_off = reg->off;
>
>  			fake_reg.type = SCALAR_VALUE;
> -			__mark_reg_known(&fake_reg, (s32)reg->off - (s32)known_reg->off);
> +			__mark_reg_known(&fake_reg, (s64)reg->off - (s64)known_reg->off);
>
>  			/* reg = known_reg; reg += delta */
>  			copy_register_state(reg, known_reg);
> @@ -16835,6 +16850,8 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
>  			scalar32_min_max_add(reg, &fake_reg);
>  			scalar_min_max_add(reg, &fake_reg);
>  			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
> +			if (reg->id & BPF_ADD_CONST32)
> +				zext_32_to_64(reg);

The comment above copy_register_state() says "Must preserve off, id and
add_const flag" but only off and subreg_def are actually restored after
the copy. At this point reg->id has been overwritten with known_reg->id.

If reg was created with a 32-bit operation (w1 += 5) it would have
BPF_ADD_CONST32 in its id. But if known_reg was created with a 64-bit
operation or has no ADD_CONST flag at all, then after copy_register_state()
the BPF_ADD_CONST32 flag is lost.

Should the original reg->id be saved before copy_register_state() and
used for the BPF_ADD_CONST32 check, similar to how saved_off is used?
For example:

    s32 saved_subreg_def = reg->subreg_def;
    s32 saved_off = reg->off;
    u32 saved_id = reg->id;   /* save original id */

    ...
    copy_register_state(reg, known_reg);
    reg->off = saved_off;
    reg->subreg_def = saved_subreg_def;
    ...
    if (saved_id & BPF_ADD_CONST32)   /* use saved_id */
        zext_32_to_64(reg);

>  		}
>  	}
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20962647765

--===============3638536524982155259==--

