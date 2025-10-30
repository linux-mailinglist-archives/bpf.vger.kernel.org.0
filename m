Return-Path: <bpf+bounces-72956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57972C1DFC5
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 02:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B52CE4E52DE
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627B23EA9B;
	Thu, 30 Oct 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMjLIlyE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32D266A7
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786370; cv=none; b=h0wBCY8HoVeTmznJTT+LjU5SWPl1ifJIdOHH3DlZ8O/OkY+mjz0x+jJ+wpfZru8zUae9fcy8BEgGHznZqaNjV1z+3upJbiGIkwLXtk9dwMNKxnARsrh6QdF/EguNXoh/wGIitQvfIm7KGsUo0hts4WXAEF01tADXfwtpoBiD4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786370; c=relaxed/simple;
	bh=L8krtgX+6ralJcIjlTbaje2g+J4vDEGDOdySbO0kb5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwwWHBwQOdFGNb2zA2CL0uCpHmXQ0QAsZsNHtzKUTckNVboLYS3tCyPV5476/MhcdamKdhGug6EntLLhU0NSxRTp5SXiSYaRh3UMlCUJ4TCtvwMKJu8ufW0SpMR9SyiBkSCWFFIzmk/luw4q1WwSJSkjy12wQOgrOj2Wn/4s0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMjLIlyE; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4330121a885so1971875ab.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761786367; x=1762391167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAObxcR4HKyNDmTkYhPM7UMETIyPvjEyFOejPzT6as0=;
        b=XMjLIlyE/NnxsRrKXjSvRqV+Ab7g5KWKpvu2nzK+Vu1EHJQIfnq/urXT4kQ/7LlI4x
         jCjHB0rYrWNl4H4JcXG7fNzgKToG497GBq5I3ZpBsB0v9qGqH/sTp4rJozyXLvfeNSMR
         MAJgLOGS2iSScR4xPQ3tyki6+pLE+x0aTZDwkcnnX624/JUZ4oHcsCKeMEJinslhyO/k
         rYe/QbzMRrbr/Hll1p0Mwab6JbzcBT2VEM+oFPU1Tf9qMl0m93BaXszMJsk9FmDW3/Ip
         ucZ00WgR4u/ybAZJTPj3WpqboXqsJZMctywbjq2GCmTeeMZreAXSOkG1+T4DffB/zRtT
         1eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761786367; x=1762391167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAObxcR4HKyNDmTkYhPM7UMETIyPvjEyFOejPzT6as0=;
        b=iQpv5VEArLh8K1kKyYQHI3WCwEmDbsRjrCUo7asNdl4V5av4KPZO6HXIOUXi9RVcSz
         Q0yFDVE8xcxWJNcQ9oQaNg6QYklsD6c7rpL9NayG1Z8RxeKwzCnTyuI+VmhlySyDIdi2
         /lSNGmEOZokTPUNOZinL1NVkLvaBf5SzzIjQOyR8sLRqjt9FMKM3OZF9P8RAVBubnrjV
         yiP6nG7jyv2OLeIPITxkITPSgpOtiYoB5O/+nrG2gfPc1BBnaCOwrzze3yJUQZvZdQVf
         kZC8H6JksanPsW4bS4IcOBBSj5sYFau3d3U0oFuA6vSL5E0L2nYF0R7owVixMxkXg/pY
         ZW9A==
X-Gm-Message-State: AOJu0YxbId6WyBx/DI6+bCoUlNtUoD3ivKuw5zBDQFyfuvF4i0Jp9XQQ
	vLFRYq55wBtZk9rzSzOx44MesIDfMM6kPQyuQmfnK22bFCgJZ1EwpaRbxXzouEhM8GyMQ9nZt3D
	s/NC+yF6GyTo/eyMGRozHnMXOxGpJcEY=
