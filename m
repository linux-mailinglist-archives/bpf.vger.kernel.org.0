Return-Path: <bpf+bounces-19712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB7482FFFD
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 06:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29E61F234CB
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 05:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D828BEB;
	Wed, 17 Jan 2024 05:58:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71F79CD;
	Wed, 17 Jan 2024 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705471134; cv=none; b=Nhi+kCXquq6jZTNfc0p31aZ9yELIpZbIhKOkfaa/AzWPBqboiW7uZ80KBDmYGf6380+bwW3Di2aocyeBIEHiR9XbrNtC1y/Tgdk4orhltuNAy/LEiCfjhXQJz4rWds0Z9Ow2hP1o7EnKPRsOxOQUBzffuMhdFeJeqc9oZy7uGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705471134; c=relaxed/simple;
	bh=D4KHcuCwO6TM93KeN4GQmsoxdmonylr1GPq99r0fO5E=;
	h=X-Alimail-AntiSpam:Received:Message-ID:Subject:Date:From:To:Cc:
	 References:In-Reply-To; b=rekBPYtb4MDc39oRrV3L/bmzPZ610WVXpvZYYkZp9juggdBt7QMpcKCCNS77YgD9Lk0d3bNVn9VJjLSdstz5epn9w05FlF1ghP2N5kRWB6CVmGiX4LIXxsJQeQl2qEyvYlQSFRIrCCByKs1W/tF3/L1kYPRvlGosoQzxec1PJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W-oO.HL_1705471128;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-oO.HL_1705471128)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 13:58:48 +0800
Message-ID: <1705470932.7850752-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy (3/3)
Date: Wed, 17 Jan 2024 13:55:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 "Michael S.  Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S.  Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Alexei  Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
 <e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
 <20240116070705.1cbfc042@kernel.org>
In-Reply-To: <20240116070705.1cbfc042@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 16 Jan 2024 07:07:05 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 16 Jan 2024 13:37:30 +0100 Paolo Abeni wrote:
> > For future submission it would be better if you split this series in
> > smaller chunks: the maximum size allowed is 15 patches.
>
> Which does not mean you can split it up and post them all at the same
> time, FWIW.


I hope some ones have time to reivew the other parts.
In the future, I will post one after the last one is merged.

Thanks.

