Return-Path: <bpf+bounces-31463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258FE8FD7C6
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 22:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1033B2121B
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 20:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21D15ECDA;
	Wed,  5 Jun 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXGTHy/Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5E14A082;
	Wed,  5 Jun 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620614; cv=none; b=o3RANy3ojfn8hfPoEcjeKUhIXFkOCfYKNosn9iAsJaeIiUbqqRSJJNUEDS23nLdfqDDsV5oEdRLkPYsz7BXNB4opRcR5aK4QcIYI+CAobzRdmHWz6SZtRBxw/TSbesK7zvM9zCtoUW3HjUEHoygwdg0gljv/5gJNSwZcqAjGPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620614; c=relaxed/simple;
	bh=nFqzopE4yIBU+n0lvWvqybJhFArNaPc2r8aTMdrpla8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN1qyYJSgMhxo2EPpJVyNsZ5dJcUSP/xZYL1rmklwJqqKZ+yBw10gJpIW/EHEhZ50lpfxY1RPsPcJEmZYDerxHQ9cLsX+06Y+nUvtKCUJPdS4hZsmljymrwyjvdQAJsCBZjpvHYQaQdrzD9iVl+d78UOW0ablX+Wh61pBSqQXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXGTHy/Z; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a683868f463so26430666b.0;
        Wed, 05 Jun 2024 13:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620611; x=1718225411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLuQSn22Q0XbzYMrmg3FlopJe7yv4Si8pGo0Hy2H0g4=;
        b=AXGTHy/ZZtXvT5ln8g0Crzfwm3BkKdd571BEIKt4WLWFs/E2ulucMCZK3aIyAVfZAs
         0m7hKpwE2IzO1/H7WMeU2fF0G3g0uogoutvDIkFcQ/3FZ5I8r9PKWCSl2rYbVGbuzDtY
         aOR2uAB/m4f3etA6W7PnsAFjT6q4v8CUQG6eBsCwJKmtomat2gCp3pRg8+UwDZ70jdk4
         viHQY3NqiU2smPhBpBAEEjEq89/nccz0KHWpJpa4oZj0SlTMpDRiBGXSnkHujzHWvdqv
         FK46b1Rf9kTDQ1PqHc6n9CCm5dgqDWGRaVOvRiyB+4YYkFhLTJXRBRpT1shAYIZhkegb
         B+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620611; x=1718225411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLuQSn22Q0XbzYMrmg3FlopJe7yv4Si8pGo0Hy2H0g4=;
        b=VmtKdu75toY+Myi4BBFFQB7TBW9oVWP3/11oMY2BF8sG5Al8O2xhl2Je4Enmty0G3m
         18Kd6I6VehFWmCKcB2x/m2+XZKEUrJ6Pj8nnhjz+VPZzuDIkr4+deEEd6L0l019h09R+
         Xw7kSBrbuJk7mTNgLz4kQcYOkux8VV4jWgniRXpi7oH9PEL+Xxj9UJJ7X1SS0PuHHMAe
         lt65/mcupteK+UCZ5LFKzrlWqQLV7PNLL4zSd09oEsim3JfbdVkoHV3E0PU5iMGaIvmZ
         zFf7q3K8m/oXToNMNPHggX552PCpOmR8KKvLwn9sw5Xam8QV7tWvtaZ/YgydZyKTO9fb
         mrBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUagUSLodPVvw7OrSysj+qL6jzFpKUXrjom/qvGSWQnHvk/GfLc62sAo0yAcux4UkS+pwSZxYANWN8R0v7If6Wa1nhGaeRuY4WOPGLuthM6zWf7QnYSJCUXu5l7KC5aG7QJFgdbiT9hLIrEiO5q6a3S8jeHqDl83btpBdcZZcReUUuoWfhv
X-Gm-Message-State: AOJu0Yy54A4t9a3KQP3Kgq4ZRosOotjoXcl1yhHZaR0Ox0OqqioI5mW+
	yiMDMNR54874yb6Kp0j0dKnlBsLJtAP/9+zoGVmedKsKOwB3ydrH
X-Google-Smtp-Source: AGHT+IF8cE1+5XhbMdO8HMQL7oNYqClJi3lw8FCpx+dmiOec2u+4Kd1Br9QIWGuYo31IHdqZOhwbWw==
X-Received: by 2002:a17:906:840a:b0:a68:e1a8:9d2b with SMTP id a640c23a62f3a-a69a024f584mr230170466b.68.1717620610955;
        Wed, 05 Jun 2024 13:50:10 -0700 (PDT)
Received: from krava ([83.240.63.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68ba7fd6besm679871766b.190.2024.06.05.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:50:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 5 Jun 2024 22:50:08 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <ZmDPQH2uiPYTA_df@krava>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605175619.GH25006@redhat.com>

On Wed, Jun 05, 2024 at 07:56:19PM +0200, Oleg Nesterov wrote:
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

I guess we could have hash table in return_instance that gets 'consumer -> cookie' ?

return instance is freed after the consumers' return handlers are executed,
so there's no leak if some consumer gets unregistered before that

> 
> > > +       /* The handler_session callback return value controls execution of
> > > +        * the return uprobe and ret_handler_session callback.
> > > +        *  0 on success
> > > +        *  1 on failure, DO NOT install/execute the return uprobe
> > > +        *    console warning for anything else
> > > +        */
> > > +       int (*handler_session)(struct uprobe_consumer *self, struct pt_regs *regs,
> > > +                              unsigned long *data);
> > > +       int (*ret_handler_session)(struct uprobe_consumer *self, unsigned long func,
> > > +                                  struct pt_regs *regs, unsigned long *data);
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

well they are meant to be exclusive, so there'd be no other non-session-consumer

jirka