X-Gm-Gg: ASbGnctCe6YOn9xtskHMqOT1DMhKFJsNvUAqMSnu340kq/ewsozae9ntJTFuHhbD6QS
	zT9abZdhvkcg4+g/b+KwoXDbOhJHR00k9hkq80+96mV7B9samnw6H/8tjk3I2a9rkpeYZUFKwwU
	mFXM7E1yGObzZTzOYojWMkKWKef0oL3vgwjcY72GwlqhoVHX71kQ4anjeITu84/y7H8xJRVYsee
	qtrknoDyNyhX7qaaShrxyfV3BHiDl+31VTMj0FTbowv4qrXPYrmEaTeUI+CiP6bfNHHFw==
X-Google-Smtp-Source: AGHT+IGyU+e2TKks/GzIgeq6nuTulBw9VRG+BFu1zdSqlOgbKI7LBQM+eWqxleIKd9dXVO254PS20cDRmLtWHNoZhK8=
X-Received: by 2002:a05:6e02:148a:b0:430:a183:85 with SMTP id
 e9e14a558f8ab-433014dabcfmr21550535ab.1.1761786367485; Wed, 29 Oct 2025
 18:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028183032.5350-1-fmancera@suse.de> <20251028183032.5350-2-fmancera@suse.de>
In-Reply-To: <20251028183032.5350-2-fmancera@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 30 Oct 2025 09:05:31 +0800
X-Gm-Features: AWmQ_bkuS7qmFAAnlHJ8e34dvDD7tihPHsebYl69q3OqYQP549CHRnIRSzkggtA
Message-ID: <CAL+tcoD4es0WLbZRF+OhrfrL3XrkDw1rnr80bBxFJn9zZBJWGg@mail.gmail.com>
Subject: Re: [PATCH 2/2 bpf v2] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:30=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
>
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-a=
md64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debia=
n-1.17.0-1 04/01/2014
>  RIP: 0010:xsk_destruct_skb+0xd0/0x180
>  [...]
>  Call Trace:
>   <IRQ>
>   ? napi_complete_done+0x7a/0x1a0
>   ip_rcv_core+0x1bb/0x340
>   ip_rcv+0x30/0x1f0
>   __netif_receive_skb_one_core+0x85/0xa0
>   process_backlog+0x87/0x130
>   __napi_poll+0x28/0x180
>   net_rx_action+0x339/0x420
>   handle_softirqs+0xdc/0x320
>   ? handle_edge_irq+0x90/0x1e0
>   do_softirq.part.0+0x3b/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x60/0x70
>   __dev_direct_xmit+0x14e/0x1f0
>   __xsk_generic_xmit+0x482/0xb70
>   ? __remove_hrtimer+0x41/0xa0
>   ? __xsk_generic_xmit+0x51/0xb70
>   ? _raw_spin_unlock_irqrestore+0xe/0x40
>   xsk_sendmsg+0xda/0x1c0
>   __sys_sendto+0x1ee/0x200
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x84/0x2f0
>   ? __pfx_pollwake+0x10/0x10
>   ? __rseq_handle_notify_resume+0xad/0x4c0
>   ? restore_fpregs_from_fpstate+0x3c/0x90
>   ? switch_fpu_return+0x5b/0xe0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>  [...]
>  Kernel panic - not syncing: Fatal exception in interrupt
>  Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xf=
fffffff80000000-0xffffffffbfffffff)
>
> Use the skb XDP extension to store the number of cq descriptors along
> with a list of umem addresses.
>
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")

It might be off topic a bit. I keep wondering if we can find another
solution to fix the issue that the above patches tries to fix: how to
avoid the wrong fallback in that corner case. It's unlikely to happen
but the cost of correcting it is high because of adding memory
allocation in the hot path and freeing memory when the irq is disabled
in the irq context... Sure, for the latter, we can implement a
workqueue to handle this to mitigate the impact. Here I have no
intention of expanding another different topic.

Adding additional memory allocation or something like that is really
not a promising direction we should take. In high performance features
like copy mode in xsk, the biggest challenge is memory operations and
the second one is various locks.

Thanks,
Jason

