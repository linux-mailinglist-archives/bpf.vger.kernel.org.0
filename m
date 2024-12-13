Return-Path: <bpf+bounces-46904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA359F1824
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75D1165DDA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F7193086;
	Fri, 13 Dec 2024 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMYa6N/F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37F84039;
	Fri, 13 Dec 2024 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126733; cv=none; b=XI/GZLYUZh21WlRmaZALL/Oop3IcG6N0HL2ouoxZfcl9mMVRbdNEvADbELb5g3FpqrTeb6E3LCwon13wld5l6d3x8d5y4JiENBMJe3qm6s00ngNwh4vds8EY+48ax74fBREbtnpMN/ZYIJ5XGGaHgUSuHdXN6jzng0avP1PXBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126733; c=relaxed/simple;
	bh=VEbAqhLoFMU/UoefqB+aA8+wiZ0qPNT/h3bEq9xnuGg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugVPJi1drNVHgA+36+Fjrf6R0DUEKJXUMbDaZ7mXKtloA6Nf6A/cpDp/IPu8A20CjZ0u7FhLuwDlVTjR5wJ0FZ3cOf0FqN4MXItPHYbPmR38GbRfo9vZbTj17d7FsP9uQV/PEw+Nkybr125ZdCPhhQHxnmFjHu+h1EZbyZJYpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMYa6N/F; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so3482175a12.3;
        Fri, 13 Dec 2024 13:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734126730; x=1734731530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5wzDKPzJnMM02kKA5AIsGL2ncAxhsfcXx2ChL8Znrg=;
        b=jMYa6N/FCHBkAKhop2eK7udm+AdjY2YXaW7KlvTUjBe8Ii7Kq8RvBfhbSwqZ1NsCD2
         aYffZV06PwdUhHbcE+/DCfZgpytT6sjy9xkPjv/XovlIoFw3DLG3E8FGimpmyDecjoQU
         s0Q6gohbSQ1TrPgGM2ctG2gR2OXtE5EU5R1dvtigVf3pfc00amNn/0zY6etYrYYMiXgJ
         tDFCvLzaziTUukl30Z1X16KshPBzMp6ngxyym/5fQZVV1+FjEwk4vz2Xi3aqQaoDBf4y
         YkeQiKcdjENJqQ1mTq/6/ySiDw/+GJnxYVzrAbJA3NdXfRw5a2oHAyVbUPXBPD3L417J
         5PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734126730; x=1734731530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5wzDKPzJnMM02kKA5AIsGL2ncAxhsfcXx2ChL8Znrg=;
        b=FsAuFXyKnDicPVxT68zemnG6aLUJO542+DyCVB5wJrp+A9qRh1jA7y3YzbhhEkzsF8
         BfBNtuDdqzCJVCiivwluGEynvFte45L7mCp1fmhB/CBnNkWyPSNH47h0Wegp1++KiSFb
         rCxDqep6vUbG7LbpA2qeTi89aH4JRW8P23iQmIScg0YfQC+9gpZGkTRzuHZmmbdX4rrP
         PPpG53U77mw7XVhOSCT7zpOgTUtaYbfCMDH9j2DgfR6fUUUvFjJQL7KVlNZf/pWDM4+4
         cO2CBhtDkbe+XEdMIdWtgs+J5JaR8B0zQLvpC2nuj+MtzQk2kx2wwAWTJrNQR/GCx2f2
         3OxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/plFe2Z9zSH6h4qy9uMHPWQ1GCSGnbrmUK7M/ZtuoBREbuqAPdDtXOQwZewwFDNz+bVs=@vger.kernel.org, AJvYcCU3NKFrOKdsdt88BuegvileyYyHHAQ1w/S8C67bWVsIIdJaqbFzbsnMC793fxcGMnnhdUGKPugiiKJH4Nf5iXDvLh2a@vger.kernel.org, AJvYcCXtATJQvFzIKmxobAtoUis3aV4/OdOKpof26Hel9uOqXgI30H3TE+BbVbKZcrHTKftEpqqTCcgnFoEynVxO@vger.kernel.org
X-Gm-Message-State: AOJu0Yxitf8ik+RacnHfo1N3QM6GqymntZqeFR/qoLcD4d82wNSpgJc1
	j6b83oHT8GU5TOUaI7mJzEiqZgOUWJ4VJSLqPvjcPMRvEOWN9m6D
