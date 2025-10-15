Return-Path: <bpf+bounces-71034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F14BE033C
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 20:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38153A8A91
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550C224DD0E;
	Wed, 15 Oct 2025 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6vC2OM0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699F325480
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553335; cv=none; b=tSzEOKN1F7kW7xVGS3opRwXcYtmOfsZaivYJ/qLf4UQJpPeJ4cn/SLDX6lb3yCRJhok954Os/nUFnYfiio2bgoWBVOVw+aABf0tiMBBUxPhqSIKLusTTRBfhVWDQioQsFjtVG5sQRfgilz5NeX+cL8/rYr/kkeRZWhaRbDl2c4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553335; c=relaxed/simple;
	bh=dZoFZHPm//JNTwS/F+Wm1bTY8FKtC4cSEnJlR6fXqn8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE2rbmPyWdy2WdkWT0dlaRLZjqQZf6ZskGkfoZ1adZIeuqgIoL8AbWlT6H2Cq6OCJvacz7JxxSJmCEkrtXcnC/uExEEi3jWpDg4VzoOf5YmccMFEeF/C9HePNVrWAil+uegUQA4rUlrLSOqpk12dWVbn7ytyy/5orOtLHK4myn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6vC2OM0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-639fb035066so10744538a12.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 11:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760553332; x=1761158132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6K6BWz1miNH3tNhkMkrJPIGanQ7GeLNVVRC0WUagL8s=;
        b=g6vC2OM0XxUfcdWYFEy1H/nuazYgPYy3T5REPR+dH4zEA57v9USkV7glD/GpN7x0jC
         E/EzxDiBr6j7UbVH8hYF3We1YrST+6l0zpbFG5mS+YSpaIHG87Z07lobQKoBIEINjj0Y
         JMU8ORzeZikyEr9F4pT76I5DPPEVprmUIaG0jLkJtw3JtsqP5J7Lx3dCkUg1OZxCFk3h
         iXbPVFQfmv4gKFcR13kp1YgP/x3WCPDq35IQ2EVIEoejatqIfmlGAXhaRfZSYa8aSI9A
         GNXM+3JaMaQ/fVCxYja2MTudLExIIdc99v/Td+ukk3JO9r7mVXGmz38Br9Pu6jqtP1eA
         Mucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553332; x=1761158132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6K6BWz1miNH3tNhkMkrJPIGanQ7GeLNVVRC0WUagL8s=;
        b=KZbv6puyQB+R09SecfKbkOurm40bkhHlwL5sAOkRWVa1YKVVGIPO98xDIFsVv33Wch
         c5gsV5yH3wwi6JXPr5BBpXr0/FFVDhb+JZ+QPZSPzsMheL5aRcL/n7zngM2u/J3+uSxr
         8+vEBq4PorCAAz8UQbP7gYJD3yEgWpsy7WTzxQWONZPN+xborCn2+4UgXBwYJ+kHbXtx
         DT8Fs7qFt43tKdh/h+hGUyeR5YOhf7aomNqGi9LLaI5lbRo/N+4aFNT/fCndQYFCJF6O
         bBXq0QsUyC1LnT8vwXRdfpq4Kkxkb/K3nzY2/TpBBypYAYfae5dtKs1Quov4ID0K/xd8
         yNeA==
X-Forwarded-Encrypted: i=1; AJvYcCUf8TbbhGwdJ0/wmwiheTV5zTop4sPV1bS6CwottoxdTVHZTOnGIzXllsYWn0+uwvec+gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjskFGDZuloVEGrUmBYjrS5oZfYH2tzFtAcKwVhZ/CbFHxDFaQ
	4FufO6OpqZp1AEZS4rKYEaxijcBaxtid9XuCjRWNqMSCUi+VEPEub1tF
X-Gm-Gg: ASbGncuO2mmhRgS80arc1h2e33DtrTzscrYXCLRm7ALMbDs/MWOj0jLiKlHB0pcq9fw
	FdjcVuz8Kl+R7ptK8bamK0SYyNGesiKt2EEiDj5WD6oagG0PsDQSXJ+CcegGwGwvQe18EjbVm1j
	DqBgJeMzUUuDY1TV1VnuRcfH7SEC6zTX8NmMizEvshFh8nKcaoy28BFIfNKvlBJRcB2oo5MS9nq
	FVKtOJCMFbgEDAUFMBaL9sCN1cuY8XnQ5aZKuiSMB6M+e6YM01BsWgquXkB4HxC0gR/QbdbEZLa
	gUo+C6kCqlKIL8wbSNTdDc//ws5AXYeKZ0ARz1vTQObQs2iYPry1vVj5Glm6xOlMaF8pDd5MZxX
	InQM/rat8xytQAhhT+MuRE2VJCKa8X+3sgfdCaIhgMLb7wnL/7rE=
X-Google-Smtp-Source: AGHT+IH2fHHwhnPyVBi2UTA780f+rY83tuI7SN/GXy3KL83ZvHUN5IpI2A9kO29Lj/nXfjx1LXZuHA==
X-Received: by 2002:a17:906:c105:b0:b47:de64:df1d with SMTP id a640c23a62f3a-b50aa48c4c4mr2980187566b.13.1760553331887;
        Wed, 15 Oct 2025 11:35:31 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb965c4dasm290861866b.9.2025.10.15.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:35:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Oct 2025 20:35:30 +0200
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
Message-ID: <aO_pciIZnL_xdJQJ@krava>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
 <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
 <aO45ZjLlUM0O5NAe@krava>
 <6a3dfd7d-00de-4215-9bdb-f6ffab899730@oracle.com>
 <aO-s74SN8YDqoEWQ@krava>
 <5fdfb3f8-8acb-405e-8171-bc57fca71210@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fdfb3f8-8acb-405e-8171-bc57fca71210@oracle.com>

