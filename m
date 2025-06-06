Return-Path: <bpf+bounces-59898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420BAD0736
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632AD3AE3ED
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2728981C;
	Fri,  6 Jun 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkVQGYSR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F601DCB09;
	Fri,  6 Jun 2025 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229747; cv=none; b=D8s9pqluqKyZ0NIMvBNAa7I2vqCqaWSkqtIfIg+7sp7YaJgTkOnwY/JdZw5Qr4YmTh9fm1MnEDDI6cEejXzRr+XyL2RxDvVekgkQJ/gwzq3bC1XVxPYJK28AkdcO5E26k+LySiCY8B4SEa4aFhu8wxucjV34VIiHjZ3QXRshgFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229747; c=relaxed/simple;
	bh=4wz8BRL+n/MQpnQHEz1U+NXu/OCcRQ/pOsQCQAPqlAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgiDMMgD5QpP5MSExPltXYoFn1dWsuUa8LtemEvcfDsxmY/JQ1GJJBicyKhGVXunOA2lQcJh5yIENPMtE+I1ZVm4MHwDKSzwbB3cnLvJWnwmiaNX7Dc7aAas8CwhrOp2MKAx/XardEaJubaC4BWw3zp/NyEbC9NQmU0eVNwy9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkVQGYSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB8CC4CEEB;
	Fri,  6 Jun 2025 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749229746;
	bh=4wz8BRL+n/MQpnQHEz1U+NXu/OCcRQ/pOsQCQAPqlAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FkVQGYSRuXJbgU/ZvU4cjb0hsP0JhjabswEuhsC0WVB27AEO4SbD2LLhSpxGpB1sj
	 o5J7oUop+Z6BSwmhxLcg7pZezRREWJ79lAu6QF3XAaMfyh9N6VfC1dLdQF5sc4JjgR
	 LQIXK1maq6eNJ8WdHO+jZ0mH2Gg9fIFLEoCtqvgzCey4dfLKiKLGUeWMXTkF2qKC8B
	 Y7bTraeCcD7HIYnYSrrhletVerTY00xeygExH48KkubEcjbOXn/GINyUyuTG1w2ojP
	 IV+9uG9KZbxCr6YnPisKEAfMUyCPVJmqDMxMr8GF66d8QVetCKWJsAsQ+cZerv8ZrW
	 CD6HLTh03QWNA==
Date: Fri, 6 Jun 2025 10:09:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com,
 william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
Message-ID: <20250606100904.668aa3f4@kernel.org>
In-Reply-To: <68430f86f651_266eaf294ab@willemb.c.googlers.com.notmuch>
References: <20250604210604.257036-1-kuba@kernel.org>
	<CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
	<20250605062234.1df7e74a@kernel.org>
	<CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
	<20250605070131.53d870f6@kernel.org>
	<684231d3bb907_208a5f2945f@willemb.c.googlers.com.notmuch>
	<20250605173142.1c370506@kernel.org>
	<68430f86f651_266eaf294ab@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Jun 2025 11:55:50 -0400 Willem de Bruijn wrote:
> I would drop on every program that calls bpf_skb_adjust_room() or
> bpf_skb_change_proto().

I think @maze covered it well, not all adjust_room calls matter 
to L3, they may be adjusting L2. I don't feel like blanket dst
discard is either always correct or necessarily sufficient 
(when rerouting the packet without adjusting length).
Let me respond to him with the draft patch..

