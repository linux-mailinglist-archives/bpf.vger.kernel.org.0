Return-Path: <bpf+bounces-45309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0849D44D4
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4707C1F226B0
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DE14A02;
	Thu, 21 Nov 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZZKXe1w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365E63A9;
	Thu, 21 Nov 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147834; cv=none; b=DuKyNNfUN4OmNCyZwGX+Nh+jNDJd5sm1zgnS6FriRq64RkzwPQcaWSe3KBGser32ymdiIJcgrv6vQQI9QwS9w3vti3jXIIgflyVaIUAi2/5vjjF08R5Aq1hRGLarB383gCHZmJig812C6Qu0O/6+XQnm8q6Y8VOPNmtu6xdwICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147834; c=relaxed/simple;
	bh=52vl+/hj+YqKACiJKGmD1zj236nSYaUQRdFwvrJZXHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAVnNNtGNaankCKqOGK6z5kx+jWpxaL2JhqFYhZ8bFKaSqdtwQlOajab77wDltib7GXDpwMAcuHPUngI4jeD1a4a/A+IhdFSKL1D9ZHQEBml5ttJjSrmfsFwTOustO5LRz0nKVkwhDlGrRskVm83UjHwVP/GMRPXK833eNexX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZZKXe1w; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eacc4c9164so332125a91.0;
        Wed, 20 Nov 2024 16:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732147832; x=1732752632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Io1oydagJA/XDlS4jBwlR6rqktOSTtIcBlfECrFRe4=;
        b=OZZKXe1wo4K9LLfF9WNfF/I+rYavYbLWlhlIOVicX8wqSoG3X7ZMvt1rNn8ujD5Bg7
         zC0AQNkKq9ztjEWW+kSgY9nyJLvzaJd2NC1BBkneYwc/iPj1IiMlAZJ4GGL6S0nts1NR
         aXXO0eAdDF9BHG2z6ny/cYiCdnvPKVDa7aMWQziVBZtZNqOXOh/X82yyxbgYEBpR1oiA
         BpMSNkWz/4PHzecmnMCR0dra2UsABps/GkHaZfPCCNeIsvX3ZaBrqQY4xUhdPff7/oLa
         om00cRd8jFtQrNepYAIpxVEmGi6exCp3kpxHmpACHGFyD/s6TOjNSw2b/ELGGF+TuYzv
         F7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732147832; x=1732752632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Io1oydagJA/XDlS4jBwlR6rqktOSTtIcBlfECrFRe4=;
        b=JGFi8vSJI6/KCweln94F+ksyfTgGpQPObSBgiB/yrmJbpRDPcVNWGVGwnyYZ/RAePI
         xHoGWZNkSAy8NhXXcOOkYP0u8n7Vi8ErBAXHZNRWFydtTBCBCsY3h5Nn6VKwEe3xNaSQ
         6ITJ6rBqNvfxAlhmIwkKAdb9PKY53ttkHwCXEecq+JqM/Sw47wvGUCLiAso4ejU1wmhb
         e5sJdpevXOFlPLKBexOMKWvQM2VDExxnCBvUx0QcAKTxAP05piOjF3KBLsCXqVh+suC1
         rOGXQJW4LWzpE0zENN6mCLo2ZeWHYXnYa/rVQb1uKm4GZUcRRzmoOsD4GKraVb3fxap6
         Ky1A==
X-Forwarded-Encrypted: i=1; AJvYcCUeHHr4aBgYfdLNcaYYyFgwUJ/4aHznO+u4AfUo5QANYuetzrUUPZ3i+xqyCLq2sWDYVITvU9X+45eXhvnb@vger.kernel.org, AJvYcCWQ2NWSngIV9ymS+6pTfeJ8sHnpd2r7yCSENUhipUHF+jSR/ILWxo4UfIKLFDr+P8lFiwUDapOywjKpJuWwpJGKnmVg@vger.kernel.org, AJvYcCWj2beuX+CQSo9LzyhqcpsMza1kOVxh56G090fuorS/xq4xDi/7aY7ZKPTa5AAF9bUXlpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqsXXwvoU/kxHJzlUbla+UUbdqIGUJSIvahz/PGddkG32IL0g
	xG3qG9C5W9bR6zT8ZCLM5GYI44snzW0jeF8Uzl2vFCDz1RQ+l17yGcyohM7IPnpMDEBcOKvrDgV
	x/f9Vc5fgcEf3cRdom87G+EnleOk=
