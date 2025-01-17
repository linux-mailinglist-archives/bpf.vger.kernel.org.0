Return-Path: <bpf+bounces-49183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AF3A14F3B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5FA3A873F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD101FECB2;
	Fri, 17 Jan 2025 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV6U5Bst"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DF155300
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117331; cv=none; b=auTKaCl+iO8VEtYi88fcyA4G6+RgPMWeZbhunHcGnYRSBBxuSWg/JFdGlHy1ro+dtuArGKEbobmkxmhKByoMAbc6BsUHk/tkfQgcLyq3BYXHN53+LIiYV4XXr+7LRtN6WYTMGCMM5y9HsxLJpg1WiJJAFTmq26arxN02+RwWcec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117331; c=relaxed/simple;
	bh=ere0eKkjxpEd6P+w/yvOs40WBvKrVQYBYT7ApgTyteg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ej3AeZF/IwDY4Aa/ekM3nA3ob2mL9PD4t/xmGMNbX1mhP5r6mwCgBRmCyyMiYOHw7C4fTI6FSng4m0AjSND7NKddhTRMW/p4rcPnQcIQVgdbWJfkwllJlqcjcRRSue75WMOv31TFwj4EShV1NI3nebRdzp0OldsgfdqA1hT8bUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV6U5Bst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D55BC4CEDD;
	Fri, 17 Jan 2025 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737117330;
	bh=ere0eKkjxpEd6P+w/yvOs40WBvKrVQYBYT7ApgTyteg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gV6U5Bstxn795dRdQNDOIeyY7Fwm6rIERr90Lx4PTrRaRPx3AaC6kviN+MH2J0gg9
	 iLSqwEh8oQ6QlME+aQxboNTy97jGwHnHTbzWoFjo9Ufky9jMTMk0+oezQcjMycDyQa
	 kNV8c+qn6X745DWrulra4D2wwUGxeDju7CoKdPfigl7FB8L6cQtihhnsLTvdaLLgsI
	 OkkGwQgarrSDGF9frZ6jtR9ENA4EolfaKlV8BanjJfVVvDtXgWlRhhwTVvUMhMiM6s
	 rCkI6o3k1cJzQN/cQMNhJvknqv7yboKpUUIFIMBqHq0J99n9+0zVCVKZiUg9WJ22rC
	 AaIb3plhfxkow==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CEC8617E7862; Fri, 17 Jan 2025 13:35:17 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Free element after unlock in
 __htab_map_lookup_and_delete_elem()
In-Reply-To: <20250117101816.2101857-4-houtao@huaweicloud.com>
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
 <20250117101816.2101857-4-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:35:17 +0100
Message-ID: <87o705oby2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> The freeing of special fields in map value may acquire a spin-lock
> (e.g., the freeing of bpf_timer), however, the lookup_and_delete_elem
> procedure has already held a raw-spin-lock, which violates the lockdep
> rule.

This implies that we're fixing a locking violation here? Does this need
a Fixes tag?

-Toke