On Wed, Oct 15, 2025 at 04:19:29PM +0100, Alan Maguire wrote:
> On 15/10/2025 15:17, Jiri Olsa wrote:
> > On Tue, Oct 14, 2025 at 03:55:53PM +0100, Alan Maguire wrote:
> >> On 14/10/2025 12:52, Jiri Olsa wrote:
> >>> On Mon, Oct 13, 2025 at 05:12:45PM -0700, Alexei Starovoitov wrote:
> >>>> On Mon, Oct 13, 2025 at 12:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>>>>
> >>>>>
> >>>>> I was trying to avoid being specific about inlines since the same
> >>>>> approach works for function sites with optimized-out parameters and they
> >>>>> could be easily added to the representation (and probably should be in a
> >>>>> future version of this series). Another "extra" source of info
> >>>>> potentially is the (non per-cpu) global variables that Stephen sent
> >>>>> patches for a while back and the feeling was it was too big to add to
> >>>>> vmlinux BTF proper.
> >>>>>
> >>>>> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
> >>>>
> >>>> aux is too abstract and doesn't convey any meaning.
> >>>> How about "BTF.func_info" ? It will cover inlined and optimized funcs.
> >>>>
> >>>> Thinking more about reuse of struct btf_type for these...
> >>>> After sleeping on it it feels a bit awkward today, since if they're
> >>>> types they suppose to be in one table with other types,
> >>>> searchable and so on, but we actually don't want them there.
> >>>> btf_find_*() isn't fast and people are trying to optimize it.
> >>>> Also if we teach the kernel to use these loc-s they probably
> >>>> should be in a separate table.
> >>>>
> >>>> global non per-cpu vars fit into current BTF's datasec concept,
> >>>> so they can be another kernel module with a different name.
> >>>>
> >>>> I guess one can argue that LOCSEC is similar to DATASEC.
> >>>> Both need their own search tables separate from the main type table.
> >>>>
> >>>>>
> >>>>>> The partially inlined functions were the biggest footgun so far.
> >>>>>> Missing fully inlined is painful, but it's not a footgun.
> >>>>>> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
> >>>>>> user space is not enough. It's great and, probably, can be supported,
> >>>>>> but the kernel should use this "BTF.inline_info" as well to
> >>>>>> preserve "backward compatibility" for functions that were
> >>>>>> not-inlined in an older kernel and got partially inlined in a new kernel.
> >>>>>>
> >>>>>
> >>>>> That would be great; we'd need to teach the kernel to handle multi-split
> >>>>> BTF but I would hope that wouldn't be too tricky.
> >>>>>
> >>>>>> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
> >>>>>> make a lot of sense, but since libbpf has to attach a bunch
> >>>>>> of regular kprobes it seems to me the kernel support is more appropriate
> >>>>>> for the whole thing.
> >>>>>
> >>>>> I'm happy with either a userspace or kernel-based approach; the main aim
> >>>>> is to provide this functionality in as straightforward a form as
> >>>>> possible to tracers/libbpf. I have to confess I didn't follow the whole
> >>>>> kprobe multi progress, but at one stage that was more kprobe-based
> >>>>> right? Would there be any value in exploring a flavour of kprobe-multi
> >>>>> that didn't use fprobe and might work for this sort of use case? As you
> >>>>> say if we had that keeping a user-space based approach might be more
> >>>>> attractive as an option.
> >>>>
> >>>> Agree.
> >>>>
> >>>> Jiri,
> >>>> how hard would it be to make multi-kprobe work on arbitrary IPs ?
> >>>
> >>> multi-kprobe uses fprobe which uses ftrace/fgraph fast api to attach,
> >>> but it can do that only on the entry of ftrace-able functions which
> >>> have nop5 hooks at the entry
> >>>
> >>> attaching anywhere else requires standard kprobe and the attach time
> >>> (and execution time) will be bad
> >>>
> >>> would be great if inlined functions kept the nop5/fentry hooks ;-)
> >>> but that's probably not that simple
> >>>
> >>
> >> Yeah, if it was doable - and with metadata about inline sites it
> >> certainly _seems_ possible - it does seem to work against the reason we
> >> inline stuff (saving overheads). Steve mentioned this as a possibility
> >> at GNU cauldron too if I remember, so worth discussing of course!
> >>
> >> I was thinking about something simpler to be honest; a flavour of kprobe
> >> multi that used kprobes under the hood in kernel to be suitable for
> >> inline sites without any tweaking of the sites. So there is a kprobe
> >> performance penalty if you're tracing, but none otherwise.
> > 
> > so you mean we'd still use kprobe_multi api and its code would use fprobe
> > for ftrace-able functions and standard kprobe for the rest?
> > 
> > jirka
> 
> Yeah, if possible. For the kernel inline sites we'd be dealing in raw
> addresses rather than function names so that in itself might be enough
> of a hint that it's not an fprobe site, so I guess it could be framed as
> an extension of kprobe multi to support a mix of fprobe-able and
> non-fprobe-able sites. Not sure how feasible that is though.

that seems doable, kprobe-multi api already supports both symbols and addresses,
and because ftrace keeps track of each ftrace-able function we can tell which
is which via ftrace_location call

looks like there's also register_kprobes call that registers kprobes for multiple
addresses

I wonder what's the standard kprobe attach slowdow nowaday, it was substantial few
years back, will check to have an idea

jirka

