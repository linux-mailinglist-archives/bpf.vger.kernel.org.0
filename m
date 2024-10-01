Return-Path: <bpf+bounces-40695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E198C43E
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61443281BBA
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A61CBE86;
	Tue,  1 Oct 2024 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBuCx0CH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E801C6F7B;
	Tue,  1 Oct 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802686; cv=none; b=h+IYMPfzDFL6bEtUnEo4FabL66dIBSKGD7aksiTvrGG8185Ii/SfVwAdI4bht6vUOl5WWNm/lx+LZsMyRVe5rJNIFGx5VzzhBes2PQETwrq61iCBmSJFay36jsexCyN2rDHw3zVr9AD/Yy/8rTZ1rmkdlI9G4gxlQ968zsqnPmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802686; c=relaxed/simple;
	bh=0sSh3ZCHBJPpJ28ZMI5T70fcWwIV9M4FjxM0fbpj6iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFjaaS+n9WXGI1KdBBXK/3+39UtRXNnsXQLri0Qt4BYzimOLpAfH87QbHceGrZnvDOGdXoSOua0akbVon87/6FKqrgNxWKe70bfrdsMj6ISJc4UAD31kZXYg74WWwUvjZ8DWEjvh4ppjtseByn762aRcllQc1CA8Bpyd+czC5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBuCx0CH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e6ba3f93fdso3672096a12.1;
        Tue, 01 Oct 2024 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802685; x=1728407485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYiVgO3mv9eTxEti/PW66LLKYQU9HIPqaaS7/jCRmIU=;
        b=XBuCx0CHp8U1WKtg5VnulszI00lzMjoYTkldaaqo79YUEpssnQ5uFR4ubCmHAE/aVB
         qoX5Kg69S/AOXM2JruD09hsG2RXT4NVy9lviPUCtjTMTOT7w7JnJQTL2LGkYItKYKte/
         mF26Ejqm8DxFbApY2q2+goDT6x7l9irhQ6vNVUShl1ioHWoq6QwkDBqsKzPCUmmxdT1I
         gt/Dd+WT9q/hdpeL+QDtZ0DV/UfXVLwbtgtQnumFdWzGODJg5r+DeFgsnNCkAHRaMmUJ
         FbU2FLudtz28rRqtvWw3X0Hp/T4DHmNNSMmuWr4MHbCfHKvFT9QEE+LaoDcGjVBxpFqW
         UIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802685; x=1728407485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYiVgO3mv9eTxEti/PW66LLKYQU9HIPqaaS7/jCRmIU=;
        b=OSe71bJ3NLmmRd1k6fF6sAVFKag7Y+z4QZdpHYyYgsikih/HkZf3TOrvVauH3A/nB2
         x0ot2mZfSLjw8haPcXBLciDlV+hhGyMcQlE6p+Bj38IQz8N/J0D8qVHxtXOxsm2ADmYk
         827CP7/jd7AT8PcHd8NKqTmaKzqlPaYYDZpOZ/EQk8UM+aqT7aHi21O2BMifQ4oTq795
         Hdn2GAsxVnpIGtRIkmKVlF61Gtip6N8dtRBppVsmvETBYkC9P+f1i3EMZOcvsOXEZ9Cu
         8/gorQqcaX57OmRz6L3vuJYnuK6ITyUIM5poSQN+Agc8NMr8H9bCzYA/xHNAa7/KxGsl
         rizQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7eeeMrVa1j3i7HN9KXkB4v//MbNIW5LR3Wna2UAMewGOCOz7g6YJgHLCatt/uB5rkbTV6oIBuqrQuCpHM@vger.kernel.org, AJvYcCVeiwp0dtdqJiwHk12Wlcxle+t1dloXROo0h7be52ribi3uHxURby1jInGjZBh8otqZNNboIZEH9+MqnJy8q4T9xW4C@vger.kernel.org, AJvYcCVnkuJHvBSkiu73QT7seSZqKtYyyt0EEBqG+MUhClq+cdGXn6sYJWlOvCuAlIYImM2UzoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdxhf2cydiGezFlMInQOXG7g5YgC7BwofW4FaE05gpfKmPWYS8
	IsuSy4l0fmt9FkkUwa5zy5BbVPVfC2qKv1p+1MG+7ZnqdzwWeTIFGnHk7DI7vMlIfMJUQ0Rzmx2
	dTk2a+qum6rVrqu+oH8NptAYoHec=
