Return-Path: <bpf+bounces-62832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6053AFF366
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 22:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187167BA11B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E78B23B608;
	Wed,  9 Jul 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx1ntk1+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB121A92F;
	Wed,  9 Jul 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094703; cv=none; b=Zli0sb5dH7celP5sMPccXz82R+vzxfLvyu0gpwUuRcMrcJebQG355iwTe4ey6858lR90m20RcefNlkth6IZtSv+17s9IoVulztgM8d9+/3iDPNNJkmYL8QrymMS7piYMLhUMlDhqcHytZS4JLg/b5hto236UnsYRYlmzjYWKFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094703; c=relaxed/simple;
	bh=ueEG8yp3hUYyJWqlqrkUDKTjvyC55obFwvi/Yvm/Jmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEnI9UTpJDYxyHfeanx/J0RPYrP/JPe/g4EfP3KRV5WOOmhjriRs9a3Mter4VovJGJ/J8bTLMoZdfB1a32n70hn2o5Lx/tuvkjVXD0SNbDSlakpl31nwzr/ttRx82yQbixD6tljCcEQd/bSDHrebFfdxBgEHkaIfV6wME/D9tN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx1ntk1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D5AC4CEEF;
	Wed,  9 Jul 2025 20:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752094702;
	bh=ueEG8yp3hUYyJWqlqrkUDKTjvyC55obFwvi/Yvm/Jmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kx1ntk1+wqmtkcJE8xJdtY7xSzaqdbtvoUPfW9Z9ItTuZrVqVQvdLHV3WDEkbi7ZN
	 O1VTkYU8elasexw05Xgux1zf7uZgrDLfw+u+wtZHbS9VCIuI9hEp+B03YoZNWbGHUX
	 N6pUi8k/KxGe3nDUqa5Iom5Dh1kqr/2bZcXTc0a35CG5NeE3iubT/NRr+jpS2ma6LE
	 UXVIdTYxfumiuwrDnW+VeCeUEMx9Xn03B0k7cjaumXHP757KGRAfaAJ00rzG3HPZYW
	 MFMNrARB05rb4cVA2bhG2wWUwKc/TW+fmBDtQwcbQcQWc3lDHtB23vW/kEnoNlR4y8
	 yHk/cuWYyUG8w==
Date: Wed, 9 Jul 2025 22:58:16 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	rust-for-linux@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v12 3/4] rust: add support for NUMA ids in allocations
Message-ID: <aG7X6Htx0I6cUqYD@cassiopeiae>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172458.1032040-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709172458.1032040-1-vitaly.wool@konsulko.se>

On Wed, Jul 09, 2025 at 07:24:58PM +0200, Vitaly Wool wrote:
> Add a new type to support specifying NUMA identifiers in Rust
> allocators and extend the allocators to have NUMA id as a
> parameter. Thus, modify ReallocFunc to use the new extended realloc
> primitives from the C side of the kernel (i. e.
> k[v]realloc_node_align/vrealloc_node_align) and add the new function
> alloc_node to the Allocator trait while keeping the existing one
> (alloc) for backward compatibility.
> 
> This will allow to specify node to use for allocation of e. g.
> {KV}Box, as well as for future NUMA aware users of the API.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

> +/// Non Uniform Memory Access (NUMA) node identifier

Please end with a period.

> +#[derive(Clone, Copy, PartialEq)]
> +pub struct NumaNode(i32);
> +
> +impl NumaNode {
> +    /// create a new NUMA node identifer (non-negative integer)

s/identifer/identifier/

Please also add an empty line in between those two.

> +    /// returns EINVAL if a negative id or an id exceeding MAX_NUMNODES is specified

Please start with a capital letter, use markdown and end with a period.

> +    pub fn new(node: i32) -> Result<Self> {
> +        // SAFETY: MAX_NUMNODES never exceeds 2**10 because NODES_SHIFT is 0..10

This must not be a safety comment, but a normal one. Please use markdown and end
the sentence with a period.

> +        if node < 0 || node >= bindings::MAX_NUMNODES as i32 {
> +            return Err(EINVAL);
> +        }
> +        Ok(Self(node))
> +    }
> +}

With that fixed,

	Acked-by: Danilo Krummrich <dakr@kernel.org>

