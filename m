Return-Path: <bpf+bounces-37989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F34595D87C
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 23:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A3A1F24722
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 21:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040D1C944D;
	Fri, 23 Aug 2024 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHlt+jai"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72C1C8228
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448725; cv=none; b=F5IpX9iqteR1EdvgLvY/hiIx4hzBqe/snUSG9MslbiQB1h2apshfp9mi4egzTNfyzU3aR10nODY6mgl/BgL6vkTwytokWnhooiV/4UZbSlDZ9xa7Nn+h5MDyvPKSM6CwEOH86eHr2Ak9LTMG52bAsc1uJCjR4R5+Z03O1NfFkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448725; c=relaxed/simple;
	bh=g/gV2w5HQ7wfx9sxd9JTGaEuGL/nRMkx/hKgPJOb3Qs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmFD5SnOzL2XvhRCCcPWOZiU46BmGhoaETjV+CsImDdGdZW9261mEcOtQEGXkS6zvbDi8pTJ+toW8cDZJLZP0O889Iepu50AFPrt3maFZVXme6Dzz9Z4m5FsikNuD0VYAPqVHCxmRB/mRYvZEPUYmmbzSHDTWNLXMfpoyb0jdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHlt+jai; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3717ff2358eso1270844f8f.1
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724448722; x=1725053522; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pAf5epTzoI3jCagibZrWcBRliAgRptiFRazQidXOONk=;
        b=gHlt+jai/vrI33t4mPqfBu9I7OM2b0EFhpMl6RWPya9nPVgsCiZoEVnlm0ldhpBEoM
         /N21DeIqQ8I9/DsBwKWBH/pMWb+oZU5xk1RbxhotmT0jwE+PD1KDx2pFqFXX+v7uKAhO
         zlYiGIGRjIRVwh7mMOIF8lWL50ZQ6miUBiMWs4FiLlXyDmVwkQfEFZg99z98UlI/bLt6
         80A/6Ge00eSfNmOHJE++6CPWAc0WknH9prBjAkgdAftr6Ehnq5Dv08tsytGNh5qjdU9d
         4mXg3RFriWp/uFqcfpSeKo85VcucagI6L36kHMlaDbKzhrCZnsYVQlL88nDCaSXt+IAl
         BuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724448722; x=1725053522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAf5epTzoI3jCagibZrWcBRliAgRptiFRazQidXOONk=;
        b=UNgD93dRfxppe3KXx8GELGZabQfBJ+HRpvh8o+/jFMOIVZnaQMXtxuiOWJap7b62iz
         2D7O6wOECiZ8GusJtV00lK4Ey1Bph/Qz7aaq7FW8YEXNv+PbFKvkp+1IhtoIbavff5wt
         H/G6Fiomm4urj2l3Fn6Ym6Q2Oil9ROU0kXN6nw6vNdhmRZTeXuEJX2jYaPjJdy9VN81M
         L4gW0rXhEB3Ss0Sv5SkJ8udRXhzuIyxTx0LzeiLcSPmK3OjaaeyZpHgxDHRDWUW2PU9X
         L1COZgIE4lS1t3oUhxhqRWQaaUnJERJ8KEAafQHszwatMYXQYLoIgdmoQ/6x82GoR8Mm
         pP9A==
X-Forwarded-Encrypted: i=1; AJvYcCVkpDWx4PLZEjLkNjiopqyBLUqv61ZMp0b4YjJR8tG19gUB/sT5Sv9w3bhnj8vvOSAIt44=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4NUO1iB3gtUOFNNhqiONlBmhkF69XwXCU6U7AKdqa1qwmfs6
	iP0K2UEW9Z685YqyCSjCYhJHryFjLkq0v31vfFuaJ2uo8JOESJ/6
X-Google-Smtp-Source: AGHT+IHNVZHG3qfJzk7rud8+1+ybP0wF7NGcAKhwb1C5POk5y+JJfoliwcIwQh2Jnu3U1P1iwpx2aA==
X-Received: by 2002:a05:6000:2c2:b0:368:7583:54c7 with SMTP id ffacd0b85a97d-37311840d4dmr2629181f8f.8.1724448721469;
        Fri, 23 Aug 2024 14:32:01 -0700 (PDT)
