Return-Path: <bpf+bounces-45688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6E9DA26A
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 07:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A1F1677AB
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89117146019;
	Wed, 27 Nov 2024 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ZGTKARIE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085CEC2
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689705; cv=none; b=nlM9XEtYaxQngbqxIOaTU484V/1eOdDhjdYD6K1DKgZNlVmbh+Q8tuHYf8D+uJhVaIKudP94Dw8vCQ67DKyXmWWTlP72gVKuaLJVDv4t1RG4HZEGao1AuBEyQi42TBFg1TbyDMrOrsOkRndcQ5ydImlDj1mw4O/7RTpxSNVwEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689705; c=relaxed/simple;
	bh=JzuFVSVfNBlkIvanF7vzB3imktOHKZ7LIFm9+xTSZP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvoAlN3r7iQZQqnwAwwMCy66qMSJxKtOaFp3TQSIMAzKev0QCZdLD5zgvE6b8EH1IpqpBarsyGKF3KvzrljAMzk49nBv45fW/p3lLELVh2jWIs8uBn1gXPETqesiCWGwQCYuR2ndNcHnlDvfaVUkYJjiUnvQHLnHhJyVZo/gNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ZGTKARIE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a45f05feso21087235e9.3
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 22:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732689701; x=1733294501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0UKTU+RG8kNnKHRXnLz6NKW87+uLUuujS1P7KCpglY=;
        b=ZGTKARIE7D3j6eUR59Ya5jsNRugO8j9pGH+JLLRXYJRkpthgAfjZStOFvylSA5jNOQ
         b3jYt5bxHzCX6lS8WZOcS2ydARtA5pgDm/+hVw3DKaeV1adOi2tBs9EvQ858rxippMn0
         EYdygxxSXH+U6TFlssvv2r/3dUCTqNX3TyDu67wV51elsfEzACZO0CRL8yxsNXPwxznG
         QDWcBtaFUiaeopX9E7aiSt/8Vq2uy8wMtVQblKuZJhG46i1wL+gUQWros4fUNiP95hb8
         s852ZrGat8cUxVIW6Z2Aw96hfxaC9AR9At4oMKllgWFA1G49qTPLZqGq25+HhVkBXIG+
         EG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732689701; x=1733294501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0UKTU+RG8kNnKHRXnLz6NKW87+uLUuujS1P7KCpglY=;
        b=EMjCeMX0cSekaIvYIisWY7ugj0HntAaz2Ww4A4l8pnMJML7bkQuFsLJqv6pjrJlZdI
         nAYF4K2CFDGjETYK8yApHq/2H3H1yZiXqy4s10LRuvspv9seDM2oOfWh+hkVcQBQf1Uo
         ZI2hkj7PbPmGGa2aNZd1UZkARBh5/xAxShICYR7YAfzYy+JD6y4bV6MLSQKLJkkgkye/
         4o+Z4YLKIDpMH6zR0PNNu7Y3gyXMWp3EY0D1Rb+ZwUEj0hdQIZdGE4mPgnfENah8IZuu
         jpW2guUUSURqEb+T97IDzZXZ98W4+QWd9zhYUOxTVDcoHL7Rbpcp0jA/7kCne4zDYWdd
         8+SA==
X-Gm-Message-State: AOJu0YxXB1AiS6RraBzTzSjdPo6cAOrYgPxOurm3OAI6dSLfdlpB05+C
	8V0SaF6NLjXSSajztEwtw+RQgz6LgTLV+NE5Qo2D0jy1j1ikqwspFXRCaoWmIW/lniuJE5XGN4r
	I
X-Gm-Gg: ASbGncuDGpevaNQATiLEugNGfNB8l3zmytejVBCGf8OF4chrDIxR5H8jtoaGZesdlFh
	WrS2apOcdzXvR4C894Zi42JwKyC30NmFj4JXvY9X7EXrzZ0L3mfSXziu/eRi3c/kk5NHKRpCNO4
	OwDDwaCckaI3eyU/ozOxcrRAi1YnqfFxJc14k49f4/oi4vEKRruaSz4G4gydTq2GdzygO+inoIa
	sO4h3sh2WYLcON1YpoS5me5FlwCg5YeopFca1M=
X-Google-Smtp-Source: AGHT+IEoy7Yt0ienQolnArnSJGIFd5XQVOr2xq7Hy7cY2MMq5D6sSW3ewtkdeM9Bcm67i4SpuKaD1A==
X-Received: by 2002:a05:600c:3585:b0:434:a04d:1670 with SMTP id 5b1f17b1804b1-434a9d4f86dmr18362035e9.0.1732689701152;
        Tue, 26 Nov 2024 22:41:41 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a972c33csm15800145e9.1.2024.11.26.22.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 22:41:40 -0800 (PST)
Date: Wed, 27 Nov 2024 06:44:13 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z0a/vaxyp4Gnk3TE@eis>
References: <20241119101552.505650-1-aspsk@isovalent.com>
 <20241119101552.505650-4-aspsk@isovalent.com>
 <1b5f9aba-d7de-a677-0a5f-89237c8f62a4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5f9aba-d7de-a677-0a5f-89237c8f62a4@huaweicloud.com>

