Return-Path: <bpf+bounces-44892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8FF9C965C
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DD3B24B05
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 23:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51F1B4F0A;
	Thu, 14 Nov 2024 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7ifhL1m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49A1AF0AA;
	Thu, 14 Nov 2024 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627869; cv=none; b=QwPPb+FDAWucN7q5tBr2hn38iDCsMebeq8Jczgu1RqKXlBQ5ybYqz5jPpNvgy2O2d/Tw377k5fQJSNVxI2Qb2e59rH8J++hNJI7uUzbZsMbAUjdEzxJrSVmR9AT/xZxMOCUhiUdENb82KwVxXiHYx/HTUH29VHwbl4EoeON6aRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627869; c=relaxed/simple;
	bh=GR234zBpNcBoD/pJp9WP4uBBVruMLv1xZDuF06B5mEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSHGlXCY/Z74jFKSwLuTkN0zltKy8es1jZY3JPRXTitos3zXhqj99AJFTsTOJs+5ztcSkc+v58KZxQbtjUko1MnJgKUX+mXuZo2MGRUUzHEqhVQ2XLWGgQQpPWej3J5koWe/96WtO9zurlhyfLZrC0VHg8/sqZHNuwhL21XDN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7ifhL1m; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71ec997ad06so925310b3a.3;
        Thu, 14 Nov 2024 15:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731627867; x=1732232667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjOP5kTCHnrD1+M1LVzZFAiTUUabR1gQTzr55Tchjr0=;
        b=H7ifhL1mvud+BdWy8BaIzcnhwJ7CV4MlOdNVijGIOA5bN2ekmyXPrv9Dsc7Ijzwjcu
         tGu5TqvbhZsTRhO2+Xejv/snAKU6dFxRI21V8wFaze41Xjt0d4yaeUn8z6GSHYbsedtj
         ZniLW5lXKwLgXilhcEA+/Ik++rj2dbtAPwYFtD1B8mD/4DkDcCfzZKseIcqgRLQWOvtG
         mBb2XnliPNYyiHQcKo051o4vFLwvh5coPQHQDAPYYsxomYGE/C+bn17pByNK0e+xfGR5
         wBk7fNQEeHoZwpqiNbkLH5brWsP0Yk/I9ROt84XKj4gjtOca5tlRrEu6RWZZHEcP9JJA
         20kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627867; x=1732232667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjOP5kTCHnrD1+M1LVzZFAiTUUabR1gQTzr55Tchjr0=;
        b=u5muRoJ6arvdMkYUUHCsFxSSX06HP5meMGCj+rhqcWH76sqWFnNL2+D+sxw2MSZbvl
         sK5bRaSNbpY+yhyYdyRN9eNb8WaKd7xFma3w6/8Xdqr/pnFXC+Bb38KyHmQK5phRNaBt
         Evj+v/7ZFnbNkYw7YgduUZq3X+EuEJNCEIA4MlAnPqPGHWIY6mXqV9fjWSDKIZf6en0p
         7ReRqXzEjv08NMuZqpjkFDHTCX1R6z4xnu5ECVmDF/pdsIPnLDoDyEssgfcd3ZEJseQi
         93FWlcBvEaGmtEWrgYSZCyPcGD0sDhVLaS9mX+AoRiWllWkCI/g8jbRS/uykXAU2N1v8
         tCZw==
X-Forwarded-Encrypted: i=1; AJvYcCV0VbY0I8AUnieZ+xjl3XLohLwYE5hyCvIIGbE20/pl+aOu1TaGQtdK+sAoim2nx9k8t1L//Ju9naUS0qtrlV3Hgemm@vger.kernel.org, AJvYcCV5azG+iIZ7pNJh0t1i0vboKi/UQPieEA/Pbz3JstiRY8V4P0TwVpm/UvMT8HDnEE63bHy43+e4PimUowgN@vger.kernel.org, AJvYcCVGXCLoMl9w1em+Kc7p2ozlnwo3b2OUGdlDOCg0FiVd678kIE1KY6vJXTIgSveKqgvHjHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwarXG9SO24mDNdXBUZsk9aIePJQSCjjT0j7+O0yU2OP0D40ixF
	cRZYJpqenn28aCtj4RPUzU6SH8MfE6O7fwEaOLCwpr9TZBVn7ZNJZhXWepXeW0lwL52oqwsreLB
	6FJZWxsmW+T9xielV3xGFMO05D2w=
