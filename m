Return-Path: <bpf+bounces-41018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFA99910E3
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CC11F22EEA
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200911ADFF7;
	Fri,  4 Oct 2024 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqZMa0fP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB231339B1
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075131; cv=none; b=npUBtt46+W0h0Zw0IdYq07B9TgKwbaZYukztEhIXfmwQGXQUz+4OfNklz+Hb9PCjerHAWK+9VZQs7rbwv/K3dyIzPJczf737iJKcSNqNIwdL38SGDhe7xQSAzZetBw3ZkEbfpu/lPKpMZ6xJ0jn5YSQFetN6RJnmM1WCUtut6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075131; c=relaxed/simple;
	bh=2mwI+cpW++bi36DJhtyWYNUvMNIVaFPeLVbEFgI72t4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RuIi785iXwfKc3y6pQSS0doqiKFXT+HbGWMq3K5VLuyzyzpMcTL2sdUpaMdOlgUnF6Kz3uGCRzpoB3C2MsA6EC3oy6+gYlIJhh6hn7QS0E4td/rS3SmnhOKtxAWv7fH3ECQdShEnP+aUerd9iCG+mDVWDWKGCaaI6YPvXgbWb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqZMa0fP; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-710d5d9aac1so1242611a34.3
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728075129; x=1728679929; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2mwI+cpW++bi36DJhtyWYNUvMNIVaFPeLVbEFgI72t4=;
        b=UqZMa0fPXSLZseJq0SpRKn+E6uHvuSnveJ9rJl961+i/nhnLJiNo4EcqgMqTp6Bj5j
         965Zpt7NxygvDyhjCMNub0YM1KSuL4YeVyOrWG0Kc00ytrFS0+60E/iWzEjPiTgTHcbj
         IYeT7f0fhmVLE2oETIw5SM64+VFPmF9EpRbGz59Lar1fPffBIrQeAKM+UT6ZipX5PH6H
         h8ZmQNZXcMxKtrIqiy6nIA0fJsJlLTCBpoMTtizb0+Wk9ngTvJZRE/ep6Rg09cbqiidd
         L++UCYG+rLrhBsWYBdN+4A4PEveGLLtM0UELuPMoUYvpUJeBjYJIu+RAOtiXBTVgsc39
         hkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075129; x=1728679929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mwI+cpW++bi36DJhtyWYNUvMNIVaFPeLVbEFgI72t4=;
        b=WdQ9tZfYA8mDr856hLpevl1HxxBZa+o+KLO+GSKAd8NAzSC8sTKgr+SG1UAkuo6e2A
         MA1wPRG8NWq9jb9IR6NpBsb5CQz8koLxUf9ncNN7ZxZecrnueB6+ZsKcVUAqXZZq0hZz
         EcfPy8rsmrnp9p2PR1mrm6dqPUi3+i0FyYs/3JhIIe1u+r8VD/jpdmK/4zAAL0vlySJc
         hnGhtNUJpLLK4/N8Gss27BZ3LTpB1p6kddjK8EArbzjo+nWg8k0JTQ/Ox9yem3ht/tA+
         7WcAbIS2deSGAkS61hdS7r095+J54Q7JUbL9iYkMYC25tQkrb14dZYJ8lFjQNrPdBbSR
         sZvw==
X-Forwarded-Encrypted: i=1; AJvYcCVk/XabxVIp6w68dKILDQLLVEi3thwEy170YCeO+AGg0NJnkUAvHjaFkNou5HQwEo3D1QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfSalROjnVBLMBy0GAc+zvRVIWaKKX2+BWJGL+Ro4P3GQOW03
	fzBUQu9N/dqdKGbaYgwSxV/dak3Yn3bHjEVMUYmkZDt28CWj9mzj
X-Google-Smtp-Source: AGHT+IHbbuVII5ehSKJZ+Uli2xqv916bqSjEUfbIazEzM3mlmgytFpRfv9nyloXA7psjztNVLNlGmQ==
X-Received: by 2002:a05:6830:6781:b0:713:cc30:87a0 with SMTP id 46e09a7af769-7154e83a6e9mr3921775a34.17.1728075129213;
        Fri, 04 Oct 2024 13:52:09 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f682c801sm419029a12.39.2024.10.04.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 13:52:08 -0700 (PDT)
Message-ID: <3d2ba1d054d73c53b205559ad5d89cef78d89303.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Prevent extending tail callee prog
 with freplace prog
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Leon Hwang
	 <hffilwlqm@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Puranjay
 Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>,  kernel-patches-bot@fb.com
Date: Fri, 04 Oct 2024 13:52:04 -0700
In-Reply-To: <CAADnVQL_VUJCFH6TuHMLesafY8iQ-4xBkiTdfEMqr02C_G6T=w@mail.gmail.com>
References: <20240929132757.79826-1-leon.hwang@linux.dev>
	 <20240929132757.79826-3-leon.hwang@linux.dev>
	 <378aa2d5-6359-4e89-a228-7ea47ba563c3@gmail.com>
	 <CAADnVQL_VUJCFH6TuHMLesafY8iQ-4xBkiTdfEMqr02C_G6T=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-04 at 12:33 -0700, Alexei Starovoitov wrote:

[...]

> btw the whole thing can be done with a single atomic64_t:
> - set it to 1 at the start then
>=20
> - prog_fd_array_get_ptr() will do
> atomic64_inc_not_zero
>=20
> - prog_fd_array_put_ptr() will do
> atomic64_add_unless(,-1, 1)
>=20
> - freplace attach will do
> cmpxchg(,1,0)
>=20
> so 1 - initial state
> 2,3,.. - prog in prog_array
> 0 - prog was extended.
>=20
> If =3D=3D 0 -> cannot add to prog_array
> if > 1 -> cannot freplace.

I think this should work, because we no longer need to jungle two values.
I kinda like it.

[...]


