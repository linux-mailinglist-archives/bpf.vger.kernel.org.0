Return-Path: <bpf+bounces-36403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566BB948055
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 19:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838E31C21C8A
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E8815E5D4;
	Mon,  5 Aug 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH0Lvem1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A044F17C64;
	Mon,  5 Aug 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879110; cv=none; b=SkxywU9VvAvoNnCcvSDHNmzvsSHgon+/fG43fO/8ElmIjj4u/UUPsXUTM8OTeGjsqT/DwhqP4b3VYXuCoNdVPZJo0UXHBMarekYx5YS+2xW5fBaT/iadUxVYjW9W1KPslQl4WgzxL3pptE7HTGJHibh48fssm0K7wce5UTH1rus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879110; c=relaxed/simple;
	bh=Ibgh/YjVQWJdHMNczmxRvke1jNVKCND/SdSPSZ79/jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCVhyG2zw7Sm/afMA/s6hhhKDqiAkmOu10MxdjuPCxyRbi1QmUTc6h//6r3QwhFiuAyX3I8rpXRcOm13MBcmsnPeT60CexEtmBPH1MpKhSrm3Tvy8HGYTPPPhhtsN74DdcjDOcEgOtUp9l8GDBTn+xGT/d6EcTPo3iP8YJsTiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH0Lvem1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7b594936e9bso3533470a12.1;
        Mon, 05 Aug 2024 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722879108; x=1723483908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1g5VDeZ4AkSP/vFwnOsYgzTX60jyBRR6+L3X4qb46I4=;
        b=hH0Lvem1lNJuDrqSzvK+4i/y771y3Pzvx92wll0kv5NepusjlSLBsmWDynnCXCxZcW
         PbFr3eNXFOUc8neyoE+klK6kORMy90M/dhJgYsvrCC6fk1x49BaEOzHt1XcyMVY/Y5dC
         vIfybYZcjr8YKMjRcUqaBsg8j2RCF1ieSNaSGSw1JRSGnmR50pEtj56PPkhVY9bJkHRa
         lB1NaLx/5al/VXN14nL+EAJUt3SkJ9GUVI3cu7ztuiuwQUlO5mHfQg6wOz9YiyOfZhEK
         vlGmy4BHfdTc9fjK0Nhwf3+eu1d6d+GMbeh5+xA3UgDbLQx/vzUtUaHzaaO7Es3FBHhs
         CrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879108; x=1723483908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1g5VDeZ4AkSP/vFwnOsYgzTX60jyBRR6+L3X4qb46I4=;
        b=xMuobTkEmyJYH2bp8H0jmWLx+dNNTO4Y9TktTAyuP9Vqz5PxWyVvIpA4WqBURtRh6g
         xfH/8LDhmMlw0cCfLkQYCksadtw3dAoS6Xh77WNkJeCe7Bdg4bINMpa+1RQmuea7jtj/
         gk4nuRGpcNXQFh/MwkIXTXht060K3CLwfDgPRp3h6ngqCD9oo0WvXdWtOeGPOrgQiWgJ
         Oct/KTTBrhdZZksSczzHfaVM+1sgjENZe5oft1W3xs742SQmf1S4fhuxKuDvoLo/CwU2
         9dQ0Y9KJY5hphijOkdtY3tc6ydIoLE7ivJxPS9WX5B/874Q3phVdNCeo4EqsVmX898tV
         i2XA==
X-Forwarded-Encrypted: i=1; AJvYcCXp1NfGnAQ7zWaYRLvqxedt7qsrFXPPG3vAGWO0aov7kre5Dzonv6OKBlBbR6W5f7lVxDK3zqz/Q13hVVl+C6aW9witV4sWxOk3/ZxoKJljLKSHQ82yNn1jlazOrXLhkLo3UITfb8kupyMWc4ql+mwazFBKWCZJHXcqj+ErR9Ba6nnKt++e
X-Gm-Message-State: AOJu0YzGkDLtTqNJv0e5pT5nvVMasHMet7k2Q5cViFuovnJcYlkH8ZUY
	83fzdso3W9XSOu0dWt2m1prgp6i5/ldSuoqEHN0qJxAL8y35wvGWY1kNdls0kdOPzoyojr2VmkE
	dv2KzIJUSHicnQEX03FrdD/ZOzI0=
