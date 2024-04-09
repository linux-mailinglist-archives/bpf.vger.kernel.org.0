Return-Path: <bpf+bounces-26255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FE589D397
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 09:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87720284108
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D777D09F;
	Tue,  9 Apr 2024 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsN9e246"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302067C6C5
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649353; cv=none; b=f/GlsRaEx/TvawVcaYrd14myY7c5lAjts5DrhQjO+w1OQLvg8EgT30r5Eh71FtI+AfpLAwPG+zCqGcqkEE5nH78P7h6EOShNrwYTu0yJ+pxjXy1gsadbRgqWJK37eD/z5BKJ6l6/MhKjxGxX06cX0NST0ioR9Dl4p6fMLfLaCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649353; c=relaxed/simple;
	bh=Mi1wOmby5lQfDMvWOtfYTn1SMfaJdCHzJBm6iKOg0CE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O7r4D/97CqBWJG922Kz2teCtkBZpCXBZPEZMWu3P+Osj2tpZXMpe5DkYPJo0KpdGu+XkrrfefwHnm27vHrLteerRTPkmXpY/xMU8xAQ0qhjUwS04plbM7HfRd7wFDFEmkTWcJBwiIunrEYXkC5mWWFT/hUtH0Hgz7d09xuYHfms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsN9e246; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso3322999a12.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712649350; x=1713254150; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mi1wOmby5lQfDMvWOtfYTn1SMfaJdCHzJBm6iKOg0CE=;
        b=HsN9e2466e55frHdNuSvhDdTDEgIivRmxk+hZuY0zVtArNEXjc621co9AEJX1TjDoq
         izjFXaP2oewMnuDQIRVoEnxP92t4qXL7uDqDOox9Kx0RphZJyrfoe9iOTI6L/IQdbWTL
         ini79AlY+ZJ2rooFTqe1a+iRaVwdveSZJWSrz6hQVEVG4Pi3Od4nXQKPwxiDm3dWOTxs
         yqM6iEIOP9I4XB7hUUwIKVueRlvN/fh+dInSZHdbUaPYOqPMqo58lSGdrUKiojEkd+Cs
         oCs2m6IklkDiXcUVNL7gkqSujzgubo56D8yKf1GxY7woz4DGUyAGe1MEJgUcof5XT/FC
         q1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712649350; x=1713254150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mi1wOmby5lQfDMvWOtfYTn1SMfaJdCHzJBm6iKOg0CE=;
        b=xMn4d52p3vx88EIOpZCU7+CASaqbW0w1d2rLP0qr71tptzCKB+CPb2XTEj42m+JS+d
         5em8KxU7HP31nFTY9eOY9rcVd4AxrWlphWWXeXzBH5lzzTmZSUCSUYlCBVDuTDroBgwj
         oB38vyEa/vRP41vQp1qGTDKDpitW31dJQ7/OoCogUahVH+BIHJuP3CB+qCxgBpXhu+9S
         XaJurD4XpxkQd54pdJltkvBuG6tfVstiNDIujvkzm+VaCs4ikixXk13ri1Ot2puKkPgG
         7/NFU1nIsrt5rDMbOAijD+Fwre2y3Pu0nMR0sjZ0CmVpMa/IRxx7hJHEgBU4FE32mP+4
         uE7w==
X-Forwarded-Encrypted: i=1; AJvYcCW895yFgxms3aQXh2PA4Yn+HWeD7+OBQr9GKr76fqJBRT0RS4Kdxd9tRhRbv34G8TLIC1gpq5rv0LLwUcqz8HlPolzF
X-Gm-Message-State: AOJu0YxL5If2ybHZOzj5eMNVPMIY9esDClrVMpNZuuislunRWro4jJjq
	cNUxA1s8CJvUFTkZSJi9cR4oNivrU/1BNMEKQ3h9F7I6odNEy76c
X-Google-Smtp-Source: AGHT+IH2s+s3pWEGWfGxxnKgR8VansM3jmpsyTDV+oPZw1nykDBi50dk/AMht7KFN+xs7Lkb8e0l8A==
X-Received: by 2002:a17:906:e252:b0:a51:fffa:c356 with SMTP id gq18-20020a170906e25200b00a51fffac356mr162433ejb.46.1712649350145;
        Tue, 09 Apr 2024 00:55:50 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id k14-20020a1709063fce00b00a4e8a47107asm5309402ejj.200.2024.04.09.00.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:55:49 -0700 (PDT)
Message-ID: <2c752b345df7bd4a9963611dbfcd0274e9106465.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add some tests with new
 bpf_program__attach_sockmap() APIs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Jakub
 Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Tue, 09 Apr 2024 10:55:48 +0300
In-Reply-To: <20240408152451.4162024-1-yonghong.song@linux.dev>
References: <20240408152425.4160829-1-yonghong.song@linux.dev>
	 <20240408152451.4162024-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 08:24 -0700, Yonghong Song wrote:
> Add a few more tests in sockmap_basic.c and sockmap_listen.c to
> test bpf_link based APIs for SK_MSG and SK_SKB programs.
> Link attach/detach/update are all tested.
>=20
> All tests are passed.
>=20
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


