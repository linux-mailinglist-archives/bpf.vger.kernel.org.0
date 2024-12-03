Return-Path: <bpf+bounces-45996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A1B9E1942
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 11:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329CD165551
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCFA1E1A3B;
	Tue,  3 Dec 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ei1fs1mS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3071E0B6C
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221780; cv=none; b=UF+pIZNKcK3c11hLq3OgqvjHXZVUTavqoNcvX55vub8fNrr0m1CTq1NGlWFGI4MHmoWQPO5o10cKW4vhkMoKrKywMsTat3/azHsk7jqSzuJ6LP5gxbMgTGzIBtQuZtLrIYqtfZ8qTemcOBMmj5tOH7mLDoMEIYW9YxPzDEoH8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221780; c=relaxed/simple;
	bh=WfEqM5xplKpbMWb/k3pGtlJpHbKv45Q3OVAgi44f/5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL2ghVKJXpBBK4mb87r0ITWCNUs0Sj0Orerp1kNo1cy56AUGPnl+ccQ7UT51mpML6S1FRVMefkAO1JVyD9I15gP0Zrm5ETmM7v9J4I4bAxlgVPNg/G+53hrhsxR7AgJqJ7IHhlcZxTMpMK5dnQq9tOogGuCUbFIzvyrNScmauXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ei1fs1mS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so49164475e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 02:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733221776; x=1733826576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkiNQgk3NfPA/JEndzQjllNIKVCECDLdNNcQBpwtI9s=;
        b=ei1fs1mSnSqBRI0fvEYujhum4sh51WnjurcwoegG7plLEbeNTiBn441HufNd0eTWgO
         1kzbwr4GcmD3/douyfOfmwoipHq2wNAjL9WRFj+Vv9F9pf08sFXlrNjh33zKh3DotgIc
         RDTo2wImdrI05Ys9PptUkT9si8nv53AjLiYSIhWAIjvwdaP2b1gJERNgl3OdAaqPJ+Cz
         v3KvgjZfyT0mj8N4gnxHvWHYfzpP1S3InlqgUXYQEW8ZCNMEVrSG98pxV5UV5XA147MU
         xXbnK+6VSsKsB6oZ0n2C6D1vU4ZvbeCcdKmeN8HPkE7VFuDYsHuTvDf/cUcIG9HX8nI2
         3ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733221776; x=1733826576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkiNQgk3NfPA/JEndzQjllNIKVCECDLdNNcQBpwtI9s=;
        b=e+6F5HeGp9uLDyIDPkO8R3V2QkkMGUAnp1B0zKDPo8R99McGDipGnWUqEJ65k6urXG
         Jc0yNYQvk0pElSAxdNPRLuAHguBg/EUfkZRbBvrneTYPE8nmFOeFFO7QdxJXQZ5sBFRv
         pl5PQB4YwJHgV5o5E++f4y7WaNS5gkEb5mL/bBXC/SNe5+cdfJMo8BIpG6Y9JCLqh70q
         P4MNt4063Ok1DK0pJdoGd/jObMOfzQIIt5Wdpdr0Vr6vKHrRcY47EhT1mR71dJg/J9Cs
         7swkwKwG9uiDg9LIlL58kmtpl6k2en5Qo4E8dXAXjWru3Fnp/J2BffJZ1z4sooEQlbaQ
         RC/A==
X-Gm-Message-State: AOJu0Yy+4+OuxdWWrQb0E40rSzGZZ6KTazoQ1LKVJoIX2L4iITu16VlO
	zfEb29rCH5T+vaRiUxL6Ay5sy621DgbMGaSyjmg7VlC0m2DzVWw+j3R9xiHPkIk=
X-Gm-Gg: ASbGncsFYllcbLPQV717BfB8dmRpaHLAXhQh9q8l0htRzKm5DUvOJ9sJhgZmLGGxuP3
	OuRfha/4zXWJLgBdnoxXsuMDbOXbvQIs1L742zVSEwsDHMFOPVz/YLLgPcOhssZB1qBAF8RiXwt
	DJQoARBPXcBeI4myHEnIvWi1bl0ex3y1d6eWb0KxCdceCX+HCU6t9CQ90eFeXym6KXsX2M2iYAX
	jZsry/SzaPQOiPE08EuBiMJEW9scptBxUsltjQ=
X-Google-Smtp-Source: AGHT+IHnaZYzHD5L9Ps1qopmQbOlyyPlswazrxM2YGBmdyZ7ajUNFidWkMeAK47OGPMU7s5VWdH24A==
X-Received: by 2002:a05:600c:1c07:b0:434:a10f:9b with SMTP id 5b1f17b1804b1-434d09c0b93mr16519105e9.14.1733221776398;
        Tue, 03 Dec 2024 02:29:36 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70cbfsm188752475e9.36.2024.12.03.02.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:29:35 -0800 (PST)
