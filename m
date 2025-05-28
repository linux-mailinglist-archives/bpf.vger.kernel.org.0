Return-Path: <bpf+bounces-59077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5717EAC5FF0
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694997AFE2E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ABB1E25FA;
	Wed, 28 May 2025 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUtdmK2x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE93F9D2
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402240; cv=none; b=YdxmmlYaLljxaOTa5ZJ5y6PgIiNH9W95BVRm8F/rnNDurU+mkIipZYpwXGJ25mjxQGSufFbgCwoCU4PGt6MNULMcsInHoqdbox2myU0Y9hwTSOVjc/kkK/E6K3khdXWlCdSFaZFQILvdSkazwtDIATPJyiHbIz/WNrP5o6Cc3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402240; c=relaxed/simple;
	bh=LdFAyeQKVhf9an3e5Ej7+PQMaVUuxTdXfDQvB2CxLPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeGN6QaLJmje6nSZHiVSNiAcjMqlS//AWiAiqFdHigSYZ85NwFrSgMTypAIRYgVNmaliXhxgnLsncEBgGCIoIj3czpyp9/xgGI4c8snFHNsXcRJF3uTmYfu9fcrIPU6fmn6EbaZ8VJL6oSpu63prFbivCASVyQeBOGrT8fJnfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUtdmK2x; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2348ac8e0b4so70305ad.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402238; x=1749007038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdFAyeQKVhf9an3e5Ej7+PQMaVUuxTdXfDQvB2CxLPQ=;
        b=AUtdmK2xipN+sZQV7Qo76/sOfDnoWKgEgP2v40hWsmGmrGxbr0cc9D7EiPHGOS0cXm
         Wz7EMFD9xV4B3CEUWPGwsIjks/X3EGkJcQql3y/mdnouEwwiaEh8hbthGBlwH2hF6jCP
         75Xr/+7z67Ad+8aw1BqRB7LxgGX7bcnc399qs4I09LOw+fhcU42bGj2mcluoqmaSv6wD
         +CsOAqPniJcsIMR2WPzdtjvu7sk43omgmglDfG3e/cDRk0YGqqAIGIAWRjNNbmhmNe5c
         P2aJH7/rRCZvSVi61dAQYUsgqd1vtEcPXsWdwMFTir3OclYupZU2USsXwEdmlPKCTjPR
         w2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402238; x=1749007038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdFAyeQKVhf9an3e5Ej7+PQMaVUuxTdXfDQvB2CxLPQ=;
        b=klusorG9b0D5AOCEvd78wCPLS2lvQcd7Sy/C9vmoIhZkeJmAyatb5wwrVxJZNkFY3e
         hSc18Zgn1NQxPfX//X8oqafL5fKMCc7pzYp7bUNawXNZv/YVLUJ97aAMcXa7y+yo1SeL
         9DSlY2TBSZluZJsmDJg0otkD1VUKe4z88ueLhu437KkM1pln/WcFXpk5yLelJqwDMwPv
         set3AYGbj1yGLVKxIOcjI6wzfxaaU/srU6EAGK9l6xNGqRh01mnZXqN0YXAvOrxbPVOI
         o+FdGj1XejS3j+2zRmuuEWS6Tuzas+SoFt5rI8GsqX32D7/di/IU51m70qp9AK7iai6l
         Lndg==
X-Forwarded-Encrypted: i=1; AJvYcCWTe9OePaDGoF+Ia/wUxXXG8nIcQt0HkHnEgqdlF8vdZlAQ1arnDz6uAS3XJaNyCCOM6dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7XL5Upmyj+8YnEjAtyLTnPN3M2TxnmrRiBAawmkDPXwjmX2M
	smi2bNAwiAhifCKYplOE8vstCEIK5sMtEKcVccFL8BuzD+4Fh3m75pFlCKgGSjckBEx71D77PtF
	m9/7aTO0fsJ6uCZ5c034jrqsY0fJqp6Pzuer1FpAe
X-Gm-Gg: ASbGnctiFpBELNVX9IrUGEgPDZf15o3JD7KjzsdaW72oFgEAdW3aEv6GhiK4cVgb8/x
	cEUxbge+MJe6dlVokU8ixO1qZuepIZ9sny6yAia3HbfJh7VhV5R+HUjnsd2ir5iXF+cn3gOjrp3
	u/G+ZV4H7rImy1NOit6pXGpco/DbgAd1cuIyK06i6nY2FFl16Hlm8aAes=
X-Google-Smtp-Source: AGHT+IEnczAUe8aSvzmzngQXQGk0N5lF0CakBmamAAAHOTmJuCP9XYZrHm/qfHgB3Xi0bVS+4KeIoprZZQQkQB9JjsY=
X-Received: by 2002:a17:902:ea0b:b0:234:bcd0:3d6f with SMTP id
 d9443c01a7336-234cbaf560cmr1132885ad.1.1748402237697; Tue, 27 May 2025
 20:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-6-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-6-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:17:04 -0700
X-Gm-Features: AX0GCFs29uDSGIhRSaJWQiNCOlbuHKz4cCZioyPrXBBoYFAI3Cxm46scEROF8Bo
Message-ID: <CAHS8izOVbJZfS0r+A1Pi_ZxmrJBfUBZR4fApbd=GWj0AFQ8vcw@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
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
> Use netmem alloc/put APIs instead of page alloc/put APIs in
> __page_pool_alloc_pages_slow().
>
> While at it, improved some comments.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

