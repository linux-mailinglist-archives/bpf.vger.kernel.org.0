Return-Path: <bpf+bounces-64593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A1DB14A0A
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9BE164C92
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 08:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ADC27F74C;
	Tue, 29 Jul 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgFv3EQl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3F2139C9;
	Tue, 29 Jul 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777539; cv=none; b=R3zr/OHpeLjiS8Dx/4aZrWkP9q22d2I/RlJvIVjDxV3qYWHrh6tgo3JP5hqeIH9/cWM4kZVg1X0gnFMp4SsPvk8fOlcnM7XisKd+uADsWpVqHLUT6swKavrXZTn5DMAeSHAIs8m4w8kcXVy3xSWs3a9hN8DPgkeWa2MebHt8SoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777539; c=relaxed/simple;
	bh=trWv/O9N9LVzYZbp1eqr0+k5qTUNtSEiwyb6DFcx67E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=XR3F07RjRG1/AvgOB/LeAkbnfu77g/y8xzkakAWMTlSggvwfKp7ulfnWLhzHkjnoJ64XFAkjJjU+HYb+P1b2uA2vUDQsWEp0tpjDMXbXp20D9t7krBr09Zffi/RJL1lxnFmZ95V1cUQTi6zp7DBQwozPg0yIGnU9rXZ/tOiu+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgFv3EQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E6FC4CEEF;
	Tue, 29 Jul 2025 08:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777537;
	bh=trWv/O9N9LVzYZbp1eqr0+k5qTUNtSEiwyb6DFcx67E=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=fgFv3EQlY2wrAjec/GhEM4fnwhqVwAKfjahNRyiU935vDwY3emdOPuRrk9X9AKLSg
	 s3Rn1wg4oPcHkCeIfvw6M6G6S+5q8eMJfhPVoISggyYqYc28O/G2vFvdiope7kGL0c
	 bVF9rKCTQfZkCWeRz1tJqijdXfI3pJ6VlsGvv3ItNyu2dxhll0drtkRGjoJ6/d+NEY
	 mb1Ucmy5cwiYT9XWxoXLKkiuDzvjXqJ4tjms0Frm4orwZyRTsGRLwJuI4u1vwB+/Lh
	 IPssxQRMSYVGTJ1O0vLgpotwkf90l5gSsFUKhbYwMPoBW3GxOVNKbBdP2FxA/hu5Qs
	 DpQZZ96LN58WA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 10:25:33 +0200
Message-Id: <DBOE907J16WH.1IOU3M11RX5SH@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v13 3/4] rust: add support for NUMA ids in allocations
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250715135827.2230267-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250715135827.2230267-1-vitaly.wool@konsulko.se>

On Tue Jul 15, 2025 at 3:58 PM CEST, Vitaly Wool wrote:
>  pub unsafe trait Allocator {
> -    /// Allocate memory based on `layout` and `flags`.
> +    /// Allocate memory based on `layout`, `flags` and `nid`.
>      ///
>      /// On success, returns a buffer represented as `NonNull<[u8]>` that=
 satisfies the layout
>      /// constraints (i.e. minimum size and alignment as specified by `la=
yout`).
> @@ -153,13 +180,21 @@ pub unsafe trait Allocator {
>      ///
>      /// Additionally, `Flags` are honored as documented in
>      /// <https://docs.kernel.org/core-api/mm-api.html#mm-api-gfp-flags>.
> -    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, Allo=
cError> {
> +    fn alloc(layout: Layout, flags: Flags, nid: NumaNode) -> Result<NonN=
ull<[u8]>, AllocError> {
>          // SAFETY: Passing `None` to `realloc` is valid by its safety re=
quirements and asks for a
>          // new memory allocation.
> -        unsafe { Self::realloc(None, layout, Layout::new::<()>(), flags)=
 }
> +        unsafe { Self::realloc(None, layout, Layout::new::<()>(), flags,=
 nid) }
>      }
> =20
> -    /// Re-allocate an existing memory allocation to satisfy the request=
ed `layout`.
> +    /// Re-allocate an existing memory allocation to satisfy the request=
ed `layout` and
> +    /// a specific NUMA node request to allocate the memory for.
> +    ///
> +    /// Systems employing a Non Uniform Memory Access (NUMA) architectur=
e contain collections of
> +    /// hardware resources including processors, memory, and I/O buses, =
that comprise what is
> +    /// commonly known as a NUMA node.
> +    ///
> +    /// `nid` stands for NUMA id, i. e. NUMA node identifier, which is a=
 non-negative integer
> +    /// if a node needs to be specified, or [`NumaNode::NO_NODE`] if the=
 caller doesn't care.
>      ///
>      /// If the requested size is zero, `realloc` behaves equivalent to `=
free`.
>      ///
> @@ -196,6 +231,7 @@ unsafe fn realloc(
>          layout: Layout,
>          old_layout: Layout,
>          flags: Flags,
> +        nid: NumaNode,
>      ) -> Result<NonNull<[u8]>, AllocError>;
> =20
>      /// Free an existing memory allocation.
> @@ -211,7 +247,15 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
>          // SAFETY: The caller guarantees that `ptr` points at a valid al=
location created by this
>          // allocator. We are passing a `Layout` with the smallest possib=
le alignment, so it is
>          // smaller than or equal to the alignment previously used with t=
his allocation.
> -        let _ =3D unsafe { Self::realloc(Some(ptr), Layout::new::<()>(),=
 layout, Flags(0)) };
> +        let _ =3D unsafe {
> +            Self::realloc(
> +                Some(ptr),
> +                Layout::new::<()>(),
> +                layout,
> +                Flags(0),
> +                NumaNode::NO_NODE,
> +            )
> +        };
>      }
>  }

Regarding the change in the Allocator trait, we also have to consider
the Cmalloc allocator in rust/kernel/alloc/allocator_test.rs, which is ther=
e to
support userspace tests.

While we're planning to remove this (see also [1]), we still have to consid=
er
it for now.

[1] https://lore.kernel.org/rust-for-linux/20250726180750.2735836-1-ojeda@k=
ernel.org/

