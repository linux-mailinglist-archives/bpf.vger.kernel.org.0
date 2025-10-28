Return-Path: <bpf+bounces-72475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ACEC1289B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 02:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 022564FA823
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 01:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4708A2236F7;
	Tue, 28 Oct 2025 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyzJw3wd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6C222599
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614756; cv=none; b=gXf0qfJATeSprCQkK+PjgI98k5MAJ4vSxV3qQQUCDE62U+yef8n2XqPXk84D7IR3vhT07B1FL2rPCk2lTA1OgUhq12K9PK8Cpl0zW6cprUiZAoPRkJmgj117sTo7M6riT3Kvw9QrzhZWYAX/9ZbYnwIUeat5Uo5gpbrmpDUQ5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614756; c=relaxed/simple;
	bh=ywd+nRpAGTiaVQINUv/TgRZUFQCJClxYOhlWAyBWtdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtaUcLRYVuUNmQbaSIO0eNbih5mAXiq1kQ3XukVqP/UolysOQ+7EmXcYslgCVwla2/53PgDQPXK+ivpins+Tbj3edw2FXP+LHFY702Eoqk15BAfzUqWtTX8IeiIAZR9bXbea8GKDdSi6LSYujMzvOdk7S13K7eM8aylUBQgXDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyzJw3wd; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ea12242d2eso119461cf.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 18:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761614754; x=1762219554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+IhRzMSNfrWbx9v4qoylhMH03PgpLB+fsJBfp3BHIo=;
        b=HyzJw3wdWeYBunTcMnkz87mw/GU4wDc7GQzDVRA7sFOlCDYzDPcERjPgBsPqrfPhS8
         MrVOJ7AqD2X2V1XfOJ2M7hM4oRdRI9xgAehIsQajES7y3QWs51UlKGw7BTjNuCp7/5HD
         olW+1dHh0WjQrAjZcnTs2i7Nfvi1gZ4JI2nIxJ6u3AwpDjruPXz/X4bwQlA9At2BTcGL
         wblkjMCS0bPAQpDabL7yV2UJOYBe+I6P7mNvS/cmOQITrjjji75GA0GxbdeB9O/Of5tP
         B1EtAm9jfLzQLonYVFXzuPPqLp9adcevjyUr7ULbUXSYfTi0pJLxZRjBg0bwIoEH8zqw
         znPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761614754; x=1762219554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+IhRzMSNfrWbx9v4qoylhMH03PgpLB+fsJBfp3BHIo=;
        b=FM/hE4J34FqT/pr0PbIRgSfPVd6+qz2+YT5+pFzXSS3v9uodwtQkujpd+Tvl6a632l
         QYvG19zSNb6V396Of54rgWNkPChN9CuWdQToItlJyepV8H7OXCSfmpMgWYgdjuD6j4HI
         s56+4jnf8mniSqh7xc0sgzGKUa1rEqGgjRHT/4Sza6WTqa5xGmm9rnkXWFzUBni/K2Zb
         7hX49fp2W3LS5nLlfd3Tn5WRNgUs5040a4XdyenGHG3wWUDBTBswuFkUsG6vvt4/6tU4
         cKMD9yHj7Z8bMa/cVlqHKahgWnIykN+V3djEuuF2lBhSpMCIXMdzSmPIu5AbfN1a0v52
         y9mA==
X-Forwarded-Encrypted: i=1; AJvYcCXMF+7WGczh/EitwdBY62G2MxhMoXWyijXI44Vy6pk1XLM+aO8VBy6l1b2ADPCPw4u/+CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QbT9Lz2nEQddzKg1qXtFy5ArVynjhPuR/ncOmjmslJ0/3sKJ
	h3w2L2n1TLTrdbfmEOABR++sKqNzY6zQCQl0UeQ9WPR5P47ugcQRqOJi4W2toHUXMFjlpePhhnC
	TSStFWCOWEAhtiZhOhNmi90yyJpjcqnAR+unymyZd
X-Gm-Gg: ASbGncvfXV0QqwgcQfbJfAX4roHQF8bwztzjpKs9SPwO6dExo6SoFXcnCAOLhwUTej6
	SamCOt6pdS82RvBzjxRqWoV4a8l/Hyk3OU3sEQkgm+vWB6Bl8uNftI1sztlpnr9Vea7zabeFMmL
	erc2j/ayirYKIShBpdGgmXNGKCf1lk2SC0R3fxddCJXKb9jKDSSepibUDxFQ2VLIgTamI5E7tmN
	Ztax9Ro1ExGwb9OVvYHNkqcsQZlDZ5nlK86jkN/+u/ydA1JZW87Y9Qv0l2h
X-Google-Smtp-Source: AGHT+IGZpu7KbnVsM8kZ0fYv9D1RFyxoo19HTWIE9dDLgf5qw+saPGsXAmE1ImayYWVIS9arkPI85hHzY2/USWHgdZE=
X-Received: by 2002:a05:622a:190c:b0:4e4:d480:ef3a with SMTP id
 d75a77b69052e-4ed09f734c9mr2176101cf.13.1761614753768; Mon, 27 Oct 2025
 18:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023074410.78650-1-byungchul@sk.com> <20251023074410.78650-2-byungchul@sk.com>
In-Reply-To: <20251023074410.78650-2-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 18:25:38 -0700
X-Gm-Features: AWmQ_bltJKoIWK6cFNZ6Knu_i6BSq0jOkYeTZTTOB6G8J-1_KJrKj4k-v2-ULKU
Message-ID: <CAHS8izPM-s2sL_KyGyUyv37PfZxNLf029DrXpQe8fo637Rn+rw@mail.gmail.com>
Subject: Re: [RFC mm v4 1/2] page_pool: check if nmdesc->pp is !NULL to
 confirm its usage as pp for net_iov
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org, 
	kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, toke@redhat.com, asml.silence@gmail.com, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, 
	dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:44=E2=80=AFAM Byungchul Park <byungchul@sk.com> =
wrote:
>
> ->pp_magic field in struct page is current used to identify if a page
> belongs to a page pool.  However, ->pp_magic will be removed and page
> type bit in struct page e.g. PGTY_netpp should be used for that purpose.
>
> As a preparation, the check for net_iov, that is not page-backed, should
> avoid using ->pp_magic since net_iov doens't have to do with page type.
> Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs to a
> page pool, by making sure nmdesc->pp is NULL otherwise.
>
> For page-backed netmem, just leave unchanged as is, while for net_iov,
> make sure nmdesc->pp is initialized to NULL and use nmdesc->pp for the
> check.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  net/core/devmem.c      |  1 +
>  net/core/netmem_priv.h |  8 ++++++++
>  net/core/page_pool.c   | 16 ++++++++++++++--
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index d9de31a6cc7f..f81b700f1fd1 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -291,6 +291,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                         niov =3D &owner->area.niovs[i];
>                         niov->type =3D NET_IOV_DMABUF;
>                         niov->owner =3D &owner->area;
> +                       niov->desc.pp =3D NULL;

Don't you also need to =3D NULL the niov allocations in io_uring zcrx,
or is that already done? Maybe mention in commit message.

Other than that, looks correct,

Reviewed-by: Mina Almasry <almasrymina@google.com>

