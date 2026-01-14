Return-Path: <bpf+bounces-78866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE9D1E3F6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84EDA306C489
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EBF396D3C;
	Wed, 14 Jan 2026 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFVsKo1F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB9394478;
	Wed, 14 Jan 2026 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388027; cv=none; b=tTNNtrqxjl4hXJ+189ilaapgOdGg25m7Pb/Ee5XrbgE0G+k0jxhB7pZSisid7UswVsPh6rvaQQ4phNrMWyaS/qO4Q7iyhlz5Gg8tLkuQpMijVB50dJ4YbMNtjl6wbantazKh5+7g8c4fAWFr5jwolxh8omg8jWu1D8eHgF4iv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388027; c=relaxed/simple;
	bh=HogBlS4eugUmPgdpVfFz1jm25c38dhN/Oy/Kc76rqV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5HMZ3XOaajmJ23dFcKZs7YLlktMDGBz5dl+6GN8xqfyXzWQtzh5AUsO0x0RCSsqDAv0INOCV/c5vQ0zaDtL0ZXWzBwole0lp4RyBxNqnjhBtBn0yMmN+h0f/SPBycMJHMHiPby7CUPslvEkpnR0kamAh6Isgus4FPwEVkDGD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFVsKo1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2437C4CEF7;
	Wed, 14 Jan 2026 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768388027;
	bh=HogBlS4eugUmPgdpVfFz1jm25c38dhN/Oy/Kc76rqV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pFVsKo1FKQbBHCJFJYhyJGS55CrMbFsoMdeV1Qvs/JHk4w/jEcTmhaoZNu/zibSoY
	 R4x3DKGJQvuqgCHCY3FdinXW150qZJ4zMWMmoIvIAJRgtnVCBllU9AroRLMxfRCliU
	 YKuAdW9zRgoGaJVIWmK46yUmiE4jeAlXbYfzj8pX9Cwpm+57igkE87oHroUW+Gqxue
	 LWeNuRFKm5xiRKM3UBrzkpQDcO/v5h6ijthQX2/3jKM+BPCgqYlsOAXEIGjNbzUNg+
	 3zNBOgeJIh8h1XuP1M+Xxy5Ux3XCnLTcm7t94aBsBmk2tR3fnDgmOktQZAXUSHMOML
	 7qmENa+aN4p5Q==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8EC37408B4C; Wed, 14 Jan 2026 11:53:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org, saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
In-Reply-To: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Jan 2026 11:53:42 +0100
Message-ID: <87h5so1n49.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com> writes:

> When packets are redirected via cpumap, the original queue_index
> information from xdp_rxq_info was lost. This is because the
> xdp_frame structure did not include a queue_index field.
>
> This patch adds a queue_index field to struct xdp_frame and ensures
> it is properly preserved during the xdp_buff to xdp_frame conversion.
> Now the queue_index is reported to the xdp_rxq_info.
>
> Resolves the TODO comment in cpu_map_bpf_prog_run_xdp().
>
> Signed-off-by: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>

This exact patch was submitted before by Lorenzo[0] and was rejected
with the argument that we shouldn't be adding more fields to xdp_frame
in an ad-hoc manner, but rather wait until we have a more general
solution.

-Toke

[0] https://lore.kernel.org/r/1a22e7e9-e6ef-028f-dffa-e954207dc24d@redhat.com

