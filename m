Return-Path: <bpf+bounces-79167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05202D295D6
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 01:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435E5304A91E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 00:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF871862A;
	Fri, 16 Jan 2026 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbofzJRJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5641A92E
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521991; cv=pass; b=fqhlXjuBHjVADiko8Fov08mdSyreNdThiSSYx9Zo6k2zGQrp+ctQ650Rece9KHfbWDb3F5RyRM8jR2he4W3hm34fAbypn0Ar+rmbaPSGWEKrZp7o2a8ojrUO1tmedLSWnedXr73QZIKtAtHHDqSlISgMLxTtUSUgu8auL7nIfSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521991; c=relaxed/simple;
	bh=026F9tB9C4DnFMNAbwjqTuZTqI/FPwSez2fEDi6wXsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKyFEovPiMlZ1K3DtrV5cATclWqnJac2A+7i7g0XO313hr70r7aTMD1DYkrsVr5k4qJPkc39rCIXRqS6tYYqEXhhSo6MRo2/lgwjm9hdo96yHMMZ8Pn7d2o5Y6VjDnyGqcxLUWdifu+8FacATcUqBu6hlfWOOVEOU1GDqE2gYww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbofzJRJ; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b66d427e9so1710a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 16:06:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768521988; cv=none;
        d=google.com; s=arc-20240605;
        b=JEfevq7CxdtXrQ1Z3zyCsBDh67l+WlRb6UIo1LSK3GxXKD9N1MNmiUhfWiQoQ15D82
         PNZ70u12pOy1ysqoS8r6WoUezs2bA5KDE2m62gLfDXz4FM9UscHZvbWf1okuBfFtuQWo
         /mvV66CyHCoMq1BOBxvvFmfLe7+6PGjB6UOOGyoIePz9geMhYRJrRmsxkEg828Eutx0k
         txnQpixVIataUMwpsd2KHkin2DsUvxTlOACeVCLdu+cka0Ia8DGSpbS+AM2SPvIovXrj
         HFGj/7qp/TRZZNosJvihqQg0b6qyq13nm65sntt4b/kti9up5ORscZTGaWXZyt/cWOnz
         /V7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=026F9tB9C4DnFMNAbwjqTuZTqI/FPwSez2fEDi6wXsM=;
        fh=GlCQOz5x5c52s96GlXT0PhHvfQruw7Oj28xHSu9ZHew=;
        b=BH5GVQ2aWeXkSI03LhgHWzyKo1EUcq8eSg8f5SdshkNf41FNta9MUNHWcTAiObOg4a
         e5ystVxX2d8PMiIqGdpCKfU3oWxXSUq8RwFdxpkkGhYn1JyVIUrLKHjzlJOOGwWJwj0V
         nf3BgdviJPMEwsX9tq3209A6ANE8qMJoc7F4++pMm2s8dhyT8rLTjaCesaX12dmoCIch
         JGR8OsD/flzD9H5Q4L5GfdPUBUb0WHuu2uJYmd+apFcwXCmF8xapr3R0kb8T/Lm+ZtdS
         M0uWFxczfuxC6UCqDB5Oa16WM6mqx8182a8xHUghzkcIYwqtAkCXGC1iojTpiwX1SKY7
         91OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768521988; x=1769126788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=026F9tB9C4DnFMNAbwjqTuZTqI/FPwSez2fEDi6wXsM=;
        b=JbofzJRJyDGE2WFjGAzSg0/cphuJpchBbAD2PcwVDtk54AAb4c9x/oQKH/+DZRovMo
         GXuGT2hhgDuJH+duHFIlnqs3SkSv/6OqKU2BzDWnPHy9Os3bikP6RLzwHaM5aSVjyqQB
         PoHYwZiOeJ2rv9oHnLrlcQm3BvFVeygQ5yLgWMAJArERsYhvz7cj6XH9BifQZ17GM6l0
         vDVhKjgnyHrUF+GwW0voA8aASv4/rcyn4fgrFbaI1hnRYn72xVfDU+JkT9umUIl6+QW7
         NO3VdmttQwoWVg2eptF67vjtSDedVIHupm9gITmz7Is38hmcabL7bs8+AzGlIguDLoOK
         4dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521988; x=1769126788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=026F9tB9C4DnFMNAbwjqTuZTqI/FPwSez2fEDi6wXsM=;
        b=mfIeWynzLYNrtwobz+ZeB2sk9R1SEbfkkZ9k1I2dSr7OU4MQqtIK+ZAEjp7PZGq5Cf
         y/IQPT2dT+mPVL4C/2u/kUORJVVaB49LrEUGUkQiwY3GUS8/xjGzyLAtKI6+1ohCna00
         LZqaBDZ/+5Yp7CNvAGo3NjuhloEXAshtB3ENPhxH4EsK5Ak9M33Z+0ZHCY6vFcSSaSW6
         yzGvRKo5+decFXR2080sSTf2hVFX7FaZiUSAB0fHH3/RKECqPAgakOiaHFXmObCP9p09
         3ub0pJ0fElGlMBYdy333n/hZWVsObYMFXcL5wHr9xDvCiG/CVKsBXI/tJFnoVhQ5yQwg
         Lu6w==
