Return-Path: <bpf+bounces-77539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB29CEA9B1
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 21:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C50AF3009855
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138162FD1DA;
	Tue, 30 Dec 2025 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wg2cW/uG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925C2E6CA5
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126486; cv=none; b=Ts9wuz4nUDmOROG46QgJeO/ssnZKQzFHr1ZRS860En/n1LlAnCXuAiLgCpgS1t4RM2e7M/KTjcUejDw0bf6ACCHfgTx8Lc4TQX/VGEvDqTMyypqKPvXYYKU93VC3MhKewF0vP3TydFuRoIFNUSaV7fWyzppBu+SEhqQw6Dgw04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126486; c=relaxed/simple;
	bh=4iLwP3+bqqtfDl/vQvDTB7PtdvtzxpHMvYEt/LBe3Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX7RX6c3Cxfwp/X3ilc91t9ML9QGVKBaVCp92PIanhAphhCE9z5iJUS16PTWtOQDZjmECRkNi3Lfr1sCyEkT+prx6qIE48s8/bXZ/o4BEAICigAkf07BclTKaolb3NUuqTz10m+QqqlRj8GKjdk85jJOECGyfSEU1NVymK2Iyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wg2cW/uG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so2110587266b.3
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 12:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767126483; x=1767731283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztPE8iH50nMPfa6HL0qHJ1nqnsXkThvqgh3cI3Vnq7M=;
        b=wg2cW/uGzPIAxWENGVaLCKRAPbXo9s8IogjQSRLL++kibadVHegDwA3CthNHlSW45J
         hSOGXAl9oOkKLR/fWtwzB/b9cYia91YY6wVtVXfzSIx7UW7c7nOlItG6C40yoB0n6mPj
         FM85g7IA2/epn6fBuJXK7rFBDfbiBxDRdykAg+OeRGxjNfFwSrUq9tQ2j9+JpktjG9UL
         qLakX40CckKKBeIKwJlmRxuv0EDGN/IanrF8sPBnuxED6jT73hPsVokMQ5xKHoc5Vw0t
         YAsO2p1DrIzF/jJSgFu042KLZ1COtjvqS79vXexmRTp7Y2MuzkyymRvwhHO435lu0OWa
         TqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767126483; x=1767731283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztPE8iH50nMPfa6HL0qHJ1nqnsXkThvqgh3cI3Vnq7M=;
        b=d6fj4oRbGU27JEGQLiCRTL6ldyfFN6jcPEftgLANYIfrvBXkTR1pPDSwVPD9vCu+Rs
         ovBbpLuDwUxOnUz90keEfe5+lWhin9Jstxyahvkx/fqWFFZNpN0hB4nqNZqAmQkDEAkT
         ksDMF3kdp7Xw05fRufwV46wwrJwcIebKfaWS63WtGpRgzjlRmXAXt/wk4Jnvs8hf3g6c
         WubDxVpRzdNThuZQpXzUTFcJSOnt1fBO9GKcqVcCVpMe6Z5gPcYdBuHkUXND1S688hBJ
         cgoQmWrxPTA/G+e1+DqZ9+woqM32tooSdbAcF/fMzxHvRHyYwmBsO+YRFkdfuXZnkXoQ
         IN9Q==
X-Gm-Message-State: AOJu0Yyh4m8XrgENtA6Yqiz2LRKlgXQFQ8IOufjQPiePun46E64699cf
	vXTf8iy/tupJ78E5UCM3NicFYzbavZhG+iu2PHgWneVQ+M+8LuYgJ7tTgdwFBNtCsg==
