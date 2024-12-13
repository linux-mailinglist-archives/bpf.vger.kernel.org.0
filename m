Return-Path: <bpf+bounces-46797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E881D9F0171
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40F42858A0
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1698125D6;
	Fri, 13 Dec 2024 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MapgZhGX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01BE4A06;
	Fri, 13 Dec 2024 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734051726; cv=none; b=Q4vpFKHh6LtgETKxk+RJoo4xB64FG8CI9h3UYh58v/iJlHmTN9WS+4LAKVc3B1rK4ssSe8NuTUxnWErhtOPYhXhPJwRiN3TeWoP2D+iCN+duvA+PDY2VoZlxWGYsCTQ0qLi+q/HhmRzgPujivjj8Y8Ci2k4UnrsrBnThMWgVdTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734051726; c=relaxed/simple;
	bh=Kym6VrYxHrsEryNYEUHq15JGnm+oHt/W/iIQnRQvpSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTbXft9nhqGWY6YxFNl3XerSZ7JdnBafB09oWbXhNr2sCyy+Xe1dN0/ALsGnmvoI4cG7roKAPR2HDCrV79emD+gpRbCthhB23QStuuZk/fqYZ7c7rg+cdv8WKB8EFA725esa+HPLQr5cn6q/8T/2oFtL0FO/KFWDBtNDTmLyv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MapgZhGX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fc93152edcso1040612a12.0;
        Thu, 12 Dec 2024 17:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734051724; x=1734656524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRPjkEFYECNCam+aAk3MjBT2kOPT+USpYazr/q3Cmlk=;
        b=MapgZhGXpsIjtxE7pI45DeZxiMxpZCc957eRZKxaKO7scDobIWPw3/sBG+REbLb5fe
         z0c/kjU6XPW1x10fF28vuw3hWLpU4luExZVEgTSpOVEfTGL0LKSPFb0RVypeUepp/lXY
         nvj5hUqYzdTWMK7BV4nkyqLUjx1ye86QI4Y6hBvqAOBcd1Keb5xHEeQ4zmt7oaAblEeg
         CqCF/hK7M34M9dWdlEZPIAlpr6vyIVTyRAMzjGk8Z+0h8IDKJ+uoTTLJiq8aYThbAWL8
         8WMWCQb+jAI7yHI3u5dR6Wu6MsKUoF4qxmHU+jNHUtdnC/FMTGADvLC/Wn9DGly6PDdg
         WjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734051724; x=1734656524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRPjkEFYECNCam+aAk3MjBT2kOPT+USpYazr/q3Cmlk=;
        b=u+v2JYwIk54nVn1gjkepyIseN1kZ8qdhk/c83sQcuYd4pOvpMqeRHAXAEz3K5QNvw+
         PPQbmA3faeN8q8uLpl7ONRjJ/ZUwRKsJjPRZKT/XqeqdPy7GC6M8cWRJhLB3r2/wJOmy
         qVx3VDHm/0obCQ+OXqE78hsgpnYLnQ8mdE0jYueDl5NgT2K/o0CYuo8d+jBTts3wcxdQ
         OpWX+a4arJf+4KWnVaxNpSFhEtjBpUON2pwY8iFV57CnljBrnCmUdKOp2g9/2frGTFk/
         NbpQfAleZdNVLC2oqH0vCBkT0XcFY9VLsTlKg6oFOjCJgwt4fOU13mMNvCIDCxJlWPB+
         8JXw==
X-Forwarded-Encrypted: i=1; AJvYcCUtdiiCA8h/SkZhSiwHSj4QJEDgIA3m5Keiw8ABEb1bhrqfFlUoC5sDui6bp8IrjDOTCho=@vger.kernel.org, AJvYcCXXyAObnAkK9iRCLM3yUYV/ErwWYjcdEGhQyjUPFaHmQX8VoC0tLjzrBvyKNSVuI9Lf2GMLkqh4kNKOLi9s@vger.kernel.org, AJvYcCXjMMVRATE0oPH7zpkCUW7coh6qRK94QJUX0DbVT9y7vfGM0fvUWllQ30o8WAgMFhtilWYOMtgLeTeGILmXQIC/LBzg@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmrSAL2EGuVoMd5wMJ6LSMq+XaWQjqm+6O/R0+oPdGbBFLBui
	yj4a6pyfByEWtrxmnNGyllUe2VhzQQvsoblGWhtIV3dr0R5ZVdfh0I01/u5U8fGAgxrr+WY7wln
	GiLjF8OrE/1+eqOrODfWemGMC9VM=
X-Gm-Gg: ASbGnctIthxZzf1hG2zXun5o15z9rnnuLLrp5BfwfQoQQ3MUEEFWSOt0ldL/66KI21w
	8nzb4XjcKQjcJKLl8unqR5I+ai/CHBxoHOqj4zyS1PaplEkZhcs0FXg==
X-Google-Smtp-Source: AGHT+IH95GED+20NT/CsLYu+Njap3yr1GP2+NSdRYG1CdE2HycgDJDRSAz7eRwBRpVO9Cc0Hrq+CWLwksAMxDL7GHJo=
X-Received: by 2002:a17:90b:17c3:b0:2ee:9661:eafb with SMTP id
 98e67ed59e1d1-2f2919ba2dfmr857330a91.12.1734051723977; Thu, 12 Dec 2024
 17:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-6-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 17:01:52 -0800
