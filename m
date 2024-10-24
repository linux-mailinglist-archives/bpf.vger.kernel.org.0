Return-Path: <bpf+bounces-43042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C09AE36A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 13:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D8C1F2243F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BFB1CACE3;
	Thu, 24 Oct 2024 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDRRYJiM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3671B6CF1;
	Thu, 24 Oct 2024 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767958; cv=none; b=LtBVZ6V4pEix7MQkh9ZUjBhtBnI7Zkn0XCzDmTFbUY2CHVmUoCkZKn8f7mNUaFeU0fNgy2KFCttlvb9nmrrAX6G5SDVXVoeARQB3EHEflxPbHx5uFWQeUaPoRZXYX+PWciGVbFMSBOkvZHravDRsbxxIufSqRuRktrhxOGhTCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767958; c=relaxed/simple;
	bh=gLh242x7zfZsbQK/+qxlTv2wxnqju0Sw4AuaFDzi1hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLfsbBojMjmB/kka4rtf3YwOFqoQQpK4k41WOL5Isp4HmFIAx4eLpM3sHL73lSNr69749n7XBpTItQZDjtdjdEvfTdsXjr5x8Dt+CngmbhDM5sQy0qptHwB7NlYWd3JQbMnaLOZcn0apfKzYruRv8jyqqFXFaErUqFFWEjMWHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDRRYJiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E465C4CEC7;
	Thu, 24 Oct 2024 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767957;
	bh=gLh242x7zfZsbQK/+qxlTv2wxnqju0Sw4AuaFDzi1hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDRRYJiMatmii3PYXsFtihJD+hqfCsnJARX7+VEWij/xoNeRuV2vtJaMq+zruQ9DN
	 8DMrmKGeTeZLrrAxcFT6nxRgV8+dWnI/sdhALOzniGeSlA54jcHlsLcPLTClODWA/M
	 6cqox/RVQQ9kPThFZwlDM8j/OiejiU+fDguVscOY+2El4eTJ3LqRHkeMMXFdqgIHea
	 irHsHQyD6sLQk40gUNKk1MxYRHwLEgAdzehGnNL0MyU6zO0Y1TfBl93S1yzeit+aQE
	 KPRRS5Kp9M/HFm6cAGSJttsL+z+mgO1rL+9bxcbrfg6MTtNPFAz7vOCx8QOWTLMTBn
	 mQsMJe9wI6PHw==
Date: Thu, 24 Oct 2024 12:05:51 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] net: mana: use ethtool string helpers
Message-ID: <20241024110551.GE1202098@kernel.org>
References: <20241022204908.511021-1-rosenp@gmail.com>
 <CAKxU2N9nQFs_wDbe=S_ywfOFYeX+LWuN8f9y1y2iA5GV4tFDFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9nQFs_wDbe=S_ywfOFYeX+LWuN8f9y1y2iA5GV4tFDFg@mail.gmail.com>

On Tue, Oct 22, 2024 at 01:56:56PM -0700, Rosen Penev wrote:
> On Tue, Oct 22, 2024 at 1:49 PM Rosen Penev <rosenp@gmail.com> wrote:
> >
> > The latter is the preferred way to copy ethtool strings.
> >
> > Avoids manually incrementing the data pointer.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> forgot to put net-next.

Hi Rosen,

The CI guessed correctly, so I don't think you need to repost just for that.

...