X-Gm-Gg: AY/fxX7VcUt2PVS3F/HycWpJXhqyyDpe2zaaw+amK7FayKhBTbee3VLJFbChatJ1kD9
	s3VS5MTczRiN14FPnqrWOi5ySDjC6vXyIu4N1EKf6VMFVg1BQeqhkJwZztFJWQPXKszJEwFwM9t
	yXrRF8pECbN0N88Dy6hwkA0n056ZaWPN3RrwXi6wq73AzBbVthUiWc3cEMRKFCxARN/JrE8BWSJ
	sRtYZweCeGhvLTVxBsrvyeTkdTidFVywtF/Cv5w8CNCQLPbGUOBNWa1MteCRd4Vci9G8WevsaY7
	BKXilqJpi4rZAyWnIaWq9Tb3mGYhZDTHCGWp3Uv7q9jJo6TT/6+TycvdIrgbM3v+Jsrw9pYcZ80
	7qsOg8CKCQDuk07xUxEvH1Sl9E7vEH/xDY911YiSpJGubzYp+am+HnGOS1P6Eb/Es+Mlj8jnIZc
	rxCmqZdeb2ZrQ36PygfkST6h9JGqKy2AwngKZvPRyUku7zsr5qDqebxw==
X-Google-Smtp-Source: AGHT+IE6klKBBpPwYZcs6xdTSJ0fjAfHgeE3C/83ZK9N52lbmSSXdkT+x85Kgg+Uwb0dJJL5W7RgZA==
X-Received: by 2002:a17:906:7315:b0:b80:1b27:f2fd with SMTP id a640c23a62f3a-b80371da6f3mr3750815066b.54.1767126482937;
        Tue, 30 Dec 2025 12:28:02 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0e8f1sm3731533366b.53.2025.12.30.12.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 12:28:02 -0800 (PST)
Date: Tue, 30 Dec 2025 20:27:58 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	JP Kobryn <inwardvessel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v4 3/6] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
Message-ID: <aVQ1zvBE9csQYffT@google.com>
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
 <20251223044156.208250-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223044156.208250-4-roman.gushchin@linux.dev>

On Mon, Dec 22, 2025 at 08:41:53PM -0800, Roman Gushchin wrote:
> Introduce a BPF kfunc to get a trusted pointer to the root memory
> cgroup. It's very handy to traverse the full memcg tree, e.g.
> for handling a system-wide OOM.
> 
> It's possible to obtain this pointer by traversing the memcg tree
> up from any known memcg, but it's sub-optimal and makes BPF programs
> more complex and less efficient.
> 
> bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
> however in reality it's not necessary to bump the corresponding
> reference counter - root memory cgroup is immortal, reference counting
> is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
> memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
> obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/bpf_memcontrol.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 82eb95de77b7..187919eb2fe2 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -10,6 +10,25 @@
>  
>  __bpf_kfunc_start_defs();
>  
> +/**
> + * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
> + *
> + * The function has KF_ACQUIRE semantics, even though the root memory
> + * cgroup is never destroyed after being created and doesn't require
> + * reference counting. And it's perfectly safe to pass it to
> + * bpf_put_mem_cgroup()
> + *
> + * Return: A pointer to the root memory cgroup.
> + */
> +__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
> +{
> +	if (mem_cgroup_disabled())
> +		return NULL;
> +
> +	/* css_get() is not needed */
> +	return root_mem_cgroup;
> +}
> +
>  /**
>   * bpf_get_mem_cgroup - Get a reference to a memory cgroup
>   * @css: pointer to the css structure
> @@ -64,6 +83,7 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> +BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)

I feel as though relying on KF_ACQUIRE semantics here is somewhat
odd. Users of this BPF kfunc will now be forced to call
bpf_put_mem_cgroup() on the returned root_mem_cgroup, despite it being
completely unnecessary.

Perhaps we should consider introducing a new KF bit/value which
essentially allows such BPF kfuncs to also have their returned
pointers implicitly marked as "trusted", similar to that of the legacy
RET_PTR_TO_BTF_ID_TRUSTED. What do you think? That way it obviates the
requirement to call into any backing KF_RELEASE BPF kfunc after the
fact.

