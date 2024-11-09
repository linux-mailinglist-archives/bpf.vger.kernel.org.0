Return-Path: <bpf+bounces-44435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E909C2F72
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 21:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9E41F21746
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89C61A00F2;
	Sat,  9 Nov 2024 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd5BbGK5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E5A1990C9
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731183259; cv=none; b=noyMwafnK4Ti3caW1qv04OE7aETebp0eDRZUIFSglIUayKHzo2zweUCf25jmMIXbRlm+G4WJsi+SUtWkozc6gX4/HrnWHE8rFguW75IJ4qQCGk0Sf/qqNUVoDR+fCAXV2DY4HV4ONsT7iGR6YEP+ny3vN4GRBuzAJQ7Y1F9sISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731183259; c=relaxed/simple;
	bh=7G74V9elcsbcTHS+u+0lcV6viTfz91WQ99HOiaoFO4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2Y4EujkwCPTPbjHcYDp+S9FBbN4rj8NH/8gJEXMJXWisFRW826VtA6eqM2A+tJdrgVaotxboTwUGgVTdBPZOqZ8YgIcIn003GGRdiWy/jGmlLGLzxHSweximE7sCBF1c/0g13OCCWstpM+CIuHic+Ssq+dhg0WYDLF5LM6ZBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd5BbGK5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so2132411f8f.2
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 12:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731183256; x=1731788056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFtHX//dQ/IUpGmUx3poTvgY9D0xgnFa7XVX0FZwoT8=;
        b=Hd5BbGK59lUKFBEXv4tIr956N66scFJStKWz9wZY4k3Qm21Bz3uAX7PlHLBJRLcCT1
         YsbXp6ff33M0szdQkrlnzGjA8qbZnts9cgUj9rNA1Eb50fNMg2QjLfJFg1SrzlFQ6Zmi
         arRvDci/pammZ9xOPlyzyJ6Auov2NDJq2TXVnSvvA5CYfvodShOtHoYQj0W0PVmd5vF8
         aGyE3Rn0TOjrDXYSrYeY6oxRJ9okvymlsyNG/9M0O17/fmYWDxHtqHKKxffb0gIZkObx
         hk8BEQfMyY/kt6ooqD6oELG8xOaFBvUMZBmG9/i3Xp1MTlQmqhbCKHaGv9e1eUmaeGK9
         wyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731183256; x=1731788056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFtHX//dQ/IUpGmUx3poTvgY9D0xgnFa7XVX0FZwoT8=;
        b=E49F38riSUSNW0U+tYO7Y+cIvBXrnYedUAMjjrkUVYLoUMvRmM14KQInfaLAKUcr16
         q0chc+tDQhQQtXBKV0REMHJ8JBp9Ojf/ByRr/gODbViJZJwBjFPkAWbk65T63EU01Go+
         zNHDLuBhTRtAw7TyhWVRND0cenBMI0/cpB+vOOq7u5fo5X8iEZp8C7jg5K6eZjgyOHtq
         ivXNIpmZfZ3QcN9cCMjg63X3q0Fd1kYo3HpTjTvbHYkTepsmYbcVzOu2ocbTVJgFThS+
         A8yX9YTGd8fQJu94q3Zqh8k9JBnQNA4AdTFKFwIW6KquzD4PO2Ta8E4BZcKghmWvrpNd
         YShw==
X-Gm-Message-State: AOJu0YxdJzq+I6dY3Dhy8TdlwRnpljS+obTQyRJWbTQd+BGJ/OK61lkF
	5ZHU23p1tcqWCTkVnNyfUku4eaxBdqFkyUKpjbiaDE91cue9th7P83Cm5hZa2mAGFCnUXVl/eEw
	LVFmVzBPi7BfMdNBLAUUg6Xztijw=