X-Gm-Gg: ASbGncvKJGhTey+XZSPdAl17cEyOuWot0Uh0ikRKPAJZglQJxeXXFpOrgVa6kmoLiUN
	mJoHMG8v42AJ+FfbO50sLJKhosB2s0PgnHxcFloqn0BbpA4DWsBPZDeHw00ShrT/hRPEzgYnaq8
	YgYCSlCH6EQVtAgu+LNzS0LWSY3qqiunp1m+VZD72qmogCv6A0Nf+l1P/wK6T/wx+DfwZ1LYflh
	Y4a9LUACSkgIYX9chGHqFXW7vCUowqs+CkbrCUAtzfNrhjptx66BP87c2ate74hsw==
X-Google-Smtp-Source: AGHT+IFb/i/SWozFuKvqUEwsGeSYtS//xdr6WVR0c51i/8mHsM9kgg9YsycjLz1DP+94ooB6Zvu6zA==
X-Received: by 2002:a17:907:7d90:b0:aa6:7d82:5414 with SMTP id a640c23a62f3a-aab779b04edmr465919566b.30.1734126729733;
        Fri, 13 Dec 2024 13:52:09 -0800 (PST)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab960684fesm17785666b.56.2024.12.13.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:52:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 22:52:06 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 04/13] uprobes: Add arch_uprobe_verify_opcode
 function
Message-ID: <Z1yshuMy5UOUWwF7@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-5-jolsa@kernel.org>
 <CAEf4BzZ2g6PwY+Ah-39F7Dw2AFZUE7AxEqOuNbs5LouHtKMZbQ@mail.gmail.com>
 <Z1w0z2KSgFGggAVD@krava>
 <CAEf4BzZ+nkvZFADq9HzLUUcDGNa44G+hPfzOhUexKW7WqBxS6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ+nkvZFADq9HzLUUcDGNa44G+hPfzOhUexKW7WqBxS6A@mail.gmail.com>

On Fri, Dec 13, 2024 at 01:11:30PM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 13, 2024 at 5:21 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 04:48:05PM -0800, Andrii Nakryiko wrote:
> > > On Wed, Dec 11, 2024 at 5:34 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding arch_uprobe_verify_opcode function, so we can overload
> > > > verification for each architecture in following changes.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  include/linux/uprobes.h |  5 +++++
> > > >  kernel/events/uprobes.c | 19 ++++++++++++++++---
> > > >  2 files changed, 21 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > > index cc723bc48c1d..8843b7f99ed0 100644
> > > > --- a/include/linux/uprobes.h
> > > > +++ b/include/linux/uprobes.h
> > > > @@ -215,6 +215,11 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
> > > >  extern void *arch_uretprobe_trampoline(unsigned long *psize);
> > > >  extern unsigned long uprobe_get_trampoline_vaddr(void);
> > > >  extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
> > > > +extern int uprobe_verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode);
> > > > +extern int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *page,
> > > > +                                    unsigned long vaddr, uprobe_opcode_t *new_opcode,
> > > > +                                    int nbytes);
> > > > +extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes);
> > > >  #else /* !CONFIG_UPROBES */
> > > >  struct uprobes_state {
> > > >  };
> > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > index 7c2ecf11a573..8068f91de9e3 100644
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -263,7 +263,13 @@ static void uprobe_copy_to_page(struct page *page, unsigned long vaddr, const vo
> > > >         kunmap_atomic(kaddr);
> > > >  }
> > > >
> > > > -static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
> > > > +__weak bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes)
> > > > +{
> > > > +       return is_swbp_insn(insn);
> > >
> > > a bit weird that we ignore nbytes here... should we have nbytes ==
> > > UPROBE_SWBP_INSN_SIZE check somewhere here or inside is_swbp_insn()?
> >
> > the original is_swbp_insn function does not need that and we need
> > nbytes in the overloaded arch_uprobe_is_register to distinguish
> > between 1 byte and 5 byte update..
> >
> 
> and that's my point, if some architecture forgot to override it for
> nop5 (or similar stuff), this default implementation should reject
> instruction that's not an original nop, no?

ok, makes sense, will add that

thanks,
jirka

