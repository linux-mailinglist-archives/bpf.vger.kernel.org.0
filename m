Return-Path: <bpf+bounces-38560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BC69665F5
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8617BB23EF6
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFFB1B78F1;
	Fri, 30 Aug 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yevicrlg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469121B5EA9;
	Fri, 30 Aug 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032694; cv=none; b=PNGwYH5GP9hy59bb55Hex+G1IWvt0JjnsB42lhLFFHjQcT/OTM8YHpSAJW+bAmAlhU9WmyZjtFZ9U0eEK5HzQsyP29JkQ/Q7KdgbTa9oQFjQ39jUuVDDO8AOYnaPxFxPLSebGJ2RqgKVeBlQBGqvBCYfaumR7E5gKuzWdajkNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032694; c=relaxed/simple;
	bh=hUdJ3tWChLbbIEYKPPb76YRhW/3TjJ4im9OWeMVWOqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpR78mcvo24my41uarXvX4EGP73CGLNLr032O6Vbf5LdlJgxd4B9fwHPHjLbJkzrI0JwQKEovwHWlwvVZrAD9zGfMjIYXhY1TNz9A7JYuHuM58nC7MqQSwbwaNmxqzqk/31T4phir8mF2js6JD+KES1pBsnZ5QnCaZ419NxZx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yevicrlg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso1506730a91.1;
        Fri, 30 Aug 2024 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725032692; x=1725637492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUdJ3tWChLbbIEYKPPb76YRhW/3TjJ4im9OWeMVWOqY=;
        b=YevicrlghPocsPDK3NvUrHhvcAB3iqOKcne1QbsulqjB0eoteEZtXPsY4x+ndhvoJO
         zT5WEU/+/6M3wpbUOY0KcAR0vwtm7/C8Z4tHkP5CnRPDs87ksqVJH3rBUMVs1ZVtmR/M
         tnmPw9GhTVHjOrDm50Sb6T52BjgyT8o7Ik0r6qNV9kFSxDC8bL4xQQZoQV6mVFwAVd2k
         rW8tkLTdhzs97lc679ozmzaxY9IHiK/RGQeXfg2eG/iC4rnu0L0HPXxqRUd2u+htXTxd
         +QRf+tCxoNvm9ZkIpc7RtUXJv4kepIcrXv2fCRanFwk9oiEOC01x2Z2v8pj1lv0LkUkm
         mptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032692; x=1725637492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUdJ3tWChLbbIEYKPPb76YRhW/3TjJ4im9OWeMVWOqY=;
        b=a6FUSCwIuiHBhGtmqjMIkayS5F2e2omutH/QAI7xJRW0bzzSngifUlkBT25ljsDCEa
         tRvvQq8POBBmrer2nLu2GbEJh+sTw/GvSwj+Naoh2K8YOFkxXjh1st0bJmC+/s6j1rKR
         e4BEcqPYjoISKgrdiJNP69z/7iEoqAlMXANL/ol2h83MIQOBEqlnT7+XF84FG7eZoFK/
         5th59nlyxmeoSjNQvnX3DE2uY1b94HKJNVIG6q5Am30OJvzC7U12i28faR5EoJoGHSn/
         91ajvWCWQ7GBbCpTZAcrScLif6OLIJTG6QNA8F7cORAj+UohKUOHpOiBh2eUFsPLksAT
         YZHw==
X-Forwarded-Encrypted: i=1; AJvYcCUm84KsPxmzpNhUDXC23s0biLbNeWAIKYRt3roCU0fLRpGL8Y38prNKj+cqqI4bxN5YMMj42tvsoskoVm1YX/Ym2IYq@vger.kernel.org, AJvYcCVJPIBXY6Dw1GckPdDBBhrXnX4p4YqQPMZUPSVDWiF4v1B2LapkvRmc0ws4FboZ2sqfnuf+auGKVYMbz2VL@vger.kernel.org, AJvYcCXx5WB1lzTpFuAYaGB9e1NGlAtAQNSAzL39C9vcjjrq86ZOWdagYNvxElCmw8aZ6543kw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1+/hlvo+rfp3UtpxdsHnQEM6P2qc5oyTNB1rcXV8R2dcNPZL
	5gB9yeWGe05dRqnB9GsIWnj4Q52g1WPlhD0YRxqHCaVX21FCq7Bkkjh+3oGv6u452XkVP2wypJL
	mox6wAt9C0ixVPKHg1oE6gFhQbc4=
X-Google-Smtp-Source: AGHT+IH9lOOCe2rTqfIXmA2Zm8EduBS6oRpThaN24Qeaw7NMFyCeTcHthyMHP2O028nkC0WV5jBoesnEOD50qPdMhJ4=
X-Received: by 2002:a17:90b:4b45:b0:2d3:ba42:775c with SMTP id
 98e67ed59e1d1-2d85618168dmr7730941a91.1.1725032692525; Fri, 30 Aug 2024
 08:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829183741.3331213-1-andrii@kernel.org> <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava> <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava> <20240830143151.GC20163@redhat.com>
In-Reply-To: <20240830143151.GC20163@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 08:44:40 -0700
Message-ID: <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
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

On Fri, Aug 30, 2024 at 7:33=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/30, Jiri Olsa wrote:
> >
> > with this change the probe will not get removed in the attached test,
> > it'll get 2 hits, without this change just 1 hit
>
> I don't understand the code in tools/...bpf../ at all, can't comment,
>
> > but I'm not sure it's a big problem, because seems like that's not the
> > intended way the removal should be used anyway, as explained by Oleg [1=
]
>
> It seems that I confused you again ;)
>
> No, I think you found a problem. UPROBE_HANDLER_REMOVE can be lost if
> uc->filter =3D=3D NULL of if it returns true. See another reply I sent a
> minute ago.
>

For better or worse, but I think there is (or has to be) and implicit
contract that if uprobe (or uretprobe for that matter as well, but
that's a separate issue) handler can return UPROBE_HANDLER_REMOVE,
then it *has to* also provide filter. If it doesn't provide filter
callback, it doesn't care about PID filtering and thus can't and
shouldn't cause unregistration.

In ideal world, we wouldn't need handler to do the filtering, and
instead generic uprobe/uretprobe code would just call uc->filter to
know whether to trigger consumer or not. Unfortunately, that's a lot
of overhead due to indirect function call, especially with retpolines
and stuff like that.

So I think it's reasonable to have an (implicit, yeah...) contract
that whoever cares about UPROBE_HANDLER_REMOVE has to provide filter,
they go together.

Jiri, the fact that uprobe/uretprobe can cause detachment by returning
1 is a bug, we should not allow that. But that's a separate issue
which we can fix in bpf-next tree. Please send a patch.

> I think the fix is simple, plus we need to cleanup this logic anyway,
> I'll try to send some code on Monday.

Can we please let me land these patches first? It's been a while. I
don't think anything is really broken with the logic.

>
> Oleg.
>

