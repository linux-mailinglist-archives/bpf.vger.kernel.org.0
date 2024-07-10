Return-Path: <bpf+bounces-34423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2711E92D85D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B05281FE0
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8019644B;
	Wed, 10 Jul 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4o42eGK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFF194C9A;
	Wed, 10 Jul 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636833; cv=none; b=G/25RxL1G+XD8/FO6ri+BXExOKyueae3Yq+CiwKuepsquF26bz5Eajnn74fm6ZBa8XxveC/pzUdh5Bi7RdnQGaqBWuvnzsB2e9Ku+vzx1yn0HqYznaZEumW/hbHCoEifuXyZBNAZd0NAkXu7CAIispjrgNV3aoLUWq8Rza5j+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636833; c=relaxed/simple;
	bh=mOG1/dy9foWXLBEbNdNTS2vxukoMRdb2jrb0IqcqAdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZB8hHlja7I6phyehCRU4niQ9zG+TqLIgQjX0B21bZr14du4BJY5nK84Hj/b7UmH3Em/9jnEQwU9GzYmiVvvN221tCk0+jjboVNWIMZ4Cpnlw/xYwJD/TlmL9+22IiMeVEkwMXp38UFqWjw8f2VVMGgZyJWvVNgnuCnP6fC8cRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4o42eGK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b05260c39so111835b3a.0;
        Wed, 10 Jul 2024 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720636830; x=1721241630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH2iXf/QMBEgCOBgDj4vj0d1Ba4Ks2ZfB6GNwCH8rhU=;
        b=D4o42eGKZv6V1qEe/PdcQsGA2E/ROijA9fBj+6lXnrOqBOE3i200zVWtGlY7UZ1XW5
         tDjJmcK2E4D4crpUurbeDM/1jS0xnrtFNnywpsC7rBFc4Iho17Yg1Rkwyyfoeq87NgNK
         woRw0r2HlpPofd6qhzC7lWBat4iwqvVqiv9e3QMooO4Iy6FI1ZV26RTWrUx2KZDjbbPT
         VwBe093DbEEBsvUpQs4An00/6ehM1SZV50OaehX6p2tC9socu3ii2IWoUjTuGih5igK+
         QPvWrEM7NcdfZdqUV88o8p+FqnYie0ZWFJ90kA4g5ZZLcrbnTXcqCTjgz/6suyf6zHiY
         f9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636830; x=1721241630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH2iXf/QMBEgCOBgDj4vj0d1Ba4Ks2ZfB6GNwCH8rhU=;
        b=fS+hUW0WhbrZoLDUu45xQC0f0j2E6x/lVBaXgKMoxVa+n1qM4J97cZ6D+B2e2f2ZL7
         7ImQpbq01/jRotzNYx5M64OehLxTio88uMXpL8Gu+0JfXClOSxzYR/UUbiKTEwP8HeEb
         YvBVj3YKc6VfNzr7o4l2CGEKVwezljUoob6gVvVwcQaszEcM6J73sfFCJi5itAqg9pRN
         QoQysQ0BBCc+osSn8XmwTtchzwxsCqASYHxkD3StW65RTFta/oPTW4xEAqcgVC7iMpHW
         yl3GIrzgShINna7EoehHUcmUABF/YwyjQJp15ZJVBGcm25Xsf1iG4mKLHzpzIldE0YVw
         Y7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXjOSN9qInP1QHeBbabsUJ2clJFQUy4adP6G962oUYYj4H1pzfgb39uiS2HXEbysl6zJNLyYRABR9WcKkT79WugAx2sc0O5JrqO+OufV6YlF+fwObk/qgoxf8YGIcZ3S6DP
X-Gm-Message-State: AOJu0Yzwrb35W6nMknd9xxmIOcipdGKqwSfVjB0WYUZd9iwQ1lFKsjqD
	yY71iNPpoksMw8QXIhUi/cNGPu2MZuMS0PZ8yfe9bnwdqwghJF+Q5WMM2edxQdDzkJnTtWod9aC
	ZZzdopfanYjloG+XutMBZwO/pKi8=
X-Google-Smtp-Source: AGHT+IHbcbETAey3NnuCmNe9kMNNq4TJGEo4sZLOKWaX4wJefc0OEeANmtUqvBXPG/ZjU+u19uigzELjdNSis4bytkA=
X-Received: by 2002:a05:6a20:c22:b0:1be:c88f:c60d with SMTP id
 adf61e73a8af0-1c2984d82d1mr4743125637.56.1720636830506; Wed, 10 Jul 2024
 11:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708091241.544262971@infradead.org> <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090304.GG27299@noisy.programming.kicks-ass.net> <Zo0KX1P8L3Yt4Z8j@krava>
 <20240709101634.GJ27299@noisy.programming.kicks-ass.net> <20240710071046.e032ee74903065bddba9a814@kernel.org>
 <20240710101003.GV27299@noisy.programming.kicks-ass.net> <20240710235616.5a9142faf152572db62d185c@kernel.org>
In-Reply-To: <20240710235616.5a9142faf152572db62d185c@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 11:40:17 -0700
Message-ID: <CAEf4BzZGHGxsqNWSBu3B79ZNEM6EruiqSD4vT-O=_RzsBeKP0w@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <olsajiri@gmail.com>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, clm@meta.com, paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 7:56=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 10 Jul 2024 12:10:03 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Wed, Jul 10, 2024 at 07:10:46AM +0900, Masami Hiramatsu wrote:
> >
> > > > FFS :-/ That touches all sorts and doesn't have any perf ack on. Ma=
sami
> > > > what gives?
> > >
> > > This is managing *probes and related dynamic trace-events. Those has =
been
> > > moved from tip. Could you also add linux-trace-kernel@vger ML to CC?
> >
> > ./scripts/get_maintainer.pl -f kernel/events/uprobes.c
> >
> > disagrees with that, also things like:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git=
/commit/?h=3Dprobes/for-next&id=3D4a365eb8a6d9940e838739935f1ce21f1ec8e33f
> >
> > touch common perf stuff, and very much would require at least an ack
> > from the perf folks.
>
> Hmm, indeed. I'm OK to pass those patches (except for trace_uprobe things=
)
> to -tip if you can.
>
> >
> > Not cool.
>

You were aware of this patch and cc'ed personally (just like
linux-perf-users@vger.kernel.org) on all revisions of it. I addressed
your concerns in [0], you went silent after that and patches were
sitting idle for more than a month.

But regardless, if you'd like me to do any adjustments, please let me know.

  [0] https://lore.kernel.org/all/CAEf4Bzazi7YMz9n0V46BU7xthQjNdQL_zma5vzgC=
m_7C-_CvmQ@mail.gmail.com/

> Yeah, the probe things are boundary.
> BTW, IMHO, there could be dependency issues on *probes. Those are usually=
 used
> by ftrace/perf/bpf, which are managed by different trees. This means a se=
ries
> can span multiple trees. Mutually reviewing is the solution?
>

I agree, there is no one best tree for stuff like this. So as long as
relevant people and mailing lists are CC'ed we hopefully should be
fine?

> Thank you,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

