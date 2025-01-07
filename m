Return-Path: <bpf+bounces-48043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6824BA03549
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 03:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987213A3C21
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 02:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C8417B401;
	Tue,  7 Jan 2025 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqCQ9eqr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E31607B7;
	Tue,  7 Jan 2025 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217745; cv=none; b=XsOTpEaAwvtiI3ndP7HZn0VY2sYhS/iVSq9yPX8LQk5uOgKCuOTFLqZMScYaQX8QaqdAZivEbszf1e66TgcKhRhfZyggpMKk4N7EoiqP2oBNrzd8TDiiV/Ox8sAn/9TM/OZzfDTEKqnyyplHAFEa1NrvbDGJWmY+spXA7n89Mcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217745; c=relaxed/simple;
	bh=HAVWPZcqx3hWwS/w31a3qyuVF7RHxPLpvdQgPAGYUrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSoLlzB88kRBDGxLe9nkG6d7BSAJR1UE3nxS+yGsrXzfnazelpXqeJ3KTEPRHj0pWVCPiI96vahGFBu2DzY7VO2V+tCQTGxlUw2AYwSEp6Ea29uuGYlfcQ9gaAI+rIq4SyNF7QjJMHevk0LSXYizFg/erDTw33jY7iWTm5ZdEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqCQ9eqr; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd1b895541so123758446d6.0;
        Mon, 06 Jan 2025 18:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736217743; x=1736822543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq7easgvkA7Ji/NytoCVtO+yohd/iRvIMntE9SiMUis=;
        b=BqCQ9eqrsMijkYMZRsqGSsBISvoTnTn4yIUkLwDmoQiu4oPkIxSkftn2evLXPK1ypL
         RRSMKK3hp9ZZ4NPIQGZvq9Df4TCVBMIStliqe/eIn2T87f4SWb8rJl7dl08dnVVvQfdn
         eo5La97Ev11G06XMc77TXN1G7sTZ3BXoFEAOmHqE6MgyAPVQdLJ0eAdRXUCt1TxcycHD
         xyOrDIgN1Nqo4hAdF6iynPVJ4SgG8/RIDvD7T1OoZvRvd/oNuBErlKiGFq4yhQkckx2z
         xgKR3px+DroS0T9gi9UeHiN2K0Ftl3EXtS6jOrXMEngTNgrI8PimQOWQmoJd2dJHSDAg
         PRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736217743; x=1736822543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq7easgvkA7Ji/NytoCVtO+yohd/iRvIMntE9SiMUis=;
        b=w3sJz3717TjmyK00K8JVbZAsoU6I057YuBjhJ3puG62bNCbZyYbgzVdiscmqEYhS+Q
         PHO3RHjpCjfIQsySqb3O54S9/gKv8AQmUBvCXoGElPXV/RMZbtQwhqWrV5Dt3ykmC/Zj
         eWW1MkkAgQi9MrHQzMmNK/CYUZNSrUenLgt5VCYd6YQLU59hbB/ES/gXUXjJJ4Qysb43
         ZjKtYcFQqX+xISKasIK6Qq+p32NFXOqupPFFib5JPPvpf8Gwkv1ICaFNqFSsBJysmk0d
         o16zG9mGSzaI2jIw9eoXXWSVfkVaLwdKVj4ZBckJqAS1SoeVoFxYZjcThtRSUSHxMB3T
         U+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUG53teLkzYD7SQpt2k4PwH13Ei3YkgpbOPoxwtdd7e762a3Gx026Kwe+uWxk0CEDCLE4hdeIBf@vger.kernel.org, AJvYcCVUS7O63Mi/Gi3mxF47pVq1J8/j3HMIfxNhLIx4YloWFAxIQAetYqZI6kN1dyklGHHpFKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KgVT3+6kYvkAM7XSBE7mdIcG04kLLtN0xrXM+ltlq3uik525
	jihl7CYzE4GRLsZiOQpqLS50LTii2LeMJinqr8nnSejy7wsJiHvEe9yKdRhqI08sLogZ68bjT3+
	KwMCxklQfMMgHXhFsv/Am8bQbwfE=
X-Gm-Gg: ASbGncs/22kwVqWJDiMyMHQjnDsSwRMZO+owPQ0ZqGDjr0S9Ryoa3un5JbjM3GEwfCO
	12qc/ffEFivSkF+a82yiXw4Aj8bc2t2jjtxGhRQ==
