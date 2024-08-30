Return-Path: <bpf+bounces-38498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13651965438
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 02:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB0AB254AC
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 00:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345AF4690;
	Fri, 30 Aug 2024 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfv7V/W3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9494409
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978831; cv=none; b=hfbeohveL3ZVAFYaV/aOubNJVmC07a/1cMqwBHabcIRxnZXYa1IXcpBMwW8sepfuZl2SCQU4fmoF9+uJkwYpzv+CDBIbxGEILqgB6E69HlV01lVs2HGK4tEEuWr7eaPwqsKZO24hx65mm+W/8iIT4g6zll4NJQ3Atx6gWmRHsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978831; c=relaxed/simple;
	bh=AyazNVC204hKz4rF0h2azNmmaLGfaTe92kkSMoMpbMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2+3If2h6OQAWjplxQonrTecM24xfx9dELbrmdG29ITFv9jIEWKu8+Ckskqb75psC+aE2cRHlPJB/LRHZ9b/b8HF2xhE2Cz9aD6ZYTtSK5OGt/1bI1C6049HoL4lU0/zXlxFW71Ab4piL41aegNdQxW4uIKlZ6Rdx0RMSPmC1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfv7V/W3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so844184a91.1
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 17:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724978830; x=1725583630; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QIKUi2pbx8Bq95ojbBeLKN8XiyRswdTiGu8SWDvc0ng=;
        b=hfv7V/W3Esnv1DYIdbrqrSJJ8L/FMO+cyMEsL92lCxK9duYgHImX8JRSHmhQu4k6K7
         Q986w66FHMV5jT1J+QSRalYJFMkxBilGP32Ku45p0Tzqpa6YOEOa2UprIkzn6JIQmCcx
         lqL1cLpwyMMTgrNTuvQoByc/qDKaZX81Y0tgZo2huF8iShP4QilpEHaFQeT94ICUQFTI
         CeTFMMzUTYDSbAfzX88HTr8Yl/vYBjp/QV2qM5Ph7PBB5jSVqJf+Foc2lnI5F+HmXQQW
         du69BXnZLN9CF+PKQdRdMiiyA6gVW3HDhspUBv0tkjVIRePJbqCvZbpAc+ihhBWCNTDD
         /M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724978830; x=1725583630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIKUi2pbx8Bq95ojbBeLKN8XiyRswdTiGu8SWDvc0ng=;
        b=XMO5NGwGGqY4ZcIL6pJAECJiz+vBqeKCW7nVy/LTdgok+59zqphxXfr/+agPLhLeYu
         5b5JjzGCAtPabn3uubwfSWMY2igjQ8kKWyrxJsAxiOQTcNkSNDMybbqaPOqjBQpPuUqV
         st8TF+10xyBR5QvgFRiO5a7DUYt+RvGLjN4x9Wds0M41uu2zruhckzO5LmmXx05dfOz5
         guf7JTxWJKmEmZ6IqpaQnCzpE1WKuBRMQVhyR6Jp829wH305s+2Ij5ccMIDOfkguYrP0
         kwwoSZWIyyTALxYjw52p+YOpvcDhBdRhMgejDK5NaUimRvOE3Dvn5R9oMZrA+n8cKjgC
         teQA==
X-Forwarded-Encrypted: i=1; AJvYcCV8yQY9o6XZLzfOP1o8mg63C+U7rbxuBrEmtfPvdgs7PHLx8+eHibkvbAybvyOGS6HDeDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSqdpZuiwY0efUj73Mwv2CEXY2VFsPiXJD9FhdKAiXBOXX54+
	wgR1ofDQWf0J1c+jUFEIq+fwl17KrhStWmP4unVANWbW2qYTPQ/q
X-Google-Smtp-Source: AGHT+IFIdkDlZ8BRVbhlkqpy7eysHKWSpAA1kwGifdgYV0yA566c+shXlL937j8C4qea/ECJYnQuhA==
X-Received: by 2002:a17:90a:558c:b0:2d3:bb9b:ce64 with SMTP id 98e67ed59e1d1-2d8564ce51bmr4655043a91.30.1724978829520;
        Thu, 29 Aug 2024 17:47:09 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84462afb6sm4894865a91.33.2024.08.29.17.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 17:47:09 -0700 (PDT)
Message-ID: <cdd2ea1421331cf27e5435ad60b7461936eceab2.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/9] bpf: Adjust BPF_JMP that jumps to the
 1st insn of the prologue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Thu, 29 Aug 2024 17:47:04 -0700
In-Reply-To: <20240829210833.388152-3-martin.lau@linux.dev>
References: <20240829210833.388152-1-martin.lau@linux.dev>
	 <20240829210833.388152-3-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 14:08 -0700, Martin KaFai Lau wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 261849384ea8..03e974129c05 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19286,6 +19286,9 @@ static int adjust_jmp_off(struct bpf_prog *prog, =
u32 tgt_idx, u32 delta)
>  	for (i =3D 0; i < insn_cnt; i++, insn++) {
>  		u8 code =3D insn->code;
> =20
> +		if (tgt_idx <=3D i && i < tgt_idx + delta)
> +			continue;
> +
>  		if ((BPF_CLASS(code) !=3D BPF_JMP && BPF_CLASS(code) !=3D BPF_JMP32) |=
|
>  		    BPF_OP(code) =3D=3D BPF_CALL || BPF_OP(code) =3D=3D BPF_EXIT)
>  			continue;
> @@ -19704,6 +19707,9 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
>  		}
>  	}
> =20
> +	if (delta)
> +		WARN_ON(adjust_jmp_off(env->prog, 0, delta));

Just noticed this.
Suppose prologue is three instructions long and no epilogue,
then cnt =3D=3D 3 and delta =3D=3D 2, adjust_jmp_off() would skip instructi=
ons
in range [0..2), while inserted instructions range is [0..2].
So, this would work only if the last statement in the prologue/epilogue
generator is:

	*insn++ =3D prog->insnsi[0];

which seems to be true for prologue generators in the tree,
but looks a bit unintuitive...

> +
>  	if (bpf_prog_is_offloaded(env->prog->aux))
>  		return 0;
> =20



