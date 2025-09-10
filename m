Return-Path: <bpf+bounces-68020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87DFB5191E
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805A74653E1
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D413531B127;
	Wed, 10 Sep 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1yccfSE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F91F3BAC
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513949; cv=none; b=NSotaiafdPYdJDsSHOu2wJ4JtpQ1cS3Zo1yUCA9hNabJ/tBHGPNTdDBY7rDg0nEmGUOUzmV3XX3NqUAqCnO8iNU5UxUIahXYZJcZYStZMUn7PUv+PCjPfA71kwQFb0hQ04kUnQ1x/MHyFxkN2e9K8uC0IMx/MXmBKEeZBBdU2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513949; c=relaxed/simple;
	bh=Pg7JOkezErhBpzIfIBEvXYS2qqBCkHHelBeni8RBf9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSJXgMmhi1TaYY7gPNRJBhUmBockNBo0nKu0HSzCPH/gaqRxkbq+7CQVBuKVSnXMG9TqSf3qEy7nItkxsA3FGMjXf2wrI4mJLcQnVvu8N5mKT0hqt3KLqCXkJz54IzWylMIKxVDJMUTUb+FQe880b2CKEikqVMlQSrkmUgzQT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1yccfSE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32db52f2f07so1353396a91.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513946; x=1758118746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh8nAV3aFTnZMHtYWJctZ9QfqEPL93lGAPL0Bx/B3rY=;
        b=i1yccfSEr9V3AO6j3GydKeLOKMy+2VAsBJBSDaqSWctUYhBV92xQblh5g8BPjRp/4B
         zVhZEDYm5GDhUm7J1hfPSyoeKEYP74aLgg6tL2yBNAPopmeGMPQ9dzzrIX3fkIJpTT6g
         I3Mxu07PiP/9uQFKlmuGMRiHMwj/0hKOmD9HbxQGcujJwRBX9/aRCqh3m7xfqaaKT9RX
         x1uxFXxnn8K+a83Acok5jgyUjl8E23dJuF0+by3FDFELO2RiYG0IvlILs3gkrZOUxYaF
         WYYNsjGMw6NSzPR3E9MRH1QauAzmowYbK22Yf2cKnP2fEn5yYnNuHXIiw5RIzA6/7LJC
         +1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513946; x=1758118746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rh8nAV3aFTnZMHtYWJctZ9QfqEPL93lGAPL0Bx/B3rY=;
        b=oi9OGR3MFgIw03/MBkzksrnChaiBRlrl2LxXfnbW5Ebyk/8VQ59VF1xy4NkC9gQvX7
         tFBIJI13W4XwQ1rQ+MMUdg8scksKgT0G9UlRFaZOvkghPRZEzWi2829hlKlgTAPUMo6m
         uJxr8ZtJ1xG5M4xw/FuqjE61cIyAX5aH+pPLHwJ1fomd3O7Au8ITWNpSdUPqfsbzlkUG
         1RLL7diFQGuoSgpaSwB2NN6TGc3QyFet0KUOnS/Mu75AlvM+Ho/YG642J3D4YyZfxgdY
         9kL6Jn6wjHqucZNAPE/01evQvvdxYOe61mCfix5s0KJov/Kryiw93bINaPywIjbKCTeT
         u0eg==
X-Forwarded-Encrypted: i=1; AJvYcCVAlQrQMsc7HdNjkaPe2AaFSpKqL0lhS7FaEJewDOXSR/1DDDlHmO7UMPjioPzmyuA1wDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfR2ZOZQAmWxXoG3EJC/kdtseCWMcD+o+/g+gASRFjy3vzovhJ
	5Yc13oxDNY76Ckh/ANYsNe+qSg4an5+zwxTGkr4QE1vzr/4AqvPhd2+gbkESTlYzy/UfuLMY+bh
	LjvlbB7tZG2Qx9vraBgoAn6BGY+2Mmz7MTg==
X-Gm-Gg: ASbGncuINIuFkegVknrsEszBreV79RSzrLm39t4XJQqk+X594oT03Sp464QaIu6Pqn+
	diQ1nbOncoJrpgmKqQtl2Sl6e/oUUnl2NKzIhZrO/d1qHnfM+qGAT8VwhEhos034hxHk3I4TMtW
	mwgHvhb2tdn4kiZaw9SM8Qpzt1cdrPnkfXajf04Pg8s7T3O6uhoAWH3UcbFnY1wDkvURdCy3eta
	3SHs/LrNq2GhYEYbcTYfvJu88I2gT9I4Q==
