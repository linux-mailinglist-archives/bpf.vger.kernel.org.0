Return-Path: <bpf+bounces-21696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921258502E6
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35281C2216A
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94820DEA;
	Sat, 10 Feb 2024 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJT9UW5F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF66FC2
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548771; cv=none; b=tRrqqaqKtXUDHzgOXcWj7IoLAZudak/WYnFK7JhVJtxVtjBjPMu8X9Tm6ZyVzx7o91KnXmS2pFGlfSGMduFwbBuQrt7OU09HneQCP+jbQOgNz9ABYHdC6Nla/zhbjwKuWP2/IHBkXDGAHM7Wh5SjJSmAZGfA4+zUAHSYx0JeQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548771; c=relaxed/simple;
	bh=sYD/R7R/hDmyEGsp+e2S1PWj3Ofbsbn3C7SMz8GGlis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRazuWuVDrs91BsiAx/LGxurrOVOiy8EtAMvjiZGVtSVmXHCoqObPNe6/67uvUH4mO+9gz7P0GE1YogdDypi5xi4873Sz2ePHyJZ3W9fg6m7KJs8TdUX+E24Z2Lw7l+LZuS17Sm0nJ+jGp7QJXtE4zk/iAciam449aurOKVUkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJT9UW5F; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a38271c0bd5so208337866b.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 23:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707548768; x=1708153568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMrLd53X4p2C1U3yzWk5+am9wSMQVZW9rTtdVqVc6n8=;
        b=dJT9UW5FPdXhG+lKhwZkXfU2Iyh/3HXXfAwwFIxnEINhHVNic9H0t971gOIJ/y0AVZ
         xLcfKSb3E8xcFcANwFgsZCs3T9WTgPpBoUZ7lN9OSJS3ApJWOCIuwbIgpHBNoAO/lItQ
         MzZBfzqxst4g/bRT+O+iSufB7C31MSLngQuOiE41Is3sWwlDWGKdBsfxI078tIDXeCUG
         oY/Zw1Iw+UTZLE0GGdZKiMU5NSVwjyTJqz85LQ1Cu0OxMm8OgppjfcgrkF8QvYrCUE3l
         IET6Q6rh11EXIqkViE54RXMZYiD8+Z4X/ElNz+2GBgcZpqmPPqRXqHnEbW/aPZ0+HTj4
         Z3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548768; x=1708153568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMrLd53X4p2C1U3yzWk5+am9wSMQVZW9rTtdVqVc6n8=;
        b=ivaRmrc9edOpVtuz9AVNU8B1xoY6D0yy6pmN6duLAfC1G7KAZiCC7WiuG3OdK8na1n
         /lpo6pmj8ykO3ew4xz/Dva/8gjOqsDfuiR1YxtGAxHtQI7H9MpODzPRGHCk+HQiZqBYo
         eNdVo18qnQBYnrr/gLPpWjwZA7WsHgcb5Ek8r8QtbMuLhovJ+/tAgOTap7K5UtgyI6QB
         lEONExzbFXLtZt3HuhbadjRRaSRB9nVvBNQrUmkMon7/SAo0WZtGKTKTJDxvTf8vIFpe
         I0DpAJeqapmtI5dMuOsVmNhU+j2eehxOjnOQJQ41hmYCBImr8kfkKvmAWB+SynQT3HoB
         eQCQ==
X-Gm-Message-State: AOJu0YyVlVzidy7LYcSlitythloIM1fk3iKqXCP9gXHsNaKrRyCUYseI
	iBd2NbpVCkHrbjQjC9TAz9JrZsluJ7wJ/lz9EK4y0YbbcpK4wC8DTHZjSMcCLaA8n8j3+zCNT/H
	XlnKj2IHthjn2vGGOV/PdxlsP1og=
X-Google-Smtp-Source: AGHT+IGc4Om1nlYW5n7s8S6p5fXk27M+WU4383LiEpV4fysMa0+wXFwrvmE6xvIfTGXQgFjLIcmTIwH0rGTsuIvGr8U=
X-Received: by 2002:a17:906:6885:b0:a3b:d8b3:bb6c with SMTP id
 n5-20020a170906688500b00a3bd8b3bb6cmr877217ejr.12.1707548767644; Fri, 09 Feb
 2024 23:06:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-21-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-21-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 08:05:31 +0100
Message-ID: <CAP01T74x-N71rbS+jZ2z+3MPMe5WDeWKV_gWJmDCikV0YOpPFQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 20/20] selftests/bpf: Convert simple page_frag
 allocator to per-cpu.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:07, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Convert simple page_frag allocator to per-cpu page_frag to further stress test
> a combination of __arena global and static variables and alloc/free from arena.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

I know this organically grew from a toy implementation, but since
people will most likely be looking at selftests as usage examples, it
might be better to expose bpf_preempt_disable/enable and use it in the
case of per-CPU page_frag allocator? No need to block on this, can be
added on top later.

The kfunc is useful on its own for writing safe per-CPU data
structures or other memory allocators like bpf_ma on top of arenas.
It is also necessary as a building block for writing spin locks
natively in BPF on top of the arena map which we may add later.
I have a patch lying around for this, verifier plumbing is mostly the
same as rcu_read_lock.
I can send it out with tests, or otherwise if you want to add it to
this series, you go ahead.

>  [...]
>

