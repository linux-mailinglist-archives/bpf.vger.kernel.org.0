Return-Path: <bpf+bounces-73559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE00C33B71
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 02:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CF6462C63
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 01:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2A1DE885;
	Wed,  5 Nov 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGrOzqmp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3785B1A23B9
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307740; cv=none; b=g/Ktv/NwAXSFeUbdl8hO7cut9S/8oFUECvyPHEpK47l5u+8/3W7r4xr2JkXnRkLwMNJy3zqdApjJLGv3xyldZmWJu+GznHzDCPEt8Yiz0s3G8MhhL4qKZnkpvHTfNIxCfx/NIZkywz1LhT4pgy6eIrvlRPbcU/yJU1CXLiMkmxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307740; c=relaxed/simple;
	bh=4a2cMY6x5xwbiIO4AfwvSZbxZPl0B3iDH/keTNhUNvs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mkf9wTxURFxDs1y0akp4ccP4Ci8erzq+vrxQ3mcBETk7vjkE2szxBmw9PJCaA+HHLVhFtG/OTfBJjYcRIsFGDP43if4DAYVEh+gcl3P3R/T0AEmexB/m5W6tHMpdJROo/P/+lSFxpH/tLtK88izrP/2+NVbESkfEmmpHy6wRQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGrOzqmp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1290962b3a.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 17:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762307738; x=1762912538; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wOFMryYkzLr1eG1Ll2Ax7P71j3x/fKg/djMdpST6qzI=;
        b=ZGrOzqmp5zd7nTxRNLU++OiypXC1RcWH9ci7n7JCmHKXme0Bkv9AF0xv6Lq/ubGo3P
         aJWz/S3p8KUQjsocEEYIBpO9hCmN4Xc+EgH2t1KeJBLUUDE+MY3VBYF03l9DCTF7JsQy
         8eEUCoXyyumzjIblLV9XPD8PAOTNKMtj/SQDyrO097ESr9s1rvgpxYe65SeZRphgQwOD
         s37YQIS79rOMN20K/i2RbmvG3zyZcfzOHZtI+Ka85NFf5pgkDgQbF1v3YsGOr+KRg8nf
         +4vuCi9nYMwdS+yVXxzv3T5Skn9ufXK95+M0JplSbMly2Z+zPQamZfljlOYi2FcI1Mo6
         s56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307738; x=1762912538;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOFMryYkzLr1eG1Ll2Ax7P71j3x/fKg/djMdpST6qzI=;
        b=sMAjaaRyzx2k3wbfo0Qkr2ZKzKCeWtseQNDKT3iaohq3f8HWYwmGmJ95pJ7y/OSKKn
         nfWmXa1+zqd7L7Fm6jJY2Xs0AwXhPSrMHwc/xfv7J6DhL5NfR6mDNq557/0kmPiGyMMm
         qKgL3HdqBnCEGNjmGMjDQ3/fX0pdiEyraqd5WIsc3eEbzdi6LP+DATPyQ1sKGM4HMMaN
         GatrUzj7bW2ed6YLoe8RlCnklAaksk4nMR9LhEFiMoK80j0aLRBO0z5y5X+AcXEBYvNU
         nYt9hgP8hI2uf6KCw+JplBhRqAaqQnYyS7eUTPbepXeiY3g45tdIr8uwX3RPvYwYkhsa
         uwdw==
X-Gm-Message-State: AOJu0YzbkBqV5PN7xJYWbqVGv5i13UDk1Qc6Ub6jQDF3yZVbAtmh8g72
	hElbI0XOgkQmX6Tm8evKTXH++bBZ2PurnPvW0Wa6wkumY4D9wTPoaH7t
X-Gm-Gg: ASbGncs0gnLfH+i7pZjZB8GYX2LoeNAQFaROUWxGO9snGiaC+DSkYV6gDUHZ2D97OUe
	dUhDT40knRd7XUjTxvDr3FEbNSOh29PZnbBtrcf4GEnenj/t9h+Wwa5LictCL8AuTQPTWkzpCQH
	ot/oKmPdQ6PhLd0hXX38yQE/e/7+IcWqfFMgIChTWCuLoFxEqFhJcRx3chpO33Ab/gfZ4bq8G3Z
	UApfoOVdUaB+ulTNKr+CttgD77JsryJWkUUIOrko8T4j7/8Gvnv5Xw46O3NNYv1qH3Hby02EdKV
	pg1YM+C+yKF4giZ0Qp7QdEF+wNpjE7kYKJFz8+aL//tNsJiP6ks7LOjbzYT+jey+xJ5BPeO4IF8
	mw6yYkKOKG6YtzXAy4bhPBpvZIXwRc1rT9N2RGcNXu/trv9EpItYe8pS/bILATToISd/lDnNlZN
	sMv2N8fJxuy32saZMb0fD38xQ=
X-Google-Smtp-Source: AGHT+IHfZVHaL+1AoBJIOhUwB44Qamd0mYFbRaY+ULhlHYNXA5luFKLu5fdcYEXvOsEuI1V52+wxgA==
X-Received: by 2002:a05:6a20:3d82:b0:342:6380:7ec9 with SMTP id adf61e73a8af0-34f853f6679mr2071627637.37.1762307738521;
        Tue, 04 Nov 2025 17:55:38 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586f862sm4385350b3a.34.2025.11.04.17.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:55:38 -0800 (PST)
Message-ID: <da133e69429c39871b6f4f586ca9843c9e35048e.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 2/2] btf_encoder: factor out
 btf_encoder__add_bpf_kfunc()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 kernel-team@meta.com
Date: Tue, 04 Nov 2025 17:55:36 -0800
In-Reply-To: <20251104233532.196287-3-ihor.solodrai@linux.dev>
References: <20251104233532.196287-1-ihor.solodrai@linux.dev>
	 <20251104233532.196287-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 15:35 -0800, Ihor Solodrai wrote:

[...]

> @@ -1411,6 +1397,28 @@ static int32_t btf_encoder__add_func(struct btf_en=
coder *encoder,
>  		return -1;
>  	}
> =20
> +	return btf_fn_id;
> +}
> +
> +static int btf_encoder__add_bpf_kfunc(struct btf_encoder *encoder,
> +				      struct btf_encoder_func_state *state)
> +{

As with previous iteration, 'state' has a link to 'encoder', so there
is no need to pass it as a parameter.

> +	int btf_fn_id, err;
> +
> +	if (encoder->tag_kfuncs && encoder->encode_attributes)
> +		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
> +			return -1;
> +
> +	btf_fn_id =3D btf_encoder__add_func(encoder, state);
> +	if (btf_fn_id < 0)
> +		return -1;
> +
> +	if (encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag) {
> +		err =3D btf__tag_kfunc(encoder->btf, state->elf, btf_fn_id);
> +		if (err < 0)
> +			return -1;
> +	}
> +
>  	return 0;
>  }

[...]

