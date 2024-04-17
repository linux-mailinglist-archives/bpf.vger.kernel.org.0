Return-Path: <bpf+bounces-27038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795FE8A82CD
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3C51F21253
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCF13D2AB;
	Wed, 17 Apr 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="k+c6TrXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PskRulJQ"
X-Original-To: bpf@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1113D279;
	Wed, 17 Apr 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355668; cv=none; b=DTIzVNg0rLcJPDGoadF4xmmljJS7dBy7qADyfs3RAecfFCc5WM0V6aRSsdCtVuB9asN8SJXt4aKYegqVg7qKCbDKvirFFFZCVhflwsyVKEGZ2LGHKHoJRJ6iVdXFseaHAjg2iXkqOb+mCmQ/KiwkLySC0RnL8xhGJ5av5CN7u8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355668; c=relaxed/simple;
	bh=ePiA4ddQh/R2An+M1WNyiwY8cnfIfyGkHQWLq8GAgQE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EPxOx4jDLSHzdt6nLr8LzG7GgTksJ58DdQBR2PcxP9+M0O60hRqSvM+42KrhQUjsdbqfx9X5eBeluvej/cRzNmDnkDSazKVwz/CJJb4fXuO7Ckf5Dh6nk6h0Mg3Z4WqqKaI8+Aoo5Ok0pwcUqTeADS3ZrijheNenUYwfUoZRCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=k+c6TrXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PskRulJQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E831D13800DA;
	Wed, 17 Apr 2024 08:07:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 17 Apr 2024 08:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713355661; x=1713442061; bh=JRwjaLl0ym
	PdY2EgpKl1AbwXbEtgcsWk+ZdHAqGgzzA=; b=k+c6TrXTt5DHwehRTMmiSrDI8X
	l2e0ys2mZWau27bGYpDETExVxOKyRry6wX4aYJMZuXz/rDiALPj6s770Pr+m86RX
	Tk4euw3T5Ytz/mgrWfj9+YCzDhuPANYtli39Spr7MZkNhr+pKrU/jdSku9pb3+zP
	jM7iqZmNRLOq2j+Fs7xh8wpbgqAtxVsvXQ+RJ17kLqz3pFBExGYARGDpcy11UIzb
	B9jesANBpTBKjPj+ehy+LVKQILkfrY+6EAde3F78QJuO92n0URjrJMC36ZvYSuw0
	wxNZKs7wO4viH52Uof3J9i69NFGXTL8jOM2RN+p32OrBJjjapaiWQYAvdI0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713355661; x=1713442061; bh=JRwjaLl0ymPdY2EgpKl1AbwXbEtg
	csWk+ZdHAqGgzzA=; b=PskRulJQuqnv1ZOaZ50DEIAA3VW4QVBBupAQcPlTv1IK
	dtEyQz9vBKl3/cnuZRphIQ1Ko88EM7KrplI+YwutgaaSIUq0w3BmQ0V6TufjEyP2
	yTltxlsJapXhVkedfxfyGEL0meg4CCLTca8uCiOnkeNrWsAozWbI03ErYj839KTU
	7wrUsQkd0dnBWfXGeL006fV/8YBv9DEaiOzpBKs+xjoZsDlkazxB9OT+4E9DCq3S
	Z0QmGG0b1DQIfkl6aQQD6M9hV+PR7TQKwLgHcdvevbcs8bQ8aTCi91Wto7ULXNLC
	aY44keeltld1H76RHlpp0RDISov29a2XxU+sxAxONg==
X-ME-Sender: <xms:jbsfZht3D6K4z8QUB_gpc0081jG8mXbjM2wxuhL6ay0L_xLcjQsBqQ>
    <xme:jbsfZqcUcmTDrDyv2PjpKywqMyZD8QMW4Bo2U6WIB_VblLYvDAu33DmGDRto4uPdA
    i_V3CJA19Qq__lhYIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jbsfZkwtdRa082bkNjb2lvv2HcsAlt__dmZvMbAP-SSYpwpEfMVoxQ>
    <xmx:jbsfZoP9icWCo2EnVuIn5n1fSCHZ1vsYQ9NtAh-R-FFFUQTLwu8suA>
    <xmx:jbsfZh9njKASvlFGKFHyLftms-gaKJ07O5IieLpg2qCUWGBc0QNg1Q>
    <xmx:jbsfZoVe6PONKKNFIlqeQoLgVLq4doPUraiRPj4rdjhTGjji32QnaQ>
    <xmx:jbsfZogZw4hA1EhiSt-0ZqWxnSZqbuj3bTO9NsJsmCHYbblYG_WtVpF5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5986EB6008D; Wed, 17 Apr 2024 08:07:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d752e7c9-7793-4b50-bc2a-344b63ffa6cb@app.fastmail.com>
In-Reply-To: <8663692f-528f-4d68-8c35-136e5f1244dc@intel.com>
References: <20240417084400.3034104-1-arnd@kernel.org>
 <8663692f-528f-4d68-8c35-136e5f1244dc@intel.com>
Date: Wed, 17 Apr 2024 14:07:19 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
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

On Wed, Apr 17, 2024, at 13:49, Alexander Lobakin wrote:
> From: Arnd Bergmann <arnd@kernel.org>
> Date: Wed, 17 Apr 2024 10:43:01 +0200
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> There are six variants of the cpsw driver, sharing various parts of
>> the code: davinci-emac, cpsw, cpsw-switchdev, netcp, netcp_ethss and
>> am65-cpsw-nuss.
>
> https://lore.kernel.org/all/20221119225650.1044591-10-alobakin@pm.me

I also sent a version of this patch before, but there were conflicting
changes in the past. The version I sent should apply to the
current code.

    Arnd

