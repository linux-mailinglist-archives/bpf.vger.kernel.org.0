Return-Path: <bpf+bounces-39181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43896FE14
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 00:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D9E1C21EA9
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F92F15B0E0;
	Fri,  6 Sep 2024 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8FnuD8T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C771581EA;
	Fri,  6 Sep 2024 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725662521; cv=none; b=Gf6j/KgQjS4MxTLqCU+iJjm8PDqMXJ/Ibb/KDfi0jWKm/FH6Yd4z0d6SZqVdW4PmOFxnrWpWw7gSF0BmD4HYmxrs3rdlzO4gKtMa31SwJJVwtQkqLkpoIZ/Vo5OMZbmON3dDr5spBVdn9EFJXFJ3gYTgBUg2s4QStBAUf/FKdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725662521; c=relaxed/simple;
	bh=apriRO30uNjR4VhVg9cdtohH5DV8XblOWdUpesBhdm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8DAI9lOLgy9wCkunsVyxMNeExcjnxNAcEv9hiW+unyGWTXEnfHBQsoVSR6UXbBD4hLhVGigMXkHhk5mVCpgWsz1lD3LB/aDmz0+JZ418xAgeRxW95OC78qY5L49se/Y3bNE7fs853iW6wpSDIjsV9Ag2yeov8KT2XwzXCvxOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8FnuD8T; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso14120665e9.1;
        Fri, 06 Sep 2024 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725662518; x=1726267318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apriRO30uNjR4VhVg9cdtohH5DV8XblOWdUpesBhdm0=;
        b=c8FnuD8TvH6B/ITLmavws07mwccv0FVLrZAB2IKqYkb+J2Ye5aFv/77B/N1gx/GNb8
         3HN2I4g1pfbmZ+D/QjSQhNo0b4SVEb+nMIbbdlfcEBod2xgb5fYk1Eb2DjLURLpituh7
         gtJzlURK9mz7ACgbGn9s7UW8WRZF4V6QzuAUpbSfJlQZnphWv7/FYXNgcsDFheNn2uZg
         OHBVPOJFuVQ+r9Cr4+FHw/t5+NJBjDlGtwTGWuxsHguj7h+X5jNeWR9qR84xhbuFsB4s
         rcgWx4qpWthFs8cWbuE8eV92lxwjk+LjxmFMk4REPsCRdR7WVvBQYnemEOWf7JGAG0bZ
         xFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725662518; x=1726267318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apriRO30uNjR4VhVg9cdtohH5DV8XblOWdUpesBhdm0=;
        b=n7r/6/1mavCpzxrpKne+RvuC2xVEnb7ImcW0IGh/R3wqoHyx5o6hDqe40sYCW6bwvn
         2SVwJwe2mpb4twz4ikM4COw86V3hTHjfyYA0wqKAepOlZ4UaZtbunmv6WmHtXQFzYoPp
         Omnmix06CISFPdPYTNY3uCxIo0k2OWLeydqz9M55hcxoE1YwMunH4U00VwA8cHiINotK
         By5o5bGlfJ7+GrV0PpIC/2RPj/ke2S2+9Dr8yoNdfDyOQZxzdvx3u+gC1FjW//tvs08W
         jQc1K0C+fUcpfwi7BWSsnIRf+ZK6j2nTlw3KC++0SynNUuuElQajGE5KbUrsCguWsdbs
         lPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhpoPKvmuVns3Bashu3UXtunIKLZJbEQNpuArf5QTXRfS6CpFa8t3Ytbqmi1lVgS0vEZM=@vger.kernel.org, AJvYcCWuNXsH/W+1TeSgTB3xye8igVBat3uWN7txT4ZLHUQUL73/W3QUo2hRuwiGqjO1SEkYiNxJG2JiJJw7ZWV0C7VqCIhL@vger.kernel.org, AJvYcCXoDJFXRGvS0JhBElm6tZbBIPv9iu8eS6eeXZmETlw/F7QhYfzqEAdcaKmtD4mh6SJSKc00DUt6@vger.kernel.org
X-Gm-Message-State: AOJu0YyB2C4TlqMS82oI/qNOre8K05atnpvuVEC/HJkubCyFUObE1ZSy
	/UmV3OMS267nhl8kSrA4BW3BrcZVEt/Y9YXyqYY4pV0TWF824VMt25ipOTDsDgWAqrvAE9WrNrX
	QdCi6wvwILy8k/gHoTXHkS0MiWL4=
X-Google-Smtp-Source: AGHT+IEaBRFwqqdXZeoCk5GBB37GxWku+OwdSPI1p8rOw/8V6Em+nvEPnRW57/xNDI4BVDGd8e48Zr+d89/jUhMRzvc=
X-Received: by 2002:a05:600c:4689:b0:426:67f9:a7d8 with SMTP id
 5b1f17b1804b1-42c9f4bb7femr28102635e9.9.1725662518098; Fri, 06 Sep 2024
 15:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
 <20240905075622.66819-4-lulie@linux.alibaba.com> <CAADnVQL1Z3LGc+7W1+NrffaGp7idefpbnKPQTeHS8xbQme5Paw@mail.gmail.com>
 <20240906152300.634e950b@kernel.org>
In-Reply-To: <20240906152300.634e950b@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Sep 2024 15:41:47 -0700
Message-ID: <CAADnVQJWm_CJobz71_FRPTFeVojHLgmYmQA4tVhOg3MDP2V2Dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] tcp: Use skb__nullable in trace_tcp_send_reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: Philo Lu <lulie@linux.alibaba.com>, bpf <bpf@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kui-Feng Lee <thinker.li@gmail.com>, 
	Juntong Deng <juntong.deng@outlook.com>, jrife@google.com, 
	Alan Maguire <alan.maguire@oracle.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, Viktor Malik <vmalik@redhat.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Network Development <netdev@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 3:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 5 Sep 2024 17:26:42 -0700 Alexei Starovoitov wrote:
> > Yes, it's a bit of a whack a mole and eventually we can get rid of it
> > with a smarter verifier (likely) or smarter objtool (unlikely).
> > Long term we should be able to analyze body of TP_fast_assign
> > automatically and conclude whether it's handling NULL for pointer
> > arguments or not. bpf verifier can easily do it for bpf code.
> > We just need to compile TP_fast_assign() as a tiny bpf snippet.
> > This is work in progress.
>
> Can we not wait for that work to conclude, then? AFAIU this whole
> patch set is just a minor quality of life improvement for BPF progs
> at the expense of carrying questionable changes upstream.
> I don't see the urgency.

The urgency is now because the situation is dire.
The verifier assumes that skb is not null and will remove
if (!skb) check assuming that it's a dead code.
This patch set adds trusted stuff and fixes this issue too
which is the more important part.

Also it's not clear how long it will take to do 'dual compile'.
It's showing promise atm, but timelines are not certain.
If you recall I pushed for 'dual compile' for the last several years and
only now we found time to work on it.

