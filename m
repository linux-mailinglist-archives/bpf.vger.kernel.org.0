Return-Path: <bpf+bounces-63493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1953BB0800C
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CC81C23819
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F214F2EE27B;
	Wed, 16 Jul 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3pV5/F7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAC2D9ED5;
	Wed, 16 Jul 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703008; cv=none; b=AA7EzJFzPy7hr1W432qVyfkDK6Fq2BApabk94i6nj/i6trIJTC9JOb6c7p8VzDKVUga6Gq9wlY548vtznxs84wbVoOqpyh/8nmbIF6KibiaYYkU4ELGLVeAqX1/l8HsfFiG334Wh5mrOfocgKqTWiwFlA1h/atZY8/TGsSGLUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703008; c=relaxed/simple;
	bh=0AjfIuX/m6YBPOeqwBG7JHyDtGIXLSkG0tHWAx7aNBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8DaHNj208SiTkvHAR8If7bz7VKvKO7hzkT2hq1kKPQUMa2F3wY3+1X8k++R9ARJUR33eGCF9HqGWylgsXZVU+lyNFkzDUyj6FynFlLgok0jMtTv5rW3VnkrREBzkyE8XvlqScAJIwjc/GtBoT3BNGrwWmqGEjyJy65Fg8putYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3pV5/F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569A5C4CEE7;
	Wed, 16 Jul 2025 21:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752703008;
	bh=0AjfIuX/m6YBPOeqwBG7JHyDtGIXLSkG0tHWAx7aNBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C3pV5/F7GnwWib8GaWYYDZQ98x7jvWG5McWE1616KsDD08AQLA88QsO0waxkKDkqc
	 Cx+yNS4r0QxtCCvSW1nMyA+8H8spZ3MgMS6Rmp+qvOQwHTB+olkkF17nDZbToWh5MY
	 X8eE943RSgc9HazCtsXllb74lpv1oRWgAVvfU70weuHH0mUGkLxqox9SpmfVYH42++
	 jisaGHRBUZHnCOydKQaEJX5/xZdMriwlkovNC/2Q4gGVien24cTCC1pVHNzyc2bha0
	 t87O6mWQMIDsm0GMbHVPrAXRnIr/la3cZqjswFM21no7BTagjl5Ln4daUpRcZZX5Pg
	 DEBMmdn2V/8bg==
Date: Wed, 16 Jul 2025 14:56:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] xsk: skip validating skb list in xmit path
Message-ID: <20250716145645.194db702@kernel.org>
In-Reply-To: <20250716122725.6088-1-kerneljasonxing@gmail.com>
References: <20250716122725.6088-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 20:27:25 +0800 Jason Xing wrote:
> This patch only does one thing that removes validate_xmit_skb_list()
> for xsk.

Please no, I understand that it's fun to optimize the fallback paths
but it increases the complexity of the stack.
-- 
pw-bot: reject

