Return-Path: <bpf+bounces-60656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE92AD9A0B
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 06:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48AE3BAD74
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 04:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F61D61BC;
	Sat, 14 Jun 2025 04:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="awOKk3/U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC3151990
	for <bpf@vger.kernel.org>; Sat, 14 Jun 2025 04:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749875408; cv=none; b=KjIZhzVHLT6xnauO9Fdx8hSAHzYz3Zial5+t82ImPYLX7u9lMPq3Og7x61ZdphTcIyugyvJu1l4SFJNee6wRL2F/So2oiO/GGE7eTYqlbaehjE8yKlQjmZZ6RbC384EGpXVsh6ZF37X5Zla0kWcuRl//U+THX/PM3MCDyD2snDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749875408; c=relaxed/simple;
	bh=XNGM7hbzMffKhpfxMTQ3F/J1yS9Q30hS8zYBljaE3r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9ClMII9ZEuJkjD897AoV350TUyggI0sHFnmo6OocscPJX+rM448bKeUQy8oVffJC3vdc+lE5MDm6P1uWzglKYohj6n0huW0Sm1n3AB8JdAlJx7ll30hVDdGZZloYH8R0hvIoTzVycjUHvRq/dfRfHgv0H55V48hCeE4o8hNmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=awOKk3/U; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a365a6804eso1840062f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 21:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749875404; x=1750480204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3UyMkex9gWKrcutLitVneuFUOREOl7zIrZSd0dvQp3g=;
        b=awOKk3/ULQNezjsMM4NYAa7Enul18Z/h/GFnKMyX2mFJf0+GRA2YPZNG31byctxzFK
         HDAbXqkuc0CHuve1qfYgg4nue4qnYAyZoiGbFw0ctHnIsAV4GKgEhFSw8HbNygt/gvFJ
         xNnNX57CKGm+0oMv3OuugGYwW0hirxmSZ2d1SGgcLG3z3N7q92RSqM7sgr3X77hTlwyh
         ZPq6BcSZ0SvNQ78zySyN7cz8dV7FyoJR4iQco1/1LrZNDY58fIlCDlM0aHvnaSWYa9jn
         ejfO+yR5LWJXgOA8cc71tk4TPZhwywNKELcPNQTfpUQ9G4Au3MSCBu8t1xQOoKHwRlvE
         6Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749875404; x=1750480204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UyMkex9gWKrcutLitVneuFUOREOl7zIrZSd0dvQp3g=;
        b=hPquMV0NIfmnitG418inztty4+G3FCn+dSUAvKXkwHIwgUNdNSG1VwhWq4ADt4YIHm
         lU24gx5qXjfj+cAgMGP8WIMGMZrvLXA9eVrFDgdYLmXi1GbvlXC4Z/5V2ppNTYGyUqD6
         WsZcoiLZWeCZQH7nxwZiszbvkydP2v0oQxrd8hlpMXUA4WlsLNHRLugscTzJjuGnp8ms
         jh/VPcEXM+8qgE5DWt+b7RB6aZhwQ/zuFxngiehbGxrfzPu1bXKXNMDdPeJVWQZvzgqN
         X3JgcS3G8TFKQAYuk/6Rnb2mHlkakBvs3Akug9udznDNJwMgEKqBmOu1k/FxRcF981CD
         dHOA==
X-Forwarded-Encrypted: i=1; AJvYcCUCfMg50GqwUSIw9MlNxGEG4CDXGpLI4F7Rt2dCEgRF4IjSt783jqLw5DDuJ4enq21oB3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXRJM7FPYCIkUNMhooEoNrW4u4S+86tLfRiY7H+KMr+YCqqBi
	Of5EHW7b1hymHJbywfFHPvuyhqaoL0c6twIlBRxYkdQccuCztMO68P4vPnZlelfeY/hh36jHAWd
	32SwhDRD+gw==
