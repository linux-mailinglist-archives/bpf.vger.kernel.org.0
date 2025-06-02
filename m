Return-Path: <bpf+bounces-59453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D795ACBC42
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9809418929CD
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937CC1C5D53;
	Mon,  2 Jun 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E01sVPO8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6823CE
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748895916; cv=none; b=fDoVPM8tWtFsVNEvx0eAqxs3jZqLKkq0EMXMP9UTP/A34Ok7X8Yx5NoJtgiqct74tEckBvn5IStkYZVV+aex2VVbsk9yrfCD2kWl+71MYgnxnFoi2gLWquVPYSvovHlf9yAI/tGN/RDGdK+o6epwUNHIyWjJckK7AkEYWdzHDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748895916; c=relaxed/simple;
	bh=MjXkiRZvidUHA8xr6l8m7OB5ByqG2UKd5yVEuTyRKZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hirF/Y+OW/e8XAcxycCHO9QnNqVMhJbUdKZp55DQN36NkGKnRvrRi1IzEtYX+96FPrRfEeLlrJ9paYXr/X1LpVbxYpLPnoanBdVkk7uf2iHKmAFzV5Jsbeua8Y6nETPbkF4ma1xB0AM+i4BYWKJaoykbzskoHH1bllLT4QUk6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E01sVPO8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451e24dfe1aso5564225e9.3
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748895912; x=1749500712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVlrD3vrYJGoj5CEBaBNeaZX0IhdwgYo1kyO/D6L2NY=;
        b=E01sVPO8E0Uvao6VP8Zuo6v1rLD4yCHnpLV8Swb6d6APGssUNP05+bB8/8Cr0NjC3T
         Zt6YONDETvBU7yI++Fr4BMXym9tkz7IxthU8sgIfieBItT+JAyuA9Au/nvl4uBFB4B1D
         lGhDryCIo51jEvn9yP7rpIFlPmCkacpozapnb+EQu3yBPzpAup+NYnRMr6kBuBAKlE7s
         tROKBgrw/b9tvUjiC+IoV12Tn6nCGQiphTgS6Z0ZR3WjajdZkEF93c2jaxjwIN5zsAsQ
         ltIkcxk1OdLUR7g0Bfn5NcIi6CWoWhnKeyWqyVWf0uGXMs2k+6A7ADg9KQX+YyS75GYD
         AJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748895912; x=1749500712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVlrD3vrYJGoj5CEBaBNeaZX0IhdwgYo1kyO/D6L2NY=;
        b=eF7tdBpmiwfoo2g8XXGN7S70aMuAL7in6SLGhpMymti50q9Y9Fuo5sSPqNy87GKYwi
         ZI+fWDAbXMEAUumSGh3MJBofOM/o2PwnxxoCOHoO8W58eBhJVCh9FAiSsXN8daiKNbAU
         CDpGFoK1gOIQbAfwLuAjl/TSsdIeTzvD5j62YjsOFHkOfwRiwbDaBY0+dNM/SEB4BE5Z
         muJV4t3qrCIAuMz1WF9b7+9Ry4PU4a3WdN7UWuHE1Miam+v9EG1rvsp9lGQyI1QRXrjh
         wlFDgu8EMWXeHwYaob2gMaOEuAYpWtbtaEGwVKKuMECHVUpVqorBTbw7uGgwMRa+rqKG
         BJ9A==
X-Gm-Message-State: AOJu0YzFgQD69ORuGJKLMrNohOTibvGv7fKzFXgOxv061OvVUMwrHnwa
	BhhzzqG4hsFWBdUezY5ZxZ+e6ZxByyFKcts0FBdcG/C/4Ya/gZyTdX4m+CGvQUzGxteg7ixbNWN
	PkDWix/KzR2Nw2No5YLahoG+qSb7vai8=
X-Gm-Gg: ASbGnctFOkc26I+/keOyeJBkntUJiwZ4DA1sLNXDqroDCYE5D7eythXhKQ2ptcopB1w
	qo9ra9u248NAt/ryGW0gY3eOttv2TTTZrWDs8aRZw/FsmXV6W+Vjb1v0gxcngk+3un6G2RM8g6/
	7vStQ6KTnDNWgMVklV+QrMz/iBM+C7dVqzCXUJYfh3LNiz6VEB
X-Google-Smtp-Source: AGHT+IEL1o7InBh68ihLNXWCFcagbx1CN4Fh4yhv1F9+xD4j+nI0PmyLlrqYUwziTK2yKrWh0xvNXOdUzv52VcojIKM=
X-Received: by 2002:a05:6000:22c3:b0:3a4:eeb6:3b6b with SMTP id
 ffacd0b85a97d-3a4f7a6d218mr11880140f8f.43.1748895912353; Mon, 02 Jun 2025
 13:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-3-memxor@gmail.com>
 <CAADnVQ+M20Jn_+hkLuRTJJGZQSVvwZQd0q0RxBV-u7CpTf0Orw@mail.gmail.com> <CAP01T757V7+E6H7H10J4L_ULdDtB0T=BQa7==TXDyP_0WCn0QQ@mail.gmail.com>
