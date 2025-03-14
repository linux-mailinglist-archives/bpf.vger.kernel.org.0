Return-Path: <bpf+bounces-54045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C60A60E89
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 11:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E040169A9E
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7D21F30C3;
	Fri, 14 Mar 2025 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PdQ4E71h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9392AEE9
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947387; cv=none; b=MFE8bXtjSS7bXYNWEZfNws2fiAMihSlgj8vS1Cksp6ggdS1LMqMMq+T2GxyaoNwUt7e4knr4OtJjTcfp7pmUfgO4RByQSnEti1gTLv22oNdjH5IL/4NGUpQ2GncThOdAfXaUq50Gk6Eg9NR4YJl+I1gCNNNX5HA4GER9xI4pFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947387; c=relaxed/simple;
	bh=asfU0pF76zrC74MvsYmZmJMVgv8X7tsgWSuNyy/0GU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBOGDcK3gUOx6UdblfNw3Q+8WCSlTJXZGgzAtFrcI3LPdG4InoAuo7Zn+04ROsHD2nGw/Bt9ygmcG3rMdAsxvyjW7LF3pArlZSOCpjGsm9G4kFbvV6LnGyLcpKcCz+Ahf8FyJ8na5oi08W6ljb3cTWcf0VVQROYHpzsTimkuY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PdQ4E71h; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac339f53df9so41250366b.1
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741947383; x=1742552183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlooZCqpuuYmk/BU1NwLBULyb/9UA2hcKvt6wavKqTk=;
        b=PdQ4E71hVv+rtS0mt1N2BlA4T/pdt2zADEq84t73m1GCCnzgU4J1LG6dMoY+Bl5ngv
         cguCY9yMtInHRFZVoTSHDqfmYiWQLh1mbEfXiVergpIUzIkmSG2PxuFmnJfne9S8UwcL
         1lG+KFlpNahqOgM8jcxoQ05eE8fSe17OmiNgi8hwU+k6BaYhMOHWUP7fFl5ij82/5wuC
         B4vhCJgbxMkqpl8RPt+T+zHqpSNdbRnUr5wBCbQTTSmG5yBs+6bIZRw+5nX1lw8tAKZP
         FQ863uP9trO5vnz/RmqnLvikq+eBhZThwYvdYNg7XaVcpFYhRK6OT+HQMMweYcelS7D/
         gT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947383; x=1742552183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlooZCqpuuYmk/BU1NwLBULyb/9UA2hcKvt6wavKqTk=;
        b=hiAhU1RmUBOSGcHvP5M+Ha7djAEjZyp1P/jpFIQAfIFq0Q2rTJjpzomx0b/zlkzIcB
         Cj7kcDocqejOHXgs7ErC5NCjr67KjOKCFeUm9d8FHaIllRyq/1oXK7qHgHJL9xESpE7d
         XkV0WhELAv3pFtOsWHzQCDFmn8mEZ10eOkQYF1nQuFgTBVqdoPtWZT297aBKpxvwHF3S
         /YwHL0L1cGoj5/rX6ttp4oh9ghMXx023DK0LeGZ5YL4GNyyxGdy5W2XSOJ49EFqsWksj
         lPNUNDq92E8rzy0hieyERnYV8OR6pHyuv8TGnNloxMc3W3010dRfy7vDs0v9tCd/tYlC
         aH2A==
X-Forwarded-Encrypted: i=1; AJvYcCXYRNI70DvBMyrC4wadBNlhu1e2muA90alv/M6UfOnCM4SZPvqBO9E2aQlTaGvRp0VC3uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KlsSwS7A19Za3d/obFN7WwS5HjsLeUj7ae7+clMCqAFGXchB
	qKuosrzHkYa7qSx8XBRmqLqgTJxx/8llECx6qOpV4/K8y8mkQ8Qz45Uf46zaD/E=
