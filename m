Return-Path: <bpf+bounces-32035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DF390620F
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F22B1C20D97
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7566C12BF18;
	Thu, 13 Jun 2024 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xqkh5nw0"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCA84055;
	Thu, 13 Jun 2024 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246400; cv=none; b=dpLA2WEv+fGzLKdKfMMiiNijAUc4KhGoHd93ZMWjOGwmRKKy9X6tEI7jNCZEGzxb+tuntsWz8hM2ai5PXb1BhKwPWvmTYvoPuBLLb/6mQsNv226Ohjg4BZTZC++1XbbSlAlSSqo17/Dj2znu1xxdVd4zDNazVCBGDL0RZzTJDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246400; c=relaxed/simple;
	bh=1MQ1Fp6HjbgootLBn8zZmwvHuRc7XlhiqbCjKSbPafA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=bjGjIiDGD7jIH1nuJmuBJoplKtwOui//KoN9B+CPw9YCoSKQtO04QcWd30OtfMUzzZIbnJlt/Sk0N/FIB93gN7/DPBQiGYsrmg49Q4hGf6f8QXKmH5XXPQFtT9W85zOIhGr9wVxsJusv6k14LZA+bmeXU5BQylZ0phKnmNhb/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xqkh5nw0; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718246395; h=Message-ID:Subject:Date:From:To;
	bh=tEcZiFuzzMApnaL1rj8g8wA1o3mOqOt7+2FRZmiJQpA=;
	b=xqkh5nw0W3Ai3Yb9cOXMTdzbvABN++TKN1bUJ0/PCXJc7kUeksBWZfWAQLGr4lv7yMl2inpmlSfwOR+wYryJCe713lgSNEznZhSPabMQGaglbBs6TZ2S6QCUOLxF9KMQsgQrCQJBYIJU8+Dq74LhiXU2ZmIGHgajURvq7aws1pk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8MQWMo_1718246394;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8MQWMo_1718246394)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 10:39:54 +0800
Message-ID: <1718246386.8347378-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 08/15] virtio_net: sq support premapped mode
Date: Thu, 13 Jun 2024 10:39:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-9-xuanzhuo@linux.alibaba.com>
 <20240612162337.137994bb@kernel.org>
In-Reply-To: <20240612162337.137994bb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 12 Jun 2024 16:23:37 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 11 Jun 2024 19:41:40 +0800 Xuan Zhuo wrote:
> > +static int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
>
> Could you try to add __maybe_unused or some such and then remove it
> in the patch which calls this function?  Having warnings during
> bisection is not great.


Will do.

Thanks.

