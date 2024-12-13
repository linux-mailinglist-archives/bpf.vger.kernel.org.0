Return-Path: <bpf+bounces-46847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE86C9F0D33
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7595F282C5E
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02791E009A;
	Fri, 13 Dec 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEG0v1FV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237E383;
	Fri, 13 Dec 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096085; cv=none; b=BZ8IpCZZKjPJ3Jd9nmbKOf7iNBuLWpe32SPI50IJiz8HADZ0C3UA6SSliWipul6ZSlmyv+QlBU0R5qlFElB+3d2oAeW0sdujerx5CcmWT9qJyk0U+aAuY1KNH7DPpz0QwqI27qa0bUIVD4GcGdDu9gpocKlgvHfHHNTe1G2AY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096085; c=relaxed/simple;
	bh=fW6luxMrAqnYlvsreIEbbkCkFhzIfplK1rD1utBIVMU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgRLf9bHKgS9oBcxil7pAdwXFHdPC5d94+2uE2U9/EOJQF+j1pe1wQUGxMmN3Vf5wSqXvNIxV5JyY4nUAc5/1o3roP41YwzTFVk8cuq66uPvHV0/Efb2wm0T1I8esz+QbQUM6WP2Q289ugdd9xSbjrlo7thTe2zZM86SCVrLVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEG0v1FV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa670ffe302so322113466b.2;
        Fri, 13 Dec 2024 05:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734096082; x=1734700882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yYReai1ncqht/ueqrcPsQZn4164HqXgFhDBF0uVO5OI=;
        b=HEG0v1FVVQ8ZL0KSwi25X/FQuTrnDMyHWeTPekve899W9UYB6eyIHxSK/LWwjGrffa
         0j2cjJa6lci17bYd4AcylCzthWErBdvu4OM+XYFWnFbyANeFLgpYk9miUN0D9Dk3797d
         tJGXBXzY69LavmT7xYsIxh7F6tUyl8ILhs7Np6AZXTl3inwYY/5KaeBT9c85MtNJrF4b
         SSYhDiIL0cu9xf79hxu4AURMcli4PQ5Ut6o8SwTdSHNN3vPu7Wh9JlbTKjAyiHGknY49
         KQA0t2UHr/BNh9cwU6955E98GXImQGRTaKGHz4DVRKx2Xi4uG+KCxV50DxXov6O5pS7w
         9g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734096082; x=1734700882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYReai1ncqht/ueqrcPsQZn4164HqXgFhDBF0uVO5OI=;
        b=xM4Z8L3+eZdsAoj0hfH2Kt5OgUkHaDaZtfFHsz/KH7/zM06jvdubPtfWg1gWUPrw0E
         sgEHJNPZi40t85psAwbad49KGhQ6wW8zi6ihcp5IaBMT4N3a4vdwydYAx1n4bwUuA3g9
         XHmBOfhUsknfqOr/IbijUmv9EctC27/MP39BteOCV/+zQA1q3eUpSGOWZNX0jgk2J6gq
         jcgJWzFyqW40HbgnhjYQl7eNXRvvgVBc6OGV4YGzZ6T3/jAQqSHT8IOUUAn+32Z6QG3S
         KrfrKsL7sdv6NG9xn7iAHtF6s588uwa8hdBVXZH0eSE1iymMu/iNzHw1WsR0AxMflm/9
         I6tw==
X-Forwarded-Encrypted: i=1; AJvYcCUzgYNDtV83l8geVh2Xrx3LHQkZ9KJlV8tZGk9QSXkrLXsJtVho63EAnKzy7YLL0PTCZmjpZo8pntGJN0ZRqXmI+LRr@vger.kernel.org, AJvYcCVpO+c32Im5/teuQsgIxsB4nHlXjIx3oFKGs2DrBIAs723mqgGwN2MeH2BSCJZud8gVg4o=@vger.kernel.org, AJvYcCXZfd9oZy86MH7gV8Q6iXphDP61ld9ipjKnHtPZiJeByBeu/1s1FZ1Pn+KnFawxMW84fgFZj1IA9JLTAXNo@vger.kernel.org
X-Gm-Message-State: AOJu0YyddFSsHS4xsTxAL/ktp4m5Ca23L80rWmaYxpJOqNPDMYA38/Y7
	qqi+j3eeY8MLnXqMoGcpJspaUajuhTIUmW03e7mkGvOmNqEeI480
