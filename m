Return-Path: <bpf+bounces-44888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 476AB9C9637
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFBF283266
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 23:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCF1B3954;
	Thu, 14 Nov 2024 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds6SIuS7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C31AF0BA;
	Thu, 14 Nov 2024 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627674; cv=none; b=FRfbIZPX9+ZDnRLziDbyGJcvgPFuTjQWMAuFTQOAK8XKXvIImJxDlk/hWuYSL17iis90rT36GI67BrZ3KFM5OXMhO/p7925FB7ZgSuqc42Hyp5WDUZ5A9d/mUvmsxDDKYa5VAKGsuKTT1ot/m9lCrb+kYC8QxS/O6nmKTXTIYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627674; c=relaxed/simple;
	bh=ylL+d7fyuCtcJwGj54NW7/qUOBNPHqH5K7VBWejg5p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2lqZRbTG284t0bhtFmn2ut/NXjST6643HIKyzMB1RKDc2HHCAe6lSFq0hDZQpTeeUiXZCW7lTBriWJ98RAE65LjIGZQf3rjNTKSky9z6FOyfd6IAQC0iZGuRZtduqLsbnYH+OGnijmebusrN0lVF225YQt+y9JkVH/YjIqCP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds6SIuS7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so818279b3a.1;
        Thu, 14 Nov 2024 15:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731627672; x=1732232472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+/NvY5tVdBmQUZb33MAC3QKS9VGHEF59/xEUPDlkuA=;
        b=ds6SIuS7/T1kFvh9zafEJZEvdY1KYCOyL9BMZzxqspNQ8KCTiI1yIIIexpDSXrxLf6
         r2obLxotnAQ+cr/kVaw0nRaOXz9CExc5LO7XXrupxdRV8XuoNIiC0/OsHu9sGywCh9Hu
         NZyhWR9yT9KQe/nkwCyEyhEg+EtUOMBeqlRummW3XVn6UgDOrh9+alb+vRT7Bt0u7Y8E
         eyp8pAWUxCzOgeLnyMFAEQ0bdbLlox9gorNeF1jdNx4D2zX5+Onuyn4L9m1TB/fl/GGx
         70qGx5XgrTzZtuYk9HNj3w7W70yrX5aH+MQ72aMK6J3WifzkQQXuZeUku2DYdAMuMVQh
         6y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627672; x=1732232472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+/NvY5tVdBmQUZb33MAC3QKS9VGHEF59/xEUPDlkuA=;
        b=ew9rDCWSq/+GXfeL1bOfMXq+5qYN5nBV7Vtr6Mmz4XjhXXOcFb3NSrb6Ug8pSnzv1r
         25l3X1GUvV3Z0j6kiHkcCvcl8JyhWziNOnO5WbhNg+WqlETYXt1ztMBVBO7lEwK3bGXu
         MLmEA8ZMPy/YB5qa3q44/DvpYtZ1zjNTUefjQHvz1JYGS0Q80vWSL/axuOIgKkdhg/+5
         01kOi8YYuxTElwmyp1/wpg2IxGuQe5HUtrEN/yf4Y9URlkr7D68lehWGpT6cKjM4D1Uv
         8U6eOImdxbjuLCgOW7n04Zp04/VGfzHl7wX0U6G8lhvGK1IoBGA+KWgi351m5KQh8mQc
         nPTA==
