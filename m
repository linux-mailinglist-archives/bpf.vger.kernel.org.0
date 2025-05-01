Return-Path: <bpf+bounces-57139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 119DFAA62AA
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 20:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AAD1BC0898
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 18:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E593221FBE;
	Thu,  1 May 2025 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQjNP5T1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B721D3FD;
	Thu,  1 May 2025 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746123126; cv=none; b=WaqbjNH62iePGwHX6PVOBsPqArZgET0WHD6soA1WzZacVxspaJlvnC6CkY/yhGMZWrMNIzYFcf6tgExYqxfGAYvWaN+ayJCWtq2MmxPr2/s4Y9LUkbiFHDvQEc6JwV+DPmVZKwlBxYkgxJNO1SaHZxcwkrAMZ3UR3z6k3QZsi88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746123126; c=relaxed/simple;
	bh=4XvbgcAfvaKHgkvrKyrrbxsc9Zo4i8P85+j5/TVPMVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsWzfhLBbbrp45U+ZkmRwjp4k6pygxESEYxP82SDg5tBRVzVAR+VEPDRenegij7nPq01XqEvvQwzqVPyg672y/6XrnLzLx3/tFQm2AujdZdDJysiZYvlZ13k52x4RkG+HZj7sYiEJEJKVHiOweKJtoYzxfvrMmr5VbBMzuKUd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQjNP5T1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1458736b3a.2;
        Thu, 01 May 2025 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746123125; x=1746727925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2KG2as49bpWoOoSGAasYC9XopQyjIivrGhuc6j4Ja8=;
        b=bQjNP5T1I7Js8J7w5NTxt04RcBavgH+0ZgdXlX/CQAhESJ8chMnfpYW96hNKs5tndS
         L2Ppy5TAdqUxCFwTNRkkyl0X6Sg2NjmBo2A7CS7oa/RN6IM56TVkI4DSQqGNTk/T239O
         XTXSk5RRiOATs3Qqfdps63LrDNQgX/dkBPFNRl7TvFXrwL/mtG0kti8nI19X86T3QSNp
         AWNdXoNK2U+8IJSStptewId52keQlcGj4Vex/b0EzEAj6CgfICeVNVP7lEDe9nn9zQcM
         SJINQw4FUqO9rd5x/ZaH8pej9mx0Q585N8h9jpDYSnXkN5JdFu83YT+yFF+Qd7K15VNk
         g6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746123125; x=1746727925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2KG2as49bpWoOoSGAasYC9XopQyjIivrGhuc6j4Ja8=;
        b=Dp9gqM7Wv59+xLmCK79mttaH5y+Gy5NDJFx7K7kKqZeLRMK78yMXrhJBF85J/gPvie
         +fYb4dHdwzHc+6MaHy+kOApKKgwYlduR7QEIeOQYvAsgw05/jIVU1NOTOuvvJkmWEFjW
         cmhIj7Mtnm7Q3/+ZZZuVhbam25Lk16Be798/uDwXz2S8fjijsTzFmCCFJ2yA1kAaLF7p
         Fdy5BYGQHLvpiF8XAzJYI8o8LKcBsb0cuzJ72nYpeOZRWhpuoleDL0TMPHgi+LbPzoDu
         PRX9BJejpAFUkfD7t5dsjOUoHKnyWLjTtF1PP3fSCvv/qAs+OQLOMne6wSD3O4khzAGp
         nrkg==
X-Forwarded-Encrypted: i=1; AJvYcCUSDJ5D9MKTIY4/g6/NnybioQ9Nn76h74yzWBXxS5VVNTIfnRtlcBw7uLf/kM5HcDi6oCQESvOv@vger.kernel.org, AJvYcCVAGifGUFYxgtyPjr+KA4zoaNzz5kRjVF27oavz0z7x6ZUfRXaB2nKldWBi1+T9t1/z5lOPlfueXclDxU3nONuT37/F@vger.kernel.org, AJvYcCWuizKf0JozSE4xFLdEFS5QZeKk7AvCbZPVo8OhFftokKsxnQ0S47BN4vPfBJp3bBf1iqg=@vger.kernel.org, AJvYcCXl/ti90M6CuFQZ9HYimjtUpRHAkIQfK8zmcRfPrA3ClAjwLKBUPHUImlnA7Jir4i6gQ4zbSfHck3DpqJ0b@vger.kernel.org
X-Gm-Message-State: AOJu0YzWu8okbSP+C5vSTyZOarMLQ/WOROfVR63lXpuMmAfkSrLkN0mP
	Uud9hpGEwmHlfquPdX8Tj6XXaw9h7rAFIDaop7tYrV6dtFfFA0t1j4JvDwd+MrVkTwJ2u74frcJ
	Z/wwncA+13N8RvaVhiu71y9MdZDU=
X-Gm-Gg: ASbGncsrPcVU2A9K1Mgxi/NvTtPep1xemTrL6+ZTJcjgbAx7Qfa9G8JnvCg1UaGVSle
	bELGBbNpQo2SwiFXerpfipkBNhJxhaH0rpIcqq40ZU/X/RE8n9UgwB/DQqCAwiwqYBOBQrZU+e/
	3qCwir0qdmPVpKFMHTg4OoNVurpxf3K0godmlvtg==
