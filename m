Return-Path: <bpf+bounces-44094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393929BDBCD
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 03:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469DEB2323E
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 02:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EBE18FC85;
	Wed,  6 Nov 2024 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj5LJTDd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0518E025;
	Wed,  6 Nov 2024 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858854; cv=none; b=kNTtZAP5mbS/CWjS0hIcrhGcyflTc5L2DdJUN1PawYaHz09cVhrZgfpY0lo0JPQfNdC3DAmX9FidS59TAwVAo5S2nMFoQIsU5s+Vs9hYYmKMW4lUJsNqIrLgcLIk/6XcFJX1hs8uew2pwUfW8d3FFSWDS/jGYNEyzfjZUOgwqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858854; c=relaxed/simple;
	bh=fu2K2J5rHgApVZ6IuXl1Xc4gFwZowV8l8RlH0okoPE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWC8E6YBnPJJB4hrTKrVS2MQwSAOkeGAI5a6iysXOLQvwp/NM08nOGRWtSzKSJsYlH2NFgsekOUfqs7FvW7gvCwJk0oIezm/pf9mKUaomLHst2Ffn6d6CQE723/dPMy7s/jsAqDaVk2u0uYrAVjvNLQztGVLaGofrxlri5LaSK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj5LJTDd; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eab7622b61so4704249a12.1;
        Tue, 05 Nov 2024 18:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730858852; x=1731463652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEZQzg0UaUfDatvDkIMoyh2lAfrguhARAalz2WwkTCM=;
        b=mj5LJTDd1OpE6/MzNLeuigKxgPx8H2SqaGR2xMqqHDn2tGraRnftgywGdCypKW8zQR
         LDYrQtx8ajeKeyrSH+DsKM2ONX9GzkHSyz0H286zY8IAuITDlyAZrueBqeImTTIyeYec
         Efj5fL0GOtV7ZTCRE5XFLzTGz0A/fdNAXZS9kt4El1JxghMQ4yJ9+VfAK8wJ1zKpmjMc
         nXOLA9Y7JdokuoCIlHFnya41UKyAo7BCC1IaU2k3UMmXm+MKK1n6Ta9PxftAO23rs/1O
         RKkAYabaNf/mfUktb3Vgd2eCY638jfRmRdhTyjxM7xosGWv5GGxAPUXY1XUnhIFtWzaH
         26Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730858852; x=1731463652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEZQzg0UaUfDatvDkIMoyh2lAfrguhARAalz2WwkTCM=;
        b=ghDhajtsdbZWZXZfRtb2/53y6A5LNwpK6E0/fx9EXvYdHJcVWZWT7YJ+jn+fW/ToMn
         /34x2V/LT97mMPD0xmSEXj3XGHQ7xL9MdV3MmJXEjCWdbK8aV0ATbNimU2ogeASsCcGy
         jAJzqPLVebyY1MuvW+dnRZsIzFdET2wPuU3P9ts75hpjznwqe+OcRfIUONNSB7k3wH0b
         E9pB/FtEcJ3HMD1lPESuJtlesbmAjkDvJ2RFKrAEe1P4n9ZMWj0XfOpeHnCJN8esfFq5
         l8ah1Z/PbPVfiWw2UyKKlcsdmiEtN82dm/Y8UVeh11mhJWoA4mWhrzPaOr5xAngiQQg4
         IORw==
X-Forwarded-Encrypted: i=1; AJvYcCUWvP0r4ivWR7978E5m4kadubCMnsJRjmsN27p/Yc65EDKpLVPuvvf4Lqav5fEQqzsKtys=@vger.kernel.org, AJvYcCVY9Qyl9O+LVUoP5WYLqJR8gJMVl6469C2H96fTV5VLUO3/P9iE7gZ7EzPAMyXjnZRaI52DA9zne1WKgBNIpc7EkXL0@vger.kernel.org, AJvYcCWUjmetF4Wi5axssYtuNJBJ4s9ojbAl559tJqQuqM9p8PfsuMU8VWGR/CMZE2QxJ6w2t3ezBjUQXBGyOk7B@vger.kernel.org, AJvYcCWo7aBE+scK7DIXFyuRNzxfJ42ZhsX2XUZGVqK06OejlK3Fyem7beXJoBmuTN9H7SDA7Nt5pzg495eZwqAivE/oTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTT7MSx+G2Cvd86Wj+H67n+qsLlrSPg6/Fifpc/AeYhujilz9
	9EKOLtrGP8d48vdlbIlkXiVh7JhKwcVvv2EF2YXPYZ8UFiJWmyaCHtLfApMELOUeCAZW1apEAbV
	pS6J481mainIr3BMpxlvrOfSniQU=
