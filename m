Return-Path: <bpf+bounces-59076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A5AC5FE9
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4817F4A380E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2A1E8322;
	Wed, 28 May 2025 03:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnbfP11N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB71A7253
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402178; cv=none; b=XpuK9lmy8ncbVESB+ChANhdgSHg6lnI+gYTEjSR+hTFP9eg/PyF75dTOiUjox0ClNAaeuDGL+EGfCiPPVfwhYAbc+hB28C0tlxeaKoZqENG38DInkkqwd1oE3SFh97ErOAM4MqqF7wukX21nK8wwNXLvgWMENDRHfwHcpNQM6j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402178; c=relaxed/simple;
	bh=0bdtpndwZMuDSr/xS0AhTKAcuII2GsnyUAe5k1Utuqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsKeTOzkmKW03VCghtfNhXoqGMGDjYrWKDUY0i7aRATseuIQ+D+/JCOeL1YVxWUeebcmLsrKyphBJjlGMmJDPmrs1qybUTvjYYo9LeJEsskr3SILLKF05Pu3hycf1HOEaDCt25thXgRmcwhb/4zHOhJDm5CfZww1V9F3p6gOXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnbfP11N; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231ba6da557so80645ad.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402175; x=1749006975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bdtpndwZMuDSr/xS0AhTKAcuII2GsnyUAe5k1Utuqo=;
        b=pnbfP11NPQBkIarbw0bv5nZdtf5tIu1Hgy9LFF0tcTIG4Ddky2BuBRbmRqjkggpzNU
         X9LoRi4J2pJRQy6Ymj83eBvcdEh1fLI9xel3M1d/KdIBEqWJFeccOP3vL+MpStwgEEjj
         rWq1uI2CwKoKD0IalwGeIBuhFot4jgq9qVu7N4sYrfUwcNKtC229un9ocw9diQqyAdz3
         qriyP0oPIPu5tyLSGxtrLxosl3mybzLMSWP5Ba19qAb63I8+nRc4X27ztH3ZRDYndCcR
         qLhN4RMDMepzE0JGVqEfXZ1gPJ5ZUtN9TxHAPbNFXtx4+/VK2ATOqK3xD+2fb3dt9XxN
         eumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402175; x=1749006975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bdtpndwZMuDSr/xS0AhTKAcuII2GsnyUAe5k1Utuqo=;
        b=sriFVmbJhZmxFAvKRbDqBXPtY/3y3Gt1+sI5s6TdA/ap6/HTRcAPwRT4hXTnPA46J5
         xTEEwgqgyi2DcBbqZEIIoEmzyoRpOumFSy9SfK4XTQUSHF3uN7gkVsuAxGFoHrpp67em
         G/MCxO5FAGpD7ax5VWd5dekQiq9OAVJZYjVphklSs8rIDUZwUwZm4/vF4ceKtqHC7Iru
         duugpKejIWV8VaN1h1ICI0Aeh8aWIcuEoFZDvFNt11QI6CRQiLS65TxyAFy8yXXQui2X
         Qor2M2/G/DPm491jydZwRJ5+u6zMOJrIibGsslX+mGW8+EwHECF9mIY7f0BySReY0NT1
         cEGA==
X-Forwarded-Encrypted: i=1; AJvYcCUxhBkrcHmYaRTkfeyX/957RBvVldhujOne9J/eXossUDE8/3YBBaKgeodglMahMifHPv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1SxGvU91GfUneoisgZwx/FTygHk3ll36l25m/tbCjzBTajzQW
	NLvO4s6m0utFbzCRYCzxf3ATd5q6xlePetnd/NmoaMQ7/WmwVj8JVY262d8FITjxmX47hbZIFrV
	GoRDtezHEqqZAgdQm6HQdxs1Ilo2c23McRRCHVxG7
X-Gm-Gg: ASbGncskLeTwAUKGyiKn5LnpafTPL+Fl+kHKL4+vnd6OCTAlAVqCYQaYTDju75TC87f
	SWWUBsuveb2vTrmOd7rfYQ9UZ/xWBkyxQml7VnbbJXJdZzG0oDiLX7VXYH6uwpnm+6cVvfwXIkg
	KxfgnYz9EcdGnevnJZAdxzMB647p6ttyFl3/RIwijjnmfS
X-Google-Smtp-Source: AGHT+IFWlfqtKFHMBOLGn7Z83pzgLQUiE0GOnbpIGbNfU5pFgYiUQrcsYOaQ/uMIysvwNUJIuaG+fK9N/GeYGeIrPqk=
X-Received: by 2002:a17:903:98c:b0:216:4d90:47af with SMTP id
 d9443c01a7336-234cbe69a15mr1091405ad.29.1748402174833; Tue, 27 May 2025
 20:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-5-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-5-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:16:00 -0700
X-Gm-Features: AX0GCFumg6JlJqGa53nVXK2u3d4-rG_n2DPcLF5XB4A7_ranyMV2_0D-3YxOvnY
Message-ID: <CAHS8izMWhQsGuf4vFzU-LwViR5M0a2J3=H8Uuwn27ju4uZC6NA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] page_pool: rename __page_pool_alloc_page_order()
 to __page_pool_alloc_large_netmem()
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
> Now that __page_pool_alloc_page_order() uses netmem alloc/put APIs, not
> page alloc/put APIs, rename it to __page_pool_alloc_large_netmem() to
> reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

I suggest squashing this to the previous patch that modifies
__page_pool_alloc_page_order to make the patch series smaller.

Also __page_pool_alloc_netmem_order may be a better name.

But either way,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

