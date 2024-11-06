Return-Path: <bpf+bounces-44134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090AB9BF302
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 17:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C001F21EF9
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EBE205130;
	Wed,  6 Nov 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awcB549r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56145202620;
	Wed,  6 Nov 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909714; cv=none; b=JD7sgadZLkGhw3VQbwpmOPh7T8OT7ncolQ+i8I/nXQ3TgNoRAV32KB37cSJE3ntpHxrt/f5ttL2Vst8oFhnNEgPk6ic0CS+YysGYJKgutdUHFjb8R7xaXv+OXt4gJnt0SBqpt22bXVlQLEkJgEf99jXsYhX92DYAgztO5YOivY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909714; c=relaxed/simple;
	bh=c9tnBYgUOdSrn0I+qBFaOnvVIUWOFf6RdjI3dGuX/ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnDWj2UEAV/63eKoGJIQJWwFCpVFyvh4rHyKHFQwMf1yVjYz7G1au4duG3XDpbkz2rqrwYY2WE5WVLpt+8LCTHLGFPQxj3Vh6GHjYgXsj+J+PQS8qcm3Lde/rmEh2ByjivtbRS9I4KkFLOAtTC+uzgLuVMyfsEgRjk0FK4r1BUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awcB549r; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c6f492d2dso75705005ad.0;
        Wed, 06 Nov 2024 08:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730909713; x=1731514513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuM9FPVYlyiO8dA3+OPrpH3HUSy+nPdZ2IbMvNIALEU=;
        b=awcB549ryZS1EC9M33SPSVgH3jp90nzLbvp+GfC0HWxsZdgYTnCNGYfYDwFo++tJiA
         yeeJAwTB7z75kP5M+alBhpe88PyH8rRAGQnCkNGVMsbs5c+8aVJ4mmCcy5xRp9uHAa4r
         Dfm5UVqVr3thgYYWZrEqWbKEvS0lwWoODPxtqf50b65vGUDH+jW3exdseqm/dwA8AYDC
         G+WzdMpLq04pQ6/5a6tydLO+I2uExdQJ5tbEl7dCmoGkjkFn5+dgZKDUuaN5LQIblOHz
         TGpvGDfO5+m4Co0zMwqT1zBmV0q1ehFCfkRx9DfMr/h2feQYtS1RmZ4IX9NV88nRyGD2
         zubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909713; x=1731514513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuM9FPVYlyiO8dA3+OPrpH3HUSy+nPdZ2IbMvNIALEU=;
        b=pxEwhnF59ANK+rSO60BykvPhXz7rsQzQ5GD+ZcntXmhBGQSezfMrBI9f1sSZWsdVYW
         Eb7c4GDWzjEyC+eD6MEvkZynBvoqikvcOUeLXOmFZGr4y+4XOAcofmzwBWQz6Fw3N5G5
         tps7NN1nj+qOVdzoJ+c8fxoW6GqbZAvAcpuWalSwdoibqcCMv3HvkpTOppB0Y2LU6lFJ
         Z62gjLvMAvXO+H0bnYAy252vf0fehfHW7kmVooI0bYbg3jKYqXJvts+4pNVknPrRks2n
         zf2O6ldbkhHGX32tJN8u8Bp7NqGgzEA8TfgcXYz2OvAeNkZICLShwszo7PimEMxCGtMf
         e5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVEo/NcobFYvk9vlmxl1oZ0FzLXtLxZxz4heOdBQG71rORn8I6RxulSQJ6xmIuWMOfsmSE=@vger.kernel.org, AJvYcCVbBDEVFzOJS7EwLUt32EjkMTye5AuQKF+ZqZfJApOuUTsmdRJRsQgk/EtQevhjuSr+RM/FP0+0lb5MOE17JKijIRPD@vger.kernel.org, AJvYcCWMsZcxqHJhFoy4sP+RAky0LFXivuJlKBtqaGMktSR33vZyWR541xjiLt7CxE5+iPluSRrElE+JF51jW3mE@vger.kernel.org, AJvYcCWQ28n9TG7VVMlZ81UpMfSyfh+BGFOQGgpjCUuLC+1xR5DfQbDh+0UYN5WgETskEk3OxcrfiEXp4kwtPg6Rl0ii9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZj4i8XDY6gEccYWJ9E2WWRNiS3YtD6QBY9yIrJpCSp/TY3xT
	euz2ZS4by3ge6PR/Ebg7+lWOZG8mRxzMVegIj5Krw+XqDSwHG2PUlCIoEsvfZVNZkuTHrzd/DId
	BD7gdXkDmnMjryKJdleMDz6i42rQ=
