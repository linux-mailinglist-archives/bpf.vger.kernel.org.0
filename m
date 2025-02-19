Return-Path: <bpf+bounces-51907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C92A3B0EE
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 06:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B43188FF6E
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 05:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375A81B0F20;
	Wed, 19 Feb 2025 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiadiTvc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3725760;
	Wed, 19 Feb 2025 05:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943039; cv=none; b=ETHAM0RjJAfUvLpDH6eT0KMrlLpA/+4PG+QaRim2ALPkc9DNl7Zd2GTCt5YMLvDqE05HcAEUHSX4Ve4FC1pG6o4Oos0KZGvMcWr5eA9ic0K28cQZWX2dQJz60TxKYspwl0c01gHAiequLfREzGYNez9a5OeHQmRN6EI/FF3xeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943039; c=relaxed/simple;
	bh=+YNxBThtXKhnNf0Dsgch/tdXWFPaQ6+fd65MXUja50Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mh0do+Vc1KxuIZyRWoGD8uUqzSpKcYCLFFHQ73Dq3lRMMMYMs4K9hIfHvjKW3BGCb7w0zLtZqdV8mKFDdf1tAa/GTjjSoBGQ+1Yy3mSADxA1Gwd2zcXEzMxIXvzGRrtZqKE1trou40JP+n9+me6OIDIAUFV3x/5JZtmKVqkrokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiadiTvc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d39a5627so92439155ad.1;
        Tue, 18 Feb 2025 21:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739943038; x=1740547838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+YNxBThtXKhnNf0Dsgch/tdXWFPaQ6+fd65MXUja50Q=;
        b=BiadiTvcuBN96fal83sBX5wi1Db5bsuoNo0Zip7oHDxyqkuMO3rsEtVR8Lcjcy0TTO
         fnTMYPjlvpWIBaSmf88X1bqkfXJ6qt9opxdI6/4n1ZSMb0/NMRGLvQjK6KtmtJ7pK9wK
         VlbaANh+JaCTZabsnG/3wnhdsqe/JR5RWeTUIMCg/mzIXIQtJdivpZLmC9SzPqySgh4W
         PbSEfnhffiS0bsbSBAmGUu8rZoDG4o4O/VYP5cVPadVG5jElS1atBlsr9whypRu71a81
         Qg4I5/med/C05P3iQdy+gjBkg2ewRGd8nIOtfhb7PQqZnoktfwI+fAXUZP8yVFZ9IFap
         q3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739943038; x=1740547838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+YNxBThtXKhnNf0Dsgch/tdXWFPaQ6+fd65MXUja50Q=;
        b=WAmi05UyVdmf+gcC5aMAmIJJunMenbnhNOpz6n6IMfR+HY9KgmbmH+JgBUhq11GrBY
         RYj+ZOKqIYT/7Q5cwYPCL6gPDlF4cdMJVECTr98J36EIUUuz54JOXNahKZy9QAaNDDeN
         75SSSmDDLOSRhRFyi8YvLdkWtc147Ma90PLmZrYCC8OxN/sMyFOAVccUmsAOdvshN5Eb
         ldHTmEeslAPlzZSH+g1hxi1XG5lVLpTr8YEgx1FIxzW/nUZNKWXAWJzOn3APtgAZqhsY
         Urhu+yqNc6/wYBvpvrJQvyDgpxyWijIwqTqXqpYL9lZSjj7jnuKNsZWRlCqC0hauvyGU
         FE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWw1EvdsggrZFmOaKha7O2RIFqjfR1goRYjm1Sg1MkBRPQtnfm+XxMZrC7UYrwDs86LCokaT9IP6Q==@vger.kernel.org, AJvYcCWyfo6+M8Ud6AXq/6XHra2XNO2EKY/fL9dcTmxljBNqqZTNW0X4lVPnMbAE3enUff5eVb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMCj6tI+M3WtptHadmJK+QCJOjGOiFrxqUIu8KGGVODz/qMSj
	FFfSMDpFgHAM5hYJnmHvjUXvDc6BLEwP5RKvvhiLR+UD7TbpstQ7
X-Gm-Gg: ASbGncvcrAON85gMhHsuLm0PJLzdD1eXFxEBV1Yp9UZroQYpQmbk1tchKEsc9ZTxHLJ
	dD8RZ6VA7FsbyYBxmwqhuElQR4gzr/XuI77eJhgYok7vxO5GYA15BY8reB1s9b0ihKxXuyu7htQ
	UjRRUiZ+I5FC1vyGZHsK8NmUUngnQ4VhH5qatCFGIzpXi9pcAXL9bXf58dtIg89A/dsIDiTJVkh
	1YUtDdyY5wVkVAstnWA2bWKwP+f+Qt5ccik4EreHYedleohzf8sqimhwo6QwewY3Goodp9xtZcG
	9IJpAdcDom3D
X-Google-Smtp-Source: AGHT+IGIDRjENihzv6MJn1PkRHRJz2z9CcHzqcPtxP5JpasaysvHc5dZZo8vYbCKtNlAhMFfruqq5A==
X-Received: by 2002:a05:6a00:198c:b0:730:4598:ddb5 with SMTP id d2e1a72fcca58-7326177622emr27791000b3a.2.1739943037595;
        Tue, 18 Feb 2025 21:30:37 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568a1asm11098509b3a.39.2025.02.18.21.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:30:37 -0800 (PST)
Message-ID: <8daa5d4d88c42316dd0cb27e65dbc443871dabb8.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 3/4] pahole: introduce
 --btf_feature=attributes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, 	mykolal@fb.com, kernel-team@meta.com
Date: Tue, 18 Feb 2025 21:30:32 -0800
In-Reply-To: <20250212201552.1431219-4-ihor.solodrai@linux.dev>
References: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
	 <20250212201552.1431219-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 12:15 -0800, Ihor Solodrai wrote:
> Add a feature flag "attributes" (default: false) controlling whether
> pahole is allowed to generate BTF attributes: type tags and decl tags
> with kind_flag =3D 1.
>=20
> This is necessary for backward compatibility, as BPF verifier does not
> recognize tags with kind_flag =3D 1 prior to (at least) 6.14-rc1 [1].
>=20
> [1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@li=
nux.dev/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


