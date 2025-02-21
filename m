Return-Path: <bpf+bounces-52175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB9A3F60A
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 14:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9740D3B7A9A
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456920F093;
	Fri, 21 Feb 2025 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIf3ZSMX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663820D4E8;
	Fri, 21 Feb 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144625; cv=none; b=AKPV/Z/25EmoLsZVhPUvXNLg1/xcrsidcRnZnOqjtl2D/i0EfXi7GqBBBX3XAnWJY9S+NjEKvqLaVt3cODqCeKlMWZLC7YqNMNf3gNZHhbYU7lmozUtaaXEi31r9rEKVz5Xt5GhjzPqpfAIROHAzaTnZlD+Ic6rrRfELW9m5yzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144625; c=relaxed/simple;
	bh=yrgPSzS1iVpcnrrmsNx/lFzIbzwcOZjCNokDJvcWQ3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0GpbRIezTYOPDcI4KGi4fY8FiyxT710Umq6AZ1+djZY3PlgBoNi4YgM8T9+zrPmfffHDxn3xjQkWcaYzU2iw2TBqZspW8zsiwt7MMZB+osyyDAq31uU0y9QtrXJPrjflO1uBzQwWM2ME1KtREEz3HrhI+l12yzVw4z42g0XL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIf3ZSMX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740144624; x=1771680624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yrgPSzS1iVpcnrrmsNx/lFzIbzwcOZjCNokDJvcWQ3s=;
  b=CIf3ZSMX1nmKSHmNXl96Aea/7otTl25rRQTxYIZPQ8fRomVnz4fgX+/P
   p2gB3HhZkqx7Rf5pd4rLkQbFROj4pklqBhMuBxW1m24EyZZ/ilNZSnbsO
   VVXF1FeHCPfMfUQdh+VmbgNrr8ULsnxJvIvgvzy8nedU0J8oqkJ8wWCgq
   aDVulbrDV7qdl/kJywiwOhBy/z42dXOZWKnqVgaWoqAz9Y0UVoan5MuzA
   RYZmQlJxsj5qjHO0JCXDrYi7py03MoVREqD2BK9OeSYmvX2z/PWFAd9uC
   p1ziHL/b4KiLavA5wBfR3coae88WGBDI+KX2nT8cah0XERpBBcZyBWhde
   g==;
X-CSE-ConnectionGUID: j/bm6XUJSq+D913a6mFo6A==
X-CSE-MsgGUID: k+ieUTekRi2e2FzyPimLPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="58510784"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="58510784"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:30:22 -0800
X-CSE-ConnectionGUID: Yyg/CP+UTXO0VBzS4RNfow==
X-CSE-MsgGUID: k5Pn0+0ERjyzbmGZjjCwkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120614996"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.60.175]) ([10.247.60.175])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:30:11 -0800
Message-ID: <3fbe3955-48b8-449d-93ff-2699a7efcd8d@linux.intel.com>
Date: Fri, 21 Feb 2025 21:30:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v5 1/9] net: ethtool: mm: extract stmmac
 verification logic into common library
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Furong Xu <0x1207@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
 <20250220025349.3007793-2-faizal.abdul.rahim@linux.intel.com>
 <20250221174249.000000cc@gmail.com> <20250221095651.npjpkoy2y6nehusy@skbuf>
 <20250221182409.00006fd1@gmail.com> <20250221104333.6s7nvn2wwco3axr3@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250221104333.6s7nvn2wwco3axr3@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/2/2025 6:43 pm, Vladimir Oltean wrote:
> On Fri, Feb 21, 2025 at 06:24:09PM +0800, Furong Xu wrote:
>> Your fix is better when link is up/down, so I vote verify_enabled.
> 
> Hmmm... I thought this was a bug in stmmac that was carried over to
> ethtool_mmsv, but it looks like it isn't.
> 
> In fact, looking at the original refactoring patch I had attached in
> this email:
> https://lore.kernel.org/netdev/20241217002254.lyakuia32jbnva46@skbuf/
> 
> these 2 lines in ethtool_mmsv_link_state_handle() didn't exist at all.
> 
> 	} else {
>>>>> 		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
>>>>> 		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
> 
> 		/* No link or pMAC not enabled */
> 		ethtool_mmsv_configure_pmac(mmsv, false);
> 		ethtool_mmsv_configure_tx(mmsv, false);
> 	}
> 
> Faizal, could you remind me why they were added? I don't see this
> explained in change logs.
> 

Hi Vladimir,

Yeah, it wasn’t there originally. I added that change because it failed the 
link down/link up test.
After a successful verification, if the link partner goes down, the status 
still shows ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED, which isn’t correct—so 
that’s why I added it.

Sorry for not mentioning it earlier. I assumed you’d check the delta 
between the original patch and the upstream one, my bad, should have 
mentioned this logic change.

Should I update it to the latest suggestion?