X-Google-Smtp-Source: AGHT+IHIVO6xC+J8LCnizPq+6behDDgawyaO8but+UtYe0w2fp6EW9qeg97Oeg4hDQiK2ErzYMOsaAuRdEEjf7fH59I=
X-Received: by 2002:a05:6214:8116:b0:6dd:d513:6124 with SMTP id
 6a1803df08f44-6ddd51361f5mr101996026d6.35.1736217742740; Mon, 06 Jan 2025
 18:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105124403.991-1-laoar.shao@gmail.com> <20250105124403.991-2-laoar.shao@gmail.com>
 <CAADnVQ+ga1ir9XCDxPiU_-eYzKHTQsiod9Sz4_o3XeqGW2rq4A@mail.gmail.com>
 <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com> <CAADnVQ+Cbq99wpNoijyJbvtqaMTAxQF_S-n8yf9+0JGHJnShLw@mail.gmail.com>
In-Reply-To: <CAADnVQ+Cbq99wpNoijyJbvtqaMTAxQF_S-n8yf9+0JGHJnShLw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Jan 2025 10:41:46 +0800
X-Gm-Features: AbW1kvZaAe1ugDyUQlmmVmRtZ2yzW32XDu34ZHIDH5o2BI_yzXx6R7f0ga5VgcE
Message-ID: <CALOAHbBxDnwkXXouYRiZcRPAic4k+JE5St7yJA8Fyrd9sw1ntw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add support for dynamic tracepoint
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 6:33=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Jan 5, 2025 at 6:32=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Mon, Jan 6, 2025 at 8:16=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sun, Jan 5, 2025 at 4:44=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > Dynamic tracepoints can be created using debugfs. For example:
> > > >
> > > >    echo 'p:myprobe kernel_clone args' >> /sys/kernel/debug/tracing/=
kprobe_events
> > > >
> > > > This command creates a new tracepoint under debugfs:
> > > >
> > > >   $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
> > > >   enable  filter  format  hist  id  trigger
> > > >
> > > > Although this dynamic tracepoint appears as a tracepoint, it is int=
ernally
> > > > implemented as a kprobe. However, it must be attached as a tracepoi=
nt to
> > > > function correctly in certain contexts.
> > >
> > > Nack.
> > > There are multiple mechanisms to create kprobe/tp via text interfaces=
.
> > > We're not going to mix them with the programmatic libbpf api.
> >
> > It appears that bpftrace still lacks support for adding a kprobe/tp
> > and then attaching to it directly. Is that correct?
>
> what do you mean?

Take the inlined kernel function tcp_listendrop() as an example:

$ perf probe -a 'tcp_listendrop sk'
Added new events:
  probe:tcp_listendrop (on tcp_listendrop with sk)
  probe:tcp_listendrop (on tcp_listendrop with sk)
  probe:tcp_listendrop (on tcp_listendrop with sk)
  probe:tcp_listendrop (on tcp_listendrop with sk)
  probe:tcp_listendrop (on tcp_listendrop with sk)
  probe:tcp_listendrop (on tcp_listendrop with sk)
  probe:tcp_listendrop (on tcp_listendrop with sk)
  probe:tcp_listendrop (on tcp_listendrop with sk)

You can now use it in all perf tools, such as:

        perf record -e probe:tcp_listendrop -aR sleep 1

Similarly, we can also use bpftrace to trace inlined kernel functions.
For example:

- add a dynamic tracepoint
  $ bpftrace probe -a 'tcp_listendrop sk'

- trace the dynamic tracepoint
  $ bpftrace probe -e 'probe:tcp_listendrop {print(args->sk)}'

> bpftrace supports both kprobe attaching and tp too.

The dynamic tracepoint is not supported yet.

>
> > What do you think about introducing this mechanism into bpftrace? With
> > such a feature, we could easily attach to inlined kernel functions
> > using bpftrace.
>
> Attaching to inlined funcs also sort-of works. It relies on dwarf,
> and there is work in progress to add a special section to vmlinux
> to annotate inlined sites, so it can work without dwarf.

What=E2=80=99s the benefit of doing this? Why not simply read the DWARF
information directly from vmlinux?

$ readelf -S /boot/vmlinux  | grep debug_info
  [63] .debug_info       PROGBITS         0000000000000000  03e2bc20

The DWARF information embedded in vmlinux makes it straightforward to
trace inlined functions without requiring any kernel modifications.
This approach allows all existing kernel releases to immediately take
advantage of the functionality, eliminating the need for kernel
recompilation or patching.


--
Regards
Yafang

