Return-Path: <bpf+bounces-64592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69DB1498D
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF69546DBB
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310FC276054;
	Tue, 29 Jul 2025 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fua0unI9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A827702E
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775570; cv=none; b=h/iVfj/cFwpcaucZzYYWXxpRZAzZoQ/WyEuKCBC0WkwwCw/R5bytuz6407VcX0jZ5+HB8AFPM+zJfLC7TQilxPrJjwCAorv6btcrtgDLr/k7MtuzuawjKQmp3ffACOn2JYVZDWDzPc7C4QgpR0TdBMaGFgXi/iKLw06bT6h7+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775570; c=relaxed/simple;
	bh=CNSb76TGdj+gFuih1zP2avye5YEW8OHvS91aBcbOnTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBPIkH+YovIA2ik3BD0z+VRqdQoWc25760DQdO52ImwkH7FJ6r5RKSOZ2IDAzKe70OsSVFbRU165xQgjDdJkDLQ0YgdlOaZvecm9TG2H2PKzXl0LFStOA8auuiLs09Dtrz8xZ1P5hq2lIsS4NyrvvkIC1m3XOVlLxLS27nA7YQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fua0unI9; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a54700a46eso2464326f8f.1
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753775567; x=1754380367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POOw2AzqU4l8ku7+T2EDU81Hg767aGK7xmT7Nws0OKE=;
        b=fua0unI9KuFWU/00SuqaK0TGX+hTic09yhM4NxrQrTdqkLOSecjSazbf7oY04ov2+I
         +oES9NHDE7a9IzMoNlu8G3FoEMmyqgzMY17c91WWQSelwKZEsCYNG7pRaYrB0NvFjGwH
         4JcJFX+A2XRXRMR76MeVKOkHciE817O6ZqZPfvOyku9D+gbrw9Ib/3xqzzP/qbL1fhby
         m8l1rkeRTcCjV9+2E/B0nMYwr7aGqrZZsxa55gm6drQhKavG3a+M1V4YRXR0S110Kxsu
         eBpCFIuLFC0TYl8EnkggPpEw1mJE8qOQW/auiJD0TjMaV54SYV6b8/r0JoUMZgm7siR4
         yRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775567; x=1754380367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POOw2AzqU4l8ku7+T2EDU81Hg767aGK7xmT7Nws0OKE=;
        b=F8UwoSMKo7JWuDJnie9NzHrQYPyd7wUnpqBxIEAxaNxGLgmMtMdM/Dwhv/WMVoQ4Pt
         2u1sYJ0hk+8dfTgkxfnVU7XUIfiLP8ZQzmgtIVEqlkJgnOXbWt2fny5jPNHcYgC19Rjf
         tPDo3v96kLLloR1qGt0OFh5mHp659Loe3xJl4UmIrzh5p22zZU4RvHWDck86BG2t9z6h
         WTeAa0eIP5iGkihCx//2bqwkgeVQVYSd+Jz6MufCe7Gicjo4qgWm1SshXtAMiqp6y5GW
         l02tQUi4e+qjITLFVdgs0QvKeZc/7KHLhhnlMRKN3TAlN/DVWP44KcPyOX1iG4bWfenK
         tfQw==
X-Forwarded-Encrypted: i=1; AJvYcCVKx0LGsG6jOcjRrsRcanmHQu1dkbtOjCeOAaWK5qaxqlkqIrNOwbaxkKAMocW9F0e2yhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/OoKCBSYTtbaiZ36rngSM1mBxzCqTkwZh2nAGyFQHkHyvlJ+
	Hg7PFnAplxgccpZPxphT2gjbH1+kiehEPCh0lzlYLpDCzrB0vb5g0ylURzTdIKcDfuk=
X-Gm-Gg: ASbGncvXEP/BCzgI2FA66CFVOcFRCL+fksEBpLon+Iz+JPYR4vZrwDdysL7Xr2vubWt
	V7aN1TXk8Wk3+YcyyzAdHkjWguFVMqc9vMRFofZ+hLHKiZQJR3evk7FjIGf3gRgjx1wkexuYo7j
	rHoO0kEuErhsXwTFxaOJKjp8VgrDGYHooc+UDVDO4EwJs5dTpYfBf5FDvbqNxSO67WHXuSGxQWq
	NudZ9Nyby70KCkVi/NQxbUxA2CGBv0jc+Uj6BwJ850QUwUuU6ee3Gx8oFhsxsT5UEJOfuEkx89X
	3zgCESA+9uHgwIBdVFlTMhVfQzo6XAuwzkpoHNh3SNEt2lAoZ+RcLKA+eeDq2T4q785gI+dKHsH
	6TXdvfyABzExh6gM=
X-Google-Smtp-Source: AGHT+IGUFMmvLZgepS9rwBCvOXUwBwrSJxGKECA7oR3fnkX0xGHXApd/TpggKCB4zTbU7RkbicouOA==
X-Received: by 2002:a05:6000:2001:b0:3b6:463:d85d with SMTP id ffacd0b85a97d-3b77671d3c4mr9493607f8f.11.1753775566716;
        Tue, 29 Jul 2025 00:52:46 -0700 (PDT)
