Return-Path: <bpf+bounces-47565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF6B9FB654
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 22:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F22E165F3C
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 21:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9A1D6DA9;
	Mon, 23 Dec 2024 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACfWoK1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650D1C4A34;
	Mon, 23 Dec 2024 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734990231; cv=none; b=jpgDloBEKmX0/D4NNniclhce7bK1cAhNgcGwczh/S8LTUFOUpxnAy2xecF4CZlruDzVYukntEndtaGRzEjRCi6EPvY1WK/YZcxItUk9SntFgdhIaW79uOq1O9tm+tPsgK6gU9/wYlMpSPQJVXySeLFzDyt6FzBmA0K79dTM3FCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734990231; c=relaxed/simple;
	bh=s0CNqzqT8bmHy3bAfm+RcQX0YZ7PY72wrxELCw1lowk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYITCK+r2kv0PkqpSTuUFln2PtRK22quqgfmFi8JP1Hq1anqhiWOWf+W4mvAot/j71lV3jYbzx/rXHAhmKG42DPBXLnGJKOivVJLPISm85xdx2uvPE0As6MwsasDFRP08GzegM4FwgR31Ap9K7PC0kOeS4F2kHzXgHDrJ6cSxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACfWoK1M; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-387897fae5dso310065f8f.2;
        Mon, 23 Dec 2024 13:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734990228; x=1735595028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJINGdpDwCDG3ewzWN9k9REq0fQ7Kv+5EsDRsZO4yDQ=;
        b=ACfWoK1M+7OlPNls1bpYCS2X82UfbXF27DbznxaKT+vD/VL6INUChJvOwtW4wUd/FU
         4wVQyBVcfe5vdbFLLcXbPVMrjzw3Wv/09ssPwH2ymgph2r/IKdO4Smi9s42zgMU7+ZfM
         uD29R9MYK4uCn+8QUi1/NNOTrgtxGG5NRaZYgdteNtK5VAKZTfyGhO3ZltPkTjtIX8np
         gLMmr7PghpfdrAfjemJE6Lx+nI6b3+uhU8NGQwWLE+L/aPxsWEWHhcpf3Yz0ZxRuCRJN
         fHKOyt2PMYn9vsjCYwOmdVPTV74NKyR3bpRv3b4YBozZIE8eZ5E7pgMsvGM9gJivpwv6
         xBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734990228; x=1735595028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJINGdpDwCDG3ewzWN9k9REq0fQ7Kv+5EsDRsZO4yDQ=;
        b=JjiemA37gN7JI1GuX1i6NH7JfUaaTQBkEcFRd7LWIj+fdlaFj9cEseK3r6MELO6GJ7
         LFAZMpettWZNLjIYqlV18Tt4rt2nYrkJ2VquSwfrPom7hu5keIomgEOE0KP4Zj9Ivn0V
         WrB3XmuoYNn7Ia0obNmUZ5G9x2lmPvh19/5blxJQHv0YAdQZRRFQ5xvzmVvMh5F2+F4W
         JfHXEwnUp0WTGm8i+FfbI+Ya6ZFyu+42hoo5ZsPoBAhLbsRKqlqBOePmNiJd9mluy165
         AY6zzzc3W4KmRFeAS1aLlK/iLB0lTmAp+CtnlPniPuKxLbXpqLnHDtUH0u48zJ46NPzi
         gz5A==
X-Forwarded-Encrypted: i=1; AJvYcCVCh96V991yxeL75bWnIGuWCct++vLVtL70EGLK10CaXVbI8fqykFYH4FbSvBFkbVO2CE0rGJSybix7Drhx@vger.kernel.org, AJvYcCWKAc9wt85jz6GOoiJt/nv6+j78/vhWQZwjn7zHDuE/tBwGemHQaykq2VjnLzzEe/Hn+qDkJ02q@vger.kernel.org, AJvYcCX4NhgSBd0PI978x6R5bE2p1lL2RbH6pNlLhjhQA24G5ZcrhjgpY6YHQEtJZvbSY6n14H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWFl2q8WmR9UyY5VyFWSuQHQeXltYRuo4/3/Q2CB76XUCaqyc
	7ACeXje4pP4IWymdnh/4BzmxlqfBpSYLcBZqcGOLriptmP5jM2qC
