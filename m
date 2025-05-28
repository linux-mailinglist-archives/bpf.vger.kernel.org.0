Return-Path: <bpf+bounces-59083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927BAC6008
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784E43AED30
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450D1E834F;
	Wed, 28 May 2025 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0vwD/5X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0D78F3B
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402632; cv=none; b=omTVzQ9m3t6tKZ3cZ4yx2rtBFFz3o3FsO3Lq/aZUTHtQ38EIxSW3yE6E9pPQ2MeGRUqDCHhLXUj0rQaYb3IXgRuuplycxkXnP6PMcu8sz/h/m21YgzCLk+iObujJ78NK+MCnDD2hhaGzJxSkaCfuaAHsV9ioMYneqnjeXSJ80ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402632; c=relaxed/simple;
	bh=vqO+Pm/HwIo5j2bH5VUANxqKXpi6ZB2hEzbeH28UmWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgezMzoPXDlAwWe3gbKXp9NR3zsC8PE0eZj21WRVCBCL5X4QNBxcTNIv8slgfywuIsK+BRC1SguhS5blO8Fn81Gj/UptW1ibIF2/bOJ7TY07CnmsRdl2U8iIgxDk6yHEWw2b37JHYHv6uyDThGnyKWHsyJWKvGVWzCDGXUc8hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0vwD/5X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2349068ebc7so135795ad.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402629; x=1749007429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqO+Pm/HwIo5j2bH5VUANxqKXpi6ZB2hEzbeH28UmWo=;
        b=p0vwD/5XFh5llZYeWqF0PTmm2GwywM3CMo5XuibxGx4z5aBU+feF/KYJw7NsnDeLKK
         Q8ySWDV47zStZCcEkuEjvESRXvcFONuczH+Q5Hh1E8UB4mmMUR7Pbi+pRz1/3lLIg0+A
         mrls/9KvgpIOVPva4ETMsqimq0vZCy332ZaY5METQoTcARwUV90jGo9o8h6jxtBk4rLO
         9bpRLtFTPoeFFbBPc27xnmUpcJoiqKJXU6vJwcjxcsLQChvcKJzCzVBN/smFSZYqdO/Z
         NEUQChhzzsoPCxSSHexqktR1BvduQAIcTgGSIXCHGOU1qGxdJkC9hDQrOAqo+/qz13rj
         7ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402629; x=1749007429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqO+Pm/HwIo5j2bH5VUANxqKXpi6ZB2hEzbeH28UmWo=;
        b=EOWgX2mZXVOZQs50lgjDl8wKGdXOl4ILdEzJPFrqk/DkApMJ+apDSQZTolhTS7x9fJ
         ULHHuY8lpNp2JVwgn9/00FDAlvwiU2BjDmVGBSuez3+Fa/NORo6Nq1x6FO4J/G+Bbvto
         TK/bDxBl3pBypmsX0svzGrdviqePJIDdBJ1jJryz0ssY3jKf/sqe532sStaxzxFgXPQM
         JwIqZmRM4lUKBEgu/DdE5ivKAyfXMZrn6V/XCJISjEoyq8ahs7Yq1TQcHpVJZtU5IAyg
         PV8MLqQ9D/ujlk2oGIWqkBMN4hXF+y0LN6FcBoIkhuMcv/VEHtmTrExQVAe+6XgoyxN+
         W6+g==
X-Forwarded-Encrypted: i=1; AJvYcCV5xhJAGkch6LFf98vuGSyQSRaQVPwthF8yWeHjMewDvgPy7rVcp1NKl83S2Re6XsTKt2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBc5ONYjGauvkSv6elUpzT0eau7Jm/iKqadvZTJ+Ln/Wl1xXZ
	iSegd9+KEUvTt9JhfO2i/K2xbT9c6N/cwdeV/RNHQfv3NAZhP0dIiKCUZqZhZlgDV4Tn5pSJbOK
	AwoWp6dzWc2jTWcKk5UfXfutQEdkuAbw8DN302chc
X-Gm-Gg: ASbGncsdLM0Svu7KIVBaauYduNY/O6Bw6+BmhG0mv5S0RS93+TzjNuZxqMXrkf25+ZC
	9BZcKLzyr97iL090l9qfdt3s6S8CkI2OMZ2FO+ZY5607ayiIEpRM6SdLkvikzTX2ueoODaX9o/k
	McefQV2GB6iDUQQ28T6dJIHnht22BrEMhLtAmaj1nqz26u
X-Google-Smtp-Source: AGHT+IHrCaCboVb+mYd6VODPHySRh2UlXAVZ/QOay+nn+pjpJ//L1jegP3WSxBTh/9vzWlfdXpQUzy+19mVRhyBPxn0=
X-Received: by 2002:a17:903:1b63:b0:21f:2ded:bfc5 with SMTP id
 d9443c01a7336-234c55ab5aamr1578395ad.28.1748402629057; Tue, 27 May 2025
 20:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-11-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-11-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:23:35 -0700
X-Gm-Features: AX0GCFsppSqNuMrfRURYgwM0eiForkoo7rTRScW8zc9A7vZ7d83h17DCjG3kLl0
Message-ID: <CAHS8izMWhqJacD2UKJWGOEFoqcSbeaiEYkkQsiHPKkCNwnOmHw@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] page_pool: rename __page_pool_alloc_pages_slow()
 to __page_pool_alloc_netmems_slow()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
> struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