Message-ID: <CAEf4BzZEPdGxjHjPGr-4qKFju+roOiAVrMhTuviozmcP1-qojw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/13] uprobes: Add mapping for optimized uprobe trampolines
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to add special mapping for for user space trampoline

typo: for for

> with following functions:
>
>   uprobe_trampoline_get - find or add related uprobe_trampoline
>   uprobe_trampoline_put - remove ref or destroy uprobe_trampoline
>
> The user space trampoline is exported as architecture specific user space
> special mapping, which is provided by arch_uprobe_trampoline_mapping
> function.
>
> The uprobe trampoline needs to be callable/reachable from the probe addre=
ss,
> so while searching for available address we use arch_uprobe_is_callable
> function to decide if the uprobe trampoline is callable from the probe ad=
dress.
>
> All uprobe_trampoline objects are stored in uprobes_state object and
> are cleaned up when the process mm_struct goes down.
>
> Locking is provided by callers in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  12 +++++
>  kernel/events/uprobes.c | 114 ++++++++++++++++++++++++++++++++++++++++
>  kernel/fork.c           |   1 +
>  3 files changed, 127 insertions(+)
>

Ran out of time for today, will continue tomorrow for the rest of
patches. Some comments below.

The numbers are really encouraging, though!

> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 8843b7f99ed0..c4ee755ca2a1 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -16,6 +16,7 @@
>  #include <linux/types.h>
>  #include <linux/wait.h>
>  #include <linux/timer.h>
> +#include <linux/mutex.h>
>
>  struct uprobe;
>  struct vm_area_struct;
> @@ -172,6 +173,13 @@ struct xol_area;
>
>  struct uprobes_state {
>         struct xol_area         *xol_area;
> +       struct hlist_head       tramp_head;
> +};
> +

should we make uprobe_state be linked by a pointer from mm_struct
instead of increasing mm for each added field? right now it's
embedded, I don't think it's problematic to allocate it on demand and
keep it until mm_struct is freed

> +struct uprobe_trampoline {
> +       struct hlist_node       node;
> +       unsigned long           vaddr;
> +       atomic64_t              ref;
>  };
>
>  extern void __init uprobes_init(void);
> @@ -220,6 +228,10 @@ extern int arch_uprobe_verify_opcode(struct arch_upr=
obe *auprobe, struct page *p
>                                      unsigned long vaddr, uprobe_opcode_t=
 *new_opcode,
>                                      int nbytes);
>  extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes);
> +extern struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vad=
dr);
> +extern void uprobe_trampoline_put(struct uprobe_trampoline *area);
> +extern bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long =
vaddr);
> +extern const struct vm_special_mapping *arch_uprobe_trampoline_mapping(v=
oid);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 8068f91de9e3..f57918c624da 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -615,6 +615,118 @@ set_orig_insn(struct arch_uprobe *auprobe, struct m=
m_struct *mm, unsigned long v
>                         (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_IN=
SN_SIZE);
>  }
>
> +bool __weak arch_uprobe_is_callable(unsigned long vtramp, unsigned long =
vaddr)

bikeshedding some more, I still find "is_callable" confusing. How
about "is_reachable_by_call"? slightly verbose, but probably more
meaningful?

> +{
> +       return false;
> +}
> +
> +const struct vm_special_mapping * __weak arch_uprobe_trampoline_mapping(=
void)
> +{
> +       return NULL;
> +}
> +
> +static unsigned long find_nearest_page(unsigned long vaddr)
> +{
> +       struct mm_struct *mm =3D current->mm;
> +       struct vm_area_struct *vma, *prev;
> +       VMA_ITERATOR(vmi, mm, 0);
> +
> +       prev =3D vma_next(&vmi);

minor: we are missing an opportunity to add something between
[PAGE_SIZE, <first_vma_start>). Probably fine, but why not?

> +       vma =3D vma_next(&vmi);
> +       while (vma) {
> +               if (vma->vm_start - prev->vm_end  >=3D PAGE_SIZE) {
> +                       if (arch_uprobe_is_callable(prev->vm_end, vaddr))
> +                               return prev->vm_end;
> +                       if (arch_uprobe_is_callable(vma->vm_start - PAGE_=
SIZE, vaddr))
> +                               return vma->vm_start - PAGE_SIZE;
> +               }
> +
> +               prev =3D vma;
> +               vma =3D vma_next(&vmi);
> +       }
> +
> +       return 0;
> +}
> +

[...]

> +struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
> +{
> +       struct uprobes_state *state =3D &current->mm->uprobes_state;
> +       struct uprobe_trampoline *tramp =3D NULL;
> +
> +       hlist_for_each_entry(tramp, &state->tramp_head, node) {
> +               if (arch_uprobe_is_callable(tramp->vaddr, vaddr)) {
> +                       atomic64_inc(&tramp->ref);
> +                       return tramp;
> +               }
> +       }
> +
> +       tramp =3D create_uprobe_trampoline(vaddr);
> +       if (!tramp)
> +               return NULL;
> +
> +       hlist_add_head(&tramp->node, &state->tramp_head);
> +       return tramp;
> +}
> +
> +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> +{
> +       hlist_del(&tramp->node);
> +       kfree(tramp);

hmm... shouldn't this be RCU-delayed (RCU Tasks Trace for uprobes),
otherwise we might have some CPU executing code in that trampoline,
no?

> +}
> +

[...]

