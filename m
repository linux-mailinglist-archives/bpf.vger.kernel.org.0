Return-Path: <bpf+bounces-44889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 948B09C963C
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08745B24D6A
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 23:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557D1B6CF9;
	Thu, 14 Nov 2024 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTcXgl8e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8811B6CEA;
	Thu, 14 Nov 2024 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627681; cv=none; b=Fp/jfxwoyfqTVL9hsL3yT0BXJB/YOKtbm+HnX4M/7TmJda1Z96OY/tAyQAVQ6rg/xhLWBvpAignHZmlugNUgflvB1SBvmlu6h65l4xVCm7RdiL7j1rcjQsY7CR4zO8XS+CNAVhr6BfPpu/DHZhPFUQKdiZWc9MiDtkeevB45dj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627681; c=relaxed/simple;
	bh=UBpbiWquLqRO8+0oIrD36l/VRiFiV+lsOnKi9bFAoH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDzWaVpdGa0wi6s74rJ682pI+xCkcLPwa8LezH1/GtXWOWA1mHQpszUqE+vRmLru8QFjB4Tz+FIQoE+SqxnG1hdpElzkIEpcj17t41rHeSULll0Ktb1abfqwIBX4UClwA6JiZkPwcwuV1kd29H9czXUZvhXONjW0vHwYCxHL4AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTcXgl8e; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7240d93fffdso142923b3a.2;
        Thu, 14 Nov 2024 15:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731627678; x=1732232478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWOkzk9IX/VIC/wGI1eUw6NOMFS4iLtIIZiKC2APgog=;
        b=PTcXgl8erWjm0kC0nCKwPQV/IfZeq2n0a4YJ8zIbbFyBt/IqaDWBAKY0x+g5GBPTdp
         ZDB+eWpUVhDQMnhh40hmfnn72RjxtdFo3tdseGLHg7fxfIi4xZ9ooThHOF4LI+FJs4fo
         j8X8YaAVvJ/0egNOJIuZm8VCz8UEHTGuku7cQDgsVp6nvba/+B4iIyFDySknHBDM6AOD
         LmJ1z+xEboimHEi+cgxccrzZHv5g8oclroWCRPHCymOQcKjhQ5yMB/JfdpBRYMXeESOc
         KY6qF5P9rF2qRlmEzHmMupXkyvrIbQNKLBLsq63DNyT5G/89tpCjOkbHf9ayx3h1qM6C
         f3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627678; x=1732232478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWOkzk9IX/VIC/wGI1eUw6NOMFS4iLtIIZiKC2APgog=;
        b=LbNvMNNkafX6zlGFdQ9AIbVSXL+d8G+kTBNAWX09hUHI3Cojwj+Xzzo9Y6MYUCkyy6
         nv816mcLe1KncKzwYPwDWWOUS7NrWBfcREueiQizETAlP0dQ0y/Z4NiAJOMARwvtmuIO
         sOJASj0EOFo7n1/y3BwE4NqMCqnYShaly6+7q8350P3zS4eZoKQYt6GKmRdjuRGxcUyz
         ARu9DadZy21j4SFFtKIcvPObM0HEyP1kQskgv1V9t3MtSshNhRp12XWFnA90pDYTVz4o
         SE08iQMZ5zoNCUj5ZhFinLJukt6VRKat39waBgkw5imFpmXBJoX5twskgh9JS0nOfC2l
         PlDg==
X-Forwarded-Encrypted: i=1; AJvYcCUNX1s1QpBgxDsJU4vMQI9n4+TvkJsRaz+JkZ8bAjDvZy707d3g+AEBJHhJb739JdZR9zs=@vger.kernel.org, AJvYcCWv2dXrWsdv2Q8dCsdwN3YhjOvXQAL3vYvJv8X+zaPuvBXBlbwZwILydZ9fF5fU8gfLZTEyrtmKVTj8P1Jw@vger.kernel.org, AJvYcCXEvzP6IQRA0Yvh/58455KxukJxVDN/hb42XIppQOtpaDL2Z4EzN2L+16PMbMZ7my7Z6jR0MlbWh4V8KGOz5cEvQ6qp@vger.kernel.org
X-Gm-Message-State: AOJu0YywkguJo7sZqFOfCK3KHOMOn6+HMhcXJbjj7QVs22ZHiz3yviwA
	zYkzO0dw+oNBb1lQYYYJ3qCAA0XnGcEvWizRqTnzrUIuwnSbfD+3y7noDnu83i7DGwDphJAQNgK
	kDWVB/41xr5eVloveHIRUmmOgRkQ=
