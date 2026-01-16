Return-Path: <bpf+bounces-79220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ABED2D8C5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1928C30146C2
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9732BEC2B;
	Fri, 16 Jan 2026 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1zCjLn+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2603FFD
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550145; cv=none; b=X6HgF71SDPGwOudS/MQxm7d80nXu4xe1JCEjMRbiwUwaadhyRQj/HM3uObhnWOKrlJXSpNQgZW/A88YdLFqoh4iJq7DF6K6sCwlTu21/YxsjnKA/zbl2qg6tevOSBvjKEKlXSigWC5/gwgwtKoqhN7jFop+xy0IdXeI1SUc2/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550145; c=relaxed/simple;
	bh=Z7lvwij4kffqoaf7wQpfk+BJzjM3u4r57YPt17vIXm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR7sHlg1QVOwA0HFmO0O5Jl7QSZeYfnEdUs86KabkelqI4jCTKvGk9kEzXDFcSD7qjyUUvOiU1OBmYLKOJweO548gAYV7R0TB+14OnFjXWqnSPZ0AezND0YLm0AafPWSBViSLjC1wV6qR2yBU37NIfrOidjwr5WDnxhxBuswQto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1zCjLn+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b879d5c1526so60584866b.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 23:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768550142; x=1769154942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uT0bm6+T+6f9KXJYVAEtgn8BOpGRzAbHo48opPMYrTo=;
        b=p1zCjLn+hH2PfrTeif6lej37baO2T55Ovlxv78Dzm9j84jPBtF0QjZH+g5/a0PTiyj
         tGGKgGIcWuMasYslQ+kXRDJxEfvQBPjiYUoCoQf3/1kQJYLqkxnun6p48+W7L+UnDQPs
         6+BHJuPn8PXcYsasqp3po9vmXYFRTSOt7GNaGneYKAFXL6+tqzpTk9KYSd4tmm2/tScb
         tPqvV4KLCqiXv4fzt2BSHMQERQRsQg+rhO9RhmIywBHUUpu3gXZXx8YmhRZIlcb2g6uS
         NOkOMhNX0xXaJJMKF9rTcdRNj8f60kHX01oN2G7aDdTm6wBO+fVxRvQSHR/1htEfW0PL
         2clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768550142; x=1769154942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT0bm6+T+6f9KXJYVAEtgn8BOpGRzAbHo48opPMYrTo=;
        b=isokqWu8/rt6ltduETPjFZbk4vp++ENEePssINonHf0miJdjwL1XQWVxQavOhuTwBF
         6Ly3lbUiwnq1ajiVFvOp1pwZvuT3alP+2nM5kpuRxjH+uRz3goM2duExfUmv2XZy9OFN
         Qh9x2AiLQXmqtL2w6LJq35HA1kyc921eQCeCMtYccRpy+OQ64191V6wjySyFr5ky1CDk
         T/9wxDNZaUTFrGE/Sf4/XZIej7o50LNejSAP+MBT/SQGKe9gN9ThrdaCtCWlvYn0cXsU
         DFhChU5UnOX53myJuFkY1d6+F6lvOaDVSLmeypwlT7ZyOplDktvojKH9/1BKTbXtQKbY
         m2xg==
X-Forwarded-Encrypted: i=1; AJvYcCWVr5n7mD8DmWQ0hYX+7tRBn59Tv/hFZFh+tOF6LpJZJYf/MfL0fgCacn7iIyk0XitNpdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQTPMWkwMf4xCCBE+3HToRMmEapnDpdIfzUlcijiElo7sK/Ag
	Ryb7XcKhQW/85hk9UWjx4WhzSPTk2GMyl/ui0S/UgEsuM1ZvQpxSzy1YI/7yMrPoKg==