X-Gm-Gg: ASbGncvjD/40Ja0buUT4O7+PdosBM0GdhnzUXjEYOutkdIxf1zF2mqcR/7vHhedBSt/
	1lOpHvdydCa3YnKYiqAspkch0NKZyhP0QXadscvkVsWXmMvpNkAVYwlkERbOKMWCpTrv+uf4Z1L
	3J9sHYkJ8hiatvzqmUq8nACI6Qbqe/KlkcVBLmMiufxtvMT9eZ2E5/vfET2zCE7kWu9cv9t0Imb
	4D0fx4q7u8GjN+qsLf7VAkK0A5w52krPnyafhBMohXeTKzxmsehuNP0oQdKLEVgzUE6wnNFbwdw
	etAGcz6qKz7sO6lshFMT6IX9ROTOmUCbOQs/wltyNI4pnGK3U1yUTbf4
X-Google-Smtp-Source: AGHT+IEMTpDP3L2lj4VyrQ5EbeDIvTfzZ44zSGT6lzrokTIqEWCgQGUu8OSQ5ScRV3QFtV3wZkj1fA==
X-Received: by 2002:a05:6000:240e:b0:3a5:2875:f986 with SMTP id ffacd0b85a97d-3a572874a1cmr2022636f8f.44.1749875403734;
        Fri, 13 Jun 2025 21:30:03 -0700 (PDT)
