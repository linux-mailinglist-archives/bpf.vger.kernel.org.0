Return-Path: <bpf+bounces-63965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE4B0CD7D
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812636C35D8
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D01923D2B6;
	Mon, 21 Jul 2025 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvlEQJAw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93E1AC88B
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138889; cv=none; b=krZhKfSyeuc/AClp7gGEfXThSGtc/5uEVP1F/nLs+lvNYv1/87IpqQ/4QekZ1BSwaD0eH4Z1CwI37GtyV0x3130d7x+7NsQB55imWXwEKapIMEqCNYg06vIFH4RDJe2MPArllk2yuYYUBmRALvsHHHc8NHNyep2+7blytFyVZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138889; c=relaxed/simple;
	bh=drFTvDndEoVe5muySRQK94rvwG5dqoRU+0nD5Ww2BCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBM6C5bkeknV6hs4RUV2cGEcxj55VBGpPxdx8Acpw/t04lp/bMJ4Y2f+Bip+nQ2EXoT19rstpFrC1pJQuFmcZ4J8tbqScnm21E3kjj/MmHjEAIYg8ZUxACpih64OtSDibldT4HEKcx5txgprEClbjUAabzZsuIqWkyHqlSLFQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvlEQJAw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23c8f179e1bso48703665ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138887; x=1753743687; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=drFTvDndEoVe5muySRQK94rvwG5dqoRU+0nD5Ww2BCE=;
        b=LvlEQJAwz0iie34RpamRYYnEUe7MF2DzofgRxGLh9FEC1iTlPdLO9szxSYWha958k3
         RD7T6qJWwQAn4gQSBrNuPLw4iwjynjLBa/B7bWtLz5JKVvReCV9vX200JQg5VodQP0Y8
         AhpHSYP4kwCBfdFftvKnVDVzQ4PnAwbej6QNcWAQjrhPAU30zJkrie+jw+qSje6VzTf0
         8prlz+db3DeIRZbUDgZDec8sBgwyO3QyuuCUnATSF5s++xK3Cy3qHbn1jQm06h985V08
         PJ3aLsIiqj0nQ2LY3G4mgboCNtAVXoOg/G2ZZIuBSdfA7EEwvLM8187fZi9bTE2aiZNZ
         wbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138887; x=1753743687;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drFTvDndEoVe5muySRQK94rvwG5dqoRU+0nD5Ww2BCE=;
        b=rw1jqFmm0D52TLcpmUHWbesNtSyzL4mgV2SQQEhczCL5vu1AM29Q2J3dbwqsZwi821
         eqMR5DWIvXjAFyPEOISLlvac//oGnWQnCndmNkPBrgllJIgB6PfvOct9u/gasdQCQL7g
         p1WxTHGVCqJbIpJ1KL5rhFZ9omHCL7VZD+AeZPMt84f6D2shv9Cp91B+VmBwbua5a9zC
         dlOL/4xifAUoILz/8gw8BFxlPwMuyUxfB8OibXwvKIsjn+AqMGQrx4Azm6Z1QpRD4M7G
         TaPFR1AHrsGRdwLJwht0UlDBlA4ruvErCMYt0INVm9qM4O3ON0nZSqG74t0iqyq5vqUd
         s1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUFDEJJ4cu/lzhoC7XmoFaTKYYvlYcmefeHwBFnHVGyMOdweCCSMvp5Pwdl90e09UO9CSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLY2suewbgFSDgce/7vLHma+hUoATh0+4fZ2fTPP6iGvq8SRL
	y8gV3iYsZ4snFVBjIIlH3bg7sVXj+PoYDftuI7DjcpTZ6dvP3V/RBeJu
X-Gm-Gg: ASbGncsU/IogjA1L3IFag3zQE6eyj5vFmuAAr0kY4pJZvHF0UDIvJ7P2VbpKCorY5BF
	rXud3Vs1ZxC8QjivrvOvouGxU8eIL+0zH0+uphcwiyzQ4s1IFqmBY51uXuPRt/MfbsmA2KBmlLy
	28xU6zE+xAzPygJtfXrEZ9+Faw97Oq/GkGOfIyY6Pxzg5P/aXdwbV5H1P0zk2i7uGehM8riugeq
	p/koz1XvfQkrtBxPutZbsxXZGUvf8r3OTupNsDTNTRjhpaNoNsEqlv8Y/3W3MZUZbnb9LYUaNJt
	eSB7HV+Gic/8tK1/PqaPhX97lLazaBgk2S77DXXEKyc3wBHgddqN3K7JG0tnjzpHuh4mOs7X5KY
	DdfeQLdRkELj7OhhAvsQuaeFRPcmIrTNb51sT+ys=
X-Google-Smtp-Source: AGHT+IGA5xU1/uh9WI1f0Rk3RcijSwEFSZSqdDh9vqQ1FMcTMHDBokucP6e4kZD3wwY19lF46LDk8A==
X-Received: by 2002:a17:902:e884:b0:235:129a:175f with SMTP id d9443c01a7336-23e2573647bmr303360255ad.34.1753138886843;
        Mon, 21 Jul 2025 16:01:26 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2e51sm62952975ad.19.2025.07.21.16.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:01:26 -0700 (PDT)
Message-ID: <1bdcf2d020c6bd69be8421cd5e979f825e14dd64.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use ERR_CAST instead of
 ERR_PTR(PTR_ERR(...))
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, kernel test
 robot <lkp@intel.com>
Date: Mon, 21 Jul 2025 16:01:24 -0700
In-Reply-To: <20250720164754.3999140-1-yonghong.song@linux.dev>
References: <20250720164754.3999140-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-07-20 at 09:47 -0700, Yonghong Song wrote:
> Intel linux test robot reported a warning that ERR_CAST can be used
> for error pointer casting instead of more-complicated/rarely-used
> ERR_PTR(PTR_ERR(...)) style.
>=20
> There is no functionality change, but still let us replace two such
> instances as it improves consistency and readability.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507201048.bceHy8zX-lkp@i=
ntel.com/
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

