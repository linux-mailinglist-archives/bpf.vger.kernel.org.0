Return-Path: <bpf+bounces-28589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C38BBF49
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 07:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3566D1F21700
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 05:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DF65227;
	Sun,  5 May 2024 05:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mrn1xhBN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F717FF
	for <bpf@vger.kernel.org>; Sun,  5 May 2024 05:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714885793; cv=none; b=Le3hDD+MOxO6XHZSz44qOATezgFPuokBBtABjNMy/yfHGyuHbMY5lzT1C+/xXCaUhXviiNOlaqAa2NTAa0lEz9fMnhnWDq4FSupC1e8u9Pw4UVCnAAFr9N5chchCluctURfdpVGHM/rUKkx6+KKq3fENFbR9GR6FawZlcJtNjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714885793; c=relaxed/simple;
	bh=olH7hQHHDHDp2bsomJmiSdHdXsNU4KXMYOJHnmgtMxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEQ1YbMrvruwBgrnmzAmAZYHXIuNdRuopgbI2I7A72ls+080fAN9YYTl3rrZqRobvywONRm7781Tbwqrr0gdDpVLuadK1tZuCvimQL0DTAmn6AYC3IhAaYgUVHN8ziYoPEWGVe+JuAzxaHhG/mukh2cwGy9gtx4YDDsbcej9ZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mrn1xhBN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec182ab287so96015ad.1
        for <bpf@vger.kernel.org>; Sat, 04 May 2024 22:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714885791; x=1715490591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LFEOHbhdT8xlmXAZ79el6d0XvgZNSArYbb5H09rUb4=;
        b=Mrn1xhBNBqxCE5yPD5OVx+e8FNRV17ekqQA2aKdNnVNULq8zWnwENBgC+uQl92OwtH
         N8CSJy84/hyjZZjR6nTlf5NZYZVbhQvn0/s2xcrqoxO6hcBF9TVX8NkzWKg8cm25W1+0
         0boxYbJxSq21MoP1RTNS/2jad52AnDomuT+zNIfSYmC0RsvYFALNXf3ssOYQmEWycu/e
         65ZT8SB/V25cyTrikHt5DWMwAVwYH6IyNvxza9ZVNbcMQw9AFRxRAhIG+o9VGHsv1vms
         R1I7anqnYCubCZwrkOusYF3KwLWw5hEqWk5W3DxnebOzRvc3dshcmd4SvE+TLp67Rn1T
         rG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714885791; x=1715490591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LFEOHbhdT8xlmXAZ79el6d0XvgZNSArYbb5H09rUb4=;
        b=G7PIGr3wcmxQNhvpKjIcvDRm67vwWVzWgiQ4VK+M6JoJGlO7+TpXiL3CAawJ5xRhVc
         dhqAsep/T9cQP/z/n9RR4Xjh4lleoWguQZA6QSTEr5pBTMwlhmeB0JNvfZNcLBt2kMj3
         /WlZpWMmH9ZTVoAWIG7+fyqO/kkveHe5ilJrR9PEm+1sPeSo7vqBYGtq3bXT0N+US23k
         x4g27Tt41EoCPISt6OpFvgDO8BWWPAH+mDNYb5JEK9cWy3IkntVhKCD6Fa2/n+8t8wym
         bVJnrCqBYIQhSFRrpIcA/gJdQ0hgAw1OYuEGhBMx+nOTubLHAsO5ScEGtr69oRQa5Vg1
         v1nA==
X-Forwarded-Encrypted: i=1; AJvYcCXq86pkX3C2NFE1bB3jacF5KtBIDmSuemnc+TlZJYoippkw/ecc7n9jCNPR38LbtJPxVoHj62k6Gb43dOKhEfGK72ja
X-Gm-Message-State: AOJu0YxytYvCpH2iSlgH33WtOLSlgUeEtkzhPJ3+5iqsFx7ejqMqWL1M
	tyNyC953N47zDcG+gMnDFeHIeMDPHGi5S4JNJcuyqOplMndhy02EbaXZk1BFHXy7FRwlu2uZX6E
	FYuijPIfwEAJ+VFYasFZAqt4O3nGFVmiY4sqZ
X-Google-Smtp-Source: AGHT+IHGBa7tMMleiZKIyfq04qQxdw3xbaO8yY7nGHAFS1LwAn2FIimhO36Sml74NHR419/S58AeVS848bcSO81YVbs=
X-Received: by 2002:a17:902:f789:b0:1e0:c571:d652 with SMTP id
 d9443c01a7336-1ed851171f3mr1404605ad.1.1714885790351; Sat, 04 May 2024
 22:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050404-rectify-romp-4fdb@gregkh> <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
In-Reply-To: <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 4 May 2024 22:09:39 -0700
Message-ID: <CAP-5=fWPig8-CLLBJ_rb3D6eNAKVY7KX_n_HcpGqL7gfe-=XXg@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 2:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, May 4, 2024 at 8:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> >
> > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > > Implement a simple tool/benchmark for comparing address "resolution"
> > > logic based on textual /proc/<pid>/maps interface and new binary
> > > ioctl-based PROCFS_PROCMAP_QUERY command.
> >
> > Of course an artificial benchmark of "read a whole file" vs. "a tiny
> > ioctl" is going to be different, but step back and show how this is
> > going to be used in the real world overall.  Pounding on this file is
> > not a normal operation, right?
> >
>
> It's not artificial at all. It's *exactly* what, say, blazesym library
> is doing (see [0], it's Rust and part of the overall library API, I
> think C code in this patch is way easier to follow for someone not
> familiar with implementation of blazesym, but both implementations are
> doing exactly the same sequence of steps). You can do it even less
> efficiently by parsing the whole file, building an in-memory lookup
> table, then looking up addresses one by one. But that's even slower
> and more memory-hungry. So I didn't even bother implementing that, it
> would put /proc/<pid>/maps at even more disadvantage.
>
> Other applications that deal with stack traces (including perf) would
> be doing one of those two approaches, depending on circumstances and
> level of sophistication of code (and sensitivity to performance).

The code in perf doing this is here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/synthetic-events.c#n440
The code is using the api/io.h code:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/lib/api/io.h
Using perf to profile perf it was observed time was spent allocating
buffers and locale related activities when using stdio, so io is a
lighter weight alternative, albeit with more verbose code than fscanf.
You could add this as an alternate /proc/<pid>/maps reader, we have a
similar benchmark in `perf bench internals synthesize`.

Thanks,
Ian

>   [0] https://github.com/libbpf/blazesym/blob/ee9b48a80c0b4499118a1e8e5d9=
01cddb2b33ab1/src/normalize/user.rs#L193
>
> > thanks,
> >
> > greg k-h
>

