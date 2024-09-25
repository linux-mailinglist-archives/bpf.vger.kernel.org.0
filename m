Return-Path: <bpf+bounces-40279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58E7985275
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 07:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9661F24190
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 05:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E8514C5A7;
	Wed, 25 Sep 2024 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyqRsQxA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43921B85D1
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242353; cv=none; b=Zj23DmIcAKc0eZDn5vxKfluOH7Cv/BsNI1aeAHXB7yh+l+BtCZiHl3wjTMNc/AIZlRYAtLU6ABEwgD/VIOgDnzm0cdhffJYtxJpqJJuq5uiGRT021o3h1nVy2yeQbCUoIZOcnzMV9U0B5UUENnnNOQz9JYPv3ZMIZu2JzTVxGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242353; c=relaxed/simple;
	bh=M28FHNBcFZRtYiH6SrEFMVeQLySFFdUewzlZP+d03aw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=co/xjyXCDxFZxER8S4e+ty8OW/GxBoQYE0hYq9qO22/NItJTSXr6RV+qs0f3HJ0+fMDtcMi0X3E7BW3I9P6kc/PvdiMbNegCEixbu6Vwk/39eXDL19bqdNKcajKARXb10E5PiPHqRV+RSZJOPqoCN8rqxDE+cijgWKxG8sam28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyqRsQxA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so4363779a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 22:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727242349; x=1727847149; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b5x97xXgs8Y/dKClSY4c1H8fm4nvMj1RD1AgaKupRpc=;
        b=fyqRsQxAQ4Px+O/KmMheGIJakDtA+dII4h38Tm+S+j6a9Jxmg5gZ5m5BSf8M72PnUF
         oQ2hxK7bLKyK57v+0JuzXm/XwKx78aCjlOjOKilnEbnHnWnAF8zpELsOia/x+ZMaZ/nv
         adq80tKml3Bnm4ZyUL9ReVpSjA0I2D8P9trGCKB8q4kreTV6bfrpGOMnUYKbCd5TljDC
         EQDw17FdIb4tOC0AKrIfEu4IM9I2qlloAVKdC6S/EY6jbzWvaKs953ObGIB92flG9YJr
         xJgv3LmGu98rLtX1QCqwi7zXhKpylOCsmCCBi4AQP1cMKCNuyeyMYhhBumLrNXbCBlxB
         PYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727242349; x=1727847149;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5x97xXgs8Y/dKClSY4c1H8fm4nvMj1RD1AgaKupRpc=;
        b=nf/tl3MGZQemngVM9rTGK0Ac+gdPx4c7xl8052y6sK7d83SDLnFVefXnQwT+jPjdP4
         C01WLJBsXIr/JnxPD40lQjvs+KpRPp4eB+PZr+HRi2qQwGLWYuV3q3jLLRffcoaXpWx+
         fdWac+kBn5FvUUAZVrbF5aLgOSgOZkrYyTK1NZYn1SKVRjefyJMoM4wTdbrU2D5B0ArN
         QGcj/zxS9zPft9aeByx4TeRwHTcKnlp8Hg5ArZs8HdWyzStyG83Fq8s/lryHRAZrpWhx
         hLy7lKxeHlrpZSqoH2dLhE4qYz45zRgwCtfwCgxnBoaBrXEU86pUMvLXa3V2iAAzaooF
         ffCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk9ign0j463I+4oyPAQJjGuMOp4GsSclhkVZp7TEOp7yFposA5Qn/bxgHJ6Svf24bthpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+a7kQ5krsNaau3H3DPChEgM6zdgswYcM4V1x0j9aMKcesfXk
	TEnXqfAkFe/gQO7b0H9FGFiUyEhvn8N2vaVVFj6gV4sc3awk7lgk
X-Google-Smtp-Source: AGHT+IE92MaL+OMnA3elW85J3YjhW/1QUWb6hNAI4xzgkQ7YrNazOCy1ScfVkK6ABxaTx5T6sENhLA==
X-Received: by 2002:a17:90b:4b90:b0:2d8:9506:5dfd with SMTP id 98e67ed59e1d1-2e06afe03d0mr1936976a91.35.1727242349155;
        Tue, 24 Sep 2024 22:32:29 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1ae96fsm561368a91.16.2024.09.24.22.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 22:32:28 -0700 (PDT)
Message-ID: <ab4afb61e39cea42fb2ae2f4a2e134415417bbf6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Prevent extending tail callee prog
 with freplace
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
Date: Tue, 24 Sep 2024 22:32:23 -0700
In-Reply-To: <20240923134044.22388-3-leon.hwang@linux.dev>
References: <20240923134044.22388-1-leon.hwang@linux.dev>
	 <20240923134044.22388-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-23 at 21:40 +0800, Leon Hwang wrote:

[...]

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 048aa2625cbef..b864b37e67c17 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1484,6 +1484,7 @@ struct bpf_prog_aux {
>  	bool exception_cb;
>  	bool exception_boundary;
>  	bool is_extended; /* true if extended by freplace program */
> +	atomic_t tail_callee_cnt;

Nit: the name is a bit misleading, this counts how many times the
     program resides it prog maps. Confusing w/o additional comments.
     Maybe something like 'member_of_prog_array_cnt'?

>  	struct bpf_arena *arena;
>  	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>  	const struct btf_type *attach_func_proto;
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 8d97bae98fa70..c12e0e3bf6ad0 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -961,13 +961,17 @@ static void *prog_fd_array_get_ptr(struct bpf_map *=
map,
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> +	atomic_inc(&prog->aux->tail_callee_cnt);
>  	return prog;
>  }

[...]

>  static u32 prog_fd_array_sys_lookup_elem(void *ptr)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 18b3f9216b050..be829016d8182 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3501,6 +3501,18 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
>  		tgt_prog =3D prog->aux->dst_prog;
>  	}
> =20
> +	if (prog->type =3D=3D BPF_PROG_TYPE_EXT &&
> +	    atomic_read(&tgt_prog->aux->tail_callee_cnt)) {
> +		/* Program extensions can not extend target prog when the target
> +		 * prog has been updated to any prog_array map as tail callee.
> +		 * It's to prevent a potential infinite loop like:
> +		 * tgt prog entry -> tgt prog subprog -> freplace prog entry
> +		 * --tailcall-> tgt prog entry.
> +		 */
> +		err =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	err =3D bpf_link_prime(&link->link.link, &link_primer);
>  	if (err)
>  		goto out_unlock;

Is it possible there is a race between map update and prog attach?
E.g. suppose the following sequence of events:
- thread #1 enters prog_fd_array_get_ptr()
- thread #1 successfully completes prog->aux->is_extended check (not extend=
ed)
- thread #2 enters bpf_tracing_prog_attach()
- thread #2 does atomic_read() for tgt_prog and it returns 0
- thread #2 proceeds attaching freplace to tgt_prog
- thread #1 does atomic_inc(&prog->aux->tail_callee_cnt)

Thus arriving to a state when tgt_prog is both a member of a map and
is freplaced. Is this a valid scenario?


