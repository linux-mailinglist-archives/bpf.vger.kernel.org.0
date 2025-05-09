Return-Path: <bpf+bounces-57832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A7DAB076A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 03:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DD91C00E97
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922627FBAC;
	Fri,  9 May 2025 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMDvMc0Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70CBA53;
	Fri,  9 May 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746753970; cv=none; b=FRnQnootndoH7RIDIeM/BmZCKFiYoRm2BRYLoD9EyYNawz2h9XOE+GzKNikgM374aAEc/jOOyVR0lxgzcNOAYdY33g+o17ssdniGFirM19dYuNkJ+pxvCh0X9O72MrI6lR+nftXL1RiUJkYQ7GZf9ENe+q5BXTx+trKRKgq4Euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746753970; c=relaxed/simple;
	bh=W2Kn1Meo1WO1OQfVj7njhn7xo955vvkHdnBFO5GErao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzLPhqzXxNK7syWtbNHECT7s/t68AZHrksGGh7PRJ4CPSwBKc+jQNu70qB8e904J7fLqkbo/AN1+OAS7wI20PrCOYpitDpLTlC21GJtQ88cYRrPrLIqZJnUibOnrzChsl+qBdCNizvcoSxWOb37l0MIRVMRHPXZ1AgOFNlSSIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMDvMc0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8BBC4CEE7;
	Fri,  9 May 2025 01:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746753969;
	bh=W2Kn1Meo1WO1OQfVj7njhn7xo955vvkHdnBFO5GErao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fMDvMc0YXCFTgqtrfugXQ1jFCIjWb2vSTc0lOFCGXY27nUXkVGWIbLoMQ0nXjvbLy
	 qTsuWXPelekMmuAg3wdf6omHEM18OXYSHIJW17V7j0GMdNh1LrOZP2GkLZNT0A4T1G
	 HYbx+bPLRuiRvgHJXmIIgpvqU5A5N3VrmHUVIbSednuJO6QKBd1Ly+h4kVSLRXscZW
	 stuhYTNGc027UdNEa4nrY/ie+RgO7Z8XsHN38A2nGzn1jidWOe+AXyzWEmFJmbqYUp
	 mOoGe+6459MuV3VHChiX4hfvKvexoIAqoJTnkzn/6p9eyuuSt7DDC9JWxFPbS2/nLJ
	 klNryf39xwtBw==
Date: Thu, 8 May 2025 18:26:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jon Kohler <jon@nutanix.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Zvi Effron <zeffron@riotgames.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Message-ID: <20250508182607.75993cf3@kernel.org>
In-Reply-To: <3fed59c6-e959-4863-b1c5-1927ef0d61df@kernel.org>
References: <20250506125242.2685182-1-jon@nutanix.com>
	<aBpKLNPct95KdADM@mini-arch>
	<681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
	<c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
	<CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
	<062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
	<681b96abe7ae4_1f6aad294c9@willemb.c.googlers.com.notmuch>
	<B4F050C6-610F-4D04-88D7-7EF581DA7DF1@nutanix.com>
	<e4cf6912-74fb-441f-ad05-82ea99d81020@kernel.org>
	<6FF98F38-2AE5-4000-8827-81369C3FB429@nutanix.com>
	<b99b73e8-0957-45f8-bd54-6c50640706df@kernel.org>
	<B864BCB8-AEAE-4802-AB46-176D2CEEE862@nutanix.com>
	<3fed59c6-e959-4863-b1c5-1927ef0d61df@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 18:59:54 +0200 Jesper Dangaard Brouer wrote:
> I do notice Jakub isn't a fan of the patch in general, but it seems
> quite popular given the other high profile kernel developers that acked
> in V3.  I think it increase code readability for people that are less
> familiar with XDP code and meaning of the pointers (e.g. data_hard_start
> vs. data_end vs. data vs. data_meta). (We don't even have some ascii art
> showing these pointers).

Yup, ASCII art would be great, hopefully

 DOC: Basic sk_buff geometry

can be an inspiration.

