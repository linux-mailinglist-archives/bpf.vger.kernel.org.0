Return-Path: <bpf+bounces-34455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D6792D91C
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD681C218A9
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A405198A35;
	Wed, 10 Jul 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF24DBt8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9D19007C;
	Wed, 10 Jul 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639508; cv=none; b=Cowjkg0ETgnjNMPCV5tpBtRikEmiSi9VChn6SDMSJ2v8rWaYyeqMkhfyi2RV0+jz6qYIWOhpnJOXktOM4vBL6ej9csTsReQptJ/jNqfPaTvgq9YOnOmv9DxCP8wvjrXKJhvui/6TUfsXARbhJhDZtyi34DWrvSndpWdz73Rcf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639508; c=relaxed/simple;
	bh=omilDSKQECKeBUVSpSd4qOmn3xJFmiJMe5rmxSPa2d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPib8yMvVBJA7tIqaBn1HNWcENXHnc+zYSWHD22VlNWNg9K4D1E54kCA+Rq2iJmWYkN9UKJ6Fnum0nX0utYyajGzY6INYksVlCPCKpVHEnhRsMw62JO+DE3n5mtoDs2pXLq/Nl0oESAeg9iQH9cG823RUx1zyGe58sMz306vc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF24DBt8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso51467a12.2;
        Wed, 10 Jul 2024 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720639506; x=1721244306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEDs/EPHjLdDM6/Co61/kE6mDTJI2bCieTn1Dt+Dg9o=;
        b=LF24DBt8jHKkfO7M2fcG0I1NMzrVdnTwb9eT7Qe5QfTT3wxPK9ltMng+Dbo77Hm9Al
         EzMGMpiAkDMFH/xyg6DjucksLPf00PjcKJEl3cZ3zy/cdtk6EA5DNXHNRDE4qVuBPPPy
         XkEsALJEdko8SmI1IkAUkJaeOvhQrUT9CLnziaCBSDBqKChsm3kUcBJ6T7ERacKr7oNB
         G4QcQNu28cC19sEctiBTbgudfeNLzT4glMz2y+5oqWV4TKDRJe+g3GtFxgRlIkpwe6mD
         RhKZgS25zlfSSrgbmLY6uk7GCSh9ZqAP3h0qcDIIppdrdQNB+u7EL1iXeYM32n3z8hN0
         OIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720639506; x=1721244306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEDs/EPHjLdDM6/Co61/kE6mDTJI2bCieTn1Dt+Dg9o=;
        b=ivJU1aVYSg6EQ+p3e4UHlu0sBfcBjylCyCstI6jrprgq7rLP76p3KKklBNiUmp+EYD
         fxwgzXvV3DEunIor1OqQCK/He5Geg0l3HzLYYG+pvoLa0FuFfjUTWwqy2YY/QeUEUrzn
         T65aJofP38DrGYA98Z049YDq6M26/1vOvxPUOlr8sBhxzz9WJW64o0/HZyPogoIPrX4l
         mhJC+SUrAVBsjIJGv3JTicF7Sn8ODfGMRoKOAnXessRW0NYmsBwoIlYT/S+sYFFsA9P/
         AtD+W8rByL/+bYqnrKxayc9U2MDTDUSFU3b7WCrlIOvCaGENqUbz0DEX0nIfWyI99vqT
         F5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgfmOdBnnl+JwAUymdYQtt67BsOubXaSB0ZTlK4UuXh6flufEMzfoNSSHgiS+qTHcXZgdYuwrUOr8UPI+MshKhfRXjkuEVS792W843rFovfheoKgLL7GkCvlf4vbH6s0RVqD//8CJ19hXUEWSrZhZiSvV8nXSSgPonxdJJhmG3ZMAupjlVpQk22Jg/uGEL1lVLQ/Qw0vVQaFxsAKhKg1c/NyHtclTjug==
X-Gm-Message-State: AOJu0YycPdO7FLgvdQaOmhPOJGINz8RqtML0+gTtQWPhgzjvOdSvy4xV
	/rwYdFrDmrV+72QJN7sbudYs7vWpqpepdvu+nVC1OVmox9a3Y35V6MtyDEwb0RoSTEXIKpXqwxO
	3Q+GCX2NUXg68oS3Iiwcpvxqy0GM=
X-Google-Smtp-Source: AGHT+IHtbuljG1IBcyBMraYfI+D6InQs6S3XkCH14VkcgnRT0bYon+i47a2S6g9RF2siZgkOGeoqVejPslbBitLPe1A=
X-Received: by 2002:a05:6a21:6e4b:b0:1c3:b211:67e3 with SMTP id
 adf61e73a8af0-1c3b211680fmr626265637.50.1720639506034; Wed, 10 Jul 2024
 12:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708231127.1055083-1-andrii@kernel.org> <20240709101133.GI27299@noisy.programming.kicks-ass.net>
 <CAEf4Bza22X+vmirG=Xf4zPV0DTn9jVXi1SRTn9ff=LG=z2srNQ@mail.gmail.com>
 <20240710113855.GX27299@noisy.programming.kicks-ass.net> <CAEf4BzZFU6CEK-=eTo_LTScYCVoBCYXeH_O_AoZd8rBYiwWzdg@mail.gmail.com>
 <20240710162311.gz3njyjshraeuto7@treble>
In-Reply-To: <20240710162311.gz3njyjshraeuto7@treble>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 12:24:53 -0700
Message-ID: <CAEf4BzZyskNTxq3jUgJ=TzCvZuCVTv5qbUwZrCtF5_+EGo7-mg@mail.gmail.com>
Subject: Re: [PATCH v4] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	x86@kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:24=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Wed, Jul 10, 2024 at 08:11:57AM -0700, Andrii Nakryiko wrote:
> > On Wed, Jul 10, 2024 at 4:39=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > > On Tue, Jul 09, 2024 at 10:50:00AM -0700, Andrii Nakryiko wrote:
> > > > You can see it replaced the first byte, the following 3 bytes are
> > > > remnants of endb64 (gdb says it's a nop? :)), and then we proceeded=
,
> > > > you can see I stepped through a few more instructions.
> > > >
> > > > Works by accident?
> > >
> > > Yeah, we don't actually have Userspace IBT enabled yet, even on hardw=
are
> > > that supports it.
> >
> > OK, I don't know what the implications are, but it's a good accident :)
> >
> > Anyways, what should I do for v4? Drop is_endbr6() check or keep it?
>
> Given the current behavior of uprobe overwriting ENDBR64 with INT3, the
> is_endbr6() check still makes sense, otherwise is_uprobe_at_func_entry()
> would never return true on OSes which have the ENDBR64 compiled in.
>
> However, once userspace IBT actually gets enabled, uprobe should skip
> the ENDBR64 and patch the subsequent instruction.  Then the is_endbr6()
> check would no longer be needed.
>

Ok, I'll keep it then, thanks.

> --
> Josh

