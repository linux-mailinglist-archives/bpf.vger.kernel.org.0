Return-Path: <bpf+bounces-75014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB66AC6C103
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 00:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D1413499F8
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365743115B1;
	Tue, 18 Nov 2025 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftUxuC6o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBB27E1D5
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763510299; cv=none; b=YIKLuxxm0jDG05B+8brt5sBlmb9fig8eMZHHyd+2bEjSNtP0RpNi/fBCyR8tFDDsF30Vm6D4ULofO2XtTNZzKHYYBKXKoxHSMPV0GJ6nNAsZHLcRIK2abjNrzxjJIHLiGqp/ByP8AaWeHJ1gaG7Y/5esZ2RqC6N3dAchnzx4AlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763510299; c=relaxed/simple;
	bh=5tAJ47zFX9gz4T5fxNzGCe+6WWdu2i3qxuI/jP/4N1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6U/R5HLN2tGaYvinUWbKxmAisZ9x6ZWfc6bIsDZ+Ai0MCW69MMiElPL/MzBaFgL12GnsPQq3dSzxwvWyJg+d9EVif1irS6z8r32RpY0aI19Jx1bNNUxFLqUqJLykzqoptB+bOa1vMx43+DakxNr73aZlMoU6cKwzr0ZB2knJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftUxuC6o; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-433770ba959so35295985ab.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 15:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763510297; x=1764115097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkiZ64UoXtSYnpib+9rP2k6ThWKW/fjaVzr954J/GZM=;
        b=ftUxuC6ooqOZRjh+ay8U1YbxtYkYHBIjBiCdtj/0TDm+aSYgly9uOkN252Yl4vckA9
         R2ASMiDmvsbss0oZyogopmkeuxUvuW08Bu7P316vKQ+WR+8ob9TwKKpi+MisNQ1IWmrY
         1DR4VGuoMjjMLtosXHT/Tsr2Ym2RMcUHVpvNLJWY7otRvixk5CIVsMgETFzM0qJ/rA7J
         EPdaOLzBbUC07lZASkEY6jc9d50AZ0nMQXaI+GQjUCIdfGQI8ubp86AyLQYVGTxwqsoT
         JTIRqCqVzxBt+d57G+Hh926m7O6eIevDuUERc4dX9mfM/XKTC+lGFko94L+5Rpkcth0h
         O7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763510297; x=1764115097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkiZ64UoXtSYnpib+9rP2k6ThWKW/fjaVzr954J/GZM=;
        b=JkGhQBVoimjsnj8NTqLVdTOGwB+IRabSjRH0CBF/oPwIjvxhKWtiMK94ViwTCwyDiT
         eGcbNfiy+Ca5KK6kWnEujKavO+CGjt8hcfj2tfeyP0+1gPVFCc/wiOETU/QuVYL38AxE
         kf0TOH+0Ccj9wvFByk0pT/XTXdNUgX3M3jf7Glzan5k8w0T9643LiDlqppHbPNGcuiCl
         FP+0us1eNJIyI576xR5sko5ABw8KDM9zsvCPUcypnV36HvL8tLfr0ibWnUzBJA7rCeLP
         QaqJIPoRuyNNMg4owGmIXm352/o6aHqZxe85XUY2VXWkWEm295arHe7k1z0JtEkVSlNJ
         Xl8A==
X-Forwarded-Encrypted: i=1; AJvYcCUgoGa8MtccRFlc+172gjFhr1zNaKC/mxGCUGCKA+DdRnndP1IZSL65M23G6R7juhaZLAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5qJVcU7ORo0sKu7qF9jwjavTBte04K3X1BDziVkW0LVaD6es
	7Ud7bBg7Q3qxegRisIdE4Y1KbMfO3Z4wBDv3xPx+w4dGnOJ5pIvAum2oFs4/YjMDucaV5KoHig9
	w3NbUmVZQeSBIFtcclHWyG6WArq1R1dA=
X-Gm-Gg: ASbGncsBRjGyuUar5tPtQrRZZ1PnSTenV7BSP/U/nJHWjYjr48Sw0s822vvA8VTE4i4
	M04zgXxDdiJ293uUm/C2+ogXSkBYYVcLsjQXdAuTGuv7rhMDhaPZgoWJ/lxSxKbAZbWM9KNVgvm
	11PXMjzSFGqxVl7vaU6A9Ft6Rul6+wGzpoawIn2FwwV7TYdDFMQxpDhWhUCE30Tf5qXmmYgN4r7
	72wHjPaE07MU4FSe3JhiUUdNjQJH8Vq2EeOB0izJ+8B7vAFgOXDfD85AujMM+y3sHXvuIQ0XYbJ
	17o0gHi9
X-Google-Smtp-Source: AGHT+IFmS29CWrYRvyTbb+W6jFmSNhlfiJEhPBeIs7q7jfCV8ZsklmhdIHu9x+VAEuR+6bDrfr76UBgawkuziMV5gRo=
X-Received: by 2002:a05:6e02:148e:b0:433:5b75:64d6 with SMTP id
 e9e14a558f8ab-4348c93733fmr246677525ab.28.1763510297319; Tue, 18 Nov 2025
 15:58:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118124807.3229-1-fmancera@suse.de>
In-Reply-To: <20251118124807.3229-1-fmancera@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Nov 2025 07:57:41 +0800
X-Gm-Features: AWmQ_bm-Gjj0eMYFUANQsCSI1iXAT4Hke8358FyYhOIi2eiNrUtc1r9YMzcq6NQ
Message-ID: <CAL+tcoCGP8crix=NWca9PBMF4z9NAXKJu8kyTdKanb3n7JEpWQ@mail.gmail.com>
Subject: Re: [PATCH net v4] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:48=E2=80=AFPM Fernando Fernandez Mancera
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
> Instead use the skb destructor_arg pointer along with pointer tagging.
> As pointers are always aligned to 8B, use the bottom bit to indicate
> whether this a single address or an allocated struct containing several
> addresses.
>
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf=
1c@nop.hu/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks for your effort and the fix!

