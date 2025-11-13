Return-Path: <bpf+bounces-74408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EA8C5799F
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 14:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC035525A
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288B350A04;
	Thu, 13 Nov 2025 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rek854TF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9zLXFdF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1172C21D8
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039804; cv=none; b=EL+Eh+KtHtXSeaGADK1F91Wmfdyw4kwnhCr+WOX93P6PeVrUpG0ZB+r6YbrbsqKFldA3Ho3CqIj811h1I56m8CODJlOoYmKDQpg/ZCtxt0jEc4DLzljnepnklpDnkIH1l0vKTKr9KsPqtSYuC+vy4dmy/EFgOioJtTXrXyVfvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039804; c=relaxed/simple;
	bh=9vAPeMTFO0eBnz1z3RP+JUWWUOUJ64sbjllUUULC1tI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=he3i1DypZ2XiShzKPXEA6P6feD7TJ50tanZcvbaOG2n0ci7XMO0ZU8SXaP4xAQ9a6P/zjLSNUdNW8AROSqzV6z1xtCTnxZ73HNsyYpUKGFy6DUi03P4A7K4lT9obsibigfbxXV+zCK3aWMNNd6Iwv0A2rMu/OE6cgpPeBI6mS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rek854TF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9zLXFdF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763039801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vAPeMTFO0eBnz1z3RP+JUWWUOUJ64sbjllUUULC1tI=;
	b=Rek854TFxnAKfYKWm2nrR2LDfpADm1im5ESCGw0cbRUXVXm6LjA9x4mc7VmKp1Wn2ooBrS
	bUwemOk//Ji8ztvjwlv6djZuusVfGA9FgU4siExe8Nq10/0D3hoN7ggUdaBs3/2rsvT6CD
	3U4kKQAerQ1z8bgEbLfKnugtdEzsF0o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-lm8yHlPVOrGPIyfPrFBm-Q-1; Thu, 13 Nov 2025 08:16:40 -0500
X-MC-Unique: lm8yHlPVOrGPIyfPrFBm-Q-1
X-Mimecast-MFC-AGG-ID: lm8yHlPVOrGPIyfPrFBm-Q_1763039799
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64097bef0e2so1097825a12.3
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 05:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763039799; x=1763644599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vAPeMTFO0eBnz1z3RP+JUWWUOUJ64sbjllUUULC1tI=;
        b=N9zLXFdFYpV/osHscfn7TdXBBfd5UFZvIppK9EQQoLWEGDVKnu7QTJK8Gvz5AT2Dit
         yfRz4k5Dx5DaSV5v5RqehBpn3vSIIiRvw7VnYm1OtQIW2ndijSvhoSEDD25A56VS9YaB
         C1YTQbGUZK2WEOrfWdFlNocb8r9FCcL94EQ+CnWQqLz+U/Ij9MSMRvHNRsp91qEANUiK
         VEwFewCBFtOSPQK7PmJZK/aa24MnwoPEqs6w89K/k0FvU3XiF97l5/gw7nGe8hlHXvv7
         /ongoYI09PSI8XPah4a+qRk6bp+xvg+BLQJGKncEMylvl1EpSoxTeLGkmeWW2cMVuv5+
         6qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039799; x=1763644599;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9vAPeMTFO0eBnz1z3RP+JUWWUOUJ64sbjllUUULC1tI=;
        b=IaGKskJ9oFVWxNqyB4r+5PHc9KC0SP7OrqutOFNv6gHnIPpJkSFd+52KFRqmHg/xf+
         npMFomAstiy/czLQlymwTHOoBYdLZgWZTsDYshzmFmH6KB42daQ4qX6F1BVRKMUL30SH
         rBpqRI6TMgRxqYNGjE6V1KlS70XM/fa/JQU9C1zjHrpt1+kQrtP+vnFaNfJmtkMBTCJo
         WTPT2KwkGTpyuDM4YjIBEOq8h+I5fuwRfZ7D+lusAC0FMgALp9ooUnqCUbQIOFrcskMi
         qz/pQD524KKpGkDQkaTtl8T7wjn8H4IRGZ1b1kc1UcF7tjpJKYdqYGHYbL3RuS8hZFm1
         BErw==
