Return-Path: <bpf+bounces-75242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F571C7ADED
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 17:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 761953599ED
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40E287506;
	Fri, 21 Nov 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duqw/79B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDC2773C1
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742904; cv=none; b=c80g6VtAdcgfCb5G5lQDwtnD4YJwthSY/nNwfXg9/Y39OKlaqU2PK8/qZmynwxkxlJH8V8vyF9JSMAnrW6IrY64uzfYzxeGF3ASONInarPIFm/SmegzvzUjsc3lGYe4FA47bREkC88yiMu7uOMyGASC+dYyRqnPX1Zfii9yyPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742904; c=relaxed/simple;
	bh=32SWEfk+OG4SI3fuk6dXDc3Ips4hxRT5KuSSBtErlqU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+jFegIe3fhE7uqMnCdv0PmSqcANTSDcz145dS15xFGvWvMlGtTKth19RR9+hBPf46+zv7URT9z9cGUMigDkwjwN7jodrhF+wBQW7SMLNtZwqTGKPug3LZsJ7KWpUtKUjldqh28yEozNDhmhgZVTYHo3vCs6y7bvEHaLEzyUQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duqw/79B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47796a837c7so14789145e9.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 08:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763742898; x=1764347698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeBh4Bmf/10he6RTgyJAy/hm7lbhgMBwonk4NxPOv6g=;
        b=duqw/79BImHtOPugtCkXpy+YPsdd9KPXg6FuP7p1jllnYI/RVkvP2qTu8evEYpOuL0
         FFeSf56qsiv1x8M5C13TU6xNwpzChBI1RM/HzkBxFUE+KKCbrpiLAsksEwEznuJPKkwq
         iNlXuXjgCvcgEQ6jIj7fZr5hUtPH34drSSJiz6gqGjubdiutFiqIx3Yu/mi6sE6sHlVd
         6YacpbM/UCqQpbZGTiB8wd+wcvJlPAP1sdgCzjz9M1JkUPsTcoPnJEW3YPVou0OyZzbl
         A4A1Th+Zj16KqDFoGxflN7mvcYkAijUvWCWaCqtnGfejF0gn0YgOCxpF0PhPrN1vGcgb
         MxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763742898; x=1764347698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeBh4Bmf/10he6RTgyJAy/hm7lbhgMBwonk4NxPOv6g=;
        b=DjaJ5d7eZ1tUpPjWkkeOSDK2AnU2f47ENZ0wVH4v4RY/90YH13pfZYZiVMwPj1Q8i9
         WAO85Oyy8x1TdkK8kAOYMEx0MWHUdfwlhHj/3c/tYM/e7mVbkEMkTLhXbN4JGJRMxE8i
         TrMaTpZH8GBM9zx0eJ0WZldKxqsyU4qh+X6g6cSFPXIiClBDvvwrLEiBvKfQjF4lHJhI
         TV0BfLF8+HK+FFi5UUvUZq+K9zDXAAzNvZY6fxAWInFZQzGXELjkG7tiI8zzLgqUPp0O
         Il+h+Cg9rgtEI/AUSQRUwf3dnfyQ+cSh1ZQGxbLe3cBMe7LtSRMELBcY5HDSIaHnqcTP
         0e1Q==
X-Gm-Message-State: AOJu0YyfTBgJ3KdHEyAPAdWdETrLDkzKD/AR92AKWUTRy9WhfeA17jcm
	tlQPSdJH7L9uY+CUJ9H+8HwXG+Q/FWtxLBH/39i3ARpMs83Z9Apxr1A4
X-Gm-Gg: ASbGnctAy8LkrmH6NeaEAbKzcbjtZ+1usA7hd0RH6A4TWibm/w6wah9JJwLHedtcvA7
	p7CQu2zIULtsVbkNIHAqdH72fMoxCLJxp04rF7WLPZjmeRV9lLH3MzA7DNI7Clv0hAlj/lCLEeV
	Tls5LS6FPPqKrI0Pi7PDL8HZwJ/rFBcamzVsU1v2qEkXJ1RYPz+PZJjB6yPe30L2r0pKpRNa9m9
	ayUDuMndmHVGFGkwvNeztdE+OSzbCnYDJY08tg4buz48KcHCZah61zpIPFQnmmVj5dUyEkaIYSw
	ugs9VXnj14fHO/Rgz7NZaGgnelJIQqp8jFHPbZnSShQ/4XQBVrz+2csAKEhYC4ZFUaVO9+H580W
	X2UHarq0uPSwgV29YaHm8L4Q2rnyQc/MO31/6Dl7ksxML9CWhto+V1zDiRqxK3UcpQTPGJjyl6U
	YV39ij
X-Google-Smtp-Source: AGHT+IEKdc92wQhMBHJXAveRBg7fiF+sSYb2PsxuIGwuTPQH/pLO5VsLsMQfdUdHa4/EJSA5dpNgdA==
X-Received: by 2002:a05:600c:310d:b0:477:9fcf:3ff9 with SMTP id 5b1f17b1804b1-477c01c359fmr32515485e9.27.1763742898107;
        Fri, 21 Nov 2025 08:34:58 -0800 (PST)
