Return-Path: <bpf+bounces-60598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6165AAD85D7
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC38F1898504
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 08:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBE279DC3;
	Fri, 13 Jun 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAXsxcQj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038C2727EA
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804081; cv=none; b=OKTn2dji/RGuoSG+UjXE08ar5TM7atFINd2MnJMtHgdAknVjTs0Zpbx3GC8od+wVHIPkLeqfWz7EmyAL18o4emI7y4sDeJ4l7KCAF8+Y/jN5QcWXw/lNwQtJDnMAcZGk2clb9H3HF1wh0EM1Wu3HaSAzXhTEYYqXhVWUQ/fzpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804081; c=relaxed/simple;
	bh=BLmTKI+Q9DOfOhx4cbhUvOqosks41IEI7ecv711gzTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dyNTT+ASsrQX+xQl1N1cCPI+b/8vkD+WfbMj+FOTElBlq6FO47mSbH1Y6Bj2rW//3w02Itilc0RBNfpWVloB0SDnHsPNZCHIlqxxGqi9FSodamwuj4YoyaQBi8KWxChz3pc/ARg3PbNmTp6PDdPZ+zOuUgbPt+9VQQ4Sg37BlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAXsxcQj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749804077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLmTKI+Q9DOfOhx4cbhUvOqosks41IEI7ecv711gzTA=;
	b=FAXsxcQjS4v+YKg2f66eGUlXel26Ytr1+U8rSVeMf+1DubIcHtZX9WO9HeXXQM5i4pl8nH
	F3S9/GFJ1g3WLdNnpBsGqDTrtnz861zFGiX94/ZESjVKHdY2bY6pMyNFeMI4uhX0tEyeNp
	RduZ6CiN0SL4A3iJBeJs7DZ5aPFnVQg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-mjyFwuouMeSef6d7S1Jd0A-1; Fri, 13 Jun 2025 04:41:16 -0400
X-MC-Unique: mjyFwuouMeSef6d7S1Jd0A-1
X-Mimecast-MFC-AGG-ID: mjyFwuouMeSef6d7S1Jd0A_1749804075
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-553af0e0247so566034e87.0
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 01:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749804075; x=1750408875;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLmTKI+Q9DOfOhx4cbhUvOqosks41IEI7ecv711gzTA=;
        b=vnOAOxCrb42L3SodO+uDE8pH/RSnC60y6mFC/7EspZVUqMh+BkAf/0WYTiJS+ot2HG
         qamKjGOh985C46OWpVBeh6LBl0q+QJwvEpwGWfBJ7d1L94Rk93PMG49jda92scraSK20
         7rjFFegU6kStKu9U1FIvokumwvIbinSDDfsn5yAgD4ZAB1PYOOeraQz8pLOsJG3pFDAu
         5B0wsU3Z1FXIq7+LCKvFDTqOE1VocljpN3BINuCqDZmYKT0CpD6jyAjnyV/BAvEWO+ae
         ZnUR2Xo1+EdwJfS45B1tf9v8n7CMXbQLEW+BwbZPPZkJsmg3eZF6WtiibNA0OY3a5qDE
         cduA==
X-Forwarded-Encrypted: i=1; AJvYcCUxGpbEQKZyMjEooqQYQjefS3CE58//52WbTxAr+I/IcUHHcOjYQYnE9URrVtQDPOCyOBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJlbXeVCY3R/uSuFcsK/YJ5WwR3smPhNfLOLTtUmpMQlMa3a+
	Py1McceKmOyN7bGFhAp0Ualb8gsEN+/31O3+CbYe1XTflu/nz3DA06DKtMtEJAGwnT9sNQFn8nH
	WbIuYaiBU29ka/Dp7kYa/+oD30C2RBB/bSXG5EP7u9WZ/oSzRgwXdqQ==
X-Gm-Gg: ASbGnct2HK8JNisT/Cd0ElgJU2Z2xe8J1ob3ocZJUVUQVl3i84Gljjc0o+T2bgnXUjI
	4eClhqG5D6Fc0eIF0IcwYy0cCRkiHPx6ro7tEH1MZeoRzflA4QPHKP9SCvqRTqCGmL0Z32MkZOR
	kGYRJ7/Do3WppV0lpXUxus4cu/wKBocO+PGC/++y8ITCgFfM8Zk0U2AaozT7L8POmbbyx/qZ5Ed
	xRIAhojwnIq0rOcq9QXxzzX9sEp9o0x6FXneRlBvV41ETw1012voMzxY9eE7mnXmKkBRxomYWjz
	FX4/dIQ1+zPw0F9mWUU=
X-Received: by 2002:a05:6512:1590:b0:553:2969:1d54 with SMTP id 2adb3069b0e04-553b0e7db36mr492390e87.8.1749804074736;
        Fri, 13 Jun 2025 01:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8IpMdUtTgJ3Dn5a0CMKZlpCnJMUPmS8+a17CagSgy2Cpy4kjX5FwqO1WhjH05IZnnYmmi5g==
X-Received: by 2002:a05:6512:1590:b0:553:2969:1d54 with SMTP id 2adb3069b0e04-553b0e7db36mr492364e87.8.1749804074236;
        Fri, 13 Jun 2025 01:41:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f76fesm370344e87.226.2025.06.13.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 01:41:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 708031AF6DCC; Fri, 13 Jun 2025 10:41:10 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>,
 gregkh@linuxfoundation.org, sashal@kernel.org
Subject: Re: [PATCH net-next v9 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <20250612070518.69518466@kernel.org>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
 <aEmwYU/V/9/Ul04P@gmail.com> <20250611131241.6ff7cf5d@kernel.org>
 <87jz5hbevp.fsf@toke.dk> <20250612070518.69518466@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 13 Jun 2025 10:41:10 +0200
Message-ID: <87zfecrq3d.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 12 Jun 2025 09:25:30 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hmm, okay, guess we should ask Sasha to drop these, then?
>>=20
>> https://lore.kernel.org/r/20250610122811.1567780-1-sashal@kernel.org
>> https://lore.kernel.org/r/20250610120306.1543986-1-sashal@kernel.org
>
> These links don't work for me?

Oh, sorry, didn't realise the stable notifications are not archived on
lore. Here are the patches in the stable queue:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12/page_pool-move-pp_magic-check-into-helper-functions.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.15/page_pool-move-pp_magic-check-into-helper-functions.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.15/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch

-Toke


