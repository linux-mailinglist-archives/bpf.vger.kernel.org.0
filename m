Return-Path: <bpf+bounces-37360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA549545E7
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 11:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698242832C3
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9E13F426;
	Fri, 16 Aug 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YlheqFlO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkwzjobR"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9C12CDA5;
	Fri, 16 Aug 2024 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801122; cv=none; b=LMZ9NJVcZggTeKazFnI0Ui8NTlMpu7fiz3WXhJ0l9sAdQs5r22nsMr+7KQHaCKS2f5BGX8OJozuek7AZIzPdlRlxHlu0Z5FGjU5bAcFEpRcuq6jcH2F+f9Fu+ksRFhLKo5otFIRDce0gQl3PPPmaVf2nVRT1T7xwXc1f3aQ7FYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801122; c=relaxed/simple;
	bh=/FSiv735nj3lBdVJrQXDsrZBvWB2k55ZxDhpjlwycuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOt8TrF1WMGI7/ZrI8f05DeSz3/K9nqODcFHqzy5EjsPG+vDjN4mX5dotZEQlpCZdUHO/0BGMJrwFd+vIonvhR2H7gLq86NtctGdMwiR1udnp2wqaXVfSN5POE8ju73jCjY6gbVDNX35P/B1JcpBhZI+a0EHnjzaXORjeOk6ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YlheqFlO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TkwzjobR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Aug 2024 11:38:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723801119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4A0ncITU7sK44pZjbb9IGN+bBgHKoi/AYwMNN3yoM3w=;
	b=YlheqFlOvIePYCb9WAVjljhc+ynBrUApZXQYXstjqBQ7JagjcVNlO+vjOsbGY9L1NVxIAx
	IV+KSpFvO+znRhG6IxxP3nUhqgJ28WQtgf3sSZaNOb/cnXlADWaqt+9qTFQmZ2T+N0BPt5
	FVQzZZ4VD0w5f4FZ9c3UhGukjaPzOQVighKCAZWSti+Jv8fmsbY6Zyw2+tsWUqHbwuQ3Ty
	fMxzr9TDCn0iUt1zyno+pTIuehwETgdedOnAUPjAoRVG5RFXicOc7LBqyIt90zwPUfMMnp
	VIKV2uqUSPbHBCVHrfSJAfe2ojce9h+j2yMzf+nNvmtoeY7++fuLaJoEO9GpaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723801119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4A0ncITU7sK44pZjbb9IGN+bBgHKoi/AYwMNN3yoM3w=;
	b=TkwzjobRKZQFsqAnvwafio5sXYbUAd8gBXbxX7QN60OTP2eVC0uiXRduOEJ8cNZr3QPkm5
	tL6wBeB4koKMWrAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	Benjamin Steinke <benjamin.steinke@woks-audio.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v6 1/6] igb: Always call
 igb_xdp_ring_update_tail() under Tx lock
Message-ID: <20240816093838.ZpGD38t-@linutronix.de>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-1-4bfb68773b18@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711-b4-igb_zero_copy-v6-1-4bfb68773b18@linutronix.de>

On 2024-08-16 11:24:00 [+0200], Kurt Kanzenbach wrote:
> index 11be39f435f3..4d5e5691c9bd 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2914,6 +2914,7 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  	}
>  }
>  
> +/* This function assumes __netif_tx_lock is held by the caller. */
>  static void igb_xdp_ring_update_tail(struct igb_ring *ring)
>  {
>  	/* Force memory writes to complete before letting h/w know there
This
  lockdep_assert_held(txring_txq(ring)->_xmit_lock);
would be more powerful than the comment ;)

Sebastian

