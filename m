Return-Path: <bpf+bounces-39651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D392C975BAC
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 22:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B8F284062
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA61BB6B1;
	Wed, 11 Sep 2024 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnIfha+4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004701BB68A;
	Wed, 11 Sep 2024 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086117; cv=none; b=SFGpGLUdBLBrvcE8C47e1R5wIioERi/uG/c6nnvqIsIMrmvEyjrKej2Eba/0rj2nyPLhVQwPCFxnmA1DB3uG1tiC3PBXPSEG/VPsHw4OnkYvJ2+3DRdZ99qaHud7h2jToA1dQadKEO+z2Nmpzk8Ih19SdhYiKONOyIdyPVnHYZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086117; c=relaxed/simple;
	bh=oIRAfl1TX560+5DKNTCG1XiBZP1UaC1FZo1lt4Bil2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efcvkVc5Lp+bETPAV6k7Lhwumt3vin+C7+hy5Ko9bRqqvYedC0CSi2T+DawJ5Oa5OBounDFFBeRso5JtZsu992Tjlzk1XU/Y7hj5t9QwBQ0j6CAy8Mood973v5NDc8lzTfW8PsYLJyZJyuMVEddbswZphKtU+zG9k2QW+UlJrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnIfha+4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso154961a91.2;
        Wed, 11 Sep 2024 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726086115; x=1726690915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbmDeYH8hlHZXpV1hqninsp0SrO6x00Sy+YTR4btEiI=;
        b=nnIfha+4BBiv4rwEQbPm2I8nrEhBthdjgJx5CmGdZtWNMgCvpErug6ZBQnUAqUWlGh
         bJm4bynmo33Bs4N+WIRump1zQlsuzg05ygZvhmpmN1eXhGqkU/Fy++kZanb6QK2kYMHo
         EBXfD/DnUXY/x3fcqFFedaturf6KxsGOngWdU6axnvLW+ChE2B9Vmr/ox19W8I0AeTjp
         HOn6MSMCU99MyMbFXB07wwSve3NHiIiz5HlPDMDFzchfGytIbqXt7pCstdKfM6tcXMB/
         NdLCzxMROG83IsP75lyNx6afQ9PdyW8SDYWPgCMnudT9ZJEiEFMCimEXw11/DPdznX4b
         UvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086115; x=1726690915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbmDeYH8hlHZXpV1hqninsp0SrO6x00Sy+YTR4btEiI=;
        b=GfEDpp6vvosE+lu7RNmiPSZKGMEOfgaQyVw4ukLLOqYYpzd3pAVSRI1XmvwYdakd1C
         cjzXn0fLkyDLrbG45JVciE/t9uEtYpDbEeO25G+x3Tam1sB6j2+gse2ZTBRZNA/dJj+Q
         Pce7JxfkDsD5jrj0zjKUStTI3kATJZPUG2BYHMs2nb4z6XpJhAucfZO5IeETLWeF1x4S
         SEKFWkjeR7zKvfaQ4t07V8/uVKkM2RRsfPAASx86NFCFVaQQBI2RuYDNAnyJh2tj4l8v
         eKSE7/cLe3+82mnbWgeVrxFBUNITwts28Wd1pzNn5WVcQP03lPhnBAKXzG+fH915uIWD
         xgxw==
X-Forwarded-Encrypted: i=1; AJvYcCUbq26OzM1siVgGrCJnVIV7m+9CIiyCp62P0QJzzLx1pn9QTxybplTgznNI63l7gdvgGj2Tu8LoeuDT+7LYqBP4AOD8@vger.kernel.org, AJvYcCV11ZgVWotz2Mi+boohweXd6nKJxduqZRv1GzwyOKFX6FFCRWwEF1HAAZcL6YtezE7mZQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kBevslaanNmlmqDconavQgZtOY74ddS9zvlIpgiAmsizVvfI
	8vI40GY8rJ0J0qqi4tDa/eMdIeNayQoDBjDGuKuQmljR9QRDgWzBHoXGQBWihh/SszpW4AdVXIe
	VwdmKnDd3tYYUDeh7305s8Rg1G8c=
