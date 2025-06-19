Return-Path: <bpf+bounces-61110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD19AE0CCB
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 20:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5726A2200
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E6294A12;
	Thu, 19 Jun 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Y2+oqg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29702E62AF
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356795; cv=none; b=K0w7jwHb9zvsxJ2DAQ+vqktemqvjZseOELaaEmtiiAlYK6c/YZcjcF6WJNmzqG8cxTtDNzOZtzxgMWJO+IX3fPPuRfhD3pzfTqTubW42DLndaIF5sOA1MgjRR1ji+HiXmu5S95FCBCdCaJcZZabDN+xiHpZOpeCPKGDSvqfmZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356795; c=relaxed/simple;
	bh=+0dCH9OIss3ql91eaNcFEo8C9M0UVYntKC1SDLVzLXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWH6CnalmJXyFS3Reoj0LwSqSNhdtlPuTT5CquO0myHrWYuFhSOD2I6nuvBIgNviLOK3YSJ3XPg6ZFR1ENYOi4v13VKvaCRHChdTNMLD87ASuvQxJ9k8jb28sbOp5j9yeHsgRMLEwnSwBRRHU2uILmiiBWS/fcCRJBp8mYTXrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0Y2+oqg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235ef62066eso13283025ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750356793; x=1750961593; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0dCH9OIss3ql91eaNcFEo8C9M0UVYntKC1SDLVzLXg=;
        b=R0Y2+oqgBZYiHJ3pveMy1E9rMadgn5P7ZqhffPNkJErv4j1Ww+m1pubbu9xs0+hudH
         1YvuI/eR9qWk5sk0zFRjGZe9qNTFzHQvIBM5ZQSZnFTq8KQeTh/oVt8DHrQcfQ/mdWCT
         foFhX3jshRTa0th5p2cxWYmyTkup9SVLER3QkeF7kbj8FPWMXe6jV4GigpGY82SCzMv1
         4j8Uzo9e4v9f/8aQrYuKnc724msHOCHcGqdP5jq4wqC26RwIRpTscSouBGPbBRV4wh0b
         lVCB9DIevHE71ZVoW9Rm26eXy6vFajcZfIJapDAOYfin/fdp/P+fvZ7oWkx4aPpzd+bm
         LXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750356793; x=1750961593;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0dCH9OIss3ql91eaNcFEo8C9M0UVYntKC1SDLVzLXg=;
        b=qvq0/kUqFy22lcK1zxJZCBjQWaiFL+AoVSzDR21fL59SqYhPu577xLVJjzCX7+fLRo
         QzeLG+RL1XM8PZ89B0Ye/XJr5WJBue3mVo7whT/jhn4o/nN7GHuhetAQfXLUWQAym8Ns
         eRwcIRNSK+NoB2G/jQ7QmIWOZkCa9PC7Ymu36ucIvX4aHWx89DSYru/debf/9CUxR6nG
         quWUZJM6mAzWF5fgVVUTpnJ3lU6p2wu4o+lxY/DTt5zb7pOHzsatEg/aRN17faSfZ/oZ
         lqk65l2etWkwJLocMy3f0lZPcB2Cc/IDb6+xZ/WjL0WrvmHRU2BnQsjFjgD7i4Mi9mrA
         +07A==
X-Gm-Message-State: AOJu0Yxu7CaZ/0f5m3qA1mnixIGupfAuUyodS/wFbgUFV96HSybS81g4
	Ron2yk4XaTdZRdBq4Im13oZnTaPsx9IBet9qrL+qDH1YsRheUHQisqL8
X-Gm-Gg: ASbGnctCvUlgP4d0P//IDtezzdsdrHuYMyOHDAjMzcmt7UHR6DF3bLni8Hjg6L1NrKr
	NvJivSEIkLjQFG1Sp/FUCmoqH6zrIPrz8ijMnbRFV1RChWhYNrCXTQYdx+ADWdo30+moNcv6D3X
	K6ZYyIQ7I8XBBZxfGUgz6ItlEEp6SRNM/tybne+Ih+Gb4QIZAxnXqhWzuJFUajMD1pxcdmWBrRA
	wvY+i8Xvvvl62Kdmh0sYYJB9EHtylgTTTl5T5xMrbByMRrSH7PhX+dvlF7Jowrfna+gfaSMkT1D
	3O5ALghllvFU51x7VfMvbdrwmE5QWbWXxF+XajdL1a7yplgrY81rf11C4Azuu8RIvub9
X-Google-Smtp-Source: AGHT+IGxDKae4/vtbT8FRYnyr6ZyhuFWXYXoUlNqm4MIGMQPKqdlfIHnLLlRdzR/DYu/YFkLh/E27w==
X-Received: by 2002:a17:90a:d888:b0:313:23ed:701 with SMTP id 98e67ed59e1d1-3159d618a7cmr336886a91.4.1750356793247;
        Thu, 19 Jun 2025 11:13:13 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df93ae4sm3970a91.22.2025.06.19.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 11:13:12 -0700 (PDT)
Message-ID: <51cbadb3cabbb0b2479e5087618e1015c25b4f26.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 mykolal@fb.com, 	kernel-team@meta.com
Date: Thu, 19 Jun 2025 11:13:10 -0700
In-Reply-To: <c8540b80-2903-4e31-a4ee-93278475d232@linux.dev>
References: <20250618223310.3684760-1-isolodrai@meta.com>
	 <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
	 <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev>
	 <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
	 <7e7e4056-e2b8-41a5-a6b2-a2fbe0a94f4c@linux.dev>
	 <50c2f252620107b6fa6642e281a91db444b032c5.camel@gmail.com>
	 <c8540b80-2903-4e31-a4ee-93278475d232@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-19 at 11:04 -0700, Ihor Solodrai wrote:

[...]

> It should be possible to walk through fragments like
> net/core/filter.c:bpf_xdp_copy_buf does.
>=20
> Any reasons it's a bad idea?
>=20

You can do that as well.

Also, what's the plan if you'd like to memset only a fragment of the
memory pointed-to by dynptr?


