Return-Path: <bpf+bounces-59658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032BCACE2A8
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05FA164DCF
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3431F1A5BA0;
	Wed,  4 Jun 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYTc7xWM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDC18DB24
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056385; cv=none; b=P3Y9hZumXIhK/6G99+1ASKyxLvw4tkT6i+E9r6wpCDDTWrtX1N+1hHVCcvelDwQimMPAhaI7ONY57TP0UOzFIoqZRTIQ2lU5yIRaMzoeU+pWnZlQFHCWRm/Dk7k/JUNo6DY1gRb2e9bKF5cJN2C1zvDotfn5Y7c8v7GL6287VbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056385; c=relaxed/simple;
	bh=TisxmFxL/O31Am4LeVuPkcK1xwB3+HHPha7PZiRcrV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptsm7p5xX4SE4smbey03V+WjkK4mWvOC2yt5z8ZHTuvM7Sc30JO1XGTFTGrCDNAqkG85x8E+S9oEBSqc6paHMRGLb5daGQUPUg/rg3ErMkESs6FT/6IfJDbW5CsFWqI5Q+hU7tcgcTi03j3Dmo90Qe9MMsj2VKmSC4qblsEmx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYTc7xWM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcDq3LrKSOS2wxrwTduRvwlyf6+kgRTg7vc6C+v+3YI=;
	b=CYTc7xWMu/AbTU+BGb0SrhX0NiLK5uo15c0jsQPlvyBA6nyGa495VQaQB1d9sJZjQ3p1ak
	uTdMqWdhbmK7VD7buG8eUDKae1yIsABJVW/OW4i53NzlOccH2sTamNReq7BOIUyR4+kzu9
	KR1utFChIJJrucKwEop8X7BiePiSieM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-alM_e7WGMxCwZufoQwFf0g-1; Wed, 04 Jun 2025 12:59:42 -0400
X-MC-Unique: alM_e7WGMxCwZufoQwFf0g-1
X-Mimecast-MFC-AGG-ID: alM_e7WGMxCwZufoQwFf0g_1749056380
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-604ba4eb681so138597a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056380; x=1749661180;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcDq3LrKSOS2wxrwTduRvwlyf6+kgRTg7vc6C+v+3YI=;
        b=wyVq28xBLzv+ofmaGb5wGUdpYuh/v5b2yS/QwmtcPuSMsLsWkyIpi5FN+MNMyQEz1A
         Bk8TrAL9QSlxugIxb5BgnCw3UwnEdWU93KGP5948XTB90fTJWz5RdHIFNJhlc77aDv21
         HPR9Rc/cFWgH8NdImJHwHqc0/TO6IWO6DQsVSqMqNAFes6RpVh+TEePtXVAgKvod+S7j
         iRjha7Lyvb0FhoTk068rSNhWTpHeqDVyEISGLOP2B8KORQBApOzwJrBGvt9xFzWuo6t3
         d/vUEij1c1MCKpodYNJd3LTvwuJZY/OuOBvptfqaT2Sfvvb1mcBidgded3XnoZmgI2SS
         kF2w==
X-Forwarded-Encrypted: i=1; AJvYcCXsop1XSgyOEAC4C9sozVDZwepMwWmVss/5VQSj884BHKOq0V/SJ/y/3fQqaRaOE0Bd64w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCEskpnUzNvxsfPcqRJlsjspM9TyCZSW0sGGrCTr1onOOjlq8W
	dDaZbyinspsJF5UWwWVeFCs8Jvv1pPASeEcVXGonfGCxuxfxZZmwyryptQ3D3ha/zsvNn4ayEU4
	MIg9HkrWUBLiUZsxO6u5OOwVXIUc890Xd9BMKw5q6dAlQe5Fxv946YA==
X-Gm-Gg: ASbGncs+0lAdVkcDDnOsi6so44kQMinmU66IcmUkI03Ao9owydPfXaI7u6yg0Uc/5PJ
	mJA7rKQoSTGVnRANcXce51Ak0VxMTTGtlEKIk5vlCkZC57iyKlPc5XGhaQG6XzrDXxYOJT8eEaF
	peYnUL0gpsYOYtQzvBzMFdUtxDkY/S8uSH2PFPQFk88xBGq2q1g3BvbYebtkdg2VtEi9bne4zSM
	xu68V8kGl0jbpiZuHIHQhTxj3eTSWJmkKWtgRHRJUP5BQuaz6+Pdg7HVeqH2nFToQVRLdgx39wX
	It5NcvAS
X-Received: by 2002:a05:6402:358e:b0:604:b87f:88b4 with SMTP id 4fb4d7f45d1cf-607226293a8mr293592a12.2.1749056379686;
        Wed, 04 Jun 2025 09:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZxMOZadu+KBXSHu7RkEeaN6qtSvGLWFm1vInB8dLTiO0dgyXATXc6Hz79i4hKaPIEOdbWXw==
X-Received: by 2002:a05:6402:358e:b0:604:b87f:88b4 with SMTP id 4fb4d7f45d1cf-607226293a8mr293550a12.2.1749056379325;
        Wed, 04 Jun 2025 09:59:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606d7e17dd7sm1783024a12.48.2025.06.04.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:59:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C55081AA916A; Wed, 04 Jun 2025 18:59:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
In-Reply-To: <20250604025246.61616-19-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-19-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:59:37 +0200
Message-ID: <87ecvzv3wm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid directly accessing page pool
> members of struct page.
>
> Access ->pp_magic through struct netmem_desc instead of directly
> accessing it through struct page in page_pool_page_is_pp().  Plus, move
> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> without header dependency issue.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


