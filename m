Return-Path: <bpf+bounces-63241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41560B047B4
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228AD1A673DD
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4593260565;
	Mon, 14 Jul 2025 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTCwD1sV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F5277003
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519902; cv=none; b=momsUN24WIhukg3V/dW6PTT1wq8tdKLsd2ho5Z9RFT4SdWt5CAc7W9Uom0Vc1v8EYRZQN5M7Xd6bmGRmFb8UJZI0yozitZffY53ut8tvhilVJroay2SsU1rpR1+VaMuAN2htgGStbdYA68NgtAVVDIv835VCziiWfBNKRHGBuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519902; c=relaxed/simple;
	bh=q+olkIxO6QSEQI4AAJlhbaSdpfzA/5MYP0ugPj8Pg54=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mCo+0sjCX/GgjSItmxbhlAW0q8vFvM3SikTCbjW7SxQdzB2FoCMhvkAj+TLc9xKc6d0etv45Gnt0LSE1srSOr6Nl8yi9sxidRfbpYly+nNEd5AMXTG75B1ljLTh4ABBofjfzLc/nrmsDEC6FNq6QhdGDgw7CUpPomNO56qJ+85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sTCwD1sV; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-41b4bf6ead9so261895b6e.3
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752519899; x=1753124699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BdAiWES77XaDLnO1vrNoocWtjPZ3jZaAJoidOert7wA=;
        b=sTCwD1sVSnftV5hJjV8nFHfLb4mon1BUI16mKTCnYmtsyTmntOioiWqOo/rtCdH2rI
         GkUHmxMPYJYEJ2OpcdMV7uZIxtUMAPZDdGVl80ymcZPY5NjwvfMSf5/lMWhqIcMqWPLL
         DrTMXQPSzYHUtVrJbMizG11FocMlG5tTx43NKmQr4PtmjHGKjPuVx/jjW5FJDvJrcc8o
         KP7jJfxad7TvkbV8auzqpNgnlVr+QgVwtlP5ruH7MOig/f7nknRhEtSneFv5ShiNFNUJ
         mHnGlkspSxfvb43+eRM7nxZ5xIjF0VPA1+nm3Ez7Q9suQQEMr2pXbm18D6bkn5wZihCP
         YxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519899; x=1753124699;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdAiWES77XaDLnO1vrNoocWtjPZ3jZaAJoidOert7wA=;
        b=aqzMtbiMvBeWQ6iGCIxXI6xflZh6gcZUwAupx6yk0s3lvvrmkDsmP0SJ2QEmcq43BZ
         9niVuEXOpM25aO7VdS1VTr6O+evwt1q0FqVtnerNj5v1WHy530dk+iEcSx/FhV9iPGKf
         sLOJ1JdrFhKKphLZV0UY2MfxsdP04xsAR6H1tbnokuvQmwTncWRYpzIZxAW96E7cWEVL
         FTayw0znIUWo9NXboObJBaUswgfIiRDFhHAq9+Q3rG8Mi5SuCCv1vgZ114Dm+S+GpBFp
         nEbgsL+iPjFAHZ3wzFVm5wGjqNAy2MkjRpPcQcsY9weWU/ORLWmOIZ8GECX7U+9idzPS
         vP0A==
X-Forwarded-Encrypted: i=1; AJvYcCXdlTBWI4J6Os6UQPrL9mTQ9UiubNLo4sqP3S3hg7XA+a66J4cG6RB/oYpaOh6Cdnxs6xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsG/UkIL0tCDw/pOwJ7/p5Z9UO3MYkOpXbClCN0ViMUUqB5fHb
	9mdyfWQ4NSboE/88tccvonJ/T3lEzJIpZWUxXDx31UNscxqCNs7TUDUoaLf6WeusyJY=
X-Gm-Gg: ASbGncsZH2kbeQGoYSnnWEz3W1/3y7JNgSITPFHcAKF7KxLIf+KzMJ/vzp3IMjP/EoB
	4K0C10UeiyxmSXlIOHOeumh1kgYu/aoCC41c+5HztL2omomdQKm8c22OSCcak7UCI7NNPMFsjMm
	Jf7IL+2Bvcx24Qs4Ba6MhgnYsZrbsRsLCFJVThIlYOtwHaVTped+6hv5oTCte7grmQBaY9Y/Gry
	vgoVo3AJgeW/q5EG04RoVIgCq2/Nnb+9P1jJRrHMJHMh2AqxOXruhoVbyGt+mn+8mvrEPR09DuU
	X0NM8w2nEq/WC0MXjT84Yh6LbJw3mOZmGR0nwkPwyLmg+EZPttMfAQze69WMpWkeWEcXQsqHdNT
	gQptrvxtesqfecEfVuiA/GrLgLxcVfLH3jh/qokPZ
