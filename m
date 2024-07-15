Return-Path: <bpf+bounces-34828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C36931799
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07181F215A8
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65918F2F1;
	Mon, 15 Jul 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CwFPhu7K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246D1E528
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057377; cv=none; b=BSQ8vv3VFM0ajVue0iHdDuTmOAFVGS7QAEwCgWWJgqSevgLcARIpygbbgdPfKwMXvYTVeF+8haIAZmbLYaV1qRaX3JZEj5n4KCQ/Z0I4pexvhApCt9td23pqzesjjrfYKUeBG6Au+/OtdhD6akbDrfpeAnjM1q7B31LFF2DCvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057377; c=relaxed/simple;
	bh=yypmGt/M/ctq0oCz1BZ2VCwDMved74B6rckIIyQNve4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUymrj/d/+AgISrbGHde21FTGQ5OPg+cOEMMHRCkmyQ3ngQIdxO+TsOFuMirMeYszmaJLYqETCJZ5+3XFdVgaQc0H/Q2tTnHpUHE0G7p9oXhMaYBzVl77CDXsipr35PbjF9M31ihALnRozD4CJognMf3bH8ZE5AHlBSHYwUbC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CwFPhu7K; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso58453701fa.1
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721057373; x=1721662173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw2sxY68fgmKnezZgZPqrxHMx7nB5++L9IkaflZ6P5A=;
        b=CwFPhu7Kid6UOcV43N6uoU4vQ6TGEXupBEOXZbYd7lon9H1VgKkeYFIOD4cvD0Djet
         gbmkJJDWndqtLBqYbo2+BtWAX/6iFxXnJ1P83iIxgQ6E4onLteHYZRVb3dzw99KG82Rf
         eBdrpxeKud+zpH/cEgWQPeG35VWszA2Y6j7vMuTTYnHyAZPZdakmwtl2V9FWy6f5onQ7
         yW11bFKNP4Mz/sOUQ1ide5fUAKCEflMmh+u4VNBqDSQWWFaaTvaaTVMROk1hx4u52yfu
         9wWHfVHdtUsWfB8ezzYGXx/4IXBAlpEv0+qTtjNCT3AgQiES5KqQGTtfFMiG8fIcA6m7
         35EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721057373; x=1721662173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw2sxY68fgmKnezZgZPqrxHMx7nB5++L9IkaflZ6P5A=;
        b=SsDfyzyiTv/BnN7B+HyhUoPCFuVoA3Hf9iG1+z6qEQ1L1RAIhcWswbWAF7KMjdPmtX
         5VlG5e4XRzVqI2lLhE0BahQtNttR9EkPQIMJj4YbSasVe7Vx+8CILAQbFfYawMr5TwEf
         F3HOz3pmBP+vy4ZqLQIibb2EviDZgYUoOH1Z4/NJkTxHFNc63uRgULkpz83TyQM6dVj9
         gq/QaHNoLzbU2ktfJV/Dg1tFr0cZvZy349zen72FnMbcfmIcqKeNQ4Iio7OXHateoEPO
         D4sSES10UkNJsAbV88wkbZ40sY2XN51BsEJOGUcqb4xOKSJny2Hzdyrn0Lcv8n+i5aCp
         EUMQ==
X-Gm-Message-State: AOJu0Yxy6YOmyh5xj4uTmPD3vOgYMmV2o8U14jDDut76082AMpoIRx2B
	KjY7HyBTFEw7fndYHl6/5MIsRVM8LAnBumGjIGCWQtfHyfZ6+7NN0+7Iw4o+G+0=
X-Google-Smtp-Source: AGHT+IHEArf01ePhgYLP+BI90/1KIcTf6Cb0Dxulnhl09C/1JXAiVXaqcNjTaLxoLBtfftTGc8z18A==
X-Received: by 2002:a2e:938f:0:b0:2eb:eb7c:ec1b with SMTP id 38308e7fff4ca-2eef2d822c8mr1622541fa.25.1721057372572;
        Mon, 15 Jul 2024 08:29:32 -0700 (PDT)
