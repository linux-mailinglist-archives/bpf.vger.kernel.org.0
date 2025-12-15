Return-Path: <bpf+bounces-76600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF6CBD25E
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3EB23017065
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2613C320CB6;
	Mon, 15 Dec 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1hhOrw/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFF320A38
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790546; cv=none; b=Aehv+IM6QLXIbQHzyml939F8SP6e9nCaWD9SfebzuyWeWJNelLJAbSdi4rwcTPzcBAt+hoZ2r+3vq+AkHGG15lKVfr+TXMTHMThDyZgLIG3FoEyodATlq4cY3ykBR1tzUuSgkJEW7zqEZVRrLSFObSaAh7aUm3qLCLfJt/xW+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790546; c=relaxed/simple;
	bh=rRgk/jKyq3Xc+z294BSrYdB5EGZbteu2gYXGFcGqquw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HbHgS3Kcj2sOa7lmRxV2zcVIQ+iaMDymuhJwOWNmfiwSPOkHShLqv5NC1nYX4g931fVWRu2CFnWOg6/DOKyf3Zx6DKA5OFnojXSgXEBLj4nxJiADl512xjbUt8EteLAxF7LfRUyRtlAqD1eULZxLMZGWZLXjfIVt9ruhmYkSMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1hhOrw/; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-649839c5653so4946823a12.1
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 01:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765790543; x=1766395343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRgk/jKyq3Xc+z294BSrYdB5EGZbteu2gYXGFcGqquw=;
        b=J1hhOrw/8M2Se6/m0bGqpXY8UkWEM1ckvf/oW11Mzwma0wxV06Wbq90JpPDD8l/0ci
         BeJsEtvt4BfL+rWxs6795aOQbmE9KAGKxmJehKKVMJt46VMoZyt8BHEmz6MeA4dTqi55
         TJE8L5TmRbZx+f8chM0QN1UHUFcOjfzibWeJm00RCn/qa5/D1QrUfdDYS+y12Ub0PDaW
         n4KHc29SffuwHK219o4Udp8i7KTYY+vYu5f7D4cK8bj92j1nKTlH1qAUph1qZDK13ftr
         Ez4wMB/GzpvIb+vttHZdsmb5mj2jpo9DKVgXluqqPAsm1Hpdnbexs36yFT9Ff0tCQAk4
         rEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765790543; x=1766395343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRgk/jKyq3Xc+z294BSrYdB5EGZbteu2gYXGFcGqquw=;
        b=rZI2AUw/37ys13KtPgzZzor5anMewIbbx49FC0BdZisgEd7PwizqTUDxlDW8SeWP3H
         j24sJE/KVpICY38MP3mv5QXfnsdAfBZMRgMnHxgIfvqZs3/wxf/O1RYIbUqD19fhG5kF
         zdqN+Qq0q+XJR0+o5gTzSEee3wlbBtY8Qgan7Lc969LEeAuHyneCUdHbFx91nP6MP1D2
         ozZ4z5kiw6W99wAa+OKMeXu6ecF01rDxUGQgz1PpG9pfankOLeiq97z4rfDcc56QfWw1
         f3Ik5B5mMHmlxvEj1MsEBBDEr0nQQ4hwr7WeT3rEfZf5/6OS7BgaHnXk7ngbfKgniWzs
         s1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKYIFhst+3eNFk9kS/jnt89P+vxgMDZq+CdFuGgfoMfIoz2LvbpBdhD1gsPNoCUXufvyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6rsPMWZsLQVx0MiIJlr6QEHohvzFXnvGw+6prxxOckEbeViZ
	Ijx1xwWPtxsTup6ZFHokREiaw5LyhLNUqs2hPUlik3k3CGkxRkfnCEvqkMB8vkYypiC14MfH90g
	pf1AP1SAQ62I/Cg==
X-Google-Smtp-Source: AGHT+IGqA6/7NhdOmRJlayZuRkq/89Snr/0cKuIgnNpYQ1catSJLJfZQNQG1cjXYcwltRqxHcaD6SGiYTjuK7g==
X-Received: from edbdy7.prod.google.com ([2002:a05:6402:31e7:b0:649:8456:d4bf])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4312:b0:649:62e1:10ca with SMTP id 4fb4d7f45d1cf-6499b1d86bfmr9525174a12.27.1765790543128;
 Mon, 15 Dec 2025 01:22:23 -0800 (PST)
Date: Mon, 15 Dec 2025 09:22:22 +0000
In-Reply-To: <aT5/y3cSGIzi2K+m@e129823.arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com> <aT5/y3cSGIzi2K+m@e129823.arm.com>
X-Mailer: aerc 0.21.0
Message-ID: <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
From: Brendan Jackman <jackmanb@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, Brendan Jackman <jackmanb@google.com>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>, 
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>, 
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jolsa@kernel.org>, <hannes@cmpxchg.org>, 
	<ziy@nvidia.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>, 
	<rostedt@goodmis.org>, <catalin.marinas@arm.com>, <will@kernel.org>, 
	<ryan.roberts@arm.com>, <kevin.brodsky@arm.com>, <dev.jain@arm.com>, 
	<yang@os.amperecomputing.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, 
	<linux-rt-devel@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sun Dec 14, 2025 at 9:13 AM UTC, Yeoreum Yun wrote:
>> I don't have the context on what this code is doing so take this with
>> a grain of salt, but...
>>
>> The point of the _nolock alloc is to give the allocator an excuse to
>> fail. Panicking on that failure doesn't seem like a great idea to me?
>
> I thought first whether it changes to "static" memory area to handle
> this in PREEMPT_RT.
> But since this function is called while smp_cpus_done().
> So, I think it's fine since there wouldn't be a contention for
> memory allocation in this phase.

Then shouldn't it use _nolock unconditionally?

