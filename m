Return-Path: <bpf+bounces-27174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8153A8AA464
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55131C236A1
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60811836EE;
	Thu, 18 Apr 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtR9RzGZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D8190690
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473565; cv=none; b=Zebd+pEkF3BuX5CI4WO2H/LlpADQPK744SjCP43puQXRhKPF9ym3NtDMu38sPFYLv+so4ymSx8zZUGsq2zOPEcn2kapKy/m2YLHeVi/gjz0Vkpwj3LmiTP9h4tQhyIq6yrJYJgOZonp4lA39njHSCUGNgns88neRybhtVIILnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473565; c=relaxed/simple;
	bh=QxMgcA5Jc7KOm8tpyh/PxEM0P6yl08gBmEgwBk4LShE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1Txn9XWWPoVH+bI5KvuGwvXYpMzSGkKJxTZ2CQErzSibwMUhd4/c+daB0sVKrwJUTWGYyf6Ksixul6QYIv9rT776yh6I5pZCDpENWnIpVK8LIkd7MU1hLyYCJ+w1Dy8DyTDKfcgWjSHgGjTRSZg3DQl3/MWDOo+25wrjf+Z8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtR9RzGZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso1308434b3a.2
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713473563; x=1714078363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PAvTxuWT9yBaZyV8vJnx+BAyfbHYxSCc+lgUXZnTno=;
        b=DtR9RzGZpOrCrhcVnAlQw9TSjWlMCjbD9FBsvXwYFAgCruvIXJduAc7jQkbqgLSlw7
         hTAOt7PYWvL1bx/avwDAYZuFV2BAOEkB+Nk+GU8pxvk9ueKoGCoyFo05U6UC4tLtcsn0
         sHeyRth46d3nFnXJ/iRJbanySpVB5iIdwWhrfLuWJ5/WH/2NkxPIdfwv6PfR8JXugYx1
         R+85IIOjXgFItEP59Vv5Nt84JMHoeL6/F/y9RRGlrFNFyH3ga2yH6a2xUVDk/bIf2l+O
         9Go9eW8Z83NqkF5b1k406R6VUf/2uwZ9HquCSbeaW83bP7iHZJCghQ13A14v2u38PG6c
         POJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473563; x=1714078363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PAvTxuWT9yBaZyV8vJnx+BAyfbHYxSCc+lgUXZnTno=;
        b=otBGri4lxD5DJpUocxCeP0NC8rk1cztPMJ6OX9bnzcgw/hNumVceX0WXZmKov41ws5
         BnyolXO2z/vBaUPvxqQKfsRqgxOXEBrMxqGZJoT7eRsSNYC7mpukj/rwp8hNmasrf4xo
         O88Pf8Ds1w8wzoUsMtBa3uSv5p0jbw7QNK+5SU0h5sQ7rMNvR/aN9goISdPUFy/6yGaT
         i/z+ofzGARTMqplHV02pjgiCfA6h7CA3LMdULlLhfR1c1T/icaINQvAa0anF7YQ73GFB
         J4POn6TCxgrzRMw3gRgUCpNw1/KFZx6AH6TqqhSX/vq//9q0olyQ6iy6hJzlyOoGhJQ3
         lVSg==
X-Forwarded-Encrypted: i=1; AJvYcCVgr8GC0SSdKTGMLi/7TMFo3YJqyc00DBvXlnM1XFxG6Fct4ZKHfSRQv0ZPnZW+cq/xKzxoHBMq1JTz8lSQHIAg2DnL
X-Gm-Message-State: AOJu0YwcsQdTMqvTnjB0qYWq9xBp6aapBTgkGFJf4KQqZGUecJMclFWy
	JKO5QqkmhyQ66Sz7rjhRrzTj8atZFmwV6RdPWlEf3A5cLujjqELjCzpSh02Wp0EJpDHoSaIbfDU
	2Y1lqDmjaoCIA2ZunMFJo/sx+VSc=
X-Google-Smtp-Source: AGHT+IGUGFfNHDC/l5Rhn+yVyzx2DTZ4iqxKAh71Yf/VweU31FJMf/77WvuVddhnG8xvdaRLCF8yXDAGdW2/kSQwATM=
X-Received: by 2002:a05:6a00:989:b0:6ed:21d5:fc2c with SMTP id
 u9-20020a056a00098900b006ed21d5fc2cmr316980pfg.26.1713473562578; Thu, 18 Apr
 2024 13:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319233852.1977493-1-andrii@kernel.org> <20240319233852.1977493-3-andrii@kernel.org>
 <ZhT+N7CHi47zDzjo@xpf.sh.intel.com>
