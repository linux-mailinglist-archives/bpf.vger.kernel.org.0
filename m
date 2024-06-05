Return-Path: <bpf+bounces-31462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E68FD7BD
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441361C22DBB
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD615F304;
	Wed,  5 Jun 2024 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwAJAF2k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D777462;
	Wed,  5 Jun 2024 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620434; cv=none; b=bPYsW4n1mfUk6LV/1NRJsoq3p2FluqwzeKPX13eZLCxizR3s1QLvbyfcIOf9bI2N231k2M2qI9ooNhueAX+zztvKDErf9LxSNtLGzHaALFrBL41ogURC7TcIe8G2DlsOiiKa9iI1a3C7uTh5XWVt7/mk4k8yKQBVZAm9WPS0Ekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620434; c=relaxed/simple;
	bh=klYKjOnVknraFytFz7IL6PTVE75Fk90Z7bNkhzgsgS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiQL/nYdbgsv07xNLa24HVETeFj8wQUkorcuiomkmNa0auw+yr+5gisXNmEFd5LbNfVEPvuuUFErB1NMD+sg7D0ut7CfzAT7hxdGNrN4quUEZhfy5d8hKZdYXZWu7GLFSPO5k7683kAwJrEL2w3s4SkK+Vcqiz1iELl+uFCJkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwAJAF2k; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c2200dbdf7so225328a91.2;
        Wed, 05 Jun 2024 13:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620433; x=1718225233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Glm3mA8QnXBmJCA+vVErk08DMx6cbnQiMEf8o6LS5k=;
        b=BwAJAF2kmBu86dX245iKgqOmOdGM9b9ThofwHlPf9ULxkCMYor18OnJCFj+yUAfpbI
         PfGNNAfPnv6+o2OlmYNdOiDCRKyXR+G2K23Oz1omqtTxs3qPWUQRV33TBBKKKVVyRwSH
         9X3DEIYSiI22TCDun2uuNYdJqRvT9jx+cjjt0iQMTqNSPo9QN1e/pbyqsdAncM01T0DP
         2M+RMGPgIWHyF4J3JheCBq9J65KHdRnlIFy9WHv+nskKyMWcN7VSVxOSHhH1Fe78tO9r
         DJIU5D5wZB+r7ED40QuQFztGJ1/rFwbx/Gb6zdtOzEkbiTPXr00SlwqXCnBGi//COzp7
         rarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620433; x=1718225233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Glm3mA8QnXBmJCA+vVErk08DMx6cbnQiMEf8o6LS5k=;
        b=gg9hSDPlBu8wNsgc2RttNANTYKN3omM9U+5m7mJkyY4vAATui6CWeC/lrLtaqxpJ6F
         zkfdwLZ4I1PuWE2dOWOxvF2z2IgJeVhpStFSp5njsgDu5wHvMdetctTgNmWcam61Ykdt
         pGm/9LXdzS+rnYRLAe5n0xTgFEP5VQs8qUZEhtzvuFaA25FlPmVWb7CxoY+0QjP/kBPB
         O/DP0hGucoARHMdisE213G9yYVDdTyPO+ciyE1yoPRux6GnBg18UBBHXIWQGM3Z4YR4s
         FwlWJd4f8FcFzr7h6x96XJ4ZafvE7oJxdMaEmbskSUS1Lv6HhRNpHTOxilUOKJKYuicb
         1nRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcrHxVILeTRl+MqCJte6pl+MR8z3C623D8AbFXSe2WK+xxf6eSFAK08PNfuXkD9AUjsAUPa6EdR7sDeeScnVqC/G/UVEgrbielrg69239UHNyzjkkD5NKFFPCIOC0TpuzUsuigfHgyTE6O1+llQq5C6GpE7g4hrhlIkm9Uu+NwqQXXpUXg
X-Gm-Message-State: AOJu0YyNsdUbma2F0tW+13nkaVDWyTtryq872Wi3sJ7zZ2KsDzkwH8z/
	RWd5OlVqbkOhDq+/tL7Z2zuwAAVqTcqnBvcXW87DD0asjPfySHmcgO1mzTF54mH0IZKtVFNHx0D
	fTFlr30U7S3sSBbbz2KyAyqbK+5s=
X-Google-Smtp-Source: AGHT+IHt747T48icypSQULl9KHiWK2xqd3REFbVftukuXwX+yNOBcY3Zy1BesAnM7CAEa0QVPwChvGtipwyjytTpwzE=
X-Received: by 2002:a17:90a:8d0c:b0:2c2:7dd6:97b with SMTP id
 98e67ed59e1d1-2c27dd6098cmr3312784a91.16.1717620432636; Wed, 05 Jun 2024
 13:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604200221.377848-1-jolsa@kernel.org> <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com> <20240605175619.GH25006@redhat.com>
In-Reply-To: <20240605175619.GH25006@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jun 2024 13:47:00 -0700
Message-ID: <CAEf4Bzbz3vi6ahkUu7yABV-QhkzNCF-ROcRjUpGjt0FRjfDuKQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to uprobe_consumer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:57=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 06/05, Andrii Nakryiko wrote:
> >
> > so any such
> > limitations will cause problems, issue reports, investigation, etc.
>
> Agreed...
>
> > As one possible solution, what if we do
> >
> > struct return_instance {
> >     ...
> >     u64 session_cookies[];
> > };
> >
> > and allocate sizeof(struct return_instance) + 8 *
> > <num-of-session-consumers> and then at runtime pass
> > &session_cookies[i] as data pointer to session-aware callbacks?
>
> I too thought about this, but I guess it is not that simple.
>
> Just for example. Suppose we have 2 session-consumers C1 and C2.
> What if uprobe_unregister(C1) comes before the probed function
> returns?
>
> We need something like map_cookie_to_consumer().

Fair enough. The easy way to solve this is to have


struct uprobe_session_cookie {
    int consumer_id;
    u64 cookie;
};

And add id to each new consumer when it is added to struct uprobe.
Unfortunately, it's impossible to tell when a new consumer was added
to the list (as a front item, but maybe we just change it to be
appended instead of prepending) vs when the old consumer was removed,
so in some cases we'd need to do a linear search.

But the good news is that in the common case we wouldn't need to
search and the next item in session_cookies[] array would be the one
we need.

WDYT? It's still fast, and it's simpler than the shadow stack idea, IMO.

P.S. Regardless, maybe we should change the order in which we insert
consumers to uprobe? Right now uprobe consumer added later will be
executed first, which, while not wrong, is counter-intuitive. And also
it breaks a nice natural order when we need to match it up with stuff
like session_cookies[] as described above.

>
> > > +       /* The handler_session callback return value controls executi=
on of
> > > +        * the return uprobe and ret_handler_session callback.
> > > +        *  0 on success
> > > +        *  1 on failure, DO NOT install/execute the return uprobe
> > > +        *    console warning for anything else
> > > +        */
> > > +       int (*handler_session)(struct uprobe_consumer *self, struct p=
t_regs *regs,
> > > +                              unsigned long *data);
> > > +       int (*ret_handler_session)(struct uprobe_consumer *self, unsi=
gned long func,
> > > +                                  struct pt_regs *regs, unsigned lon=
g *data);
> > > +
> >
> > We should try to avoid an alternative set of callbacks, IMO. Let's
> > extend existing ones with `unsigned long *data`,
>
> Oh yes, agreed.
>
> And the comment about the return value looks confusing too. I mean, the
> logic doesn't differ from the ret-code from ->handler().
>
> "DO NOT install/execute the return uprobe" is not true if another
> non-session-consumer returns 0.
>
> Oleg.
>

