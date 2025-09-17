Return-Path: <bpf+bounces-68590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EFCB7F597
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292894E2C37
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 00:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7B1388;
	Wed, 17 Sep 2025 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwYmy2dh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F1634
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067617; cv=none; b=qHpFtMEji+LUzsdJu9YOBA1rgPiIzz7gVoI7QIYohEbauV3XbPgQ5ptM2pPV0A2TtndF6vSLOxqFAJ1BUavyJepShJmNmkiMv4zhRMPuXEDkhK6QM+vZY3nD95zsF6wm0bNgPcEkCBRfJognRjy8DLyTpKzdg4rNlKwlG3u9yzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067617; c=relaxed/simple;
	bh=lT0JiLzMi785TUIW65CnSa4Rwk0x2eGbBAHF6LSOvRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5zWezCUxWWHn8LVkubuTVPfbabS0J53pfyR/1XZGpTH0nH4HYXwNlTzKGnACpdQUEiGWxh3enwCm8R6pRIuRg5f+qxsBI9xSFmSnJKz1+3kegvT2CpkzuTxzz7cV3Q6C57Rjv1IzYmeiyhgtA4elhouPFEzyD2ZPemczwSxzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwYmy2dh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32e0e150554so264829a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 17:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067615; x=1758672415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF8wGeK1l43wPo4D8zPdFegAOruZOm7+elN47Pu2bJk=;
        b=mwYmy2dhOV2AFamVVU/vZGKJfhLCNePyAAqevF/tySa1B29Nr1pFmIQsPJYWEnS6ih
         JGJ+be6PkotIeN2O+uKDQ5eel0UM/UZ4/8W70EEse74FDwy5V1scdAVafIXNSDr77J4G
         iIsxkM/0nloWE08mghSI9o0V1sj2aa1K2qGpH8gZoOYnSFzILueteATz6R1HenyLSZk5
         VUdOa5nqYDdDJG9QlmuxRZBTq80r0GudMHTHnNNDZvuAZtFTzi9XlxhyD0YoGNQktmPu
         4Y5mk+9+Q32ezaL9u/ZUO/ywjjWnVuF3zu4FP/HjaiaE4B4t/xGzrq0XeAQmS1F6QqE3
         U2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067615; x=1758672415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF8wGeK1l43wPo4D8zPdFegAOruZOm7+elN47Pu2bJk=;
        b=n9MTbO4+bboirA5J7ndkUXkUuItcNo76D4LBgkAgbM582taRFaR2BG2T9+8PKEUKB5
         viuHTLAWmQMcxecKIkkIF8DmZyZTuoVuWXzzNFRcyGMRB43223zqtT+/0y/gAtb6YxjB
         BfvAW0cjlZfDQLAl/lHjmIN63L58OhcAOc+Xgo/3/F/dY8pFjDuX/mGpUvDJW5QxlGdB
         L4fYg1FnpNFJhQJljVbYJBEG6pnWszDtJfdVWHY08CLN4k5w9FNdlRkq0+094sGKI8ft
         6iPnHL4HU1SnkO7+jkhhBL1z3mU9Lx/Qq0RN53bUsO4miQUkKRizvL1tPMQmqaJCHI6/
         bZ3g==
X-Gm-Message-State: AOJu0Yw+44ByT9T8NfLCzLcJJtySb+3FLqTeGLRt3qQY4pYtqidvE661
	NxxmcyRVOH1L6ZoYcs02AJWc9vhGGf9Wd5thyw3AGpLL4eqivB5bfdu3RNPxHvf+i1yQtyorzfV
	qkGMOiN5aRglLGXod7nYKjiHOVNwdoSg=
X-Gm-Gg: ASbGncui59RmFv9+6/2DwDOL58qTmQ5wkrqozSssgdRFIXyBMkvjrJtB4fBQBa6GYfH
	Riwzig8w89rypO7XRwSMXcTUgFWtDuhHxpf/jgtf1FKv4Hlte46KqE6zFV58je4JFv8EFb7sNAu
	fSJhhDOPsoZ2jKLVTdTApTgr/AFl04K1fwBVe0roBu8vPOlNkU2G8s4fIPOdshDLzp+RQb49V1b
	77Goz2eyiHq6W3vm2dQffs=
