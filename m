Return-Path: <bpf+bounces-47817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80992A0023C
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 02:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27BA1883E64
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 01:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065F219FC;
	Fri,  3 Jan 2025 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6xrQk/H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C1182;
	Fri,  3 Jan 2025 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735867111; cv=none; b=uyerXG4Gg1U3Myf+Ay+sZWuKcrMs5ldLytNGcqdNiWOcEotiLAM2zqry9Na2ubOIlN6gg9Q9IS7zTOVDhPl82hn5gx5L4nlL4u4tHu8ySTlzYiZ4//6BpZ04fWiutflrc8QHrcEOjntgkZAhGqcJs0TowMuscZThZbW2Spso9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735867111; c=relaxed/simple;
	bh=z5yPHpacrO4HqrfKO4bIWxiOUKas9nJfAyS0TinH5yA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WktZMqIJeo4fSMGdBScY+1MVqOOxa+hDMmSbcwQnm+HCOUzmjcdkV2ibPDv2J9BXa7QjJI49EADTID9KAgZbrH93dgBd1etggc4IJuAnqmxWUK9mTONFGOtax8c6T/Wqq13RFmkV3oDSQpFa+QwxIBbZapTTjmldcNwhP4xBKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6xrQk/H; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166f1e589cso197813885ad.3;
        Thu, 02 Jan 2025 17:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735867109; x=1736471909; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5jxcKUz/U0QZ95Konfxwh++ykBVFTnTZ54qxa7JSr0o=;
        b=b6xrQk/H7B+ldnC59R4sNrLlYFopmezF27+C0dzpShhJtEsZ6+1XGuwrUxkZ/SSBTm
         QdOQyMHVrPoOmvzWxdviTXd5+bjdnE55HLemotR8CmyLLO7ZSxDhxRQNlL7flLX1xf9M
         08mZTmiw6VU7cli8MPVLRPWMWs1g9xUFWdwbSHAcys7ElNADT1r4UZQA0jl5eejr2WSw
         3Q7nTVeHlRIQRI9P5/CHA8pPhKUk6t2VlBPfC5KbcSZJURd55T8iG6zfkr21JHDaNPTk
         V5IkZDDlLmonTSgM2ONwQIgUHWWzw6uEFEdSXp4dZoTcCXpbqfs+T2oEOPP4zUlANDVe
         ethw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735867109; x=1736471909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jxcKUz/U0QZ95Konfxwh++ykBVFTnTZ54qxa7JSr0o=;
        b=GYReA70iGeq21p2vVOZTFS2DQwPzisAFgiRuX5yMgklC8YOynY2yB9z16z2KCISR5z
         Hh/3IOxQX0HXipAI3gHt5kqZU+Mot5Q7KZC9SkopuER9N1HcXDUvRK7bbgP72Gwlkikk
         EUkUDVdwgi1yI4mD5GvQoraMkVt8RZDlCcSoAmYhGRebvm+yE2ht2fENIrYFewJk1vPH
         QYRkXjHlipw1leRxTVky0fpS3/pF8Hyc7sonaiuOkvp4Futuq5Qi71+OqlUwz/ppaTVr
         T5VMng+/YJRGyhf9psXKBv7d803LhA02MimhMtkIZvWjZtrqRs6C4h3RyS2JIbHl+NzE
         3O9g==
X-Forwarded-Encrypted: i=1; AJvYcCUyBYkMEClZ+PumLDP/D8dLicxp8SLRJwbc5v//Yp8ZldwIt20balNLVIhDLOa07oBX2gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNmBojbnH4UkhTXFT0/ZNEksz3tA8y8CPO5OaCXWt1GKaDxhb
	wonK//pueI+9jBcBmxR3qmGym2vVTiCgz/1f2RHrRqZVW2Vdg52Z
X-Gm-Gg: ASbGncsWc13nW+Ma+RrST/PByd8nwQM5mV75b+OJUdF7E+jt5VMRnV91Xw8Ih3IMkYs
	QwEcIa53PbjzLkxPwpDiay0QcGdICyMuh/YrbhI3dqiwovVZPbhIMjTSndV9Jjo2UVtRNQw6v/M
	qkvvxyutpQ9byFbaDHF3AVdoypSoNp+dVt4k6fRAj48pSzG0R9idnVJ/E8FnJcNI/R8/pTJHD7E
	e8bDmQGzsAOHgfEBuuiSd17WfQPgiV1OQlOGE5Tr1Zx0tkwMjzWpw==
X-Google-Smtp-Source: AGHT+IEerXF2Ip3970WsZPlco0slPFILOVKOSnialcdvOPxqRQGpVy5TEYwjCeI6duB1qKQjNH2qAg==
X-Received: by 2002:a05:6a20:12d5:b0:1e0:f05b:e727 with SMTP id adf61e73a8af0-1e5e043f41emr77314921637.2.1735867108779;
        Thu, 02 Jan 2025 17:18:28 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb70sm25103480b3a.98.2025.01.02.17.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:18:28 -0800 (PST)
Message-ID: <19cd9101d5d1564be97c1e3786a32ab2b0f27ca3.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 2/2] tests: verify that pfunct prints
 btf_decl_tags read from BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alan Maguire
	 <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	yonghong.song@linux.dev
Date: Thu, 02 Jan 2025 17:18:23 -0800
In-Reply-To: <Z23HIVBLFmFZ2KFB@x1>
References: <20241211021227.2341735-1-eddyz87@gmail.com>
	 <20241211021227.2341735-2-eddyz87@gmail.com>
	 <e7247151-ad60-402c-a3f8-ce976ea03dc0@oracle.com> <Z23Gmu_ot8svVJnx@x1>
	 <Z23HIVBLFmFZ2KFB@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-26 at 18:14 -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Dec 26, 2024 at 06:11:57PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Dec 12, 2024 at 07:50:57PM +0000, Alan Maguire wrote:
> > > On 11/12/2024 02:12, Eduard Zingerman wrote:
> > > > When using BTF as a source, pfunct should now be able to print
> > > > btf_decl_tags for programs like below:
> > > >=20
> > > >   #define __tag(x) __attribute__((btf_decl_tag(#x)))
> > > >   __tag(a) __tag(b) void foo(void) {}
> > > >=20
> > > > This situation arises after recent kernel changes, where tags 'kfun=
c'
> > > > and 'bpf_fastcall' are added to some functions. To avoid dependency=
 on
> > > > a recent kernel version test this by compiling a small C program us=
ing
> > > > clang with --target=3Dbpf, which would instruct clang to generate .=
BTF
> > > > section.
> > > >=20
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > >=20
> > > nit: the test is great but it would be good to print out a descriptio=
n
> > > even in non-verbose mode; when I run it via ./tests I see
> > >=20
> > >   5: Ok
> > >=20
> > > could we just echo the comment below, i.e.
> > >=20
> > > 5 : Check that pfunct can print btf_decl_tags read from BTF: Ok
> > >=20
> > > ?
>=20
> To clarify, I'm doing as Alan suggests and adding that message when the
> test succeeds.

Sure, thank you.
Sorry, I should have reposted v2 with this small change.


