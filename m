Return-Path: <bpf+bounces-51886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43582A3AE7E
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35C4169A80
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 01:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35818E1A;
	Wed, 19 Feb 2025 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpawjOru"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D646447
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927103; cv=none; b=XhHkoFJ0FFEaBH9Rp6doaoJcZ9s+xsbB7KVfXo4OQV7ysY8DUd8PXJEhHXaHVg4fwOA3GDIR5BtcenbtFBxlQmfu0dKa5XYGYEUcjkhYCX8hoK/Es1EyWUZEUH+c7rjsMkvH3WcKQbEdDKj511eWyDo7CVyixmTBe5LOhXOZa+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927103; c=relaxed/simple;
	bh=+m5QYpMoAptwMUxxUM+HfBWQM9TxX+zWG+Z9XsJS0nU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ml0dxZOtFWKtpLUaWEo91fGuru85z76e0RNc8y67JPHhi24d79Kd06BXdZgQMyFvhmuwY+LbXXhhxRDUVKf1jKSQg+xBaNCQbnJiKSREVEUUg4dPftR36sbqLbfOcKpduzkAQqquX7txD113YEQjVy9oNubG627hYOBg9ui4SNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpawjOru; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so8853663a91.2
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 17:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739927101; x=1740531901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+Ax3ySM5ejpfD827Gn6aZ+dl+UPwWfuxx8p4EaC5c4=;
        b=FpawjOruewHV47lo6ZDXo46tDwraTb23XE4ekRyDT5bsHeincBXanVsSNZJHQvb0Ty
         pa3mc8j68YycBra0fwGVLObW8rprQvi4OQKs53g1Ue6o3liNo7dDghv4PnED/aOVmW+Z
         F5NVIXWTjQ9qEDOi23oCtpj+7doKCsR391YD844ymgbRu8fxuha2pQO/FXZsVOcXEnVE
         tPECgQIBnHjBOoPSmFE00dJ5tIt0NGXJVWAhCk5G90T56tH1d0SJ6HXu+6w3Hrc2jJWK
         tFQ1W+JR65CGEdMx2j51fpBRjk1xZAOLR1cIJPrJOtf0h7dxPSUkBSE7Rz7mJfg1wdzT
         1ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739927101; x=1740531901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+Ax3ySM5ejpfD827Gn6aZ+dl+UPwWfuxx8p4EaC5c4=;
        b=B39r1zt09r6a7N78joslH+Qkx9jlcohvCP7QKVK3N5ZX494Ckiq80ceyYprTHUug5R
         1tQc2lX3S5VpvpL5zfRT9USO15IEyYMEueoFJKS9R62/PjBxZO9huU31sgBWPgz8Mwlx
         opMI57LzilpNTzCQ5t2hFZnrprQjYIsA/zXR3R0udUZGRqPnGiSaBjqEMNpbEX31efF/
         MIVVwxm+dWdDt1Dum93aKMqGpFSiAN4Kb0aY68Zaf3br6+b8dUUDRJBWKN94Hq8pQkfW
         v7Lq2EDqOmGEya6qC+4v9/pvvVuOsqDoXKYdqfqxzdFH8zs1Nn+3f1E0gqhAeGdVoBHy
         oVZg==
X-Forwarded-Encrypted: i=1; AJvYcCWraNDq42xe47QA5ezl8eh9b1DL8JxdmUwtASfECs8hz4lg9M1D3EaZ7Tcx8dkkd0MWERE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0SiFQxHt66LyadZ6zbSf4FPKK/2MT9sywjBPieODEEs3aqG/
	fSOAhvWofgzZOLRLfR6xtbWOqg2ukg3awnyJc3nIyz8sIbwqvMuc