X-Gm-Gg: ASbGncvSQIWxs8B7MN/lM5gMaRNOBnZx1pSp38cd6nsdU8lqqQtzsUeo90ucFlj7nPv
	OqPMIVNwPaxYf4NrIJhLuDls3yom7KqFWwpo7Kh0Ka659uOQz0HsmxAOCUXZDjXc9XOqotbWkkp
	cYf4EoR0TGGP9BBFSjmad6HJeqBhajCWfnEQghWrEjIoEPid3xijOzGHiS9nXJ/btLNfx68ZpaS
	8TK63EhqnF8VR51fErBPt5rqClJooaY3vOXHlPrFIyZ
X-Google-Smtp-Source: AGHT+IHL4I7TGBfT9Dfs3U2q5y6UKuVcMOivINOhCJ4rodXMGa1Ob/wIQjBOw7XqflRGuJN4X3cDbA==
X-Received: by 2002:a05:6000:70a:b0:385:faaa:9cfe with SMTP id ffacd0b85a97d-38a223f82e8mr5051691f8f.12.1734990227688;
        Mon, 23 Dec 2024 13:43:47 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm12226921f8f.29.2024.12.23.13.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 13:43:46 -0800 (PST)
Date: Mon, 23 Dec 2024 23:43:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 5/9] igc: Add support to set MAC Merge data via
 ethtool
Message-ID: <20241223214343.dbmhbj7cr7pfbeub@skbuf>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
 <20241216181339.zcnnqna2nc73sdgh@skbuf>
 <ef07ba7e-eb61-495b-8abc-a46d675302d4@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef07ba7e-eb61-495b-8abc-a46d675302d4@linux.intel.com>

Hi Faizal,

On Mon, Dec 23, 2024 at 05:23:27PM +0800, Abdul Rahim, Faizal wrote:
> To recap:
> 
> Standard range: 60, 124, 188, 252 (without mCRC).
> i226 range: 64, 128, 192, 256 (without mCRC).
> 
> The current IGC_TX_MIN_FRAG_SIZE is incorrectly set to 68 due to our
> misinterpretation of the i226 documentation:
> "The minimum size for non-final preempted fragments is 64 * (1 + MIN_FRAG) +
> 4 (mCRC)."
> 
> The calculation above is for the fragment size on the wire, including mCRC.
> For the TX preemption point and pure fragment size, mCRC should not be
> included, as confirmed by the hardware owner.
> 
> On RX, i226 can handle any size, even the standard minimum of 60 octets
> (without mCRC).
> 
> What would be ideal for i226:
> Min frag user set 60:64 → Multiplier = 0.
> Min frag user set 65:128 → Multiplier = 1.
> (And so on)
> 
> To make this work and reuse the existing code, we’d need to tweak these two
> functions:
> ethtool_mm_frag_size_add_to_min(val_min, xxx)
> ethtool_mm_frag_size_min_to_add(xx)
> 
> With the current code, if I pass 64 octets as val_min to
> ethtool_mm_frag_size_add_to_min(), it returns error.
> 
> Proposed modification:
> Add a new parameter to ethtool_mm_frag_size_min_to_add() - maybe let's call
> it dev_min_tx_frag_len.
> 
> Set dev_min_tx_frag_len = 64 for i226, 60 for other drivers.
> This field will be used to:
> (1) modify the calculation in ethtool_mm_frag_size_min_to_add()
> (2) as a warning prompt to user when the value is not standard, done in
> ethtool_mm_frag_size_add_to_min()
> 
> I was thinking (1) would modify the existing:
> u32 ethtool_mm_frag_size_add_to_min(u32 val_add)
> {
> 	return (ETH_ZLEN + ETH_FCS_LEN) * (1 + val_add) - ETH_FCS_LEN;
> }
> 
> To something like:
> u32 ethtool_mm_frag_size_add_to_min(u32 val_add, u32 dev_min_tx_frag_len)
> {
>     return dev_min_tx_frag_len + (val_add * 64);
> }
> 
> So this will yield:
> Standard range (dev_min_tx_frag_len = 60): 60, 124, 188, 252
> i226 range (dev_min_tx_frag_len = 64): 64, 128, 192, 256
> 
> But what's not so nice is, the rest of other drivers have to set this new
> param when calling ethtool_mm_frag_size_add_to_min().
> 
> Is something like this okay ? I'm open to better suggestion.

I'm taking a break probably for the rest of the year, and spending time
for the Christmas holidays mostly off lists.

I didn't look through all your replies. Just regarding the one quoted
above: just don't use the ethtool_mm_frag_size_add_to_min() and
ethtool_mm_frag_size_min_to_add() helpers if they aren't useful as-is.
They are designed for a standardized NIC implementation. They are opt-in
from driver code for a reason.

