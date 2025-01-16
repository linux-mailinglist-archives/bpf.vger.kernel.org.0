Return-Path: <bpf+bounces-49127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A3A14517
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8176A188B8A5
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975A22CBDA;
	Thu, 16 Jan 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFHSUe/A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C21DD0DC;
	Thu, 16 Jan 2025 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068736; cv=none; b=ecqVKjOwNQdQCf9GcvI2LcAd0NoEQdyYTwl4hbhxmMUmOCEyzplfggYSJk7LPFPjuTpwAqtCnyEFQd4ujnke+7mvTxI4Tk+FY58I1JXLW1zHTR3I7NXBIbNd1yDzN0dt8E5AoVOPR9PDTyXfiG+v5GK71HBOgjwGgaMeln+jzx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068736; c=relaxed/simple;
	bh=I3Ct52PeAz/1s9Qra43gWoNiKkkvOv9YIZlqhPN47iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrBUnIuzZ9XI5iQ7qpNw4Tk6h4w/c4UEfNNdEjGFn/U1DmqxIR0k5EmmgtbEkvG41wka4nDPRAEw1sN+netO2i5PPwcNtsQiB+mP+YxQQbPqcvvrJDqQaNxGhIC/KlcXQxt9HbX3G+jyxHUh4N8wukm855isHszWKuh0YXC6r0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFHSUe/A; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso2099940a91.0;
        Thu, 16 Jan 2025 15:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737068734; x=1737673534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaDYoeZitqBrufGRdiB4RB+j23wLRVs6RCMwk4dcOb8=;
        b=RFHSUe/AWis6mq2pSJmB+wuiwL2R0u/s6u+NH5FIXuEfZ4luIp2YjJhFnE1OC46e2N
         YbIRhVX2kNG7INs70QYhh/D/kzdETDgqGaDggGyl2oOukaNZDpG6Ob1aooQyM7p5XwB+
         isRITQaPsWzhgKe7gsaqOi4BBEGMCCuqcK4HATr0yNP8sYVyD09mGC0msU/ZH6LPtg9q
         RaiXMCN/LxT7V6rW/go6Y6m3+ACqCvAJV7S2nmcJVAEO0DbFJzeFJS/xHJAKmB1/m1XV
         7jftUbAckrmSCkBkoEY/bUO/LhDOdqKr4G4XevR1yYVtk/WR3nWd8zD6ndY+w0F1hhXL
         hAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737068734; x=1737673534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaDYoeZitqBrufGRdiB4RB+j23wLRVs6RCMwk4dcOb8=;
        b=gS8AI3Yu3lT+lTUJ5y/hLbwSzVkOv6P52mIsk3dhtUASP97LF5WrqLVyPbPc/5yV9+
         SyzJ3FaVP3fE6u6R7QMzlCmXCpIIfZmbCxjgihV7r3TUwtfWCAhpEgD+B2WHfcMERLSi
         wTF+YWpG08OiIyYb0X5SXnaUvVueLGH5UGTqS5fqfEx2j12puX8c1Ybo6xjy3KqXvkbO
         BPebbmD4xKZksLopDIzi94k1SKcaV4KNa/nlBo/IKf4p59bp2f7KvKuENvis62j2rTpE
         9+99lmFLhdjiIuBoQSFgGhrA9eJ2LDDIy6tjMtQ6IK8P2Ib3n5mpoTONy2acUPaaThUG
         AevA==
X-Forwarded-Encrypted: i=1; AJvYcCVb2KoWMkc+iIYCu9QyhQ8GfAll34A6SC1jG//7osgGjxo3600VFr/X8/new897PUAAlY8=@vger.kernel.org, AJvYcCW1KgIMHMM3hGrOEWhiQ24vmRx/bWfoQTuUl3LKO5q8Dj6WatgDqKUk8iA0hX3XNK+25fXV7AL+@vger.kernel.org
X-Gm-Message-State: AOJu0YyYwx0NTaaG/sLccoM2GUwUTakQHjfkGczudUgkZJChqoT/2q1b
	ga4cwGeAtigYkoStfMgNEsTyoKI+0xVgV2uLzgN1Frj8k92e/mFPsJpgC7HNSgKZyq4P17HeYSN
	/CKfOXCOHUplJzj/4olRUqcdF35Y=
X-Gm-Gg: ASbGncurA9rdoP4BW2NCCHmm3Q4Ja9/ZCJiOR/SJhSB6io3KSlHLYfPUNLvpgYpNUX2
	oDGslpFS0s8cTXeHJm4ywC7GBN+4y+guvJIBC
