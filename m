Return-Path: <bpf+bounces-36236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA532945114
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 18:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5D21F2433A
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2171B9B3B;
	Thu,  1 Aug 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHHK2njM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8991B4C38;
	Thu,  1 Aug 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531005; cv=none; b=FodBoVozoRRTCAApmASmiu6gPdGwim8hQtZACuEFTvqbXn/QguhPY3MseOE3UzaluyXDllveQqWM7ndVDJRgso9ZYOGZoI8uXKS4/JCAdlEmfIAUm9KMQ2SSaCW5H9qC/WQz5HhGzu6BiMIg6UUVzVCjt/qr5dOhEFWrkPk1Su8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531005; c=relaxed/simple;
	bh=QljzG37ZxW+ppSl9zWBZVeNiQZbhg8Gf/7+gLVuFROI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HThffxX7uPgttZzLxVyjNlXidlNpEHg7vUL830CP/Rqd8LAUFOpJR8eLuamdhcwueb1B/+vny5ChoqoVcqlb1/nmIGzLe4CboH1mlLjyRrUEcZSBxPivysU2u0zKbNsD/FReGo9HKDn83qYCFnCXH9YLwL75kyZZtiOL048V2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHHK2njM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so4656309a12.1;
        Thu, 01 Aug 2024 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722531003; x=1723135803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF/PKvsxpz+PWWENgL52yR6SfVEAwuJr0if6hvpz4X4=;
        b=lHHK2njMf5L+vbaSpv7wFWT2VCUxCJRe4zK+2gmlH0u6DjYqLcnkfVu7fTUWvvOJxY
         jGypik9lf8ZzDwdWSqNp7n2IJ9B5m+wr1EDFKCzoO9Zi/xaGeCtNNU6iJedNn7/bsOr6
         cK8t2msc7SRCVcLcOxCISkaUpEUVx3Xh49DHwPwfzPmoY1Jh4p5dRQi31I23HsBkoOjY
         vPtdEcqnU4GnpqZOkGnqRGV9rkJN7mEWeQlN9pkVNYDF30CNigGyJD4RBTJSYLcnmUr2
         0gbv0lrHYt8I4p9S2zpAE+IPDZbrcyul39HAmF0Eb65EJt0pVGxt/xdP5AGdy7l0fE6X
         q7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722531003; x=1723135803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF/PKvsxpz+PWWENgL52yR6SfVEAwuJr0if6hvpz4X4=;
        b=auXNH4BSl7rTe9r50/WDT5IzlVfWKpGZXdRxl8fekYIid9ZrQyUcIwF97gb77AGx9M
         mWYocqhJNjpawCokKXFiBXP1wBHcsfGlmidvjbbkLT/5STCF23QvViPP/89X3cUWiStH
         wUuHie8vupY3qQVmK4X6KnCMURtjB86w2rwZPuKgUmAyaI5xYdutjNVdy8E0azjtkePA
         Zk/vWila9XT3C8U4pOtTCB/Dk8mWt8n4xRQR07HUp0Ko+ItoagimItDsMaT6A0/0mOgn
         7Pmj1gS8I/aWoUqlgklFf4Nuna6Dcbb1rStUlHSw/17Mgsa7ItfddCeBh1ZHP6qOxRQt
         4DKg==
X-Forwarded-Encrypted: i=1; AJvYcCVrqDQIZbfcx0h0C55+gI8fR91D3Y7FQP81a89PkM2N+qHWyUgAr5YlLoyho9Hm5iJgGPXvuogUcOcUKfJhC56RP07/gGdXz6IhhazHzzxnct1aNP56bhpr/TrF8mMsSw20Ts1Yk1B+Y9BDSyhTTkANKAG+8Php4YsVvvcI2+UwQ15qM7OY
X-Gm-Message-State: AOJu0YwTW6TySE/uROsSse+Gx8pU0P+tjAdy9yD1yFgKnBq9rpwhXTWj
	ujQPWVKq6ISiCSZPSZU/KFHvQ/0MNwEUrR3hl427ZFTjeTnofQ/hqxjAuXY72CDji3publ8dZOz
	2nKWlgwb07AI7ZBmduIWnevNTNI9CXQ==
