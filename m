Return-Path: <bpf+bounces-33911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9945E927E56
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 22:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D181C22971
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352A13DB88;
	Thu,  4 Jul 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8DGUv6M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A8C2ED
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720126273; cv=none; b=R9C2UudeH5y8S8N9w/jpLdpebYNH01pzPsJK+0Ln2FaPqlmZd1Cr2HIZXTakapCaBvugR3zYbmtpUwHwVkXNx+hiUvYEr304dfGNSkiuPa+xhc6IUq+ZTMtBnFaYXZMOIgZ9IwQfh0sDqCovySnYodoGhU+pRzpLLuY305aWEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720126273; c=relaxed/simple;
	bh=JSaf/nDb0s6xGvsoeMt5COMRWNoeH1JiLaKYcQ+ydJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uSfVlOSoa1MUGyPPC/2PDcOhsXNRrpoD1TVcY4YcWjI9NPIkhxoFK8fna5l4xHll0i4xRCq3yXXiRbzB3NHSqoL/HEMkn9AU/hlfhBHdDlx4mK7ZeMBa7O45uMWZlSAIlL8glR/GZ2dswc/nX/lzg6SN8HP4fG9+XZrLG3vA83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8DGUv6M; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d5666a4860so590383b6e.2
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720126271; x=1720731071; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G0SjGj3ys0flTzVDf7zfKXKhRIXzc4MQs3jIg6g/3fI=;
        b=k8DGUv6MDypBdCgtGJrMxYHLodwMODQNMbQ22HJaQRybz4VYpabOZ6OsYaefWjJUb5
         eBdPYZcenapUP+If1+qY/sbd6rVVjIpdzJINX/aTOgHsAuQ30oRRRmXxxvV0GsAvFIKI
         v9qwabJeYYbNTKBGyNYV1Ra+ANpr8NRrCJouxoVOc6dsyrPvZr7F9zlRv32FXHpShque
         zNdL0pOxEteG0nFPig9iv/WK7tuUs8F963qj3gegLOqd1kS4PD1FiwVhIGLNRSvJKubE
         s7Q8UbZdHBweMC9OgH6GcUTyAT4Lb3gIBTpUqWxCl3IZ+sECb3FQHj2WNEcE4poTK64o
         d4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720126271; x=1720731071;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0SjGj3ys0flTzVDf7zfKXKhRIXzc4MQs3jIg6g/3fI=;
        b=QQO9fkJPgxA9WAymm20qlX2umyGjbZI8TfJ9cs1brpWbf2kDYCKQKM9einUcG+TA/E
         yxr2Hz9nWIAGQZh1imSWAJX6UE4aYhI9orQVm+KbuY9MedjPQ5J5BcYyxlrsi2RbOG0B
         ei+M0Mdx2vtj2LWvckpHRvqRWP/xqIas2q6FkTjOa+CnK6GBmhBplP2k1JDqnRm5eV7v
         bixEDfF+C+iSFIVwwyGRls8f1NhEjz/2BdiO8iI7DuCB7zCGu7GElEXUxD2D9K6lmQdw
         bXdAc9ZCp1rW9FTwfwOd0mC64mqPxI8pREwE+0LCvPLuOMhR3EH9ouras1XlZ0B5tKOr
         zTkw==
X-Forwarded-Encrypted: i=1; AJvYcCXNZIZofpjREUuTUy7SsAPOvl108HmFwRRMEN50TG9EY7UDbxt8r1LQm5mr2sAoC3DH7xy9RQ53wdU4NLzXCF4mUWRd
X-Gm-Message-State: AOJu0YziHn2QjVTUPMKgLTiIZGilbaafThxWuUNPvU9aNbwszUZ2HOJZ
	h5+uP0gJhx/fQAiacv1E/yK3RixMjHIobLcQD5XiqOjD8vPNuFvI
X-Google-Smtp-Source: AGHT+IF+yDoamCtKQa1xkLE1AEzGpi9io685TizdTMWXkQUHJM5dKAQg1qqa6MFE8szsSxO8KhrHuQ==
X-Received: by 2002:a05:6808:238f:b0:3d5:1eba:10b5 with SMTP id 5614622812f47-3d914c51bacmr3243106b6e.12.1720126271001;
        Thu, 04 Jul 2024 13:51:11 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7084d7061a0sm12369848b3a.219.2024.07.04.13.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:51:10 -0700 (PDT)
Message-ID: <11196cc77173e29588e93078bd74a9ae9d8463e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: fix BPF skeleton forward/backward
 compat handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 04 Jul 2024 13:51:05 -0700
In-Reply-To: <20240704001527.754710-3-andrii@kernel.org>
References: <20240704001527.754710-1-andrii@kernel.org>
	 <20240704001527.754710-3-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 17:15 -0700, Andrii Nakryiko wrote:
> BPF skeleton was designed from day one to be extensible. Generated BPF
> skeleton code specifies actual sizes of map/prog/variable skeletons for
> that reason and libbpf is supposed to work with newer/older versions
> correctly.
>=20
> Unfortunately, it was missed that we implicitly embed hard-coded most
> up-to-date (according to libbpf's version of libbpf.h header used to
> compile BPF skeleton header) sizes of those strucs, which can differ
                                                  ^^
                                          nit: "struct"
> from the actual sizes at runtime when libbpf is used as a shared
> library.
>=20
> We have a few places were we just index array of maps/progs/vars, which
> implicitly uses these potentially invalid sizes of structs.
>=20
> This patch aims to fix this problem going forward. Once this lands,
> we'll backport these changes in Github repo to create patched releases
> for older libbpfs.
>=20
> Fixes: d66562fba1ce ("libbpf: Add BPF object skeleton support")
> Fixes: 430025e5dca5 ("libbpf: Add subskeleton scaffolding")
> Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

I double-checked all uses of bpf_object_skeleton->{maps,progs},
all seems in order.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

