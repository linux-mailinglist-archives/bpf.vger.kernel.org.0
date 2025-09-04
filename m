Return-Path: <bpf+bounces-67452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E4B43FDF
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 17:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF923B6297
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B989303C9E;
	Thu,  4 Sep 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaLOxh72"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130012D3EC0;
	Thu,  4 Sep 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998131; cv=none; b=FsS1BOAfED/Lr21020RKJuJtJeyoPpJVnj1FaCOjTbOUr/UbZcflLtfcXINfw0zp0auDEjIoeJJ9HVNiiGwfIMdFWcf/XecOqUvpQDy7T5xzDdXZ+qu1ViR3u3V1HCH3n22jMnqQFXS6Q5PavrYfjvsW96yyuZyNX514eO3Zh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998131; c=relaxed/simple;
	bh=WsAaT5z9DTXprMXgadEDAY3E4jgG3J07sJHYyh6BVw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laPZir0K+xE9q+eWs/ADSKJyLfnFpv+aXYAVb8OY2D4V+UfkWjh2S82Khb4l9vy+ri6fSqaIZcq45kHgMsHMJIsb+lcYGc+h/aDv4t5pa3RSsGsG9rz7Lw0mbS4p4e6WW4gcSm0zI3pXTrMotWmE7xE4Kh+QV8+N5XsNvk/2Lg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaLOxh72; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3e2055ce7b3so427521f8f.0;
        Thu, 04 Sep 2025 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756998128; x=1757602928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2ajTeyG2BSzRFwWcOgVNlWU2GcEhvUma3dwfU9D+78=;
        b=FaLOxh72/54hyhLZ4Vvp0g3qhrJyDNdwqjZZ9se3T136mee+OR0RbQfYpu78VjKb92
         IPJ/9i/eHFsErpfss7d5Oj0cOdjb7fvjrqzTRtYkpQHXDbASNAPDmjbrPvxc00drHPE5
         wVUyXTIa9SwOY+F6jgLsirAALhsbBQ6cWl0BeGXvt+PSOH+10jnLcVsQdgpAk92zG7jc
         LzKLmZ0J9nXKZi0xuwfPdj/3V7ws4fZTndpgGZPZAhWpr09JnCtUB/V1tU+RVrbseMoV
         H8oKLIW2RBLq/wjmXLfAe3D2oo5hcp+o1PdaE/qqWCEfmXAK1OXn16SRnbe64DkJvFEq
         la5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998128; x=1757602928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2ajTeyG2BSzRFwWcOgVNlWU2GcEhvUma3dwfU9D+78=;
        b=ZaXv+e5vJnPqzw7t7RbkmKJ+nXahsS+DZnKgah2MzfrU78RwTpi24j76E+1j8i+eKg
         8Hqhb8/u+umJM0G7zvw/O3OSNJ3XBOQ/HQrBFym7NlPXLZ+DHuSmhKgfdI6AECJp+PdL
         Npwrppp9NLa3ys4OYtSUbnyMa9HNStnu0WhV3gHhXMOYFeQWs7ivP53v60Ft8urL5q++
         cKfyJuPizgf5N2gdYvoCjqmoS40aAZbgTrzPirinrU0mv/ssFDS9p+0w3nxZhqOpJCUX
         wYYAnAagNKyg/8RpGHweo4H+TjuHenkBXp5T7hH88xPQLJdwOqpAmbwYfcbgvv3HgjdI
         JLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUifZrFyzcz/hndgnYfOEfFMgH/wLDs76hjd7gJu3HtFEMcK+rpGXJwqw1lRC6xvdLRrns=@vger.kernel.org, AJvYcCWbOh54Ij+EEZ4e3mxty4WDsV9WJHHyKi8VWJfQF5m2QmQryXooPr094EsB4hUkkquwr5pjOhjCw3Cxu39MzDwiInu5@vger.kernel.org, AJvYcCXN9Ha4JtcLAA87zdwnzmhBeg/8912qDSGj5KfQIb5hmRlyrnfNG3SG7dMcN2t9hrmy8cvq5tKrmHqfyNZQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkL07hL83Y18u7dfhg2LW25J9Cu1F8uctUi4kDsEt0YCIwqGq
	Xfo05hiQv1QOYgQZMfHyPR+ib6TBG4DsG5jFLIfan2jXfHuYxHOav9bTuqq1BgePQCfAX0GtoWv
	qhPGnfgajqtRug6Pv5r2f9QT6gIGE+zo=
