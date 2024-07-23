Return-Path: <bpf+bounces-35319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF69397DA
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085531C219E4
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3373F1386B3;
	Tue, 23 Jul 2024 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e8W9LZFt"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66626AE6;
	Tue, 23 Jul 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697713; cv=none; b=N2G2+wwKjI4yXP5rGgjGpKEEJoPjN0n5gurPrh9mjpxTvLrKExr0BT/h9bffDod63IWWvmzSSguh44ez+6DrW4VruzbZRGJ7Ul3gd+v6nh06LaQsE799ORb2x8cfkzw5yfYNDnlQsLZ8KN83oqPtWj3/JR2Lq/81Mpqi3IroXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697713; c=relaxed/simple;
	bh=sZHr2Gnel0ldBTDzDCSgwwZ5OaKWorgBIOfSH9dJHBo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ZqKbl+0XDBOpK/zWB3sH26/unlXvxm+Vs41p1qg58IzkkbOuPfzRITO5AI8+fssIPAq1aQ8ck7LsDbH8iI/IGYJFlZ32qGcnv661TWyp50DOKZ4YU5CuMVJukgeveT5ia+K4C3SqhjfnDMn49DPIQAVrjh7Ur39XiOU0xfwaD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e8W9LZFt; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721697708; h=Message-ID:Subject:Date:From:To;
	bh=sZHr2Gnel0ldBTDzDCSgwwZ5OaKWorgBIOfSH9dJHBo=;
	b=e8W9LZFtOxy1m3SoJwRGr9612PhUXxg6Sel0ErGnpLMkTw3WZFV5/Bh7vHGUo6wh+nXBlh4+vtHhLDEuKFaw6VtMhUznUlnaA+SAgNO0d6hjDCFI8mXjg331K3grpmNvsxyoNVGZPTev7075FKmBai+GezuhFooSRxyJEKP2Lqg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0WB77v12_1721697707;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WB77v12_1721697707)
          by smtp.aliyun-inc.com;
          Tue, 23 Jul 2024 09:21:48 +0800
Message-ID: <1721697638.0475743-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next 00/13] virtio-net: support AF_XDP zero copy (tx)
Date: Tue, 23 Jul 2024 09:20:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsX5CwQmrwYzosSDMRdOfYVEmaL6x0-M9fWq0whwyRwSQ@mail.gmail.com>
 <20240722174204.0eedd139@kernel.org>
In-Reply-To: <20240722174204.0eedd139@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 22 Jul 2024 17:42:04 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 22 Jul 2024 15:27:42 +0800 Jason Wang wrote:
> > I wonder why this series is tagged as "RFC"?
>
> I guess it's because net-next is closed during merge window.


YES. As I know, we can not post "PATCH" during merge window.
So, I post "RFC".

Thanks.


> I understand that the situation is somewhat special
> because we got Rx merged but not Tx.
> Do you think this is ready for v6.11 with high confidence?

