Return-Path: <bpf+bounces-68862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF3B86FC7
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 23:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB095818B4
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184F72F5A2E;
	Thu, 18 Sep 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emZ+exrG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102872F3632
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229226; cv=none; b=rhCxL/b6/TN0OD7jtfV+w4UEP1lgB9dPKEG7lxe5sdjcrXp5+Kv1vNAhL5Hgs5J7IC2//LGN1IWKc7Bi1dLHIfeCII8JLgiSV97hoVAqQIuj9wbnOTDh+yVnHDLzpXljQKhpnwLXL2g6oWahMAHFMMnIT7HKLjjgTeP1VVCwnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229226; c=relaxed/simple;
	bh=m2AY+dTHUFCIVPNKpFfyxspidRLOgvX/vcvm37BiScg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NuN8woybFQSWiN8ehRvRoTo7ILHsgNCJFL6BP6DTysFJDHQQBrJQ41quGAxEaPAuj+28P2QQFHGtNJssIGy8IE/o653Nhs9kDj2P78L2apPxslx/mUSzO+63Wp+XxgDHRZNvFYSjj9+LnoazGDYm8WWBElidaXnA/5ru/xep61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emZ+exrG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77d64726e47so996952b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758229224; x=1758834024; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BWNrKzoKGn0Mg3+cCGhe36Q1YywPLG4pBTqfXb9sGs0=;
        b=emZ+exrGMWd35nk7rvVZWxTL5lBlL4HIqmvD0OiLbTUl+AH69D07vWGFxUBtm64q6i
         gWj5l5MYnHMmX5RtVi2QFAL9hCO7u7tslknc+Sd7glpjomI+27oVpLLiRtKG1NsfpKom
         hhe/6Q1MShFKcXIvnKBY2Vsb8JP2gwczs8BorhTKkZpIeDHfaxDhHiL+zdC5EwecAzxp
         gVk9rs84bJ6oopM/T7f20vcuRxiLktMJ/+Uq9gkfFhqW5VjY/YJmrZjsWdVJnCwQqbNi
         KTvkYEzXrZvgvzEsnnfETABRs1U8DRGlnVomHxw8/F9ck4wmGjChnX2G1vajflv0OlJl
         bbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229224; x=1758834024;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWNrKzoKGn0Mg3+cCGhe36Q1YywPLG4pBTqfXb9sGs0=;
        b=C767RHseyoA6HDH8xxXJK0lrC/kkU4RQKtri0CtT41mewu6Q9X3cwuqJUjOq+3xRho
         isYHii8XalFd2gL6I8JsPzghUECONNb4B9ZcnvYdVCxdVr6Y52LM77vZHL5OjMnTYtMa
         txs9l1nsbk+2LlJvZcRNXLeFfbioW1H90jxQNBYz1JAOKbMK8T2Xv3U+ELHTxKFaJvSc
         NhOKZ1fsE3S2hQSN3r4dn82FBllbG1+70YDJBvq6JXmj4QQxJOHiKygg4NUAuE1VCz9c
         dPKVExEaKrT0xxhaR8+aGSxD5hus/NqtCzjd8FImTpBFhnpaqlfNpkpUYUeL8s5QQ6Un
         zl3w==
X-Forwarded-Encrypted: i=1; AJvYcCXTAesX6bvstm/h9ERVCwcZRtNbz0CN62A88c5W7YBuRh4gkGqds8Dd6UJYrvg13cLg8yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWtxR457I9N8FDTrOetHCGmk01pJEKgFoM+2KATGBY2IcrwMe
	VBDO6MhlJsfsIwvNf/D7Rxkwd4Jg00RuEnsueaZkZVQkL7VIFRm0cYUqpNijVdPT
X-Gm-Gg: ASbGncvqgUOIr807TB1Vf9qekicoxeWNVDpCkRmY8ex1jxheAbn9hHIzEAiLXMIhL4U
	SU0iTphyQ0tMTqeusrHxPACAT3HjYn1kj2thT1Rfy47DNSf3+/N6bEzIZgbyCaMN1OzrUQi4nGG
	hf3HB6ePylkrYF83GunzJejdZK6KvtpNHq5aaW/RLfN7cM+JTWt3rb0pjE4WufFaFTTxy6gmeCl
	tdcAST+M6RTw35MC7aZl5G+a0sihaUAnIDv11UgFknqqxeTp+XiTqr0tnRa3xUMQKTQ1USAhATw
	rddMxH0mKj3tJtA7f0Cdy8gv9cL3RBEKSm12PiCfKeK+hbjNtgECU+7yG2G1aNSvJbrT2Vrx9mX
	a4r4TDnKlbD7rkkE+Q2Onaf7Xy352mQzkRSL5wG6hdBnzsZtv