X-Google-Smtp-Source: AGHT+IHCmvPLMq7lOIbxpl3oO0snKwGDgaF1MlhGdVQmfuq1SXhNOE0Fgj6CiOiB3RloShJcunriA+1+yzs0aEfswLI=
X-Received: by 2002:a17:90b:530b:b0:329:e1d0:3bf6 with SMTP id
 98e67ed59e1d1-32d43ee2f03mr20691025a91.6.1757513946359; Wed, 10 Sep 2025
 07:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-11-andrii@kernel.org>
 <ZqJBK4loBv030jj_@krava> <CAEf4BzZkGur_zPrPCEo6=asFGO1uBShvf1wwEoBhaKk-46ctAQ@mail.gmail.com>
 <ZqOWGvrrubXbVDlY@krava> <CAEf4BzbF+Q14fW-z2Fg02AEcFaF+dU53FVpDO_K_Tz-xQP_k5g@mail.gmail.com>
 <ZqaeOl8c_Jwl3ieR@krava> <CAEf4BzZtu_LWu82z9RFDf00a77uJuEpqYtuJWqz2zvm8jG3UWA@mail.gmail.com>
 <aMEWKR2QPQtRMxp7@linux.ibm.com>
In-Reply-To: <aMEWKR2QPQtRMxp7@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Sep 2025 10:18:53 -0400
X-Gm-Features: Ac12FXyWJ3nz5W3iVItOC7SDdjR2FskkSKR8cVcSR4_iebdyRkF50CchuGmDBHM
Message-ID: <CAEf4BzYWVtfZh07iQm5Fo=kMm+8hgAu+rXRx1uLRHz07wc59+Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, ak@linux.intel.com, 
	osandov@osandov.com, song@kernel.org, hbathini@linux.ibm.com, 
	donettom@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 2:10=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On Tue, Jul 30, 2024 at 01:03:17PM -0700, Andrii Nakryiko wrote:
> > On Sun, Jul 28, 2024 at 12:38=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> > >
> > > On Fri, Jul 26, 2024 at 05:37:55PM -0700, Andrii Nakryiko wrote:
> > > > On Fri, Jul 26, 2024 at 5:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.c=
om> wrote:
> > > > >
> > > > > On Thu, Jul 25, 2024 at 01:03:55PM -0700, Andrii Nakryiko wrote:
> > > > > > On Thu, Jul 25, 2024 at 5:12=E2=80=AFAM Jiri Olsa <olsajiri@gma=
il.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jul 24, 2024 at 03:52:10PM -0700, Andrii Nakryiko wro=
te:
> > > > > > > > Add a new set of tests validating behavior of capturing sta=
ck traces
> > > > > > > > with build ID. We extend uprobe_multi target binary with ab=
ility to
> > > > > > > > trigger uprobe (so that we can capture stack traces from it=
), but also
> > > > > > > > we allow to force build ID data to be either resident or no=
n-resident in
> > > > > > > > memory (see also a comment about quirks of MADV_PAGEOUT).
> > > > > > > >
> > > > > > > > That way we can validate that in non-sleepable context we w=
on't get
> > > > > > > > build ID (as expected), but with sleepable uprobes we will =
get that
> > > > > > > > build ID regardless of it being physically present in memor=
y.
> > > > > > > >
> > > > > > > > Also, we add a small add-on linker script which reorders
> > > > > > > > .note.gnu.build-id section and puts it after (big) .text se=
ction,
> > > > > > > > putting build ID data outside of the very first page of ELF=
 file. This
