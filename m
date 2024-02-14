Return-Path: <bpf+bounces-22030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8AC85548F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 22:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE991C23AA8
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 21:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095813EFEE;
	Wed, 14 Feb 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfWC7NN+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D190741C71
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945343; cv=none; b=YFPNIieqoWgmaS11s74dUyhnhI/X/xQjWKDuu1vBxYlL1MVZwoeTQUICHxKkkL8jOEVBm6zSkayAi1VNymIHUxAFK2QSNCeYumv9flwfZzbvPj6LFbEyp/WfJRRdCCPXq9w37JFFQAl6jeywQyLnAO43LjqXdxflTmi/loM2ZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945343; c=relaxed/simple;
	bh=F9oKYLh44bvwDgUu2A/DAornn6Az7M/1rM8//1GfUsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jskDsx04utVyYNqvpLp7dH0Y3x7wvMa+9CFo9JnXFgM5yrORXyCOAiJwUYhcZWa3P255tuT4agfQOd6FLODEXcfflBhMgFbAkTyfDsqFy6VoZl9XLn4ZLBOgwnAk+DHLYCgV9VsjyiNCLaf65JAtoh5/OFBXo3lzu5unCJglLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfWC7NN+; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so15411cf.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707945341; x=1708550141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtPYS+AuuZocKBV8MQsQ9n8ruvZkdc3y9Vt/v5r10Go=;
        b=bfWC7NN+E64DVyDhqXIBAFqshBjmiiXEfnsjOpJGgY8cD3ewiUtMOdVSNjCMuqW14T
         q/OvfVbpdLQW9VdwtkDUVlIKn8+04TlyPL8BuR2qslAJajSF2CU2j88oCbGjMyukeS8x
         AOAthsstPPUXOQEYDOXIXIW5U0nPddGJvhWQJswl/8zvaHCeIWfyO1/P8H8Dui81byYz
         vlAUP4hmSbkbPJk53netgDL3RuuOQALSsvi+hDqgMsmiYHQK0ocVZbHDQy2vwipSGTrI
         NWkxstYgj686YNcd2Q6c4l9841Tmh6HoBStqdiscHsGij92OIFoepr5uPtFHczdQwuL8
         Xq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945341; x=1708550141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtPYS+AuuZocKBV8MQsQ9n8ruvZkdc3y9Vt/v5r10Go=;
        b=N+TnXJ2K4DuCirD7hcx+gHsoJawa1LqJEbeizKB02RAqih+PksXhSncQTDehxt701C
         F99jvUk0QmN2UVeLlg6k7w5Ioa7L9c6gJ6I8KXu+Y+0BeSWMBctayYV0ju+TAAR9kTij
         GAT/ldHxBUtviD988DHDJIDIgOqMub9VopwlXxgXjCZvP5mV9dw4f+bmNkkW3aoFStYt
         iG1XMyCTtZxRlh538sDLON6h95oIRQ4IFc1MzAS9NNf7mUOp4sehJZkEmqa3p7VE7HNA
         y50oTSzdewDEYmaepZh3F9Xne3Xp7xqLbWnB/UGV+X8L3iBDgLpcD8gvbbDYS+bbVY24
         q0PA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1mdKyHvDjqFn9FEjQgZ8lUVn8TTVrHp85ZguDkWJQeF9+bkHuogkPK6ZvG1hpRySHphRpqVvq6gUk4nqjTEJzVMY
X-Gm-Message-State: AOJu0YzIa2bRz5tnceNVtDc+hGSN8C1kc7jE/HeGzwCCTPSJYBQaSA7m
	FhdJ9r+cLEIcIty0WO/Y2YB2oMkYzuyqmHZtcxBQSKFD0XLlKk9utcZuNIOBFl+o7OGAsniGwY8
	1cezXAaUaEFH0FuprVxVu5ZQMB2h5JJL4LpXz
X-Google-Smtp-Source: AGHT+IEipjTakTkH6uUdqHEGoQ/AQsh79Py+LRmsAxPdIx46RUJnI91c573VL4Jo7dlUQ0Sjjg38UhtVioJEXHjoSuw=
X-Received: by 2002:a05:622a:1882:b0:42c:501c:ed12 with SMTP id
 v2-20020a05622a188200b0042c501ced12mr495153qtc.4.1707945340646; Wed, 14 Feb
 2024 13:15:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-3-irogers@google.com>
 <Zcz3iSt5k3_74O4J@x1> <CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com>
In-Reply-To: <CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 13:15:27 -0800
Message-ID: <CAP-5=fXb95JmfGygEKNhjqBMDAQdkQPcTE-gR0MNaDvHw=c-qQ@mail.gmail.com>
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

On Wed, Feb 14, 2024 at 10:27=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Feb 14, 2024 at 9:25=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Feb 13, 2024 at 10:37:04PM -0800, Ian Rogers wrote:
> > > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > > threads") made the iteration of thread tids unordered. The perf trace
> > > --summary output sorts and prints each hash bucket, rather than all
> > > threads globally. Change this behavior by turn all threads into a
> > > list, sort the list by number of trace events then by tids, finally
> > > print the list. This also allows the rbtree in threads to be not
> > > accessed outside of machine.
> >
> > Can you please provide a refresh of the output that is changed by your =
patch?
>
> Hmm.. looks like perf trace record has broken and doesn't produce
> output in newer perfs. It works on 6.5 and so a bisect is necessary.

Bisect result:
```
9925495d96efc14d885ba66c5696f664fe0e663c is the first bad commit
commit 9925495d96efc14d885ba66c5696f664fe0e663c
Author: Ian Rogers <irogers@google.com>
Date:   Thu Sep 14 14:19:45 2023 -0700

   perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
...
https://lore.kernel.org/r/20230914211948.814999-3-irogers@google.com
```

Now to do the bisect with BUILD_BPF_SKEL=3D1 on each make.

Thanks,
Ian

