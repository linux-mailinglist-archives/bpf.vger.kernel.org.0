Return-Path: <bpf+bounces-64749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A7BB16780
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F413A388B
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345DA21128D;
	Wed, 30 Jul 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT4Ac7ow"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CACC120;
	Wed, 30 Jul 2025 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906742; cv=none; b=NL/8hV2HFk2QnYzV/6t8BdOcfEMH06waF4s+vVmKfxaBTrFiFIhCB/IamAMBS3ZdGAbfDQLoFGQxZDGlG9sI6SIl7wD2YJhTcRNN2+YSzNcX0y3OSYBA7m+hoEXD5Cgcn2IYe1EQ+5QKgip07SllqS5NjusykAT5/oxfdMwkxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906742; c=relaxed/simple;
	bh=DcXjq2rfJ+zi5yPib7hAe6FOJllbPaxz58yhERY06OI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=KNXqf+FkPhxvy142I9TkS8eOFZTKNtFd5e+qiD2Qq5pCi3wCB2YBEc8exFEMfeLONK0C0R9ab5ReCCQwZD6Dx7GiTRNA6z7B7wELVOVf4kiEFJ7m4m/xQtB0kjrpHPt4GrHWoPjAk494Jhz8RT5mGF9aiKjjURkX5zF6Kw0RMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT4Ac7ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF478C4CEE3;
	Wed, 30 Jul 2025 20:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753906742;
	bh=DcXjq2rfJ+zi5yPib7hAe6FOJllbPaxz58yhERY06OI=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=IT4Ac7ow31BC8gNnNxnNVAMGyuMvD4bYXd9tSwxtFbZobmWygXm90zc3LzmyBgCTD
	 +o7FmG0vdx8O8n+KpmvZ4pdP5TSP3tN1nLwf9PTmiDQpCegRaTWBSkXz3a7McbK139
	 D4vfpd4p+FFno6p1UsJOVyo/aFKtPeIX3Rf/54ONmFda5ov2qAfqICAIg99jFhImyU
	 XzhbbAXsU8M2zdaIIH+XAOiGsBNh+ayGf2sx0pWGL41GoBwlAoSEGBKBIKkLAYxIW6
	 1eIk08J7R4vft+bMFh6jzvdORdmCfTADmQYv2iRXx51mSDGcwFLPelBYhey/RhhfI/
	 1iPnYimu2U98Q==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 22:18:57 +0200
Message-Id: <DBPO1RQMZDH2.2WFOZO0X4DODN@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v14 4/4] rust: support large alignments in allocations
Cc: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 <rust-for-linux@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 <linux-bcachefs@vger.kernel.org>, <bpf@vger.kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Jann Horn" <jannh@google.com>, "Pedro
 Falcato" <pfalcato@suse.de>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
References: <20250730191921.352591-1-vitaly.wool@konsulko.se>
 <20250730192101.358943-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250730192101.358943-1-vitaly.wool@konsulko.se>

On Wed Jul 30, 2025 at 9:21 PM CEST, Vitaly Wool wrote:
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allo=
cator_test.rs
> index d19c06ef0498..17b27c6e9e37 100644
> --- a/rust/kernel/alloc/allocator_test.rs
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -40,6 +40,7 @@ unsafe fn realloc(
>          layout: Layout,
>          old_layout: Layout,
>          flags: Flags,
> +        nid: NumaNode,
>      ) -> Result<NonNull<[u8]>, AllocError> {
>          let src =3D match ptr {
>              Some(src) =3D> {

I think this hunk should be on patch 3.

Also, don't you see a warning when running the rusttest target? I think it =
has
to be _nid, given that the argument is unused.

