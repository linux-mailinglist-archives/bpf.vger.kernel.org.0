Return-Path: <bpf+bounces-52894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC9A4A26F
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342BC16772A
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B301F872F;
	Fri, 28 Feb 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpju1Avn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6E1C1F20;
	Fri, 28 Feb 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769674; cv=none; b=Ze6wqG9JywZ0wk4/NcffvbH8lb+JaEgPbk352m29fY3axTBG7KwTJ1hTTfWXQDii22E0YRV2o2tuUpIEt5uP7sR7PtpcCSRj7qnNh8THbQLsQ2MWaIH/dl7n6Woc+EGln62Q5Yf3IuEcdtTfwiJsYLo0YVJkJ47rk2AP8DeOiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769674; c=relaxed/simple;
	bh=9lW/L2uwTClYpBDI96k2oS/2hJMHgNf7Jcxjr8JJPjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7Yaf6n2GiTNVW+QZQuq49xsnjE2KqvfgXe7DA4j5lyz4vj4GNT4ZXr1JYJFQzpVNjjOiGe0006FOvG0l6LHYC+vyghtuwdQ0RU3kLbGTgfuGH8Cl5A9K1d0tko+Dy+yCxrSoYF9OB2fx0bkXh1J8ZTythyKtGsB44P2xIatUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpju1Avn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22104c4de96so43664235ad.3;
        Fri, 28 Feb 2025 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740769672; x=1741374472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX8RKp2k+j3T5ymvVtbsGkD0SHBdaBI/tBq0Hc7RKcs=;
        b=lpju1Avn+f+hGwCa9+QkPM8DDuTeRaYnnCiU1/XvPWbOtaf6dpH4uLOygYUJxbRQGC
         vy1o2FiK8H3jPFROtEtleAMrCH5KezZ9qNIQIjeqg+VKyZsSkbkNnJ75eagzR/qnuere
         Eebi3kKnHmMZ8QFZShr97KLdnAsj6/+AM7II8BkgNatkh+o2LP5WzjLOK/nAxsYvMUGo
         mB+lOTJkt9+hvoPm3tLG9Z4IzyFGpzgU+e+O3zacOFjNsvFC56XlgprSUVIcYQL2gWyK
         bBJyky8fMCP8nUN2Bzs6qyzg7QEHoTMvXccWXc6wIY14gU+UF4QR0nvWgoBfFqoHMW/k
         g+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769672; x=1741374472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gX8RKp2k+j3T5ymvVtbsGkD0SHBdaBI/tBq0Hc7RKcs=;
        b=xTbEOwP1AM/sLHnPM9jz0O0gCcA1JTd66+Ery0VbguxZ/Hzzy+cFlkWlEWM1RpQWnN
         zg8HWMUuIsaQB8nwxNo5ChgutteoM8Y3lU/fH+W1R6N6TI7P5aUNI6YENDCtZURbVdwe
         RXR8ma/6Sb2kd1RLeMVAvPzr4SCE2F+Nj+/Ane/AD3YBpAIJwJTaK5+YE/h3vXnkX4JT
         fiy2GL6kj6Y4dlcIU5p9FDkWBoC2YfWi4jHQ+HypWaqAPCeJPAqPgQ/hAgZXDi97Z/7q
         xVSGqJ/xMU497UCvMv/ljTzow9PtHjWHI3y1VJ9xPskqBduDqyD6Sc6LdD/4sthVPWPA
         JxRw==
