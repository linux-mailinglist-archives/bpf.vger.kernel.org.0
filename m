Return-Path: <bpf+bounces-17001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A07808714
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 12:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F15B21E29
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7643C39AC9;
	Thu,  7 Dec 2023 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="D7CepgAJ"
X-Original-To: bpf@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951FAA;
	Thu,  7 Dec 2023 03:53:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EBAA5207D5;
	Thu,  7 Dec 2023 12:53:35 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xdw25MNClfav; Thu,  7 Dec 2023 12:53:35 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6980F20799;
	Thu,  7 Dec 2023 12:53:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6980F20799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1701950015;
	bh=9f501q9ShAm0hj89EjusFvxtFDqwlRusnLwKcvi42mk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=D7CepgAJkUf8ObQV59bX3sjzotaZC7yz4W8BbEEPxFsauN4JnpriOKHOeNnLHd5z5
	 k8rU2E+qi07ZeozaTsqqQgYa6F346EcDYsYta3MAdRrJ9XRNp8MlHillXqujCYCXYl
	 X8ayrwgbFlTUrkT5Ycu6VDrhmmEvZSkathdTTzuQ+YTSzOW1NJFotPf8qRBrWglVqJ
	 JvrwR6zaofalFArBdycd/q9lCM+s332FqDrXlzvlQv2/uUGbl7h1D17ll9/7VGdngR
	 B3UyX6A3ve7OV7Q4X87fb71kWatYzzj88BPnLLGSdHd9ySD3o+HW24I/i2G3Grj7Et
	 inCpW/iZVW0+g==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 635E980004A;
	Thu,  7 Dec 2023 12:53:35 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 12:53:35 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 12:53:34 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id AD2A231848F7; Thu,  7 Dec 2023 12:53:34 +0100 (CET)
Date: Thu, 7 Dec 2023 12:53:34 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, <pabeni@redhat.com>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<antony.antony@secunet.com>, <alexei.starovoitov@gmail.com>,
	<yonghong.song@linux.dev>, <eddyz87@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<devel@linux-ipsec.org>
Subject: Re: [PATCH bpf-next v4 02/10] bpf: xfrm: Add
 bpf_xdp_get_xfrm_state() kfunc
Message-ID: <ZXGyPt1GUVH1amA/@gauss3.secunet.de>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
 <e0e2fc6161ceccfbb1075d367bcc37871012072d.1701722991.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0e2fc6161ceccfbb1075d367bcc37871012072d.1701722991.git.dxu@dxuuu.xyz>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Dec 04, 2023 at 01:56:22PM -0700, Daniel Xu wrote:
> This commit adds an unstable kfunc helper to access internal xfrm_state
> associated with an SA. This is intended to be used for the upcoming
> IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
> words: for custom software RSS.
> 
> That being said, the function that this kfunc wraps is fairly generic
> and used for a lot of xfrm tasks. I'm sure people will find uses
> elsewhere over time.
> 
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>


