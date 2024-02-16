Return-Path: <bpf+bounces-22150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB393857E5E
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 15:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7AC1F25C8F
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BC712C547;
	Fri, 16 Feb 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgPIHn++"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84112C549
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092048; cv=none; b=l/Jt3mxspOJpsD634f+ye+5A139Qx+GVvq/AaZPLtSyRTyYTrZJcRMaEPA1ADF5YXZloDr9fRCbt6TzajlViIGch+J+ZAj1pSA0kF5xgYm5cwnBnC3mb6r5f0wiM02t8SH5eaPwY9mhjpv25ATzmB1OZKXho+HGYG6BCm+rZbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092048; c=relaxed/simple;
	bh=21ncnwEnUoXv+hRqMt7TP45+3FncijYHN5SkzR1tt8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyH14ebBHRNZZHC/eRpgxtA4M4rZJN5cDkPobgJl/1l+rkARHKlQ4+TZORFUJ4zbg1hgehf0WWHPJ++FFxwMgIZ/qHqpzjnZpV54d/NuLU+KG18qFhRTa66+F0r6u2ffqkXruoxQCJc2A8SmdMa7LD8f9RrDOt4PXq2+it2cx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgPIHn++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708092043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21ncnwEnUoXv+hRqMt7TP45+3FncijYHN5SkzR1tt8g=;
	b=VgPIHn++YfpHdQqR6DSBLjZ3CekDZh2RNoLshGN0xqJhXShEzg0hlqhOVxUnpLUC516r93
	LY+hVozaiwbJaqhMMwTB0qiHNTI7F7c5Jk45Va/Eej+t/nBNVYEtHi4KX17cZnR4vyHMSA
	5mnmYpV0IBumGEmqo5RDzdliltfdUQ4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-_QfNorBFMEOzGKKK2huw0Q-1; Fri, 16 Feb 2024 09:00:42 -0500
X-MC-Unique: _QfNorBFMEOzGKKK2huw0Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-563e2fec088so503553a12.0
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 06:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092040; x=1708696840;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21ncnwEnUoXv+hRqMt7TP45+3FncijYHN5SkzR1tt8g=;
        b=mxI5qSNiKi/RF+zFdcAWHSGvCnU2jYgM6/lZX9L/cck3YwmX2tjhCBC+MyRF5/saac
         vmx6EouP8rCXmOw/YYg4M+Mt5EEF+1siyG4XTwEOPKm500MLzshz6otlC/u07qdVATxQ
         jYRpHTuO3xVh1QckXAHDN1m0O9Z4ue3BvqfT678lJT7z9YjdFn6GN2DNKkg+rkuHCi70
         ybckNUNnOqHrOsc1dMu2GoLG1yrbCghtoMkk+B4SBB3yNzCwCJc7g6F/n+fg1REjX0hF
         LVhYm9p+N+tqtcseyQHZwsWO9zdzXFljL2BRa5qZ7anip6I26eXbV7+527n8Ouha3AjH
         q/xg==
X-Forwarded-Encrypted: i=1; AJvYcCV/2NCYUbIqc5/WIro53nIZhFhdmROWHmle2uqKWWzv5FtsWSvxuArjKbyX3obR+oNtX3kFvkgfzEYlwdFHGTIrsW+g
X-Gm-Message-State: AOJu0Yx7zj02zaFVx5mRVxbRXQBMtlNjFS+tHKeSN17pkQbKTZDTSjEm
	HhDsEBkb5+FwEHtRuXm1NyoUzYdfJ5z4cnMnou2mD/CiX+G1Q1/CPMzVtQ+4ogIFv0mvh794ncr
	Zw5UOVavJaJWT9uMEOAYv5GiRnzfaaatNmaycBrvNE6/tzAC8PA==
X-Received: by 2002:aa7:d39a:0:b0:560:4f1c:99c0 with SMTP id x26-20020aa7d39a000000b005604f1c99c0mr3754048edq.13.1708092040726;
        Fri, 16 Feb 2024 06:00:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH9qLErIx9BTiLXdRzSFEVfAu/4I+PSZLkGaxAafzAUsaGy/sW9sX57lS2R3vwbol5SzyQFA==
X-Received: by 2002:aa7:d39a:0:b0:560:4f1c:99c0 with SMTP id x26-20020aa7d39a000000b005604f1c99c0mr3754022edq.13.1708092040363;
        Fri, 16 Feb 2024 06:00:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b2-20020a0564021f0200b00563b96523c5sm1346763edb.80.2024.02.16.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:00:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8734310F5BE9; Fri, 16 Feb 2024 15:00:39 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page
 pool for live XDP frames
In-Reply-To: <a33c3cb6-a58c-440a-b296-7e062fa8f967@intel.com>
References: <20240215132634.474055-1-toke@redhat.com>
 <4a1ef449-5189-4788-ae51-3d1c4a09d3a2@intel.com> <87mss1d5ct.fsf@toke.dk>
 <a33c3cb6-a58c-440a-b296-7e062fa8f967@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 16 Feb 2024 15:00:39 +0100
Message-ID: <87h6i8cxvc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Date: Thu, 15 Feb 2024 18:06:42 +0100
>
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> Date: Thu, 15 Feb 2024 14:26:29 +0100
>>>
>>>> Now that we have a system-wide page pool, we can use that for the live
>>>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>>>> avoid the cost of creating a separate page pool instance for each
>>>> syscall invocation. See the individual patches for more details.
>>>
>>> Tested xdp-trafficgen on my development tree[0], no regressions from the
>>> net-next with my patch which increases live frames PP size.
>>>
>>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>=20
>> Great, thanks for taking it for a spin! :)
>
> BTW, you remove the usage of page_pool->slow.init_callback, maybe we
> could remove it completely?

Ohh, you're right. Totally forgot that this was something I introduced
for this use case :D

I'll send a follow-up to get rid of it after this lands.

-Toke


