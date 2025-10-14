Return-Path: <bpf+bounces-70943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5916EBDBB8C
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C46423AED
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACBA2C1599;
	Tue, 14 Oct 2025 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqT2XILz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CE4438B
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483081; cv=none; b=o4V8S1UP7admSKi56e0bkQxnKnX6qppMX4gXa22QG7CqU7jExOjkmssWWliZx2/RTRhGLiW0PdjyTqEe4NEZhvMM0/l2wC9nVXwvJUQUnAeQF+e250yinlwQ+ohRaYb+mFaqokW7UFL++/U49NVSvS1EYNvMI8U4D5SFcP8VGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483081; c=relaxed/simple;
	bh=/gaJR8hM7fS+7Stl9MPt3DNcP/y33WBsW/aXjuiJE/s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HtHA7X+XX+nzhCJ47wlA6dIbQTx6j8TaXNKnnX0EP2d5UebumdnYr3xAyZS5YI+MgZMlZc1xXS4W81RggqhjLP697VjsFPHJagSBQ00jm2dkdsWtN3CRk09EsdEpzo+5KvjeERC5uJpOLQouTP5ogeaKcLOkuqjfa3eWd/19qDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqT2XILz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D97C4CEE7;
	Tue, 14 Oct 2025 23:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760483080;
	bh=/gaJR8hM7fS+7Stl9MPt3DNcP/y33WBsW/aXjuiJE/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lqT2XILzj9dTANRzWhDkd7rZFNiQ6qYzkHP3moesTPlO21Z7SuPxVX79kaTsw9MTG
	 Q9ygy56FcHvZzcFrx9NBdGvaXGvUdU9cPwkbgcflPjV3kpuTla9XvdVaEcDAYqpQBq
	 EXmAvJBrbNVdCy1cdNUxbsbxPjnJ/ZFqx/aA4lsJ1t90GLQhRW7TSJ8+fEmKtdJrkW
	 mJsSaxoH04oqeMlwcuSZPnHsBm2s+ZsQ3L4duvSGZodRP8+jtkC3eaM7qZ1XQEmuKn
	 fZ9e1Zvd+N5nj0/WgpVOTTJVNUr62PBxFEfp6Bn++xsQPUUDbwDf2XyDXETrnfjWIM
	 6wLhToh4kDhvA==
Date: Wed, 15 Oct 2025 08:04:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Thierry Treyer <ttreyer@meta.com>, Yonghong Song
 <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Quentin Monnet
 <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, David Faust
 <david.faust@oracle.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
Message-Id: <20251015080432.8d883079d9904a1f32dc150d@kernel.org>
In-Reply-To: <6a3dfd7d-00de-4215-9bdb-f6ffab899730@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
	<CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
	<b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
	<CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
	<aO45ZjLlUM0O5NAe@krava>
	<6a3dfd7d-00de-4215-9bdb-f6ffab899730@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 15:55:53 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> On 14/10/2025 12:52, Jiri Olsa wrote:
> > On Mon, Oct 13, 2025 at 05:12:45PM -0700, Alexei Starovoitov wrote:
> >> On Mon, Oct 13, 2025 at 12:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>>
> >>>
> >>> I was trying to avoid being specific about inlines since the same
> >>> approach works for function sites with optimized-out parameters and they
> >>> could be easily added to the representation (and probably should be in a
> >>> future version of this series). Another "extra" source of info
> >>> potentially is the (non per-cpu) global variables that Stephen sent
> >>> patches for a while back and the feeling was it was too big to add to
> >>> vmlinux BTF proper.
> >>>
> >>> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
> >>
> >> aux is too abstract and doesn't convey any meaning.
> >> How about "BTF.func_info" ? It will cover inlined and optimized funcs.
> >>
> >> Thinking more about reuse of struct btf_type for these...
> >> After sleeping on it it feels a bit awkward today, since if they're
> >> types they suppose to be in one table with other types,
> >> searchable and so on, but we actually don't want them there.
> >> btf_find_*() isn't fast and people are trying to optimize it.
> >> Also if we teach the kernel to use these loc-s they probably
> >> should be in a separate table.
> >>
> >> global non per-cpu vars fit into current BTF's datasec concept,
> >> so they can be another kernel module with a different name.
> >>
> >> I guess one can argue that LOCSEC is similar to DATASEC.
> >> Both need their own search tables separate from the main type table.
> >>
> >>>
> >>>> The partially inlined functions were the biggest footgun so far.
> >>>> Missing fully inlined is painful, but it's not a footgun.
> >>>> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
> >>>> user space is not enough. It's great and, probably, can be supported,
> >>>> but the kernel should use this "BTF.inline_info" as well to
> >>>> preserve "backward compatibility" for functions that were
> >>>> not-inlined in an older kernel and got partially inlined in a new kernel.
> >>>>
> >>>
> >>> That would be great; we'd need to teach the kernel to handle multi-split
> >>> BTF but I would hope that wouldn't be too tricky.
> >>>
> >>>> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
> >>>> make a lot of sense, but since libbpf has to attach a bunch
> >>>> of regular kprobes it seems to me the kernel support is more appropriate
> >>>> for the whole thing.
> >>>
> >>> I'm happy with either a userspace or kernel-based approach; the main aim
> >>> is to provide this functionality in as straightforward a form as
> >>> possible to tracers/libbpf. I have to confess I didn't follow the whole
> >>> kprobe multi progress, but at one stage that was more kprobe-based
> >>> right? Would there be any value in exploring a flavour of kprobe-multi
> >>> that didn't use fprobe and might work for this sort of use case? As you
> >>> say if we had that keeping a user-space based approach might be more
> >>> attractive as an option.
> >>
> >> Agree.
> >>
> >> Jiri,
> >> how hard would it be to make multi-kprobe work on arbitrary IPs ?
> > 
> > multi-kprobe uses fprobe which uses ftrace/fgraph fast api to attach,
> > but it can do that only on the entry of ftrace-able functions which
> > have nop5 hooks at the entry
> > 
> > attaching anywhere else requires standard kprobe and the attach time
> > (and execution time) will be bad
> > 
> > would be great if inlined functions kept the nop5/fentry hooks ;-)
> > but that's probably not that simple
> >
> 
> Yeah, if it was doable - and with metadata about inline sites it
> certainly _seems_ possible - it does seem to work against the reason we
> inline stuff (saving overheads). Steve mentioned this as a possibility
> at GNU cauldron too if I remember, so worth discussing of course!

IMHO, it may be hard to insert nop (actually it is mcount call) to the
inlined function, because the inlined function code is optimized with
the caller code. In this case, it is hard to find where is the original
entry code. For example, a specific entry code can be skipped even if
a part of its body is used. Thus we need to put mcount calls for each
(but there can be a code which calls both entry and the body).

But if we can work with compilers, since it knows how it optimizes the
code, it may be possible.

> 
> I was thinking about something simpler to be honest; a flavour of kprobe
> multi that used kprobes under the hood in kernel to be suitable for
> inline sites without any tweaking of the sites. So there is a kprobe
> performance penalty if you're tracing, but none otherwise.

It is possible if we can find the actual entry points. Of course using
kprobes means it will take a time (overhead) to insert the sw
breakpoints and to sync the code.

Thank you,

> 
> Thanks!
> 
> Alan


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

