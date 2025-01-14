Return-Path: <bpf+bounces-48838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA71A11064
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 19:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6B188AC55
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E71FC112;
	Tue, 14 Jan 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJu9powr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC2F1F9EB3
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880213; cv=none; b=DaH8RfGtpAzdq0zGMcqSVQZJEQlArZ+C3++hPWITZ4RE/HEjxKbPZBcETae11eoCWAJ1nMtDZd5C9hpb8dvWiYj4pejHXnc+iuQczvA76q2zg8kh7+te+vK6rG1qmBz/yuY1gQ2Wb7PWuBqTJk2HD27HApsMAskThnZBNVjFFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880213; c=relaxed/simple;
	bh=wJZZ0cwCSEQ2mts2sXIW9goT38hLDXXYRIJC7LGOT38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqMqT1abMGFGFB5FVU+nY6b0foy5t6yVBA52jIdEs/ShYXu9ZNrNOhsSOHPkBDa9bE8Zk70Wedhu3PUGF+1aGJln3ISuw9zYZBum1ZPvoWmM9fDzS64eFDQ+dJQaOdd401AXlr66zEFd32vUSSxbWMo9N++ENBESK1bvumrWdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJu9powr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436249df846so40870665e9.3
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736880210; x=1737485010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbd7D0Czmr9vCgKgM6FC/ck4MWSPttymXy3sW5wVy50=;
        b=VJu9powrlR0T/nEAPd2znsnI3aPcD7EA/PSxh1ZdR7j+pyjmufd1i8KvgjREa0OF9K
         Io1gl7B0z3DyBpiBS8J/B/HqtPdkg1I/qzz6ggvYzdVgqI1wTU+u8tTYkDJhfuDcZIR+
         2HOJnZWSHVBroLVyyYtY5HLgVBh+BhucWkcuHTACJLulCTtrtRmFIfLVk7cC4pNP6tck
         tUBzWkCRqdcrlxlCg99mFmTbxw0DXu7dda7qpcvBExNn1RAYe3V1tXfFdN9s9naQYZw2
         eRwoDiKCfEIL/nvvaHyzhjXd2rB8Smz8DbFU/JQEz5S3tkqEQlwKaArvjAOTyfbCWY3J
         bV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736880210; x=1737485010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbd7D0Czmr9vCgKgM6FC/ck4MWSPttymXy3sW5wVy50=;
        b=lSKpOv4NJKwGeCKIT7HUa4kc/SUAdYN+S26scJR1bUfLnpPi1mRqW8KyFL/FsuG66W
         sRvpTYHmHI5K+Ztw30YTW3f862jxPwVTvMNwB75I+YjH/mwx0vBwumJUCe107c42Ue/A
         93OYzEMLymDHo8Oys9WAvSgfyrMVABZq1eVzO/qDxWBC/xo0Vx7lXctn9CbsKw1V0E92
         ErqxOilwikh2tWJSH35hGGlCdecKqdnNlmW7P6NJuMtacGNKzEc5Mf671MhKgPkES/rz
         CXqkqDG0ArFsWvXBj1juP4V+8a+xfGwkJwt7AlNPwJXECMAslJGiX9W0JfUSMmQB/BPC
         1c6g==
X-Forwarded-Encrypted: i=1; AJvYcCXZSgLWgdtLvjU6Q6UjlJ5ho7dF1omHQDRIwzSzUoqWIZBPKP0fvWuC7FhfPRoDWKmU8KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnFFnXP8hKHUsMcRjVHebPwsmb/Wn7ovVHkq+ux37bckId76z
	Wxn27a1QKesfFZQhvyGS19ZUXSXip+h0IHi54Es6o6w/4K1+f1fB4fEPKRRy4Ec=
X-Gm-Gg: ASbGncvwdyQ8RXhGK2CaXBAscY+6HKPFpBTrxXlOa6OJ/mFWkOG4S/eE+7i/4o7NfGW
	uEYLvye/g68E1l7DvrbzNFOyYIBql9bLEQLaUc6aRZWuJtTG4xXEJ5JxCRGyGhIHkpvtSH2WZgC
	t1uaETIbd41wHLtIDXhN/kIoCC57Grb17UV14CRKUQYttB1QDdbDhQHNI9dj4Hdi8Obamz/+abH
	gUHUAgAZWDWOTO726S0450cg3ALXdJAOQDzCwtOY6jlXcaShK9OqGK38M8o3g==
