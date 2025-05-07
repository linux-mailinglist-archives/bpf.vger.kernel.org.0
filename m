Return-Path: <bpf+bounces-57628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3FDAAD4D0
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 07:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1351B681F3
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879511E04AD;
	Wed,  7 May 2025 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mko7YDkT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E21DF742;
	Wed,  7 May 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594552; cv=none; b=UIAGavYhBIPGKULGacmOagd4WmfGuymux6A+QT/6UOctSDj+S4HJyC8m/EbRvVB0rHM9dm2cBuBEdDuW4brYw/G+cdNnniY9E7vULfT2b4U3FGRz7O7xICIYi/pmKIs4nkEZd0w6X1tDY2IKwNvGRwGZtbhtkd9NskKq0Ou4QYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594552; c=relaxed/simple;
	bh=Cg3lNgNXXlY3tbGP5L2tCy8t6w10UD5L5/hDeNrXlh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ3/M+X9YVQGGWBHQ9kakyQCFDyjB0arDL16pBLwJHbpk5MGqeYa4eZxtKyTzUjNjDhyGsAMdYPgDZ9++0tnKZZ/xyHwoSnQ1GSXGaJZAZi8YbE8l9uUvBWVGK9uCfXIuR829aaK8OEnHOsRq/Y5ZI5dOK6ktU6+HZiPK0te1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mko7YDkT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30a509649e3so3791743a91.2;
        Tue, 06 May 2025 22:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746594549; x=1747199349; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qDfFaWqi7aHktXrAOXgC9kWrCSEA1y5g+C1t+ku3vxY=;
        b=Mko7YDkTZNpD12w+iwfQJK2Z4a0Kdbb1Ehd7eqTQnYrEb8/qipYNqReb4YcytRg+Tf
         8XBxBXeeNhC1shujpfoUk027AJEE5tHuMjOW39IoP98bZY2TkVT7+QAicgGBPyfCnWog
         4+bugis547EVPXTLlsZliZuRqIZXqWidQXEu17XHa9+yCEzB2bvg+X2T+JoW4UZSdqK0
         o5BsvAOlE7A7exnsGRpYE9GpmaTNHJ8jZhb2d4ZkexUrmbYtQ+LWZEEA9FXNVY6HEGVT
         UPkXFP5SJ+EEp5hFrqJBBxkzm7G7LTTbrVazJhftfghfXXGSeBDCo2Oks3jxwNEboKQS
         Fjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746594549; x=1747199349;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDfFaWqi7aHktXrAOXgC9kWrCSEA1y5g+C1t+ku3vxY=;
        b=OXhWZB3ZYx7ogQvFkdMhrudwtjF+7P9hjDzyVIdUyBAl3pGd7At5Eo3t/gTOL0np1s
         x7cs2ChPsQQ+mgzInX6NqkeVc/iFgxmLj7yfsjEdW2yYLKd1xMvyyi5J65P6ZfPr5MKe
         FtX+P/MqVbXmHnJpEX3DK7yneI15mFDP8azm4IUu2wawHuLV9pK7nyjIyxyT2HgfpIVw
         ydLofPJDJsx35wPp7H5uAADuvjCFmecI5mZdCCUYK5Pc2WIOWIKarEtIxnwnGkRfgbOM
         lw/drHelm9VsRe/HIDw6zneJPziLN3xGVFvWhNVUGyfmvqmZkbep19nM5XMKyPLF21nf
         CekA==
X-Forwarded-Encrypted: i=1; AJvYcCUwezCLQdlQY1rsRvq2XjoTZaGrdq2Yo+Cvy/sT5gt5GwMKsAlrYu33TKEdDTwWLXua44c=@vger.kernel.org, AJvYcCWS97lFshWuhG9ap/sxqvpI6I8/nPGy1uflb6HyY3PcQfkK1eZWu9vM/vUKUks1z3vYseRFQAQy8MH74/0XxQ5g0fTV@vger.kernel.org, AJvYcCXRvTA+BhSbm90KFTCnC5Fum0Auv+QEr5TJInk6cYBWsgX36zzALT0gKsNZIgUq9b59FsQWG2GS@vger.kernel.org, AJvYcCXgBZvGwsI9lk4rBW+JXb7hNAV3omaRFnVKoGfeQRSBLRfDP/yUJPfm1k7+Ud3gWgOUAeQvJi6sS+ySC7m8@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUKN4ND+mryru0TvGHuwxdVCWk4Mim5PGtHxlRNk4gDEh0sLb
	v2vX0fCWbXqX94KzgPhP6JhQsL/E+T3cnTZq9OfiXTPBk98Lb05G
