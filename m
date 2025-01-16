Return-Path: <bpf+bounces-49086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E794A1427B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23A33A3B44
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680B22F847;
	Thu, 16 Jan 2025 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBsJHEz5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3922FAD4
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056564; cv=none; b=ZpCEYLlA+CXV0Y1XK+7dhBkwSONiwS7w36MaKL+PebyFmrXasN9/Eh2BIPua5WaGhNcAKALSREvBvOp2pYVHAlejpYpLe4b7IPINhSlz9Yrf3UARToKNJcbjfS3M0ldtmd6RwzTH/GeY8XjbZHRfb49o0OEEAAISSDWcnpwed2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056564; c=relaxed/simple;
	bh=fsUHlJbpvJeu5WEwg/YbwKIShknXQe/4mfSDH09wQcI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0sMUgr/HLcc8hAZ0XHBpiWtCFDpXJvmBPMBkMDk5F09CyztVXleLa4AbS4OxhvrlI+RstD4aw1EP7H6qsKQw9fiPLBi4Ssa7wBa8/J5t+VsReH/XZKw7mHoTz//AUOp26ofK+pkZHcEElsCfyqnYCjhoOrTCpj+Wknt7BBcu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBsJHEz5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21a7ed0155cso21112465ad.3
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 11:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737056562; x=1737661362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jvabKTG3o3NyX9CINFEfVnQlVtTJ6xFdYbjAGTXHaMs=;
        b=bBsJHEz58BRe79RVGzdXyTXYtRlwHjDCkT5gjU/jMQLEvqB1xngGUlWbsYXHdu77o+
         g8qI6XDPnGLxenDzMDtNecRwL73LmrEBQ3fnpoP0vsP8n0j+lOEERbVFG0HMCnaWgp5E
         jLw039tB0lp9gdccvTnIgwGgLzR9u8EAh+Xx+Mwo7idKSkeUIpc5aMPWIq/fNARRh+hw
         EnQYW4QqsNCJUVukoj25z4j3D1d4ForprMQiXZEiaVRdOLp8BUpU2ot2JkpQw2j9zkOl
         ySXoYYHnNGkgxy6JQ62ZU3F0SXiJEwKpNUuPS5C5bD0YFLhQGmjBodR0EtCZPYiT1L5B
         ZGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737056562; x=1737661362;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvabKTG3o3NyX9CINFEfVnQlVtTJ6xFdYbjAGTXHaMs=;
        b=N5QyNtvv2TV4Okfj47logzwpzSfvXRA6nk0y30O9eKXJvbhcV3Sxcu06TYv2VAmFrs
         pKetPZd0feGT/+g5tkNFnt4x1MLPCie5RgyYGZYHcR8pXK8RmG6kPA1ATmvvGedvEqlB
         Sg7YCiS2SjxvwlERwZsKRMegnpnbZQeK69OHE2H/5/i0zg7wnj1I63EvvDAn5LvkdQcU
         COzXvP2ZisX0iJRM85xP2Xejw8vHsdErSjAoiID2JWZj+iFXj9msEQ6DIiUJRbpiEL0w
         TCbYCigWD0cnEgRKrV3Gmtmsh7ArpeYTxi68ThqRyBm9MWzlT1ysXHd0irCmooTfhZ+2
         s9aw==
X-Forwarded-Encrypted: i=1; AJvYcCUMmX+QBJhqdba3ZNTGXwo6LpVZ5jSom3nicSG9iqFyTCV/xeRBzsfzTURJSCDhaxgrFes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZxQ4jzTXXpAUc68rZXv0v2Qb2EithxA7eqoP9ztfgJAuLAEZz
	HmRBCBZuvHfu732UJagjLiLA+qnk7wxegIESKhcJWyk9uyWg7ahP
