Return-Path: <bpf+bounces-58071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E224CAB4816
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 02:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A8D465353
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D211C268FC8;
	Tue, 13 May 2025 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcmgrWyh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345F258CE4;
	Mon, 12 May 2025 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094400; cv=none; b=oOq7Y3tyBWfoqb73bKMMlm9xktZENSmKJv3+MGUfeRbaoV2P9dGbLYj8NA3siVIyWbKpfqNzl5ezcTusUHbBofDQbecC2k1G+wMa6U0Acl/F0Mmd9wWb9GZh89UBww39nL12vkwn2PTBsHtFKJRoYqtEh0mv+S32ASqT6NrXU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094400; c=relaxed/simple;
	bh=2J/em8HLtQvc9E3150hVUwCcvJnp4okY6FX7p2Q6hbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUIXeCmKL6Ay4Ym/9i+jZAO59QIzWmyEkmfnAEVwnv85DdhZ+2YExEuj1vGm2lld/BZ0PqhnHwOuQgfw01NyGbZ1EHOo4rvHx/CIm2xpUamoOa7Jda/Nf3AD79sVBFhhIyo1hsRF8PHNPeXZy+LvrfSewIZeJyo7zAjFiwzK6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcmgrWyh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso53684195e9.0;
        Mon, 12 May 2025 16:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094397; x=1747699197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqkHrkvohXoeATOZwyroosrjMBKBmZpV7oFref0aHQE=;
        b=XcmgrWyhUnQzffwxalDBryr56+2TklbbjyEnN012qKhLEF7tVcagn5j46njXAUOcf3
         whHUkYodcLJ49Ad9/AZi8jSCv7IcNQvU09yIswkAuHAt/sxerPottZTyMYl0fJ4k85TY
         7Q0s11x/8ry4FRc4BsgjR9LXs1h34w1B+ZGXYlBo3pKjHAzy3NA/7GmWWqC+bf3SeGeY
         mWIN3YJv6+t4KkZy9DnFsGWy6EMw3GHwsg3JU0LvO4PgpjTly8yC6YzL1d4IIwpmedhQ
         go9XNGD/NKXnHnKEkZe4QMvHtNPExlRoQHqD28NBqNTEKQjD5ZQK1AiMeuRd6nwj1kSB
         Z/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094397; x=1747699197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqkHrkvohXoeATOZwyroosrjMBKBmZpV7oFref0aHQE=;
        b=CDLMyF2Qm3iSgD6EzlndPhNlkjktAnJ7/rSxN/WcSyoxQiJ9KJLOiv26yeXQJGSGmh
         FVHbEsbA1XrdSjWgOjPgcbNTuNKQjWNSOiYSGN4MFIBGJn++agM3LUTB/zORCHIEJ8lK
         WoI6FF6hg0H6XLp6CTkQpqqGBNBHKftxYSFf2h8uMWvObs7JbKPtWl/ZrnY/ySI/+vL9
         LN2ERMmgdxTFe3bAS3MdvzWSQeNkOBYiP+OmKa2PWjAprBPxbScXs30X72xZUQG3KEAe
         gn6t0IL1caoWl8N3cRHgYTK4JQZjINm36TKsZ/UquWJu5ziN9Wjy6Dl3oWmTitdK85ai
         QlyA==
X-Forwarded-Encrypted: i=1; AJvYcCUVkupJ4a2qNwqw2hSQMQVPkVpAIBOtNMxJP+ZKr2raxPIGi0i1t2Jpptz1bN1+RWs7cnutDf//xnsbIWjb@vger.kernel.org, AJvYcCXZBNkTXgNWeTpD+8R8UJRFD1n4YJNV2Q2x+uJ0/VgkXlvVoadxT17yBrmHl9wuGvXvxfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxed1+SfcbNc0jdTVvDijWZD/NFqsBYoHKAt2hq11UlB1RnZCWz
	xuNHXbisUZdXrKBKfQm9uX3iJhe5G9ySRP0OadG92UhIWSo/1TB0W6iJ5YKQzd8/aOSjkB2dM/9
	BSaeHPy32jTwAbjSWsMrF8Z6q0VY=
X-Gm-Gg: ASbGnctNRmjz4HpFHyyRW2GBxKZ2PWUIF+oeVF+m8L5oDZXbvJOdZxqo8xVPRSx/+4a
	roJ3UAURuzwgctpZysuc0W/0bK6X/+9AY8Zb5v3flfVg1P/Wayn2SSwRvk8dKQICRvbVO5HOFIG
	mIJ1c26SR+uzMUlI4FAKYT+WhxGzjc7+gK3ilwlyfNC7v51SWo50xRunTbnyZy8w==
