Return-Path: <bpf+bounces-39183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B696FE65
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 01:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F81D28903B
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A978015B140;
	Fri,  6 Sep 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCTTjGop"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F31B85DB;
	Fri,  6 Sep 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725664947; cv=none; b=RSqwnnQLxuxUnXGbOhUN+2ZoqnQc6uH14g9ZsFmeX/5NOg+C2BbBIRzUsnQy1R5Tfh4GuJ51qfzbWnBHoQV5V9/V94XkGGaF1AgrdoFKoPOrk6RtfjJx8c5lx8qAvjA1i3NFHZKHptsAF4FxKkiow7YK9I7jFJIypnmQn+7sgy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725664947; c=relaxed/simple;
	bh=4ifgj+aVAOh+9a5Oy9wqAahHvc3xrxq66py1pHBwu2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsLG9Sf5RG8EHpbYfSpQvfUPffE84XP41lqsi7XA5LY/7W8F+i22dE0Hh7DaF/k0r5RH/3DL3Hc/oLL/nYrWb9fz4DciC8z35OwovOK6b+y72YIuWFDaYP5fQFaJNgDc55Ofz7SIeggULdWm/NxLPoLZgV4eijpDI1uH/PS43DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCTTjGop; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c1963cb6so1394594f8f.3;
        Fri, 06 Sep 2024 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725664944; x=1726269744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSvXewikvayzhAgejdKKNOWwhCZKcclsrYl2PMO2ODM=;
        b=FCTTjGopo5Qu1Iiz2Y6AgrZSv9aLu08KQ5w2miTvJa0O2iby0//xAf3Hl886oAHZ82
         azElQtVVWMu6usZ1LtDvsFVBMJzLbo6+JpOl7z+YpIcQFKs+u+sfcOgtl6HJSKQ27H1b
         L/gYPo0E+Jwbz1jT9RdwBPC5YvYzuu3p3Xgfr3LsJrlSSQ2I4UhzZXkBJ1NZ8tlVgM2Z
         3/Hrcn4FlK7BVU5osDU0N1v0zQpb0NasEZw4FuuKml3aLF3WetRmCMSw7r6WipAUq8Ln
         18CpZ02mAgsp0ts80CNZ1umOeYHOO2RjmV9Kxzb11YCXrQlGi8S1e8ibYr+G/RYcGpsm
         zJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725664944; x=1726269744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSvXewikvayzhAgejdKKNOWwhCZKcclsrYl2PMO2ODM=;
        b=m/5cZZB4Iiy9CdlQkMiB/t1+J8YjQmX0tpCGefUXyNEg1iI5TOd88/06W9KxcrQBB8
         ddan2K2n6Bv2b+3mxWFPg900GM+PRPpvTqZJM+sHQa25VBoPwKqLWYp+YdS2VTZ3+BTd
         86VcTFctsPxJ2Dc7agLVxmzjfS7clLQV+bt1gMl/x3qBLzH4gGxKLXO7k5eXkR3KkRle
         hebs6Zcr7BbTmraihu9aV+7xsLNxVUpVBNTbTbDzsAiVjX22wgvZ5zbaSLpfx2U1RMz3
         re0xzsvF+bs45RlE8fPfCxnKMsFOu7qmPDdo+OPDtURsEvmPbkwq3P8OD4/ANuyF77BC
         ijvA==
X-Forwarded-Encrypted: i=1; AJvYcCVCQTCAouVFrjgF6QkMfl7JE/ry8qWsk0JqlCJYQLeI3p6vss2TeAF61WJUlrLeRYsrZFS+teOy@vger.kernel.org, AJvYcCWklgPeZbMbTc52aEghbg1Lj+3W5Thr0Xo+bcMvWMhBxJkIQpGHgcYd6H1frXuwXQtiM9k=@vger.kernel.org, AJvYcCXMOCdiYSZVDGY1y+ZlB68jKdrLqyPul1ilsvx3/ui0cTMTa3WDZZ52X1/XYJKyBY3HyB7AiN6dKUBqUfK+jkSY+h8J@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVLSq0RjqqqPZy5pBebf6p/cV3Hxerc0+wpv7xye5xtS+hodE
	Gvl2vMkoLjbVunw/j/YMuCwCv5bY3XlUlHrhFiRaO8GrYu560NOzsPdnMTq4XFf4ZLr5pIqbZgL
	O7mA/TgOnzyERfDsB9a7i7BvYGklUl/6E
X-Google-Smtp-Source: AGHT+IFEzcUdF+SphkBccXrWQ7DN3tpOqvQj3byjfTquwPfVrG60kAqMzFX4viERfVLubpFz0O5jlN59xegcugO7XIo=
X-Received: by 2002:adf:a11e:0:b0:374:c0a3:fbb1 with SMTP id
 ffacd0b85a97d-3788960336fmr2639589f8f.35.1725664943765; Fri, 06 Sep 2024
 16:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
 <20240905075622.66819-4-lulie@linux.alibaba.com> <CAADnVQL1Z3LGc+7W1+NrffaGp7idefpbnKPQTeHS8xbQme5Paw@mail.gmail.com>
 <20240906152300.634e950b@kernel.org> <CAADnVQJWm_CJobz71_FRPTFeVojHLgmYmQA4tVhOg3MDP2V2Dw@mail.gmail.com>
 <20240906155742.0bd4d4e3@kernel.org>
In-Reply-To: <20240906155742.0bd4d4e3@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Sep 2024 16:22:12 -0700
Message-ID: <CAADnVQ+nsUuQ+6rvEq7mYdE0vvqfZ-=hubcoGgUpprHA5P_mHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] tcp: Use skb__nullable in trace_tcp_send_reset
To: Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Philo Lu <lulie@linux.alibaba.com>, bpf <bpf@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
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

On Fri, Sep 6, 2024 at 3:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 6 Sep 2024 15:41:47 -0700 Alexei Starovoitov wrote:
> > The urgency is now because the situation is dire.
> > The verifier assumes that skb is not null and will remove
> > if (!skb) check assuming that it's a dead code.
>
> Meaning verifier currently isn't ready for patch 4?
> Or we can crash 6.11-rc6 by attaching to a trace_tcp_send_reset()
> and doing
>         printf("%d\n", skb->len);
> ?

depends on the prog type and how it's attached, but yes :(
Without Philo's patches.

It was reported here:
https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.=
csb/

Jiri did the analysis. These files would need to be annotated:
include/trace/events/afs.h
include/trace/events/cachefiles.h
include/trace/events/ext4.h
include/trace/events/fib.h
include/trace/events/filelock.h
include/trace/events/host1x.h
include/trace/events/huge_memory.h
include/trace/events/kmem.h
include/trace/events/netfs.h
include/trace/events/power.h
include/trace/events/qdisc.h
include/trace/events/rxrpc.h
include/trace/events/sched.h
include/trace/events/sunrpc.h
include/trace/events/tcp.h
include/trace/events/tegra_apb_dma.h
include/trace/events/timer_migration.h
include/trace/events/writeback.h

which is 18 out of 160.

All other options are worse.

