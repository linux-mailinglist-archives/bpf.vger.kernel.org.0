Return-Path: <bpf+bounces-75402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA2C82D51
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF53B4E0702
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA72F83AB;
	Mon, 24 Nov 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMJaBaVM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747302750FE
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027749; cv=none; b=lOL4+zwkH4aum0VVtbVCAFQ+ToK5wePYtMbFsvTZRXTqjhibsVApcvKe0xOQ/KgYr+OaPpxCcYCZl5AdSag17vSp9PJthHRKDXs6iVNhesBfk61eboaLfPDv6nPQ0XWmTXyulcp+k8zu6QI8ibYBk1w3sqj+b06i37Y9KOkmH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027749; c=relaxed/simple;
	bh=dG0C2S+L2R3WtJH9tdP29ghbxSjbg7+VtnphMfrKoEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8UhlcC7flVL5ZlARibDKPztr6kIZTN07nPI6cxIPSjSuh6h48nDtYdzWd8/xSFX3E2GWzcaYNpUlPAtTnET6Z5VXlaXad5rIL0staAICVD/9tFfEosuXWRvyfpClJ+T2LngWM3mxp3FO3m1KBdwcdyABCBvfusdUJv5j67mlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMJaBaVM; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-43479d86958so24112495ab.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764027746; x=1764632546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3apy2CyU2bh8Lc5v04oP/DIoqnkdbNgF8gnG9rkBtU=;
        b=bMJaBaVMEP48YG5KtvpQpg8hEB9ObXzr+cpsLlC/ftRYlS9xrWo/R98eW4yebHSuOz
         qRtY9DpUakEqSLLb7S8SVAiNJsIdfTnWSApy4lQFnn3r1GnIX4tCnJRLaWTwV0rDyk5X
         sVwqqWUnnRwNrTrx5h0BcpQGv/wVydCRvfzmoR3phRk6XVbdeiM51D5r1D+HyDmNkbZf
         uxkfnG5tfIONQPqHLqIDJYqZEa9s3ZT9UTrYja+CNfzBHlmtRgrSbAoZ/31wjYEOZM1v
         +f69kBms98OWDyeikSt1nHHVeDeyesRqiaC7NtTpGeoem+vn84C8ZNv9uXkU01yoKUTC
         LcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764027746; x=1764632546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w3apy2CyU2bh8Lc5v04oP/DIoqnkdbNgF8gnG9rkBtU=;
        b=qgrUbxXWNQQbu+TRK5kaP6+xeDCJfYfqu3oLshEsqlKMJ4bRxPUiS1NiQYSF44d0zw
         6CPTofy5GnnfJUDE/57OtbDwmyCFaUJKIKeUupS3xwCdbOnhGwA4nu/Vdzv6qCI1aJEa
         FaBO/F1DVWM4v8Xa+nq9H4F4DlbTUzFBIaDOz62wwtBy9Fc0HlB2WAi21xxPlinbFQOn
         TEfSoAj/bQwiGiByW2m+mVOCkb282kKFZu6VRntz1HoAD5VQjcj4jqq+m6+hZ/EQX7P7
         veiENWpUTletVzas+9ACyf1/MvOE0qutxmX6MD+EWsRHfdypZcd9s2v1onpmGgKdrVBJ
         OGNw==
X-Forwarded-Encrypted: i=1; AJvYcCVioe+LjuUjASu3zg5c5/xTg0ufgVeJFzFSqmQQc4LBwKZQ5rxDfvKYWTtXizRCLcQVSa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7c+RlHigVpgJ7rvZnJZAnM4yD2oIcGtGuPKJzCqicUJ5e0n6
	/RAjimi2X3iesMmbz3fCDb/IVEWmzMXrF1Vwh1snaQ/Wr0NqigSdi6w6kmEkk0PWSGY7nJuWGjJ
	/SbG2rK1VnHEWp674KG0apSjUNtfSoNs=
X-Gm-Gg: ASbGnctnN6aZyOWj6rWtKP/1AAPytPUd4btvSAxDxBcV/OkYC5Yk1uDCHNA7opvSBKE
	Px7BwTsmOGBw6RJ5Gbbs3HmhEqOx8CLM0dfw7XIIgAQQ1gcx4m1L4WxO9MXq7WTIy4m+jhDVUB9
	SrJg7iPxJWx4OjtDEVQ1ScTuaWm/Za0Dj1srGblWUzHptjE+KnV1L7xNV31TEtX9rNWYkA4t2NX
	KsDzeItgtKsjiNiz0130lZLc6FF+aJ7RFoY2pHkEXoQC+RVsu2asJyurJyMDw7wjr9HiUs=
X-Google-Smtp-Source: AGHT+IFhjvOgyNk/ahK1jKtOHPvBR51MmjnhrjCGQLG42lR8Yu6Hk1kGORg6yuxlKqs/mXoSn5MuPF95NqWv2N9KyMk=
X-Received: by 2002:a05:6e02:1a06:b0:433:4f6b:4ca with SMTP id
 e9e14a558f8ab-435dd0de78cmr7882615ab.24.1764027746430; Mon, 24 Nov 2025
 15:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124171409.3845-1-fmancera@suse.de>
In-Reply-To: <20251124171409.3845-1-fmancera@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Nov 2025 07:41:50 +0800
X-Gm-Features: AWmQ_bnE-Ua7Eq7VP_JZmltG_86Z7uUmIs67PUNX4Qyc6wi6NWDFRmM2Qm4MzIQ
Message-ID: <CAL+tcoBKMfVnTtkwBRk9JBGbJtahyJVt4g8swsYRUk1b97LgHQ@mail.gmail.com>
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	john.fastabend@gmail.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 1:14=E2=80=AFAM Fernando Fernandez Mancera
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

Could you also post a patch on top of net-next as it has diverged from
the net tree?

Thanks,
Jason

