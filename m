Return-Path: <bpf+bounces-49391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B858A18019
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021A218862A2
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 14:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E041F4286;
	Tue, 21 Jan 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvMW59qo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80801F3D3C;
	Tue, 21 Jan 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470341; cv=none; b=ZVrVyXGt0jWSZHGhWLFtnYC/6MC5qTf1OK/hqboZnRBsEJWVD0idKtMIJtQFda9QZbLHrvp1oJ6UB95AoLlViFJxF9CTF8paW/mdUuYVI3fextdDlJLO3CNwLQXtUER1PGZZL/ZjYi+nS7yk3txTegZm0JbV6qUborDgYlVToUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470341; c=relaxed/simple;
	bh=NDb3c3rxblkJhIMSxUpUGDYxdUYnogGCKjor79k2CbI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF9oJQcIXGdOqzDWZZbRswAsNMZ2d/hTQC5czmIMHqnmpcFUkLKOIYo4uD/Gbl7LJQAAONKwYCPtgdULWFv3gtZkwdZXEkXwLmhJa3caPFJcLhYwxss9RLQgAvMC1Y2QD2hzdkLGg/CIQ9WinNNEM2Ts8oi7tg0yfMJGN3eSaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvMW59qo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so1129469766b.0;
        Tue, 21 Jan 2025 06:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737470338; x=1738075138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJA4KS8nHHtP6ZQfKRoHiZPqETFaft+MeGa73f89gpE=;
        b=OvMW59qoEcUaBdNagcPx+mU2iu6miUJQXXZMUJg5asGlvlMVFahHDa9mXqu9i4Njqg
         c/RvsjUOvPzJd2VQnCR3jrA8EA//b+7VvRw3QcjpyimXPR5QlVGQOBuRCoM9TGUgrNmi
         gbBiCWb/sN/3e4312ZpiHJ2TC/1+PPm+6DHjjvCjDCizlZX+W7CoODRJwykVZx2Bzrlo
         TN2HCnERWp9dM5oOPSgloEBdPW04fjX6bbTlYcAWvOn3FMh7ZauLiLFmZRcZWyczYz3g
         xlQgvUYPoFgDL8NCmzfOBjGJTQukbaW9T3MJrb4M9jmBqrTh5N9LnozoHKAOAcaYGs+q
         /xrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470338; x=1738075138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJA4KS8nHHtP6ZQfKRoHiZPqETFaft+MeGa73f89gpE=;
        b=BSMkiyMgkcJdBPs4D6oG2ckoueDrKHQuNu75IoIghwx1bll8lKE0EeC3Ft5R0LDXzR
         ICNKT1rgUh0M7ZlZXObhfSBSSmR7e11twBPbuevIuYUCGcrpD6dYJ2PbOJzfkpu8fGhb
         1XzlKtsl4GAOy+5lV/cTQ/cNb7rsyQsY//5+Pwbg7UQIu1Ch2Xf6EOS2iU+9hosJpKpe
         NJ/WL1DBwNZPxUWiODPI8/o0b4LBfeslSXdlmln0gAIvodGnsAVFHnIM1vcGBjsXF7PK
         iocffdBA8+ovY2/HrZZA1189GpaVfBdCPHSB9ZAh09VpAer41lGn6QAExFOT6i1JFvmZ
         Oa1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/KJLN9J8fO5KCLia33dWdtnEQcmCs0jJ9buTBX6KFSgXSerQ5Q76a6jv+14ltQQnbfICxMeTQHB9M@vger.kernel.org, AJvYcCVARmYtO3IlnnhP7xeCG7d2njYO+bJ5P+us453QH/nMJB/QJI28U+6lDfrovRfKCtZktniGkYgz75treosT8KJXmhjM@vger.kernel.org, AJvYcCVmbae6DnH7KLB2CVEWUS/QkMsiYQFjwWZOkFxx1u9D9w07J1IXsVn/QAtKgj3UtknwdlIchMUB@vger.kernel.org, AJvYcCX69w5rcbsy4YzdXiD6nCgNUEC7zatVTQj5QgeclEiERKAEcIwAOpMXHQVvTenMkfTSgBco5GYDH2u5gc1J@vger.kernel.org, AJvYcCXxUVmaLdMp50JIsi5m44KUEjA8roJ9PvsE8NYyiXfiV6mhkOAsHYNSiT83S4PyF5Vad20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPg+aUvB3CDqo0wnNJmjiJMlatJ4LmVGfO0FY1A3XgFLcek43
	A6VaF+EmPsF0YFfokj5zAgTL0/qvByMlDaxGKg5JA1/HHoodP9PW