X-Gm-Gg: ASbGnctCNnRmStMzBzeFMssF94fijFJa/cY52j/XXGS56HyWz3YfzCgRbWmF0zB/xIT
	AGFy7MHNdSgxdr3UaQXEU/0Rqa0OXSbk+MvS53Py832iJU/TFofX/ntEVyBleLOXhyjWbJNJrR7
	SD6EVvAxd01nzYsCOqov7ZXd5/aUGc+uSCWXyEwp8Q4nr8sWd3nIi6D8JbTgPbnv8LkSQ40kCt/
	AqVJqYM/D0CiOA9laL3rAKHYCgyaPzBDHMKTpG6Rxe9DfCKk3nB3N81ZqwF9JzSKgjQhz6UCkuz
	MOnz6cHcxgQVei3ysN5xQVyw2jhe4GILtsPWY0bP+mhG7gvF12+Z3G0cmA==
X-Google-Smtp-Source: AGHT+IFIRZIpZU1ud7THKhfimdrL/Ki5fS5WMHUSVLs0E4NFQaMnaEfc5B/VLMfbRmQ0qXg0VbNxXA==
X-Received: by 2002:a17:907:2d0f:b0:ac1:de84:deba with SMTP id a640c23a62f3a-ac33017bbc4mr211515266b.19.1741947383260;
        Fri, 14 Mar 2025 03:16:23 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac314aa5166sm207946466b.176.2025.03.14.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:16:23 -0700 (PDT)
Date: Fri, 14 Mar 2025 11:16:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <Z9QB9sH5R8F-xuYA@tiehlicka>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com>
 <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
 <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
 <4d75c5a8-a538-4d7d-aaf4-8ecf1d1be6b9@suse.cz>
 <igjisv7v3o2efey3qkhcrqjchlqvjn54c4dneo2atmown6pweq@jwohzvtldfzf>
 <Z9KbAZJh5uENfQtn@tiehlicka>
 <4a52db5b-f5fe-4a60-ba17-a634a2d0b7af@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a52db5b-f5fe-4a60-ba17-a634a2d0b7af@suse.cz>

On Thu 13-03-25 15:21:48, Vlastimil Babka wrote:
> On 3/13/25 09:44, Michal Hocko wrote:
> > On Wed 12-03-25 12:06:10, Shakeel Butt wrote:
> >> On Wed, Mar 12, 2025 at 11:00:20AM +0100, Vlastimil Babka wrote:
> >> [...]
> >> > 
> >> > But if we can achieve the same without such reserved objects, I think it's
> >> > even better. Performance and maintainability doesn't need to necessarily
> >> > suffer. Maybe it can even improve in the process. E.g. if we build upon
> >> > patches 1+4 and swith memcg stock locking to the non-irqsave variant, we
> >> > should avoid some overhead there (something similar was tried there in the
> >> > past but reverted when making it RT compatible).
> >> 
> >> In hindsight that revert was the bad decision. We accepted so much
> >> complexity in memcg code for RT without questioning about a real world
> >> use-case. Are there really RT users who want memcg or are using memcg? I
> >> can not think of some RT user fine with memcg limits enforcement
> >> (reclaim and throttling).
> > 
> > I do not think that there is any reasonable RT workload that would use
> > memcg limits or other memcg features. On the other hand it is not
> > unusual to have RT and non-RT workloads mixed on the same machine. They
> > usually use some sort of CPU isolation to prevent from CPU contention
> > but that doesn't help much if there are other resources they need to
> > contend for (like shared locks). 
> > 
> >> I am on the path to bypass per-cpu memcg stocks for RT kernels.
> > 
> > That would cause regressions for non-RT tasks running on PREEMPT_RT
> > kernels, right?
> 
> For the context, this is about commit 559271146efc ("mm/memcg: optimize user
> context object stock access")
> 
> reverted in fead2b869764 ("mm/memcg: revert ("mm/memcg: optimize user
> context object stock access")")
> 
> I think at this point we don't have to recreate the full approach of the
> first commit and introduce separate in_task() and in-interrupt stocks again.
> 
> The localtry_lock itself should make it possible to avoid the
> irqsave/restore overhead (which was the main performance benefit of
> 559271146efc [1]) and only end up bypassing the stock when an allocation
> from irq context actually interrupts an allocation from task context - which
> would be very rare. And it should be already RT compatible. Let me see how
> hard it would be on top of patch 4/6 "memcg: Use trylock to access memcg
> stock_lock" to switch to the variant without _irqsave...

makes sense.

> [1] the revert cites benchmarks that irqsave/restore can be actually cheaper
> than preempt disable/enable, but I believe those were flawed

-- 
Michal Hocko
SUSE Labs

