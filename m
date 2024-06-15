Return-Path: <bpf+bounces-32209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73473909525
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 03:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7A0B22754
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 01:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F851FBA;
	Sat, 15 Jun 2024 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvpyrupH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105F173
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718413504; cv=none; b=BfLkM0EZ4V6vjQIl07AmB4/KLkxlUfN/kymooU+n/CIDDVk+xFFoT+sjtqV2Mh0ibtuhElD5fVDCcFcJQp0f04HrDK5gliS+BSpju5tpDwiSWgalWIxZmgRVpHYyknYEsHtqhxxxmhHmzExkDW4PD4TTrbdazpbpRpwFaFGsR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718413504; c=relaxed/simple;
	bh=3AhyQHIXiL6+UR41T0vrBpNTJKI+dtljItR+0D4gQIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr/STgLQ1qDXre4/YhP09hla9g07ML5ZD708/t2Xi8iHWMgTuhdMpcKHTNGBQRtZB+mjDPr+qnjsVOid4cVLWwC5wOestMzPc9pcJxRwus5olpHwuyZ8mW41kA8NMjDOnj98bItR5To+/i1am9lO262WCG2f1g7JtR8cCH3YvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvpyrupH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1c209893so2978942f8f.2
        for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 18:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718413500; x=1719018300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XxCZXCFBkw016JI61A2Fr8NWFQX15Px1nWGcCrlo24=;
        b=cvpyrupHg42e6UGDSYdDl/tMFKfJP6XJrkJrcIHhi6MzRZoqXWvUidPyKi05J8IqIF
         go/7+q8ZA82P/3ilkiqtK7HaJ8oq5b8/IymBQ/Mey42RlEcbsPj9eDIbdDEyzbhLrdST
         PDg6vV+fPOuAIOx5u6uq5gHEfAgHyduPyupdXrkwumwxtJPqcv3mGvjQeZEGqAtBH4hJ
         EBCcbR76DnBWaxH1NXlORXSRy2Ofa7u1cu3dssuU5OMqoxlzdDACl0FNZQipdIybZKv8
         BDBMB4h7ZgSUfmf9xRIBu8za0Bvyim8WVq4QN/OqIeHKoBXzICYKU8YDtCA/WI3ABqTF
         Glrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718413500; x=1719018300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XxCZXCFBkw016JI61A2Fr8NWFQX15Px1nWGcCrlo24=;
        b=Wp2M5gzu/rmGkOQ/iLrlni05+N4fJpd1wtMFEkEtnuIv8YNrKEmuzXPJ8ZW73ZLKLD
         k+3WuFL74ezmr9ApZLEN2wG2CzTGVjCN5ulqIFYMyF9fgsS8fLUtUVa6iPe5YD9KKEUf
         60qDW7Jb27/0G1ir1I+tpWNN0GdqE21slvGipE255nqoXAM5bBJu4QqfWWUei5ExFk1S
         jHqrbJAqVaTkVhqYAJYdVgqimq4yZ9HMDdHZzuPdKrsEHMfyOwifVSDXZ6hnhOGSavuu
         HaYRE549cAbqfPEqD/aflSDcrVzExBWVL9aU6zsigyYFsD5e6NDgT/1MHupylhOS+go1
         Gshw==
X-Gm-Message-State: AOJu0YyXVdne9V/KYTf9ULfzhHo3SUbDjnxtGCGAVn+j5u5wIO0hlnfC
	lt4iW90L0zbf1MnYQj0fpzj+9js8IGkaU07MNYrlKrkzMYPVH/p0ryyOtjbQjYkctaehCruP/Hc
	Y6IU+Gxst6DtYoKxLgsWVjP2VbWpL56Ak
X-Google-Smtp-Source: AGHT+IH2QOQvTKOpIynDI9oS7IrEl5t1BrCtF1vfxIPoo4cEHAMWDz3gEUszKsrwqV9v7Om7XSpAf83WMjsmU7UnROU=
X-Received: by 2002:a5d:4bd0:0:b0:360:712e:3610 with SMTP id
 ffacd0b85a97d-3607a7687ccmr3579589f8f.38.1718413500411; Fri, 14 Jun 2024
 18:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmIyMfRSp9DpU7dF@debian.debian>
In-Reply-To: <ZmIyMfRSp9DpU7dF@debian.debian>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Jun 2024 18:04:48 -0700
Message-ID: <CAADnVQKYAf7tZU+gqnDAoOa4THyqdhZtbmSd7DtwpTZyUZi9RQ@mail.gmail.com>
Subject: Re: Ideal way to read FUNC_PROTO in raw tp?
To: Yan Zhai <yan@cloudflare.com>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:03=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote:
>
> Hi,
>
>  I am building a tracing program around workqueue. But I encountered
> following problem when I try to record a function pointer value from
> trace_workqueue_execute_end on net-next kernel:
>
> ...
> libbpf: prog 'workqueue_end': BPF program load failed: Permission
> denied
> libbpf: prog 'workqueue_end': -- BEGIN PROG LOAD LOG --
> reg type unsupported for arg#0 function workqueue_end#5
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> ; int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
> 0: (79) r3 =3D *(u64 *)(r1 +8)
> func 'workqueue_execute_end' arg1 type FUNC_PROTO is not a struct
> invalid bpf_context access off=3D8 size=3D8
> processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'workqueue_end': failed to load: -13
> libbpf: failed to load object 'configs/test.bpf.o'
> Error: failed to load object file
> Warning: bpftool is now running in libbpf strict mode and has more
> stringent requirements about BPF programs.
> If it used to work for this object file but now doesn't, see --legacy
> option for more details.
> ...
>
> A simple reproducer for me is like:
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
>
> SEC("tp_btf/workqueue_execute_end")
> int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
> {
>         u64 addr =3D (u64) f;
>         bpf_printk("f is %lu\n", addr);
>
>         return 0;
> }
>
> char LICENSE[] SEC("license") =3D "GPL";
>
> I would like to use the function address to decode the kernel symbol
> and track execution of these functions. Replacing raw tp to regular tp
> solves the problem, but I am wondering if there is any go-to approach
> to read the pointer value in a raw tp? Doesn't seem to find one in
> selftests/samples. If not, does it make sense if we allow it in
> the verifier for tracing programs like the attached patch?
>
> Yan
>
> ---
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 821063660d9f..5f000ab4c8d0 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6308,6 +6308,11 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>                         __btf_name_by_offset(btf, t->name_off),
>                         btf_type_str(t));
>                 return false;
> +       } else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING || prog->type =
=3D=3D BPF_PROG_TYPE_RAW_TRACEPOINT) {
> +               /* allow reading function pointer value from a tracing pr=
ogram */
> +               const struct btf_type *pointed =3D btf_type_by_id(btf, t-=
>type);
> +               if (btf_type_is_func_proto(pointed))
> +                       return true;

The reason it wasn't supported in tp_btf is to avoid potential
backward compat issues when the verifier will start to recognize it
as a proper pointer to a function.
Since I didn't know what that support would look like I left it
as an error for now.

'return true' (which would mean scalar type to the verifier)
is a bit dangerous and I feel it's better to think it through right away.

Eventually it probably will be a new reg_type PTR_TO_KERN_FUNC or something=
.
And it won't be modifiable.
Like arithmetic won't be allowed.
Passing into other helpers (like prinkt in your example) is fine.
But if we do 'return true -> scalar' today then bpf prog
will be able to do math on it, including conditional jmps,
which will be disallowed once it becomes PTR_TO_KERN_FUNC.
And that would become a backward compat issue.
So pls think it through from that angle.

