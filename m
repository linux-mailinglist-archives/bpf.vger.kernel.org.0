Return-Path: <bpf+bounces-66138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99572B2E97E
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 02:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BBA17E66B
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94331D516C;
	Thu, 21 Aug 2025 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpHUmphi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412746447;
	Thu, 21 Aug 2025 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736649; cv=none; b=NzPIhWfkS3TgpPDaE3pnsYp+Mjc+r0PURic7cCF8QAoDJfzU3OrqfvsGP9kS5dGMZ6+uJcNgzAuzbOOWuusakBGF9CVRmsu/uuZP3GzngXR0w7cFCi7XxslYPiqhWEr2bv3ypcPCNHsgfZahVEn1rMhANraQq5v/NyLBAdBh/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736649; c=relaxed/simple;
	bh=Cnz4VM6Ya5LPIOF946Rw+gR/NWbc/uyyYgCnKofBZ0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AasNxZRgUxIZDZqU6nChhyEufUTo4RvfpLHVQ3TPuUeitYE6ntZ5Rgw40SZcZJShY7qLzG0DvVrf3ztYQUB03VNxQ2vdPolFsU1nHosAkyH9zbijLl2yOEsHOe82txkAinEm/HF/AvWrzRgEyXZPOIR1IdB8GjvqF7pgkKiAz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpHUmphi; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-afcb6856dfbso87338066b.1;
        Wed, 20 Aug 2025 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755736646; x=1756341446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AaWiycjbp+an5S1lmP1IBUI4ltkMoLxdO+qHmbgyWx4=;
        b=mpHUmphiQCvmj07WxcoQJIjJEDX34ttv4NlqYGYOuz5hpLRq8scpfIKpUjSjpJ5a+X
         aQb9cBsR0zXLBGTtITS0c5nZzLNfsjq/ZJKpzz3VsQREwY4BrpbUoNQ4tjTIw7+8z0Md
         gzOmsq9+XKi8mdsoWUIfV/Ca1zP+NFEhlxm+IDHv7rFrR+jrs0qDeiDePGAc/19A3EUL
         sHCzgz1S3OuwdfwGYd3VMFB7ZTW5lSFBNXqWfKmLlpjhoLLchkJNT2DBXPbD6eY5yK7X
         CaMNCcUOGFpb5jD/94rIkIfKtGQ39d0TVGoa+sCUbDC2rLKf7ggArUQ0RNforpHY1G/d
         UxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755736646; x=1756341446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaWiycjbp+an5S1lmP1IBUI4ltkMoLxdO+qHmbgyWx4=;
        b=FX3ZtwexMXaN23zLQbCVyeqp5okluWSYdQ9nih3BJClyN3x6sLn7C79AWanVOhplW2
         gqLzFjtFVJA2TOQQiVzxux2DAy1AqqGjuYnooxRAIVA50uZ4xeFzkQi0bbuTOxpOoB10
         r3UDEg0pckqkL9oGL/DYJ9ugka7hLWBphPKELxRpTJPlsv/57GJSwCOHv3hA7tTXKC6B
         OSfb4x6ztaB2FEKIPFvRXumhvbu8Bby0USs7arT9RmwXwm3Zz2Vbj/YTd9pLg1OaQKGO
         H9CWnNx+//nfJmq6jqf9AkQfnYE/6x27ilYEWdzp/FxoojwehHWcCLgMItmoXyDAGA7T
         ZdUw==
X-Forwarded-Encrypted: i=1; AJvYcCVfkrVtKH4DxB+kzMZvHzj8HOVUdrI176pWQyn2/BSaJ3iGZaK5fZs+IDbk6O7SiaDUY+olKBE2c7NhdKPb@vger.kernel.org, AJvYcCXYyIXylCllz2L1a1M2GsNOUEkzuD5j+nMeMIghlfD5YgP4JXSNpX4XQXfwR3OJmFCBV5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RiOpeLdaYkfEAYwmTnmX6GA2INrkVKGZ4tkVaropxVC0X2U3
	5zZuqn6jmP+nfZCJQtqtgioldPug1NO8+LRms8mnUN7uY6vgbj6fUTwW1rzEcg3P/85NDMDAv9o
	ma67g7PNDMdgGKB8JxY5pdAM+hYw51RU=
X-Gm-Gg: ASbGncvwb6iW1oFLdev2jMlJgYcqxU3Llm8dYxxAr55mQOQWBJDI4FzCce5pBdotRFG
	4f+K7kJ8rp97yNBF7lb+da0L1xV0a7pqsyL4vumnVmGbeIiFrK1YlTRNiszwvGCEosu5YWVTtfN
	ke/kZGXj6moB+87R7yxObfVIRglo+0cCA9AxCd1L0gPXIG+s1duhW6JfANhf3eg81p+bvkY+VNA
	87oWcxr
