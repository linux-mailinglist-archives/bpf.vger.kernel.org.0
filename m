Return-Path: <bpf+bounces-66077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9AB2DAEF
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F0E7BB179
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128072E3B0D;
	Wed, 20 Aug 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt25tUS0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00102BEC22;
	Wed, 20 Aug 2025 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689366; cv=none; b=PAs1fhmFGFuJGMeQYQGz2ONYUnKvJ/ygcGa3IENPnzq91G+eqqCGuDz5K3eS5tsZVaa0fKQ5oHfmBoTBQcFrG8k4zTdN7n3U5ACTdjFxTy1mq36sMLyoNAEARIYmQIEfxp5OTitijK5ZzSXIHVBvbvcCHOsO4URzqFFdGHcQM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689366; c=relaxed/simple;
	bh=Jsb4n0u5pdla5ypr6UnYHFRMfmkZIPMBUQ2dB9p1JlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDKIH3kLDRZZz12uw/sqgtSC83e96Vwb6jxl2jWDjAvbASWb7aJFcTOZsw1DPil48sTs1YOKnz3+uHCQLJz+CX2IsKhzePFZgPa6tKyPCeOYowyPbISyZx7DWaaBK1JRw4wED0otnuU48nkxmhd/6FiIWmQmEZALo10JLZzF2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt25tUS0; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-afcb73621fcso759318866b.0;
        Wed, 20 Aug 2025 04:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689363; x=1756294163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=upjI12z9EKSOogPe3mu03H4QB6bxTGw3qKQDwah+3Jk=;
        b=dt25tUS00eHmbYL1fUR6nZZBVziKjRxQM89ppGNQV1uHFPZuyjAePiyFu81aSApsp4
         98hcTS7YZ7+JbGNhL6cm+vgBLQr3rjyBwMCot1EEKMCyDFGC7WUIL0INPAbYd3ig5mDg
         udaoDgljojpYpwRMOk/3K2UXjR39MJOHBEaOfOsrwaXju2bumBjDx/Vcn192a5KqhNG9
         coy+N9nT1OoUIY+qBUzrR9gtXO+bmvg2gBTwYY/Y3Itz/CW6iEhTVPWBESZiZXQ3PxRm
         gmZtG6O9gx6ipFGFh0BDBdEIKouM6143QE+Dj4nrodvudJ81MU2E5xF0hvhR80kuasYL
         Ew+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689363; x=1756294163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upjI12z9EKSOogPe3mu03H4QB6bxTGw3qKQDwah+3Jk=;
        b=kpWeReF5h8lJkud/L2E02mhdfx/l/SgDZt6nIKlEJWEgjEX4ML5J+wP6UlImBbb/A1
         U9dUAk+SU13lvvr0KykBwxzpCbvpmwBg9s2DFoY12f5SD3r7GFuxrd05RmtxLe5SwUuH
         kNLCyHqegw9TKv2GmieKPzGMiGzl9r11WU7PLXmc3evOEs17wvtwlNsULp2XpxWpkMCt
         IoWxX6G3aDRlNqcXH35sVM2DKjmlZpwGx0wVSkkgilTj39zn+YdTHsQzC4+BXsJTIPrn
         W0FU30S8/KIQKOU66On8L2MrggGhLEuXFq58UZ8L8k8ftwMJQRiNjCTmCNgSaM5WMJat
         zY6g==
X-Forwarded-Encrypted: i=1; AJvYcCW0crhNJ8eYyKcnpdFNsmGPNMoE6X6HV0my03rILT6Plm+LLPlHEH46PKi/ZhuSjt8jYcY=@vger.kernel.org, AJvYcCWux+voe7fALdvd76StqN79JiEK5znCcKan/ofzi0l+1WTpJpGGtyB0p4UGTz1J77IALT5FZG1AkbLTMIkh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DgJiMRooEelUCurT4ZA4PJC8iYklr/9YC5ExXO9WT0UdHAbd
	nz5O3KI2uu+VLTkTqTfWZjimF1SPPx88vJ5xJShQuiFw8RfcbB2uGpPQSSgKqYcvck96Nq5T1CV
	kJAx4QUFqXjdjt2XmRb2ytPwSsdODUkY=
