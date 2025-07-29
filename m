Return-Path: <bpf+bounces-64625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1D4B14DE4
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 14:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A7F18A34ED
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D1828DD0;
	Tue, 29 Jul 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdU9v6hs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB0208CA
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793487; cv=none; b=plva5614laOyv2lE2oG1d7o22oC3MDLtmoHv7pMFVAKFPvZquoAeUSVRlFfg+oqji60e2960SqTDsCF2maJgYTjs3VtqyIYhKwuLpZWPYFB0SHGb4KUQ8V/UEr+Wxw3Mm56wU31jpHfUWe4rbYZ9dAnKwcqBZtR5QzwwV0KcaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793487; c=relaxed/simple;
	bh=CtMKtoP4iIfLhIvwT5OnuV5uj6TY0U7rqvzubUtNL+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApT6EFvnIsgLJOm2K8dUgSdPJ/3yD+56SwlwmqII5v8zpVO25wcO6hxZKN8KbwJWzHLYyymFxWT30jp4UtMlY/jSoCvesT0xuYXoPtcEqYK/PzRQqX4g2+APQsMXNqBWdgmnkZrqLtoKzspZ1mxbWG+AR2eSABArn0u2iRqB8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdU9v6hs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45600581226so55039695e9.1
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753793484; x=1754398284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X5MmN7P3nXqKqtvgr/GbRPj+8jtqVKEWRu5Mm0lBoyk=;
        b=PdU9v6hsRj3M8asggQTjql8fbwNWYc14q/INULrAG5f2h5Z2Tcehybr0FPESqRav4J
         d70pQfy9aC9mWLmAyp8bLAul7R1jJrp+FMVf9SHyEpsuX6GSr1ZUgFfuToM/Rf1f3a/p
         0KvrtBfn63hbiX+yuAfE+ehwlCUUIGp1PJmdxVhvuNqai2IwTTAdOWE/QCRsujQT9o4W
         pXk8Py4v6oT1QyYoSCgIXAXGeaKdul9/vgzkbD0rQy+4WqLUoaVdPVh4DWVN1EIALefL
         n6sliMVhJrRZIEqH5d0I68YCBqpyf6g0ta/khIIVFFNj5Z7trC1cR/mymwXokDwcQbZ5
         j+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753793484; x=1754398284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5MmN7P3nXqKqtvgr/GbRPj+8jtqVKEWRu5Mm0lBoyk=;
        b=hREDFOhOk18X74FJL/YoAp9TYi8vivUEABVONQwldakOmjefvkPmBWNKMy/yzuM3vC
         eOhdr++YUzQgPEn8W1MMIGTurZbxQLvuvQWOreo3bk/NqQlgsfeiw6zMLnnUgMqT/D+e
         KXa9yw9oRgS+nuvXApBQ33cg+/PRjNYB0QjR6DdutZnCYyTitWvsymrznPLS5YzvfVr+
         bgdXRrZkgcyrwP6brjac7KGohZLUN4oY3TmB2B7Jg8sCuQtUtC6HObvJFOd11zoJBLnT
         V+qWDnTHyV2sUEyZvmKayEdH4kOSg+nW0b0hf/uPSuQ0JRCHntdYcYVdrmUBzT6DqajG
         zIMA==
X-Forwarded-Encrypted: i=1; AJvYcCVKVu5BhJBGMNtipX8ILzt21mx2iIrg8WHqBHuWYpk3EtFVTYJVGToqHuhHIYSwfFy2Zsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFR+fzNz/kHJVuo5vjDjUeLUT+PKeUXjSkE79yYvWVpMC4LIpk
	zDogaZALzRt9B5XHeJHZf0AVcRZjTblv777HdcDGbjje5TTygU8QuM13