X-Google-Smtp-Source: AGHT+IGFlizhcX6BWM8Ymib52+AagzmPrdgnHqTZI6F1VDgVgHX1/2aLpO6P4WQH2SSBMG0HMdptOuNIG/DHifm5BLc=
X-Received: by 2002:a17:907:2d22:b0:af9:3f99:1422 with SMTP id
 a640c23a62f3a-afe0b00fef7mr38375966b.5.1755736645809; Wed, 20 Aug 2025
 17:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev>
In-Reply-To: <87ms7tldwo.fsf@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Aug 2025 02:36:49 +0200
X-Gm-Features: Ac12FXzsMSgLK-MYBBqTfMM353IQRheSoWImI4AVOKJlla4jC56TBdVvPSNUhKo
Message-ID: <CAP01T76xFkhsQKCtCynnHR4t6KyciQ4=VW2jhF8mcZEVBjsF1w@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 02:25, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Mon, 18 Aug 2025 at 19:01, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >>
> >> Introduce a bpf struct ops for implementing custom OOM handling policies.
> >>
> >> The struct ops provides the bpf_handle_out_of_memory() callback,
> >> which expected to return 1 if it was able to free some memory and 0
> >> otherwise.
> >>
> >> In the latter case it's guaranteed that the in-kernel OOM killer will
> >> be invoked. Otherwise the kernel also checks the bpf_memory_freed
> >> field of the oom_control structure, which is expected to be set by
> >> kfuncs suitable for releasing memory. It's a safety mechanism which
> >> prevents a bpf program to claim forward progress without actually
> >> releasing memory. The callback program is sleepable to enable using
> >> iterators, e.g. cgroup iterators.
> >>
> >> The callback receives struct oom_control as an argument, so it can
> >> easily filter out OOM's it doesn't want to handle, e.g. global vs
> >> memcg OOM's.
> >>
> >> The callback is executed just before the kernel victim task selection
> >> algorithm, so all heuristics and sysctls like panic on oom,
> >> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> >> are respected.
> >>
> >> The struct ops also has the name field, which allows to define a
> >> custom name for the implemented policy. It's printed in the OOM report
> >> in the oom_policy=<policy> format. "default" is printed if bpf is not
> >> used or policy name is not specified.
> >>
> >> [  112.696676] test_progs invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
> >>                oom_policy=bpf_test_policy
> >> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
> >> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> >> [  112.698167] Call Trace:
> >> [  112.698177]  <TASK>
> >> [  112.698182]  dump_stack_lvl+0x4d/0x70
> >> [  112.698192]  dump_header+0x59/0x1c6
> >> [  112.698199]  oom_kill_process.cold+0x8/0xef
> >> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
> >> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x313
> >> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
> >> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
> >> [  112.698250]  out_of_memory+0xab/0x5c0
> >> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
> >> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
> >> [  112.698288]  charge_memcg+0x2f/0xc0
> >> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
> >> [  112.698299]  do_anonymous_page+0x40f/0xa50
> >> [  112.698311]  __handle_mm_fault+0xbba/0x1140
> >> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  112.698335]  handle_mm_fault+0xe6/0x370
> >> [  112.698343]  do_user_addr_fault+0x211/0x6a0
> >> [  112.698354]  exc_page_fault+0x75/0x1d0
> >> [  112.698363]  asm_exc_page_fault+0x26/0x30
> >> [  112.698366] RIP: 0033:0x7fa97236db00
> >>
> >> It's possible to load multiple bpf struct programs. In the case of
> >> oom, they will be executed one by one in the same order they been
> >> loaded until one of them returns 1 and bpf_memory_freed is set to 1
> >> - an indication that the memory was freed. This allows to have
> >> multiple bpf programs to focus on different types of OOM's - e.g.
> >> one program can only handle memcg OOM's in one memory cgroup.
> >> But the filtering is done in bpf - so it's fully flexible.
> >
> > I think a natural question here is ordering. Is this ability to have
> > multiple OOM programs critical right now?
>
> Good question. Initially I had only supported a single bpf policy.
> But then I realized that likely people would want to have different
> policies handling different parts of the cgroup tree.
> E.g. a global policy and several policies handling OOMs only
> in some memory cgroups.
> So having just a single policy is likely a no go.

If the ordering is more to facilitate scoping, would it then be better
to support attaching the policy to specific memcg/cgroup?
There is then one global policy if need be (by attaching to root), but
descendants can have their own which takes precedence, if it doesn't
act, we walk up the hierarchy and find the next handler in the parent
cgroup etc. all the way to the root until one of them returns 1.

>
> [...]

