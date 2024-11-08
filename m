Return-Path: <bpf+bounces-44397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6149C26FE
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 22:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FF41C20A65
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF561DC184;
	Fri,  8 Nov 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El554r9h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70080233D80
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731101138; cv=none; b=YGoAAqyJCmytGZdp3A/QllDuhZhm6gfgB6avfZkd+Hvwo0IgRRgjkoGoP2+CE/FVrxUH/B7XthGniJ9+0ctSr9yYLI3YZZBozIPTWEjtsBfu3cW/mPrHkIHbR6XzpisekCk7mO4aq+xjcS4Ns4pNtPMjwpptl2mrxwQ15S0Zwr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731101138; c=relaxed/simple;
	bh=nMSAiYBSCGv3EKC0vh3yQxO2vp8OykGIjtE2sBm8Ogw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aD5DP4p4o5PPGFZm8MQKt0nYeg2+0kGgDkP04kM7VbcUFNV1EqiIRNEodhtzL61GKoJWW1QoqMvr0mno+zVl8zQB7o3V7UoNoTAKCYFkV/1hwd1dC3jWDjhRD85mz9P1EktV+rMWeOM0fy3xX2gRr/NRkLqVFmVB//waQYoEnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El554r9h; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20e6981ca77so31530175ad.2
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 13:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731101136; x=1731705936; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9+V6sFKd0joUIdM3ECyn1kbn326D1kN16XuW4OZgCI4=;
        b=El554r9hnLnmxdmQSrxtsW6WkaE3xX2/p+8OAf/4vz+sXvPGmq9UYhg9SAgrD7csXu
         mRQKhiPWDY7jhLPrL3zCyjduHqaCACCq+BJkL6TjOHKFozoshzoC1clQYQO0B/3b6DYR
         0fn9OgRtYT+umIAlU9/XYgArqfOYj2bRdbru0KUQ6N/cNlE511JzlsJF1L1QjdwAvn4U
         n6fm7xaTtW1YPEAKg8no+0vRTb0CSDhqnqVHp0SWH8p0D/n2KuVG025TM8SyVQmnVW8j
         2ytZAXbPqFo1soB4BAVbQ0kheOIWAOKU2u1+GUjdMAfMmaQ2yPhvO515ISeMYYvFM5zy
         z0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731101136; x=1731705936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+V6sFKd0joUIdM3ECyn1kbn326D1kN16XuW4OZgCI4=;
        b=uJXQEt79EgkOPQEKKOTNrzh25Fo4L+GYa0wWVU3ucdZaeKycztU5btuNgZV5SyVabW
         izXQWJtTNBeE4QIlRNz4wthcdF4gV436EE1fTk6WCrU/GhmMSp925ELbYTmdphcr3eLy
         4Sk82tbXdnQJPzx4d6o+ypBzP2fjb0OFqetUQAEZg4qZOW0d8Oezv76VrxNgD2sxA+ah
         NM9TfJNTlpx0T116BySGYiLgZbvKkU1TOs2i9x8QWLxfeRiElK6sxSrNOSErohY1fd4q
         e1EjUDRQRD/o5l7RXnYKU6XrcT3+QuG431yACCO33j87dEipoUTRarK/Jh6w/u1WqPvX
         RN+A==
X-Forwarded-Encrypted: i=1; AJvYcCURbUtyEHuBTZHFiPas0/eZnLhusEdgOLiU5BMgeSjx1V/S80VenXWoIMlLMP/WkZn4Onc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiLy3wDkwy9OxWfGHGGdHXkL2arhh2O13zxDm/LaAnW25MDtE
	RS125LeQ1LDR9b9tKkJ0zGmJIthn+pKgIpXKck9yImIaJVGWDdXCg9xc9w==
X-Google-Smtp-Source: AGHT+IGivsZT2XkPjbPgJ9NGCH2hfgaPvjlPaGvnHf63DJhJvMZXfZ6mprK6dOJI2dkC86VGl8mQDQ==
X-Received: by 2002:a17:902:ec8c:b0:20c:ea04:a186 with SMTP id d9443c01a7336-211835da2e5mr48441185ad.48.1731101136454;
        Fri, 08 Nov 2024 13:25:36 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e49bcbsm35343075ad.161.2024.11.08.13.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 13:25:35 -0800 (PST)
Message-ID: <1ab081f87a60bacb563f4a55d02fa7749aaaeaf9.camel@gmail.com>
Subject: Re: [RFC bpf-next 03/11] bpf: shared BPF/native kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, 
	bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com
Date: Fri, 08 Nov 2024 13:25:31 -0800
In-Reply-To: <87ses15udm.fsf@toke.dk>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
	 <20241107175040.1659341-4-eddyz87@gmail.com> <87ses15udm.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-08 at 21:43 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Eduard Zingerman <eddyz87@gmail.com> writes:
>=20
> > Inlinable kfuncs are available only if CLANG is used for kernel
> > compilation.
>=20
> To what extent is this a fundamental limitation? AFAIU, this comes from
> the fact that you are re-using the intermediate compilation stages,
> right?

Yes, the main obstacle is C --clang--> bitcode as for host --llc--> BPF pip=
eline.
And this intermediate step is needed to include some of the header
files as-is (but not all will work, e.g. those where host inline
assembly is not dead-code-eliminated by optimizer would error out).
The reason why 'clang --target=3Dbpf' can't be used with these headers
is that headers check current architecture in various places, however:
- there is no BPF architecture defined at the moment;
- most of the time host architecture is what's needed, e.g.
  here is a fragment of arch/x86/include/asm/current.h:

  struct pcpu_hot {
  	union {
  		struct {
  			struct task_struct	*current_task;
  			int			preempt_count;
  			int			cpu_number;
  #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
  			u64			call_depth;
  #endif
  			unsigned long		top_of_stack;
  			void			*hardirq_stack_ptr;
  			u16			softirq_pending;
  #ifdef CONFIG_X86_64
  			bool			hardirq_stack_inuse;
  #else
  			void			*softirq_stack_ptr;
  #endif
  		};
  		u8	pad[64];
  	};
  };

In case if inlinable kfunc operates on pcpu_hot structure,
it has to see same binary layout as the host.
So, technically, 'llc' step is not necessary, but if it is not present
something else should be done about header files.

> But if those are absent, couldn't we just invoke a full clang
> compile from source of the same file (so you could get the inlining even
> when compiling with GCC)?

Yes, hybrid should work w/o problems if headers are dealt with in some
other way.


