Return-Path: <bpf+bounces-22547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3421C860883
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 02:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6011F246DE
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 01:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71AB670;
	Fri, 23 Feb 2024 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nLtbP1dv"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00095C14F;
	Fri, 23 Feb 2024 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653048; cv=none; b=S9cOo8TjJWehCkO2EF/ptPZnBWY6yTlINr0LgEH7/mUyby6/Tg8aOvVZGPYARAESJtCs7htIzyuntp8u+2iQVBPzuzxPkjssEyTFl2TeqS2u5qMpWKCWQVQfdU6DVkTFjCvy8b2omzVjCiG1lAkW4wigFAE6citn1tbucyCYer4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653048; c=relaxed/simple;
	bh=WUvQfUI7lKeFwecJH+4aBo8NAOgyOfNRfH06TTR6lCs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=LlwZv1CnbfWT6GZ1Gjx3NqxOiASUWaGfctAEXx8gWOPQCYKG/kAqMmP9Ftux8oKsOM2wgJ3KbTh/6NfZJfb9Fs6VXmC1Q/pJY8FloYGZhvhMhCImmrRNC5URHdsN9+9nzsgi7FaiJdsvSdCjkSee9O6lXCHu0NyrhBDNevAvVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nLtbP1dv; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708653037; h=Message-ID:Subject:Date:From:To;
	bh=WUvQfUI7lKeFwecJH+4aBo8NAOgyOfNRfH06TTR6lCs=;
	b=nLtbP1dvuyWJmUWNFyqHPUZ2g4bH2hqkvYThnTRdimeZXFWUsOppoHZ364dtfvIDXTMKnGWnmPyTA6q6lX8LS0Om4IXFixUu7k6jLRi3MCsoKmEsoHhQV5XgibktPkIsW5ZuT+mOqK9L/O/ZFPtkWKxAb6Xe8wKua6Q4mZKdGyc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W12WM7U_1708653036;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W12WM7U_1708653036)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 09:50:37 +0800
Message-ID: <1708653008.6983442-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
Date: Fri, 23 Feb 2024 09:50:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <20240222144420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240222144420-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 22 Feb 2024 14:45:08 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Jan 16, 2024 at 03:59:19PM +0800, Xuan Zhuo wrote:
> > This is the second part of virtio-net support AF_XDP zero copy.
>
> My understanding is, there's going to be another version of all
> this work?

YES.

http://lore.kernel.org/all/20240202093951.120283-1-xuanzhuo@linux.alibaba.com

Thanks


>
> --
> MST
>

