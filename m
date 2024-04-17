Return-Path: <bpf+bounces-27039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE88A82F5
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5425283BA4
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ABC13D296;
	Wed, 17 Apr 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbv3oMtp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC013D25A;
	Wed, 17 Apr 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356112; cv=none; b=FbCZXY1LaUXaJUHMXw979axQLsAlPGRHO9BcakyzBD+2+aA0yZRovFVMRi7DowHTxhAqmFv38OxvGZG+mIqy3XC7pRNbooNfAgkGgMNd18+nYbkDrQkMCGe6+MTlanWAKLarYTF6K/c0yVR3mGLhoBx/+3B16NReUoB7vgKVx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356112; c=relaxed/simple;
	bh=8RP7YV6jTWwAhDK6cRCfXJzcrc3TupkEAEbXFcDpJT4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PnZHcmOU3BU+DAbch3Zp8jji4sJ0bEuEf+Ol/Vj/mESz05uy0b2t0b33G0LsmFykTZHP/W/bn3hwnMceJFoL48Lla637oSXy/fau6nKX3LNxuxAMZNfVAcvqKghIBQWCbSslumQhAcTlnz3eB8GjU26AW3i5LaMtBEBbf93GSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbv3oMtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4049EC32783;
	Wed, 17 Apr 2024 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713356112;
	bh=8RP7YV6jTWwAhDK6cRCfXJzcrc3TupkEAEbXFcDpJT4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=Cbv3oMtpZseqC3ure3t5L2KaTZIVIVnpn2+inN1ISPc9sXzqqeU3BNa5xKwrFY2mf
	 eFJWa1jVH4S2rs9c+jLJIbf9XuFfzS22pEIUO3kCd6SdiOmW5u7A82aNXpd3eY6fNL
	 HDb/RBhwlNELOwhU6Uw/ef4xDPSmlBtIHd0Q1KhLOuUNJIwxcId1jKhRzVgzu4uley
	 kNMSlXlH+rHp1AEn31bQguC0l6D0SX+1pbcmDyn0iSRaGljH/52wFSjOju0LUMIJFI
	 RtlWvfMeXlLxw9PZNoOlpHyhbCX90X5bcyVLk1M5BzPTbDZ8kfWI8A10yqDdYbQkH/
	 6Hl0yRGEXjb7A==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 3AEA11200032;
	Wed, 17 Apr 2024 08:15:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 17 Apr 2024 08:15:10 -0400
X-ME-Sender: <xms:Tr0fZpE7dxpHQLHE0pOCAjs9k0gDWGR9vyviVxQ4Mb914Y8i6bTofw>
    <xme:Tr0fZuW-6lMu_vQnvVTK9I1K2I3AXL-9zSoImgmAVfeLwMgi6VsFW6ARXseyn3h2L
    MoM_SA_KtrL9A5zB9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepleevgfduieehfeeltdettdfhfffgkedugeeklefftdeivdfgveeiteet
    keehffevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnug
    eppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Tr0fZrJd8SokM4hZbcqkS6XUKGM83Kgiuh6-3KvYgqeJk1BgEm01DQ>
    <xmx:Tr0fZvE87iMMA1rnHIAfWTlxqHdIpo1Vprx8j198KFgNfoxtjJ7fEA>
    <xmx:Tr0fZvU8oL9wnoRIDttwogW8MAwiZj6KbjhC4Ba2BJ3PUV-HJKqEjw>
    <xmx:Tr0fZqOuwLYfwM6V2PTjBPlfKRD3GunocahJtAWZPA-mzFSKtEsa0g>
    <xmx:Tr0fZu1e0rcuLjKGllbhh3Athko76UPPk3FY6ShM0XmMfnB_rYC-ASKf>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EFC1DB6008D; Wed, 17 Apr 2024 08:15:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c02841b-b398-4a18-8b82-a80e53d4ecb0@app.fastmail.com>
In-Reply-To: <d752e7c9-7793-4b50-bc2a-344b63ffa6cb@app.fastmail.com>
References: <20240417084400.3034104-1-arnd@kernel.org>
 <8663692f-528f-4d68-8c35-136e5f1244dc@intel.com>
 <d752e7c9-7793-4b50-bc2a-344b63ffa6cb@app.fastmail.com>
Date: Wed, 17 Apr 2024 14:14:49 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 "Ravi Gunasekaran" <r-gunasekaran@ti.com>,
 "Roger Quadros" <rogerq@kernel.org>, "MD Danish Anwar" <danishanwar@ti.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Diogo Ivo" <diogo.ivo@siemens.com>,
 "Tanmay Patil" <t-patil@ti.com>, "Simon Horman" <horms@kernel.org>,
 "Ratheesh Kannoth" <rkannoth@marvell.com>,
 "Grygorii Strashko" <grygorii.strashko@ti.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Linux-OMAP <linux-omap@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] [v2] net: ethernet: ti-cpsw: fix linking built-in code to
 modules
Content-Type: text/plain

On Wed, Apr 17, 2024, at 14:07, Arnd Bergmann wrote:
> On Wed, Apr 17, 2024, at 13:49, Alexander Lobakin wrote:
>> From: Arnd Bergmann <arnd@kernel.org>
>> Date: Wed, 17 Apr 2024 10:43:01 +0200
>>
>>> From: Arnd Bergmann <arnd@arndb.de>
>>> 
>>> There are six variants of the cpsw driver, sharing various parts of
>>> the code: davinci-emac, cpsw, cpsw-switchdev, netcp, netcp_ethss and
>>> am65-cpsw-nuss.
>>
>> https://lore.kernel.org/all/20221119225650.1044591-10-alobakin@pm.me
>
> I also sent a version of this patch before, but there were conflicting
> changes in the past. The version I sent should apply to the
> current code.

FWIW, I also still carry this patch in my randconfig build
tree, with a lot of the same changes as your other patches:

 drivers/edac/Makefile                              | 10 ++--
 drivers/edac/skx_common.c                          | 19 +++++-
 drivers/edac/skx_common.h                          |  4 +-
 drivers/hid/Makefile                               | 12 ++--
 drivers/hid/hid-uclogic-params.c                   |  6 ++
 drivers/hid/hid-uclogic-rdesc.c                    | 69 ++++++++++++++++++++++
 drivers/mfd/Makefile                               |  6 +-
 drivers/mfd/rsmu_core.c                            |  2 +
 drivers/mtd/tests/Makefile                         | 34 +++++------
 drivers/mtd/tests/mtd_test.c                       |  7 +++
 drivers/net/ethernet/hisilicon/hns3/Makefile       | 11 ++--
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |  9 +++
 .../hisilicon/hns3/hns3_common/hclge_comm_rss.c    | 14 +++++
 .../hns3/hns3_common/hclge_comm_tqp_stats.c        |  5 ++
 .../net/ethernet/marvell/octeontx2/nic/Makefile    | 14 +++--
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |  9 +++
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |  4 ++
 drivers/platform/x86/intel/int3472/Makefile        |  9 ++-
 drivers/platform/x86/intel/int3472/common.c        |  5 ++
 20 files changed, 198 insertions(+), 53 deletions(-)

     Arnd