X-Gm-Gg: ASbGncvtdgv4jFe7dRDCOuaHdWFkFDNz9+6rlNOWJ9XOlnsVSnGEo+PBbSz2fjQpbAf
	AyONu5mkiu7OaYdQkH1LWBIbX8n/NJ9FXQjX1IKlc7xRteL1yJgy6twvMDqt9MP87jRr37Z/2fw
	NbfAYv3EY9RwwyWdCTYUsk+dYbGF2ds6vxaAYaCd8T3JtRHGdJRkrj+8KCdyvaA7YlTtKgdaS/E
	A9AiUDazwiGDVbdTgA/NYvIj8Nhma9imcnuvQMeQKeCq8TBg8ZkCR/2xwIf8lkp8N6Rzy0Re+MT
	bT/2Tw==
X-Google-Smtp-Source: AGHT+IHbt51KgaNHWYPsUJyDM3PxIHsFbWa2cwUWn0p6bD6sqDfQiHdD/IM2ZAFY8hTlRWEBkFudxA==
X-Received: by 2002:a17:907:3f11:b0:ab2:aea7:510f with SMTP id a640c23a62f3a-ab38b320310mr1794735466b.30.1737470337728;
        Tue, 21 Jan 2025 06:38:57 -0800 (PST)
Received: from krava (37-188-142-170.red.o2.cz. [37.188.142.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2dee0sm759550266b.78.2025.01.21.06.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:38:56 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Jan 2025 15:38:48 +0100
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org,
	oleg@redhat.com, ldv@strace.io, mhiramat@kernel.org,
	andrii@kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com,
	cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com,
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de,
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org,
	andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io,
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <Z4-xeFH0Mgo3llga@krava>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
 <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
 <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>

On Sat, Jan 18, 2025 at 07:39:25PM -0800, Eyal Birger wrote:

SNIP

> I think I wasn't accurate in my wording.
> The uretprobe syscall is added to the tracee by the kernel.
> The tracer itself is merely requesting to attach a uretprobe bpf
> function. In previous versions, this was implemented by the kernel
> installing an int3 instruction, and in the new implementation the kernel
> is installing a uretprobe syscall.
> The "user" in this case - the tracer program - didn't deliberately install
> the syscall, but anyway this is semantics.
> 
> I think I understand your point that it is regarded as "policy", only that
> it creates a problem in actual deployments, where in order to be able to
> run the tracer software which has been working on newer kernels a new docker
> has to be deployed.
> 
> I'm trying to find a pragmatic solution to this problem, and I understand
> the motivation to avoid policy in seccomp.
> 
> Alternatively, maybe this syscall implementation should be reverted?

you mentioned in the previous reply:

> > As far as I can tell libseccomp needs to provide support for this new
> >  syscall and a new docker version would need to be deployed, so It's not
> > just a configuration change. Also the default policy which comes packed in
> > docker would probably need to be changed to avoid having to explicitly
> > provide a seccomp configuration for each deployment.

please disregard if this is too stupid.. but could another way out be just
to disable it (easy to do) and meanwhile teach libseccomp to allow uretprobe
(or whatever mechanism needs to be added to libseccomp) plus the needed
docker change ... to minimize the impact ? 

or there's just too many other seccomp user space libraries

I'm still trying to come up with some other solution but wanted
to exhaust all the options I could think of

thanks,
jirka

