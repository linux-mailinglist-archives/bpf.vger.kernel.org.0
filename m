Return-Path: <bpf+bounces-44248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA9D9C0A52
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D612283D3D
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93612213157;
	Thu,  7 Nov 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da07fTKk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC5A13635F
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994397; cv=none; b=IDuCjXFFLgOKhRZDwESGA3SnazCKoivB2ABGJH82Nojo2OV4TapIF/pMr9QxciYnVbzfb2Cy5vi5YCNOt62tpBBDpsupWoCLCcd8OnEueU+5JX3HvcdyybsPECuRtByiKsqpdtjE1wh2WaziERUeRB5oS1wCxCQN5mHDzlmiAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994397; c=relaxed/simple;
	bh=cyIZ95Z/f2HM7Lht+VZs0K17697ScWAq+odM7Try00o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7wvqI2UOW0dXmb6zkqvq/0tTMTNuh6pO/ll13T8ZYWdqjwZIKOpqJy0jKBh69GTstu2YKGI5AKydNckSng245p0dp2x1wwWmId1m9Gynaz4ivYoBOaavH0TYnUi+P/Emb/mO5+TmyoJkZfdR+4bQXOEaNVoiAjgdzDugUN7dK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da07fTKk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso13246885e9.0
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 07:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730994393; x=1731599193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02DwU3vG9Lf4hWdzxH5zz0msOsOJ+ej1hvwng8SzkTg=;
        b=Da07fTKkXEB9m0NpOAZgqXglwgBb2HNZgJlmBnxt3qWLkYZCxhkucBGGllqUehVIr1
         IVL3em7fy61MP8kW214cgG45jHKM27KzHx9uKWIFEA9+LWpZ843UkN1Z19FqJ5zqqhWR
         1d6gnQ90fZS+TI9bn9LcQ6rd1wPf71iMgkSDZgE6oXTHFFCBrZrEHfU0YPSDWTiIe+GJ
         cQBi+DCKePEPn2i8ychjDbNrVISBtQZ80iDyh1FnTtd1EkA09rwFzJT90Uf3IdVfpdXH
         fEWn54aAZiq/RMHbNMmSCnULg9zShcXgBo1ajY4hoR/v0nllNI1L55tI2JiCg8HsoNa4
         /hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730994393; x=1731599193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02DwU3vG9Lf4hWdzxH5zz0msOsOJ+ej1hvwng8SzkTg=;
        b=Orc4jTTPlseaPAbamS4x1BOFfvZu0PeGzZJTce1TBqSnftbpPfy+mITflzN48wpXPK
         gp+V2bG84PWcOVmPi7BzpyrrAljYWj3+zVMCGhqTXTR5PVciAl12KNO9ZWeF567e1AYU
         aiLJ8epH3IqMY3jSd+b3AnfawS98G71+Q9G638Jenn5rwy0wTY/o44XibXEYUe+mrpVS
         kQWTGClmpdUud/DPd0X4uqLJj5UcQlNSuUK/DYuSbaUp9QK8B/eP8ODS71VK0VYMrTUW
         lrM+JcKMyAzXefGgmynUXse2Ht7o5mmQ3+vGRBqYI869g6fuDgFd9gh45SGlr/NFXW/c
         k5Tw==
X-Gm-Message-State: AOJu0YzkJdxAad/KHvJOihmvUg9hPJ1Do7yFZaA05CUWNrPSmU/5MLq7
	LKGkifBABGCAwrZ1DJPwXLo39czUouLC0vn8ub5bnZPTUXF06XosCSajASYitF/q7yls0pzMNF/
	rP8q9TjRDr1s0yhfDCTybIe+HUrI=
X-Google-Smtp-Source: AGHT+IGJomdjiREoyVf8EoroSIIpZSV5jlEMOaLvMycG0ttRESTSkoYP0RpuzLmS7KNU+Uhz4IZeXMMclQbrPYOzQ68=
X-Received: by 2002:a05:600c:3b82:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-4328b4bdc8dmr213025705e9.32.1730994392690; Thu, 07 Nov 2024
 07:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4afdcb50-13f2-4772-8db1-3fd02bd985b3@redhat.com>