X-Google-Smtp-Source: AGHT+IGE7as/zhJ/0hEXJE5Nd8KS+oVlK6xJ3ACRVLTTH5+NKKQj62K4Tvc4N/owmW8kKUkfFogKU95TIgG/KpD68IE=
X-Received: by 2002:a17:903:2cd:b0:207:6fd:57d5 with SMTP id
 d9443c01a7336-2111af38936mr255571785ad.36.1730909712511; Wed, 06 Nov 2024
 08:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
 <ZyH_fWNeL3XYNEH1@krava> <CAEf4BzZTTuBdCT2Qe=n7gqhf3yENZwHYUdsrQP9WfaEC4C35rw@mail.gmail.com>
 <20241106104639.GL10375@noisy.programming.kicks-ass.net> <20241106110557.GY33184@noisy.programming.kicks-ass.net>
In-Reply-To: <20241106110557.GY33184@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 08:15:00 -0800
Message-ID: <CAEf4Bzbv_kv11STXafjdO3FsfyMuMNEG-=xWpeTw1cJdMHj+gw@mail.gmail.com>
Subject: Re: The state of uprobes work and logistics
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Liao Chang <liaochang1@huawei.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:06=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Nov 06, 2024 at 11:46:39AM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 05, 2024 at 06:11:07PM -0800, Andrii Nakryiko wrote:
> > > On Wed, Oct 30, 2024 at 2:42=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > On Wed, Oct 16, 2024 at 12:35:21PM -0700, Andrii Nakryiko wrote:
> > > >
> > > > SNIP
> > > >
> > > > >   - Jiri Olsa's uprobe "session" support ([5]). This is less
> > > > > performance focused, but important functionality by itself. But I=
'm
> > > > > calling this out here because the first two patches are pure upro=
be
> > > > > internal changes, and I believe they should go into tip/perf/core=
 to
> > > > > avoid conflicts with the rest of pending uprobe changes.
> > > > >
> > > > > Peter, do you mind applying those two and creating a stable tag f=
or
> > > > > bpf-next to pull? We'll apply the rest of Jiri's series to
> > > > > bpf-next/master.
> > > >
> > > >
> > > > Hi Ingo,
> > > > there's uprobe session support change that already landed in tip tr=
ee,
> > > > but we have bpf related changes that need to go in through bpf-next=
 tree
> > > >
> > > > could you please create the stable tag that we could pull to bpf-ne=
xt/master
> > > > and apply the rest of the uprobe session changes in there?
> > >
> > > Ping. We (BPF) are blocked on this, we can't apply Jiri's uprobe
> > > session series ([0]), until we merge two of his patches that landed
> > > into perf/core. Can we please get a stable tag which we can use to
> > > pull perf/core's patches into bpf-next/master?
> >
> > The whole tip/perf/core should be stable, but let me try and figure out
> > how git tags work.. might as well read a man-page today.
>
> I might have managed to create a perf-core-for-bpf-next tag, but I'm not
> sure I know enough about git to even test it.
>
> Let me know..

Looks good, thank you. I'm merging it into bpf-next, testing, and if
everything looks good I'll apply Jiri's patches on top.

Tag is more so of a promise that everything up to that tag won't be
rebased, otherwise we'll run into tons of problems during the merge
window. That seems to be the case, so I'm proceeding, thank you!

