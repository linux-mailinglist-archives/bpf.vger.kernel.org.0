Return-Path: <bpf+bounces-71000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E2BDEF45
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A50189FED0
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378525949A;
	Wed, 15 Oct 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu1DiAwM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82552205E2F
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537845; cv=none; b=s8cFwup6L7LrLzpTeVHSbSFUKdbI6tulUTxx81KWVwXMuQwaiWPAPmufc5xK3MKr9fh7CqEytWQNaG9vkjtMwcGHzeEWnPCFTcRxouZYRqO9J85TWjIH6VObkfUOUNw3RI1zuj8uWn0Ot3OGIC0u7nUxTKck8jDlGp59NzDLY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537845; c=relaxed/simple;
	bh=PMPgjaM4tai1aH3RrEPvEhgN2mlK6u4/6DtXqiPaths=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM8AFqn6ethChusXPm5TJdiA7rOG72V6gjEoySQWNlFkEno6a0/Mpfd8HmNL11vejFDMRRIXWKVWua1FGjiN1T+ZjFXXtDSSoOB3uRNroXiyP3whS639he7724PXHHVWx1xGGXuf3qZUHqWZN7wacWDedwDDwrX0vJZhiU/Rr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu1DiAwM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b4f323cf89bso1196595666b.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537842; x=1761142642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pR4zRJs6D7uKpxqX7s0BAvh2cnecIUAOMCtEFFIOH70=;
        b=Xu1DiAwMoJ6VRPuaSqh92AxKNTJu/jIpGjAphmG+6deq1x7b2D7mphI+AAH8irVfbw
         2mRe7FsSdOsw1enjwGZBSRdoNJjuySGHPmElmomWp5lvHKeKPun8za6JMsUorqPrtko9
         lsL0W3adgsdlSP76w7ohhXIvyWLd4vPrZ7SF0VbcsI6nGETcjuer5XgrlSI1L7O/OBya
         ObJw2tMB46keCii9s70yoJ39M8Nd2q5wotclfhfyDNisHiPTJxrEwugx1sZbkjbtE+bT
         0NCv+9HLS0NQQrIPQ9MjX3U0PB1sFal7Bby006pINklSHjJr77YFTOVBW6XJWgTaxZC+
         /0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537842; x=1761142642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pR4zRJs6D7uKpxqX7s0BAvh2cnecIUAOMCtEFFIOH70=;
        b=SF7OPt4057pBKn0lq9gIkZYw+gRB41Ge7O4rwqJn70OROvMIVVJHzkaNhWis6eaWuz
         BJgQ8lttl+UG63SZKkltqinkkDJHHjz8nYLTxbZZj71Ii+btLnvqzb+4Tp+9DYOcZhcE
         G2aTvZ5AdCi8JBsT15lTnK+WTO0nKv/KHavmvQatLsWPipM5ReaaAMgf4vTnmhEbYnZT
         6txJAAdfFQA8i7LkmHdyoOshIFRz3uo+9bSV8sOTKyvxJrvH8YE1JXv6K2wtU0FnV4A7
         t6o6oXVdOYNHv9ISKkhAxOqVEvR+MqWgCmSm3wJkRHV3JSfLBT3v/PghzCLsMnfz7a96
         WQng==
X-Forwarded-Encrypted: i=1; AJvYcCU6RFtab8CIXtKfHRzyr3i4iwIDvJwYQSOPdgwnE4rbvRdxHcAEz0bx2dUlXwihKhuuJJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4ioLpPWWnyf9zZMGQVX+adRNnrQldaMsS8/8cKStz395tYfH
	DTrYmDL1QnwWH5dZlgMEL90nPnYfGLbuU5Fed6jxW+XN6mWktwvtgAjd
X-Gm-Gg: ASbGncta7f7b6qeGanBH0u/3im4/pJYQ970IRlbBQASvivohz0n9xNRnikJCxRO/xNQ
	ygGdFVaXKXbbScB+ik6li0oy5gUkXcVHBVbyhcoyIjlzAbJm7JSE6ssoS9OBpJPMkIX+yxRQkUb
	6v1UUM1JF5U8gQam8ibg1LRTKg3/hOkWmq878vAIsu8ZC/eorrD9NrlHLdZck9ig3lAgzkZe73Y
	YsogBO236a11rXwLkPZdylD9qQ3QpZCe6hsjauo4bT5S7kwMEib/8zd7McdI8NuueqiQTn6whIp
	EiivXhVfucGc78KhIliZ617fbzwC4ePyD2hF3EJbZlCkk8KajBOQfNaLFWko/RXnWhGGizqCPFh
	ur547R37KSzOTvYpl27ooVSbwK4m+3Njbf94xhvCy
X-Google-Smtp-Source: AGHT+IEg8evgXEvgVB8TMjd2Jcb4HDR/qE4VXC+23ha7vInJk55WwPoZ9gmeErGGrCvzZGOQZWjmSw==
X-Received: by 2002:a17:907:2da3:b0:b46:11fc:c9c9 with SMTP id a640c23a62f3a-b50abaacf2emr2612626366b.42.1760537841358;
        Wed, 15 Oct 2025 07:17:21 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd6b95bdsm237091266b.79.2025.10.15.07.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:17:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Oct 2025 16:17:19 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thierry Treyer <ttreyer@meta.com>,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Quentin Monnet <qmo@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	David Faust <david.faust@oracle.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
Message-ID: <aO-s74SN8YDqoEWQ@krava>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
 <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
 <aO45ZjLlUM0O5NAe@krava>
 <6a3dfd7d-00de-4215-9bdb-f6ffab899730@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a3dfd7d-00de-4215-9bdb-f6ffab899730@oracle.com>

On Tue, Oct 14, 2025 at 03:55:53PM +0100, Alan Maguire wrote:
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
> 
> I was thinking about something simpler to be honest; a flavour of kprobe
> multi that used kprobes under the hood in kernel to be suitable for
> inline sites without any tweaking of the sites. So there is a kprobe
> performance penalty if you're tracing, but none otherwise.

so you mean we'd still use kprobe_multi api and its code would use fprobe
for ftrace-able functions and standard kprobe for the rest?

jirka

