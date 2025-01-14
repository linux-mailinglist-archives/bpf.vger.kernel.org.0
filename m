Return-Path: <bpf+bounces-48864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A72A113E9
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373EC3A292B
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F32139C7;
	Tue, 14 Jan 2025 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhJ1eA34"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758C21322A
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736892683; cv=none; b=ZOyh+qIsbAPolZt4TWWFYNMmdP1U2PT9VyMunQDNG76ACT/0ogdHrNp5Ok9fQd/hnC4Siu6FFrJCrT557Bij6vyCJrjL84nS7SIzIgZJd3228DrRO9GoPFLhrwL3kqI5yjbkuxpMN/fEdY3agDt+XjQSDtfbOEjwuKQOBNDPYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736892683; c=relaxed/simple;
	bh=+ovgz39tY88dwtzotQQdo6p6n/6QPXchjNTUZS4C/5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqzrinE4V70s2Nn0wFCL4gu5A869wNgc366RXZOLD+qSpZX9N2cN3sTgoBPOq578GT2rW6s43u23PumZFtl5h37lXf0Z6UPIu9lLdkXBcDStkGjCwPNR6dcqIu3C4T3LznMCQnJRGXc/29SztmtNA/2iuNwmeFXze65HxiY09YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhJ1eA34; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736892680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ovgz39tY88dwtzotQQdo6p6n/6QPXchjNTUZS4C/5I=;
	b=DhJ1eA34URDGeXjuXwMHnt03dIf5krq/yX1g4HfhODtbGg5Z81VnCQxJdxHwA6pEa/U7Hw
	XAWC6jfNIgWNRa23gk6MFfHNaJkE9xhgdz3aFvyeVi5Na5YtXR26wiax2VIBeSEY5YjR4I
	CWSV/Byx3W/vbC/+7+frrtOLly0NdU0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-fNVoz8YDMMiv09T73PKnTQ-1; Tue,
 14 Jan 2025 17:11:16 -0500
X-MC-Unique: fNVoz8YDMMiv09T73PKnTQ-1
X-Mimecast-MFC-AGG-ID: fNVoz8YDMMiv09T73PKnTQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2EC71955D83;
	Tue, 14 Jan 2025 22:11:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8261519560AA;
	Tue, 14 Jan 2025 22:11:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 23:10:47 +0100 (CET)
Date: Tue, 14 Jan 2025 23:10:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250114221002.GA10122@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114105802.GA19816@redhat.com>
 <Z4ZyYudZSD92DPiF@krava>
 <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
 <20250114203922.GA5051@redhat.com>
 <CAEf4BzaRCzWMVvyGC_T52djF7q65yM8=AdBEMOPUU8edG-PLxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaRCzWMVvyGC_T52djF7q65yM8=AdBEMOPUU8edG-PLxg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/14, Andrii Nakryiko wrote:
>
> On Tue, Jan 14, 2025 at 12:40 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > But, unlike sys_uretprobe(), sys_rt_sigreturn() is old, so the existing
> > setups must know that sigreturn() should be respected...
>
> someday sys_uretprobe will be old as well ;) FWIW, systemd allowlisted
> sys_uretprobe, see [0]

And I agree! ;)

I mean, I'd personally prefer to do nothing and wait until userspace figures
out that we have another "special" syscall.

But can we do it? I simply do not know. Can we ignore this (valid) bug report?

Oleg.


