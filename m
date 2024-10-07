Return-Path: <bpf+bounces-41161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B1993986
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 23:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6336C283963
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 21:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218918BBBD;
	Mon,  7 Oct 2024 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4AFtj7i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A374C08;
	Mon,  7 Oct 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337631; cv=none; b=pEI5PBXpw7mQdZy1PA0Oa+zmRRfhHDJDocfcj6Ll5VETIqmAkfQyt0wljURlPyEO5OHSg7BbXYja41SU/eTq/evtRIjpwyJI5+Bq+mCzrnWfsi0Ehp3IY16BxepIBnhTbxoT0EMlJtANPoN0udblj2YB40xhuXqUQY+KuMiTfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337631; c=relaxed/simple;
	bh=VcZanQC3m+p7WEESbSdjf5TpbV9z0kDJsFseYvijCbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTrYPbyAGiGGYnF6OnU8H8KBGQFPm9tT3ylgFebM44E3VdvxtNyzgeXAM60OiIPPqbnLk+8t3NjjIPNJESzraMXgf462noV57b60CphsLTQ5As3U80kd9y7ld0rh+XjdSyALxNkf3e4p+AIYtm3sH5ugiOcmE8gJfL9fdGka3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4AFtj7i; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2840bb4a0so17534a91.3;
        Mon, 07 Oct 2024 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728337629; x=1728942429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv3fPD4rUPx3TkUH5lZOgbJDMKhbgUYLdbkXklJNYiA=;
        b=M4AFtj7itgoxwbyU5w45c3+mzx1xlJXJ8/QRTOZiXcJRUNS53GGcMQX4gTCxgj4+8z
         miAw/1rg209wdsi97uqTaz46AnRJEn1SYkaix6+SSYCqtfp58KoJwOr0WgpdQarvCL28
         v/Dipcq8afo1e60QIdpu/MTpQSpJoe3UWHlVRWtdwrmr7v8a5qpPqoNoYWL96afsdkeo
         TI3saAlFTDTGGkOt/oByHQQDlsu5UcYbbdgjZvAdxVLCiHPOtUwCMs614kmTjLn1k8gR
         6MBwRGVCPTkTPObJ5Fj25dNXhna2qHJqAKuBd+3HDw5JroGTHMfTTbiIpO0PH0NRA+ER
         Pzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728337629; x=1728942429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv3fPD4rUPx3TkUH5lZOgbJDMKhbgUYLdbkXklJNYiA=;
        b=IxKw7RwVVpEc0DoNfm2JldYPiB3T0DEn1LWdA5Mdg6d0JWEv4adhLHNcrNZLNrdawy
         uUarJDe4Etu+RacHbN/lTZqYdH5qqXJmBwqwSkQF7t7YjZ3gGLbrf/AoMPXDPM1IMd+p
         7pWGa2SBUp2oG73qKyXdMAHP/s0THeayc12XOLIu5fC4CAJOgIsrbDhewZdSka0XaLlQ
         5bZU3vA3tV0nUZ32ayZW6j2nDhFbM1pmq9FdR8QsNk1p25d86M1OCvpndKgLH1PiZZdy
         gxtMLQV1UnqJcvBGusGKfVWZJyLSUivRVcrA8BMyv8PC38z6t7oivcIGI8abgoHHWVei
         NbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQkzT9Dlia2MaHm2frzSi9CL4k+hMMZ2SnuZzu+md70WYHQj6rSqW+/s7WmZiuI1q+Q3bW9z4puIb1LOf1aP/H@vger.kernel.org, AJvYcCWSZ8at2P8weWFj7pFOD+kLlMOFJJQoiJIjxSLCGsSGDtIRQv+k4QyEpq0iguzMiDdp6aw=@vger.kernel.org, AJvYcCXSWx+f/GAhG3NlGVO4yNwxXHn36PJOT0QDsklGCSI8aWgwJ7DsBvqMy2Z3/YptEvwnYGMQRwYiZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4n2PJcmlddIOWumgOksgYjEG3X/0/vvoeIaOK7+kUAMfFgljG
	0Xpx623pKI95dgZ5po5FOl5gx+lc+UlhMROc0T9aYwubo6GrcfmLixs+SkhwVkSKcmE02qRRN2H
	Ri5Wj9Db1wcPpAqZc2LzhR+dPbtk=
X-Google-Smtp-Source: AGHT+IEiY3L813FikGrucHazYRLlFh++w/y02VGPhAOt7GEsLrRfOvmnC9kn5b6tDYEHvUKmUw/5J87lu5qaiJJiRW4=
X-Received: by 2002:a17:90a:2e89:b0:2e0:8e36:128 with SMTP id
 98e67ed59e1d1-2e1e620f811mr18273694a91.5.1728337624549; Mon, 07 Oct 2024
 14:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
 <ZwBXA6VCcyF-0aPb@x1> <CAEf4Bza3cnyef1VAcGkmP02dBMU_fp=52aS9LknOWhN855-PPQ@mail.gmail.com>
 <87o73vltce.fsf@oracle.com> <ZwQs8K7VUrITuUtO@x1> <ZwQvtCJN5idM92z_@x1>
