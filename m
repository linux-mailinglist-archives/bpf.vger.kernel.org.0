Return-Path: <bpf+bounces-75230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D8CC79EA6
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 15:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444E04EB13B
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29134E763;
	Fri, 21 Nov 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF/GBOse"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7F23BD1A
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733189; cv=none; b=u1U9mCiE2ywIwTvc2adu4XrjWldkT28npUoSENjJbJ9BfeSxuTAMpugIBZRaY3WLJXmSCdUcR4Tkh/PEZBfTXCKw9bNQd25/+foyZQF2yKHp+EYpVa+nOAmZoD/Pc8ghBh5ynvHkv55DftE1Fw14ZWyS/nO9oOPgd4LBin7qFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733189; c=relaxed/simple;
	bh=Vs0n9+plsNCzPFHj8LtJuwnYS7N5jF9XX1ybVRqv2Po=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBkmhEWNFP7yZMADvXg2MNN8x/EmuGfMuABnEjyY7voMRdGyB9Vl05jxydZImS82L9/F81ULT+a0tRQkEUpW7JTgXmLemVTnbtC9e5uf5edMrtGzVMnIJlIYmAUTGcWb7a4s87hWvzQLpLDayEy7Xo56cadZaxLnwuxBa5U1ylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF/GBOse; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47790b080e4so11451515e9.3
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 05:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763733186; x=1764337986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9ZHAU96zRwC8rydbydanUtXN3FsFzz3+3+B+AWK6x0=;
        b=cF/GBOsevcacIQ1JV48DLuklvFOV+eBbikcHVIO1iOk8TGBztjNhb2DJ+r25+nzzEk
         ICkxPHk/Ao2onluv2xJXyHkaP+vhSYf7uS/tCONjc+s7e+82ZJmSzaNm1n7mBdNONU/z
         hOvRIsAz6eU1u56qLg4eJ/x91aSVtKHrwA6jVVfAu+Z0XW4nWKcaZfHbUk7XHSuvA6pX
         6Sfckl6Kycnw5rCGQJGRHmro9vEDcC1sLTAAqYMuetNZy0Qgs4bSkjmtcFi4FI96i9ca
         SZBeKMr5pA7HA9KaAsQLTuCxoJ9YgJckfyXleuhie/gp3TGm5hx3pjlCS2Duza7vEaCb
         c0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763733186; x=1764337986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9ZHAU96zRwC8rydbydanUtXN3FsFzz3+3+B+AWK6x0=;
        b=V8j1oFwJ52/BvjtDrPLnp2nYpnsaJDuw5AX0UqpZ7Meiwpjgq5fwMUfCl/q0xU8JX2
         KyqC0czO03d7HHOa3A4/wFFXxlo7zTBbI35uWEWws4JbO05JtnZTNzScfjo3Yxmcv4WM
         KiIQ1vue8ubr7Pr/iWStsy5tdVPHqZdAzka5WN7eSybn00Rve6iOJw6KwXuMm/W16mrf
         LGdEJbb/XGNw0jJlrzpSWxbarFNzJGzekL1yGyFBPsHFbqrgY9ZyXbuzeWapJtLlt0fo
         KyuWD267KUXnyJY8p0cJLvUyBr4zA6ZKARQqNcLPAeWoikeRHWiyMs46FOGNahpNOLuc
         Hniw==
X-Forwarded-Encrypted: i=1; AJvYcCUFbI2debklx99b2l56hHk9sqK/joZ243PfdNrmbyJY4azufwoad4lj9qs3T/wN3ZUdNMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNWNGRBAhT5pVh0VuxDLF0E4mfWoEh1AMArbEmunJN/6qd8+H
	zggSUotmiklPVYpIGp88dFvRa80Y1b2uFeASi6faiVbJ9RKXiMsirH9LdRmy6w==
X-Gm-Gg: ASbGncvKAcjG23Hy3pK04QA5+6/e3qSxn8HdwaFvsDkTam08QBZHWL5CmjKRZ/RChZQ
	GRuNkbydh5jybdyAIZp22XML34CqDdyiFyy0nlSsjHBuQcZ/IAWgASWFBxbbA2NI0+J6GotXPQz
	j5pic2UEYgdMg/2qpBoDlTpcJBCzekscvyUdbIuxCSH/FQ9K3grlx6jH6PXr1Rlg/ixwOgCahx2
	nbDZa0d6xDIIm7lrmRWwlLI6XDbOKdHPSV82Oda3GwUIL2z44Q6XRbJj17hkRT+f/jU8uooVs1J
	4VKx+iuLaFiqc+nMqAUU5fZKy6+yY6oNR+Bk3nK508Slhq9MmZrnDO1kyai/jU2woOag0cxFuYy
	U+5NoM7ZZYVPbdVMzSO+XbqSfho5wq8EdOBxhBXij2BmM8ysVblqxkv5iyAHM
X-Google-Smtp-Source: AGHT+IFuTvsjtGwTRPEN026FC2pczcZ8IxCeMFrd96paI0v/3ChPKOPZkThC91+ughQf8nM8pWwgpg==
X-Received: by 2002:a05:600c:1caa:b0:477:8b77:155f with SMTP id 5b1f17b1804b1-477c10d4935mr23861215e9.8.1763733185974;
        Fri, 21 Nov 2025 05:53:05 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm87267315e9.8.2025.11.21.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:53:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Nov 2025 14:53:03 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 5/8] ftrace: Add update_ftrace_direct_mod
 function
Message-ID: <aSBuv8Ab0y8SeAHS@krava>
References: <20251120212402.466524-6-jolsa@kernel.org>
 <a302c70bc1914835ea69c8b30105741b1d1d06d549ef95b9650d0827e0ca276a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a302c70bc1914835ea69c8b30105741b1d1d06d549ef95b9650d0827e0ca276a@mail.kernel.org>

On Thu, Nov 20, 2025 at 10:23:47PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index c571deeff..4e2c0ed76 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index cc730a8fd..5243aefb6 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> 
> [ ... ]
> 
> > @@ -6486,6 +6486,74 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  	return err;
> >  }
> >
> > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
> > +{
> > +	struct ftrace_hash *orig_hash = ops->func_hash->filter_hash;
>                                              ^^^^^^^^^^^^^^^^
> 
> Can this crash if ops->func_hash is NULL?  In update_ftrace_direct_add()
> and update_ftrace_direct_del(), there's a defensive check:
> 
>     old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> 
> But update_ftrace_direct_mod() dereferences ops->func_hash before any
> validation checks occur. The check_direct_multi(ops) validation happens
> later, but the dereference occurs first at function entry.

update_ftrace_direct_add is called before update_ftrace_direct_mod which
ensures the existence of the filter_hash, but same as for the update_ftrace_direct_del
case in the other reply, it's probably better to add the check for future

thanks,
jirka


> 
> > +	struct ftrace_func_entry *entry, *tmp;
> > +	static struct ftrace_ops tmp_ops = {
> > +		.func		= ftrace_stub,
> > +		.flags		= FTRACE_OPS_FL_STUB,
> > +	};
> > +	unsigned long size, i;
> > +	int err;
> > +
> > +	if (!hash_count(hash))
> > +		return -EINVAL;
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19552032346


