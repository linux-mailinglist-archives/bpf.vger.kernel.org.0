Return-Path: <bpf+bounces-56012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DECA8ABDD
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26333BE6D3
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803592D86B7;
	Tue, 15 Apr 2025 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU3LJWxC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D6274FF2
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758656; cv=none; b=LdanoTUsM0eL+PZ8sxRR8998X6X1x+l7ddVHIxSd+8qF5K9ZQddVLTY95MFlVy/zE4846qfT6B/16I6OVsbo+0c7Ye8S6SrQZ/2QTrNsHCboj0pzXxXAu45E5+INhiuaJkBqbU+VWj5aH2vi9r+KwhSGRGFGjeAdZkebw7nD1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758656; c=relaxed/simple;
	bh=RdpDcCZ01a57bHfGDSxwJUsdK/tgjcm6oQVODUgFu94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPT/OOu6gmQX0fLL+YNCqM5eJqHkrL0LSGaFopjkRAHEmaavcn3T6QMPQ0ToQT9OyJCNvAGC+ZnhO72QyEThJARUCXW0BcmJLBKQQQTSJiGGIk8L3iHh5VdyroN7OivYjyHLmjim/wI1ZHCq0XabkfKhi03eHqjRkRNCE+GF0pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU3LJWxC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso4816891a91.1
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744758654; x=1745363454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwjWfT5B0K/JFdE14QntNpQqgQ/FkvVTBI1loxQKWbE=;
        b=eU3LJWxCaT8ShjW9Z4bKU6n73le+f++WWpavmDqW5065EIegj0uRz/TMIXylWc1w/Z
         +9GFHTHrMv2/XxUmlpaSOU3hJrcr/aiz7foS8AGB6fhzq/n0L4p9jQsRFfECaj276R8O
         H3yoTgJMVhMAUVD7iRoMv8+ANlIVpnVeiTZJr8Nu4bptLuw8m/qOg1zSj1PDDJwNxGsg
         vPA1ZBXGHGsKixGpD/uBCBkFlfP819WcqTUTq/TS/EvN0EuwP8I486ALRJQrMOZWeOXO
         YAHYDmIN5QWfCRe/4EVLVMSSlUNIj2nUfBq65YIy1C0k7/DQoOi7B5RS2vFm9BcEWaAI
         QRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758654; x=1745363454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwjWfT5B0K/JFdE14QntNpQqgQ/FkvVTBI1loxQKWbE=;
        b=Hpjsd7Wcr3cAJXVJpJfmkJcruriXgB14ExjgES3FBoc58WogpPsPs1Qz7spqLMWZ6N
         w9+qqWeTrveEEt7YFA2EW3jmVSpziiP/NjVmgNKa6eFy+gNDl8vNyDYmkupsX3gQJ1Jc
         tDVsmhq5jZhYyOOQzMoZd3wDnbdT6LwdC9gG7gubjfvEw3vS/uGObxLLHuO3PI5VDYV7
         cjLrx++gzw1kJNat88INvluar8aMxDYQRKyWRAWiwCCt+IfY8qD/ltRKk03qk3SBDK2a
         T2gQjeTa+gfiyDpRtU+EIFdpYrwY1TpWqMQBt+Pe0oRfPXo6x0UmQyinqgVNj+8xI3J3
         irJw==
X-Forwarded-Encrypted: i=1; AJvYcCVB/1ABY9mMlc1ARZi06bXZpVCOGdLozeTyUS11oD8kFOC7qyV+krIqTWM/wgRW/lG1IIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLYimF3tcq02snppRai6PPzq34kYxj1qQFNv8dmwM3SSfcheq
	giFcstShgL8QjhZZ6quxPlPpI+3VDlHSaUXi4MQlDk/UTnq/HN2G9CiFxtF2inb1vIMMfnicONa
	+uXT8LDfaxOh18iz8WrDBnJWJnSM=
X-Gm-Gg: ASbGncvFiKHetOHvTO9akWn+xQ3cM03p1bmWAMeD0FWSI6NYSlQka211qqXky4xROaB
	XPx8cWeITS2xWlTKYubsJIxezye5AP4vvBgSRDJfHy1Va8lN8ViyLD9Ho2fNuoOItd0/xhGiOHR
	hKeEhrsujIsbmwzS735bMNKYMNFfgKRmBosr6I2aXsCkRNnreq
X-Google-Smtp-Source: AGHT+IGEocVpj24ecC8R40cFYUgARcp1wAwtN/wxR51MHqQVQ+j0gRTEUjIvAKGshj5RSliTekUXjboEXzGDRHPVeJA=
X-Received: by 2002:a17:90b:5864:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-3085ef05d9cmr1580195a91.11.1744758653927; Tue, 15 Apr 2025
 16:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414212207.63163-1-kuniyu@amazon.com> <20250414212207.63163-2-kuniyu@amazon.com>
In-Reply-To: <20250414212207.63163-2-kuniyu@amazon.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Apr 2025 16:10:42 -0700
X-Gm-Features: ATxdqUE1Zz445_8iGYS67s6z577-DqMXGWgLXCB7yYUEny6IR7asygYJy5hxq6c
Message-ID: <CAEf4BzbjeuMkJZnqL-E4x+mb744=sNWyaFaboKHY-V5ovWhqTQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Allow bpf_int_jit_compile() to set errno.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shahab Vahedi <list+bpf@vahedi.org>, 
	Russell King <linux@armlinux.org.uk>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 2:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> There are some failure paths in bpf_int_jit_compile() that are not
> worth triggering a warning in __bpf_prog_ret0_warn().
>
> For example, if we fail to allocate memory in bpf_int_jit_compile(),
> we should propagate -ENOMEM to userspace instead of attaching
> __bpf_prog_ret0_warn().
>
> Let's pass &err to bpf_int_jit_compile() to propagate errno.

Is there any reason we are not just returning ERR_PTR() instead of the
approach in this patch? That seems more canonical within BPF
subsystem, if we need to return error for pointer-returning functions?

>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  arch/arc/net/bpf_jit_core.c      |  2 +-
>  arch/arm/net/bpf_jit_32.c        |  2 +-
>  arch/arm64/net/bpf_jit_comp.c    |  2 +-
>  arch/loongarch/net/bpf_jit.c     |  2 +-
>  arch/mips/net/bpf_jit_comp.c     |  2 +-
>  arch/parisc/net/bpf_jit_core.c   |  2 +-
>  arch/powerpc/net/bpf_jit_comp.c  |  2 +-
>  arch/riscv/net/bpf_jit_core.c    |  2 +-
>  arch/s390/net/bpf_jit_comp.c     |  2 +-
>  arch/sparc/net/bpf_jit_comp_64.c |  2 +-
>  arch/x86/net/bpf_jit_comp.c      |  2 +-
>  arch/x86/net/bpf_jit_comp32.c    |  2 +-
>  include/linux/filter.h           |  2 +-
>  kernel/bpf/core.c                |  6 ++++--
>  kernel/bpf/verifier.c            | 21 +++++++++++++++------
>  15 files changed, 32 insertions(+), 21 deletions(-)
>

[...]

