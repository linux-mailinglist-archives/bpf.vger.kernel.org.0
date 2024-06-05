Return-Path: <bpf+bounces-31427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7771F8FC8DA
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 12:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043B2283558
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63475191496;
	Wed,  5 Jun 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSKDDX/o"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB00191484
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582849; cv=none; b=mch6t6k+G5QN4O8LT6rHojCqcjDQxJZ1hbH24hbywY+OjxclMf0dmKseAzkTAfEFLsN80+xcsl4JvwqqaaKDym8YIx/MiIuSjeA4FiFKsJN4zFTuRvjlycn4g+QP7nHlixm8PcsoyaxnCrn+gFUp1GZito6YRCcBQoHAPy8kpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582849; c=relaxed/simple;
	bh=3+/0pw4u2JaQ4V4b0wPU5b5kRPyOdE+6zuH2exjbjLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b9nXtV7zCDJSqjmGrT0rVsr1jnpXRGUxqlvZ5ctgCd/jGTdCAjvKViNftsqUmiqVxJ5WS/mqyajY7o9LAlrqh8JDyrUjAvp2y14psQh9Gg9oa3JRScNITdfCEQPjXqPD6EyoJGyHEa6Bems90jqDtK8vK+S3eRjVrbGO53VrFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSKDDX/o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717582846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+/0pw4u2JaQ4V4b0wPU5b5kRPyOdE+6zuH2exjbjLI=;
	b=JSKDDX/odrfcKPgR5CFpY85vEBQ6X3NDYuZNV2pANS9RjnGnGcHolq2FE4cyWk63UY37uO
	J6VNC3BMWGJNZjG48SGXz8yqZtB3njPjoxIg7J0BBBannvrrlmCfubeTPfM8Ygf3dbYFBW
	HAvPZySx8pheL1pdL/nImOcK0gmrbFo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-bLogc0PcMNixP3e8cDAemA-1; Wed, 05 Jun 2024 06:20:45 -0400
X-MC-Unique: bLogc0PcMNixP3e8cDAemA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4215a04220eso57565e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 03:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582843; x=1718187643;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+/0pw4u2JaQ4V4b0wPU5b5kRPyOdE+6zuH2exjbjLI=;
        b=o6FqEF1izDwegMMttjVugAkVoFD9REPjIJb1ewYK9ZSnRwtCmP70QOvBvX+NtW3FO3
         4uSsD4k9sZCbIuRQbkE42zZEBMb2z6pLlnHSx8Av9BY/hYbSNosFx5uFmyXsLF7/OAq/
         cbAuC38DWcmD6/zOp8L6m0gA5JxpTohkafKJ4ADIAy+d2d3J9BR/LkqaaB46wm7FXIVw
         01cn7zIU4Lzs0qHx0DK+iHoHrSHjrC9A4VsvoLF+4Kc2rsVTXfO5kozJz5xcvkN9HdZJ
         t97uUfY8P98LDOTR6Q+pSBAv806/KRI2X0BGrOqbWkgHwZ55mJR7uwHJ7vAWyel4JsjF
         pavw==
X-Forwarded-Encrypted: i=1; AJvYcCW7TEsm9LJBj7GORoi9/vtad9nwfdeeouu8uW5VByc71wVDIfDp0ebTHYfNXcNlxrbm0iMX3rHcrX5h7QIaX/shk3B7
X-Gm-Message-State: AOJu0YybhMo259D81Cvola80TL+9bDIE1MBndS1H4TPnWL5LDe1ZuohB
	C2R83peUCks4KGevE6MyW779u3yKp5BL6pBQXwcztCOGzMtIxeoXAOYcd7vt+Y2nx8LoljTJwN6
	9n0JM0Y5ZAM7vkddYfNmDk5qnjACDcoP+ZXKJD3txRdaAAI10yQ==
X-Received: by 2002:a05:600c:35c1:b0:416:8efd:1645 with SMTP id 5b1f17b1804b1-421562c354emr21673395e9.7.1717582843333;
        Wed, 05 Jun 2024 03:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBLwiAsKcL/M+2PwMmgmbYOgQGPx558hBVK9zwpiwuDQuK9ZU3XA/Dqu4W0NvuVGidf6++kA==
X-Received: by 2002:a05:600c:35c1:b0:416:8efd:1645 with SMTP id 5b1f17b1804b1-421562c354emr21672985e9.7.1717582842778;
        Wed, 05 Jun 2024 03:20:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064b684sm14225962f8f.100.2024.06.05.03.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:20:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 903B613854FC; Wed, 05 Jun 2024 12:20:41 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v4 net-next 14/14] net: Move per-CPU flush-lists to
 bpf_net_context on PREEMPT_RT.
In-Reply-To: <20240604154425.878636-15-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
 <20240604154425.878636-15-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jun 2024 12:20:41 +0200
Message-ID: <87cyovadxi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The per-CPU flush lists, which are accessed from within the NAPI callback
> (xdp_do_flush() for instance), are per-CPU. There are subject to the
> same problem as struct bpf_redirect_info.
>
> Add the per-CPU lists cpu_map_flush_list, dev_map_flush_list and
> xskmap_map_flush_list to struct bpf_net_context. Add wrappers for the
> access.
>
> Cc: "Bj=C3=B6rn T=C3=B6pel" <bjorn@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


