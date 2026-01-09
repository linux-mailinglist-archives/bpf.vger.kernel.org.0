Return-Path: <bpf+bounces-78296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F055D08840
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 11:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B753A3010D55
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039273382E2;
	Fri,  9 Jan 2026 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FghdoX+X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83C3376A1;
	Fri,  9 Jan 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954140; cv=none; b=CBPZMy3eZPFbuYenO5tKUsJ7MuFIYIzpFjnmoWRrCk6mXvaAShimn78vFmPfh+p7j6mQpgkn88ZP47ceMSpQrCrlCyrIoPEsHvZUAeGW6pCrgszxIYZ4BSjK4pbJNlCbFQplZPlkDmAGtLOfOBc6BFiun3RkC45/61pZeUEjbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954140; c=relaxed/simple;
	bh=k/y5wS7m3PCorSbIsufYzlkMVA4cSH3NgFbYGHDriBY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c3dZL3F51y2l9VvusILKxltOw9uUnSLCCiojgKRTtehnAosDn388MRO6iDnE5GWet6gMYEXFXC3lU5kXhjLfPExFZ5mONhUkHWGDxzy7aJf+4UsGr5jgvxL4aEARthj+uweZDk3unES+yiPWU1FXekL0dfyIApAuejHe+atd1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FghdoX+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23C1C16AAE;
	Fri,  9 Jan 2026 10:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767954140;
	bh=k/y5wS7m3PCorSbIsufYzlkMVA4cSH3NgFbYGHDriBY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FghdoX+X7pCJ1CY1P/xDwUjk10zpiuFN1umKblJMo1Mya7cu8cFkuBtTgxMxI3ozy
	 4DLJjNFub0ssGK7HyCIVdwcxMnQEH1Z9lYEUU9+U/H68tR/CRiLhUe5I1r2REjXcJ/
	 51FD5wiLYlUM1rL09x6563BzeqaoXbinnj8yPrTJFsGGzt+gnRECmMXnx0bgvq2SDn
	 Not0l4uPPUkZjnEwL003BaqTpY1hTb8JnzWNRrlO/pyORnEMRUx3NlPfTNTVMpopr8
	 YtVCCvcoW9Mfgl/NU6ge6QThj1pyJDsojtyEcdCJ5Tt4UsxISpDf4DlivJKVYTLyxu
	 UrCo3xtdhWBBw==
Content-Type: multipart/mixed; boundary="===============3264741798394886588=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f04fd2cec5faaad04efb29f9c8ada7057d7d90f4ee76114b5b1095c8e0fc81e@mail.kernel.org>
In-Reply-To: <20260109100420.1967-2-qikeyu2017@gmail.com>
References: <20260109100420.1967-2-qikeyu2017@gmail.com>
Subject: Re: [PATCH bpf] xsk: fix init race causing NPD/UAF in xsk_create()
From: bot+bpf-ci@kernel.org
To: qikeyu2017@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,bjorn@kernel.org,hawk@kernel.org,pabeni@redhat.com,magnus.karlsson@intel.com,daniel@iogearbox.net,maciej.fijalkowski@intel.com,kuba@kernel.org,edumazet@google.com,horms@kernel.org,ast@kernel.org,sdf@fomichev.me,john.fastabend@gmail.com,qikeyu2017@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  9 Jan 2026 10:22:19 +0000 (UTC)

--===============3264741798394886588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f093c3453f64..58e9c61c29e0 100644

[ ... ]

> @@ -1922,10 +1923,6 @@ static int __init xsk_init(void)
>  	if (err)
>  		goto out;
>
> -	err = sock_register(&xsk_family_ops);
> -	if (err)
> -		goto out_proto;
> -
>  	err = register_pernet_subsys(&xsk_net_ops);
>  	if (err)
>  		goto out_sk;

[ ... ]

> @@ -1942,16 +1939,21 @@ static int __init xsk_init(void)
>  		goto out_unreg_notif;
>  	}
>
> +	err = sock_register(&xsk_family_ops);
> +	if (err)
> +		goto out_proto;
> +
>  	return 0;
>
> +out_proto:
> +	proto_unregister(&xsk_proto);
> +	kmem_cache_destroy(xsk_tx_generic_cache);
>  out_unreg_notif:
>  	unregister_netdevice_notifier(&xsk_netdev_notifier);
>  out_pernet:
>  	unregister_pernet_subsys(&xsk_net_ops);
>  out_sk:
>  	sock_unregister(PF_XDP);
                ^^^^^^^^^^^^^^^^

With sock_register() now at the end of xsk_init(), the out_sk label is
reached via goto from register_pernet_subsys(), register_netdevice_notifier(),
or kmem_cache_create() failures - all of which occur before sock_register()
is called.

Shouldn't out_sk be removed entirely, and the gotos redirected? For example,
if register_pernet_subsys() fails, we goto out_sk and call sock_unregister()
on a family that was never registered. The same applies to the other error
paths that fall through to out_sk.

While sock_unregister() on an unregistered family appears to be benign (it
just sets NULL to NULL), it will print "NET: Unregistered PF_XDP protocol
family" to the kernel log even though it was never registered in the first
place.

> -out_proto:
> -	proto_unregister(&xsk_proto);
>  out:
>  	return err;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20848468294

--===============3264741798394886588==--

