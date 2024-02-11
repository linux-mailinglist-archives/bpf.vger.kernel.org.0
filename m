Return-Path: <bpf+bounces-21716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D54850A4A
	for <lists+bpf@lfdr.de>; Sun, 11 Feb 2024 17:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260101C21EA0
	for <lists+bpf@lfdr.de>; Sun, 11 Feb 2024 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1615C5EE;
	Sun, 11 Feb 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KJ3JSM6U"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8CC8465
	for <bpf@vger.kernel.org>; Sun, 11 Feb 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707668793; cv=none; b=ByjbieiJmGwW5XIPN31skjPdcwi47F1lJ4TVvlJb8/PR/1shDPc0l65DI2WM9tOpvKNlBU8IvVHr08YURgVyDfawAWugWEaEUjkKtb68Xp+t6Q2YbfHFLbhaVq6AFtfkFbz9dM+dMYPAdQNYXQP6ZziviDuGZnuDRSNx7mYvZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707668793; c=relaxed/simple;
	bh=WC0j5cE78bI66QyWpB6SovTOLU9TJuOYVOQCaYZ4t5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIwQQjjwAqY62EtuVoZdUgxcljL5jq41gmav/jHjkwL9aIqWyzZ6nOV8Ys7OjZf6O51L2LbD5NoecqXvU8GT6555ON+LVr3YgtnzPXTJL+510qhmHJ9edjnxYsotdm8EZcXidCmlPjpLFcBDDZHrEgu4BP0GslEupNhV1vZBeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KJ3JSM6U; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4953e59a-69b2-4498-9c12-8b7c7669692e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707668788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcznWC7iRyJbwAd2B923e7pHltmpxtpfwkiOTHFb+qo=;
	b=KJ3JSM6Uoa02mKIQZkCM7o53QRo06YiP4zxUPG1bD4lsz6y+xEHb8l+5qYcHTTCISGUjc/
	f/rO2+CfOT+1mqAeAMfuXeY7YcSfGDy3b2bfWKUL03vfTYM8FNf+kG6eSpj0cfjXzCfhSE
	QBRdBlnbQOlhDaKGlM9dPT/7uciXGAw=
Date: Sun, 11 Feb 2024 08:26:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: emit source code file name and line number
 in verifier log
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240210003308.3374075-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240210003308.3374075-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/9/24 4:33 PM, Andrii Nakryiko wrote:
> As BPF applications grow in size and complexity and are separated into
> multiple .bpf.c files that are statically linked together, it becomes
> harder and harder to match verifier's BPF assembly level output to
> original C code. While often annotated C source code is unique enough to
> be able to identify the file it belongs to, quite often this is actually
> problematic as parts of source code can be quite generic.
>
> Long story short, it is very useful to see source code file name and
> line number information along with the original C code. Verifier already
> knows this information, we just need to output it.
>
> This patch set is an initial proposal on how this can be done. No new
> flags are added and file:line information is appended at the end of
> C code:
>
>    ; <original C code> (<filename>.bpf.c:<line>)
>
> If file name has directory names in it, they are stripped away. This
> should be fine in practice as file names tend to be pretty unique with
> C code anyways, and keeping log size smaller is always good.
>
> In practice this might look something like below, where some code is
> coming from application files, while others are from libbpf's usdt.bpf.h
> header file:
>
>    ; if (STROBEMETA_READ( (strobemeta_probe.bpf.c:534)
>    5592: (79) r1 = *(u64 *)(r10 -56)     ; R1_w=mem_or_null(id=1589,sz=7680) R10=fp0 fp-56_w=mem_or_null(id=1589,sz=7680)
>    5593: (7b) *(u64 *)(r10 -56) = r1     ; R1_w=mem_or_null(id=1589,sz=7680) R10=fp0 fp-56_w=mem_or_null(id=1589,sz=7680)
>    5594: (79) r3 = *(u64 *)(r10 -8)      ; R3_w=scalar() R10=fp0 fp-8=mmmmmmmm
>
>    ...
>
>    170: (71) r1 = *(u8 *)(r8 +15)        ; frame1: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R8_w=map_value(map=__bpf_usdt_spec,ks=4,vs=208)
>    171: (67) r1 <<= 56                   ; frame1: R1_w=scalar(smax=0x7f00000000000000,umax=0xff00000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xff00000000000000))
>    172: (c7) r1 s>>= 56                  ; frame1: R1_w=scalar(smin=smin32=-128,smax=smax32=127)
>    ; val <<= arg_spec->arg_bitshift; (usdt.bpf.h:183)
>    173: (67) r1 <<= 32                   ; frame1: R1_w=scalar(smax=0x7f00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
>    174: (77) r1 >>= 32                   ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
>    175: (79) r2 = *(u64 *)(r10 -8)       ; frame1: R2_w=scalar() R10=fp0 fp-8=mmmmmmmm
>    176: (6f) r2 <<= r1                   ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R2_w=scalar()
>    177: (7b) *(u64 *)(r10 -8) = r2       ; frame1: R2_w=scalar(id=61) R10=fp0 fp-8_w=scalar(id=61)
>    ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
>    178: (bf) r3 = r2                     ; frame1: R2_w=scalar(id=61) R3_w=scalar(id=61)
>    179: (7f) r3 >>= r1                   ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R3_w=scalar()
>    ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
>    180: (71) r4 = *(u8 *)(r8 +14)
>    181: safe
>
> I've played with few different formats and none stood out as
> particularly better than other. Suggestions and votes are appreciated:
>
>    a) ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
>    b) ; if (arg_spec->arg_signed) [usdt.bpf.h:184]
>    c) ; [usdt.bpf.h:184] if (arg_spec->arg_signed)
>    d) ; (usdt.bpf.h:184) if (arg_spec->arg_signed)
>
> Above output shows variant a), which is quite non-distracting in
> practice.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


