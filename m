Return-Path: <bpf+bounces-17002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B87808717
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 12:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34BD1C21C5F
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 11:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2428239AD2;
	Thu,  7 Dec 2023 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vpHrysFS"
X-Original-To: bpf@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4160210C8;
	Thu,  7 Dec 2023 03:54:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 050902084B;
	Thu,  7 Dec 2023 12:54:19 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g1AA3E5yqbnw; Thu,  7 Dec 2023 12:54:18 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6981820799;
	Thu,  7 Dec 2023 12:54:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6981820799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1701950058;
	bh=vHv2uiIJHFa+oEnwl8Qg+nF1oDhGEIZ83vb7AQ2qMT4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=vpHrysFS3qfhS3tNx1+U3dwrm52+rTHD2Tw735x3IdISWPOeb307vONBxf+x+ZBo+
	 vgsuden0nZPxZlye6dmSzhk3cziKo9OuM2+kEA3Si/Jz7ZUBHibxLh6Y9H9wQmt0iW
	 xsznjPbTBzA6OJ/EZxUiAPy//PKg8ZspjcvvI5ZQ2xDiqXTPST90nMZJEMlcyWOS5W
	 cbN2+VJ3tq2es4nsSZG9qPdlhMSjDnHgqoI6pIBWKv7+i6zWCIsI4URQhCzNjM5ZVl
	 rDZBDZ2wP2HL4ggwLxTTMAFfbV2bsxgpx5VtxdQnb/TwisfbhTEREACM/h3vUpZM7p
	 VT2f9nfKcylRg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 6447980004A;
	Thu,  7 Dec 2023 12:54:18 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 12:54:18 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 12:54:18 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id AC32B31848F7; Thu,  7 Dec 2023 12:54:17 +0100 (CET)
Date: Thu, 7 Dec 2023 12:54:17 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, <pabeni@redhat.com>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<antony.antony@secunet.com>, <alexei.starovoitov@gmail.com>,
	<yonghong.song@linux.dev>, <eddyz87@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<devel@linux-ipsec.org>
Subject: Re: [PATCH bpf-next v4 03/10] bpf: xfrm: Add
 bpf_xdp_xfrm_state_release() kfunc
Message-ID: <ZXGyacGEeV64J/PE@gauss3.secunet.de>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
 <66e92984df48e03a518580f2d416a6fdb5bd4b0d.1701722991.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66e92984df48e03a518580f2d416a6fdb5bd4b0d.1701722991.git.dxu@dxuuu.xyz>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Dec 04, 2023 at 01:56:23PM -0700, Daniel Xu wrote:
> This kfunc releases a previously acquired xfrm_state from
> bpf_xdp_get_xfrm_state().
> 
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>

