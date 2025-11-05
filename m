Return-Path: <bpf+bounces-73698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 086EEC37A3E
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A56E4E4B3B
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B81126C02;
	Wed,  5 Nov 2025 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nisTt9wn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD2257AD1
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373409; cv=none; b=rx8VXWsTShWNhLgA6xERVc5t9jyh9h8b0vdR3mgZkclRfrA19/9FiW/I2f6uCYBlSjrNJndC6kpG6Fdxsq0kOnhWATKiZBE5Y+2oULMGKomJrtSTGdbA3Yx8XMuAlgh+MUuOHFHM3YVdNeQ0JpuqR0EhaarUTOxIi+h5BFvZBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373409; c=relaxed/simple;
	bh=HSG3yyTFGMqKZ0cSpvp51BJAnBQZN+IrjtCtx86iIwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvGu+YkiGTjeHXDnAJYpPGmN1pOJJtI0B7RHPJRoXNpHDxyesMU2pqV42AV1/Rfrp0GOyIJXdpDB2JfFriOzPUPnC+YLe9tC/lPpHyqW1Y7rPmsQL7vdxTX8Io6UhKYxsNQWu6peAGtF/jfh7df1VmrRnr1kAdWYtuzHsHJkq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nisTt9wn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso301258a12.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373405; x=1762978205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4NT9lfKj/E3SYNd0qsKIwheb3jqENbhsmTvnBecBgc=;
        b=nisTt9wn2idwgKa5Df6ru5yUqzjabLX7FHRsv1kOORBZr617oY4epWIOrfvR8VATWz
         hkR5fkJz3/W0Quy5CMsqDJ75PVvungyRe+hFWUt6YOvPEYeYBo0H9S3sCV+tkzH2/OWZ
         1OComI8lBK1QLiLJBNaliVSlNslSjgvysN7Yxqucmj+bblWyze8kAR7u20ycyZunkc5u
         jdtCXGALEjHKTgf7NWPgg0AGoUeTPR26RZgkRrSwEz6MDaFTDxB8ZTejgE1qr7sXlMDQ
         FGh69ILAyMf4GCFm4tyjgOCj4gBFAXs0Bq3vABJE24UO2b2XbD+mgFrkLmsHOMkfkKG7
         Fn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373405; x=1762978205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4NT9lfKj/E3SYNd0qsKIwheb3jqENbhsmTvnBecBgc=;
        b=TpuIPftl5FineOobi4SaDmjpQgBrqNJYBrzt4KGgcsEpZycNSWELmDsUgeHVOlxQNP
         K68vs2+qUOVNA2nHtzZ8mEH3YA/6VrkBaI4xKLcCwE3HKQjcFK+t3RaUH/FkAA5bVOcz
         /FRHtGA9zOSJIH69PJwJy0p+csjnBywyO1zYumKsl1xV1o628Hmaetd3g/3/lNvmL/O/
         yYShfCbqDTNsqrswxB7XqirGnh8o8d/+TxNulbo6kr6DPWSPfJ2oM11V1dYNaDh9xRIm
         QAeaTDoU6ZdBCoUq4eTM4g10KBz2aS2ASKdd8wBd2cgoBByHsHJSzkCnKw6mN1fhquZ+
         KAXA==
X-Gm-Message-State: AOJu0YwwQRZHwByvf0YuPW0GDFLDjy48Iv5lkVujecPEX7c2/Revvf38
	zDCewVsoD1Ir4TGgSy+51U9wGCOTBqLz5P7lM7Md3dxrnG+4hyssDyql
X-Gm-Gg: ASbGncsHGiqptdcGcL5BIgjfRzowlVtYvZtMmaN1XiyOtFW4Lj3FVI2vPc9NAzOQh8D
	tFkMR2ZjEHt3v3hKgE+IJ7VBVZE8wPWv2GOEN8ShCeFazwfdjgf9rgaaMLwZPX/Yra+O4fV/YP1
	6OdVrvxj+t7lyFhLo8++g9xx4NRnKtd1auz8Y3ZKsXVIFRyPJierojpneES/9ov9bh/JEZjUqSY
	IocqQ8mBfRaxt79USc4rHvpU/NY/xqAq9ZSpM3Jr83Z07vCikwv55aP7WTWcKxTWiDkh+gLVhAB
	Jb/WeaHAww868mzRHOIsBkUB2MdalMMxmQWInqvN74nGJ4jzHBrgdtXE7CSqJo/EAhI0I3t/ehr
	33l+11ExTQCp8cAXhqYZ8+zejctNZXaT4L8YFXkS2bTbDS2eS4mjqTOBTrTvYXnGYeiiYD6uTW2
	Hx9ygBq1gUu9jyPV14vDyo
X-Google-Smtp-Source: AGHT+IEk6eVlS5EUL7/Zv1RjS+NHqmXJv1LzNSgjfljYFl7OqvviBTF7ItzvE1saKfX+2F31gbdYCQ==
X-Received: by 2002:a05:6402:51d1:b0:63c:2d72:56e3 with SMTP id 4fb4d7f45d1cf-64105a5d549mr3926212a12.23.1762373405381;
        Wed, 05 Nov 2025 12:10:05 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578ecsm27846a12.19.2025.11.05.12.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:04 -0800 (PST)
Date: Wed, 5 Nov 2025 20:16:17 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v11 bpf-next 08/12] bpf, x86: add support for indirect
 jumps
Message-ID: <aQuwkcGMI4yXYDTV@mail.gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <20251105090410.1250500-9-a.s.protopopov@gmail.com>
 <aQszqAyqdQZMlt3p@mail.gmail.com>
 <7fa1213c-68b6-450c-b69f-1e8c9eac5250@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa1213c-68b6-450c-b69f-1e8c9eac5250@linux.dev>

On 25/11/05 09:45AM, Ihor Solodrai wrote:
> On 11/5/25 3:23 AM, Anton Protopopov wrote:
> > On 25/11/05 09:04AM, Anton Protopopov wrote:
> >> Add support for a new instruction
> >> [...]
> > 
> > Interestingly, AI review is stuck with "Setting up Claude Code..."
> > on this and libbpf patches of this series. Robot got tired? :-)
> 
> Robot got tired indeed.
> 
> Could be network issues during setup. Happens on CI.
> 
> Let me try restarting stuck jobs.

Thanks!

