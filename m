Return-Path: <bpf+bounces-27675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB148B0890
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14471C21431
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D12E15AAA2;
	Wed, 24 Apr 2024 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK22elU6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72231158DBE
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959137; cv=none; b=lT95rZhhIkPLx0EsuLUzTP7OQ5gs4UQpm3fPqVwv1gR1hjZ72HmX/XZ1TC5qVlf9Csr9lZ2B7fNxTHhCxmZWi5TbposZe4wUhVMOWJiJlFmkVy8nvI+QbuMATB18GgaiwmfGMN9RqGWQtqZRfiPXp90gJJnCvjk7yysudBJfyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959137; c=relaxed/simple;
	bh=2ELkQjA6/gqvJZxVKGUMtNrnbLQa6yqFR9YV8tcEKck=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs1MjYb9f1o0IDOvhFzJyvxmDl22HMmelwWaSqBT2vXI5+IukcHAeyXmBgdEbkF8qm1UcKChBzYr/CX3ffFVmSLSbMFYHOPKUFsmbo4Y8ZrudjiSjkjRTOz39VLEjUQxFkp13kbFhzSwEunrlS6QYIlZNIkHliuG5F/PBqmBkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK22elU6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so7851178a12.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713959134; x=1714563934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=poXQ6HJT6R/fY1lGVLzrkIoelYS753BPQigVwd0TmGQ=;
        b=cK22elU6PwYJX5V5LJtZaSgLVqF6AenvX3vObUEEHg72Au60MMVlj1+oAZv/bD93bi
         mYzoOv1CTJrU4g3/3x8ur+U/whKyGGR+AKHk52s0kwd3LUIKYN8DbvZvaFcTqjcQB/KY
         HC0BFH5zPuoqDQcD72xU26/1r5wBmPnKDInKhK65qimUkSzVSCqsW2TQ1hRMYLrtw3L/
         hCpiAup1DlvLS0fwZzPcJ+U3eBi4hUdPzrbQFrc8CbwCZAclyFa+XS8lO7KG4kpubAEm
         fVyM/vKegAPGMYvpjOxphu1kpk7+q6T6feoTcD1KXWROI24OIoKCjFQQUhvBfrOPlVTR
         C6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959134; x=1714563934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poXQ6HJT6R/fY1lGVLzrkIoelYS753BPQigVwd0TmGQ=;
        b=iww1ZW7rE71KzzZXs1qXtRGsoRoagF33Bx7jDPyYt5AKFYwBXo1rtfMtumy99SDxhD
         A0ezgwcUIhPaaBOBKmrnL+d5Jp5oyLBn9m7lwSzA7P2e1dsUfZQkkwqV45VwaC57IuWS
         /Ex2ILwUGrAsNQWIUDI+mZWwCQkiechbXbYaohw5pg04BbhvhibZetOztk8M4jA3cpXv
         mV6Hzy/RaWPtuC0iYC+/n2P9IW+Z/YvgDbvMGLFDjlSAfXzKqShZkxejJXQIoMqlMX42
         rySYjcU3vSXwQn5b28QL2IgKeTNcStDrEJMioNCWMjvuF8dzGmG4RvzpOxDfLPMpO9PP
         s0sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8BY1f1QzqAGu3Vr3kTYPeo3iuqeHNVErOMqHyNeVHFfGOWbFLG186UnQDWURNDbOQVHmSO2uqMAIiNC6SXBAhP8FX
X-Gm-Message-State: AOJu0Yyzvou+mpXqUWVVXV1SCmkMlum8HYVQOtbB4zhxguC3oCMXztRv
	nrnwViIKdJPJYI2CRCoQfPv8HLhNEeL+EXMHlhROm+t5zMP52jcN
X-Google-Smtp-Source: AGHT+IFjhWzdsSxF8L7VLWA2ioDtj3DNkioWQLKW5owmRskVFB7xNO1dy2oSkoc20ngnkMK8v74KsQ==
X-Received: by 2002:a50:d5c7:0:b0:572:32e4:dac8 with SMTP id g7-20020a50d5c7000000b0057232e4dac8mr1034287edj.14.1713959133827;
        Wed, 24 Apr 2024 04:45:33 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402104c00b00571c12b388dsm7315634edu.35.2024.04.24.04.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:45:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Apr 2024 13:45:31 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 2/7] bpf: Add support for kprobe multi session
 context
Message-ID: <Zijw2-y-PrTJFHmc@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <20240422121241.1307168-3-jolsa@kernel.org>
 <CAEf4BzZYpaZ-70WU9gCRAcAfYEH9cq5GRyyZatygULKhS7zVZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZYpaZ-70WU9gCRAcAfYEH9cq5GRyyZatygULKhS7zVZw@mail.gmail.com>

On Tue, Apr 23, 2024 at 05:26:45PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 22, 2024 at 5:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding struct bpf_session_run_ctx object to hold session related
> > data, which is atm is_return bool and data pointer coming in
> > following changes.
> >
> > Placing bpf_session_run_ctx layer in between bpf_run_ctx and
> > bpf_kprobe_multi_run_ctx so the session data can be retrieved
> > regardless of if it's kprobe_multi or uprobe_multi link, which
> > support is coming in future. This way both kprobe_multi and
> > uprobe_multi can use same kfuncs to access the session data.
> >
> > Adding bpf_session_is_return kfunc that returns true if the
> > bpf program is executed from the exit probe of the kprobe multi
> > link attached in wrapper mode. It returns false otherwise.
> >
> > Adding new kprobe hook for kprobe program type.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/btf.c         |  3 ++
> >  kernel/trace/bpf_trace.c | 67 +++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 63 insertions(+), 7 deletions(-)
> >
> 
> LGTM, but see the question below
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]
> 
> > @@ -2848,7 +2859,7 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> >         int err;
> >
> >         link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -       err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > +       err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, false);
> >         return is_kprobe_multi_session(link->link.prog) ? err : 0;
> >  }
> >
> > @@ -2860,7 +2871,7 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
> >         struct bpf_kprobe_multi_link *link;
> >
> >         link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > +       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true);
> 
> Is there some way to figure out whether we are an entry or return
> probe from struct fprobe itself? I was hoping to have a single
> callback for both entry and exit handler in fprobe to keep callback
> call chain a bit simpler

AFAICS not at the moment.. also both callbacks have same arguments,
just the entry handler returns int and exit handler void

jirka

