Return-Path: <bpf+bounces-57624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C498CAAD435
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A96116E57E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E31C84AA;
	Wed,  7 May 2025 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAPrLagE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446F1BC07A;
	Wed,  7 May 2025 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589437; cv=none; b=MXJefBHI+Sh2vYloqKrVi3M7HWOy7AV4AZQYM0+1FaKlb6O103EZAoXmwxX87olkmvpab+jbQa+X88ohongrj9T9z9WTgVI0kF2OFSasgfI97ChYZmgWchSONrPI7Y/WJQ8hECwCu5scvzbPgVr2GT5olkZRvh02TLKsfJZyk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589437; c=relaxed/simple;
	bh=1/TV6tMl2gNlog8KxmmJQ9ScMhNwTlfXsz6pi42aGTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYhOLNyhuDCt8614pCJZKbADTxE9ZlFbOkAZd1wZEN0N317wQroKHmIq8ehHH5eQcD/t7YGplv4CN+N5pONHjW93jritzx9RRPllVEAR6a7nuRcxHsx17qw+650cuafCqwYk/CxtR3Wj8E7k08GBtqiuKpG0LeCVWrRvPtI9pH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAPrLagE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441ab63a415so63816045e9.3;
        Tue, 06 May 2025 20:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746589434; x=1747194234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKjjpWzv48U9LX3EX2sY4j22d7QCieaYoLqSyYGhmYE=;
        b=MAPrLagEqcyWEV7L8kkenHgxQfXOSr6ZrSWQThVkNLdze8dC3EVQ1Y/y7x04FRO710
         oMZxFrtI5sc0STAjdgpKSsUXpBi7hFkNKOoZ3lOrTFUf8r9q4w7Hr+sZdubJj81/S6fN
         tXAgeUM79mg4lSsRqunPubQdR7HYnC5lTwLxT+BNS40uNcYUpH4YCFsWH9pXQJ7sZQ7S
         H0BJU9HjtW57XH1MF5NRe+i3cGtQitGkj3wZ5FuqZg0uisnMpczTeyhUgSSYCD/mTCyE
         jP0OwFI25OcOnLmH+Ez0uJAPyhTBEafO1iuVKfHtJXoi+fOmQ8MhDdR4X4z7Tq+OwiVX
         rgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589434; x=1747194234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKjjpWzv48U9LX3EX2sY4j22d7QCieaYoLqSyYGhmYE=;
        b=A6xmXgKJHNgyd4AdL6HmI6D4zExZaMezh/Dy8YCrMJTMEeXeXNPQeV5FvFr8LofOcB
         NZOjfFyrKOx+95jdiRP+UpAPamSrFd015KerHacaO+KDw9ACgCGaPovVBJ2roN7sq9+o
         HXqerhyDn6t0PPQHaOJEoj4iljEfeTgqY86ST74qjXlb5s+k5flIL5UaCvymk46cJnyK
         0sbopWNy7Y3PS3ar8tN48OqVUwMoEy1PUT5wxW6gA/P71YATjXaGrlSDYPV7b3VC6S/o
         IZwG1YGo/8smBKZPoGPyNlGrbbZXOekcBIITXMCoV87K1X/KHT52x4pBsIUnNntTMkfC
         t07A==
X-Forwarded-Encrypted: i=1; AJvYcCUfNO3Up6J4/RSFna8EcKDSOxwgPUVMR0hRlo15riSK8IGISsonLKLIoglXeS3TQgjvW37c4XFt38gizj3U@vger.kernel.org, AJvYcCUwW3pQ3fWU4duwj/8c8J1pMUQKeOuR3wJVkE5Z/MHYpQDFwXMYySyEn062Br0T6UHn6mMWjrGe@vger.kernel.org, AJvYcCVjIjzf4J8WGZO2G1R/f3Q3CrJg76Mp3OWpyVPdXsBLVMqRVKlAJDlv+5DxrfPWgk/PVls=@vger.kernel.org, AJvYcCXR34x1TQByDKF6FxBH2Vc1Uvc+OmwV1ah3rRA1HivSTl6/4OdsaIik1ymKarELf+pdcYdM3WGE3WKUIx8BTPqi9DXH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7j5W1o/CgCRM1H4hhNtYIGY7vvscjvzpJAJhiwzotXBWlrS2u
	Y9Jn9JNzW8GAmr2xAJr/hDHDLFQCI9gs7aeJky7f6lEJPJHGlP8Y+2YrLldH3xDqtxuC64J+H+Y
	Fh69juD9YQffiJQEMT/Bj7jthiOE=