X-Forwarded-Encrypted: i=1; AJvYcCUSCikAZCCa+aCdCE3Tuwq5o3MfMBQ+/hSFpyuwHmrJIt8PFW3kZ7tx1KhGGaSsSG6zGs4=@vger.kernel.org, AJvYcCVnXr9FxhT3xQ1AkR9IM3w74bhs37yQIbgAjRBEdIltHInRDenSS9/c5mvk0OS5xF2Or4/0fA0xc5uwut1FwN06x9R5@vger.kernel.org, AJvYcCXk8Z8UHKHOvoX2nVGjE8MUNLtb2j0avLWmD6ejHsIvGLZlk+yhCW0MJuaIznJadJfhkonWjB3GQRw4L3MI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgn6Pq2lHIqTOjf7L0+xOkum2gIHYYcIJGLrP3QNXZ61ybI7mx
	z1GEG5l9EZBxsfggPylQVHXDNWSl3Wt/NA4/G5MKITxPMI+vZ/oI1sjPyg54uJidneop+fycF6i
	ZAM1AHTrX+4DYd6uMDKfrQI02x0U=
X-Gm-Gg: ASbGncv8wZpURAH91nNPFH2KKxkh8fod0pz8IhhHLVETClcWQpe62Kat3C+NS4kw0C+
	eemBp9vMRexQPnRc53JXi+VguPkVSu1B1Bl120/lpD3pkCqod0aIUY536y20EK81qmnhyzKXI6S
	KU4GYg2Lg70CPxs47V6FsrbRA=
X-Google-Smtp-Source: AGHT+IGuy2F+O6xkEm0RmJ8Snn2z3mEZjrIDO8zblSIcPmYR7MSfS4388EyBUboSCR7xy0fLHrjLlj+vvBMqgk78I50=
X-Received: by 2002:a17:903:fa5:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-2236924f8fcmr59479745ad.39.1740769671787; Fri, 28 Feb 2025
 11:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224140151.667679-1-jolsa@kernel.org> <20250224140151.667679-7-jolsa@kernel.org>
In-Reply-To: <20250224140151.667679-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 11:07:38 -0800
X-Gm-Features: AQ5f1Jr7R7T1i4YVMLyvGi1eA_0AUq6Fm08N4xTtjpgH-0hiHSCKFQiDSZ5y_cA
Message-ID: <CAEf4BzZ=TOGXMwYDz1=bdw4DVVgkXJkMKKv=O1HnWddS-i6Kww@mail.gmail.com>
Subject: Re: [PATCH RFCv2 06/18] uprobes: Add orig argument to uprobe_write
 and uprobe_write_opcode
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:03=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The uprobe_write has special path to restore the original page when
> we write original instruction back.
>
> This happens when uprobe_write detects that we want to write anything
> else but breakpoint instruction.
>
> In following changes we want to use uprobe_write function for multiple
> updates, so adding new function argument to denote that this is the
> original instruction update. This way uprobe_write can make appropriate
> checks and restore the original page when possible.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/arm/probes/uprobes/core.c |  2 +-
>  include/linux/uprobes.h        |  5 +++--
>  kernel/events/uprobes.c        | 22 ++++++++++------------
>  3 files changed, 14 insertions(+), 15 deletions(-)
>

[...]

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index ad5879fc2d26..2b542043089e 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -471,25 +471,23 @@ static int update_ref_ctr(struct uprobe *uprobe, st=
ruct mm_struct *mm,
>   * Return 0 (success) or a negative errno.
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *m=
m,
> -                       unsigned long vaddr, uprobe_opcode_t opcode)
> +                       unsigned long vaddr, uprobe_opcode_t opcode, bool=
 orig)
>  {
> -       return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN=
_SIZE, verify_opcode);
> +       return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN=
_SIZE, verify_opcode, orig);
>  }
>
>  int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
>                  unsigned long vaddr, uprobe_opcode_t *insn,
> -                int nbytes, uprobe_write_verify_t verify)
> +                int nbytes, uprobe_write_verify_t verify, bool orig)

why not call orig -> is_register and avoid a bunch of code churn?...
(and while "is_register" is not awesome name, still a bit more clear
compared to "orig", IMO)

>  {
>         struct page *old_page, *new_page;
>         struct vm_area_struct *vma;
> -       int ret, is_register;
> +       int ret;
>         bool orig_page_huge =3D false;
>         unsigned int gup_flags =3D FOLL_FORCE;
>
> -       is_register =3D is_swbp_insn(insn);
> -

[...]