X-Google-Smtp-Source: AGHT+IGO3rtM/AXf46yDWKCK6ezTEmrdy78VmXbRq8QPiJfiQ2QMzm7lTTs0SNS0WhaKH+CGYgqAMgBJt8ZRpxbVqZ4=
X-Received: by 2002:a17:90b:3e50:b0:32d:e309:8d76 with SMTP id
 98e67ed59e1d1-32ee3fb455fmr202617a91.10.1758067615228; Tue, 16 Sep 2025
 17:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-2-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 17:06:35 -0700
X-Gm-Features: AS18NWCnaRwTQjv5YiajiUtbly1-ni9tX2jtsl_iaedLcwijc9trN2jX3NXSC7Q
Message-ID: <CAEf4BzZAb1RFpJFLJLWLyV-r=yrKj1_tpjk1MSvx=uHC_DG=aA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/6] bpf: Extend bpf syscall with common
 attributes support
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, menglong8.dong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch extends the 'bpf()' syscall to support a set of common
> attributes shared across all BPF commands:
>
> 1. 'log_buf': User-provided buffer for storing logs
> 2. 'log_size': Size of the log buffer
> 3. 'log_level': Log verbosity level
>
> These common attributes are passed as the 4th argument to the 'bpf()'
> syscall, with the 5th argument specifying the size of this structure.
>
> To indicate the use of these common attributes from userspace, a new flag
> 'BPF_COMMON_ATTRS' ('1 << 16') is introduced. This flag is OR-ed into the
> 'cmd' field of the syscall.
>
> When 'cmd & BPF_COMMON_ATTRS' is set, the kernel will copy the common
> attributes from userspace into kernel space for use.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/syscalls.h       |  3 ++-
>  include/uapi/linux/bpf.h       |  7 +++++++
>  kernel/bpf/syscall.c           | 19 +++++++++++++++----
>  tools/include/uapi/linux/bpf.h |  7 +++++++
>  4 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 77f45e5d44139..94408575dc49b 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -933,7 +933,8 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned=
 int flags,
>  asmlinkage long sys_getrandom(char __user *buf, size_t count,
>                               unsigned int flags);
>  asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned =
int flags);
> -asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned i=
nt size);
> +asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned i=
nt size,
> +                       struct bpf_common_attr __user *attr_common, unsig=
ned int size_common);
>  asmlinkage long sys_execveat(int dfd, const char __user *filename,
>                         const char __user *const __user *argv,
>                         const char __user *const __user *envp, int flags)=
;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 233de8677382e..5014baccf065f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1474,6 +1474,13 @@ struct bpf_stack_build_id {
>         };
>  };
>
> +struct bpf_common_attr {
> +       __u64 log_buf;
> +       __u32 log_size;
> +       __u32 log_level;
> +};
> +
> +#define BPF_COMMON_ATTRS (1 << 16)

add this into enum bpf_cmd after __MAX_BPF_CMD (with a small comment
about the purpose of this)? That will keep everything cmd-related in
one place

>  #define BPF_OBJ_NAME_LEN 16U
>
>  enum {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3f178a0f8eb12..d49f822ceea12 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5987,8 +5987,10 @@ static int prog_stream_read(union bpf_attr *attr)
>         return ret;
>  }
>
> -static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size=
)
> +static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size=
,
> +                    bpfptr_t uattr_common, unsigned int size_common)
>  {
> +       struct bpf_common_attr common_attrs;
>         union bpf_attr attr;
>         int err;
>
> @@ -6002,6 +6004,14 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t ua=
ttr, unsigned int size)
>         if (copy_from_bpfptr(&attr, uattr, size) !=3D 0)
>                 return -EFAULT;
>
> +       memset(&common_attrs, 0, sizeof(common_attrs));
> +       if (cmd & BPF_COMMON_ATTRS) {
> +               cmd &=3D ~BPF_COMMON_ATTRS;
> +               size_common =3D min_t(u32, size_common, sizeof(common_att=
rs));
> +               if (uattr_common.user && copy_from_bpfptr(&common_attrs, =
uattr_common, size_common))
> +                       return -EFAULT;

use bpf_check_uarg_tail_zero() for extra checks, just like we do for uattr

> +       }
> +
>         err =3D security_bpf(cmd, &attr, size, uattr.is_kernel);
>         if (err < 0)
>                 return err;

[...]

