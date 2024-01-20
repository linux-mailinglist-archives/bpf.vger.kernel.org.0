Return-Path: <bpf+bounces-19968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA3683350F
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 15:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1941C20FFF
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF9101CF;
	Sat, 20 Jan 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMDJStZq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F006FC00
	for <bpf@vger.kernel.org>; Sat, 20 Jan 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705761711; cv=none; b=UXyDLNX6iujJdB+t8fZvvC7WC8wgSKt+nP2utGEANv/b3S1HHXhvNr577M+eCycwZu7ZQKtJjDmju6AsBjUqZEnvUao0QRVj8RtF2NG0btTyvWOgohbiJDZ0+9h0CHr3dDlqH3YLUgEeUpTDWzHJroSU8KC2ZqEv17yxWugXNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705761711; c=relaxed/simple;
	bh=S6BPwrXGE2thBcbHwFqMBAxcppB+4NWQZehPC54KYU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uul44HSnMwFDEiVdTLbnFmYGzkYxIJ4SUu/T73ArNaSQwFfpI1OSf4Fg+JoHWwDwcuu+pV5Mgr6UYrxJSJ0vCRmMypmrEideXM4sAAIOgSvUF8+wgkFoBUn0/JmEcmqCmAXLObW1pQlBY6ceoqq0hQ2Qu16kRRv/QYhYiWMlFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMDJStZq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705761709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6BPwrXGE2thBcbHwFqMBAxcppB+4NWQZehPC54KYU4=;
	b=NMDJStZqzhbz0RE4QgKkxrb9jnsjhOiKqZtjEolO/9cLNnh67mHrotCjbZBLpsQKCBeril
	+K8jMDp3JNuOfJOQuGbi/YpL+MJ4qsBARDeTrMIUib7qeU2Mw2NBuN4zXhRNv/y/xQ0i10
	6E9cMOMeGLuE+Lm3ZdK9VPFa7ke8vZI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-Gva_p7lfM1-03XxvlvehhQ-1; Sat, 20 Jan 2024 09:41:46 -0500
X-MC-Unique: Gva_p7lfM1-03XxvlvehhQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2b047e8f9fso89315066b.1
        for <bpf@vger.kernel.org>; Sat, 20 Jan 2024 06:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705761705; x=1706366505;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6BPwrXGE2thBcbHwFqMBAxcppB+4NWQZehPC54KYU4=;
        b=HDzyA102v8POtvhm31+/Mto8N+teFwQNI5GG2+pDr4zXq7W5AqMLlYQsbcNzldq6tl
         CbRPEKMHVIdGUAyntWB6ZISiZD1+2gmr50fm1EFtNvu1QGb+kGN4hpPrpHkefsZXPoXM
         RfSc0aPMSLqAFzaXZU/KbmxE2VUn+1u5M2gI5U4gLEzXUJ8/mlHVRhC9lKRCLwEQ1rx6
         ODdUTetUacUHAJxNLpCmnTg9fRIoPro/rZNhGse8i043ccotX8Yg/yOP97sPmtQNcheV
         fy2gCv+wIBhsVFrxi+5tx39Zg8suGAm80iWtKszrdBnAOMzkFGYdsdAFOeCZTh1m6y8O
         tRyQ==
X-Gm-Message-State: AOJu0YzxYTkeKk/472f2qU8MBsrpwE1EvyYzAi9IqxE2LBRxemtTg9Nl
	WRkEgwQXOw1NDa6cdFAmRQoCZNCjhTeflfR2av3r5YR9i6yxbcLDyrXOCUJHKZdCvEYkmWIoECO
	gcrYpaAOFVYtKhEktkuiwUwqEgiloFQN4vPpQR6CKfIa6o3RrFw==
X-Received: by 2002:a17:906:5a98:b0:a23:1163:24be with SMTP id l24-20020a1709065a9800b00a23116324bemr712753ejq.95.1705761705065;
        Sat, 20 Jan 2024 06:41:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuDY3A8O2vrfwcZAM0M1PYEeHPFP2ngva2JatE0cp7cV6iv0XZ5IXfV5wLy0eR3UWBYZ1gsg==
X-Received: by 2002:a17:906:5a98:b0:a23:1163:24be with SMTP id l24-20020a1709065a9800b00a23116324bemr712749ejq.95.1705761704712;
        Sat, 20 Jan 2024 06:41:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id vh3-20020a170907d38300b00a2e7d1b6042sm5542040ejc.196.2024.01.20.06.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 06:41:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 827D01088FD4; Sat, 20 Jan 2024 15:41:43 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Hao
 Luo <haoluo@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jiri
 Pirko <jiri@resnulli.us>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Ronak
 Doshi <doshir@vmware.com>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP
 redirect.
In-Reply-To: <20240118083730.5e0166aa@kernel.org>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
 <87r0iw524h.fsf@toke.dk> <20240112174138.tMmUs11o@linutronix.de>
 <87ttnb6hme.fsf@toke.dk> <20240117180447.2512335b@kernel.org>
 <87bk9i6ert.fsf@toke.dk> <20240118083730.5e0166aa@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 20 Jan 2024 15:41:43 +0100
Message-ID: <87o7dg3w48.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 18 Jan 2024 12:51:18 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> I do agree that conceptually it makes a lot of sense to encapsulate the
>> budget like this so drivers don't have to do all this state tracking
>> themselves. It does appear that drivers are doing different things with
>> the budget as it is today, though. For instance, the intel drivers seem
>> to divide the budget over all the enabled RX rings(?); so I'm wondering
>> if it'll be possible to unify drivers around a more opaque NAPI poll API?
>
> We can come up with APIs which would cater to multi-queue cases.
> Bigger question is what is the sensible polling strategy for those,
> just dividing the budget seems, hm, crude.

Right, agreed, though I don't have a good answer for what else to do off
the top of my head...

-Toke


