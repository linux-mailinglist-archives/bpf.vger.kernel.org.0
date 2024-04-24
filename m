Return-Path: <bpf+bounces-27645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317668B00DE
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 07:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C1BBB22769
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14213155395;
	Wed, 24 Apr 2024 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmlF+96g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D34D154BEB
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935530; cv=none; b=sZlbzo6SbuNWNqiOwZqjDTswYVKc95xRY1lnhSyzr+co980pOEPpbgXF7/NMBW3gqbVXrZmb2QnfbNuTtniSiSQafZpV4JfQGb41e+GQ4/a6MYUK8/xr+UHOXwXcVxdz8g063uN/nxOc7N3exLTCKqO/+r4oKSvVMJOz0E9UBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935530; c=relaxed/simple;
	bh=oigdUpyDyXGEsznwqLeXQmV6wBROE5hyxlqkdeJIZ9Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pvsdaK+bXUQVcGnE8DhwCrIyTv3e15E1W60mZEd9BNpinKQUNk2dWjLZSAmfixEqcQa2FLmS65q3QJwZkAcbOqmJmH4tC2+JQVM82ETZLqxG8G9sfDHGb0Hzcglv8YvD40unHcL7sWBFkF/Or2QzSxA65uy82XPSQ6h/SboH7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmlF+96g; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e4266673bbso58308335ad.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 22:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713935529; x=1714540329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0kS4SbVAyAukHq+C3RgQ7YfBlnAL0irPtThbDywcDw=;
        b=OmlF+96g8ImvD6Z/zPjWjox0qDH/ho4+DWKtHjYz3b2JeDmyrpnidyPx5noTJRSKhl
         VrBa71ykHcBZe03iOrEFOYf+x6KcfYwc7pOSxQhlgUDY5bTC9hlvYJJk5YIQEiwlXcG3
         IMabuiYYX+uq44K2EXxbGAh954Txr6BjYI47KFZXUrOOWuaLwQgNWWmmqSKA8/8Kd6cy
         A/SSd/ftafAnb+xb03RK5TsKvFe0UNFbUxq+qfKPuuRuf8cszS5d2clPvFRZPIyoIRDj
         1DY5RcxLAkVbpjd0AACXQswqKU5jDV3LSJPiKySoPioKnXDnaWHCU6Mr05SX398p8K8p
         MW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713935529; x=1714540329;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q0kS4SbVAyAukHq+C3RgQ7YfBlnAL0irPtThbDywcDw=;
        b=RGQp66hNdr1T4BnXsSwclx6NsGMP8YRm3NA8zTVtXHrr/aUGtib6MnrTISqj+r+YCf
         8H6kEs1cmxAaRnMxQVA6QIvlHkcImAbFeqC+E8b3bjhnR2xOV1tKYGNT+ZXfKT38zU1h
         6fq1maAroQFHXrd3pmtY+fSFFAoW1zc/M9MJc7So8m5v+ccgnKiM0Y/+e0Q6ZTyRT0he
         aCZWwB4HERki/sXBJt/80EmtYZhhAx7+N/yBwFvXHUbN0bGeWQi5fyA6pUkQeNpWbAvK
         wMaTOydfWZLIY11nQcgtNmApXsuBFI06pTDZex24s/emI38haH2578mEicaYxFXJeDtl
         r8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhkykrb0d3XHROOIYcDDEU+RmVFH/OPglC2vJTUbITS8Ziq+9eJtCdU2XBcB8Svq7ii9Z3bd1HtefyMt5HgpFBRSUJ
X-Gm-Message-State: AOJu0YzDQLIeDcaZ7YNvW9uCfrq7b4c6eZhfJqenHPSZAFM0u2VVaILU
	39YvPJpVzS7qc5crNppbesG6iA0pX40dMfOcHsVZgxkZmPtLPKO5
X-Google-Smtp-Source: AGHT+IHa9T9tfgx95++vBjhRcqPgd8kkq9Fvz9S6JkXaopJX7hRXob2Fw9RvT9C3IxEjzxErE+OWdQ==
X-Received: by 2002:a17:902:c40f:b0:1e5:5ccd:30e1 with SMTP id k15-20020a170902c40f00b001e55ccd30e1mr1359938plk.65.1713935528533;
        Tue, 23 Apr 2024 22:12:08 -0700 (PDT)
Received: from localhost ([98.97.33.87])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001e1071cf0bbsm10965631plg.302.2024.04.23.22.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 22:12:08 -0700 (PDT)
Date: Tue, 23 Apr 2024 22:12:07 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 Martin KaFai Lau <kafai@fb.com>, 
 Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@chromium.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Viktor Malik <vmalik@redhat.com>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Message-ID: <662894a735565_61405208b7@john.notmuch>
In-Reply-To: <CAEf4BzbAjGcrqLi4+rjU5JALHPF5CjAww4fexassr3vWe4FaZw@mail.gmail.com>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <CAEf4BzbAjGcrqLi4+rjU5JALHPF5CjAww4fexassr3vWe4FaZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf: Introduce kprobe_multi session attach
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko wrote:
> On Mon, Apr 22, 2024 at 5:12=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> >
> > hi,
> > adding support to attach kprobe program through kprobe_multi link
> > in a session mode, which means:
> >   - program is attached to both function entry and return
> >   - entry program can decided if the return program gets executed
> >   - entry program can share u64 cookie value with return program
> >
> > The initial RFC for this was posted in [0] and later discussed more
> > and which ended up with the session idea [1]
> >
> > Having entry together with return probe for given function is common
> > use case for tetragon, bpftrace and most likely for others.
> >
> > At the moment if we want both entry and return probe to execute bpf
> > program we need to create two (entry and return probe) links. The lin=
k
> > for return probe creates extra entry probe to setup the return probe.=

> > The extra entry probe execution could be omitted if we had a way to
> > use just single link for both entry and exit probe.
> >
> > In addition the possibility to control the return program execution
> > and sharing data within entry and return probe allows for other use
> > cases.
> >
> > Changes from last RFC version [1]:
> >   - changed wrapper name to session
> >   - changed flag to adding new attach type for session:
> >       BPF_TRACE_KPROBE_MULTI_SESSION
> >     it's more convenient wrt filtering on kfuncs setup and seems
> >     to make more sense alltogether
> >   - renamed bpf_kprobe_multi_is_return to bpf_session_is_return
> >   - added bpf_session_cookie kfunc, which actually already works
> >     on current fprobe implementation (not just fprobe-on-fgraph)
> >     and it provides the shared data between entry/return probes [Andr=
ii]
> >
> >     we could actually make the cookie size configurable.. thoughts?
> >     (it's 8 bytes atm)
> >
> =

> Attach cookie is fixed at 8 bytes and that works pretty well. I think
> beyond 8 bytes there is no clearly "right" size. A common case would
> be to capture arguments in kprobe to handle in kretprobe, and there
> you might need at least 40+ bytes, which seems wasteful. So I want to
> say that it's probably good to hard-code it to just 8 bytes (enough to
> store timestamp and you can even fit in some flags if you reduce
> timestamp precision from nanoseconds to microseconds), or use it as an
> index into array or some other data structure.
> =

> let's keep it simple?

+1 for keeping it simple. Use it as a key if you need more.=

