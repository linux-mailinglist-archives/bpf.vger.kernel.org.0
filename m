Return-Path: <bpf+bounces-53490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED806A551CC
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD0A3AFA78
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C342E257AED;
	Thu,  6 Mar 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PZR3j/Eu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90B255250
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279547; cv=none; b=Dfxiy5xzWVBXDbEn85Ffx6aZT0Bl3Zg6laCXMqtTa4hXaadMpqa7nNj+iJ4VjR4eNdnz6FM8B2mPwMTmHSLFVAKzLhR0043vBh7R//wVWnzypJgcr+tpW0s5a0DrburKKD3z/G9y60ZdpoBtygj+yrmKk0ccZP2F+WM4b3iOx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279547; c=relaxed/simple;
	bh=QBbBN5q5jWmas5qLcxj17oZ+jdnLgvFe5h91P+f5FGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3SciihsleaebH7+hTKR0RzjhlxWr8c+KTOEcJTwetsfdLQ5Tzy00AiZ+Enjz4CGMLcTK71egETOW+OvFPRIgybVH58NZxjWA4dWiOzjOQlBenr39sZtj+f7EqdvcrBQVjzH88S+O0+hYKvYoMsomNvo6vsNSY4PBBgcjM4VW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PZR3j/Eu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22349bb8605so17533145ad.0
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741279544; x=1741884344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1tVqjEsF9yz8as4gUEJSF7TOmyvcDOBt4MIJRvQkVI=;
        b=PZR3j/EuVQYZWE21li6QoRQedCT7JnMnGf/od4wE6dyyVgekUliUg6eNTO1Im67f7T
         /w5W4lng4T7Fuwpt9mhYaDaKe16zGXSM/Yya1x9A4GHojyvRMZHy/+ho6KQsSfdwNN3Q
         icvWlv3Vbu6bLJ+CClchlUORc5/VBAeolG1EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741279544; x=1741884344;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1tVqjEsF9yz8as4gUEJSF7TOmyvcDOBt4MIJRvQkVI=;
        b=msr2yLXqpQdFemw6+9mtN+ijsHGxpBYBOrqpLFh3+9PhLzTFC43rLGzC5zEyhhD5S2
         G7eIavtSWJpSa2DGWqH+GtdMetrN4pxIfiidrsSMpsL/i1dCgI4+XHkgrKgkg/5twAVd
         yTR1JssiewXIRrtofRUeaV7apiLh4rcABM4Kc68TLISby+SzdU2QxdgAuZOkEgUP9wMI
         f7y7fYQpQ97jH9i2VVCI5ueYdC+C6Dzxw0HN0a+eBBMwAJApL6RVHgtTYPOgqW9VBdIj
         uGeERf72b4BbPf2EHqKK7tXfQoCymg2ZU6bzsSE0yPhv22ACDGzfH2MoWbFjcBeh3BY4
         KYnw==
X-Forwarded-Encrypted: i=1; AJvYcCU16KQ/d9F6xBuEcFi73EWyrHyIiDAH2QJmZFOtMThPO/6f8uI2DHrCzcddFzlmUt71jQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7O2MVYKN9D76hG9Vy4bv7Wj4uYeEqRKXRQCoX0qcxmSsXoYes
	s+Yk84L0G5dSu3zVNmvvPdANO5B6ULC8MXfd0qSo098are66Ik6VCnW7DUXrfM8=
X-Gm-Gg: ASbGncshW6HMr7F68oLN9EcCiFUCAV1bwclFh9uP5uEYoWgSbKuAeRf2uLyEMrKs6zr
	OBHXFkSMC9YYl8HTOxKRaMmir+1YrB5rhDCYceCKKUak9jZ107Vhwmmuwp1wlT5sruBd227hJ6j
	LUrYCMMhIvOC7ehIUQUHgxGLcl2ISPH1gB6yGfi3fSZuXNOG5bKO7KMnx3BrhH+8uVQ81bk7ZGJ
	tZl2If60eY8sagqclT30SaPAfAvqQCYXXba1pMkMlFTgMP9/8YOgO/12AxXeH7fGTT8aGkfQf1P
	9apuepQzIKKJbu+h9hmiHu6BN4Y/nUp+6sxEXuxz5zXfOr3NDBR3bMpNDx7HmsNfC9N0v68iNv/
	6i9jgrJZFmTk=
X-Google-Smtp-Source: AGHT+IGQhJlPlmoVKTFjSwcpy61urGaNYqp80VZY41flaZiT4qOPtjFv0gmL/biTffVDgOSzy876LQ==
X-Received: by 2002:a05:6a00:244f:b0:736:5c8e:bab8 with SMTP id d2e1a72fcca58-73682b5510amr13251516b3a.3.1741279543956;
        Thu, 06 Mar 2025 08:45:43 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698452a28sm1570365b3a.78.2025.03.06.08.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:45:43 -0800 (PST)
