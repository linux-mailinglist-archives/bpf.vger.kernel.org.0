Return-Path: <bpf+bounces-17000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08880870A
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 12:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A5A1F2274A
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA439ACF;
	Thu,  7 Dec 2023 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ChmI4z+m"
X-Original-To: bpf@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAA6D7E;
	Thu,  7 Dec 2023 03:52:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C868920870;
	Thu,  7 Dec 2023 12:52:13 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i3Bo8QGSjezw; Thu,  7 Dec 2023 12:52:13 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 41CDB20799;
	Thu,  7 Dec 2023 12:52:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 41CDB20799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1701949933;
	bh=KeHXcwEZ89gqASxIxHgTB0iaAVQN00/hXtLJfbYi6sM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ChmI4z+mcwzr/JvE3uUfPnUOym+Gcapt+jpRiYIFk8nLiQf5u1X66kC0Go3pA3FnH
	 hgQ2lDcOCPQmybU37awBawsfyTxVuZBZWd5bRKLCxcO0Qq2fhzNUtRU/McCg92MoyW
	 8z6qdVUH0GHRpMRvvdyxe8C8WKOA0VCd7YBw86qg97I5jO9iddDBd0gVdY0Nlk1dTh
	 9FgUt/zdGqLgE+Hs3FW0QLm+0ahIaPDzW7U3xFhYe6p5gl9dK22MhO07FRfb9YuapN
	 T2DKEBZMK6TCAhWSyo03I34FyrnFdgDRCQ84ufrfAadLwPxsVsBq4riqhoBon4hF+1
	 ZUYh3ZPItqbSg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 3147A80004A;
	Thu,  7 Dec 2023 12:52:13 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 12:52:12 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 12:52:12 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6053331847F8; Thu,  7 Dec 2023 12:52:12 +0100 (CET)
Date: Thu, 7 Dec 2023 12:52:12 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<antony.antony@secunet.com>, <alexei.starovoitov@gmail.com>,
	<yonghong.song@linux.dev>, <eddyz87@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<devel@linux-ipsec.org>, Eyal Birger <eyal@metanetworks.com>
Subject: Re: [PATCH bpf-next v4 01/10] xfrm: bpf: Move xfrm_interface_bpf.c
 to xfrm_bpf.c
Message-ID: <ZXGx7H/Spv634xgX@gauss3.secunet.de>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
 <a385991bb4f36133e15d6eacb72ed22a3c02da16.1701722991.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a385991bb4f36133e15d6eacb72ed22a3c02da16.1701722991.git.dxu@dxuuu.xyz>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Dec 04, 2023 at 01:56:21PM -0700, Daniel Xu wrote:
> This commit moves the contents of xfrm_interface_bpf.c into a new file,
> xfrm_bpf.c This is in preparation for adding more xfrm kfuncs. We'd like
> to keep all the bpf integrations in a single file.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  net/xfrm/Makefile                             |  7 +------
>  net/xfrm/{xfrm_interface_bpf.c => xfrm_bpf.c} | 12 ++++++++----
>  2 files changed, 9 insertions(+), 10 deletions(-)
>  rename net/xfrm/{xfrm_interface_bpf.c => xfrm_bpf.c} (88%)

Adding Eyal to Cc, he added the xfrm_interface_bpf.c file.

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>

