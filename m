Return-Path: <bpf+bounces-77054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0EFCCDD65
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3E3E3058464
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47392F3613;
	Thu, 18 Dec 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S81qPL+U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CC2C0291
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766097297; cv=none; b=lCa3uvbEEQFzvWZZrNqXYRaMQeJI7pUnVI0/zpQBR66Dr2jZwtp2hozOpX+FUX0K11QeqOwW0a1biZG8aCrceXHhldB4yd/MDmBmrTCkSHYeRbVMbWwDaflyTdpMWmUI3Vg6Az0SDX9Q9YvIEq/jGMRlU55Gg6TLNLL6eEzC/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766097297; c=relaxed/simple;
	bh=czzmppIyjjj7RIUE14rFRN89EdQCvwyVAVF+asTs7Ik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVpuh10CCRrIEFjZhJWFlc1IAbB2EPmGzPJHjtJvYT1EvRdQsYyxR8DHZtw8MXJOBiau3rxr11x7K4c+FFCXhoMDfbBl8GTi38qNq37t3ZAPIg2zj1T7oSfrppMKNCVq7la+vCboCpvjCbmCH64FSMQBgUK1+gdDts5kLkWjtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S81qPL+U; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29efd139227so14711185ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 14:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766097295; x=1766702095; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=czzmppIyjjj7RIUE14rFRN89EdQCvwyVAVF+asTs7Ik=;
        b=S81qPL+UmMYZdkRWi7zDYOn9i+temZrVuSzvkvuCFY1Sfhf5K+PrVMcg0o+rJkGeZ7
         x2vg4EMUiNalNw5j+VUWcEYkoZa4CnScxuuQkpPPh1lfXB/r+ciNIZOMZEa/7Gg4nBn7
         LmYIqV2vMtcPJyS+G2Kxl0LGFvJkvEuxsszqfQlZoLN0eF0KwdysvZL6s6N97qrYDK34
         WU2q3JAa0O68oRoYbeImhuQFALK11wk+2nP1DFNSRLVHsGSTPghO7Vxebc2vmk9vdv97
         hgb+x1HIS10HmVqhTBTrt6NnoFHn0+F7M+0Z1ABldVG6HtWbETy3O+yNKahA8IcQ2CIX
         NxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766097295; x=1766702095;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czzmppIyjjj7RIUE14rFRN89EdQCvwyVAVF+asTs7Ik=;
        b=spJ2yUXrwBptJfGj1opZvp2LlyuLHtCQbRHpTWlbVhrRIWd+kN5WR9CCDl/sG5A8Up
         dsv85+hdMxmYvCPjWeMqTGNXhBM2VrvQ/erlRjFGd0kzT4UaUbj3n6bYjpFYFRbahLoA
         Fg9kAadfuJJRJJ5wRHzc4ajWp1Zqqrj0VZW20dVLzntSkSYj793n5ltVw99YPab82AkH
         X7pfa77XoKgfQe9ZLnpg0kZTYOCqv2uLr4uIhLFn4LOcJl2+IBCu0KbRpfm/hRlePSTm
         bNYuzmVDwDAWAaugfYSWnv9cjQIujCnI7+4PqjMH+K0hDzCpxa3pcndSRbmaFlv2/YQh
         mPiA==
X-Forwarded-Encrypted: i=1; AJvYcCUnEObZ3Lbq+u4WCUk7K29dwpHG4Av4PqlCTAnf0m6P/MpZ4wJTx+c6ZDFbT9Ogf8oeVPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRK5y+OwE9BUKhB89gXMn2o4egL0S2mGLjhwKMkcFAC/zqij6e
	z7yIfUsZKk7Ed9rBw16goy+o9MyzGohU04FyE7oFnjQft0YN4PNNoSuK
X-Gm-Gg: AY/fxX5nI+m6NL0iUrqnPxuq4GHcX2hsc91jiZswZS8mwNQRT7pJNs35iDOwF3KSGn0
	Edww26ojoTYOJ+Y59sJu/N24q3FOXOowLSTLf1GSGr+FD6LxC7pwsSpdNdCuHx8qZwqAOx953U/
	zlwBgEBEgsz9jaHlt1JNVqKJnqS79QGtI608eGI3ADHF2/IYvfUtLDuSiu2GGFWJQhFJ6XHi/H9
	WlAgbf6JVynM147lMbVkECy7Xt94myL52+kef1INWX/B+hOMJX4INWY1Ojrl+wPCGo+tQ6gzvUv
	Dt8+MXL/rQ603SFdnhk8p7kiGq3Go6V3QJD1juE1bGn3gD1jik7qrJ0Du5L2AA0sKcL9FY5aPcq
	lMSGAIh+G/kqRnUvF5ApRaa032qt/7ROwevp0D4UbwducfPO/3gEO34T8FdJjDqbEJ4aPGWTCqb
	UoJV1WUXJyP0hGasUQrpfPNFpR6YQHdImXfYVu
X-Google-Smtp-Source: AGHT+IEwSRdFxUVb13ALwlxpaIHZTTB8BhdbEBj1c1I8EZTickWph9IAnDTr5Fqp/zVn2UcRc7YKBQ==
X-Received: by 2002:a05:7022:208f:b0:11b:2138:476a with SMTP id a92af1059eb24-121722de680mr653967c88.27.1766097295223;
        Thu, 18 Dec 2025 14:34:55 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm1980083c88.4.2025.12.18.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:34:54 -0800 (PST)
Message-ID: <f60b0d23e3ddd22a077d5a5218d6d97fe48172f7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 13/13] btf: Refactor the code by calling
 str_is_empty
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 14:34:53 -0800
In-Reply-To: <20251218113051.455293-14-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-14-dolinux.peng@gmail.com>
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
> Calling the str_is_empty function to clarify the code and
> no functional changes are introduced.
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

