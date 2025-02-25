Return-Path: <bpf+bounces-52566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE3A44AC2
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 19:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002BC3BE680
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1E140E3C;
	Tue, 25 Feb 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COlcqOY8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA319AD90
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508526; cv=none; b=UtBxMc56M5V1IlGSZmlTTmSC7fqYcTCUxAG/fybl5xfchnIAgG+JpipRo73euLWjqEBzERl/8pZYDgntQ44hD0C/7U6m9y4JP9YsRg/0ToevSu/k9l44w9UuDX9QQARB47CoZ9BnnFpYpYmQNwd0OiGf/IMCDthEbY4poD/ZEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508526; c=relaxed/simple;
	bh=W8m5MRc3Px1cvdc2w85DmWymy0XRT4cehafLIHwHz14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOgix6tQDc+06sjYpLbeSk1TAJXxD7D+5exujH+8k1tWwrNILTEUT81kS7eCUAw/2JY7scBl5f6K/rdl8wPJkXeuIV1lqH+9PLfIOvFtdV3i1tfMzszs7TCpsDIydChDx3DOXBLa0q9RWvGzoBZCXrMb3esPDlWtDO1suDbzdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COlcqOY8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2211cd4463cso121969295ad.2
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740508524; x=1741113324; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gh19GdKibxMUNgOj7+4ajRpIsJuUQNwik7bOXyIqgis=;
        b=COlcqOY8KiQLpFNJUhr5vjz0kqtaW1pTKYwrxCnxIgsumzCVi6ErQ0jhPQt0Gyh1pG
         zDLgv1BtvRrhKJqq45QuatenoLNOsSlgAFZyEdbnb8hm2C8sr+BNRnzfo08o9zO5Ahku
         T1Od14w0ccnIfAAmLZOV3oGBAsUoz79Fy+/n+g1/5aCuH3T1X5eoTKh0qPtXDl5DaUI8
         Zg8JBIYAou+0lUiLkkUg1JLGOyq7Mqzv00qA8EUf6pdptF6i44l6kB0RjJCu62wp+Z5i
         8vNjlaHR6BlbZrE9/W470nNaTccWjGHl0fcvSz3bBH1M3rXiEj3gexp3hHSU0EjbWRrM
         8e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740508524; x=1741113324;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gh19GdKibxMUNgOj7+4ajRpIsJuUQNwik7bOXyIqgis=;
        b=TXNG10q/Tmp/CHMiIxZFHkzGGTE4ezONeCQviy48UXQu4FOtG9Vf58GvS1qsSFkrvf
         Z0BJsm3VlBFxk2DsAcuw92P0ZKFycAU/8mG6/dHZ30bIC5Ot/MZkQfTDh754zumi0Qfp
         ds/ZaAsgYCehPB48GeUmE8HgF/jEVhFRjaXZBMP6hvL8LSuMLxzZUqjYJ98EEUJ9Xit2
         8Ab4YRLJOPtPnRJFADo3EknoWoO8fU28L7eh2WBpgu3KKxwh5avQAndFNzCRjmyVATrd
         CKfPlI/TUb6lZBP4aK8KFzAugGUXJ49cmGm+V/uJbXFSXkMY5d+GuD37DzMP5/HtL3Uu
         dTTg==
X-Gm-Message-State: AOJu0Yz7SjUHzbSp6hb2rRcLHuUccU048LsUJKg7alPlBeRceBq8sjXt
	/LihmOTaDLEaawM4OeWTQd9w8+IKgQRcI9V6uW/1yy6xPbznZ4MiN/U/jw==
X-Gm-Gg: ASbGncsy0aERK6cORdo1RefEWlK65/69kbbr+ugAhDmyRsKS6UYzt2kvMGjtqRMEdNH
	tJGoFXcxZZv/JhI47C/pULqqpwFahU5V2eROrXLWzGZlDRO3XpZhIuxYP9C8rD2W2H7PqkkltJz
	dPRRG57+aW6mE93pk7Nxel6hvz8T9aA5t7nn0YjC+d3zmTMTxo9NuNQsFoUnKNbl/MEEHID4UIV
	uWOzYo3+bxp3SkjPTkzupi99KK/hcjuDaEqYH6kGoiB1GqRSGJzxYkcGFOfzeTxc/nYMUfTPBbA
	6ECo/sR7CWIL38QIOziWII4=
X-Google-Smtp-Source: AGHT+IGFfzhL8vSkiUdObikq9ziIQLsH7dUDBPxrzXsV6hjCY1X6F1UPPrvkIVFlASzqDdypC9f5ew==
X-Received: by 2002:a17:903:191:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-22307b4bd13mr65594795ad.12.1740508524301;
        Tue, 25 Feb 2025 10:35:24 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0007dcsm17711055ad.1.2025.02.25.10.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:35:23 -0800 (PST)
Message-ID: <e7c836f169930381942deb5d0d4c7e42fcb95423.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] selftests/bpf: implement setting global
 variables in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	kafai@meta.com, kernel-team@meta.com, Mykyta
 Yatsenko <yatsenko@meta.com>
Date: Tue, 25 Feb 2025 10:35:19 -0800
In-Reply-To: <CAEf4Bza=-MJc8wAcG6_i9OOQEFs09OaAnEi1v5pFEntmFxTquA@mail.gmail.com>
References: <20250221223259.677471-1-mykyta.yatsenko5@gmail.com>
	 <20250221223259.677471-2-mykyta.yatsenko5@gmail.com>
	 <CAEf4Bza=-MJc8wAcG6_i9OOQEFs09OaAnEi1v5pFEntmFxTquA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 16:38 -0800, Andrii Nakryiko wrote:

[...]

> > +       } else if (*val =3D=3D '-' || isdigit(*val)) {
>=20
> instead of doing this detection based on characters, why not try to
> parse a number (and I'd use sscanf("%lli") which will handle 1234 and
> 0x1234 transparently)? And you can use %n to check that all characters
> were parsed (i.e., you have exact match)
>=20
> it's probably fine for starters, but it kind of sucks that 0x1234
> isn't supported

(Nit: {strtoull,strtoll}(val, NULL, 0) supports decimal and hexadecimal not=
ations).

[...]


