Return-Path: <bpf+bounces-59457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B2ACBC7F
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B27A9421
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BBB1CDFD4;
	Mon,  2 Jun 2025 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAtKhlFr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19F2C327E
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748897583; cv=none; b=Ukela8sKHDLeYR8xW+gmzYDAQKfcoWAAhRdSG7UK09njIzm8litmOXRE/kwbVDmkbk+DdjWc+sQGQehWB+795J/YdD6mIUtrBLkD40YRcDI7tDZEQXTYWpX2M8CI19nnk1cziT+b31Q7PPYxZK0ZShS4Qz44072+lWJ1BOSX6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748897583; c=relaxed/simple;
	bh=8c32t/UxaKh8IIULsaO+2W/QOfXyJiiYSTO8wu7FFJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7s0CXnlK9dKObe+Hw6VOCK8ra3mvVO1wTTbc9SrpeMt2CiiFhyLYAxspSCSpLhGDjlAM3cdC/45Hkt/R0Wr6LLr5ve3rnjfJ4w9GtWbreSll8VLBCf+5zZFjWTW+Pb/3O7jh19hr+ZDQiUE0D1yYeliXHD7l2WTl0n6qnDe+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAtKhlFr; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso6273669e87.3
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748897578; x=1749502378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a2/P+yhD/Wm95bO7SeIWjArP9Ck9zCMpoVNHxrOUPE=;
        b=TAtKhlFrygq0LJFxFJAAGl6nYomIfDqeZ3dfXPNgYv12Sj4MC7x+B6TGDbkwvapI3+
         HrHrP5zh0GCh4ZcMxxYfoV/4T9IE4FD2n3bPLhBjm1zus3aNB2wjJxpSFLyClVvOX9bl
         IijyH0Go69r6JizNpps552Yznz3V+t6Hg5qj8TKKSTyI8gmX2RsuU77GgtCO0Xiqh0Zf
         e1GwiW6waajBh9ZfItsytnEX5jh08nKbSKyV/+/DVrvbvU7UtVNUngGy6bkemBbGiigF
         me87da6qMQbif3zFxp9APdE1HESfOeEKcuC7XLrjmbyf4/EDsozKPSJBGIxye5P8tPhh
         YM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748897578; x=1749502378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7a2/P+yhD/Wm95bO7SeIWjArP9Ck9zCMpoVNHxrOUPE=;
        b=APnKOkzEl/wZD2U7QceZYkZZ4a6TZYmxC/UbVAYXydzxq7lEYVNiQ2HDAs5Txy/n7D
         6pbWJxclAm2kKMFNhC5bY16PM1xep9CZsuA1scsKiGfgnt/ZWJSOJHZi0Fw8GKQf5757
         C9QqA8nFdimf1gGl4AD1Of8flr7kWcAE+z4l3K2O0xqtGxh33Q9WKgRVWgVjaWfkZvAR
         Ip40SZz7DtI7+5oIUK8f7BdaMs6WaHVeLlZZXgrQIvGRdJl0eiPGcIHLWVre6c7PPLGG
         2lBT8dVsFSq1d1ZcLAlXPkrGW5mPOdhlEMZUIfSBvRbxshlYn+rRYyqqDtZWfaCCGitd
         7otw==
X-Gm-Message-State: AOJu0YzDJOhJhYFVZmG+hGuvSYi3JTy+ni7LCvviezRVYCs1f9c/VPuw
	NjaRv0UsfKSocH2mHJBgAyqkybIrzVYlDLMaf2oKhXZLGTMC7mmGbOhlM3SnY0rAaFWhFXuwmSb
	NHC3/mS8qZ+guMDZYxaovO4F99TkmDkpvv47A
X-Gm-Gg: ASbGncumnK+mEGoDfzux0fC2+Uwlb0JGqsn9YDa4jdL6rYZB4HBOdLO82RO2QjVjPQ4
	PhxS/U45u/VdWI77a2nenlfEa1yQ5oiNa9lMAYYwkvyqJGBkCUva67sNyqJ8xi28oCZnMUwezsF
	GOxDz50ShWY9YgWuNWPh8AQIJ9oajenGoIdXnI+3KwvewiyR9pLdybQQJLfF9jan2XvX+DQ/oQH
	z8uRA==
