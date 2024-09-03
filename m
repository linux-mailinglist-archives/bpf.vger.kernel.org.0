Return-Path: <bpf+bounces-38801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40B96A580
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0D0287291
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D018FDAB;
	Tue,  3 Sep 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG/jCMVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50C18DF8B;
	Tue,  3 Sep 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384925; cv=none; b=Jw5TH20NaWi0Lr5ww0iMe4bsXglZ4q8aqLetoOsuVPk0F8ERzvhUKb2YWS309+gvsxinI4J5aQEx9cBUdmrb9Qt/naplO62lelM3BrfA1i8yUpOsnv8BUujaG5peK/CnGRm481486i9FcJ/SLxktUCa1v7Vgox6KDtLB5NBzAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384925; c=relaxed/simple;
	bh=LQwsYC0/HXU6jv1YztlWr/faX6lsno7F23xR44vC5ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsXohx9HpA1xPgCTTYmGL4iTaNQ1pj8yJTMdPxh4rNL5BG7ieQUBtYd/yGeZ2AdqRfVTzkMiEOG+jZL05ZBIvAHtF1UeaCRfIdJi4WVQQ7RpvWWXqY6Mhu4TIfK3JMj0IybxpFRrUuia8HJo2qpFdnPT83+BvBEyhnOEQa8aX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG/jCMVN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so1163230a91.0;
        Tue, 03 Sep 2024 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725384923; x=1725989723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3hUXgLjalL7lAeUT4m6rvI6dnqff1plFSiWYGGCoE0=;
        b=AG/jCMVNwCHA4Dyii8SIMZJJ8eoDatV9yd7Gu1SPdIpYWk+sFKjQ3IGxOk5+TTErBs
         IkFItP5ar9uOrp08u2uIoeSiX88+HZwXRl/pA7rt0Vmh3+0NZp1qTJMD2rQkNDoBFO/i
         AmIo6nYkn73QvPVO3XLtEEWXZVbwFpol3KyrcBaNwvWlFL7sx5V6yixh831eKwXqf+yI
         K8YpBH8d2Pf6XDGqCoLQBfDOx0JDSSPXpx/l6bjeZfvPFQfycIdKDGfWto3q++5iqQGW
         Dx3mb2v5rrapnrwlu/JYfXDM+Jksp1nQM05vUJjkytAyYcpkF6tvfvd7PGnWRG/2fkTL
         /cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725384923; x=1725989723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3hUXgLjalL7lAeUT4m6rvI6dnqff1plFSiWYGGCoE0=;
        b=lUaS9iNxMGAmNKJgpPgxszrwKSlcDiYfnt+Dhj5Hl4lFEYU0kHdhMKj3LN8WOwcVwm
         56+vt3iuNcH20rGEAbff7bpsnK+renLz1ZHPBCgG8CcRtjMSjmwpac4q47o6qMQZyeDH
         2EwKD4QAP7YGlnsKytQA0KlY6kpmFRHinxYto1/JlqUAZS8CJ2wrf/FPGFR5rSVnn3Fa
         Q4ujBTdChAHBCb8wRUet/Ah1FH2KxG87OlViezV+r4wOzUUgSkAl8Z8t/N4o6b5PVwMU
         hX21Oi/ZfXfsvMVqaB8p5WfBIiqn+njKAO/7cqxKfRVboJiN1EYcMAwN0PCkIbNSWxTH
         WzTg==
X-Forwarded-Encrypted: i=1; AJvYcCVJWbBSZrTFdTAlUmp3aFMAPZx1j9ESP0bu7aw3IDNm0THfEnIHsAydaciQ8x9by5VbnIyDXyAFycJaXh4r@vger.kernel.org, AJvYcCVpujKKvoJw88DJQx1dUkiYrWVfZRvioiQIZXYS8+jSsZr2vu9qwwhgspT9QW9ztDSOxsBMjO44J4NIfP5aDJr4GAc8@vger.kernel.org, AJvYcCW/Wv6MuKyT3J68eud93DOFp+Aq2n9wJvPXNswkl87R+S7vncdoPb/ELcE53UYSVMhu22s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc3hQjZA4+hEVmfxkFhXVQ5NsYSEaY1LJfY83yP35MitfgrJkn
	tjqNm0es/s0wkhCl2MGkOzHM0Wu73MuT9WbY5ddT/k/p/xebKiwA00Wu4Q6y0SabFDzfKTJjuTt
	l+u4UAUI0mY6obMT/TAr5jLFJ2Ik=
