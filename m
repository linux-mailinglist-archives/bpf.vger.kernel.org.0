Return-Path: <bpf+bounces-69376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DDAB9573B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA972E46F4
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECCF32127A;
	Tue, 23 Sep 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT2+MJ23"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D428A3EF
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623947; cv=none; b=dF7m1qcurCg3d5XW7VbRMz0WcQ/rkQg+m/jMeJ4UV1LBWmSm4n7xAens9xEWmpuUE4k9MgPZftEH7+iVZxHamb1Wn0lhtwrDanv9u0tbWYX/PunvAPwzGItq+bnBN86G8JTlL6sFVPilAPPaB5ay1RDdfoYOqdhuSq3SnIkiZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623947; c=relaxed/simple;
	bh=9I+UfsvIx+bsD4niyYaXYH6gHpsHBUv5FFHGyAAC3ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GieqCn/fwc/Q74LVCfQZM9LjrD8/lkS9PaldoViyDbcS7ZOOqB02uWRMvDPCrtV3mX2LFLIP3x6KLCcOnbeH60us/AXz2BBDUEASqhKgRBS7sPwJJ2gmD9o06F2/YPGQKnsROoaKlIzbDHWNCMFpMqqOOWun6ime9OiylxCoTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT2+MJ23; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b2ef8e00becso226032166b.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758623943; x=1759228743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NnfkqnOJdsB0bfPkZ1igYkNhvejCpYg0U/vTuy5A1tc=;
        b=nT2+MJ239mkEhxzL9DGGySSasGJpZLCQSNir6/+yLIlKcd3SK0x2llDZG1nLO3ePfI
         82p6JldTotKKz7V95gBUDkfXHkWBI0fs3Cp5VHe5L444xVM6oOPEjv/Qflcc3+fg8G75
         02UJECVuxS2IaXqT9p6Xh02a8qZMvzy/KEMs/whgbcE+cp5RztYoKoIpoE9h0F/ohw3p
         bo+SnXDb4j2MA0X1dST3JUZtBsb1fKCL8Lw4BOq9RMroJgJ/LFdyN0hap8Jh48Z+kL6d
         1O85KQ7v+7bsbveMm/NZxc8R1In5jFcR1/3qPJt5Y5jvDqmWJBpGDNbwvivZ5shazTwe
         DaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623943; x=1759228743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnfkqnOJdsB0bfPkZ1igYkNhvejCpYg0U/vTuy5A1tc=;
        b=dWMSLBfhJB2I6zunAtXgtMxrllwFCUqnka8r1rBECah9SPKM3/9qvHwQqqYwVu9IZz
         Tk70HtktZGRURVUvEzEERPYTfS8CY33ZBIOwEkrzUcRn9ZVeFn9NJd0jIiQYcNFJi7Nm
         zK0HvAhfflH4v0oaOf6q27IvS2YUCAGaHeuACvtRcsgu9cylIeq7Jk7nUmk59Ecl21M1
         FzxLD0/fmj7SyO05ZYzZHBBqd9l4L5XtObqZoQdesKItODqJPqLBpQttMnHg1SWcIxoy
         eRBffOFQyKLqboJfWHPaA1meOVz0E+IhX96S7KuRPsc5h+Bd5m2AdxDBn779Rk3OzF7R
         CqYg==
X-Forwarded-Encrypted: i=1; AJvYcCWnzBMxUohFPR6KnBXbKjclGqOuIvcJReNTZsnbIDtgufnnmDKccZzCCfD5JXy/laPxwws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DYWsp92TjlEo+3e0G002B5M6hVHw1sX2otqNJ8Mn207Ty+XU
	C0V/4EYcG4z5OHucPVBMBglYmBw50198uKm5MjWXLumBWq/YwNclDI+0Nboh3jG6MFcvx/XjSJn
	8qa0dElCzIplTB/D5EOk12+9G650bf95246fcrkU=
X-Gm-Gg: ASbGncvKVUBFWABKM8RmK0o3Cx8pDJFUMDpyijBqjP7ipT73dvYpz+icSahr/9xoGIW
	cmigdLcIg28cxxIy8No7VwQ9038rKflChoRM+v5XSvlpIrZXR/vzhyUuTLMT/WpMCfgvqH8hFKt
	WYeb5hU3vt3l0DJXKL7xcVr7xmCUuJIbbl81Au4K4FJ0pmgPRY1fjv90yRD//mnvuMCOU0yMflw
	snfyey+LA==
X-Google-Smtp-Source: AGHT+IGe8BueWIvyXCDLHwL8VpMfxPGaA/c+GGWafGvE2t67inmTkzI9pV52mWfvHL17NVaKT6Khw4wvn8Yi5AG6Q3o=
X-Received: by 2002:a17:907:9484:b0:b2e:4ab2:485f with SMTP id
 a640c23a62f3a-b302c10a345mr210661066b.53.1758623943305; Tue, 23 Sep 2025
 03:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923091634.118240-1-arighi@nvidia.com>
In-Reply-To: <20250923091634.118240-1-arighi@nvidia.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Sep 2025 12:38:26 +0200
X-Gm-Features: AS18NWBYse4BMQwVtmlQ_EXCFADp-5s0Or4bp9_W7wncLZyqeCwKDe4OHa96rDU
Message-ID: <CAP01T75_tsZoGX0SghGtO5V6LJOkDEMDcocWHZwoOpXmS7cK9w@mail.gmail.com>
Subject: Re: [PATCH] sched_ext: Verify RCU protection in scx_bpf_cpu_curr()
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	sched-ext@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 11:16, Andrea Righi <arighi@nvidia.com> wrote:
>
> scx_bpf_cpu_curr() has been introduced to retrieve the current task of a
> given runqueue, allowing schedulers to interact with that task.
>
> The kfunc assumes that it is always called in an RCU context, but this
> is not always guaranteed and some BPF schedulers can trigger the
> following warning:
>
>   WARNING: suspicious RCU usage
>   sched_ext: BPF scheduler "cosmos_1.0.2_gd0e71ca_x86_64_unknown_linux_gnu_debug" enabled
>   6.17.0-rc1 #1-NixOS Not tainted
>   -----------------------------
>   kernel/sched/ext.c:6415 suspicious rcu_dereference_check() usage!
>   ...
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl+0x6f/0xb0
>   lockdep_rcu_suspicious.cold+0x4e/0x96
>   scx_bpf_cpu_curr+0x7e/0x80
>   bpf_prog_c68b2b6b6b1b0ff8_sched_timerfn+0xce/0x1dc
>   bpf_timer_cb+0x7b/0x130
>   __hrtimer_run_queues+0x1ea/0x380
>   hrtimer_run_softirq+0x8c/0xd0
>   handle_softirqs+0xc9/0x3b0
>   __irq_exit_rcu+0x96/0xc0
>   irq_exit_rcu+0xe/0x20
>   sysvec_apic_timer_interrupt+0x73/0x80
>   </IRQ>
>   <TASK>
>
> To address this, mark the kfunc with KF_RCU_PROTECTED, so the verifier
> can enforce its usage only inside RCU-protected sections.
>
> Note: this also requires commit 1512231b6cc86 ("bpf: Enforce RCU protection
> for KF_RCU_PROTECTED"), currently in bpf-next, to enforce the proper
> KF_RCU_PROTECTED.
>
> Fixes: 20b158094a1ad ("sched_ext: Introduce scx_bpf_cpu_curr()")
> Cc: Christian Loehle <christian.loehle@arm.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

