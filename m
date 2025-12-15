Return-Path: <bpf+bounces-76630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FB8CBFDFD
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 22:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF9E3016CDD
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB6431076D;
	Mon, 15 Dec 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL//qSk4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE637328B6E
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833138; cv=none; b=SV0JYQf/j8gWK/yLmcw2uj9wmCEqZK/mJwvn/o1VObCFTSfkiV/kHdc2lqin0y/dekuZmcn03R+vDexCdP1HxZ+TXqpxqRDDcr1sRuSM+OgpmTUpYfJPSD0HNIUgVmKTtQotf35sETy42xJ6F6Bl+7CYO6Bs1rwwIk8mzGOnXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833138; c=relaxed/simple;
	bh=WnSSJruIHQYbFaCzG3AM6lw/2t1SyBRruHLEqw1qp+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSMp+uW0rlgz726bhEtAFu7kumpYKJBdxFQhHU/agt0aJU+M7INJx0UYPSSAWOQPhiaJvFvYWe+gowFm5mOcJP6JkonwyjCbM+MHdqMVgrGYKLR5oDLWlnNV3Ebk2hD3/gyQMo+6uh0D18UbpuuIws/+vx7xWN3xvNhmr4bVw8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL//qSk4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7f651586be1so1728109b3a.1
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 13:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765833136; x=1766437936; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WnSSJruIHQYbFaCzG3AM6lw/2t1SyBRruHLEqw1qp+8=;
        b=GL//qSk4Hm67wvozu4uAORn5t3/+vBzn1tjGbTS9fW7m8uayjaSyXr4gAFk7yMpnnQ
         0n3gLytf5Sgvq65I7by1vp0pZOfhc8HWn8Qye04OUzHBINrnkwSaeGdprfRMkbdXuWb6
         U4CakuGvMOrNFNLxiyxk+S1C3AYP5jC5mprA094G/potpyHzqshJ2gNxvPnpdlMAOKhQ
         XuLcTLzujbwlRtIu/sHFYh4GCzcan/KPy3uY+hor4vqEE1BbZTPWjLWHJXVMymRfaFUX
         /kTKHjX+jpst4wrillaLVAsrML5A5KQNB4lhR5umGw3A91gY122Ekn943ZdBNv/KDRum
         TX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765833136; x=1766437936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnSSJruIHQYbFaCzG3AM6lw/2t1SyBRruHLEqw1qp+8=;
        b=xT7jGN8o4dRVmoeK3mlwTUPKIGF41cDGvuYzW13O9kbOpTcHrMmPNizcDdYy6d8K5c
         6Q3dYrCjG8e1bu4Z3/ZDv9+Anlixsn8VflAifOvf7ZHRq43RqupyOxWiiJgIIuydwZgs
         7wpL2ZFSSxqiMCcBb9SBOfH2HeDQnMMGO9wr4D1UKqfYUMemiO7H0hlUhzhtKHLOyOVT
         K3Zzcrx/1dJmOgo4zWwaYm/sib8kBI7Znhg+DZzPRNGwhhARGrnTY7KWHMT98BRYA939
         5SkUgNshDWGPbcBRxCO507IjNZHI6y9w8pPMCDlLaEwLSh3c/hcFctS7zX/fqclNM8IO
         oimg==
X-Forwarded-Encrypted: i=1; AJvYcCW2YF7QZ6KAR7rKbGMgohHnxR9pIAt5ZUzJD0Dy/hlGOZIFqyq9No0LhZ1AjK/TDhbDF+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7AWSIYzbfips/KT3+c7pyIYs9g6zqcIxG7WeElB9hE8R9JSM
	cTmZFlKZnCZ7Jl1niVvf42Y5e3Fi0WDf0Dk1GFbCjhubW6UW0Zox5JO8KrMi3RCv
X-Gm-Gg: AY/fxX7YcVhLcr5ORgkCY+a4ZXXlsRhLA6HsrZaWTf15xnECQubIJMA84x3j+NZFJfL
	MYqWjplb3KIhXr6X/hHZpg5U7RV80btiy0ZUqdaSuZCKXCP7xM3C/muRQsc+fvZOFT+M+4FNghH
	+N1g30dd37Jn+83/iIK1BgbbFmahxFR3zVqQHQZxVHoJhhci1c4q8reEZoE672keq8KrRJZxjuy
	s+2gUwPpPjdWrz/1o1/6rGRWDTpnUDxWACMmC673ie5EOdEOPijrqVwNuFuADCajPmuZo+lyHV8
	tJTyiwmCo18CKtRtDwKL6LSwG43D7jpmR7z6No7pm4Uk2NA4rz1YfM1yujAUrDMbgCVvUfm0smF
	oYTtbPOghR8FnLf36IZN+U2ChinNJN0rNg1jpnu4gfiGuXOXhyofJgaAKUYGIRiAxJqfcBtH3Kf
	srk/GZnMNs
X-Google-Smtp-Source: AGHT+IFLVTgQCWTpCeUCvEW7NBqed9WvXR8o6kfPAiu2xLFTp54+7t3IaMOeWd1/pZLmbK30uuR6bw==
X-Received: by 2002:a05:6a00:739b:b0:7e8:3fcb:9afb with SMTP id d2e1a72fcca58-7f51db09721mr11435492b3a.17.1765833135841;
        Mon, 15 Dec 2025 13:12:15 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f634c229b9sm10397760b3a.43.2025.12.15.13.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:12:15 -0800 (PST)
Message-ID: <bce8c7063b11fa8136a796fedc24b7fc7866f832.camel@gmail.com>
Subject: Re: [PATCH v3 4/5] libbpf: move arena globals to the end of the
 arena
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, yonghong.song@linux.dev
Date: Mon, 15 Dec 2025 13:12:12 -0800
In-Reply-To: <20251215161313.10120-5-emil@etsalapatis.com>
References: <20251215161313.10120-1-emil@etsalapatis.com>
	 <20251215161313.10120-5-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 11:13 -0500, Emil Tsalapatis wrote:
> Arena globals are currently placed at the beginning of the arena
> by libbpf. This is convenient, but prevents users from reserving
> guard pages in the beginning of the arena to identify NULL pointer
> dereferences. Adjust the load logic to place the globals at the
> end of the arena instead.
>=20
> Also modify bpftool to set the arena pointer in the program's BPF
> skeleton to point to the globals. Users now call bpf_map__initial_value()
> to find the beginning of the arena mapping and use the arena pointer
> in the skeleton to determine which part of the mapping holds the
> arena globals and which part is free.
>=20
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

