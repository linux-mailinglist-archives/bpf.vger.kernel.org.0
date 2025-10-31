Return-Path: <bpf+bounces-73152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB64CC24739
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 11:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54272188ACF4
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8B33F8BC;
	Fri, 31 Oct 2025 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeRKJe11"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880020F067
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906261; cv=none; b=SbYaHe2rDA3pcmfFJq9jdkEBTklt0OpsroCN3qP1+2YkS04M/qigaI3wek7pmvFWyh1Lfc8W7X6HQ2w9m3yy/+osB6FpLMNhWgVfzQc/pGqyRUem7eHAcuKP+Hp07Rptz9iM+6UwWJ7Z0VB/9Dkjfy6T4uS9jbzWJeoXnc2X+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906261; c=relaxed/simple;
	bh=D1Xy00qgplQ4CxhVupRHRrM9ufHQk+cp/uFPcEY+Juo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAAyYk0OspJ13PMFPMs8+gX6xGleKppWhii0f2xs5qNNV+pPLdJvMTy4w0Y2zQxmMqs0q6a2R3B9IlU0fDkZMHqMwxxuf3VcH+0PrpYkMeu0BzC0t1cPSGi8Ilf853YoXQPLR+jGibOGqCJUYHeCo4KxTX7QkXGkVNHum2qLjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeRKJe11; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42e2c336adcso7951835ab.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761906259; x=1762511059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gkgfv9tootIqhycA+Qln9V3+am0892WmbrCpNXTuqYA=;
        b=XeRKJe11+i61I/agIIe8RGs5waVpnYhzwvXxoD1PnGVdUiAcLBXGK2+WMveGH+vw24
         Eq12uyvm6iVtdI2FHI/aZjv4wuGWZA1ZLF2sTfWT0N7mb/x8ABaSucX+bFxuKQbCoVIW
         hmagAho/voKovXqGsskPfajMyL7bqCezkMlPvaAngHjay+1B8ZYWBY+ElLG7f/psyy6o
         5IR+3Pp50L+IwU2L7qRqJYOHStbeN2ZpzrQ1kd40rDX1zLbvTvgm4zq1j+JLEaorIShY
         8uROCwP7qsRWitrbcQhJRw64mBTv8bwWTg+IOhOIkd6SdHoNgcPLnM1PQ/AvibuWTTZP
         QUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906259; x=1762511059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gkgfv9tootIqhycA+Qln9V3+am0892WmbrCpNXTuqYA=;
        b=DELfy0+I8FUrcwi7qeNoW6KiV44t6JAH1p7AsxvrQbjMADrBgr8jvflfQEwyMOfQzl
         XgZ0lWT4UccRpShkvfaqyZy5/6QAhSlDP+sRp+dtMny7WhAs3Wg7Shn6H7k+eel6e7g4
         3r6aLRjezKY9trRPepfjKJ4HQJAALhuhQHnsjtryg/n6yUZoIoU25iE2O+prExUvX2xy
         dBI/kJcDqsTUnW9sTmX3Zf/ctHLo59MWkNhZYeo99wDwjYAkNE0ahotz1Ztd4SRyqjEC
         fOeMMtq7OGQogdHCI06UNMieAzDsx37yelpHIwtvwiim3L6hprWHCKba9QO8xwuSoIfF
         zbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNOZDrpPi/lZ2VcoFHn8uLs2HdUb9f3CsLFlKagY/rv/CUTiThanKqTffbzMoQcr530dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgjQp2QExEfSvxoNk+5Z1h84ycIKy6YzhgzRmKcix21d9kmti
	eEJSznMLkGrmEQ3gFHJQLNAB0851LBzYif6N+WDsucaqFYeiyFHmzgQo8VICK/Wlxwp+YlJYLG9
	r8hfMt5i1KTR5QCmMvRfeJUa24uxE1wY=
X-Gm-Gg: ASbGncv7o8i1gCqseRtX5DdANXwjpPDxRuLbBoPsVPiTgmMVv16O5ouGQ3KBAFOrGbm
	p2hEYR/85mZJQrlK0x8Nutq/yz0xG1OoOM9GdsjGuO18Uv0j57paYUf1jp9LZUhxPU5tUX0QRcy
	f3Ug81GRowu1gtHJeI5TvNGs9txdtZw/cIJev5qW1gVE1IifVqKvOUCNZWK6AZE2xV7m1cm8gse
	Toih/4/s8MD1DgRsSK1mAhGm6izXEBr9wzBtVR5KQtswwai/sMhvXJctRUGsIoR
