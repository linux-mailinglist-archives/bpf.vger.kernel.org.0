Return-Path: <bpf+bounces-74838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F93C66D30
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 02:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DEAE34FA18
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA932E9EC1;
	Tue, 18 Nov 2025 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQE6w355"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91396224B1E;
	Tue, 18 Nov 2025 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428775; cv=none; b=AVN4gaRfy6+AybN5Ss5ZMaLNN4t0+ZThzlmYY/NMmr4JK3zN1DHFqeXVHUkxtK12qEJ/tLCc2mlFvqQQo6kes7wbgGkV8c69eNe4A1XR02sXMwx+A3yCNvpLQjw8XX/rbF3WJP5sxF81Ha7JYmzTQNg+WBcuOQdoDmGbYzBnZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428775; c=relaxed/simple;
	bh=2xPAQ8vTmRss1HS6NiJylWsPP0y8vQsGritlWJFOQTE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WyRvZDlF/e1AYfstStptnzXT7abEm2mZ6lAjRG3e3MDTyOE0QH8lWJrrZoRk8O3TKQNXyRyj9q/aPMkXZydu8yTX+y/NmspUB6S1dFS2gDn//YzReV2DahxOo60updo2CwvzVFBN/5X79p6WlWO0ItZBpIgDBQzjLmdW67KAXgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQE6w355; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A45C116B1;
	Tue, 18 Nov 2025 01:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763428774;
	bh=2xPAQ8vTmRss1HS6NiJylWsPP0y8vQsGritlWJFOQTE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iQE6w355xmiBHO4GN13T/2EgmI08XBqKVPINMZBasaH4rjWYI7AKIw13N+UlKSbr2
	 9WNWnRAhug1XBUhaf/VwF3VWUdWp7pe2NcVNOshffgNA+uNSJw/D7nsdGsQdjRSJxt
	 YrsOYoKrGITPvlkCaqB4aL3V5M+N+j/Yg48vDglItj8Ab0K7jael16tmOfAnB4qval
	 //wfNVBXdYOIqFsN4UBez+3V3dnicXgkKKkdtailCMjd11MHcxMGGa0H8/1mdj/856
	 Bi1NZ8ivsf34HyROZ8IfZlhjMQOXgysBebJbUzVy6AsBBSAsQNMiXzbWOXClFz+cov
	 YC8Cv53SOCnRg==
Content-Type: multipart/mixed; boundary="===============8582021740552472443=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <47cb75777a482c283798d055c22c0a8c536abe74e9877bb8d01fbccaef840a2e@mail.kernel.org>
In-Reply-To: <20251118005305.27058-4-jordan@jrife.io>
References: <20251118005305.27058-4-jordan@jrife.io>
Subject: Re: [RFC PATCH bpf-next 3/7] bpf: Enable BPF_LINK_UPDATE for fentry/fexit/fmod_ret links
From: bot+bpf-ci@kernel.org
To: jordan@jrife.io,bpf@vger.kernel.org
Cc: jordan@jrife.io,linux-arm-kernel@lists.infradead.org,linux-s390@vger.kernel.org,x86@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,puranjay@kernel.org,iii@linux.ibm.com,mingo@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Nov 2025 01:19:33 +0000 (UTC)

--===============8582021740552472443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 23fcbcd26..7daf40cbd 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1215,6 +1215,8 @@ enum {
>
>  struct bpf_tramp_links {
>  	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
> +	struct bpf_tramp_link *update_link;
> +	struct bpf_prog *update_prog;
>  	int nr_links;
>  };

[ ... ]

> @@ -1840,6 +1843,13 @@ struct bpf_tramp_link {
>  	u64 cookie;
>  };
>
> +static inline struct bpf_prog *
> +bpf_tramp_links_prog(struct bpf_tramp_links *tl, int i)
> +{
> +	return tl->links[i] == tl->update_link ? tl->update_prog :
> +						 tl->links[i]->link.prog;
> +}

This helper is added but the architecture-specific code in
arch/x86/net/bpf_jit_comp.c, arch/arm64/net/bpf_jit_comp.c, and
arch/s390/net/bpf_jit_comp.c continues to access tl->links[i]->link.prog
directly. When __bpf_trampoline_update() passes tlinks with update_link
and update_prog set, won't arch_prepare_bpf_trampoline() and
arch_bpf_trampoline_size() use the old program instead of the new one?

For example, in arch/x86/net/bpf_jit_comp.c around line 2966:
    struct bpf_prog *p = l->link.prog;

This should probably use bpf_tramp_links_prog() to get the correct
program during updates. The same pattern appears in the other arch
implementations.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 171440f37..486f945f6 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -232,7 +232,10 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  }
>
>  static struct bpf_tramp_links *
> -bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
> +bpf_trampoline_get_progs(const struct bpf_trampoline *tr,
> +			 struct bpf_tramp_link *update_link,
> +			 struct bpf_prog *update_prog,
> +			 int *total, bool *ip_arg)
>  {
>  	struct bpf_tramp_link *link;
>  	struct bpf_tramp_links *tlinks;
> @@ -252,6 +255,11 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
>  		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
>  			*ip_arg |= link->link.prog->call_get_func_ip;
>  			*links++ = link;
> +			if (link == update_link) {
> +				*ip_arg |= update_prog->call_get_func_ip;
> +				tlinks[kind].update_link = update_link;
> +				tlinks[kind].update_prog = update_prog;
> +			}
>  		}
>  	}
>  	return tlinks;

[ ... ]

> @@ -397,7 +405,10 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
>  	return ERR_PTR(err);
>  }
>
> -static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
> +static int __bpf_trampoline_update(struct bpf_trampoline *tr,
> +				   struct bpf_tramp_link *update_link,
> +				   struct bpf_prog *update_prog,
> +				   bool lock_direct_mutex)
>  {
>  	struct bpf_tramp_image *im;
>  	struct bpf_tramp_links *tlinks;
> @@ -405,7 +416,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  	bool ip_arg = false;
>  	int err, total, size;
>
> -	tlinks = bpf_trampoline_get_progs(tr, &total, &ip_arg);
> +	if (update_link && !bpf_trampoline_supports_update_prog())
> +		return -ENOTSUPP;
> +
> +	tlinks = bpf_trampoline_get_progs(tr, update_link, update_prog,
> +					  &total, &ip_arg);

[ ... ]

> @@ -503,6 +518,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  	goto out;
>  }
>
> +static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
> +{
> +	return __bpf_trampoline_update(tr, NULL, NULL, lock_direct_mutex);
> +}
> +
>  static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
>  {
>  	switch (prog->expected_attach_type) {
> @@ -626,7 +646,7 @@ static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
>  		return 0;
>  	}
>
> -	return -ENOTSUPP;
> +	return __bpf_trampoline_update(tr, link, new_prog, true);
>  }

[ ... ]

> @@ -1136,6 +1156,11 @@ arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image
>  	return -ENOTSUPP;
>  }
>
> +bool __weak bpf_trampoline_supports_update_prog(void)
> +{
> +	return false;
> +}

The commit message says "For now, only x86, arm64, and s390 are
implemented" but none of these architectures appear to be updated in
this patch or in the visible preceding commits (627b0f207, b0184022d).
Without overriding bpf_trampoline_supports_update_prog() to return true
and updating the arch code to use bpf_tramp_links_prog(), the feature
will always return -ENOTSUPP on all architectures. Was this patch meant
to include the arch-specific implementations, or are they in a separate
series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19450205468

--===============8582021740552472443==--

