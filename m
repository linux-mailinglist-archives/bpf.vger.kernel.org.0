Return-Path: <bpf+bounces-49057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5CA13C7F
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356DC7A2CF3
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358A22B590;
	Thu, 16 Jan 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9wdClW8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4724A7C9
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038443; cv=none; b=iIlQhqE2rhlLF1Vvu7BgtQ4/iydpHjBHKlD0T5GqPs9pwWvrPd5ULdtLVpyYZ9IELMae46ArBClAOoCA2Z//LQ0gNn1YTNKoEMbFyQirgb2b+8VOEOZPn/+zdniOD6MfsAatRZUR5V03zz882losXx1gJfjkh1DM+LiQzp+dYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038443; c=relaxed/simple;
	bh=njqXd/uQ+QT9aanmRxZO+r+o7uxJnuiyyh1zBELECRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8JdcHw42ZE/LS1764Cd8QNHAqxAxoQURWrh6VHK4NhAfcNmVJ7GTdAswvFB/NDYl6FTHRelZsKA/f+5QibxaVy/m2Q+Bl4pjkQi6hsbNihBOUy61uDhcKH4lTJCfBxb8dktIi2luvwlBJaN2jK9q2WP8srGO767RId6AfSQRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9wdClW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737038441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb/9KjaC//7ekSA5D4ZTqkLvXMQfEqyfvg4jgXEsaAk=;
	b=h9wdClW8mTvZly8svVEK18uKCZhykPeO8p5nohdh4pvh/JwT2qiqK1YsHbgQo7uo5Ajpr0
	hhGGuwLfDfs6w/h7o/sSva7TJwve8SWoDcrzpNvxTTZ9Kp2aidUU2+424PmnY/6Ru2TlPB
	e74UViLnpV8Zck5kq/IpRvjj3tlWKF4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-G7yyzW9yO2WCYMiQJsup1g-1; Thu,
 16 Jan 2025 09:40:37 -0500
X-MC-Unique: G7yyzW9yO2WCYMiQJsup1g-1
X-Mimecast-MFC-AGG-ID: G7yyzW9yO2WCYMiQJsup1g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DCF419560AA;
	Thu, 16 Jan 2025 14:40:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 55A0619560BF;
	Thu, 16 Jan 2025 14:40:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 16 Jan 2025 15:40:08 +0100 (CET)
Date: Thu, 16 Jan 2025 15:39:57 +0100
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
Message-ID: <20250116143956.GD21801@redhat.com>
References: <20250114143313.GA29305@redhat.com>
 <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com>
 <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com>
 <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
 <20250115184011.GA21801@redhat.com>
 <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
 <20250115190304.GB21801@redhat.com>
 <CAHsH6Gtd5kYPife3hK+uKafjBMx=-23UzvQgnOnqNDzSZgHyqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6Gtd5kYPife3hK+uKafjBMx=-23UzvQgnOnqNDzSZgHyqw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/15, Eyal Birger wrote:
>
> On Wed, Jan 15, 2025 at 11:03 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 01/15, Eyal Birger wrote:
> > >
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -1359,6 +1359,9 @@ int __secure_computing(const struct seccomp_data *sd)
> > >         this_syscall = sd ? sd->nr :
> > >                 syscall_get_nr(current, current_pt_regs());
> > >
> > > +       if (this_syscall == __NR_uretprobe)
> > > +               return 0;
> > > +
> >
> > Yes, this is what I meant. But we need the new arch-dependent helper.
>
> Do you mean because __NR_uretprobe is not defined for other architectures?

Yes, and see below,

> Is there an existing helper? I wasn't able to find one...

No,

> If not, would it just make sense to just wrap this check in
> #ifdef __NR_uretprobe ?

Given that we need a simple fix for -stable, I won't argue.
Up to seccomp maintainers.

But please note that this_syscall == __NR_uretprobe can be false
positive if is_compat_task().

__NR_uretprobe == __NR_ia32_rt_tgsigqueueinfo, so I guess we need

	#ifdef CONFIG_X86_64
		if (this_syscall == __NR_uretprobe && !in_ia32_syscall())
			return 0;
	#endif

I don't think we need to worry about the X86_X32 tasks...

Oleg.