X-Google-Smtp-Source: AGHT+IGeKhgTq3O3rcYtoZoYdx/AdPaOkHOlBgQ6ggDOH7T3wzMw9XinRb/A6dz8LuSNjf+2SkIUhaFqcbl7KnJ0kGc=
X-Received: by 2002:a17:907:3f99:b0:ad8:8efe:3201 with SMTP id
 a640c23a62f3a-adb325838ffmr1485068166b.43.1748895714977; Mon, 02 Jun 2025
 13:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-3-memxor@gmail.com>
 <CAADnVQ+M20Jn_+hkLuRTJJGZQSVvwZQd0q0RxBV-u7CpTf0Orw@mail.gmail.com>
In-Reply-To: <CAADnVQ+M20Jn_+hkLuRTJJGZQSVvwZQd0q0RxBV-u7CpTf0Orw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 2 Jun 2025 22:21:18 +0200
X-Gm-Features: AX0GCFu8est_h8d-fTWBFnFm9y5SR8A-eRDo34f4rZU7ASHqaYy6IP3mdYK6Ds0
Message-ID: <CAP01T757V7+E6H7H10J4L_ULdDtB0T=BQa7==TXDyP_0WCn0QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/11] bpf: Add function to extract program
 source info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jun 2025 at 22:18, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 23, 2025 at 6:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Prepare a function for use in future patches that can extract the file
> > info, line info, and the source line number for a given BPF program
> > provided it's program counter.
> >
> > Only the basename of the file path is provided, given it can be
> > excessively long in some cases.
> >
> > This will be used in later patches to print source info to the BPF
> > stream. The source line number is indicated by the return value, and th=
e
> > file and line info are provided through out parameters.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h |  2 ++
> >  kernel/bpf/core.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index d298746f4dcc..4eb4f06f7219 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3659,4 +3659,6 @@ static inline bool bpf_is_subprog(const struct bp=
f_prog *prog)
> >         return prog->aux->func_idx !=3D 0;
> >  }
> >
> > +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, co=
nst char **filep, const char **linep);
> > +
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 22c278c008ce..7e7fef095bca 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -3204,3 +3204,52 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
> >
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
> > +
> > +#ifdef CONFIG_BPF_SYSCALL
> > +
> > +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, co=
nst char **filep, const char **linep)
> > +{
> > +       int idx =3D -1, insn_start, insn_end, len;
> > +       struct bpf_line_info *linfo;
> > +       void **jited_linfo;
> > +       struct btf *btf;
> > +
> > +       btf =3D prog->aux->btf;
> > +       linfo =3D prog->aux->linfo;
> > +       jited_linfo =3D prog->aux->jited_linfo;
> > +
> > +       if (!btf || !linfo || !prog->aux->jited_linfo)
> > +               return -EINVAL;
> > +       len =3D prog->aux->func ? prog->aux->func[prog->aux->func_idx]-=
>len : prog->len;
> > +
> > +       linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
> > +       jited_linfo =3D &prog->aux->jited_linfo[prog->aux->linfo_idx];
> > +
> > +       insn_start =3D linfo[0].insn_off;
> > +       insn_end =3D insn_start + len;
> > +
> > +       for (int i =3D 0; i < prog->aux->nr_linfo &&
> > +            linfo[i].insn_off >=3D insn_start && linfo[i].insn_off < i=
nsn_end; i++) {
> > +               if (jited_linfo[i] >=3D (void *)ip)
> > +                       break;
> > +               idx =3D i;
> > +       }
> > +
> > +       if (idx =3D=3D -1)
> > +               return -ENOENT;
> > +
> > +       /* Get base component of the file path. */
> > +       *filep =3D btf_name_by_offset(btf, linfo[idx].file_name_off);
> > +       if (!*filep)
> > +               return -ENOENT;
> > +       *filep =3D kbasename(*filep);
> > +       /* Obtain the source line, and strip whitespace in prefix. */
> > +       *linep =3D btf_name_by_offset(btf, linfo[idx].line_off);
> > +       if (!*linep)
> > +               return -ENOENT;
> > +       while (isspace(**linep))
> > +               *linep +=3D 1;
>
> The check_btf_line() in the verifier does:
>                 if (!btf_name_by_offset(btf, linfo[i].line_off) ||
>                     !btf_name_by_offset(btf, linfo[i].file_name_off)) {
>                         verbose(env, "Invalid line_info[%u].line_off
> or .file_name_off\n", i);
>                         err =3D -EINVAL;
>                         goto err_free;
>                 }
>
> and later in the verifier we do:
>         s =3D ltrim(btf_name_by_offset(btf, linfo->line_off));
>         verbose(env, "%s", s); /* source code line */
>
> so please drop these two checks.

There was a kernel crash in CI when these NULL checks were missing.

>
> > +       return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
>
> I would return it by reference as well.

Ok.

