Return-Path: <bpf+bounces-52932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF7A4A68A
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91F53B83C9
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6795E1DEFF5;
	Fri, 28 Feb 2025 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8H3gkXv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606F1DE4FE;
	Fri, 28 Feb 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784377; cv=none; b=Z9pHzIDUKHeoFZlMPyAuZxc7Qi2lNLy7MnAs73emKdt//RZiFyVzDVg4JlhI1QKQa5lRPMG+UcZr6dgXm2n+a9BJkIGH4g20xOcvKh4zEpWnm3jvCRVGHONNowXYU+Kd7UmVXuP25ynV678OH3IEWAX6Ey9ZOFmamORt7Vhn4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784377; c=relaxed/simple;
	bh=gmeQwYPCQfhotOYwDnCsLa6dzBnIllf0QgILB1a/s3c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHwsKKpt6EcvFFldzMktwe6ocVGeAj9A92yiTLfEFkCabv/pJOjUp61kC2Ep3wTafeODVsgPqWnwL1wnoY9DZCtRKbOdLASCOxRn0P5cvwZNhBAbp1AhgVT5NFaXwwvc0d/KMu5P6HzkBWFueevZSGsYB1EQ8UpY+Vu5yosbYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8H3gkXv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43989226283so17374895e9.1;
        Fri, 28 Feb 2025 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740784373; x=1741389173; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8uLW0n5QBORTDksDdW+NNYX6aNfN0bVWFh5dY1j8jpE=;
        b=O8H3gkXvVUwseMGGqJ026kxAhHCaC5fS1yc9v6SYTmSxElSFx8hMOKGn4HI0mLPB/C
         h89nmejBbiTfurSfcZwXr2aq5j1Opz324et2TYk6xpyGt/33276T66R8waIaj2A+ApDo
         GqpAV3v+iNRtbsBCjlo96F/QmYh2b5UeGMzC8szYjb2g5+CzPw2eWAqrEivvWTo2x6j6
         ts8yk5qoklFeOGGOfbZTalr8zRvZ6yBS3JXg56UwUvC0oiUfcPY54EzoBeW341Us7ypK
         8WL+NyDoWzlzxVpuq3UWwx/CORkdoeVcMe+Et1KjuH4hi+LcX0xPobH/hBHN1KL3Y1Y7
         ZhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740784373; x=1741389173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uLW0n5QBORTDksDdW+NNYX6aNfN0bVWFh5dY1j8jpE=;
        b=afIS3Es/0HGreuy+X6pfzYzS/8/XpRzqHLl0t/8gO7uYWevVhf7sdQe+ihuLbRHAjo
         w+ipJf2l6jI0K7K8iQUf5urz4H0hp9kd/NhrHYvV6a0dywi/J4rphj6WRKv4wlngIWdu
         Q6pvrtKq4VAsugVaxEujt5Rr0I/W3DDW1IYFN9Q5wWPSsEOz5mYs0mnTM1eF6uzyTMKn
         nYhhVajZ+8xVg7BXvC8+y9XNUQXZRU6AgFD09kj2qgltKyTy4WJhas2umcBYymovHvQO
         pG4js6FeQuxMNgu4q3e0A7xvqGzZ7VpSm742wXaLHsxCZ7d0uUqt1AWeHjjz5txmxG+E
         tMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqEkw2WgJ9JhwDL9jsRtO9dPJCvdp3fe/J+Dhk199lT2YNGqqCsGLEYQsqOoK3B13IyJ/ZUVqx0daRxR5P@vger.kernel.org, AJvYcCVyoF+eTuA+nhIBqWkdQchyn2w/yNmDLEhgvu/ohOIvgF03Ueqa0nLLx672xA0XACwLJ9YDOzmmZl0Kx5hb430t/SHR@vger.kernel.org, AJvYcCXlRs46qtmu/VxiathpXbM1yUzVcrc9W4Xc4XaTCAr6FNm3ow7oJoJvlFe0G2sbmjrXvLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cY6T6xynP0BQbeUObf4kX4zFe8YfvXC2pAILMsLn2pnoHcXW
	WlZMP1BtNMughtWE1RjPZMN22zItl9W8BdZIi7BQEQYqtwYHkEuv