X-Gm-Gg: ASbGncvwgbfwIBOAz0eSeSGv3hTyxu8Z71iG+1XxEYakR41oRjdgDKe/CeqfhUBnand
	BpfsgCna4GTijdaB2E57s7eZyWJXYRGoOwXOHsYmVqWTTjYr183swHKQvSuzc1I3fhlgOEyEfdq
	ZEBGhJN7/4zQDcdfDhBHG6Z2Jc+O1bWwNxau7IEWlSo8AT4TJ1RDibNJ4NWbsw5pOn8I89+L5br
	Cgy6NqGE8rXcis//kIJqaqRJMhh
X-Google-Smtp-Source: AGHT+IHKR4WT5Ll3zM9CQe9O0PlIb3Q7/p2qJgWorUSCzbLQuFfLo3z+C+RdY7BU9glE+sZqnURywScSjdBODs3VOHc=
X-Received: by 2002:a17:907:e913:b0:ae6:a8c1:c633 with SMTP id
 a640c23a62f3a-afdf026893bmr188656266b.34.1755689362625; Wed, 20 Aug 2025
 04:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-2-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-2-roman.gushchin@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 20 Aug 2025 13:28:46 +0200
X-Gm-Features: Ac12FXwIsXWjctJQDIgLXvBtGEjb-bEMufXtBQBLDBmPn-VgQIIHSI30bz2R0xw
Message-ID: <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 19:01, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Introduce a bpf struct ops for implementing custom OOM handling policies.
>
> The struct ops provides the bpf_handle_out_of_memory() callback,
> which expected to return 1 if it was able to free some memory and 0
> otherwise.
>
> In the latter case it's guaranteed that the in-kernel OOM killer will
> be invoked. Otherwise the kernel also checks the bpf_memory_freed
> field of the oom_control structure, which is expected to be set by
> kfuncs suitable for releasing memory. It's a safety mechanism which
> prevents a bpf program to claim forward progress without actually
> releasing memory. The callback program is sleepable to enable using
> iterators, e.g. cgroup iterators.
>
> The callback receives struct oom_control as an argument, so it can
> easily filter out OOM's it doesn't want to handle, e.g. global vs
> memcg OOM's.
>
> The callback is executed just before the kernel victim task selection
> algorithm, so all heuristics and sysctls like panic on oom,
> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> are respected.
>
> The struct ops also has the name field, which allows to define a
> custom name for the implemented policy. It's printed in the OOM report
> in the oom_policy=<policy> format. "default" is printed if bpf is not
> used or policy name is not specified.
>
> [  112.696676] test_progs invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
>                oom_policy=bpf_test_policy
> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> [  112.698167] Call Trace:
> [  112.698177]  <TASK>
> [  112.698182]  dump_stack_lvl+0x4d/0x70
> [  112.698192]  dump_header+0x59/0x1c6
> [  112.698199]  oom_kill_process.cold+0x8/0xef
> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x313
> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
> [  112.698250]  out_of_memory+0xab/0x5c0
> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
> [  112.698288]  charge_memcg+0x2f/0xc0
> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
> [  112.698299]  do_anonymous_page+0x40f/0xa50
> [  112.698311]  __handle_mm_fault+0xbba/0x1140
> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698335]  handle_mm_fault+0xe6/0x370
> [  112.698343]  do_user_addr_fault+0x211/0x6a0
> [  112.698354]  exc_page_fault+0x75/0x1d0
> [  112.698363]  asm_exc_page_fault+0x26/0x30
> [  112.698366] RIP: 0033:0x7fa97236db00
>
> It's possible to load multiple bpf struct programs. In the case of
> oom, they will be executed one by one in the same order they been
> loaded until one of them returns 1 and bpf_memory_freed is set to 1
> - an indication that the memory was freed. This allows to have
> multiple bpf programs to focus on different types of OOM's - e.g.
> one program can only handle memcg OOM's in one memory cgroup.
> But the filtering is done in bpf - so it's fully flexible.

I think a natural question here is ordering. Is this ability to have
multiple OOM programs critical right now?
How is it decided who gets to run before the other? Is it based on
order of attachment (which can be non-deterministic)?
There was a lot of discussion on something similar for tc progs, and
we went with specific flags that capture partial ordering constraints
(instead of priorities that may collide).
https://lore.kernel.org/all/20230719140858.13224-2-daniel@iogearbox.net
It would be nice if we can find a way of making this consistent.

Another option is to exclude the multiple attachment bit from the
initial version and do this as a follow up, since it probably requires
more discussion.

>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---

> [...]

