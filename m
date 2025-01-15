Return-Path: <bpf+bounces-48974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E34A12B6C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 20:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5C71888776
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D491D6DAA;
	Wed, 15 Jan 2025 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWofEc+A"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D11D6194
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967829; cv=none; b=MK7jHgtCMyXf6Sxx2jatRS9cTVRCUJymIdc/YO3CGQAx4qWIWyHRB6Gu9S7iWpnZ98E+ofaFskG63IXHV7peHEfvb03xuPF2yrmN66qT6VUI6SllpFVk0PO83oQrxEYVMFlN01sGaH7VOv1RbgdTsUU5polsuQz94AhDi0JKIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967829; c=relaxed/simple;
	bh=BBKSHK8KSd2buL5pbJ8xO8WsCp7GYMHvslpO2KIaoQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcAbXbCgaCR5Q+hsqD6Qwgyd7AsIXsgaK2Vd827g57nT6900vP7C0J29IxQHxhGpQXKcLhDF09l1yzkrojs3PSabYsVlE9l+BNMwmyIGi801jS8d2051UTevJqlcecpuy/gG7G5XGO0H5MZQ67AUGJVQ1RrBdetRFwaX0F719N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWofEc+A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736967827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYYRC3Sr2G9O7qD5vlzHOVTE1CaKcq2wNHa/9Za5ETQ=;
	b=HWofEc+Aw8CTCbjZmX4w79UYh7uKBeHZDMilkoPrn05xjddqWXmLL2++VCKfkYh/73TK9O
	I09+HjHMntdkXmtsGbzw6saLZ5qJXHFzQAfVQb0djbIXuCv1UHq8iIGfKFADdZ99d0WfCw
	D/3PtIaJKmidj19NoP6AGcUBdeVMlI8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-04Pu3tqpMdy-5dpiPsJY7Q-1; Wed,
 15 Jan 2025 14:03:43 -0500
X-MC-Unique: 04Pu3tqpMdy-5dpiPsJY7Q-1
X-Mimecast-MFC-AGG-ID: 04Pu3tqpMdy-5dpiPsJY7Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DBC41956073;
	Wed, 15 Jan 2025 19:03:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B51A619560A3;
	Wed, 15 Jan 2025 19:03:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Jan 2025 20:03:14 +0100 (CET)
Date: Wed, 15 Jan 2025 20:03:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250115190304.GB21801@redhat.com>
References: <Z4YszJfOvFEAaKjF@krava>
 <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com>
 <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com>
 <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com>
 <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
 <20250115184011.GA21801@redhat.com>
 <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/15, Eyal Birger wrote:
>
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1359,6 +1359,9 @@ int __secure_computing(const struct seccomp_data *sd)
>         this_syscall = sd ? sd->nr :
>                 syscall_get_nr(current, current_pt_regs());
>
> +       if (this_syscall == __NR_uretprobe)
> +               return 0;
> +

Yes, this is what I meant. But we need the new arch-dependent helper.

Oleg.


