Return-Path: <bpf+bounces-45626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBDF9D9C13
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF219B28E36
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896F1D8E1E;
	Tue, 26 Nov 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="MPsG8nwz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF70A1CD2C
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640605; cv=none; b=lTQn8f1VGbPUc/VG2MeKm/EzJg2FmPqzTxOkS20pniHqpELXVG2vY0h12gNiqJk1YJ33+ZlcKNQs5q5AP3dArthpeJ72uSYBcC99TAS5qVcxoXisP7yG688hL15QbKQu2UTo4+iR88W0xbhABuh70ChAYX3FyIMVCCS2xe1oBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640605; c=relaxed/simple;
	bh=RFsagDbO+JDvDUY0bsBU0TAxhA3Sov2hxhc0ijc9Aas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye+2z4YPBuhkWnRvhLSwkOZIm9aXZq3Xssh36DM31tTFaTj5UXsfoJJ3vTSUbpbOQUjD5LbLqd/DtM+sP27yPDsdmOYlh5djSWRE1k2Djedc+qmEfOe4LHHwRmfNS1sCKNh6kjnwBc9EiV05vozM5F6XnU6YCbrBRzvH6xu/a40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=MPsG8nwz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso23095825e9.0
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 09:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732640601; x=1733245401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7bOXZtJIAkkjMa1K6/NsJ8m/6SAhGN2qINvWgzUHe7g=;
        b=MPsG8nwzRAZNazY6Y1YooX2xAvNBWGOYPbLz5CX/W5k1Kskx+3HGcW8+ERA3JJvgaC
         F2zxVm9syfeePjmIQ0JlELnYKnRJXrIeZNwrE7t6cRcrrYP4yzpo4Hz7u0xLd4xW/I9r
         1PaYzVPXFPyW7imqObrB9aanZoFa3zc0UW15KMhqnbQ3KNUMf+1hxKP6eyEPiHGdEfOK
         guvjzwa+Dnj1BbN2SSS581RU57hDeiy/zSB4DV9keSt/oDqlp6d7OH5DRl9IzNqxGVwU
         pGIkNPekzy12XMquQHEa+h2N1K564IqF4bSCUoV2PfROpdZeOPiJByrb+H7IslBOz/DI
         CdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640601; x=1733245401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bOXZtJIAkkjMa1K6/NsJ8m/6SAhGN2qINvWgzUHe7g=;
        b=aLjs3xU4CRSyvCUNyCurdOtDCegLkNzxjucT6qiiNIPY6mR6rjONkdrv9W6mLUIVCf
         quJzKHL7rxdAgoT5OkPbERAIjDrub7xP8CPIKlnYNzQPUO9Zbh9N4ocyDVi5K5Jx2332
         wXY5OcBAXDaIdp/iL0zCB8VraUe+b2fmi98L5XlY0BQekbZrjG6V0g9EQgsg08/yx7hP
         E6nBn7PO0EmCcj3j4jL+P8/l8cLxSi3u0oIpY+9JSg6XRYdfimml31Z7/gzDOVafJano
         rQj/8KmM9gaio/zM1FHHCPF6732VBr5OxftUyczvE3NQCEXpismphRnOw5B0qJPXcHRC
         7Z7g==
X-Gm-Message-State: AOJu0YxwoFyUuVoKlyxdHtMEPY6qhYfx99ScjoDVPGwn9HBWDCioknGI
	aKJ4rsPod9J39w07PmlL+HqHN8nO1oipXickJI+ejgvIChiR7w8vkdmQJI7wYR9rqU+GDwD+Fc+
	X
X-Gm-Gg: ASbGncvca1vQGOVYhqaSYqDMfFenMkkv70doLIxSGOG/MmGzUB4d0uYrxOVAPTUXTci
	qjlB/aSZFBjuLiucvXL3i0kaqL3AGBUMs1QTEZ51iCk3225/biqIElbYbMH1v4YDpg7VCfUFttP
	/rjupMra3G3fTAmymVooD2xWIdZD0egLsv9plbdyUP0MOh6aK9ttnT/BYfcFmn3D0T1mBZx9D/p
	GxCXmxeABV7hMlUz2L0fpQSH0ml1OuuuhQX7W0=
X-Google-Smtp-Source: AGHT+IF4Qo+jAalAjNETbOu5qjr867oPT/wlvnuTwcUmsn3ozPHEa0qmjY1OZn0jhp1wxW5Qh8Wixg==
X-Received: by 2002:a05:6000:1566:b0:385:bf55:2e24 with SMTP id ffacd0b85a97d-385bf552e63mr3961526f8f.17.1732640600703;
        Tue, 26 Nov 2024 09:03:20 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedce3sm13754109f8f.97.2024.11.26.09.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:03:20 -0800 (PST)
