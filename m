Return-Path: <bpf+bounces-21959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A485440C
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 09:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381941F280A4
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4171C02;
	Wed, 14 Feb 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVO1wnQi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5717CE
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899430; cv=none; b=IHc6+5Haqlj1eDpN1nl4hHsx9M0vM2WK5aPE9fmvVCXxYx8uLGJVCpqDx3koPjh9Nuo6DD09cU6CcpvnOui3BVgu8Jwwff7ZFF9u6oXF58V7/8YCyh2QpEtO3GKTZS7q1m/NIp437CtkzSSC/zDDqxoz297jCoMQIbp/GCdag8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899430; c=relaxed/simple;
	bh=pmsbHnq53dvCu6VkhtDW1C/d0U2G02STvjn7R7Aakhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQy0G/o31+YALR+sS+TvlFfDZeuZUITyWyO67gw5xD2p1cnnzBc7tvucuKSgiaNYDml+W2C5zwZpqQuS59uxFa5j+D5Z6va8HgmEi9wo3Bs9/laIxyNlpV1NriVkwTw+ogCwipuPSeAk8pM+PHe6Bu8+HZUvemSpPTD+Xu7dauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVO1wnQi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a293f2280c7so732792466b.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707899426; x=1708504226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26O2FuJTwzbhBy6Xbqbt+4vu7+SCRCcjHZ9n12uzXFk=;
        b=gVO1wnQilenalop6YuUd7TCfhWRjzf5A7584x9W7B453KBA8Uu/dng3asphHe8adFU
         imnO8snZnSreo+79rce2vEPgvbujKWeszaTDMiGnOwkQjvlXWSOnJNFIUJg/x3hzzjwv
         jcw6HlqoVSyJhqgoM6wqz0bPwBv+my4V5kLJYDzymxv5mt6BOhkq/CNXFk4mZ4mpRB+2
         V56IPlUtfB4WzOfQpVmPf9G9xzJNJMVv6VzxIPn2K6uDnhu778tUPcRcuKnuA7w73OiU
         yQbLLJ7QFpbhDgf13TdaUc7dKk8Co9sTQ1tHXHYNfJq6xIu1/Pn7NUsSj/Ni3Erk0wx1
         ooHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707899426; x=1708504226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26O2FuJTwzbhBy6Xbqbt+4vu7+SCRCcjHZ9n12uzXFk=;
        b=XwxmFNBcB/v0jR7+1m8t58om83ywFXXm4zh+HJentj/kBKMDTxa2ZMsmk167jxIcS4
         5QhZQ7/faz+8/qtcPffNBABHTyv52q+PycqeCg4wnCm1X5BgHdXfOq4iRT+lkTQd1o0Y
         ZuRmyO5JRv5e7JE7sR2nKDiQa6TjEv0Hcb8uwketLqUU15zkxZAnuzgqzC0KNk3PGlMT
         ngzRGmJZuuoPWzNqSb8LPpbiliYvJF/Kg2zMfdQsuD1o0r/CB40HUxnw2wQDzLSPg0hD
         /s/Mi39Yl7yQL8storizBXll2pD0QxXgdeghKnXmYq5KmdCoWgvZwe14HwwLgRdy98rG
         b78w==
X-Gm-Message-State: AOJu0YxHF8cUpqscdRHmHcnBJLyHT31LjjYER0xc9caLKvFnTir28/g4
	B5qHiT1yXWe7amMcUuBBMAqewOvKiIUJQQ/24rxsTfO3VXZ/P8DQD5G3qKp9BmXmuhj+TcyRbPt
	ZGQ==
X-Google-Smtp-Source: AGHT+IFdPqwPI7ecyd8++xAcwtFFJrZpfEjQ9HqIqVSWEt80UlN+OsVc8uBwawZjmMGjOM4lFn3LgA==
X-Received: by 2002:a17:906:e2c4:b0:a3d:5c4b:323b with SMTP id gr4-20020a170906e2c400b00a3d5c4b323bmr273479ejb.14.1707899424395;
        Wed, 14 Feb 2024 00:30:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0GiDbg84wC7qNi3DalIiX1FmIscyqR3twbf/P0UoEdwonPbjF1VbMRMR/Qw57TOpPy25XiTrPpxuqAHK1o1vQCQL9GuQ+lGYO10U/DrHHhmM=
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id vh8-20020a170907d38800b00a3d0e9bdc35sm1239174ejc.68.2024.02.14.00.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:30:23 -0800 (PST)
Date: Wed, 14 Feb 2024 08:30:20 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Subject: Re: [PATCH v2 bpf-next] libbpf: make remark about zero-initializing
 bpf_*_info structs