Date: Thu, 6 Mar 2025 08:45:40 -0800
From: Joe Damato <jdamato@fastly.com>
To: florian@bezdeka.de
Cc: netdev@vger.kernel.org, vitaly.lifshits@intel.com,
	avigailx.dahan@intel.com, anthony.l.nguyen@intel.com,
	stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Fix XSK queue NAPI ID mapping
Message-ID: <Z8nRNJ7QmevZrKYZ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, florian@bezdeka.de,
	netdev@vger.kernel.org, vitaly.lifshits@intel.com,
	avigailx.dahan@intel.com, anthony.l.nguyen@intel.com,
	stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
References: <20250305180901.128286-1-jdamato@fastly.com>
 <796726995fe2c0e895188862321a0de8@bezdeka.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796726995fe2c0e895188862321a0de8@bezdeka.de>

On Thu, Mar 06, 2025 at 05:27:38PM +0100, florian@bezdeka.de wrote:
> Hi Joe,
> 
> On 2025-03-05 19:09, Joe Damato wrote:
> > In commit b65969856d4f ("igc: Link queues to NAPI instances"), the XSK
> > queues were incorrectly unmapped from their NAPI instances. After
> > discussion on the mailing list and the introduction of a test to codify
> > the expected behavior, we can see that the unmapping causes the
> > check_xsk test to fail:
> > 
> > NETIF=enp86s0 ./tools/testing/selftests/drivers/net/queues.py
> > 
> > [...]
> >   # Check|     ksft_eq(q.get('xsk', None), {},
> >   # Check failed None != {} xsk attr on queue we configured
> >   not ok 4 queues.check_xsk
> > 
> > After this commit, the test passes:
> > 
> >   ok 4 queues.check_xsk
> > 
> > Note that the test itself is only in net-next, so I tested this change
> > by applying it to my local net-next tree, booting, and running the test.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: b65969856d4f ("igc: Link queues to NAPI instances")
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_xdp.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c
> > b/drivers/net/ethernet/intel/igc/igc_xdp.c
> > index 13bbd3346e01..869815f48ac1 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> > @@ -86,7 +86,6 @@ static int igc_xdp_enable_pool(struct igc_adapter
> > *adapter,
> >  		napi_disable(napi);
> >  	}
> > 
> > -	igc_set_queue_napi(adapter, queue_id, NULL);
> >  	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
> >  	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> > 
> > @@ -136,7 +135,6 @@ static int igc_xdp_disable_pool(struct igc_adapter
> > *adapter, u16 queue_id)
> >  	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
> >  	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
> >  	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> > -	igc_set_queue_napi(adapter, queue_id, napi);
> > 
> >  	if (needs_reset) {
> >  		napi_enable(napi);
> 
> That doesn't look correct to me. You removed both invocations of
> igc_set_queue_napi() from igc_xdp.c. Where is the napi mapping now
> done (in case XDP is enabled)?

igc_set_queue_napi is called when the queues are created (igc_up,
__igc_open). When the queues are created they'll be linked. Whether
or not XDP is enabled does not affect the queues being linked.

The test added for this (which I mentioned in the commit message)
confirms that this is the correct behavior, as does the
documentation in Documentation/netlink/specs/netdev.yaml.

See commit df524c8f5771 ("netdev-genl: Add an XSK attribute to
queues").

> To me it seems flipped. igc_xdp_enable_pool() should do the mapping
> (previously did the unmapping) and igc_xdp_disable_pool() should do
> the unmapping (previously did the mapping). No?

In igc, all queues get their NAPIs mapped in igc_up or __igc_open. I
had mistakenly added code to remove the mapping for XDP because I
was under the impression that NAPIs should not be mapped for XDP
queues. See the commit under fixes.

This was incorrect, so this commit removes the unmapping and
corrects the behavior.

With this change, all queues have their NAPIs mapped (whether or not
they are used for AF_XDP) and is the agreed upon behavior based on
prior conversations on the list and the documentation I mentioned
above.

> Btw: I got this patch via stable. It doesn't make sense to send it
> to stable where this patch does not apply.

Maybe I made a mistake, but as far as I can tell the commit under
fixes is in 6.14-rc*:

$ git tag --contains b65969856d4f
v6.14-rc1
v6.14-rc2
v6.14-rc3
v6.14-rc4

So, I think this change is:
  - Correct
  - Definitely a "fixes" and should go to iwl-net
  - But maybe does not need to CC stable ?

If the Intel folks would like me to resend with some change please
let me know.