X-Google-Smtp-Source: AGHT+IFe6rx7/d1pqD0J9WLQw4dAQX7K4wsR1gC/6r0PLYpTIjtkaZeylPtVL5Oddi9VlMuHAjVNTlZ1S77/YKopJ1c=
X-Received: by 2002:a5d:5849:0:b0:37c:d57d:71cd with SMTP id
 ffacd0b85a97d-381f188c777mr5767367f8f.52.1731183255578; Sat, 09 Nov 2024
 12:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109025312.148539-1-yonghong.song@linux.dev> <20241109025332.150019-1-yonghong.song@linux.dev>
In-Reply-To: <20241109025332.150019-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Nov 2024 12:14:04 -0800
Message-ID: <CAADnVQJ4OiJbVMU-xrQhokPoECh4v4fWf-N-0YMx0k=h12f8EQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 4/7] bpf, x86: Support private stack in jit
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>         stack_depth =3D bpf_prog->aux->stack_depth;
> +       if (bpf_prog->aux->priv_stack_ptr) {
> +               priv_frame_ptr =3D bpf_prog->aux->priv_stack_ptr + round_=
up(stack_depth, 16);
> +               stack_depth =3D 0;
> +       }

...

> +       priv_stack_ptr =3D prog->aux->priv_stack_ptr;
> +       if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
> +               priv_stack_ptr =3D __alloc_percpu_gfp(prog->aux->stack_de=
pth, 16, GFP_KERNEL);

After applying I started to see crashes running test_progs -j like:

[  173.465191] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000af9: 0000 [#1] PREEMPT SMP KASAN
[  173.466053] KASAN: probably user-memory-access in range
[0x00000000000057c8-0x00000000000057cf]
[  173.466053] RIP: 0010:dst_dev_put+0x1e/0x220
[  173.466053] Call Trace:
[  173.466053]  <IRQ>
[  173.466053]  ? die_addr+0x40/0xa0
[  173.466053]  ? exc_general_protection+0x138/0x1f0
[  173.466053]  ? asm_exc_general_protection+0x26/0x30
[  173.466053]  ? dst_dev_put+0x1e/0x220
[  173.466053]  rt_fibinfo_free_cpus.part.0+0x8c/0x130
[  173.466053]  fib_nh_common_release+0xd6/0x2a0
[  173.466053]  free_fib_info_rcu+0x129/0x360
[  173.466053]  ? rcu_core+0xa55/0x1340
[  173.466053]  rcu_core+0xa55/0x1340
[  173.466053]  ? rcutree_report_cpu_dead+0x380/0x380
[  173.466053]  ? hrtimer_interrupt+0x319/0x7c0
[  173.466053]  handle_softirqs+0x14c/0x4d0

[   35.134115] Oops: general protection fault, probably for
non-canonical address 0xe0000bfff101fbbc: 0000 [#1] PREEMPT SMP KASAN
[   35.135089] KASAN: probably user-memory-access in range
[0x00007fff880fdde0-0x00007fff880fdde7]
[   35.135089] RIP: 0010:destroy_workqueue+0x4b4/0xa70
[   35.135089] Call Trace:
[   35.135089]  <TASK>
[   35.135089]  ? die_addr+0x40/0xa0
[   35.135089]  ? exc_general_protection+0x138/0x1f0
[   35.135089]  ? asm_exc_general_protection+0x26/0x30
[   35.135089]  ? destroy_workqueue+0x4b4/0xa70
[   35.135089]  ? destroy_workqueue+0x592/0xa70
[   35.135089]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
[   35.135089]  ext4_put_super+0xff/0xd70
[   35.135089]  generic_shutdown_super+0x148/0x4c0
[   35.135089]  kill_block_super+0x3b/0x90
[   35.135089]  ext4_kill_sb+0x65/0x90

I think I see the bug... quoted it above...

Please make sure you reproduce it first.

Then let's figure out a way how to test for such things and
what we can do to make kasan detect it sooner,
since above crashes have no indication at all that bpf priv stack
is responsible.
If there is another bug in priv stack and it will cause future
crashes we need to make sure that priv stack corruption is
detected by kasan (or whatever mechanism) earlier.

We cannot land private stack support when there is
a possibility of such silent corruption.

pw-bot: cr