X-Google-Smtp-Source: AGHT+IFZ+nZS9EEXWDkpoeAVyAwFiMG+8EshzGXCL0tvbjG8wSxbegA3OU0L3jzDRvQ7v0SSg0+TlbtD4coNmecrYB0=
X-Received: by 2002:a17:90a:a883:b0:2cd:55be:785a with SMTP id
 98e67ed59e1d1-2cff93c4c5amr12152134a91.1.1722879107995; Mon, 05 Aug 2024
 10:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-4-andrii@kernel.org>
 <20240805145156.GB11049@redhat.com>
In-Reply-To: <20240805145156.GB11049@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Aug 2024 10:31:36 -0700
Message-ID: <CAEf4BzYnYZAOg1syEhDYG-B4Te-f1YccdJjO466h1pUJ5G4Erg@mail.gmail.com>
Subject: Re: [PATCH 3/8] uprobes: protected uprobe lifetime with SRCU
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 7:52=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> LGTM, just a few notes...
>
> On 07/31, Andrii Nakryiko wrote:
> >
> > @@ -59,6 +61,7 @@ struct uprobe {
> >       struct list_head        pending_list;
> >       struct uprobe_consumer  *consumers;
> >       struct inode            *inode;         /* Also hold a ref to ino=
de */
> > +     struct rcu_head         rcu;
>
> you can probably put the new member into the union with, say, rb_node.

yep, good point, will do

>
> > @@ -1945,9 +1950,14 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs =
*regs, unsigned long bp_vaddr)
> >       if (!utask)
> >               return -ENOMEM;
> >
> > +     if (!try_get_uprobe(uprobe))
> > +             return -EINVAL;
> > +
>
> a bit off-topic right now, but it seems that we can simply kill
> utask->active_uprobe. We can turn into into "bool has_active_uprobe"
> and copy uprobe->arch into uprobe_task. Lets discuss this later.

I'm going to change this active_uprobe thing to be either refcounted
or SRCU-protected (but with timeout), so I'll need a bit more
structure around this. Let's see how that lands and if we still can
get rid of it, we can discuss.

>
> > @@ -2201,13 +2215,15 @@ static void handle_swbp(struct pt_regs *regs)
> >  {
> >       struct uprobe *uprobe;
> >       unsigned long bp_vaddr;
> > -     int is_swbp;
> > +     int is_swbp, srcu_idx;
> >
> >       bp_vaddr =3D uprobe_get_swbp_addr(regs);
> >       if (bp_vaddr =3D=3D uprobe_get_trampoline_vaddr())
> >               return uprobe_handle_trampoline(regs);
> >
> > -     uprobe =3D find_active_uprobe(bp_vaddr, &is_swbp);
> > +     srcu_idx =3D srcu_read_lock(&uprobes_srcu);
> > +
> > +     uprobe =3D find_active_uprobe_rcu(bp_vaddr, &is_swbp);
> >       if (!uprobe) {
> >               if (is_swbp > 0) {
> >                       /* No matching uprobe; signal SIGTRAP. */
> > @@ -2223,6 +2239,7 @@ static void handle_swbp(struct pt_regs *regs)
> >                        */
> >                       instruction_pointer_set(regs, bp_vaddr);
> >               }
> > +             srcu_read_unlock(&uprobes_srcu, srcu_idx);
> >               return;
>
> Why not
>                 goto out;
>
> ?
>

Good point, can be goto out, will change.

> Oleg.
>

