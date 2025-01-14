Return-Path: <bpf+bounces-48765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D1A106AD
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 13:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18F316205C
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCCC234CE8;
	Tue, 14 Jan 2025 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E85dzK+M"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDE234D1F
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858023; cv=none; b=HW/WL8YQygswtNZJEkXQCNIWzx5vVRIy39okQBYErFs6sUoE0bQ23K1huqfgoNeY+ZpYGwTjvJW/BS5ujtXrS6Q4kdtQ/a5ST3bVyTwX/rN3I2FOV8BdGbldP+CvNDZh7Dpp7yfwGwl2O2T04uvnbl8bldXfcZKfw9NGoiZLB+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858023; c=relaxed/simple;
	bh=5Lm5kB0+iK6wFItSmhLHgK/BDyvkiOdFqPcvI0Aablk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZhjQW4BmHnwBn4wE51mbCbUi0fDpLwGEM+XWAfH+0qnwfGN4EAGA+RfDbGR2HIHvSOoFMn/usCIv6ohp52Zz8NUcmvzXgYW+TqA7xoHOu/3fzwHUyeKogrU7CmouVKGXpeQDLB5vN3Hy3ibzSMWNOScthAGzn6V9JjuV5gE7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E85dzK+M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736858021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tlfbHWekWk1By060j3CLqJiaSA0VtIW2bq5QccDzkHI=;
	b=E85dzK+M9WWb345F9y/6noRj4dizw+YqWEbejJJ4ARFXpR3+oHLXNqFwkNdBLzUPxdHc/z
	lHSj06bO4hJRUq8NL2oy7Cki6HnJElZ2jwT14AkyROCDJa1xVbf3lgMhQZ5cx0PKRXNJPD
	dh1MgAn3Hh+642V0YeJfn4bGxYUBqMg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-wYWgucfDMnefcq1Cd22vhw-1; Tue,
 14 Jan 2025 07:33:35 -0500
X-MC-Unique: wYWgucfDMnefcq1Cd22vhw-1
X-Mimecast-MFC-AGG-ID: wYWgucfDMnefcq1Cd22vhw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77DE61956050;
	Tue, 14 Jan 2025 12:33:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A34F2195608E;
	Tue, 14 Jan 2025 12:33:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 13:33:07 +0100 (CET)
Date: Tue, 14 Jan 2025 13:32:58 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, tglx@linutronix.de,
	bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250114123257.GD19816@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114104215.GD8362@noisy.programming.kicks-ass.net>
 <20250114110149.GB19816@redhat.com>
 <20250114120235.GP5388@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114120235.GP5388@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 01/14, Peter Zijlstra wrote:
>
> On Tue, Jan 14, 2025 at 12:01:50PM +0100, Oleg Nesterov wrote:
> > On 01/14, Peter Zijlstra wrote:
> > >
> > > On Tue, Jan 14, 2025 at 10:22:20AM +0100, Jiri Olsa wrote:
> > > >
> > > > hack below seems to fix the issue, it's using rbx to signal that uretprobe
> > > > syscall got executed, if not, trampoline does int3 and executes uretprobe
> > > > handler in the old way
> > > >
> > > > unfortunately now the uretprobe trampoline size crosses the xol slot limit so
> > > > will need to come up with some generic/arch code solution for that, code below
> > > > is neglecting that for now
> > >
> > > Can't you detect the filter earlier and simply not install the
> > > trampoline?
> >
> > Did you mean detect the filter in prepare_uretprobe() ?
>
> Yep. Aren't syscall filters static for the duration of the task?
>
> > The probed function can install the filter before return...
>
> If you're running a task with dynamic syscall filtering, you get to keep
> the pieces no?

Sorry, I don't understand... Perhaps because I am enjoying my state after
dentist appointment ;)

OK, suppose we have

	void start_SECCOMP_MODE_STRICT(void)
	{
		// in particular nacks __NR_uretprobe
		seccomp(SECCOMP_MODE_STRICT, ...);
	}

and we want to add uretprobe to this function.

In this case prepare_uretprobe() can't know that sys_uretprobe() won't
work when this function returns?

Oleg.


