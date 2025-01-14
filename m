Return-Path: <bpf+bounces-48853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A5BA11237
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 21:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AA73A4BD9
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CEF1459FD;
	Tue, 14 Jan 2025 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQIyUzAm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5E20C033
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887208; cv=none; b=HRfLKErxEMbnND3Joq/KUSFpylW3jzHn/qu0a9DCyS2Srg8hn9lr34NBquoNhz2+XAa2RBZ65B+ZbaJAIkJ9+CKFVmEwd/urA+yJI+qF1GhvK3HA4nYTt21MoftJ/YsaTDkf4aScIUYmmP2WJeAp9szTGmUfgZroGpZ6+JUsqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887208; c=relaxed/simple;
	bh=iGtvFc/Jy4BJY0LRoDaVaXzDrDXFuoFF7wBMz6Gftpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzD0nqxS8B6d2BrAncEZFioZ+zvaS4ij0oLhdo9tsYZFpTZbNmNd/rgjO6SfPShLvYE9F9ILR4a0WWP/MmnlXJHEgj9AeeopSjUOOvldjcwxtyZktFSh0bKEhkseyDIbdvYOvrb+Qstym8gmD7P0NeHfuVfmgO+yWa4SxNZi8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQIyUzAm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736887206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iGtvFc/Jy4BJY0LRoDaVaXzDrDXFuoFF7wBMz6Gftpg=;
	b=PQIyUzAmmNZt96k+Fs8Shn0axuxdE+54SSftJO90Xz3axKHcK9/3PllS1RVx1E7aiWRtXt
	7jeyOeQHaRj6cSvvDmW87tUrlfl41j+JTiH4GVY8+6cQIsa0zhLHHcw7k2IFai03bEthRG
	S4n1B/OGZxlnRAb8ngaXcgdWazS8I9k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-8PfkFcqLMTezb9LkqFK0JQ-1; Tue,
 14 Jan 2025 15:40:00 -0500
X-MC-Unique: 8PfkFcqLMTezb9LkqFK0JQ-1
X-Mimecast-MFC-AGG-ID: 8PfkFcqLMTezb9LkqFK0JQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D77FD19560B3;
	Tue, 14 Jan 2025 20:39:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EC0A919560AA;
	Tue, 14 Jan 2025 20:39:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 21:39:31 +0100 (CET)
Date: Tue, 14 Jan 2025 21:39:22 +0100
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
Message-ID: <20250114203922.GA5051@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114105802.GA19816@redhat.com>
 <Z4ZyYudZSD92DPiF@krava>
 <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/14, Andrii Nakryiko wrote:
>
> Should we just fix whoever is blocking kernel-internal special syscall
> (sys_uretprobe)?

Well, we can add __NR_uretprobe to mode1_syscalls[] but this won't
really help.

We can't "fix" the existing user-space setups which can nack any
"unnecessary/unknown" syscall.

> What would happen if someone blocked that other
> special kernel-internal syscall for signal handling (can't remember
> the name,

sys_rt_sigreturn().

Yes, the task will crash after return from the signal handler if this
syscall is filtered out.

But, unlike sys_uretprobe(), sys_rt_sigreturn() is old, so the existing
setups must know that sigreturn() should be respected...

Oleg.


