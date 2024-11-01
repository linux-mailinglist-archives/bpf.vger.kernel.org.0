Return-Path: <bpf+bounces-43758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD89B97A3
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0BE1F216BC
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DEC1CEE8C;
	Fri,  1 Nov 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YprcyMNL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305C1A0BE7;
	Fri,  1 Nov 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486104; cv=none; b=P6YEQcDcrAGwvOsJVbBEIdV8/aZqvG4NtWFwLYiRgfzjhiD2bx4ZNa7YJKVvsoQ9AMEsahzN4x/26vwmysfj/IONZLobgc4JO+i4nRlHl7D9jGYP7i0T3kwJETKJZ7kT54KHWtBtsb2rjA0uaKtR1DBT+A9gdZ5NNutFL47ZQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486104; c=relaxed/simple;
	bh=/DKmTKHIjmlZSS7sCDOPosSqeLYK7lnXNwFxIrEBzU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+pPggxLt4F1oQcsOh4q80U4XhfP+H9A5Qctlk0IfhOgJLJFQNHaGrMuF2DZQM4nmQevv8QkYnmEAy8JckFE0rqrWxbDVpwLX4DcHS4aKIi8W8DDr9YHWaWb/j0GXFfhyaez1T+MShYGp02f7R3OHu8IA90gdg/Bus6sgUBzjuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YprcyMNL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-210e5369b7dso23586865ad.3;
        Fri, 01 Nov 2024 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730486102; x=1731090902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPo1tI9wzglf8YLeLlOLbMvwKDopYV6C72DllgtOniE=;
        b=YprcyMNLbqeb1dHOQGYS5CwN5q46vrEzogrImFgCdETPkt+5StAbeiZ11/R7zU6ZIG
         gYwNoMikuZe3OtIWlVIPT2GjbbUmKdHdCG8WEF1UWsZsuKgJ+h50NHlps8Q40U/WZ4zR
         MavRA4lEtUjsPZ8IX+/ZBL9x/IL0ppB+UzRDop0VHGYDsGZcgf1q6Jk1itE9RUDP41+/
         IZcICzXqfMfg0i1wPO1QwrJcl9DazH9NeV8P+4DI7XkUtDjiz/R3uxf+FDNDT8Fe+CWK
         qpEFYlwzIvSsCHUnUtGuyHgzWq+/tneObdcMvONhWd0WONJxslavjVPZyhhNqFfI5DWk
         YHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486102; x=1731090902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPo1tI9wzglf8YLeLlOLbMvwKDopYV6C72DllgtOniE=;
        b=lJRcusVq1klBjIZiNAC5GNHnliVBrdsefb4BSozZ4oBoH9cI8HuCbq8MmDDH3ZUC/C
         IP03KIYM54kAib1FPu3JTH7X9eeJtM1cx2EjoJrVjjCru9FuRIJJ6E9hI3qfwkPc0pUx
         9zg0ebv+zI4phQ8TocAA5Ll+G+HXcGEHRbISgdtXK6XG0XErvUIWl/IfVKdBlWwRFN/q
         p3oVyu/V3a5h0E+La79HoGJ0rZEF5c5qIVX3rpUi6tyHiBbQ+lXEPRWc7UZmXI1RS7cL
         2Pc0URXxLRo2th2HTFXZTIGH/SGB5XzMSSTpJmVTLWfayhbShuRWjJ0ShqG51fYkAZDZ
         ZTOw==
X-Forwarded-Encrypted: i=1; AJvYcCUVi2zIRq7qKpjhR9og5yPeAAnsW7xcIbUAEZghFk2lb7GDCsQo0r/OyiNp9J6s5WRKkp7HzymfvJiXOtQb@vger.kernel.org, AJvYcCV3tFbAJGftxcTCTssdBTjzQ+QgmZYEN+ZVGOiTpK4mq3+sL7YL9oL8dU1GDIPLRCgky6mWkCqOOhukzwey8xLJsQ==@vger.kernel.org, AJvYcCVO/hB0+WFUA2Ab1qucgM8ZpWoj/uQ+e64aHHmhACEMO/oqxkvoDvU14iy9U/0nrhu+g9g=@vger.kernel.org, AJvYcCVwTmY4ZGWYNop1KL8c6pLKskU8cFm+Ox3HI+hqKflxEJg/V/W7pBi0wvaq96MezkCHP6Ojv+sRoWcikg/KfOcJbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxputqIhZqsmdqP1SUC96bGVKD+MUQOo+0dIIvOb08JI4nX/vcD
	c4QeEEkVzKlKatI+DIAMkpjEfkinYrPo/i0/07Ts8fmbXdEAnuC5vk7joqnOatajeNkLyFGagWd
	ZuvzdzSHLsLpVe3orBomSFIdNCQk=
X-Google-Smtp-Source: AGHT+IF2YjMqXZPYah7m3lrhbiDdZb26BaklKlKYyp42YVVUUbtBqsph3qTabUINnUKy5UHnStaLFXMuuGksC/i/2EQ=
X-Received: by 2002:a17:90b:4b89:b0:2e2:e136:a931 with SMTP id
 98e67ed59e1d1-2e94c2950b5mr5919131a91.6.1730486100861; Fri, 01 Nov 2024
 11:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net> <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
