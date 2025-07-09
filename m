Return-Path: <bpf+bounces-62750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C725AFDF3C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 07:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F73A482151
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 05:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8B26A1A4;
	Wed,  9 Jul 2025 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU0STjlT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEE18A6AE
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038873; cv=none; b=pfn/7YDwPEN7FzjU3ElfnVhhi+RRDGaHUQisHOcNP/Q8DchvWTtG+K5G2tJ66K21gC/w7hYt+lrV9BxOkmZjevffov0lzSA0it7MGmTzNkRsF+/PJkL9nlM3RSgTtpXtLYgO8K62rzpq+RNXTf2lYRufFV85ILbSN7QGj39/PVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038873; c=relaxed/simple;
	bh=GYS2FKIOyYBj7THuTRKw9NgfHgWcfLNY4YIYyD0+Ccc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKMryMchsDvJRu7URBDgs3qbzrwQ5IkXUkVQtePcSJkN0T0gUqkSdsFTcUVKr8BfRhNPag6H2pK8a/UlpUrpzST3q8IJyuiaahApzHCwcULkbE6/DA4AuFi/OWiEkouC+ivSX0lGy/KIyXLhFCRaiGFZz5rioe9TInn1d8uOZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU0STjlT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-454ac069223so2878825e9.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 22:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752038870; x=1752643670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XNJQb9qyJ18K9oAMjaL8rvQ6AZ/+KAOB2Jf5CYkuw10=;
        b=IU0STjlTrkZsP7AdpPVnYtFT1dIBu7H69rOLa9LQnTks2VWKdaJE6w1Xy0qa58sv0O
         PGZXQsMKgvLebA2zEv1JO9fqQTYrkTGBLKD+iXGY8HPAoMTQ9X6S8RqT6lqqByMse+r8
         hGzLcF6ol/+KjvhMwZXgOkx79L1OF41FTGnpNksauQTCm9++n+f9pS6W5v2ODbR2OYzW
         xOtOUXgAlPu+8M/ORcvQkx9O9G199pthgzwYjenevENdn7kM6JrEzBXK++iBK7TQVvpC
         k3icFeFaob7NFkdXiJXAS9fzIn1LTmubTX5Dv/3JirRrWVCCX0qbw5eqBbC1T1jfACMp
         yR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752038870; x=1752643670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNJQb9qyJ18K9oAMjaL8rvQ6AZ/+KAOB2Jf5CYkuw10=;
        b=dllefoHRzsmtbcypZ/LQ5XWsxTK72Hb65uK+OCAe8xyNQpA/108R9VK4KUC5q0KVDp
         KxwM2wKQbe5Na5hw8CU+erMkP+nA82QtKaOzehcn0XT+mdzsOj1NxoYsOfZMrjCO5tCt
         FLirRo64lYWTT+ca1Z7D3G8w6yjowT9KpX97anL/77e+pq5wp9TqC4PXvWxxNQNFt+5V
         LXMJA7AHaPrgOJ7VLpzFgQ4jhtlH3n36jUr1WacaS/qBp38BqttgfagHT7hBAG25doC0
         W6M+E0dupVfqv+3wsR7J+DRgw5q1SDrp3cvss6WuUd8ALc6f4NGeQPgoQTbV+7Arkdp8
         orJg==
X-Forwarded-Encrypted: i=1; AJvYcCUJTlCHNIBA7V1WBZeD0bvn/DG5voy2ySBt7ce3Qj+YYYJMltDX7sJni2/FdyCU2RT4Uxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ37/WPBxqx+tdGEKuKJKj5OI0RBveQ/AbdN7qB3nm0a7YOFh7
	FL4corpkqAhTxjDB2M+76lqOZBfMBVXadb7CmCzKIhz0/b5RRVLgO2kG
