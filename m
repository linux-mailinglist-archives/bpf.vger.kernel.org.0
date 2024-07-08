Return-Path: <bpf+bounces-34115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868192A85D
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC380B20A1E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CD9149C60;
	Mon,  8 Jul 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2ZXzLjj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0D13E41F;
	Mon,  8 Jul 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460851; cv=none; b=PZTe8mFmWu6opdnVeW0Ey/i7LNs367Nb8MnGnQRyJinEG2JLzMlp4suZcDwbMZq4kN/30/OxaG829n8MHxYx1D9ljcFCwBMp0iLdwBL2byMMwD6/S9abHGUzazbyD1o416h9DS2DNRTLHr4vMBXhvYZBGRbYc8Eh55V2qBoZBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460851; c=relaxed/simple;
	bh=YmRJ/llYeqWDvkAYZ6TNULQzPAxdrLYFGHqHcqllx+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXeoQhQhvWnLQ5J4510QqxIwZ2qXfIKwz+Xo9jLugF7X9jp0SA2JkmFLfCKcgAfeP+kk9ZGNZ4PEC6u8f0RIJwWoiSrCA8rW+h/Gx5QqIjKrhQTRrejAAnGwbslwT7HNgzANwiKnqnFqfvJ8nvvCQ2a2VPV+bI72+J354YUK8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2ZXzLjj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-767506e1136so2158833a12.0;
        Mon, 08 Jul 2024 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720460849; x=1721065649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9QNspGgC5kgbd17kT8SP/v8QG2qYZqzuZld1mm1/6M=;
        b=l2ZXzLjjEVrilF8QPtrokLcBp4zDV//tBcRU97d+ZIt2kY8Oxu6lmwGYk85pxfmhcE
         AlNluJX82yeQx2j0uBe/F8SEGfHs6VQmavdWC8LztR5z9hcmd/6WxoRoVOuJyk52hA9r
         jyPpgvaq8RKdqix6jpYxWBid9pz99LxR6ZTYjD4TBcZyktfAuI6xep+6u9sIyAyOSk9N
         eEYxPhm7e/XgVrJJSihAWAx+9EL+vYftBUR7CmHRs+kIuWLaU2Ij5yqtsmfAMjlAIx27
         GwkfllsTYfCvxdLLnoOlKM62Mcx5Hx8EhR4SabtnaXiUIrmkxtkHbFyRMgqhmEA3OOGR
         3LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720460849; x=1721065649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9QNspGgC5kgbd17kT8SP/v8QG2qYZqzuZld1mm1/6M=;
        b=TSlwLIkMEowK1ZTfvThgEGt6m+haiY+5G5gnGD2llu5NEJqOUh/M7WIRhtUXPeOyyY
         0tbkJeBDgZBdFpx2zuG+QXfcbVH+EGtbFJg4AV61wu/wgxtUZsGZB8+JlNdi2RYkrwt5
         RQpkLTN0t54smegvd4EIGtnuzAscr5AyfOc9dQJBcu0r9WzhdvOZu0TNlNw+vM0OivC9
         iXdOXaKJ7FqQ6wplFAYLA8EoEs+oq5yYGLlzWjkad/RanNoY6Tl2IPmAK4u/IZGD25Qd
         S6M+XAMmQ758RBIjYBKrPv9WIcGZPav2bEeBYmKaXm8xCzXZdwXCHcwzBtkp3W6iJjQ1
         NrZg==
X-Forwarded-Encrypted: i=1; AJvYcCXHbY22Qpv3VxymCCZ/IZy8rzxjeLe1cUVPlp5Blb43KB/CWbaFOm4rWbkgBiL0cozvDz8SQ3WpTXqGJdKium9pv9McpaDWB6bHTX4EB9RZxpUkUl1K9mrwH6qveTK6IYn8pfOcMekY
X-Gm-Message-State: AOJu0YxWSG5Qhvis+/PTqvDsJRvhsOL0nRfp43O2RjdwWqFZVrPdPht6
	w6qBZCBGN5A1ozE+u4Zm8jFgwKPBK0jm33ZzCjBRDElU/Fm1tFdtvJREggZfXBpkHktNRn2hDZO
	SGFygklc1XZsDyfSiNymQJCV95F0=
X-Google-Smtp-Source: AGHT+IGcB+YcUctnfqopoAMa1xqchCmZp7cNeI4mqNep7QNu9Igx4yldh0+di1tcnCo8ZMWa/pDE8iln6XAtdD6IUDY=
X-Received: by 2002:a05:6a21:1698:b0:1c0:f1c5:524 with SMTP id
 adf61e73a8af0-1c298530b2emr90618637.16.1720460848936; Mon, 08 Jul 2024
 10:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-5-andrii@kernel.org>
 <20240705153705.GA18551@redhat.com>
In-Reply-To: <20240705153705.GA18551@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 10:47:16 -0700
Message-ID: <CAEf4BzYDJMo0E=pVFkqctdPQa66kD-Lt7Rx7BkMKw6TQtLcjtA@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime management
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 8:38=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Tried to read this patch, but I fail to understand it. It looks
> obvioulsy wrong to me, see below.
>
> I tend to agree with the comments from Peter, but lets ignore them
> for the moment.
>
> On 07/01, Andrii Nakryiko wrote:
> >
> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> > -     if (refcount_dec_and_test(&uprobe->ref)) {
> > +     s64 v;
> > +
> > +     /*
> > +      * here uprobe instance is guaranteed to be alive, so we use Task=
s
> > +      * Trace RCU to guarantee that uprobe won't be freed from under u=
s, if
> > +      * we end up being a losing "destructor" inside uprobe_treelock'e=
d
> > +      * section double-checking uprobe->ref value below.
> > +      * Note call_rcu_tasks_trace() + uprobe_free_rcu below.
> > +      */
> > +     rcu_read_lock_trace();
> > +
> > +     v =3D atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);
> > +
> > +     if (unlikely((u32)v =3D=3D 0)) {
>
> I must have missed something, but how can this ever happen?
>
> Suppose uprobe_register(inode) is called the 1st time. To simplify, suppo=
se
> that this binary is not used, so _register() doesn't install breakpoints/=
etc.
>
> IIUC, with this change (u32)uprobe->ref =3D=3D 1 when uprobe_register() s=
ucceeds.
>
> Now suppose that uprobe_unregister() is called right after that. It does
>
>         uprobe =3D find_uprobe(inode, offset);
>
> this increments the counter, (u32)uprobe->ref =3D=3D 2
>
>         __uprobe_unregister(...);
>
> this wont't change the counter,
>
>         put_uprobe(uprobe);
>
> this drops the reference added by find_uprobe(), (u32)uprobe->ref =3D=3D =
1.
>
> Where should the "final" put_uprobe() come from?
>
> IIUC, this patch lacks another put_uprobe() after consumer_del(), no?

Argh, this is an artifact of splitting the overall change into
separate patches. The final version of uprobe_unregister() doesn't do
find_uprobe(), we just get it from uprobe_consumer->uprobe pointer
without any tree lookup.

>
> Oleg.
>

