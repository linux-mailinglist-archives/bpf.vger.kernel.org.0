Return-Path: <bpf+bounces-53571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32383A56799
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 13:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C24318903DA
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CBD219308;
	Fri,  7 Mar 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAAKNVwX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5B1B413D;
	Fri,  7 Mar 2025 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349623; cv=none; b=ci0xVbc+MYIF7AXBV5F4Mczkh0u0XpTGUv5yyKxPCTbpZeIYRtTwd2cx6dflSt5Co8Yxn2GvgyW3/m6IygGi6scgXJcYDQG37H1GwAjwWhCqxoowvfaPi3xtBuIU5Tx5FFnGh/fH4NryD/b99qPdCNdps1FBeOdE6ztjBsL3K98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349623; c=relaxed/simple;
	bh=A0iB+YCb+UVBZshzVwjPGcV1KlpUOFw1SPgFL2eBkpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoouyaTMfkyPKHPwJ73QdVV5VO8tJMcJJSTc+s78j5lD0WX4L3cEOLIgut7B9hqJ/5nSDG9GHHyNBEzktGQWB5LywgbiCoNSj3YgiJip/fZiA31x2L3nu+hn0b2gsLwRFwVFEpEBX9j3DU05kbTidYxbhI/skNL/z3hBSlLZwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAAKNVwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C604C4CED1;
	Fri,  7 Mar 2025 12:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741349621;
	bh=A0iB+YCb+UVBZshzVwjPGcV1KlpUOFw1SPgFL2eBkpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAAKNVwXTNgwLiB5yUVEtuwsAVGV/QIJuDWb7igtxd0P9qswD1E8OeErlDEuR/e4A
	 KzLmqjaEJZEEl8hSt3qCO5bduwmqj7FwIXcOT4tSNTVGxBcAdBk7AWN4yLRQ/mH/Ta
	 NH7IKeh8DSsI6ZQyf5gMsWXFqhAVxHXQBYrvIhW0+UfaCBXrOUm7UjEXrPkF7B1TOK
	 SMzEej6Y5vdB6J5u6wKBSSsXn2sden45AL2Ml53BlqVAWJg8Ls711zuQtM6RIh95+n
	 mN2kfDztpe5dbxCy74QPpzR2QMb4IHiGzh8wu9JEohDHUW7xPD0W/hDCgkdkVGFdrr
	 aEDVYiNNNjX8A==
Date: Fri, 7 Mar 2025 13:13:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
	eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	yury.norov@gmail.com, akpm@linux-foundation.org, hpa@zytor.com,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
Message-ID: <Z8ri5h-nvNXNp6NB@gmail.com>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
 <20250306162541.2633025-2-visitorckw@gmail.com>
 <9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org>
 <Z8ra0s9uRoS35brb@gmail.com>
 <a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org>


* Jiri Slaby <jirislaby@kernel.org> wrote:

> On 07. 03. 25, 12:38, Ingo Molnar wrote:
> > 
> > * Jiri Slaby <jirislaby@kernel.org> wrote:
> > 
> > > On 06. 03. 25, 17:25, Kuan-Wei Chiu wrote:
> > > > Change return type to bool for better clarity. Update the kernel doc
> > > > comment accordingly, including fixing "@value" to "@val" and adjusting
> > > > examples. Also mark the function with __attribute_const__ to allow
> > > > potential compiler optimizations.
> > > > 
> > > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > ---
> > > >    include/linux/bitops.h | 10 +++++-----
> > > >    1 file changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > > > index c1cb53cf2f0f..44e5765b8bec 100644
> > > > --- a/include/linux/bitops.h
> > > > +++ b/include/linux/bitops.h
> > > > @@ -231,26 +231,26 @@ static inline int get_count_order_long(unsigned long l)
> > > >    /**
> > > >     * parity8 - get the parity of an u8 value
> > > > - * @value: the value to be examined
> > > > + * @val: the value to be examined
> > > >     *
> > > >     * Determine the parity of the u8 argument.
> > > >     *
> > > >     * Returns:
> > > > - * 0 for even parity, 1 for odd parity
> > > > + * false for even parity, true for odd parity
> > > 
> > > This occurs somehow inverted to me. When something is in parity means that
> > > it has equal number of 1s and 0s. I.e. return true for even distribution.
> > > Dunno what others think? Or perhaps this should be dubbed odd_parity() when
> > > bool is returned? Then you'd return true for odd.
> > 
> > OTOH:
> > 
> >   - '0' is an even number and is returned for even parity,
> >   - '1' is an odd  number and is returned for odd  parity.
> 
> Yes, that used to make sense for me. For bool/true/false, it no longer does.
> But as I wrote, it might be only me...

No strong opinion on this from me either, I'd guess existing practice 
with other parity functions should probably control. (If a coherent 
praxis exists.).

Thanks,

	Ingo