X-Google-Smtp-Source: AGHT+IGqDlC2E7jiIsFNvlbYgxIKsWbas6w3+iAUOFuauDSOc2+ar8JgNhN475KkLIkoWKqF5a+y+XbTQjTmFoi/4BY=
X-Received: by 2002:a05:6a21:338c:b0:1f3:41d5:6608 with SMTP id
 adf61e73a8af0-20bd8247791mr3810125637.26.1746123124663; Thu, 01 May 2025
 11:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427063821.207263-1-yangfeng59949@163.com>
In-Reply-To: <20250427063821.207263-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 11:11:52 -0700
X-Gm-Features: ATxdqUEFaJVWHzuMIuxkj8n2TpEySzKQv1HstKSN00XuW5rRGuMvrjMLfJDz_ZI
Message-ID: <CAEf4BzbJ0eaiiaCukaJV0JmrzF6fsbwOxszQUV3pL+MAJT25rw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Allow some trace helpers for all prog types
To: Feng Yang <yangfeng59949@163.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, davem@davemloft.net, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, htejun@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 11:39=E2=80=AFPM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> if it works under NMI and doesn't use any context-dependent things,
> should be fine for any program type. The detailed discussion is in [1].
>
> [1] https://lore.kernel.org/all/CAEf4Bza6gK3dsrTosk6k3oZgtHesNDSrDd8sdeQ-=
GiS6oJixQg@mail.gmail.com/
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
> Changes in v2:
> - not expose compat probe read APIs to more program types.
> - Remove the prog->sleepable check added for copy_from_user,
> - or the summarization_freplace/might_sleep_with_might_sleep test will fa=
il with the error "program of this type cannot use helper bpf_copy_from_use=
r"
> - Link to v1: https://lore.kernel.org/all/20250425080032.327477-1-yangfen=
g59949@163.com/
> ---
>  kernel/bpf/cgroup.c      |  6 ------
>  kernel/bpf/helpers.c     | 38 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 41 ++++------------------------------------
>  net/core/filter.c        |  2 --
>  4 files changed, 42 insertions(+), 45 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 84f58f3d028a..dbdad5f42761 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2607,16 +2607,10 @@ const struct bpf_func_proto *
>  cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_pro=
g *prog)
>  {
>         switch (func_id) {
> -       case BPF_FUNC_get_current_uid_gid:
> -               return &bpf_get_current_uid_gid_proto;
> -       case BPF_FUNC_get_current_comm:
> -               return &bpf_get_current_comm_proto;
>  #ifdef CONFIG_CGROUP_NET_CLASSID
>         case BPF_FUNC_get_cgroup_classid:
>                 return &bpf_get_cgroup_classid_curr_proto;
>  #endif

this is the only one left, and again, it's just current-dependent, so
I'd just move this into base set and got rid of
cgroup_current_func_proto altogether (there are 5 callers, let's clean
them up)

> -       case BPF_FUNC_current_task_under_cgroup:
> -               return &bpf_current_task_under_cgroup_proto;
>         default:
>                 return NULL;
>         }
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e3a2662f4e33..a01a2e55e17d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -23,6 +23,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
> +#include <linux/bpf_verifier.h>

why do we need this include?

[...]

> @@ -2057,6 +2074,27 @@ bpf_base_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
>                 return bpf_get_trace_vprintk_proto();
>         case BPF_FUNC_perf_event_read_value:
>                 return bpf_get_perf_event_read_value_proto();
> +       case BPF_FUNC_perf_event_read:
> +               return &bpf_perf_event_read_proto;
> +       case BPF_FUNC_send_signal:
> +               return &bpf_send_signal_proto;
> +       case BPF_FUNC_send_signal_thread:
> +               return &bpf_send_signal_thread_proto;
> +       case BPF_FUNC_get_task_stack:
> +               return prog->sleepable ? &bpf_get_task_stack_sleepable_pr=
oto
> +                                      : &bpf_get_task_stack_proto;
> +       case BPF_FUNC_task_storage_get:
> +               if (bpf_prog_check_recur(prog))
> +                       return &bpf_task_storage_get_recur_proto;
> +               return &bpf_task_storage_get_proto;
> +       case BPF_FUNC_task_storage_delete:
> +               if (bpf_prog_check_recur(prog))
> +                       return &bpf_task_storage_delete_recur_proto;
> +               return &bpf_task_storage_delete_proto;

task_storage_{get,delete} probably should be guarded just by CAP_BPF,
no need for CAP_PERFMON, IMO. Can you please move them up a bit?

Also, we should probably get rid of bpf_scx_get_func_proto() in
kernel/sched/ext.c, given it only adds these two on top of the base
set? But that's probably a separate patch against sched_ext tree?
cc'ing Tejun

pw-bot: cr

> +       case BPF_FUNC_get_branch_snapshot:
> +               return &bpf_get_branch_snapshot_proto;
> +       case BPF_FUNC_find_vma:
> +               return &bpf_find_vma_proto;
>         default:
>                 return NULL;
>         }

[...]

