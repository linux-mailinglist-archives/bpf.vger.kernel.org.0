Return-Path: <bpf+bounces-22033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96985550A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 22:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B8C1F29A66
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1313F00F;
	Wed, 14 Feb 2024 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNmCXzOL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284A813EFE8
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946942; cv=none; b=DGx2En8QqZdCHNJ/uv5z7v3NzSUhn2vCVB2v0iPrfcqpKOMKBRB/DsrTfLcWpF3s6EKak0NlY+vWLk3vVXqCVTAVYNv3aUwWkpJfbbigzdTu55oDIcD/VZHTGbDZlVR8pm45epA8H6xvKQRHcVIMPCn1Z0AEcMjdkqLRm2HXGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946942; c=relaxed/simple;
	bh=3c2GIuuOcUIlF/1ZcnXuHB65jZ0swkmR0K4YPD0mw0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dubfytPD46W7+WhRRCbM2RktWk/XicMND7NUSJaYlU2TnSuv/6blsV1JUm+uS0/06LnGforTez0O7Ot6jF98a92MpUz20CsqLNy3yeWB94ZAgmu8oUiQVCQRgL1iYb/92W2SGu4F6UFXpyZIZA5LC8GTuC2w7kjyDpOF4DS5nps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNmCXzOL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1db35934648so7225ad.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707946941; x=1708551741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSPUubyM84iE4if7k7+oIKp95nXKMAdaOOfobzF3zB0=;
        b=lNmCXzOL9h32nuJ4HssXpVPH4FG5EV/LM1ZVL8NTeHRz2OFYc+KHqZwcbiHEhQTfJB
         rkjb5eFNkTzYNHBhrgkQr1PHDfh+VX56oxdyEXZWIOtZPWBkaAWnGHCQ5McVX5l0lA3f
         RFkVX43CvrhFNmNAXyvR5f/WD8Le8awfEkOOhGIp3xxdFCQ4s06QgmFllHqBh633o9P2
         9Fnws4A7Rh5poQ5oM7IAzsJbi43jQLELap3+Kb1NvayDuU4FqYCNau/lsQWosxV5iO42
         erFsoVU4mNHydYvyuZ47dAOUdomPBWxTZODIHRTww14eL2nr91Gx3q200iMMIfTxtqD/
         fwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946941; x=1708551741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSPUubyM84iE4if7k7+oIKp95nXKMAdaOOfobzF3zB0=;
        b=eWtLNljiakicdaBAqYjkOU3WNngvWRaddDtPfNoVHo7NjkGeh87kLTjtbkV1w35l6m
         uIl8pSry2iApH/JcDtFakxNNrFSAHpMgF0ZANS01dwml62URz/l+NLfJuSyYBc9QbCPT
         SVdydcoPs6rwyFJkR13Yq3U5E4DgSVpKLFOh5AphmL+9OExFb0vj6VoY5y98oOs1jHHM
         aJKE1/9PFF1ncUqcodPYv3tyPd6HeUfPJr0ildojZrmDzxIbfHwdWSoLs2VdD0zzNgxS
         rOW4BiEbsQGMokUPEy9iAs81k4y/Xbl03zDPwjWez6snJUpoARCHvzXChOIijVVhhfnV
         e9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbQFdtDUqMWY8VJ9Ialxlrhp6SAGiLFAfYmZXxt8sfkX/D3sXWxYXohPoYcg/JFEPCyz2bihleBQRQYuLoDdpepV3N
X-Gm-Message-State: AOJu0YzG68bnQKQxZpDkjQdVJBpyDCCtDoI990Tt/MIRWbBgfR1v/XS7
	lW3O9JJ59PGRoxehVw4J6HdD5YBnX4cxkKF6ceX3/f/KIFcTv05XtxPl4if0XyP2gVYsL1LF18q
	smMejN4wykWFBJ3nUwmjVnQICAUwnFsiJIHWK
X-Google-Smtp-Source: AGHT+IFs8GCOC1Z1vNjMOHZlsyycKXE6lDJY0f+bDQxt7tw86T7dQdf0yTj1R5o+IbfIUHdOmfrLkolaVuy4fv1aNEY=
X-Received: by 2002:a17:902:7b94:b0:1d8:d90d:c9ae with SMTP id
 w20-20020a1709027b9400b001d8d90dc9aemr335917pll.1.1707946940434; Wed, 14 Feb
 2024 13:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-3-irogers@google.com>
 <Zcz3iSt5k3_74O4J@x1> <CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com>
 <CAP-5=fXb95JmfGygEKNhjqBMDAQdkQPcTE-gR0MNaDvHw=c-qQ@mail.gmail.com> <CAP-5=fWweUBP_-SHfoADswizMER6axNw89JyG7Fo_qiC883fNw@mail.gmail.com>
In-Reply-To: <CAP-5=fWweUBP_-SHfoADswizMER6axNw89JyG7Fo_qiC883fNw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 13:42:09 -0800
Message-ID: <CAP-5=fUP-Ss1UNKWUwzSpWAO1trCdXNMkey1gYnpZPODn+Gn-Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] perf trace: Ignore thread hashing in summary
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 1:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 14, 2024 at 1:15=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Feb 14, 2024 at 10:27=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Wed, Feb 14, 2024 at 9:25=E2=80=AFAM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 13, 2024 at 10:37:04PM -0800, Ian Rogers wrote:
> > > > > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > > > > threads") made the iteration of thread tids unordered. The perf t=
race
> > > > > --summary output sorts and prints each hash bucket, rather than a=
ll
> > > > > threads globally. Change this behavior by turn all threads into a
> > > > > list, sort the list by number of trace events then by tids, final=
ly
> > > > > print the list. This also allows the rbtree in threads to be not
> > > > > accessed outside of machine.
> > > >
> > > > Can you please provide a refresh of the output that is changed by y=
our patch?
> > >
> > > Hmm.. looks like perf trace record has broken and doesn't produce
> > > output in newer perfs. It works on 6.5 and so a bisect is necessary.
> >
> > Bisect result:
> > ```
> > 9925495d96efc14d885ba66c5696f664fe0e663c is the first bad commit
> > commit 9925495d96efc14d885ba66c5696f664fe0e663c
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Thu Sep 14 14:19:45 2023 -0700
> >
> >    perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
> > ...
> > https://lore.kernel.org/r/20230914211948.814999-3-irogers@google.com
> > ```
> >
> > Now to do the bisect with BUILD_BPF_SKEL=3D1 on each make.
>
> This looks better (how could I be at fault :-) ):
> ```
> 1836480429d173c01664a633b61e525b13d41a2a is the first bad commit
> commit 1836480429d173c01664a633b61e525b13d41a2a
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Aug 16 13:53:26 2023 -0300
>
>    perf bpf_skel augmented_raw_syscalls: Cap the socklen parameter
> using &=3D sizeof(saddr)
> ...
>    Cc: Adrian Hunter <adrian.hunter@intel.com>
>    Cc: Ian Rogers <irogers@google.com>
>    Cc: Jiri Olsa <jolsa@kernel.org>
>    Cc: Namhyung Kim <namhyung@kernel.org>
>    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ```
> No LKML link.

Hmm.. basically that change fixed the BPF program to verify and so the
problem has been long standing with the BPF code. Maybe perf trace
record never worked with BPF.

Thanks,
Ian

