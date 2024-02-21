Return-Path: <bpf+bounces-22402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1703D85E026
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 15:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19E91F24F63
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD367FBA4;
	Wed, 21 Feb 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goBDxIuD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB679DD7
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526727; cv=none; b=mdyhD/w5xfJPm7kOc/CVAVqZDIENOXpGo76Y8vJp8/V9L+CbxMwtiVMPyDJZGKORH/KG8aKritkuvjZ65pwr7Rj1Mtkm66Xo9JhgSQvuJF1w7cKgIO4P95KhvdZlyFHeHS+YZG6VVSKkHt77VfC4+L+OFzaoq0Rk5DXKgE60bVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526727; c=relaxed/simple;
	bh=TF6Jk4G9pKDpFKD38K4laHdELjPZgfrs/lrgj4o7a/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ad1ZHsNAghQzPvwacmqQZnVFM0/QdKedhwi7I9AD9QOim2vfxuVvhTTVup0OE3e6BlUp3HE3SRRnbH5/Btns8rxNMtW+Uql0+kwIemXOVNtkhWQGzWPCcNUBFxPu5LDOYRToc5IE98Hi6BiQOr/K+dYxVAblHK/uRjLEKX9FOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goBDxIuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708526724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WryMDEtQzvcbTVLA7pUg1xW62/aEPP+0OIGRV4dqoyk=;
	b=goBDxIuDfA+hfGwg1jYEE6bWhihduyqEI4uZp9n6Dyjx1A4JOTw4KYUR+e+mfuIHtbrY7h
	SnjdI3oSVv0qtw475Y5w1DY2JUkqEyQZv2pwLff8LSe14jnVZtD7NmEXlvd1DydRl/E4vW
	PabQzFz+D0nNfu5U14ssptSu6ZRS8C4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-hjuBOXpWNGeRHLwdIDkIsg-1; Wed, 21 Feb 2024 09:45:22 -0500
X-MC-Unique: hjuBOXpWNGeRHLwdIDkIsg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-563e8ae4456so5003731a12.1
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 06:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526720; x=1709131520;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WryMDEtQzvcbTVLA7pUg1xW62/aEPP+0OIGRV4dqoyk=;
        b=XQOknWqYvtMH22kgHNIRzoShmY/3Bi15813YZ5/GByHxhJqhyV2zWG4T9mVPYWgGaK
         xiQduzitvw420lghYh6tznALR0OAiEHJLycbUVkgNK2ZpDMl2lV2ztfJ6xTgHYbpIGui
         G2s2t89nG5ZYoiqU1Oi8HU9Et5AVwoW2+yuAA0qwXZl/gP3Wh1iqLqxhgCts0nRg4gWw
         7qab0K1qZ+zDD4yiSM27LMKXCnU4ceK73FoBf2xLDeum1XH8EEj10DzN1dm+P5pdEaLv
         K8NTjwqP5m3iA0qxJpMIIN5wAxEgQdPY5CdYIYMW8lmw1EfhxzdgkTdZh/zeN2TWoWev
         vegw==
X-Gm-Message-State: AOJu0YxscxV6vMS+t/LZWD6ZFBP8WQHqpcIIe3uHLx/WytRVpsNCFV5u
	vT4A+Q3R0n9oXIAU+CUPBJEto/ZQ+2hPM2ShIZFqz8UvXuY6qsigpnuhHYgmCcKsnS9jCTiJet5
	vbKFYIRZFLiqe3HSlh8EkFVhWwxiWYMlNTvsQ0QMX+gVWgFFN1Vly3+b+K+w9/tO6VhzZDfG9MB
	PJwWdNjUl9k28cTG+R3zvESXm8D53g
X-Received: by 2002:a17:906:280c:b0:a3c:2f68:54a9 with SMTP id r12-20020a170906280c00b00a3c2f6854a9mr18329483ejc.3.1708526720815;
        Wed, 21 Feb 2024 06:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc1lbczJ3wsvQhn5i9HYuwfX82GuZPtUB197i5UxA15lCRen6tSrYAGbXCIHHZayd2fdT50w==
X-Received: by 2002:a17:906:280c:b0:a3c:2f68:54a9 with SMTP id r12-20020a170906280c00b00a3c2f6854a9mr18329465ejc.3.1708526720445;
        Wed, 21 Feb 2024 06:45:20 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090699c600b00a3efe1a2878sm1612270ejn.137.2024.02.21.06.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:45:19 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 59D9210F6580; Wed, 21 Feb 2024 15:45:19 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Change BPF_TEST_RUN use the system page
 pool for live XDP frames
In-Reply-To: <20240220210342.40267-1-toke@redhat.com>
References: <20240220210342.40267-1-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 21 Feb 2024 15:45:19 +0100
Message-ID: <87v86hzxj4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Now that we have a system-wide page pool, we can use that for the live
> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
> avoid the cost of creating a separate page pool instance for each
> syscall invocation. See the individual patches for more details.
>
> This series targets net-next because it depends on this series of
> Lorenzo's, that adds a global system page pool:
>
> https://lore.kernel.org/r/cover.1707729884.git.lorenzo@kernel.org
>
> Changelog:
> v2:
>  - Change the cookie that marks the page for recycling to be a 128-bit
>    value (Paolo)

Alright>  - Add a patch that removes the init_callback parameter from page
>    pool (Olek)
>  - Carry forward review tags from v1
>
> Toke H=C3=B8iland-J=C3=B8rgensen (4):
>   net: Register system page pool as an XDP memory model
>   bpf: test_run: Use system page pool for XDP live frame mode
>   bpf: test_run: Fix cacheline alignment of live XDP frame data
>     structures
>   page pool: Remove init_callback parameter
>
>  include/linux/netdevice.h     |   1 +
>  include/net/page_pool/types.h |   4 -
>  net/bpf/test_run.c            | 143 +++++++++++++++++-----------------
>  net/core/dev.c                |  13 +++-
>  net/core/page_pool.c          |   4 -
>  5 files changed, 86 insertions(+), 79 deletions(-)
>
> --=20
> 2.43.0


