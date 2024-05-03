Return-Path: <bpf+bounces-28531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5588BB230
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5972814E2
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67D1586C2;
	Fri,  3 May 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bggLyUzF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D181514C2
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759848; cv=none; b=BaBWj2TTTZ8Lc2MjGvuoKYYvT6ztc4USGBoukWKyCvTnRCZYJQIw5efzq+I/Ack6qkJTlB5s0eZualOghhnjk0qaD3UYyO2brT+sheIAu8Zxy0LSRnXvnKoUE22drIeXoqm1dm0t0inm5qLE9jVgsFgUGsjCVG2ZsdsWux3kE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759848; c=relaxed/simple;
	bh=rC15Eonyuc1jcimaNB2Cu8/SMm8+puaY+okhAV08Feg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=exsPsGgOh+tMSppj0+EoFk6EgNwegCT23E1FP3EXSob6Ppw23Iz3LPPRseWTOs7vyYlQrk8yUJirFFar8Rgks2PsQ0/EssiGkRruKJ1WYrL9VWWeO67+vAyoqZLKuWiFsoXI4EVparoAA5AP0pYbHCgC4w4k52HWtkRSkzb2yuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bggLyUzF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ed41eb3382so6554495ad.0
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714759846; x=1715364646; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oB99JpRsj1l3VMW2lLKM8caMBxb7ADjnB29jYj28ZmY=;
        b=bggLyUzF041nPx3cw+Ena86VWviyBCL6GlYhbjuFEQmOaVaQPcuZ2JLCRmiQBX6Lhk
         gvN/mMh/qWBqMjnVRvRASkAC/t4yWkJuwo0CrtitMPUgXDCQTGHmJNTGnhMSt2m6Miu4
         3f4sIvVNFj9vjNytvLbf/6qdO/iXBKFJXJMcey+AYxCOvgI7L+oWyLLNDkuiZlzg76kr
         df9nC4VLYbNER60E0yZ7nHQ694FMFTGCpU3CL3OZlmygKx6OQzaN8rYGjyitEPSFpPBz
         oi4zZ+wzoZ/S5275ROMM2R7D9wbrnhwWdXKUpdxxpeI62BH8YRNVcJsJD6t/7IwOscUV
         9kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714759846; x=1715364646;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oB99JpRsj1l3VMW2lLKM8caMBxb7ADjnB29jYj28ZmY=;
        b=MIWncmJerSPTJQ1veYflqpfKGNFcpMdGr8/g59j8RKgjamu+aAyyE9yiW4q7E1lKyh
         KAmVK5noYZ6zLD89OnVGjo2/T4SIHv9igCHX79aCPS81WwzVThuLKdyi/M17Vx5iEblB
         s2YE81U97X1Zko+ATD0YWriU2NeG/G1+B28mpth7ye9dsLcr6+2l3oUFcBpbiumlb/U3
         kb48Zk9FQY275BSOR+/jnfiH2NsJk3nioR1Y8mKbm/QXaPm8Kg4LGzEiIk8U0VcaSmgl
         qgYSwxs1xjiNB99xAmYPSj6ZpIg+SdEjXBd5q2KQj4XTu7BKTE48T++k+yMf499OrIne
         OnPA==
X-Forwarded-Encrypted: i=1; AJvYcCUqfn3psVhwMHn3H1xjJswUqRKSofUXEWBC5ek7eE5NoHT3zF+VDo+dsXkZZywRTnYSehTdeSsN7pFC8zo4gNlUHlgZ
X-Gm-Message-State: AOJu0YwBVAFRtF4ACnBT1xBqscJ2tAYyK4mPtK5N4C+s2NjsdMJBM/Pg
	Jwn/uvByvno3axqA2QiOq+/9AZ4YJeCET+9stmYeD7UXfdCMmapj
X-Google-Smtp-Source: AGHT+IHi6SoTC7g1Tvta+4srR4Ldehmm3X84eWQqvrAoB+Cudba5GRVb65ivl6pMdim7KVrrxH3+AA==
X-Received: by 2002:a17:902:ed04:b0:1e6:68d0:d6c9 with SMTP id b4-20020a170902ed0400b001e668d0d6c9mr3226713pld.40.1714759846255;
        Fri, 03 May 2024 11:10:46 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:da47:6959:81c7:8b0? ([2604:3d08:6979:1160:da47:6959:81c7:8b0])
        by smtp.gmail.com with ESMTPSA id lg6-20020a170902fb8600b001eb7823164esm3527794plb.279.2024.05.03.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:10:45 -0700 (PDT)
Message-ID: <30444d73030ade8610674428dce0e0978e537768.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] bpf: create repeated fields for arrays.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
Date: Fri, 03 May 2024 11:10:44 -0700
In-Reply-To: <0fba228d-ee81-4aee-901f-c60dfd53c102@gmail.com>
References: <20240501204729.484085-1-thinker.li@gmail.com>
	 <20240501204729.484085-4-thinker.li@gmail.com>
	 <017ecee002197526aa5d91d856c25510d36b57ce.camel@gmail.com>
	 <0fba228d-ee81-4aee-901f-c60dfd53c102@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-03 at 11:02 -0700, Kui-Feng Lee wrote:

[...]

> > > @@ -3624,9 +3690,14 @@ static int btf_find_datasec_var(const struct b=
tf *btf, const struct btf_type *t,
> > >  =20
> > >   		if (ret =3D=3D BTF_FIELD_IGNORE)
> > >   			continue;
> > > -		if (idx >=3D info_cnt)
> > > +		if (idx + nelems > info_cnt)
> > >   			return -E2BIG;
> >=20
> > Nit: This is bounded by BTF_FIELDS_MAX which has value of 11,
> >       would that be enough?
>=20
> So far, no one has complained it yet!
> But, some one will reach the limit in future.
> If people want a flexible length, I will solve it in a follow-up.
> WDYT?

Sure, follow-up works.
Just that 11 is not much for an array.
I think sched_ext is the only user for this feature at the moment,
so you are in the best position to judge which size is appropriate.

