Return-Path: <bpf+bounces-46792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEA9F0136
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97902188D258
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE44C6E;
	Fri, 13 Dec 2024 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTrd1rOh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C4523A;
	Fri, 13 Dec 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050592; cv=none; b=BXifMsyWq/wxwf04WKUIPmVSZ2zKQDYegu3Onmyw0KBDxHs2FifVKB7m88ZDLcIE+Gs8IWsF7xTnFqw0ncRTlQX0RRRB1Htjyz2f2ckVhLDvCtVW1PnGMfDg/7996l0mTepV8uP/iTibSbZbd3FaQyUAqZ4/NURzZEOFOHMsj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050592; c=relaxed/simple;
	bh=BCdglMHLexZMkCD6JqQlyBWW59OVFpvm4T+m7wx8Ceg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqB+x/4YA0aEXVCLmD57wKqKzSlSKRLvr4JyLZGzSdnd7bL1zb9frStyI9hstikbcMwMXxj7RSNZ0w7swKrhRNoXsG/pXqirnsNU4+avELKjp6Txp6wsXLgYd3UXFUIFqCUXfRrHttFdqOE8Anh3BGjuZpFigcA2RpnlhzkF6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTrd1rOh; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd526d4d9eso1069928a12.2;
        Thu, 12 Dec 2024 16:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734050590; x=1734655390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsJbGvzSa9/QB/jMdXB7TBTgWOMJ+LEfE/O1tMVjAS4=;
        b=YTrd1rOh10VaCSuE9aZXVEdahEX1LRJTrBwjpaSkWiFijfrhQyJ4YPx4Y5+muahGxU
         3wwDyKwHLJpReeMAGxZFhccZO46J8q8AhBwX3XbEGXMountTXlunri4uBbCZRUHqF2GZ
         b/6d3uzyftG/WaYtnjgaOa49x57Mf8ot0lt0P8cak8tQ91CToDfZFMZjkNbWeAe6Ab/X
         mkWQWDSuCDTE0nAFgAQQvlbf0wMEWtu4/i9I50phIRwjrjeOX+zKaeHQnnenTf/vbc1Q
         3POLhfl9VvGq7f8uKgjYwgWARkRX8NGdm3hEyEDvzaT9CFyGv2A2W0rnUB5/BGTUWdt8
         LPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050590; x=1734655390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsJbGvzSa9/QB/jMdXB7TBTgWOMJ+LEfE/O1tMVjAS4=;
        b=qVCkzv86myXcbN0g7fwNLmK7IbmtPYPFnipsZJ/qKm8LUol3lfedZfifHMVmYD0IVU
         GOqWFIZjVu9p4KJ78Q1S146POJZlnsJEMD03DhuXnNqaPSxYhPDlS55TYw3eytGcS99a
         evugRjTNS1iNd/BcVQLgOhN9GlL8Zj7u3FXOxuu2jcyewNc6JYTS2FwioAXo8QUuGRGX
         7KhasYbGPv/Qzp5XGSxHzEJCO1gkZzNYLuwRpWGWm96X/SpDy15EGx6ZFcs8t7ADF4xV
         DvAjCT8idfj7EKrb5gM8Ljg+NdeOJJ33rrVuxIHd7jAUWTtCFOIt8/cEBdaJzoMqfxNs
         8S/g==
X-Forwarded-Encrypted: i=1; AJvYcCVaS21fX3dg96c+hhgMN8yYXvDXKpL5Hs9snCWZ0dz3Du+0VdJ9S6HHyhVnpl9QIUyIVqInY+YkWMh8NLNZ@vger.kernel.org, AJvYcCWaXH2WCD0siqIt5+POl5qtjf4DcpiB71+4izqat/MdXR7amKrVTEWyUYKT40zFHi1sLIo=@vger.kernel.org, AJvYcCXmC07X62z2CBILi/pvwweA5Oul7KKT4vasAzBvIGimjPqEUmHgXCwkf89s2gAGhxX368RJQICa4yEQrBHK8pYysTf4@vger.kernel.org
X-Gm-Message-State: AOJu0YxZh7IWiNfRQxWx1toHRSSjcq0i5Ueq+omUUmxsfQnkrlcig59+
	a9KzhSqDhakFOFXhYAUyRtGxY3jmz/2j/QwrfH1gjGTX3alf29TWCgGXy0E0c8aPO0+zk7AowzY
	Uv+/z5hkoCFOKaqQh3WTaxMDyXCR2rTuy
X-Gm-Gg: ASbGncvd05stjHotDVAzJ7Aq3QzKIOANAdlqtJRvakCbQpWvG5Ojur/CgSZZn7HhXDy
	0k4EV368LkKRoOXA2qcYJk035ls0fmRLzzcefP7yW1D0JKV1eFb10fg==
X-Google-Smtp-Source: AGHT+IHj/RiYry3pOBJ4XoEf5qEomrF3K4uWEhSaBQ8g6DrZc/Hk/YNBE3Kaadg4kicioH9UXb5SFVbdQs3bOSc+EM0=
X-Received: by 2002:a17:90b:5105:b0:2ee:cd83:8fe6 with SMTP id
 98e67ed59e1d1-2f2901b80dcmr1301883a91.35.1734050590152; Thu, 12 Dec 2024
 16:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-2-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 16:42:57 -0800
Message-ID: <CAEf4BzZEbUpc0CnsJXWvbpSEvhF7hpnScCR7GdmpvMMkSm0W9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/13] uprobes: Rename arch_uretprobe_trampoline function
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
> We are about to add uprobe trampoline, so cleaning up the namespace.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  include/linux/uprobes.h   | 2 +-
>  kernel/events/uprobes.c   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 5a952c5ea66b..22a17c149a55 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -338,7 +338,7 @@ extern u8 uretprobe_trampoline_entry[];
>  extern u8 uretprobe_trampoline_end[];
>  extern u8 uretprobe_syscall_check[];
>
> -void *arch_uprobe_trampoline(unsigned long *psize)
> +void *arch_uretprobe_trampoline(unsigned long *psize)
>  {
>         static uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
>         struct pt_regs *regs =3D task_pt_regs(current);
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index e0a4c2082245..09a298e416a8 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -211,7 +211,7 @@ extern bool arch_uprobe_ignore(struct arch_uprobe *au=
p, struct pt_regs *regs);
>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr=
,
>                                          void *src, unsigned long len);
>  extern void uprobe_handle_trampoline(struct pt_regs *regs);
> -extern void *arch_uprobe_trampoline(unsigned long *psize);
> +extern void *arch_uretprobe_trampoline(unsigned long *psize);
>  extern unsigned long uprobe_get_trampoline_vaddr(void);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index fa04b14a7d72..e0e3ebb4c0a1 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1695,7 +1695,7 @@ static int xol_add_vma(struct mm_struct *mm, struct=
 xol_area *area)
>         return ret;
>  }
>
> -void * __weak arch_uprobe_trampoline(unsigned long *psize)
> +void * __weak arch_uretprobe_trampoline(unsigned long *psize)
>  {
>         static uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
>
> @@ -1727,7 +1727,7 @@ static struct xol_area *__create_xol_area(unsigned =
long vaddr)
>         init_waitqueue_head(&area->wq);
>         /* Reserve the 1st slot for get_trampoline_vaddr() */
>         set_bit(0, area->bitmap);
> -       insns =3D arch_uprobe_trampoline(&insns_size);
> +       insns =3D arch_uretprobe_trampoline(&insns_size);
>         arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
>
>         if (!xol_add_vma(mm, area))
> --
> 2.47.0
>

