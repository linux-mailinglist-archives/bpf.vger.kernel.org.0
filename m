Return-Path: <bpf+bounces-61103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74EDAE0BDD
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B05A34C6
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3223328BA91;
	Thu, 19 Jun 2025 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTcVyWFs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885821C9E1
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750353564; cv=none; b=h19MORDQK1gvQFOxgOwreD9V6hoK2U4yJmyTDnn4qM/CDy6UhmFgxdvQE+lxLBJ4JWo8Yc82zI5rwaXzonllWmaQsUd72KJgp8MEmzR+eE5aBcqvN+BQkJzo2CzMNE4yxGyc5TGfE9aOg/LyXjSw2D17wVUvZRDX1+i4yJYHkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750353564; c=relaxed/simple;
	bh=LaaqiiEL9zYJgHRyozBrVv/dU8/AOpKbhEwvzCYkBgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVqzY50cin3O9D3sTyHycGCpkYvim2H0BpCZcyKf/sfrdmuG6HpvRxsMJPL+J+F8q5znfLMNngz2K3u7Xb7FSOoeBcioBYdvHk1sgLJ5gv+4k+BVOkyGeEjrzUtraXO6N3jY/2iUSN3oPGiIjAe16Jb02VGAlu+bfDTt1sacrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTcVyWFs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fc7506d4so727365b3a.0
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750353563; x=1750958363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LaaqiiEL9zYJgHRyozBrVv/dU8/AOpKbhEwvzCYkBgM=;
        b=jTcVyWFs/aGUlNBfNAiREWKrqVBHyuaJzgk0RctS4FqEoRT+cm9X9CUdX3c4Ol6nAZ
         RjKLm4fUnTNNDGFZEu7rveMYfNurEnx+rWhq6/Dm9raCinf6fVESpfvaf1IXMA3YYvCP
         eEALFXuAVkC3GQ6r52bILIYjRn70PJRBEeUffUuaHDWDHxaB4+HWLQp+0ZFbBknzjXcT
         zlrcyZvBroKJIFPVTnk2c6P2FOuI9tkCM8ztKDsNzTPrt8LLym79DRyfXgzOvxDmqk2O
         YK9rR5gl4vspqRd3M3n5RxvSnYmlZ+vjwWvCCzFIGYyzLOMilAwK3aqtAm+18S3LsBq6
         m9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750353563; x=1750958363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaaqiiEL9zYJgHRyozBrVv/dU8/AOpKbhEwvzCYkBgM=;
        b=DeguoRrAMCpIWPU0X++6lH+n+nxmexKRLlcTLOTQtLxkkisoBaL2kKZJx6gsJb10Zo
         ICquS5Td8/AmTT91phELgzAUf2nTJsUjC5m6ZRulg5IGCql3rXK/+m80eV1Xn2gxbuqa
         PqeaflxphcO2D2F4rbyCb7gOqi2+f5cAuOpz/LDXNFfImM6pXaNStOjd49ucdVUA9DgU
         hy2d6/PQKm3ksIsUBu39pYUF1fxot5F1LZLfGFO7vm6LmkCo/v7DOPn7uo1rIOs1drIV
         cg7wGq/gIJnXuw3mZvSdZ6fzyjznNOzWCAuFXWmqVQADzWfhVbVHyj3CxEeKG2P75RFG
         /xrw==
X-Gm-Message-State: AOJu0YwVKQTrf9NwA8UUWYnBwAtbVsYtwSAjx+h92B0MRWU2TTyv/cub
	g8FFZQggCWbBgj80JcGFrTGHIKXL/UTsb6uuuq5mMh8J/FdHYbhxLSbT
X-Gm-Gg: ASbGnctbyShRzyTzkHYuslQqwY53gwvG5sJpfv4IkGr1StIMT4G+d4G+nDWBccUNDr3
	zem2kd0F5XeF5jFtO8gvb6pCzYyf4EMlZEYULedwnMYr/H76tHLp+B9eXCTqMFnJU1GE3TTPe9J
	2qx9BS4jTGZt0fzx8d/xH+BwpjkwiGw6P6V3mtVUhTPzBVO9zAS/pwVDaLuIDax4lDkErtbuspx
	1YLvEhEQMWwo1KROFKfogm0Tz4IrQL4lXOXy8t0usMh2h1KAYILlgR7G/Ha/l7dZjnj9A3/QgUk
	NbQ93NPWCozsL6pML2cPRqQ1GB6KC88zSvU27h6UsJzDgxPgmIftewbCHA==
X-Google-Smtp-Source: AGHT+IETNlJztDJk0Ua5ORnDgwhzuNM43mUYdTA1uVW5xrRwiarBGkAxN/9FXONnNHyxELxf1qxOYg==
X-Received: by 2002:a05:6a21:99a4:b0:21d:fd1:9be with SMTP id adf61e73a8af0-21fbd57ff13mr33017620637.12.1750353562599;
        Thu, 19 Jun 2025 10:19:22 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a68b0desm248589b3a.150.2025.06.19.10.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 10:19:22 -0700 (PDT)
Message-ID: <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 mykolal@fb.com, 	kernel-team@meta.com
Date: Thu, 19 Jun 2025 10:19:20 -0700
In-Reply-To: <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev>
References: <20250618223310.3684760-1-isolodrai@meta.com>
	 <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
	 <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-19 at 10:09 -0700, Ihor Solodrai wrote:

[...]

> But then, does memset even make sense for xdp/skb buffers?

Why not?

> Maybe -ENOTSUPP is more appropriate?
>=20
> I'd appreciate any hints.

I think Mykyta has kernel/trace/bpf_trace.c:__bpf_dynptr_copy_str() in mind=
.