> > > > > > > > will test all the relaxations we did in build ID parsing lo=
gic in kernel
> > > > > > > > thanks to freader abstraction.
> > > > > > > >
> > > > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > > >
> > > > > > > one of my bpf selftests runs showed:
> > > > > > >
> > > > > > > test_build_id:PASS:parse_build_id 0 nsec
> > > > > > > subtest_nofault:PASS:skel_open 0 nsec
> > > > > > > subtest_nofault:PASS:link 0 nsec
> > > > > > > subtest_nofault:PASS:trigger_uprobe 0 nsec
> > > > > > > subtest_nofault:PASS:res 0 nsec
> > > > > > > subtest_nofault:FAIL:build_id_status unexpected build_id_stat=
us: actual 1 !=3D expected 2
> > > > > > > #42/1    build_id/nofault-paged-out:FAIL
> > > > > > > #42/2    build_id/nofault-paged-in:OK
> > > > > > > #42/3    build_id/sleepable:OK
> > > > > > > #42      build_id:FAIL
> > > > > > >
> > > > > > > I could never reproduce again.. but I wonder the the page cou=
ld sneak
> > > > > > > in before the bpf program is hit and the buildid will get par=
sed?
> > > > > > >
> > > > > >
> > > > > > Yes, and I just realized that I forgot to mark this test as ser=
ial. If
> > > > > > there is parallel test that also runs uprobe_multi and that cau=
ses
> > > > > > build_id page to be paged in into page cache, then this might s=
ucceed.
> > > > > > So I need to mark the test itself serial.
> > > > > >
> > > > > > Another issue which I was debugging (and fixed) yesterday was t=
hat if
> > > > > > the memory passed for MADV_PAGEOUT is not yet memory mapped int=
o the
> > > > > > current process, then it won't be really removed from the page =
cache.
> > > > > > I avoid that by first paging it in, and then MADV_PAGEOUT.
> > > > >
> > > > > ok, I triggered that in serial run, so I probably hit this one
> > > > >
> > > >
> > > > you did it with v2 of the patch set? I had this bug in v1, but v2
> > > > should be fine, as far as I understand (due to unconditional
> > > > madvise(addr, page_sz, MADV_POPULATE_READ); before madvise(addr,
> > > > page_sz, MADV_PAGEOUT)). At least I haven't been able to reproduce
> > > > that anymore and BPF CI is now happy as well.
> > >
> > > yes, it's with v2 and I can still see that.. but only for the first r=
un of
> > > the test after reboot.. so far I have no clue.. I can see the success=
ful
> > > page-out madvise (still not sure how much is that telling about the p=
age
> > > being paged out), and then the build id code sees the page just fine
> > >
> > > attaching my .config in case
> > >
> >
> > I wasn't able to repro this, sorry. It works very reliably for me with
> > your or my config. Given it also seems to work reliably in BPF CI, I'm
> > still inclined to add this tests, I think it's good to have that
> > coverage.
> >
> > I'll monitor, and if it becomes flaky, we'll need to reassess this, of =
course.
> >
> Hi Andrii and Jirka,
>
> I encountered this error on powerpc, which is happening quiet consistentl=
y:
>
> # ./test_progs -t build_id/nofault-paged-out
> serial_test_build_id:PASS:parse_build_id 0 nsec
> subtest_nofault:PASS:skel_open 0 nsec
> subtest_nofault:PASS:link 0 nsec
> subtest_nofault:PASS:trigger_uprobe 0 nsec
> subtest_nofault:PASS:res 0 nsec
> subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1=
 !=3D expected 2
