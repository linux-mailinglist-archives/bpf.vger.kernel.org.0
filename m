Return-Path: <bpf+bounces-22323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD985BFCC
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01769B22401
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4AC76036;
	Tue, 20 Feb 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LB6JEXLp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA96F080
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442686; cv=none; b=Qp1bD5drm2OQBByAUrmFGkbL+nmrPL1Nof2LPs6JG85SFo+u0c3mPw6IIHInX+BbBuD9AvmdJ+0IsBmHV/Xvw6zYs/h5vKW52l+BjzUecnbUK+pLuoi0Qx7KeiOjlsTFM6sUdUkZzMnSWR5JPRDF8iByhV6G76BAEliVzzFiT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442686; c=relaxed/simple;
	bh=6pODhE1Zx33BITaVfHpYG18YCzm7URFOHUcj+WO+rLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6xGwWO/1bG5ju50fpCOs7evotbFdwME/6u9tXrwXoC3wcq9TNsIAgMbuEBUzB70ZvSmwT5iKgX6dDp6x2I6BwEfKRAMH3GSet+s+4xAnfndIaQKY1oifoopGH0Q8LPGOPehoBk1CeI7tTx/jv/FL+L4eZO7MR/3b6tSOxr+EYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LB6JEXLp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708442683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9SenMZraiZayPUOD+gOhwtXJEGEHUkO84uIul9F3WI=;
	b=LB6JEXLpBjmtsa0ril3db0BF36gwCX49BZXVOljIOCF+QeRJ7AF8/Z+pJ9lovxbY3bqZHn
	SSL+LoP2ijNcOWo7rA88/8QyGH6/bxQAKGEJIJuZKIUMnHfrNr5laBpKUVG3RmOaERzBhh
	cCk2ZBaR/+MXHrM+djqrpe/l9sxPRb0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-2MYehGfUP4q192WpV1Bqtg-1; Tue, 20 Feb 2024 10:24:42 -0500
X-MC-Unique: 2MYehGfUP4q192WpV1Bqtg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56451e5801dso1014782a12.3
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 07:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708442681; x=1709047481;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9SenMZraiZayPUOD+gOhwtXJEGEHUkO84uIul9F3WI=;
        b=JNgSwVaZBNEcn9pwKfJUQzYIPNCEolIPkCIPTC/LD0V6/WTqwAxjM7jb6t73YCVrdD
         IWEq5+Z/ZbrZ/C6J+CCPZP/WP09aIHScHBk9hxxGghtAqcKEYJEFJtCkfcx7xQ+Gq0Yh
         UflKbaBAj1BDiHS+S/lpH8Mt/cQ0SgXkhd227Fu9LJ1BzQq6xfSGft4n4KtSfJWHhxOW
         TBNV2atLih1wGzQ9ZCFCa5b7WhgpaJJqc95IeuhC6H5p/Xfi2N11rg48k0AT973prpp6
         lac607C6VJQRh4TWwSNrVZ30Be0LokmSzdC4V0f6vFwRlZwqhVavG+R5Re+CW4tYhzgb
         0NKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdY3WpkzWI+HJ0+JeMQU4qKrnPTCuc5zbk5aU9Lv/nPslzODGH9/0cqStqcUXUjhO619/I4NwrycXLp8rOBni7eEz6
X-Gm-Message-State: AOJu0YzjTe16ONhb1R9SO/HshfKZtU9/eNvMf+yfjW7EHTEXz628RYdK
	iKegMkNzXp1+5IdQ9f94RdwwgOFOydx+Y0gOx29eiRAPia/XYEz87vQ+dhi8ShvBXJTRG6qH4Qw
	ROOLY7dMCTvBs3vqXxv30kkmMvdln8BYTUQi2L1iaJZ6kNyWnKg==
X-Received: by 2002:a05:6402:5248:b0:564:a994:a057 with SMTP id t8-20020a056402524800b00564a994a057mr3003407edd.27.1708442681248;
        Tue, 20 Feb 2024 07:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4wtxriL2KMIYt/yB8VHu8FLT9P/BBDR5P19wxkJzVrZ3eljIjp7F5KDgJZPsPWvAWx/hRlg==
X-Received: by 2002:a05:6402:5248:b0:564:a994:a057 with SMTP id t8-20020a056402524800b00564a994a057mr3003388edd.27.1708442680922;
        Tue, 20 Feb 2024 07:24:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g7-20020a056402114700b00564d7d23919sm371072edw.67.2024.02.20.07.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:24:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0561710F638B; Tue, 20 Feb 2024 16:24:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page
 pool for live XDP frames
In-Reply-To: <c888b60a-0be5-8e7c-0fa0-8039e691406a@iogearbox.net>
References: <20240215132634.474055-1-toke@redhat.com>
 <87wmr0b82y.fsf@toke.dk>
 <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net>
 <87o7cbbcqj.fsf@toke.dk>
 <c888b60a-0be5-8e7c-0fa0-8039e691406a@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 20 Feb 2024 16:24:39 +0100
Message-ID: <87cysr17m0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 2/20/24 12:23 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>> On 2/19/24 7:52 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>>>
>>>>> Now that we have a system-wide page pool, we can use that for the live
>>>>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>>>>> avoid the cost of creating a separate page pool instance for each
>>>>> syscall invocation. See the individual patches for more details.
>>>>>
>>>>> Toke H=C3=B8iland-J=C3=B8rgensen (3):
>>>>>     net: Register system page pool as an XDP memory model
>>>>>     bpf: test_run: Use system page pool for XDP live frame mode
>>>>>     bpf: test_run: Fix cacheline alignment of live XDP frame data
>>>>>       structures
>>>>>
>>>>>    include/linux/netdevice.h |   1 +
>>>>>    net/bpf/test_run.c        | 138 +++++++++++++++++++---------------=
----
>>>>>    net/core/dev.c            |  13 +++-
>>>>>    3 files changed, 81 insertions(+), 71 deletions(-)
>>>>
>>>> Hi maintainers
>>>>
>>>> This series is targeting net-next, but it's listed as delegate:bpf in
>>>> patchwork[0]; is that a mistake? Do I need to do anything more to nudg=
e it
>>>> along?
>>>
>>> I moved it over to netdev, it would be good next time if there are depe=
ndencies
>>> which are in net-next but not yet bpf-next to clearly state them given =
from this
>>> series the majority touches the bpf test infra code.
>>=20
>> Right, I thought that was what I was doing by targeting them at net-next
>> (in the subject). What's the proper way to do this, then, just noting it
>> in the cover letter? :)
>
> An explicit lore link to the series this depends on would be best.

Alright; seems I'm respinning anyway, so will add one in the next
revision :)

-Toke


