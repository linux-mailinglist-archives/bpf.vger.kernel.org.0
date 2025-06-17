Return-Path: <bpf+bounces-60849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A67ADDCFD
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB88C3ACFA8
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1732EF646;
	Tue, 17 Jun 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of12+ksd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F182EFDA4;
	Tue, 17 Jun 2025 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190929; cv=none; b=rJ/2AsHghjRS0/vt7QApKsOSbV8oXgbmeeeCCIgHrQTdXNC/Pka4i+XjZ5ls3cc/CapDBELYjzdy3U0M8gJMCWiVw8a4gXC8b1ooCYMgEpb72wzLmpZvKJxLYI7ab4DfMv7oy9gsx4chOr6XjZ+t/pVZw/RU18s2wyupPACYquA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190929; c=relaxed/simple;
	bh=+7MkDaNSvLbnsgCHheztecylUhUYF6UYGE+0ya+iFnQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IoQ9NYfdyKxipWo5NOUAcQyhdLmpiWEeY+kvACB2jhcXCuY+qzex9lrJkxbLCnaHWL/nXtchxjfRFVZeKFkXlCjCxXoviDbd35pU6BBOE11ovfTqt69wcoXERRYrHUL99h8WU9ApbhC0sS4g596oX8CoG4SW34JVS06JakPcYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of12+ksd; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e77831d68so60857167b3.2;
        Tue, 17 Jun 2025 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750190927; x=1750795727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K47AyRD9C8APvHVdVcg+JhX/4k3xEAD2ampnaOSEuhg=;
        b=Of12+ksdHJ+tENHEsoqZjPC1qi1G52Ca0vHmraBoPB84EvZHGkiNGsqe9pw8uHXgHc
         jnBrH44c4lNSE0cfYhxiAkoeodKdwcujISe27WEJCA4OAhmttylUtDnpM4A0l26Q1zDs
         bfLG9ySdNZ68ZkXSXZNsYq2yGNcxmJmHpscsXJp4Tq4zSx0koobmewcve0RSh5QBPfIM
         F4Z6fu5ceMZmC7SrtDQK4Sf+b/zFpUFnEkqaIFN2xUiuSZCpuGqQsr7xXFUt2y3ynkTx
         jEKh0GCnOPZU+nEInIBFCvIwwGDBI/1q1SZ3kLeXRnSz28AFAuI38Y/ymc9t9c539kwZ
         hBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750190927; x=1750795727;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K47AyRD9C8APvHVdVcg+JhX/4k3xEAD2ampnaOSEuhg=;
        b=Cy5mtxoF22L5HDePCEvyBGhHATqK/M/URWBEZUS+8UWclH39tf1htIseXy9BhysSdf
         QbzP4Pv6+mfgbkj7v11gZyAUwsmlegQWYXbDDP/AR41TpoeU70CR2sPvWykfKLlMbswM
         ohhrmL+Zh3O45Q3fSXBwbF2Ad+aFTPY7pIHuYzAikpLXcxm9PGZ29Oucywuyz8U/itu4
         m+C7LK6mFaKrVsUDP+5V1WrRTRCLd24qScWeVioUfNDc3UcPWy+A4t0FEkDd4oodaLp5
         DF5G8ep3GNrqMQ89K9yPwCwRCyDwuSXBZHYDSCzKEprix25/VDe2TnmgN/wK+54BXraP
         ZQVA==
X-Forwarded-Encrypted: i=1; AJvYcCU97YyPbzNG+O7jPh6lwqPkxYZu4dDrm7JM588c/BBNbFCN/9nwVilIQzzn7hsqFWWMGYTTMCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdSquRwCCITY92D2y4n2aXkouWcwPUxaBIn06HgHJz9ubN7mD
	pUDqdsRxBcegLOTb/b0f3wK5/uvc1ftfSnzc7WSdeySykAxkEQ9deDOh
