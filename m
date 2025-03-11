Return-Path: <bpf+bounces-53820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D24A5C2C1
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1DA7A2F78
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD8618870C;
	Tue, 11 Mar 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFu2x2Am"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8817156880
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699959; cv=none; b=RIo+K1X2u68YgBeMm/lo6V/cVUWEEJlLpg/owai7FVFIVVpxfQMY1oQFIA9yvwXvfenrEfj3fcdde4OqeDd8bZNP27ZhPcma2+c7671sQMWsb9lXuXUO8mDfgCISqJswfR78xqcyTsPgoVrvUecfgnvgtiqGHvpWPGc99sXB8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699959; c=relaxed/simple;
	bh=7YbnVmNe8UoRCBcf+1f3EZFQxgV8TT5S1exL28Gr7wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mwq21i9I6nnrb8D40vD0+NPPHq+0m2pjPpzdh29gpK2E7YfejGHGcelp2H/bvWCSNiVP+VyWSPksbiH0Ce4w4KWcfVgJarO76NnFJ+prTQVqt6tqv9HKy8XyyLXU5hMcW4tZdFLCSrquC/ajFZ7pGOYDIl77Be1UO8+oC3HPY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFu2x2Am; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39133f709f5so2118968f8f.0
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741699956; x=1742304756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdTYoEl8wfhHEewA/2JsHqo4KOPWgY33CGSVFDAwKuE=;
        b=nFu2x2Am3zgYrjJzS45Ax0gaSh/0bvZF1QnKs7q7yeSTbEYxLasBCWZR/e+hI4e0P9
         EUSRsENH7A3ohCXOJmbfBjhkPzl5y0GuXhOSt0+KTxOtgnHc6axVYdAH+Qhatr0/uN50
         +BB0ZtZc0b0cdzZxYGM14+yM1wuvfqz1cJZDgm6G8p+AGkOSkvTiHk3b0EyRidCMHce7
         QdgbhicvOIY8SVa+Q2+yJZyvTLqxFOwFQes+Ouk2Bbx0xTWVdLpEZHMByZJe9IaeFSIi
         p4oQjHYkCpAokApXIrLWhbH2lIp5lqYnjV7SKy7Aop7RnbCF44rOLSEatO4X/yX+7vne
         usHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699956; x=1742304756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdTYoEl8wfhHEewA/2JsHqo4KOPWgY33CGSVFDAwKuE=;
        b=NFOLYpqIO5EWNSKyxiCIPT9ljF9L2y+/topsRLa4gv7YMRqq/qWB8+JQw4g7SKdDMM
         g6Q5gA2ipM7Il3sTEAwJC3Ol+hyVYQD03NNmF/5kY5uIsjsbf3LHJE3kht5PTXL3DAcD
         YDzkpsPHVOn9eKzUX4cMVjTPBWIFgeLxiYaUN56cVvXmOgXvBb391Q4i73MOKGzYWCan
         HXi+Yj2U1rrpErLwpO8VI7Iwli5rcEmgDiv35PVTC4ILgIJwDFy0UOClfwwY4jGQXnuh
         8oEsL/fyChymZJ5mXZf8WBh2lFLkZYP/bTqVFC3xyJVb91HKPNMwDyzq6lL1AxKncMC9
         QIPg==
X-Gm-Message-State: AOJu0YxODFXXge3SvVUQgr4f6Bwb/uXK5Hbki0PnmQNSgReApTGgD1hE
	wlGUtFYWVjBlHhhpoyxSGrp0ReY4L8iXs7U0L12ULak0fi2dnsVG7hVP+2mnssl860XScwklGJE
	YxgF8KO6fu9GMzQDiyQxjRSNaQR8=
X-Gm-Gg: ASbGncsaUU6F2o924u4wXuYm8yc5CGsx/6UiswQ+LvTJQMAmsn4azX/SjSTJScQ4FSC
	IgiChUzECN6NLjdBCLp+usX4qPwWzpnfJ1vKg4Ynty/YR/VCVNYWzrlnC/ZTUyVGJDM7wm4i+Db
	KZVHsU1Ra+BKyOhVfAkSnNvjqzrA==
X-Google-Smtp-Source: AGHT+IEUkfhD/dw9hM3L/QFUgVEKOUsGduOUjXyRSO7SIgVBQyMoWBrdCZufpE6j0Uq2QsiYbNXfCHGwAWF6S9YA0V4=
X-Received: by 2002:a05:6000:1448:b0:391:4608:e7be with SMTP id
 ffacd0b85a97d-3914608e99amr8434110f8f.14.1741699955869; Tue, 11 Mar 2025
 06:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com> <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
In-Reply-To: <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Mar 2025 14:32:24 +0100
X-Gm-Features: AQ5f1Jp7QSTqv2heAEtFcjekuEzUH9DYv2etNft2vfsyOnMf-bVen3S-43kRLbA
Message-ID: <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:04=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 21 Feb 2025 18:44:23 -0800 Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
>
> > Tracing BPF programs execute from tracepoints and kprobes where
> > running context is unknown, but they need to request additional
> > memory. The prior workarounds were using pre-allocated memory and
> > BPF specific freelists to satisfy such allocation requests.
>
> The "prior workarounds" sound entirely appropriate.  Because the
> performance and maintainability of Linux's page allocator is about
> 1,000,040 times more important than relieving BPF of having to carry a
> "workaround".

Please explain where performance and maintainability is affected?

As far as motivation, if I recall correctly, you were present in
the room when Vlastimil presented the next steps for SLUB at
LSFMM back in May of last year.
A link to memory refresher is in the commit log:
https://lwn.net/Articles/974138/

Back then he talked about a bunch of reasons including better
maintainability of the kernel overall, but what stood out to me
as the main reason to use SLUB for bpf, objpool, mempool,
and networking needs is prevention of memory waste.
All these wrappers of slub pin memory that should be shared.
bpf, objpool, mempools should be good citizens of the kernel
instead of stealing the memory. That's the core job of the
kernel. To share resources. Memory is one such resource.

