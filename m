Return-Path: <bpf+bounces-34921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E52932A4C
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36AEAB24558
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC5419DFBF;
	Tue, 16 Jul 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HeLMnDXJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257019DF5B
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143168; cv=none; b=phZmZcjZSdJFD+c5uM6QzUin5lk2fhEmQ26i8rtUzXOeM4bdYDycE+bnrr32CCbnabrU3PPdg3wSVEIQXAwDoxOa8RbCPWPhU5DEySzWkPxxD9dxr1mxeCWJ19+cPj4eNt9Te8NJPJdC1cUB1bMFEMqeyLk/mtkGgi3DuIJwI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143168; c=relaxed/simple;
	bh=KaZ2njEmp4RUNM84N/6cNoD7OX6UqTOmbPDyK5/Ng64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIPBAMJEk1lT4nhHJ4xihzjqzbJf+x5gw4uTyEQ1Ml9+gIcZRAyO2WmWgZotAwTkhra4vsFISI6d1fOzf8/vqUNKT5CiQkNAGrOtTd+WK/Cb/Nc4PPAhNfW/AfdSKsOmQgnzNQdeilKq6Cgrs8OzqPNUa0X5y23IujMyqLeH4FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HeLMnDXJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so76467331fa.0
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721143165; x=1721747965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KeZ6/rh0i1GdYbxdshyX4kcwweWs7eyBawm/uxsVtyg=;
        b=HeLMnDXJ022Tf0v7agSzxuM1rehRD4BaJS6ZNFVc0inDmMJRYt7nywsZh8A+h427BA
         PoHEszmXZ27IhPEqN6MrC6yEFCPR2lZ+fTKFaQ4KCORXkcQgAf/IfZMqMhA04/WlV7Fn
         jfc5DGlK3TLihTHtnw7euySA8xDZKdvRV/j5VOjZTBmmTrWm/Xqy5zzOGxaS4SyDRZ6d
         Yz3kE/LYXb5dPtTSviwe3uW7F5l3FKJZUDdrIQCJgTeXYCs8Gqmkukkgyb21Qw40OPIs
         9LQ5hp9EJOEU53sHc5rdN7dZI9B5LePL8nI8bXwb77MAdHNchpaL5b2YzB7Df2wrXpdi
         vcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143165; x=1721747965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeZ6/rh0i1GdYbxdshyX4kcwweWs7eyBawm/uxsVtyg=;
        b=vTz/OnWf4CIso4ftOOr5YRzDhWrjnr/Zmegoi0/i1LXhOqz0cDOPUuEL6zItFfc5Wy
         J6gNCozxg7NBzMtTsdRyHu9XW149qTCBkEfFCYpfqZtuwWpSYkVcdPWjqz7yETAffr7C
         MchSlzjiFR+ovs2kFgEiIICePw6SeQxlwrZ9ih6FNhiBRS0pWjQv+H6MWf4MimLzDjll
         W3wVNfLDjl8T9gbApCSIrpsvf1V72RTemKRTtHI1um6BZ1lxe/2So9OSPLQKXZGEkHRt
         FwhzJWByhFI0/VlxAo9v0K+9IFxFjsGAWekSykXf+ubvOD/NYJsOJuY8/8czmR9uDibv
         EDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVySWj7KepObqyYWmUX9h+304drIBt5zJRwImyOcV13s1yOTCdLD30ViyEwRL9QI+DETyBWufkMt/nYzI6Ab3vQo9V0
X-Gm-Message-State: AOJu0YwvzA1JZhA+O/eADjQnyuGgf8y84MlzzNPm/xtvJfrbLIpEdYdg
	ERvwzW7DXHkRdN7mVvP1X/GPb2TOBQZCauSBYqFy3yqRkkfVZ/sPWeXFsCK9wGY=
X-Google-Smtp-Source: AGHT+IGlRC+52nuLghozFL4QOhOn/cuikofedDmsLXVyzpc4IHSBxl28texq3Y+Qb/x0l0F0vY4YEQ==
X-Received: by 2002:a2e:3515:0:b0:2ec:51fc:2f5a with SMTP id 38308e7fff4ca-2eef4168610mr16943331fa.4.1721143164573;
        Tue, 16 Jul 2024 08:19:24 -0700 (PDT)
