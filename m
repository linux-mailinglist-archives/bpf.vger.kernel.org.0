Return-Path: <bpf+bounces-69314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29B5B93E4D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D23B4552
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3510262FC1;
	Tue, 23 Sep 2025 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQn+E+Nw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE623BF96;
	Tue, 23 Sep 2025 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591524; cv=none; b=gS3EyrkjK44ifdVsBhvvLS6w5SRQJR03cHD0elkHit5FZcQmftW5CMYwBI1CsUsj0eTGS2KAsl8xoimylCC7/RQEFSMCFPvnSCL5kQIUQLGMUm7uZbPUT4cPJhb5D5ztK+m379y3bz03OGvJ4dzk2bo/7ImgrWImccRxRMeXfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591524; c=relaxed/simple;
	bh=LZN9QXfs+zx71EgWPJSu/8hN+4idwhoEUX4TZyScry4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvDUUWIpWEW6VMnTSvU9q48mu9abccQ/2R3kQwN4s9W3ygje1tUw5HwlBDWKM5yeXOyL125Xn3PqXYXCW1hnQ4PjkIU9I2QVUi9uYB6r61FAnKI3HBI/+oPnCl9Nuxqufh5xzxPACDsWhUx2bJeMcE2JyFftRtZ+hMjDwICkahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQn+E+Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C375C4CEF0;
	Tue, 23 Sep 2025 01:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758591523;
	bh=LZN9QXfs+zx71EgWPJSu/8hN+4idwhoEUX4TZyScry4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HQn+E+NwiOdLTbA6HMIIBMutWilTixqrX7bRXd88DHZcJcsZaMQQASS1qa5tAA0Q/
	 sj0LpOaiE1JVLdm+PxBWc7R1nNLwmO9fg58tbJW1QYNx1ExdPpGRTRh33jB9cCWsnr
	 nAoD637FbicS1ttHCX0Arh71llIWpy2NnRrix77pAbMarXwg1jal+MX1S/hQALQ8XH
	 yeXtkVHeSUjbOmJ+mBgKCKB2SlkXItG7OGO2JP6kaAAA2UHo0Ux5ZjCwYae6orIzGq
	 XtraeJPjt3PjSogIalHkAfK0qQWh+vadRxtOJrwmY3JUJ+WAAD5bFl8afvJpwWxkYD
	 rbf2J1tuhRyYw==
Date: Mon, 22 Sep 2025 18:38:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 07/20] net, ethtool: Disallow mapped real rxqs
 to be resized
Message-ID: <20250922183842.09c7b465@kernel.org>
In-Reply-To: <20250922183449.40abf449@kernel.org>
References: <20250919213153.103606-1-daniel@iogearbox.net>
	<20250919213153.103606-8-daniel@iogearbox.net>
	<20250922183449.40abf449@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 18:34:49 -0700 Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:40 +0200 Daniel Borkmann wrote:
> > Similar to AF_XDP, do not allow queues in a physical netdev to be
> > resized by ethtool -L when they are peered.  
> 
> I think we need the same thing for the ioctl path.
> Let's factor the checks out to a helper in net/ethtool/common.c ?

And/or add a helper to check if an Rx Queue is "busy" (af_xdp || mp ||
peer'ed) cause we seem to be checking those three things in multiple
places.

