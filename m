Return-Path: <bpf+bounces-61933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CF8AEEC6E
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 04:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBE2189C0A5
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AF71917ED;
	Tue,  1 Jul 2025 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A54fC3Us"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452EB1442E8
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336613; cv=none; b=YbGdMZOMsFA7wcMZ//bLaVLILaWKBGxcIH1q8rDFOU4AWz3lc4G0sMrX79UJfI9oSWAUywdx1c/A+7MCwFYaKIw7u8jwiWKVaqAxhpLAq8dcyIzLMUWsCiByXxGRJ16y0coMlPRDcieQ9geU1t25JdlmbsDfb5h/vKQilEXOFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336613; c=relaxed/simple;
	bh=UzEAJUUD9OK3W0bVuYO+NSmpMMWNsePaoIENu1gvApg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INCCSQ56QxesWIjWCvh2EjiJZzMtAgnmoQ9z+aHacsHxUOXt8aRdYJBmeFUr7p/JciGUXzNODg8b3CbTIQqRTUHFN82uC85hZ/vwR7kDAExaTriMUo1qB2pTsWowXg45Y6ZTii2qUpKs1hQvBuKjhQCCSILt+73LRcRySSvMSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A54fC3Us; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzEAJUUD9OK3W0bVuYO+NSmpMMWNsePaoIENu1gvApg=;
	b=A54fC3Usp6IAEXfjI9BhNmg6Wg97Ae8qnkVGyCZf+Fl/5dJNbVXPUXyjhSNfbLKY4Dv1G1
	5xlqYj7HbIl8jx7tm2DQiIWUNdTztaewCaPn/lxpQM1HHHHmXvdhUnkv5dWmccaj0gXnCn
	uThczIaGgz/iHkYpn1tWBalU3tgllSs=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-CJGVBR6EPQGSVN3gKVUFVA-1; Mon, 30 Jun 2025 22:23:29 -0400
X-MC-Unique: CJGVBR6EPQGSVN3gKVUFVA-1
X-Mimecast-MFC-AGG-ID: CJGVBR6EPQGSVN3gKVUFVA_1751336609
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-532d32147f3so1382133e0c.0
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 19:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336609; x=1751941409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzEAJUUD9OK3W0bVuYO+NSmpMMWNsePaoIENu1gvApg=;
        b=LzK3+udOawx9QGthyb9X8mKJWbZnSwRaF6y1k01QdhR0q9d+7yyRjJBvdVRuINpd30
         vDX842slegzcDZAt6a6xXYMrz4X2FVtmDlkQBDOW7mg4Lq893bl8IPoaqoMQBRdd2M6P
         L9MbnYHIjUOp+SiX845tWybZ8/0Yjw+ZC+JAlkW2gMhWc00kQNTDkOKZQYb5nWhleO3m
         e7SnwnmY37a/ctScfRILej1aRtNfW2yMFaO3ZYX6CCyfjxb/KoGbWq2A5LH7g3Y7e3iv
         z0CMDGj9m0Pcoj6SG7GqL6FSNpZM04C+XdeY0G/O/nfn95typLwqllu5eu3ttzopFv4F
         sQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeYuSAa0XpbHXtm9yDJblJ+YDuyHRzJrJJy+CHkvvuGKRN9b0A0rUrZfOoJChzJXl8fy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3wfBempKnGutjnQLy/8Ae0oLnEwOkpqO8HTpx4NpejOy22c4B
	zBdTHxpXThiTGbOcPXraNEw2+0WVjHznFhR1GjcZM55vZk/qp/Ger66fCg724Brx+o5Xg7nWp+F
	cpQ0Tx698BczmJISVDyFQiDSXaoIv6ut7QgRucm1MOLBY0Q/q925Cydz7HjeTxHiWUE/C5X9zfR
	SjhdRdsR80mL9k+N+vD75FQiTjdfeQ
X-Gm-Gg: ASbGncvtmZxBvWBLNg7r1In6zkAFtmBI/x+xeFzuOX9aiea3UlngDwL/PCzKLthuPpQ
	sO7YOHX+ydQMt/jjrQ6P8q+NxtocnS5ne7zcBLkiejU0BI1NRCzaP8RPdbmgTNMg016K4ZShEiH
	H5
X-Received: by 2002:a05:6102:5123:b0:4eb:eedf:df65 with SMTP id ada2fe7eead31-4ee4f55fa28mr10132611137.11.1751336608773;
        Mon, 30 Jun 2025 19:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYUKosjg1xV3/2kEIImXNwrpXMZl3+XgrJg900Mb6VAWhQ1VVykJLy6Rp+l/68SJ/VfW9TfhDDb0JYqP7DqAE=
X-Received: by 2002:a05:6102:5123:b0:4eb:eedf:df65 with SMTP id
 ada2fe7eead31-4ee4f55fa28mr10132595137.11.1751336608477; Mon, 30 Jun 2025
 19:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630151315.86722-1-minhquangbui99@gmail.com> <20250630151315.86722-3-minhquangbui99@gmail.com>
In-Reply-To: <20250630151315.86722-3-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:23:16 +0800
X-Gm-Features: Ac12FXwmRMP0wrScNXo4jLviRavx1GRKuzUNyZLulsaizoOGTdjbvUZnQk8mBA4
Message-ID: <CACGkMEtv+v3JozrNLvOYapE6uyYuaxpDn88PeMH1X4LcuSQfjw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 11:13=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> This commit does not do any functional changes. It moves xdp->data
> adjustment for buffer other than first buffer to buf_to_xdp() helper so
> that the xdp_buff adjustment does not scatter over different functions.

So I think this should go for net-next not net.

Thanks