In-Reply-To: <CAP01T757V7+E6H7H10J4L_ULdDtB0T=BQa7==TXDyP_0WCn0QQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 13:25:00 -0700
X-Gm-Features: AX0GCFvEzWTWlTWwDjEiFxEmT63aXJqSzz5bRAgOEwyyG7nwIVxn7YF3kc2qU3k
Message-ID: <CAADnVQ+Bh1FdhvjEo_STvYk3Ht6NVpid4H+QcOFnsy32iv8UBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/11] bpf: Add function to extract program
 source info
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 1:21=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Mon, 2 Jun 2025 at 22:18, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, May 23, 2025 at 6:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Prepare a function for use in future patches that can extract the fil=
e
> > > info, line info, and the source line number for a given BPF program
> > > provided it's program counter.
> > >
> > > Only the basename of the file path is provided, given it can be
> > > excessively long in some cases.
> > >
> > > This will be used in later patches to print source info to the BPF
> > > stream. The source line number is indicated by the return value, and =
the
> > > file and line info are provided through out parameters.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h |  2 ++
> > >  kernel/bpf/core.c   | 49 +++++++++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 51 insertions(+)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index d298746f4dcc..4eb4f06f7219 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -3659,4 +3659,6 @@ static inline bool bpf_is_subprog(const struct =
bpf_prog *prog)
> > >         return prog->aux->func_idx !=3D 0;
> > >  }
> > >
> > > +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, =
const char **filep, const char **linep);
> > > +
> > >  #endif /* _LINUX_BPF_H */
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 22c278c008ce..7e7fef095bca 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -3204,3 +3204,52 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
> > >
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
> > > +
> > > +#ifdef CONFIG_BPF_SYSCALL
> > > +
> > > +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, =
const char **filep, const char **linep)
> > > +{
> > > +       int idx =3D -1, insn_start, insn_end, len;
> > > +       struct bpf_line_info *linfo;
> > > +       void **jited_linfo;
> > > +       struct btf *btf;
> > > +
> > > +       btf =3D prog->aux->btf;
> > > +       linfo =3D prog->aux->linfo;
> > > +       jited_linfo =3D prog->aux->jited_linfo;
> > > +
> > > +       if (!btf || !linfo || !prog->aux->jited_linfo)
> > > +               return -EINVAL;
> > > +       len =3D prog->aux->func ? prog->aux->func[prog->aux->func_idx=
]->len : prog->len;
> > > +
> > > +       linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
> > > +       jited_linfo =3D &prog->aux->jited_linfo[prog->aux->linfo_idx]=
;
> > > +
> > > +       insn_start =3D linfo[0].insn_off;
> > > +       insn_end =3D insn_start + len;
> > > +
> > > +       for (int i =3D 0; i < prog->aux->nr_linfo &&
> > > +            linfo[i].insn_off >=3D insn_start && linfo[i].insn_off <=
 insn_end; i++) {
> > > +               if (jited_linfo[i] >=3D (void *)ip)
> > > +                       break;
> > > +               idx =3D i;
> > > +       }
> > > +
> > > +       if (idx =3D=3D -1)
> > > +               return -ENOENT;
> > > +
> > > +       /* Get base component of the file path. */
> > > +       *filep =3D btf_name_by_offset(btf, linfo[idx].file_name_off);
> > > +       if (!*filep)
> > > +               return -ENOENT;
> > > +       *filep =3D kbasename(*filep);
> > > +       /* Obtain the source line, and strip whitespace in prefix. */
> > > +       *linep =3D btf_name_by_offset(btf, linfo[idx].line_off);
> > > +       if (!*linep)
> > > +               return -ENOENT;
> > > +       while (isspace(**linep))
> > > +               *linep +=3D 1;
> >
> > The check_btf_line() in the verifier does:
> >                 if (!btf_name_by_offset(btf, linfo[i].line_off) ||
> >                     !btf_name_by_offset(btf, linfo[i].file_name_off)) {
> >                         verbose(env, "Invalid line_info[%u].line_off
> > or .file_name_off\n", i);
> >                         err =3D -EINVAL;
> >                         goto err_free;
> >                 }
> >
> > and later in the verifier we do:
> >         s =3D ltrim(btf_name_by_offset(btf, linfo->line_off));
> >         verbose(env, "%s", s); /* source code line */
> >
> > so please drop these two checks.
>
> There was a kernel crash in CI when these NULL checks were missing.

The math before is probably wrong then.
idx is invalid ?
This needs more debugging.