X-Gm-Gg: ASbGncsoJGCBqNKycb25uZiHQIdb0vvTf5308SuwxA8RZdXIxmbH0yrl7pe9tgJiFy1
	osxyYwYJLc43/vbsZ0l1bEfmRIKvpVbFtWq9bT4flER7IAim/ZiwP7G/ZZwX/3lfiNm8hHI2VVC
	ZfsCaiPrkIhDwCmODbx0NqAvCZLcnRuVFOTFIFDyJtj5Kb9LMv8BbiBSf7fvvJ7qZ98YlJmF7Nn
	hx87D005Ck8q0OG8rVGO+U=
X-Google-Smtp-Source: AGHT+IFkJxBHJsi/qhXBTMrnuJxMrKa9yT7zV/ASPN4AZtBUYPr88vFciqMUlhOtEU6msJtj1095Jt5l4VsOVmKLPPo=
X-Received: by 2002:a05:6000:4013:b0:3b7:94a2:87e8 with SMTP id
 ffacd0b85a97d-3d1dcb75006mr14310626f8f.18.1756998124908; Thu, 04 Sep 2025
 08:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902143504.1224726-1-jolsa@kernel.org> <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com> <aLicCjuqchpm1h5I@krava>
 <20250904084949.GB27255@redhat.com> <aLluB1Qe6Y9B8G_e@krava> <20250904112317.GD27255@redhat.com>
In-Reply-To: <20250904112317.GD27255@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Sep 2025 08:01:53 -0700
X-Gm-Features: Ac12FXzf4RJj6-nnXZ3VoZB1z-JhMD_QU665pLEmSa9O2cuDWoa1D1tma5CQqOQ
Message-ID: <CAADnVQ+DHGc8R0Tdxf7eUj1R0TDGHXLwk5D4i_0==2_rfXGbfw@mail.gmail.com>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 4:26=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 09/04, Jiri Olsa wrote:
> >
> > On Thu, Sep 04, 2025 at 10:49:50AM +0200, Oleg Nesterov wrote:
> > > On 09/03, Jiri Olsa wrote:
> > > >
> > > > On Wed, Sep 03, 2025 at 01:26:48PM +0200, Oleg Nesterov wrote:
> > > > > On 09/02, Jiri Olsa wrote:
> > > > > >
> > > > > > If user decided to take execution elsewhere, it makes little se=
nse
> > > > > > to execute the original instruction, so let's skip it.
> > > > >
> > > > > Exactly.
> > > > >
> > > > > So why do we need all these "is_unique" complications? Only a sin=
gle
> > > > > is_unique/exclusive consumer can change regs->ip, so I guess hand=
le_swbp()
> > > > > can just do
> > > > >
> > > > >         handler_chain(uprobe, regs);
> > > > >         if (instruction_pointer(regs) !=3D bp_vaddr)
> > > > >                 goto out;
> > > >
> > > > hum, that's what I did in rfc [1] but I thought you did not like th=
at [2]
> > > >
> > > > [1] https://lore.kernel.org/bpf/20250801210238.2207429-2-jolsa@kern=
el.org/
> > > > [2] https://lore.kernel.org/bpf/20250802103426.GC31711@redhat.com/
> > > >
> > > > I guess I misunderstood your reply [2], I'd be happy to drop the
> > > > unique/exclusive flag
> > >
> > > Well, but that rfc didn't introduce the exclusive consumers, and I th=
ink
> > > we agree that even with these changes the non-exclusive consumers mus=
t
> > > never change regs->ip?
> >
> > ok, got excited too soon.. so you meant getting rid of is_unique
> > check only for this patch and have just change below..  but keep
> > the unique/exclusive flag from patch#1
>
> Yes, this is what I meant,
>
> > IIUC Andrii would remove the unique flag completely?
>
> Lets wait for Andrii...

Not Andrii, but I see only negatives in this extra flag.
It doesn't add any safety or guardrails.
No need to pollute uapi with pointless flags.

