Return-Path: <bpf+bounces-36325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3734B9465FE
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 00:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF960B221DF
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8919313AA2D;
	Fri,  2 Aug 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmhwDZJG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A81ABEDD;
	Fri,  2 Aug 2024 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722638913; cv=none; b=iVqBx0UGjpLxeu7+R6dNP22zhRvA+A+AitoqH7Pvua2LU0pUejCmhQvxaJMHjplCbc238yB62a8GAG/pO1QydGInV7yB5OdJLJHcmsJw9AYDKiBP0HqEib/8ARDmRaBBtBM8TJxgEjTsDdxY4LCZNNhv9eVQD5sK1ZwfBdisppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722638913; c=relaxed/simple;
	bh=u1OvSoK1rFbwNdxFMjcrpR4gd5lDO5xx65Jvjp77uVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3ol3y9C0rsn5n6hw6u/E5QImeS1dESajPtmYaNDbyvwpfzaz25Yoc/Z6Uv9YM6KtwKXrNzSbOiZ9Hdcq8dWxw5ZMYpNW/z9uAYrRHI1/dqoUcl+4T37MwA6HvGakskqUPUsR8zIBTGHxgeIdCuP16GrQsmrss4Es/z6XrEUgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmhwDZJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFB9C32782;
	Fri,  2 Aug 2024 22:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722638912;
	bh=u1OvSoK1rFbwNdxFMjcrpR4gd5lDO5xx65Jvjp77uVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qmhwDZJGgTnu1+dpNZRrJeHfPTNenRtIC8SNAzseHLplj1qdOKt0FQZPQGlT15c8V
	 8pj46mhNxENKcPsgA2mAz+0amh7io/z3VkHcuOMgN5xsaOeBWnYR3cgRswuh1IxzOK
	 twMOW7zE2Bu1GrvvPya+EDlXdGALAdr23yxnCeB8yd/L085d9++zzqzU2gOd9rViso
	 gWXEnKjXWao4MW1TpXUYsQzllc7Utkk30HZDwEHxg1rdP1VZ2ssK3b7scVBtTPHy2o
	 zbELD7LwlL5KYu4zqdADVyBwlFIwYWdL5CQfE782dbdpLlfopUz0xfan84SMNvOlcr
	 axu/1/O1tosjg==
Date: Fri, 2 Aug 2024 15:48:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, Andrew
 Halaney <ahalaney@redhat.com>, bpf@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC v3 0/14] net: stmmac: convert stmmac "pcs" to
 phylink
Message-ID: <20240802154830.7b147f75@kernel.org>
In-Reply-To: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Aug 2024 11:45:21 +0100 Russell King (Oracle) wrote:
> Subject: [PATCH RFC v3 0/14] net: stmmac: convert stmmac "pcs" to phylink

we have a build error here inside the tasty layered cake that is the op
handling in this driver (from patch 2 to 13, inclusive):

In file included from drivers/net/ethernet/stmicro/stmmac/common.h:26,
                 from drivers/net/ethernet/stmicro/stmmac/stmmac.h:20,
                 from drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c:=
19:
drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c: In function =E2=80=98=
stmmac_ethtool_set_link_ksettings=E2=80=99:
drivers/net/ethernet/stmicro/stmmac/hwif.h:15:17: error: too many arguments=
 to function =E2=80=98priv->hw->mac->pcs_ctrl_ane=E2=80=99
   15 |                 (__priv)->hw->__module->__cname((__arg0), ##__args)=
; \
      |                 ^
drivers/net/ethernet/stmicro/stmmac/hwif.h:485:9: note: in expansion of mac=
ro =E2=80=98stmmac_do_void_callback=E2=80=99
  485 |         stmmac_do_void_callback(__priv, mac, pcs_ctrl_ane, __priv, =
__args)
      |         ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c:419:17: note: in expan=
sion of macro =E2=80=98stmmac_pcs_ctrl_ane=E2=80=99
  419 |                 stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, priv->hw=
->ps, 0);
      |                 ^~~~~~~~~~~~~~~~~~~