X-Gm-Gg: ASbGncsttdlqD9MsSCBimSyGH0Z8QA2k+6zgyGb9LMsFY4ANGNb4ba4YOW2J4IjiZAh
	7VckEke1t/UWFJfE5NYbRwTZPQfVOnPeU1HY/6ge8ObW2AzMlA/1kO86TzXuWkolALgVmW+FC1r
	9dxDhuTWoLjUUAYqGZcH4V24OT6I8MNIk+/TTzmuKcIVVpk8XAGjQxnYlEtQrAkOWkDsOCzCOol
	J4sGGFmXNnYeNOSBhtsQYUuXTFS4XJjcWZjgYEL4yDvMb2ruZ8qAu3qGgzK5ov9grSWnviE4W1O
	VbJsMF6J7azdbLsC1ifY3TCX4sE41WkvjUdFfE0ZEwyLolte6zCxRUkSuAD6INopgeE2+LDBaP2
	2kqDb3x07n9mr0QP2LwUfqQDj3maMupI2CUS4DE9rhy+SVU8aneAtw+pVntUa/qerT3N1MRRNiX
	z0m1T5uUvWcXV0ehG6Zyqy
X-Google-Smtp-Source: AGHT+IHIDJCzghYzPtyUHDTvve9cjG+OP70TzvLp7RJR272jyETb56xCaSR9A4AyiFwv1Ln8/HWUlQ==
X-Received: by 2002:a05:600c:810c:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-458765475bcmr137637865e9.18.1753793483504;
        Tue, 29 Jul 2025 05:51:23 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001f3a1d19b7d62baa.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1f3a:1d19:b7d6:2baa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870555065sm202333125e9.15.2025.07.29.05.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 05:51:22 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:51:20 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: A summary of usability issues in the current verifier
Message-ID: <aIjDyJj2ihnn7AFv@mail.gmail.com>
References: <2eb5612b88b04587af00394606021972@epfl.ch>
 <tkwmhg2u6qjjqkncnem3vzpprsnisdoh7ycpxtsstlry45vtjp@wvsve7i2hjtg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tkwmhg2u6qjjqkncnem3vzpprsnisdoh7ycpxtsstlry45vtjp@wvsve7i2hjtg>

On Tue, Jul 29, 2025 at 03:52:35PM +0800, Shung-Hsi Yu wrote:
> Cc Dimitar (worked on coerce_reg_to_size_sx, point 1), Paul & Eduard
> (maybe point 1 will eventually lead to invariant violation?), and other
> BPF maintainers (point 2, 3, and 4).
> 
> On Wed, Apr 16, 2025 at 01:52:09PM +0000, Tao Lyu wrote:
> > Hi,
> > 
> > I found the following usability issues; kindly write them here to see if the community is willing to solve them.
> > If yes, I could write patches for them gradually.

Hi,

I'm curious how you found those false positives. Am I guessing correctly
that the programs were generated by a fuzzer or something similar?

I think that matters because there will always be false positives.
Addressing them usually makes the verifier's logic more complex, so we
probably want to focus on issues that are affecting users. Or at least,
we may want to balance the complexity of the changes with the
likelihood of a user hitting the false positives.

