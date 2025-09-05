Return-Path: <bpf+bounces-67540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619BAB451E1
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BD4A042E2
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C5309DD2;
	Fri,  5 Sep 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bnumHXjM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BC2F747F
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061778; cv=none; b=jjOZ/o4eDFZuPwr1fXMcIrYHpBWIpEsZzAXdTwGqkNlsbPD7cSZjnCTqXBTp6gNSsfWr+E6TviV/5WYGSGM8yoUCwttPyEPRFc7dYF+Ta55BeNMyiAJfPaGtGPk3UCveswWi/YrlM8IzVIIhzrSPh8th9tWI63pWmLCASD013t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061778; c=relaxed/simple;
	bh=EoMaYTYHFXEwCGBlN/IEjhrPWRNTs6kRsDou2dH4cSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc35QLhcUG796Rqtlvmb8jYxnCkjw+8ju4qG8RbrFCEjaJ7JPXwnOyW6xjH74uDgSXJzwHgZGcelO5ABKCJhCCUuwi+cLM5YwG7TIZVVwrov8vkJ6CBevkZt3UuK0gxSpzyEIUpg5GZGXZU8aGuPLANJx6R+KXqrlLaPkfFcYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bnumHXjM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so875269f8f.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757061775; x=1757666575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Upm3gtoelWKi/OiIlfN8TaykvgP8Dbo7GPj1kZ9zlhE=;
        b=bnumHXjMsPsAYEmJ6Jb9jkgCVgqnF0tMridMkmKh93akDhM38MH2S/Ia3UAZeP/biP
         GoWOY0x/2+dVTmZXWlK4WDUJ5EKxFmHj5SCF2q7aI1juiq6iREVHszZ0orMZ9PFhoMOM
         dpDeC5Iv/ClHsF4slfWhwbEI4NCtnhDNNkRmra4HIIoLyF7mdJFCu4veqIfUWdU41dSp
         q8l5JQ+iG7KYzbzSaI1JAZsC0hiB1de244r6Oi9K6fLoINi6UT007Xa0Zy9rzvXoT9bs
         l5D8SBBZ/rPqvGrDUg3mo368I27ob4sc0CCJN4aif1xmbDtnKnrCUAFGdgbd1fYcQMGC
         aPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757061775; x=1757666575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Upm3gtoelWKi/OiIlfN8TaykvgP8Dbo7GPj1kZ9zlhE=;
        b=TNlaYlukBoIc/yFRsvv9nn/XfSCcHm5Bu7DiIp75vMmG57TU9Xx7ftgxZhnSd9skDf
         /gXGzWbHPUeV0zvFYvkPxbzBkVGXQ7caHB0hismhWmZQeCgpVbtz1+OsyJCdwP6TXFpQ
         veJ29RAliTGeGxa+lJktMwJtG/gTdJ8ElPhlPTgLFKpvIKs4VvR8tsBFvTtdpWWM5ydU
         b476TIko7afL7OmJQBjhKdStBS6xC+X+eXeQF6wKRgjMOVCDvD+LkAt+kmchShuqcXwJ
         hpzauk1drEL4CM4lvV2ZdlpRauuemTuVccGFwIyelrVFu31vfbZNO25Hrztu/0ve402L
         S9ig==
X-Gm-Message-State: AOJu0YxdwduFStVBodCfj5jP+aVpmQ6nAbjpM+h6IwzT+TMPIxzPctq3
	0Qqyu75xL9olmsOPfJDnrVGwg49YOcZsFediAnieRERTBzFfvGj8HDMJHMcphh2iwqEtrXDb0e9
	3B5WVnrvZfA==
