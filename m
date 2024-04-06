Return-Path: <bpf+bounces-26102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3889AC99
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076C8B2255B
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD04AEF1;
	Sat,  6 Apr 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmUKPMy+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78817481AE
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712426264; cv=none; b=jscxbUHKyD7bevidTStC+Qx68uwt/NcI9hcKgeLFvPw8H2zMP96rr7N7UVUis6f5JbLBDe7tAvr8f0MnD2KnnyiPLLkuKiXziUmKw5ZxiDZH+9zpX/IRLKRSHwLSbtQ+lBHK1aHPEO1gKgtTI4GJELPRwj+985xmMV6T6xheG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712426264; c=relaxed/simple;
	bh=QCupe60Wi+dfmZCvC412Qmcmr7ZevvaEiPxSMLn4g/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCi7bzMESdlwZrvAkf2Tyg5ay5+w5CTlnnCQE2i5v1G91KfBxWU8bR+Sj3UH5WP3Utg48hUtqB3E1ZWyBF0PcWZu0KjNRL4VSZF834SoOyifYmW5yGv0q6pJbPfwet8EX+7XXIhNTnxI5fWejntW1SD+7BP5x8Nsp8mZiHo2jFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmUKPMy+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712426261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GReCWnFPjN08AjP0bPCM7WpKp2nC3psJcp83CUkmhh4=;
	b=GmUKPMy+3H9d0TrCAlCwHQHlxTCbyZHqpYZLwnYjGGtM6rqQInklytzAC84/pcANSvanlk
	yrcvGOgr5cnN9hEj0hOOj9/lUTICRxfwGdT5PBpzLYuO4+mWKPA/exQ6w20GBK6G4YL2hX
	2cjRhIMXOBakaB/p6YfL3BbI/YxKBXI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-1Cg6l7qIPZ2PwNbQHHUDpg-1; Sat,
 06 Apr 2024 13:57:34 -0400
X-MC-Unique: 1Cg6l7qIPZ2PwNbQHHUDpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32BB53C0F69A;
	Sat,  6 Apr 2024 17:57:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id F1667100F4D8;
	Sat,  6 Apr 2024 17:57:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  6 Apr 2024 19:56:08 +0200 (CEST)
Date: Sat, 6 Apr 2024 19:55:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <20240406175558.GC3060@redhat.com>
References: <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
 <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
 <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
 <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
 <20240404161108.GG7153@redhat.com>
 <20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
 <Zg-8r63tPSkuhN7p@krava>
 <20240405110230.GA22839@redhat.com>
 <20240406120536.57374198f3f45e809d7e4efa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406120536.57374198f3f45e809d7e4efa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 04/06, Masami Hiramatsu wrote:
>
> On Fri, 5 Apr 2024 13:02:30 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > With or without this patch userpace can also do
> >
> > 	foo() { <-- retprobe1
> > 		bar() {
> > 			jump to xol_area
> > 		}
> > 	}
> >
> > handle_trampoline() will handle retprobe1.
>
> This is OK because the execution path has been changed to trampoline,

Agreed, in this case the misuse is more clear. But please see below.

> but the above will continue running bar() after sys_uretprobe().

... and most probably crash

> > sigreturn() can be "improved" too. Say, it could validate sigcontext->ip
> > and return -EINVAL if this addr is not valid. But why?
>
> Because sigreturn() never returns, but sys_uretprobe() will return.

You mean, sys_uretprobe() returns to the next insn after syscall.

Almost certainly yes, but this is not necessarily true. If one of consumers
changes regs->sp sys_uretprobe() "returns" to another location, just like
sys_rt_sigreturn().

That said.

Masami, it is not that I am trying to prove that you are "wrong" ;) No.

I see your points even if I am biased, I understand that my objections are
not 100% "fair".

I am just trying to explain why, rightly or not, I care much less about the
abuse of sys_uretprobe().

Thanks!

Oleg.


