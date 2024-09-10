Return-Path: <bpf+bounces-39533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DCD97445B
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 22:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB1C1F2297D
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229101AAE0B;
	Tue, 10 Sep 2024 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8oRt6JA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F91A7076;
	Tue, 10 Sep 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001656; cv=none; b=Whk7RqMJjukO1NGPcTYUSIq9o8um92g9IVKCNYPxuR6mu47jmRLt4dzGVuVx14DtF5YCoNW2iEpbDcM/MQw7B9KSD1B2XhxsiLBXQLZNdnjfiSvCTTo/hHanjc3xThFbMOitkQfQEPmIiNWQgfJ/JTR05Hd9Ksb0+qV0hij/uW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001656; c=relaxed/simple;
	bh=FoE0BbGu9jYnpxKVV1kYsj9vzLeA9lwXBxv/oR3XHmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSDAGDFglI77UPwTOyeYLhOpYkWWdwAl1EmYk6FoPPhWvUtsJw7HyT9QffxOZJhzmJ1AgSA8dbKBLVKj0VVS+TVal/Zd3IXgGIBJJWa8eVcgz1pfJN2QjiCApYt9LnhG/a+/QaypHiOM0ls/WF2WyoG7GQ1hHYUo5Lry9HzkiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8oRt6JA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso3865519a91.1;
        Tue, 10 Sep 2024 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726001654; x=1726606454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR6TleHbOsdTsdP/ABsy/+JWZtjaatWU+1TzUIHX4ro=;
        b=a8oRt6JA06bt2In2+NNIVz9ugZsP6eyUeiAu8jAZgrf1GQSCCt1b2Id8IsSASW4HLd
         ozo+BFRW6tgFsIIp5kHvUGAuzVCmTojc6FMRhzed79pHcqAwPdEzfZ2U+oW1+z7Nv2KR
         mKshg5mcr3Ry3s4W49aLvKEqb3REmter34TSV5gnxUtXq9dOYXxsXN83M1aHl4Hl6vJq
         lhkGPkvcJRinD6Zz5UddYBYobYWg3Kethm3VDxzR/1QGsv5PaHCP4gy8frQkVwe0XrC7
         KGDIW9Mfzo5maiK8QF/HB/aB6fTnfAn+krxKpQNcz5pd92+E/RaCM9VnImMS2ymozgyf
         oTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726001654; x=1726606454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR6TleHbOsdTsdP/ABsy/+JWZtjaatWU+1TzUIHX4ro=;
        b=DO+pgreb5HGYWTCUFlZzeCz69oVTfyFT5OJ6nCS/ETRLpopmtLyPDUz1IpUOLcSGqu
         CuwRgnLuhF59TfQeTr9Ty4qlH3NWS9w/1DAhniLQl++3TvBd0UvyJFYQwy0jfdxMR0bL
         mqQ+AAkuSZMnXpgwE6fDIHkB5+8NWqzXVjzOQUrncM9xkjsKNgVxoMjIXVDFynKI7jRC
         UTo0jTxSdoyWwS7CKSW0i2PNq9TPnrQ3W8H52lnfqCy8ylLFMDT4J/5xZYEhlDv1mydN
         wOwpQ5VoeMdXnK3T/RYklYKPd9mcYSzl3UTZyjRR1VIzODJQb68ycBMxUf9jvj8M4Igr
         4iJw==
X-Forwarded-Encrypted: i=1; AJvYcCUnfloYK4+e6QfpFu74rWZVHcm5D7/Ba4KlSwmmRkjPXJg9fIapkS4QfBojxRpc962pML0=@vger.kernel.org, AJvYcCUrGL37hjENeMTQZtMka2vZM+kYI0Mtdpo2jI/Bv75YQkVe7Isra5IiifYC+1xrzMN10lV+MUG70yvwTol3@vger.kernel.org, AJvYcCXiKqIUwN82B148+CDUnzODaY1W1GbLds1ZqynxniEXiEY2IsHE0wrhXXtPJ7xgTG6O4v8L5XRH8903XgLTwhiitBua@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44rnM0B8vZWbCeka/7tAc1YJ9m/oPprwbC9Je8C0tiC/ZG8Q8
	SeHiwG9hVX29tZiUjHYud+NyRan6NWqcB71nKT/+C+R8P8PJHu0fC6NN0KhWwMEh7ai4E8cZ0UE
	kTzJwyMjaJNpR4nj26khMx1u8I84=
X-Google-Smtp-Source: AGHT+IHekojY/Q8DdJSguWn/mqLAZjMjbi8qqdv/HgY6+tPFr7cVSIoGgLTZraZmameLouJc1Aw+jO7IXlbRLvu0gxo=
X-Received: by 2002:a17:90a:db93:b0:2d8:8ce3:1e9d with SMTP id
 98e67ed59e1d1-2dad4de4cbdmr13592925a91.3.1726001654477; Tue, 10 Sep 2024
 13:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910060407.1427716-1-liaochang1@huawei.com>
