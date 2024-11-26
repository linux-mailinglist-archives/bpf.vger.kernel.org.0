Return-Path: <bpf+bounces-45630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043D9D9C99
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19B4167DCD
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C081DB372;
	Tue, 26 Nov 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk31YEI0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B01D6DB1;
	Tue, 26 Nov 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642356; cv=none; b=nOhcvUVC6TWA8jjRVlPqbAIzw9wU10xoBPHz9A+Ess3gvMkWRfedimbqCmfssBFlt+89Qnezlj/DlFX+VsNcGpBppTz7DkMlGWioCE1pgEDzj+xWythfXN1sieNQX3VNWgbOwF8HUa/9fDMFAmTHGg1VvaZVEE0qnbdTnFTnIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642356; c=relaxed/simple;
	bh=x/JsoJydVI/aDMpHnkDtFlMhInO/9sxMRx6mm9Pcpwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azOVjC7MrYnf6oG3CJO2ppsXWABoLBd8yqSQ9Vd6Qp0lZOAum178i+EfCJt2izuEsCRNAhBoOlcpAUWXZjspMSc3Lq+LGlwJy/zxb6gzUyQwSHkdcQNCAvghxJ9hx8QE3UL2L1jZFvueu8OsKsyOomeUFRWJBP4c3gtRnqUmR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nk31YEI0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-212348d391cso56983535ad.2;
        Tue, 26 Nov 2024 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732642354; x=1733247154; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SqKw1ouWNDgAluBu7GXNoP3d9/kyqinVguFG6XhvfoM=;
        b=nk31YEI0rOl+id6L2lf7WZ73LettsSKrLOgZh1UJi35ANmrFZz0nq9ELCw/YA3hvza
         yZQmcRybdrjrrLDtNX7ApmOQDwf0qPLo9jjIY3wa85iPlY/t3+ChTr4h32fK1xdSB7Dm
         dL5qigQ7ePCYV3pQEZsQaa1qUzhLaRnVRcndejDKRd7o+cTzYdbaWYtiphiKsiDcCo0b
         WTbQzRIKLN7waoD2b+XSOC6BPHlv12xI87dTItzkpde10u/WMliy1lSkO3x6KiL8XFLr
         bhf9B0PYkAPF3GZs/0N8z7R8JDYDwyJElixga3dofjo1AkZQKaEmSJnAzC0KZd/fiDHR
         C9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732642354; x=1733247154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqKw1ouWNDgAluBu7GXNoP3d9/kyqinVguFG6XhvfoM=;
        b=UY/wi91/MPGynlFP8Pc/81XbnBQX+BjvZ6M10LUSHz7ObLvRAkTaCzkboBPKPvMsEI
         bycoESRi5Hk+dh6DVIP2gYNML+y3+GEOMM2evPjRGyBitKljk8STwqzDNdat+4DUhlAd
         CtcETRiUFFWOP8jNpL/5TOzF/DGVXtiiYTPv/LfMkycvyt6ubFrwjWcjEQ72PJrofHwk
         zqj7gjCoFsn3rjjkrO+gukxbDdZizZgFaQPoIGWpFub8vpw4sukXu21/xgon7rVTagH8
         u9S6HmG3KQsDvNJtD8ODKL2K4eqZduTwmnDMKxA7vIoeDyzbKSIQEF+siI3iWjBGPrQX
         G8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVtEHD56j3ppLfniXs27FMjW52gldqm04LjXGOhLiEbDq/tR3Yqf/Y2W5SjbbfL7lbkjsy1ZnHlPA==@vger.kernel.org, AJvYcCX4HYVCKZ+UoNjwNBJb4RpZSJjvmoTTvhKLZ+/Nvo7Xn6XVwqJnVeA3wTOMrAJfIM60eys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNs5O9a9ejJtV0lj/vyYLwQKcfhxOvuuxCDRnkIBLgseXOSlW
	xjfCE727cWBJM3rN/DdPj6TsjUc5v7qAZTCa416OOO7GXiuWf1Mk
