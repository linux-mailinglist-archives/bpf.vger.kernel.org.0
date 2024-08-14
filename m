Return-Path: <bpf+bounces-37169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E2395188A
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE35228628F
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B31AD9E4;
	Wed, 14 Aug 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cD6jR9ZJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07214264C
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630787; cv=none; b=GXIvMcsWOwjYbt7yv109HxI2zjgRz6X+sdxoEZQBTaNGMe4lPPVVQ67syxPL+UGgpV88v090gkxC3n7l4QxDT635iRlT5NYugDUpovuGhyFe039N5vS9sL/GMUkDsAu2agBENRskg8rWN43FJl3GxBlWYGTzIW3ZEHIqnphnkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630787; c=relaxed/simple;
	bh=FZz7rN1iHlj31dNr3oGwlQhhvu2v+gYIwV29BtDPZZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P8EW6xTchPEhnVDY1x8taC3esqUHe2WhptuQOLDfQ6qmxmNUBS1VJlRLO9AFVIruj8pxMz2lcBgcYwYoHhqdkA650u+eulv9h/N8cCJUo0Qoolx9RJ+72dYhNdnXoyyeKFiKVK8J2vnIBQV7uhxH/BQ9iIUIcVV1c3RkFUUVsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cD6jR9ZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723630784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujjRrY9jmmA5hNr8cZIFcVaa3uq5D7CrEXBCcjjRwbY=;
	b=cD6jR9ZJTju5AGr8dlYOIGO8A3TytJOAhgTxBxkc6NGoeduhzoytp5bZwJmpIGeL/sOY2L
	OA1irGSmK6mYr84jO3i0DLtVXezQ30JIW3GOTiVY19Q8dXpzcdypPeaNg0a8NNPUHXa2L2
	xcGtHXR/hZWwEM581jZ/mnJIJNJehL4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-oePiHlFGP0aHui8E7jCKYg-1; Wed, 14 Aug 2024 06:19:43 -0400
X-MC-Unique: oePiHlFGP0aHui8E7jCKYg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42807a05413so46625055e9.2
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723630782; x=1724235582;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujjRrY9jmmA5hNr8cZIFcVaa3uq5D7CrEXBCcjjRwbY=;
        b=UGjsM8i25MM0Kv6v7v0xJK3i5ScIGH9gXxMC3KMUJL4ONIMWWczlJTUyxqY6vn4vSg
         +rdKbnNZidvFtkokKreaR8KGGOlL62z+J2+IaNPfyUY7lWq0czMsnzTY9krTpf7V8/ai
         KvEiG7c5/id3ey1QlKZn/hEwCSKl0OVL+rYJWuE8ST5vXXq0d6h92ErN5BtCw+e+ZFWu
         wh9lmUww7Hj7zQ14YKv6PewK+wv9B5G5m6PXyZv/y+JwodD/UbJxybBogJ+BzHjsK7Ua
         xIW6NBKI6gCd/qluUeIOPXymkh8DGXKlN2W9C/QeE23wWujIR+/BKV9unx3U3DdYIFH0
         GmEw==
X-Forwarded-Encrypted: i=1; AJvYcCXEGLCWgD56TpanQiX2pJMuxpjSJ2FnXqChzVJ1pLXEIaHE7Zgn4/SurcxEYj8iUv1IrxIMlTXQmlhaT/7Kf9NXl+LG
X-Gm-Message-State: AOJu0Yzco8J/PoCZ7MPT3YFn/JPoTgJcA6PTdgfM4L0ycnexQR5UWuVb
	vGDS7xrY5ZqODQQQKWGvfZkBE2Ke1pKOcdPEy6yeFL8XvgsaBMDYeKr+jyyDIARSHA7jpoGlsih
	SAZXept+5vHU8F+VOyxlZB9Y2OCeqO4luhtQCL+QaAlwGFD4+iOsE7vHPhA==
X-Received: by 2002:adf:e644:0:b0:368:6b28:5911 with SMTP id ffacd0b85a97d-37177760a1bmr1546848f8f.2.1723630781707;
        Wed, 14 Aug 2024 03:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC502yJUKbD+xbFsQIpm66zQN+FX64YOh1xGOvttuPua4rFxKJdQmq1Q8KvP6ui+G9bsDLMg==
X-Received: by 2002:adf:e644:0:b0:368:6b28:5911 with SMTP id ffacd0b85a97d-37177760a1bmr1546827f8f.2.1723630781208;
        Wed, 14 Aug 2024 03:19:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c938280sm12483923f8f.36.2024.08.14.03.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:19:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D04C714ADF7D; Wed, 14 Aug 2024 12:19:39 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Ignat
 Korchagin <ignat@cloudflare.com>, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>, Yi Chen
 <yiche@redhat.com>
Subject: Re: [PATCH net 2/2] selftests: udpgro: no need to load xdp for gro
In-Reply-To: <20240814075758.163065-3-liuhangbin@gmail.com>
References: <20240814075758.163065-1-liuhangbin@gmail.com>
 <20240814075758.163065-3-liuhangbin@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Aug 2024 12:19:39 +0200
Message-ID: <87v803csp0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hangbin Liu <liuhangbin@gmail.com> writes:

> After commit d7db7775ea2e ("net: veth: do not manipulate GRO when using
> XDP"), there is no need to load XDP program to enable GRO. On the other
> hand, the current test is failed due to loading the XDP program. e.g.
>
>  # selftests: net: udpgro.sh
>  # ipv4
>  #  no GRO                                  ok
>  #  no GRO chk cmsg                         ok
>  #  GRO                                     ./udpgso_bench_rx: recv: bad =
packet len, got 1472, expected 14720
>  #
>  # failed
>
>  [...]
>
>  #  bad GRO lookup                          ok
>  #  multiple GRO socks                      ./udpgso_bench_rx: recv: bad =
packet len, got 1452, expected 14520
>  #
>  # ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
>  #
>  # failed
>  ok 1 selftests: net: udpgro.sh
>
> After fix, all the test passed.
>
>  # ./udpgro.sh
>  ipv4
>   no GRO                                  ok
>   [...]
>   multiple GRO socks                      ok
>
> Fixes: d7db7775ea2e ("net: veth: do not manipulate GRO when using XDP")
> Reported-by: Yi Chen <yiche@redhat.com>
> Closes: https://issues.redhat.com/browse/RHEL-53858
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