X-Google-Smtp-Source: AGHT+IHUc1cjGA+9WC0p4KmY9aXJ3wnQCknBGLCj1rhOfrN+pLJVHyAGYd9lc567X5ES9Kd6yqHQcFQDOFI71pZEHXU=
X-Received: by 2002:a05:6000:1ac6:b0:39e:dbee:f644 with SMTP id
 ffacd0b85a97d-3a1f64b5a71mr11441819f8f.46.1747094396479; Mon, 12 May 2025
 16:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512145901.691685-1-chen.dylane@linux.dev>
In-Reply-To: <20250512145901.691685-1-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 16:59:45 -0700
X-Gm-Features: AX0GCFv2mL6YyRFJjz6uEDOQtpzKiEgSaMHj8gosX_KFjGLuWx8EQHoXsRH7xw4
Message-ID: <CAADnVQJNmS-3gDQ4=GRGzk00S-n9KOs2temi+P-7Nac_gnx5DQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix bpf_prog nested call in trace_mmap_lock_acquire_returned
To: Tao Chen <chen.dylane@linux.dev>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 7:59=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> syzkaller reported an issue:
>
>  bpf_prog_ec3b2eefa702d8d3+0x43/0x47
>  bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>  bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
>  __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/m=
map_lock.h:47
>  __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mm=
ap_lock.h:47
>  __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:4=
7 [inline]
>  trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [in=
line]
>  __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
>  __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
>  mmap_read_trylock include/linux/mmap_lock.h:204 [inline]
>  stack_map_get_build_id_offset+0x535/0x6f0 kernel/bpf/stackmap.c:157
>  __bpf_get_stack+0x307/0xa10 kernel/bpf/stackmap.c:483
>  ____bpf_get_stack kernel/bpf/stackmap.c:499 [inline]
>  bpf_get_stack+0x32/0x40 kernel/bpf/stackmap.c:496
>  ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1941 [inline]
>  bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1931
>  bpf_prog_ec3b2eefa702d8d3+0x43/0x47
>  bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>  bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
>  __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/m=
map_lock.h:47
>  __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mm=
ap_lock.h:47
>  __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:4=
7 [inline]
>  trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [in=
line]
>  __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
>  __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
>  mmap_read_lock include/linux/mmap_lock.h:185 [inline]
>  exit_mm kernel/exit.c:565 [inline]
>  do_exit+0xf72/0x2c30 kernel/exit.c:940
>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
>  __do_sys_exit_group kernel/exit.c:1113 [inline]
>  __se_sys_exit_group kernel/exit.c:1111 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
>  x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:=
232
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> mmap_read_trylock is used in stack_map_get_build_id_offset, if user
> wants to trace trace_mmap_lock_acquire_returned tracepoint and get user
> stack in the bpf_prog, it will call trace_mmap_lock_acquire_returned
> again in the bpf_get_stack, which will lead to a nested call relationship=
.
>
> Reported-by: syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/8bc2554d-1052-4922-8832-e0078a033e1d@=
gmail.com
> Fixes: 2f1aaf3ea666 ("bpf, mm: Fix lockdep warning triggered by stack_map=
_get_build_id_offset()")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..eec51f069028 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -130,6 +130,10 @@ static int fetch_build_id(struct vm_area_struct *vma=
, unsigned char *build_id, b
>                          : build_id_parse_nofault(vma, build_id, NULL);
>  }
>
> +static inline bool mmap_read_trylock_no_trace(struct mm_struct *mm)
> +{
> +       return down_read_trylock(&mm->mmap_lock) !=3D 0;
> +}
>  /*
>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>   * They will be subsequently:
> @@ -154,7 +158,7 @@ static void stack_map_get_build_id_offset(struct bpf_=
stack_build_id *id_offs,
>          * build_id.
>          */
>         if (!user || !current || !current->mm || irq_work_busy ||
> -           !mmap_read_trylock(current->mm)) {
> +           !mmap_read_trylock_no_trace(current->mm)) {

This is not a fix.
It doesn't address the issue.
Since syzbot managed to craft such corner case,
let's remove WARN_ON_ONCE from get_bpf_raw_tp_regs() for now.

In the long run we may consider adding a per-tracepoint
recursion count for particularly dangerous tracepoints like this one,
but let's not do it just yet.
Removing WARN_ON_ONCE should do it.

pw-bot: cr