X-Google-Smtp-Source: AGHT+IFbWZu/Op5q1u1++KWxKhxXOCSmOqj/rf3NlKpN4maBxpEa9f3ipFc/ib5YDm7xhueuTWGYXhMA0NtOiUzD3Vs=
X-Received: by 2002:a17:90a:ae0a:b0:2e0:8c5e:14a0 with SMTP id
 98e67ed59e1d1-2e182c994f2mr523996a91.0.1727802684899; Tue, 01 Oct 2024
 10:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929205717.3813648-1-jolsa@kernel.org> <20240929205717.3813648-4-jolsa@kernel.org>
 <CAEf4BzZfy1H2O-uY3x9X7ScsJTXHgqjZkcP7A0tMmhmvubF-nw@mail.gmail.com> <Zvv2gciCj-0mAnat@krava>
In-Reply-To: <Zvv2gciCj-0mAnat@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:11:13 -0700
Message-ID: <CAEf4BzaRrg_=scWTt1X7fvB+4wxUiiQUOCPvvtWgL4_rwr+2CQ@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 03/13] bpf: Add support for uprobe multi
 session attach
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:17=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Sep 30, 2024 at 02:36:08PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > >  struct bpf_uprobe_multi_link {
> > > @@ -3248,9 +3260,13 @@ uprobe_multi_link_handler(struct uprobe_consum=
er *con, struct pt_regs *regs,
> > >                           __u64 *data)
> > >  {
> > >         struct bpf_uprobe *uprobe;
> > > +       int ret;
> > >
> > >         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> > > -       return uprobe_prog_run(uprobe, instruction_pointer(regs), reg=
s);
> > > +       ret =3D uprobe_prog_run(uprobe, instruction_pointer(regs), re=
gs);
> > > +       if (uprobe->session)
> > > +               return ret ? UPROBE_HANDLER_IGNORE : 0;
> > > +       return ret;
> >
> > isn't this a bug that BPF program can return arbitrary value here and,
> > e.g., request uprobe unregistration?
> >
> > Let's return 0, unless uprobe->session? (it would be good to move that
> > into a separate patch with Fixes)
>
> yea there's no use case for uprobe multi user, so let's return
> 0 as you suggest
>
> >
> > >  }
> > >
> > >  static int
> > > @@ -3260,6 +3276,12 @@ uprobe_multi_link_ret_handler(struct uprobe_co=
nsumer *con, unsigned long func, s
> > >         struct bpf_uprobe *uprobe;
> > >
> > >         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> > > +       /*
> > > +        * There's chance we could get called with NULL data if we re=
gistered uprobe
> > > +        * after it hit entry but before it hit return probe, just ig=
nore it.
> > > +        */
> > > +       if (uprobe->session && !data)
> > > +               return 0;
> >
> > why can't handle_uretprobe_chain() do this check instead? We know when
> > we are dealing with session uprobe/uretprobe, so we can filter out
> > these spurious calls, no?
>
> right, now that we decide session based on presence of both callbacks
> we have that info in here handle_uretprobe_chain.. but let's still check
> it for sanity and warn? like
>
>         if (WARN_ON_ONCE(uprobe->session && !data))

You mean to check this *additionally* in uprobe_multi_link_handler(),
after core uprobe code already filtered that condition out? It won't
hurt, but I'm not sure I see the point?

>                 return 0;
>
> jirka

