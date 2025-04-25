Return-Path: <bpf+bounces-56705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E29BA9CE5A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B90B189A6AC
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF221A315C;
	Fri, 25 Apr 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqegsN0h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6E169AE6;
	Fri, 25 Apr 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599134; cv=none; b=h95TlhYShSI3B5aDJyN5D+T9p9t07jEKMVn+o2uG+u6dA/s8GTxUqB/Y7PrUVBm7cI1R9kRiwYG4PX+FLyxsQ9ueyLoTRQzkV90vmDS2gsuko8Lz+zzFp0iusO5cZl+YtrhvehK3c+G4KFxs5Hrk7sGpco1Pesb6+iZu6mcNZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599134; c=relaxed/simple;
	bh=50iEDjqA2Jf8NqyUevMHPMcWNOhJKHJ7l0SSNos8C8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7TuR+sa4nk6pdDDOySaVQPtzIm+AKzkoj8svU9BQqpOykMMFNigynUuSSpJSmN4VzVNuxUicetHa7fEGE4M5x0lHTfCyGwCUNeNnTAok2+s9WqKvT/3D6N24ZMMXVOUWtseYQlal0m/GczhVSGkPF1CGgMUPMw188JhKjRqkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqegsN0h; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso2728676a91.3;
        Fri, 25 Apr 2025 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745599132; x=1746203932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXiNbQmDpj/6IlBES4itiaRMtSWy34oPDGVBOYZLx2s=;
        b=FqegsN0hiGv9msrHjcwqkC5hucQSvu1jwT4Z1Mty1X6q8boQgna+t1bANU+neD4GGo
         J41EXthi30HCWEt6sRIfKPWHDhwE8IJOkflNriFcwQqZwogNfyycSxUCCpeAMVfRtqUp
         FbsXI9xsD+vtJXEqdSkc9RmaarcvdI9oZN1bxhavvrqCEdo5uO7uxJPbx46UiQEOn9Fz
         Nrf4SRCSoDTbtCNLmFKmK5Wl3tkV15pkWafm6SxRl1VHjhoed94yuwBCbGyf5XJmKakb
         /6JI4CHXlsQikWFeQPDO0d3LL68lMN09zHxvkqEc8qBhl1Ptm/0hGu264xyPaIUsIdYG
         Jh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745599132; x=1746203932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXiNbQmDpj/6IlBES4itiaRMtSWy34oPDGVBOYZLx2s=;
        b=YxeqYVkCRfSDJohWw7ooPm3DN9jEXG4dq1jn/+WjFOzmCWxL5Yy9X8p6sEIXKnAnpP
         YWixnObeT7tS7bH37FkZoUyMsCRRUqGVgiPZ3Z597iuy9wGPREQ6azyZf1/R2TJ99xEm
         d/TEFEAc4otEE4HvwPpHYZxABnqNhO0mNRgCwlRAcqFd4bFmEyDt8DhZD88e5QxKFWgS
         WaIMG20edrwxuumnacOyiFVDoQ0UMT1QRZ3SkNA0CQBwfM6iHkTnX/r4jr7yYM/A7D78
         3n9YgXO/eYKf0P0E4fYJwvJSeuOI49ROiR0O95v8YVoc01OMS4pt+tCS8PmeFuDgzax1
         4ihw==
X-Forwarded-Encrypted: i=1; AJvYcCUsPm1ZQ2YcPFedsoVdj0FEz+HRHBuuDo21e3AGtespSRxnJo/0O36Qg46qQ5sI8UXHHokwcZsnSXfVa8Ua@vger.kernel.org, AJvYcCVm+EySLWze4S6uNcgGuDc3nK4TEuG7m91lIDepY/wxyJD2iMNkZfCiEqZawC3Hc8iFWTTPUy5/@vger.kernel.org, AJvYcCWUqi7B8FIj5nTDDJC+ZqdhLktgTVWmUaJAa/Y7UPaLhXeCrpk1rS+EqUJsasvEeUU8ouY=@vger.kernel.org, AJvYcCXCcPPUQKOHP03LD0p1iuigNdU8Keqk2Pe9NFf0L0K0A6rFjHsrOj6X1oyrus7H7aYqZ3tl3wb/aH7rZ21bPqj5nHlT@vger.kernel.org
X-Gm-Message-State: AOJu0YxUD+9kyX4JBQrwNR2736D7Pf4GoGTxoWixiqC0bqpQx7Ai6eGz
	A4RrSCD+18AXFbJ9dib+lxAIv3UWlyE3eO6VjcS8YOZZ4AzKa31ghp8lmpU9+FMIjEkzoO8nx8W
	569soFHqMedQHQiwVxg6+lX29A04=
