Return-Path: <bpf+bounces-54520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB24A6B35C
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 04:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8667217CFCC
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 03:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A521A7264;
	Fri, 21 Mar 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI1I70bs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4DC33F6
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527960; cv=none; b=O12YcqGahjLt+KUyYVKPUM5cNhccLClb7fLeQn9dlL9VB1K2tS8Y/dNJk8qRy9DWtEifSXEdaZ+0ZFjoxI6aXII7a7S9cMbRykagRla4aHt8nng6bLqVsX+0K3RUgt/y875036ch4r8BjSpbaZRoJFr1xWgsujqlkR2NHvrTtl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527960; c=relaxed/simple;
	bh=B+E5PJv1gRiFphDbPZ9EpVmBw++AGhX7qtuaOitpRtg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U6sIkZA5WyrxArwoAFsDt66N+AgnYp8pSzGAh2tRq4ECbv6zpyWjtZ9IjCvWD9dED6Wz8pCDMIMNsM6qhLWlV4p7snKxCnCdFy0RufhnsrXZ+XRMsZwYWpFvy0qtb1iq/iwf8r5TrzisOlge7+IvFxoZ2puY40xKLrbvRENbZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI1I70bs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so13674655e9.3
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742527955; x=1743132755; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g9oozaQPCiW7aHMMJLEoWbHIJA+eqbljpGWao3hp29Y=;
        b=nI1I70bsSjmaeAGqzfA72MpUUWKVv8PkHW/6IVZjY9WgDS7BivViIC5dSOGdEntQ02
         Jbl1C6yrpWOu9w3uuR2qpc2mbxwOJGL0OFjuAFjR6OoBam67Fi/h0pT8X013OdSh/I1K
         +xLWzp6v2OoCDhKSyJ4z586f2XWZ8CedG6LSX4qJyTIX0Gl8p6B3soQJ2AOBqF5i4a+J
         6qMPi2XxAlVJeeOG4O0maYmqfH8eJCvcs3yedHeTIi2l6gNnwkAnDsW1jf3+Sfx0Oujm
         +7VStjZ3w8ZLi3udg1Aqn7vspmOnfkKNXfdgSmOpC/j1GEx0Ws2ziJ3m3UUSQ8GnDf14
         f3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742527955; x=1743132755;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9oozaQPCiW7aHMMJLEoWbHIJA+eqbljpGWao3hp29Y=;
        b=Yy4B23XUXSrOXJW66kPGB5W3JOKNoFEiL7TDVIWHuXC8wHmzzrJ2xhwoNnVw1JMxoI
         mmyniubixeqIvAuPTBy8kHEppTzw8pq+XRQ+EW2RgO/e3c38l0cED7ymRBeuQiJgCmQ6
         0qK8vnar0V+Au6RgtQRn6WklSN9bA22H0mtL/wXs167CG9ObPprOEG5csBwzqseNk8rM
         ZJzc6ZAT2+0oorN2+QjiddBut6LyzhFdcHQcI5TEf8N5y391tRQ5CWZDrMpJ72ORehyW
         7wxFyMPPXFUzArR07va6K0OEv5J9aa6IkjR4x4Gy9/PoT877hMSsLX1avZ8vVL02YU9Y
         mQyg==
X-Forwarded-Encrypted: i=1; AJvYcCU0xGgwcbgXQCAp59bu2NfDUxKIOKsykElCmlGNfr45v6nUDrPxD+q4RllDOjTBoMc38As=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHR+Dksec/Uw0PbQjKlEFP1eC3adLxAufdmac97T4FIXCdmMq
	AeuWVrywbwHyvWfeDdrw6G+DkzfUE2mf/6e75DZYuP7SUCsCuNfQuIlflHFm9Pox5OlDoFlHCv/
	h60O/yOrRlpj1ovjnXjVY5RYMzOg=
X-Gm-Gg: ASbGnctGYonFeMsVvGkZybxXaaB7SwzsyICFtmshx3laUfRTzS/fZ5FhTSkqMei9bu5
	SD8zlNzsJCvP8qUVxXcnPxc1XhAlUbVi8xooOi/35SdLHY8YI2mP37QjE6mM31/SsavoRfasm+p
	V+dZTri0WvqZYMecK4wCKbiV7T3PTNByCDNXd9nKxh1w==
X-Google-Smtp-Source: AGHT+IGIKbPhkp/L3eskCCw8rn0DFYqCAzJh424BZ/d9vhS5L2/3pLgKQiiukxPyovMMfppzBlEF2bzphuyaw80maog=
X-Received: by 2002:a05:600c:4f85:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-43d50a13947mr11235585e9.17.1742527955115; Thu, 20 Mar 2025
 20:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 20 Mar 2025 20:32:24 -0700
X-Gm-Features: AQ5f1JrYzK936gHVp14lqoGkzrbLD1DOiw4Ntzzohvehiz5wXVkOTU6kc56U5Tg
Message-ID: <CAADnVQ+=x31Rcjh6-qX1C+d2q0LBRCH=1gPqfKOaMXYx_fkQjw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Reentrant kmalloc usable from any context
To: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Hou Tao <houtao1@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

A year ago Vlastimil kicked off a discussion:
"What's next for the SLUB allocator"
https://lwn.net/Articles/974138/

One of the proposed goals was to adopt slub allocator to use cases
where bespoke allocators are currently used either due to
performance requirements or context restrictions.
bpf_mem_alloc, kretprobe's objpool, mempool were mentioned
as initial targets. netpoll should probably be on that list too.

Performance might be addressed by sheaves
while context restrictions are more difficult to solve.
bpf, kretprobe, netpool don't know the context where they
might be called. Currently bpf, kretprobe handler preallocate.
Preallocated pools pin memory to one subsystem make it
unavailable to the rest of the kernel.
This has to be fixed. mm subsystem needs to own, share,
distribute the memory.

Agenda for the discussion:
- discuss and agree on problem statement
  what is being solved, why, requirements of the solution
- discuss pros and cons of the existing design that we
  made a bunch of progress on
- brainstorm next steps

