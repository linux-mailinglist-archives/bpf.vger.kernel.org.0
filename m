Return-Path: <bpf+bounces-59661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F0ACE2BE
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312713A6565
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA11F4285;
	Wed,  4 Jun 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfJojYoi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4991EEA47
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056620; cv=none; b=Ak0FmwN+g/M4+I8Hba7JBzWjV5hlKYJMn0DYfQojp2FC4/jjVU8TFDzTmSG1oV5GVgigT/otY0tXYrkyWy9ucwOm2UUhuDezbHK9LekRu8ZDSeYjP1ROoDSrDRxPXr2tx7MceRje3t8ULjk4Us1I5esZc6ZrLk2d5X2Zlzsw4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056620; c=relaxed/simple;
	bh=jayrpGQ8EMuNrxluCYCn92f4Z9jqZ5yLz/s/cukRdq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OLbDK68NzqJ1fzhOwHS39O88whPAERGuuEoyX5qlkmagglrPRuE2STTD629lb/msSWjndsPWZxMQYirydbsnA+1O5MFeOvPwyd3wuyamYoPsA+q8X8uJKGe1jwGLF/MWJtkoe9UbFfxbUzklik+GbxtJqJnhpDVB/KGEuA797NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfJojYoi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jayrpGQ8EMuNrxluCYCn92f4Z9jqZ5yLz/s/cukRdq8=;
	b=NfJojYoioFhA8YQ6Zr1J5w9TwqfFXsqGbf+EgQt0+GgAc/rbjouSdi7BvpfbSB0f2TpkQV
	pbjDO+LwRsSyIKHRyRe3RbzPEdRayB779m321u7UJS1blKKqugiWFfh+yGbSyOyzSMGhv+
	uPB6GRAi37ojUFOJPbwKKmGKb+/U6Bo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-G3-aqW_UOiatR66Kh8BlwA-1; Wed, 04 Jun 2025 13:03:37 -0400
X-MC-Unique: G3-aqW_UOiatR66Kh8BlwA-1
X-Mimecast-MFC-AGG-ID: G3-aqW_UOiatR66Kh8BlwA_1749056616
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32aaad533c7so143871fa.3
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056615; x=1749661415;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jayrpGQ8EMuNrxluCYCn92f4Z9jqZ5yLz/s/cukRdq8=;
        b=AOLiFdMJOcj9oSuF6BvDA43Y70M0emQx9KaTFFfv1V+vZT/LGbnYfauZeLXE6UUGGU
         l1U00+oXLPpVjEsdKNAanbBo1az1sj5xtFaMbJ3gOGq5B63viJNF7lGC+7k83ELnRXas
         4WV4qe/81tRhrSQcxejhuiUoro50rlhA7iWYLkq1TJ1hsOtfljIYK5ptpmVwyoByhmBU
         vXeDsvwjdu7gLrvot6AcxHFsubCQmrLJzn0Cga/6cM+EpXQu2yVrNqZhJZRahNAFGwtE
         h0r5n1k8Ks9Bc7fV768uMsqQwfG8B8nDQJhtKudV04Qv+wstToIqmGvgvyd96/7uD/4H
         +d7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7OsXDzIL+aaUxYe8B2kYiOIUdNVLnZoAeXFQVPYZEJTAzK61PifE4GXS1Hoosiy70RqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAy3CAYrCgh1Xo7jRENYqqKsa64rMCJe/G1FXydYyv7uFoVyRQ
	4uzQalzVTmNN3YXzg+7R7ec38vHBkp5bMSp06Xr9XqDbH6TuRLanhRtjmhd92+mEFOvFcRqoYga
	HMxI4aaIIIXHFeF2MGGVDb3WbAqQBWId4BONRn4udkxmTBby7Qb2JSw==
X-Gm-Gg: ASbGnctoHMKMRctLR/en2ZmnzKoONwAB3IvtMw8BwXrnUHku8Cs82iWBM5e6ugzSMPa
	oWJE7xuP0vFtK2OG+CrCUyqTX4rPBRpk00melp7fxlAP9mVQ5i/C6WQUZPvIAIS6jC8Pt1TpSMs
	GHXbRio/SfzmIpMuEWOKZ5tfYS630vLLtL9i0B5HvTE8ltZ746b0W4iYs/rQPfyoL7rtNFkIZCF
	9bngIjMHt9H8tysUvrvGsACDbM5YIQOKFHa7IOzqN3un0nOyxv7Oyo0n2unM4mWP4vVGhYO2kyh
	eAn8pRMdilqivP0gdc6Y3xvz+pfDsyvruBrm
X-Received: by 2002:a2e:a581:0:b0:30b:b908:ce06 with SMTP id 38308e7fff4ca-32ac79599f8mr11790011fa.19.1749056615288;
        Wed, 04 Jun 2025 10:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhvowgSTP9uwRV+BqJt6GC7sN1OE+Dwxjsqttfw8aGqFJyzPj9td+LDCaCRBwp+P5agViq4g==
X-Received: by 2002:a2e:a581:0:b0:30b:b908:ce06 with SMTP id 38308e7fff4ca-32ac79599f8mr11789411fa.19.1749056614743;
        Wed, 04 Jun 2025 10:03:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85bd26d7sm22115981fa.106.2025.06.04.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:03:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 74C7C1AA9173; Wed, 04 Jun 2025 19:03:33 +0200 (CEST)
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
Subject: Re: [RFC v4 10/18] page_pool: rename __page_pool_alloc_pages_slow()
 to __page_pool_alloc_netmems_slow()
In-Reply-To: <20250604025246.61616-11-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-11-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 19:03:33 +0200
Message-ID: <875xhbv3q2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
> struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


