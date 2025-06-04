Return-Path: <bpf+bounces-59655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 569EAACE2A0
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472B318998E7
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419D51FA85A;
	Wed,  4 Jun 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrK0CWH3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB601F8BC6
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056205; cv=none; b=dsj4SXn81ixu3FQlEXYxlVMl7rWAnxCZUYLmcPYArAb6IYYZLqFL/9iu0kk7Wphwb4mLCNLcH3vU/QLIuBkvKa/MBwWL7Gvp7y/kI88HHHFBJxPjjLOOR60fJNBn3dPvXLqO2MNacrPuANhI4fox/Q/KQjGs3/Ah/qPJ/glNLKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056205; c=relaxed/simple;
	bh=hHWkN+1W3r8pcWm5IykqgahYA5ORV1Tz/OpKi1g0bhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B1XAwpBL6ogFNXPcgXdfNbBLYcOsF4WyRYSYGlH3JqAeSYdbsRu8ZiagdPV/tSSKcpsfiSPR7RP9gdciV4tkeMFy6Jig3KgQB+Wop7nroYZaXWfW3/XY8JO6DfIDVACZjYHNGpNdnPjCIcBU0lvfrOt9tzsjH7jJehPL0J8EXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrK0CWH3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2I81AuUlYQ9366SJCkTTKCrVJZ04owtIVy2X3Og2iB4=;
	b=BrK0CWH3FfoOHGjGxh9H+5lkEXpshUj74CQUaiqB66dc9Zoo0Hvk9c2JzVjD7nQDWOWa0I
	FrYMelZU+bVDeXdezvXOREd/xqoRUYHmrz60tWhmj2Q823dKa1n8bZUF8VpoIHo3SgR8xG
	89W2RlgbSs+DuZM89fD26fCDcG80dzw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-a8zJ3gKvPd6kcBV5cfqnYQ-1; Wed, 04 Jun 2025 12:56:37 -0400
X-MC-Unique: a8zJ3gKvPd6kcBV5cfqnYQ-1
X-Mimecast-MFC-AGG-ID: a8zJ3gKvPd6kcBV5cfqnYQ_1749056196
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad89a3bcc62so10975966b.0
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056196; x=1749660996;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I81AuUlYQ9366SJCkTTKCrVJZ04owtIVy2X3Og2iB4=;
        b=xIZhgb2G/HWhX+8KByEHgoWTE3QD7G3kQz7hha6poGwk6n7lPDJ5BracSRUnH7J7u2
         s+g2R+gqVTekBsN+XuRnQDMN6go2kZ1SoZip5TRGHFhkFJYSw4e7kKmPlShGojcaH8pR
         wt9kwUitEGcE5/EUrFM0Gqw3NeosL1DwmaSX2bEMt+sjZWWFbcy0DKd9RmvjOl3H3a2n
         ej12Nx/tugj06R5F0ZjLNTXoDYGbTVulOG+JjO56DCx7ZSIuGMPS5oeDrZGz6YU6YKZN
         Cx/8DJf2U27ZJYS6LoqpwLha+BIu2yrlgAXkh/i4SyF6ohg45lOSWG7nV44LBSiEnBy5
         10uA==
X-Forwarded-Encrypted: i=1; AJvYcCUSaSJoAKzaVJhSZCN2wkx0FO4R8tsWNH7aZ9RykxVscZYbj38vvfkG9hC16EZzMd1F5uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0FBfpODvGBDp3V2ycmgz0Apqv4cMcPOyVzplNksjVBwaD7A0
	I1GDcvZpX7If94xWSV1rki2CkZ7yRogERwTej9bTA9CDBWgVFRnnTIxF3sO+/vbheNtP4Zi1pTt
	u1LeCBncMkgv+/M2ivKb+B4PD2xWl/NDtK/b4O2hPK5y52Kx30iS14A==
X-Gm-Gg: ASbGncsBxrsF8EiNQiDU7fvhoasCesvk2+lWUJO4Ly4H6sOC9GN6dn2GrD4EhpJyTN1
	fIrQlA4JhiwntkOnQA7k8Rg/0JKGP7NywS5PUy3LShL6omgg03Ggy7xML/nJ8ZysJqU8JTv9UXH
	bTSGWIh0c8ksvG7vxtfUQPNlvybjShr43c1EViuMz2wHjCxt5ORPKDQ0AP9SCujlobtY7y4N0Bo
	dZEn3KwqQxvubkQMmB8m4Js744ccCyeYaLr+utOS9YWl3wKIrnTIv1FVFbXIPlLPdZ1czQPPhS0
	BNC70p7n
X-Received: by 2002:a17:907:9410:b0:ad5:eff:db32 with SMTP id a640c23a62f3a-addf8fbbcbamr374235166b.48.1749056195785;
        Wed, 04 Jun 2025 09:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyDZZleVWiVesfO9YTAhzLK2xLG6f1Ssys6/5lTY37/ymkAbmNiWcQtPEP0I7NoOuKWqtMkg==
X-Received: by 2002:a17:907:9410:b0:ad5:eff:db32 with SMTP id a640c23a62f3a-addf8fbbcbamr374230266b.48.1749056195333;
        Wed, 04 Jun 2025 09:56:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad39f08sm1135981966b.144.2025.06.04.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:56:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 06E6B1AA9164; Wed, 04 Jun 2025 18:56:34 +0200 (CEST)
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
Subject: Re: [RFC v4 13/18] netmem: remove __netmem_get_pp()
In-Reply-To: <20250604025246.61616-14-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-14-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:56:33 +0200
Message-ID: <87msanv41q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> There are no users of __netmem_get_pp().  Remove it.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