Received: from krava (85-193-35-108.rib.o2.cz. [85.193.35.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3eb693sm2552119a12.53.2024.08.23.14.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 14:32:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Aug 2024 23:31:58 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: make use of PROCMAP_QUERY ioctl
 if available
Message-ID: <Zsj_zl3ODn2JHzYk@krava>
References: <20240806230319.869734-1-andrii@kernel.org>
 <ZrM5ZKXwjKiWjRk9@krava>
 <CAEf4BzZb_-Rw9miDyb8+ABT9siK7eUeigiKaLqch9DDz0EBSbQ@mail.gmail.com>
 <CAADnVQ+mq48x3dELpAajq+uihfGvfGjV-3kHeSwpDarovAkTKg@mail.gmail.com>
 <CAEf4Bzb8vSYVYqcoSVicFOVkpeAdd+MmC56m7o7KipnycWbq4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb8vSYVYqcoSVicFOVkpeAdd+MmC56m7o7KipnycWbq4w@mail.gmail.com>

On Fri, Aug 23, 2024 at 09:53:03AM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 23, 2024 at 7:48 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 8:17 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 2:07 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Tue, Aug 06, 2024 at 04:03:19PM -0700, Andrii Nakryiko wrote:
> > > >
> > > > SNIP
> > > >
> > > > >  ssize_t get_uprobe_offset(const void *addr)
> > > > >  {
> > > > > -     size_t start, end, base;
> > > > > -     char buf[256];
> > > > > -     bool found = false;
> > > > > +     size_t start, base, end;
> > > > >       FILE *f;
> > > > > +     char buf[256];
> > > > > +     int err, flags;
> > > > >
> > > > >       f = fopen("/proc/self/maps", "r");
> > > > >       if (!f)
> > > > >               return -errno;
> > > > >
> > > > > -     while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
> > > > > -             if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
> > > > > -                     found = true;
> > > > > -                     break;
> > > > > +     /* requested executable VMA only */
> > > > > +     err = procmap_query(fileno(f), addr, PROCMAP_QUERY_VMA_EXECUTABLE, &start, &base, &flags);
> > > > > +     if (err == -EOPNOTSUPP) {
> > > > > +             bool found = false;
> > > > > +
> > > > > +             while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
> > > > > +                     if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
> > > > > +                             found = true;
> > > > > +                             break;
> > > > > +                     }
> > > > > +             }
> > > > > +             if (!found) {
> > > > > +                     fclose(f);
> > > > > +                     return -ESRCH;
> > > > >               }
> > > > > +     } else if (err) {
> > > > > +             fclose(f);
> > > > > +             return err;
> > > >
> > > > I feel like I commented on this before, so feel free to ignore me,
> > > > but this seems similar to the code below, could be in one function
> > >
> > > Do you mean get_rel_offset()? That one is for data symbols (USDT
> > > semaphores), so it a) doesn't do arch-specific adjustments and b)
> > > doesn't filter by executable flag. So while the logic of parsing and
> > > finding VMA is similar, conditions and adjustments are different. It
> > > feels not worth combining them, tbh.
> > >
> > > >
> > > > anyway it's good for follow up
> > > >
> > > > there was another selftest in the original patchset adding benchmark
> > > > for the procfs query interface, is it coming in as well?
> > >
> > > I didn't plan to send it, given it's not really a test. But I can put
> > > it on Github somewhere, probably, if it's useful.
> >
> > With and without this selftest applied I see:
> > ./test_progs -t uprobe
> > #416     uprobe:OK
> > #417     uprobe_autoattach:OK
> > [   47.448908] ref_ctr_offset mismatch. inode: 0x16b5f921 offset:
> > 0x2d4297 ref_ctr_offset(old): 0x45e8b56 ref_ctr_offset(new): 0x45e8b54
> > #418/1   uprobe_multi_test/skel_api:OK
> >
> > Is this a known issue?
> 
> Yeah, that's not due to my changes. It's an old warning in uprobe
> internals, but I think we should remove it, because it can trivially
> be triggered by a user. Which is what Jiri is doing intentionally in
> one of selftests to test uprobe failure handling.
> 
> Jiri, maybe let's get rid of this warning?

fine with me.. or change to pr_debug if that makes sense for anyone,
Oleg, any idea/preference?

jirka

> 
> >
> > Applied anyway.
> 
> Thanks! I just found another auto-archived patch of mine, the one
> adding multi-uprobe benchmarks (see patchworks). Please take a look
> and maybe apply, when you get a chance.