Received: from u94a ([2401:e180:88a2:4c10:c47b:26d3:8f9b:63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f328a0998sm909507a91.1.2025.07.29.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 00:52:45 -0700 (PDT)
Date: Tue, 29 Jul 2025 15:52:35 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: A summary of usability issues in the current verifier
Message-ID: <tkwmhg2u6qjjqkncnem3vzpprsnisdoh7ycpxtsstlry45vtjp@wvsve7i2hjtg>
References: <2eb5612b88b04587af00394606021972@epfl.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2eb5612b88b04587af00394606021972@epfl.ch>

Cc Dimitar (worked on coerce_reg_to_size_sx, point 1), Paul & Eduard
(maybe point 1 will eventually lead to invariant violation?), and other
BPF maintainers (point 2, 3, and 4).

On Wed, Apr 16, 2025 at 01:52:09PM +0000, Tao Lyu wrote:
> Hi,
> 
> I found the following usability issues; kindly write them here to see if the community is willing to solve them.
> If yes, I could write patches for them gradually.
> 
> 1. Inaccurate tracking of arithmetic instruction results.
> 
> There are many inaccurate arithmetic computation results.
> For example, like below:
> r0 should be 0 after `r0 = (s16)r3`.
> However, due to the inaccurate range track in eBPF at (coerce_reg_to_size_sx and set_sext64_default_val),
> the lower 16-bit of r0 becomes unknown, leading to false negatives when exit.
> 
> func#0 @0
> 0: R1=ctx() R10=fp0
> 0: (b7) r6 = -657948387               ; R6_w=0xffffffffd8c8811d
> 1: (94) w6 s%= 16                     ; R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> 2: (18) r8 = 0xff11000279981800       ; R8_w=map_ptr(ks=4,vs=8)
> 4: (18) r9 = 0x19556057               ; R9_w=0x19556057
> 6: (bf) r3 = r10                      ; R3_w=fp0 R10=fp0
> 7: (bf) r3 = r6                       ; R3_w=scalar(id=1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=scalar(id=1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> 8: (67) r3 <<= 38                     ; R3_w=scalar(smax=0x7fffffc000000000,umax=0xffffffc000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffc000000000))
> 9: (bf) r0 = r6                       ; R0_w=scalar(id=1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=scalar(id=1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> 10: (bc) w0 = (s16)w3                 ; R0_w=0 R3_w=scalar(smax=0x7fffffc000000000,umax=0xffffffc000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffc000000000))
> 11: (bf) r0 = (s16)r3                 ; R0_w=scalar(smin=smin32=-32768,smax=smax32=32767) R3_w=scalar(smax=0x7fffffc000000000,umax=0xffffffc000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffc000000000))

I would say it is just not as precise, rather than inaccurate. But your
point remain, the verifier was not able to come up with [0, 0] as the
range after instruction 11, and we end up with [S16_MIN, S16_MAX]
instead.

Dimitar has a patchset[1] that make better use of tnum for sign
extension, which should address this.

1: https://lore.kernel.org/all/20250130112342.69843-1-dimitar.kanaliev@siteground.com/

Can't comment on point 2 and 3, and unsure about point 4.

> 2. Unnecessary atomic instructions operating on private memory (e.g, stack).
> 
> Since atomic instructions are only useful on the shared memory,
> it is unnecessary to allow them on the private memory like stack,
> which was discussed long time ago in this commit:
> https://github.com/torvalds/linux/commit/ca36960211eb228bcbc7aaebfa0d027368a94c60
> 
> Moreover, allowing atomic instruction also introduce another usability bugs,
> which was reported here: https://lore.kernel.org/bpf/20231020172941.155388-1-tao.lyu@epfl.ch/
> 
> 
> 3. Inconsistent constraints on instructions involving pointer type transitions.
> 
> Most bitwise instructions, such as and and xor are disallowed on pointers,
> but negation and bitwise swap are allowed.
> Moreover, negation and bitwise swap are permitted in atomic instructions,
> such as atomic_and and atomic_xor.
> 
> 
> 4. Coarse-grained pointer comparison.
> 
> Pointers pointing to the same memory region can infer more pointer range information. 
> For example, comparing two stack pointers (one with a constant range, while the other with a variable range) can help infer the variable range,
> as shown in the code below.
> 
> 11: R0=map_value(map=array_map3,ks=4,vs=8) R9=ctx() R10=fp0 fp-8=mmmmmmmm
> 11: (61) r6 = *(u32 *)(r0 +0)         ; R0=map_value(map=array_map3,ks=4,vs=8) R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> 12: (bf) r1 = r10                     ; R1_w=fp0 R10=fp0
> 13: (0f) r1 += r6
> mark_precise: frame0: last_idx 13 first_idx 11 subseq_idx -1
> mark_precise: frame0: regs=r6 stack= before 12: (bf) r1 = r10
> mark_precise: frame0: regs=r6 stack= before 11: (61) r6 = *(u32 *)(r0 +0)
> 14: R1_w=fp(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> 14: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
> 15: (07) r2 += -512                   ; R2_w=fp-512
> 16: (ad) if r1 < r2 goto pc+2         ; R1_w=fp(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R2_w=fp-512
> 17: (3d) if r1 >= r10 goto pc+1       ; R1_w=fp(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R10=fp0
> 18: (71) r3 = *(u8 *)(r1 +0)
> invalid unbounded variable-offset read from stack R1

I really have no idea whether compilers produce this kind of pattern,
but if there is some chance, then it does seem reasonable to have this
implemented. Seems like much existing code for scalar can be reused.

