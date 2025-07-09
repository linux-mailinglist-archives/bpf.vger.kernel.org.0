Return-Path: <bpf+bounces-62833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A0AFF369
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934D41C8106E
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCED233152;
	Wed,  9 Jul 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whehk9WW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63942AA5;
	Wed,  9 Jul 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094858; cv=none; b=Sp0hkDGgU7miy3xYnnyIjRqM7KA0KP/Pl8KVnEopqciEa9eSyUDy/Z8pNj4PoFseANEzyFW4qRAfgs60UCbsKPZJVXEhGGjQBpSqHAjH9o75lLrYfUkuwS4EDLPmbrzPkRB3y7F0iYI9c/UWZUT8BRBOKZ7XNduHNi+IAHgfiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094858; c=relaxed/simple;
	bh=AmnUb7yJNWX4dwwep1SMKT/h6N+Cx4+LrtblZJzni+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLxLVu5BjWAdCmPotX0zUweSddKotdegWZ6LdeuNZ40ebsgbQAl9DOKJXtDV59ExC5e9J7JGjwkZ0beflGn5htzR3VcskFN22KployJP72yqsShK8NSb/0okyKkKyxz6+YRNUZZI+a1lYSH2xh4QzC5P/fNgILQmVaRm1mi9gaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whehk9WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A55C4CEEF;
	Wed,  9 Jul 2025 21:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752094858;
	bh=AmnUb7yJNWX4dwwep1SMKT/h6N+Cx4+LrtblZJzni+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Whehk9WWYghHn/wCtVNA/Tk0Zu86XExQdHkvRXk6QzqRubkOrrgp2yH7/mNyMKFmt
	 yyXcAVZZqHIEVFAUQFyvqgoqe0EQv01OYJuE5oEHZAazBJNRyYMQ3uxE3PG9VwQ3+Z
	 R++8huQw5IDFb86bXOYYjdhnA2b5qdQfPoPQnw3pS0FK3Y2h9wr9kGSxsQCfLRUVea
	 IR9lbCBScLQ3AJebsy/XXxQG9luGKNUpMMU7vtTAIaGnvTAVe/fffs6YcLVEKtY4i2
	 D17/VKX4Rh9Dgpbom2XJXg+GDgrs/hSCRuxLfYjgb6h3ekw/FBpivjfy8SimhpcwRC
	 VE9dLj/Bcy5QQ==
Date: Wed, 9 Jul 2025 23:00:52 +0200
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
Subject: Re: [PATCH v12 4/4] rust: support large alignments in allocations
Message-ID: <aG7YhNnGih9KcQjV@cassiopeiae>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172509.1032067-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709172509.1032067-1-vitaly.wool@konsulko.se>

On Wed, Jul 09, 2025 at 07:25:09PM +0200, Vitaly Wool wrote:
>  void * __must_check __realloc_size(2)
> -rust_helper_krealloc_node(const void *objp, size_t new_size, gfp_t flags, int node)
> +rust_helper_krealloc_node_align(const void *objp, size_t new_size, unsigned long align,
> +				gfp_t flags, int node)

CHECK: Alignment should match open parenthesis
#38: FILE: rust/helpers/slab.c:14:
+rust_helper_kvrealloc_node_align(const void *p, size_t size, unsigned long align,
+                               gfp_t flags, int node)

total: 0 errors, 0 warnings, 1 checks, 94 lines checked

Please make sure to always run scripts/checkpatch.pl. :)

> @@ -185,12 +180,6 @@ unsafe fn realloc(
>          flags: Flags,
>          nid: NumaNode,
>      ) -> Result<NonNull<[u8]>, AllocError> {
> -        // TODO: Support alignments larger than PAGE_SIZE.
> -        if layout.align() > bindings::PAGE_SIZE {
> -            pr_warn!("KVmalloc does not support alignments larger than PAGE_SIZE yet.\n");
> -            return Err(AllocError);
> -        }
> -

Since you remove the pr_warn!(), you also have to remove the corresponding
import, otherwise you get a clippy warning.

Please build with CLIPPY=1, see also [1].

[1] https://rust-for-linux.com/contributing#submit-checklist-addendum

