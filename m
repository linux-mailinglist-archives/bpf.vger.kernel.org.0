Return-Path: <bpf+bounces-63331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D5EB06183
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 16:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5640E1C4298D
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9851DE2D7;
	Tue, 15 Jul 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIz5qjCs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1E224F6;
	Tue, 15 Jul 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590008; cv=none; b=efoGftHQ1HCMpDT/YemTohtJX4f6KLS5OZt+xlxGFy0fdl5yhVI0nABTeoiYOGDFG/DNvwEcEWFF3HhZOPcxSwwAOZ+yhjdFMqqyxig62wUlP2DCwn4lOnZa/O0EnYA1L5yHYmF5Wd7jSMP641bECl+L8tu6dQvl8dEwOay1fWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590008; c=relaxed/simple;
	bh=eQa8mNAlVqavYHMUiPZeXoF99a7nhAyYvF6Mw1NgSY8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=VljhCHZUkw8whmfwmgfbucUWvVimcdAfTMNMRgJxwoMXXg+NlijVtj5yAw0IO8xTk8frITT6u0rR6z12vWCHo1KP0xTr7rnkhBDYRfUoa27v16UF2ZJCPzDlI4NO6IEeDM4EI381f3zaizSJhry2GF4NAas/l0BQkOIeP8s55EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIz5qjCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8386AC4CEF1;
	Tue, 15 Jul 2025 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590007;
	bh=eQa8mNAlVqavYHMUiPZeXoF99a7nhAyYvF6Mw1NgSY8=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=gIz5qjCssM+llIhH6PvHDb8FA7i70zQlzt+e8lbo3FScMmpDPN4fCu4iD2UCoHHxa
	 6Ne9ufacuEEXwsqDFAo57hOVBL6hFpJ7m6VhSrGQBcxKI7MD0BuT1cPk4COrbYLWlE
	 syOojojEapjjus5E5037StMekGujhTULPpN9gmlBdTaACw9XWofpJQHxmi1FVJQbwu
	 0vvPpn0oFH+0Ui/YeNJvKnQAda/3ujxcAmDu41bCww2eLacdIA0+i43fHDVIulAEi+
	 oo5bxLB1CvlS44nsCpg3MWT3KAwK2F2QIPtfYZjHOzp4mC8vmgWxFXkeIcMj/w5Bp9
	 Y8Arud/b8O5nw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 16:33:22 +0200
Message-Id: <DBCPB0BHKNTQ.K0NWNXIFKCT0@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v13 2/4] mm/slub: allow to set node and align in
 k[v]realloc
Cc: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 <rust-for-linux@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 <linux-bcachefs@vger.kernel.org>, <bpf@vger.kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Jann Horn" <jannh@google.com>, "Pedro
 Falcato" <pfalcato@suse.de>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>, "Kent Overstreet"
 <kent.overstreet@linux.dev>
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250715135815.2230224-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250715135815.2230224-1-vitaly.wool@konsulko.se>

Hi Kent,

On Tue Jul 15, 2025 at 3:58 PM CEST, Vitaly Wool wrote:
> diff --git a/fs/bcachefs/darray.c b/fs/bcachefs/darray.c
> index e86d36d23e9e..928e83a1ce42 100644
> --- a/fs/bcachefs/darray.c
> +++ b/fs/bcachefs/darray.c
> @@ -21,7 +21,7 @@ int __bch2_darray_resize_noprof(darray_char *d, size_t =
element_size, size_t new_
>  			return -ENOMEM;
> =20
>  		void *data =3D likely(bytes < INT_MAX)
> -			? kvmalloc_noprof(bytes, gfp)
> +			? kvmalloc_node_align_noprof(bytes, 1, gfp, NUMA_NO_NODE)
>  			: vmalloc_noprof(bytes);
>  		if (!data)
>  			return -ENOMEM;
> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
> index 0a4b1d433621..2d6d4b547db8 100644
> --- a/fs/bcachefs/util.h
> +++ b/fs/bcachefs/util.h
> @@ -61,7 +61,7 @@ static inline void *bch2_kvmalloc_noprof(size_t n, gfp_=
t flags)
>  {
>  	void *p =3D unlikely(n >=3D INT_MAX)
>  		? vmalloc_noprof(n)
> -		: kvmalloc_noprof(n, flags & ~__GFP_ZERO);
> +		: kvmalloc_node_align_noprof(n, 1, flags & ~__GFP_ZERO, NUMA_NO_NODE);
>  	if (p && (flags & __GFP_ZERO))
>  		memset(p, 0, n);
>  	return p;

I assume this is because kvmalloc(), and hence kvrealloc(), does this:

	/* Don't even allow crazy sizes */
	if (unlikely(size > INT_MAX)) {
		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
		return NULL;
	}

Do we still consider this a "crazy size"? :)