Received: from u94a (2001-b011-fa04-1e5c-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:1e5c:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc28835sm42434165ad.148.2024.07.15.08.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 08:29:31 -0700 (PDT)
Date: Mon, 15 Jul 2024 23:29:20 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>
Subject: Re: [PATCH bpf-next v4 16/20] bpf: Add a special case for bitwise
 AND on range [-1, 0]
Message-ID: <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
 <20240711113828.3818398-4-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711113828.3818398-4-xukuohai@huaweicloud.com>

Cc Harishankar Vishwanathan, Prof. Srinivas Narayana and Prof. Santosh
Nagarakatte, and Matan Shachnai, whom have recently work on
scalar*_min_max_and(); also dropping LSM/FS related mails from Cc since
it's a bit long and I'm not sure whether the mailing list will reject
due to too many email in Cc.

On Thu, Jul 11, 2024 at 07:38:24PM GMT, Xu Kuohai wrote:
> With lsm return value check, the no-alu32 version test_libbpf_get_fd_by_id_opts
> is rejected by the verifier, and the log says:
> 
> 0: R1=ctx() R10=fp0
> ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
> 0: (b7) r0 = 0                        ; R0_w=0
> 1: (79) r2 = *(u64 *)(r1 +0)
> func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
> 2: R1=ctx() R2_w=trusted_ptr_bpf_map()
> ; if (map != (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_id_opts.c:29
> 2: (18) r3 = 0xffff9742c0951a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
> 4: (5d) if r2 != r3 goto pc+4         ; R2_w=trusted_ptr_bpf_map() R3_w=map_ptr(map=data_input,ks=4,vs=4)
> ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
> 5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
> ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
> 6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
> 7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
> ;  @ test_libbpf_get_fd_by_id_opts.c:0
> 8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
> ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
> 9: (95) exit
> 
> And here is the C code of the prog.
> 
> SEC("lsm/bpf_map")
> int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
> {
>     if (map != (struct bpf_map *)&data_input)
> 	    return 0;
> 
>     if (fmode & FMODE_WRITE)
> 	    return -EACCES;
> 
>     return 0;
> }
> 
> It is clear that the prog can only return either 0 or -EACCESS, and both
> values are legal.
> 
> So why is it rejected by the verifier?
> 
> The verifier log shows that the second if and return value setting
> statements in the prog is optimized to bitwise operations "r0 s>>= 63"
> and "r0 &= -13". The verifier correctly deduces that the value of
> r0 is in the range [-1, 0] after verifing instruction "r0 s>>= 63".
> But when the verifier proceeds to verify instruction "r0 &= -13", it
> fails to deduce the correct value range of r0.
> 
> 7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
> 8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
> 
> So why the verifier fails to deduce the result of 'r0 &= -13'?
> 
> The verifier uses tnum to track values, and the two ranges "[-1, 0]" and
> "[0, -1ULL]" are encoded to the same tnum. When verifing instruction
> "r0 &= -13", the verifier erroneously deduces the result from
> "[0, -1ULL] AND -13", which is out of the expected return range
> [-4095, 0].
> 
> As explained by Eduard in [0], the clang transformation that generates this
> pattern is located in DAGCombiner::SimplifySelectCC() method (see [1]).
...
> As suggested by Eduard and Andrii, this patch makes a special case
> for source or destination register of '&=' operation being in
> range [-1, 0].
...

Been wonder whether it possible for a more general approach ever since I
saw the discussion back in April. I think I've finally got something.

The problem we face here is that the tightest bound for the [-1, 0] case
was tracked with signed ranges, yet the BPF verifier looses knowledge of
them all too quickly in scalar*_min_max_and(); knowledge of previous
signed ranges were not used at all to derive the outcome of signed
ranges after BPF_AND.

	static void scalar_min_max_and(...) {
		...
		if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
			dst_reg->smin_value = dst_reg->umin_value;
			dst_reg->smax_value = dst_reg->umax_value;
		} else {
			dst_reg->smin_value = S64_MIN;
			dst_reg->smax_value = S64_MAX;
		}
		...
	}

So looks like its time to be nobody[1] and try to teach BPF verifier how
track signed ranges when ANDing two (possibly) negative numbers. Luckily
bitwise AND is comparatively easier to do than other bitwise operations:
non-negative range & non-negative range is always non-negative,
non-negative range & negative range is still always non-negative, and
negative range & negative range is always negative.

smax_value is straight forwards, we can just do

	max(dst_reg->smax_value, src_reg->smax_value)

which works across all sign combinations. Technically for non-negative &
non-negative we can use min() instead of max(), but the non-negative &
non-negative case should be handled pretty well by the unsigned ranges
already; it seems simpler to let such knowledge flows from unsigned
ranges to signed ranges during reg_bounds_sync(). Plus we are not wrong
for non-negative & non-negative by using max(), just imprecise, so no
correctness/soundness issue here.

smin_value is the tricker one, but doable with

	masked_negative(min(dst_reg->smin_value, src_reg->smin_value))

where masked_negative(v) basically just clear all bits after the most
significant unset bit, effectively rounding a negative value down to a
negative power-of-2 value, and returning 0 for non-negative values. E.g.
for some 8-bit, negative value

	masked_negative(0b11101001) == 0b11100000

This can be done with a tweaked version of "Round up to the next highest
power of 2"[2], 

	/* Invert the bits so the first unset bit can be propagated with |= */
	v = ~v;
	/* Now propagate the first (previously unset, now set) bit to the
	 * trailing positions */
	v |= v >> 1;
	v |= v >> 2;
	v |= v >> 4;
	...
	v |= v >> 32; /* Assuming 64-bit */
	/* Propagation done, now invert again */
	v = ~v;

Again, we technically can do better if we take sign bit into account,
but deriving smin_value this way should still be correct/sound across
different sign combinations, and overall should help us derived [-16, 0]
from "[-1, 0] AND -13", thus preventing BPF verifier from rejecting the
program.

---

Alternatively we can employ a range-splitting trick (think I saw this in
[3]) that allow us to take advantage of existing tnum_and() by splitting
the signed ranges into two if the range crosses the sign boundary (i.e.
contains both non-negative and negative values), one range will be
[smin, U64_MAX], the other will be [0, smax]. This way we get around
tnum's weakness of representing [-1, 0] as [0, U64_MAX].

	if (src_reg->smin_value < 0 && src_reg->smax_value >= 0) {
		src_lower = tnum_range(src_reg->smin_value, U64_MAX);
		src_higher = tnum_range(0, src_reg->smax_value);
	} else {
		src_lower = tnum_range(src_reg->smin_value, src_reg->smax_value);
		src_higher = tnum_range(src_reg->smin_value, src_reg->smax_value);
	}

	if (dst_reg->smin_value < 0 && dst_reg->smax_value >= 0) {
		dst_lower = tnum_range(dst_reg->smin_value, U64_MAX);
		dst_higher = tnum_range(0, dst_reg->smax_value);
	} else {
		dst_lower = tnum_range(dst_reg->smin_value, dst_reg->smax_value);
		dst_higher = tnum_range(dst_reg->smin_value, dst_reg->smax_value);
	}

	lower = tnum_and(src_lower, dst_lower);
	higher = tnum_and(src_higher, dst_higher);
	dst->smin_value = lower.value;
	dst->smax_value = higher.value | higher.mask;
	
---

Personally I like the first method better as it is simpler yet still
does the job well enough. I'll work on that in the next few days and see
if it actually works.


1: https://github.com/torvalds/linux/blob/dac045fc9fa6/kernel/bpf/verifier.c#L13338
2: https://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2
3: https://dl.acm.org/doi/10.1145/2651360

...

