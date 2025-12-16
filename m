Return-Path: <bpf+bounces-76706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF8FCC1EA3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 11:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F6C33025A64
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B068A32BF21;
	Tue, 16 Dec 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTn3imK4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A5325701
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879850; cv=none; b=GaMQPVCu9dq/21TBN0pI/ClAGbCorxRihrmYlqiMgAde3dr81kUOuh54et1oB1m/1LgeCfIkL0RXUxVVNyH28Jf4nKJpfZ1WUNlA3igeA/MP8XaeBJnAfc7Da+fkanaUbb8Dqz1xWeZNdgTs2h16yPiY9lFAoSThLC9RghAMFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879850; c=relaxed/simple;
	bh=t5rEzB0XfV2HhggtoY+1nXODslnee9LcIT7edg43TyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I9leAeLT/oSMad/wvgLTXk6t6t1V4AMlMJBnSyv4kw6pic6OXgMo4ZrXHc+bWiSBS43U4tOw7CaEyDAK7ceb/arzswmpT1B/1W8AXikZeliJ5j/KOmRWcYMFQGN6xBx7bqW7HARx1d/3Kl9/8osuqJT5b6Q/P36BNfSN/8HB+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTn3imK4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so36146565e9.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765879847; x=1766484647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5rEzB0XfV2HhggtoY+1nXODslnee9LcIT7edg43TyE=;
        b=fTn3imK4WN596VrpvXlde7uqQuEB5lbWeGDN50/aOdyI+oOvQvN+J1BYFdk+or8Jd7
         O9VlJxWalbWrYGMpZ5bkArfPZ6R+fDQpQCjaj9hnsfguiiOTxA2Z086+qMCfgOLcabd9
         FgKkDmewYtMl12uEoUdt4Igs6hqHqzWVYToJ4AYZNVfNXww5cr4Hllfc+lcHOps8SnTA
         4c3EyCDTqofvVQIt3gN7KZHzCxbDmNH6Ga+qa2cO2C1qc84mOMY2Gm9QwgDegQMnelJF
         U7qc0SwmL5/fiFnGCfPzYNbEebpUfWPC4/zN3O+ko+vgLsJQ6QgIuftc+kyuExjWHJzL
         vlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765879847; x=1766484647;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t5rEzB0XfV2HhggtoY+1nXODslnee9LcIT7edg43TyE=;
        b=JBQNXOxtmuNduLPhb2HWjRI5VcLFfMO0hx7hw1wCcl8Ywoq5xbHnoYxVukn9AFL86B
         NgpdnZdwzhgRIwuiOMeQE3VVJkAdF7zshzboo8vWjSJBWaPxm4l9hExBgsI+ZS7LbhVb
         CVAt6l1O3CYftDixH6SBkTkozAQVSkWa8XerLcAJOiLMDx40+uaAwDHCH2vFOgb/Cnz7
         MmtZdhILgCXooDGPPNVUdxQlpB2US1qVUI8kJuRPP5Om2cl1Zfv94v4HmXcx/E3qriOl
         g0SsSiHe1VQBhseUX1j6NPQIrzDvJ2jbu5JmlOvenKlY/AW5FCoQOnFf+kXZZMILSGUl
         gjxw==
X-Forwarded-Encrypted: i=1; AJvYcCU+eZr4fVuXHIKpKN2Uwj0RRGiQiTGyGHNmpk/tuLRzRggfhNLL2hBK2iCjB9L2as2O63A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3EhUrn2TdV0kax/Z8DxBTlKEeB8+bIDH7iQvv6HBhB/UtMNHS
	0PdgDekllnKoRuEmYTqsOhKgLb7nfu4wYmk7ohGIKGMYIyrcgosjrizjdFMxYQ+YJbybHB5VkEF
	93OR1dewARIP85w==
X-Google-Smtp-Source: AGHT+IEd1DtqS9iGujKBf5Wl3HxnREueKAOxGRaJlybjiAz1XyBUCEjyQ5pN21ilTcLVd3HJFgAC3/iwKoa2lQ==
X-Received: from wmbd22.prod.google.com ([2002:a05:600c:58d6:b0:477:632b:1238])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3104:b0:479:3a86:dc1a with SMTP id 5b1f17b1804b1-47a8f9155fcmr137796355e9.36.1765879846765;
 Tue, 16 Dec 2025 02:10:46 -0800 (PST)
Date: Tue, 16 Dec 2025 10:10:46 +0000
In-Reply-To: <aT/drjN1BkvyAGoi@e129823.arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com> <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
 <aT/WOAr4osoJWaMS@e129823.arm.com> <DEYP7JSVTB9D.3EFN2KEHH3O79@google.com> <aT/drjN1BkvyAGoi@e129823.arm.com>
X-Mailer: aerc 0.21.0
Message-ID: <DEZK5U2YP6I0.27VJHSVK14646@google.com>
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
From: Brendan Jackman <jackmanb@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, Brendan Jackman <jackmanb@google.com>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>, 
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>, 
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jolsa@kernel.org>, <hannes@cmpxchg.org>, 
	<ziy@nvidia.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>, 
	<rostedt@goodmis.org>, <catalin.marinas@arm.com>, <will@kernel.org>, 
	<ryan.roberts@arm.com>, <kevin.brodsky@arm.com>, <dev.jain@arm.com>, 
	<yang@os.amperecomputing.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, 
	<linux-rt-devel@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon Dec 15, 2025 at 10:06 AM UTC, Yeoreum Yun wrote:
[snip]
>> Overall I am feeling a bit uncomfortable about this use of _nolock, but
>> I am also feeling pretty ignorant about PREEMPT_RT and also about this
>> arm64 code, so I am hesitant to suggest alternatives, I hope someone
>> else can offer some input here...
>
> I understand. However, as I mentioned earlier,
> my main intention was to hear opinions specifically about memory contenti=
on.
>
> That said, if there is no memory contention,
> I don=E2=80=99t think using the _nolock API is necessarily a bad approach=
.


> In fact, I believe a bigger issue is that, under PREEMPT_RT,
> code that uses the regular memory allocation APIs may give users the fals=
e impression
> that those APIs are =E2=80=9Csafe to use,=E2=80=9D even though they are n=
ot.

Yeah, I share this concern. I would bet I have written code that's
broken under PREEMPT_RT (luckily only in Google's kernel fork). The
comment for GFP_ATOMIC says:

 * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lo=
wer
 * watermark is applied to allow access to "atomic reserves".
 * The current implementation doesn't support NMI and few other strict
 * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_N=
OWAIT.

It kinda sounds like it's supposed to be OK to use GFP_ATOMIC in a
normal preempt_disable() context. So do you know exactly why it's
invalid to use it in this stop_machine() context here? Maybe we need to
update this comment. Or, maybe actually we need to fix the allocator so
that GFP_ATOMIC allocs are safe in this context?