X-Gm-Gg: ASbGncst/eiapIjTd7HhNn+7q6HhZRgemfl2jvzrd2n7YJ/dwEkLbD6bymrbS7CDn8W
	pTSH/zewjln0HSkWKHuJCqCfF3sZGw9ocdbC1vBr/r7WzgKBmBMNu4atiiEx/iXjFu4D1M0fj6J
	ec23jqK0l+oth7qE3zdxnkCvURFG5//I2W8NV4ve25XxKiKflZGMvnla+GyW5fgG8UqVFhHa/rM
	QViBdaXUoQU1rSJ0O0I+LTJj2PoctqA2oxwb0ENfSNpLuA=
X-Google-Smtp-Source: AGHT+IGZQKS5COfBHhCV7jMiAM8NCZ6xHQd0/fjS9MbJz2m+W3z3UzAZcHIWT45L68cWPKu4SXfL5Q==
X-Received: by 2002:a17:902:f682:b0:210:f706:dc4b with SMTP id d9443c01a7336-2150109af63mr192245ad.13.1732642354159;
        Tue, 26 Nov 2024 09:32:34 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2aad7sm87447545ad.279.2024.11.26.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:32:33 -0800 (PST)
Message-ID: <b2e5cb3b1478d6900f126d4de223500d6be4c97d.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/1] btf_encoder: handle .BTF_ids section
 endianness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, dwarves@vger.kernel.org, 
	arnaldo.melo@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com,
 ast@kernel.org, 	daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, Alan Maguire	 <alan.maguire@oracle.com>, Daniel Xu
 <dxu@dxuuu.xyz>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Vadim
 Fedorenko <vadfed@meta.com>, Vadim Fedorenko	 <vadim.fedorenko@linux.dev>
Date: Tue, 26 Nov 2024 09:32:28 -0800
In-Reply-To: <Z0X2YnMyzNlZyQtP@x1>
References: <20241122214431.292196-1-eddyz87@gmail.com>
	 <20241122214431.292196-2-eddyz87@gmail.com> <Z0HXqLswziDAjNrk@krava>
	 <Z0X2YnMyzNlZyQtP@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-26 at 13:25 -0300, Arnaldo Carvalho de Melo wrote:

[...]

Hi Arnaldo,

> I think I saw instructions in one of the messages in this thread to get
> hold of a vmlinux for s390 and test it. Right?

Yes, in cover letter. Full vmlinux is not needed, a vmlinux binary for
s390 would be sufficient for testing. Repeating the recipe for convenience:

  To reproduce the bug:
  - follow the instructions in [0] to build an s390 vmlinux;
  - generate BTF requesting declaration tags for kfuncs:
    $ pahole --btf_features_strict=3Ddecl_tag_kfuncs,decl_tag \
             --btf_encode_detached=3Dtest.btf vmlinux
  - observe that no kfuncs are generated:
    $ bpftool btf dump file test.btf format c | grep __ksym

[0] https://docs.kernel.org/bpf/s390.html

> One extra question: this solves the BTF encoder case, the loader already
> supported loading BTF from a different endianness, right? Lemme
> check.
>=20
> cus__load_btf()
>   cu->little_endian =3D btf__endianness(btf) =3D=3D BTF_LITTLE_ENDIAN;
>=20
> enum btf_endianness btf__endianness(const struct btf *btf)
> {
>         if (is_host_big_endian())
>                 return btf->swapped_endian ? BTF_LITTLE_ENDIAN : BTF_BIG_=
ENDIAN;
>         else
>                 return btf->swapped_endian ? BTF_BIG_ENDIAN : BTF_LITTLE_=
ENDIAN;
> }

I can switch to is_host_big_endian() instead of `BYTE_ORDER` macro
if you think that's better.

> So we have parts of BTF byte swapping happening in libbpf and with this
> patch, parts of it done in pahole, have you tought about doing this in
> libbpf instead?

BTF id lists handling is currently not a part of libbpf.

Thanks,
Eduard