In-Reply-To: <20240910060407.1427716-1-liaochang1@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 13:54:00 -0700
Message-ID: <CAEf4BzZ3trjMWjvWX4Zy1GzW5RN1ihXZSnLZax7V-mCzAUg2cg@mail.gmail.com>
Subject: Re: [PATCH] arm64: uprobes: Simulate STP for pushing fp/lr into user stack
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org, 
	oleg@redhat.com, peterz@infradead.org, ast@kernel.org, puranjay@kernel.org, 
	andrii@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:14=E2=80=AFPM Liao Chang <liaochang1@huawei.com> =
wrote:
>
> This patch is the second part of a series to improve the selftest bench
> of uprobe/uretprobe [0]. The lack of simulating 'stp fp, lr, [sp, #imm]'
> significantly impact uprobe/uretprobe performance at function entry in
> most user cases. Profiling results below reveals the STP that executes
> in the xol slot and trap back to kernel, reduce redis RPS and increase
> the time of string grep obviously.
>
> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
>
> Redis GET (higher is better)
> ----------------------------
> No uprobe: 49149.71 RPS
> Single-stepped STP: 46750.82 RPS
> Emulated STP: 48981.19 RPS
>
> Redis SET (larger is better)
> ----------------------------
> No uprobe: 49761.14 RPS
> Single-stepped STP: 45255.01 RPS
> Emulated stp: 48619.21 RPS
>
> Grep (lower is better)
> ----------------------
> No uprobe: 2.165s
> Single-stepped STP: 15.314s
> Emualted STP: 2.216s
>
> Additionally, a profiling of the entry instruction for all leaf and
> non-leaf function, the ratio of 'stp fp, lr, [sp, #imm]' is larger than
> 50%. So simulting the STP on the function entry is a more viable option
> for uprobe.
>
> In the first version [1], it used a uaccess routine to simulate the STP
> that push fp/lr into stack, which use double STTR instructions for
> memory store. But as Mark pointed out, this approach can't simulate the
> correct single-atomicity and ordering properties of STP, especiallly
> when it interacts with MTE, POE, etc. So this patch uses a more complex

Does all those effects matter if the thread is stopped after
breakpoint? This is pushing to stack, right? Other threads are not
supposed to access that memory anyways (not the well-defined ones, at
least, I suppose). Do we really need all these complications for
uprobes? We use a similar approach in x86-64, see emulate_push_stack()
in arch/x86/kernel/uprobes.c and it works great in practice (and has
been for years by now). Would be nice to keep things simple knowing
that this is specifically for this rather well-defined and restricted
uprobe/uretprobe use case.

Sorry, I can't help reviewing this, but I have a hunch that we might
be over-killing it with this approach, no?


> and inefficient approach that acquires user stack pages, maps them to
> kernel address space, and allows kernel to use STP directly push fp/lr
> into the stack pages.
>
> xol-stp
> -------
> uprobe-nop      ( 1 cpus):    1.566 =C2=B1 0.006M/s  (  1.566M/s/cpu)
> uprobe-push     ( 1 cpus):    0.868 =C2=B1 0.001M/s  (  0.868M/s/cpu)
> uprobe-ret      ( 1 cpus):    1.629 =C2=B1 0.001M/s  (  1.629M/s/cpu)
> uretprobe-nop   ( 1 cpus):    0.871 =C2=B1 0.001M/s  (  0.871M/s/cpu)
> uretprobe-push  ( 1 cpus):    0.616 =C2=B1 0.001M/s  (  0.616M/s/cpu)
> uretprobe-ret   ( 1 cpus):    0.878 =C2=B1 0.002M/s  (  0.878M/s/cpu)
>
> simulated-stp
> -------------
> uprobe-nop      ( 1 cpus):    1.544 =C2=B1 0.001M/s  (  1.544M/s/cpu)
> uprobe-push     ( 1 cpus):    1.128 =C2=B1 0.002M/s  (  1.128M/s/cpu)
> uprobe-ret      ( 1 cpus):    1.550 =C2=B1 0.005M/s  (  1.550M/s/cpu)
> uretprobe-nop   ( 1 cpus):    0.872 =C2=B1 0.004M/s  (  0.872M/s/cpu)
> uretprobe-push  ( 1 cpus):    0.714 =C2=B1 0.001M/s  (  0.714M/s/cpu)
> uretprobe-ret   ( 1 cpus):    0.896 =C2=B1 0.001M/s  (  0.896M/s/cpu)
>
> The profiling results based on the upstream kernel with spinlock
> optimization patches [2] reveals the simulation of STP increase the
> uprobe-push throughput by 29.3% (from 0.868M/s/cpu to 1.1238M/s/cpu) and
> uretprobe-push by 15.9% (from 0.616M/s/cpu to 0.714M/s/cpu).
>
> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02e=
zZ5YruVuQw@mail.gmail.com/
> [1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/
> [2] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@huawe=
i.com/
>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/arm64/include/asm/insn.h            |  1 +
>  arch/arm64/kernel/probes/decode-insn.c   | 16 +++++
>  arch/arm64/kernel/probes/decode-insn.h   |  1 +
>  arch/arm64/kernel/probes/simulate-insn.c | 89 ++++++++++++++++++++++++
>  arch/arm64/kernel/probes/simulate-insn.h |  1 +
>  arch/arm64/kernel/probes/uprobes.c       | 21 ++++++
>  arch/arm64/lib/insn.c                    |  5 ++
>  7 files changed, 134 insertions(+)
>

[...]

