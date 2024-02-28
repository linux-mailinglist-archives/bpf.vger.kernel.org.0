Return-Path: <bpf+bounces-22918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D437986B8BA
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756511F277CF
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74035E09C;
	Wed, 28 Feb 2024 20:02:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87CB5E08F;
	Wed, 28 Feb 2024 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150529; cv=none; b=HShJgyh5zo3wo9SAdqtaikyCsKXKe5CeQDGggwJYUNXVWLvlT0tX5nE5nLNohD4oUNTj9EN52CDkMmMwYTdzwTd5qusapH3u9SEd6FOyop/iPJcljDhPz95rWl/Mo9I57O+02yFfIbduCo47qKjU9GRQ6sj5jy8BT1S8nqtR9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150529; c=relaxed/simple;
	bh=6z3iaZGWB2lz9LZAf2X3JKVFfalTQYnhr0AVzFbzCAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrJakuCAJ5TUUPgRYrQCzb1DWicBYCjw1R5YShKpW9V60ZIYSTwwgbADAbTkMCUh3tg4NUX3kn928/wXA25OuymAvHVcqzcFGXREQ0jQ98Ki78/QAoeWCwchjZEip2rpYcNaNqG6YkhDM/u+ejW9G2YhgFu/KqQeFGy3Om3AGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29a61872f4eso43831a91.2;
        Wed, 28 Feb 2024 12:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709150527; x=1709755327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6koe4WNO4Ri3MEZtZKFzHROV4MgMQpn964cZ/2nP/Qk=;
        b=V34DmFkdXdFTtoze9gGQo/wha6JgiNbQEaeD6jfCHEr1KoUuNidNzZuQT8Qi8tM5sy
         atPQQI9E6shfYEzfr52r6dXkAqcMyWE3mZGgL4sDs90k/Dh3ZyNOGhBrNUtWaYfffPDE
         8kp+Jb7JFa8/2NiTRpur68d7Do5meC1PiPr2XTYnt0IKPQ7Xe28qMEw1NVLLRLZvMFuW
         Yd+xLHIbEZ0LMeo31B4GTZfk3lk6uZgvQaOziWXJ0EHpBV+G7oD0HQzJkSOfkgRYyX/3
         IDqb2fe6phPYPb5cdCvNxyJquHNnHAkP4e2YZzV2c0liqqjRWlJIUFUgY72+oAemS6Cg
         Wnww==
X-Forwarded-Encrypted: i=1; AJvYcCXSzoL4Xxyd1wOe5lgN6JjmFFsQ7S5+hIStxz9yUsAuzswJ3em7L5MwZNlh51HJ8hNNOHn7AIcDPy3QxZ9wF/F+YRYCGBDEEiAlPnU/THOX+99flheURKmYJ95Sz9kKSsXMTBzF6v9q3CEZhpnTcyaXsory8QzBBxA2Aq6UbH34FwZ7jA==
X-Gm-Message-State: AOJu0YwQZkEbxdjw/IJF4It2jxIVDuaSEUxk5VFVej2NTJ5E6hIA0wfD
	AUtWZnQEFh+QswQ904Vp8Pzku7OV6TQZMaUJZz1nsDxMET1br72qZsGJK3wLbpINr+9YrPn46Ch
	V28hvP8szgsAAMX6/mXfkWRJrPzg=
X-Google-Smtp-Source: AGHT+IELmYQumUyc0rX3Df8LExfX3oUvUqiAdziX5lbpiDA9MT3P6e7at/2wYzhQVt7D6/YafjxfiOVEuRGgM57WOSo=
X-Received: by 2002:a17:90b:1010:b0:299:bb08:e83a with SMTP id
 gm16-20020a17090b101000b00299bb08e83amr180984pjb.28.1709150526919; Wed, 28
 Feb 2024 12:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228053335.312776-1-namhyung@kernel.org> <Zd8lkcb5irCOY4-m@x1>
In-Reply-To: <Zd8lkcb5irCOY4-m@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 28 Feb 2024 12:01:55 -0800
Message-ID: <CAM9d7cicRtxCvMWu4pk6kdZAqT2pt3erpzL4_Jdt1pKLLYoFgQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf lock contention: Account contending locks too
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:22=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Feb 27, 2024 at 09:33:35PM -0800, Namhyung Kim wrote:
> > Currently it accounts the contention using delta between timestamps in
> > lock:contention_begin and lock:contention_end tracepoints.  But it mean=
s
> > the lock should see the both events during the monitoring period.
> >
> > Actually there are 4 cases that happen with the monitoring:
> >
> >                 monitoring period
> >             /                       \
> >             |                       |
> >  1:  B------+-----------------------+--------E
> >  2:    B----+-------------E         |
> >  3:         |           B-----------+----E
> >  4:         |     B-------------E   |
> >             |                       |
> >             t0                      t1
> >
> > where B and E mean contention BEGIN and END, respectively.  So it only
> > accounts the case 4 for now.  It seems there's no way to handle the cas=
e
> > 1.  The case 2 might be handled if it saved the timestamp (t0), but it
> > lacks the information from the B notably the flags which shows the lock
> > types.  Also it could be a nested lock which it currently ignores.  So
> > I think we should ignore the case 2.
>
> Perhaps have a separate output listing locks that were found to be with
> at least tE - t0 time, with perhaps a backtrace at that END time?

Do you mean long contentions in case 3?  I'm not sure what do
you mean by tE, but they started after t0 so cannot be greater
than or equal to the monitoring period.  Maybe we can try with
say, 90% of period but we can still miss something.

And collecting backtrace of other task would be racy as the it
may not contend anymore.

>
> With that we wouldn't miss that info, however incomplete it is and the
> user would try running again, perhaps for a longer time, or start
> monitoring before the observed workload starts, etc.

Yeah, it can be useful.  Let me think about it more.

>
> Anyway:
>
> Reviwed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks for your review!
Namhyung