X-Google-Smtp-Source: AGHT+IE84IX9l+YfKcAPP0w7Ossgfiuhs05P87eHw2dON8mIN2Mm3ijgY/MisiuOZMmmoE5B5FUUoYB3ZjMFhK9YME0=
X-Received: by 2002:a17:90b:4c12:b0:2d8:6f73:55a with SMTP id
 98e67ed59e1d1-2dba0048735mr385897a91.25.1726086115213; Wed, 11 Sep 2024
 13:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
 <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
 <20240910145431.20e9d2e5@gandalf.local.home> <CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
 <20240911093949.40e65804d0e517a1fa1cba11@kernel.org> <CAEf4BzY2_HN36Lvy9p2s57tGet3ft_1oT6d690vwu4JMgOd9XA@mail.gmail.com>
 <20240912002647.1000516bf87198b343bafcf7@kernel.org>
In-Reply-To: <20240912002647.1000516bf87198b343bafcf7@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 13:21:43 -0700
Message-ID: <CAEf4BzZtX_R-7W-EfjEn1aFcvQNtW0xajmEeEV_4ECQz3qe4nw@mail.gmail.com>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Florent Revest <revest@chromium.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 8:26=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 10 Sep 2024 17:44:11 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Tue, Sep 10, 2024 at 5:39=E2=80=AFPM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Tue, 10 Sep 2024 13:29:57 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > You are probably talking about [0]. But I was asking about [1], i.e=
.,
> > > > adding HAVE_RETHOOK support to ARM64. Despite all your emotions abo=
ve,
> > > > can I still get a meaningful answer as for why that wasn't landed a=
nd
> > > > what prevents it from landing right now before Masami's 20-patch
> > > > series lands?
> > >
> > > As I replied to your last email, Mark discovered that [1] is incorrec=
t.
> > >  From the bpf perspective, it may be fine that struct pt_regs is miss=
ing
> > >  some architecture-specific registers, but from an API perspective,
> > >  it is a problem.
> > >
> > > Actually kretprobes on arm64 still does not do it correctly, but I al=
so
> > > know most of users does not care. So currently I keep it as it is. Bu=
t
> > > after fixing this issue on fprobe. I would like to update kretprobe s=
o
> > > that it will use sw-breakpoint to handle it. It will increase the ove=
rhead
> > > of kretprobe, but it should be replaced by fprobe at that moment.
> >
> > Ok, given kretprobes already have this issue, can we add this support
> > for BPF multi-kprobe/kretprobe only? We can have an extra Kconfig
> > option or whatever necessary. It's sad that we don't have entire
> > feature just because a few registers can't be set (and I bet no BPF
> > users ever reads those registers from pt_regs). It's not the first,
> > nor last case where pt_regs isn't complete (e.g., tracepoints set only
> > a few fields in pt_regs, the rest are zero; and that's fine).
>
> pt_regs things are asked by PeterZ. It is not recommended to use pt_regs
> if it is not actual pt_regs because user expects it works as full pt_regs=
.

Yes, but it is what it is today. Tracepoints, for example, have like 4
fields set to real values and the rest are zeroes. So sure, as
complete data as possible is best, but the reality is different.

My point is, the feature being available with one or two pt_regs
fields not having a real value set is *much* better than no feature
availability. There is just no comparison here. And you said yourself,
current kretprobe implementation has similar problems, so nothing is
regressed.

> So I and Steve decided to use ftrace_regs for this faked registers.
> (I think tracepoint should also use ftrace_regs or another one.)
>
> Anyway, we're almost at a goal we can all agree on. I think we would bett=
er
> push fprobe on fgraph series instead of such ad-hoc change.

I really hope you are right, but you see yourself that there are all
the small things that pop up and need debugging, fixing,
investigation. Performance regression is pretty noticeable. So this
might take more time than all of us would like.

>
> Thank you,
>
> >
> > >
> > > Thank you,
> > >
> > > >
> > > >   [0] https://lore.kernel.org/linux-trace-kernel/172398527264.29342=
6.2050093948411376857.stgit@devnote2/
> > > >   [1] https://lore.kernel.org/bpf/164338038439.2429999.175648436254=
00931820.stgit@devnote2/
> > > >
> > > > >
> > > > > Again, just letting you know.
> > > > >
> > > > > -- Steve
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

