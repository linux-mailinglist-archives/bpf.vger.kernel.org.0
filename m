Return-Path: <bpf+bounces-45009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586FB9CFC71
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 04:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1EC283668
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 03:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098B126BE6;
	Sat, 16 Nov 2024 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7B00azJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E863D
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731726395; cv=none; b=F5Ufa/FvvESvdaIUVdSCLLyPaacZhrDWfR2fk3k+BL4BVp1x/3AYtczMPM926KcFiKYIGQWQiHWdmkK3FG/OdiorABaiRBzACPg+fJNQbnJBn6Pa3Gw92uGBIpCQt99t98xkY5h2pXHHGzPycGdW8EECPcwkwrPYbz3HJtocAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731726395; c=relaxed/simple;
	bh=xoHorzPCJfOGpVdK2pYBL/MGwEIcRsrxQIjYABu3GZY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMu40Ev25PF1M6yK5tREYzDOOweV/UM7aeEf8R3sLqNsJwHd9xKYPhNLPpKWTSJzqaHXaBKv78mfftkMXZ5uFQ/RqGILZ5Hc7W26EiBzpVbDHwj3RCCvlt+nqkbwaJ41WoZ8Gd8/hzgb/GrLmBdZeYlXdV3U7hhWLOq/aE1C2Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7B00azJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca1b6a80aso1577365ad.2
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 19:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731726393; x=1732331193; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIk4JrVWN63FUplRqpWXKX3uqnSnMPlM3fRrWr01lGE=;
        b=l7B00azJ+58ountLcFmFJD9igTBTXaKmIpzHHM4bqY5zDDUUvnFaOaB2XGiE/lB4To
         QxIipZlakyNU8G6TF8f3/AN94bi1/rhP4oX39W37qy/UDSnueuASJ6BthTxtwSiFugIL
         SOMV4Gue26D6mhhxcb4FGSGyZjmNK7mzkT5cq0IoN8OHR627XxbEumVYtywq42BshJgI
         60fDyMekw85fxj2y+Qos3j+mNcer2wVD+AfHbVDBOjQgpOIKAH1wUft2SdISmclRxGYB
         QDV2it2Mv9VRYvdiJKB1QGxmpJyU106u6mAJHf903Xdm97+Dp1p+Y6p9EMbLiUZvSb7L
         secw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731726393; x=1732331193;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jIk4JrVWN63FUplRqpWXKX3uqnSnMPlM3fRrWr01lGE=;
        b=Hp98N/3piVIPzUk4uoFRRnAnE7LXjTKf+XtzauHLYWEL+CA3ya9uYX85kuzKq2ANQo
         DcHrJJzIA0+OzLM3972HDJTU9CIbk+UWrVw5KJ/f3qt6SmeOw/vAZKwCld0UABHpOLdf
         4bUydY3E5yTFgTeKg9dPBwb3//xa0pe+oc2anGeY/g1B/4dXEv2EjOY6zNC8AZ1Arrep
         INsOAKDha3CJjIxVSodIX+4W7nhb5xauZhGVUpQpy1TWNy5zVBE+jlaJ99zS3DkmefzO
         GtzhYJ07zP6JUHJ59+kUY99rOPUAbXyn2phl//Wj5SZSiDXeZTyGnoAKCIJ0tpDqxxCo
         We2w==
X-Forwarded-Encrypted: i=1; AJvYcCXFolDaxIRPRUnj6xnvMX9OH7dtVMNJXFAsyIfNJe7yXA1OKWtkYRTUHmeklsQHTmir2oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4Qzx0bC/3jGyBBCVqh65pgq8Y/LuefDZPSDS7J3QNAd5waiG
	5gkrMoTJV1ylCzL1/RB90AljzIbGd38dNPS0j2WnX/cC1txV5uGc
