Return-Path: <bpf+bounces-30891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D27028D4410
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 05:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E81E288076
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 03:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B65647B;
	Thu, 30 May 2024 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFbOERoM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CD51C5A
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039511; cv=none; b=TeyQba9hcmBlVgL2nlXmPc0/9YfjBr4JlZNEu3GBKQwaH96ci5mqGooyWtkMn8cie4YSYYdol4XIV3f3YDv0HGi3Qs1OWgucsSKBjQJr2c8TkI1VP43R2aLNGdKk4RJz9CdYmhO0VJJuKRqRDsJosgakm5/c8uHD4bXuiSIu++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039511; c=relaxed/simple;
	bh=gvyjZd5IaiTDWjDUYVA8c6LUGBpslShBCIPBi4+02T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIoeAuc0YOaDiKQboTMI1WHKVgIs8cJWOvz16QY7Sc+RVNhqTzbmcmGs7n6cujfH8JO/fjlGtcrp7qlxm8NeVnMq9NwD2Hf36liPLxsv242ISrSYaUIk5UGyNC6Vhd94RzxjbkOMOe4z1JKTnJCWFrQIqYOQDlq2HVLoNYu6eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFbOERoM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvyjZd5IaiTDWjDUYVA8c6LUGBpslShBCIPBi4+02T8=;
	b=gFbOERoMGcfFjcdZXZxy671jrTygupA+LZCzzUyZtlpk+DUZoY8VuiLTji/N1hUVInR+dO
	bsQAgU9A/z97zJvENwj68/TbcQbtAKWLHWQaSokPIZq2+kpuuC9wJ/ty3GJWgYM3PuPeqQ
	QOur2Nf7j8BUs87bUiZAvz3x5Uc/TMg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-HC3ZN_upNb-x4eGRaba2YQ-1; Wed, 29 May 2024 23:25:07 -0400
X-MC-Unique: HC3ZN_upNb-x4eGRaba2YQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c1ab9e588dso397243a91.3
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 20:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039506; x=1717644306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvyjZd5IaiTDWjDUYVA8c6LUGBpslShBCIPBi4+02T8=;
        b=kZkq8eLN/ljZPt4ttP1Jijy+DLvNIabN6jIqJH7uie3BbVpufIWK6t8Hf3rtCvT12c
         NWWLhYyMnA1ph5ic42+BMGziyPWS1YS50h74F/a/7EWRglZ+u1p5ivzJFKvwvdrjL7vI
         hKD9lbDTLAJ9h8ABgePChyMFf6VXsHjnXQ77689s5PrpwXU/82kwRkWxN8r4Qu6bxJ5K
         rUVygUnTrp1EXiY0b9oMEOaSFjHUxUkYuhzQBX270e4ISwXhkqOesdsWdSpX2+qKUoqB
         Scx+chlnyZKJasS3OOmoLDw/8ymhgiWe8d+gr5rfWwo8Rjwn8kpI99tlNqMCTEUg7G4X
         +FPg==
X-Forwarded-Encrypted: i=1; AJvYcCVlq937EZshp+pSYiKUVwt2XMBYQoqcZ/t7VCMVxz2fzgFMHoce/EBS6vmkFe828k1gxP3iBi45Zw9aCYfDyinAfrDI
X-Gm-Message-State: AOJu0YxqvzHD2r2sI9qnx5SIJpV9ETEDQ1AY6aG0TQjPjMzBDBV1iAYU
	ngw2J3KCvOkJE1K1mUOohLvBJWMfH/4IisbplaJBNmdhrcWizj9gLiWH0p2tEjZfnl9fXQpIzMY
	m/pYctmwRF29OwaGtbXusRrY1UgWVBpWUlqhBPZoeTkXX8uZ9whLjFoArJwV33LgmjKDyUFeMhP
	aFhFX7XUVU1qSBJJGeUGXzuBEaO9qyW83T
X-Received: by 2002:a17:90b:360f:b0:2bf:8824:c043 with SMTP id 98e67ed59e1d1-2c1ab9fb68dmr1011592a91.18.1717039505527;
        Wed, 29 May 2024 20:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG96xKooU/90RmHTSiFiV3oOPsdUF20/3dw7DdogIGRjKcpmQnv/lRyL3JORNQzenL8VZoz7eZ4oHhGnDiVoTc=
X-Received: by 2002:a17:90b:360f:b0:2bf:8824:c043 with SMTP id
 98e67ed59e1d1-2c1ab9fb68dmr1011570a91.18.1717039505002; Wed, 29 May 2024
 20:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <20240508080514.99458-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:24:53 +0800
Message-ID: <CACGkMEswH8X0utO-ORZ8g-4UELfhxxDxdAaycwxUdVR2uxw_ww@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] virtio_net: separate receive_buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This commit separates the function receive_buf(), then we wrap the logic
> of handling the skb to an independent function virtnet_receive_done().
> The subsequent commit will reuse it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


