Return-Path: <bpf+bounces-77394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4955CDB167
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 02:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C283430285F4
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA74280308;
	Wed, 24 Dec 2025 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mcHv79/Z"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96819F11B;
	Wed, 24 Dec 2025 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540394; cv=none; b=b1173B7VUZ264P/uvJcFfCDXf+u+NtTBn/7/XDZ00J1vPIrP+9rYHAEDwcSnttd/DHkt/DS5sQsT3qhNK1lrrzFwHoEY6t9dRZcG/8AZHBRXJv8kkzhebFsfG/feb3A6nQiYBJLrty4jpbSDgrxZiYqxb3OSRZTxczm39AZ4uy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540394; c=relaxed/simple;
	bh=ov09Ork4JNS4IuqSOtwCellFGVGIVdD3OwGE/wbPJ/0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Z2OyXeOzjLMcMxHQtikIofRQt4Z+uwiy5l1h9ikolmE/UKEb5gozYvfNRe18SRpafY+7KegsTFCPA3+SSSC0PEWPIuvR8Fbu0l14CQLPp5cPFLKKLFHDITHFy3MVaJboiKLYfaQYxcBcUSmaZJjHq4qbc6y/giqKPAFFwDH1ypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mcHv79/Z; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766540383; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=ov09Ork4JNS4IuqSOtwCellFGVGIVdD3OwGE/wbPJ/0=;
	b=mcHv79/ZS4wOYVbhJfv47Ai4pv613TDLfqJ41BXMvBzDWXGCCSowvXLppiR3c9UkKSKnvvFiDuFBBXfguQ23M0kqsTJ1aXgd2lm7gst605btH4Bc4WrB9YiuX5vIY5YeGu1D+gZSxyumIufcW2q9O67u0HKbmYT/7MyS+5KOmfU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WvZJ5Fv_1766540381 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 09:39:42 +0800
Message-ID: <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
Date: Wed, 24 Dec 2025 09:37:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 Bui Quang Minh <minhquangbui99@gmail.com>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
In-Reply-To: <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


Hi Jason,

I'm wondering why we even need this refill work. Why not simply let NAPI re=
try
the refill on its next run if the refill fails? That would seem much simple=
r.
This refill work complicates maintenance and often introduces a lot of
concurrency issues and races.

Thanks.

On Wed, 24 Dec 2025 08:52:36 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Dec 23, 2025 at 11:27=E2=80=AFPM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
> >
> > Currently, the refill work is a global delayed work for all the receive
> > queues. This commit makes the refill work a per receive queue so that we
> > can manage them separately and avoid further mistakes. It also helps the
> > successfully refilled queue avoid the napi_disable in the global delayed
> > refill work like before.
> >
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
>
> I may miss something but I think this patch is sufficient to fix the prob=
lem?
>
> Thanks
>

