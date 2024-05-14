Return-Path: <bpf+bounces-29684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A7B8C4AC2
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 03:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335141F22FB6
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 01:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4B17EF;
	Tue, 14 May 2024 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nhWdX3An"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69B5EC5;
	Tue, 14 May 2024 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648956; cv=none; b=gioD83WxgL8NhBuSjnYvrIIRD/Z5XvKVldZA51hOWdWgk3zJ+W7QeyVtrgMdIB5CRTvFcMNGWO3XwAvhySu30eVCv+OVBQKXHaun6ajDY8NUWx04BjMVVoLQrtvv2MQko4rY7Ed8BYBzbnKRuk1TEJy6nLhPvcmzYf9Vm1VSiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648956; c=relaxed/simple;
	bh=Z0a9zo/oD7Fzoeh2HMvsQbMyP/a4DTsMNsBtVleFWZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VF6viBxU4cViOEtn5FxgnGBMmU11NcaBkS5YrfUlv3Plm0GNPNSKISCbPaGTI4olYSY0W2gMOxjoQoQgguxbikKO7TnaltQMzzRFbn/uDt4tQkX9G+xdya/doJoneM+kJAVX7AS4IWlLLH1MtJIuPKdDGdrxpGa1VYSFmSEkUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=nhWdX3An; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1715648950;
	bh=cJZZq6BaqUzfoKYWBZ/95aiewNAVNaflLJy9ncQn21Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nhWdX3AnX/lfpTM/3msxKX1vr3ahC0e0aj5/uYWopsMwiOJhDV5Nj/9I89GXiJ3Q/
	 6aWx/cOv3OZ5Xo/4WZgD4+v03yGXP9Y07XFHKiUgCf6W10BmHEh3ar0Z6HIhINcKMB
	 Nvk9huz4bBVvkHluHiCMpZ+lJHDL8VkSbohw0wrxlC3wLUTp0h+L99ji3VJ1t4ZXCl
	 Irb8bpFJpVczlOs7DFojFAjJN7zOYxbbCkp2/BPs86cHpna5tdzFe7teI5Zjk/pgWb
	 lkRs4aODolq4b60AuGvlOMP8nfOQuE2sioi7ZEaPvpXugmAHNmKLhYBf4LxJH1xpS8
	 esjU/uxMK+iMQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VddY15HGZz4wc3;
	Tue, 14 May 2024 11:09:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Puranjay Mohan <puranjay@kernel.org>, Naveen N Rao <naveen@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH bpf v3] powerpc/bpf: enforce full ordering for ATOMIC
 operations with BPF_FETCH
In-Reply-To: <mb61pwmnxhfcw.fsf@kernel.org>
References: <20240513100248.110535-1-puranjay@kernel.org>
 <wlslraxtexuncmqsfen6gum4sg4viecu4zx73pvlfztjmwxenl@fcoal5io4kse>
 <mb61pwmnxhfcw.fsf@kernel.org>
Date: Tue, 14 May 2024 11:09:07 +1000
Message-ID: <87h6f1w66k.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:
> Naveen N Rao <naveen@kernel.org> writes:
>> On Mon, May 13, 2024 at 10:02:48AM GMT, Puranjay Mohan wrote:
>>> The Linux Kernel Memory Model [1][2] requires RMW operations that have a
>>> return value to be fully ordered.
>>> 
>>> BPF atomic operations with BPF_FETCH (including BPF_XCHG and
>>> BPF_CMPXCHG) return a value back so they need to be JITed to fully
>>> ordered operations. POWERPC currently emits relaxed operations for
>>> these.
>>> 
>>> We can show this by running the following litmus-test:
>>> 
>>> PPC SB+atomic_add+fetch
>>> 
>>> {
>>> 0:r0=x;  (* dst reg assuming offset is 0 *)
>>> 0:r1=2;  (* src reg *)
>>> 0:r2=1;
>>> 0:r4=y;  (* P0 writes to this, P1 reads this *)
>>> 0:r5=z;  (* P1 writes to this, P0 reads this *)
>>> 0:r6=0;
>>> 
>>> 1:r2=1;
>>> 1:r4=y;
>>> 1:r5=z;
>>> }
>>> 
>>> P0                      | P1            ;
>>> stw         r2, 0(r4)   | stw  r2,0(r5) ;
>>>                         |               ;
>>> loop:lwarx  r3, r6, r0  |               ;
>>> mr          r8, r3      |               ;
>>> add         r3, r3, r1  | sync          ;
>>> stwcx.      r3, r6, r0  |               ;
>>> bne         loop        |               ;
>>> mr          r1, r8      |               ;
>>>                         |               ;
>>> lwa         r7, 0(r5)   | lwa  r7,0(r4) ;
>>> 
>>> ~exists(0:r7=0 /\ 1:r7=0)
>>> 
>>> Witnesses
>>> Positive: 9 Negative: 3
>>> Condition ~exists (0:r7=0 /\ 1:r7=0)
>>> Observation SB+atomic_add+fetch Sometimes 3 9
>>> 
>>> This test shows that the older store in P0 is reordered with a newer
>>> load to a different address. Although there is a RMW operation with
>>> fetch between them. Adding a sync before and after RMW fixes the issue:
>>> 
>>> Witnesses
>>> Positive: 9 Negative: 0
>>> Condition ~exists (0:r7=0 /\ 1:r7=0)
>>> Observation SB+atomic_add+fetch Never 0 9
>>> 
>>> [1] https://www.kernel.org/doc/Documentation/memory-barriers.txt
>>> [2] https://www.kernel.org/doc/Documentation/atomic_t.txt
>>> 
>>> Fixes: 65112709115f ("powerpc/bpf/64: add support for BPF_ATOMIC bitwise operations")
>>
>> As I noted in v2, I think that is the wrong commit. This fixes the below 
>
> Sorry for missing this. Would this need another version or your message
> below will make it work with the stable process?

No need for another version. b4 should pick up those tags, or if not
I'll add them by hand.

cheers

