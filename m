Return-Path: <bpf+bounces-79516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2CD3B8B9
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 21:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3947730215CF
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E562F4A15;
	Mon, 19 Jan 2026 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhJ1HH99"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3C221264
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855402; cv=none; b=MIAQDfnDeBzIrz21BfJ8zagasXLCGih9R40ZedUo6dXGGzBVJ7wQLwfgiXQo9johxHoiBsFLz1Y8FMcEElxUaF/khlVWxxuiNUna+iJakYciL6vIJ3k327YkPe5HROU0oxpdB8w30g5uzKCYRCipO5EOuKpUKZfsTzjKQ1b917s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855402; c=relaxed/simple;
	bh=DK2Ox8tRf41I/4CD4+ghBJ+W5QUWZRQ+vztmjdsTTqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EAR1Udt/JHy8HxnO/tFowCmPFWWY2NF5Qu6j/yOrpG8Y3/VI8necTICiRzmqy4sWAoACNv1dK7tFfALbHikzIyY/SgDFTopInQrLzx0iPvZAy7t9pM5wKBkJt8j1d+CoHQD2IDwg2qIm7T1vHnJkUkomaLyVAQoWyaQ2KjssuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhJ1HH99; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b6f5a9cecaso587889eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 12:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768855400; x=1769460200; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DTswKAcXHjAjSVyIK1XhIPE0y5rf4rz1XBF2jXNueWY=;
        b=FhJ1HH99snS+SHpToAS5YIGC0c4wfHyT7rHOCl+ez9ftC+4sX6NyHrXkdU/quQNQ6t
         tQKw7EVuPUwztix6MHNbgc9/NeSH9EzxUYs7S5qNN+A98VnRrOzGT8SZXc/PyoALvG95
         8lRzV1brXD1TK45NucwleUPVa73k+RxtY3Nmd3ERUgZJfig9YpfBrGjxTSX9Wfg4zjct
         tUpz8Y/9zrnd/zsgkw3SpCCEPVTDLiDYMTAoHiQhxEUKWO1UE8wOh0qqfYrGan4e8Slt
         P5YccK2ylbXqUFHtCC7sYLeiEFNTBz45pIgConCxiXg7MziVGxef8uP5jH9PRiEYC3oc
         CmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855400; x=1769460200;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTswKAcXHjAjSVyIK1XhIPE0y5rf4rz1XBF2jXNueWY=;
        b=wJhRYmbHQGvp0E38z1/8c/x+h8m4xBkcOp88Rqzt2iVouaTx8KFY6kmt2L+fmYrmkm
         qU96u27rU5JZVJgFzoq8koPXMFQfPAux/qv409JF7M5z2soeiwk9AMF8agujRAvw6EEX
         +j5jOSM4nLn6NxR8gjHL83813jBbD/6XOBl/bG71nkXOMCVkQvGk9tTvDS+jKdF1AoZk
         6616tsQkcgsbcP7rfuFGvAgBizJSqKG8vMdcoq8kCFKlZobRqbAEAgoqRmBLtahUn4jK
         dELY0sLddUrjt2QKl6qHeqewTb0I6ClYmOf2ZvnIK+vanx+2D64jvzXCpvl7Wmhkozoo
         awKg==
X-Forwarded-Encrypted: i=1; AJvYcCUdnwQDSKya6c5q0O7KaK6x/BMh3LvntRUS8nw0KH6hAYlLIDOdm4PTsfWzpVJ2PdB8uU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+gb2SKcRfl3NErcxowfSxhGLNzUhXPNCVmAIezRg7OIA64x0
	EibeA03QTWLeTHbYz6AmGGfn9cJ+65WRq4APJycnOV9SwLDvQUjLds0+
X-Gm-Gg: AZuq6aLzZL4bvzQSCbtrrSu2Ws5xSnBU1QGwgzp8QUXurc4yACAUkwIVuCVMR8YUTFi
	6PmX3EzKKWG+p4dUvO/4KBRVeLOvIeg/IqKXg7gCeyCL9ulNrr3ZCGGXlcr/92BAcnZcO37qhx0
	ReCSWsfHdZt0muUfOVHkgbhaNMxPfgi7dcUHaQGT6orMoulTm2ZJZR+D9YhSeE60Ph4t/JbH9h1
	L+oa0h2+Wn8AAYPAvaZk/XpYCAOiO0RdgW5hbqVGfTRuO7XQnLpzJ5SlJ/Dd9EEyddIDf3MSteM
	23Hcb8FVuKaIzRddIrZOkDefD6AjxXSCmE97yo457RpcR625B7C7deFXxuqXysXB1Z6BwwC2VUy
	bekwSwZIXqmIvJRYFrkMFHcL3CBA1Cg8BoHd4eTgJj58/A15rz9KUCCLY+qbmac1sBI3WpH3eoC
	cXA446egYzqjZbwSiBoFK0xhsDUpTq21wpyc2E0Ubxr2AQPU3Fp9cZu9/ZaYZ8mfEORQ==
X-Received: by 2002:a05:7300:dc85:b0:2ae:601f:f4f7 with SMTP id 5a478bee46e88-2b6b410b233mr8446466eec.40.1768855400395;
        Mon, 19 Jan 2026 12:43:20 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbd4sm14492703eec.33.2026.01.19.12.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:43:20 -0800 (PST)
Message-ID: <e2403635a55fcf95e3d2aac7c0606388a62c713a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 19 Jan 2026 12:43:17 -0800
In-Reply-To: <20260119070246.249499-2-dongml2@chinatelecom.cn>
References: <20260119070246.249499-1-dongml2@chinatelecom.cn>
	 <20260119070246.249499-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 15:02 +0800, Menglong Dong wrote:
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
                                                                   ^^^^^^
					Nit: this change is no longer x86 specific.

> to obtain better performance.
>=20
> In !CONFIG_SMP case, the percpu variable is just a normal variable, and
> we can read the current_task directly.
>=20
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -23319,6 +23323,24 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>  			insn      =3D new_prog->insnsi + i + delta;
>  			goto next_insn;
>  		}
> +
> +		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inl=
ine. */
> +		if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn->imm =3D=3D BP=
F_FUNC_get_current_task_btf) &&
> +		    verifier_inlines_helper_call(env, insn->imm)) {
> +			insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&current=
_task);
> +			insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> +			insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
                                                 ^^^^^^^
			Silly question:
			  This assumes pointer size of 8 bytes.
			  Which is true for all archs where bpf_jit_supports_percpu_insn()
			  returns true at the moment. Do we want an additional safety check
			  here?

> +			cnt =3D 3;
> +
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    +=3D cnt - 1;
> +			env->prog =3D prog =3D new_prog;
> +			insn      =3D new_prog->insnsi + i + delta;
> +			goto next_insn;
> +		}
>  #endif
>  		/* Implement bpf_get_func_arg inline. */
>  		if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&

