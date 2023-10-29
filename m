Return-Path: <bpf+bounces-13565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9E17DAA78
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 03:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DA3B20DBB
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 02:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F25DEDF;
	Sun, 29 Oct 2023 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAB803;
	Sun, 29 Oct 2023 02:13:53 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D3DB8;
	Sat, 28 Oct 2023 19:13:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5BA05207AC;
	Sun, 29 Oct 2023 03:13:49 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LPJ8PIOGi8-4; Sun, 29 Oct 2023 03:13:45 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C859E20612;
	Sun, 29 Oct 2023 03:13:45 +0100 (CET)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id B9D0380004A;
	Sun, 29 Oct 2023 03:13:45 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 29 Oct 2023 03:13:45 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 29 Oct
 2023 03:13:44 +0100
Date: Sun, 29 Oct 2023 03:13:35 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<steffen.klassert@secunet.com>, <antony.antony@secunet.com>,
	<devel@linux-ipsec.org>
Subject: Re: [RFC bpf-next 0/6] Add bpf_xdp_get_xfrm_state() kfunc
Message-ID: <ZT2/z1pbufL0fYqe@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1698431765.git.dxu@dxuuu.xyz>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Oct 27, 2023 at 12:46:16 -0600, Daniel Xu wrote:
> This patchset adds a kfunc helper, bpf_xdp_get_xfrm_state(), that wraps
> xfrm_state_lookup(). The intent is to support software RSS (via XDP) for
> the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
> on (hopefully) reproducible AWS testbeds indicate that single tunnel
> pcpu ipsec can reach line rate on 100G ENA nics.
> 
> More details about that will be presented at netdev next week [1].
> 
> Antony did the initial stable bpf helper - I later ported it to unstable
> kfuncs. So for the series, please apply a Co-developed-by for Antony,
> provided he acks and signs off on this.

Thanks Daniel for working on this and bringing it upstreadm.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>

> 
> [0]: https://datatracker.ietf.org/doc/html/draft-ietf-ipsecme-multi-sa-performance-02
> [1]: https://netdevconf.info/0x17/sessions/workshop/security-workshop.html
> 
> Daniel Xu (6):
>   bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
>   bpf: selftests: test_tunnel: Use ping -6 over ping6
>   bpf: selftests: test_tunnel: Mount bpffs if necessary
>   bpf: selftests: test_tunnel: Use vmlinux.h declarations
>   bpf: selftests: test_tunnel: Disable CO-RE relocations
>   bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
> 
>  include/net/xfrm.h                            |   9 ++
>  net/xfrm/Makefile                             |   1 +
>  net/xfrm/xfrm_policy.c                        |   2 +
>  net/xfrm/xfrm_state_bpf.c                     | 105 ++++++++++++++++++
>  .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
>  .../selftests/bpf/progs/test_tunnel_kern.c    |  95 +++++++++-------
>  tools/testing/selftests/bpf/test_tunnel.sh    |  43 ++++---
>  7 files changed, 202 insertions(+), 54 deletions(-)
>  create mode 100644 net/xfrm/xfrm_state_bpf.c
> 
> -- 
> 2.42.0
> 

