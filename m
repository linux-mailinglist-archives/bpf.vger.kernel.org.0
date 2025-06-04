Return-Path: <bpf+bounces-59654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C584CACE28E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C861779CA
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305B1DE4FC;
	Wed,  4 Jun 2025 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj4rCBMa"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF01EBFE0
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056152; cv=none; b=VpkNRClUGU/NJqAmFFsBnB2AnOfZoynnTtUON7JDXCo3/vY2CP2xTOKsRle67kvSMBvqA6FhfdB15ElJfksBjX0vxN4kRtM3TKnG/rJFHvJLlM4z8PVWpdZVqMtdMien1LXwYNMyazcz4GjDGftLX60PTiBB7hPBJtcHnC78Gjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056152; c=relaxed/simple;
	bh=8Sw6ZrIatdp9zV8VYnA2N077NI0xfChsEjWe7K4eQws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1vQm42ndwNyXz9oU8Bc4U5Qx0d36BCL/3UW7QJk8x4gr318mEepwUuh5HHm8u0OnLV/+XS5PlX7Rk8HUctP6NjtDbq8Icxz8Dv4hsls44cTm7h+EDp9lnYXH/TEOUYWREDGHbiun9X0ON3AOfVepY7/hD8XRInZ8rQgdP++kQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bj4rCBMa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Sw6ZrIatdp9zV8VYnA2N077NI0xfChsEjWe7K4eQws=;
	b=bj4rCBMahxrglJlQwhFjCbyHi7++XPXL15t3/hPuGy4AuNiDw7QafJ1izFDKdxAp3znrhD
	K4r+txjXX5xmrkBy5rWaxSeREy9tbsJY2cVoMjE3stnXnYAtPUwI0tdoz1oXK5LSew8OzE
	rOoq63oNzPfp1G57N/2ibKFz6PgAcCQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-MErEw7lQP7-s5MXl2wqaww-1; Wed, 04 Jun 2025 12:55:49 -0400
X-MC-Unique: MErEw7lQP7-s5MXl2wqaww-1
X-Mimecast-MFC-AGG-ID: MErEw7lQP7-s5MXl2wqaww_1749056148
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so1848266b.2
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056148; x=1749660948;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Sw6ZrIatdp9zV8VYnA2N077NI0xfChsEjWe7K4eQws=;
        b=JhtNk1W0JEl/wmlReDg8hR9nz3yOwNGdr+XFVTREZRcFaMRypTuMLkdNUkX8CdtUMI
         aKEilEqccingrTpz/at2skv2HXqcHlERzs4a7MtTU6fZYV6hZMbQ+IG8e5DDdk23F26D
         xFLagAdpzaNK12zg2RYbz1BaoftddolKA/xY8KF4A5MMwDZvKPeYHCdGUUBCXnGr170/
         LqnYAGNyR6UZq52bWC/UFp8UkFu+8fYFjTZwhlfZ7xn4TKvHqgnnFzkIKhncVWvUaU3O
         3l2ikRFFL2HYO0fZQ8rKgSewcGK3z5nb0Ouah5R2K+M7LIfjJ8Uh+qo0Ekcy2/Gw3OQY
         g4XA==
X-Forwarded-Encrypted: i=1; AJvYcCWeG6ZvyeqbQkjyHuH7Im6X6Cxbj48qfzSXsXdYOy0+BUcowvYO44F7WcM0y+GKBcJ4JOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUPeeJw29hEaiyCGUkq26Albwltr1HIZE5QPLjcGwv0gA/34Y
	4u/QlYKMqC7td/22RBAVDoaLYn6nFlQopmdABOrznTdalgYQ+ifv4rI3KrRKb2hxMvhFxHz8Xzb
	UQaEbyJl3BFuTjVetbCu+hWjaoXB+qoqeDgQHzuV07+YYDJgw/huxKA==
X-Gm-Gg: ASbGncv7dqpkthmI97FPHuiBIAMm7+bUC1UkQsb3FrnH5Q+ZwapBgHHITd9LwHHd3pN
	MKn+z23gcflPKX8wF4DS4orD5PNBEFXNrnQhFv5nm3tdvyIx2X7pv32yhv/azyBxjUT7lck4KjZ
	09e1PFSaNSCkf5hBL7HczfsvjbS1CBZ1mhyfvAWb9nB9d9veswpPO+hR85rnAR+gWKDHYAQwxbS
	G2O0Mrt0zy/PelMHM77urY1BpT19SN7b0fQtoapT4JYz+SOWR3btzbg3xPFYVwvENBaJC8Lz77w
	t2HQltp4OCldi4WnRlpDMeyvNm+hjlyupJFc
X-Received: by 2002:a17:907:6e9e:b0:ad2:4fb7:6cd7 with SMTP id a640c23a62f3a-addf8c99908mr343450166b.2.1749056147775;
        Wed, 04 Jun 2025 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYPG/Bjmaa00gr70znOgvLxuMNOHBq9tzeMq8cTFVTOyJdUQkjk6QowoSWQ/jATpsw4qluaQ==
X-Received: by 2002:a17:907:6e9e:b0:ad2:4fb7:6cd7 with SMTP id a640c23a62f3a-addf8c99908mr343446666b.2.1749056147365;
        Wed, 04 Jun 2025 09:55:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd043a9sm1117788866b.89.2025.06.04.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:55:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EA8FF1AA9162; Wed, 04 Jun 2025 18:55:45 +0200 (CEST)
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
Subject: Re: [RFC v4 12/18] netmem: use _Generic to cover const casting for
 page_to_netmem()
In-Reply-To: <20250604025246.61616-13-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-13-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:55:45 +0200
Message-ID: <87plfjv432.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> The current page_to_netmem() doesn't cover const casting resulting in
> trying to cast const struct page * to const netmem_ref fails.
>
> To cover the case, change page_to_netmem() to use macro and _Generic.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


