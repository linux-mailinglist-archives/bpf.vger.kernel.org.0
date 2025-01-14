Return-Path: <bpf+bounces-48759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 133DDA104EB
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 12:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449BC1888307
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAE22DC2A;
	Tue, 14 Jan 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvM/3WAE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0B22962F
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852556; cv=none; b=KfaELkwffjRvB6c627xL6Zb1Z+GMyhljD/ll9drF2V6lpeWopZldOevoYFCrQKP0gq5SHgo0iXODg6TsChCagDN+V9JDipO55GTs0kZ8pPaVsYCjaORbcgjeMOHb6eKev5h3wRQm252ALJxVyEKGdqILhAueSlZoZQ+R8PkdKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852556; c=relaxed/simple;
	bh=Ovo/VNfzR+CoK/PJl5X0EEHPgpzOZZFY8SPWGupSzYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0v7aHfrQfVVcWLV+fBiJ1pzP9XHoPl9CSE68C/1UsERFN/fVY83ocmYPV3Z/7hdeYyJeFebtWrBvb1kQqJm6kRhtYZ9pwnTQkrOyt2QiljLbjVCCguCMvc/Hj2Jh3X59+Rkb5sDWnXMXit4a11VfmBG0qjJiKDB7xp1aEx7sYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvM/3WAE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736852553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ovo/VNfzR+CoK/PJl5X0EEHPgpzOZZFY8SPWGupSzYw=;
	b=SvM/3WAEHNEksr+kKZmtcGFSFdhyLgR3PKnJxYshhEROIID1Bs2WiWHSTcFXV0Io/Hub0a
	j7CE+YDOPuhrJM3qttfP3t5vmOA0YKu+ye5XuUZygLSn68VrEBi+EEJ5pU2VQ8hS/O1nHi
	zcQbBmCh50JnCMbVkT9S3wk2M4INy8g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-D0WvGm4gNfqO2dO07wT6UQ-1; Tue,
 14 Jan 2025 06:02:27 -0500
X-MC-Unique: D0WvGm4gNfqO2dO07wT6UQ-1
X-Mimecast-MFC-AGG-ID: D0WvGm4gNfqO2dO07wT6UQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49A4219560A2;
	Tue, 14 Jan 2025 11:02:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6FF3519560A3;
	Tue, 14 Jan 2025 11:02:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 12:01:59 +0100 (CET)
Date: Tue, 14 Jan 2025 12:01:50 +0100
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
Message-ID: <20250114110149.GB19816@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114104215.GD8362@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114104215.GD8362@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/14, Peter Zijlstra wrote:
>
> On Tue, Jan 14, 2025 at 10:22:20AM +0100, Jiri Olsa wrote:
> >
> > hack below seems to fix the issue, it's using rbx to signal that uretprobe
> > syscall got executed, if not, trampoline does int3 and executes uretprobe
> > handler in the old way
> >
> > unfortunately now the uretprobe trampoline size crosses the xol slot limit so
> > will need to come up with some generic/arch code solution for that, code below
> > is neglecting that for now
>
> Can't you detect the filter earlier and simply not install the
> trampoline?

Did you mean detect the filter in prepare_uretprobe() ?

The probed function can install the filter before return...

Oleg.


