Return-Path: <bpf+bounces-12846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461A87D13FE
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01294282572
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8919BA0;
	Fri, 20 Oct 2023 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0Gs9Pk5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F201EA7A
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 16:30:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D82D46
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697819452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zj22KpoL/SINcqO9zJg9x2W7MuNU91Uro8MdWTCGGEA=;
	b=O0Gs9Pk5m+Nv2c+vnWrnoXRT6VT9KNrF5EZy+DnSU7tuIGhbD74uLJ/PSpaIy3eWkh3atJ
	gaQEYBCl5fBPtBGoB0dy0qc+KnkQUIuLmSEfeWfcYFu+xE9orS/A1y0xBLzAlsTCZkgycE
	rAhP4eREtLkmIlmBc+OQbB6tpcO83ro=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-oV_Es2-4Ne62eTwHGT233A-1; Fri, 20 Oct 2023 12:30:51 -0400
X-MC-Unique: oV_Es2-4Ne62eTwHGT233A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae7663e604so63592166b.3
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 09:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819450; x=1698424250;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zj22KpoL/SINcqO9zJg9x2W7MuNU91Uro8MdWTCGGEA=;
        b=kJccF73A+plb98ZKHpCsRGOEw41cvBPgk4b4I+9XExKrgHywmPPmuT0xPKO3C84aQV
         2/Q8MI9Nd9cVkb8Je7gQ7NnW+I/kqG5ysIWG2mTgxCh//bei2a4HbMMkLp/csMbtIRJb
         AxEv3KSPeXjHA/4X/a16NB+bnWz+d7R+Qb5QIBQyiN94aYDuvb6ArklWvz3Om4wI8ISl
         4vON6PllbdFn63ub1hyDnySZ7RFq22abii4O/HfP1pUwkv7ioPErMaQIz06BpFHdeYWm
         MM+LBygG6DpNVplZfoF+e/Dk5Z1kqNGbKqXmITgquPG4D+QMVyZwGfSKYy/m0zFp43qy
         AoIg==
X-Gm-Message-State: AOJu0YxNnIgS/w0ze/AYY6w/vA/X8Yi+BBQM5vl/tVXVrGP1Ez7etPUK
	f40xc+sLib9ohN0sWWDleapuYBDzRTzzlcp7s32r7aEVB1jh4rrIuzVDPfSPQypeqKIzea/R+eg
	6eIpw3xti93hV
X-Received: by 2002:a17:906:6a19:b0:9c7:5a01:ffe7 with SMTP id qw25-20020a1709066a1900b009c75a01ffe7mr1949311ejc.12.1697819449874;
        Fri, 20 Oct 2023 09:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfIqEXWtvyPiNyPvFtTE3pshp8ywgNWPL9PgJT7GGQVpWb1YeRM9TYboj2L3hpLrVFvvfqWQ==
X-Received: by 2002:a17:906:6a19:b0:9c7:5a01:ffe7 with SMTP id qw25-20020a1709066a1900b009c75a01ffe7mr1949297ejc.12.1697819449561;
        Fri, 20 Oct 2023 09:30:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dv19-20020a170906b81300b009928b4e3b9fsm1794525ejb.114.2023.10.20.09.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:30:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 84AF6EB26EC; Fri, 20 Oct 2023 18:30:48 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org, Mohamed Mahmoud
 <mmahmoud@redhat.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
In-Reply-To: <87fs29uppj.fsf@toke.dk>
References: <87jzrrwptf.fsf@toke.dk>
 <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk>
 <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk> <ZS6nnJRuI22tgI4D@u94a> <87fs29uppj.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 20 Oct 2023 18:30:48 +0200
Message-ID: <87mswds1c7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:
>
>> Patch based on Andrii's analysis.
>>
>> Given that both BPF_END and BPF_NEG always operates on dst_reg itself
>> and that bt_is_reg_set(bt, dreg) was already checked I believe we can
>> just return with no futher action.
>
> Alright, manually applied this to bpf-next and indeed this enables the
> netobserv-bpf-agent to load successfully. Care to submit a formal patch?
> In that case please add my:
>
> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Thanks!

Friendly ping - are you planning to submit an official patch for this? :)

-Toke