Date: Tue, 26 Nov 2024 17:05:54 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z0X/8ufRfLOrEXfI@eis>
References: <20241119101552.505650-1-aspsk@isovalent.com>
 <20241119101552.505650-4-aspsk@isovalent.com>
 <CAADnVQ+=SoVvmGizF8L78j=U+MWi1XnCQEdz9tJOxwYeKuZsJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+=SoVvmGizF8L78j=U+MWi1XnCQEdz9tJOxwYeKuZsJw@mail.gmail.com>

On 24/11/25 05:38PM, Alexei Starovoitov wrote:
> On Tue, Nov 19, 2024 at 2:17 AM Anton Protopopov <aspsk@isovalent.com> wrote:
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
> > index 8e034a22aa2a..a84ba93c0036 100644
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
> > +static int add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
> 
> _from_fd suffix is imo too verbose.
> Let's use __add_used_map() here instead?

Will do.

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
> > +static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
> 
> and keep this one as add_used_map() ?

Will do.

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
> > +       return add_used_map(env, map);
> > +}
> > +
> >  /* find and rewrite pseudo imm in ld_imm64 instructions:
> >   *
> >   * 1. if it accesses map FD, replace it with actual map pointer.
> > @@ -22526,6 +22532,75 @@ struct btf *bpf_get_btf_vmlinux(void)
> >         return btf_vmlinux;
> >  }
> >
> > +/*
> > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.  In
> > + * this case expect that every file descriptor in the array is either a map or
> > + * a BTF, or a hole (0). Everything else is considered to be trash.
> > + */
> > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> > +{
> > +       struct bpf_map *map;
> > +       CLASS(fd, f)(fd);
> > +       int ret;
> > +
> > +       map = __bpf_map_get(f);
> > +       if (!IS_ERR(map)) {
> > +               ret = add_used_map(env, map);
> > +               if (ret < 0)
> > +                       return ret;
> > +               return 0;
> > +       }
> > +
> > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > +               return 0;
> > +
> > +       if (!fd)
> > +               return 0;
> 
> This is not allowed in new apis.
> zero cannot be special.

I thought that this is ok since I check for all possible valid FDs by this
point: if fd=0 is a valid map or btf, then we will return it by this point.

Why I wanted to keep 0 as a valid value, even if it is not pointing to any
map/btf is for case when, like in libbpf gen, fd_array is populated with map
fds starting from 0, and with btf fds from some offset, so in between there may
be 0s. This is probably better to disallow this, and, if fd_array_cnt != 0,
then to check if all [0...fd_array_cnt) elements are valid.

> > +
> > +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> > +       return PTR_ERR(map);
> > +}
> > +
> > +static int env_init_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> 
> What an odd name... why is 'env_' there?

will remove

> 
> > +{
> > +       int size = sizeof(int) * attr->fd_array_cnt;
> 
> int overflow.

Thanks, will fix.

> > +       int *copy;
> > +       int ret;
> > +       int i;
> > +
> > +       if (attr->fd_array_cnt >= MAX_USED_MAPS)
> > +               return -E2BIG;

(This actually should be MAX_USED_MAPS + MAX_USED_BTFS)

> > +
> > +       env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> > +
> > +       /*
> > +        * The only difference between old (no fd_array_cnt is given) and new
> > +        * APIs is that in the latter case the fd_array is expected to be
> > +        * continuous and is scanned for map fds right away
> > +        */
> > +       if (!size)
> > +               return 0;
> > +
> > +       copy = kzalloc(size, GFP_KERNEL);
> 
> the slab will WARN with dmesg splat on large sizes.

The size would be actually smaller than 4*(MAX_USED_MAPS + MAX_USED_BTFS),
as we check this above.

> 
> > +       if (!copy)
> > +               return -ENOMEM;
> > +
> > +       if (copy_from_bpfptr_offset(copy, env->fd_array, 0, size)) {
> > +               ret = -EFAULT;
> > +               goto free_copy;
> > +       }
> > +
> > +       for (i = 0; i < attr->fd_array_cnt; i++) {
> > +               ret = add_fd_from_fd_array(env, copy[i]);
> > +               if (ret)
> > +                       goto free_copy;
> > +       }
> 
> I don't get this feature.
> Why bother copying and checking for validity?
> What does it buy ?

So, the main reason for this whole change is to allow unrelated maps, which
aren't referenced by a program directly, to be noticed and available during the
verification. Thus, I want to go through the array here and add them to
used_maps. (In a consequent patch, "instuction sets" maps are treated
additionally at this point as well.)

The reason to discard that copy here was that "old api" when fd_array_cnt is 0
is still valid and in this case we can't copy fd_array in full. Later during
the verification fd_array elements are accessed individually by copying from
bpfptr. I thought that freeing this copy here is more readable than to add
a check at every such occasion.

> pw-bot: cr

