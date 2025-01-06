Return-Path: <bpf+bounces-48032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE28A0335B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 00:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B8B1882EA2
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DBE1E1C30;
	Mon,  6 Jan 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0P+SLzU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5A1D95B3
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736206539; cv=none; b=V5JrYv1SbuTygIdf9nDElGjidhH2x/UMCSgXmoFidxZQrZ+VT8xAjv+h7SOM3lbU56K13Bnl+CVk2ZUGYxR9mc/ami91oS6vL31GuF94nWDxkteOjrj2kdAVQU4SGFetCIwTBSGnavP7Qpr9CjDIfyUjmYQjKzqA5+KfwSbl1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736206539; c=relaxed/simple;
	bh=EHeTcLiUS/xouHwE7LJjXjxZZ/Km2mcfj+lUldhiE98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9eoULHdrA0ZAwA2dtgPx/TrxoUdQEicOf7FBEGbZnYF0OsaQ0UUbjNumwnFOUW4FokSM4YfjTYHBZOA7Z+L2ORZkV3PKRBFKLDr6ZurNE7bQC078mkC5/cUSnoCJba5vvJ1clwUnIaME0mHqLcIegjpKz+MgTCNIcCgT82OhzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0P+SLzU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166f1e589cso262686355ad.3
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 15:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736206538; x=1736811338; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EHeTcLiUS/xouHwE7LJjXjxZZ/Km2mcfj+lUldhiE98=;
        b=E0P+SLzUIQ7euoa3W2xiazYb0TJTDyQR+K6pukATpBmItYM32Y0Y5AgsntTU8MqkpY
         w3TtcqVBcmPlEtLWCpOS96xq4Fm6V+tzYuIX5xQ9CMDkiMEXsvYBSkZ2k9ZAinERo3Fi
         DFMFmjIIP7SzKs4y8YjbPzYRVDV3BBrz8OteecH/N7kKIFRG/Q9nZmfXZsdjg9cN8cfE
         63UY75wAYZd8JsjeYU6AIIlqc/zHeKi3Yi4mtUPc1Y3jhG9VymDfM9mkwoU22TYbqLyt
         JxPSezyHNFpt/PK1bi9LZcsWyvOVJxdM0vpp6lOovayh8ZT1h6NnaEuUlAo2U8SbGBR8
         U0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736206538; x=1736811338;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHeTcLiUS/xouHwE7LJjXjxZZ/Km2mcfj+lUldhiE98=;
        b=eJaGHvVHDEkX0KZO9FNDyZsQgbJpeqGnq8CYsA+vwHsb+TA7u/8yYhru/4LIn1U6y0
         dfvRD3nL2duwwjJ/e0rfCVtYPVWCaNNdg4lvKsVQVZvYEj4hwJwsHhazRSBWBgoED15Y
         lIyJJJr1euuCJpEVaHsF3iPDa/pio61IBvBWTgjOgfrFvEDEY9aflfmusqbDXtXmsmDS
         VTadqloIDGxcIldgqg6U0APqMW6c3+ZPRi21GIwdOE/g7hcypYDEohU7lYAq25V4gP+A
         giLOwshccBtJLBksr4UHEMeqMRLeE9VdFKMNCAkML2vlCtOFa/v5pWHbNQc3S8tdjYU8
         +Hkw==
X-Gm-Message-State: AOJu0YyJk1tnfzq5vstjkG5iqD1weNIsgMdNKcouIKhCSweo62Hj2Ejl
	6rfHXdhRk2pZv8CKmizTqULaCbwUugH5NTDt6a9YqS8HbCVyBqxQ
X-Gm-Gg: ASbGnctabdHLfN78E2cG4g0UV3DoAW1uiySqhUmwtv/WYjoOgqlmuvIRIjl6Pr8IPIX
	Mo1NWRn5mqDfkkdAdj2at+YBCFIFFBCIgrST4NJ1qWFA6DTCB158dCOW4lOnpwiqjV/VAfI9/Wp
	1rLZrCk1SBZp8yztimZhyFMCS9etJ0vRrK4JTLyRyLK6HlnwDXYhn57Etutl+iQL5eyFG8sXkEf
	6/F11p25q/X//S/U6gWRzwgf1ErcJCw+yQuWJ+42pKdNSAo3PwG7Q==
X-Google-Smtp-Source: AGHT+IGnx4+1l1VCAFhpUZq70yF5vlCqu2E4yx4bTPy4soK0DC6AoL7BJRfbAMC3nFnNc4enQA5GQA==
X-Received: by 2002:a17:902:ebc6:b0:20b:a6f5:2768 with SMTP id d9443c01a7336-219e6e8c8f6mr935288205ad.10.1736206537762;
        Mon, 06 Jan 2025 15:35:37 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde2csm298516065ad.156.2025.01.06.15.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 15:35:36 -0800 (PST)
Message-ID: <d7f52423797aca03acdbed9c17cf837ad799abb9.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add -std=gnu17 to GCC BPF build
 rule
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	mykolal@fb.com, jose.marchesi@oracle.com
Date: Mon, 06 Jan 2025 15:35:32 -0800
In-Reply-To: <EzSHGqsyeIGPaYpD8_zHxcl5KM6qQ0EwkmfgQUbU2tw6ZsmbzujDtGiNGIkUwwLchJlM6wKc9m3_Qn4cGL1J67VXzE3-RN9F7hp9Dy4pVpA=@pm.me>
References: <20250106202715.1232864-1-ihor.solodrai@pm.me>
	 <a621a6f62a3e2b30966a5f84be483f0fb6e9061a.camel@gmail.com>
	 <EzSHGqsyeIGPaYpD8_zHxcl5KM6qQ0EwkmfgQUbU2tw6ZsmbzujDtGiNGIkUwwLchJlM6wKc9m3_Qn4cGL1J67VXzE3-RN9F7hp9Dy4pVpA=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-06 at 23:18 +0000, Ihor Solodrai wrote:
> On Monday, January 6th, 2025 at 1:16 PM, Eduard Zingerman <eddyz87@gmail.=
com> wrote:
>=20
> >=20
> > [...]
> >=20
> >=20
> > From previous discussion it looks like it's better to just enable some =
-std option for both gcc and clang.
> > Kernel is compiled with -std=3Dgnu11.
>=20
> Do you mean that eventually clang is going to make C23 the default too?
> Yeah, considering this it's a good idea to specify the standard explicitl=
y.

Yes.

> I am not sure what's the best choice though. If the tests compile current=
ly
> with gnu17, maybe we can leave it at that, and not fall back to gnu11?

Based on my local testing gnu11 works and that's what kernel uses,
so I'd stick with that.

[...]


