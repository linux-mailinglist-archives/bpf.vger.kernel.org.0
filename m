Return-Path: <bpf+bounces-31142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B08D74F8
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 13:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D1328139C
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382838394;
	Sun,  2 Jun 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPhErJLf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7206F17BD9;
	Sun,  2 Jun 2024 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717328170; cv=none; b=tSCO1Y/rWBIrO46DcjwauROQfgmxBvh8MyypQcyPuo68sDtJTXvPXAdZF9JqApQSufk5gSDjniA8sgIEEPapNo5ukDXgN7kef5j4kDMDCfLjAGeA1wh3KLSnNlE1roDAJpnUTRaGisoyVPsSmUpI749vcbqI2RWKh5P7a8sjey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717328170; c=relaxed/simple;
	bh=FOo2QvzzOgJw16ySqTtOHMK4PlRx+7XYznG2GztJOhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+mzKXQr/wXeWRh0+eF3ZZQKVVkLOHvh7i3x/c8Ewrg0hl/45bW/xexVMWAvY5v86V4nc8RJRqWAWHwn2l0o/HByFjxZ61EZgqzhfh7hEbf+1j1qQVXpMcNzfr1Z2dTHVWH5gR0tweWVNoqfw0iK8tXp0qxNB4cSY/rg+v232eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPhErJLf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a196134d1so3881318a12.2;
        Sun, 02 Jun 2024 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717328167; x=1717932967; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJnUfRpYDIz1jm/Tu3w6AMIdtyuVPoIRBKnHAV8Af8U=;
        b=TPhErJLfhILuBdQpHq7Few9YnSQAafK3TIefmj7aqUP7Ck5nekHRt9491UjZJjyRRS
         /PIJGrWwp4XETs8FX1jGxybzDaFwoR3d0NXpZyBlFuw+/bDaN8Rvb/fMUs7vMcnx+eE1
         p/df5gHJydn8UIH4KizXv0/n//GoPgK9Mwv5b+Qus2QF5Xg/uYiFM6Nz0sxi0W1JRKxs
         73wl0fziWk5of4U3YyYUH+doHZNL57KVYjb8+1WxdYlg0LvxVUB3cfagrPRBK6XpT86r
         ku9BVjYZxW3QojBOs9+rlVFjg7HvC2yZarNrJcgYU2Dp9iLdTQFvD00u/479pCrlCl3v
         pwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717328167; x=1717932967;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJnUfRpYDIz1jm/Tu3w6AMIdtyuVPoIRBKnHAV8Af8U=;
        b=GNNCTwuxLk1dn43xw7PNlBBbbF2r0TQp5FqdsKQgE1oaYjy7uqu+EJsw1NLWmC0//u
         13Bb2IuuTLqlA3kwbcWSmy2SZjYSk/7E6FpmnEpv5jRyiDhfsRrOBpl2/Qg0ckGD9qb+
         0cJgEY6q0m2aiPpWoQ82i4iWdPPlrZHbyO61/xdGOHRKh6GdbX2Z+PouWoqEjWRSQ4a3
         0ZKzrhwEWSMumDaMVw8GbV1arBizo4T6phrRpLnqMMLvtzUlaR/fQZoDKyr/Lq5xTvvp
         pPzqy8Ghwinr7KXUNG0mWT72Ptkv8fhKRzYVs94I8xoDA6MHlFEUibS0IqcKfZ4kFK5w
         oUzg==
X-Forwarded-Encrypted: i=1; AJvYcCWQgtohwXDJB80EuOmwWtyd4sEbwZhSZ6frSoay8agkP5xaX5xJS0jlfP29TxGtch8wwyJAPjIbioTfXT6STJp+ATdvked6CD4qSAj43M6PVSS0qzNPM/UZ9TofNBg/lQ0aS6AJ6rOea7Thp7/UsEjd1MfC3ZKtTVNqygXUJQcvbC1bnQdM
X-Gm-Message-State: AOJu0YzNhF6G2jyO5tJx1UJ4f0h/T/sqO6/isUWG5pn4kV5gd+F9Gws1
	DQ8SpVFwI6UXelWCIdXzsyfGZ5u7Yow1AZd/KfXBE24xRaHKO7ck
X-Google-Smtp-Source: AGHT+IGjoFBqQ+UJLG3MIUhLGnmrgpKYVEVPilTn/+DpSFGXEUPnSuIltG8U2ylx3xnjxCsjWVdjiw==
X-Received: by 2002:a17:906:1455:b0:a69:2fc:8340 with SMTP id a640c23a62f3a-a6902fc841bmr32663866b.73.1717328166465;
        Sun, 02 Jun 2024 04:36:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b59e925csm190030966b.220.2024.06.02.04.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jun 2024 04:36:05 -0700 (PDT)
Date: Sun, 2 Jun 2024 11:36:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>,
	g@master.smtp.subspace.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] static key support for error injection functions