X-Gm-Gg: ASbGncvcjEcOKeRIDn3rpy46LKYbQbmnFv4Rj857M3X8nX/QOUEmhMLdP4Uj7KYajmD
	6SzzMzvATWo8ZpG+IsUk9/Y8w791HtvDcBhkFbJ9u9JtaMOk=
X-Google-Smtp-Source: AGHT+IEKO0ZnRsai5bDHwR4ClElexQx5+ms8gESZvc4s0aQnDFQKAJ35jYk1jcGtFIyBjVmkB9iGLiNA6jfsozRefeA=
X-Received: by 2002:a17:90b:4d0a:b0:2ea:94a1:f653 with SMTP id
 98e67ed59e1d1-2eaca7ddfd1mr5197536a91.31.1732147832197; Wed, 20 Nov 2024
 16:10:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-6-jolsa@kernel.org>
 <CAEf4BzYycU7_8uNgi9XrnnPSAvP7iyWwNA7cHu0aLTcAUxsBFA@mail.gmail.com>
 <ZzkSOhQIMg_lzwiT@krava> <CAEf4BzYBRtK-U_SLY-qYDGf2pc4YzBOeKgyjFbzv-EHXrdNANg@mail.gmail.com>
 <ZzyrQWLrPYzUqLGq@krava>
In-Reply-To: <ZzyrQWLrPYzUqLGq@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Nov 2024 16:10:20 -0800
Message-ID: <CAEf4BzYN4LzOFqFKQTGiN8H6ANqY0cpA5LgEfnBGx+EMWy=K8g@mail.gmail.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe trampolines
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 7:14=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Nov 18, 2024 at 10:05:41PM -0800, Andrii Nakryiko wrote:
> > On Sat, Nov 16, 2024 at 1:44=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Nov 14, 2024 at 03:44:14PM -0800, Andrii Nakryiko wrote:
> > > > On Tue, Nov 5, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org>=
 wrote:
> > > > >
> > > > > Adding interface to add special mapping for user space page that =
will be
> > > > > used as place holder for uprobe trampoline in following changes.
> > > > >
> > > > > The get_tramp_area(vaddr) function either finds 'callable' page o=
r create
> > > > > new one.  The 'callable' means it's reachable by call instruction=
 (from
> > > > > vaddr argument) and is decided by each arch via new arch_uprobe_i=
s_callable
> > > > > function.
> > > > >
> > > > > The put_tramp_area function either drops refcount or destroys the=
 special
> > > > > mapping and all the maps are clean up when the process goes down.
> > > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  include/linux/uprobes.h |  12 ++++
> > > > >  kernel/events/uprobes.c | 141 ++++++++++++++++++++++++++++++++++=
++++++
> > > > >  kernel/fork.c           |   2 +
> > > > >  3 files changed, 155 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > > > index be306028ed59..222d8e82cee2 100644
> > > > > --- a/include/linux/uprobes.h
> > > > > +++ b/include/linux/uprobes.h
> > > > > @@ -172,6 +172,15 @@ struct xol_area;
> > > > >
> > > > >  struct uprobes_state {
> > > > >         struct xol_area         *xol_area;
> > > > > +       struct hlist_head       tramp_head;
> > > > > +       struct mutex            tramp_mutex;
> > > > > +};
> > > > > +
> > > > > +struct tramp_area {
> > > > > +       unsigned long           vaddr;
> > > > > +       struct page             *page;
> > > > > +       struct hlist_node       node;
> > > > > +       refcount_t              ref;
> > > >
> > > > nit: any reason we are unnecessarily trying to save 4 bytes on
> > > > refcount (and we don't actually, due to padding)
> > >
> > > hum, I'm not sure what you mean.. what's the alternative?
> >
> > atomic64_t ?
>
> hum, just because we have extra 4 bytes padding? we use refcount_t
> on other places so seems like better fit to me

My (minor) concern was that tramp_area is a very long-living object
that can be shared across huge amounts of uprobes, and 2 billion
uprobes is a lot, but still a number that one can, practically
speaking, reach (with enough effort). And so skimping on refcount to
save 4 bytes for something that we have one or two per *some*
processes seemed (and still seems) like wrong savings to pursue.

>
> jirka

