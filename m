Return-Path: <bpf+bounces-62193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD6FAF635E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE754E1AD8
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 20:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F722BE62A;
	Wed,  2 Jul 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja5ZPSUI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9A221F03
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488410; cv=none; b=Rw5x4wn7o8X9Z6hsesq7w5dn66/tU6DY/hv+ip2sPiqeazYiarglNYEs6ZtjW3i/x7ainHxdEH8iYMajeNvO4L2JAvg6xx6LJIR8rgTwK9CmpA11cq26edupj96BRlGZ5UEVlNJVZW/LNSAYHVAqPcPIZVT17VxWR4tfyxxUirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488410; c=relaxed/simple;
	bh=b1O2dJETf/3KXU8DG08bwKJxWAdKVAWlcB0zDKYJOwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ae4FF8XCYC73mGp0RWC/RrUxR5uZEq1whKs4yzYg2MQ4cOuNJ9uVfkojUCQaIGUymbfcffQ8t3lZqyO8iMJ+rQ8Iu0q1YGukoGMQhJE26dDoJGGMUmERZt9Gw+lBsFAxSbDzmtX1zqFWX9yykqIZNVtidY6luqKbAri0Ov31Jgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja5ZPSUI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74b56b1d301so684624b3a.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751488408; x=1752093208; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G2cd/SAi/vYnoxmeEQpjroKsmmrjSv6b+73nBea2PEY=;
        b=ja5ZPSUIzvXIAZr6MRVaD0/xdVoLfru2fcOvsHLqr3OSdGl4fz2eZfCUNTbMDa+4cG
         SyY8SiisRYiSEZoWW1QzRqMeBSssvfU0JfNSGbWg5w9xPI5Md3V3YTIPcRb+sLREcVqG
         mUP+73APBiHW1rQguwLJ0KbuAD1gau4woWn+NmLWd4cPYL+AO9EP9F9PsttJeVZg8/BT
         0JOxJ93sxVwvjbOCF1P5SNhlgWaZbif2wPG9ojIkBuiut3faaeV58vUM6BS/ZlMIpHnM
         Ewfv8I2mH43/4ZYLPakrIf258RKDdAk/5t4PFEbg0p38EAbgEN9k//bXSgSQnEr7wQok
         HnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751488408; x=1752093208;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2cd/SAi/vYnoxmeEQpjroKsmmrjSv6b+73nBea2PEY=;
        b=oPPBwhbUqxpeFnlKaUDztxuzHei3vnKDNetdLbh8PoChWSkss7lVJosi1RxV8edpxM
         N2zFsM3lyYOT8toBn+jIxfitDoC0CDRC4tk+T2nvXrxVReMisfTDCvS2CBs7KMD3gloX
         6exPf0lYBEfCFZDE/Qhyp4JO0NBJ7LxsB4GOFqpZB/7w7E8Hna2zTcgkEFXGW6bHN2w7
         ogaXzpqEjwJhbgLbcUq0k8ztod+ZtUGvVnFLmZOmCTr8cT7EagFVJ4uawESrHshke+tL
         BaBQkUGi2lWWuogG6NvdM5R5jNWXF4p7oChDfUEpLGwAzu7NDjEWagQEwZHr5aLB0TAW
         NfHA==
X-Forwarded-Encrypted: i=1; AJvYcCUZNd+jh8In+9hiem4nt+Zj1/YKB0aHF6yGUfQwfhwGJOsEPkatlX6o89QxRXxJufpDf5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrbPptcdSPpEJch1Sy4eQGsT6Q+NOBIJ9RO+ddobBpNftby3Hn
	Q4M28kg0eNO5Ga7iSIlG2pLajD1/Sf9NEGTNzPUjFx871BViWVjVHLzi
X-Gm-Gg: ASbGncsLDNB8voR2I5ew/M+BOM9ECcYlHuyukV6hdF0PIodcqpXVpsaCqMvGPxnV6Ed
	igV2ShZlg5UPYUod0q0uxNTzvo23KAl1iXCx7rL4TFsBtKn9d8cxY7nXDzxO4jhWSWbOx823h7V
	tgkM0+LPearJ0Va/t5PZgJWI7E5I+rvgvEf3jXHTrU2qNC6Uv5QvAhgXX9KNCiSmm0tARCknByQ
	q1A1KgWmPq96t56QvhGdGe8PhKYq5Z0G4jioS+yXuuJq+L/YtXV3LxbuE63qYVD2BLs0mKnzYeE
	IJEoxg1VKySabfJMsd6RLzYY8ikOHNTUTYYk6tzJXp2j2mjlqiU2SY1uTwzjRuVSQ5oalB72dfm
	oZkhOLVjV1fw=
X-Google-Smtp-Source: AGHT+IGeKAoWyq+hvk9rABtXEBukWawGAaMUFIajLnD4amJlXVb4B9SLHGU66hfp/I/Dm3XOXAMNqA==
X-Received: by 2002:a05:6a00:98a:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-74b50f2a324mr5670187b3a.12.1751488408118;
        Wed, 02 Jul 2025 13:33:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:ce31:8a4b:8b7d:e055? ([2620:10d:c090:500::5:5e14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57f80e3sm14980130b3a.177.2025.07.02.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:33:27 -0700 (PDT)
Message-ID: <3f7f3c4f80d0deb51432b098f5ae30d5c68de085.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Reduce stack frame size by using
 env->insn_buf for bpf insns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, Arnd Bergmann
	 <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Olsa
 <jolsa@kernel.org>
Date: Wed, 02 Jul 2025 13:33:26 -0700
In-Reply-To: <20250702171144.2370681-1-yonghong.song@linux.dev>
References: <20250702171134.2370432-1-yonghong.song@linux.dev>
	 <20250702171144.2370681-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 10:11 -0700, Yonghong Song wrote:
> Arnd Bergmann reported an issue ([1]) where clang compiler (less than
> llvm18) may trigger an error where the stack frame size exceeds the limit=
.
> I can reproduce the error like below:
>   kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds l=
imit (1280) in 'bpf_check'
>       [-Werror,-Wframe-larger-than]
>   kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds =
limit (1280) in 'do_check'
>       [-Werror,-Wframe-larger-than]
>=20
> Use env->insn_buf for bpf insns instead of putting these insns on the
> stack. This can resolve the above 'bpf_check' error. The 'do_check' error
> will be resolved in the next patch.
>=20
>   [1] https://lore.kernel.org/bpf/20250620113846.3950478-1-arnd@kernel.or=
g/
>=20
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 189 ++++++++++++++++++++----------------------
>  1 file changed, 91 insertions(+), 98 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8b0a25851089..ef53e313d841 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21010,7 +21010,9 @@ static int opt_remove_nops(struct bpf_verifier_en=
v *env)
>  static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  					 const union bpf_attr *attr)
>  {
> -	struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
> +	struct bpf_insn *patch;
> +	struct bpf_insn *zext_patch =3D env->insn_buf;
> +	struct bpf_insn *rnd_hi32_patch =3D &env->insn_buf[2];

Nit: I'd add a comment here, something along the lines:
     "use env->insn_buf as two independent buffers"

>  	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
>  	int i, patch_len, delta =3D 0, len =3D env->prog->len;
>  	struct bpf_insn *insns =3D env->prog->insnsi;

[...]

