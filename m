Return-Path: <bpf+bounces-37219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA115952566
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 00:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E691F23D1E
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1871494D0;
	Wed, 14 Aug 2024 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQQ7L6Pf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140A35894
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673871; cv=none; b=B4Q1BkAFaSu5G4pNFTYA5ixCzvHQBOPUPTsC8+LcXueB/ZKLrYKDwu416XUKU7uGvNUWdX4uYE2p0O8KTQdHEStKRYf67MSK0aHqgsqqhxPKvq8xZR4lcFJNJNeTvHmh3gVeKIZlhinX8m8y7aCk3yYeJwMrwq7i/wPUKgwooGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673871; c=relaxed/simple;
	bh=UimmfS8XWBcereSJbaHK5HPFJQ7k1aQIJx0z9MNo8t0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tqcuotj2inb1Nyjf49Dmr+SXHhgV3RUHp2Cagtj4sJaGNTa1Cu3+8wx0df1I3sxcf0czGh/vzk8ECco3urQsb0iuxdMc2c3eICXdSMFUFkpjLcKXUnbhR35k1kBP1SDDlCqVvWpZ9nOP6CarKVNacUmA46RdfY0xxWD0H0zop0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQQ7L6Pf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d316f0060so1027741b3a.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 15:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723673869; x=1724278669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=29p36TNPsALHKDvJmWKw72MtMPILielyDHBlgtv6ur0=;
        b=UQQ7L6PfAYKZ3S30odRecSNwxu61Hu8JGRxqG9ChzAM/GiVlN+GPQ/3ymHCB8NsyiO
         p1eo7pFH+BbVQ0cvY1KR4kH/ZKBy27IlYxjkrAoOK1wJgTS3mki8qDoCOC5BJbN4ZFtV
         xl4gxNPJxtt614OG5NkNnmF7hSEcbfcgKAetFku9mkhgIBm98AEsYK3sQOUIE/otD/b+
         3aP8H/iundcEacUaatXrVike5hcg6LqEwqQR3Sx9zFGlog2Jswz8DKIxwDhAT7HYEBBt
         o5iS+zPzi1s2AAZdVGahP+gJF98uVFaQYeAuikecdFy8Ci6raeAPTtEVMmJ569Z56dEu
         qgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723673869; x=1724278669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29p36TNPsALHKDvJmWKw72MtMPILielyDHBlgtv6ur0=;
        b=sAYpKzgnMWhxm+GfxspjCbkbuItyhm/tiujVW9llqLrGPhWLkNyxK/6c6EHLNmSO8N
         1/Fh6nMea8IRILDRNonHY4i+wex6gEvUK6fHwMwvnDTiqjSJramqPrDo1nkCbvkdznTE
         7BrEpj9Zz7G31Foy1riTmmS+sxrFbu5NKa0hOyHJduAN7mkxax/b1IwpUpK6ok/cIYi4
         pKTZEDbOA2kq9HfcXkk0xCMLerZ0EuZ9a2PljkFxs7I+f0E/GtV9lDztVZyj1WNiT2Q7
         CX3bxGFHjhHQwzlVob0n3YHvMMPTdcmEr2Q+EkfZy86HyK74F+tKlRc9MSEyLcMFbMKN
         qPzA==
X-Forwarded-Encrypted: i=1; AJvYcCX+PmHthRKRp4jzexgBZuUSzdS8sSHL84zgRpPI8CX8VI6enQzEZCprudQLxvsYJcXnDRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpBQ5/t0XfYS5/NzT6hGrUKt77BX9vfyiVgKqfczdmtCeDjdE
	F9htUXLBGDSQYbXPdXSM+kQq72w3czdd6n0mSyBkhCYyOiPY3bk0VLITpAaUC9E=
X-Google-Smtp-Source: AGHT+IG96r812kpONHjIFyaxlwQA032s6zqHJx6j0WDNZ1kPQDv40G722kqSZNazFu8hq/X2p8b9SA==
X-Received: by 2002:a05:6a20:6718:b0:1c0:e1a5:9588 with SMTP id adf61e73a8af0-1c8f8582db8mr1580443637.2.1723673868591;
        Wed, 14 Aug 2024 15:17:48 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5431sm56311b3a.109.2024.08.14.15.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 15:17:47 -0700 (PDT)
Message-ID: <3066ed3d157d391e67858e44da8b0d7865df2ad9.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next 5/6] bpf: Allow pro/epilogue to call kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 14 Aug 2024 15:17:43 -0700
In-Reply-To: <20240813184943.3759630-6-martin.lau@linux.dev>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
	 <20240813184943.3759630-6-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-13 at 11:49 -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> The existing prologue has been able to call bpf helper but not a kfunc.
> This patch allows the prologue/epilogue to call the kfunc.

[...]

> Once the insn->off is determined (either reuse an existing one
> or an unused one is found), it will call the existing add_kfunc_call()
> and everything else should fall through.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

fwiw, don't see any obvious problems with this patch.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 116 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e995b7884fb..2873e1083402 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2787,6 +2787,61 @@ static struct btf *find_kfunc_desc_btf(struct bpf_=
verifier_env *env, s16 offset)
>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>  }
> =20
> +static int find_kfunc_desc_btf_offset(struct bpf_verifier_env *env, stru=
ct btf *btf,
> +				      struct module *module, s16 *offset)
> +{
> +	struct bpf_kfunc_btf_tab *tab;
> +	struct bpf_kfunc_btf *b;
> +	s16 new_offset =3D S16_MAX;
> +	u32 i;
> +
> +	if (btf_is_vmlinux(btf)) {
> +		*offset =3D 0;
> +		return 0;
> +	}
> +
> +	tab =3D env->prog->aux->kfunc_btf_tab;
> +	if (!tab) {
> +		tab =3D kzalloc(sizeof(*tab), GFP_KERNEL);
> +		if (!tab)
> +			return -ENOMEM;
> +		env->prog->aux->kfunc_btf_tab =3D tab;
> +	}
> +
> +	b =3D tab->descs;
> +	for (i =3D tab->nr_descs; i > 0; i--) {

Question: why iterating in reverse here?

> +		if (b[i - 1].btf =3D=3D btf) {
> +			*offset =3D b[i - 1].offset;
> +			return 0;
> +		}
> +		/* Search new_offset from backward S16_MAX, S16_MAX-1, ...
> +		 * tab->nr_descs max out at MAX_KFUNC_BTFS which is
> +		 * smaller than S16_MAX, so it will be able to find
> +		 * a non-zero new_offset to use.
> +		 */
> +		if (new_offset =3D=3D b[i - 1].offset)
> +			new_offset--;
> +	}
> +
> +	if (tab->nr_descs =3D=3D MAX_KFUNC_BTFS) {
> +		verbose(env, "too many different module BTFs\n");
> +		return -E2BIG;
> +	}
> +
> +	if (!try_module_get(module))
> +		return -ENXIO;
> +
> +	b =3D &tab->descs[tab->nr_descs++];
> +	btf_get(btf);
> +	b->btf =3D btf;
> +	b->module =3D module;
> +	b->offset =3D new_offset;
> +	*offset =3D new_offset;
> +	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> +	     kfunc_btf_cmp_by_off, NULL);
> +	return 0;
> +}
> +
>  static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16=
 offset)
>  {
>  	const struct btf_type *func, *func_proto;

[...]


