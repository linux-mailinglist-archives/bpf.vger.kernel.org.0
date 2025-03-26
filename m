Return-Path: <bpf+bounces-54757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E611A71AED
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 16:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F0D1687D2
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB31F5619;
	Wed, 26 Mar 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qEh8ODKv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB431F4E30;
	Wed, 26 Mar 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003658; cv=none; b=jo2j3z4L2MooYflvNDCNfAz+gKUzkh+1nvT63ivuKAKs8eK+dDkE+t8A83HaDCSrUTSPZn5/ZhzsCHhIJOMOaGSd1/wyh+aqWNSjSgnH81XslwdihseQAIciN0HOwjQ7Rntq2OlNWlp0NGTPzJXMS6wT7bPFv8/7e+ZdPrzt0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003658; c=relaxed/simple;
	bh=/c2BhTigo7q3rFYk5cg72DWJZ+VY8tYCx4u09+3mvbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnfQkwEXnDPWFQn8wBWfKh9+th49nLEg1nhhEJZFKUuRgKLAiRkPZJPU3h6Cww8ET06fXcAxmn/yUyryY4JcGc/pgcNoBDrfPUyn3OPOK4CDh0NQdhrLqTH4k9mE5kHAEZgHhzSUPYBPcPOx3nrUznJb9MJcO+OnfyEYET+GWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qEh8ODKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0388C4CEE8;
	Wed, 26 Mar 2025 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743003657;
	bh=/c2BhTigo7q3rFYk5cg72DWJZ+VY8tYCx4u09+3mvbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEh8ODKviEUhFSd/Tp/OWN/KY/MkmQ4QLZjxpJ7F5Lbcu8CjVJ5iev4rVQ6pyVZdQ
	 0yTI3slB55+84BFpvOp66MxOMB/lDQxuu0WpTOWmJ7ebQfSH/TrWC6DVUF4d4twNCk
	 rgENUAJFSZWr5Lhuxz7uyByYmYF7Dg47u8x9eD1U=
Date: Wed, 26 Mar 2025 11:39:33 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Friedrich Weber <f.weber@proxmox.com>,
	Aaron Conole <aconole@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Carlos Soto <carlos.soto@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Pravin B Shelar <pshelar@ovn.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	Breno Leitao <leitao@debian.org>, Yan Zhai <yan@cloudflare.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@gmx.fr>,
	Joe Stringer <joestringer@nicira.com>,
	Justin Pettit <jpettit@nicira.com>, Andy Zhou <azhou@nicira.com>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Simon Horman <simon.horman@corigine.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:OPENVSWITCH" <dev@openvswitch.org>,
	"open list:BPF (Safe dynamic programs and tools)" <bpf@vger.kernel.org>
Subject: Re: [PATCH stable 5.15 v2 2/2] openvswitch: fix lockup on tx to
 unregistering netdev with carrier
Message-ID: <2025032620-protract-reassign-f3e7@gregkh>
References: <20250325192246.1849981-1-florian.fainelli@broadcom.com>
 <20250325192246.1849981-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325192246.1849981-3-florian.fainelli@broadcom.com>

On Tue, Mar 25, 2025 at 12:22:46PM -0700, Florian Fainelli wrote:
> From: Ilya Maximets <i.maximets@ovn.org>
> 
> [ Upstream commit 82f433e8dd0629e16681edf6039d094b5518d8ed ]

As Sasha's bot said, this is the wrong git id :(

