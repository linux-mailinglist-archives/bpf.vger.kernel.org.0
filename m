Return-Path: <bpf+bounces-35686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD693CB09
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 01:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092B21C212CE
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 23:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76D148312;
	Thu, 25 Jul 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnsKPNyK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB34131E38;
	Thu, 25 Jul 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721948822; cv=none; b=V8HmdWXFTb6baLvaRuZ35Offm4GR5El7f6sfEx5f9E0bjxLt6af0VFTt7kkNaC0aYLpcCs9WefUaifCPPksWpjTzROd3aqKw0lqgqL8oNJYTF1rWm8KtCRckSy7yLiCngx7VgYPnUcO68l6fUrSMVnXRHC/kFpvNTfK5m6bzykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721948822; c=relaxed/simple;
	bh=WcJu4HKSi540Gh4QQTNvr6MDlTHW/9r+T5GZ9rbjlA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNCpc7uSZk5aPp1xQzxDXHLlbb8+0paCgSrhSxpFXOG16GIQV6MJQ7Lz1ePPQgLq7zwmNEGqNlZwQNH9kpyyk7nD+XIIyHJT6YPcK72USSxmOe/mkybIaFTVn2ptXzn4YeC0ebQSGw5nAIfSMqECZODTWANLChvDNR/wt+KipoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnsKPNyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9622C4AF07;
	Thu, 25 Jul 2024 23:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721948822;
	bh=WcJu4HKSi540Gh4QQTNvr6MDlTHW/9r+T5GZ9rbjlA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OnsKPNyK3FID5EW4dmTQZIav7FB2NmlZWTcN1pObaVuNnO4t53tiTyA7nN1/SG63V
	 FZm+sMEg95QoT84Y0p7VS9Kgk7GFc7uO4b2/bNhS3b24dGSC2oZ/fMp15qfVmWRfMu
	 5Z+1y2MkK2rfNxf8hIxiAo+85guFqVvp6PB6REv27GV4F1MOJEXbBr7z7yN0J/8pbx
	 k/uNlxVNGTc45mwQRV9tJZKBOOucpRiOCKfiVCWmS++X7DyRUw8E4U5PZjmZT8lQBq
	 b72Pwdf54j1jYmGsueJ0SLx2rVNhXHu3CKjYwzt8RDttoddn5JjoDtLGf7BT3YgjC9
	 vumwbksDT89yg==
Date: Thu, 25 Jul 2024 16:07:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Shannon Nelson
 <shannon.nelson@amd.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 6/8] ice: improve updating ice_{t,
 r}x_ring::xsk_pool
Message-ID: <20240725160700.449e5b5f@kernel.org>
In-Reply-To: <ZqKaAz8rNOx/Sz5E@boxer>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
	<20240708221416.625850-7-anthony.l.nguyen@intel.com>
	<20240709184524.232b9f57@kernel.org>
	<ZqBAw0AEkieW+y4b@boxer>
	<20240724075742.0e70de49@kernel.org>
	<ZqEieHlPdMZcPGXI@boxer>
	<20240725063858.65803c85@kernel.org>
	<ZqKaAz8rNOx/Sz5E@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 20:31:31 +0200 Maciej Fijalkowski wrote:
> Does that make any sense now?

Could be brain fog due to post-netdev.conf covid but no, not really.

The _ONCE() helpers basically give you the ability to store the pointer
to a variable on the stack, and that variable won't change behind your
back. But the only reason to READ_ONCE(ptr->thing) something multiple
times is to tell KCSAN that "I know what I'm doing", it just silences
potential warnings :S