X-Gm-Gg: ASbGncs2AHe5u1y8cqyE40ZaiG660diuJiGah+J7cnKsVl3CAfEcS7n5peis41pr/yq
	hijLCTV4TYVZrk6WkCFXLp9OllOkeuO9BSy4eqOgpBEkAY2/cS3mDWL7LI/u6hefk0N2TKnfuoh
	utte6Rx/RUgVd3ZIsgbDTMw4WgIPU///Q68yucaD3ksOdFkZqqUwdYI4JDv8Y9CCySFfufXVBpC
	J6BKmJ6/nVRXKLQGPpay9w7Q1fgmBJEFIAALE55fWP3IEYiyQq6hhLlJUI25tlZQj8D/w/HKBcA
	qMzC/v2o96wO
X-Google-Smtp-Source: AGHT+IGIbQfIN79cKPJXxTw0CUbHLA2Ajm4fq1wKo32FlniQBS5v/Zt1RAi4IZqjLQyp0W7ys/pxbg==
X-Received: by 2002:a17:90b:2fc3:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2fc40f1048fmr26035777a91.10.1739927101468;
        Tue, 18 Feb 2025 17:05:01 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98d05cesm12839640a91.18.2025.02.18.17.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:05:01 -0800 (PST)
Message-ID: <d9314a49d54d7478d2b85bee6f4de0fb3d680deb.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add tests for
 bpf_dynptr_copy
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 18 Feb 2025 17:04:56 -0800
In-Reply-To: <20250218190027.135888-4-mykyta.yatsenko5@gmail.com>
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
	 <20250218190027.135888-4-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 19:00 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Add XDP setup type for dynptr tests, enabling testing for
> non-contiguous buffer.
> Add 2 tests:
>  - test_dynptr_copy - verify correctness for the fast (contiguous
>  buffer) code path.
>  - test_dynptr_copy_xdp - verifies code paths that handle
>  non-contiguous buffer.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +SEC("xdp")
> +int test_dynptr_copy_xdp(struct xdp_md *xdp)
> +{

Nit: it would be helpful if there were a few comments
     explaining which special cases are tested at each step.

> +	struct bpf_dynptr ptr_buf, ptr_xdp;
> +	char *data =3D "qwertyuiopasdfghjkl;";
> +	char buf[32] =3D {'\0'};
> +	__u32 len =3D strlen(data);
> +	int i, chunks =3D 200;
> +
> +	bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
> +	bpf_ringbuf_reserve_dynptr(&ringbuf, len * chunks, 0, &ptr_buf);
> +
> +	bpf_for(i, 0, chunks) {
> +		err =3D  err ?: bpf_dynptr_write(&ptr_buf, i * len, data, len, 0);
> +	}
> +
> +	err =3D err ?: bpf_dynptr_copy(&ptr_xdp, 0, &ptr_buf, 0, len * chunks);
> +
> +	bpf_for(i, 0, chunks) {
> +		memset(buf, 0, sizeof(buf));
> +		err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, i * len, 0);
> +		err =3D err ?: memcmp(data, buf, len);
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	bpf_for(i, 0, chunks) {
> +		err =3D err ?: bpf_dynptr_write(&ptr_buf, i * len, buf, len, 0);
> +	}
> +
> +	err =3D err ?: bpf_dynptr_copy(&ptr_buf, 0, &ptr_xdp, 0, len * chunks);
> +
> +	bpf_for(i, 0, chunks) {
> +		memset(buf, 0, sizeof(buf));
> +		err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_buf, i * len, 0);
> +		err =3D err ?: memcmp(data, buf, len);
> +	}
> +
> +	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
> +
> +	err =3D err ?: bpf_dynptr_copy(&ptr_xdp, 2, &ptr_xdp, len, len * (chunk=
s - 1));
> +
> +	bpf_for(i, 0, chunks - 1) {
> +		memset(buf, 0, sizeof(buf));
> +		err =3D err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, 2 + i * len, 0);
> +		err =3D err ?: memcmp(data, buf, len);
> +	}
> +
> +	err =3D err ?: (bpf_dynptr_copy(&ptr_xdp, 2000, &ptr_xdp, 0, len * chun=
ks) =3D=3D -E2BIG ? 0 : 1);
> +
> +	return XDP_DROP;
> +}