Date: Tue, 3 Dec 2024 10:31:52 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 3/7] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z07eGFH+c6mX8bvg@eis>
References: <20241129132813.1452294-1-aspsk@isovalent.com>
 <20241129132813.1452294-4-aspsk@isovalent.com>
 <CAADnVQLezUADcW5gJopCyfdYaNSiA+9Zk2n5Mf2EovzCv0AnvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLezUADcW5gJopCyfdYaNSiA+9Zk2n5Mf2EovzCv0AnvQ@mail.gmail.com>

On 24/12/02 06:26PM, Alexei Starovoitov wrote:
> On Fri, Nov 29, 2024 at 5:26 AM Anton Protopopov <aspsk@isovalent.com> wrote:
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
> >  kernel/bpf/verifier.c          | 94 ++++++++++++++++++++++++++++------
> >  tools/include/uapi/linux/bpf.h | 10 ++++
> >  4 files changed, 100 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 4162afc6b5d0..2acf9b336371 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1573,6 +1573,16 @@ union bpf_attr {
> >                  * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
> >                  */
> >                 __s32           prog_token_fd;
> > +               /* The fd_array_cnt can be used to pass the length of the
> > +                * fd_array array. In this case all the [map] file descriptors
> > +                * passed in this array will be bound to the program, even if
> > +                * the maps are not referenced directly. The functionality is
> > +                * similar to the BPF_PROG_BIND_MAP syscall, but maps can be
> > +                * used by the verifier during the program load. If provided,
> > +                * then the fd_array[0,...,fd_array_cnt-1] is expected to be
> > +                * continuous.
> > +                */
> > +               __u32           fd_array_cnt;
> >         };
> >
> >         struct { /* anonymous struct used by BPF_OBJ_* commands */
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 58190ca724a2..7e3fbc23c742 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2729,7 +2729,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
> >  }
> >
> >  /* last field in 'union bpf_attr' used by this command */
> > -#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
> > +#define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
> >
> >  static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
> >  {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8e034a22aa2a..d172f6974fd7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19181,22 +19181,10 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
> >         return 0;
> >  }
> >
> > -/* Add map behind fd to used maps list, if it's not already there, and return
> > - * its index.
> > - * Returns <0 on error, or >= 0 index, on success.
> > - */
> > -static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
> > +static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
> >  {
> > -       CLASS(fd, f)(fd);
> > -       struct bpf_map *map;
> >         int i, err;
> >
> > -       map = __bpf_map_get(f);
> > -       if (IS_ERR(map)) {
> > -               verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
> > -               return PTR_ERR(map);
> > -       }
> > -
> >         /* check whether we recorded this map already */
> >         for (i = 0; i < env->used_map_cnt; i++)
> >                 if (env->used_maps[i] == map)
> > @@ -19227,6 +19215,24 @@ static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
> >         return env->used_map_cnt - 1;
> >  }
> >
> > +/* Add map behind fd to used maps list, if it's not already there, and return
> > + * its index.
> > + * Returns <0 on error, or >= 0 index, on success.
> > + */
> > +static int add_used_map(struct bpf_verifier_env *env, int fd)
> > +{
> > +       struct bpf_map *map;
> > +       CLASS(fd, f)(fd);
> > +
> > +       map = __bpf_map_get(f);
> > +       if (IS_ERR(map)) {
> > +               verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
> > +               return PTR_ERR(map);
> > +       }
> > +
> > +       return __add_used_map(env, map);
> > +}
> > +
> >  /* find and rewrite pseudo imm in ld_imm64 instructions:
> >   *
> >   * 1. if it accesses map FD, replace it with actual map pointer.
> > @@ -19318,7 +19324,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
> >                                 break;
> >                         }
> >
> > -                       map_idx = add_used_map_from_fd(env, fd);
> > +                       map_idx = add_used_map(env, fd);
> >                         if (map_idx < 0)
> >                                 return map_idx;
> >                         map = env->used_maps[map_idx];
> > @@ -22526,6 +22532,61 @@ struct btf *bpf_get_btf_vmlinux(void)
> >         return btf_vmlinux;
> >  }
> >
> > +/*
> > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.  In
> > + * this case expect that every file descriptor in the array is either a map or
> > + * a BTF, or a hole (0). Everything else is considered to be trash.
> > + */
> 
> The comment is now incorrect. 0 is not a valid hole.
> No holes are allowed. And no trash.

Thanks, fixed.

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
> > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > +               return 0;
> 
> It is quite asymmetrical that maps get refcnted and saved
> while BTFs just checked for existence and not refcnted.
> A comment is necessary.

Added.

> 
> > +
> > +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> > +       return PTR_ERR(map);
> > +}
> > +
> > +static int init_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> 
> The name still bothers me.
> The fd_array in the env and in uattr is not initialized.
> 
> Maybe process_fd_array() ?

Sure, 'process_fd_array' looks fine for me. 

> pw-bot: cr