Message-ID: <20240602113604.pn74o7g2lazr7ugk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, May 31, 2024 at 11:33:31AM +0200, Vlastimil Babka wrote:
>Incomplete, help needed from ftrace/kprobe and bpf folks.
>
>As previously mentioned by myself [1] and others [2] the functions
>designed for error injection can bring visible overhead in fastpaths
>such as slab or page allocation, because even if nothing hooks into them
>at a given moment, they are noninline function calls regardless of
>CONFIG_ options since commits 4f6923fbb352 ("mm: make should_failslab
>always available for fault injection") and af3b854492f3
>("mm/page_alloc.c: allow error injection").
>
>Live patching their callsites has been also suggested in both [1] and
>[2] threads, and this is an attempt to do that with static keys that
>guard the call sites. When disabled, the error injection functions still
>exist and are noinline, but are not being called. Any of the existing
>mechanisms that can inject errors should make sure to enable the
>respective static key. I have added that support to some of them but
>need help with the others.
>
>- the legacy fault injection, i.e. CONFIG_FAILSLAB and
>  CONFIG_FAIL_PAGE_ALLOC is handled in Patch 1, and can be passed the
>  address of the static key if it exists. The key will be activated if the
>  fault injection probability becomes non-zero, and deactivated in the
>  opposite transition. This also removes the overhead of the evaluation
>  (on top of the noninline function call) when these mechanisms are
>  configured in the kernel but unused at the moment.
>
>- the generic error injection using kretprobes with
>  override_function_with_return is handled in patch 2. The
>  ALLOW_ERROR_INJECTION() annotation is extended so that static key
>  address can be passed, and the framework controls it when error
>  injection is enabled or disabled in debugfs for the function.
>
>There are two more users I know of but am not familiar enough to fix up
>myself. I hope people that are more familiar can help me here.
>
>- ftrace seems to be using override_function_with_return from
>  #define ftrace_override_function_with_return but I found no place
>  where the latter is used. I assume it might be hidden behind more
>  macro magic? But the point is if ftrace can be instructed to act like
>  an error injection, it would also have to use some form of metadata
>  (from patch 2 presumably?) to get to the static key and control it.
>
>  If ftrace can only observe the function being called, maybe it
>  wouldn't be wrong to just observe nothing if the static key isn't
>  enabled because nobody is doing the fault injection?
>
>- bpftrace, as can be seen from the example in commit 4f6923fbb352
>  description. I suppose bpf is already aware what functions the
>  currently loaded bpf programs hook into, so that it could look up the
>  static key and control it. Maybe using again the metadata from patch 2,
>  or extending its own, as I've noticed there's e.g. BTF_ID(func,
>  should_failslab)
>
>Now I realize maybe handling this at the k(ret)probe level would be
>sufficient for all cases except the legacy fault injection from Patch 1?
>Also wanted to note that by AFAIU by using the static_key_slow_dec/inc
>API (as done in patches 1/2) should allow all mechanisms to coexist
>naturally without fighting each other on the static key state, and also
>handle the reference count for e.g. active probes or bpf programs if
>there's no similar internal mechanism.
>
>Patches 3 and 4 implement the static keys for the two mm fault injection
>sites in slab and page allocators. For a quick demonstration I've run a
>VM and the simple test from [1] that stresses the slab allocator and got

I took a look into [1] and I see some data like "1.43% plus the overhead in
its caller", but not clearly find which test cases are.

Sorry for my unfamiliarity, would you mind giving more words on the cases?

>this time before the series:
>
>real    0m8.349s
>user    0m0.694s
>sys     0m7.648s
>
>with perf showing
>
>   0.61%  nonexistent  [kernel.kallsyms]  [k] should_failslab.constprop.0
>   0.00%  nonexistent  [kernel.kallsyms]  [k] should_fail_alloc_page                                                                                                                                                                                        ▒
>
>And after the series
>
>real    0m7.924s
>user    0m0.727s
>sys     0m7.191s
>

Maybe add the percentage here would be more helpful.

>and the functions gone from perf report.
>
>There might be other such fault injection callsites in hotpaths of other
>subsystems but I didn't search for them at this point.
>
>[1] https://lore.kernel.org/all/6d5bb852-8703-4abf-a52b-90816bccbd7f@suse.cz/
>[2] https://lore.kernel.org/all/3j5d3p22ssv7xoaghzraa7crcfih3h2qqjlhmjppbp6f42pg2t@kg7qoicog5ye/
>
>Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>---
>Vlastimil Babka (4):
>      fault-inject: add support for static keys around fault injection sites
>      error-injection: support static keys around injectable functions
>      mm, slab: add static key for should_failslab()
>      mm, page_alloc: add static key for should_fail_alloc_page()
>
> include/asm-generic/error-injection.h | 13 ++++++++++-
> include/asm-generic/vmlinux.lds.h     |  2 +-
> include/linux/error-injection.h       |  9 +++++---
> include/linux/fault-inject.h          |  7 +++++-
> kernel/fail_function.c                | 22 +++++++++++++++---
> lib/error-inject.c                    |  6 ++++-
> lib/fault-inject.c                    | 43 ++++++++++++++++++++++++++++++++++-
> mm/fail_page_alloc.c                  |  3 ++-
> mm/failslab.c                         |  2 +-
> mm/internal.h                         |  2 ++
> mm/page_alloc.c                       | 11 ++++++---
> mm/slab.h                             |  3 +++
> mm/slub.c                             | 10 +++++---
> 13 files changed, 114 insertions(+), 19 deletions(-)
>---
>base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
>change-id: 20240530-fault-injection-statickeys-66b7222e91b7
>
>Best regards,
>-- 
>Vlastimil Babka <vbabka@suse.cz>
>

-- 
Wei Yang
Help you, Help me