> #46/1    build_id/nofault-paged-out:FAIL
> #46      build_id:FAIL
> #397     stacktrace_build_id:OK
> #398     stacktrace_build_id_nmi:OK
>
> I dumped vma mapping using pmap in trigger_uprobe function
> before/after MADV_POPULATE_READ and b/w MADV_POPULATE_READ
> and MADV_PAGEOUT, page residency using mincore() (as shown
> "Before uprobe: Page residency =3D ") and addr (as shown
> "Entered trigger_uprobe addr ->").
>
> Here I am putting out 3 scenarios:
>
> 1. #./test_progs -t build_id/nofault-paged-out
> Entered trigger_uprobe addr -> 0x105a0000
> 144992:   ./uprobe_multi uprobe-paged-out
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000010000000    7744     704      64 r-x-- uprobe_multi
> 0000000010790000      64      64      64 r---- uprobe_multi
> 00000000107a0000      64      64      64 rw--- uprobe_multi
> 000001002bf90000     192      64      64 rw---   [ anon ]
> 00007fffb55d0000     832      64       0 r-x-- libzstd.so.1.5.5
> 00007fffb56a0000      64      64      64 r---- libzstd.so.1.5.5
> 00007fffb56b0000      64      64      64 rw--- libzstd.so.1.5.5
> 00007fffb56c0000    2304    1280       0 r-x-- libc.so.6
> 00007fffb5900000      64      64      64 r---- libc.so.6
> 00007fffb5910000      64      64      64 rw--- libc.so.6
> 00007fffb5920000     192      64       0 r-x-- libz.so.1.3.1.zlib-ng
> 00007fffb5950000      64      64      64 r---- libz.so.1.3.1.zlib-ng
> 00007fffb5960000      64      64      64 rw--- libz.so.1.3.1.zlib-ng
> 00007fffb5970000     192      64       0 r-x-- libelf-0.192.so
> 00007fffb59a0000      64      64      64 r---- libelf-0.192.so
> 00007fffb59b0000      64       0       0 rw---   [ anon ]
> 00007fffb59d0000     256       0       0 r----   [ anon ]
> 00007fffb5a10000      64      64       0 r-x--   [ anon ]
> 00007fffb5a20000     320     320       0 r-x-- ld64.so.2
> 00007fffb5a70000      64      64      64 r---- ld64.so.2
> 00007fffb5a80000      64      64      64 rw--- ld64.so.2
> 00007fffee7a0000     192      64      64 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB           13056    3392     896
> 144992:   ./uprobe_multi uprobe-paged-out
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000010000000    7744     704      64 r-x-- uprobe_multi
> 0000000010790000      64      64      64 r---- uprobe_multi
> 00000000107a0000      64      64      64 rw--- uprobe_multi
> 000001002bf90000     192      64      64 rw---   [ anon ]
> 00007fffb55d0000     832      64       0 r-x-- libzstd.so.1.5.5
> 00007fffb56a0000      64      64      64 r---- libzstd.so.1.5.5
> 00007fffb56b0000      64      64      64 rw--- libzstd.so.1.5.5
> 00007fffb56c0000    2304    1344       0 r-x-- libc.so.6
> 00007fffb5900000      64      64      64 r---- libc.so.6
> 00007fffb5910000      64      64      64 rw--- libc.so.6
> 00007fffb5920000     192      64       0 r-x-- libz.so.1.3.1.zlib-ng
> 00007fffb5950000      64      64      64 r---- libz.so.1.3.1.zlib-ng
> 00007fffb5960000      64      64      64 rw--- libz.so.1.3.1.zlib-ng
> 00007fffb5970000     192      64       0 r-x-- libelf-0.192.so
> 00007fffb59a0000      64      64      64 r---- libelf-0.192.so
> 00007fffb59b0000      64       0       0 rw---   [ anon ]
> 00007fffb59d0000     256       0       0 r----   [ anon ]
> 00007fffb5a10000      64      64       0 r-x--   [ anon ]
> 00007fffb5a20000     320     320       0 r-x-- ld64.so.2
> 00007fffb5a70000      64      64      64 r---- ld64.so.2
> 00007fffb5a80000      64      64      64 rw--- ld64.so.2
> 00007fffee7a0000     192      64      64 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB           13056    3456     896
> 144992:   ./uprobe_multi uprobe-paged-out
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000010000000    7744     704      64 r-x-- uprobe_multi
> 0000000010790000      64      64      64 r---- uprobe_multi
> 00000000107a0000      64      64      64 rw--- uprobe_multi
> 000001002bf90000     192      64      64 rw---   [ anon ]
> 00007fffb55d0000     832      64       0 r-x-- libzstd.so.1.5.5
> 00007fffb56a0000      64      64      64 r---- libzstd.so.1.5.5
> 00007fffb56b0000      64      64      64 rw--- libzstd.so.1.5.5
> 00007fffb56c0000    2304    1344       0 r-x-- libc.so.6
> 00007fffb5900000      64      64      64 r---- libc.so.6
> 00007fffb5910000      64      64      64 rw--- libc.so.6
> 00007fffb5920000     192      64       0 r-x-- libz.so.1.3.1.zlib-ng
> 00007fffb5950000      64      64      64 r---- libz.so.1.3.1.zlib-ng
> 00007fffb5960000      64      64      64 rw--- libz.so.1.3.1.zlib-ng
> 00007fffb5970000     192      64       0 r-x-- libelf-0.192.so
> 00007fffb59a0000      64      64      64 r---- libelf-0.192.so
> 00007fffb59b0000      64       0       0 rw---   [ anon ]
> 00007fffb59d0000     256       0       0 r----   [ anon ]
> 00007fffb5a10000      64      64       0 r-x--   [ anon ]
> 00007fffb5a20000     320     320       0 r-x-- ld64.so.2
> 00007fffb5a70000      64      64      64 r---- ld64.so.2
> 00007fffb5a80000      64      64      64 rw--- ld64.so.2
> 00007fffee7a0000     192      64      64 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB           13056    3456     896
> Before uprobe: Page residency =3D resident
> After uprobe: Page residency =3D resident
> serial_test_build_id:PASS:parse_build_id 0 nsec
> subtest_nofault:PASS:skel_open 0 nsec
> subtest_nofault:PASS:link 0 nsec
> subtest_nofault:PASS:trigger_uprobe 0 nsec
> subtest_nofault:PASS:res 0 nsec
> subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1=
 !=3D expected 2