X-Gm-Gg: ASbGncvl895Ma7wlzQQXnaoRvZVQsw8XassRrp5G8PfRwNcRX+qcYjBbv5AGANfKzPX
	uEZKFoqjNjI/1jG729aF5VUm8JBhti+msjXtyxi3BxXMfS9Ee4+0c8Xaef7mWjNyzyP7Ptc2zaL
	4Pbn7REGhHz05Kqx7VzzY1fohMmBSlos61HmxyAKC/+YGrdCg73xyhtK9/toSVEjDmi9J6VhNk0
	DV4ABdc5+YavUgz2X6U9jM6dTgPf9cETiL9FtiKGLcJuE18ZMreElN2pKpxHF19ZNb/dKU98QeC
	EkxiGgfJV4zhm9SN+0NCCObguoNs8bcj6c45VsziA3f6ZrtVG4qPA1gpfogFl3XMb1XBTJ3O9Zd
	SXefMFn1TPNmaBHwuKMk+wl8T40iK1Rd7suzd+727sg==
X-Google-Smtp-Source: AGHT+IFh09BwRMGRKSRbvS48EJlBsM0xkYWgCclKY7R3GPqJENpdjndn0ctvt/sI7UnizFlnQgMVIA==
X-Received: by 2002:a05:690c:7246:b0:70e:1821:a219 with SMTP id 00721157ae682-71175463114mr218771127b3.36.1750190926947;
        Tue, 17 Jun 2025 13:08:46 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7118ff66f34sm10726687b3.123.2025.06.17.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 13:08:46 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:08:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 martin.lau@linux.dev, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <6851cb4dcdae7_2f713f294e4@willemb.c.googlers.com.notmuch>
In-Reply-To: <aFGoUWgo09Gfk-Dt@mini-arch>
References: <20250616143846.2154727-1-willemdebruijn.kernel@gmail.com>
 <aFGoUWgo09Gfk-Dt@mini-arch>
Subject: Re: [PATCH bpf-next] bpf: lru: adjust free target to avoid global
 table starvation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> On 06/16, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > BPF_MAP_TYPE_LRU_HASH can recycle most recent elements well before the
> > map is full, due to percpu reservations and force shrink before
> > neighbor stealing. Once a CPU is unable to borrow from the global map,
> > it will once steal one elem from a neighbor and after that each time
> > flush this one element to the global list and immediately recycle it.
> > 
> > Batch value LOCAL_FREE_TARGET (128) will exhaust a 10K element map
> > with 79 CPUs. CPU 79 will observe this behavior even while its
> > neighbors hold 78 * 127 + 1 * 15 == 9921 free elements (99%).
> > 
> > CPUs need not be active concurrently. The issue can appear with
> > affinity migration, e.g., irqbalance. Each CPU can reserve and then
> > hold onto its 128 elements indefinitely.
> > 
> > Avoid global list exhaustion by limiting aggregate percpu caches to
> > half of map size, by adjusting LOCAL_FREE_TARGET based on cpu count.
> > This change has no effect on sufficiently large tables.
> 
> The code and rationale look good to me!

Great :)

> There is also
> Documentation/bpf/map_lru_hash_update.dot which mentions
> LOCAL_FREE_TARGET, not sure if it's easy to convey these clamping
> details in there? Or, instead, maybe expand on it in
> Documentation/bpf/map_hash.rst?

Good catch. How about in the graph I replace LOCAL_FREE_TARGET by
target_free and in map_hash.rst something like the following diff:

 - Attempt to use CPU-local state to batch operations
-- Attempt to fetch free nodes from global lists
+- Attempt to fetch ``target_free`` free nodes from global lists
 - Attempt to pull any node from a global list and remove it from the hashmap
 - Attempt to pull any node from any CPU's list and remove it from the hashmap
 
+The number of nodes to borrow from the global list in a batch, ``target_free``,
+depends on the size of the map. Larger batch size reduces lock contention, but
+may also exhaust the global structure. The value is computed at map init to
+avoid exhaustion, by limiting aggregate reservation by all CPUs to half the map
+size. Bounded by a minimum of 1 and maximum budget of 128 at a time.

Btw, there is also great documentation on
https://docs.ebpf.io/linux/map-type/BPF_MAP_TYPE_LRU_HASH/. That had a
small error in the order of those Attempt operations above that I
fixed up this week. I'll also update the LOCAL_FREE_TARGET there.
Since it explains the LRU mechanism well, should I link to it as well?

> This <size>/<nrcpu>/2 is a heuristic,
> so maybe we can give some guidance on the recommended fill level for
> small (size/nrcpu < 128) maps?

I don't know if we can suggest a size that works for all cases. It depends on
factors like the number of CPUs that actively update the map and how tolerable
prematurely removed elements are to the workload.

