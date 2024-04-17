Return-Path: <bpf+bounces-27035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F18A81C2
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9EBB253D6
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE7213C903;
	Wed, 17 Apr 2024 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="c3Ws1byl"
X-Original-To: bpf@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99DB6D1CE;
	Wed, 17 Apr 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352322; cv=none; b=VWhe3DgvcQ6C9agtVaT7AJsolaD3PrLa9AZ7dQiUXOO+ovIaIeNjnzHg89WQRzywTg+/Ig/sjthRjkoR7llvj6Z3YNRNsw4XavD+7xIvOFtcehsR5UaUhLvutAyrxTO7RCr91GsotbphcRgk+UIuPIYaDWaQF+FC809M57/VDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352322; c=relaxed/simple;
	bh=BeAGE4NgF1PvvDtuvS7meGY6+y42Zw9trUsDmKq6F20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qw261fOcqNi6En31oMtiBs960wOs8PgfyByGa0HwsduAV/UCJm5J2UR+h1ID3qP18R0S8tBAqj//X/W5GDbj3y8gTif19mXy9RliJ7BGUzUTlNBSlqoL8hs9E/RVveN/O3D1Is+oS8b+AxLhwlkQfPACgZWemXI5/7VLRFnfzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=c3Ws1byl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j5hzFpqDeiSvh3i5/NNbcyOTjOMmoOjEjWS33BvjzzU=;
	t=1713352320; x=1714561920; b=c3Ws1bylK3k+IuEn2TbhHtgRWguRUCfV6mjHUU4/IARA+u5
	wyIYNyPMQ7Rk4VrCjGHHvKuJcbNKlZgreBrqVPnrf53qICKmcALAVuEkCB2Qf52hpGQxLBS/EfghD
	dM1iG8PWWWaEUIWmNofahxTPWBPwmYIqCvJMkLWLNJbuH0BO8zAPMcboqafSw26Zj1wI2LPDjrChU
	8/ZvDmohcKFH6t+3AbSWqSZL6B+6icAMuF8/87xLue5uANkrXWHsomEHjWhfQm/cGPbeB+J+NipfY
	Bay914wPzKk2RdrQWjjH/KXRO+ec6ACJvKJDUWH+FPufIlURK4y5Tno6/tdDwTKg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rx3CW-0000000AtjI-1eSv;
	Wed, 17 Apr 2024 13:11:40 +0200
Message-ID: <e0d5741ee053c11fe078fc8afe6cf4a92e274095.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v6 03/10] net: create a dummy net_device
 allocator
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jakub Kicinski
	 <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 elder@kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,  nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,  taras.chornyi@plvision.eu,
 ath11k@lists.infradead.org,  ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, geomatsi@gmail.com,  kvalo@kernel.org,
 quic_jjohnson@quicinc.com, leon@kernel.org, 
 dennis.dalessandro@cornelisnetworks.com, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, idosch@idosch.org, Ido
 Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 17 Apr 2024 13:11:38 +0200
In-Reply-To: <ebe80c29-4884-488d-ab83-c020f9c3bc81@intel.com>
References: <20240411135952.1096696-1-leitao@debian.org>
	 <20240411135952.1096696-4-leitao@debian.org>
	 <20240412191626.2e9bfb4a@kernel.org>
	 <ebe80c29-4884-488d-ab83-c020f9c3bc81@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-04-17 at 12:51 +0200, Alexander Lobakin wrote:
> Just FYI: kdoc accepts only this pattern:
>=20
>  * @last_param: blah
>  *
>  * Return: blah
>=20
> NOT
>=20
>  * Returns: blah

Actually, it does accept that, the regex is "returns?". It's just
documented only as "Return" . IMHO it sometimes reads nicer as "Returns"
depending on how you phrase it, but ...

johannes

