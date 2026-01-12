Return-Path: <bpf+bounces-78608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33AD14BC9
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A44F306CD97
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD843876A0;
	Mon, 12 Jan 2026 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcXi7YaI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415837E313
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242053; cv=none; b=m5OTYk6QAYSMp0BHHffkl5if5zypNgqOhyn44RUYJJ1yWvrFRDtzCMC2vjYicSPpTXSwT+gZh7sXwv3jgzO/RxvNUNBIuBVEtDLnbRWWWELe+lYO/I3uXwJYwT1Xmtg1MIcdRhIk37CBYXddxvgZ36V86Y+2QO189s5nh3lzqY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242053; c=relaxed/simple;
	bh=2kDMNGlutLZbBlBwbeCuPsKPzeKjPwdmAr2kRZI8ISk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+aQlDT9NNzBR7Cp8d0g8UT1/YIr2j//KmHqvgkvzvR20aiIihr2wD4MrsnXgXwgQQ8v5Yjg6+HVCIzP7cwRPzVGX/HQy9FG5y4zXI+mStKc95ZbeO5AtqH55vEFsQUiKsTbz/BoBW43sc6TmHCSidJgKqdGboJxzZQoi4ouT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcXi7YaI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b87003e998bso302610366b.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768242051; x=1768846851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XHGqVtaW8x0Sh1FjZrgxZJsIoNRNYfvhtGoAiQ9Qrc=;
        b=qcXi7YaI8TqqlD3628ylsT3CVvAt+SCOSI0MjNzZgDhM4FgG2c2V962xOgHX0nOYPG
         MAq45iYgE8EevBCBaA0uDHRnllUNcSooNFm8IJfp0TG84klkUR4hP034nxmQmgYXxf9R
         hcu6dkr5j15qfp/OCeOdKRJ2ATu6vG3QhveRkna5Lj2SHLvNVVKJ7l3xjD1znJE94Paf
         oZtOL4diWOJmN0dSHF/kclchYYjPfhs80Z181R9T+m5yKNqafS4raNv/RlDCKxoiNX4C
         PsQj1Ei/Uo3MDVUCjvjmIa23b2EbkWZbozT9Pp3t2oVYR8R4dtCQEYmVAavP/QhipYZ3
         vr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242051; x=1768846851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XHGqVtaW8x0Sh1FjZrgxZJsIoNRNYfvhtGoAiQ9Qrc=;
        b=N+xs3DcORCvA4l6e17Suc0A3SRdtUeul+IhoylE0I3jlEbi9/cmdFDcaORSAlSaYlL
         ckgeYkbiIFfzvqnOZFjj5DVl/QwwFJT0ISx8ZKBKfxDzUcvvd+a6ITnAW4YS3bbeW5Qh
         Hjf7/9CHPqPVmaHU4bCft/eoHN+9cbWTZaidSp7HIBlsKq8xKqBzZmpL16JpyaGPGFj0
         Um7GMy52UmA351G5PrstcGF+kfPiZ2Te8Dv2wrTTC54mjiKzxoTiMHKXHRgLq70FrTEx
         AS33AezGZ4nyIwTuu21T5rhzRyl/zsX5TdKYdUjoNPztCbl6eApDM4oriE6RaC6ah2my
         34Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV+q9vH3lH1DeCc96azP/phX+5ouF0z6m23Y4g1xbCUxLS6zVsGSUkvi0u0Pjt+WhVSfW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6eg1I4xLDsTdhYOe9uXg5RcNGTPhg/t4KgROZ1imoFGo0gV/
	PWwQBJy3NTnzwi74oM9T3k4HPuUhjMPK+vDWvzIxceiz5CD6K7oyvMHHxcVFTsIXDA==
X-Gm-Gg: AY/fxX5hdM9YvFNJgBrCihHaCjO/o/RqW9x1BkBxCkxJB9mLTq1HYEmpT65LcdUa1T8
	ptiQ4cVpyCNZ87udcs2Y0qgOKxudqWClTOpxmzfYpPMX51QJBXP43YpJt9NSHBu73nm+GSQRZD+
	cr04cjzHgTdw9uwQ0P6PyhFDS8UT5lb0R4Hf5S2F3bKWd29/EB3s5spox5St2IqqeK0HIEuvLkY
	vg/h6lnQvg/tIDepEDQ9j0NQMZTXNXBpaFBhD4dFKgNyeyPr6lUwXyjgF5N+AopVALlsbnRVJsF
	Xxf5Mi45W+Oct90TZA4a92LJsquK0DxsNvqpUb+4D/SnXKOAlcOIc8j4TDTGBXmePX2L3Sd7DIW
	aFQeVZD0aY0Jz1Dmn6gLuCbWUkb3LD7OKyJOn1AvKAs15vaGWRSpzzbSyhMLgPpHiNeHdb5NX2n
	d9idICjS5sYD3PEhhVX3OTxaUmXQ6DRqfNZrLQVo7oJevuVWefjnTMIXc5ryvzxBUx
X-Received: by 2002:a17:906:d553:b0:b87:29ae:2b96 with SMTP id a640c23a62f3a-b87357dbad6mr34509066b.12.1768242050430;
        Mon, 12 Jan 2026 10:20:50 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f1e95273sm752858966b.62.2026.01.12.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:20:50 -0800 (PST)
Date: Mon, 12 Jan 2026 18:20:46 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
Message-ID: <aWU7fnkQ5TLbAUmk@google.com>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
 <aWULOvXrN0acG97Y@google.com>
 <87ecnusq7m.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecnusq7m.fsf@linux.dev>

On Mon, Jan 12, 2026 at 09:20:13AM -0800, Roman Gushchin wrote:
> Matt Bobrowski <mattbobrowski@google.com> writes:
> 
> > On Mon, Oct 27, 2025 at 04:17:09PM -0700, Roman Gushchin wrote:
> >> Introduce a bpf struct ops for implementing custom OOM handling
> >> policies.
> >>
> >> ...
> >>
> >> +#ifdef CONFIG_MEMCG
> >> +	/* Find the nearest bpf_oom_ops traversing the cgroup tree upwards */
> >> +	for (memcg = oc->memcg; memcg; memcg = parent_mem_cgroup(memcg)) {
> >> +		bpf_oom_ops = READ_ONCE(memcg->bpf_oom);
> >> +		if (!bpf_oom_ops)
> >> +			continue;
> >> +
> >> +		/* Call BPF OOM handler */
> >> +		ret = bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> >> +		if (ret && oc->bpf_memory_freed)
> >> +			goto exit;
> >
> > I have a question about the semantics of oc->bpf_memory_freed.
> >
> > Currently, it seems this flag is used to indicate that a BPF OOM
> > program has made forward progress by freeing some memory (i.e.,
> > bpf_oom_kill_process()), but if it's not set, it falls back to the
> > default in-kernel OOM killer.
> >
> > However, what if forward progress in some contexts means not freeing
> > memory? For example, in some bespoke container environments, the
> > policy might be to catch the OOM event and handle it gracefully by
> > raising the memory.limit_in_bytes on the affected memcg. In this kind
> > of resizing scenario, no memory would be freed, but the OOM event
> > would effectively be resolved.
> 
> I'd say we need to introduce a special kfunc which increases the limit
> and sets bpf_memory_freed. I think it's important to maintain safety
> guarantee, so that a faulty bpf program is not leading to the system
> being deadlocked on memory.

Yeah, I was thinking something along the same lines. We can always add
this kind of new BPF kfunc in at a later point, so need to directly
address this use case right now.

