Return-Path: <bpf+bounces-38593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5924B9669E7
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF51C25925
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A21BCA06;
	Fri, 30 Aug 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcauP+iT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593C14D2B5;
	Fri, 30 Aug 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046468; cv=none; b=dDxwwW8NLRp9vJxEgKMICvvsf+nIktU4/p5uu1DrkNxSoyMLuK12WJg/oFJCHWfqt4XQiWax8pICYNFL/u4N0Dtl6HpieSIQ/dCtIFuG6cGCwct4LwkTPoBo5SGYKiGRsb4lt3SUDwE8GzU0eNGjE0AP/lgV7VeT6DIfp5tfbeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046468; c=relaxed/simple;
	bh=Bybqk09gEVlUo9XLG+8qiSYhkm0flYbDHNeUSV7SVc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dirJj07aiS8ulPNiQFSruTIaKYsVSHjg+xu1Q9J/9wXuAgvaLdBVjYsh3tE5xtqnEaNullhSUr1mXgdQgCX+qgd6UcLG9rWsHAzED6bcr/0eU7zvWk6HRYrBfP2gtoZeP/FcjY9g23I9rKd30UT3mnAMoGCp+zSsckXKy7FkNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcauP+iT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-716609a0e2bso1058794b3a.0;
        Fri, 30 Aug 2024 12:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725046466; x=1725651266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T4DD/L1ycBynDsagGFuV4APxCCk9WOAuvtMlSnh1e8=;
        b=FcauP+iTITVCk0ZI0DOCgwcSLxpfOq7M+KKvgYv+w/KX8LEBnj4B5Si7oGCP78PoFo
         5DGG1KanC3RSczBx0rt+mEOkcExeyZzn8+XNuP/p6SX3h7KXNDqbFbqNkdsoDutoF3kQ
         6g/+eEJ9/Nw8ZC3EfnnrW1VNlHF48ZAQXD523QghsuI3QANZiOQed3Zg56Py8Y2HsR8L
         yXVE+mgrJSl3kuCudxRAlpCvfV3XNvJmCpspy2nV//NoRTQ8O50pnPTK0naWhGNgz8pN
         41e8DGdB+xMt5YpV+d+p/LH3Q5pwFHBzesbtdVMFwd0EsPlhpq66lmO1N2MC7evzR4PT
         20Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725046466; x=1725651266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T4DD/L1ycBynDsagGFuV4APxCCk9WOAuvtMlSnh1e8=;
        b=NM+nnVW4/KCVNV+/UYaXlk7QQmxQA9fqhy49kasqi5h8ptu2Vk0o8+oI7WdR1MQod+
         J6M+C9EuTS04wwctQg7tZiZKRJ9U3Tn1C1wsQxOKppZf9YQJdexwDVCufVI7zT3MwP0J
         N43aXgfu2zroAl0WhMK2rtA6Hq574F2ViKyW8oFW648/DTeb9FGfJlQTOdOvZR6BS0Rp
         HMtoNSz4jNwcOJG4dT/5z5GX3WkiApjotKFriyeR9f/soIJnBOX4AzGQ7EFNod3Vaf2S
         EYAbBifqAcrtMpfBo5r6BLXdH+9KZvevCppsr1YSlDtSf7YKk4KNFajLB1XV28Uc8FZB
         QSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjWVhq7RVqL+8VrBD+fo1UsXI8IEosSRDnJaAOBhXVF4SZ6ZYab6EIs/J5pp73GtdHrHT4fQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KlDSYNkkbkQNfr8iHHH9trgDaMdB3L6gsyLUyWAHgIZwilGp
	XhPOE2A6+mcaziX94KlJ+KViRsqQb9NLf3VrV3Ws5TAd1jlaeqGL5vZrvs37pCq1zZ/KgsKB6Wx
	sjmUqRBvaIjbbeijkOQuFjiIZ7qY=
X-Google-Smtp-Source: AGHT+IELhpO8EFZ0TbuW8ruGGOKl7Hd0S2qc3IfGydBhjX/AqvUfL4N+n5Dlz0dg3Xm2gvJGmq1NkzYG/nGF/B0GQR8=
X-Received: by 2002:a05:6a20:d490:b0:1c8:eb6e:5817 with SMTP id
 adf61e73a8af0-1cce0ff1851mr7151079637.5.1725046465870; Fri, 30 Aug 2024
 12:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829133453.882259-1-pulehui@huaweicloud.com> <20240829133453.882259-2-pulehui@huaweicloud.com>
In-Reply-To: <20240829133453.882259-2-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 12:34:13 -0700
Message-ID: <CAEf4BzbvUQ1HA6GPSF23piqbEBNVDZKZC0rB-X4LgeMpp9svYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Fix accessing first syscall argument
 on RV64
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:32=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> On RV64, as Ilya mentioned before [0], the first syscall parameter should=
 be
> accessed through orig_a0 (see arch/riscv64/include/asm/syscall.h),
> otherwise it will cause selftests like bpf_syscall_macro, vmlinux,
> test_lsm, etc. to fail on RV64. Let's fix it by using the struct pt_regs
> style to provide access to it only through PT_REGS_PARM1_CORE_SYSCALL().
>
> Link: https://lore.kernel.org/bpf/20220209021745.2215452-1-iii@linux.ibm.=
com [0]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 9314fa95f04e..388f30cf7914 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -351,6 +351,10 @@ struct pt_regs___arm64 {
>   * https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/risc=
v-cc.adoc#risc-v-calling-conventions
>   */
>
> +struct pt_regs___riscv {
> +       unsigned long orig_a0;
> +};
> +
>  /* riscv provides struct user_regs_struct instead of struct pt_regs to u=
serspace */
>  #define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
>  #define __PT_PARM1_REG a0
> @@ -362,12 +366,15 @@ struct pt_regs___arm64 {
>  #define __PT_PARM7_REG a6
>  #define __PT_PARM8_REG a7
>
> -#define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
> +#define __PT_PARM1_SYSCALL_REG orig_a0
>  #define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
>  #define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
>  #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
>  #define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
>  #define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
> +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) \
> +       BPF_CORE_READ((const struct pt_regs___riscv *)(x), __PT_PARM1_SYS=
CALL_REG)

I feel like what we did for s390x is a bit suboptimal, so let's (try
to) improve that and then do the same for RV64.

What I mean is that PT_REGS_PARMn_SYSCALL macros are used to read
pt_regs coming directly from context, right? In that case we don't
need to pay the price of BPF_CORE_READ(), we can just access memory
directly (but we still need CO-RE relocation!).

So I think what we should do is

1) mark pt_regs___riscv {} with __attribute__((preserve_access_index))
so that normal field accesses are CO-RE-relocated
2) change PT_REGS_PARM1_SYSCALL(x) to be `((const
struct_pt_regs___riscv *)(x))->orig_a0`, which will directly read
memory
3) keep PT_REGS_PARM1_CORE_SYSCALL() as is


But having written all the above, I'm not sure whether we allow CO-RE
relocated direct context accesses (verifier might complain about
modifying ctx register offset or something). So can you please check
it either on s390 or RV64 and let me know? I'm not marking it as
"Changes Requested" for that reason, because that might not work and
we'll have to do BPF_CORE_READ().

>
>  #define __PT_RET_REG ra
>  #define __PT_FP_REG s0
> --
> 2.34.1
>

