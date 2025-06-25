Return-Path: <bpf+bounces-61477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50A0AE73C8
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130847A97CE
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922CC45945;
	Wed, 25 Jun 2025 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI5lUz9C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868B38FB0
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750811057; cv=none; b=cnGz8hqJOFZYUyS6OFURTQehUyzZJVVE7b7eHs+0/5vZ74GR3Z9o2cqd3LEprQ6bkC3uCRdgunbKVUA/r/lLAVDLo+5NcBA21+S7eMwCNVAhuLKMFSU2ofPJult7aKa3m8ZtqtkdDDvZhkRB6nMFmYqRL/CMHWB/JcnN+F8Udug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750811057; c=relaxed/simple;
	bh=j3KxswCGUF3LJAwjGw8t5ooLp9BM1zBehCGAXss74D4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqQIDXILDwDv1MZ7ZYGmWpEk9EHUAcme3r6Bxh/fMwwOqp2tpdx6e0oxcGF+5QnrRa2qdFDtUTYlu9dw7rsBGvjxOyU/JW4t/Eb74V+Zs5zaCZf0XOj4VS7ra8tIUffGcyafxEB5bKPoT0jEmy0BtaPwkfGYVCoTNSIQkWF13hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI5lUz9C; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c7a52e97so700035b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750811055; x=1751415855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j3KxswCGUF3LJAwjGw8t5ooLp9BM1zBehCGAXss74D4=;
        b=DI5lUz9C/C/XdH14u3/qzojPrv+h5oFBJrYfFD6LIwA/h1W0dw2aLv+8g5RorVSWMf
         UkEJvjQmwPPbzSdkrajkfzPTptrU7VRAcc0PUXuAAi7a2z5h3nIzwd1JAA0fZ2ij4jM/
         MTuKdExyCWwZY7UmZw/vfdzWS7a59t6rhPts6CsBTnzdgVfJ8iACNErJ57ZxtN3EBTLn
         1BOZGfSBzxfzMQnkG0L/bUbpq4Fl3wje1+t3sGVI21HJtmdjs7BWwgoQIpq/xcqT638E
         CS5XjNBt/cgOgKc4SCJg0S2UNVsWAVBvYzS7G1Ub7zjJuXAA9x4cLmmbA7J0QkXzZUch
         MOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750811055; x=1751415855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3KxswCGUF3LJAwjGw8t5ooLp9BM1zBehCGAXss74D4=;
        b=v+onoJmRETZZ0Ob8tzIITWyKyq4C7yc7nVyZjwLozFych5USMzlrX3HkaCOvXYyk49
         D+oVCkzOqu8gN2OELgrCjmundeL/MagVZw6ZlZlvzZPy3mGFJoLlps3K5PJAiuG93MzD
         dfKE7JBYRyQpZaN7TDyt3bVBmjl4Us9B3Zwsp+yncoP3stiNtB3GOp6h4fRQrFvX3X7M
         BDq1x7afKV3jXIumlg5ggs8ocyh+CkzJ+ROn4OuNacbTL0MFqZLxRw5gQ6bmRYPYf2Gn
         InGMjrCE6/fDEFh1fFblRtQ4ns+CHJnC0A4tAjWVK0+IDGWw/hDFR6tbM1P/YTxrqhX+
         iSOg==
X-Gm-Message-State: AOJu0YwHYEKxIJuXQZ48Z8oZ3g2/j8OdFcR8rh1cHh27isx9eoMR8HAh
	Ejylb3/ypXwOu4UB9QmkVaUK1Dco9P+mnevDnvGP2q/Z+3N0kxX0TcN6
X-Gm-Gg: ASbGncv8ubVw/BviUnmjP1r76nZhnivmrbfAlnwkEgatlZ/gsbbL48+V4UkPW0kMNZ6
	83GuU7cOMZq/ey7kAwTvYzP0VyZV27PY8vWCJVXFLlmJJacB2hVXc7BwTfG2RW1QUfwfmOrf8Ta
	SKBscFLHhY+IKGp4FG+g2p5U0T6TCXVJwfMfcmtbv4OSsU2nrqmPHaRZ3RGbtzfz/NAMaQP+j+C
	GZF21/0YTJkS4txqtaL3X9uAdwXNmvXDxrQlrrZGCzNO6zGBs1DmkSfMa4Ut62zuSi9I4xjKWsE
	5SkpUTcDcMMt+JxW0m7xWaOOduLfXrZPGHPtfEEH+OXKQabg5AOGDqY5lm5s/GoSJxGodsip0UW
	kSIYA8RJlPA==
X-Google-Smtp-Source: AGHT+IEnBQx8XvrHlOY9zqB4sKOoLtqNeVD+rTfB3wnBk93JU7UD0DE3GCoT7kiVfQ18R0tgktrjvw==
X-Received: by 2002:a05:6a20:7347:b0:21a:d503:f47c with SMTP id adf61e73a8af0-2207f2a22aamr1409614637.28.1750811054876;
        Tue, 24 Jun 2025 17:24:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f11ac8eesm11455526a12.34.2025.06.24.17.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:24:14 -0700 (PDT)
Message-ID: <64802dbb21f9e5c8834be3725cda68db9c6a1963.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: allow void* cast using
 bpf_rdonly_cast()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Date: Tue, 24 Jun 2025 17:24:13 -0700
In-Reply-To: <CAADnVQ+1h49trJcsobzPN=YnnbsaidJi98vMeGeBKpxh-nV2Hw@mail.gmail.com>
References: <20250625000520.2700423-1-eddyz87@gmail.com>
	 <20250625000520.2700423-3-eddyz87@gmail.com>
	 <CAADnVQ+OjowmcVdYkAR-VLZUWNbvkG=i78gV4-76YdFJL2DJ6Q@mail.gmail.com>
	 <63fa058d2be2c91cd8c2835ee7d88b745dad2849.camel@gmail.com>
	 <CAADnVQ+1h49trJcsobzPN=YnnbsaidJi98vMeGeBKpxh-nV2Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 17:21 -0700, Alexei Starovoitov wrote:

[...]

> I mean to add " =3D 123," to actual features, so when they're
> backported the number stays the same.
> Not to __MAX_BPF_FEAT.
>=20
> I doubt it matters though,
> since bpf progs suppose to use
> bpf_core_enum_value_exists(enum bpf_features, name)
> that doesn't care about the actual id.
>=20
> In bpf helpers we got burned by broken backports and added
> constants to ___BPF_FUNC_MAPPER macro.
> Here I don't see it ever matter.
> Just like I don't think __MAX_BPF_FEAT is needed,
> but if we follow old steps, then let's do both __MAX_BPF_FEAT
> without number and every feature with the number.
> The end result will look like bpf_link_type.

Understood, thank you, will respin.

