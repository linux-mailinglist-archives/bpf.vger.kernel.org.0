Return-Path: <bpf+bounces-45870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2C9DC3BA
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4380EB2240D
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C71C19CC08;
	Fri, 29 Nov 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDwRQzlP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759514D6ED
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882705; cv=none; b=NejpJ9jLAhiij8daml//yHuOOFNrAZwK6+dCiioW+z582t8254Jd1695aTO83ZqgH/Jtz0RMsSneo342TSxXSnrkFga6HbhdR+oLb1x3KJlpkQe+4OTMxPX968XtHBrsef6X9bqB/t62c1gslgX6/InYGG22lSQ1BDGX/IQ0grs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882705; c=relaxed/simple;
	bh=0/FxV4mL0f28d4vpVAd+LMzA5wzbcP+zCnBsHKxdR4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zbai9O6V1HesUkp6pE/XMlOZ8CtwKApj9q2CJVaaq3WuVYCwjCF1pd6hkTQdVAc6INKc9CSFauFag55cCjbV3TD1/IrWfaMK/yaolyD4K/ZKrzDDpIxyJNilzL8UQTEeQctHjuueG7ifTAnpVc0YLOCQHhXWC1eQf2wsDwaYJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDwRQzlP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732882702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0/FxV4mL0f28d4vpVAd+LMzA5wzbcP+zCnBsHKxdR4c=;
	b=ZDwRQzlPlGaAJ7pavpnG4HjXzm6UM7L613xmKDopVsWOZbTD3xW56nUaTJgGvJrtv5bIfP
	POIonf/4YswmyzfrYtKjA+uDLVANW4VtNqqA7M+B35r3/0/uygw0jT0mP6tOZ/bIO5HsaT
	h+tM0gOo8VaPZ2BBaKuaMEV8XTJdUO4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-9yl60pwSNFyfQzpm7Pt3xg-1; Fri, 29 Nov 2024 07:18:21 -0500
X-MC-Unique: 9yl60pwSNFyfQzpm7Pt3xg-1
X-Mimecast-MFC-AGG-ID: 9yl60pwSNFyfQzpm7Pt3xg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa53116660fso101202066b.1
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 04:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732882700; x=1733487500;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/FxV4mL0f28d4vpVAd+LMzA5wzbcP+zCnBsHKxdR4c=;
        b=VRTqCayurL4yrIvrYwCHxV4FhvfgIU7J7WrFyISO4iU8HlolT0zrYDbzBTYoKq3Uoj
         9TUv1lYIB6U6RmIbfH6ycRS5Z+8p487zbsVTs7V1LQSBv6N5Xr/wXqt6meJTHej1F7oC
         TgTQbVvpsaGHZQl6igyQmhVBxxhRqfpSIIdVbot1E8wzJDlGb7dt/iCdsvtgwCWG4qSN
         ae6CNgvyeLfEBahsOvliB1tJ83tKKm3/pddQFpf4krh77ohOyyd7zhNP/mOQsTUU2epb
         1y+1fibuAwkrnIZ3AghNBajiVZbo3SFrwIaWtZUxirlSDKf//xeXM5TRwm/VC79E7lKm
         71Wg==
X-Forwarded-Encrypted: i=1; AJvYcCW0WMSPORD/zJDrAh7iYnRuaY+UpcAElY7eO8lYWf0wboZ4Kc6frG51JU6P+kdvpYMDmDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/lL7Vu60Ii4anZqIHhYNzkt6NsIt/R48WV9qiIvfCghtAqcS
	xqR/0uXJ38TMRHq2CTDGdU2dthRE93GlTMBZgy56cGCNvUpQK88jjc0qSMW0Njz/GasoapQdbbT
	CEFUWdWLDXMH3wNHcpAhhLSF5On/8CSO0sBSgtf6fn/pMvb3Wnw==
X-Gm-Gg: ASbGncuTou9B3j/k5lE6h3Ja5x8ieFWb70Gs8UGstnwqU54EBvY1Qz+b+FWXgiiJb+t
	wcv/vM2OdL3fiK7GSd9gLfcyruNuzqCERMUmUnQ/B/L584IAKSsQ0fm/YuxwK4Q8qxUDmrc5L2M
	XQfjBzFDxL7WG0ceOFE+Z5bPZmcE36gMmtBQ8X4fsRUJoxoMmgWimC/D5uCsJcW4OqCOeETJlb/
	qcAaby99+tg6vJJtx+qReG29A4HoUrlGR5DI4LfdrBAa62OD5NM7WO7XSuJvmJyiClEUZtpi9k=
X-Received: by 2002:a17:906:cc1:b0:aa5:45f3:cbda with SMTP id a640c23a62f3a-aa5810635a1mr783498066b.56.1732882700101;
        Fri, 29 Nov 2024 04:18:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB0paS1VVzAiX55peYgNONjXt/QUyChoLU/xW1h9eY07/l44WSISTUA33879LZ+SWXvvDQBg==
X-Received: by 2002:a17:906:cc1:b0:aa5:45f3:cbda with SMTP id a640c23a62f3a-aa5810635a1mr783494166b.56.1732882699454;
        Fri, 29 Nov 2024 04:18:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6defsm168000766b.99.2024.11.29.04.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 04:18:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D9D17164E390; Fri, 29 Nov 2024 13:18:17 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, houtao1@huawei.com,
 xukuohai@huawei.com
Subject: Re: [PATCH bpf v2 7/9] bpf: Use raw_spinlock_t for LPM trie
In-Reply-To: <20241127004641.1118269-8-houtao@huaweicloud.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-8-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 29 Nov 2024 13:18:17 +0100
Message-ID: <87frnai67q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> After switching from kmalloc() to the bpf memory allocator, there will be
> no blocking operation during the update of LPM trie. Therefore, change
> trie->lock from spinlock_t to raw_spinlock_t to make LPM trie usable in
> atomic context, even on RT kernels.
>
> The max value of prefixlen is 2048. Therefore, update or deletion
> operations will find the target after at most 2048 comparisons.
> Constructing a test case which updates an element after 2048 comparisons
> under a 8 CPU VM, and the average time and the maximal time for such
> update operation is about 210us and 900us.

That is... quite a long time? I'm not sure we have any guidance on what
the maximum acceptable time is (perhaps the RT folks can weigh in
here?), but stalling for almost a millisecond seems long.

Especially doing this unconditionally seems a bit risky; this means that
even a networking program using the lpm map in the data path can stall
the system for that long, even if it would have been perfectly happy to
be preempted.

So one option here could be to make it conditional? As in, have a map
flag (on creation) that switches to raw_spinlock usage, and reject using
the map from atomic context if that flag is not set?

-Toke


