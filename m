Return-Path: <bpf+bounces-57594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E95CAAD23D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A180B3AC1E7
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2A115E97;
	Wed,  7 May 2025 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOjB9/Gz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469408C1E;
	Wed,  7 May 2025 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577325; cv=none; b=kOdyQXenfkxSUsuo3x/DWR1jLkvLTVsXOJrKKj+HGAMqfE6rcmnB1J61AG45aPpajv9HB91W2jnv9qzD3k4ar6Xw4QtG0kl71ZXtVZoPZjvvk33VlJN2QRfwYlo+w7gBnoYoAf0H/t0/uiKSST1Zcq8WjRTeDz9l+M5pbcA3Xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577325; c=relaxed/simple;
	bh=sbWPtYP3AwuR5u6auCIJtWUsNJ93jmrRHAnyqZ30u+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm6egl03OwVHTU8+o02UYScumkkm44jGh3eTwZUQPWR+KTO6CzhKzSz6TPNewziVlHjObo3/E3Tu3zvzYIWT/ncEDTS7lRPlZST7dvPYsZGtCY4JGxOdibXY/fsvmKCUEGVwLFkSkCtsNZG3O0xXczAXpJi5OELFNlPvrFT95fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOjB9/Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A19C4CEE4;
	Wed,  7 May 2025 00:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746577325;
	bh=sbWPtYP3AwuR5u6auCIJtWUsNJ93jmrRHAnyqZ30u+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOjB9/GzkQRYI3Xm3PhztQNRwLmNsHewGH4sG0IWDPRc5j40V8SuR1hbV0usH9T4Q
	 Ks5TZXzeMohXYFeKaUWU1ME/Fw0lyKEQ4Fg3+LCkSHcCBgNSBxlW+eB7/OQZpGM5/Z
	 DBB8fQGSN+gKxdYm0RV7nSVhUXm6ZfQGmgFTkN7IweZfz8lvHuh04WMp4s/Ecm7zZ9
	 cToEUDppHf7kmN6x8/rHpHHuqRpln+YIStd5DiEVjW3dURmOP0ew/aFh6ykPiHXGYT
	 3qu93fO0CMvI+pY7ejFL6+Mw7Df6ptz+NPFm4PILsemCcIcT9/I0mVa1w16nEfWLYB
	 hpvtOqXeTllTw==
Date: Tue, 6 May 2025 14:22:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Feng Yang <yangfeng59949@163.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, mattbobrowski@google.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	davem@davemloft.net, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Allow some trace helpers for all
 prog types
Message-ID: <aBqnrBKoL35u0M_1@slm.duckdns.org>
References: <20250506061434.94277-1-yangfeng59949@163.com>
 <20250506061434.94277-2-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506061434.94277-2-yangfeng59949@163.com>

On Tue, May 06, 2025 at 02:14:33PM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> if it works under NMI and doesn't use any context-dependent things,
> should be fine for any program type. The detailed discussion is in [1].
> 
> [1] https://lore.kernel.org/all/CAEf4Bza6gK3dsrTosk6k3oZgtHesNDSrDd8sdeQ-GiS6oJixQg@mail.gmail.com/
> 
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Acked-by: Tejun Heo <tj@kernel.org>

Ditto, please route through bpf/for-next.

Thanks.

-- 
tejun