X-Gm-Gg: ASbGncvOUebppnnlzXuWcnQu1+8uQxbnNNms6FUEUNmN3FTLs8yxnfC4dfOCo6tf0sD
	DTxMV5hFMPPKnmy1HWhPDAbtQr8BWcgj7U76qINdQHO6UjDnPvhKfPqpupEXBIPFmbtIFtfwW39
	rAd3XI34kPB7VrmvmbrLWrqYeOXzUxS7CvKecE3Vcq+RrcYbMZ4/bz8VVZ/hdfHnfReOTky/9zO
	rq2TRtN0of6LwjFslURtc80dmTGmCB35bTXddtC+1ETR8SUx6xopg==
X-Google-Smtp-Source: AGHT+IFN5SuyGH0x9L/k7/l77pYvWceDEq0M7OBsc1UXB8AAO5Vy1FYu3qutw2ybihrl/JAR0sTLwA==
X-Received: by 2002:a05:6a00:928b:b0:72d:8d98:c257 with SMTP id d2e1a72fcca58-72daf930ff5mr135346b3a.2.1737056561751;
        Thu, 16 Jan 2025 11:42:41 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa7381sm354450b3a.161.2025.01.16.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:42:40 -0800 (PST)
Message-ID: <75bfa14917a3475f60c6fac9d6480320d6f5f005.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Remove 'may_goto 0' instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 16 Jan 2025 11:42:36 -0800
In-Reply-To: <20250116055134.604867-1-yonghong.song@linux.dev>
References: <20250116055123.603790-1-yonghong.song@linux.dev>
	 <20250116055134.604867-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-15 at 21:51 -0800, Yonghong Song wrote:
> Since 'may_goto 0' insns are actually no-op, let us remove them.
> Otherwise, verifier will generate code like
>    /* r10 - 8 stores the implicit loop count */
>    r11 =3D *(u64 *)(r10 -8)
>    if r11 =3D=3D 0x0 goto pc+2
>    r11 -=3D 1
>    *(u64 *)(r10 -8) =3D r11
>=20
> which is the pure overhead.
>
> The following code patterns (from the previous commit) are also
> handled:
>    may_goto 2
>    may_goto 1
>    may_goto 0
>=20
> With this commit, the above three 'may_goto' insns are all
> eliminated.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Technically this is a side-effect, it subtracts 1 from total loop budget.
An alternative transformation might be:

    r11 =3D *(u64 *)(r10 -8)
    if r11 =3D=3D 0x0 goto pc+2
    r11 -=3D 3     <---------------- note 3 here
    *(u64 *)(r10 -8) =3D r11

On the other hand, it looks like there is no way to trick verifier
into an infinite loop by removing these statements, so this should be
safe modulo exceeding the 8M iterations budget.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edf3cc42a220..72b474bfba2d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20133,6 +20133,40 @@ static int opt_remove_nops(struct bpf_verifier_e=
nv *env)
>  	return 0;
>  }
> =20
> +static int opt_remove_useless_may_gotos(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn *insn =3D env->prog->insnsi;
> +	int i, j, err, last_may_goto, removed_cnt;
> +	int insn_cnt =3D env->prog->len;
> +
> +	for (i =3D 0; i < insn_cnt; i++) {
> +		if (!is_may_goto_insn(&insn[i]))
> +			continue;
> +
> +		for (j =3D i + 1; j < insn_cnt; j++) {
> +			if (!is_may_goto_insn(&insn[j]))
> +				break;
> +		}
> +
> +		last_may_goto =3D --j;
> +		removed_cnt =3D 0;
> +		while (j >=3D i) {
> +			if (insn[j].off =3D=3D 0) {
> +				err =3D verifier_remove_insns(env, j, 1);

Nit: given how ineffective the verifier_remove_insns() is I'd count
     the number of matching may_goto's and removed them using one call
     to verifier_remove_insns().

> +				if (err)
> +					return err;
> +				removed_cnt++;
> +			}
> +			j--;
> +		}
> +
> +		insn_cnt -=3D removed_cnt;
> +		i =3D last_may_goto - removed_cnt;
> +	}
> +
> +	return 0;
> +}

[...]