In-Reply-To: <ZhT+N7CHi47zDzjo@xpf.sh.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Apr 2024 13:52:28 -0700
Message-ID: <CAEf4BzYewDYdX+o0tC+f5hcJnxby=+eYsaq_5bEAjVYc96FxLA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: pass whole link instead of prog when
 triggering raw tracepoint
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Stanislav Fomichev <sdf@google.com>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:41=E2=80=AFAM Pengfei Xu <pengfei.xu@intel.com> wr=
ote:
>
> Hi Andrii Nakryiko,
>
> Greeting!
>
> On 2024-03-19 at 16:38:49 -0700, Andrii Nakryiko wrote:
> > Instead of passing prog as an argument to bpf_trace_runX() helpers, tha=
t
> > are called from tracepoint triggering calls, store BPF link itself
> > (struct bpf_raw_tp_link for raw tracepoints). This will allow to pass
> > extra information like BPF cookie into raw tracepoint registration.
> >
> > Instead of replacing `struct bpf_prog *prog =3D __data;` with
> > corresponding `struct bpf_raw_tp_link *link =3D __data;` assignment in
> > `__bpf_trace_##call` I just passed `__data` through into underlying
> > bpf_trace_runX() call. This works well because we implicitly cast `void=
 *`,
> > and it also avoids naming clashes with arguments coming from
> > tracepoint's "proto" list. We could have run into the same problem with
> > "prog", we just happened to not have a tracepoint that has "prog" input
> > argument. We are less lucky with "link", as there are tracepoints using
> > "link" argument name already. So instead of trying to avoid naming
> > conflicts, let's just remove intermediate local variable. It doesn't
> > hurt readibility, it's either way a bit of a maze of calls and macros,
> > that requires careful reading.
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h          |  5 +++++
> >  include/linux/trace_events.h | 36 ++++++++++++++++++++----------------
> >  include/trace/bpf_probe.h    |  3 +--
> >  kernel/bpf/syscall.c         |  9 ++-------
> >  kernel/trace/bpf_trace.c     | 18 ++++++++++--------
> >  5 files changed, 38 insertions(+), 33 deletions(-)
> >
>
> I used syzkaller and test intel internal kernel and found "KASAN:
> slab-use-after-free Read in bpf_trace_run4" problem.
>
> Bisected and found related commit:
> d4dfc5700e86 bpf: pass whole link instead of prog when triggering raw tra=
cepoint

I think [0] is fixing this problem, it landed into bpf tree

  [0] https://lore.kernel.org/all/20240328052426.3042617-2-andrii@kernel.or=
g/