X-Google-Smtp-Source: AGHT+IG9VB44/JBXZgU5GVNb+6d0g32N/Qwu1+N9nXvPuxbsMeajY2PfOx1sKYCIufDjdIs+/yM6kg==
X-Received: by 2002:a05:6808:4f63:b0:408:fb4c:859e with SMTP id 5614622812f47-4150d745cfcmr9800740b6e.6.1752519899258;
        Mon, 14 Jul 2025 12:04:59 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-414196c9b24sm1580366b6e.17.2025.07.14.12.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:04:58 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:04:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, stfomichev@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v2 bpf] xsk: fix immature cq descriptor production
Message-ID: <440ed42e-16d5-4b00-9402-1f26d73715d4@suswa.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xsk-fix-immature-cq-descriptor-production/20250705-215714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20250705135512.1963216-1-maciej.fijalkowski%40intel.com
patch subject: [PATCH v2 bpf] xsk: fix immature cq descriptor production
config: x86_64-randconfig-r071-20250706 (https://download.01.org/0day-ci/archive/20250706/202507061447.DwFSGum1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507061447.DwFSGum1-lkp@intel.com/

smatch warnings:
net/xdp/xsk.c:819 xsk_build_skb() warn: passing zero to 'ERR_PTR'

vim +/ERR_PTR +819 net/xdp/xsk.c

9c8f21e6f8856a Xuan Zhuo                 2021-02-18  689  static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  690  				     struct xdp_desc *desc)
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  691  {
48eb03dd26304c Stanislav Fomichev        2023-11-27  692  	struct xsk_tx_metadata *meta = NULL;
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  693  	struct net_device *dev = xs->dev;
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  694  	struct xsk_addrs *addrs = NULL;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  695  	struct sk_buff *skb = xs->skb;
48eb03dd26304c Stanislav Fomichev        2023-11-27  696  	bool first_frag = false;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  697  	int err;
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  698  
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  699  	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  700  		skb = xsk_build_skb_zerocopy(xs, desc);
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  701  		if (IS_ERR(skb)) {
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  702  			err = PTR_ERR(skb);
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  703  			goto free_err;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  704  		}
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  705  	} else {
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  706  		u32 hr, tr, len;
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  707  		void *buffer;
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  708  
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  709  		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  710  		len = desc->len;
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  711  
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  712  		if (!skb) {
0c0d0f42ffa6ac Felix Maurer              2024-11-14  713  			first_frag = true;
0c0d0f42ffa6ac Felix Maurer              2024-11-14  714  
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  715  			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  716  			tr = dev->needed_tailroom;
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  717  			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  718  			if (unlikely(!skb))
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  719  				goto free_err;
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  720  
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  721  			skb_reserve(skb, hr);
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  722  			skb_put(skb, len);
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  723  
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  724  			err = skb_store_bits(skb, 0, buffer, len);
0c0d0f42ffa6ac Felix Maurer              2024-11-14  725  			if (unlikely(err))
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  726  				goto free_err;
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  727  
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  728  			addrs = kzalloc(sizeof(*addrs), GFP_KERNEL);
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  729  			if (!addrs)
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  730  				goto free_err;

err is not set on this path.

regards,
dan carpenter

67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  731  
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  732  			xsk_set_destructor_arg(skb, addrs);
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  733  
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  734  		} else {
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  735  			int nr_frags = skb_shinfo(skb)->nr_frags;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  736  			struct page *page;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  737  			u8 *vaddr;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  738  
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  739  			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
9d0a67b9d42c63 Tirthendu Sarkar          2023-08-23  740  				err = -EOVERFLOW;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  741  				goto free_err;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  742  			}
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  743  
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  744  			page = alloc_page(xs->sk.sk_allocation);
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  745  			if (unlikely(!page)) {
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  746  				err = -EAGAIN;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  747  				goto free_err;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  748  			}
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  749  
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  750  			vaddr = kmap_local_page(page);
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  751  			memcpy(vaddr, buffer, len);
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  752  			kunmap_local(vaddr);
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  753  
2127c604383666 Sebastian Andrzej Siewior 2024-02-02  754  			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
2127c604383666 Sebastian Andrzej Siewior 2024-02-02  755  			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  756  		}
48eb03dd26304c Stanislav Fomichev        2023-11-27  757  
48eb03dd26304c Stanislav Fomichev        2023-11-27  758  		if (first_frag && desc->options & XDP_TX_METADATA) {
48eb03dd26304c Stanislav Fomichev        2023-11-27  759  			if (unlikely(xs->pool->tx_metadata_len == 0)) {
48eb03dd26304c Stanislav Fomichev        2023-11-27  760  				err = -EINVAL;
48eb03dd26304c Stanislav Fomichev        2023-11-27  761  				goto free_err;
48eb03dd26304c Stanislav Fomichev        2023-11-27  762  			}
48eb03dd26304c Stanislav Fomichev        2023-11-27  763  
48eb03dd26304c Stanislav Fomichev        2023-11-27  764  			meta = buffer - xs->pool->tx_metadata_len;
ce59f9686e0eca Stanislav Fomichev        2023-11-27  765  			if (unlikely(!xsk_buff_valid_tx_metadata(meta))) {
ce59f9686e0eca Stanislav Fomichev        2023-11-27  766  				err = -EINVAL;
ce59f9686e0eca Stanislav Fomichev        2023-11-27  767  				goto free_err;
ce59f9686e0eca Stanislav Fomichev        2023-11-27  768  			}
48eb03dd26304c Stanislav Fomichev        2023-11-27  769  
48eb03dd26304c Stanislav Fomichev        2023-11-27  770  			if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
48eb03dd26304c Stanislav Fomichev        2023-11-27  771  				if (unlikely(meta->request.csum_start +
48eb03dd26304c Stanislav Fomichev        2023-11-27  772  					     meta->request.csum_offset +
48eb03dd26304c Stanislav Fomichev        2023-11-27  773  					     sizeof(__sum16) > len)) {
48eb03dd26304c Stanislav Fomichev        2023-11-27  774  					err = -EINVAL;
48eb03dd26304c Stanislav Fomichev        2023-11-27  775  					goto free_err;
48eb03dd26304c Stanislav Fomichev        2023-11-27  776  				}
48eb03dd26304c Stanislav Fomichev        2023-11-27  777  
48eb03dd26304c Stanislav Fomichev        2023-11-27  778  				skb->csum_start = hr + meta->request.csum_start;
48eb03dd26304c Stanislav Fomichev        2023-11-27  779  				skb->csum_offset = meta->request.csum_offset;
48eb03dd26304c Stanislav Fomichev        2023-11-27  780  				skb->ip_summed = CHECKSUM_PARTIAL;
11614723af26e7 Stanislav Fomichev        2023-11-27  781  
11614723af26e7 Stanislav Fomichev        2023-11-27  782  				if (unlikely(xs->pool->tx_sw_csum)) {
11614723af26e7 Stanislav Fomichev        2023-11-27  783  					err = skb_checksum_help(skb);
11614723af26e7 Stanislav Fomichev        2023-11-27  784  					if (err)
11614723af26e7 Stanislav Fomichev        2023-11-27  785  						goto free_err;
11614723af26e7 Stanislav Fomichev        2023-11-27  786  				}
48eb03dd26304c Stanislav Fomichev        2023-11-27  787  			}
ca4419f15abd19 Song Yoong Siang          2025-02-16  788  
ca4419f15abd19 Song Yoong Siang          2025-02-16  789  			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
ca4419f15abd19 Song Yoong Siang          2025-02-16  790  				skb->skb_mstamp_ns = meta->request.launch_time;
48eb03dd26304c Stanislav Fomichev        2023-11-27  791  		}
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  792  	}
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  793  
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  794  	skb->dev = dev;
10bbf1652c1cca Eric Dumazet              2023-09-21  795  	skb->priority = READ_ONCE(xs->sk.sk_priority);
3c5b4d69c358a9 Eric Dumazet              2023-07-28  796  	skb->mark = READ_ONCE(xs->sk.sk_mark);
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  797  	skb->destructor = xsk_destruct_skb;
48eb03dd26304c Stanislav Fomichev        2023-11-27  798  	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  799  
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  800  	addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  801  	addrs->addrs[addrs->num_descs++] = desc->addr;
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  802  
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  803  	return skb;
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  804  
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  805  free_err:
0c0d0f42ffa6ac Felix Maurer              2024-11-14  806  	if (first_frag && skb)
0c0d0f42ffa6ac Felix Maurer              2024-11-14  807  		kfree_skb(skb);
0c0d0f42ffa6ac Felix Maurer              2024-11-14  808  
9d0a67b9d42c63 Tirthendu Sarkar          2023-08-23  809  	if (err == -EOVERFLOW) {
9d0a67b9d42c63 Tirthendu Sarkar          2023-08-23  810  		/* Drop the packet */
67a37dcecabbf0 Maciej Fijalkowski        2025-07-05  811  		xsk_inc_skb_descs(xs->skb);
9d0a67b9d42c63 Tirthendu Sarkar          2023-08-23  812  		xsk_drop_skb(xs->skb);
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  813  		xskq_cons_release(xs->tx);
9d0a67b9d42c63 Tirthendu Sarkar          2023-08-23  814  	} else {
9d0a67b9d42c63 Tirthendu Sarkar          2023-08-23  815  		/* Let application retry */
e6c4047f512280 Maciej Fijalkowski        2024-10-07  816  		xsk_cq_cancel_locked(xs->pool, 1);
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  817  	}
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19  818  
cf24f5a5feeaae Tirthendu Sarkar          2023-07-19 @819  	return ERR_PTR(err);
9c8f21e6f8856a Xuan Zhuo                 2021-02-18  820  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


