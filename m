Return-Path: <bpf+bounces-77030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C21CCD668
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 20:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 460913028582
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B01339841;
	Thu, 18 Dec 2025 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUnrAiqz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF0335567
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086329; cv=none; b=L2fL3x1D/oK1VwYQNk/ZgZhgpt6mGyfFBjmh5NZVWa9wHzrK42NSLd5D6mh/Y6JIzsXoiU8gR3O9d/4ngRiCCL369f1hSmkiqF1gbZ09ilupVOgxYIWfFIuut+r5bqg1Mgq9FpO6roaFMGMeYFnR/NuWSGXvummLHj+1Nhhtz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086329; c=relaxed/simple;
	bh=ssIwjLKhW7TxPZZsMXmemlCPcgF9XDpevuAc5bMB6Ck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYFl/H90FclP3FSUZAjSWfCReupxJAgcw/yg7Ufig58q5aBVv7CI2yzAUsqdxnOhUgc2PcU1jxCGicIaCaJ7NtyKW7YyTHysZj+b9ziVlYOQm8/N84OAo/GDxT7K847u8Af6oQv1fb6sKVUdPydW3EivfAFOGinMcsrURKYZeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUnrAiqz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0a95200e8so9391235ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766086326; x=1766691126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ssIwjLKhW7TxPZZsMXmemlCPcgF9XDpevuAc5bMB6Ck=;
        b=fUnrAiqzEP/UcjR2HvY8haQeyosVl/6Vb/9ht5bgxpliw4ZT0Bxi1oxtsjK5wNKo8m
         C5pFl511/x6fixuZKwuLUq/mVx4Uscfdp42kPMu5rKDVaB25ZQ7aE7Yd2nm1clgqk+rQ
         84oxAOG0Z/sGkXQqwsn6sF7nJYYSuvZnAVhxMIchs/BGiEf9sNt0D4xhQUXvZN1B26/Z
         FL5asIUXvDWhw8gM339+x3D0Kk6aZvmLsrcWyrXvAe7w3+/cmPwLHsPhKjwcOPYP289L
         3BmpTQklhCCm+faudTsM49VnDxTi5fv/Prw6dfc7emdPdU9AgpRouk9ZYcHTLNYNboMc
         SjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766086326; x=1766691126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssIwjLKhW7TxPZZsMXmemlCPcgF9XDpevuAc5bMB6Ck=;
        b=SfruWRTgyvcUrnZsPfuQMIHMI2ELBKitkcAvhDP7CDRaMs6fvTsOt1isljxG5vLPNc
         6tmLoeMDV0BQrSRzfsEn6nEJV9UXtwdJ4pTy5GZrui5xTrFkPn+wUg3LBv90w1FvC1xP
         hHK81cqVzXFDChGqzDzhoCX/70gzzcrRyTNVN5d6pXg2c7G0mz8kWjACvgL8/xmx99Nr
         f9gNtz1UuV/FD/WQehrVKVZay71bKZL22Fe+OYIBQxHcArmnAIX2JrJwGMgx/YBXjxPB
         g/cpGwaf0ep9GAM56uRTSsyxjZuLDKYyT5IN+kQ+SYbvKmbNJyi4CX+vB/8heCyn8J6M
         fmkg==
X-Forwarded-Encrypted: i=1; AJvYcCXeC5/2BKgqPJntQ7BLX1OmHzOx1yR8NQ2zG/Bl+w7cZCYMVAdmc3df3RIf6snoh5Y1e4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy5I+6MEC1rUcLo1RnqL9HzU+sg+YgWrtnwKA7W1jV77aeRlTc
	zHx2YB3YSDwmaRc9+x2Gk5fHEIdYPzYUGwGCERh/Lm+8xSfMPPWmFOhx
X-Gm-Gg: AY/fxX6jCHZzMDEowjgHbYIrWgj6K22A6kjufxFkMOdQK4WFekACaUwovsmO3DYp2sZ
	mlo/Fy1D/j5e6W9yIGaxyyiTFxKvIPNKSqnna0L0PICeevSvTEQ/BwwH+2BwgvpDob3Y7x2/e+c
	KCIioK4CddQjrr7m289MuAyunziA5aWDSAkAW3T39Q3S1Yz3dZ604UaKfhMpC1MgBknsyREwbBj
	eGifkKfFFLz+W8kW8BQo7BdiX/INhAZSNmkETOxWhYJVsG3Nqpsq5pALKnplM6t1o6OQCwgd3Mm
	Tq7BIv+CMGmen8lGMSjW5snm3967itiHwbJ6nXVbkxwyCw9qUseoLXBnF59kQ4Fr+guml/ixBoH
	Yd8BzHDICOy+dQJflDKQl45DFeoFK7fNIlbw4AY7XY1W99hoXbqvr1eyVUkufTjRQZZUgwE0o8B
	AdzeONsA5M3tN7uedajShIUqRrIEl4Lk4e9hCC/WmZI5j333E=
X-Google-Smtp-Source: AGHT+IHljvg4KI/iWmhtSRdT/OZ69NXZamkuNiRG2Vuw0TgHR1NsiuAkOpR56lvEGU0UpJFMOWBdBg==
X-Received: by 2002:a17:902:d484:b0:29e:c283:39fb with SMTP id d9443c01a7336-2a2f2a35736mr3418655ad.52.1766086325869;
        Thu, 18 Dec 2025 11:32:05 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d912:2088:c593:6daa? ([2620:10d:c090:500::7:e642])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d6d557sm542115ad.84.2025.12.18.11.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:32:05 -0800 (PST)
Message-ID: <843d859737c1b70fb4c7b543c78afdd884840091.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 11:32:04 -0800
In-Reply-To: <20251218113051.455293-5-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-5-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> This patch introduces binary search optimization for BTF type lookups
> when the BTF instance contains sorted types.
>=20
> The optimization significantly improves performance when searching for
> types in large BTF instances with sorted types. For unsorted BTF, the
> implementation falls back to the original linear search.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

