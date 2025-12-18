Return-Path: <bpf+bounces-77052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE7CCDCFC
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B376E30213C7
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD02EA169;
	Thu, 18 Dec 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUk6W+tz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C42D838B
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766097054; cv=none; b=b5smE38VZyS+0x237IanKcFokc9UrFHIXOFs6lw17I0ZEsW0Qgufrg/8lGlmD30uOfa0E6DWuAdYsLsH3JBQWQArZFwi9fquKPjoYo8ZBPv/wUiBDoT3ugi9T/KaG5++pRX2ooGkLgCSlktF+CvHlvi7nmc68bs2MzNivqq/W5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766097054; c=relaxed/simple;
	bh=XTUb6v6Y1jFD+/PY81I0lgARh1y1ThZ9M3h5CyZwf7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/FEzBN9J8ziFU4CdiGbk5L0z1gZm4Z0uVCV7Nl0GcAG3V1KvelqEPyAsS4rBbECG9AeSsXm7+6nIM5J2LKtUeJN/nADPq9Y6o896D5vWy/+O9ml4ZSnb3XPfvRgWpkhjk8d/u0yBxsAJVBQWhIIOfUOTTqDEREDNxYLWtNKc0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUk6W+tz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a12ebe4b74so17262375ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 14:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766097053; x=1766701853; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTUb6v6Y1jFD+/PY81I0lgARh1y1ThZ9M3h5CyZwf7w=;
        b=mUk6W+tz56W9W3wd2OIzxPQ29Xn2g6GxotmdPC1YiHoQ/QXB3kefsbSXUQl81ObW3Y
         wWmPDGfuz6l71Pxi2cvPT4O9oKlG21CL+jOw88lM4d5gySyZwcGqQ5f8UfFTe0+53Feo
         7byzklBT3jZO8QkUFiAkStyC6JDYdjSmHIX7cmm0iFlGK0CfbRAW5rrbs6vb18q8Gaw0
         1nivXrsQtpb/vctiM4VA+ByQAAI2E0op2ga23ma6colfp3GGxNl0MucT3jNXKp23CilT
         R8YoTyhmVorJd2DYwKdKZzL+Ug/Nc/ZqEt42OicrdmPNeIzvyXIBA8jbgAUau29cjhTA
         IoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766097053; x=1766701853;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTUb6v6Y1jFD+/PY81I0lgARh1y1ThZ9M3h5CyZwf7w=;
        b=SYz3XH++PEFVemD1FjBPG1qfnbIpQPL57gU6FGRxEllL1mG0Px5mbXwWP1gisCR85V
         lizJ1LfTTrtpC3q/8kHnZOQNKSdIRT7Q/0Kd3rKCcA/kWoi7UJMg2z6HWL6MsHqvHHYc
         8vCF1xbDCXMVVrPypdAID+VQihchaA30+AIxp5WXKycCJm1RN3sxZW6vAzjG1xfHOEMd
         ZMlpr6noK0M5l44+gCTuXBlbCkjtQwE5kqvy30uS80pNANY+d9sjTI0KCUmp61UMGCjp
         B1ErcDLH3xi8FCwwIjbN6ZSBK1+ZTo1gNz4rN6PGCS5hRE/K0Qx/LSN46Jo5dyI9kXAL
         hkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz9CNhA/UawLbiPr/K7RGi3yEw5UMS0C202wXjrhf4o80KCbtSgaMSah5zEWE0bek7XWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvzJF92J9TJ7LlZ0JsKMsBLqanpj2J3sHRhhfwsQMs3EwMkrV
	p49oCyGXYjFVnr2oJF0M3N/w+c4cdbjcNK/vBytwQD8sQj8wO8tzkadX
X-Gm-Gg: AY/fxX46OgcpGYVbT26ouHrdDGchs2CnNeC5P78knCGxs8WEQf2fo/jw/RU13CRQi/4
	GgBfVs78kHL3tbfwtiFyMuUolFWVvYN7b5EinjVIUoj37Od4u1TaP0LpR/+Fv66RdnqUh3cLBg4
	A/kfi4Q+sZ0Tz7yRPdrPWv+JogkRxpUBi5eOOSUFcttK1FzdaSO48NMWumYp2CddsQLnsXFefqG
	XJjMbeBXH084YLeWr8IRCRA4wAScs65wtlJsWchY5xxlyocLfpGN5QfkuhR3YYHPbvhvQPw1SFK
	cRpfG+q5q5DzEqGu91FgmWCN82Skjjjcrba/Dbh6Z77cW2HikNhW3lG9x8DM7t/0R17Isg8pP2h
	YNH6qP1/DcYmBiUg+Ph6it8lEEdRZrQ7n9OE254OPLYxDW1rhfDhfJvcsmzB2d/JqR/5Bp4dxEp
	DcQ8aR4tCsWd3K/6ZtjsBSjOxJsO8b5KLrkZkj
X-Google-Smtp-Source: AGHT+IHL/LGv+CMc7Aa3WEcuthM9H3wWjuP5N3W1j6YSnYB/gaQ5ezwgwlYCI6teSsVp6Nj4rmVRyg==
X-Received: by 2002:a05:7022:20e:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-1217213da36mr1220170c88.0.1766097052752;
        Thu, 18 Dec 2025 14:30:52 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm1826136c88.17.2025.12.18.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:30:52 -0800 (PST)
Message-ID: <095b18c46cd5654121841cf002a22919776140ec.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 12/13] btf: Add btf_is_sorted to refactor
 the code
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 14:30:51 -0800
In-Reply-To: <20251218113051.455293-13-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-13-dolinux.peng@gmail.com>
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
> Introduce a new helper function to clarify the code and no
> functional changes are introduced.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---

Please squash this patch, there is no need to keep this change separate.

[...]

