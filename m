Return-Path: <bpf+bounces-56456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28036A97A25
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 00:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73F73BDAAD
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 22:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451B729C34E;
	Tue, 22 Apr 2025 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXmm5xMB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11F1FF5E3
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359787; cv=none; b=fIBpmvMWTc/37fJ1jB6aifcyFn8BdvjHHBhNjBwVVtk2v6qVSltpcnMM6QlD8vYdgCZmeLyaodRnpiUv8Cd390RaYhoAwlvMLd7Oy4NwgBCub97aam3ypYVDafl91NkKQX0Yd6AD3aFHcfn5J2UuvVJo6vlbohbjEpZLCqacyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359787; c=relaxed/simple;
	bh=6Pov1BS1TmZq7K0vbSry2YqPJik9K73XA20VD0iKSgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L7C38TD8AzMiig7USJQHDjK6BcgoPkts829RQd9A3aEunVqBoJl7gjs8pFW2CuUyN3lM8Oj1AqdhA5NWFD0Uk2Qn09EMEGiK29wYAree3p+tyvHkuyuW+d050TmdjaRYUQVn0oD+oY22YUJFzqZMv81v6XJcWGwvCCGcArPIZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXmm5xMB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c3e7b390so4988887b3a.2
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745359785; x=1745964585; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yriTxxQZ5vgVX2CV9Mj1FJU4e3xR5XudM1J/tuwcAuI=;
        b=QXmm5xMBGFtEdHkdsLtIzJXitOn4bY/Z6lgpmU9onnuC23CIXGLlP7ULNSdHrbaieW
         G74OQqPnwNd0vPCt2T06MJ/HK71K3ok6CE15HSVRvpsx/6AzIwMzmhoMZUBZY47lVfz6
         OSvx+EZXIFlDmZbekPYXppWF91IrWb0xnoEpzV/JvyabOlDPYSAHHfJxIIkrvObNxlAb
         yJup05hKRuOrN4z2kzJX3D/x0V1CUS79KQn0bS8Ad/bvp+pzLBIAp01uWdwqLZHfkUrT
         ryiz1iJ3/8KyhrVbHxD6vcOSrE6I/MgSfsnVHNKuEzx2rjRV8cZwmEhywtffzjVxzKSQ
         gznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359785; x=1745964585;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yriTxxQZ5vgVX2CV9Mj1FJU4e3xR5XudM1J/tuwcAuI=;
        b=qjqGiEUTXkva5IUn0uAlUiEQ4gqplAV4/0TobmAX/kPnAN3yD/SiVQvKiykBLcoLEO
         sJkpzfL04HCj0dz9mDw3AURmxgLTsg7nUqh17c1WSYj45XeV/Pu99A11IUvjQTHOBh9Y
         9PhVXhV58JCYyXsDycjcRPg9eEiekt3YFbRg55+fDq7UGz0QiKe/gYRj1wfblgIyjRFs
         pK44M1fFsrFghvx9jC8PBcdci1He2UyUPJBBIoczeTyus8QLKLyK8Mb98UinQPBM4kv/
         GGsMjBYWtOoMlr5hnjuVIrFg3o2ZOfBjTZRHsY87BYoJ41jpYRlctP8JMsRVENwPRtUH
         hzYQ==
X-Gm-Message-State: AOJu0YwBiE68HIAltZqsgtfa7WJDVCNs4feqFxV6ug41cEMtzlBLslQV
	znuStd6W6zrfu+kLMoXnFrJ02UpxP982m29MUgJjXvXDCxntk3BD
X-Gm-Gg: ASbGncu7kTQRJxDsoVFYwfh4s2FStoagxDI7LCeNIelOSV80gh4JTPo1sVPkSXOzWhC
	5LAejR9g3fMVaT255sZ9UIVN1ruQRt1u6wpV1ipuVh1B1FNdudy77dqcnaPHipP29YzmbWqYX/W
	m84cB3wL8JBuBvLzBd0Wr1cV4ABfmNMDH07/dtsqwcrJAzxzT74w5+m97Gk/Mr86sMGR4Qdxcpk
	fq0h5R0IV9uwZDKFvciny+gEN4Hd4JJctYXcchxRpKd7eyx1z04uGCrAXdXaJCOEy6dH3jQsN8u
	z93JHS3v8fQjmcrawpFDOOu+nIC7o0bGv9mVWfE4JkV4
X-Google-Smtp-Source: AGHT+IEkKYv9N/phCZ4jsLIkfGNV40kGxyYZ4GLy1wrH6h5WSqY+hRrW/wIUgMzeu2ByEi1z29oRIA==
X-Received: by 2002:a05:6a00:1909:b0:730:95a6:375f with SMTP id d2e1a72fcca58-73dc14111d1mr23469639b3a.3.1745359785501;
        Tue, 22 Apr 2025 15:09:45 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:9822])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa588b9sm9252133b3a.117.2025.04.22.15.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:09:45 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 07/13] bpf: Introduce per-prog
 stdout/stderr streams
In-Reply-To: <CAP01T77jqjoO3pc-V7qvsck1A9KJ-1u60ryouLL68ctHz2M=mQ@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Thu, 17 Apr 2025 22:06:58
	+0200")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-8-memxor@gmail.com> <m2plhbu68v.fsf@gmail.com>
	<CAP01T77jqjoO3pc-V7qvsck1A9KJ-1u60ryouLL68ctHz2M=mQ@mail.gmail.com>
Date: Tue, 22 Apr 2025 15:09:42 -0700
Message-ID: <m25xivrgpl.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

> > > +BTF_KFUNCS_START(stream_consumer_kfunc_set)
> > > +BTF_ID_FLAGS(func, bpf_stream_next_elem_batch, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> > > +BTF_ID_FLAGS(func, bpf_stream_free_elem_batch, KF_RELEASE)
> > > +BTF_ID_FLAGS(func, bpf_stream_next_elem, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> > > +BTF_ID_FLAGS(func, bpf_stream_free_elem, KF_RELEASE)
> > > +BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)
> > > +BTF_ID_FLAGS(func, bpf_prog_stream_put, KF_RELEASE)
> > > +BTF_KFUNCS_END(stream_consumer_kfunc_set)
> >
> > This is a complicated API.
> > If we anticipate that users intend to write this info to ring buffers
> > maybe just provide a function doing that and do not expose complete API?
>
> I don't think anyone will use these functions directly, though they
> can if they want to.
> It's meant to be hidden behind bpftool, and macros to print stuff like
> bpf_printk().
>
> We cannot pop one message at a time, since they are not in FIFO order.
> So we need to splice out the whole batch queued and reverse it, before
> popping things.
> It's a consequence of using lockless lists.
>
> The other option is using a lock to protect the list, but using
> rqspinlock to then report messages about rqspinlock sounds like a
> circular dependency.

The API exposes 6 kfuncs and 3 data structures.
If things are exposed these things would be used, I wouldn't assume
that bpftool would be the only user. I'm sure people would craft their
own monitoring solutions.

Imo, exposing 9 entities is a lot. What I don't like about it,
is that API is not abstract:
- user cares about getting program log to some buffer, stream or file;
- user does not care how the strings are split internally in order to
  make logging efficient.

If at some point we decide to change implementation this API would be
hard to preserve.

Hence I suggest to instead provide a set of kfuncs that would drain
message queue into user provided ringbuf or buffer, w/o exposing
details.

A question: why exposing this functionality as kfuncs and not BPF
syscall commands?