X-Google-Smtp-Source: AGHT+IGzRy+bLYqJHbWDpA/872OJbR8D03DVKbqk2H2EDP0006B1BLsZZwpVddcQqfOiMCfn9GJsSwRwUnNUY2sXyX8=
X-Received: by 2002:a17:90a:c70c:b0:2c9:7803:1cf6 with SMTP id
 98e67ed59e1d1-2cff94478a8mr958345a91.20.1722531003456; Thu, 01 Aug 2024
 09:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-6-andrii@kernel.org>
 <ZqubRQ3TRsZbV9fo@krava>
In-Reply-To: <ZqubRQ3TRsZbV9fo@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Aug 2024 09:49:51 -0700
Message-ID: <CAEf4BzYGrkqDQN1awdS=7HNa0=Rkhmn5jtCWMA3r9TaX3Hjpfw@mail.gmail.com>
Subject: Re: [PATCH 5/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 7:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Jul 31, 2024 at 02:42:53PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> >  static int __copy_insn(struct address_space *mapping, struct file *fil=
p,
> >                       void *insn, int nbytes, loff_t offset)
> >  {
> > @@ -924,7 +901,8 @@ static bool filter_chain(struct uprobe *uprobe, str=
uct mm_struct *mm)
> >       bool ret =3D false;
> >
> >       down_read(&uprobe->consumer_rwsem);
> > -     for (uc =3D uprobe->consumers; uc; uc =3D uc->next) {
> > +     list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > +                              srcu_read_lock_held(&uprobes_srcu)) {
> >               ret =3D consumer_filter(uc, mm);
> >               if (ret)
> >                       break;
> > @@ -1120,17 +1098,19 @@ void uprobe_unregister(struct uprobe *uprobe, s=
truct uprobe_consumer *uc)
> >       int err;
> >
> >       down_write(&uprobe->register_rwsem);
> > -     if (WARN_ON(!consumer_del(uprobe, uc))) {
> > -             err =3D -ENOENT;
> > -     } else {
> > -             err =3D register_for_each_vma(uprobe, NULL);
> > -             /* TODO : cant unregister? schedule a worker thread */
> > -             WARN(err, "leaking uprobe due to failed unregistration");
> > -     }
> > +
> > +     list_del_rcu(&uc->cons_node);
>
> hum, so previous code had a check to verify that consumer is actually
> registered in the uprobe, so it'd survive wrong argument while the new
> code could likely do things?

correct, passing consumer that's not really registered to
uprobe_unregister() is a huge violation of uprobe API contract and it
should never happen (and it doesn't), so it feels like we can drop
this overly cautious and permissive part (we don't protect against
passing wrong pointers, NULLs, etc, right? so why would we protect
against wrong unregister or say double unregister?)

>
> > +     err =3D register_for_each_vma(uprobe, NULL);
> > +
> >       up_write(&uprobe->register_rwsem);
> >
> > -     if (!err)
> > -             put_uprobe(uprobe);
> > +     /* TODO : cant unregister? schedule a worker thread */
> > +     if (WARN(err, "leaking uprobe due to failed unregistration"))
> > +             return;
> > +
> > +     put_uprobe(uprobe);
> > +
> > +     synchronize_srcu(&uprobes_srcu);
>
> could you comment on why it's needed in here? there's already potential
> call_srcu(&uprobes_srcu, ... ) call in put_uprobe above
>

yep, I should. This is because we might have handle_swbp() traversing
the consumer list in parallel with unregistration, and so it might
have already seen this consumer and is calling its callback. So we
need to wait for srcu grace period to make sure we don't have any
calls to consumer's callback. If we don't do that, the caller can free
the consumer's memory as handle_swbp() is still using/calling into it.

> thanks,
> jirka