> #46/1    build_id/nofault-paged-out:FAIL
> #46      build_id:FAIL
> #397     stacktrace_build_id:OK
> #398     stacktrace_build_id_nmi:OK
>
> All error logs:
> serial_test_build_id:PASS:parse_build_id 0 nsec
> subtest_nofault:PASS:skel_open 0 nsec
> subtest_nofault:PASS:link 0 nsec
> subtest_nofault:PASS:trigger_uprobe 0 nsec
> subtest_nofault:PASS:res 0 nsec
> subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1=
 !=3D expected 2
> #46/1    build_id/nofault-paged-out:FAIL
> #46      build_id:FAIL
> Summary: 2/0 PASSED, 0 SKIPPED, 1 FAILED
>
> Here it can be seen that RSS for vma containing addr (0x105a0000)
> is not changing (remains 704) and the selftest fails.
>
> 2. When alignment in linker script is changed to 65536 (default
>    page size in powerpc is 64k):
>
> git diff uprobe_multi.ld
> diff --git a/tools/testing/selftests/bpf/uprobe_multi.ld b/tools/testing/=
selftests/bpf/uprobe_multi.ld
> index a2e94828b..2063714b2 100644
> --- a/tools/testing/selftests/bpf/uprobe_multi.ld
> +++ b/tools/testing/selftests/bpf/uprobe_multi.ld
> @@ -1,8 +1,8 @@
>  SECTIONS
>  {
> -       . =3D ALIGN(4096);
> +       . =3D ALIGN(65536);
>         .note.gnu.build-id : { *(.note.gnu.build-id) }
> -       . =3D ALIGN(4096);
> +       . =3D ALIGN(65536);
>  }
>  INSERT AFTER .text;
>
> #./test_progs -t build_id/nofault-paged-out -v
> bpf_testmod.ko is already unloaded.
> Loading bpf_testmod.ko...
> Successfully loaded bpf_testmod.ko.
> serial_test_build_id:PASS:parse_build_id 0 nsec
> subtest_nofault:PASS:skel_open 0 nsec
> subtest_nofault:PASS:link 0 nsec
> Entered trigger_uprobe addr -> 0x105b0000
> 145238:   ./uprobe_multi uprobe-paged-out
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000010000000    7872     768     768 r-x-- uprobe_multi
> 00000000107b0000      64      64      64 r---- uprobe_multi
> 00000000107c0000      64      64      64 rw--- uprobe_multi
> 000001003a6b0000     192      64      64 rw---   [ anon ]
> 00007fffa3eb0000     832      64       0 r-x-- libzstd.so.1.5.5
> 00007fffa3f80000      64      64      64 r---- libzstd.so.1.5.5
> 00007fffa3f90000      64      64      64 rw--- libzstd.so.1.5.5
> 00007fffa3fa0000    2304    1280       0 r-x-- libc.so.6
> 00007fffa41e0000      64      64      64 r---- libc.so.6
> 00007fffa41f0000      64      64      64 rw--- libc.so.6
> 00007fffa4200000     192      64       0 r-x-- libz.so.1.3.1.zlib-ng
> 00007fffa4230000      64      64      64 r---- libz.so.1.3.1.zlib-ng
> 00007fffa4240000      64      64      64 rw--- libz.so.1.3.1.zlib-ng
> 00007fffa4250000     192      64       0 r-x-- libelf-0.192.so
> 00007fffa4280000      64      64      64 r---- libelf-0.192.so
> 00007fffa4290000      64       0       0 rw---   [ anon ]
> 00007fffa42b0000     256       0       0 r----   [ anon ]
> 00007fffa42f0000      64      64       0 r-x--   [ anon ]
> 00007fffa4300000     320     320       0 r-x-- ld64.so.2
> 00007fffa4350000      64      64      64 r---- ld64.so.2
> 00007fffa4360000      64      64      64 rw--- ld64.so.2
> 00007fffc6880000     192      64      64 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB           13184    3456    1600
> 145238:   ./uprobe_multi uprobe-paged-out
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000010000000    7872     832     832 r-x-- uprobe_multi
> 00000000107b0000      64      64      64 r---- uprobe_multi
> 00000000107c0000      64      64      64 rw--- uprobe_multi
> 000001003a6b0000     192      64      64 rw---   [ anon ]
> 00007fffa3eb0000     832      64       0 r-x-- libzstd.so.1.5.5
> 00007fffa3f80000      64      64      64 r---- libzstd.so.1.5.5
> 00007fffa3f90000      64      64      64 rw--- libzstd.so.1.5.5
> 00007fffa3fa0000    2304    1344       0 r-x-- libc.so.6
> 00007fffa41e0000      64      64      64 r---- libc.so.6
> 00007fffa41f0000      64      64      64 rw--- libc.so.6
> 00007fffa4200000     192      64       0 r-x-- libz.so.1.3.1.zlib-ng
> 00007fffa4230000      64      64      64 r---- libz.so.1.3.1.zlib-ng
> 00007fffa4240000      64      64      64 rw--- libz.so.1.3.1.zlib-ng
> 00007fffa4250000     192      64       0 r-x-- libelf-0.192.so
> 00007fffa4280000      64      64      64 r---- libelf-0.192.so
> 00007fffa4290000      64       0       0 rw---   [ anon ]
> 00007fffa42b0000     256       0       0 r----   [ anon ]
> 00007fffa42f0000      64      64       0 r-x--   [ anon ]
> 00007fffa4300000     320     320       0 r-x-- ld64.so.2
> 00007fffa4350000      64      64      64 r---- ld64.so.2
> 00007fffa4360000      64      64      64 rw--- ld64.so.2
> 00007fffc6880000     192      64      64 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB           13184    3584    1664
> 145238:   ./uprobe_multi uprobe-paged-out
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000010000000    7872     768     768 r-x-- uprobe_multi
> 00000000107b0000      64      64      64 r---- uprobe_multi
> 00000000107c0000      64      64      64 rw--- uprobe_multi
> 000001003a6b0000     192      64      64 rw---   [ anon ]
> 00007fffa3eb0000     832      64       0 r-x-- libzstd.so.1.5.5
> 00007fffa3f80000      64      64      64 r---- libzstd.so.1.5.5
> 00007fffa3f90000      64      64      64 rw--- libzstd.so.1.5.5
> 00007fffa3fa0000    2304    1344       0 r-x-- libc.so.6
> 00007fffa41e0000      64      64      64 r---- libc.so.6
> 00007fffa41f0000      64      64      64 rw--- libc.so.6
> 00007fffa4200000     192      64       0 r-x-- libz.so.1.3.1.zlib-ng
> 00007fffa4230000      64      64      64 r---- libz.so.1.3.1.zlib-ng
> 00007fffa4240000      64      64      64 rw--- libz.so.1.3.1.zlib-ng
> 00007fffa4250000     192      64       0 r-x-- libelf-0.192.so
> 00007fffa4280000      64      64      64 r---- libelf-0.192.so
> 00007fffa4290000      64       0       0 rw---   [ anon ]
> 00007fffa42b0000     256       0       0 r----   [ anon ]
> 00007fffa42f0000      64      64       0 r-x--   [ anon ]
> 00007fffa4300000     320     320       0 r-x-- ld64.so.2
> 00007fffa4350000      64      64      64 r---- ld64.so.2
> 00007fffa4360000      64      64      64 rw--- ld64.so.2
> 00007fffc6880000     192      64      64 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB           13184    3520    1600
> Before uprobe: Page residency =3D resident
> After uprobe: Page residency =3D resident
> subtest_nofault:PASS:trigger_uprobe 0 nsec
> subtest_nofault:PASS:res 0 nsec
> FRAME #00: BUILD ID =3D 4f635d1d48e4f2b67b62a9a07285668cdc85fb18 OFFSET =
=3D 2c3f1c
> FRAME #01: BUILD ID =3D 4f635d1d48e4f2b67b62a9a07285668cdc85fb18 OFFSET =
=3D 5a0824
> FRAME #02: BUILD ID =3D 4f635d1d48e4f2b67b62a9a07285668cdc85fb18 OFFSET =
=3D 5a0994
> FRAME #03: BUILD ID =3D 09139ae1e5cbaf5c598222698e5b8e2e250260b1 OFFSET =
=3D 2aba4
> FRAME #04: BUILD ID =3D 09139ae1e5cbaf5c598222698e5b8e2e250260b1 OFFSET =
=3D 2adec
> FRAME #05: BUILD ID =3D 4f635d1d48e4f2b67b62a9a07285668cdc85fb18 OFFSET =
=3D fffffffff0000000
> subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1=
 !=3D expected 2
