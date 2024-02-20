Return-Path: <bpf+bounces-22314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2965385BA78
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 12:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB831F25D88
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800166B5F;
	Tue, 20 Feb 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tt3N7L2z"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1AD66B5A
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428234; cv=none; b=XTbhKc5IUXzBFJR2SUhPthT9zZvflbRyHf2UuVsWyO0MJuCOdJZ/TBoOiGnsG7OFrzIRP0Eha5cUTVOcOXILGmlzrx46pw4/wWn7DQ/5uzjgAlSZ0UjSc+baYBm4hhv9GuKIC24vLfkvDv70pGl76YU9ZR1Wb9P/DgkpM5QCyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428234; c=relaxed/simple;
	bh=/m5l675lvhpdek52eIYzQ2WRIO9Em8rH6DpHO14nHoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8rCIeNISce8GAr8pOw1xOmw4PgtTZA1Byu+In7iSrxhuDJVwgpNNvTdN0KJ0/PvKqcPcwuvX/5OGoUDiWl5UrTnP2cgiYFZ31+S8PEzQTc+RRGcRfFbC7XWdqjehjrqB7nslumMrx34w9CkcPphHcPle1d3jTrzcp2lN91IMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tt3N7L2z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708428232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHBopp27NiYjGG/312hFWNf4Ro7Aht8Q8wDQZilTwiY=;
	b=Tt3N7L2zHxfK1yCz8i+eaFnKrR8EtZ5lQSKtUEo5gRlCdWV0zj0nnlKm+hpLN4fUiDe3il
	DvS+ksHa1QNk8TQpgFIYwTLEalsaZv8GBfdITauz5OBE4NjCAEJucCx9R+mmv+NkaQKkdm
	hTXtDAtBC9ADlxC1w7l/YjRW1drV/us=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-ta8fuCONOBacyk7pCPKm1Q-1; Tue, 20 Feb 2024 06:23:50 -0500
X-MC-Unique: ta8fuCONOBacyk7pCPKm1Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2cb0d70d6cso366058866b.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 03:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708428229; x=1709033029;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHBopp27NiYjGG/312hFWNf4Ro7Aht8Q8wDQZilTwiY=;
        b=m0hU7bc0ddf0RtwXfXNgGW/oIhFCajFYyPb0Id3eQrXcFjDKViSDmOL1oExtPwPNhM
         9gfKqT2KjnIB6GZkHK33w/wSHDN8WrBLfbftqtyNWq9eC+4tjqhfo8XUmFojOMgDBkmi
         7sxwXvHRjknBQIg1oCVTuh32CY/tkfTNmqDC1AWwRzZc3BsW/xfN9JV5p2bHRbVUzSuE
         IJfl5JIedRHLG7I3gQjwEA3D4RHAQtOhgfN6ZIyN2Bf6mxA1EnIORm9d3486Bsw43TIg
         KqUMiJEu3qasJBa7ZFXBHk0wzEgLYBbrN/vZkcqdKOuLwqJXscukTfu/JhJkYDJ5h4Rz
         Bjmg==
X-Forwarded-Encrypted: i=1; AJvYcCUjTgxnr+sGQGI8mYigls3PJBnkXf368cCKMRsc238ea0/uJnofsQklGBi+w8criicAduz5fn8gF8NqjYcZu3pJIEdz
X-Gm-Message-State: AOJu0YwmLJcETSqtd5+iwLl11Dm8VErM8JcWPH/55BlnbBM8P+JDZiF5
	35NE0LU4t85mtmDKRQ9QxtmgkXkmffJt0ldaOnfa3yHvDPUqjxb2a3HPNnU8CkXTe5GQeY0h5Yi
	m4oqZRchDyDRvx19s6d1D5SwQ3sPuzwdlIuWE5L1MeDls47xonQ==
X-Received: by 2002:a17:906:6b99:b0:a3e:6a25:2603 with SMTP id l25-20020a1709066b9900b00a3e6a252603mr3484338ejr.33.1708428229730;
        Tue, 20 Feb 2024 03:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn+dYqYLg6+WkxQUfBYPRXWnBfJq01cV9qnvwWwoJA6M4vithRhzp4KiPcpYPiB6huGquIYw==
X-Received: by 2002:a17:906:6b99:b0:a3e:6a25:2603 with SMTP id l25-20020a1709066b9900b00a3e6a252603mr3484320ejr.33.1708428229358;
        Tue, 20 Feb 2024 03:23:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ld1-20020a170906f94100b00a3e82ec0d76sm2214072ejb.113.2024.02.20.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:23:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8C19710F62CB; Tue, 20 Feb 2024 12:23:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page
 pool for live XDP frames
In-Reply-To: <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net>
References: <20240215132634.474055-1-toke@redhat.com>
 <87wmr0b82y.fsf@toke.dk>
 <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 20 Feb 2024 12:23:48 +0100
Message-ID: <87o7cbbcqj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 2/19/24 7:52 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>=20
>>> Now that we have a system-wide page pool, we can use that for the live
>>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>>> avoid the cost of creating a separate page pool instance for each
>>> syscall invocation. See the individual patches for more details.
>>>
>>> Toke H=C3=B8iland-J=C3=B8rgensen (3):
>>>    net: Register system page pool as an XDP memory model
>>>    bpf: test_run: Use system page pool for XDP live frame mode
>>>    bpf: test_run: Fix cacheline alignment of live XDP frame data
>>>      structures
>>>
>>>   include/linux/netdevice.h |   1 +
>>>   net/bpf/test_run.c        | 138 +++++++++++++++++++-------------------
>>>   net/core/dev.c            |  13 +++-
>>>   3 files changed, 81 insertions(+), 71 deletions(-)
>>=20
>> Hi maintainers
>>=20
>> This series is targeting net-next, but it's listed as delegate:bpf in
>> patchwork[0]; is that a mistake? Do I need to do anything more to nudge =
it
>> along?
>
> I moved it over to netdev, it would be good next time if there are depend=
encies
> which are in net-next but not yet bpf-next to clearly state them given fr=
om this
> series the majority touches the bpf test infra code.

Right, I thought that was what I was doing by targeting them at net-next
(in the subject). What's the proper way to do this, then, just noting it
in the cover letter? :)

-Toke