X-Forwarded-Encrypted: i=1; AJvYcCWTICoZke8l9XVjQztIHzze2R8TDwMHKrERCJ+P+fUbLF1ECy7cxHWJAaMYFOr/BJeXkJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW0RV1/s0hcHY30hM7XKzsaatrL37Ow9qf9d24pjFk/HI0ACX2
	cxvM1GusHApTKwjEQdzQy5nW7jj7KHuL3w3ywRF1klF2Je0TjL/kXeOnqiOq4Yi/ONdlRzydHY7
	ibaFTrfZ23pAEu4LMM4gAiUsFO+IFd91n5ZhpEx1/OiKmMAhtlvrnOQ==
X-Gm-Gg: ASbGncsdAV1qxBuAezeRIzHAHvpfJqeWA8ARdHkUAxmtob3Ok4sol5hJJyLk+c5tl2w
	xg+ag0nqButZGBI6xqtrd0I7KtSWti1xtpVUWZlKTc2SmyuZOgPQFqBAK7jEgqQDHVkSdWa2Yhz
	HsQPeQgSlT7kK7eg+Vye/LDi75flEamlgnPPHZQkFx88Hlzxa6w5ufjN3zzBBfdzdBKlomDJO4g
	UH2dv4+7adgikVG+RQ5l4eAWfdXo63rG3fUTQ0DtFwRDj21486q3btsWMXP9pn9WhW/nK4JQnUf
	8zXH3wxkSGhKEBKMCmb58RXJxkd8cxNVTMB6MkEXqbHaJSDinwud543BO0R6hd1DsXnzXNa9g6W
	LKtafXRl4jFtL/J6xc1rnb+YgZA==
X-Received: by 2002:a05:6402:3246:10b0:640:9b11:5d65 with SMTP id 4fb4d7f45d1cf-6431a53869cmr4852173a12.24.1763039798813;
        Thu, 13 Nov 2025 05:16:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLcdyRRLd6FFTpnP+EhRUxFYbZIck3c6mTdTrBYOE3QCti+/KF//8k0n5mO+GBPIWDghFa9A==
X-Received: by 2002:a05:6402:3246:10b0:640:9b11:5d65 with SMTP id 4fb4d7f45d1cf-6431a53869cmr4852148a12.24.1763039798370;
        Thu, 13 Nov 2025 05:16:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f8eb0sm1495033a12.12.2025.11.13.05.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:16:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8CE6B329799; Thu, 13 Nov 2025 14:16:36 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, William Tu <witu@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Alex Lazar
 <alazar@nvidia.com>
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
In-Reply-To: <60c0b805-92e9-48c0-a4dc-5ea071728b3d@gmail.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <874iqzldvq.fsf@toke.dk> <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
 <87ms4rjjm0.fsf@toke.dk> <60c0b805-92e9-48c0-a4dc-5ea071728b3d@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 13 Nov 2025 14:16:36 +0100
Message-ID: <878qgajcnf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tariq Toukan <ttoukan.linux@gmail.com> writes:

> On 12/11/2025 18:33, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Tariq Toukan <ttoukan.linux@gmail.com> writes:
>>=20
>>> On 12/11/2025 12:54, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Tariq Toukan <tariqt@nvidia.com> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>> This series significantly improves the latency of channel configurati=
on
>>>>> operations, like interface up (create channels), interface down (dest=
roy
>>>>> channels), and channels reconfiguration (create new set, destroy old
>>>>> one).
>>>>
>>>> On the topic of improving ifup/ifdown times, I noticed at some point
>>>> that mlx5 will call synchronize_net() once for every queue when they a=
re
>>>> deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
>>>> that to amortise the sync latency over the full interface bringdown? :)
>>>>
>>>> -Toke
>>>>
>>>>
>>>
>>> Correct!
>>> This can be improved and I actually have WIP patches for this, as I'm
>>> revisiting this code area recently.
>>=20
>> Excellent! We ran into some issues with this a while back, so would be
>> great to see this improved.
>>=20
>> -Toke
>>=20
>
> Can you elaborate on the test case and issues encountered?
> To make sure I'm addressing them.

Sure, thanks for taking a look!

The high-level issue we've been seeing involves long delays creating and
tearing down OpenShift (Kubernetes) pods that have SR-IOV devices
assigned to them. The worst example of involved a test that basically
reboots an application (tearing down its pods and immediately recreating
them), which takes up to ~10 minutes for ~100 pods.

Because a lot of the wait happens with the RNTL held, we also get
cascading errors to other parts of the system. This is how I ended up
digging into what the mlx5 driver was doing while holding the RTNL,
which is where I noticed the "synchronize_net() in a loop" behaviour.

We're working on reducing the blast radius of the RTNL in general, but
the setup/teardown time seems to be driver specific, so any improvements
here would be welcome, I guess :)

-Toke


