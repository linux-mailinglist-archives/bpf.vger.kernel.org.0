Return-Path: <bpf+bounces-78830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDB4D1C432
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6140130142C7
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F6284896;
	Wed, 14 Jan 2026 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1kTo595"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161C2E401
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361485; cv=none; b=c2QpZzlFj23WV1I6ZKS7W422NgTLhlB7L0Rl4NX2w0A8BKQDMDckvA2ghq8x1oTECd/fl81F/BMwA8t92bL11HicxnpP/tE5v2/4qPHyf8CaSFiXzVqGaUBgx+eDzMaoTIavNoJN+Oa05scOsO3XlYcqS6wBILdb0Ts42pkuv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361485; c=relaxed/simple;
	bh=cfrqsW8sP5o7ktsIS6ZHNgJ7VMmSDGubBh2uclhq+J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3c+xp/BuhrT/pDrncGV1GIWie9+uSNnA8Ybl2AyFI/H7iofRyYEVExGjru0wAr05VER2cw92s2mbj42Lfkubrb/t4EBye9R4NMhw4zX8nh43szw3sJQVOq5fxABZ3EpwZLYDBcC9jGpfN3U/FgAvv+cVihKjlXvOT0718PHcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1kTo595; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f57cd471so4139742f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 19:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768361482; x=1768966282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAwkswLSDvceXj/iX0pI2u7qJO+mp3M2B3KW95gBNSc=;
        b=U1kTo595A6nqbOS6KJi2juLmo2M+W9Wp5chwQzvnESOMwgdS6K57Xvb48P3FbcXlWs
         4ZzLsmN7GYENKfNVEyZRq6hLTkTk7kMlXSd1l7xmQguUThm/LKkeYbL6xdUP9+OsnPCk
         NwcQof6WgRapdRBb8zDqfH9dsM0RuxG1NGMQ3tO+l3B/lP24zK8ocs8+jsyCOEg6CMO6
         LsaOAPdCoiY012XRQrGhABrhr7yjhN3rtfcBXklFwTQtpTCgOVhYf8jRdt0jCWwN/OJH
         YtiwCR0WLUjq8eX5gM1RcGiSJlqK+3RkWiyxVdUa8rTmPgbRKniEa5RCnytAM8EXVyIQ
         f2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768361482; x=1768966282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAwkswLSDvceXj/iX0pI2u7qJO+mp3M2B3KW95gBNSc=;
        b=CmrKV184PvOCjYVfxzgSaJLjyaBA0grVTMjC/lglkf9yP01BrXiEmloh689u/g+J8a
         Lu7lMPc8C9LRtxQUwPALFI2zMgpDfJ8wrC1YR2PcByXkLNoqcp4gesDgk6gDrBoxw6Vg
         Syvi0RIIwwE7SZuZiKPCHuzjJSzKEaU2VYpT9jPoryqy/J3S2DB/RIm2kkMyebfqhD6a
         oxYDYEHlt1CqhrXf0yfYNCIKOSYb1c4enruDUDSM9DjKmZqchev9Up5jREyB2CE9c92c
         AyYxfyAsDQQ3uM+JJTDLTov6NqI2G043WR/Q3WZ9JGw4gvyZ29JN6mGiLAzAnQdVOdcf
         f21Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEx9iJ6yG45gTTHhbkuzmjv1HJK8lDYq4IML+pjqeqdl31erdyNABd7ndQ2gao0ZSdj9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Ji6nDaL40TAU7lYtSWJEaVJzRVADLOaOU0nDXolU847feATT
	/SeAuEeal8/rIRbfuVFIcM1Wrk3mPUwpqTFWsU/iax/fTyyhAQA2jY6KNr1ovx01nFi80EST1kR
	fsR5+uMwEEmaWexI3SvzbCtpDeUifVHM=
X-Gm-Gg: AY/fxX7cvPE3RJZlrGWFxbShRJq92X6qFR68wfj8kzPNzw10kbnVJDNWBoa0/MUeISD
	JtbmOQ8zSF6nVt0wALmri5rKh43mQ+dVdBwJQxHxdIqOyNqAkfDcVwgOyPtfph3IedWk67/MvZE
	cXwzxO2TotlE6mSTsMQjVzWHAUECQtyfzNS2J8ly7dB5S3QwP/u4HEoiWggKlGqakPGayPG1vF6
	yKH4dQziIKE5sRonQubDGH15rZLqu3ob0LDOjBvhXqpLCtWZqQAXe7VYkkFU3DCqgmC0FAr0DmV
	PjvGJinfp0C9E7wLYBXA1KTHkkwS
X-Received: by 2002:a05:6000:310c:b0:430:fc63:8c8 with SMTP id
 ffacd0b85a97d-4342c54759dmr1005118f8f.35.1768361482534; Tue, 13 Jan 2026
 19:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz> <20260112-sheaves-for-all-v2-13-98225cfb50cf@suse.cz>
In-Reply-To: <20260112-sheaves-for-all-v2-13-98225cfb50cf@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 19:31:11 -0800
X-Gm-Features: AZwV_QjU8IHt4ADtGwZuCMWdsEN668TGd1jbbhsvRKh-PS7J4GcDNvMn4EbhZYo
Message-ID: <CAADnVQKBt2xmqs+o0onUwd7G-0UDbE8LECnkJJUCVbywAr2tUg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 13/20] slab: simplify kmalloc_nolock()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 7:17=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> The kmalloc_nolock() implementation has several complications and
> restrictions due to SLUB's cpu slab locking, lockless fastpath and
> PREEMPT_RT differences. With cpu slab usage removed, we can simplify
> things:
>
> - the local_lock_cpu_slab() macros became unused, remove them
>
> - we no longer need to set up lockdep classes on PREEMPT_RT
>
> - we no longer need to annotate ___slab_alloc as NOKPROBE_SYMBOL
>   since there's no lockless cpu freelist manipulation anymore
>
> - __slab_alloc_node() can be called from kmalloc_nolock_noprof()
>   unconditionally. It can also no longer return EBUSY. But trylock
>   failures can still happen so retry with the larger bucket if the
>   allocation fails for any reason.
>
> Note that we still need __CMPXCHG_DOUBLE, because while it was removed
> we don't use cmpxchg16b on cpu freelist anymore, we still use it on
> slab freelist, and the alternative is slab_lock() which can be
> interrupted by a nmi. Clarify the comment to mention it specifically.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

sheaves and corresponding simplification of nolock() logic
in patches 11,12,13 look very promising to me.

Acked-by: Alexei Starovoitov <ast@kernel.org>

