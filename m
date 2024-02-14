Return-Path: <bpf+bounces-22035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5DE855659
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 23:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED9F1C21EDC
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14764502D;
	Wed, 14 Feb 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovj9ljpj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD905182DF;
	Wed, 14 Feb 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951126; cv=none; b=cq6y+PWJmRs8pMBPn4O4mNgclVKOQAmbXBS6+SlyKEd1LJho8LthLOgqJ09uP/9ZxGwLU2g3kKk1QnEe/6VXbAd2G1YaolLeaSIcLLMuevIuCATn0rGN/+T+oQzvXYXTA1WxtjUc8Ats1ZFaykSsgCMOUA84GU/9+vdTOalEQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951126; c=relaxed/simple;
	bh=u09PV9YbBb9hMy1rCPxXxP9YHVWOw9esnqZGdmRe0G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIGwmB1+TDQie3xur2AKVHnZ08Hsr6W26+W9/KY2apJMk5WXN+1wzoN9uY0mL0YAUx6pA59acLqkugvsTq3gRPEQIfpJLkboA8Sfz3sOSrY6yIqR0GUeGhHTI5WlvLmqXc+cTw22x1eZmfth6N9ac4P7zhUilQY2hXFEuMbWP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovj9ljpj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33934567777so99557f8f.1;
        Wed, 14 Feb 2024 14:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707951123; x=1708555923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ51eSPqqPDCFvp0TDSFvQ80BT6J5ZmQ2kvwhoUpX+E=;
        b=Ovj9ljpjlH/XyH63Wtu1PqDK21IGBY2ejK62EM0KizPQaW3lVz9CnMla/HuGA5Nd5Y
         CEGg+OqXpAdQR4W6XSzmDW0MDIMXY40D6V0ZLoF8uv2yPSRAQIhMz/GEOQwzovNl4kV3
         AjMILDpQ9MT84TEbuwDlaLr3vktXxi5YArn1xQNptKzwWLvIunLHtDuAH9tM9M3i49hg
         rfCSb5UxyCla9h55+n//kZIXwuSgVhufs6K9biVHjcQikUH/vahQK0zk/sFAqw7mWlAg
         skHujKnophKMGfhCbNn+Fnb7q5gzg6LphjYkiBYjgrQArMJahJrMfPwosAAyWrGKwEgd
         CJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951123; x=1708555923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQ51eSPqqPDCFvp0TDSFvQ80BT6J5ZmQ2kvwhoUpX+E=;
        b=m4zZ8dklX0eYNZWTPryzgH6Rsdt4mVCM6n6zFxaskP+vipKxzr/RJ5Jj1bGn+dc+IK
         d8DIkQM6uBDqnjdh9ay/0ab4QadA/6+fUvuMUBEAapmx6Cdq3ycGI8eCDgb0RB8oiAx2
         /P/XzRy/GyAiQx2xZMsk2oSIrz00hORFvxOgJScBiVQd4wJ1l9TkNcnPlLJ27cM4QZAB
         cXTxSLR61DFBcjd0NhvPd2lHfkN4yyhhcVNUeSTmwN28aoXapKrkyQp4J5nNPussQhc7
         21Wm+u2SOv+D3enEhJVUaBtOzmmd5sa1yz21hwfshCjB/+5zTs7VOxP/ezoEUCOJDNmk
         iZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPmTyc+8VF8mKN7+L06udbh/ER0/t/5iU0PD0WbpP/QEfD3IpCePKQPMha5axW1VVfEAwJds4jyfZHu48+Zhha9tCMwJzba5uEYLJLtyhoZg8oxBbmo1naK6BIMjA0ekSH
X-Gm-Message-State: AOJu0Yy27dAnNCKudfsN5NTHEelHa/5L1CdX36EgbNua6ELHGHUfywos
	Gfxnn69KrwKEqgk7RZleCqBr6JGEDg7hx3+D8W/0uaDvoUQZ0zdy316mJITkQS6misE2iH1ZH1F
	Rg1XhnYulFqr35aZe5wJ88Xo27Ck=
