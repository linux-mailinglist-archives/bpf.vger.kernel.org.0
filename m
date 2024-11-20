Return-Path: <bpf+bounces-45293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3429D4156
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 18:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A24B348B7
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0451AA794;
	Wed, 20 Nov 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isqjpdpx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204519C543
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122667; cv=none; b=U0orsx34O7kPUd1qhCVERQQ/KPGiiwQOXTsQamowvVSxJjgFhhxi9EMg/iSKaBIjoDQeQfDkpVxfQ23RAwWuORYQEAhS6p2/tyJRC54BLIlRg7kN4Uaa3dOjrarLGtHYKPzOMzfJs/X8SHyrYi0aBPMW2Gtpjxslc1k9vBQ2cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122667; c=relaxed/simple;
	bh=bD2+PXc5yOVf78h3sEDBO2zFlBtAaawUxdecGEXQBRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PEq3CUnE/wA85qR5C8QaKrlSrVHEK6/Q3Gniehj4rvYNULODN7YPZArDjeWLeoufrJOX/iSjZuz5HaU3UX+CGVlewDUyP4NlHgpd8SnQ71GJKpTuIwrCxOd6hoAvGyYNueIhJYErdlghAVnE3+FhnWxopN5Yfv/EFgYbpPut9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isqjpdpx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732122662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/9IdVXzOrQgYnWle7hTlDaq+06CP5BjggLeefeVjYk=;
	b=isqjpdpxa5Qi1jWjOh7ui/Sk/dupns9Y/Wd/L125Nc6vAoBy4l/x34EIZptohFrSrCn4Pn
	3REFFURG1Z9qL8Wq18P8kjpEcyZTEtdCBxtrVWWY4c1bQuysbFir1+EQsLgTL8IAKf0WPf
	kCX73236KnRDZjhlMMETF4zahgskHXU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-I7EDXVFdOeOEgmQ7iUH6iA-1; Wed, 20 Nov 2024 12:10:59 -0500
X-MC-Unique: I7EDXVFdOeOEgmQ7iUH6iA-1
X-Mimecast-MFC-AGG-ID: I7EDXVFdOeOEgmQ7iUH6iA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d40df31c3fso326386d6.1
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 09:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122658; x=1732727458;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/9IdVXzOrQgYnWle7hTlDaq+06CP5BjggLeefeVjYk=;
        b=ejd1RRDvWe5sZyNyfY9gNP68IWHCRZBb1ASPej0123ZXCPyJgmqcHpgKKQv+d9fc8/
         TOTFfATweuP2LEHoXwXFMpczZ0jJVa35T4e137iDauo1i24p5JK+A0isLUNCpAcVxilf
         BRcfZL6nYS4pRFQEnDnntMxLD6DkM7e8BfrSBiUB2Q0uc3cU2lvQykub8SaqPImG9LYv
         TdNNuAzwlIZ3bJkdOFEJupAl77S7IwkBIo+BwzqEO3JacNwF0s32VV29Hs+5CpYHvOmD
         x2ckjbsj8QWJRh2B0PS53qSKntRw8KUiqFwMvzFMwRKDHtBO9ff5nB6uzif1+URzgxkR
         45TA==
X-Forwarded-Encrypted: i=1; AJvYcCWDsPcWVKCVOfnF7NAzaD4bEsP1DDxU9TC+Y7FGYzYTvRrkeUSDy0z8sTsNspu0GNifFvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eBR4zcCt/OsZKinPScY+rWceiON4XpZwBvYoVjfTS4l4udfE
	v3LIMtYYWfwhqwxLxFcSUJNkTaMAPZe6ES5KTpuhzNyeDSwEznQzMsq9hMRMQIBDUizf9HqxRCj
	g1N8k2w1AuTckxfIcyFYplI2VyB3mf14gPDU1O1QeYmoze1h6WQ==
X-Received: by 2002:a05:6214:1d2a:b0:6d4:1c3b:1cb6 with SMTP id 6a1803df08f44-6d43779b915mr51503926d6.18.1732122658339;
        Wed, 20 Nov 2024 09:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv9CkwhZjIaA2k5+ZORakSpYnSngvWk8FXITINBTOVrkhvREcruWPODJNNTMgDJRVDzvSyug==
X-Received: by 2002:a05:6214:1d2a:b0:6d4:1c3b:1cb6 with SMTP id 6a1803df08f44-6d43779b915mr51503036d6.18.1732122657909;
        Wed, 20 Nov 2024 09:10:57 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812ab11sm12976636d6.94.2024.11.20.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:10:56 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel
 Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 11/15] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <Zz3w0o_3wZDgJn0K@localhost.localdomain>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-12-vschneid@redhat.com>
 <Zz2_7MbxvfjKsz08@pavilion.home> <Zz3w0o_3wZDgJn0K@localhost.localdomain>
Date: Wed, 20 Nov 2024 18:10:43 +0100
Message-ID: <xhsmho729hlv0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/24 15:23, Frederic Weisbecker wrote:

> Ah but there is CT_STATE_GUEST and I see the last patch also applies that to
> CT_STATE_IDLE.
>
> So that could be:
>
> bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
> {
> 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> 	unsigned int old;
> 	bool ret = false;
>
> 	preempt_disable();
>
> 	old = atomic_read(&ct->state);
>
> 	/* CT_STATE_IDLE can be added to last patch here */
> 	if (!(old & (CT_STATE_USER | CT_STATE_GUEST))) {
> 		old &= ~CT_STATE_MASK;
> 		old |= CT_STATE_USER;
> 	}

Hmph, so that lets us leverage the cmpxchg for a !CT_STATE_KERNEL check,
but we get an extra loop if the target CPU exits kernelspace not to
userspace (e.g. vcpu or idle) in the meantime - not great, not terrible.

At the cost of one extra bit for the CT_STATE area, with CT_STATE_KERNEL=1
we could do: 

  old = atomic_read(&ct->state);
  old &= ~CT_STATE_KERNEL;