X-Gm-Gg: ASbGncvjFufBKdqKqKSeGMdyXLFPfrShfmW1t0I/O5hEylb9aAv9PokszcFw1/FJ6Uo
	nvOViq/sW0QimeB3C5AifKoMeJSs4zJo3rBijbSSr0sMYpuBAtHYB6EM+1iNHMFb63MaQ0LCwt0
	mARZMevYOj0Z2ExF93m1KPTyp3UcQ0bC1B6oTx+uKptPzVnrB3qg==
X-Google-Smtp-Source: AGHT+IGEG3zUsL0Hq6HZDsiJfGiMiVQhydWmd7Hclu84WAzBoZfmF3OvFbXv3SSqQyG4o6d2sB5Gmpt0wlD2gHsBZ3w=
X-Received: by 2002:a05:6000:1a8b:b0:3a0:9de8:8a45 with SMTP id
 ffacd0b85a97d-3a0b49d2755mr1212225f8f.32.1746589433881; Tue, 06 May 2025
 20:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506025131.136929-1-jiayuan.chen@linux.dev>
 <b776fa07-de4b-44be-ae68-8bc8c362ea81@linux.dev> <9c311d9944fa57cec75e06cde94496d782fe4980@linux.dev>
In-Reply-To: <9c311d9944fa57cec75e06cde94496d782fe4980@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 20:43:43 -0700
X-Gm-Features: ATxdqUFaoJtwVj0z2KLyes9UtmvTMsURQNshsCTGx3BUOtVxeWC_uBDz5fClPus
Message-ID: <CAADnVQKK87UV9rH_YviePfUmOO3mGXQmYfN-Q9Ax5AYv+xE8zw@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v4 1/2] bpf, sockmap: Introduce tracing
 capability for sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Jakub Sitnicki <jakub@cloudflare.com>, 
	John Fastabend <john.fastabend@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 8:37=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> May 7, 2025 at 04:24, "Martin KaFai Lau" <martin.lau@linux.dev> wrote:
>
> >
> > On 5/5/25 7:51 PM, Jiayuan Chen wrote:
> >
> > >
> > > Sockmap has the same high-performance forwarding capability as XDP, b=
ut
> > >
> > >  operates at Layer 7.
> > >
> > >  Introduce tracing capability for sockmap, to trace the execution res=
ults
> > >
> > >  of BPF programs without modifying the programs themselves, similar t=
o
> > >
> > >  the existing trace_xdp_redirect{_map}.
> > >
> >
> > There were advancements in bpf tracing since the trace_xdp_xxx addition=
s.
> >
> > Have you considered the fexit bpf prog and why it is not sufficient ?
> >
>
> 1.This patchset prints a large amount of information (e.g. inode ID, etc.=
),
> some of which require kernel-internal helpers to access. These helpers ar=
e
> not currently available as kfuncs, making it difficult to implement
> equivalent functionality with fentry/fexit.
>
> 2. skb->_sk_redir implicitly stores both a redir action and the socket ad=
dress
> in a single field. Decoding this structure in fentry/fexit would require
> duplicating kernel-internal logic in BPF programs. This creates maintenan=
ce
> risks, as any future changes to the kernel's internal representation woul=
d
> necessitate corresponding updates to the BPF programs.
>
> 3. Similar to the debate between using built-in tracepoints vs kprobes/fe=
ntry,
> each approach has its tradeoffs. The key advantage of a built-in tracepoi=
nt is
> seamless integration with existing tools like perf and bpftrace, which na=
tively
> support tracepoint-based tracing. For example, simply executing
> 'perf trace -e 'sockmap:*' ./producer' could provide sufficient visibilit=
y
> without custom BPF programs.

Similar to Martin I don't buy these excuses.
For your own debugging you can write bpftrace prog that will
print exact same stats and numbers without adding any kernel code.

We add tracepoints when they're in the path that is hard to get to
with tracing tools. Like functions are partially inlined.
Here it's not the case.
You want to add a tracepoint right after your own bpf prog
finished. All these debugging could have been part of your
skmsg program.

pw-bot: cr

