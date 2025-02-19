Return-Path: <bpf+bounces-51893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B6DA3AF4B
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 03:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C257A3494
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583AC14B08C;
	Wed, 19 Feb 2025 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbM0/gxF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E11805A;
	Wed, 19 Feb 2025 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930933; cv=none; b=HJH6mf3UWSf+jBDJqWPdceFD3+3YsegTVRuIw69TlmIMLWdQL4ydkDYhAw6oi3Rl2cCw0zhrtcD8NBsLjE/CcuMk0kvUAHLCUiA/CQh8EIhIzdOlH2YdRvsdtsJg/ZmAF2RnoOunkSO2ciYIhs4LVIFm/GbM6X6ytEFb5H5BsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930933; c=relaxed/simple;
	bh=9cOy29OvP7ZBEQcBbx/gedji3w0W/Q6u6d79Zx+DtjQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZ/TZtEFX68T6yM7hmzPbfiEH6o5hsWlE2VIYBijkSKj1u+aQ/Fv2NQ7cAxnelaOV/mVypOrSUgCFPXg/BDg6tv0f2BnTkb2dSh4XWckn3nvVYbihScs2kjH53Pd4wSIITOFC7gyvN1w7KzRO71r56rFns9Q1S728AXn8QHET1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbM0/gxF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e6028214so106970095ad.0;
        Tue, 18 Feb 2025 18:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739930932; x=1740535732; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/EdM1s9pztV7IL90sAggP0F5OnbzvPg9nV7vCRuFdoM=;
        b=KbM0/gxFQ+MGp/7ECAVgBI7JB8MZK8ikVXiBhZtzEXTAaMnd26WK3meHWI2+9cDIzp
         AlkHSB6zevk4X92zw9QtCcEe57OOIUgb4HfhwkVhhw8vmi6o59D7oQelonZ+zt+nXgVx
         mKGaYjlAcXeI1D4PPfWHB98vawb2FXzKEUtZhhdt8c5mGRhSFqWWHlX65qYox+uiQwPd
         H69aV8xye0T3kK3SsWQ+NFqlC/mWZf/oB0rl/imnO6nBzUOsz8r9wsA4eM8sR0UIOepT
         fS7u6DlTsUnvPq4Try7fLSHWGxkx/iFpf8cZskGC61Ip7q8z6x/uhU+W/SadtTYqj/1q
         sgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739930932; x=1740535732;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EdM1s9pztV7IL90sAggP0F5OnbzvPg9nV7vCRuFdoM=;
        b=qb9d9/Tnl0TC2ZgJij2wy3oVO9Uqk0hO4yZmCAecDeQ0BTUadoOpkJt4EXm/jUU5J2
         QJXoO1B/I/mtL/EOhMbKXRw53ItLPj4WaoQiQfpvYnBPPwAPomEXQdC7UZoYNSCf4FV0
         PRDKyF+uYZJzc9PbtsFtZBiAL6Lb6nAAub7TcSfkLyZgcgg0OD3vhAETQtJMMpesY+f9
         pZylCFFt6MIJ9QVQ0+yuF2fWlTh/YTCswK+cF7pQRkVNzQLBXGDDo4xxwkHUGQ/bpTFp
         t18StktxAI58nXmfX4OxBoi4BlygTAw2oAnlp7Jx+oTSIOePtdta7nlSnz+ALYaZWZ3Y
         ujzw==
X-Forwarded-Encrypted: i=1; AJvYcCXMo7T4AflWXPr8Jn2sa6zDQr+BtU2rYBQE+lhtz94dZ9PZ+n/7St6kw+EnRtgqvnFU+69JgUDvD3BJ6TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLZbAhODuoyda4wEz9n0yL7y8H0hlFlcz0ZtlPdkOOOjM0emO
	TlPalD6YgNJL4C9d2tRFQralkhOk7lLshT1a5RbCcGtdcRg9vvm3
X-Gm-Gg: ASbGncuoPJeCGJJmUcF++om0Vojz4NiVvuXiznyqNDin41anm/1h/ixMaUgB+xvbO7S
	mCIQUZp2BTFc7mR6y4b2i2mAS97zIpgcN9U382C8pXhEv0RP9h0vOqFehmEYXzlC0L0ALk3SyRW
	U2fYHpbR2vBFBED5k3EftOwZp9LnBl1tuMVtj5DUgcEwtheNB8RpRh3jrlDVvNrTBrFYzPZoi0/
	Sfc8GYrmrP71Fo9kzXh/XGgnDxktpygOYM0L1aQL78NLEmlENUvbdXk71uO7ToKZKV86eS7VsuF
	yw9uz8ci8l+d
X-Google-Smtp-Source: AGHT+IENl5sjDwIpeGCUrJXxldtR+hqwrwPO7KDZSPvnDk0Ndft8HGr1HdZvIfmJyHgGjSu8yEdHSA==
X-Received: by 2002:a17:902:d4cd:b0:221:2f4:5446 with SMTP id d9443c01a7336-22104048145mr268602175ad.25.1739930931844;
        Tue, 18 Feb 2025 18:08:51 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d051sm94103435ad.108.2025.02.18.18.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:08:51 -0800 (PST)
Message-ID: <88f0c25cc981f958e46d51560fbf6db7136a3fa0.camel@gmail.com>
Subject: Re: [PATCH] libbpf: Wrap libbpf API direct err with libbpf_err
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 18:08:46 -0800
In-Reply-To: <20250214141717.26847-1-chen.dylane@gmail.com>
References: <20250214141717.26847-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-14 at 22:17 +0800, Tao Chen wrote:
> Just wrap the direct err with libbpf_err, keep consistency
> with other APIs.
>=20
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---

While at it, I've noticed two more places that need libbpf_err() calls.
Could you please check the following locations:

bpf_map__set_value_size:
  return -EOPNOTSUPP;       tools/lib/bpf/libbpf.c:10309
  return err;               tools/lib/bpf/libbpf.c:10317

?

Other than that, I agree with changes in this patch.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


