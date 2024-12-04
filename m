Return-Path: <bpf+bounces-46071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655389E39B9
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 13:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202B1165174
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A91B415E;
	Wed,  4 Dec 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="D9eCJIDv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B182126C10
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314802; cv=none; b=di6rF5QcW9SI7gH8U6P15yrIJKDGbe/hITcTCIBcjrgcc5KeCDiv/Y1btTklOvR5Vk1HGcIUlztCsB827ReWbh5Y/p4ybZBC31l5KW8jj9u9LOJZsRqnAmn73eam8lshj1wCQMkxtv69JazcWoBYsRXjimuIFlYa8pKQz2umpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314802; c=relaxed/simple;
	bh=ioAxq0SzJKRU3/VWrwmGMO2cLLomTTHNAqcdYdk/wQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD6Ecvv50lXf3LPIemsIKXJ35nUOrRC2/pf+dqmDGe2MUn15tdQOifezOxvljEP+bbPdIis9PvBj/xYCEAvRw5DksmQoHqMn+7d1W5zmKJdK28mimr9NqfoeI66qqskNxA+omY3bQfXvblC31QZ3vgvKo0cpAAPQWIK2BPnEYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=D9eCJIDv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434aa472617so55263295e9.3
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 04:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733314798; x=1733919598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gGTwo5hAh93+LPzxiUpW7oMfvLmndHCDHXauAdKEOgc=;
        b=D9eCJIDv2sg5FQc43VAEIKQcl/wBRHHvjiEhMDOzZ+tXr3ZqeUC7G1zQP4b0khO9oa
         hKuJ/6ljVrJZM+rjmeIaVc7iVDOVd7hzFs4xCSIJ5OmFOCBUU3/bquzNNvEpwX8+1zi3
         3L1TuUTaHbr4uaCqshS2D0VH1aT6248izhzTKGX2GvT2qBDgTlK0ccNQXumRc5GV55R6
         0eDGsyLCqxrcNIK9tmdmHUTsWMgp9mGOfw4lhA6+VpkR2LvT8P0hHt4wvj4qc+sEaQa1
         5tnSncsSMYVJGlpqKVi62048nJUJxfhPikRRLOhKFCpmqEDB3usnIFznrH7P7psEgKun
         Bq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314798; x=1733919598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGTwo5hAh93+LPzxiUpW7oMfvLmndHCDHXauAdKEOgc=;
        b=XZQWjwGPvZyN/N6N1lSjGclmCyrO//WlF61N+E1HxUcn6vp0MH4+jznqk7JagjG5Lb
         NQYICS8+6b5WVEOqT0cOmF8DOUVXOHXWiqfgUQnZFsIkt1xK7gVf/G7IKM3JN+rdleiA
         ivKzW8ofw56OhFBFg2bVGqYP44Vx/cgmapQbcCsnj7TXX/G/e7j6BjG6U8Zw9i9ii2+D
         tw4qs4tyKHULoUsMLc+jHgBJxQl3/XaSMJ6yaJ0Lr9cbYMJLLpPHacoNUMafdkRWzJEM
         03ogVp1xhuGTYcC54tLtH/0UzgY79MVkuA9vABfK6T6+wYcWvmZ4FomCStifmOfmdicX
         ZD5w==
X-Gm-Message-State: AOJu0YxuX+KoTWqnQFsIUjK29Wj9Waor13TNn5dL6pd93OV9CfUH3O11
	rjr6zum1ZsfNdIHFfEFd4rng/iVkClCQBGqHN2Lt+u2wAUMzVrlSUPj+pKeFh0/fF8hNpjmNhDE
	o
X-Gm-Gg: ASbGnctZAlKNvuHNAgRvamDxAHqD9pNnGZWGDBPtVKEyoBj8M/0/4zLtK+7P5TI3ju4
	zDlPFiC934GwHPAlGzx9Jvi9FXgykZZZmC3uFW7GhPy8flStVPoDU1Q8QKVDAU+ARU6ujwhsTcY
	tPaUCLyVhNiMG8L3rJEBV7q8g8wEmH8ofWEXLbTKGugh9MqEN/B1ttvcBZkMPqhmHjVelC+QJOQ
	mpIfsrjX8Owz1GkU/Y2EHCm70Ig+raOQc7++Wk=
X-Google-Smtp-Source: AGHT+IFS2m2UiFo8AMRzP6Hhr+rnc5gxKLVKydzaB8fqftdKyRs/grOBpmJrW3wOlXDqlFQI5ug5YQ==
X-Received: by 2002:a05:600c:4586:b0:434:9da3:602f with SMTP id 5b1f17b1804b1-434d09cecd9mr57517565e9.16.1733314798492;
        Wed, 04 Dec 2024 04:19:58 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e230b283sm13344259f8f.106.2024.12.04.04.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:19:58 -0800 (PST)
Date: Wed, 4 Dec 2024 12:22:11 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z1BJc/iK3ecPKTUx@eis>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
 <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>

On 24/12/03 01:25PM, Andrii Nakryiko wrote:
> On Tue, Dec 3, 2024 at 5:48 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
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
> >  include/uapi/linux/bpf.h       | 10 ++++
> >  kernel/bpf/syscall.c           |  2 +-
> >  kernel/bpf/verifier.c          | 98 ++++++++++++++++++++++++++++------
> >  tools/include/uapi/linux/bpf.h | 10 ++++
> >  4 files changed, 104 insertions(+), 16 deletions(-)
> >
> 
> [...]
> 
> > +/*
> > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
> > + * this case expect that every file descriptor in the array is either a map or
> > + * a BTF. Everything else is considered to be trash.
> > + */
> > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> > +{
> > +       struct bpf_map *map;
> > +       CLASS(fd, f)(fd);
> > +       int ret;
> > +
> > +       map = __bpf_map_get(f);
> > +       if (!IS_ERR(map)) {
> > +               ret = __add_used_map(env, map);
> > +               if (ret < 0)
> > +                       return ret;
> > +               return 0;
> > +       }
> > +
> > +       /*
> > +        * Unlike "unused" maps which do not appear in the BPF program,
> > +        * BTFs are visible, so no reason to refcnt them now
> 
> What does "BTFs are visible" mean? I find this behavior surprising,
> tbh. Map is added to used_maps, but BTF is *not* added to used_btfs?
> Why?

This functionality is added to catch maps, and work with them during
verification, which aren't otherwise referenced by program code. The
actual application is those "instructions set" maps for static keys.
All other objects are "visible" during verification.

> > +        */
> > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > +               return 0;
> > +
> > +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> > +       return PTR_ERR(map);
> > +}
> > +
> > +static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> > +{
> > +       size_t size = sizeof(int);
> > +       int ret;
> > +       int fd;
> > +       u32 i;
> > +
> > +       env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> > +
> > +       /*
> > +        * The only difference between old (no fd_array_cnt is given) and new
> > +        * APIs is that in the latter case the fd_array is expected to be
> > +        * continuous and is scanned for map fds right away
> > +        */
> > +       if (!attr->fd_array_cnt)
> > +               return 0;
> > +
> > +       for (i = 0; i < attr->fd_array_cnt; i++) {
> > +               if (copy_from_bpfptr_offset(&fd, env->fd_array, i * size, size))
> 
> potential overflow in `i * size`? Do we limit fd_array_cnt anywhere to
> less than INT_MAX/4?

Right. So, probably cap to (UINT_MAX/size)?

> > +                       return -EFAULT;
> > +
> > +               ret = add_fd_from_fd_array(env, fd);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> 
> [...]

