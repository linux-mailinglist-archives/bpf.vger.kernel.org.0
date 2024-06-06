Return-Path: <bpf+bounces-31515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA88FF2FD
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EF52908FF
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA3E198E8A;
	Thu,  6 Jun 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awbEH11T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB71990A6;
	Thu,  6 Jun 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692773; cv=none; b=XS3LLR6Uhh2DJkwgygo1loqMqO2G5rKH+hsQuViaA0/Gqh0RzI5xyb82mv8b71AinP5OI6tfSqM6otfanL9pjUxceGyUxqyHk3FLQ2UOmFbNNp92KOJJCGmPs6isvDzi6m3gLpzxhq/jN8+BPHdWP3zx37J99SCbJjg5RhiRte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692773; c=relaxed/simple;
	bh=Z489YCatSICp2CYkRv/f1IFzE668yX8OtUM+wlNOmgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sP0LFT/bTxtNgGklslTCjjjgJBO3+y0cHKsHDpSOIERJFEyijt71uv/blqUdR00oyVlvE6002Fc/6BqSt3zoMwBdty6Q7Nl2cH8oTT2Mx9gqsBSU9wTN3eqvF+hSAsJX+BGukjdbsArRmnRTnK/2lOD1cCIiAQxcAiFihu5KaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awbEH11T; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c1b94dab63so977358a91.0;
        Thu, 06 Jun 2024 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717692771; x=1718297571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En8ByHgq5/JBTLUzMheK1+qjcQIGlXPibjicoZGW6BE=;
        b=awbEH11ToG12JIJYNIJngXm4TXa097gs+2tBqDv+NCYFYhaOBmIjPSrVtfrvpFyUbl
         YJCBZG/CXVkqRgzHTGytFYKBupDtmX5wf1qihgIAfuMXKoxwxapkuzvFi7x5JBcVslft
         FhlPBV/EtLvWYtTcQlGPIilN6O1zJxuWmWM3t8UxNpO+lE/caNVWsXKLW2PpmH+PfYpQ
         K14V1Qe3cXr9JzgA7k0f98E05gv/Gw1gGtM38EwU0kORa1onOzL5iECd0nRNbMkH/2Nm
         gmWWJjXbviK+r73tjZrT23ZjLvsSFl1rukGizqfNrX/29GLCziADudjQy/BqymV2pnyU
         6+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692771; x=1718297571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=En8ByHgq5/JBTLUzMheK1+qjcQIGlXPibjicoZGW6BE=;
        b=W+FI+xhB8n33EpnZ1RL5tuYy1ZgaBUqp2ho9zuYLTT5wQ4g7DKQ49TktbVT30bHipp
         rTxeWa5vkGbEl3JoB6JEuZ8hY8lnUPpG+X3cw8nDBh8IDjZ4861XBegqh5qIC8ggIbVY
         nblACsMuf42/iqG4CkznoGjenuCyKicUYdPHfOChxe2bePq7OAxQPugskJWZIoAQNnku
         8q76OGCvQNiIoiOP1+Lvexek/34SMA7eLHCSvYxtW31muqUNwcIKd8lwuk8tJcWWlTC1
         mJutNmWexfrOZJPP8kX6zEiwNUu01J4s/KRWKIuTqVu42japtCB02d5NCsYRaO75lY9T
         4Qmw==
X-Forwarded-Encrypted: i=1; AJvYcCWRR6/9eglT2klwf0j+m7V9DpamNwZCSTnkzh3kyKA3ZVyrb8XTdnp30E511uvQDP0h38MLD9kpOzaW6xpucVl25BYqM0pv5JCy6VQgF1co7wcErx/5GDPMi1j8pKRzurvIpb5aqBa8NS681eaUt1chLMxJ37a6FA2vCC528BYIfkSyzuIm
X-Gm-Message-State: AOJu0YwPthqQAW58YnGPhdTot+xdFHLkOvyVQIKNe3jBrPbsMcsAINiS
	f87ALpMxIpuBv0rZLf5BGHYgDKoPAhcg1zaELTCl7Atx64LjgkmjcPgDIO33udM+lbYAQCU30WG
	TNAzMZZNyPL+JnT6PrLFRUI+oBiQ=
