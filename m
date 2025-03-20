Return-Path: <bpf+bounces-54474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641FAA6A8CF
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 15:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CCA1888E78
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7731DED46;
	Thu, 20 Mar 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGEYCgpr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4B2628C
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481256; cv=none; b=lQCIaoXH/yMqmCxlIQMoDVHdaux3I72L3A1PuWQpS4SRjIbpNKJ9tP11R76VRM4Gfu63sBx0o3ZZi0NEPfw7Aav2W56y6UimQ5jhx/wDDd6+nPN5YmI/jJz+15rKw89ViLOKm8C46JkAPTzQoXCDvkK/I133lYiII65UUtitu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481256; c=relaxed/simple;
	bh=aLsT93dSweyrf+qk2uXM1EK4iaVizTPbN4c8paMt31M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mxlljpi0Il++kyE5FkrbEWfRdpOj1bUe8s5XDIVoE1yEJcuN1u7ecHcqaYhYOEBFz6/8ZxBET7qh0taQbmdw8ZmS6kF73dIdaozhbA9pThCNGqZlBimHXrWWQ7jFxQpTTB3Av6q9H5TmUkkfuDR3T/tcPFKD2Om6DafS0lEG3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGEYCgpr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742481254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLsT93dSweyrf+qk2uXM1EK4iaVizTPbN4c8paMt31M=;
	b=KGEYCgprfOZTr5lKbtW5TdDu/Yp5EIZzVVid7e2U8fZityZ/VZK8QDcWpqQQGQGqpuqpXd
	6ohRFCzkPf06qeLowUlX93q9tgn6aWtng+JESTuo6lC0pe6hsma+/nEKo8ghiTKsg8tkue
	Fz2oeBqXG6HokiFY2cqtfwkEaH44FS8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-9M-fRYYnMmm0wwU6e2ZV6w-1; Thu, 20 Mar 2025 10:34:11 -0400
X-MC-Unique: 9M-fRYYnMmm0wwU6e2ZV6w-1
X-Mimecast-MFC-AGG-ID: 9M-fRYYnMmm0wwU6e2ZV6w_1742481250
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5498879a3aeso422405e87.1
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 07:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481250; x=1743086050;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLsT93dSweyrf+qk2uXM1EK4iaVizTPbN4c8paMt31M=;
        b=Kaeh1N+aUe5u31+nSVV7JjAh+mg7h/GRFO9hmkQ+lbWZouDxkGEUxwbj2wPs1MhD++
         PfgmNRDVPK1o8DepJ2bVg3H4uwZ28cWsuZIAzL+3wTs2zFE3QCF1fzMzR9IZ9ij66LBk
         u8BXjKJmiFVTofEKpULvLnuab3ENozut4lS9wuq0PEP/Jaj6VfSSvNJGAR3wZjW5N9qE
         9ALVjsuHvldrd9jOr++Q9VMcmn7n0iZgW0t5wDpzOyBco21J1x7FUMTswYMeA59vOOYB
         1Gwizx9KGuhnG9qgRmuN/fQabdKVxNYS3pzx7gzYLmk9PLZqRdSbZ8EL0uzXPggdDWX1
         cz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+z0476uEHoyGtlWFSGxn2xMcVwQcW1Lj8YwTQ0+g0DYRLBHcON5Hy7E9OtgSvQArL7vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCN2QQ8hHmOZL/2h8fTcDAomSflOV9caSBu3RZ3UU+CAt737an
	xSSuCpD1KGEcuC5YmSqPv88QmbE71t2DruR2zJ598OpG+IDO880tVU715bbhWxUKUjVI05SD8uf
	j3UwsEDPG7SdwZQ+B7mX4crItX89mKWonmSOC9JAn0EHzG8FYGg==
X-Gm-Gg: ASbGncu9QO0+aaVcU6I68AGLJZHMP4Uidgpe//YuunIdsxuSHEX5gTbKFdgOOWvnV8g
	xLfMkKt6Vr3yh7/+00SfgJ5OSOtIwf+HtCoM0Aj5FQANXcdpX/SezYrK2t3cmT/mJRz7uDNAmZN
	SomCl2aXJ9xhOuYeLqx8rF5Elj8nVt8vV2F3rtSqZz484yxp/loPyt3vLPHFk9yzf690uSUYYU6
	ii2aQsygYhQCxUnZ0OVxMBZtgecYPwEG7hOwQrQ6wikZHIzqch/r/BeFhwVBwpEBJ98pTLLF9EL
	wSg5CrnL1HKC
X-Received: by 2002:a05:6512:2392:b0:549:8e54:da9c with SMTP id 2adb3069b0e04-54ad0619d9cmr1163967e87.4.1742481249714;
        Thu, 20 Mar 2025 07:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5MKiRxkFgKG3EdSlhgqaV6W6DjuZ/y68FT+nnGB1qw2EVv6jr9Oog18ux0YhIZ7JDKVH0g==
X-Received: by 2002:a05:6512:2392:b0:549:8e54:da9c with SMTP id 2adb3069b0e04-54ad0619d9cmr1163951e87.4.1742481249052;
        Thu, 20 Mar 2025 07:34:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a9219sm2230109e87.249.2025.03.20.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:34:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 202DA18FC2E6; Thu, 20 Mar 2025 15:34:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>, IOMMU
 <iommu@lists.linux.dev>, segoon@openwall.com, solar@openwall.com,
 kernel-hardening@lists.openwall.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <7a604ae4-063f-48ff-a92f-014d1cf86adc@huawei.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
 <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com> <87wmcmhxdz.fsf@toke.dk>
 <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com> <87r02ti57p.fsf@toke.dk>
 <7a604ae4-063f-48ff-a92f-014d1cf86adc@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 20 Mar 2025 15:34:06 +0100
Message-ID: <87o6xvixep.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/3/19 20:18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>
>>> All I asked is about moving PP_MAGIC_MASK macro into poison.h if you
>>> still want to proceed with reusing the page->pp_magic as the masking and
>>> the signature to be masked seems reasonable to be in the same file.
>>=20
>> Hmm, my thinking was that this would be a lot of irrelevant stuff to put
>> into poison.h, but I suppose we could do so if the mm folks don't object=
 :)
>
> The masking and the signature to be masked is correlated, I am not sure
> what you meant by 'irrelevant stuff' here.

Well, looking at it again, mostly the XA_LIMIT define, I guess. But I
can just leave that in the PP header.

> As you seemed to have understood most of my concern about reusing
> page->pp_magic, I am not going to argue with you about the uncertainty
> of security and complexity of different address layout for different
> arches again.
>
> But I am still think it is not the way forward with the reusing of
> page->pp_magic through doing some homework about the 'POISON_POINTER'.
> If you still think my idea is complex and still want to proceed with
> reusing the space of page->pp_magic, go ahead and let the maintainers
> decide if it is worth the security risk and performance degradation.

Yeah, thanks for taking the time to go through the implications. On
balance, I still believe reusing the bits is a better solution, but it
will of course ultimately be up to the maintainers to decide.

I will post a v2 of this series with the adjustments we've discussed,
and try to outline the tradeoffs and risks involved in the description,
and then leave it to the maintainers to decide which approach they want
to move forward with.

-Toke