Received: from u94a (2001-b011-fa04-1e5c-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:1e5c:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc915asm6431150b3a.187.2024.07.16.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:19:23 -0700 (PDT)
Date: Tue, 16 Jul 2024 23:19:16 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Matan Shachnai <m.shachnai@rutgers.edu>
Subject: Re: [PATCH bpf-next v4 16/20] bpf: Add a special case for bitwise
 AND on range [-1, 0]
Message-ID: <b6xgxp45bisr2rygzzs6rwwtyaq23e6vwf6wpfnzho4fxrgijw@e4imapyktalv>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
 <20240711113828.3818398-4-xukuohai@huaweicloud.com>
 <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
 <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com>

On Tue, Jul 16, 2024 at 03:05:11PM GMT, Xu Kuohai wrote:
> On 7/15/2024 11:29 PM, Shung-Hsi Yu wrote:
> > Cc Harishankar Vishwanathan, Prof. Srinivas Narayana and Prof. Santosh
> > Nagarakatte, and Matan Shachnai, whom have recently work on
> > scalar*_min_max_and(); also dropping LSM/FS related mails from Cc since
> > it's a bit long and I'm not sure whether the mailing list will reject
> > due to too many email in Cc.
> > 
> > On Thu, Jul 11, 2024 at 07:38:24PM GMT, Xu Kuohai wrote:
> > > With lsm return value check, the no-alu32 version test_libbpf_get_fd_by_id_opts
> > > is rejected by the verifier, and the log says:
> > > 
> > > 0: R1=ctx() R10=fp0
> > > ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
> > > 0: (b7) r0 = 0                        ; R0_w=0
> > > 1: (79) r2 = *(u64 *)(r1 +0)
> > > func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
> > > 2: R1=ctx() R2_w=trusted_ptr_bpf_map()
> > > ; if (map != (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_id_opts.c:29
> > > 2: (18) r3 = 0xffff9742c0951a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
> > > 4: (5d) if r2 != r3 goto pc+4         ; R2_w=trusted_ptr_bpf_map() R3_w=map_ptr(map=data_input,ks=4,vs=4)
> > > ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
> > > 5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
> > > ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
> > > 6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
> > > 7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
> > > ;  @ test_libbpf_get_fd_by_id_opts.c:0
> > > 8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
> > > ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
> > > 9: (95) exit
> > > 
> > > And here is the C code of the prog.
> > > 
> > > SEC("lsm/bpf_map")
> > > int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
> > > {
> > >      if (map != (struct bpf_map *)&data_input)
> > > 	    return 0;
> > > 
> > >      if (fmode & FMODE_WRITE)
> > > 	    return -EACCES;
> > > 
> > >      return 0;
> > > }
> > > 
> > > It is clear that the prog can only return either 0 or -EACCESS, and both
> > > values are legal.
> > > 
> > > So why is it rejected by the verifier?
> > > 
> > > The verifier log shows that the second if and return value setting
> > > statements in the prog is optimized to bitwise operations "r0 s>>= 63"
> > > and "r0 &= -13". The verifier correctly deduces that the value of
> > > r0 is in the range [-1, 0] after verifing instruction "r0 s>>= 63".
> > > But when the verifier proceeds to verify instruction "r0 &= -13", it
> > > fails to deduce the correct value range of r0.
> > > 
> > > 7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
> > > 8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
> > > 
> > > So why the verifier fails to deduce the result of 'r0 &= -13'?
> > > 
> > > The verifier uses tnum to track values, and the two ranges "[-1, 0]" and
> > > "[0, -1ULL]" are encoded to the same tnum. When verifing instruction
> > > "r0 &= -13", the verifier erroneously deduces the result from
> > > "[0, -1ULL] AND -13", which is out of the expected return range
> > > [-4095, 0].
> > > 
> > > As explained by Eduard in [0], the clang transformation that generates this
> > > pattern is located in DAGCombiner::SimplifySelectCC() method (see [1]).
> > ...
> > > As suggested by Eduard and Andrii, this patch makes a special case
> > > for source or destination register of '&=' operation being in
> > > range [-1, 0].
> > ...
> > 
> > Been wonder whether it possible for a more general approach ever since I
> > saw the discussion back in April. I think I've finally got something.
> > 
> > The problem we face here is that the tightest bound for the [-1, 0] case
> > was tracked with signed ranges, yet the BPF verifier looses knowledge of
> > them all too quickly in scalar*_min_max_and(); knowledge of previous
> > signed ranges were not used at all to derive the outcome of signed
> > ranges after BPF_AND.
> > 
> > 	static void scalar_min_max_and(...) {
> > 		...
> > 		if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
> > 			dst_reg->smin_value = dst_reg->umin_value;
> > 			dst_reg->smax_value = dst_reg->umax_value;
> > 		} else {
> > 			dst_reg->smin_value = S64_MIN;
> > 			dst_reg->smax_value = S64_MAX;
> > 		}
> > 		...
> > 	}
> > 
> 
> This is indeed the root cause.
> 
> > So looks like its time to be nobody[1] and try to teach BPF verifier how
> > track signed ranges when ANDing two (possibly) negative numbers. Luckily
> > bitwise AND is comparatively easier to do than other bitwise operations:
> > non-negative range & non-negative range is always non-negative,
> > non-negative range & negative range is still always non-negative, and
> > negative range & negative range is always negative.
> > 
> 
> Right, only bitwise ANDing two negatives yields to a negative result.
> 
> > smax_value is straight forwards, we can just do
> > 
> > 	max(dst_reg->smax_value, src_reg->smax_value)
> > 
> > which works across all sign combinations. Technically for non-negative &
> > non-negative we can use min() instead of max(), but the non-negative &
> > non-negative case should be handled pretty well by the unsigned ranges
> > already; it seems simpler to let such knowledge flows from unsigned
> > ranges to signed ranges during reg_bounds_sync(). Plus we are not wrong
> > for non-negative & non-negative by using max(), just imprecise, so no
> > correctness/soundness issue here.
> > 
> 
> I think this is correct, since in two's complement, more '1' bits means
> more large, regardless of sign, and bitwise AND never generates more '1'
> bits.
> 
> > smin_value is the tricker one, but doable with
> > 
> > 	masked_negative(min(dst_reg->smin_value, src_reg->smin_value))
> > 
> > where masked_negative(v) basically just clear all bits after the most
> > significant unset bit, effectively rounding a negative value down to a
> > negative power-of-2 value, and returning 0 for non-negative values. E.g.
> > for some 8-bit, negative value
> > 
> > 	masked_negative(0b11101001) == 0b11100000
> > 
> 
> Ah, it's really tricky. Seems it's the longest high '1' bits sequence
> in both operands. This '1' bits should remain unchanged by the bitwise
> AND operation. So this sequence must be in the result, making it the
> minimum possible value.
> 
> > This can be done with a tweaked version of "Round up to the next highest
> > power of 2"[2],
> > 
> > 	/* Invert the bits so the first unset bit can be propagated with |= */
> > 	v = ~v;
> > 	/* Now propagate the first (previously unset, now set) bit to the
> > 	 * trailing positions */
> > 	v |= v >> 1;
> > 	v |= v >> 2;
> > 	v |= v >> 4;
> > 	...
> > 	v |= v >> 32; /* Assuming 64-bit */
> > 	/* Propagation done, now invert again */
> > 	v = ~v;
> > 
> > Again, we technically can do better if we take sign bit into account,
> > but deriving smin_value this way should still be correct/sound across
> > different sign combinations, and overall should help us derived [-16, 0]
> > from "[-1, 0] AND -13", thus preventing BPF verifier from rejecting the
> > program.
> > 
> > ---
> > 
> > Alternatively we can employ a range-splitting trick (think I saw this in
> > [3]) that allow us to take advantage of existing tnum_and() by splitting
> > the signed ranges into two if the range crosses the sign boundary (i.e.
> > contains both non-negative and negative values), one range will be
> > [smin, U64_MAX], the other will be [0, smax]. This way we get around
> > tnum's weakness of representing [-1, 0] as [0, U64_MAX].
> > 
> > 	if (src_reg->smin_value < 0 && src_reg->smax_value >= 0) {
> > 		src_lower = tnum_range(src_reg->smin_value, U64_MAX);
> > 		src_higher = tnum_range(0, src_reg->smax_value);
> > 	} else {
> > 		src_lower = tnum_range(src_reg->smin_value, src_reg->smax_value);
> > 		src_higher = tnum_range(src_reg->smin_value, src_reg->smax_value);
> > 	}
> > 
> > 	if (dst_reg->smin_value < 0 && dst_reg->smax_value >= 0) {
> > 		dst_lower = tnum_range(dst_reg->smin_value, U64_MAX);
> > 		dst_higher = tnum_range(0, dst_reg->smax_value);
> > 	} else {
> > 		dst_lower = tnum_range(dst_reg->smin_value, dst_reg->smax_value);
> > 		dst_higher = tnum_range(dst_reg->smin_value, dst_reg->smax_value);
> > 	}
> > 
> > 	lower = tnum_and(src_lower, dst_lower);
> > 	higher = tnum_and(src_higher, dst_higher);
> > 	dst->smin_value = lower.value;
> > 	dst->smax_value = higher.value | higher.mask;
> 
> This looks even more tricky...

Indeed, and I think the above is still wrong because it did not proper
set smin_value to S64_MIN when needed.

> > Personally I like the first method better as it is simpler yet still
> > does the job well enough. I'll work on that in the next few days and see
> > if it actually works.
> 
> This really sounds great. Thank you for the excellent work!

Sent RFC in sibling thread. I think it would be better if the patch was
included as part of your series. But let's see what the other think of
it first.