> #46/1    build_id/nofault-paged-out:FAIL
> #46      build_id:FAIL
>
> Here RSS changes(768 -> 832 -> 768) but looks like page is still
> not getting evicted (as shown "Before uprobe: Page residency =3D resident=
")
> after MADV_PAGEOUT and the selftest fails.
>
> 3. But in the very next run page is evicted and selftest passes:
>
> #./test_progs -t build_id/nofault-paged-out
> Entered trigger_uprobe addr -> 0x105b0000
> 145256:   ./uprobe_multi uprobe-paged-out
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000010000000    7872     768      64 r-x-- uprobe_multi
> 00000000107b0000      64      64      64 r---- uprobe_multi
> 00000000107c0000      64      64      64 rw--- uprobe_multi
> 00000100317b0000     192      64      64 rw---   [ anon ]
> 00007fffa5cd0000     832      64       0 r-x-- libzstd.so.1.5.5
> 00007fffa5da0000      64      64      64 r---- libzstd.so.1.5.5
> 00007fffa5db0000      64      64      64 rw--- libzstd.so.1.5.5
> 00007fffa5dc0000    2304    1280       0 r-x-- libc.so.6
> 00007fffa6000000      64      64      64 r---- libc.so.6
> 00007fffa6010000      64      64      64 rw--- libc.so.6
> 00007fffa6020000     192      64       0 r-x-- libz.so.1.3.1.zlib-ng
> 00007fffa6050000      64      64      64 r---- libz.so.1.3.1.zlib-ng
> 00007fffa6060000      64      64      64 rw--- libz.so.1.3.1.zlib-ng
> 00007fffa6070000     192      64       0 r-x-- libelf-0.192.so
> 00007fffa60a0000      64      64      64 r---- libelf-0.192.so
> 00007fffa60b0000      64       0       0 rw---   [ anon ]
> 00007fffa60d0000     256       0       0 r----   [ anon ]
> 00007fffa6110000      64      64       0 r-x--   [ anon ]
> 00007fffa6120000     320     320       0 r-x-- ld64.so.2
> 00007fffa6170000      64      64      64 r---- ld64.so.2
> 00007fffa6180000      64      64      64 rw--- ld64.so.2
> 00007ffff1890000     192      64      64 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB           13184    3456     896
> 145256:   ./uprobe_multi uprobe-paged-out
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000010000000    7872     832      64 r-x-- uprobe_multi
> 00000000107b0000      64      64      64 r---- uprobe_multi
> 00000000107c0000      64      64      64 rw--- uprobe_multi
> 00000100317b0000     192      64      64 rw---   [ anon ]
> 00007fffa5cd0000     832      64       0 r-x-- libzstd.so.1.5.5
> 00007fffa5da0000      64      64      64 r---- libzstd.so.1.5.5
> 00007fffa5db0000      64      64      64 rw--- libzstd.so.1.5.5
> 00007fffa5dc0000    2304    1344       0 r-x-- libc.so.6
> 00007fffa6000000      64      64      64 r---- libc.so.6
> 00007fffa6010000      64      64      64 rw--- libc.so.6
> 00007fffa6020000     192      64       0 r-x-- libz.so.1.3.1.zlib-ng
> 00007fffa6050000      64      64      64 r---- libz.so.1.3.1.zlib-ng
> 00007fffa6060000      64      64      64 rw--- libz.so.1.3.1.zlib-ng
> 00007fffa6070000     192      64       0 r-x-- libelf-0.192.so
> 00007fffa60a0000      64      64      64 r---- libelf-0.192.so
> 00007fffa60b0000      64       0       0 rw---   [ anon ]
> 00007fffa60d0000     256       0       0 r----   [ anon ]
> 00007fffa6110000      64      64       0 r-x--   [ anon ]
> 00007fffa6120000     320     320       0 r-x-- ld64.so.2
> 00007fffa6170000      64      64      64 r---- ld64.so.2
> 00007fffa6180000      64      64      64 rw--- ld64.so.2
> 00007ffff1890000     192      64      64 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB           13184    3584     896
> 145256:   ./uprobe_multi uprobe-paged-out
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000010000000    7872     768      64 r-x-- uprobe_multi
> 00000000107b0000      64      64      64 r---- uprobe_multi
> 00000000107c0000      64      64      64 rw--- uprobe_multi
> 00000100317b0000     192      64      64 rw---   [ anon ]
> 00007fffa5cd0000     832      64       0 r-x-- libzstd.so.1.5.5
> 00007fffa5da0000      64      64      64 r---- libzstd.so.1.5.5
> 00007fffa5db0000      64      64      64 rw--- libzstd.so.1.5.5
> 00007fffa5dc0000    2304    1344       0 r-x-- libc.so.6
> 00007fffa6000000      64      64      64 r---- libc.so.6
> 00007fffa6010000      64      64      64 rw--- libc.so.6
> 00007fffa6020000     192      64       0 r-x-- libz.so.1.3.1.zlib-ng
> 00007fffa6050000      64      64      64 r---- libz.so.1.3.1.zlib-ng
> 00007fffa6060000      64      64      64 rw--- libz.so.1.3.1.zlib-ng
> 00007fffa6070000     192      64       0 r-x-- libelf-0.192.so
> 00007fffa60a0000      64      64      64 r---- libelf-0.192.so
> 00007fffa60b0000      64       0       0 rw---   [ anon ]
> 00007fffa60d0000     256       0       0 r----   [ anon ]
> 00007fffa6110000      64      64       0 r-x--   [ anon ]
> 00007fffa6120000     320     320       0 r-x-- ld64.so.2
> 00007fffa6170000      64      64      64 r---- ld64.so.2
> 00007fffa6180000      64      64      64 rw--- ld64.so.2
> 00007ffff1890000     192      64      64 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB           13184    3520     896
> Before uprobe: Page residency =3D paged out
> After uprobe: Page residency =3D paged out
> #46/1    build_id/nofault-paged-out:OK
> #46      build_id:OK
> #397     stacktrace_build_id:OK
> #398     stacktrace_build_id_nmi:OK
> Summary: 3/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Here it can be seen that page is evicted (as shown
> "Before uprobe: Page residency =3D paged out").
>
> Although the selftest occasionally passes, its behavior
> remains flaky and unreliable across runs. But introducing
> a sleep before/after both MADV_POPULATE_READ and MADV_PAGEOUT
> tends to improve the consistency with which the selftest passes.
>
> Your valuable suggestions or thoughts on how best to address/debug
> this further would be helpful.
>

How do you check page residency? Instead of just sleeping, I'd add the
code that just waits for the page to be non-resident (with some
reasonable time out in case of bugs), and wait until that condition
happens. (And of course let's increase alignment to 64KB, it has to be
page-aligned across supported architectures).

> Regards,
> Saket
> > > jirka
> > >
> > >
> > > ----
> > > #
> > > # Automatically generated file; DO NOT EDIT.
> > > # Linux/x86 6.10.0 Kernel Configuration
> > > #
> >
> > [...]
> >