X-Google-Smtp-Source: AGHT+IGAZSi0P2wj4w1YlPZ9Jx4Rs4/BvTFAJTgVDIdsGNOOacJKptloSppK84bQU1SfXt8IFK6pTbL58I/pMYNv6fQ=
X-Received: by 2002:a17:90b:3a08:b0:2ea:2a8d:dd2a with SMTP id
 98e67ed59e1d1-2f782d2e9bbmr513744a91.27.1737068734555; Thu, 16 Jan 2025
 15:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112064513.883-1-laoar.shao@gmail.com> <CAEf4BzZcs6YP067-KJYQRsMJMLooypepq8iiX7wXu7CZwVhD3g@mail.gmail.com>
 <CALOAHbAXyLy6gcRLwtF9rz8v5hcpx5ua4En25sst3pgUu0K=xA@mail.gmail.com>
In-Reply-To: <CALOAHbAXyLy6gcRLwtF9rz8v5hcpx5ua4En25sst3pgUu0K=xA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Jan 2025 15:05:22 -0800
X-Gm-Features: AbW1kvZ5JPyNnXPV3pJCSy4StXrN7raHp8mbWxmg6dq3MS51w5lLb0hJZj2Xib8
Message-ID: <CAEf4BzYVjLo4J=ZbNqYqVJL4Ntkc+vbJa1X1NEs4uvLBxWa3fQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] libbpf: Add support for dynamic tracepoints
To: Yafang Shao <laoar.shao@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, edumazet@google.com, dxu@dxuuu.xyz, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 7:13=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Jan 15, 2025 at 6:32=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Jan 11, 2025 at 10:45=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > >
> > > The primary goal of this change is to enable tracing of inlined kerne=
l
> > > functions with BPF programs.
> > >
> > > Dynamic tracepoints can be created using tools like perf-probe, debug=
fs, or
> > > similar utilities. For example:
> > >
> > >   $ perf probe -a 'tcp_listendrop sk'
> > >   $ ls /sys/kernel/debug/tracing/events/probe/tcp_listendrop/
> > >   enable  filter  format  hist  id  trigger
> > >
> > > Here, tcp_listendrop() is an example of an inlined kernel function.
> > >
> > > While these dynamic tracepoints are functional, they cannot be easily
> > > attached to BPF programs. For instance, attempting to use them with
> > > bpftrace results in the following error:
> > >
> > >   $ bpftrace -l 'tracepoint:probe:*'
> > >   tracepoint:probe:tcp_listendrop
> > >
> > >   $ bpftrace -e 'tracepoint:probe:tcp_listendrop {print(comm)}'
> > >   Attaching 1 probe...
> > >   ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
> > >   ERROR: Error attaching probe: tracepoint:probe:tcp_listendrop
> > >
> > > The issue lies in how these dynamic tracepoints are implemented: desp=
ite
> > > being exposed as tracepoints, they remain kprobe events internally. A=
s a
> > > result, loading them as a tracepoint program fails. Instead, they mus=
t be
> > > loaded as kprobe programs.
> > >
> > > This change introduces support for such use cases in libbpf by adding=
 a
> > > new section: SEC("kprobe/SUBSYSTEM/PROBE")
> > >
> > > - Future work
> > >   Extend support for dynamic tracepoints in bpftrace.
> >
> > Seems like the primary motivation is bpftrace support, so let's start
> > there.
>
> I believe we should extend support for this feature in BCC as well.
> Since this is a common and widely applicable feature, wouldn't it make
> sense to include it directly in libbpf?
>
> > I'm hesitant to include this in libbpf right now. The whole
> > SEC("kprobe") that calls "attach_tracepoint()" underneath makes me
> > uncomfortable.
>
> I reused the bpf_program__attach_tracepoint() function, but if we
> examine its implementation closely, we can see that it actually
> creates a DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts); rather
> than a bpf_tracepoint_opts.
>
> If naming is a significant concern, it wouldn=E2=80=99t be difficult to
> reimplement the same logic with a more appropriate name, such as
> attach_kprobe_based_tracepoint().

"kprobe based tracepoint" is exactly the thing that makes me unwilling
to include it right now. Let's put this on hold for a little bit and
see how bpftrace users use it first, we can always add something to
libbpf later.

>
> >
> > You can still attach to such dynamic probe today with pure libbpf
> > (e.g., if bpftrace needs to do this, for example) by creating
> > perf_event FD from tracefs' id, and then using
> > bpf_program__attach_perf_event_opts() to attach to it. It will be on
> > the user to use either tracepoint or kprobe BPF program for such
> > attachment.
>
> You're right=E2=80=94we can manually attach it in the tools, but if we ca=
n
> make it auto-attachable in libbpf, why not take advantage of that and
> simplify the process?
>
>
> >
> > Yes, this doesn't work "declaratively" with a nice SEC("...") syntax,
> > but at least it's doable programmatically, and that's what matters for
> > bpftrace.
>
>
> --
> Regards
> Yafang

