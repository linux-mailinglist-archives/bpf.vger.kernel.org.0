Return-Path: <bpf+bounces-26520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEBF8A1551
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6910928295F
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DD14C58E;
	Thu, 11 Apr 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTAamx34"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AD3AC16;
	Thu, 11 Apr 2024 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840969; cv=none; b=mzAdWTt81pUfNOubNuQTw8FKosTyjOQ5k+Y9R+Dm4JZG2n2oXlSHBl9GwG9NoYiqZkxxPa0mJEo8iTQ/dlwaATqQOmgJjMjUak2k1eDAkhascSSYqq2xJuAF/CS8d9/xisE6IByuqBU+c8sRIEIM+q4gD89PUckJr4gc9p3G/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840969; c=relaxed/simple;
	bh=8jloMJYR3hI592a7bjdaurZGTF8DZUtzFZslxyASiCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB38nak/bnt0A4PwUgrv749baejkdz7KWlgE6oXIT5M6yriHSOh3m0uL+VWLAgHodZgYoufZLNxEIk244cUfRJk2KO72wogrgAtiMsl7o0J2wLKVf5VbxrLSPhygs+mjZlLBZF18c1QwzaebB7etKdhv5wmCnXFaJk7/mHxyl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTAamx34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BE1C433F1;
	Thu, 11 Apr 2024 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712840969;
	bh=8jloMJYR3hI592a7bjdaurZGTF8DZUtzFZslxyASiCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bTAamx34aXT0c7Dh0yldr3GLqQzV9IzdoRpbQHFtNRfItKvSV300oarDb7loQj0Db
	 nRfkoxxjnz9tSITwwxA3S3R++Th5BRDwHiy/ceBrv1hqDHDqRJhGCW1VuDm77tbvXj
	 sYF0lmSkNDM4sLi9I7SYA9CxCWtr8xgDLIJ8pvoFZns2rW3Hlm+PbN79aR13Zve2Jc
	 yKCiaqvumONCNAg1kYgPV+4UsdpCK8RYPlqHwgbszTVNkDUDxSiiLeHovaY2EzHZxI
	 tUFT3DR9oTRec7cO/yCDK54isJiPslGyjV/kl8GNT5n7CVWLJpcB+11xU7fbNibyU2
	 NojDEfZDJvLqg==
Date: Thu, 11 Apr 2024 06:09:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, elder@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, taras.chornyi@plvision.eu, ath11k@lists.infradead.org,
 ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 geomatsi@gmail.com, kvalo@kernel.org, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, quic_jjohnson@quicinc.com,
 leon@kernel.org, dennis.dalessandro@cornelisnetworks.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 idosch@idosch.org
Subject: Re: [PATCH net-next v5 00/10] allocate dummy device dynamically
Message-ID: <20240411060926.308788bf@kernel.org>
In-Reply-To: <20240410131407.3897251-1-leitao@debian.org>
References: <20240410131407.3897251-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 06:13:41 -0700 Breno Leitao wrote:
>   wifi: ath11k: allocate dummy net_device dynamically

Sorry Breno, I didn't notice earlier, patch 10 didn't make it
to the list. The series wasn't ingested by CI and tested because 
of this. Could you repost?
-- 
pw-bot: cr

