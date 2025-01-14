Return-Path: <bpf+bounces-48799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F529A10E09
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA89C188890D
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB61CEAC9;
	Tue, 14 Jan 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsGTatE/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555F1FA8C2
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876649; cv=none; b=m9xnjdA0APDotIWa2x1l9NtRgNHdCuGOXNn09/r0NhTJ/mFGbL/nEKTfa6EerbRQkgilAB17bjCj9N0WeEaSsQkHgy2r3KmwEqrQ3x9fJaLYtUO2E/+t8FuHiiJmM2HUBooOH2yYqRDes1QJWELljfezHVjY+3SoGc9QPSlqbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876649; c=relaxed/simple;
	bh=34nq5GvUjgF2h085Ws7NjT1zgg5lxaD3R9awcycTZt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsMnmhVYfNuvSILt+FlCfwHjgXLoczqmdtgw4tRn5oV+hDMb5YS3DXQaH7Tbd8sQoYZDo+TcaBadYJFyxNgRbGjbyKJ4SKsafewOxCUsSNw/SV9Efl7+MTyLcidmk3En538+N26A02983aHd2D4RyhMYvPkJGTck+qXy3ay6KdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsGTatE/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736876646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5GqpWIQ/f+Qoh7dp3s/bx/J+oYUj8DQrXmPD3hkUEY=;
	b=AsGTatE/AIK9oXTSaU/jLZ/UILJQ4d2/kgRoVTQwJq7+8wE4ZB7LRfFx1e9AIrZl7Zkwo8
	xBJCzv2A9k6I9NUlQCitjI0ZhuPaT3aGnVEIZ9FcrErQ/F6DgnHtzdpinfpa9pptnMh4GL
	inAAvUIQ744ZrC1+y4wVCtYEMwgTjkw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-eiSQ_5ztN3aUYMn0tv8PUw-1; Tue,
 14 Jan 2025 12:44:03 -0500
X-MC-Unique: eiSQ_5ztN3aUYMn0tv8PUw-1
X-Mimecast-MFC-AGG-ID: eiSQ_5ztN3aUYMn0tv8PUw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36D001955F79;
	Tue, 14 Jan 2025 17:44:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 72B19195608A;
	Tue, 14 Jan 2025 17:43:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 18:43:35 +0100 (CET)
Date: Tue, 14 Jan 2025 18:43:26 +0100
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
Message-ID: <20250114174325.GC29305@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114104215.GD8362@noisy.programming.kicks-ass.net>
 <20250114110149.GB19816@redhat.com>
 <20250114120235.GP5388@noisy.programming.kicks-ass.net>
 <20250114123257.GD19816@redhat.com>
 <20250114140729.GQ5388@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114140729.GQ5388@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/14, Peter Zijlstra wrote:
>
> On Tue, Jan 14, 2025 at 01:32:58PM +0100, Oleg Nesterov wrote:
>
> > OK, suppose we have
> >
> > 	void start_SECCOMP_MODE_STRICT(void)
> > 	{
> > 		// in particular nacks __NR_uretprobe
> > 		seccomp(SECCOMP_MODE_STRICT, ...);
> > 	}
> >
> > and we want to add uretprobe to this function.
> >
> > In this case prepare_uretprobe() can't know that sys_uretprobe() won't
> > work when this function returns?
>
> Indeed. But any further probes placed after seccomp() would be able to,
> and installing trampolines for them would be a waste, no?

But the probed task will crash when it returns from
start_SECCOMP_MODE_STRICT() above.

Even if, due to seccomp filtering, sys_uretprobe() doesn't kill the task
(I missed the fact it can) but just returns ENOSYS/whatever.

Oleg.


