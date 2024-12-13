Return-Path: <bpf+bounces-46796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 681739F013E
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342FE188445D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA16D748F;
	Fri, 13 Dec 2024 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKGW+/Mg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B624C7D;
	Fri, 13 Dec 2024 00:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050899; cv=none; b=OasQbMBqUBGoqg3G+laEOoFT0ggF+xYwUlOwnBuVbR4BJ2vVHnUDWRDM+BvK01o5ZDqn6FgCLd+toinXa1tFKx46Q43s3oqTNzq4Jtq1mcts+IytPCl7jpUP/r83WlBM6x/9awYmvBcxxheygZPbGUjnz2GBGPX0SVwRlG7yhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050899; c=relaxed/simple;
	bh=HC5PDz/HHoF+AR2P9tP6KJb+2GshOm5NaL1PdaQVN5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZ99jHJ2R1/vWwmlZD6om6wNGz1mBSLQKTxc0PqI/02FwVqA8vXCUkFsyg9FiPrwtfYpDnmSHgvG3RTu0o+H/j/PurBwlLrHC0XYTCbzkpimcr1SUuMqHcvvXcVxNx7h5GzVZMBRDvG9QuXpTsy/WotjC7gTlapkgcgiyJ46NvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKGW+/Mg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fdc6e04411so733550a12.2;
        Thu, 12 Dec 2024 16:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734050897; x=1734655697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNRmVQanQATFAfXikHHEScNAYqmRpENEmwgU9NonBBU=;
        b=BKGW+/MgM72uei8Ltd9GhDyCT+3jKP8WCLJHNFB1506qxlYbVI5gGubxceHQDyBQdn
         psq+ctzNtrb9yuZ9W/Zm69xBoDLpMQtQzvtaArpxMeAur48MAmp3ejZ/ASm5Q2vkMySU
         8K8OQz4U8/Izt2CK8eHRxYLSWu+tbCJvCQ1XjOqO8nrqMU/7qeQI24L8sriD+Pxw7LEp
         YFzDzQE7pg8Q7e6U0BSqWlJNAYt1/bfTA6xPVn7JsUiK4Qcjfr4fjWIBxUVNwLvM2JY1
         OT3Zl1zx19K6u8nat+lvfENnCyODs8++m/KgLgJA/Yk07EkLYl1Qh35L1PcB39/ZZnJ4
         xqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050897; x=1734655697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNRmVQanQATFAfXikHHEScNAYqmRpENEmwgU9NonBBU=;
        b=Z8P4nohyEsNxJGXLHZiBHr+rofMbpJbf4zP+DlhCK4WJ0wxrz9wuQPdsnw+CABqdo3
         jcnx10b0dpALo5uaib5E/pIHBvLBaYLFuJamidxIdJLFYaTmmDP2CtEI5YsjR4WyLfUt
         2RXksEPjF+Y+GActuONjgn1WSrkquVGBH+Bq2RV2uM8QxnyPpInSMlmhQiOzKmGf0oLL
         wNMKpjwCnlrWKsiAX1sJGRTAdYUF0VRwNWLoWsSnUKuwXxrCDP+sOv7aUHmJjnNxNmPk
         p1SLb875vj9riGXMVorAJ1edqXqBGrQi2FxWpjx1BjKZlU5qKBMk20BpXXVXPTmdv/By
         oI/A==
X-Forwarded-Encrypted: i=1; AJvYcCUelYnbMjHDh6SdghracRImLxO7S8J34+roKkMQCNpwyi6UsBbUqafbvRTomjjeo4OlcDQtRd5sgLsH31gokqaWoHCx@vger.kernel.org, AJvYcCVTQ8hXMYK0iWnDzB1zCqXVZEiJIp89C73O13ZOzC5TfVUGTA3x9LJ/ID9KQRRhyB+DNT0=@vger.kernel.org, AJvYcCXy1YF8D6VkXiFHvOsMCDQzEyOEpF8mymlwqZMjBpTm/5yhMC1TIn9Q4tXxkadH+K3hU0rUYQM8OKRNx1lM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8QJviY3SAwzfHYue5QbldWStgAem1ZZgT08+fMBkmL7m5PoA
	YZjTmMTcE+SdxTMgRHd/IH2nl4TZbuL5mZbrWrVZ9U++uB6efFtSCcR8D1lzXWpQMOdicAahM02
	oGLth+UF6L/BtV64Mm4YhtoimusY=
