Return-Path: <bpf+bounces-59648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE663ACE275
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65016177519
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120011E633C;
	Wed,  4 Jun 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKqaVa60"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF281DE4FC
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056073; cv=none; b=FiTtnPeUDN5UtaAQOm4Py/VD6ZNIaWgSFfX3JTsOVmQT1eYvBp6dmGgmIkCNvCeqVrNJHW8Wky/5aAa3DAo8E5uAGn8HoJwMjjQAFPJK3wecAXI8+PfqjhEP+RfOyRqpc8YOn7/B7IvD90gbAMhgrNh46RgFJijoujAMYOpDTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056073; c=relaxed/simple;
	bh=CBJrqZ+K8qtu4Y1ldouIvNxY9hw3rtwJv5cO0xC+o1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aYhumVsKHk7sv3B2AH7wSuY6uC+Opoif9rFlUPMOyDz3EPflJL0IkfW36WbLE3Lm/PuzXS1VSuKcgCVdmtYVA8gQT3dwXv3bzs8N0xDBkXs2z2HzlDIAeo6uxXjMMj0FNDoQ7O7WGhjO45KpCCRhbNHko5NHZCFJJgZ9DC86QHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKqaVa60; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBJrqZ+K8qtu4Y1ldouIvNxY9hw3rtwJv5cO0xC+o1Q=;
	b=RKqaVa60G09kku/ouAhm2a1n6fsTN4+nSYbsfbE9JeikfVCKFny3tLCg64PL8/pq+f+El1
	H4dTG1A4Zgm3zYRVin0psUHQVBoacfuCIlH35LKkJDL8f/f848k5tKECWO7jTR8mdnxsUX
	vA/es69d9FMfmswo1+J857SSft29woc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-sB5g4dYiNxCOqWVesRhb-w-1; Wed, 04 Jun 2025 12:54:30 -0400
X-MC-Unique: sB5g4dYiNxCOqWVesRhb-w-1
X-Mimecast-MFC-AGG-ID: sB5g4dYiNxCOqWVesRhb-w_1749056069
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so1755066b.2
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056069; x=1749660869;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBJrqZ+K8qtu4Y1ldouIvNxY9hw3rtwJv5cO0xC+o1Q=;
        b=RVXHFqXZiyiCW9nRwsvw5e7TfYWndi1GPVPGer0gHyGhmYG2VmfqmXGihHk1mAX/h0
         dZJbdF3D53vBFuv5LMFp3OlYi7sykaQAg7knvz8aeUBNHfA+45SGRdHqRHiSOFhoA1cv
         RvUj4707Pz05suOTsJbx2/ssv5ieHEGZq8tc0sIAd7/JHuZhtbK+obTGx83D7WmW/7Qw
         qrC/V6J10BNkcE06dj1rJAkrGMiNchm8PTp5pXRfT57WFzWV0CiEGZ75/7WJS583vmVZ
         zKbL/DEFWoMUTFraCvC383iyWxHu43EvjFV1l8mgBIMBlqOCoVD2Jmed7q2KcOMGMQEC
         MLfA==
X-Forwarded-Encrypted: i=1; AJvYcCXGTv9hisKTSrgSnH3S37+RjPfU7P01XXJH9PgLPZQjJ9iba90C1FvjSBBxCHEBrrNgCR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7Srj4UHKREwaa6VUQ11M5VlibL635u2GJ3tQ1NMi9DwY4ewk
	te47JkqmgaQRjwfvURmgO8zYKnXxmVZn6E6jGiteym4EY2AKnFmcL/KM+n7mBpd6rEijsHtpS0r
	gomtSRKqhrCeW4B1podrfM1a5G/3Ce+lrUPZVHHVc4g2FYP6uQ55Yuw==
X-Gm-Gg: ASbGnctsjaHfyr+OhwgOOIBgUTbrbtYHvYRcyfECd0653lCYJv2jaUXZM8+fXmO4ejj
	Mk84SRGFxbbjW9H6hrc8inEqGJHICjzFGzu5ErB3t/CMqSrpa6a7GysoHKvYMelMdsTcWUhP1um
	uJqiGy5TgIHvChbIkAFsZTEX0i9XjZyw/gW1EdIWbOWKsWMhKbKkKhlGTE6nfttVwgtl0/UUtgj
	Nnh4RlYyCZBuYaP9Zcu/j/vSgtHXa1FW7QXMUpZwUK/iDytvw0xDEtVw0PiufI3SjxwXjOAJd0c
	G8SgngQ1
X-Received: by 2002:a17:907:d1b:b0:adb:7f8:9ec2 with SMTP id a640c23a62f3a-addf8fb2d1dmr279357966b.53.1749056068631;
        Wed, 04 Jun 2025 09:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE72YuMsy54qWRNWHktjij3Nn8sx5T48vgaRUFWDRjP/O8/fKC1PRWFpCbXd9M9VbWIKd6C2g==
X-Received: by 2002:a17:907:d1b:b0:adb:7f8:9ec2 with SMTP id a640c23a62f3a-addf8fb2d1dmr279352866b.53.1749056068172;
        Wed, 04 Jun 2025 09:54:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad39479sm1120713266b.124.2025.06.04.09.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:54:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C59421AA915A; Wed, 04 Jun 2025 18:54:26 +0200 (CEST)
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
Subject: Re: [RFC v4 04/18] page_pool: rename __page_pool_alloc_page_order()
 to __page_pool_alloc_netmem_order()
In-Reply-To: <20250604025246.61616-5-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-5-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:54:26 +0200
Message-ID: <871przwipp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_alloc_page_order() uses netmem alloc/put APIs, not
> page alloc/put APIs, rename it to __page_pool_alloc_netmem_order() to
> reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

I think it would be OK to squash this with the preceding patch; but
regardless:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


