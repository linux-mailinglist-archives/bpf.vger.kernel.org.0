Return-Path: <bpf+bounces-65091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C03B1BCC6
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 00:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B2617194C
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 22:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF924293C;
	Tue,  5 Aug 2025 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3ciXNWT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C802E36F0;
	Tue,  5 Aug 2025 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433966; cv=none; b=clZ0n77B5gmiWRNUYYo4UcB0y8yA0XG0MsSCebSOK1RHCLCPqKoVnfLJXtxSs4KIvF77bvUDNFZXlNPZTK7t+jIf5VXbpnjFT86vI27q6MemDdzXUWF3q0g6T+pw425fZ2q02K4AOsncWoG/AyQ8/niT0s/TuPDLfD7ExLYyHNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433966; c=relaxed/simple;
	bh=NqAn7xkr0Rfx37RWYqFvxyrYUe9MsAbnMN8SOZ0XZ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvtko5+WrWzti0BGVQu3wa4iAiacnckZKay7wtbjVzm9pk/mfvGH54egdtoweGAuXqfJ6Oatczm210JKd9V8Upum527H+LTCsY62UGU3BS16p8RPVABWbxfr0yDxG3bcxb13zpFM0MXGJaS65OkvP0G7POU/6uWMBm/imJW5oLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3ciXNWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4400C4CEF0;
	Tue,  5 Aug 2025 22:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754433966;
	bh=NqAn7xkr0Rfx37RWYqFvxyrYUe9MsAbnMN8SOZ0XZ8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f3ciXNWTApQibSjgZTVBIQ1cfxquSZMI/00XCX77N9oGij/RpxiPKAUV4q3Brivk3
	 VahaglYpe02/YuF/x1S9+U9CKzsJKDnd0e099GnXRys/MKRtq5QwNcGJrQ+OGkqS3Q
	 nwSxEwzT4mkMC9oahFyy8cmWtOY+QeZQtuaOohxHzwLjMFMHMbMR4fNKthJ+UAyC8F
	 70uPWfb/uaah7OOzIMUSOP8Fgyzzb0QM06zlJppwgB7IZco4rh5pX/lsJxWCVO32F0
	 5TvqJ+3oajZpY1dPkAJNfduWnl4Z/Qp0S9S2WYuZPzoQE5IcujFxxhf1FBoGN+syrX
	 4N/DDJOwAvRbQ==
Date: Tue, 5 Aug 2025 15:46:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
 <michal.kubiak@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 Simon Horman <horms@kernel.org>,
 <nxne.cnse.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-next v3 16/18] idpf: add support for XDP on Rx
Message-ID: <20250805154604.680bde07@kernel.org>
In-Reply-To: <a151336a-eda4-4f44-9ab5-da79e7712838@intel.com>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
	<20250730160717.28976-17-aleksander.lobakin@intel.com>
	<20250801153343.74e0884b@kernel.org>
	<a151336a-eda4-4f44-9ab5-da79e7712838@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Aug 2025 18:09:40 +0200 Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Fri, 1 Aug 2025 15:33:43 -0700
> 
> > On Wed, 30 Jul 2025 18:07:15 +0200 Alexander Lobakin wrote:  
> >> Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
> >> applicable. It really gives some good boosts and code size reduction
> >> on x86_64.  
> > 
> > Could you perhaps quantify the goodness of the boost with a number? :)  
> 
> Sure, only a matter of switching this definition and running the tests
> (and bloat-o-meter).
> Intel doesn't allow us to publish raw numbers (Gbps/Mpps), I hope the
> diff in percents (+ bloat-o-meter output) would be enough?

Yes, delta is perfect. Absolute numbers aren't very meaningful if you
don't specify all HW components and FW versions, and direction of wind
on the day, anyway :$