Received: from krava ([2a00:102a:500a:1917:4c7b:f90f:b94c:79b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf35f976sm52771145e9.4.2025.11.21.08.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:34:57 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Nov 2025 17:34:54 +0100
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH bpf-next 1/7] bpf: Set up update_prog scaffolding for
 bpf_tracing_link_lops
Message-ID: <aSCUrtsBrfS2iTkB@krava>
References: <20251118005305.27058-1-jordan@jrife.io>
 <20251118005305.27058-2-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118005305.27058-2-jordan@jrife.io>

On Mon, Nov 17, 2025 at 04:52:53PM -0800, Jordan Rife wrote:

SNIP

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index f62d61b6730a..b0da7c428a65 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -63,6 +63,8 @@ static DEFINE_IDR(map_idr);
>  static DEFINE_SPINLOCK(map_idr_lock);
>  static DEFINE_IDR(link_idr);
>  static DEFINE_SPINLOCK(link_idr_lock);
> +/* Synchronizes access to prog between link update operations. */
> +static DEFINE_MUTEX(trace_link_mutex);
>  
>  int sysctl_unprivileged_bpf_disabled __read_mostly =
>  	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
> @@ -3562,11 +3564,77 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
>  	return 0;
>  }
>  
> +static int bpf_tracing_link_update_prog(struct bpf_link *link,
> +					struct bpf_prog *new_prog,
> +					struct bpf_prog *old_prog)
> +{
> +	struct bpf_tracing_link *tr_link =
> +		container_of(link, struct bpf_tracing_link, link.link);
> +	struct bpf_attach_target_info tgt_info = {0};
> +	int err = 0;
> +	u32 btf_id;
> +
> +	mutex_lock(&trace_link_mutex);

that seems too much, we could add link->mutex

> +
> +	if (old_prog && link->prog != old_prog) {
> +		err = -EPERM;
> +		goto out;
> +	}
> +	old_prog = link->prog;
> +	if (old_prog->type != new_prog->type ||
> +	    old_prog->expected_attach_type != new_prog->expected_attach_type) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	mutex_lock(&new_prog->aux->dst_mutex);
> +
> +	if (!new_prog->aux->dst_trampoline ||
> +	    new_prog->aux->dst_trampoline->key != tr_link->trampoline->key) {

hum, would be easier (and still usefull) to allow just programs for the same function?

> +		bpf_trampoline_unpack_key(tr_link->trampoline->key, NULL,
> +					  &btf_id);
> +		/* If there is no saved target, or the target associated with
> +		 * this link is different from the destination specified at
> +		 * load time, we need to check for compatibility.
> +		 */
> +		err = bpf_check_attach_target(NULL, new_prog, tr_link->tgt_prog,
> +					      btf_id, &tgt_info);
> +		if (err)
> +			goto out_unlock;
> +	}
> +
> +	err = bpf_trampoline_update_prog(&tr_link->link, new_prog,
> +					 tr_link->trampoline);
> +	if (err)
> +		goto out_unlock;
> +
> +	/* Clear the trampoline, mod, and target prog from new_prog->aux to make
> +	 * sure the original attach destination is not kept alive after a
> +	 * program is (re-)attached to another target.
> +	 */
> +	if (new_prog->aux->dst_prog)
> +		bpf_prog_put(new_prog->aux->dst_prog);
> +	bpf_trampoline_put(new_prog->aux->dst_trampoline);

would it be possible just to take tr->mutex and unlink/link
the programs, something like:

        mutex_lock(&tr->mutex);

	__bpf_trampoline_unlink_prog(old_prog)
	__bpf_trampoline_link_prog(new_prog)

        mutex_unlock(&tr->mutex);

I might be missing something but this way we wouldn't need
the arch chages in the following patches?


jirka


> +	module_put(new_prog->aux->mod);
> +
> +	new_prog->aux->dst_prog = NULL;
> +	new_prog->aux->dst_trampoline = NULL;
> +	new_prog->aux->mod = tgt_info.tgt_mod;
> +	tgt_info.tgt_mod = NULL; /* Make module_put() below do nothing. */
> +out_unlock:
> +	mutex_unlock(&new_prog->aux->dst_mutex);
> +out:
> +	mutex_unlock(&trace_link_mutex);
> +	module_put(tgt_info.tgt_mod);
> +	return err;
> +}
> +
>  static const struct bpf_link_ops bpf_tracing_link_lops = {
>  	.release = bpf_tracing_link_release,
>  	.dealloc = bpf_tracing_link_dealloc,
>  	.show_fdinfo = bpf_tracing_link_show_fdinfo,
>  	.fill_link_info = bpf_tracing_link_fill_link_info,
> +	.update_prog = bpf_tracing_link_update_prog,
>  };
>  

SNIP

