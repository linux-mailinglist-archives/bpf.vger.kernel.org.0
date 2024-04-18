Return-Path: <bpf+bounces-27157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B808AA231
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A011C214C8
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A853178CFA;
	Thu, 18 Apr 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGlPpFMl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55816F919;
	Thu, 18 Apr 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465716; cv=none; b=eo7kTr1xCeDdKyvjtu+7hDbmBo2t/tMYuWx2+HYehHGmLKiFmu+yDt3KJ32wwlHcUWGmZNYB5AGkiy0eXRrfF51VlcsUJIIhJcTwjwBcPP89LmFFhvQOCrZZVAQ8vVOKikQqKVu6yWzzisCTWDnXhzW62KBUL5Eh24Zm90MKwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465716; c=relaxed/simple;
	bh=jjzIel/0iYgUq+MHzf/g/Bl4Dpu8TgcfIH+ll9wVj5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mm7/y4Fibhyn5JygpE2ex7T8GGF4sCOvOVAjdDPcAaAOe9m8/Kah2DF6Z8dgC7nCDjeM+ajsEAQ7dQYNedO0SUTSkD6fga+fksouxzk8jUg02sdGK0yPGJyve6pbKA1HbWwNifgcx4y7oHGtE54oaEIY7hAES9/Vloz6FFgdmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGlPpFMl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so1267779b3a.2;
        Thu, 18 Apr 2024 11:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465714; x=1714070514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8C8IikmJy8uyY+XBYNIZBe+JCpoTPr1zzk9t3ER+z8=;
        b=NGlPpFMl94d/84zUSavJrv0jyVbQJxlLYbcVZdHTNuGL+8zE686wNkrPu61Q+bRGp/
         aqwgUgUQLUekNrD+2Pm2zu3tgCPd+Wu9KwBytf2YLig1mQY2RBT0DjHFeVRmvJhN91Q3
         h7dW1lDgEG5Jp9OeVA2p7wRgox7+O2+tfJvdmk1bfV/n3bi0O1O5/zVSdhhLDilpPor5
         Gf8hMJl8swmFhd/QkznVypaGgIROHKMZDiI3JOc7k7nyOHCLSfS1RDQe1mLQsYeE6IvO
         LVI2ioOsNtHTkztCmhczLyIUUwlFMEgAtbxQ+2qxfQ1AAGMwT/4Jb8IUyZG/XxsUPM3U
         KuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465714; x=1714070514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8C8IikmJy8uyY+XBYNIZBe+JCpoTPr1zzk9t3ER+z8=;
        b=gxghT/+YX6oQv+dK9KW732koNur/wK4ZdXEIhLBxl2jgnm/owck6V80D7+/Is+8HIb
         ySc211Oi4t/bOFOmZMVKIy2dBdjTX2+3y9AB/a4WADQwYS3GtkpiTsAFDVJoHqHaXgtU
         08j0YC3uPiqGqpGSCrkZhPMaEp5hSa3tDdavs+sWdAPUFMCD3y3QQSm1F7vv1Elx9CfC
         qw2K25dobS7bvq3Bwtmkx2xNtjHrPUi4BmYgsE0ito988aX19H5F9bLF/dtp/A+N/Kmo
         OdasvCXQVgqIf58G3sYCHO3shfbafhzdQDiDVkEeOpRwK2SdlfKsLytPKQw5ths2vCys
         72vw==
X-Forwarded-Encrypted: i=1; AJvYcCXduCT7NtvYr8+XzlbT2CwyCCf1W9HgF7Xd+ck1z8MZ47mTmeoSLl3oxx4lAgnCPkgU+V4BMnBx6B2OrWYD/1UD5V40C2MutNTBSsDxOGhukZ9JYeBSmL7B3kaY4EnLDnB2TYp7hx6Q
X-Gm-Message-State: AOJu0YwW1VfX8AHqE6+6n/rLKyubSE8zZoayyZg+aONNsYvcxVFXFDGh
	KZJwSm9+nfNyJovts4qKlJL/nBck73KLi1h1sumWrHvkPLiH4V6LL65sB95oyzUzp5e6/K87vYt
	LhiEoTbw0NmD0M/QIr7MDBePw4jomUVtU
X-Google-Smtp-Source: AGHT+IFlliZAatUTLAv/zRtbDtIqyF0Sabqyl/u2IqjJWTpJtmOaRa/M0PgvbI7xS6Z1eBVdXqSrUMQ9ZOqGZ9sLUcA=
X-Received: by 2002:a05:6a20:da81:b0:1aa:a6cc:39c1 with SMTP id
 iy1-20020a056a20da8100b001aaa6cc39c1mr71577pzb.3.1713465714154; Thu, 18 Apr
 2024 11:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403220328.455786-1-andrii@kernel.org> <20240403220328.455786-2-andrii@kernel.org>
 <20240410074819.9b3a9a6d6a53d534b9915dc8@kernel.org>
In-Reply-To: <20240410074819.9b3a9a6d6a53d534b9915dc8@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Apr 2024 11:41:42 -0700
Message-ID: <CAEf4BzbPk+kzXV7KVUzeA=Okbe+kvCNYEoYEOYPEu_QFVKTRUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rethook: honor CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
 in rethook_try_get()
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, bpf@vger.kernel.org, jolsa@kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 3:48=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed,  3 Apr 2024 15:03:28 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Take into account CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING when validatin=
g
> > that RCU is watching when trying to setup rethooko on a function entry.
> >
> > This further (in addition to improvements in the previous patch)
> > improves BPF multi-kretprobe (which rely on rethook) runtime throughput
> > by 2.3%, according to BPF benchmarks ([0]).
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aN=
DXQSHYia47pQ-w@mail.gmail.com/
> >
>
> Hi Andrii,
>
> Can you make this part depends on !KPROBE_EVENTS_ON_NOTRACE (with this
> option, kretprobes can be used without ftrace, but with original int3) ?

Sorry for the late response, I was out on vacation. Makes sense about
KPROBE_EVENTS_ON_NOTRACE, I went with this condition:

#if defined(CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING) ||
defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)

Will send an updated revision shortly.

> This option should be set N on production system because of safety,
> just for testing raw kretprobes.
>
> Thank you,
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/trace/rethook.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> > index fa03094e9e69..15b8aa4048d9 100644
> > --- a/kernel/trace/rethook.c
> > +++ b/kernel/trace/rethook.c
> > @@ -166,6 +166,7 @@ struct rethook_node *rethook_try_get(struct rethook=
 *rh)
> >       if (unlikely(!handler))
> >               return NULL;
> >
> > +#ifdef CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
> >       /*
> >        * This expects the caller will set up a rethook on a function en=
try.
> >        * When the function returns, the rethook will eventually be recl=
aimed
> > @@ -174,6 +175,7 @@ struct rethook_node *rethook_try_get(struct rethook=
 *rh)
> >        */
> >       if (unlikely(!rcu_is_watching()))
> >               return NULL;
> > +#endif
> >
> >       return (struct rethook_node *)objpool_pop(&rh->pool);
> >  }
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