X-Gm-Gg: ASbGnctU4L1bu4imKVNB37Qr4Q4jyGaw97udl+FawIQJTHLg3/p4zRpM6AcF8r0Z0st
	vb3qKxN8SiFi7Qe3L3j8rOCE/DRdXlNy+7rg3G0dzkjzqEyb/PxAWR77KjBP7Ryak9lIgc+iQ+5
	oUfLv42/23qgnF3LdDO7HuAgCeqC+9SvoEPUFWHnmtH4luqF0RsxgWxfnPuhKpSG+GTlei02G94
	V1hFQe0gi5iEDIemyiXMejOPK0RV1OAUVlORvW1YtFPzAwwCSTuFr9+nTYanoSxIsXIyq6QNHcO
	36EtrnyIeirpoI3ceUb2ajTNJAk4+w5C
X-Google-Smtp-Source: AGHT+IGRSOA7+QXkz5A8u+ThZYyr8UN/SnOX4jRnZVZJoyvHgtMPQphXhnbeQsJD8NsejbCxvJMhFw==
X-Received: by 2002:a05:600c:3ca8:b0:439:987c:2309 with SMTP id 5b1f17b1804b1-43ba675f291mr38984865e9.27.1740784373209;
        Fri, 28 Feb 2025 15:12:53 -0800 (PST)
Received: from krava (85-193-35-41.rib.o2.cz. [85.193.35.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532ba6sm102322825e9.12.2025.02.28.15.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:12:51 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 1 Mar 2025 00:12:49 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv2 06/18] uprobes: Add orig argument to uprobe_write
 and uprobe_write_opcode
Message-ID: <Z8JC8U004JRZuF2b@krava>
References: <20250224140151.667679-1-jolsa@kernel.org>
 <20250224140151.667679-7-jolsa@kernel.org>
 <CAEf4BzZ=TOGXMwYDz1=bdw4DVVgkXJkMKKv=O1HnWddS-i6Kww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ=TOGXMwYDz1=bdw4DVVgkXJkMKKv=O1HnWddS-i6Kww@mail.gmail.com>

On Fri, Feb 28, 2025 at 11:07:38AM -0800, Andrii Nakryiko wrote:
> On Mon, Feb 24, 2025 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > The uprobe_write has special path to restore the original page when
> > we write original instruction back.
> >
> > This happens when uprobe_write detects that we want to write anything
> > else but breakpoint instruction.
> >
> > In following changes we want to use uprobe_write function for multiple
> > updates, so adding new function argument to denote that this is the
> > original instruction update. This way uprobe_write can make appropriate
> > checks and restore the original page when possible.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/arm/probes/uprobes/core.c |  2 +-
> >  include/linux/uprobes.h        |  5 +++--
> >  kernel/events/uprobes.c        | 22 ++++++++++------------
> >  3 files changed, 14 insertions(+), 15 deletions(-)
> >
> 
> [...]
> 
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index ad5879fc2d26..2b542043089e 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -471,25 +471,23 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
> >   * Return 0 (success) or a negative errno.
> >   */
> >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > -                       unsigned long vaddr, uprobe_opcode_t opcode)
> > +                       unsigned long vaddr, uprobe_opcode_t opcode, bool orig)
> >  {
> > -       return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
> > +       return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode, orig);
> >  }
> >
> >  int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >                  unsigned long vaddr, uprobe_opcode_t *insn,
> > -                int nbytes, uprobe_write_verify_t verify)
> > +                int nbytes, uprobe_write_verify_t verify, bool orig)
> 
> why not call orig -> is_register and avoid a bunch of code churn?...
> (and while "is_register" is not awesome name, still a bit more clear
> compared to "orig", IMO)

I see the logic in the function the other way around: if you want to try
and load the original page as part of your update, then you pass true to
orig argument

also the is_register makes sense to me in the old code where you have
just 2 states: breakpoint or original instruction ... now when we added
call instruction the is_register would need to cover that as well

jirka

> 
> >  {
> >         struct page *old_page, *new_page;
> >         struct vm_area_struct *vma;
> > -       int ret, is_register;
> > +       int ret;
> >         bool orig_page_huge = false;
> >         unsigned int gup_flags = FOLL_FORCE;
> >
> > -       is_register = is_swbp_insn(insn);
> > -
> 
> [...]