X-Google-Smtp-Source: AGHT+IHHHXymJ8JSJ4Xi5YlKRmIaIJK+xFvdr+mbDmGzCpmsr3lK9pl7bHMABGDWp4z4mOzA4BO+KdMa0Go1LavuD48=
X-Received: by 2002:a05:6e02:3090:b0:432:fccd:288a with SMTP id
 e9e14a558f8ab-4330d1e471dmr47241975ab.25.1761906259125; Fri, 31 Oct 2025
 03:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030140355.4059-1-fmancera@suse.de> <CAL+tcoB9AUGLafYF0rMs7-+wFJPrTUzf1cbwy4R_hc_7Zs9B3Q@mail.gmail.com>
 <9fa46203-cafb-4def-9c09-e589491f9f65@suse.de>
In-Reply-To: <9fa46203-cafb-4def-9c09-e589491f9f65@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 31 Oct 2025 18:23:42 +0800
X-Gm-Features: AWmQ_bmRDEdvPYznbyakpfhgma-Na9UwKyTRP1yfzqSh1hY2wIsJ5xEyFMtwNOE
Message-ID: <CAL+tcoBx88qdt5BXjEvRUh1bxW2-Q9PGMjRcEjotAEzw1=hkVQ@mail.gmail.com>
Subject: Re: [PATCH net v3] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bjorn@kernel.org, sdf@fomichev.me, jonathan.lemon@gmail.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 6:05=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
>
>
> On 10/31/25 10:51 AM, Jason Xing wrote:
> > On Thu, Oct 30, 2025 at 10:04=E2=80=AFPM Fernando Fernandez Mancera
> > <fmancera@suse.de> wrote:
> >>
> >> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> >> production"), the descriptor number is stored in skb control block and
> >> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> >> pool's completion queue.
> >>
> >> skb control block shouldn't be used for this purpose as after transmit
> >> xsk doesn't have control over it and other subsystems could use it. Th=
is
> >> leads to the following kernel panic due to a NULL pointer dereference.
> >>
> >>   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >>   #PF: supervisor read access in kernel mode
> >>   #PF: error_code(0x0000) - not-present page
> >>   PGD 0 P4D 0
> >>   Oops: Oops: 0000 [#1] SMP NOPTI
> >>   CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-clo=
ud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-d=
ebian-1.17.0-1 04/01/2014
> >>   RIP: 0010:xsk_destruct_skb+0xd0/0x180
> >>   [...]
> >>   Call Trace:
> >>    <IRQ>
> >>    ? napi_complete_done+0x7a/0x1a0
> >>    ip_rcv_core+0x1bb/0x340
> >>    ip_rcv+0x30/0x1f0
> >>    __netif_receive_skb_one_core+0x85/0xa0
> >>    process_backlog+0x87/0x130
> >>    __napi_poll+0x28/0x180
> >>    net_rx_action+0x339/0x420
> >>    handle_softirqs+0xdc/0x320
> >>    ? handle_edge_irq+0x90/0x1e0
> >>    do_softirq.part.0+0x3b/0x60
> >>    </IRQ>
> >>    <TASK>
> >>    __local_bh_enable_ip+0x60/0x70
> >>    __dev_direct_xmit+0x14e/0x1f0
> >>    __xsk_generic_xmit+0x482/0xb70
> >>    ? __remove_hrtimer+0x41/0xa0
> >>    ? __xsk_generic_xmit+0x51/0xb70
> >>    ? _raw_spin_unlock_irqrestore+0xe/0x40
> >>    xsk_sendmsg+0xda/0x1c0
> >>    __sys_sendto+0x1ee/0x200
> >>    __x64_sys_sendto+0x24/0x30
> >>    do_syscall_64+0x84/0x2f0
> >>    ? __pfx_pollwake+0x10/0x10
> >>    ? __rseq_handle_notify_resume+0xad/0x4c0
> >>    ? restore_fpregs_from_fpstate+0x3c/0x90
> >>    ? switch_fpu_return+0x5b/0xe0
> >>    ? do_syscall_64+0x204/0x2f0
> >>    ? do_syscall_64+0x204/0x2f0
> >>    ? do_syscall_64+0x204/0x2f0
> >>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>    </TASK>
> >>   [...]
> >>   Kernel panic - not syncing: Fatal exception in interrupt
> >>   Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range:=
 0xffffffff80000000-0xffffffffbfffffff)
> >>
> >> Instead use the skb destructor_arg pointer along with pointer tagging.
> >> As pointers are always aligned to 8B, use the bottom bit to indicate
> >> whether this a single address or an allocated struct containing severa=
l
> >> addresses.
> >>
> >> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> >> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-6886847=
4bf1c@nop.hu/
> >> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> >
> > I don't think we need this fix anymore if we can apply the series[1].
> > The fix I just proposed doesn't use any new bits to store something so
> > the problem will disappear.
> >
> > [1]: https://lore.kernel.org/all/20251031093230.82386-1-kerneljasonxing=
@gmail.com/
> >
> > Thanks,
> > Jason
> >
>
> Right. Then let's consider this patch dropped.

Only if we all agree on that new approach :P Any suggestions are welcome :)

Thanks,
Jason