X-Google-Smtp-Source: AGHT+IHrG5gBXEj/oKAeA06RjR3JVHKu1w/9RqSdMr272xr9j/SB7e+Wj76K3mGrfi96l78TCGr9Xw==
X-Received: by 2002:a17:902:ce91:b0:20c:79f1:fee9 with SMTP id d9443c01a7336-211d0d5f6cbmr67821135ad.11.1731726393074;
        Fri, 15 Nov 2024 19:06:33 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc3276sm19445675ad.23.2024.11.15.19.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 19:06:32 -0800 (PST)
Message-ID: <a21258aa3de7f478ff7144d0d453adc610f3797b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: add fd_array_cnt attribute for
 prog_load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org
Date: Fri, 15 Nov 2024 19:06:28 -0800
In-Reply-To: <20241115004607.3144806-4-aspsk@isovalent.com>
References: <20241115004607.3144806-1-aspsk@isovalent.com>
	 <20241115004607.3144806-4-aspsk@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-15 at 00:46 +0000, Anton Protopopov wrote:

[...]

> @@ -22537,6 +22543,76 @@ struct btf *bpf_get_btf_vmlinux(void)
>  	return btf_vmlinux;
>  }
> =20
> +/*
> + * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.=
  In
> + * this case expect that every file descriptor in the array is either a =
map or
> + * a BTF, or a hole (0). Everything else is considered to be trash.
> + */
> +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> +{
> +	struct bpf_map *map;
> +	CLASS(fd, f)(fd);
> +	int ret;
> +
> +	map =3D __bpf_map_get(f);
> +	if (IS_ERR(map)) {
> +		if (!IS_ERR(__btf_get_by_fd(f)))
> +			return 0;
> +
> +		/* allow holes */
> +		if (!fd)
> +			return 0;
> +
> +		verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> +		return PTR_ERR(map);
> +	}
> +
> +	ret =3D add_used_map(env, map);
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}

Nit: keeping this function "flat" would allow easier extension, if necessar=
y.
     E.g.:

    static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
    {
    	struct bpf_map *map;
    	CLASS(fd, f)(fd);
    	int ret;

    	/* allow holes */
    	if (!fd) {
    		return 0;
    	}
    	map =3D __bpf_map_get(f);
    	if (!IS_ERR(map)) {
    		ret =3D add_used_map(env, map);
    		return ret < 0 ? ret : 0;
    	}
    	if (!IS_ERR(__btf_get_by_fd(f))) {
    		return 0;
    	}
    	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
    	return -EINVAL;
    }


> +
> +static int env_init_fd_array(struct bpf_verifier_env *env, union bpf_att=
r *attr, bpfptr_t uattr)
> +{
> +	int size =3D sizeof(int) * attr->fd_array_cnt;
> +	int *copy;
> +	int ret;
> +	int i;
> +
> +	if (attr->fd_array_cnt >=3D MAX_USED_MAPS)
> +		return -E2BIG;
> +
> +	env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel);
> +
> +	/*
> +	 * The only difference between old (no fd_array_cnt is given) and new
> +	 * APIs is that in the latter case the fd_array is expected to be
> +	 * continuous and is scanned for map fds right away
> +	 */
> +	if (!size)
> +		return 0;
> +
> +	copy =3D kzalloc(size, GFP_KERNEL);
> +	if (!copy)
> +		return -ENOMEM;
> +
> +	if (copy_from_bpfptr_offset(copy, env->fd_array, 0, size)) {
> +		ret =3D -EFAULT;
> +		goto free_copy;
> +	}
> +
> +	for (i =3D 0; i < attr->fd_array_cnt; i++) {
> +		ret =3D add_fd_from_fd_array(env, copy[i]);
> +		if (ret)
> +			goto free_copy;
> +	}
> +
> +free_copy:
> +	kfree(copy);
> +	return ret;
> +}
> +
>  int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uat=
tr, __u32 uattr_size)
>  {
>  	u64 start_time =3D ktime_get_ns();

[...]