X-Gm-Gg: ASbGnctr1QMQiB7Y2AbAkakd2JIKJd6SnPtbN1cej9eAXgqsX8y0+MLdRk34/hwbsKs
	AT9DVc8cQKeRLpHl9wZfikRuRKD2EiXcZTex4O9E+I/8U4f9RibBS6q1pPRTxsOLcm/zk/l7JQU
	/4H/i7S1j9Iuh8Z37Ext5+4Ph2oDBlg9W/o/Jek6GLiO0mNC1kRS0oZ3xLq8yBFd//SNHeFxGQ1
	xjvorPQzmi9ccLJQ7Bggr7u+rldpq1/U6fRjayPXSvxs0zp6ocar6FCn2A4BihzFKJ80DgEIThY
	1/31pWkf8dDWp1kmccng5bUbY1gE57ga4YZOkwEp1SqKpAn40o0gJrteWTPvSIhq8zdzsHfEVw=
	=
X-Google-Smtp-Source: AGHT+IEp+/2Ph2RJJh+khfUWAzBWEFUHONmq2POBaLyJ5vFTcT4K5zqome/cHUNnw1o5wXWDnQg6hw==
X-Received: by 2002:a05:600c:1d25:b0:453:7713:476c with SMTP id 5b1f17b1804b1-454d7629edfmr1464515e9.2.1752038869759;
        Tue, 08 Jul 2025 22:27:49 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285bdf8sm14517056f8f.87.2025.07.08.22.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 22:27:49 -0700 (PDT)
Date: Wed, 9 Jul 2025 05:33:37 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
Message-ID: <aG3/MWCOwdk5z0mp@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
 <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>

On 25/07/08 01:59PM, Eduard Zingerman wrote:
> On Tue, 2025-06-17 at 20:22 -0700, Alexei Starovoitov wrote:
> > On Sun, Jun 15, 2025 at 1:55 AM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > > 
> > > The final line generates an indirect jump. The
> > > format of the indirect jump instruction supported by BPF is
> > > 
> > >     BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=fd(M)
> > > 
> 
> [...]
> 
> > Uglier alternatives is to redesign the gotox encoding and
> > drop ld_imm64 and *=8 altogether.
> > Then gotox jmp_table[R5] will be like jumbo insn that
> > does *=8 and load inside and JIT emits all that.
> > But it's ugly and likely has other downsides.
> 
> I talked to Alexei and Yonghong off-list, and we seem to be in
> agreement that having a single gotox capturing both the map and the
> offset looks more elegant. E.g.:
> 
>   gotox imm32[dst_reg];
> 
> Where imm32 is an fd of the map corresponding to the jump table,
> and dst-reg is an offset inside the table (it could also be an index).
> 
> So, instead of a current codegen:
> 
>   0000000000000000 <foo>:
>        ...
>        1:       w1 = w1
>        2:       r1 <<= 0x3
>        3:       r2 = 0x0 ll
>                 0000000000000018:  R_BPF_64_64  .BPF.JT.0.0
>        5:       r2 += r1
>        6:       r1 = *(u64 *)(r2 + 0x0)
>        7:       gotox r1
>                 0000000000000038:  R_BPF_64_64  .BPF.JT.0.0
> 
> LLVM would produce:
> 
>   0000000000000000 <foo>:
>        ...
>        1:       w1 = w1
>        2:       r1 <<= 0x3
>        3:       gotox r1
>                 0000000000000038:  R_BPF_64_64  .BPF.JT.0.0
> 
> This sequence leaks a bit less implementation details and avoids a
> check for correspondence between load and gotox instructions.
> It will require using REG_AX on the jit side.
> LLVM side implementation is not hard, as it directly maps to `br_jt`
> selection DAG instruction.
> 
> Anton, wdyt?

I think that this is exactly what I had proposed originally in [1],
so yes, IMO this looks more elegant indeed. (Back then the feedback was
that this is too esoteric, and instead the verifier should be taught
to eat what LLVM generates (<<3 and load).) The instruction can be
extended (SRC and OFF are unused) to support more formats later.

>        3:       gotox r1
>                 0000000000000038:  R_BPF_64_64  .BPF.JT.0.0

How hard is to teach the LLVM to generate this?

  [1] https://lpc.events/event/18/contributions/1941/

