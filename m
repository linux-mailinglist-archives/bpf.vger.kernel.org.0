Return-Path: <bpf+bounces-14609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3C7E70C9
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1429BB20CC8
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBAA3032C;
	Thu,  9 Nov 2023 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxW5KmNm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD631A63
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:50:49 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173412D65
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:50:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9e5dd91b0acso6960566b.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699552247; x=1700157047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcRGHECZna8mJLEGh96daX3M84u04zf5pncfaUCbvSw=;
        b=QxW5KmNm35LhjVOiYVXuVQB00xE6ORbv5+tytmucFPf+5H50ImU9+XkrkrGkhOp3eg
         Brid4tBV96/ouk1ZEQaAwRW1wDOE6lxTaUNxkFUXViA/OMWUgqF8b8BdXWJM+vIE4zD7
         g7glF4D9GLXZ9wEPkkQ6Y3x8m36xJBKFAAV+I9+o5+zR/g9OJ1lxRv76MLCBSJFUFEnS
         EAnLRdCi0SrNGnjzHq6EC04Zzt0iZO3xk/iuKdaUNbyViznQrkWDv9IjDXDUuTIDqfwk
         aqOU9bXxWYqcJyfaEYXug9FINv4W40vXpGWaAGOiziZ9UeYhUN57jxlurwiR5zPfM3uz
         dIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552247; x=1700157047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcRGHECZna8mJLEGh96daX3M84u04zf5pncfaUCbvSw=;
        b=cfwl/CXVfomCyOYv1caHrsKhDcjzhPe6wqi+KGqZh96kUgRjNet8IwpHwTmuvtcWji
         /9S1g8QiPfaJExa6ynkjGZG7sl8PK0VBCZbyUUos72/ns9OvJdSCaxIKt8V6+9zZ0PSG
         JrfqEIJtKo1vsOD8byCggNrohQN6OyXVfF7oPDMv3rppHd7gzsr/+q4y31HJOrMCYOke
         +u25VwxZXpXguMCgH2CygWSmo8xOoHTjamkHsY+PzKUrHQm+YiqTPcKNeKhzOvaNpJNY
         ZOH+b9vonaOGUFStH4spj+GJd6+5dmj2NvytCD5y8+y8af52nDNXdPvlhY6cMpApPGJl
         DykA==
X-Gm-Message-State: AOJu0YxISlMOBBn0H8e2qv87KBQziXpZRTcpDmoR+KoizhrwO3yhVd0N
	xEQzXtSH6+YOxvsx09Un4s6evBgO1/kwHam1Gi9Bi9gJi7o=
X-Google-Smtp-Source: AGHT+IHTI6D+turB7p/aMyG7DgwpEZCmpFDLciIejp6grax3lObaKrW7PQndrLht51ApQBjECgpX2yWUNlAmYQ13WXM=
X-Received: by 2002:a17:907:7fa5:b0:9c5:ea33:7bf9 with SMTP id
 qk37-20020a1709077fa500b009c5ea337bf9mr5557733ejc.51.1699552247365; Thu, 09
 Nov 2023 09:50:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-4-andrii@kernel.org>
 <71cc364752f383559c7d7a570001fd353f0ca8aa.camel@gmail.com>
 <CAEf4BzY1-mcN5Wjf4-FOKQvnom+0EV=a=cGxvBO9=rbCS0kzwA@mail.gmail.com> <b335aa904dca981058e1db92b6270960f2a28948.camel@gmail.com>
In-Reply-To: <b335aa904dca981058e1db92b6270960f2a28948.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 09:50:35 -0800
Message-ID: <CAEf4BzYHOMgxE1NitS_8YosrYWFzZ-BT8qL=Fnyna9tDA2M+2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: enforce precision for r0 on callback return
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 9:38=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2023-11-09 at 09:32 -0800, Andrii Nakryiko wrote:
> > On Thu, Nov 9, 2023 at 7:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > > > > Given verifier checks actual value, r0 has to be precise, so we n=
eed to
> > > > > propagate precision properly.
> > > > >
> > > > > Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > I don't follow why this is necessary, could you please conjure
> > > an example showing that current behavior is not safe?
> > > This example could be used as a test case, as this change
> > > seems to not be covered by test cases.
> >
> > We rely on callbacks to return specific value (0 or 1, for example),
> > and use or might use that in kernel code. So if we rely on the
> > specific value of a register, it has to be precise. Marking r0 as
> > precise will have implications on other registers from which r0 was
> > derived. This might have implications on state pruning and stuff. If
> > r0 and its ancestors are not precise, we might erroneously assume some
> > states are safe and prune them, even though they are not.
>
> The r0 returned from bpf_loop's callback says bpf_loop to stop iteration,
> bpf_loop returns the number of completed iterations. However, the return
> value of bpf_loop modeled by verifier is unbounded scalar.
> Same for map's for each.

return value of bpf_loop() is a different thing from return value of
bpf_loop's callback. Right now bpf_loop implementation in kernel does

ret =3D callback(...);
/* return value: 0 - continue, 1 - stop and return */
if (ret)
   return i + 1;

So yes, it doesn't rely explicitly on return value to be 1 just due to
the above implementation. But verifier is meant to enforce that and
the protocol is that bpf_loop and other callback calling helpers
should rely on this value.

I think we have the same problem in check_return_code() for entry BPF
programs. So let me taking this one out of this patch set and post a
new one concentrating on this particular issue. I've been meaning to
use umin/umax for return value checking anyways, so might be a good
idea to do this anyways.

>
> I'm not sure we have callback calling functions that can expose this as a
> safety issue.

Even if we can't exploit it today, it's breaking the protocol and
guarantees that verifier provides, so I think this needs to be fixed.

>
> [...]

