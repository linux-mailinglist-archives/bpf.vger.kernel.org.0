Return-Path: <bpf+bounces-67492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EDB445ED
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D097C1696BC
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8832673AF;
	Thu,  4 Sep 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqSC/YVX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13A25FA10
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012252; cv=none; b=s/R3nXhtAa94B9kREfI+9MsUtNo+yT6TvNQDExUkGC3UMlrnvF7txaKr/ALArnE6J/8nR9bokkkUNEN0CnPxytW9BuCLMevzsG4rYKCR1wqE7EhigsrEYFopMX23qRW+rsY/IcEfYhHBqRR8wKFYVs1Bofg9cqFcXkoiTXRRxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012252; c=relaxed/simple;
	bh=KhNsHMrf/sqhKR9sqHXIW82i5pCmcA37pzNT3Ot6msA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecq8YoaYVN+Z0IgLxcVX1H4mFffIWu0l2AXY3KYsEU2/4qvnYuSugIO5kwG4biaV+2otB+tiVOHwsMnTdCLooidsUe1YQpj86RRp107PbY56Z5P9smuE56uqKYivDEMsHpFhOQ+aCkLd71V2oydG0/rzCW/zjbUR4NR+woY4yqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqSC/YVX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757012250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DmCH56rhjiTxUbJSVCbpismgDUwi7/9oaxfTAsfdf3k=;
	b=KqSC/YVXuwks0ZLlMlvoaYJQ3MnzF/e8zeSO0jcR39aZFw9bivRc7Nc64fU7WdDW6FhQAQ
	khq083UwuN95nncYgZBrpxzpY4f7jW7zmNR+/ITDuIzVS9wY8Z8TTCfESqNiC1vZJr9Tz3
	cnXQf8rs4foxp7N0y1M1QvE4nuTbKM8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-Y0I7RuJ5P4C1Do2xTWLcJg-1; Thu,
 04 Sep 2025 14:57:26 -0400
X-MC-Unique: Y0I7RuJ5P4C1Do2xTWLcJg-1
X-Mimecast-MFC-AGG-ID: Y0I7RuJ5P4C1Do2xTWLcJg_1757012242
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A87B1800357;
	Thu,  4 Sep 2025 18:57:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 14EC31800446;
	Thu,  4 Sep 2025 18:57:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Sep 2025 20:56:00 +0200 (CEST)
Date: Thu, 4 Sep 2025 20:55:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
Message-ID: <20250904185553.GB23718@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com>
 <aLicCjuqchpm1h5I@krava>
 <20250904084949.GB27255@redhat.com>
 <aLluB1Qe6Y9B8G_e@krava>
 <20250904112317.GD27255@redhat.com>
 <CAADnVQ+DHGc8R0Tdxf7eUj1R0TDGHXLwk5D4i_0==2_rfXGbfw@mail.gmail.com>
 <CAEf4BzbxjRwxhJTLUgJNwR-vEbDybBpawNsRb+y+PiDsxzT=eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbxjRwxhJTLUgJNwR-vEbDybBpawNsRb+y+PiDsxzT=eA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/04, Andrii Nakryiko wrote:
>
> On Thu, Sep 4, 2025 at 8:02 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 4, 2025 at 4:26 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 09/04, Jiri Olsa wrote:
> > > >
> > > >
> > > > ok, got excited too soon.. so you meant getting rid of is_unique
> > > > check only for this patch and have just change below..  but keep
> > > > the unique/exclusive flag from patch#1
> > >
> > > Yes, this is what I meant,
> > >
> > > > IIUC Andrii would remove the unique flag completely?
> > >
> > > Lets wait for Andrii...
> >
> > Not Andrii, but I see only negatives in this extra flag.
> > It doesn't add any safety or guardrails.
> > No need to pollute uapi with pointless flags.
>
> +1. I think it's fine to just have something like
>
> if (unlikely(instruction_pointer(regs) != bp_vaddr))
>       goto out;
>
> after all uprobe callbacks were processed. Even if every single one of
> them modify IP, the last one that did that wins.

OK. If any consumer can change regs->ip, then I can only repeat:

	Yes... but what if we there are multiple consumers? The 1st one changes
	instruction_pointer, the next is unaware. Or it may change regs->ip too...

> Others (if they care)
> can detect this.

How? If the the consumer which changes regs->ip is not the 1st one?

That said. If you guys don't see a problem - I won't even try to argue.

As I said many times, I have no idea how people actually use uprobes ;)

Oleg.


