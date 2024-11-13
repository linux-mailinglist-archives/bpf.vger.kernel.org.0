Return-Path: <bpf+bounces-44711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7D49C670E
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 03:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DCC281A43
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325F70835;
	Wed, 13 Nov 2024 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2F8zcTZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601822081;
	Wed, 13 Nov 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463508; cv=none; b=oJ10Cvz7SZgw1ezE4P3hxbSAwFf3UjPpqiYoM4bJg11kxxu7RJjlu/C6QzAfkPrAGKeqMxatZpUE28s0FwiklJ9RDD9sLBDuTRe1m9I0XRwGumiLRMRQliNurKTjKmPCnzarmlk0/7sXE0VYBrX4bARfPCCFcydaKAuF6dyGbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463508; c=relaxed/simple;
	bh=2Yw/P3dld0TRMWGFQWeFVLNCPXWyzavy3QmAvNv1Li8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+nifte8msd9Ccvh1NqzQlg4u7FOip5QZkvb4AAhSeAUQgsa3zK42IfECOCSBImTwCjypMMWcs5eAtef/t2U4ct/7a0xRKZVCwrNRR5lvW68lWaMmpkrLQQpcWV4zXMn5XK2BawonsfG29cfl4ee2N/YsIGy3U4vJu+8sIqdz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2F8zcTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64311C4CECD;
	Wed, 13 Nov 2024 02:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731463508;
	bh=2Yw/P3dld0TRMWGFQWeFVLNCPXWyzavy3QmAvNv1Li8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N2F8zcTZJ1tGo8LXCCbXh12frl1tAbpOW/W04qSDul14Wm+5pzGSxYWgnCjeSQrF7
	 jLl3mFxlV4rt/0aklw50Iq4iKXZMfp0G07jOXHsCifFz48rP9lo9lWm5xWRkfEzI2f
	 puioUhmUqm4gRzOUq9UmsFp6chPKUpQxmGlxNMfd0PYXtwMKhcwPeZZwWCbxGt1fo1
	 groxDQgaOXva9UpnXztKwv5oyIIO0iyUuDDr3K0U/B4QxvnCXQHaso9ANGuzsEUjsF
	 eR002jAy2bsxgCIcXW8oMgRBVWln/2mlamlMBibDdfamo9Niaf++/PqsgrQXZgzlwG
	 bPvHibv5P5JRg==
Date: Tue, 12 Nov 2024 18:05:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Magnus Karlsson
 <magnus.karlsson@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
Message-ID: <20241112180506.3c523f63@kernel.org>
In-Reply-To: <32c8ef18-8c9b-4580-b064-2ed9ba25772b@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
	<20241108082741.43bf10e7@kernel.org>
	<32c8ef18-8c9b-4580-b064-2ed9ba25772b@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 16:23:28 +0100 Alexander Lobakin wrote:
> > include/net/libeth/xsk.h:93:2-3: Unneeded semicolon
> > include/net/libeth/xdp.h:660:2-3: Unneeded semicolon
> > include/net/libeth/xdp.h:957:2-3: Unneeded semicolon
> > 
> > :(  
> 
> OMG, shame on me >_<
> How did you catch that? IIRC I didn't have anything in
> `checkpatch --strict`...

It's coccicheck, make coccicheck. Which takes a year and a half to run.
Filtering down the files to run on helps a little bit:
https://github.com/linux-netdev/nipa/blob/main/contest/tests/cocci-check.sh

TBH I don't expect people to run this, it's too slow and noisy.