In-Reply-To: <ZwQvtCJN5idM92z_@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 7 Oct 2024 14:46:52 -0700
Message-ID: <CAEf4BzZ2+s0M6hmNEO33se6Nx2v_uAcyaw4GrMhTJDD+fo6BpA@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 0/4] Emit global variables in BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:00=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Oct 07, 2024 at 03:48:16PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Oct 07, 2024 at 10:24:01AM -0700, Stephen Brennan wrote:
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> > > > On Fri, Oct 4, 2024 at 2:21=E2=80=AFPM Arnaldo Carvalho de Melo <ac=
me@kernel.org> wrote:
> > > >>
> > > >> On Fri, Oct 04, 2024 at 10:26:24AM -0700, Stephen Brennan wrote:
> > > >> > Hi all,
> > > >> >
> > > >> > This is v4 of the series which adds global variables to pahole's=
 generated BTF.
> > > >> >
> > > >> > Since v3:
> > > >> >
> > > >> > 1. Gathered Alan's Reviewed-by + Tested-by, and Jiri's Acked-by.
> > > >> > 2. Consistently start shndx loops at 1, and use size_t.
> > > >> > 3. Since patch 1 of v3 was already applied, I dropped it out of =
this series.
> > > >> >
> > > >> > v3: https://lore.kernel.org/dwarves/20241002235253.487251-1-step=
hen.s.brennan@oracle.com/
> > > >> > v2: https://lore.kernel.org/dwarves/20240920081903.13473-1-steph=
en.s.brennan@oracle.com/
> > > >> > v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-step=
hen.s.brennan@oracle.com/
> > > >> >
> > > >> > Thanks everyone for your review, tests, and consideration!
> > > >>
> > > >> Looks ok, I run the existing regression tests:
> > > >>
> > > >> acme@x1:~/git/pahole$ tests/tests
> > > >>   1: Validation of BTF encoding of functions; this may take some t=
ime: Ok
> > > >>   2: Pretty printing of files using DWARF type information: Ok
> > > >>   3: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> > > >> /home/acme/git/pahole
> > > >> acme@x1:~/git/pahole$
> > > >>
> > > >> And now I'm building a kernel with clang + Thin LTO + Rust enabled=
 in
> > > >> the kernel to test other fixes I have merged and doing that with y=
our
> > > >> patch series.
> > > >>
> > > >> Its all in the next branch and will move to master later today or
> > > >> tomorrow when I finish the clang+LTO+Rust tests.
> > > >
> > > > pahole-staging testing in libbpf CI started failing recently, can y=
ou
> > > > please double-check and see if this was caused by these changes? Th=
ey
> > > > seem to be related to encoding BTF for per-CPU global variables, so
> > > > might be relevant ([0] for full run logs)
> > > >
> > > >   #33      btf_dump:FAIL
> > > >   libbpf: extern (var ksym) 'bpf_prog_active': not found in kernel =
BTF
> > > >   libbpf: failed to load object 'kfunc_call_test_subprog'
> > > >   libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -2=
2
> > > >   test_subprog:FAIL:skel unexpected error: -22
> > > >   #126/17  kfunc_call/subprog:FAIL
> > > >   test_subprog_lskel:FAIL:skel unexpected error: -2
> > > >   #126/18  kfunc_call/subprog_lskel:FAIL
> > > >   #126     kfunc_call:FAIL
> > > >   test_ksyms_module_lskel:FAIL:test_ksyms_module_lskel__open_and_lo=
ad
> > > > unexpected error: -2
> > > >   #135/1   ksyms_module/lskel:FAIL
> > > >   libbpf: extern (var ksym) 'bpf_testmod_ksym_percpu': not found in=
 kernel BTF
> > > >   libbpf: failed to load object 'test_ksyms_module'
> > > >   libbpf: failed to load BPF skeleton 'test_ksyms_module': -22
> > > >   test_ksyms_module_libbpf:FAIL:test_ksyms_module__open unexpected =
error: -22
> > > >   #135/2   ksyms_module/libbpf:FAIL
> > > >
> > > >
> > > >   [0] https://github.com/libbpf/libbpf/actions/runs/11204199648/job=
/31142297399#step:4:12480
> > >
> > > Hi Andrii,
> > >
> > > Thanks for the report.
> > >
> > > The error: "'bpf_prog_active' not found in kernel BTF" sounds like it=
's
> > > related to a bug that was present in v4 of this patch series:
> > >
> > > https://lore.kernel.org/dwarves/ZwPob57HKYbfNpOH@x1/T/#t
> > >
> > > Basically due to poor testing of a small refactor on my part, pahole
> > > failed to emit almost all of the variables for BTF, so it would very
> > > likely cause this error. And I think this broken commit may have been
> > > hanging around in the git repository for the weekend, maybe Arnaldo c=
an
> > > confirm whether or not it was fixed up.
> > >
> > > I cannot see the git SHA for the pahole branch which was used in this=
 CI
> > > run, so I can't say for sure. But I do see that the "tmp.master" bran=
ch
> > > is now fixed up, so a re-run would verify whether this is the root
> > > cause.
> >
> > right, that is a piece of info I sometimes miss, the SHA used for the
> > test run, but today's test is in progress and should have the fix for
> > the inverted logic, we'll see...
>
> https://github.com/libbpf/libbpf/actions/runs/11221662157/job/31192457160
>
> Passed, so and here as well:

Ok, great! Seems like I was either too slow or too fast with reporting
this, depending how you look at this :)

>
> acme@x1:~/git/pahole$ tests/tests
>   1: Validation of BTF encoding of functions; this may take some time: Ok
>   2: Pretty printing of files using DWARF type information: Ok
>   3: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> acme@x1:~/git/pahole$
>
> - Arnaldo

