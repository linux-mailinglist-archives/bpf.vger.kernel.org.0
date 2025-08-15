Return-Path: <bpf+bounces-65724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B67ACB2795F
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2815E1CE4A0C
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6C2C17A1;
	Fri, 15 Aug 2025 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2oPZPNc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0A4315F;
	Fri, 15 Aug 2025 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240336; cv=none; b=fila1xYKwFoOV5uchJQaU4dv8iFIJuozc6teUOggGSCuiTO4RwFcRLpzW9j8OQfqjSb4mA2WfVax8tQJCBQ/qRDtFl03oDKp3+9zc9M49k+ZcnfSOuXToFfTgR513DWP7afFOYTVm8Os3nb1GEDDDvjTS37RcSZnlhs1PtdqEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240336; c=relaxed/simple;
	bh=SCYjCnz3XVRzVnVe5rs6F1dPNQttczMdZqhy4mt5/NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5LglzhJ89NIVnjvEybPbDSZHDq9Xj5rQbRxO6QYcLki81uq5TZMEWM0pty4uq73VMgwvkiAww6HGUQYG2mvoC8lnKHnDdm02of+X3lnsbNtmL2k3iDQqOy1RuyexDghl44g6BB9zwcd7kzFyaG6DkOxx5WOB+2KLaAqwxWja2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2oPZPNc; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e56fe95d83so9287885ab.0;
        Thu, 14 Aug 2025 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755240333; x=1755845133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7hH2B7Sxrr0RtmYEadQyxGGr9aWUdk/Aw4TDC1HQ4k=;
        b=B2oPZPNckSxw2wj3zTMxy+2I/yamg+ssKePVjVOnVXiGpzXK944+gFPew/rP2b9P92
         ldhs1mdeUODPoJ6sLq94g5Uaf67h73NoLBANwhy2LKi4kdPRRYZdnnoYAXbpXkWxtSHE
         3yQ6dLC1ClG0Tj6/Gqf5KxLMZ9kYOwEPOrAuyU5NBHFKk6qrOWTttRGaU8odlVZnwxVB
         24EP5M22Ag089lasYE7dOZdhnta0mee12wDLQ0F2BC+HhsvVr2gv0LvponBqPn7F2xZB
         uA61JXGuoxlFLgyNNaUThoPBVk7mX5AbYdJMoxQZHJjGCb2oUkbWlYrB8yEV0b4IrDHg
         QJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755240333; x=1755845133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7hH2B7Sxrr0RtmYEadQyxGGr9aWUdk/Aw4TDC1HQ4k=;
        b=ZiIu1HfSD0N2sBWwMGd/l8Fhgq9VW+IgNNNyc+R7KDjoEQh3DsMHiluWUtJ0pHH+uM
         lgq/jr92i0oxSB9Bjrd65uJ/mxusCQk91p6t2OBf+zrr1DGT11Ol5dNMEVj/J0h3ZCuX
         3KVFTgDGuZiI+OOL9enBSJd0yV/MfbWV6cC0zolLaWSZm86yRv1JSh7BDnCZlI4LP3Cx
         jFncifrQ+U09XrlfJr4Xkn1WHCtHE68rhidKPdCuXSu4T0BI2vaV2kddULiaPg+8Bn+F
         wHuwRX40asvSqdKxRHShHC76meSsCSD/bVShBBjfNJcvHxUUCax/dZJ42/52FNCeDaSc
         Au8w==
X-Forwarded-Encrypted: i=1; AJvYcCVbQSz6+jkZUYm6zUeWXvHDv8I1x6CU1/XQCeSYoBeqhxpTCnP5mwsQknMZ4iqnNAdFfME=@vger.kernel.org, AJvYcCXRyftD823gXYODGrP+Vkmb3zbibpEoRRRIE237Z35WiqOR3KC0NKG6ljv8vSeaBjauMlVdZEc5@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnKTXssm9Ocmb0jhKBwVDLfl50kym8NuGpj/JwKwFyHWTgcam
	AGvgfl2/fvGhP16gLO/5ODHW/JBXPNTY8sMpXYZdWULw+SXQrzoZEg7yhFsoqW5l8/kakMnYFO3
	cB5IyE/PGn9BA/pyHaMhZEfk5dvLvfjI=
X-Gm-Gg: ASbGncu0wLtvW+3aRYWyn4rczVoYJS5uCZjc21uNYLN8mKdG4tuV/meuzZUMc0q4XB/
	2Pnyvkc7oXEObYapoWZhEHc9Ozz4lR9JZ4xVSOgRe5igGen+PlmKI8iWiZuma98L/hfYLqsLXah
	N7PVcrXeV22gj5cWzeGliVGNRMTq0TsLNkBx5JUrdXKJ+7XfsHAJyWTldBg1tAe3tXMZIqqbWRE
	ZFlQU3v+Rd0AwdaUg==
X-Google-Smtp-Source: AGHT+IFTwJ9rZu8aVPSRnfUbYyXPqkmlPt7Vj7eJRtwEj6UTWqPmzTUIOanNW+vYUNkxPNiSnRVBIloy036mHDdBulk=
X-Received: by 2002:a05:6e02:18c5:b0:3e5:5081:eb8f with SMTP id
 e9e14a558f8ab-3e57e9a83cfmr15691625ab.11.1755240333189; Thu, 14 Aug 2025
 23:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com> <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
