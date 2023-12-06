Return-Path: <bpf+bounces-16956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29582807C7D
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 00:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0482282589
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEDB328BF;
	Wed,  6 Dec 2023 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fs8Cgqd5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD2A4
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 15:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701906172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=byKhWzYdmi5fEDA2bFIRQYvHyYjTkEKHVH1O6k33LAM=;
	b=Fs8Cgqd5fhofT48me0xsZn8zDivadKA2BOkEaYELx2r5n31T6s4KlberarQIfN6ERfFDrt
	DLiEV7nGTJ7dW8+CN5MLvL4yHzHGAW1QJT8WhDWFZsX2shq3PU/MJ3vnmy5a7b/5DEIUEV
	d5jub7Q6Vebh1mUnTXsKjdBgHu0lick=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-Ty0wYplzM7SH1uZyDEDkhw-1; Wed, 06 Dec 2023 18:42:48 -0500
X-MC-Unique: Ty0wYplzM7SH1uZyDEDkhw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54c6b97fea7so185460a12.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 15:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701906167; x=1702510967;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byKhWzYdmi5fEDA2bFIRQYvHyYjTkEKHVH1O6k33LAM=;
        b=iolFsVLZeAi9Yt5XLEheiQqw4pSlGP650gz0mfWkcUrL5uZ0f+g/TXtEeMlwqoInqw
         OhsocqbPbwW9gVFL5V7l4EeD/Ivz5bGr5yMUFiujiopab01J6SAv0S+PSWjjucp2xCF+
         oPPPOh6mYld5AG6JO3e2AqZVWs6DMOnhGk6RWa4AlMDCykHyc2Q12mNIjktJqDqE4Ead
         xHo2rVmTazJPbtj6bE7xLiGRz2hkj57LfEyGKN9gBYMK55SV0Gct57DdAG+KMFtjAiuz
         EWECXjCkOJ5y3lWNjBq720wpeayl0UtXrVL3/plKa27R32Vbf3ksU2/k1FE6FlmrtJps
         qDfw==
X-Gm-Message-State: AOJu0Yy7CuePFwZhrliCkE34RQ9CTMKWJ6+QpxNC97Tt1GWuNuzLzWMn
	GqAhqosHZ2wf2jVpuWJeqQRDggKtQnBPTK+Y/pTXNur0bOoqJG+j7IUcq4ajMkc2xq+d28MJGFa
	lM4dsxK7wxl4i
X-Received: by 2002:a05:6402:51d4:b0:54c:793b:8e29 with SMTP id r20-20020a05640251d400b0054c793b8e29mr1226996edd.29.1701906167716;
        Wed, 06 Dec 2023 15:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7vRlA+d/H97Tnlmdjl2ipDcurwnvVNGgVnqnqh+mn1wCaJMNyLFxRFkKmPIdyJdpL930WWw==
X-Received: by 2002:a05:6402:51d4:b0:54c:793b:8e29 with SMTP id r20-20020a05640251d400b0054c793b8e29mr1226972edd.29.1701906167447;
        Wed, 06 Dec 2023 15:42:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u21-20020a509515000000b0054db440489fsm80993eda.60.2023.12.06.15.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:42:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2CC53FAA7F4; Thu,  7 Dec 2023 00:42:46 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 cake@lists.bufferbloat.net, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek
 <mkubecek@suse.cz>, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
In-Reply-To: <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
References: <20231206192752.18989-1-mkoutny@suse.com>
 <7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
 <vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
 <20231206142857.38403344@hermes.local>
 <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 07 Dec 2023 00:42:46 +0100
Message-ID: <87sf4elwy1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Koutn=C3=BD <mkoutny@suse.com> writes:

> On Wed, Dec 06, 2023 at 02:28:57PM -0800, Stephen Hemminger <stephen@netw=
orkplumber.org> wrote:
>> It is not clear to me what this patchset is trying to fix.
>> Autoloading happens now, but it does depend on the name not alias.
>
> There are some more details in the thread of v1 [1] [2].
> Does it clarify?

Yes, but this should be explained clearly in the commit message
(including the reason why this is useful, in the follow-up to [1]).

-Toke


