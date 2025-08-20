Return-Path: <bpf+bounces-66080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D821B2DC3E
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3F67A6583
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395E92E62B1;
	Wed, 20 Aug 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc+cl2Td"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8092D6639;
	Wed, 20 Aug 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692344; cv=none; b=NRtElwc1PszN8LgK+rswGvEwYeUwWpWyFe7hafGc8emT9jDpnzTGIZTXKAyi+EFL5HfMyPacZesxnKDrmK/5B1dKOLS8GpqxiW6nIlqKH5Bky6cORLkiqkRJnupOWA5+wKeW4Mz2YOA5ZY4C0bWrwS1D4nllsDayRbnEMDQXlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692344; c=relaxed/simple;
	bh=Xqv+/fPvXKgUeiydkHHJT3gITGIHF+fYQbYUDsajg2A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNstT7/Lu5Nb2oyoGeqKmMZs9S6Xg01pB6qrTaGtOWpd24qlJzov2FGy8mJcE/c4g26ltt8ahWeEMSVF4QhZcW40YoDqwtFmxslOyC0PkxAipBqNWC+Bv8r0yGhPNWm1xT4GXiTbHl316WSJpnBj/GFpqEPg+O+GDqik+EMdhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc+cl2Td; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b004954so46591675e9.0;
        Wed, 20 Aug 2025 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755692341; x=1756297141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GI/go3ldWysRCFnDe+HVoMG5rlSajkF9o4GsGDgen+Q=;
        b=Pc+cl2TdsWBudFH5R+AqONbl6oh0CzJZyExGpu/QTH0zzIFJ8FOz4TksYdDbeu/loi
         qBaogPzVhWFYnid7+DJj90DtRZMmqMU6pQw63IspR2yt3ulgy7OWGIuxl2yjcQmKc/7X
         HHcdQe1sSF/1/8+RM7eEA3VePldhkg9oU+vU1RrnCvZKs0OdcGGP5S5txB3/ZJ3isnCB
         o1LFmEC1P6k+WTP2Ad1RbnHO/aaj0KdajrHNtQKnKfVTrqX6beDcaTtcxiuVY09yro2o
         0JSnIFmSP7Q8IO3ZTuzB+PWdkze3LgtTdlWBXnST1lGC1jb9zM1bggETh7B6I+89v36C
         RTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692341; x=1756297141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI/go3ldWysRCFnDe+HVoMG5rlSajkF9o4GsGDgen+Q=;
        b=OiZremnlLXygYT/JnTY8b0zGGdg3nkTcuQznVzD/jMaMZhjOq8TxPpKbnJY0tk1Wid
         gI/sQG9+EZsH72shS3NJmg42bEnMSB6IqN4ZP7rwH9tQMJw94dYP/ofbAHM3ZgJ/Q70q
         iTOiyiayX/rhT7L4LxHXccf1xHe++tlF5mN0T0/35SLahFIda0aqXmRXEkkI/iQ6+4MA
         EgALlJa5lqbyTWxqs7ip8g7K13TIZg5nSUh6TDvOQbbYw/Nx0xMKCL8eNaLRo9hZy5qY
         maENg2hYxaDmiGW09noeIMqZCNtSYx6nVSW4j9i5W9bKpaGXt6+fGkmLYh/VjGONOjOk
         j/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8wYWpJFnavWZtpz4ALm0u51M4obtIWK8LMsMgT8R32BuOl2LeS+frLUrnSXDzfdqLQTlK/4PktKyB73v+@vger.kernel.org, AJvYcCX76A+gch5qLuBTSS7X8LrieK1GWzFeBVmYB6KPZELwPbqVMrQjz7ozAbkPaqmePnN+eNM=@vger.kernel.org, AJvYcCXr8ruyrFe34mo4OtXqJKex7XxbESAp7vznofY2fTY7gnP2ff8rLmewg752g8Y1sHCWm3lk1+2dXnACJK8DXuFkekNV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+1aovCAj2twTbILfCRzba2Ml4QNthS+z+OMxpOY84rQM4OyL
	7oWy3aTHQop5c+hycTpKEZENEfbBsNfICcVUIaHFlTUIDT/t2SRlFXTQ
X-Gm-Gg: ASbGncvofv/1leGV/w6yIkZvn2VMu3i6vVCFu1hvtikCJ18q0yNX4Fi0Ko8eLNFuZur
	2vwfaz15+LfBFn9hAMy19ZWkP/O9HyFFkuTO+uuME+hRu94EJ06hHr+AullfBm0jXlJQURhIun6
	th08/TY1G2vQIEzQ7NlhgluT/+/kv6woabIjJ0Oa/q41/c/0CWEM/F7kpFT6+KTF+D3h//ZmRLE
	7qNU62ILTw6Ku6ueytzmmhjXXwYIZEpK7fR0n1lIzG0rj2p5yIX/cYOWrgTJ/i2g9s6hGr8sp92
	FGR4KWiRF+AEk2wKelr6WX/IYP0hRw5cHEVFIDWBQQxCKudu1ADdTCKSu8Wd7CGXEk0chSc3vxE
	qiDZ2ODI=
X-Google-Smtp-Source: AGHT+IHJ+tU2fM45DI2ot9VR1BpSQ14mEoDogR18uG0MTDiB9Qu9dv4Wtzuja/t2XucGRZHMRTJyCg==
X-Received: by 2002:a05:600c:4691:b0:459:dd34:52fb with SMTP id 5b1f17b1804b1-45b479aa901mr22161715e9.12.1755692341248;
        Wed, 20 Aug 2025 05:19:01 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47cad57asm33272345e9.24.2025.08.20.05.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:19:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Aug 2025 14:18:58 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <aKW9Mrbj_6H9MXrm@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-9-jolsa@kernel.org>
 <20250819145345.GL3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819145345.GL3289052@noisy.programming.kicks-ass.net>

On Tue, Aug 19, 2025 at 04:53:45PM +0200, Peter Zijlstra wrote:
> On Sun, Jul 20, 2025 at 01:21:18PM +0200, Jiri Olsa wrote:
> > +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> > +{
> > +	/*
> > +	 * We do not unmap and release uprobe trampoline page itself,
> > +	 * because there's no easy way to make sure none of the threads
> > +	 * is still inside the trampoline.
> > +	 */
> > +	hlist_del(&tramp->node);
> > +	kfree(tramp);
> > +}
> 
> I am somewhat confused; isn't this called from
> __mmput()->uprobe_clear_state()->arch_uprobe_clear_state ?
> 
> At that time we don't have threads anymore and mm is about to be
> destroyed anyway.

ah you mean the comment, right? we need to release tramp objects

the comment is leftover from some of the previous version, it can be
removed, sorry

jirka

