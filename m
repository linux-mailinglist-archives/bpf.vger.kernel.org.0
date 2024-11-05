Return-Path: <bpf+bounces-43993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1491C9BC37A
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06371F22D66
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2323D5B1FB;
	Tue,  5 Nov 2024 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zck0Cmgd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D153A94A;
	Tue,  5 Nov 2024 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775573; cv=none; b=roG0QaEmEznb16LLjqlo0Ugq9Ebxz7B5tin+Owj5Q9KTH7QXFGPRUpYojCj2Eo0YFSMj+f8994y2ISIRZCiLM2wUZjAg9YLLNkoFREM60owC1e1C3K6N4lgu5n7eyzWKf+DMymXHA8hb1UQri2KcsvYPyN44MdjAEUj1vTJ1Krc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775573; c=relaxed/simple;
	bh=bu7pN4uruG2MuJ0hCR8PI4hXZNwpCzJvpzIQc6l1SWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utTgkuV5URJbzIpnK28BmUXfTuD2jB1bLyT2MCMjvA6FazGwrW/tM/KdTyuq4GzZysivsAXsDMs/HjbJBj2SKFaxdKK8RbEs92dEI2PubImn61CRWVR4kh1oEoN5iOZ5YTsC1lgCHIP6GfTlk5cU/+KXuqhT0KY5t2NmoJT/4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zck0Cmgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEF2C4CECE;
	Tue,  5 Nov 2024 02:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730775573;
	bh=bu7pN4uruG2MuJ0hCR8PI4hXZNwpCzJvpzIQc6l1SWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zck0Cmgd8m3pQCrr88CvSnwq6cnTgld14GUwtz7BDQzVIq3fpfato6y5tg5TblG5v
	 n1xTgPiwDmPAmlf2iaupltcpMosX2lcI9q7aAWSEPYo1Wom4jPUb9rBE4Fbmm7tt8Y
	 7zKJhF3uq9QGJ2KmnhBXTiPCdqhiXT1OvbM+DMGDxVtJcLeY62c2ggu29HVp0Rrq5M
	 XBE4taJvTWgHZPvLXcPnNHsK2aAH7K94jTwP8yK+4AFz8zTFmD6Wx0wNKEvT7mZdwV
	 5tjIp7FlkNvlE04y4bO5jwqa5ZChDAZD4I5CDlMwSYVM5UJweXoEQoEJsx1KBOmdrV
	 /HjB81BDmJizQ==
Date: Mon, 4 Nov 2024 18:59:32 -0800
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
Subject: Re: [PATCH net-next v3 10/18] xdp: get rid of xdp_frame::mem.id
Message-ID: <20241104185932.7c357398@kernel.org>
In-Reply-To: <4068b108-bd5a-4d09-97e9-4f9196b35eca@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
	<20241030165201.442301-11-aleksander.lobakin@intel.com>
	<20241031174107.02216ff9@kernel.org>
	<4068b108-bd5a-4d09-97e9-4f9196b35eca@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 15:36:34 +0100 Alexander Lobakin wrote:
> Yeah I only need to assign mem_type instead of mem in that new place.
> linux-next handles conflicts, but not our CI...

FWIW we do resolve (see the "(pull: resolved)" markings on the status
page) but this is a tricky case where the patch will likely apply but
build will fail. And if we add a local patch in the CI the build will
break if your series is _not_ pending.. So yeah I don't have any great
idea how to resolve such cases. It's first time it happened.