X-Forwarded-Encrypted: i=1; AJvYcCV/AZMCfWmpK3r4haWWxkioh61NMDBIjclWumQRvRsy2p1I9Cc7i7cys4a1akn5QbuEINU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+TQsCzncmCQwfR+u2uw6AFEkPtHcfBNoASybF8qllQdznois
	S8YArEezqXAIsp8X3giBekXMbyIpBZSOVon3cbBlSnR03vMzH+njtonjA14eoTgPJtrD92AhDJa
	NEtl8K1CMiMKXiRPg31kzokXDuix2yMBnbJrRVhiV
X-Gm-Gg: AY/fxX5R04hFV3bF+IcxkIECEEtGw3PqyQWrVInGwoFHWSGUp/SDx8ialpyjLL68xV0
	Nv8vZpRm6YO+dT727jiTw83xRcoXHPv2A66XnaMtdF5vAt+p9lUxtJKvnEqyN6pWXp1ubqhFcQI
	8Yd12zz2dbbl0xcQbf86icZCdF/1Jgqq5KPEEjns3igQ0E24tcDdDDs0niS4TU0LlD/Q9Yk0q6A
	L8f7b192Gq6TUV0xPQELeHVH88E2q5v7MLXUc7srS0C3Z9PXLZ5SKa8HbfrHIOZqiRAjFNZN3V7
	reBa47xBSDYtHyDj1/PTBUU=
X-Received: by 2002:a05:6402:564a:b0:645:21c1:28f9 with SMTP id
 4fb4d7f45d1cf-655252e133fmr5226a12.17.1768521988035; Thu, 15 Jan 2026
 16:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-2-98225cfb50cf@suse.cz> <aWXvAGA_GqQEJpB4@hyeyoo>
In-Reply-To: <aWXvAGA_GqQEJpB4@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 00:06:15 +0000
X-Gm-Features: AZwV_QiPFAF4oyordk9NHVKA3LxKDdMlmD4Vltq0PHkaKAiIFW6MRACIK30AxWk
Message-ID: <CAJuCfpE7ctb+AYEsmmDbW-3+DU-kDb2ApYWYXRur5FDtPP6zng@mail.gmail.com>
Subject: Re: [PATCH RFC v2 02/20] mm/slab: move and refactor __kmem_cache_alias()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 7:06=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Jan 12, 2026 at 04:16:56PM +0100, Vlastimil Babka wrote:
> > Move __kmem_cache_alias() to slab_common.c since it's called by
> > __kmem_cache_create_args() and calls find_mergeable() that both
> > are in this file. We can remove two slab.h declarations and make
> > them static. Instead declare sysfs_slab_alias() from slub.c so
> > that __kmem_cache_alias() can keep caling it.

nit: s/caling/calling

> >
> > Add args parameter to __kmem_cache_alias() and find_mergeable() instead
> > of align and ctor. With that we can also move the checks for usersize
> > and sheaf_capacity there from __kmem_cache_create_args() and make the
> > result more symmetric with slab_unmergeable().
> >
> > No functional changes intended.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>
> Looks good to me, so:
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Cheers,
> Harry / Hyeonggon

