Return-Path: <bpf+bounces-31161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8BC8D782C
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 22:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB21B1F21027
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34F177F11;
	Sun,  2 Jun 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWjQ9pVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5529AB
	for <bpf@vger.kernel.org>; Sun,  2 Jun 2024 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717361258; cv=none; b=JKUg+3gQm0uvh0BpWXzk6Kp4LxxMIPq7l4g0uSrfaBJwkoxcScfT/PJIri5cEH0g02nuhbMpJyUItYgtkBMB/QXwXPzVlCpobYrxpNYcSj1mY0Bea5I0O5dSmosXl18as507sEMXnAoa8u/wTjWCew5VLFSsZzftN3b4LLakKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717361258; c=relaxed/simple;
	bh=zGxnj9cPkR7CN59vRwgIWsvFPmeqrcWRYugiGmLy2Fw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X6+h5utgP3s+SVE3ivRDaJwknknu65DsrqBCu+lk+ovOOqMhe8PwZ+DVPhAOzxog8qFhpEkQW3y4zFSmU/SlDQBmNNyIg6+NXT1OqYKle4QfJtwTuWLApnkpYbR86e6nRqQN5V8YVZ6+02uKB8/l2JIwY9wjy6HDabm7xRBiFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWjQ9pVN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee5f3123d8so167715ad.1
        for <bpf@vger.kernel.org>; Sun, 02 Jun 2024 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717361256; x=1717966056; darn=vger.kernel.org;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faX60ecICkYxHjtv7PonXRM66RWfo/WBRMB+odShUo8=;
        b=YWjQ9pVN02mN/Zp9lXwTs9wKyQ+MRUlBdtUe/T4NBsyCW2MIt2YC806/nsL0uqzMER
         34S9/F2pO3PHw5ptJ6+ghRdy9wJ1mmUCGI9RLkzoBj2f9vZ9TOLoaY86aVEIwQP/fKK2
         cxt0L9GLWOov8zjyb1ZXY9ZEOkuhoHrggUasv+zcUjotPOzkqHumN1eu5k+6hkVsJaZ1
         P5xrKi48SG53xSafoA+V60P9BIOd1WWBwF1WgwD4YuFCsccXPEu+GWEmftCDKkDxJLv5
         8mcWIXXTfZuL+J/VwQhWbxe+7fdXcBG1qq9r3ieJJs7Bl+WhHcocE9IZ24goqCzoq6Dt
         iOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717361256; x=1717966056;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faX60ecICkYxHjtv7PonXRM66RWfo/WBRMB+odShUo8=;
        b=b4RsQWnj62eHJ86Xip5dAhmtesodj7JV9ejV+AaxUwNh5ycv0B1zAEHtswiErbzl7Z
         kbtO7Eb6laC9NCHmEwWzzngpXx1Yt8f+KMb/4CGORdEC4N5DnnSqNhPv8JT6I1JAjHBH
         1ifBYkWKoUo83+1MwiaafdJUs7UgyAPl/1hierVg8PMuW/j7lL6vV0PsObdOKkB9A5xl
         RMT1VcDQKDmswRS6Izrm0PeMRZkfc1YW/sLSIJtDdynGh6ZgqJQc61MhakPkCHoQU6BD
         by3VhPONZknjZs7q6wQUGXsjY9N3B6PzJ05Oyo/11ik+fGdZh/2hAaID9JbR4i32t/PH
         fevA==
X-Forwarded-Encrypted: i=1; AJvYcCWHjlILOCeMMMBM07c7i0Q9PG4/DCfTuzHtHQhB5WHWnFmEAiaHlTWX+TNFxYJ60EchwSH3e67qApagAZJ9cQWe+41y
X-Gm-Message-State: AOJu0YwTEAea9gq6VY//XezRgKRQ000hqL5AwpdyF1vDO26l2W+Ptc8D
	uciw5Z/I7cANJgct5uGKl2uDJk+zZtvhXH9BUEggS5sYIg1LLiPD399y3yAxVQ==