X-Forwarded-Encrypted: i=1; AJvYcCUtFMBPMf7CG1VeeWlZ8Y4apavDTW8THXhF8QkmmT8yqs5Zns7zG2lhBVJUWAfl9+/Bu0c=@vger.kernel.org, AJvYcCVv271SCr/Wtp7hqQEbYHrBPGdVYke1rPDH9SSto1FBqVOMmJZDH6yYHJU8osL9Ivwrve9jFj0RXx84QhCM@vger.kernel.org, AJvYcCWpbLSaH8Rrez9j2MnBt3rZT3LfMvPBafXZRGuAJRHCqo8pI1kg/D6Pxraov8eaMOk0nMj1jTxLTrCH/G+ISQdW9YRr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzts1V8mU0QmDLbzEyuSsXeHths7+kHWSbRp+f2FI0CydvkqqAl
	gpPDmEPs6gs6UL+3rgwUIUF3lJM2U2JV6JatsSiFlgB1BJolUfd28FWovd9zRk3ZRqTvaF8cMYJ
	DkqAvM8Mi5XGQdSLlbPKqxYRfEzw=
X-Google-Smtp-Source: AGHT+IFEEsZ4IDHutvsVqw1fgB/8JKSvzp4q8l/43owUzQWjSJS0H062X3NdlUN5KSdNoA9stxrUcYk4PvKnFjLq1GA=
X-Received: by 2002:a17:90b:3b85:b0:2e2:effb:618b with SMTP id
 98e67ed59e1d1-2ea154f74bdmr947212a91.13.1731627671908; Thu, 14 Nov 2024
 15:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-3-jolsa@kernel.org>
In-Reply-To: <20241105133405.2703607-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 15:40:58 -0800
Message-ID: <CAEf4BzaqbBPmCvW5m8VCpxoKMu8B=1yYxAJ64m9gtS=Tg5Rz7g@mail.gmail.com>
Subject: Re: [RFC perf/core 02/11] uprobes: Make copy_from_page global
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
> Making copy_from_page global and adding uprobe prefix.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  1 +
>  kernel/events/uprobes.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 2f500bc97263..28068f9fcdc1 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -213,6 +213,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, =
unsigned long vaddr,
>  extern void uprobe_handle_trampoline(struct pt_regs *regs);
>  extern void *arch_uretprobe_trampoline(unsigned long *psize);
>  extern unsigned long uprobe_get_trampoline_vaddr(void);
> +extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr=
, void *dst, int len);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 0b04c051d712..e9308649bba3 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -250,7 +250,7 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
>         return is_swbp_insn(insn);
>  }
>
> -static void copy_from_page(struct page *page, unsigned long vaddr, void =
*dst, int len)
> +void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void =
*dst, int len)
>  {
>         void *kaddr =3D kmap_atomic(page);
>         memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
> @@ -278,7 +278,7 @@ static int verify_opcode(struct page *page, unsigned =
long vaddr, uprobe_opcode_t
>          * is a trap variant; uprobes always wins over any other (gdb)
>          * breakpoint.
>          */
> -       copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
> +       uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_=
SIZE);
>         is_swbp =3D is_swbp_insn(&old_opcode);
>
>         if (is_swbp_insn(new_opcode)) {
> @@ -1027,7 +1027,7 @@ static int __copy_insn(struct address_space *mappin=
g, struct file *filp,
>         if (IS_ERR(page))
>                 return PTR_ERR(page);
>
> -       copy_from_page(page, offset, insn, nbytes);
> +       uprobe_copy_from_page(page, offset, insn, nbytes);
>         put_page(page);
>
>         return 0;
> @@ -1368,7 +1368,7 @@ struct uprobe *uprobe_register(struct inode *inode,
>                 return ERR_PTR(-EINVAL);
>
>         /*
> -        * This ensures that copy_from_page(), copy_to_page() and
> +        * This ensures that uprobe_copy_from_page(), copy_to_page() and

rename copy_to_page() for symmetry?


>          * __update_ref_ctr() can't cross page boundary.
>          */
>         if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
> @@ -2288,7 +2288,7 @@ static int is_trap_at_addr(struct mm_struct *mm, un=
signed long vaddr)
>         if (result < 0)
>                 return result;
>
> -       copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
> +       uprobe_copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE=
);
>         put_page(page);
>   out:
>         /* This needs to return true for any variant of the trap insn */
> --
> 2.47.0
>

