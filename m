Return-Path: <bpf+bounces-59647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC49CACE26F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FA23A6457
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95D1EA7EB;
	Wed,  4 Jun 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvgBp8vC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9211BEF8C
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055990; cv=none; b=GByAsmnObha8u+uoWOxgEqjUkBeE2KqxMY1pBKHy+xRJqpYlRULMf1RaWgQNK0K6lfzc3Locve5mrfIA0TexFKDmIb05x1hiiYGm9wlXia+7jXWTzczhSZQSgxR6nu/lRDS+LRZ9yEmr2V4GkaqrUf7bhYagtxldq3ba615BEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055990; c=relaxed/simple;
	bh=Y6psz76j6Q54BLu/dla5y9lVeHPkpDqvYnlf52GvYWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bKdzPl/NAqpsI3nJiQIGU6DfuOgIvf3KII9XXnQ4eY8VwXq0ej4H+9igr8SYqt78mZ6DTLpXAG/kr/e8ooqN64Fjce51yzJKCU/Z3xelLSzTYMk5spiJCJvSxAcBFnxvqli1vGbu8QWc8G5lu58f4gnu1b5B8d94+g5AoYtGmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvgBp8vC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749055987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6psz76j6Q54BLu/dla5y9lVeHPkpDqvYnlf52GvYWU=;
	b=dvgBp8vC/q8thG/Z5+iTVw4PwPwI6svJq+U/Cc2do8UgvUl57QswQvHC29L8VJnrNlNpSP
	XLAKWHRK+AzJKQXv2zZ5QsBPAuFnblZTFMzbDJ9UbhNOP6pn26Nsl4HKwx2nwg+y0Ctgil
	3RPPY/t+Py+f72Xk88p45eYRJxU6iI4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-t677tnRGPuagrKrk_CbJAg-1; Wed, 04 Jun 2025 12:53:06 -0400
X-MC-Unique: t677tnRGPuagrKrk_CbJAg-1
X-Mimecast-MFC-AGG-ID: t677tnRGPuagrKrk_CbJAg_1749055985
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32a72e28932so5695561fa.1
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749055985; x=1749660785;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6psz76j6Q54BLu/dla5y9lVeHPkpDqvYnlf52GvYWU=;
        b=lKucEC18LQo348Mz0fb79vcHkDRJ3iGX2p1a7k02gNxmNlGR2mnmll5tnR8T7yTE9d
         YZ779lzgD6ZRhYfW4GoUXo9Ox14c41lYMFmtPzHymUNUFt6CtEddwi/+WEjWswemjLYD
         lobMjeV5c9GHB2qaIX0yF9CyJufB0rLFgpaPSSBrPE/re7IsINb7acy4M7NRkVNqHTl4
         NiRCTIKzKNpnrPqgD3Ah+moFp/Xs5w8zXTypviv3XZ9/XkYuN75o/VEYkMCq37Q4iNlC
         VyXQv68cgvukFE3Lp56ALeZhnBl7oel6iFRQYFdGdft5Ygw1z7CICBQNxktR986bzcem
         yhVw==
X-Forwarded-Encrypted: i=1; AJvYcCVACL6JWxn/7vhu5mkYUGtTD1B9Jv2eBxpvikzlpjJ15I2uNvXuh2QGg6pk8qvOuSBUXD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzsO+DsRc3hftZxj/DTQZ8JHi+TDk+7Sz4sJYPr8COBvUq9ICb
	ODX7guI16SJIgDJbabF/1pnqLIGvbcOW68CgNbdPDslg8atvcrl9Ldxi+reoQodYDhWgZhNsqln
	LvpDF0AZb0FPdsL8EHqxXdJU9xgeoKYGdGyO+oN+kIie1CKniCIkcGw==
X-Gm-Gg: ASbGnct0fIjbyn0yFZeJat7vePDvawA33xfVt+ewkudWYaswHyTCrjp8qS9hD2xHHQN
	Oq7wWimd4RFDMUfp4zV7Sg4SPvzj58vSsKjXFvTC/wS85734mEHtSocP0rltDZuzVYHh8vSA57b
	L0k0kfzX9BJfwi+ZA6xom8w4BYimE5dVtOcyhf8r2E0nMuMFtHJWBh+QOZLlg+4EV2ZiCId538Y
	VTf5p1/2eXXwf7Y4S/K5MiU8X6n7+j0KEaTluogurSMpg3N4s60fLOwZ9rT8X2IQoAUDqkCFh+m
	JILfingXS6lplLP8B/TdZqZCsun6EFaKlpG1
X-Received: by 2002:a05:651c:1508:b0:309:20da:6188 with SMTP id 38308e7fff4ca-32ad11be38amr1206351fa.6.1749055984824;
        Wed, 04 Jun 2025 09:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOVkK8aXlCZgkjT/0iG8wOa9KpXdYeRE73KlsXw6lWnYujNdB6WOp6huRvzJhw27fbEzbHrw==
X-Received: by 2002:a05:651c:1508:b0:309:20da:6188 with SMTP id 38308e7fff4ca-32ad11be38amr1206111fa.6.1749055984366;
        Wed, 04 Jun 2025 09:53:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85b527e1sm22753181fa.47.2025.06.04.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:53:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B3D351AA9156; Wed, 04 Jun 2025 18:53:02 +0200 (CEST)
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
Subject: Re: [RFC v4 01/18] netmem: introduce struct netmem_desc mirroring
 struct page
In-Reply-To: <20250604025246.61616-2-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-2-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:53:02 +0200
Message-ID: <877c1rwis1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
>
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, and make it union'ed with the existing fields in struct
> net_iov, allowing to organize the fields of struct net_iov.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


