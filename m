Return-Path: <bpf+bounces-33955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF21A9289B1
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 15:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30281C20E7F
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85859154BEE;
	Fri,  5 Jul 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B42TsceU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60F14C58A;
	Fri,  5 Jul 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186182; cv=none; b=ly2ymMXC0v8GKWzzIQbG+gakg+8skjXzKj9EQJgFoF3MpeMpbwrYSgryuCdwPiCHNLSND8i+LyuwzcwZRLtC5StWETOyNNarFilqhj/92+PheW177fyEKQHSWbCCPw2memGT5mphp9QlZwoPYgtv6RaRVaxZBypiLrA+cjnVXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186182; c=relaxed/simple;
	bh=Sn5s59O/NdJNCUezWqX1qa1IHRrl5kIcmolOISDixU4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ach7Xl0J+vjMkkFIU/bzapD6Os0YQUBhqGwHBvL0Uw8J1gcR2sK7OemrAXH7hyNP7F+blPZfONQZ0r5mxkKA/hQVavdjiRxVaUE600tD7WItrOjX98y3tFQtP4yh3tri74OmjiZt8SZeJbtnCuzT5QDqNquDQP0YtiLdhzEwZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B42TsceU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so1126358e87.3;
        Fri, 05 Jul 2024 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720186178; x=1720790978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aw0j1Lviadpf2ZsL4nF7pPLS0qZe4Z8jYOAWk2mW/4c=;
        b=B42TsceUiAcgKTmDwcKBlhIFP1VTD4zIipRqJ2TviXd58KpCfHUT+ImlOFL/5ubtvU
         APVDaskkkKiDk6uOqiumuOILk+7CYKgclwCk/ydSQaqAdzD7yVNOO901N9ImgbGoX1K5
         iYexIjmyDetcGinC5ZfJ2RqbwhplRX5OePBqLd3AeR+YULDAcf8Sm6rZ3NKIzvRhQVIE
         qJBLpaGXniSqka/r53VMs59hjZPs1rcM5wWrAhpl2enQerjNj+CIgks8NZH9gas4PHZL
         ZUPWKHlSxwZ2hHhU0smPU0SgLBnIFUJhoW/gpxa0okSIUbVO3JrMhyFXsi6BefpCvFl8
         58uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720186178; x=1720790978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aw0j1Lviadpf2ZsL4nF7pPLS0qZe4Z8jYOAWk2mW/4c=;
        b=X8xfdp3HfefiHlrv1ZitH0ThWSZpSW3M7RWd06sSDVUhR6rcn1LP7XM/eOQxeLvI5Y
         9n0yhuEPk709Hl/f9uq+6ECg2Px0YlBony3xRXsm/JDL1gA05zT9zOmeHbkw6NG7iycV
         OOjFYC05YLeob5k++7iAW5YaKqVfVF/ab0QKCbhdXRdEigOo7S4nM3wToXdrkBp28/Fy
         cN67dN+SyuUXy/H7TfmQwucEwOOAshGG3W7gGSFLslwpqg4dkf0r/iZaD/RCt1ODPw2u
         Tze2yGTjqtQkSKdRQrS2OJgL+jgHQVWjcWGqZ7WB4gBGti0O9+zru7zsdxiCo0dtKKxk
         JRYA==
X-Forwarded-Encrypted: i=1; AJvYcCVLdmMkjSoeeGJCdE7Srapj8rpwJ0Xi9gQo33nzMM2e1TktBvAMNBCViksHI9OR/uBVFtj92VfW6wmmVVZ/b1Qge9LnNN/Lqr8Nrcuz0qk8hcPqypf/nlfZi6PJBLAE0Ifh1R/BxB8sMDXbGbMkn7f9xf6+Vrmyj1XcjtyTXjKIYavqBnED
X-Gm-Message-State: AOJu0Yx83+EckxkNoS1rnTJ3OYJijlzV3PNmNEP4V0kKD22juOoAbMJy
	Lu9g87d/rT3wXC9IYd/Mc6psOAh+MvRd0Uz4pJiFzuxWWn33p1p1NYY/0pdx
