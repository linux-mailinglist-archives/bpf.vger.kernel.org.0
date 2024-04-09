Return-Path: <bpf+bounces-26256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF089D39D
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 09:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF1AB21E78
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD807D414;
	Tue,  9 Apr 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgfalYQU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F77D09F;
	Tue,  9 Apr 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649480; cv=none; b=qRpjrwbdVrEumEpvY2TBW62uOebCC3rCfiA367qToETq4qyyla56e6vzuKkVX08tkm0KtPH36AhKDsJPGMdjuvSUDGk4EAi7540jITqogw+OVeehhFhRZWexwmKrb3lVMwD1eW+iYFckW86A7UZgsbiVuy6QGQiE8no9FmxDWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649480; c=relaxed/simple;
	bh=+96kTkCYzibKfYMPaLZoRN4b2dBphMs9/4tzob3I6KM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyKFBZiy1s/8I89CzrkDiSQvO6mc6vKMxfUJNlKJE6eKb42r47JPZdsJUvXbTmOyhc5y20+C0p2Yq68ZT6tCc8sH7aCfkrmAj+f7wgNDTRGLne3Xmr6+x5Gu25WvZ0DcISTv3gf3v6e3/DFG6PhUt603TopVgqmPLCPGNOtthcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgfalYQU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4155819f710so41360385e9.2;
        Tue, 09 Apr 2024 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712649477; x=1713254277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9YXgPNf4gqlB56sgUucCnlcjmHfsJoKI/6vQ+DJBgs=;
        b=cgfalYQU5jiklB12MFso7LgZ48CDHni5bJNH0gm/bkzMZkFD42R3i1cBnzwWKdMk/X
         RcJgbskjwHR2BvhRtCoULqXSOjskzBy+gto8dAxqNhv4T/WKTbVGVNZ7iR7907MazEIa
         3R4UgroyfgKIRNYCJUnui5Um6WFMirREltu72ywCChYh4vo92NYRF7Zwrlz5uM9bya3G
         Pr+1jpPEnTKCx+jyjpqWViMs/urrjUZAszvy7NMxbvl5a+GDR8xddwiES6TTEtmLbKc1
         eBSzpEsfjcPpZQM6nLaVykVuQfSKS+88yQFowSSczLG5HSS8TywkP2tEtcsPDUfd3Noq
         V3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712649477; x=1713254277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9YXgPNf4gqlB56sgUucCnlcjmHfsJoKI/6vQ+DJBgs=;
        b=gs+mELdQTZZGjM+1pfe0yiESxp8Fqa+XG/Vc7o80MmuKmn3A1Cu7QqQRLARcX+FzDp
         ZwQ6cG+103SYxxeB799wedHF0AfG05+xb3KpFHvk4pcWxo/MOnwySPZ1m/VcK5Jf+v8j
         oJDchrYQpKW1EI6UQMn8g8SENPn3CQHEMtWSSp0hajYVz2LUGbfbbKNLHDCZ21YmtVan
         INLyca8McfsJfxeH4quYWIqIOON7dPd4dd0oOVZWcYNqfVbththCKbecWJ7tiBIR82DK
         BgB3rNrXX5O1VRqns7IQEl/fjfA/MK2iAWZ8iyuXbwEYyfkNZMqCzN4c2IR2i2rBVAx7
         mV9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcX+GgfxFLr8h9LXRC5Ihyzole7M7hVeIOWpGkPKYIGKAmAACx96IY9tSYkRRoFPDUiSzFS8DsWvhB3BsnocSExj8VdTdj96KKc39zt4hHgoxo8EQSo/zNDZtELJ7aok6EtZv6bo9swV60Ik0jm2X2GphW0ZOnrZFmj7EHrG0R6X7gzTKUi5TVU/B1UilY9bBirLO0hb8pMAoAbuADNatQ
X-Gm-Message-State: AOJu0YwL8a5ae+taiZDxKD9wZs+79suTuUT9HuxVryr3Slobtb3t8muG
	UyHV5SA7Gs+WKoSI+RuyePE1h+nrmqqSosiNoPS11SpD5oKLbiiA
X-Google-Smtp-Source: AGHT+IGfcRPUdOU4LdcmKZhc/BCzg5//3D6sVRaofs9HaPUsmttu7vgsDhJ+E46cqaYgpIyD4IaWQQ==
X-Received: by 2002:a05:600c:4708:b0:414:95e0:388c with SMTP id v8-20020a05600c470800b0041495e0388cmr8811472wmo.8.1712649476445;
        Tue, 09 Apr 2024 00:57:56 -0700 (PDT)
Received: from krava ([81.6.34.132])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b00416aca5ff66sm970839wms.19.2024.04.09.00.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:57:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Apr 2024 09:57:54 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <ZhT1AqFmo3jwOrzC@krava>
References: <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
 <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
 <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
 <20240404161108.GG7153@redhat.com>
 <20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
 <Zg-8r63tPSkuhN7p@krava>
 <20240405110230.GA22839@redhat.com>
 <ZhQVBYQYr5ph33Uu@krava>
 <20240409093439.3906e3783ab1f5280146934e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093439.3906e3783ab1f5280146934e@kernel.org>

On Tue, Apr 09, 2024 at 09:34:39AM +0900, Masami Hiramatsu wrote:

SNIP

> > > 
> > > > this can be fixed by checking the syscall is called from the trampoline
> > > > and prevent handle_trampoline call if it's not
> > > 
> > > Yes, but I still do not think this makes a lot of sense. But I won't argue.
> > > 
> > > And what should sys_uretprobe() do if it is not called from the trampoline?
> > > I'd prefer force_sig(SIGILL) to punish the abuser ;) OK, OK, EINVAL.
> > 
> > so the similar behaviour with int3 ends up with immediate SIGTRAP
> > and not invoking pending uretprobe consumers, like:
> > 
> >   - setup uretprobe for foo
> >   - foo() {
> >       executes int 3 -> sends SIGTRAP
> >     }
> > 
> > because the int3 handler checks if it got executed from the uretprobe's
> > trampoline.. if not it treats that int3 as regular trap
> 
> Yeah, that is consistent behavior. Sounds good to me.
> 
> > 
> > while for uretprobe syscall we have at the moment following behaviour:
> > 
> >   - setup uretprobe for foo
> >   - foo() {
> >      uretprobe_syscall -> executes foo's uretprobe consumers
> >     }
> >   - at some point we get to the 'ret' instruction that jump into uretprobe
> >     trampoline and the uretprobe_syscall won't find pending uretprobe and
> >     will send SIGILL
> > 
> > 
> > so I think we should mimic int3 behaviour and:
> > 
> >   - setup uretprobe for foo
> >   - foo() {
> >      uretprobe_syscall -> check if we got executed from uretprobe's
> >      trampoline and send SIGILL if that's not the case
> 
> OK, this looks good to me.
> 
> > 
> > I think it's better to have the offending process killed right away,
> > rather than having more undefined behaviour, waiting for final 'ret'
> > instruction that jumps to uretprobe trampoline and causes SIGILL
> > 
> > > 
> > > I agree very much with Andrii,
> > > 
> > >        sigreturn()  exists only to allow the implementation of signal handlers.  It should never be
> > >        called directly.  Details of the arguments (if any) passed to sigreturn() vary depending  on
> > >        the architecture.
> > > 
> > > this is how sys_uretprobe() should be treated/documented.
> > 
> > yes, will include man page patch in new version
> 
> And please follow Documentation/process/adding-syscalls.rst in new version,
> then we can avoid repeating the same discussion :-)

yep, will do

thanks,
jirka

