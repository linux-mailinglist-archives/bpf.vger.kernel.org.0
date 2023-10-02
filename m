Return-Path: <bpf+bounces-11231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325B7B5CFC
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 00:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 77A012815BD
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C82208B0;
	Mon,  2 Oct 2023 22:03:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840220326;
	Mon,  2 Oct 2023 22:03:43 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431CFB0;
	Mon,  2 Oct 2023 15:03:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-50481a0eee7so4458956e87.0;
        Mon, 02 Oct 2023 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696284219; x=1696889019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GcfuhtzVzjDNtRj4QA4ePrsnxqf+lMTsaZP4TTaHfSU=;
        b=MFEDMVdNc7YtftIMAShxWK9aeBcfDO8gO8Kjr7+MIK6L5FN8bIafBXUA3FBAGaC03q
         APElRAvzAv05jIiJNk58lWPQQ97no06OT9R7yhCFlmVLykrOGim6uT2PjP/xVbL0roY/
         R4VszKp4/6uRTEGcIWNscsXqnvYqMEcAVBwuHxaGrM4VgpmF+A175leB2j04UXYzkiLp
         z6GgkdellbB+ckI/aCcToFtXI2Cs5mFmgWaK5HzP8uAy4RHFyLm2INN3FVqP93EZqe0l
         0SHzgtFg/zh1qAjb+w7zZpCG8D7yryEU/55Li5Q15iITZ6SMdl0oBa/Au7TAAgZBI93/
         i5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696284219; x=1696889019;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcfuhtzVzjDNtRj4QA4ePrsnxqf+lMTsaZP4TTaHfSU=;
        b=HBiH51ysoC4N/oO5c/Sx4XolAUBr7UNBBlur80ByoIHKMCC77JTC1EpVyEC5TOcSgE
         9nwDmgWMU41Id1iHa4r2fYV8J+Hw+CDX7pThvef3+IUevToXSyEDhVKmq5HGqaDfMyTu
         Nq92H6kWx6NaQYTwc/3Zd/5/9YpjgUa1edwI3gqGV524OVAmKds0bs/z7f7/vRBj5POK
         9NiOaDGts064qhI8q3YBrs5/QDMDgVcSHNKW6gbPg+w23mpnBll5vQGq6+D8WbijqUIp
         RNPuOuO9LXRrNBHmMNAog745qUJzx/9fJVxSkBUWBulrio3LPw+8J9qPuDH6x5vSZTN9
         FlJw==
X-Gm-Message-State: AOJu0Yx6n923aT1f6q3sQXln0Di2bZn7SZyvJ0/rdz3h4Nkn3+by+7a+
	1zVB2Kmyyi/R9Ug4b8CjR2E=
X-Google-Smtp-Source: AGHT+IEAgHJlYSsgmnfK4UkrJFaksI3FPfgxhdP0pFjvKUKbN9WNfKQ7eecVA+Ftm1fOyG812fGfGA==
X-Received: by 2002:ac2:4577:0:b0:4fe:4896:b6ab with SMTP id k23-20020ac24577000000b004fe4896b6abmr708500lfm.15.1696284219160;
        Mon, 02 Oct 2023 15:03:39 -0700 (PDT)
Received: from akanner-r14. ([77.222.24.78])
        by smtp.gmail.com with ESMTPSA id w9-20020ac25989000000b005057781cee2sm1212429lfn.264.2023.10.02.15.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 15:03:38 -0700 (PDT)
Message-ID: <651b3e3a.c20a0220.a0ffe.58a3@mx.google.com>
X-Google-Original-Message-ID: <ZRs+NzP9sL5jbhad@akanner-r14.>
Date: Tue, 3 Oct 2023 01:03:35 +0300
From: Andrew Kanner <andrew.kanner@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v1] net/xdp: fix zero-size allocation warning in
 xskq_create()
References: <000000000000c84b4705fb31741e@google.com>
 <20230928204440.543-1-andrew.kanner@gmail.com>
 <2165e4a3-a717-f715-f7c3-e520d45ec21c@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2165e4a3-a717-f715-f7c3-e520d45ec21c@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 03:52:44PM +0200, Alexander Lobakin wrote:
> From: Andrew Kanner <andrew.kanner@gmail.com>
> Date: Thu, 28 Sep 2023 23:44:40 +0300
> 
> > Syzkaller reported the following issue:
> 
> [...]
> 
> > PS: the initial number of entries is 0x20000000 in syzkaller repro:
> > syscall(__NR_setsockopt, (intptr_t)r[0], 0x11b, 3, 0x20000040, 0x20);
> > 
> > Link: https://syzkaller.appspot.com/text?tag=ReproC&x=10910f18280000
> > 
> >  net/xdp/xsk_queue.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
> > index f8905400ee07..1bc7fb1f14ae 100644
> > --- a/net/xdp/xsk_queue.c
> > +++ b/net/xdp/xsk_queue.c
> > @@ -34,6 +34,9 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
> >  	q->ring_mask = nentries - 1;
> >  
> >  	size = xskq_get_ring_size(q, umem_queue);
> > +	if (size == SIZE_MAX)
> 
> unlikely().
> 
> > +		return NULL;
> > +
> >  	size = PAGE_ALIGN(size);
> >  
> >  	q->ring = vmalloc_user(size);
> 
> Thanks,
> Olek

Thanks, Olek.
That is a reasonable optimization, I'll add it in v2.

--
pw-bot: cr

Andrew Kanner

