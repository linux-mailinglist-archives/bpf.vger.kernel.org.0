Return-Path: <bpf+bounces-70235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ECDBB5031
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 21:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DD11C558F
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 19:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2227A927;
	Thu,  2 Oct 2025 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuNW8ot6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BF22758F
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433724; cv=none; b=gh9g4PM5DCTq7HQLjz6nzTHazXEkoIcH7E+IYom/2IEU8JaQ7x5uKpdmpgnqmoY/UabXV9heLpW5W+BDx8Y+NdT1fR6CFPTZaM3MH8vMrEkgxSSkLxMCkx+t5hnSWwrvb1H3cwiOhK4nZ3/PNm3RWt7TJOizR04AbQ9v48whnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433724; c=relaxed/simple;
	bh=9OEzJ65bN19aNh0msL4CUi36Lm+zTtpOcJhtBuIdnZo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfKat5BB2mAw+7dN+Ze8yuIBkISHYiSg+Ez6p4X68WxUSkG5Q/HkuUd+Xm6UnCI9IX5SbaxqCYSvK9hlsboXbgeZ89fguBlydq8IU47/nSQ7DwGwA4rPc7WOlTEyREv4jdtYhCnq8u4Uxqb5hmCnmaAjkSHvrzCBIhkEbcVeJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuNW8ot6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso1082242b3a.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759433722; x=1760038522; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4laTfGmP/qi7Ht72qOZldBjobpH78ukswa+QZjM1YuI=;
        b=QuNW8ot6PgAuka3CJiNSGBg3FjgeEGJz2UaOBMamNzGHQw2msRwWqFbb3hNqFYJC8G
         gTWYJrZd3LzhdG2YZZBvLAl+T0iEW6K9YWoKySqMD/9UkyOT2Iyg3U3EMQMhBKcyme/k
         K0EH8UqrIAb0bKMwm4Ed6b6hRWDQ2/5VXX8anLYCWpZyOCcybPf9BxlbQ68MSeiAi2lz
         xRUoEWD+kRyg7bK9ZC+LsLiBvIHdZKelycj1+QZv8SzdvBZ0bOsP6aTQEr9gSjMWP3jc
         OC/2NJQibiOTOmnZ10mOCNm9atZBmKhlzXvZpL/p7EKJGrI9ofHKS05wserUwrCKCjfo
         wgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759433722; x=1760038522;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4laTfGmP/qi7Ht72qOZldBjobpH78ukswa+QZjM1YuI=;
        b=ujtTdD3I079q5nOc/txt334MWYeQ3wxIvu5VUoeQ1SZDVszjmL8J9WnoPWXP3//Wke
         fWlk2br2SdWgHTA5NvKqlpNrV/vRsKEMgLNmReBYWB6TOybRhIzXYB+dOBsUcEVvd1YB
         snhCGhMBkYdrJsE8OhATQ2OMAxdOiNd7J0vZusIL4QrJT3Zo0RARebjwhfHHauocNtYs
         i/x/f3bUctnWocGPgX4OTFLB+3dSOolgvJsGw/UJLE0Yj4Ww9bwfGJ5ErJzCHbpl5kbi
         wEPJg65mF0cQnJfgDOSpYPmqTxHyhv01OnphVVX1U6lub2i0kCZQyyVrft+bSitp05cZ
         X1SQ==
X-Gm-Message-State: AOJu0Yyzvjd8Rw4Y5R/INOKyQ7mMBV0V+bdp+gkFlNdK6TpDFh1oCii5
	Mf0b+k6jACZUIqe/FpDx8Yqta3JBZqU0TUUvOp6MWCEluC0J9zJRnOD3
X-Gm-Gg: ASbGncsFFhJYrunaG8/PMfHqNBRfhYolMbE3FMYqV/T5kiabOOd0w43495XDedaRgIP
	rkpd859A/Hef0n+YwTonhuQKYJA+aDOYBa2rPz4Wuf6AoNwSogPj2hY1bx61p0NPE4iFXPqJLnM
	Fse23ecfCnlNTuFDIc0BW362JtSYa6UA/HDGAXaMPS69eARfK9wNmEVN8k+huFUiSTrxoPdDXWI
	/4wV5WtpS7MrqrYcoMbBC3Rez6RQbwBUBDlhpdoKsL+QPpg8JNkXwnoC2DKeobUHEzgkBk+oq7I
	yTIuuEw1UunDVHefWla/IMGrPXEXqAKn+JipvYN/4zLhQLDCfw63/Nc5PttnS1QpvP3PTXYV6ZZ
	ySMhdRC+vh+VWpHTPMfzoiKwUehrkghLF42bXVhflciDG
X-Google-Smtp-Source: AGHT+IEqWHl27v7/fDa71zcKumWG2kLtQY2qgI2Hmwd5E7eAby42hTVQqiZM91lQDzGyg+5T1YVLbA==
X-Received: by 2002:a05:6a20:12d6:b0:24b:1a6d:298b with SMTP id adf61e73a8af0-32b6209c8c3mr745481637.34.1759433722299;
        Thu, 02 Oct 2025 12:35:22 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b81760e58sm1089685b3a.24.2025.10.02.12.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 12:35:18 -0700 (PDT)
Message-ID: <adc12deb1253a607f44ec732fb34f85af46cd5a6.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 09/15] bpf: make bpf_insn_successors to
 return a pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 02 Oct 2025 12:35:15 -0700
In-Reply-To: <aN40ya0mv5Rp8F/v@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-10-a.s.protopopov@gmail.com>
	 <eddce884140f3df9e6c3c7e1b873a570b163ce1d.camel@gmail.com>
	 <aN40ya0mv5Rp8F/v@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 08:16 +0000, Anton Protopopov wrote:

[...]

> > > +/*
> > > + * An array of BPF instructions.
> > > + * Primary usage: return value of bpf_insn_successors.
> > > + */
> > > +struct bpf_iarray {
> > > +	int off_cnt;
> > > +	u32 off[];
> > > +};
> > > +
> >=20
> > Tbh, the names `off` and `off_cnt` are a bit strange in context of
> > instruction successors.
>=20
> insn_offsets / insn_offset_cnt?

Idk, this is a generic u32 array wrapper, so I'd name these items/cnt.
If you don't like that, lets stick with off/off_cnt, as these are short.

[...]