X-Gm-Gg: ASbGncsoasckylymbUfxDdeLV6Zg9es5xHk9Zpseb2uSiEZKGT3n34okobncOU2y+IM
	oDcsNWNG++bL3rDRfUYTI25mLHVhGYXI35SGwF/rBfs/Ak8rQjBeqo0kI4ifE2vv120y6oPsx62
	F+aCUmZv/5niMNxxA0P1fNMjiIe0l+9JuiN1n9CQ8IGuP7TaEHRivr6ZDlYmXFj463nv4orS4U8
	XZGQqK4Ax4wWu+4ALCL+hS6aR0KkdxC+xA0e5/CSFClciCZ8ISq77iFMI5/BG46ZxAGkf/f79X8
	1Hj5tWEwWZ7ss0UI4hHOVb8CLe8jGA==
X-Google-Smtp-Source: AGHT+IEgeM2acQAGmBVtCVr3+tK8Wh4DVdTknLjm57SablxJLBxeTJ/X/ZbU8qg7XoICgWkiUbRCzg==
X-Received: by 2002:a17:906:2932:b0:aa6:ab70:4a7d with SMTP id a640c23a62f3a-aab77ee9adbmr262127066b.58.1734096081874;
        Fri, 13 Dec 2024 05:21:21 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68c4b52b8sm674110666b.52.2024.12.13.05.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:21:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 14:21:19 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 04/13] uprobes: Add arch_uprobe_verify_opcode
 function
Message-ID: <Z1w0z2KSgFGggAVD@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-5-jolsa@kernel.org>
 <CAEf4BzZ2g6PwY+Ah-39F7Dw2AFZUE7AxEqOuNbs5LouHtKMZbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ2g6PwY+Ah-39F7Dw2AFZUE7AxEqOuNbs5LouHtKMZbQ@mail.gmail.com>

On Thu, Dec 12, 2024 at 04:48:05PM -0800, Andrii Nakryiko wrote:
> On Wed, Dec 11, 2024 at 5:34 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding arch_uprobe_verify_opcode function, so we can overload
> > verification for each architecture in following changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h |  5 +++++
> >  kernel/events/uprobes.c | 19 ++++++++++++++++---
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index cc723bc48c1d..8843b7f99ed0 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -215,6 +215,11 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
> >  extern void *arch_uretprobe_trampoline(unsigned long *psize);
> >  extern unsigned long uprobe_get_trampoline_vaddr(void);
> >  extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
> > +extern int uprobe_verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode);
> > +extern int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *page,
> > +                                    unsigned long vaddr, uprobe_opcode_t *new_opcode,
> > +                                    int nbytes);
> > +extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes);
> >  #else /* !CONFIG_UPROBES */
> >  struct uprobes_state {
> >  };
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 7c2ecf11a573..8068f91de9e3 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -263,7 +263,13 @@ static void uprobe_copy_to_page(struct page *page, unsigned long vaddr, const vo
> >         kunmap_atomic(kaddr);
> >  }
> >
> > -static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
> > +__weak bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes)
> > +{
> > +       return is_swbp_insn(insn);
> 
> a bit weird that we ignore nbytes here... should we have nbytes ==
> UPROBE_SWBP_INSN_SIZE check somewhere here or inside is_swbp_insn()?

the original is_swbp_insn function does not need that and we need
nbytes in the overloaded arch_uprobe_is_register to distinguish
between 1 byte and 5 byte update..

jirka

> 
> > +}
> > +
> > +int uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> > +                        uprobe_opcode_t *new_opcode)
> >  {
> >         uprobe_opcode_t old_opcode;
> >         bool is_swbp;
> > @@ -291,6 +297,13 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
> >         return 1;
> >  }
> >
> > +__weak int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *page,
> > +                                    unsigned long vaddr, uprobe_opcode_t *new_opcode,
> > +                                    int nbytes)
> > +{
> > +       return uprobe_verify_opcode(page, vaddr, new_opcode);
> 
> again, dropping nbytes on the floor here
> 
> > +}
> > +
> >  static struct delayed_uprobe *
> >  delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
> >  {
> > @@ -479,7 +492,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >         bool orig_page_huge = false;
> >         unsigned int gup_flags = FOLL_FORCE;
> >
> > -       is_register = is_swbp_insn(insn);
> > +       is_register = arch_uprobe_is_register(insn, nbytes);
> >         uprobe = container_of(auprobe, struct uprobe, arch);
> >
> >  retry:
> > @@ -490,7 +503,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >         if (IS_ERR(old_page))
> >                 return PTR_ERR(old_page);
> >
> > -       ret = verify_opcode(old_page, vaddr, insn);
> > +       ret = arch_uprobe_verify_opcode(auprobe, old_page, vaddr, insn, nbytes);
> >         if (ret <= 0)
> >                 goto put_old;
> >
> > --
> > 2.47.0
> >

