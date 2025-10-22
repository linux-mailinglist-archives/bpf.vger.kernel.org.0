Return-Path: <bpf+bounces-71654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488CEBF9832
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 02:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8FA1884D78
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 00:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42C186E58;
	Wed, 22 Oct 2025 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwJCxRdf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958878F51
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093989; cv=none; b=RVsplZWGXIdMC+HB1oDVB5ey0XtqXAJbWbfZGW5qXFfk81cQzVV4ClZd4qrVbyNO2yJOt01EXpstmFZkwhDUixkgoY4KKr8Dm8vIN9+6ACRlLB9CdB6NsQCp3MXhOOktj7I2SnxkSMWhr4T/s23DbUILxhF6oYjqOLbzyYM7cY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093989; c=relaxed/simple;
	bh=lpliMyeA47AzHFtUBa8S6kTNg2528qX79MD4C57/r4U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aq5zxIBhtRoR4gcWlwGUevujJhci3+1P++2dAHbYnpa9fKNdgdkm/4vg0q9ektA/uIGjw6hJqly1GWpDyU7fEg2XY3vl+7swcOa3rGUv8p4owZgkhR2wvs0wQnGxl9FWX133qlcn/V34yeub3ZhDRF9N6yUu8RFMO6OjfVij0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwJCxRdf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b593def09e3so4148036a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761093987; x=1761698787; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lDrHLpskHFMQv92o394xgpom3uvpCYSgWAD3X2geURA=;
        b=GwJCxRdfkEQbtNHENoXOHfeRc2dDzHu8ONWR53ybRjqIE1GdllYd/HzbxswU+XoT31
         Wu+QxDf9EkURcLr2/UA6M3necYkqGppLsT1GOuTbKH7rKOjYO+FITpo4/RqtAM8m175i
         9WVGP14ueqzOYENc8VVaqhmfZYIQEs2Ba7OiBfKqqbxEzSs1M1i1+gxjSa1wEbKcHXFe
         iu+QIjrekJg4dttrZ3wFSE13WjEfkjZFg346b8B+fVWVAvroE+f+gilK5iqdsVGquq0o
         VTcVjfdcbTciHlXcQUxeIrSC1y8/lZZFx9/QZy+L8MrsfoX2aqowFMIN4co2n02eMxcv
         vvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761093987; x=1761698787;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDrHLpskHFMQv92o394xgpom3uvpCYSgWAD3X2geURA=;
        b=IIjBEVE2tc7h2guobUUm4ZSNdUWCxiRjxWoJZcY+y3eX2A+U2TG+01jUZ2Kx8xfOvT
         OtGWN24twOAgTdp8uZBW5OQJ7Pk5EidMwV5Dr6i0ETrefsvJBluEh9LUIqYiFuEqn3kq
         DrmHcDjPDxe00mD1kiM0UkQCYTWoZDx+13OmYXzFjiI7Mv3AeEUUNctHBQa7X++HzKDn
         t7omnDDhbRWshpN1/hm51QTGdp4CqXo5qLJsc99I87ifcK4TjnPX3nZqmLQJKkA6OFIS
         L3yyKf2Q4zUMpxLkdJ+oYtiPVC+rrysiVpbwdsOt7aNmIhNXKdGb9QmHrRL1lyNYtEXM
         DI7A==
X-Forwarded-Encrypted: i=1; AJvYcCWxrrXkPjuGFJPYuOSFaZM/T6WAbwfohocmkt9tvoBPL1Db6aXkkuMs3jzUezUe46sBa9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YykndG7LxRWO7/1ru8hs9VstJ2zEPFINGHV6wIA1koeCIVG+YIR
	HVyw9tCsMWd5uvZQquIzGIRvI4eTyMfg3heEO3F1O651anQzNFD+uHElZAbsD7IG
X-Gm-Gg: ASbGncub1fttxsLeC8MphSGlie0L3oyHHifIPRVCPR9p2IHUMrKGPZv4emMyRs320uZ
	YxftY9Dnb4OSDGd46sJnPsvyUZqMY/LKryY60xb+TO7Zb/YJjx3TYn3adz2Qz7GLGImW2NGQb5k
	SWKV6jvN1D7dJcFrQcijsOk5r0e5Iku79GoUlxnKxNqBfyBqPyJ0czfeFAw02KwwNjI1B8Dr8M0
	QQeBn25/WI2RJ3GmBSndAvTSDvl8OOTJ4vR9fRtXkbDghzm2YEQP6NeezMYjVexTUzVZdB+mv3/
	qmAvvBz09GvbhlvHbw5h6To+ZghF/14zMN9qX5CL/mGnI/7gyZSOteeY/s6ukYzwtrnSApO5/wX
	NEz01ueOWnB6/cEuMEFfZcLkrRKgYNGCxIiNCl8ZKWYtKIb9GFS7nuR3Xhs8cOZkRjEQdHMRnWc
	+6KQEppRWaesbEadOXRUeT9bAl
X-Google-Smtp-Source: AGHT+IEYX5Bqr5pPBiavBwvqvBmfhhX/3I/mL6MI7va0aWpXrKwkZfJd5ieFf7vU3sfan0FPPAzm6w==
X-Received: by 2002:a17:902:f547:b0:24b:164d:4e61 with SMTP id d9443c01a7336-290c9ca2aa2mr245688345ad.13.1761093986811;
        Tue, 21 Oct 2025 17:46:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292b0e4c4ecsm58030225ad.25.2025.10.21.17.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:46:26 -0700 (PDT)
Message-ID: <0edef8990239d06feb90cf2a6574759cf68b975b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 10/10] selftests/bpf: add file dynptr tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 21 Oct 2025 17:46:25 -0700
In-Reply-To: <20251021200334.220542-11-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
	 <20251021200334.220542-11-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 21:03 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing selftests for validating file-backed dynptr works as
> expected.
>  * validate implementation supports dynptr slice and read operations
>  * validate destructors should be paired with initializers
>  * validate sleepable progs can page in.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

