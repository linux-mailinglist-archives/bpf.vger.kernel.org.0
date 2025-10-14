Return-Path: <bpf+bounces-70899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765CBD91F5
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85AE54156B
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 11:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4F3101C1;
	Tue, 14 Oct 2025 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXeNG+mU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F5030E849
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442733; cv=none; b=T+s/tA9BDnuVajaU6IzLbTnis2TZKIAYNeeBHF4GXi1nJ8IFPxxyOy0IJA8A3x4eJgwvCA2kJ0bSOXZvkQBUdJpeUedkTbF+bQY+un37/pRzH461aIHIsnEXGSuP3vw2dzeuFmMRNtoPFKdNs+OZJNhJxzz8KdEb7pH50yikV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442733; c=relaxed/simple;
	bh=KXD6lIQwVkLd7ZcK6ILaDshE1SsxFvKHZfXlcPfWtyg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee1SfBu0w0YTFEAhX7xkTDfc/fdTQ9i2MpqgmhhAym+4dDV1r/B/OBBm7W4gDxR64zB2UuNm3priPs3yWBr9YEpdTgESue8EHf7eH6FhftsPS4jkwe6gIYmDAlAHKmqlcXkF48ww6vgcuFmWJU08LMEB5EwkOAetUkaRJR2ephY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXeNG+mU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-634b774f135so8355772a12.2
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760442730; x=1761047530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jfnFB6tlrkef7QWh+7DYSXqb+k34xK9HrotTFeuXFxk=;
        b=FXeNG+mUopagfRT7gLQdkYBgVfnvClrIpmsg7K4a5BM8/JT0qGCbMNjtdTp7k+5AXd
         Bwnd5HKzrR0vfbrhxGUhZCIxRR2n7gYU0uIgjP081V3y3T1jS/9oazFRshYrIZ7fgl+P
         QU6pIHrNrD10yNjXS+25IZOdcJ5fHx5UHanKEG9ZomIiV56c1XsifuhvFxyyQdOYHv6e
         lkcuXvuWI8oJWrAWm2YDyXm7fwlyYvSto2Lp8Hbg8O2XV9zE5MJH0OzWszmNqMrPcX/1
         GTrwM7827qQN9C4CwjTBJJ53cr9db+feNaJjFCm5EniyIWhrLdcg2HXAtuulw2de8/Va
         Ik3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442730; x=1761047530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfnFB6tlrkef7QWh+7DYSXqb+k34xK9HrotTFeuXFxk=;
        b=xEhLypMjWPzc5NF7t5NJCWPpGWsMGjteBPteazj1J/uBOtr20QK95QKeMIbnb6Xqop
         GGhcumMtV6dyu8wM30I7pnpFOEpIzww57SjtEPprShN87px10N9RbMZI5c7F2wJXvjAZ
         7dZ1prA6u+x7/52Xy1Ab3f+uaX/y6/6m/uEWwHn7ijN1BM/p9VpZhTFAxAUoxBQIRVB0
         2daqyI2kgFPS7N/pUrrkHuG7TFt/h8VjDPev81jGx3hUMuEbmBWYA/hp4eFOF3ONKj5E
         +G+5AM0tU3kdN9pOgaB7Xg0K6pwEsEOYAOBZ0m5aa6pwkhA/Yu/iOPSydiKKQNoKouLq
         hSVA==
X-Forwarded-Encrypted: i=1; AJvYcCX51xraLdbb0jTz4Ompop2YTZgl3ODcxpJvu4GHn/85RsCnd6qyaeNQtQEgBK4eap9fDyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GgcR2CxBArIAekuGAHu0B6gTMc5moxlEX+d8mzRO+1UAUUFt
	V9nHwNHUgMUm2hqbaFFv0itdUcJFAkB+xJCvzV2lrEXy3EGDbYey3kme