X-Google-Smtp-Source: AGHT+IGD+NGu7We6kljAPJX0zi3pW7lKGhqM/7LhyfHIle3wv3K3ReYl5kCmvw+JLRJYw4gVRDI+zA==
X-Received: by 2002:a05:600c:1c28:b0:434:a734:d268 with SMTP id 5b1f17b1804b1-436e2699dfbmr266852295e9.14.1736880210230;
        Tue, 14 Jan 2025 10:43:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62133sm183786065e9.33.2025.01.14.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:43:29 -0800 (PST)
Date: Tue, 14 Jan 2025 21:43:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Quentin Monnet <qmo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] nfp: bpf: prevent integer overflow in
 nfp_bpf_event_output()
Message-ID: <487897df-7a82-4c36-8dcf-13d1704f479d@stanley.mountain>
References: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
 <1ba87a40-5851-4877-a539-e065c3a8a433@intel.com>
 <Z4ZAMCRQW8iiYXAb@stanley.mountain>
 <ae4d008f-8a70-4c0d-a5c8-c480cad53cf5@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4d008f-8a70-4c0d-a5c8-c480cad53cf5@intel.com>

On Tue, Jan 14, 2025 at 06:17:22PM +0100, Alexander Lobakin wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Date: Tue, 14 Jan 2025 13:45:04 +0300
> 
> > [ I tried to send this email yesterday but apparently gmail blocked
> >   it for security reasons?  So weird. - dan ]
> > 
> > On Mon, Jan 13, 2025 at 01:32:11PM +0100, Alexander Lobakin wrote:
> >> From: Dan Carpenter <dan.carpenter@linaro.org>
> >> Date: Mon, 13 Jan 2025 09:18:39 +0300
> >>
> >>> The "sizeof(struct cmsg_bpf_event) + pkt_size + data_size" math could
> >>> potentially have an integer wrapping bug on 32bit systems.  Check for
> >>
> >> Not in practice I suppose? Do we need to fix "never" bugs?
> >>
> > 
> > No, this is from static analysis.  We don't need to fix never bugs.
> > 
> > This is called from nfp_bpf_ctrl_msg_rx() and nfp_bpf_ctrl_msg_rx_raw()
> > and I assumed that since pkt_size and data_size come from skb->data on
> > the rx path then they couldn't be trusted.
> 
> skbs are always valid and skb->len could never cross INT_MAX to provoke
> an overflow.
> 

True but unrelated.  I think you are looking at the wrong code...

drivers/net/ethernet/netronome/nfp/bpf/offload.c
   445  int nfp_bpf_event_output(struct nfp_app_bpf *bpf, const void *data,
                                                                      ^^^^
This code comes from the network so it cannot be trusted.

   446                           unsigned int len)
   447  {
   448          struct cmsg_bpf_event *cbe = (void *)data;
                                       ^^^^^^^^^^^^^^^^^^^
It is cast to a struct here.

   449          struct nfp_bpf_neutral_map *record;
   450          u32 pkt_size, data_size, map_id;
   451          u64 map_id_full;
   452  
   453          if (len < sizeof(struct cmsg_bpf_event))
   454                  return -EINVAL;
   455  
   456          pkt_size = be32_to_cpu(cbe->pkt_size);
   457          data_size = be32_to_cpu(cbe->data_size);

pkt_size and data_size are u32 values which are controlled from
over the network.

   458          map_id_full = be64_to_cpu(cbe->map_ptr);
   459          map_id = map_id_full;
   460  
   461          if (len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
On a 32bit system, then this math can overflow.  The pkt_size and
data_size are too high and we should return -EINVAL but this check
doesn't work because of integer wrapping.

   462                  return -EINVAL;
   63          if (cbe->hdr.ver != NFP_CCM_ABI_VERSION)
   464                  return -EINVAL;
   465  
   466          rcu_read_lock();
   467          record = rhashtable_lookup(&bpf->maps_neutral, &map_id,
   468                                     nfp_bpf_maps_neutral_params);
   469          if (!record || map_id_full > U32_MAX) {
   470                  rcu_read_unlock();
   471                  cmsg_warn(bpf, "perf event: map id %lld (0x%llx) not recognized, dropping event\n",
   472                            map_id_full, map_id_full);
   473                  return -EINVAL;
   474          }
   475  
   476          bpf_event_output(record->ptr, be32_to_cpu(cbe->cpu_id),
   477                           &cbe->data[round_up(pkt_size, 4)], data_size,
                                            ^^^^^^^^^^^^^^^^^^^^^
Here we are way out of bounds with regards to the cbe->data[] array.

regards,
dan carpenter

   478                           cbe->data, pkt_size, nfp_bpf_perf_event_copy);
   479          rcu_read_unlock();
   480  
   481          return 0;
   482  }


