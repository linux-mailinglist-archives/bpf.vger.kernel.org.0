Return-Path: <bpf+bounces-54802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB08A72DEE
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 11:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FACF3A6680
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C020F081;
	Thu, 27 Mar 2025 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYTSuHaT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2020E310
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072102; cv=none; b=cNXtiiFObwyfMkEev7KRigBULolVNxqJRZ+9694RXxu+Gjx3dYWLF3QTW1An6KqC/j5MeDPX0wiLilq62l1DrVRNb+bAQy91utrApohwAp7VBSgumhc0nPEw2m/Ww83bJaRTOk8Dah5Kp0sKh5N88U9me2jNUDdNG3X5kWHOxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072102; c=relaxed/simple;
	bh=Iet3qpPdzxkBEABdbpC5NXSdqY79tSPMAsiZ8ZDVkeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TjvoqIIYaT4U8GdCISV6FBj/XHjSzZLgukEqtnbAGzBoSn/nSVaT7iH4OLFhfP2UYoDpenLXX6C+y3F8C5Dv1VLOG2oyYv9TRjUbVKX5z3GBJ1ydXiiHTbgWAaEgy7rW0LrBDGv7/7Ke/0vyJWOcFtSDufMuKqcvWMTuh85icVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYTSuHaT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743072099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iet3qpPdzxkBEABdbpC5NXSdqY79tSPMAsiZ8ZDVkeQ=;
	b=HYTSuHaTVTCzRthhSmxfeGw2eGnjnNun3dlekC4PAelf/2e5dqeUJQCf14Q977axcIYcn3
	k/XwkLcBIBTnFOJamhTHIo1M4U+Rg3xsYEl6+o3ykqbZVtABtvQot1ZWcPLtCkWPpBEPaQ
	+Da+5Rttz2IVjhkcYINPiMivZssIhMQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-8fgr0VGqNnqtTPT4Vz337A-1; Thu, 27 Mar 2025 06:41:22 -0400
X-MC-Unique: 8fgr0VGqNnqtTPT4Vz337A-1
X-Mimecast-MFC-AGG-ID: 8fgr0VGqNnqtTPT4Vz337A_1743072081
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac297c79dabso67584066b.0
        for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 03:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743072081; x=1743676881;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iet3qpPdzxkBEABdbpC5NXSdqY79tSPMAsiZ8ZDVkeQ=;
        b=InKWUWd+376Ky+q/7kX8u2XFztXk3B3jwH6Fhm/H8x7O0ZlOhLonEVWOg2DYG/saRh
         V9sPkuPDArragRIq3Ce+cZpfegITYK0oMuIt8PwqUM0EviFi7ee/ewDuU0qIy5kXkSlS
         pV4g7AmdTqVp85Pl+/blQKsN9Gx7/zgLsBlIlfn+7ffEIh9ghbQz3VgFTIbvpsx5Zz6G
         FG3cZ7ARqZz+5DFl4KsKMZTLxODOzHI58BDsLGQjz7YHIUeCEJnH2oIan6mNmiKvJJji
         B9S8iiFrmAVRWHTbERqaxA3wIIJwhZNrY0TQ2a7q5f8HiQ4gtEnq9gGuMxTFNaIm9CmT
         JvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBkvQTN9Npej5XbNJ68l1Ia5lu3LkayVc3Qax6jOVsoy1IHRuwAkMIeXIBjp+JtFm0ZBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysykz8eDPgXeGSc89th3dfukia5FqF0+TG0vsFfOv2YvsjL6NN
	jBCkPUWVqqeVAKxrx4OryWl1QZc3b4OXLK9416Cpp6v0LMoN8toc37ocQ79KEY5Lzf4JArzr0sl
	AzZBUwqj/YMkRKCreLe3w8AyHsaqCyoiMakNAlLl6l3whmsg6pA==
X-Gm-Gg: ASbGncuORGw4X9ofkBm90ythdSBjTrwufMWM0u6A+TL6VpUjst5A80K4EYxp0xWw7zw
	8SKCpTrog6KXEmrtGE3e7lrlY+Y1cnPaUxBqsl/uz9VEq0llvE3qQyCUs8HL8tShrPShiB0aTdx
	NpeKagVYoAMdyWKYso4jBR3ZljYN4TdQhWDYDOx38TSero/flB5dXVr4G48KzKK7YTo2p2a3q3R
	fJ5l5buXI8TNkzwlg0sAaHmCroeU3d+jRpGc76m+AADShret2fpZ8hnJRxea9LInj1WsVZn7z6t
	4hmvNk+MAQD5mud+RvSo0xXUMjCt0Cpt3L398Dwi
X-Received: by 2002:a17:907:d1b:b0:ac6:dd5c:bdfc with SMTP id a640c23a62f3a-ac6fb1491f3mr255921366b.50.1743072081180;
        Thu, 27 Mar 2025 03:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzn7n9aEz228Lpji8/Xps05eQurCOzah0ion2rj/D4w6OPRVLt3vlFZzhD4TG3XktdbJKjaQ==
X-Received: by 2002:a17:907:d1b:b0:ac6:dd5c:bdfc with SMTP id a640c23a62f3a-ac6fb1491f3mr255917366b.50.1743072080694;
        Thu, 27 Mar 2025 03:41:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e50edsm1203699466b.52.2025.03.27.03.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:41:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0C6A318FCBF7; Thu, 27 Mar 2025 11:41:19 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v3 0/3] Fix late DMA unmap crash for page pool
In-Reply-To: <20250326074940.0a224403@kernel.org>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
 <20250326044855.433a0ed1@kernel.org> <874izgq8yy.fsf@toke.dk>
 <20250326074940.0a224403@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 27 Mar 2025 11:41:19 +0100
Message-ID: <87semypxgw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 26 Mar 2025 13:20:37 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > maybe rebase/repost after Linus pull net-next, in case something
>> > conflicts on the MM side=20=20
>>=20
>> As in, you want to wait until after the merge window? Sure, can do.
>
> I think we can try in this merge window, just after our first big PR
> which will hopefully come out today.

Alright, cool. That seems to have been merged this morning, so I'll
rebase and send a v4.

-Toke


