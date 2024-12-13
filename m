Return-Path: <bpf+bounces-46794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255D9F013A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D01C16285B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568565227;
	Fri, 13 Dec 2024 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk/9+3RD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9384C6E;
	Fri, 13 Dec 2024 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050649; cv=none; b=GBttZfH8HF9v/RwR61oAk4429Eg7i8++mnTSJa3XJmJYeN6s1XXfqzyQiDf5vf/zsavI6Yh7NVeiOyBiP5JSgC+KebiiHJNVi0jihcHDkvWrsNX324pyGO8FaoOHitF2hL5P4oEbLB3iztM6eHMwmj4narp6tt18TVrBqVhVS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050649; c=relaxed/simple;
	bh=aOSMa+AdJ34zgKRMhyEAUKdyNr/lms4nAbvXt2nvhkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uis/wzcJG22JdDtoxuSDb3xz/yknIZ5gWcYtgxOo20hjUpI+SAfTesZZd7OSzWCfZVmpJZxkTirVQq9MYJIz0w+loAQeu/u6/+PQOl0s4xGaxXtrk6vyKahZYy4r9mio8y6fBqQPaw1QYw1bL0O2AJj+Dx7/wiQtj653ZQYzMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk/9+3RD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161eb94cceso8856885ad.2;
        Thu, 12 Dec 2024 16:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734050647; x=1734655447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKcrrTpyHQ1moVny8/QnD6i+L2A4ool/D10bx2vH8AY=;
        b=lk/9+3RD312MUsafQnShwOvkBJbiJbJ3ie/iq1qb75a0Pwl2+N67ZAzW4Q/lH5VP8C
         6WztOye3h5Gu14J92l1EuO+aDUUdO4m6h4FWXHRsSenDVFWWPsTi7bQvqLhAhLpwC9Nt
         NNdbiQt6IUIF1Z18zaxnHOfXnvya9jPJoULhxZmmx/4Su97M3idm9+7zKFApzHKY0TQT
         OaA8ht5ZGUM7MWGnq9MSE5afhBYNzORjsY4v6+LQSvYNwUk0DXml3RCXObAh4GKfIJAV
         3oRl1R8W4EMhLmVbEertJQ2zTr20IvJArwmHUYhVryehw0P7MmcN3ODX+f91D1d7R3mC
         kEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050647; x=1734655447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKcrrTpyHQ1moVny8/QnD6i+L2A4ool/D10bx2vH8AY=;
        b=BYl3SrE5wIGvd4pQnK/b2VLb18XXkJmOGLNPu704cUcr1FoBklqF+6vSUjlQ0pcIum
         tZyInywneyCSr9A/EvUs+EVvV6MEhdwKiisLKgEXXikuu0Biuzqk5Kikcm/wZpl8n/f/
         KUDqE7QSJfh9usoseFJdaCO+ft8wbDt9PYADEB1FsjLZzDYg0RD8tXzXdQuMOgfOK88T
         H4HXFztQH93HO9Svi3dnpuihkQ51OLTH7Mf4Dcv8OE+4zll8jEmHrmxBKau9pyHNZdWc
         0XathqVBpxD7Dibt0fOpYcv14t2yN6zgALEhxoFmpp0nBdOgfLe+tE9s1wdDpvYHDFpY
         38dg==
X-Forwarded-Encrypted: i=1; AJvYcCULU2Mbn3Rv8S9CdGRl+TO/+dHqD8KFm3UO9rMotGyKoszZqcUu6eKWUyCe2FxkZQN8E0Q=@vger.kernel.org, AJvYcCXoxM5DGf6nY5s47dGWg0+BBrhgtsEuU7h4A7gnyMA/Z7WEuUA2WkvpXJVadzh4IR1k/UPTcueije1iNMwyti3JJHq9@vger.kernel.org, AJvYcCXpiHZplosHRTX4Whk8WAWdWjjHAXFSqt78R2l/NAe0pLRX4HM4iTFbqnOYTRFkD3BlFtNx21EHur4xzWVN@vger.kernel.org
X-Gm-Message-State: AOJu0YyJS76UmAAss4rX7i/UcUl+SNj4eS7ZvMQ+Of6qgm3Q37p0BIS6
	hRP3awF/LB28x6RX2ea0muAwC/VWZ5pakD7cK8z4A4VNAk4s6P8kF3Kc19ZTJb/FmeGcDXeFXFq
	9msqmtPWoUpGcSrF8vgkKvPI0Gpk=