X-Gm-Gg: AY/fxX4QDBS8nlseDYxk3yJwac+tEpypwHWIN3zF1Ud8Vc/4pm3ePPISj7k/oFQUCEs
	hTpz6IheTl7+mCEvZMb6Y1RBxMF2qLW26afnP2dc+hwJ8h3hHdtl/nWfDDZB+nhZ4pIXLvTz1aw
	scx+M184FqAqbO8tDSXoOGrfJPgm34es8uwm4ViAOAvLFUV4tuTl0N7/XTqlllr9+DjaIb2SgvC
	wHTMfQGIX+ZH+ZEUKUmTasJ5LOx+ja2j6/IU+ynzevPoXWqjA2RBsj1J2iGMMRegv0wUfjhWPQS
	bfJ47RC4/eIypZ7G3IcytyBQ3c0lyF/oe9UBPXRbQLFoJ3fIfy1LKOHmnWx2SGB72jhYibhng6l
	1Y4P6x1h6HzrHaKzROCaciC8xnoyAvSpcrRz2A3S82CjdI9QMx69VP5DMO5nqrXW7rlQ7o3XmXV
	d6T4xOl+MXSegYB52aQKmTsiFSea2F9jQVa9D+3QyNURxy0v67cly9JjkC3U+bdO6w
X-Received: by 2002:a17:907:d17:b0:b86:f926:fbc4 with SMTP id a640c23a62f3a-b8796bb1d74mr150703466b.58.1768550142052;
        Thu, 15 Jan 2026 23:55:42 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87952919d4sm156077466b.30.2026.01.15.23.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:55:41 -0800 (PST)
Date: Fri, 16 Jan 2026 07:55:37 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
Message-ID: <aWnu-b0dlm0xZFDS@google.com>
References: <20260113083949.2502978-2-mattbobrowski@google.com>
 <87y0lyxilp.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0lyxilp.fsf@linux.dev>

On Thu, Jan 15, 2026 at 08:54:42PM -0800, Roman Gushchin wrote:
> 
> > With the BPF verifier now treating pointers to struct types returned
> > from BPF kfuncs as implicitly trusted by default, there is no need for
> > bpf_get_root_mem_cgroup() to be annotated with the KF_ACQUIRE flag.
> 
> > bpf_get_root_mem_cgroup() does not acquire any references, but rather
> > simply returns a NULL pointer or a pointer to a struct mem_cgroup
> > object that is valid for the entire lifetime of the kernel.
> 
> > This simplifies BPF programs using this kfunc by removing the
> > requirement to pair the call with bpf_put_mem_cgroup().
> 
> It's actually the opposite: having the get semantics (which is also
> suggested by the name) allows to treat the root memory cgroup exactly
> as any other. And it makes the code much simpler, otherwise you
> need to have these ugly checks across the codebase:
> 	if (memcg != root_mem_cgroup)
> 		css_put(&memcg->css);

I mean, you're certainly not forced to do this. But, I do also see
what you mean.

> This is why __all__ memcg && cgroup code follows this principle and the
> hides the special handling of the root memory cgroup within
> css_get()/css_put().
>
> I wasn't cc'ed on this series, otherwise I'd nack this patch.
> If the overhead of an extra kfunc call is a concern here (which I
> doubt), we can introduce a non-acquire bpf_root_mem_cgroup()
> version.
> 
> And I strongly suggest to revert this change.

Apologies, I honestly thought I did CC you on this series. Don't know
what happened with that. Anyway, I'm totally OK with reverting this
patch and keeping bpf_get_root_mem_cgroup() with KF_ACQUIRE
semantics. bpf_get_root_mem_cgroup() was selected as it was the very
first BPF kfunc that came to mind where implicit trusted pointer
semantics should be applied by the BPF verifier.

Notably, the follow up selftest patch [0] will also need to be
reverted if so as it relies on bpf_get_root_mem_cgroup() without
KF_ACQUIRE. We can probably 

[0] https://lore.kernel.org/bpf/20260113083949.2502978-2-mattbobrowski@google.com/T/#mfa14fb83b3350c25f961fd43dc4df9b25d00c5f5