X-Google-Smtp-Source: AGHT+IHP0yIUcy3OcRb+0v6LyDCfhpC64dvgrXwYV1W3tJj8EB6ihZgSseDQ3WrLT5MD8aI0o72kKrHX+R0NF/EEoZg=
X-Received: by 2002:a17:90b:30d8:b0:2c2:b625:ee9b with SMTP id
 98e67ed59e1d1-2c2bc9bb6edmr91541a91.4.1717692771270; Thu, 06 Jun 2024
 09:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604200221.377848-1-jolsa@kernel.org> <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com> <ZmDPQH2uiPYTA_df@krava> <ZmHn43Af4Kwlxoyc@krava>
In-Reply-To: <ZmHn43Af4Kwlxoyc@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jun 2024 09:52:39 -0700
Message-ID: <CAEf4BzaFcpqFc8w6dH5oOJNKsAXZjs-KCFAXLp8TMBtS5ooo4g@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to uprobe_consumer
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:46=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Jun 05, 2024 at 10:50:11PM +0200, Jiri Olsa wrote:
> > On Wed, Jun 05, 2024 at 07:56:19PM +0200, Oleg Nesterov wrote:
> > > On 06/05, Andrii Nakryiko wrote:
> > > >
> > > > so any such
> > > > limitations will cause problems, issue reports, investigation, etc.
> > >
> > > Agreed...
> > >
> > > > As one possible solution, what if we do
> > > >
> > > > struct return_instance {
> > > >     ...
> > > >     u64 session_cookies[];
> > > > };
> > > >
> > > > and allocate sizeof(struct return_instance) + 8 *
> > > > <num-of-session-consumers> and then at runtime pass
> > > > &session_cookies[i] as data pointer to session-aware callbacks?
> > >
> > > I too thought about this, but I guess it is not that simple.
> > >
> > > Just for example. Suppose we have 2 session-consumers C1 and C2.
> > > What if uprobe_unregister(C1) comes before the probed function
> > > returns?
> > >
> > > We need something like map_cookie_to_consumer().
> >
> > I guess we could have hash table in return_instance that gets 'consumer=
 -> cookie' ?
>
> ok, hash table is probably too big for this.. I guess some solution that
> would iterate consumers and cookies made sure it matches would be fine
>

Yes, I was hoping to avoid hash tables for this, and in the common
case have no added overhead.

> jirka
>
> >
> > return instance is freed after the consumers' return handlers are execu=
ted,
> > so there's no leak if some consumer gets unregistered before that
> >
> > >
> > > > > +       /* The handler_session callback return value controls exe=
cution of
> > > > > +        * the return uprobe and ret_handler_session callback.
> > > > > +        *  0 on success
> > > > > +        *  1 on failure, DO NOT install/execute the return uprob=
e
> > > > > +        *    console warning for anything else
> > > > > +        */
> > > > > +       int (*handler_session)(struct uprobe_consumer *self, stru=
ct pt_regs *regs,
> > > > > +                              unsigned long *data);
> > > > > +       int (*ret_handler_session)(struct uprobe_consumer *self, =
unsigned long func,
> > > > > +                                  struct pt_regs *regs, unsigned=
 long *data);
> > > > > +
> > > >
> > > > We should try to avoid an alternative set of callbacks, IMO. Let's
> > > > extend existing ones with `unsigned long *data`,
> > >
> > > Oh yes, agreed.
> > >
> > > And the comment about the return value looks confusing too. I mean, t=
he
> > > logic doesn't differ from the ret-code from ->handler().
> > >
> > > "DO NOT install/execute the return uprobe" is not true if another
> > > non-session-consumer returns 0.
> >
> > well they are meant to be exclusive, so there'd be no other non-session=
-consumer
> >
> > jirka

