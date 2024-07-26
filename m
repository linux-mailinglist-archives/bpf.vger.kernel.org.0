Return-Path: <bpf+bounces-35735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A3E93D53B
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E21F24E69
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C49A1CD15;
	Fri, 26 Jul 2024 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5UAz3Ii"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEAF1859;
	Fri, 26 Jul 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004864; cv=none; b=nW+Yhp+fLqzXNsgyGHAqQzHKbmyvY0ygoal5nOHPBqQ3m9wBDtLQ3HNX+oE3wRDSIRFOYN/bmrpmmIiBeW0aYtGGl64NMcxsrKTh+uiE5zYMjh6UqzMmbisFkymv673msp4ZcaA/u+efZj6pQiCJQVMesvL6PFm6d/EPWm9y6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004864; c=relaxed/simple;
	bh=wwpUw/2DjqoEfa8i70NKaeksaB5/sTwx5uMVq+VuSnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jghJmYde6FnpI2jWau3RXByYA6T9wpzySO0PEhV7YN9wA20ktMHQOCAMY/rVvcEp96P9V2H57lpiANio8tKDpRhBaDOURdmzIe+j7MEgoGG2mnZlVTv2aK5+RnKKDAIJvEblYthit6UdF+K9oouzXAQoYsPkz7eAnYfN1GwnkW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5UAz3Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F52C32782;
	Fri, 26 Jul 2024 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004864;
	bh=wwpUw/2DjqoEfa8i70NKaeksaB5/sTwx5uMVq+VuSnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5UAz3Ii/fAvf/k/fx09HRkn/y/XuALnNem3ahjkw7SvCnI4lvvZdtquMfItBoLX2
	 Z3l+hqAFOIeGg4rGYknxKacphzGMkj++G6OhiTeG5uI7hUsq4A6MR0p+CoJ6dmAytX
	 LuINDaipTyhAR55LzYWErIwLsQyxb9icRwP7hsLqKSuHk/yPKkKqjpJYu+tgiFCv6N
	 bJjfF36B+owPHPEHMNSL+er6uG7NIGyPLtrcLIbayH1WE39seojd9hGDoWpb0JfHLi
	 EJerIJDQU5NZAjegSM8uY6a2tbvP0NLuLLCtu9myOYGz23QIanEsltjqiOK+9Yr1A/
	 TK17ccuZrGsbA==
Date: Fri, 26 Jul 2024 07:41:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, bigeasy@linutronix.de, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] tun: Add missing bpf_net_ctx_clear() in
 do_xdp_generic()
Message-ID: <20240726074102.74b42a9b@kernel.org>
In-Reply-To: <20240725214049.2439-1-aha310510@gmail.com>
References: <0000000000009d1d0a061d91b803@google.com>
	<20240725214049.2439-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 06:40:49 +0900 Jeongjun Park wrote:
> There are cases where do_xdp_generic returns bpf_net_context without 
> clearing it. This causes various memory corruptions, so the missing 
> bpf_net_ctx_clear must be added.
> 
> Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
> Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Also likely:

Reported-by: syzbot+3c2b6d5d4bec3b904933@syzkaller.appspotmail.com
Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com

Right?