X-Gm-Gg: ASbGncs2wIk75sjXbF+lExXwDdszU079DlhmQ63bRWK9J+kOJUakBvRBmG6eGb9RVct
	iYXLx3w5K5muvpqkzz9z/x4Ho4faOcq5lHxqYZesOebj82YI3tyJxnQ==
X-Google-Smtp-Source: AGHT+IG7dp0Z5iGLnt6GYt5ILBXBuhMWJwqHdKaPat1iVR/Xa4PGGgeC1pTeSXC9R7ofX+Zt8Q5gbUd90I7W9+s//+s=
X-Received: by 2002:a17:90b:3512:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-2f290dbcbddmr941851a91.31.1734050897147; Thu, 12 Dec 2024
 16:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-5-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 16:48:05 -0800
Message-ID: <CAEf4BzZ2g6PwY+Ah-39F7Dw2AFZUE7AxEqOuNbs5LouHtKMZbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/13] uprobes: Add arch_uprobe_verify_opcode function
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
> Adding arch_uprobe_verify_opcode function, so we can overload
> verification for each architecture in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  5 +++++
>  kernel/events/uprobes.c | 19 ++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index cc723bc48c1d..8843b7f99ed0 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -215,6 +215,11 @@ extern void uprobe_handle_trampoline(struct pt_regs =
*regs);
>  extern void *arch_uretprobe_trampoline(unsigned long *psize);
>  extern unsigned long uprobe_get_trampoline_vaddr(void);
>  extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr=
, void *dst, int len);
> +extern int uprobe_verify_opcode(struct page *page, unsigned long vaddr, =
uprobe_opcode_t *new_opcode);
> +extern int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct=
 page *page,
> +                                    unsigned long vaddr, uprobe_opcode_t=
 *new_opcode,
> +                                    int nbytes);
> +extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7c2ecf11a573..8068f91de9e3 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -263,7 +263,13 @@ static void uprobe_copy_to_page(struct page *page, u=
nsigned long vaddr, const vo
>         kunmap_atomic(kaddr);
>  }
>
> -static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_=
opcode_t *new_opcode)
> +__weak bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes)
> +{
> +       return is_swbp_insn(insn);

a bit weird that we ignore nbytes here... should we have nbytes =3D=3D
UPROBE_SWBP_INSN_SIZE check somewhere here or inside is_swbp_insn()?

> +}
> +
> +int uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> +                        uprobe_opcode_t *new_opcode)
>  {
>         uprobe_opcode_t old_opcode;
>         bool is_swbp;
> @@ -291,6 +297,13 @@ static int verify_opcode(struct page *page, unsigned=
 long vaddr, uprobe_opcode_t
>         return 1;
>  }
>
> +__weak int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct=
 page *page,
> +                                    unsigned long vaddr, uprobe_opcode_t=
 *new_opcode,
> +                                    int nbytes)
> +{
> +       return uprobe_verify_opcode(page, vaddr, new_opcode);

again, dropping nbytes on the floor here

> +}
> +
>  static struct delayed_uprobe *
>  delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
>  {
> @@ -479,7 +492,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
>         bool orig_page_huge =3D false;
>         unsigned int gup_flags =3D FOLL_FORCE;
>
> -       is_register =3D is_swbp_insn(insn);
> +       is_register =3D arch_uprobe_is_register(insn, nbytes);
>         uprobe =3D container_of(auprobe, struct uprobe, arch);
>
>  retry:
> @@ -490,7 +503,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
>         if (IS_ERR(old_page))
>                 return PTR_ERR(old_page);
>
> -       ret =3D verify_opcode(old_page, vaddr, insn);
> +       ret =3D arch_uprobe_verify_opcode(auprobe, old_page, vaddr, insn,=
 nbytes);
>         if (ret <=3D 0)
>                 goto put_old;
>
> --
> 2.47.0
>