X-Google-Smtp-Source: AGHT+IE2Caw/xhU7eXyirtFUOj3URIayxgMSRZGkemLmVzQAwmUHrOMrd18peOQe/Wv611jgoKooKYSc1l00fOUfgnU=
X-Received: by 2002:a17:90a:6fa2:b0:2d3:bfc3:3ef3 with SMTP id
 98e67ed59e1d1-2d88d6af3dcmr11971100a91.12.1725384923145; Tue, 03 Sep 2024
 10:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829183741.3331213-1-andrii@kernel.org> <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava> <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava> <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
 <20240830202050.GA7440@redhat.com> <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
 <20240831161914.GA9683@redhat.com> <CAEf4BzYE7+YgM7HMb-JceoC33f=irjHkj=5x46WaXdCcgTk4xg@mail.gmail.com>
In-Reply-To: <CAEf4BzYE7+YgM7HMb-JceoC33f=irjHkj=5x46WaXdCcgTk4xg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Sep 2024 10:35:10 -0700
Message-ID: <CAEf4Bza6SRP0ZTuOa=W8W3uM86DJKkGoTQ9itHxcdGWt1Su=-Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:27=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Aug 31, 2024 at 9:19=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> w=
rote:
> >
> > On 08/30, Andrii Nakryiko wrote:
> > >
> > > On Fri, Aug 30, 2024 at 1:21=E2=80=AFPM Oleg Nesterov <oleg@redhat.co=
m> wrote:
> > > >
> > > > I'll probably write another email (too late for me today), but I ag=
ree
> > > > that "avoid register_rwsem in handler_chain" is obviously a good go=
al,
> > > > lets discuss the possible cleanups or even fixlets later, when this
> > > > series is already applied.
> > > >
> > >
> > > Sounds good. It seems like I'll need another revision due to missing
> > > include, so if there is any reasonably straightforward clean up we
> > > should do, I can just incorporate that into my series.
> >
> > I was thinking about another seq counter incremented in register(), so
> > that handler_chain() can detect the race with uprobe_register() and ski=
p
> > unapply_uprobe() in this case. This is what Peter did in one of his ser=
ies.
> > Still changes the current behaviour, but not too much.
>
> We could do that, but then worst case, when we do detect registration
> race, what do we do? We still have to do the same. So instead of
> polluting the logic with seq counter it's best to just codify the
> protocol and take advantage of that.
>
> But as you said, this all can/should be addressed as a follow up
> discussion. You mentioned some clean ups you wanted to do, let's
> discuss all that as part of that?
>
> >
> > But see below,
> >
> > > I still think it's fine, tbh.
> >
> > and perhaps you are right,
> >
> > > Which uprobe user violates this contract
> > > in the kernel?
> >
> > The only in-kernel user of UPROBE_HANDLER_REMOVE is perf, and it is fin=
e.
> >
>
> Well, BPF program can accidentally trigger this as well, but that's a
> bug, we should fix it ASAP in the bpf tree.
>
>
> > But there are out-of-tree users, say systemtap, I have no idea if this
> > change can affect them.
> >
> > And in general, this change makes the API less "flexible".
>
> it maybe makes a weird and too-flexible case a bit more work to
> implement. Because if consumer want to be that flexible, they can
> still define filter that will be coordinated between filter() and
> handler() implementation.
>
> >
> > But once again, I agree that it would be better to apply your series fi=
rst,
> > then add the fixes in (unlikely) case it breaks something.
>
> Yep, agreed, thanks! Will send a new version ASAP, so we have a common
> base to work on top of.
>
> >
> > But. Since you are going to send another version, may I ask you to add =
a
> > note into the changelog to explain that this patch assumes (and enforce=
s)
> > the rule about handler/filter consistency?
>
> Yep, will do. I will also leave a comment next to the filter callback
> definition in uprobe_consumer about this.
>

Ok, I'm adding this:

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 29c935b0d504..33236d689d60 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -29,6 +29,14 @@ struct page;
 #define MAX_URETPROBE_DEPTH            64

 struct uprobe_consumer {
+       /*
+        * handler() can return UPROBE_HANDLER_REMOVE to signal the need to
+        * unregister uprobe for current process. If UPROBE_HANDLER_REMOVE =
is
+        * returned, filter() callback has to be implemented as well and it
+        * should return false to "confirm" the decision to uninstall uprob=
e
+        * for the current process. If filter() is omitted or returns true,
+        * UPROBE_HANDLER_REMOVE is effectively ignored.
+        */
        int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
        int (*ret_handler)(struct uprobe_consumer *self,
                                unsigned long func,


> >
> > Oleg.
> >

