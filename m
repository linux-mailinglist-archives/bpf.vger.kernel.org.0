Return-Path: <bpf+bounces-38365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD5963B92
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49931282463
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0834B16A931;
	Thu, 29 Aug 2024 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4xPJr1R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671614AD17
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912921; cv=none; b=GAy1PFIZEK/dNuYtKM5qEXp8ikmK05dCAm7UjH47X+/kKtVB0HQpD1LOMtbk+6nb4lR5gY0pYrquwJ/WvLD1fRG6OAkN+HZGbImsLEbq4E2JZpI5N+xTk6Wt05D3qTvawWtZ4bwZp8xZB4j1cGwYY0V21aKOlSvns4gB4FAP2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912921; c=relaxed/simple;
	bh=iXwK71RC+WiJ6tqgkmLFcTxK7PF4LP6JKRUl24yRYBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krN7kr9Mri5mTZoCdmnHo7aa7peB/f1LnFL1bT1YlLIW8lZjpcmhYfZ8WKJuR0MXV7icafxYwK6fVE203EDPj7MInTeCeUTzy2HGlXGnfIxeRcBx55pSK3CIr6me91QJkZyqtGKjdTyv1U4DuVdABWTtzguFLJyxxlRWbY4OFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4xPJr1R; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27026393c12so176279fac.2
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 23:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724912919; x=1725517719; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cvLxHnDvR7iNQfPjVAYpRg0qY22T8jDYhoby3zEX9Dc=;
        b=A4xPJr1RIWFhjY+YhLCJ6n2qzcgHdIVIlDUHzqxSzorX54ltysmJlNZLJXh1lH3MST
         IwhYOTcyHi3uBR2BXRuWgT/u3HwyiinadC1TYIXiKA+2f0DmkSqi68AobXbWqF0kvhZR
         mHb/dTdKohl9Y930/8SRwif8rhO14+QdE5oZwkYILzN06xfkwqxxlwN0BI7D00Jjif+/
         2mEMJH4z3D0wlh/D4wdaykT2ScQgJQO7J3cOvq3/hROm0YUhjTyCeILESfdlnUnlUFdZ
         KfCO/QaC7+aNoumsXdITbr7/BcIO+bZPvTvBUQZ3ntZTiU+QzIXLpphOEMkExCXJ4t/M
         3How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724912919; x=1725517719;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvLxHnDvR7iNQfPjVAYpRg0qY22T8jDYhoby3zEX9Dc=;
        b=UqMkJx6F7rS8iLLEZgei76ziS6Qavx5INsWSL/SFH+Pun0CVilcT4o6d3X986svals
         hlBFfsQqpWP3WE6TZWisdRPLbBdPnzucDYg5j73cOt88IztMNmlr8hQDdQ6lm64kfnlL
         ib99XI98E88EaujxAxE88RWqUbD7QuzgAQrtJ+/KUM+WDyPB2p5eFGURs8kUBW2GZ+Q3
         1lA3yU+tLGW/bKYr9Y60IFxXNj76TB4Lygp80BSdOCzWdqm4Sp/cWTFjn64RVXNgXbvo
         GyaUB5+h6tPH8Co2jkxz76343MTo9qGze9Y4abJJGZ0UlCruFzr080msrFQsErXlmaxw
         yO+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuWONDmjHrIbqMy/35Oy5fVnAIo8I7FBsA0cZBmJJYgZO2+wiY8Gxc8xQlSTl0CBun14Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9pDTEGTksnMT1aFCudtJSGSVV4wZ/VtTxpUKI2fJr+EZh9Nv
	VgdhYknsa9/VjRcbDAQWCWwS84DGtLq7e0sblvBRiTLoX0ZoUkse
X-Google-Smtp-Source: AGHT+IG4/9PZkxvq8FwgDb1XvqThFgI5anF3yJNMXwFMLXYzWt4sndkQoPxt0M8SnBUg0/DMH0ysaQ==
X-Received: by 2002:a05:6870:b296:b0:270:7e7e:3f62 with SMTP id 586e51a60fabf-2779035c264mr2112754fac.47.1724912919155;
        Wed, 28 Aug 2024 23:28:39 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a45e1sm460322b3a.58.2024.08.28.23.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:28:38 -0700 (PDT)
Message-ID: <7e254fb2c9bdb9350d9be5f894e346e5cbf7382c.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 9/9] selftests/bpf: Test epilogue patching
 when the main prog has multiple BPF_EXIT
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 28 Aug 2024 23:28:34 -0700
In-Reply-To: <08bc097d-6e95-4fc9-8899-1c0c69712005@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
	 <20240827194834.1423815-10-martin.lau@linux.dev>
	 <08bc097d-6e95-4fc9-8899-1c0c69712005@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 17:58 -0700, Martin KaFai Lau wrote:

[...]

> > +SEC("struct_ops/test_epilogue_exit")
> > +__naked int test_epilogue_exit(void)
> > +{
> > +	asm volatile (
> > +	"r1 =3D *(u64 *)(r1 +0);"
> > +	"r2 =3D *(u32 *)(r1 +0);"
> > +	"if r2 =3D=3D 0 goto +3;"
> > +	"r0 =3D 0;"
> > +	"*(u32 *)(r1 + 0) =3D 0;"
>=20
> llvm17 cannot take "*(u32 *)(r1 +0) =3D 0".
>=20
> Instead:
>=20
> r3 =3D 0;
> *(u32 *)(r1 + 0) =3D r3;
>=20
> The above solved the llvm17 error:
> https://github.com/kernel-patches/bpf/actions/runs/10586206183/job/293346=
90461
>=20
> However, there is still a zext with s390 that added extra insn and failed=
 the=20
> __xlated check. will try an adjustment in the tests to avoid the zext.

Another option would be to limit archs for the test, e.g. use
__arch_x86_64 and __arch_arm64.


