Return-Path: <bpf+bounces-29554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65148C2CA0
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 00:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A810B23B27
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0537C146D7D;
	Fri, 10 May 2024 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L897KRD4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36002146D52
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380314; cv=none; b=lJBeYT602jR46a/4sfj7kYCFIdPlapcijddgnIgN/d0HZyOONBq61hfmTF1rNJLVVSjotuHAmK6mNIro0Hy+1IPa6TkmzRR2rKYT5KRKWZRHBjoPkOtON6VEdAbBAx9+xfRv5+TMjTqNT0/YFhnRBRSgZIzcSW5HRtr+43u7DsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380314; c=relaxed/simple;
	bh=vHJ5KCrluJxsTwb+/0KerQqg1YBG5fs5Wl7f/vjPQ9k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=grSMyGsfSdBUer+a5Ojz/qvdUX9qPngXDUKyVdCUuHuaEF9ypi0mpGF7U5Q0jGT0yXirZjm034yEp9ZccRKieRlhzuq/d/UGc0Y6lAFmXdC/ZzT+E6y0r4154LkXXJNE34SLpu0hroCYJv7Uj96OFiHup5bR29jlkXlSRIksx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L897KRD4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecd9a81966so25941545ad.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715380312; x=1715985112; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F+JTppQO+vdz629SI/JdjgM7uWU34EtmrMBtE6dcksU=;
        b=L897KRD4zWWFro8kHdVepf9THpvKUsq/bgxJWgcrYIbY4jyJHkpHkjWy9j+AZ/0z8Z
         1EnF28hjiGF1FE3uMo4sqvy3zHHv+bmiK6lhuoKG699bqlFCgcd8kOElmbXFzfZe5QrP
         TB26XcNHEVVhgxTcHJWQa7xA6D8a7GVDO4AgWH9vWJemzCDnsrgZ+5wxqtEnJ2Drcqx7
         ALlWAczpkrdeQNxFK7EDkTHmuxAvdT4MHOIpk+ctJg2J1W6Tb4/AGou6gzCDO94QQIgr
         ZaVsHXgLsEAH6yp71rdQD7z5GiPaYiWfbuSNH4/k0fpqTc+Bv5ndQUtRCIV6l3kR2btJ
         BcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715380312; x=1715985112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+JTppQO+vdz629SI/JdjgM7uWU34EtmrMBtE6dcksU=;
        b=CW5jwa09ifitO6FhtphibxFUu4BkOHzZXohWkQK7Xt0FUh+NnXA2UPiyJDSm8Xard0
         qdmWM5fU+HA4+4ZlWQpccMV8pawedSITqe/uFIKby4ziKIh7c/kx+Hjwtd0yXfWm9Nlq
         VtK+55X4yWvx2euZFB6X5n3/FALe9nHHo3NDL6t5pM0epAHjykIwDL2eAJzVW4+SdBug
         Z4X/Nk17qp52ItnjURwNVqWf2yMW/yu6GCiUcajXK2ZERsnfUC3BC6qGL3dJEYq9uDQc
         wKQtF/9VEqJLKmWtwrdd4ofMj/9Nab3yy/y6pBqTt4zMqB0RJjVI0SlM0t1iRtZRJcoU
         FC5w==
X-Forwarded-Encrypted: i=1; AJvYcCXGz+gJqeKb5UMf/mB94ZSlAo8Yo3Jx7lO6zTkWnC77GtBS1HD53XXskHtdG3JcEzPWVm+KEk24TJJzznqwziH5LyJa
X-Gm-Message-State: AOJu0YwYMD9ReWAwy/lj5Eo4utCE5QzSUrP9R9U6/+6CXDaEKOYMYnoE
	7pD8bx/icYSNQcLjFBNKIkvd69CEVpGerTvwcmYA7N5Rr958QiC3
X-Google-Smtp-Source: AGHT+IEWrRCIPJueNQ3/u1T7JrKtbjT8e91AORSYU4o9iquLE38CSRfHrjN4H4j7UQ/sMgIWz8fSJg==
X-Received: by 2002:a17:902:bcc1:b0:1e2:bdef:3971 with SMTP id d9443c01a7336-1eefa13a03dmr82771465ad.16.1715380312526;
        Fri, 10 May 2024 15:31:52 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1807sm37382645ad.59.2024.05.10.15.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:31:52 -0700 (PDT)
Message-ID: <a938837ff87adcdebaa58f612395dee06a0ea94a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and
 kptrs in nested struct fields.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
Date: Fri, 10 May 2024 15:31:51 -0700
In-Reply-To: <aa0cb7c8-f057-4f51-84c4-2cc9bc4e2edb@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
	 <20240510011312.1488046-8-thinker.li@gmail.com>
	 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
	 <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
	 <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
	 <aa0cb7c8-f057-4f51-84c4-2cc9bc4e2edb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 15:25 -0700, Kui-Feng Lee wrote:

> > > > Also, in the tests below you check that a pointer to some object co=
uld
> > > > be put into an array at different indexes. Tbh, I find it not very
> > > > interesting if we want to check that offsets are correct.
> > > > Would it be possible to create an array of object kptrs,
> > > > put specific references at specific indexes and somehow check which
> > > > object ended up where? (not necessarily 'bpf_cpumask').
> > >=20
> > > Do you mean checking index in the way like the following code?
> > >=20
> > >    if (array[0] !=3D ref0 || array[1] !=3D ref1 || array[2] !=3D ref2=
 ....)
> > >      return err;
> >=20
> > Probably, but I'd need your help here.
> > There goal is to verify that offsets of __kptr's in the 'info' array
> > had been set correctly. Where is this information is used later on?
> > E.g. I'd like to trigger some action that "touches" __kptr at index N
> > and verify that all others had not been "touched".
> > But this "touch" action has to use offset stored in the 'info'.
>=20
> They are used for verifying the offset of instructions.
> Let's assume we have an array of size 10.
> Then, we have 10 infos with 10 different offsets.
> And, we have a program includes one instruction for each element, 10 in
> total, to access the corresponding element.
> Each instruction has an offset different from others, generated by the=
=20
> compiler. That means the verifier will fail to find an info for some of
> instructions if there is one or more info having wrong offset.

That's a bit depressing, as there would be no way to check if e.g. all
10 refer to the same offset. Is it possible to trigger printing of the
'info.offset' to verifier log? E.g. via some 'illegal' action.