> > 
> > 1. Inaccurate tracking of arithmetic instruction results.
> > 
> > There are many inaccurate arithmetic computation results.
> > For example, like below:
> > r0 should be 0 after `r0 = (s16)r3`.
> > However, due to the inaccurate range track in eBPF at (coerce_reg_to_size_sx and set_sext64_default_val),
> > the lower 16-bit of r0 becomes unknown, leading to false negatives when exit.
> > 
> > func#0 @0
> > 0: R1=ctx() R10=fp0
> > 0: (b7) r6 = -657948387               ; R6_w=0xffffffffd8c8811d
> > 1: (94) w6 s%= 16                     ; R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> > 2: (18) r8 = 0xff11000279981800       ; R8_w=map_ptr(ks=4,vs=8)
> > 4: (18) r9 = 0x19556057               ; R9_w=0x19556057
> > 6: (bf) r3 = r10                      ; R3_w=fp0 R10=fp0
> > 7: (bf) r3 = r6                       ; R3_w=scalar(id=1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=scalar(id=1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> > 8: (67) r3 <<= 38                     ; R3_w=scalar(smax=0x7fffffc000000000,umax=0xffffffc000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffc000000000))
> > 9: (bf) r0 = r6                       ; R0_w=scalar(id=1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=scalar(id=1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> > 10: (bc) w0 = (s16)w3                 ; R0_w=0 R3_w=scalar(smax=0x7fffffc000000000,umax=0xffffffc000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffc000000000))
> > 11: (bf) r0 = (s16)r3                 ; R0_w=scalar(smin=smin32=-32768,smax=smax32=32767) R3_w=scalar(smax=0x7fffffc000000000,umax=0xffffffc000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffc000000000))
> 
> I would say it is just not as precise, rather than inaccurate. But your
> point remain, the verifier was not able to come up with [0, 0] as the
> range after instruction 11, and we end up with [S16_MIN, S16_MAX]
> instead.
> 
> Dimitar has a patchset[1] that make better use of tnum for sign
> extension, which should address this.
> 
> 1: https://lore.kernel.org/all/20250130112342.69843-1-dimitar.kanaliev@siteground.com/
> 
> Can't comment on point 2 and 3, and unsure about point 4.
> 
> > 2. Unnecessary atomic instructions operating on private memory (e.g, stack).
> > 
> > Since atomic instructions are only useful on the shared memory,
> > it is unnecessary to allow them on the private memory like stack,
> > which was discussed long time ago in this commit:
> > https://github.com/torvalds/linux/commit/ca36960211eb228bcbc7aaebfa0d027368a94c60
> > 
> > Moreover, allowing atomic instruction also introduce another usability bugs,
> > which was reported here: https://lore.kernel.org/bpf/20231020172941.155388-1-tao.lyu@epfl.ch/
> > 
> > 
> > 3. Inconsistent constraints on instructions involving pointer type transitions.
> > 
> > Most bitwise instructions, such as and and xor are disallowed on pointers,
> > but negation and bitwise swap are allowed.
> > Moreover, negation and bitwise swap are permitted in atomic instructions,
> > such as atomic_and and atomic_xor.
> > 
> > 
> > 4. Coarse-grained pointer comparison.
> > 
> > Pointers pointing to the same memory region can infer more pointer range information. 
> > For example, comparing two stack pointers (one with a constant range, while the other with a variable range) can help infer the variable range,
> > as shown in the code below.
> > 
> > 11: R0=map_value(map=array_map3,ks=4,vs=8) R9=ctx() R10=fp0 fp-8=mmmmmmmm
> > 11: (61) r6 = *(u32 *)(r0 +0)         ; R0=map_value(map=array_map3,ks=4,vs=8) R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> > 12: (bf) r1 = r10                     ; R1_w=fp0 R10=fp0
> > 13: (0f) r1 += r6
> > mark_precise: frame0: last_idx 13 first_idx 11 subseq_idx -1
> > mark_precise: frame0: regs=r6 stack= before 12: (bf) r1 = r10
> > mark_precise: frame0: regs=r6 stack= before 11: (61) r6 = *(u32 *)(r0 +0)
> > 14: R1_w=fp(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> > 14: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
> > 15: (07) r2 += -512                   ; R2_w=fp-512
> > 16: (ad) if r1 < r2 goto pc+2         ; R1_w=fp(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R2_w=fp-512
> > 17: (3d) if r1 >= r10 goto pc+1       ; R1_w=fp(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R10=fp0
> > 18: (71) r3 = *(u8 *)(r1 +0)
> > invalid unbounded variable-offset read from stack R1
> 
> I really have no idea whether compilers produce this kind of pattern,
> but if there is some chance, then it does seem reasonable to have this
> implemented. Seems like much existing code for scalar can be reused.

I tried playing with stack pointers a bit, but I'm so far unable to get
the compiler to generate this kind of code. It always gets optimized to
scalar comparisons.