In-Reply-To: <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 15 Aug 2025 14:44:56 +0800
X-Gm-Features: Ac12FXzmAnyXhuD3wwiwV0gKvtDswa1f7Jm9-MH_bHUrNKUrjIoQ2uTRLnY9VYA
Message-ID: <CAL+tcoBWOUCd8f1Q6BYh+xuKs5=Qgr2oOBb9CLU_6BrasD0vfg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:30=E2=80=AFPM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
...
>
> But this also requires changing the SKB alloc function used by
> xsk_build_skb(). As a seperate patch, I recommend that you change the
> sock_alloc_send_skb() to instead use build_skb (or build_skb_around).
> I expect this will be a large performance improvement on it's own.
> Can I ask you to benchmark this change before the batch xmit change?
>
> Opinions needed from other maintainers please (I might be wrong!):
> I don't think the socket level accounting done in sock_alloc_send_skb()
> is correct/relevant for AF_XDP/XSK, because the "backpressure mechanism"
> code comment above.

Here I'm bringing back the last test you expected to know :)

I use alloc_skb() to replace sock_alloc_send_skb() and introduce other
minor changes, say, removing sock_wfree() from xsk_destruct_skb(). It
turns out to be a stable 5% performance improvement on i40e driver.
slight improvement on virtio_net. That's good news.

Bad news is that the above logic has bugs like freeing skb in the napi
poll causes accessing skb->sk in xsk_destruct_skb() which triggers a
NULL pointer issue. How did I spot this one? I removed the BQL flow
control and started two xdpsock on different queues, then I saw a
panic[1]... To solve the problem like that, I'm afraid that we still
need to charge a certain length value into sk_wmem_alloc so that
sock_wfree(skb) can be the last one to free the socket finally.

So this socket level accounting mechanism keeps its safety in the above cas=
e.

IMHO, we can get rid of the limitation of sk_sndbuf but still use
skb_set_owner_w() that charges the len of skb. If we stick to removing
the whole accounting function, probably we have to adjust the position
of xsk_cq_submit_locked(), but I reckon for now it's not practical...

Any thoughts on this?

[1]
 997 [  133.528449] RIP: 0010:xsk_destruct_skb+0x6a/0x90
 998 [  133.528920] Code: 8b 6c 02 28 48 8b 43 18 4c 8b a0 68 03 00 00
49 8d 9c 24 e8 00 00 00 48 89 df e8 f1 eb 06 00 48 89 c6 49 8b 84 24
88 00 00 00 <48> 8b 50 10 03 2a 48      8b 40 10 48 89 df 89 28 5b 5d
41 5c e9 6e ec
 999 [  133.530526] RSP: 0018:ffffae71c06a0d08 EFLAGS: 00010046
1000 [  133.531005] RAX: 0000000000000000 RBX: ffff9f42c81c49e8 RCX:
00000000000002e7
1001 [  133.531631] RDX: 0000000000000001 RSI: 0000000000000286 RDI:
ffff9f42c81c49e8
1002 [  133.532249] RBP: 0000000000000001 R08: 0000000000000008 R09:
00000000000000001003 [  133.532867] R10: ffffffff978080c0 R11:
ffffae71c06a0ff8 R12: ffff9f42c81c4900
1004 [  133.533491] R13: ffffae71c06a0d88 R14: ffff9f42e0f1f900 R15:
ffff9f42ce850d801005 [  133.534123] FS:  0000000000000000(0000)
GS:ffff9f5227655000(0000) knlGS:00000000000000001006 [  133.534831]
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
1007 [  133.535366] CR2: 0000000000000010 CR3: 000000011c820000 CR4:
00000000003506f0
1008 [  133.536014] Call Trace:
1009 [  133.536313]  <IRQ>
1010 [  133.536583]  skb_release_head_state+0x20/0x90
1011 [  133.537021]  napi_consume_skb+0x42/0x120
1012 [  133.537429]  __free_old_xmit+0x76/0x170 [virtio_net]
1013 [  133.537923]  free_old_xmit+0x53/0xc0 [virtio_net]
1014 [  133.538395]  virtnet_poll+0xed/0x5d0 [virtio_net]
1015 [  133.538867]  ? blake2s_compress+0x52/0xa0
1016 [  133.539286]  __napi_poll+0x28/0x200
1017 [  133.539668]  net_rx_action+0x319/0x400
1018 [  133.540068]  ? sched_clock_cpu+0xb/0x190
1019 [  133.540482]  ? __run_timers+0x1d1/0x260
1020 [  133.540906]  ? __pfx_dl_task_timer+0x10/0x10
1021 [  133.541349]  ? lock_timer_base+0x72/0x90
1022 [  133.541767]  handle_softirqs+0xce/0x2e0
1023 [  133.542178]  __irq_exit_rcu+0xc6/0xf0
1024 [  133.542575]  common_interrupt+0x81/0xa0

Thanks,
Jason