In-Reply-To: <4afdcb50-13f2-4772-8db1-3fd02bd985b3@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Nov 2024 07:46:21 -0800
Message-ID: <CAADnVQKj-XBs=4nq-cmUKcJLJXPUZzjNV19OhBRjG9-UrS02Cw@mail.gmail.com>
Subject: Re: [BUG] Soft lockup on powerpc when running arena selftests
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:38=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wro=
te:
>
> Hi,
>
> I'm getting soft lockups when running the BPF arena selftests on powerpc
> (ppcle64). The issue is 100% reproducible on the latest bpf-next with
> `./test_progs -t arena`.
>
> A console snippet for one CPU lockup looks like this:
>
> [ 1124.671746] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [kworker=
/u34:0:58]
> [ 1124.675554] CPU#1 Utilization every 4s during lockup:
> [ 1124.675584]  #1: 100% system,          0% softirq,     0% hardirq,    =
 0% idle
> [ 1124.675621]  #2: 101% system,          0% softirq,     0% hardirq,    =
 0% idle
> [ 1124.675659]  #3: 100% system,          0% softirq,     0% hardirq,    =
 0% idle
> [ 1124.675696]  #4: 100% system,          0% softirq,     0% hardirq,    =
 0% idle
> [ 1124.675733]  #5: 101% system,          0% softirq,     0% hardirq,    =
 0% idle
> [ 1124.675770] Modules linked in: bpf_testmod(OE) bonding tls rfkill virt=
io_net net_failover vmx_crypto failover virtio_balloon crct10dif_vpmsum fus=
e loop nfnetlink zram vsock_loopback vmw_vsock_virtio_transport_common vsoc=
k virtio_blk crc32c_vpmsum virtio_console
> [ 1124.675921] CPU: 1 UID: 0 PID: 58 Comm: kworker/u34:0 Tainted: G      =
     OE      6.12.0-rc4+ #1
> [ 1124.675975] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> [ 1124.676005] Hardware name: IBM pSeries (emulated by qemu) POWER8E (raw=
) 0x4b0201 of:SLOF,HEAD hv:linux,kvm pSeries
> [ 1124.676063] Workqueue: events_unbound bpf_map_free_deferred
> [ 1124.676101] NIP:  c000000000551d3c LR: c000000000551c30 CTR: c00000000=
04733b0
> [ 1124.676145] REGS: c000000008a37a20 TRAP: 0900   Tainted: G           O=
E       (6.12.0-rc4+)
> [ 1124.676189] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  =
CR: 44082828  XER: 00000000
> [ 1124.676251] CFAR: 0000000000000000 IRQMASK: 0
> [ 1124.676251] GPR00: c000000000551c30 c000000008a37cc0 c00000000214f800 =
0000000000000000
> [ 1124.676251] GPR04: 000000000000003b c00c00000044e3c8 0000000000000000 =
0000000000000000
> [ 1124.676251] GPR08: 0000000000000000 0000000000000000 0000000058006001 =
0000000024082828
> [ 1124.676251] GPR12: c0000000004733b0 c00000003ffff480 c0000000043cb7c0 =
c0000000043b1028
> [ 1124.676251] GPR16: c008000305f78000 0000000000000000 0000000000000001 =
0000000000000000
> [ 1124.676251] GPR20: fffffffffffffe7f c008000305f77fff c000000003cbe780 =
c000000001b26120
> [ 1124.676251] GPR24: c000000003da0380 ff7fffffffffefbf c000000003cbe780 =
0000000000000001
> [ 1124.676251] GPR28: c008000206000000 0000000000000000 c0000000004733b0 =
c00bf073759e8000
> [ 1124.676627] NIP [c000000000551d3c] __apply_to_page_range+0x55c/0xea0
> [ 1124.676667] LR [c000000000551c30] __apply_to_page_range+0x450/0xea0
> [ 1124.676706] Call Trace:
> [ 1124.676730] [c000000008a37cc0] [c000000000551c30] __apply_to_page_rang=
e+0x450/0xea0 (unreliable)
> [ 1124.676784] [c000000008a37de0] [c000000000473360] arena_map_free+0x70/=
0xc0

Thanks for the report.
I have no idea what's wrong with apply_to_page_range on ppc.
Don't have any ppc to test and no debugging experience there.
Unless ppc experts chime in there only option to ignore or disable.