X-Gm-Gg: ASbGncvuaKitdrzWh0e3DFGT+cUqedigAdcPJ7W7xQR9D511Y0PzWJVmBZp0ymRbZ0D
	8bpQbp6f8u7Qi49qASMD3gP/pUYpVu0B+C+I6d2ZStbrDSHYzVDnXahGIu4AZGs9fl5+0iiHhxe
	Cm3WRpxRCjTzKD+IYTnt3pir5lG8Yp7ccwOP5RLA==
X-Google-Smtp-Source: AGHT+IEP+m6u+dCth1Yb4tFOhfEb6+4KFu16P8LVmvq0VkEE125qZnM8xTasu/PoyRgs1S6Q86DiLygSBaKIGI/22K8=
X-Received: by 2002:a17:90b:3941:b0:2ff:69d4:6fe2 with SMTP id
 98e67ed59e1d1-309f7df2d4bmr5067247a91.16.1745599132498; Fri, 25 Apr 2025
 09:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425080032.327477-1-yangfeng59949@163.com>
In-Reply-To: <20250425080032.327477-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 09:38:39 -0700
X-Gm-Features: ATxdqUH7SLww-vplpJsBfazG-NmzHcolGXeASR1xgSA1r2Vn0e4MZ3c1yRb-HoU
Message-ID: <CAEf4BzYYWkc0L+MLGoCpgVSvEKw3okb+Ta7WrpPOKMS1RZjM1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow some trace helpers for all prog types
To: Feng Yang <yangfeng59949@163.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, davem@davemloft.net, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:02=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
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
>  kernel/bpf/cgroup.c      |  6 -----
>  kernel/bpf/helpers.c     | 50 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 53 +++++-----------------------------------
>  net/core/filter.c        |  2 --
>  4 files changed, 56 insertions(+), 55 deletions(-)
>

Some tests in CI are failing, please check and fix. Also see below
about compat probe_read APIs.


> @@ -2037,6 +2052,16 @@ bpf_base_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
>                 return &bpf_get_current_task_proto;
>         case BPF_FUNC_get_current_task_btf:
>                 return &bpf_get_current_task_btf_proto;
> +       case BPF_FUNC_get_current_comm:
> +               return &bpf_get_current_comm_proto;
> +#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> +       case BPF_FUNC_probe_read:
> +               return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0=
 ?
> +                      NULL : &bpf_probe_read_compat_proto;
> +       case BPF_FUNC_probe_read_str:
> +               return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0=
 ?
> +                      NULL : &bpf_probe_read_compat_str_proto;
> +#endif

No, let's not expose compat probe read APIs to more program types,
these should eventually go away

pw-bot: cr

>         case BPF_FUNC_probe_read_user:
>                 return &bpf_probe_read_user_proto;
>         case BPF_FUNC_probe_read_kernel:
> @@ -2057,6 +2082,31 @@ bpf_base_func_proto(enum bpf_func_id func_id, cons=
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
> +       case BPF_FUNC_copy_from_user:
> +               return prog->sleepable ? &bpf_copy_from_user_proto : NULL=
;
> +       case BPF_FUNC_copy_from_user_task:
> +               return prog->sleepable ? &bpf_copy_from_user_task_proto :=
 NULL;

I'd put these two next to probe_read APIs above

> +       case BPF_FUNC_task_storage_get:
> +               if (bpf_prog_check_recur(prog))
> +                       return &bpf_task_storage_get_recur_proto;
> +               return &bpf_task_storage_get_proto;
> +       case BPF_FUNC_task_storage_delete:
> +               if (bpf_prog_check_recur(prog))
> +                       return &bpf_task_storage_delete_recur_proto;
> +               return &bpf_task_storage_delete_proto;
> +       case BPF_FUNC_get_branch_snapshot:
> +               return &bpf_get_branch_snapshot_proto;
> +       case BPF_FUNC_find_vma:
> +               return &bpf_find_vma_proto;
>         default:
>                 return NULL;
>         }

[...]