X-Google-Smtp-Source: AGHT+IGAMEVC6FYqpkx71XyUtxmC/kq4Od6rEDPLTdOVqFkPsGey+JX48FtyQiiebld0Fp3BoizP3Q9fUfNIyyw1X+U=
X-Received: by 2002:a17:90b:48c4:b0:2e2:bd7a:71ea with SMTP id
 98e67ed59e1d1-2ea154cf3c7mr1035285a91.8.1731627677858; Thu, 14 Nov 2024
 15:41:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-4-jolsa@kernel.org>
In-Reply-To: <20241105133405.2703607-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 15:41:03 -0800
Message-ID: <CAEf4BzbM+warM65tnYampngqOGzQ-FS7frH88Hayx7veMjpjZA@mail.gmail.com>
Subject: Re: [RFC perf/core 03/11] uprobes: Add len argument to uprobe_write_opcode
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding len argument to uprobe_write_opcode as preparation
> fo writing longer instructions in following changes.

typo: for

>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  3 ++-
>  kernel/events/uprobes.c | 14 ++++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 28068f9fcdc1..7d23a4fee6f4 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -181,7 +181,8 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
>  extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> -extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_st=
ruct *mm, unsigned long vaddr, uprobe_opcode_t);
> +extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_st=
ruct *mm,
> +                              unsigned long vaddr, uprobe_opcode_t *insn=
, int len);

is len in sizeof(uprobe_opcode_t) units or in bytes? it would be good
to make this clearer

it feels like passing `void *` for insns would be better, tbh...



>  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset=
, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *u=
c, bool);
>  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprob=
e_consumer *uc);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index e9308649bba3..3e275717789b 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -471,7 +471,7 @@ static int update_ref_ctr(struct uprobe *uprobe, stru=
ct mm_struct *mm,
>   * Return 0 (success) or a negative errno.
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *m=
m,
> -                       unsigned long vaddr, uprobe_opcode_t opcode)
> +                       unsigned long vaddr, uprobe_opcode_t *insn, int l=
en)
>  {
>         struct uprobe *uprobe;
>         struct page *old_page, *new_page;
> @@ -480,7 +480,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
>         bool orig_page_huge =3D false;
>         unsigned int gup_flags =3D FOLL_FORCE;
>
> -       is_register =3D is_swbp_insn(&opcode);
> +       is_register =3D is_swbp_insn(insn);
>         uprobe =3D container_of(auprobe, struct uprobe, arch);
>
>  retry:
> @@ -491,7 +491,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
>         if (IS_ERR(old_page))
>                 return PTR_ERR(old_page);
>
> -       ret =3D verify_opcode(old_page, vaddr, &opcode);
> +       ret =3D verify_opcode(old_page, vaddr, insn);
>         if (ret <=3D 0)
>                 goto put_old;
>
> @@ -525,7 +525,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
>
>         __SetPageUptodate(new_page);
>         copy_highpage(new_page, old_page);
> -       copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
> +       copy_to_page(new_page, vaddr, insn, len);
>
>         if (!is_register) {
>                 struct page *orig_page;
> @@ -582,7 +582,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
>   */
>  int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, u=
nsigned long vaddr)
>  {
> -       return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
> +       uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
> +
> +       return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP=
_INSN_SIZE);
>  }
>
>  /**
> @@ -598,7 +600,7 @@ int __weak
>  set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigne=
d long vaddr)
>  {
>         return uprobe_write_opcode(auprobe, mm, vaddr,
> -                       *(uprobe_opcode_t *)&auprobe->insn);
> +                       (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_IN=
SN_SIZE);
>  }
>
>  /* uprobe should have guaranteed positive refcount */
> --
> 2.47.0
>