Message-ID: <Zcx6HKU65CD2hKj-@google.com>
References: <ZcxsEQ8Ld_hqbi7L@google.com>
 <Zcx4mbzhFBGJp36N@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcx4mbzhFBGJp36N@krava>

On Wed, Feb 14, 2024 at 09:23:53AM +0100, Jiri Olsa wrote:
> On Wed, Feb 14, 2024 at 07:30:25AM +0000, Matt Bobrowski wrote:
> > In some situations, if you fail to zero-initialize the
> > bpf_{prog,map,btf,link}_info structs supplied to the set of LIBBPF
> > helpers bpf_{prog,map,btf,link}_get_info_by_fd(), you can expect the
> > helper to return an error. This can possibly leave people in a
> > situation where they're scratching their heads for an unnnecessary
> > amount of time. Make an explicit remark about the requirement of
> > zero-initializing the supplied bpf_{prog,map,btf,link}_info structs
> > for the respective LIBBPF helpers.
> > 
> > Internally, LIBBPF helpers bpf_{prog,map,btf,link}_get_info_by_fd()
> > call into bpf_obj_get_info_by_fd() where the bpf(2)
> > BPF_OBJ_GET_INFO_BY_FD command is used. This specific command is
> > effectively backed by restrictions enforced by the
> > bpf_check_uarg_tail_zero() helper. This function ensures that if the
> > size of the supplied bpf_{prog,map,btf,link}_info structs are larger
> > than what the kernel can handle, trailing bits are zeroed. This can be
> > a problem when compiling against UAPI headers that don't necessarily
> > match the sizes of the same underlying types known to the kernel.
> > 
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> > ---
> >  tools/lib/bpf/bpf.h | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index f866e98b2436..3ed745f99da3 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -500,7 +500,10 @@ LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
> >   * program corresponding to *prog_fd*.
> >   *
> >   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> > - * actual number of bytes written to *info*.
> > + * actual number of bytes written to *info*. Note that *info* should be
> > + * zero-initialized before calling into this helper. Failing to zero-initialize
> > + * *info* under certain circumstances can result in this helper returning an
> > + * error.
> >   *
> >   * @param prog_fd BPF program file descriptor
> >   * @param info pointer to **struct bpf_prog_info** that will be populated with
> > @@ -517,7 +520,10 @@ LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
> >   * map corresponding to *map_fd*.
> >   *
> >   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> > - * actual number of bytes written to *info*.
> > + * actual number of bytes written to *info*. Note that *info* should be
> > + * zero-initialized before calling into this helper. Failing to zero-initialize
> > + * *info* under certain circumstances can result in this helper returning an
> > + * error.
> >   *
> >   * @param map_fd BPF map file descriptor
> >   * @param info pointer to **struct bpf_map_info** that will be populated with
> > @@ -530,11 +536,14 @@ LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
> >  LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info, __u32 *info_len);
> >  
> >  /**
> > - * @brief **bpf_btf_get_info_by_fd()** obtains information about the 
> > + * @brief **bpf_btf_get_info_by_fd()** obtains information about the
> >   * BTF object corresponding to *btf_fd*.
> >   *
> >   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> > - * actual number of bytes written to *info*.
> > + * actual number of bytes written to *info*. Note that *info* should be
> > + * zero-initialized before calling into this helper. Failing to zero-initialize
> > + * *info* under certain circumstances can result in this helper returning an
> > + * error.
> >   *
> >   * @param btf_fd BTF object file descriptor
> >   * @param info pointer to **struct bpf_btf_info** that will be populated with
> > @@ -551,7 +560,10 @@ LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info, __u
> >   * link corresponding to *link_fd*.
> >   *
> >   * Populates up to *info_len* bytes of *info* and updates *info_len* with the
> > - * actual number of bytes written to *info*.
> > + * actual number of bytes written to *info*. Note that *info* should be
> > + * zero-initialized before calling into this helper. Failing to zero-initialize
> > + * *info* under certain circumstances can result in this helper returning an
> > + * error.
> 
> this is slightly misleading, because like for uprobe/kprobe multi links we normally
> call bpf_link_get_info_by_fd twice, first time with zero initialed info to get the
> static data and then again with info filled with user space buffer pointers to get
> other data like addresses or cookies.. I think to some extend this is similar also
> for bpf_prog_get_info_by_fd

Ah, you're right, it is slightly misleading as the current wording
implies that the supplied buffer must always be zeroed out, when in
reality that's not true.

> maybe something like:
> 
> Note that *info* should be zero-initialized or initialized as expected by the
> requested object type. Failing to (zero)initialize *info* under certain circumstances
> can result in this helper returning an error.

I'll adapt as per your recommendations and then resend this through
once again.

Thanks for the feedback!

/M