X-Google-Smtp-Source: AGHT+IGf6cecvpPPwt40Fr7/mQdBfbv0ZUtK5KbtNBTMVED5Ser/x0pjX5l9bwPm/cN6/sSQmh5ITQJI1u9MxLUtbwM=
X-Received: by 2002:a17:90a:d14f:b0:2e2:bb32:73eb with SMTP id
 98e67ed59e1d1-2e8f10a72a3mr42510576a91.31.1730858852564; Tue, 05 Nov 2024
 18:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022073141.3291245-1-liaochang1@huawei.com>
In-Reply-To: <20241022073141.3291245-1-liaochang1@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Nov 2024 18:07:20 -0800
Message-ID: <CAEf4BzY-0Eu27jyT_s2kRO1UuUPOkE9_SRrBOqu2gJfmxsv+3A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] uprobes: Improve scalability by reducing the
 contention on siglock
To: Liao Chang <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:42=E2=80=AFAM Liao Chang <liaochang1@huawei.com>=
 wrote:
>
> The profiling result of BPF selftest on ARM64 platform reveals the
> significant contention on the current->sighand->siglock is the
> scalability bottleneck. The reason is also very straightforward that all
> producer threads of benchmark have to contend the spinlock mentioned to
> resume the TIF_SIGPENDING bit in thread_info that might be removed in
> uprobe_deny_signal().
>
> The contention on current->sighand->siglock is unnecessary, this series
> remove them thoroughly. I've use the script developed by Andrii in [1]
> to run benchmark. The CPU used was Kunpeng916 (Hi1616), 4 NUMA nodes,
> 64 cores@2.4GHz running the kernel on next tree + the optimization in
> [2] for get_xol_insn_slot().
>
> before-opt
> ----------
> uprobe-nop      ( 1 cpus):    0.907 =C2=B1 0.003M/s  (  0.907M/s/cpu)
> uprobe-nop      ( 2 cpus):    1.676 =C2=B1 0.008M/s  (  0.838M/s/cpu)
> uprobe-nop      ( 4 cpus):    3.210 =C2=B1 0.003M/s  (  0.802M/s/cpu)
> uprobe-nop      ( 8 cpus):    4.457 =C2=B1 0.003M/s  (  0.557M/s/cpu)
> uprobe-nop      (16 cpus):    3.724 =C2=B1 0.011M/s  (  0.233M/s/cpu)
> uprobe-nop      (32 cpus):    2.761 =C2=B1 0.003M/s  (  0.086M/s/cpu)
> uprobe-nop      (64 cpus):    1.293 =C2=B1 0.015M/s  (  0.020M/s/cpu)
>
> uprobe-push     ( 1 cpus):    0.883 =C2=B1 0.001M/s  (  0.883M/s/cpu)
> uprobe-push     ( 2 cpus):    1.642 =C2=B1 0.005M/s  (  0.821M/s/cpu)
> uprobe-push     ( 4 cpus):    3.086 =C2=B1 0.002M/s  (  0.771M/s/cpu)
> uprobe-push     ( 8 cpus):    3.390 =C2=B1 0.003M/s  (  0.424M/s/cpu)
> uprobe-push     (16 cpus):    2.652 =C2=B1 0.005M/s  (  0.166M/s/cpu)
> uprobe-push     (32 cpus):    2.713 =C2=B1 0.005M/s  (  0.085M/s/cpu)
> uprobe-push     (64 cpus):    1.313 =C2=B1 0.009M/s  (  0.021M/s/cpu)
>
> uprobe-ret      ( 1 cpus):    1.774 =C2=B1 0.000M/s  (  1.774M/s/cpu)
> uprobe-ret      ( 2 cpus):    3.350 =C2=B1 0.001M/s  (  1.675M/s/cpu)
> uprobe-ret      ( 4 cpus):    6.604 =C2=B1 0.000M/s  (  1.651M/s/cpu)
> uprobe-ret      ( 8 cpus):    6.706 =C2=B1 0.005M/s  (  0.838M/s/cpu)
> uprobe-ret      (16 cpus):    5.231 =C2=B1 0.001M/s  (  0.327M/s/cpu)
> uprobe-ret      (32 cpus):    5.743 =C2=B1 0.003M/s  (  0.179M/s/cpu)
> uprobe-ret      (64 cpus):    4.726 =C2=B1 0.016M/s  (  0.074M/s/cpu)
>
> after-opt
> ---------
> uprobe-nop      ( 1 cpus):    0.985 =C2=B1 0.002M/s  (  0.985M/s/cpu)
> uprobe-nop      ( 2 cpus):    1.773 =C2=B1 0.005M/s  (  0.887M/s/cpu)
> uprobe-nop      ( 4 cpus):    3.304 =C2=B1 0.001M/s  (  0.826M/s/cpu)
> uprobe-nop      ( 8 cpus):    5.328 =C2=B1 0.002M/s  (  0.666M/s/cpu)
> uprobe-nop      (16 cpus):    6.475 =C2=B1 0.002M/s  (  0.405M/s/cpu)
> uprobe-nop      (32 cpus):    4.831 =C2=B1 0.082M/s  (  0.151M/s/cpu)
> uprobe-nop      (64 cpus):    2.564 =C2=B1 0.053M/s  (  0.040M/s/cpu)
>
> uprobe-push     ( 1 cpus):    0.964 =C2=B1 0.001M/s  (  0.964M/s/cpu)
> uprobe-push     ( 2 cpus):    1.766 =C2=B1 0.002M/s  (  0.883M/s/cpu)
> uprobe-push     ( 4 cpus):    3.290 =C2=B1 0.009M/s  (  0.823M/s/cpu)
> uprobe-push     ( 8 cpus):    4.670 =C2=B1 0.002M/s  (  0.584M/s/cpu)
> uprobe-push     (16 cpus):    5.197 =C2=B1 0.004M/s  (  0.325M/s/cpu)
> uprobe-push     (32 cpus):    5.068 =C2=B1 0.161M/s  (  0.158M/s/cpu)
> uprobe-push     (64 cpus):    2.605 =C2=B1 0.026M/s  (  0.041M/s/cpu)
>
> uprobe-ret      ( 1 cpus):    1.833 =C2=B1 0.001M/s  (  1.833M/s/cpu)
> uprobe-ret      ( 2 cpus):    3.384 =C2=B1 0.003M/s  (  1.692M/s/cpu)
> uprobe-ret      ( 4 cpus):    6.677 =C2=B1 0.004M/s  (  1.669M/s/cpu)
> uprobe-ret      ( 8 cpus):    6.854 =C2=B1 0.005M/s  (  0.857M/s/cpu)
> uprobe-ret      (16 cpus):    6.508 =C2=B1 0.006M/s  (  0.407M/s/cpu)
> uprobe-ret      (32 cpus):    5.793 =C2=B1 0.009M/s  (  0.181M/s/cpu)
> uprobe-ret      (64 cpus):    4.743 =C2=B1 0.016M/s  (  0.074M/s/cpu)
>
> Above benchmark results demonstrates a obivious improvement in the
> scalability of trig-uprobe-nop and trig-uprobe-push, the peak throughput
> of which are from 4.5M/s to 6.4M/s and 3.3M/s to 5.1M/s individually.
>
> v4->v3:
> 1. Rebase v3 [3] to the lateset tip/perf/core.
> 2. Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 3. Acked-by: Oleg Nesterov <oleg@redhat.com>
>
> v3->v2:
> Renaming the flag in [2/2], s/deny_signal/signal_denied/g.
>
> v2->v1:
> Oleg pointed out the _DENY_SIGNAL will be replaced by _ACK upon the
> completion of singlestep which leads to handle_singlestep() has no
> chance to restore the removed TIF_SIGPENDING [3] and some case in
> question. So this revision proposes to use a flag in uprobe_task to
> track the denied TIF_SIGPENDING instead of new UPROBE_SSTEP state.
>
> [1] https://lore.kernel.org/all/20240731214256.3588718-1-andrii@kernel.or=
g
> [2] https://lore.kernel.org/all/20240727094405.1362496-1-liaochang1@huawe=
i.com
> [3] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@huawe=
i.com/
>
> Liao Chang (2):
>   uprobes: Remove redundant spinlock in uprobe_deny_signal()
>   uprobes: Remove the spinlock within handle_singlestep()
>
>  include/linux/uprobes.h |  1 +
>  kernel/events/uprobes.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> --
> 2.34.1
>

This patch set has been ready for a long while, can we please apply it
to perf/core as well? Thank you!

