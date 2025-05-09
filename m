Return-Path: <bpf+bounces-57841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505D7AB0A84
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 08:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8947E9E6F40
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271A26A1C9;
	Fri,  9 May 2025 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esIJ+lAM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62EA26AAA5
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771729; cv=none; b=kR4BOufyHYwR8stqbmZAdhD9DWBOXpjtP51pkMRWeZf6l4z8B3y18N3uhfmS060pwU3ESGHzCaa47aJaNUIHKEVOpwcKzBzG26QzYzXjCz3/sNf8UQXOmrlE25Ic2jn1L62bjPHO0uTX+eHZiraRKdej6fGSrWXjETBEQw+kqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771729; c=relaxed/simple;
	bh=n6WVIcg3EWggQndfoR0doP6v9F33+maOhmmqJFW0GaQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BM9YWyJs8mO1Phuo90wuQZtMrUpK1qsLLTuRV3FDkf5marJpKRzxZhlytucM+BK/oxxXQRqCiJbdW0sBDbeHGIA+kjIPUz7keYzCaMpNecAHkhHFq/1nC41gTxKiJ1cB522yFAhImWlOXwjXxd9JDjVKiqfpDV7M9NNJY/S2+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esIJ+lAM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74237a74f15so999705b3a.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 23:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746771727; x=1747376527; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n6WVIcg3EWggQndfoR0doP6v9F33+maOhmmqJFW0GaQ=;
        b=esIJ+lAMsxhGUHfZ2Ml/qBzUQCh+uvVJ7U27NXy1booFWaeDfySK7QP2+ufdda88UO
         TC/4zOExSNIIXaprkkuZDKtpuOAAvfjkrJeCJgiIt89xTowDqIj6FMZCZugj2CVC9dLM
         3J3PVIIJpe/T04LqaJC1/lJutbuSrJxpg1XYX1FohgONCRmQ3sjsl1h1YXP/vP0hlMFp
         wZNI8yQ3ZdAWwhFZprgzUwwjLC2u6fFcaubIdEzvtt0PkpYZf2qJQEeFlRpbIn+wFlxn
         nF2Tq5qans5M7SFUKqN6cSJFkGuquwgUOg7bvKTjGzR+qf1TgFZsfSZzFM4t4rlsf6Ua
         Rmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746771727; x=1747376527;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6WVIcg3EWggQndfoR0doP6v9F33+maOhmmqJFW0GaQ=;
        b=L5RY42OU6bWQCb9H3qw2Jn1AX4L0ycSjdwB0fzPj4iW2gOzAMyMBzYbqFtEavC03Bw
         ZQXbj1OPZk8o+ql7dCmfcGwq3Hj1agJfp3IWQUnPgOVxI7UwO5/78bdZTfZTxPLO5GXD
         f/Cz8FQzy+SDcfM7f8bOtR0WCTgQJGv3b+M37g7BFWZocs+WszjkWXr1yAFp8wRqlExf
         W2dyX6/pijw+KCTMCAsZNLJAbiMD5i0Ht2nvymoZdUCd+FsLIpEivOmnkuDKib97obAj
         uy80L8nmffuR6s8EMB0oQfFI5IH0jY8rkJQEZGaVzY3smrRoxyI5JpJRrs8XkJc6Y+rx
         OyeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxvzIAYRtlgu5cSGOQEl0oERookkjd+dTAEo7P4qb+E7ZCYJ5iI1dTWOYMJDDCfbqEplU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/qk2rNN+PSS1l1M21V68zpuOlKyFyW5iwH4mnIH4a67JW5AN
	/QbP3fN9K/zjBblxPws9aaviqTgtH5zjjaudTkvkZ2XU/4N2BDCy
X-Gm-Gg: ASbGncsdD+mTju4U9nYnx1QfERIBdDwe7Hh3m7rkBpym5cqB3W6F1LGT4gvCdo6uuub
	WK8rNjRaTfoCprUyv47zZPiySXiDxtXILM+vx9DFWg+LSapR/h/lb4+4UNdkWCNR0K8xEjym2BV
	XAPGzTIwfxUhxBVeX3aw8orvJwg8/tPzu1DxSNBQ7slvQiC/o+/Q/Qf8TjS9gFDtkbsvtxZfUeQ
	RAYAsRnzsqUq22pVA5JXlS3+3JMC1pWIVa3y1d/+3CzH8sH6Vreibfc/uCVUNd6cy/KXG418Ynf
	hHX8fG3dVCEXzHNBD3Un03A952O3AwXWayCG
X-Google-Smtp-Source: AGHT+IFA/6YGtlyfMzheZMkCkeVbA6VMKVhC6h93dr/S0s+IaXD5K3MGmkErfuIbOyvRI82e9/NecA==
X-Received: by 2002:a05:6a20:2450:b0:1f5:8748:76b0 with SMTP id adf61e73a8af0-215abc2f9a5mr2763263637.29.1746771726844;
        Thu, 08 May 2025 23:22:06 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b235252c7bdsm822482a12.78.2025.05.08.23.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 23:22:06 -0700 (PDT)
Message-ID: <01a726910a27c92997af4b1654f483aaff190c2d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 06/11] bpf: Report may_goto timeout to BPF
 stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>,
 Barret Rhoden <brho@google.com>, Matt Bobrowski	
 <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 08 May 2025 23:22:04 -0700
In-Reply-To: <20250507171720.1958296-7-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-7-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> Begin reporting may_goto timeouts to BPF program's stderr stream.
> Make sure that we don't end up spamming too many errors if the
> program keeps failing repeatedly and filling up the stream, hence
> emit at most 512 error messages from the kernel for a given stream.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


