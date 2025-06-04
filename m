Return-Path: <bpf+bounces-59651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAAEACE28C
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BD7189C9DB
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06E1F2C44;
	Wed,  4 Jun 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA99ODXP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23041E5B72
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056114; cv=none; b=m2BsGvlVddKd/EMxxSa6gQ5qs/w/jLq0PgRk71hl7OdRf3Ap91+Hs+DPTZ1fqYKpeSPMnjA2b8hP0684MLhsfGfQL6B123T9Qa00GkY8Xgl+WDmuMMbXkjZYaqTV9U040rVjKp8UblpFu2DWnIetRyP3EJlkbc4hETp8T4FScyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056114; c=relaxed/simple;
	bh=91TmU08FsImP3F4T6u8nGlGa+H7u7HZ0VJLL7es6Lfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AF717LXRS5UXcEdZ8rpkS2jvUn8JwrlzbxcyJEGVfS20qZkJs+AMhlr8+8zCuRIgAiaGKMdQl4FaIyZW1NvlHNOstdYY4UjbcVnqC5ur0ZMVHunwPZgCU4E5OVw7Q1PdJUZXe4YhZz+qDZr2KLByInfgkxaeqZtfEErwz+STOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VA99ODXP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91TmU08FsImP3F4T6u8nGlGa+H7u7HZ0VJLL7es6Lfk=;
	b=VA99ODXPXg6zqh4kZPT4CCBZfPIsmXUIYv/vYl5Ka5kITWH2qhcGFISvbHwK9S/b6DBN/j
	dwYzyl3VJnIDjJ1JFiwgPH4MFngGY5fKnvhKrgob/k/6By/D8KcF6g8NL7BItoAqdbOxhS
	ZCG+ueBQHnQPyPuvzGZN33Jl/D0Hoy0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-Q3FIeTkOMgWV54qVM2TmsA-1; Wed, 04 Jun 2025 12:55:09 -0400
X-MC-Unique: Q3FIeTkOMgWV54qVM2TmsA-1
X-Mimecast-MFC-AGG-ID: Q3FIeTkOMgWV54qVM2TmsA_1749056108
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad88ac202c0so7503366b.1
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056108; x=1749660908;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91TmU08FsImP3F4T6u8nGlGa+H7u7HZ0VJLL7es6Lfk=;
        b=bsLc6EORocNHe5XmOHvd9dRciqclShT2HCCQno4pFcmQWuESUrSbOM1Knio90VTNoL
         P5H3DWiF7y7e+F2DCKE7gLwICQgKo8wMGerCtey+qrBnn54ybWS51+qAoYPFD9iCUKEt
         7+HWYsisIDYLSMmIPhrc2lrw6nWD3TuPTPgCnIGYxmb3aPbbJaPW/ed3xFHVqi6V7eO1
         WvV9RUfmHbdKumf/c59dOlP6zYC+jRqqnLg4jTvqAz5Un6Km1ib3d3IxZ00LEHOdeANb
         s0D8vyM3ZOCMmjS4UVkNs4mrHdWhlsL0j/pAU3X5Upp2DLafp3oxgu/AM1bWLYTRBN7R
         e05Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3isnjjWlnPI2zmQ5IUawkilSpivkphVZciNz2jjLIBWD8BkheXM1ScpjPYttIgoBFS+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wqKl+A38tgk3kv8b/YbqOTWZq2LhfpG2b4nfkmwiy/f9hQb/
	Q2DCa9vQqJNWKPk1UH5KJjcQJBue+Iy+NE1XwIQ2PI3A14dsOkm1sME0e5Hg0MoPYYTULheVdGJ
	FCyP/K94kUUzbGloBJjHcBCvPjUPrt4CNWHJNkh/+u1sN5EObCAs4oQ==
X-Gm-Gg: ASbGnct769Bkp01c8BsxkHBj2sZGmjLFu/CnnJ4hZQ6WVOLixedRK82sPYlsCdR2LIb
	VsNjm+eATczr7SfPHk1SlYid70IOkCEaRWpPy8LBtQbUY1HBgHtca2S5s7eRvIQcI+VJ5xZZMwL
	9T540PusOYUBjPUidgnH3SXn6FOamDM2nTe6GGA/sDnHFGqG6qRYCsDG0b2s4bzxLqxdl5doEnH
	fw4QdACduVO6AzmXse6I1bW3vrQ+oGYD3INUgcUsqZyd25QivgRqio00hAxOo8KAolrqgyZhFyg
	UVyNPfn1
X-Received: by 2002:a17:907:3e08:b0:ad8:ace9:e280 with SMTP id a640c23a62f3a-ade075bc502mr29797966b.5.1749056108258;
        Wed, 04 Jun 2025 09:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBc27ssHQiTtB4EgXSQkSof2j5qNISk4hB2PmUnwayLy3gFqhE1o5UG3eo/R6RPx6tePP/GQ==
X-Received: by 2002:a17:907:3e08:b0:ad8:ace9:e280 with SMTP id a640c23a62f3a-ade075bc502mr29794366b.5.1749056107818;
        Wed, 04 Jun 2025 09:55:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d84d1f7sm1118264566b.74.2025.06.04.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:55:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6A2151AA915E; Wed, 04 Jun 2025 18:55:06 +0200 (CEST)
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
Subject: Re: [RFC v4 08/18] page_pool: rename __page_pool_release_page_dma()
 to __page_pool_release_netmem_dma()
In-Reply-To: <20250604025246.61616-9-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-9-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:55:06 +0200
Message-ID: <87v7pbv445.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_release_page_dma() is for releasing netmem, not
> struct page, rename it to __page_pool_release_netmem_dma() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


