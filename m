Return-Path: <bpf+bounces-49218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F28A15619
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E6A3A1494
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0BF1A256E;
	Fri, 17 Jan 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD3iOxgQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095C188A18
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136617; cv=none; b=J7tHRinZTLS6OFQCW3ItMjuahl5WicZ2ev7W67OXLwcvp7+uZc7fco9Kx3bVlZspdjjiQO0d4WKonmLGGk5csB8Ipz7tRlLOi7koy5BSTNdFQ6RYCF6JPLz/eASAk37spC4diXSDAx7BHWX3KFx3ehDexZFZz42cAfB3dOenlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136617; c=relaxed/simple;
	bh=Ap04WDwKRAMsD4i4d3XEns5YX3FBp5hu8Jw5/8b4NYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kO9WMc6CYAEpwh04oz1gySJyq+8igyWiekt7+1VsXD1dsBacGfsTV5Q/1g/UP9CC0wqYXv+6is6WtGlOF2pxWo5LekVnEkOKiWwP8knMjmRxnJFByp4WMXNHYsbJH4QEAWw6QTFPGhCL0TdvAT82XuBrHIDIAMuXDqwqTJtfXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD3iOxgQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2efded08c79so3459565a91.0
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 09:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737136615; x=1737741415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHSq3NOiSuaS4b/08NNL65VMPKLJC24+3ZIVspEPBH8=;
        b=GD3iOxgQa1oHrFaMiAyS0OeWoTNxmbzTBRDa/repkkYdk1l06k+ixAMdDkky5OR0r6
         O7DY/lS5sg4CSOqu2W7kqcl2+jy109sDBsGN6NA9HydI8RXGiyvBQi+/SO/ZXvAYGk6b
         xaW1R+GcehywX3XZMJyoRvWrGFIFyw5Dxkgd2MkPgw98xBBioBz77R4iRQO1yUJE22lh
         sysj4YudKqOJTpmTIfsNzV76Ko02Dmq4h/u+lDvR41o31RmBEZNzkBh74yCgByQC7zqj
         koHIIK4oFi1OeGP+gEyc0B9ulZXnDxau6JDFHLFP9vp8SQBOot5KqSlpGhJozhJ2lwRm
         NPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136615; x=1737741415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHSq3NOiSuaS4b/08NNL65VMPKLJC24+3ZIVspEPBH8=;
        b=wTW1UC/P2ziUiD/5r2TA1BljsOCQHQFzBeNkW2qsvlTHH3249Nrvvg0mVQ9Bjq8iZW
         7JG9lUAX9kvFT68aL83IgFmU0J5Nr+liIWpqU0prFoHzCZhRoSgQMnCzhW2N0x4z9jaM
         RVC+kj0krpjh6WTkdWlfC0YlpMeDw6gPN8T6PlpFiFDW9ClrtlmlwMJmcNYR847JxbZt
         nu7mOXdM85wOKyS88ZuzySzKOeLZWCn0eQpiwnEQE27WI4cSP/I2USzULm2HH50o4BBU
         e8l2Pr7MkLHM0eXFY271vheO+Ah/0Z5LVgbmGSWKMTZZYaWuTzIhgBq6xS9s5b2//XmO
         5icQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnSpBwdxUxH2ea+p/jKdMvc+FGcaYpKbVIRpIrsPGn9mRHjhFXIb0uKOAf/fMpqHqVAzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXeel4/6WD1LKz9k4y+Rzo3bVmp1GVqjVm7UNR40x/b0oN2qf
	RYjhLDwWN85tG2Vtcq1cDVrBQSnwnS/P2KquHv/ZxRKzMs3EhNJA46lB9BNC9eF7QVI4qBIdx+w
	migzi4T9prSOW7Pb/zZ6XQ6vlLoQ=
X-Gm-Gg: ASbGncuEtiAGC0hoUzLqTjZXD2uLL77apjRz/K+PB+weMEruchirPJ7pTT2V1g5Hlf/
	SbZ5pLNoD4jJD4Q8lv5bDCvDxogin9/0JfGzM
