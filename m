Return-Path: <bpf+bounces-65439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0DB22D3F
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 18:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54C21677C7
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050152F747B;
	Tue, 12 Aug 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJkGNLH0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC92D12E7;
	Tue, 12 Aug 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015459; cv=none; b=HO9kqARBmjfumBof200M4WW7jBfUDa5GmNpCU5M35/RmIOiSfv/5Q662eyGOCOLpuMSm9nEAZoJvDalqMvFU/1bF1wgP6psQ/6omowLfxNBqo+5v6uOW3oat9dVcOaTRIh1iROO1NYWFiDONaaJ3MUff37dqWeiUTiUkknOQw7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015459; c=relaxed/simple;
	bh=Ws1kSqLw6SJ+E5t6BQp7L9lVmS1pgzOhNz+rc+PlLcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exkFUAneKMMfBwM1wxSxQBDdZBtM9q+0yH4uVTavc27+ZbqPm5WdPNnDBUz2mHFmu0IGEDTI/Xghy8yu6JTEv2D+WhIRWlEzG3doixTvXqimlk0llWCSKPK/4cfWzkWbJdSxzoEWuVpSmQc6sLO0G2xGF0p4gQyalFXbh9TR/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJkGNLH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872FAC4CEF0;
	Tue, 12 Aug 2025 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015459;
	bh=Ws1kSqLw6SJ+E5t6BQp7L9lVmS1pgzOhNz+rc+PlLcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJkGNLH0jQYnWPs+5wP+oKfThCVTeCe3iy4EqytBgJVYF4gUcuqlWEbyqFDG9boqT
	 sb9+JWQ3dwBz1VVqA1GSE3VDuiJ58wQR6G26rLY2kGsFLzmbCiDEo9PdH3XMh7Fkp/
	 WNapeSlpICZfA0uK+TeN5KRTHmYDa/b0ngOhgxNpKK/E3toM9H1U5D8E4LdYyAFFDr
	 /RYKmLMVQk3d33Q/6I5J0kfr9foUmuBVFnlmA/cFAOUXIILE3Lvay9dCGaijOfweV+
	 NnAZ+uqr0KvFcSvxYmuPU6lgENTbh6YevJAo/FZILLEs5oNONIXKEAAMXQeMGTbosQ
	 ok5kVvgZTmyow==
Date: Tue, 12 Aug 2025 09:17:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 lorenzo@kernel.org, toke@redhat.com, john.fastabend@gmail.com,
 sdf@fomichev.me, michael.chan@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, marcin.s.wojtas@gmail.com, tariqt@nvidia.com,
 mbloch@nvidia.com, eperezma@redhat.com, aleksander.lobakin@intel.com
Subject: Re: [RFC] xdp: pass flags to xdp_update_skb_shared_info() directly
Message-ID: <20250812091737.651fc41c@kernel.org>
In-Reply-To: <20250812161528.835855-1-kuba@kernel.org>
References: <20250812161528.835855-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 09:15:28 -0700 Jakub Kicinski wrote:
> xdp_update_skb_shared_info() needs to update skb state which
> was maintained in xdp_buff / frame. Pass full flags into it,
> instead of breaking it out bit by bit. We will need to add
> a bit for unreadable frags (even tho XDP doesn't support
> those the driver paths may be common), at which point almost
> all call sites would become:
> 
>     xdp_update_skb_shared_info(skb, num_frags,
>                                sinfo->xdp_frags_size,
>                                MY_PAGE_SIZE * num_frags,
>                                xdp_buff_is_frag_pfmemalloc(xdp),
>                                xdp_buff_is_frag_unreadable(xdp));
> 
> Keep a helper for accessing the flags, in case we need to
> transform them somehow in the future (e.g. to cover up xdp_buff
> vs xdp_frame differences).

CC Olek

https://lore.kernel.org/all/20250812161528.835855-1-kuba@kernel.org/