Received: from u94a ([2401:e180:8d23:7dd3:95f2:880a:1c89:3ec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb887csm22950965ad.192.2025.06.13.21.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 21:30:03 -0700 (PDT)
Date: Sat, 14 Jun 2025 12:29:53 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.15 068/118] bpf: Add
 bpf_rbtree_{root,left,right} kfunc
Message-ID: <avgg2fdgpdm4mwb375zwnqjvtgugwtgw73a2zkx5ybmvvixifo@mlhxcnm4y7ac>
References: <20250604005049.4147522-1-sashal@kernel.org>
 <20250604005049.4147522-68-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604005049.4147522-68-sashal@kernel.org>

On Tue, Jun 03, 2025 at 08:49:59PM -0400, Sasha Levin wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> [ Upstream commit 9e3e66c553f705de51707c7ddc7f35ce159a8ef1 ]
> 
> In a bpf fq implementation that is much closer to the kernel fq,
> it will need to traverse the rbtree:
> https://lore.kernel.org/bpf/20250418224652.105998-13-martin.lau@linux.dev/
> 
...
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Link: https://lore.kernel.org/r/20250506015857.817950-4-martin.lau@linux.dev
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> 
> NO This commit should not be backported to stable kernel trees. Here's
> my extensive analysis: ## Primary Reason: New Feature Addition This
> commit adds three new kfunc functions (`bpf_rbtree_root`,
> `bpf_rbtree_left`, `bpf_rbtree_right`) to the BPF rbtree API. These are
> entirely new capabilities that enable rbtree traversal functionality
> that did not exist before. ## Specific Code Analysis ### 1. New Function
> Implementations ```c __bpf_kfunc struct bpf_rb_node
> *bpf_rbtree_root(struct bpf_rb_root *root) { struct rb_root_cached *r =
> (struct rb_root_cached *)root; return (struct bpf_rb_node
> *)r->rb_root.rb_node; } __bpf_kfunc struct bpf_rb_node
> *bpf_rbtree_left(struct bpf_rb_root *root, struct bpf_rb_node *node) {
> struct bpf_rb_node_kern *node_internal = (struct bpf_rb_node_kern
> *)node; if (READ_ONCE(node_internal->owner) != root) return NULL; return
> (struct bpf_rb_node *)node_internal->rb_node.rb_left; } __bpf_kfunc
> struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root, struct
> bpf_rb_node *node) { struct bpf_rb_node_kern *node_internal = (struct
> bpf_rb_node_kern *)node; if (READ_ONCE(node_internal->owner) != root)
> return NULL; return (struct bpf_rb_node
> *)node_internal->rb_node.rb_right; } ``` These are completely new
> functions that extend the BPF API surface, which is characteristic of
> feature additions rather than bug fixes. ### 2. Verifier Infrastructure
> Expansion The commit adds these new functions to multiple verifier
> tables: ```c enum special_kfunc_type { // ... existing entries ...
> KF_bpf_rbtree_root, KF_bpf_rbtree_left, KF_bpf_rbtree_right, // ... }
> BTF_SET_START(special_kfunc_set) // ... existing entries ...
> BTF_ID(func, bpf_rbtree_root) BTF_ID(func, bpf_rbtree_left) BTF_ID(func,
> bpf_rbtree_right) BTF_SET_END(special_kfunc_set) ``` This systematic
> addition to verifier infrastructure demonstrates this is an API
> expansion, not a fix. ### 3. Enhanced Function Classification Logic ```c
> static bool is_bpf_rbtree_api_kfunc(u32 btf_id) { return btf_id ==
> special_kfunc_list[KF_bpf_rbtree_add_impl] || btf_id ==
> special_kfunc_list[KF_bpf_rbtree_remove] || btf_id ==
> special_kfunc_list[KF_bpf_rbtree_first] || + btf_id ==
> special_kfunc_list[KF_bpf_rbtree_root] || + btf_id ==
> special_kfunc_list[KF_bpf_rbtree_left] || + btf_id ==
> special_kfunc_list[KF_bpf_rbtree_right]; } ``` The functions are being
> added to existing classification systems, expanding the API scope. ###
> 4. New Argument Validation Logic ```c static bool
> check_kfunc_is_graph_node_api(struct bpf_verifier_env *env, enum
> btf_field_type node_field_type, u32 kfunc_btf_id) { // ... existing
> logic ... case BPF_RB_NODE: ret = (kfunc_btf_id ==
> special_kfunc_list[KF_bpf_rbtree_remove] || kfunc_btf_id ==
> special_kfunc_list[KF_bpf_rbtree_add_impl] || + kfunc_btf_id ==
> special_kfunc_list[KF_bpf_rbtree_left] || + kfunc_btf_id ==
> special_kfunc_list[KF_bpf_rbtree_right]); break; } ``` This adds new
> argument validation paths for the new functions. ## Comparison with
> Similar Commits Looking at the historical examples: - **Similar Commit
> #1 (YES)**: Added basic rbtree kfuncs - this was part of the
> foundational rbtree infrastructure - **Similar Commit #2 (YES)**: Added
> argument support for rbtree types - essential for the basic
> functionality - **Similar Commit #3 (NO)**: Added function declarations
> to test headers - clearly test infrastructure - **Similar Commit #4
> (NO)**: Added special verifier handling - complex new feature logic -
> **Similar Commit #5 (YES)**: Added basic BTF support for rbtree types -
> foundational infrastructure ## Use Case Analysis The commit message
> describes a complex use case for implementing a Fair Queuing (FQ)
> algorithm that requires traversal capabilities. This is clearly an
> advanced feature for specialized networking applications, not a bug fix
> for existing functionality. ## Risk Assessment Adding new kfuncs carries
> several risks: 1. **API Stability**: New functions become part of the
> stable ABI 2. **Complexity**: Introduces new code paths in verifier
> logic 3. **Testing**: New functionality may not have complete test
> coverage in stable kernels 4. **Dependencies**: May rely on other recent
> changes not present in stable trees ## Conclusion This commit represents
> a clear feature addition that extends the BPF rbtree API with new
> traversal capabilities. ...

Hi Sasha,

Any reason this patch is included despite your tooling suggest _not_
taking the patch into stable?

> It does not fix any existing bugs or address
> critical issues. The functionality is designed for advanced use cases
> and represents an expansion of the BPF programming model rather than
> maintenance of existing capabilities. Following stable tree guidelines,
> this should remain in mainline development kernels and not be backported
> to stable releases.

I don't see a Stable-dep-of tag, so it seem more likely that this patch
was accidentally selected.

Also could you have the tooling's decision log better formatted? In it's
current form it cannot be easily read. 

Thanks,
Shung-Hsi Yu

>  kernel/bpf/helpers.c  | 30 ++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c | 22 ++++++++++++++++++----
>  2 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a71aa4cb85fae..6a55198c2d9ad 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2367,6 +2367,33 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
>  	return (struct bpf_rb_node *)rb_first_cached(r);
>  }
>  
> +__bpf_kfunc struct bpf_rb_node *bpf_rbtree_root(struct bpf_rb_root *root)
> +{
> +	struct rb_root_cached *r = (struct rb_root_cached *)root;
> +
> +	return (struct bpf_rb_node *)r->rb_root.rb_node;
> +}
> +
...