X-Google-Smtp-Source: AGHT+IF4JP14PvjaBdhGU6nxYGOoxcgTu4dI7holh6rn2mZxGlRjwxhfuYNFTkDCaPyaR8Lyk1iyKDP0artIywhZLq8=
X-Received: by 2002:a17:90b:3a05:b0:2ee:ed1c:e451 with SMTP id
 98e67ed59e1d1-2f782cb083dmr5596052a91.15.1737136615267; Fri, 17 Jan 2025
 09:56:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
 <877c6uqpir.fsf@oracle.com> <9492b728-ce7c-41bd-b954-6981bf639438@oracle.com>
In-Reply-To: <9492b728-ce7c-41bd-b954-6981bf639438@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Jan 2025 09:56:43 -0800
X-Gm-Features: AbW1kvZxISXQL0XaOcskt9wkHnjb06W31ZfAdNMxXmEEYZGxddbXlLZDVt3pJPo
Message-ID: <CAEf4BzawWjmrWZ8Hf4iLNZ3xOXyFVrHFLgrO994w=Mw5mLKOYQ@mail.gmail.com>
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Ihor Solodrai <ihor.solodrai@pm.me>, 
	Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle <chantra@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, David Faust <david.faust@oracle.com>, 
	Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 12:34=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> I remind that just as bad as the decl_tags it also misses a solution to
> the attribute ((preserve_access_index)).
> Something like #pragma clang push/pop is not viable in GCC.
>
> Jose proposed the patch in:
>
> https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.c=
om/
>

Ihor is working on an alternative, cleaner, and much more generic
solution that would make it unnecessary to add custom options for
specific cases like this. Stay tuned.

> Maybe you could accept his patch in the meanwhile, and work on the
> intended improvements later. It would be passing more tests then roughly
> half.
>
> Thanks
>
> >
> > Thank you for getting this up and running!
> >
> >> Hi everyone.
> >>
> >> GCC BPF support in BPF CI has been landed.
> >>
> >> The BPF CI dashboard is here:
> >> https://github.com/kernel-patches/bpf/actions/workflows/test.yml
> >>
> >> A summary of what happens on CI (relevant to GCC BPF):
> >>    * Linux Kernel is built on a target source revision
> >>    * Latest snapshots of GCC 15 and binutils are downloaded
> >>      * GCC BPF compiler is built and cached
> >>    * selftests/bpf test runners are built with BPF_GCC variable set
> >>      * BPF_GCC triggers a build of test_progs-bpf_gcc runner
> >>      * The runner contains BPF binaries produced by GCC BPF
> >>    * In a separate job, test_progs-bpf_gcc is executed within qemu
> >>      against the target kernel
> >>
> >> GCC BPF is only tested on x86_64.
> >>
> >> On x86_64 we test the following toolchains for building the kernel and
> >> test runners: gcc-13 (ubuntu 24 default), clang-17, clang-18.
> >>
> >> An example of successful test run (you have to login to github to see
> >> the logs):
> >> https://github.com/kernel-patches/bpf/actions/runs/12816136141/job/357=
36973856
> >>
> >> Currently 2513 of 4340 tests pass for GCC BPF, so a bit more than a ha=
lf.
> >>
> >> Effective BPF selftests denylist for GCC BPF is located here:
> >> https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/configs=
/DENYLIST.test_progs-bpf_gcc
> >>
> >> When a patch is submitted to BPF, normally a corresponding PR for
> >> kernel-patches/bpf github repo is automatically created to trigger a
> >> BPF CI run for this change. PRs opened manually will do that too, and
> >> this can be used to test patches before submission.
> >>
> >> Since the CI automatically pulls latest GCC snapshot, a change in GCC
> >> can potentially cause CI failures unrelated to Linux changes being
> >> tested. This is not the only dependency like that, of course.
> >>
> >> In such situations, a change is usually made in CI code to mitigate
> >> the failure in order to unblock the pipeline for patches. If that
> >> happens with GCC, someone (most likely me) will have to reach out to
> >> GCC team. I guess gcc@gcc.gnu.org would be the default point of
> >> contact, but if there are specific people who should be notified
> >> please let me know.
>

