Return-Path: <bpf+bounces-43117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B469AF5C7
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 01:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B191C21C03
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3E2178F6;
	Thu, 24 Oct 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3iJPLxT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EC22B641;
	Thu, 24 Oct 2024 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729812026; cv=none; b=jj6l/Jf35xzXB5QzAODjZSI9Z8aRUGuqgJiwMbTnIvBlwBVXPj7AqUKkD2apFlRXZrGlK13192ISWW1/n9rdY7SmmjZaHONzJnup5b4qZJ1pkRbN6ID3JZmxMJQxKhwVJgKJorVLgU5zmCPpmo7VajMvDD1Dt63VojyLI+LUCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729812026; c=relaxed/simple;
	bh=96LTyYdL2JmmeBYXIFbZtoBmhJndFdhQld9KioymC3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+ZiW3WnoCoXqQ1MEfZfte83M6UyNzjMhVytYvOgsqN8ZQqD07WmXI/XhoIbTLub8XsI3hgAzfzjR5hMTLKJtQvOG6uwXmYldlz05nVYyhnZybOH9Ze60LAgTU5QsEakGKg3o+NzC9R1yngQ3VZFIlBpn2fHkL//ted/mrQ43yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3iJPLxT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so980976a12.1;
        Thu, 24 Oct 2024 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729812024; x=1730416824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96LTyYdL2JmmeBYXIFbZtoBmhJndFdhQld9KioymC3Q=;
        b=l3iJPLxTyukctWXjJUOS0qgCMVkrMu0Tvn6Hqz8JpZbADyqW6xJdRcVQhW3s65qbar
         HJJvYw4RkwLsOeKKA0GtJ5VNuzPfdLTGWjlYhhS0RdA56bjnnuRo+U+/vPU/2QfsqLJd
         EXQE5u3tqXth58ouIQ9doq8+KPL8c7QkVUankQmDtrQbxyxzJvYCGd9yJm9PQYYenzlN
         eyqpiIrjXkHi0InnP1ISGga7JXLm5jNN2jMW94LL/Wo5S0bklMBnsqCjMXz/WJEU2vgn
         tyc6Fs1Biyi2sAZAeC/AHGSAte5rwZRAH19rQy2HnMsp39/+uTdpdcrP6iXhJGIFaceQ
         F9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729812024; x=1730416824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96LTyYdL2JmmeBYXIFbZtoBmhJndFdhQld9KioymC3Q=;
        b=piV8TmCt5plToQx0Ar6vvuaEu9X3Lm0AhnHLDu5LN4NgHtTxJK3T7FSExHDcZRQTzs
         DGq+iDSoG1w3VcACzwC9VRi6MPK/z4EYNYSnAi8MxEg5OtKoe3DEKMq3Xr8h5svRN6fu
         kidwswHACqfJALaj4Bb6BUwP8g85wZATtcsyTGQ+Qu6Xn90vsX2jMBlGQRK4/qPdfDBy
         000kUE89c1y3NiOM65cO45si6fvlSQOjQmIjhtbWohKHyDSyomxxcUU+v8yl93QvlaKO
         41gHcrhX7Ld3ECVhgrCMRBIpdIXzz6VIk7145wUWjph3+2KhY/bdjd5A/ivsnjPl8hRS
         pt4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVagDV8wel+VtL0p0Swd6ieXKBIkD2G8BTb1stQcJMV8k34Sv3M1tJHykKu24RrWz+1+QFcWHslYcawYvSvBEbM2rW5@vger.kernel.org, AJvYcCW7vLNIyE2MAl/Nmf0yg+YcBnDiY07GYIP0wygy7mdXMj5Et88HJUvO2STQsKA/J21b09yIRT5Mq0HXTJpW@vger.kernel.org, AJvYcCXNd3rxin5GnqdTOdTg8B7Zqde4L0dLTfGNfGD01EqOrh3Jg6XRnimhXYgVWVxWtbqKIWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUdVAQZUxNEMQRHV0JJcIP7tmcBcu1fktFZ2sNvws4iaIug2b
	h9ar4ZNhcc05km+RhytE2Ax4Q5xnUcFWp85J3MUMlzKPyyc25e9WAN7raCvoJKDNPVeKMGgLBeI
	QIw46dHtGnhg5yW39bHd0kTYjkZo=
X-Google-Smtp-Source: AGHT+IGz7ULrL/xoNu5+rVxJsNZlD+tDD1RJbGgRccyic28alkfr8h3zJBxXB5fAn56GxrJNoWw7RQtGGn0zmHw7i2o=
X-Received: by 2002:a05:6a20:d805:b0:1d9:261c:5943 with SMTP id
 adf61e73a8af0-1d978ad5a29mr9768557637.10.1729812024062; Thu, 24 Oct 2024
 16:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <20241023201031.GF11151@noisy.programming.kicks-ass.net> <CAJuCfpFMhoCmqGJMU2uc4JHmk9zh88JzhZAeSz3DgvXEh+u+_g@mail.gmail.com>
 <20241024095659.GD9767@noisy.programming.kicks-ass.net> <CAJuCfpGxu=z-2Wsf41-m4MQ6t7DjfiiWXD408BW8SjTfx0NGTg@mail.gmail.com>
 <CAJuCfpGYzG+3aLjobsXcTSoo9Jo9MCYA_QcROPyLRKEeVHkLGA@mail.gmail.com>
In-Reply-To: <CAJuCfpGYzG+3aLjobsXcTSoo9Jo9MCYA_QcROPyLRKEeVHkLGA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 16:20:11 -0700
Message-ID: <CAEf4Bzbf_2tJL1ogZegy2sD=WbNmdKHXuXCXtAALGYuWYgyEEw@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:04=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Oct 24, 2024 at 9:28=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 2:57=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Oct 23, 2024 at 03:17:01PM -0700, Suren Baghdasaryan wrote:
> > >
> > > > > Or better yet, just use seqcount...
> > > >
> > > > Yeah, with these changes it does look a lot like seqcount now...
> > > > I can take another stab at rewriting this using seqcount_t but one
> > > > issue that Jann was concerned about is the counter being int vs lon=
g.
> > > > seqcount_t uses unsigned, so I'm not sure how to address that if I
> > > > were to use seqcount_t. Any suggestions how to address that before =
I
> > > > move forward with a rewrite?
> > >
> > > So if that issue is real, it is not specific to this case. Specifical=
ly
> > > preemptible seqcount will be similarly affected. So we should probabl=
y
> > > address that in the seqcount implementation.
> >
> > Sounds good. Let me try rewriting this patch using seqcount_t and I'll
> > work with Jann on a separate patch to change seqcount_t.
> > Thanks for the feedback!
>
> I posted the patchset to convert mm_lock_seq into seqcount_t and to
> add speculative functions at
> https://lore.kernel.org/all/20241024205231.1944747-1-surenb@google.com/.

Thanks, Suren! Hopefully it can land soon!

>
> >
> > >