X-Google-Smtp-Source: AGHT+IHhHwPUMPvwQX6weNqntFkxeQjtYYCA77JffkZg73dPIGdqMUoP7TGNBZEzxDpnYuDesfo4Bg==
X-Received: by 2002:ac2:484a:0:b0:52c:a88b:9992 with SMTP id 2adb3069b0e04-52ea06bca79mr3236891e87.52.1720186178173;
        Fri, 05 Jul 2024 06:29:38 -0700 (PDT)
Received: from krava (net-93-65-242-193.cust.vodafonedsl.it. [93.65.242.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f069sm9875701a12.33.2024.07.05.06.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:29:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Jul 2024 15:29:34 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <Zof1PiQOI0kex_xY@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com>
 <ZoWGrGYdyaimB_zF@krava>
 <CAEf4BzbfKE1cWWXfWnWN510pai8Aq_W6J-WSLSAyGO_=rZWX_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbfKE1cWWXfWnWN510pai8Aq_W6J-WSLSAyGO_=rZWX_Q@mail.gmail.com>

On Wed, Jul 03, 2024 at 02:48:28PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 3, 2024 at 10:13 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Jul 02, 2024 at 01:51:28PM -0700, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > >  #ifdef CONFIG_UPROBES
> > > > @@ -80,6 +83,12 @@ struct uprobe_task {
> > > >         unsigned int                    depth;
> > > >  };
> > > >
> > > > +struct session_consumer {
> > > > +       __u64           cookie;
> > > > +       unsigned int    id;
> > > > +       int             rc;
> > >
> > > you'll be using u64 for ID, right? so this struct will be 24 bytes.
> >
> > yes
> >
> > > Maybe we can just use topmost bit of ID to store whether uretprobe
> > > should run or not? It's trivial to mask out during ID comparisons
> >
> > actually.. I think we could store just consumers that need to be
> > executed in return probe so there will be no need for 'rc' value
> 
> ah, nice idea. NULL would mean we have session uprobe, but for this
> particular run we "disabled" uretprobe part of it. Great. And for
> non-session uprobes we just won't have session_consumer at all, right?

hm, I think we don't need to add both session or non-session consumer
if it's not supposed to run.. let's see

> 
> [...]
> 
> > > > +static struct session_consumer *
> > > > +session_consumer_next(struct return_instance *ri, struct session_consumer *sc,
> > > > +                     int session_id)
> > > > +{
> > > > +       struct session_consumer *next;
> > > > +
> > > > +       next = sc ? sc + 1 : &ri->sessions[0];
> > > > +       next->id = session_id;
> > >
> > > it's kind of unexpected that "session_consumer_next" would actually
> > > set an ID... Maybe drop int session_id as input argument and fill it
> > > out outside of this function, this function being just a simple
> > > iterator?
> >
> > yea, I was going back and forth on what to have in that function
> > or not, to keep the change minimal, but makes sense, will move
> >
> 
> great, thanks
> 
> > >
> > > > +       return next;
> > > > +}
> > > > +
> 
> [...]
> 
> > >
> > > > +               } else if (uc->ret_handler) {
> > > >                         need_prep = true;
> > > > +               }
> > > >
> > > >                 remove &= rc;
> > > >         }
> > > >
> > > > +       /* no removal if there's at least one session consumer */
> > > > +       remove &= !uprobe->sessions_cnt;
> > >
> > > this is counter (not error, not pointer), let's stick to ` == 0`, please
> > >
> > > is this
> > >
> > > if (uprobe->sessions_cnt != 0)
> > >    remove = 0;
> >
> > yes ;-) will change
> >
> 
> Thanks, I feel bad for being the only one to call this out, but I find
> all these '!<some_integer_variable>` constructs extremely unintuitive
> and hard to reason about quickly. It's only pointers and error cases
> that are more or less intuitive. Everything else, including
> !strcmp(...) is just mind bending and exhausting... Perhaps I'm just
> not a kernel engineer enough :)

heh I was going for minimal change.. but it's intrusive enough already,
so let's keep it at least readable

jirka