X-Gm-Gg: ASbGncvsF301dffHGiblw2WptqGOBWHFf721N4lGcKZ2YSuVbzHKrWwGc7ZnIHZunqm
	PAWioYIy7Pm7QjIFpT4fPffP4/uWe/ao3cQkI7jC595vD1O1GayBhSA==
X-Google-Smtp-Source: AGHT+IE5YnTbduEEk4n5sPQ8xoFfikN8jmbNhgHcXcq9epbSJl3R4EZEV5hVCZh44r8Wo7dj55M3Zg3ksgExjMDDDs8=
X-Received: by 2002:a17:90b:3c8a:b0:2ee:dd9b:e3e8 with SMTP id
 98e67ed59e1d1-2f28fb50798mr1261734a91.8.1734050647542; Thu, 12 Dec 2024
 16:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-3-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 16:43:54 -0800
Message-ID: <CAEf4BzaCHaP9wEOCQpaRfMc9Bpj8LBrUQ-cE3oE+Mki5vfngZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/13] uprobes: Make copy_from_page global
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Making copy_from_page global and adding uprobe prefix.
> Adding the uprobe prefix to copy_to_page as well for symmetry.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  1 +
>  kernel/events/uprobes.c | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 09a298e416a8..e24fbe496efb 100644
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
> index e0e3ebb4c0a1..61ec91f635dc 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -249,14 +249,14 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
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
>         kunmap_atomic(kaddr);
>  }
>
> -static void copy_to_page(struct page *page, unsigned long vaddr, const v=
oid *src, int len)
> +static void uprobe_copy_to_page(struct page *page, unsigned long vaddr, =
const void *src, int len)
>  {
>         void *kaddr =3D kmap_atomic(page);
>         memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
> @@ -277,7 +277,7 @@ static int verify_opcode(struct page *page, unsigned =
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
> @@ -524,7 +524,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
>
>         __SetPageUptodate(new_page);
>         copy_highpage(new_page, old_page);
> -       copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
> +       uprobe_copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SI=
ZE);
>
>         if (!is_register) {
>                 struct page *orig_page;
> @@ -1026,7 +1026,7 @@ static int __copy_insn(struct address_space *mappin=
g, struct file *filp,
>         if (IS_ERR(page))
>                 return PTR_ERR(page);
>
> -       copy_from_page(page, offset, insn, nbytes);
> +       uprobe_copy_from_page(page, offset, insn, nbytes);
>         put_page(page);
>
>         return 0;
> @@ -1367,7 +1367,7 @@ struct uprobe *uprobe_register(struct inode *inode,
>                 return ERR_PTR(-EINVAL);
>
>         /*
> -        * This ensures that copy_from_page(), copy_to_page() and
> +        * This ensures that uprobe_copy_from_page(), uprobe_copy_to_page=
() and
>          * __update_ref_ctr() can't cross page boundary.
>          */
>         if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
> @@ -1856,7 +1856,7 @@ void __weak arch_uprobe_copy_ixol(struct page *page=
, unsigned long vaddr,
>                                   void *src, unsigned long len)
>  {
>         /* Initialize the slot */
> -       copy_to_page(page, vaddr, src, len);
> +       uprobe_copy_to_page(page, vaddr, src, len);
>
>         /*
>          * We probably need flush_icache_user_page() but it needs vma.
> @@ -2287,7 +2287,7 @@ static int is_trap_at_addr(struct mm_struct *mm, un=
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