In-Reply-To: <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 11:34:48 -0700
Message-ID: <CAEf4BzaQYqPfe2Qb5n71JVAAD3-1Q7q2+_cnQMQEa43DvV5PCQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+cc bpf@ where people care about stack traces and profiling as well
(please cc bpf@vger.kernel.org for next revisions as well, I'm sure a
bunch of folks would appreciate it and have something useful to say)

On Thu, Oct 31, 2024 at 4:03=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Thu, Oct 31, 2024 at 01:57:10PM -0700, Andrii Nakryiko wrote:
> > > > what if ip_off is larger than 4GB? ELF section can be bigger than 4=
GB, right?
> > >
> > > That's baked into sframe v2.
> >
> > I believe we do have large production binaries with more than 4GB of
> > text, what are we going to do about them? It would be interesting to
> > hear sframe people's opinion. Adding such a far-reaching new format in
> > 2024 with these limitations is kind of sad. At the very least maybe we
> > should allow some form of chaining sframe definitions to cover more
> > than 4GB segments? Please CC relevant folks, I'm wondering what
> > they're thinking about this.
>
> Personally I find the idea of a single 4GB+ text segment pretty
> surprising as I've never seen anything even close to that.

I grabbed one of Meta production servers running one of the big-ish (I
don't know if it's even the largest, most probably not) service. Here
are first few sections from /proc/pid/maps belonging to the main
binary:

00200000-170ad000 r--p 00000000 07:01 5
172ac000-498e7000 r-xp 16eac000 07:01 5
49ae7000-49b8b000 r--p 494e7000 07:01 5
49d8b000-4a228000 rw-p 4958b000 07:01 5
4a228000-4c677000 rw-p 00000000 00:00 0
4c800000-4ca00000 r-xp 49c00000 07:01 5
4ca00000-4f600000 r-xp 49e00000 07:01 5
4f600000-5b270000 r-xp 4ca00000 07:01 5

Few observations:

1) There are 4 executable segments in just the first 8 entries.
2) Their total size is already approaching 1.5GB:

>>> ((0x170ad000 - 0x200000) + (0x5b270000 - 0x4f600000) + (0x498e7000 - 0x=
172ac000)) / 1024 / 1024
1361.34375

I don't know about you, but from my experience things like code size
tend to just grow over time, rarely it shrinks (and even that usually
requires tremendous and focused efforts).

>
> Anyway it's iterative development and not everybody's requirements are
> clear from day 1.  Which is why we're discussing it now.  I think there
> are already plans to do an sframe v3.

Of course, which is why I'm providing this feedback. But it would be
nice to avoid having to support a zoo of versions if we already know
there are practical limitations that we are not that far from hitting.

>
> > > > > +                       if (text_vma) {
> > > > > +                               pr_warn_once("%s[%d]: multiple EX=
EC segments unsupported\n",
> > > > > +                                            current->comm, curre=
nt->pid);
> > > >
> > > > is this just something that fundamentally can't be supported by SFr=
ame
> > > > format? Or just an implementation simplification?
> > >
> > > It's a simplification I suppose.
> >
> > That's a rather random limitation, IMO... How hard would it be to not
> > make that assumption?
>
> It's definitely not random, there's no need to complicate the code if
> this condition doesn't exist.

Sorry, I'm probably dense and missing something. But from the example
process above, isn't this check violated already? Or it's two
different things? Not sure, honestly.

>
> > > > It's not illegal to have an executable with multiple VM_EXEC segmen=
ts,
> > > > no? Should this be a pr_warn_once() then?
> > >
> > > I don't know, is it allowed?  I've never seen it in practice.  The
> >
> > I'm pretty sure you can do that with a custom linker script, at the
> > very least. Normally this probably won't happen, but I don't think
> > Linux dictates how many executable VMAs an application can have.
> > And it probably just naturally happens for JIT-ted applications (Java,
> > Go, etc).
>
> Actually I just double checked and even the kernel's ELF loader assumes
> that each executable has only a single text start+end address pair.

See above, very confused by such assumptions, but I'm hoping we are
talking about two different things here.

>
> > > pr_warn_once() is not reporting that it's illegal but rather that thi=
s
> > > corner case actually exists and maybe needs to be looked at.
> >
> > This warn() will be logged across millions of machines in the fleet,
> > triggering alarms, people looking at this, making custom internal
> > patches to disable the known-to-happen warn. Why do we need all this?
> > This is an issue that is trivial to trigger by user process that's not
> > doing anything illegal. Why?
>
> There's no point in adding complexity to support some hypothetical.  I
> can remove the printk though.

We are talking about fundamental things like format for supporting
frame pointer-less stack trace capture. It will take years to adopt
SFrame everywhere, so I think it's prudent to think a bit ahead beyond
just saying "no real application should need more than 4GB text", IMO.

>
> --
> Josh

