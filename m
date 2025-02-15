Return-Path: <bpf+bounces-51646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE47EA36C4E
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 07:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B17B7A481E
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 06:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55074189905;
	Sat, 15 Feb 2025 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjwO2miR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC40BA27
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739600254; cv=none; b=V9WtX/QYVkD01NoQwcp7VQpdLBQJXxKqpblpGyEf6QV/lzHdmdr3EiBLTdE0M3etGh6lZJ8LiAawoAfeIb+YLrPq5LvrCBgNt0JEe7He2Bp0iTF+9ZXj1iaeWE6eWZaYaQgDqcQOZIVK15rbvd3jAaVL7zER1teYtoKe9Xr6PME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739600254; c=relaxed/simple;
	bh=9pM4MZBrccRRjYXvKtvulV3cwNMSnWTBuYn+ZE0uDdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GggliXLvLNwHlAvUnQK4Gkun2UdaxKRCKwX/SbanC+q91HX7EOCDr3gU/77TanuZVrYa0VfMuZR8+NDleVqenhSgi5EDpu81br5/n2IEePJJ81LNE3/6GXUQqABhOc4cpqgRuiy/dQ4zJqo5UZcV1kgYpswdoz6e6LRDODiL+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjwO2miR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-219f6ca9a81so55995ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 22:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739600253; x=1740205053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3AY5WU5lQWjVx2WV5S/fns2o9ZSTHNwmgBqh8WjXEwg=;
        b=fjwO2miRNPTw3s8nRiORXZftUpF8N6dUG2vpi64oTrFYa27x9CWq3lEPGY166XpGaU
         21Iq0+gf0z4A94p2BI3jksZNL9HI4e8VyHrEdB0BiGiLKRdwndTaSjtz9Na8AFH/Ik34
         h1PhlOuvnc1D6KNY0JSpKwQJqLDhN3f/nmKyMqGckpoiiMXgckODUmFez7CyAhi7baqe
         3j5Ouky/u5CHiNYwt9pkAwLOSfgpKv2xoipvFAR71ag2+tyvCpJ314fzpqq2uer6EGo8
         XVk+ZOd2UVZ8fyFLe3ASM5jLh0ueKiJZAA2S/u7CmLiHhgwX0/Jegxefc0qCqZ8r1+oT
         VAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739600253; x=1740205053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AY5WU5lQWjVx2WV5S/fns2o9ZSTHNwmgBqh8WjXEwg=;
        b=Mh/rdAAgRQfXPxusC7vs+2A+0kU1mfwhkAF7bOjJ1Zqj8sCLQIORNUM5oqj89BEdSD
         kfqHggJPV20wfy62WIv4tXw9weZj560FMOZSNFRQUzxyXu1BWinAD2m+WPr+y+uy1uHP
         ogp430IRz2M+tM19IMImBMqNTwzjoWAFBOcHuvx+fJfEYILyVM6agIe4Pzd7DHBxrI65
         joxJ9QZFPvQOqMd7VN+pEnwLTV/V+dvFfTFExsSMu7VnkSi1OcuVCrfON3heOA8HyMNO
         j/0C8EKHbcRytAnu6p872HADpT37OjoD2nvygVaFZ6q9j3JLLUfzAngeew2Vqi1dBTNf
         WIjw==
X-Gm-Message-State: AOJu0Yy7K+2DZQNQ5GLribP7VSEwsW1q4zZw4M5BuyAbLbi6pjmU+mQ3
	aAAL46fVT7LH17oOwDGtZuIAVYmNI2IvO1OYFqHUUskZirQ4j/VwgLx1nKSI23/KZZpya0+RtdZ
	HjA==
X-Gm-Gg: ASbGncvPYgQnxQnj37ByCf2aX1Emww7MaYuOyCWi6jnpkLQooERhxltaOA8ITYAISRV
	vvTXQ/GuR4l7dwtGq4w3iuW98Vq4wdrdvQkw79F5IoG1Ja1JfOVGmo2xvPyrFYWoYluer4UI/4F
	TQqrm/RF9IOMS1Ll/xM/dAJsYwGPbZvmuyG8o1pUPnROf8+L6X8oi6PpFWdnzZHVKTGihx6c9KW
	1tP5ifovliYYJg0mG/2B35hyQ5oVJz5GxlhLhBtgYxyeHuAmKL4vKc1v89StDNBOjWg3V7Ec72l
	Ne4XOGh3eBVbNFep9RZ7m0ZdLeobkLefP5FRHGAUFKd1kfTDZNq68A==
X-Google-Smtp-Source: AGHT+IG3gQqGGdGWUSbEL9fmOrHw9BsfZ57p5du2ldVLToKKJX9c4jY9plcbSAXbZCMwuUN119NPhw==
X-Received: by 2002:a17:903:94e:b0:21f:465d:c588 with SMTP id d9443c01a7336-22104c9385emr1243535ad.14.1739600252382;
        Fri, 14 Feb 2025 22:17:32 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e318sm4272875b3a.96.2025.02.14.22.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 22:17:29 -0800 (PST)
Date: Sat, 15 Feb 2025 06:17:21 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z7AxcSwD-topj1bk@google.com>
References: <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
 <Z6gRHDLfA7cjnlSn@google.com>
 <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>
 <Z6qC303CzfUMN8nV@google.com>
 <Z60dO2sV6VIVNE6t@google.com>
 <CAADnVQ+OyoBPOJk6dcUFozTt0RD-o-hHdR4Dgy+dK2r0uHyC7Q@mail.gmail.com>
 <Z63aX0Tv_zdw8LOQ@google.com>
 <Z6_9LgfOMeR18HGe@google.com>
 <CAADnVQKZ=pjXjyzB8tJj5Gen4odcj5H5JhXyRtVgphTEDCisTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKZ=pjXjyzB8tJj5Gen4odcj5H5JhXyRtVgphTEDCisTg@mail.gmail.com>

On Fri, Feb 14, 2025 at 07:04:13PM -0800, Alexei Starovoitov wrote:
> > > > How about:
> > > > #define BPF_LOAD_ACQ 2
> > > > #define BPF_STORE_REL 3
> > > >
> > > > and only use them with BPF_MOV like
> > > >
> > > > imm = BPF_MOV | BPF_LOAD_ACQ - is actual load acquire
> > > > imm = BPF_MOV | BPF_STORE_REL - release
> >
> > Based on everything discussed, should we proceed with the above
> > suggestion?  Specifically:
> >
> >   #define BPF_LD_ST     BPF_MOV /* 0xb0 */
> 
> The aliasing still bothers me.
> I hated doing it when going from cBPF to eBPF,
> but we only had 8-bit to work with.
> Here we have 32-bit.
> Aliases make disassemblers trickier, since value no longer
> translates to string as-is. It depends on the context.
> There is probably no use for BPF_MOV operation in atomic
> context, but by reusing BPF_ADD, BPF_XOR, etc in atomic
> we signed up ourselves for all of alu ops.

I see.

> That's why BPF_XCHG and BPF_CMPXCHG are outside
> of alu op range.
> 
> So my preference is to do:
> #define BPF_LOAD_ACQ 0x100
> #define BPF_STORE_REL 0x110
> #define BPF_CMPWAIT_RELAXED   0x120
>
> and keep growing it.
> We burn the first nibble, but so be it.

Got it!  In instruction-set.rst I'll make it clear that imm<0-3> must be
zero for load_acq/store_rel.

Cheers,
Peilin Ye