X-Gm-Gg: ASbGncu7yjxodnCXL/NIaHg97t84na97ENJ895LB/GDxIML9uD5BaYIQ4LsaSuIYw5R
	qWjJZT9P2Nd6B6Wf7KK60nwYTCQEmnhwodmPy7dC4Pot0zqayNDd0ycn0db8LvW3S0BOwhXkUo4
	8k/EspDnX4iOE2cXvx+Vgkijgq53J6hUDmEsNJp7qF7TigRlTgR1S4zkcr0udpiq4sOTUrxmqEa
	W1gReLytrL2CwJaNqQ5gy9ok60ROwZrth+wI+Z5v+4Y/+sDWRAS7NF/bEc08n5QP3xlTpBudHUo
	nQlsGFLEMbEo4cDPIzBTHmcEZDaesWuj0Yb65cn+y/gfBrXPUSMgNNY56fmbm2j0L1EuxrnoOGh
	i6+Vn0gfx2wgWwS/ofUJNQbRd348K
X-Google-Smtp-Source: AGHT+IEQbkpijCuIHkSH8MhrhTJtQwPADWOBz/A63pVWyItEyOmzIbf0dkH52+ncdnxv4u3S/9wKgA==
X-Received: by 2002:a5d:584a:0:b0:3e3:24c3:6d71 with SMTP id ffacd0b85a97d-3e324c36f9amr1793548f8f.1.1757061774650;
        Fri, 05 Sep 2025 01:42:54 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:75a0:8d2:dc87:a659:a9df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723534c0a8sm19618409b3a.79.2025.09.05.01.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:42:54 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:42:43 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>, netdev@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [RFC bpf-next v2 0/1] libbpf: add compile-time OOB warning to
 bpf_tail_call_static
Message-ID: <3pevfugpcd2j44b2wkrjhspn2a2ta627nhnqxc6ty7dxy3nt3v@qhytbn7lmqum>
References: <20250905051814.291254-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905051814.291254-1-hoyeon.lee@suse.com>

Adding some context that I think was miss per off-list discussion with
Hoyeon.

On Fri, Sep 05, 2025 at 02:18:11PM +0900, Hoyeon Lee wrote:
> This RFC adds a compile-time check to bpf_tail_call_static() to warn
> when a constant slot(index) is >= map->max_entries. This uses a small
> BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.

This is an attempt to see if it is possible to warn user of out-of-bound
tail calls, with the assumption being that with bpf_tail_call_static()
users would not be intentionally calling with an index that is superior
to the number of entries.

However, there concerns with the current implementation, so this is
being sent as RFC to gather feedback, and to see if it can be better
done. Currently the concerns are:
- use macro to override bpf_tail_call_static()
- only works for Clang and not GCC
- uncertain whether this fit into libbpf conventions

> Clang front-end keeps the map type with a '(*max_entries)[N]' field,
> so the expression
> 
>     sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)
> 
> is resolved to N entirely at compile time. This allows diagnose_if()
> to emit a warning when a constant slot index is out of range.
> 
> Example:
> 
>     struct { /* BPF_MAP_TYPE_PROG_ARRAY = 3 */
>         __uint(type, 3);             // int (*type)[3];
>         __uint(max_entries, 100);    // int (*max_entries)[100];
>         __type(key, __u32);          // typeof(__u32) *key;
>         __type(value, __u32);        // typeof(__u32) *value;
>     } progs SEC(".maps");
> 
>     bpf_tail_call_static(ctx, &progs, 111);
> 
> produces:
> 
>     bound.bpf.c:26:9: warning: bpf_tail_call: slot >= max_entries [-Wuser-defined-warnings]
>        26 |         bpf_tail_call_static(ctx, &progs, 111);
>           |         ^
>     /usr/local/include/bpf/bpf_helpers.h:190:54: note: expanded from macro 'bpf_tail_call_static'
>       190 |          __bpf_tail_call_warn(__slot >= BPF_MAP_ENTRIES(map));                  \
>           |                                                             ^
>     /usr/local/include/bpf/bpf_helpers.h:183:20: note: from 'diagnose_if' attribute on '__bpf_tail_call_warn':
>       183 |     __attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries", "warning")));
>           |                    ^           ~~~
> 
> Out-of-bounds tail call checkup is no-ops at runtime. Emitting a
> compile-time warning can help developers detect mistakes earlier. The
> check is currently limited to Clang (due to diagnose_if) and constant
> indices, but should catch common errors.
...