X-Gm-Gg: ASbGncsPacGhpJvE0dtU2ebUDdjXpEq3lVy6AwqN/fOoO6oC/S5ayJc1Rl6nNARzZYJ
	QcWEdHO7qZ+lg4r5n+tVxhBKV/x/OykIqWyf0V1ZlzHH+5TRLw0fv8midNoFyOBYslv9Z09QKl7
	ZMB3+mEqyY+Vsg50m0jqsGQ+9ke0V0jFfLqI5OeLRydffN05WXb7mUaAKKak1LTNldwLHtursH3
	78c+9ku1sjlPQ4dJEcKorw1DBOTv4Y6L31elHxO46Cae4odu1L9OKwpE68EouJ9SvA6DcpettIy
	rqJQmzTjIZcGl6iHU0cajzfUC+skY2EuCglhXlP/Hx0wb1fdKtLDBpme3Mv5k3POnbnoQ4rN9PQ
	UCNNHJ4tEwyYZoNo=
X-Google-Smtp-Source: AGHT+IGfuM+b+VLTgr7jcPhwZCW7g9vur9iezaNzNEsypu7zUGa/aWX9OrN/j6v75hNefKHiQVvKhA==
X-Received: by 2002:a17:907:9621:b0:b49:86ac:9004 with SMTP id a640c23a62f3a-b50ac7e7a34mr2854019566b.48.1760442729166;
        Tue, 14 Oct 2025 04:52:09 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d69dbd99sm1133813766b.40.2025.10.14.04.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:52:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Oct 2025 13:52:06 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
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
Message-ID: <aO45ZjLlUM0O5NAe@krava>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
 <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>

On Mon, Oct 13, 2025 at 05:12:45PM -0700, Alexei Starovoitov wrote:
> On Mon, Oct 13, 2025 at 12:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> >
> > I was trying to avoid being specific about inlines since the same
> > approach works for function sites with optimized-out parameters and they
> > could be easily added to the representation (and probably should be in a
> > future version of this series). Another "extra" source of info
> > potentially is the (non per-cpu) global variables that Stephen sent
> > patches for a while back and the feeling was it was too big to add to
> > vmlinux BTF proper.
> >
> > But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
> 
> aux is too abstract and doesn't convey any meaning.
> How about "BTF.func_info" ? It will cover inlined and optimized funcs.
> 
> Thinking more about reuse of struct btf_type for these...
> After sleeping on it it feels a bit awkward today, since if they're
> types they suppose to be in one table with other types,
> searchable and so on, but we actually don't want them there.
> btf_find_*() isn't fast and people are trying to optimize it.
> Also if we teach the kernel to use these loc-s they probably
> should be in a separate table.
> 
> global non per-cpu vars fit into current BTF's datasec concept,
> so they can be another kernel module with a different name.
> 
> I guess one can argue that LOCSEC is similar to DATASEC.
> Both need their own search tables separate from the main type table.
> 
> >
> > > The partially inlined functions were the biggest footgun so far.
> > > Missing fully inlined is painful, but it's not a footgun.
> > > So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
> > > user space is not enough. It's great and, probably, can be supported,
> > > but the kernel should use this "BTF.inline_info" as well to
> > > preserve "backward compatibility" for functions that were
> > > not-inlined in an older kernel and got partially inlined in a new kernel.
> > >
> >
> > That would be great; we'd need to teach the kernel to handle multi-split
> > BTF but I would hope that wouldn't be too tricky.
> >
> > > If we could use kprobe-multi then usdt-like bpf_loc_arg() would
> > > make a lot of sense, but since libbpf has to attach a bunch
> > > of regular kprobes it seems to me the kernel support is more appropriate
> > > for the whole thing.
> >
> > I'm happy with either a userspace or kernel-based approach; the main aim
> > is to provide this functionality in as straightforward a form as
> > possible to tracers/libbpf. I have to confess I didn't follow the whole
> > kprobe multi progress, but at one stage that was more kprobe-based
> > right? Would there be any value in exploring a flavour of kprobe-multi
> > that didn't use fprobe and might work for this sort of use case? As you
> > say if we had that keeping a user-space based approach might be more
> > attractive as an option.
> 
> Agree.
> 
> Jiri,
> how hard would it be to make multi-kprobe work on arbitrary IPs ?

multi-kprobe uses fprobe which uses ftrace/fgraph fast api to attach,
but it can do that only on the entry of ftrace-able functions which
have nop5 hooks at the entry

attaching anywhere else requires standard kprobe and the attach time
(and execution time) will be bad

would be great if inlined functions kept the nop5/fentry hooks ;-)
but that's probably not that simple

jirka

