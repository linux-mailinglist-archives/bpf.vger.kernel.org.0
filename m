Return-Path: <bpf+bounces-65046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EADB1B157
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A417A362A
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 09:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FABF263F5F;
	Tue,  5 Aug 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flMnhw+7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAC2F30;
	Tue,  5 Aug 2025 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386819; cv=none; b=M1NOkROW3wfNk70tAbUr8JuTwX3B4IWSPfvVkm08q+uHH5NE7smaK+21/VKpvN56uCkf8SWsRf5p3WYJ09iSgdWQYO518d0ONNbKjtSkAbL17tHH6Ahiirv10hMH1+CJEVX2IVfMDjw4hf0UjCgYCYrudlPNsLygUUUulHm3THc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386819; c=relaxed/simple;
	bh=M0YuOEF01PK2T/MfN+UGtDqQuxe12zRPDpYIkWPWD34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCBu6Srp/MNe3PSuuxJiBZscAxrdrQF6UbilfJTkGjt/187J2IZ3/rpyPWiGF40ArKMJ7OOkZrnYsJqGiDqOfeFpMC80cJJiqRcx21YzJ9+UbBIPcADCFZs+D44XxjTTxDnbvWTff+21CfJDZnbqMOQfkhmpWcupD6zuLXfihoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flMnhw+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE89C4CEF0;
	Tue,  5 Aug 2025 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754386818;
	bh=M0YuOEF01PK2T/MfN+UGtDqQuxe12zRPDpYIkWPWD34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flMnhw+7Hcp5VbdvQFgZBJ3qLty+rB3AoG10K/lacYqadGsKvOi1IsNlKuB6huTQh
	 E3HKwSHTFIq1/f+DWtJM0TVMyP5DVV5NEA+gZUJnr/LF+xqS7eXT5M6rfHJZJuuO11
	 wItW/6xkgLd7GxjZcYPNJsaEHdcs6w4ehqdRZbBc6SAkImc1JXKZ8Qdy1DpM6+fPRW
	 8T4CkC6ZRbIed28q/wGua/dmo31Wy5753HdFNyOIZLh1g2i6sPwzxOvRzW/IDiRHzV
	 emGs37i/Dxmw650lccxBMYgf2RkDSXtEMyLYqb8Xol4VVS9wiaTBqyAzC68rfuPGXw
	 r1JyyVE6ri/Ww==
Date: Tue, 5 Aug 2025 10:40:13 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	nxne.cnse.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 16/18] idpf: add support for XDP on Rx
Message-ID: <20250805094013.GW8494@horms.kernel.org>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
 <20250730160717.28976-17-aleksander.lobakin@intel.com>
 <20250731123734.GA8494@horms.kernel.org>
 <202507310955.03E47CFA4@keescook>
 <8c085ba0-29a3-492a-b9f1-e7d02b5fb558@intel.com>
 <ff10e2a3-bd97-4c96-b7bd-f47289c9b0e4@intel.com>
 <202508021152.AD1850CD2@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508021152.AD1850CD2@keescook>

On Sat, Aug 02, 2025 at 11:52:44AM -0700, Kees Cook wrote:
> On Fri, Aug 01, 2025 at 03:17:42PM +0200, Alexander Lobakin wrote:
> > From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Date: Fri, 1 Aug 2025 15:12:43 +0200
> > 
> > > From: Kees Cook <kees@kernel.org>
> > > Date: Thu, 31 Jul 2025 10:05:47 -0700
> > > 
> > >> On Thu, Jul 31, 2025 at 01:37:34PM +0100, Simon Horman wrote:

...

> > >> Yeah, this looks like a nice way to express this, and is way more
> > >> descriptive than "(u64 *)&xdp->base.frame_sz" :)
> > > 
> > > Sounds good to me!
> > > 
> > > Let me send v4 where I'll fix this.
> > 
> > Note: would it be okay if I send v4 with this fix when the window opens,
> > while our validation will retest v3 from Tony's tree in meantine? It's a
> > cosmetic change anyway and does not involve any functional changes.
> 
> If this is directed at me, yeah, I don't see any high urgency here.

Likewise, I see no urgency.

