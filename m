Return-Path: <bpf+bounces-48417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4836EA07DE7
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7D7188C77A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DBC223324;
	Thu,  9 Jan 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPa4Ar5S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB6222591;
	Thu,  9 Jan 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440983; cv=none; b=UhXSHswpgLbb8+b898oMhmmW/Yr1MAHG3rrq+Vy0hEDzm0o3/PhBmaW0haqWhtG/kbs+rRv1WSI3L8ge/h8UCzJr4GANCzU4zjRNGzDY+mFctRk3T/L/OIZIGoeem5GFkKwKehFuDPVs1qvx9QMjcZYY5MThR6RK5SZvr9hfoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440983; c=relaxed/simple;
	bh=5NdOS4sZnyyqMpbk/MDryGSHWiIvVszi3oKpS1TBCIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsM1aGQdRwalT7ONSBcy8OUVa0BGf3za06ZeWPXrmANar4qtvD4faUNAm6uTfOkoM0mmCtvDcEnGcd9dymTLGhVejB1pgv/PO2dE/OaeeOn9FZxl/Nd/JLZcxlMn2I6nbDc0jSo1LdMc0W6iG52vQB2WIUd7dPxVIhQnIHSQl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPa4Ar5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAA4C4CED2;
	Thu,  9 Jan 2025 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440982;
	bh=5NdOS4sZnyyqMpbk/MDryGSHWiIvVszi3oKpS1TBCIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gPa4Ar5SRxxm+r/jPKU+V86yDefmXi4Huicc4JWHjvb2i/Au2KuPm9GSsoIBIih2n
	 H8AaYfdiN7JydpKgRuOxwl1W5qFfcJ4dwThrC6jsRaOhY0ucReNiEVeSi9et5SN+gU
	 W9wPJnRzkJhh9E2i8WPW/f+4aOSVM2CPRmqHMWwISLuJQVUChuF13sfNUqJKFgrD9c
	 AaBkUPB2w9X8au3e8G/pX/zJyZ9MDnwwzLIIcnXO+zpp4q4o1tumIZXH4GEGhk44kj
	 M+lQ3fMu+e3NYSm5/ggxtzzwrODJjbSwBIiw/AGIh6Tt8Jy7uBJkUb89VlCMuX0CVh
	 f8TNNz0MPXnWQ==
Date: Thu, 9 Jan 2025 08:43:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca
Subject: Re: [PATCH net] xsk: Bring back busy polling support
Message-ID: <20250109084301.2445a3e3@kernel.org>
In-Reply-To: <CAJ8uoz3bMk_0bbtGdEAkbXNHu0c5Zr+-sAUyqk2M84VLE4FtpQ@mail.gmail.com>
References: <20250109003436.2829560-1-sdf@fomichev.me>
	<CAJ8uoz3bMk_0bbtGdEAkbXNHu0c5Zr+-sAUyqk2M84VLE4FtpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 16:22:16 +0100 Magnus Karlsson wrote:
> > Confirmed by running a busy-polling AF_XDP socket
> > (github.com/fomichev/xskrtt) on mlx5 and looking at BusyPollRxPackets
> > from /proc/net/netstat.  
> 
> Thanks Stanislav for finding and fixing this. As a bonus, the
> resulting code is much nicer too.
> 
> I just took a look at the Intel drivers and some of our drivers have
> not been converted to use netif_queue_set_napi() yet. Just ice, e1000,
> and e1000e use it. But that is on us to fix.

Yup, on a quick look yesterday I think I spotted a few embedded
drivers (stmmac, tsnep, dpaa2), nfp and virtio_net which don't seem 
to link the NAPI to queues. But I can't think of a better fix, and
updating those drivers to link NAPI to queues will be generally
beneficial, so in case someone else applies this:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

