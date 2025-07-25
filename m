Return-Path: <bpf+bounces-64347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3637EB11B6B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED07AC2E22
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668912D63E1;
	Fri, 25 Jul 2025 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq1RaMdh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097A238C1B;
	Fri, 25 Jul 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437612; cv=none; b=OKsDpnnQBCMez41iCXpHKDog/mNbVyphoLLqm6DsXC346Cs8OH5zC/x5n36YLLt/3IC/hdNj7kj4i3WxRC2vOFJM3dd/wsU9On/F/vh2GkJqnB0VVGy0hnTQwbh7uvvclVH4VoQ81LIPJe60zLY8awna3ifCPCbPHiNwZ7MfHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437612; c=relaxed/simple;
	bh=SAzJ4Rh9xtuKNmwLY5cQXz+97kzVuVRtBbRTweajerk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=InuvdKqCfq8cJTIZcy5HlfgVQmfRPS1Y/e1WIiFXUF20WzXqcDYGGw2uknBVCCgsl2FOzw+L73TGdBkIMIBLVEH0rXrYmtyvWVxC7Up5PnlPqn5BiRCWjA/YItmYY6RafiIJj3qnH/SVNwMkwzktH/e9/NEOyCJnmSt0iSP16rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq1RaMdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30589C4CEE7;
	Fri, 25 Jul 2025 10:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753437612;
	bh=SAzJ4Rh9xtuKNmwLY5cQXz+97kzVuVRtBbRTweajerk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Dq1RaMdhMyl/1HeX4QMl8OlCABNE7EKtzMs1O+mlrREgWBavM6jiI6RMPKGdQxY2Y
	 x+y98/amXhamsi+kLeCv/0b2WRLiyglvKv0WDCJXZn96lVE0f1Z2wyj+LfVpZ2RZkT
	 WLtgRKeMulLCEZF9XqiXTGePW5Uniw6UHi0gX14kD9LZY/5JIGRsiCK2Ro1WNa8ggn
	 jnqpWzGW8j4ljk15MssEINb6QdFOny165vSHE4eL77OHGH5ZEl0ZTlG1suCDW2OLw9
	 NlIF4b/E8gnc3lnCFZgMvknyvwOF1wNbKdIlNsnXNxiKI16Nj8I1Gz0kiuguFH7dvf
	 k3WwUfNhhubiA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 12:00:07 +0200
Message-Id: <DBL1R8JJ38M1.21F7MRUUUX4U4@kernel.org>
Subject: Re: [PATCH v13 0/4] support large align and nid in Rust allocators
Cc: "Vitaly Wool" <vitaly.wool@konsulko.se>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 <rust-for-linux@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 <linux-bcachefs@vger.kernel.org>, <bpf@vger.kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Jann Horn" <jannh@google.com>, "Pedro
 Falcato" <pfalcato@suse.de>, "Hui Zhu" <hui.zhu@linux.dev>
To: "Andrew Morton" <akpm@linux-foundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250724135449.2cb6457b90926cce1b903481@linux-foundation.org>
In-Reply-To: <20250724135449.2cb6457b90926cce1b903481@linux-foundation.org>

(Cc: Hui)

On Thu Jul 24, 2025 at 10:54 PM CEST, Andrew Morton wrote:
> On Tue, 15 Jul 2025 15:56:45 +0200 Vitaly Wool <vitaly.wool@konsulko.se> =
wrote:
>
>> The coming patches provide the ability for Rust allocators to set
>> NUMA node and large alignment.
>>=20
>> ...
>>
>>  fs/bcachefs/darray.c           |    2 -
>>  fs/bcachefs/util.h             |    2 -
>>  include/linux/bpfptr.h         |    2 -
>>  include/linux/slab.h           |   39 ++++++++++++++++++++++-----------=
----
>>  include/linux/vmalloc.h        |   12 ++++++++---
>>  lib/rhashtable.c               |    4 +--
>>  mm/nommu.c                     |    3 +-
>>  mm/slub.c                      |   64 +++++++++++++++++++++++++++++++++=
++++++++--------------------
>>  mm/vmalloc.c                   |   29 ++++++++++++++++++++++-----
>>  rust/helpers/slab.c            |   10 +++++----
>>  rust/helpers/vmalloc.c         |    5 ++--
>>  rust/kernel/alloc.rs           |   54 +++++++++++++++++++++++++++++++++=
+++++++++++++-----
>>  rust/kernel/alloc/allocator.rs |   49 +++++++++++++++++++++------------=
-------------
>>  rust/kernel/alloc/kbox.rs      |    4 +--
>>  rust/kernel/alloc/kvec.rs      |   11 ++++++++--
>>  15 files changed, 200 insertions(+), 90 deletions(-)
>
> I assume we're looking for a merge into mm.git?

Yes, I think that's what we agreed in v1 -- the bits I maintain should carr=
y my
Acked-by already.

> We're at -rc7 so let's target 6.17.  Please resend around the end of
> the upcoming merge window?

Yes, this is too late for this cycle. Given that we target the next one, th=
ere's
a patch in my queue [1] that interacts with this series.

It would be good if you could pick up [1] (once ready) after this series la=
nds.
I asked Hui to rebase onto this series and Cc you for subsequent submission=
s for
this purpose.

[1] https://lore.kernel.org/lkml/da9b2afca02124ec14fc9ac7f2a2a85e5be96bc7.1=
753423953.git.zhuhui@kylinos.cn/