X-Google-Smtp-Source: AGHT+IHAcKXBQFsPDQM4NMHbQr6pqvh0k2z/Yyd2cS2NVZFKE2pPvtyCt3fAEKic6duvJwDcVFm13g==
X-Received: by 2002:a17:902:d2ca:b0:1f6:7fce:5684 with SMTP id d9443c01a7336-1f67fce5889mr178905ad.3.1717361255487;
        Sun, 02 Jun 2024 13:47:35 -0700 (PDT)
Received: from [2620:0:1008:15:abfd:526b:c7dd:75a1] ([2620:0:1008:15:abfd:526b:c7dd:75a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6324032f9sm51317705ad.242.2024.06.02.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:47:34 -0700 (PDT)
Date: Sun, 2 Jun 2024 13:47:34 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>, 
    Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Andrii Nakryiko <andrii@kernel.org>, 
    "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
    Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, 
    Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, bpf@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] static key support for error injection
 functions
In-Reply-To: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
Message-ID: <71ebaa45-dbd0-b39d-4b33-88da3f497297@google.com>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="2003064516-301007669-1717361061=:1421375"
Content-ID: <32fac6fa-e3d4-f025-6ec2-7b80eb8e0bc1@google.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003064516-301007669-1717361061=:1421375
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <985832d3-71c9-2701-ec5d-29c3bfccabf1@google.com>

On Fri, 31 May 2024, Vlastimil Babka wrote:

> Patches 3 and 4 implement the static keys for the two mm fault injection
> sites in slab and page allocators. For a quick demonstration I've run a
> VM and the simple test from [1] that stresses the slab allocator and got
> this time before the series:
> 
> real    0m8.349s
> user    0m0.694s
> sys     0m7.648s
> 
> with perf showing
> 
>    0.61%  nonexistent  [kernel.kallsyms]  [k] should_failslab.constprop.0
>    0.00%  nonexistent  [kernel.kallsyms]  [k] should_fail_alloc_page                                                                                                                                                                                        ▒
> 
> And after the series
> 
> real    0m7.924s
> user    0m0.727s
> sys     0m7.191s
> 
> and the functions gone from perf report.
> 

Impressive results that will no doubt be a win for kernels that enable 
these options.

Both CONFIG_FAILSLAB and CONFIG_FAIL_PAGE_ALLOC go out of their way to 
have no overhead, both in performance and kernel text overhead, when the 
.config options are disabled.

Do we have any insight into the distros or users that enable either of 
these options and are expecting optimal performance?  I would have assumed 
that while CONFIG_FAULT_INJECTION may be enabled that any users who would 
care deeply about this would have disabled both of these debug options.

> There might be other such fault injection callsites in hotpaths of other
> subsystems but I didn't search for them at this point.
> 
> [1] https://lore.kernel.org/all/6d5bb852-8703-4abf-a52b-90816bccbd7f@suse.cz/
> [2] https://lore.kernel.org/all/3j5d3p22ssv7xoaghzraa7crcfih3h2qqjlhmjppbp6f42pg2t@kg7qoicog5ye/
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Vlastimil Babka (4):
>       fault-inject: add support for static keys around fault injection sites
>       error-injection: support static keys around injectable functions
>       mm, slab: add static key for should_failslab()
>       mm, page_alloc: add static key for should_fail_alloc_page()
> 
>  include/asm-generic/error-injection.h | 13 ++++++++++-
>  include/asm-generic/vmlinux.lds.h     |  2 +-
>  include/linux/error-injection.h       |  9 +++++---
>  include/linux/fault-inject.h          |  7 +++++-
>  kernel/fail_function.c                | 22 +++++++++++++++---
>  lib/error-inject.c                    |  6 ++++-
>  lib/fault-inject.c                    | 43 ++++++++++++++++++++++++++++++++++-
>  mm/fail_page_alloc.c                  |  3 ++-
>  mm/failslab.c                         |  2 +-
>  mm/internal.h                         |  2 ++
>  mm/page_alloc.c                       | 11 ++++++---
>  mm/slab.h                             |  3 +++
>  mm/slub.c                             | 10 +++++---
>  13 files changed, 114 insertions(+), 19 deletions(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240530-fault-injection-statickeys-66b7222e91b7
> 
> Best regards,
> -- 
> Vlastimil Babka <vbabka@suse.cz>
> 
> 
--2003064516-301007669-1717361061=:1421375--