>
> Checked that the commit above is the same as this commit.
>
> All detailed info:https://github.com/xupengfe/syzkaller_logs/tree/main/24=
0409_092216_bpf_trace_run4
> Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/mai=
n/240409_092216_bpf_trace_run4/repro.c
> Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs=
/blob/main/240409_092216_bpf_trace_run4/repro.prog
> Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/bl=
ob/main/240409_092216_bpf_trace_run4/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240409_=
092216_bpf_trace_run4/bisect_info.log
> issue_bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240409=
_092216_bpf_trace_run4/bzImage_v6.9-rc2_next.tar.gz
> issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240409_=
092216_bpf_trace_run4/5d8569db0cb982d3c630482c285578e98a75fc90_dmesg.log
>
> "
> [   24.977435] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   24.978307] BUG: KASAN: slab-use-after-free in bpf_trace_run4+0x547/0x=
5e0
> [   24.979138] Read of size 8 at addr ffff888015676218 by task rcu_preemp=
t/16
> [   24.979936]
> [   24.980152] CPU: 0 PID: 16 Comm: rcu_preempt Not tainted 6.9.0-rc2-5d8=
569db0cb9+ #1
> [   24.981040] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   24.982352] Call Trace:
> [   24.982672]  <TASK>
> [   24.982952]  dump_stack_lvl+0xe9/0x150
> [   24.983449]  print_report+0xd0/0x610
> [   24.983904]  ? bpf_trace_run4+0x547/0x5e0
> [   24.984393]  ? kasan_complete_mode_report_info+0x80/0x200
> [   24.985039]  ? bpf_trace_run4+0x547/0x5e0
> [   24.985528]  kasan_report+0x9f/0xe0
> [   24.985961]  ? bpf_trace_run4+0x547/0x5e0
> [   24.986457]  __asan_report_load8_noabort+0x18/0x20
> [   24.987055]  bpf_trace_run4+0x547/0x5e0
> [   24.987532]  ? __pfx_bpf_trace_run4+0x10/0x10
> [   24.988061]  ? __this_cpu_preempt_check+0x20/0x30
> [   24.988670]  ? lock_is_held_type+0xe5/0x140
> [   24.989185]  ? set_next_entity+0x38c/0x630
> [   24.989698]  ? put_prev_entity+0x50/0x1f0
> [   24.990199]  __bpf_trace_sched_switch+0x14/0x20
> [   24.990776]  __traceiter_sched_switch+0x7a/0xd0
> [   24.991293]  __schedule+0xc6d/0x2840
> [   24.991721]  ? __pfx___schedule+0x10/0x10
> [   24.992170]  ? lock_release+0x3f6/0x790
> [   24.992616]  ? __this_cpu_preempt_check+0x20/0x30
> [   24.993140]  ? schedule+0x1f3/0x290
> [   24.993536]  ? __pfx_lock_release+0x10/0x10
> [   24.994003]  ? _raw_spin_unlock_irqrestore+0x39/0x70
> [   24.994561]  ? schedule_timeout+0x559/0x940
> [   24.995021]  ? __this_cpu_preempt_check+0x20/0x30
> [   24.995548]  schedule+0xcf/0x290
> [   24.995922]  schedule_timeout+0x55e/0x940
> [   24.996369]  ? __pfx_schedule_timeout+0x10/0x10
> [   24.996870]  ? prepare_to_swait_event+0xff/0x450
> [   24.997401]  ? prepare_to_swait_event+0xc4/0x450
> [   24.997916]  ? __this_cpu_preempt_check+0x20/0x30
> [   24.998445]  ? __pfx_process_timeout+0x10/0x10
> [   24.998971]  ? tcp_get_idx+0xd0/0x270
> [   24.999408]  ? prepare_to_swait_event+0xff/0x450
> [   24.999934]  rcu_gp_fqs_loop+0x661/0xa70
> [   25.000399]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
> [   25.000913]  ? __pfx_rcu_gp_init+0x10/0x10
> [   25.001381]  rcu_gp_kthread+0x25e/0x360
> [   25.001822]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   25.002324]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [   25.002966]  ? __kthread_parkme+0x146/0x220
> [   25.003472]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   25.003995]  kthread+0x354/0x470
> [   25.004400]  ? __pfx_kthread+0x10/0x10
> [   25.004862]  ret_from_fork+0x57/0x90
> [   25.005315]  ? __pfx_kthread+0x10/0x10
> [   25.005778]  ret_from_fork_asm+0x1a/0x30
> [   25.006282]  </TASK>
> [   25.006560]
> [   25.006773] Allocated by task 732:
> [   25.007187]  kasan_save_stack+0x2a/0x50
> [   25.007660]  kasan_save_track+0x18/0x40
> [   25.008124]  kasan_save_alloc_info+0x3b/0x50
> [   25.008649]  __kasan_kmalloc+0x86/0xa0
> [   25.009107]  kmalloc_trace+0x1c5/0x3d0
> [   25.009599]  bpf_raw_tp_link_attach+0x28e/0x5a0
> [   25.010163]  __sys_bpf+0x452/0x5550
> [   25.010599]  __x64_sys_bpf+0x7e/0xc0
> [   25.011054]  do_syscall_64+0x73/0x150
> [   25.011523]  entry_SYSCALL_64_after_hwframe+0x71/0x79
> [   25.012156]
> [   25.012360] Freed by task 732:
> [   25.012740]  kasan_save_stack+0x2a/0x50
> [   25.013211]  kasan_save_track+0x18/0x40
> [   25.013689]  kasan_save_free_info+0x3e/0x60
> [   25.014198]  __kasan_slab_free+0x107/0x190
> [   25.014694]  kfree+0xf3/0x320
> [   25.015085]  bpf_raw_tp_link_dealloc+0x1e/0x30
> [   25.015632]  bpf_link_free+0x145/0x1b0
> [   25.016094]  bpf_link_put_direct+0x45/0x60
> [   25.016593]  bpf_link_release+0x40/0x50
> [   25.017064]  __fput+0x273/0xb70
> [   25.017489]  ____fput+0x1e/0x30
> [   25.017890]  task_work_run+0x1a3/0x2d0
> [   25.018356]  do_exit+0xad3/0x31b0
> [   25.018800]  do_group_exit+0xdf/0x2b0
> [   25.019256]  __x64_sys_exit_group+0x47/0x50
> [   25.019763]  do_syscall_64+0x73/0x150
> [   25.020215]  entry_SYSCALL_64_after_hwframe+0x71/0x79
> [   25.020830]
> [   25.021036] The buggy address belongs to the object at ffff88801567620=
0
> [   25.021036]  which belongs to the cache kmalloc-128 of size 128
> [   25.022465] The buggy address is located 24 bytes inside of
> [   25.022465]  freed 128-byte region [ffff888015676200, ffff888015676280=
)
> [   25.023780]
> [   25.023970] The buggy address belongs to the physical page:
> [   25.024563] page: refcount:1 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x15676
> [   25.025401] flags: 0xfffffe0000800(slab|node=3D0|zone=3D1|lastcpupid=
=3D0x3fffff)
> [   25.026140] page_type: 0xffffffff()
> [   25.026535] raw: 000fffffe0000800 ffff88800a0418c0 dead000000000122 00=
00000000000000
> [   25.027363] raw: 0000000000000000 0000000000100010 00000001ffffffff 00=
00000000000000
> [   25.028182] page dumped because: kasan: bad access detected
> [   25.028773]
> [   25.028957] Memory state around the buggy address:
> [   25.029476]  ffff888015676100: fa fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   25.030244]  ffff888015676180: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   25.031018] >ffff888015676200: fa fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   25.031780]                             ^
> [   25.032221]  ffff888015676280: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   25.032992]  ffff888015676300: fa fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   25.033769] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   25.034571] Disabling lock debugging due to kernel taint
> "
>
> Could you take a look is it useful?
>
> Thanks!
>
> ---
>
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one reproduced environment, please ignore the following info=
rmation.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65=
 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,reado=
nly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>
> Fill the bzImage file into above start3.sh to load the target kernel in v=
m.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --e=
nable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
> Best Regards,
> Thanks!
>

[...]