On 24/11/26 10:11AM, Hou Tao wrote:
> Hi,
> 
> On 11/19/2024 6:15 PM, Anton Protopopov wrote:
> > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> > of file descriptors: maps or btfs. This field was introduced as a
> > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > present, indicates that the fd_array is a continuous array of the
> > corresponding length.
> >
> > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > bound to the program, as if it was used by the program. This
> > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > maps can be used by the verifier during the program load.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  include/uapi/linux/bpf.h       |  10 ++++
> >  kernel/bpf/syscall.c           |   2 +-
> >  kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++-----
> >  tools/include/uapi/linux/bpf.h |  10 ++++
> >  4 files changed, 113 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 4162afc6b5d0..2acf9b336371 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1573,6 +1573,16 @@ union bpf_attr {
> >  		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
> >  		 */
> >  		__s32		prog_token_fd;
> > +		/* The fd_array_cnt can be used to pass the length of the
> > +		 * fd_array array. In this case all the [map] file descriptors
> > +		 * passed in this array will be bound to the program, even if
> > +		 * the maps are not referenced directly. The functionality is
> > +		 * similar to the BPF_PROG_BIND_MAP syscall, but maps can be
> > +		 * used by the verifier during the program load. If provided,
> > +		 * then the fd_array[0,...,fd_array_cnt-1] is expected to be
> > +		 * continuous.
> > +		 */
> > +		__u32		fd_array_cnt;
> >  	};
> >  
> >  	struct { /* anonymous struct used by BPF_OBJ_* commands */
> 
> SNIP
> > +/*
> > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.  In
> > + * this case expect that every file descriptor in the array is either a map or
> > + * a BTF, or a hole (0). Everything else is considered to be trash.
> > + */
> > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> > +{
> > +	struct bpf_map *map;
> > +	CLASS(fd, f)(fd);
> > +	int ret;
> > +
> > +	map = __bpf_map_get(f);
> > +	if (!IS_ERR(map)) {
> > +		ret = add_used_map(env, map);
> > +		if (ret < 0)
> > +			return ret;
> > +		return 0;
> > +	}
> > +
> > +	if (!IS_ERR(__btf_get_by_fd(f)))
> > +		return 0;
> 
> For fd_array_cnt > 0 case, does it need to handle BTF fd case ? If it
> does, these returned BTFs should be saved in somewhere, otherewise,
> these BTFs will be leaked.

ATM we don't actually store BTFs here. The __btf_get_by_fd doesn't
increase the refcnt, so no leaks.

> > +	if (!fd)
> > +		return 0;
> > +
> > +	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> > +	return PTR_ERR(map);
> > +}
> > +
> > +static int env_init_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> > +{
> > +	int size = sizeof(int) * attr->fd_array_cnt;
> > +	int *copy;
> > +	int ret;
> > +	int i;
> > +
> > +	if (attr->fd_array_cnt >= MAX_USED_MAPS)
> > +		return -E2BIG;
> > +
> > +	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> > +
> > +	/*
> > +	 * The only difference between old (no fd_array_cnt is given) and new
> > +	 * APIs is that in the latter case the fd_array is expected to be
> > +	 * continuous and is scanned for map fds right away
> > +	 */
> > +	if (!size)
> > +		return 0;
> > +
> > +	copy = kzalloc(size, GFP_KERNEL);
> > +	if (!copy)
> > +		return -ENOMEM;
> > +
> > +	if (copy_from_bpfptr_offset(copy, env->fd_array, 0, size)) {
> > +		ret = -EFAULT;
> > +		goto free_copy;
> > +	}
> 
> It is better to use kvmemdup_bpfptr() instead.

Thanks for the hint. As suggested by Alexei, I will remove the memory
allocation here altogether.

> > +
> > +	for (i = 0; i < attr->fd_array_cnt; i++) {
> > +		ret = add_fd_from_fd_array(env, copy[i]);
> > +		if (ret)
> > +			goto free_copy;
> > +	}
> > +
> > +free_copy:
> > +	kfree(copy);
> > +	return ret;
> > +}
> > +
> >  int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
> >  {
> >  	u64 start_time = ktime_get_ns();
> > @@ -22557,7 +22632,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >  		env->insn_aux_data[i].orig_idx = i;
> >  	env->prog = *prog;
> >  	env->ops = bpf_verifier_ops[env->prog->type];
> > -	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> > +	ret = env_init_fd_array(env, attr, uattr);
> > +	if (ret)
> > +		goto err_free_aux_data;
> 
> These maps saved in env->used_map will also be leaked.

Yeah, thanks, actually, env->used_map contents will be leaked (if
error occurs here or until we get to after `goto err_unlock`), so
I will rewrite the init/error path.

> >  
> >  	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
> >  	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
> > @@ -22775,6 +22852,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >  err_unlock:
> >  	if (!is_priv)
> >  		mutex_unlock(&bpf_verifier_lock);
> > +err_free_aux_data:
> >  	vfree(env->insn_aux_data);
> >  	kvfree(env->insn_hist);
> >  err_free_env:
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 4162afc6b5d0..2acf9b336371 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1573,6 +1573,16 @@ union bpf_attr {
> >  		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
> >  		 */
> >  		__s32		prog_token_fd;
> > +		/* The fd_array_cnt can be used to pass the length of the
> > +		 * fd_array array. In this case all the [map] file descriptors
> > +		 * passed in this array will be bound to the program, even if
> > +		 * the maps are not referenced directly. The functionality is
> > +		 * similar to the BPF_PROG_BIND_MAP syscall, but maps can be
> > +		 * used by the verifier during the program load. If provided,
> > +		 * then the fd_array[0,...,fd_array_cnt-1] is expected to be
> > +		 * continuous.
> > +		 */
> > +		__u32		fd_array_cnt;
> >  	};
> >  
> >  	struct { /* anonymous struct used by BPF_OBJ_* commands */
> 