X-Google-Smtp-Source: AGHT+IHRo5oSn/zayyT93OELVc7qVyuxgGxdmHmb/wcr/wVTXcL7Eq56aFzr826TbfGsaj+Zh8X+u8FY/qPRRzVujKA=
X-Received: by 2002:a17:90b:1e43:b0:2da:9115:15ce with SMTP id
 98e67ed59e1d1-2ea154fc51emr1098575a91.15.1731627867244; Thu, 14 Nov 2024
 15:44:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-6-jolsa@kernel.org>
In-Reply-To: <20241105133405.2703607-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 15:44:14 -0800
Message-ID: <CAEf4BzYycU7_8uNgi9XrnnPSAvP7iyWwNA7cHu0aLTcAUxsBFA@mail.gmail.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe trampolines
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding interface to add special mapping for user space page that will be
> used as place holder for uprobe trampoline in following changes.
>
> The get_tramp_area(vaddr) function either finds 'callable' page or create
> new one.  The 'callable' means it's reachable by call instruction (from
> vaddr argument) and is decided by each arch via new arch_uprobe_is_callab=
le
> function.
>
> The put_tramp_area function either drops refcount or destroys the special
> mapping and all the maps are clean up when the process goes down.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  12 ++++
>  kernel/events/uprobes.c | 141 ++++++++++++++++++++++++++++++++++++++++
>  kernel/fork.c           |   2 +
>  3 files changed, 155 insertions(+)
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index be306028ed59..222d8e82cee2 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -172,6 +172,15 @@ struct xol_area;
>
>  struct uprobes_state {
>         struct xol_area         *xol_area;
> +       struct hlist_head       tramp_head;
> +       struct mutex            tramp_mutex;
> +};
> +
> +struct tramp_area {
> +       unsigned long           vaddr;
> +       struct page             *page;
> +       struct hlist_node       node;
> +       refcount_t              ref;

nit: any reason we are unnecessarily trying to save 4 bytes on
refcount (and we don't actually, due to padding)

>  };
>
>  extern void __init uprobes_init(void);
> @@ -219,6 +228,9 @@ extern int uprobe_verify_opcode(struct page *page, un=
signed long vaddr, uprobe_o
>  extern int arch_uprobe_verify_opcode(struct page *page, unsigned long va=
ddr,
>                                      uprobe_opcode_t *new_opcode, void *d=
ata);
>  extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void=
 *data);
> +struct tramp_area *get_tramp_area(unsigned long vaddr);

uprobe_get_tramp_area() to make it clear this is uprobe specific,
given this is exposed function?

and add that extern like we do for other functions?

> +void put_tramp_area(struct tramp_area *area);

uprobe_put_tramp_area() ?

> +bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 944d9df1f081..a44305c559a4 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -616,6 +616,145 @@ set_orig_insn(struct arch_uprobe *auprobe, struct m=
m_struct *mm, unsigned long v
>                         (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_IN=
SN_SIZE, NULL);
>  }
>
> +bool __weak arch_uprobe_is_callable(unsigned long vtramp, unsigned long =
vaddr)
> +{
> +       return false;
> +}
> +
> +static unsigned long find_nearest_page(unsigned long vaddr)
> +{
> +       struct mm_struct *mm =3D current->mm;
> +       struct vm_area_struct *vma, *prev;
> +       VMA_ITERATOR(vmi, mm, 0);
> +
> +       prev =3D vma_next(&vmi);
> +       vma =3D vma_next(&vmi);
> +       while (vma) {
> +               if (vma->vm_start - prev->vm_end  >=3D PAGE_SIZE &&
> +                   arch_uprobe_is_callable(prev->vm_end, vaddr))
> +                       return prev->vm_end;

shouldn't we try both `prev->vm_end` and `vma->vm_start - PAGE_SIZE`
as two possible places

> +
> +               prev =3D vma;
> +               vma =3D vma_next(&vmi);
> +       }
> +
> +       return 0;
> +}
> +
> +static vm_fault_t tramp_fault(const struct vm_special_mapping *sm,
> +                             struct vm_area_struct *vma, struct vm_fault=
 *vmf)
> +{
> +       struct hlist_head *head =3D &vma->vm_mm->uprobes_state.tramp_head=
;
> +       struct tramp_area *area;
> +
> +       hlist_for_each_entry(area, head, node) {
> +               if (vma->vm_start =3D=3D area->vaddr) {
> +                       vmf->page =3D area->page;
> +                       get_page(vmf->page);
> +                       return 0;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_a=
rea_struct *new_vma)
> +{
> +       return -EPERM;
> +}
> +
> +static const struct vm_special_mapping tramp_mapping =3D {
> +       .name =3D "[uprobes-trampoline]",
> +       .fault =3D tramp_fault,
> +       .mremap =3D tramp_mremap,
> +};
> +
> +static struct tramp_area *create_tramp_area(unsigned long vaddr)
> +{
> +       struct mm_struct *mm =3D current->mm;
> +       struct vm_area_struct *vma;
> +       struct tramp_area *area;
> +
> +       vaddr =3D find_nearest_page(vaddr);
> +       if (!vaddr)
> +               return NULL;
> +
> +       area =3D kzalloc(sizeof(*area), GFP_KERNEL);
> +       if (unlikely(!area))
> +               return NULL;
> +
> +       area->page =3D alloc_page(GFP_HIGHUSER);
> +       if (!area->page)
> +               goto free_area;
> +
> +       refcount_set(&area->ref, 1);
> +       area->vaddr =3D vaddr;
> +
> +       vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
DONTCOPY|VM_IO,
> +                               &tramp_mapping);
> +       if (!IS_ERR(vma))
> +               return area;

please keep a pattern, it's less surprising that way

    if (IS_ERR(vma))
        goto free_page;

    return area;

free_page:

> +
> +       __free_page(area->page);
> + free_area:
> +       kfree(area);
> +       return NULL;
> +}
> +
> +struct tramp_area *get_tramp_area(unsigned long vaddr)
> +{
> +       struct uprobes_state *state =3D &current->mm->uprobes_state;
> +       struct tramp_area *area =3D NULL;
> +
> +       mutex_lock(&state->tramp_mutex);
> +       hlist_for_each_entry(area, &state->tramp_head, node) {
> +               if (arch_uprobe_is_callable(area->vaddr, vaddr)) {
> +                       refcount_inc(&area->ref);
> +                       goto unlock;
> +               }
> +       }
> +
> +       area =3D create_tramp_area(vaddr);
> +       if (area)
> +               hlist_add_head(&area->node, &state->tramp_head);
> +
> +unlock:
> +       mutex_unlock(&state->tramp_mutex);
> +       return area;
> +}
> +
> +static void destroy_tramp_area(struct tramp_area *area)
> +{
> +       hlist_del(&area->node);
> +       put_page(area->page);
> +       kfree(area);
> +}
> +
> +void put_tramp_area(struct tramp_area *area)
> +{
> +       struct mm_struct *mm =3D current->mm;
> +       struct uprobes_state *state =3D &mm->uprobes_state;
> +
> +       if (area =3D=3D NULL)

nit: !area

> +               return;
> +
> +       mutex_lock(&state->tramp_mutex);
> +       if (refcount_dec_and_test(&area->ref))
> +               destroy_tramp_area(area);
> +       mutex_unlock(&state->tramp_mutex);
> +}
> +

[...]