X-Google-Smtp-Source: AGHT+IHKB1TdMLCYCaaR8+McqBs+0wf8x3+gEjCVrNk3wB3sKpdXrgszgkvzjjmaMF7jAlXi340iNg==
X-Received: by 2002:a05:6a20:4303:b0:263:1475:667a with SMTP id adf61e73a8af0-2925e423832mr1368263637.21.1758229224162;
        Thu, 18 Sep 2025 14:00:24 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7c3bbsm3224797b3a.7.2025.09.18.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:00:23 -0700 (PDT)
Message-ID: <412f49fa12de7c7f5d0461b56fd4e0b6882fa0ad.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Enforce RCU protection for
 KF_RCU_PROTECTED
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Andrea Righi <arighi@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Tejun
 Heo <tj@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Thu, 18 Sep 2025 14:00:20 -0700
In-Reply-To: <20250917032755.4068726-2-memxor@gmail.com>
References: <20250917032755.4068726-1-memxor@gmail.com>
	 <20250917032755.4068726-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 03:27 +0000, Kumar Kartikeya Dwivedi wrote:
> Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
> in a convoluted fashion: the presence of this flag on the kfunc is used
> to set MEM_RCU in iterator type, and the lack of RCU protection results
> in an error only later, once next() or destroy() methods are invoked on
> the iterator. While there is no bug, this is certainly a bit
> unintuitive, and makes the enforcement of the flag iterator specific.
>=20
> In the interest of making this flag useful for other upcoming kfuncs,
> e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfunc
> in an RCU critical section in general.
>=20
> This would also mean that iterator APIs using KF_RCU_PROTECTED will
> error out earlier, instead of throwing an error for lack of RCU CS
> protection when next() or destroy() methods are invoked.
>=20
> In addition to this, if the kfuncs tagged KF_RCU_PROTECTED return a
> pointer value, ensure that this pointer value is only usable in an RCU
> critical section. There might be edge cases where the return value is
> special and doesn't need to imply MEM_RCU semantics, but in general, the
> assumption should hold for the majority of kfuncs, and we can revisit
> things if necessary later.
>=20
>   [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loeh=
le@arm.com
>   [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvidia.c=
om
>=20
> Tested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -14037,6 +14045,8 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
> =20
>  			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_get_kmem_cache])
>  				regs[BPF_REG_0].type |=3D PTR_UNTRUSTED;
> +			else if (is_kfunc_rcu_protected(&meta))
> +				regs[BPF_REG_0].type |=3D MEM_RCU;
> =20
>  			if (is_iter_next_kfunc(&meta)) {
>  				struct bpf_reg_state *cur_iter;

The code below this hunk looks as follows:

			if (is_iter_next_kfunc(&meta)) {
				struct bpf_reg_state *cur_iter;

				cur_iter =3D get_iter_from_state(env->cur_state, &meta);

				if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
					regs[BPF_REG_0].type |=3D MEM_RCU;
				else
					regs[BPF_REG_0].type |=3D PTR_TRUSTED;
			}

Do we want to reduce it to:

			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_get_kmem_cache])
				regs[BPF_REG_0].type |=3D PTR_UNTRUSTED;
			else if (is_kfunc_rcu_protected(&meta))
				regs[BPF_REG_0].type |=3D MEM_RCU;
			else if (is_iter_next_kfunc(&meta))
				regs[BPF_REG_0].type |=3D PTR_TRUSTED;

And mark relevant iterator next (and destroy?) functions as KF_RCU_PROTECTE=
D?
(bpf_iter_css_next, bpf_iter_task_next, bpf_iter_scx_dsq_next).

I ask, because setting |=3D MEM_RCU in two places of this if branch
looks a bit iffy.

[...]

