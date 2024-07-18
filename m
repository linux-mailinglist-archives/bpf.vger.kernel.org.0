Return-Path: <bpf+bounces-34977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9949345D5
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 03:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1D2B21D58
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 01:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385EE186A;
	Thu, 18 Jul 2024 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AppCQr4Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551B6138;
	Thu, 18 Jul 2024 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266346; cv=none; b=m1WaoRfJ77WpIvVKYt/d1pcVpOep1U+HXsNEz4q0Xk5PP84s+0HgTGYB2sM04/Fbu6+QzebIXMsDdelN8d7tM12VLkQY1fy+fAMCMuK4Jj+Nu6VuadFNCIkeBos3K1t/5kKB088DT6IIOhkKiQEvNIsaqAHKJUJjGyf7g3d9aA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266346; c=relaxed/simple;
	bh=58JNHxVOW23dXB1RpVD7Rk5sNX+3OU2RKhTPML4WOGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR1II+9VZvU4Zqo4u9a9qShdVvjbICx1pNmxb7RA8qHmB02qY+iKop5h6ZW1cv1DMuY9G9/MmfmqoWD/8nIkvvdRHZbBCErkQICJSQFr0o3qK4wJcewztp3U9cstTC2IE+TVOGsA70flMikay1LG1WKctCFmLYrpNlCfiNwo1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AppCQr4Q; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-651da7c1531so2429467b3.0;
        Wed, 17 Jul 2024 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721266344; x=1721871144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0lrpvrR/8Ce+qh3lazY0C8Wgs5FIQPQpnRSul0bdNc=;
        b=AppCQr4Qb1x6roerVWnsXENg1z6Sv1B8u4ba1Xgx+ABh5lFrV9bV+1/crdDtL5TL+s
         8iBC8niqTlGfHvH93/yjKA+gW1qwY0HnxOe+QmrG4Cb4Dx+SVlpVNr7irO0XVAfegq65
         Zt0M+fzH1sQCmJ5k7dVtOGsXoqfqJidx5P1j704Xx5PkGs4ls7j6MlTr93SDGVYlrhfN
         yU3L324W4F6Q1OCc2pw2o8ilr7fH3+fK6VlJhv9aG39Es/Ws8B+45A0inL66MMEXwEwB
         zU3KjNRIYWZcs03kw0gR7jqSYKrWeLLFpboNlGekrWX3oU3pfn6cj3kzfbDrhft0NHDU
         7DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721266344; x=1721871144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0lrpvrR/8Ce+qh3lazY0C8Wgs5FIQPQpnRSul0bdNc=;
        b=jBPGN7yaXtX4n5VaFuafULf7KBu3S80B3mg49pP8rrt1OLNwop1A81H0i/vbYNlMKx
         ou1raqmkzvN9DiKHpGnwSA31Gz7qoOlTz6/4zmheJr1tfvJNgrDEVKHr0aG8oEa/hOKQ
         1w90mAUMas+AH3TKq03WpfaTcgSg3jNORVe2H4yx675yDICwc5QC8EGrjZPbYLQ4yrFo
         e0BAlUAfgQCK7TEQTlwcsi5F2kvUgdmLEaGbqrMXwierFy1UW8eiyP0eE+9Nl3V6NFDk
         o9MftercUZUAMCCChsJSfDpZCM3Kh0MgBkpoU6YGiPBWUxmRu0d+u8552VGjEuy93KQI
         YlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7TvlHJxGlsFvc0j6ACayG1qszAqmckk3ClaECquwRteihYwZBV1xXPHsIjxacxk13CKUJihaA0S/K82fE0C/QQfwwBVaRbOKx7YBMy8VU5w4nFNLSZsgOkLL0ogRxBnBB5+enQ1nCkpS6M6MRBzy9Hq/UBXc7KjkopqVlxdzoOyX39bwy
X-Gm-Message-State: AOJu0YzrXaKse8UPoub2QqEna1oV/rLGkzTTG5vnJ5CjilwhXVgSSSgJ
	tDYyMmdix7sCo7LKNNKcFDgbmoNZWYC4Ia9Xeyi6yEEoPUc5YrdCgJMYFjcJ03OZryiF615f70E
	hASN2TAScb87PpL9NpVTyWrsZvN0=
X-Google-Smtp-Source: AGHT+IGKx/mA49tpwQ+/gqsE/E+hx0yQ2GYm0gmS1Kvp32w7k7zXF5sUb46uZjs4Op7DEyA+y0BR2IlMu/PA4XhxwLo=
X-Received: by 2002:a05:6902:1024:b0:dfa:4ce2:3311 with SMTP id
 3f1490d57ef6-e05ed764b53mr4523830276.39.1721266344390; Wed, 17 Jul 2024
 18:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710085939.11520-1-dongml2@chinatelecom.cn>
 <Zo6I47BQlLnNN3R-@krava> <20240710231805.868703dc681815bb2257b0ac@kernel.org>
In-Reply-To: <20240710231805.868703dc681815bb2257b0ac@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 18 Jul 2024 09:32:13 +0800
Message-ID: <CADxym3aE3YpbMMYnKBh5voy0YuEjjvafFALGdGMd4-_6ADMKhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: kprobe: remove unused declaring of bpf_kprobe_override
To: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:18=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Wed, 10 Jul 2024 15:13:07 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
>
> > On Wed, Jul 10, 2024 at 04:59:39PM +0800, Menglong Dong wrote:
> > > After the commit 66665ad2f102 ("tracing/kprobe: bpf: Compare instruct=
ion
> >
> > should be in Fixes: tag probably ?
>
> Yes, I'll add a Fixed tag.
>

Hello!

Should I send a v2 with the "Fixes" tag? It seems that this commit has
been pending for a while.

Thanks!
Menglong Dong

> >
> > > pointer with original one"), "bpf_kprobe_override" is not used anywhe=
re
> > > anymore, and we can remove it now.
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > lgtm, cc-ing Masami
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> Thanks!
>
> >
> > jirka
> >
> > > ---
> > >  include/linux/trace_events.h | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/include/linux/trace_events.h b/include/linux/trace_event=
s.h
> > > index 9df3e2973626..9435185c10ef 100644
> > > --- a/include/linux/trace_events.h
> > > +++ b/include/linux/trace_events.h
> > > @@ -880,7 +880,6 @@ do {                                             =
                       \
> > >  struct perf_event;
> > >
> > >  DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
> > > -DECLARE_PER_CPU(int, bpf_kprobe_override);
> > >
> > >  extern int  perf_trace_init(struct perf_event *event);
> > >  extern void perf_trace_destroy(struct perf_event *event);
> > > --
> > > 2.39.2
> > >
> > >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