X-Gm-Gg: ASbGncvjKzFxBtKbCZDD80wD3Ls4ZGbPLQSxzLiBnHICkLcPyx5BRmDTuVDfzhbbxNi
	ZMt39as3GaPaVB5jevaMpXpzV18QCi9JgEqCpCX5uKn4D/dhP9gA7igG2k+bT7GqtyvEAKQxhL0
	j9r2B8wtzbkohx1CQ3w+ytk3mzbShhpFNeR247Gy4O4mw0dbMtR4HTzb486AP8dlzXxK9jeyWxS
	cKI/73CaxHPigl+93iyTRUGblp6AszP84WzbhM8l8OphKVeeTS39lnsbu1M6IMk0g7myeNbczBi
	IOrug25WaKqvmOozY3aB4vR/JOPvCC37h4S7HoYpCw==
X-Google-Smtp-Source: AGHT+IHy0jV4YgMxOHksPhxh53RpeJAZ/E8UFT1rKsUGw11pv+I+0YyJ9AE3+lffwugInqcy6tb7uA==
X-Received: by 2002:a17:90b:4ad0:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-30aac19d49bmr3325171a91.10.1746594549416;
        Tue, 06 May 2025 22:09:09 -0700 (PDT)
Received: from gmail.com ([98.97.36.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e61f3ad8asm7010665ad.211.2025.05.06.22.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 22:09:08 -0700 (PDT)
Date: Tue, 6 May 2025 22:08:35 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH bpf-next v4 1/2] bpf, sockmap: Introduce tracing
 capability for sockmap
Message-ID: <20250507050835.4seu6rz35v2uqret@gmail.com>
References: <20250506025131.136929-1-jiayuan.chen@linux.dev>
 <b776fa07-de4b-44be-ae68-8bc8c362ea81@linux.dev>
 <9c311d9944fa57cec75e06cde94496d782fe4980@linux.dev>
 <CAADnVQKK87UV9rH_YviePfUmOO3mGXQmYfN-Q9Ax5AYv+xE8zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKK87UV9rH_YviePfUmOO3mGXQmYfN-Q9Ax5AYv+xE8zw@mail.gmail.com>

On 2025-05-06 20:43:43, Alexei Starovoitov wrote:
> On Tue, May 6, 2025 at 8:37 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >
> > May 7, 2025 at 04:24, "Martin KaFai Lau" <martin.lau@linux.dev> wrote:
> >
> > >
> > > On 5/5/25 7:51 PM, Jiayuan Chen wrote:
> > >
> > > >
> > > > Sockmap has the same high-performance forwarding capability as XDP, but
> > > >
> > > >  operates at Layer 7.
> > > >
> > > >  Introduce tracing capability for sockmap, to trace the execution results
> > > >
> > > >  of BPF programs without modifying the programs themselves, similar to
> > > >
> > > >  the existing trace_xdp_redirect{_map}.
> > > >
> > >
> > > There were advancements in bpf tracing since the trace_xdp_xxx additions.
> > >
> > > Have you considered the fexit bpf prog and why it is not sufficient ?
> > >
> >
> > 1.This patchset prints a large amount of information (e.g. inode ID, etc.),
> > some of which require kernel-internal helpers to access. These helpers are
> > not currently available as kfuncs, making it difficult to implement
> > equivalent functionality with fentry/fexit.

If the data is useful and can't be read normally having kfuncs/etc to
get the data makes a lot of sense to me. Then it would be useful for
everyone presumably.

> >
> > 2. skb->_sk_redir implicitly stores both a redir action and the socket address
> > in a single field. Decoding this structure in fentry/fexit would require
> > duplicating kernel-internal logic in BPF programs. This creates maintenance
> > risks, as any future changes to the kernel's internal representation would
> > necessitate corresponding updates to the BPF programs.

If its needed we could build BPF code somewhere that decoded these
correctly for all kernels.

> >
> > 3. Similar to the debate between using built-in tracepoints vs kprobes/fentry,
> > each approach has its tradeoffs. The key advantage of a built-in tracepoint is
> > seamless integration with existing tools like perf and bpftrace, which natively
> > support tracepoint-based tracing. For example, simply executing
> > 'perf trace -e 'sockmap:*' ./producer' could provide sufficient visibility
> > without custom BPF programs.

We could likely teach bpftrace a new syntax if we care?

bpftrace -e 'skmsg:sendmsg: { @[socket, pid] = count_bytes(); }'

might be interesting.


> Similar to Martin I don't buy these excuses.
> For your own debugging you can write bpftrace prog that will
> print exact same stats and numbers without adding any kernel code.
> 
> We add tracepoints when they're in the path that is hard to get to
> with tracing tools. Like functions are partially inlined.
> Here it's not the case.
> You want to add a tracepoint right after your own bpf prog
> finished. All these debugging could have been part of your
> skmsg program.

I tend to agree. We've on our side found it extremely useful to have
DEBUG infra in our BPF codes and easy ways to turn it off/on. 
If this DEBUG is in your BPF program and you have the pretty printers
to read it yuo can get lots of specifics about your paticular program
logic that can't be put in the tracepoint.

Thanks,
John

> 
> pw-bot: cr

