Return-Path: <bpf+bounces-39531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E4A974412
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F881C258CC
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA591A01BD;
	Tue, 10 Sep 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmoP+Rqy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715817E47A;
	Tue, 10 Sep 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000215; cv=none; b=YawX084n4/zDC1VRyCXsqrGqcKhAwvgM5OmDsm68Sb5BUKZALOGZRNOwjWX/UnmjLJVFXiH/8AzneEcl5dBv5mRkUQvPlVbv8EKV1jh3oRU1NwHzrFZL+YSW9cYdg5cH+lADtduyDvjwT+3rt7gmmNJhu/Ykdfwa+jEM6cpeVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000215; c=relaxed/simple;
	bh=v8gTBVjNnqYwu3Pw3VQOCMKtImQMPaFLV+vwQblcnxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcyewfHdcsrIwTSC39iFoGhSuIl2n9E+VCP7to7Gr8J6iA2+/10pRtxAj1guwaC3dJNH7zjXr5v8p3V8pV6mYfZiKYsJruGGiUYTzZkDv5ipFnrMC1Tr5hZzlADg9w4OzEBvwmG0NyS82dfsT7IYnLVfAsK7k85W3ROZqhfLIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmoP+Rqy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so148313a91.1;
        Tue, 10 Sep 2024 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726000213; x=1726605013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGo6g06afncOxRgwlHjfQsLQi+fAv0wLc9CyNHxJx80=;
        b=jmoP+RqyimXyEMyNq3f61DaagbC5AsU6gs8XbFheOO62dyKKjcgyGYZovJYbgNVASh
         f+Q7l9ChF16sqvOWKn4Ao4H/jZnmVEB2lyCQfH1ZaMDYOnrpzDWjb8vGxQ0XgMg7O4Dv
         ED1gpZz9lzvwSwZYJHZNaTvnMHQy5r682/make1iiWKNQe1G4glgbzo4tYbUhiwNHJ4E
         4hi4Rz05jdJ3etF6ksa66/p5f8DvVI+PmOgPD19yEXBW1X9AYPeJIO2SK+RmZ6Y7Qcye
         tygmFN+qFBkKLUakgfDqkXLcgGMdo6bJB8qfRwTH9SU30WFO8FZOzHB5e+rxPE2VXXCp
         VT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726000213; x=1726605013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGo6g06afncOxRgwlHjfQsLQi+fAv0wLc9CyNHxJx80=;
        b=RIDbMr21lzU8Mmlcx1sc/2w/voKgOEBtQB3KF2kjsup0P70wfH9xYuu87Qjr13Ltel
         S1SswYXgUIlkpY2o6XKq7W8aWyr5429x9HvEQf8YrhhhZp9R6Gxt7dAHdIUk8vYyoXsL
         0H+eiNuISGU+lekTKjh/5GELvQw6UfsHiEHIkKPQhlNopvmzP5DjRPdZVqwrj4eHgmJD
         4GGgpjebCBBRKgAWZhRKptBRzQtqMwjhMvAdwClLdyhPRnQNlYBrl6+K+SpRWuHiKaXf
         csfXv288oj5zID6kCjTo69/X5MOLZ8pI/OunkXDSdri4OQCrEUEhwt9OX+DVfOZY4aY5
         8XDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsNbUpTXkV5nqTduqLiQUtfsrxSUmNalpPLwyh+cxKPPas3OAo523CaRjz5kdYV0pF7WkS7HWYbJexvbmDhe8kgy5I@vger.kernel.org, AJvYcCWdgz5blo9h8fC3RuVxCN/25lDwUmtu/pv90tcoGMxHr+hEoVC0Zn8Tq4/F71vcDmLubiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOzDQBgDAp3pXuHWlj5o6mlKM13WVsgv5kc+LikDyHFKBjTsp
	WT+zPLKmrgly9BwiLIyX2JAoeum7VRgZxRB2Q3arkC5ATuopqlBEdcj+3QHnQ7Ez34JKZai/nUA
	vPIipjpd8t4R4tI7g+QSKq/IORAY=
X-Google-Smtp-Source: AGHT+IEwu4ncjp25K1LDFGx5fKhENimNGrXJYCgI651iKudL+fFitsYRPgn1Z4hH+OYQudQOPgqI1sorAlQLUZHJOnw=
X-Received: by 2002:a17:90a:2c0f:b0:2d8:25ce:e6e3 with SMTP id
 98e67ed59e1d1-2db6718d8b4mr6971409a91.5.1726000212616; Tue, 10 Sep 2024
 13:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
 <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com> <20240910145431.20e9d2e5@gandalf.local.home>
In-Reply-To: <20240910145431.20e9d2e5@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 13:29:57 -0700
Message-ID: <CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Florent Revest <revest@chromium.org>, 
	Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:54=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 10 Sep 2024 11:23:29 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > Does Linus have to be in CC to get any reply here? Come on, it's been
> > almost a full week.
>
> Just FYI, an email like this does piss people off. You are getting upset
> for waiting "almost a full week"? A full week is what we tell people to

A full week to get a response to a question? Yes, I find it way too
long. I didn't ask for some complicated code review, did I? I don't
know who "we" are and where "we" tell people, but I disagree that one
week is acceptable latency to coordinate stuff like this across
multiple subsystems.

I understand that life happens, and sometimes times are busier than
normal, but then a quick reply along the lines "sorry, busy, will get
back later" would be nice and completely normal, and I don't think
it's too much to ask.

And having said that, there were replies to other emails on the
mailing list from you and Masami, and even reviews for patches that
were posted way after my email. So I do believe that everyone is busy,
but I don't buy not having time to write a quick reply.

> wait if they don't get a response. And your email was directed to multipl=
e
> people. Then pointing out myself and Masami because we didn't respond? We
> are not arm64 maintainers, and that email looked more directed at them.

"pointing out"? You and Masami are maintainers of linux-trace tree,
and rethook is part of that. Masami's original code was the one in
question and I did expect a rather quick reply from him. If not
Masami, then you would have a context as well. Who else should I be
asking?

If ARM64 folks somehow have more context, it wouldn't be that hard to
mention and redirect, instead of ghosting my email.

>
> Funny part is, I was just about to start reviewing Masami's fprobe patche=
s
> when I read this. Now I feel reluctant to. I'll do it anyway because they
> are Masami's patches, but if they were yours, I would have pushed it off =
a
> week or two with that attitude.

(I'll ignore all the personal stuff)

You are probably talking about [0]. But I was asking about [1], i.e.,
adding HAVE_RETHOOK support to ARM64. Despite all your emotions above,
can I still get a meaningful answer as for why that wasn't landed and
what prevents it from landing right now before Masami's 20-patch
series lands?

  [0] https://lore.kernel.org/linux-trace-kernel/172398527264.293426.205009=
3948411376857.stgit@devnote2/
  [1] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820=
.stgit@devnote2/

>
> Again, just letting you know.
>
> -- Steve