X-Google-Smtp-Source: AGHT+IHnlQU4HFey720O/neAbzq4u7yDtbjLSoM696QDkEhKyq8MSwDD9Js+9A6XtBi9LShYLh/3FPdKitff8sbQV/A=
X-Received: by 2002:adf:eec5:0:b0:33b:74a3:dcfe with SMTP id
 a5-20020adfeec5000000b0033b74a3dcfemr25991wrp.14.1707951122714; Wed, 14 Feb
 2024 14:52:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202103935.3154011-1-houtao@huaweicloud.com>
 <20240202103935.3154011-3-houtao@huaweicloud.com> <eacdea9b-4d4c-4833-b7a4-ac0b042c9efa@intel.com>
In-Reply-To: <eacdea9b-4d4c-4833-b7a4-ac0b042c9efa@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Feb 2024 14:51:51 -0800
Message-ID: <CAADnVQK8avOCKuqE2g__WOKzTKCAqdphxjncvXuEQ801g8jf-g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
To: Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Hou Tao <houtao@huaweicloud.com>, X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, 
	xingwei lee <xrivendell7@gmail.com>, Jann Horn <jannh@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:03=E2=80=AFAM Sohil Mehta <sohil.mehta@intel.com>=
 wrote:
>
> On 2/2/2024 2:39 AM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > When trying to use copy_from_kernel_nofault() to read vsyscall page
> > through a bpf program, the following oops was reported:
> >
> >   BUG: unable to handle page fault for address: ffffffffff600000
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   PGD 3231067 P4D 3231067 PUD 3233067 PMD 3235067 PTE 0
> >   Oops: 0000 [#1] PREEMPT SMP PTI
> >   CPU: 1 PID: 20390 Comm: test_progs ...... 6.7.0+ #58
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
> >   RIP: 0010:copy_from_kernel_nofault+0x6f/0x110
> >   ......
> >   Call Trace:
> >    <TASK>
> >    ? copy_from_kernel_nofault+0x6f/0x110
> >    bpf_probe_read_kernel+0x1d/0x50
> >    bpf_prog_2061065e56845f08_do_probe_read+0x51/0x8d
> >    trace_call_bpf+0xc5/0x1c0
> >    perf_call_bpf_enter.isra.0+0x69/0xb0
> >    perf_syscall_enter+0x13e/0x200
> >    syscall_trace_enter+0x188/0x1c0
> >    do_syscall_64+0xb5/0xe0
> >    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >    </TASK>
> >   ......
> >   ---[ end trace 0000000000000000 ]---
> >
> > The oops is triggered when:
> >
> > 1) A bpf program uses bpf_probe_read_kernel() to read from the vsyscall
> > page and invokes copy_from_kernel_nofault() which in turn calls
> > __get_user_asm().
> >
> > 2) Because the vsyscall page address is not readable from kernel space,
> > a page fault exception is triggered accordingly.
> >
> > 3) handle_page_fault() considers the vsyscall page address as a user
> > space address instead of a kernel space address. This results in the
> > fix-up setup by bpf not being applied and a page_fault_oops() is invoke=
d
> > due to SMAP.
> >
> > Considering handle_page_fault() has already considered the vsyscall pag=
e
> > address as a userspace address, fix the problem by disallowing vsyscall
> > page read for copy_from_kernel_nofault().
> >
> > Originally-by: Thomas Gleixner <tglx@linutronix.de>

Thomas,

could you please Ack the patch if you're still ok with it,
so we can take through the bpf tree to Linus soon ?

Not only syzbot, but real users are hitting this bug.

Thanks!

> > Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/bpf/CAG48ez06TZft=3DATH1qh2c5mpS5BT8Uak=
wNkzi6nvK5_djC-4Nw@mail.gmail.com
> > Reported-by: xingwei lee <xrivendell7@gmail.com>
> > Closes: https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsji=
W+UWLoB=3Dw33LvScw@mail.gmail.com
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  arch/x86/mm/maccess.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
>

