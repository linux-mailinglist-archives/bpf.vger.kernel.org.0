Return-Path: <bpf+bounces-48914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A690AA11E3D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 10:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6673AE5A7
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA9E1E7C32;
	Wed, 15 Jan 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCQ5cVot"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E73248171;
	Wed, 15 Jan 2025 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933817; cv=none; b=YuLMsRMxQAz9sS2OVeQQ/srgFIYRoguP5xQCkugY2g02tkCp6R2lRGZelEy1FekUwtsFC9c/S093TrEc29o8+13VBqNhtirxfD8VIfPwh9jN45RERlerw1iPmRl06HyfYWzEBGyzyhCm/I+SdRVIHtxqw2w/KaLenzDVydT1QD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933817; c=relaxed/simple;
	bh=/HT9tSOVWGWbyIOZTBOkmGKDNZ3I5tsuZeD8vIRISCo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAUag/G/QTtqU2sbSEGkrZ8csHgWA5Lbejv7n6CxceGRSiXDBktoxfZRUpf+KD1JzECsvpwmbHYAdZJimpMYn2tOoMmEdzZfgM583dOPqAWgTKw0OSHKcbZpKHPPCmBkRteoidvn4cu2+bjr0PD1JAWnkvMxYdz3TuMRxemjVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCQ5cVot; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so10995322a12.2;
        Wed, 15 Jan 2025 01:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736933813; x=1737538613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpzvpnkI2QVzc0kZevcoZcuNxSvHM1Q95kuNL314Rkg=;
        b=BCQ5cVotoJXhsMhKwC75wdwIK97Z6bCPxVjXfCiK0XHFmlzOl9d3wcKC5pDVde0mb9
         NgvWBIAMiOBW7NTdJjRQpGEZbHSccHIAvGXmHObz6jZ8VKvVmyqSefp/pf5dLvfpuyr3
         HiXpNQtXPhraSaQ0/sQPVrhbNK4DFm5QqMsXCxHSEPRjZHREsV3F6UsoXX1TRAyJ+sFS
         ta2hfyzYMJjNDBRU1cDloWGA8lXCCuOPIhe/eos/9vY86Fl+HZyIcaNViQVME4rJMdcH
         gpuaiA4Zj8F1Qg8E48lvWuWiVHhS+hbuOWUqIGsTCRIe91aubrlAVLWYl0s+3L9t6s/Z
         A6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736933813; x=1737538613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpzvpnkI2QVzc0kZevcoZcuNxSvHM1Q95kuNL314Rkg=;
        b=R5Cd8B9oJEKwu2U44tkcw+rgUnuX1UsizRS0FE8aQvp8Eh/kVxqbl0V4QcK81TSivn
         2VHX3+HMNrwQ1sbw800LKQHuE5XMN7tKskBlGvJDZabEllXHlP/58x1gH+XQuWo6oZBc
         /d5XjEh+8cZlfCdxtFFoayXKCL8IOep3LD2v9R39TkkRzTXh8ek9eT6yEY1XNySlq+eJ
         7ISHchc6pDZZOtQgKe2ur3fxaYAusSl9YnR3kX6qZy4LkbpxsTAbOxzsgY7LRSISqcZD
         ijAxnBsByYm14sPTDqSU5lkZNYcj5Ehr4KNyj0geRS+b5jIJYHwY6eUWKvVTg5dLNapI
         Dv1A==
X-Forwarded-Encrypted: i=1; AJvYcCUBZNotDVjAxThD8KUudGEqqU0xpuxO6QRTUVJD532z4dGgP37duRycI0QteB+ZSUtNbdeX759SUZFm/U75@vger.kernel.org, AJvYcCVM1i2EsWbO1SgjwrfzkUO3P+yGlmkll9UisPtw1xT67sMAPQjiVEF8uOvtqcOSgR64KEU=@vger.kernel.org, AJvYcCVuLrZz/fDDbxpV1eWEvMVOTRS6J7YgG5psCQRMXYl7tQoTMALEiKaNvVAlJxcG0e8FZKbceg1PN2Vg@vger.kernel.org, AJvYcCXM7j1Vnr3xoAAOBOzepVlBki22dItL1gsE2aOqyDzYazx0/ZUCjm+wg2g5pkGrEgpvh/ssuUAYzb9ryXHKov2qjArd@vger.kernel.org
X-Gm-Message-State: AOJu0YxY7sLYRPtXtXHjbEvAbUqcaZdIerSOKeiOvYeuFbj38LsBTuWO
	CliQMC6pA77E1g/NBch8fT5DKfNjbpu0Hv58xPbZnAZUC4Kkvl6H
X-Gm-Gg: ASbGnct3+IObpQGtl745w6BQnrtxsDZQ4f5x+wH9TpZWloxysAArganGzOM9TEU5BxI
	Dekz2uow135rezd9ROaI3vDXTaRt7Qar2fIWGSkTgzY4UL422iSE4msX0iEHVLTk0d9Id31AIsM
	mzd/Ltu28KQ6G3qLyIFk9qlVtKSFcJMeuccHFnwEx63si0uGrxlwOWSdJW5fsj6mF86O49OLBvq
	1P0r4i8bBjafN3ERmaStxtk+ZqkxONSYerDL0DQLKg=
X-Google-Smtp-Source: AGHT+IHlKCroBAxYjIgfZFU0SdqmstPeu76nRvVdFQsYIsuSUzLVYaxbpBap4Wm79bvXteS0Kfg1YQ==
X-Received: by 2002:a05:6402:358a:b0:5d9:a62:33e with SMTP id 4fb4d7f45d1cf-5d972e162b0mr26005083a12.15.1736933813107;
        Wed, 15 Jan 2025 01:36:53 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046a195sm6957319a12.57.2025.01.15.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:36:52 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Jan 2025 10:36:51 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>, mhiramat@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <Z4eBs0-kJ3iVZjXL@krava>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com>
 <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114172519.GB29305@redhat.com>

On Tue, Jan 14, 2025 at 06:25:20PM +0100, Oleg Nesterov wrote:
> On 01/14, Jiri Olsa wrote:
> >
> > ugh.. could we just 'disable' uretprobe trampoline when seccomp gets enabled?
> > overwrite first byte with int3.. and similarly check on seccomp when installing
> > uretprobe and switch to int3
> 
> Sorry, I don't understand... What exactly we can do? Aside from checking
> IS_ENABLED(CONFIG_SECCOMP) in arch_uprobe_trampoline() ?

I need to check more on seccomp, but I imagine we could do following:
  - when seccomp filter is installed we could check uprobe trampoline
    and if it's already installed we change it to int3 trampoline
  - when uprobe trampoline is getting installed we check if there's
    seccomp filter installed for task and we use int3 trampoline

other than that I guess we will have to add sysctl to enable uretprobe
trampoline..

jirka

