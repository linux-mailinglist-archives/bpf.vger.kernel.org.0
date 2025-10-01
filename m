Return-Path: <bpf+bounces-70084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E4BB09BB
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5C1C4E2388
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C323019CF;
	Wed,  1 Oct 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyxdMBj/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988D253F07
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327393; cv=none; b=dMj5xWjVnqO9HiOjYGJOga8j8yN9h0B9jgw6suwsPyQErWN0FxYeCt6TB9PoJa4E3zwOpEraWwtRu+GDAn5Gi2p0OrduenSrEYnohDvyvEcbAt1GtMtlJQOBwN2vrAQ18k7useEsKQNvU/YLdcRyjIag65F7+Fv1+3uZ5xm03mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327393; c=relaxed/simple;
	bh=+Im5V+9+8bCIyHvOmWKH2aB5A0da0eSg5DrmhXw7S3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJ1EycB+NUSjZGbsBmYRMC+JN23xCXq8ACxJxsoIhLVJzkrFJd+5rbvUQW99D4JJGcKI4AsWfduW/+4qSz44k2Xd9INbm4fhFZp5xppNoD3UX0Hko33EU9cgD3ZlW536WVjFxkI5VYAn0L5dRNm/+gCTMW93EkCDQ1agmC/du3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyxdMBj/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e542196c7so6256055e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759327390; x=1759932190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsug1ilq4WUq/pn5yxhX5suvNAknwwxISuFBz65ikYs=;
        b=EyxdMBj/OxsvUHsjDlal1sOCqxc2oXENgOoz+XCvnk0j4kFcYk1siJPmtW0EAswA+i
         lGtKA5sDdLUAmBxoLcHbFIdopOMxZkYTkOdQRoSYBLpHBdNf/xco1AwZTng+XIJaRRmB
         a2aSCtu6cfu7GMoDq5/KTR6fEswHJBidbZm7gmRHzOZBz9P2so0PtKivvWtIHlTL5S1y
         FYT0ssUlWxsw810naGI3tXhlxMI4V4aDOOoOiaUzKbiPBCbFbqWhdMEZBDSYSokRUMf8
         pmIHmsW+qf/iGk4HCMdftQrhJlzHlvUM/j37Wx62Az+T1pCMgw6zv/X1FNHf2R6hQEu1
         gC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327390; x=1759932190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xsug1ilq4WUq/pn5yxhX5suvNAknwwxISuFBz65ikYs=;
        b=kLJqcq3VHAnyFVwyguKTNn0n66PSmE0aBazMQnJoZVo/ymubIjs5HhOwvXTYdAx71K
         sOEj8SIgujWVreOyCuSwKX75rTnAgo2FAfE9qC5sbWbLbeJDijJxasGks6DEirwtqDP+
         8aw79hPetpEMubwBNpZEuj+9D5H0Eyf7mPfDKIz9Dri4fwPHOt9hTBoy9u6/DyVewgfX
         Fi6IJ000QWbCziymBl2LR4Jf9QjauoY7VZ5eM44sfTffewvJtqRGRRUZcXy7WXeIq2Hl
         DWkzyk84C9IxlsyM+jx9+C3ajemTe67dM730imTT45Ra2d2DK26fuujoUDwcEF8VkSKE
         WX/g==
X-Forwarded-Encrypted: i=1; AJvYcCVBCGn+8i1/RqTm/3tOi2CxyDKHMxsaWbSH6glnPr8yogaH/2IbLhvvkSixj/TlNTqIdCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjC7nWWAD2CuKmhmvrRf7Flmqa3/Dza1EkJwuASnoVI36Z8hqT
	r6kNbUq9sgKnXfTl+7npbuc8+zcPzC5tl75ZTwNvSFPwxItUpJOrf+dhMslSLBdSvVZoRh6UUSi
	f4Z+tNYX+ra0FU9npiDi82T/2RhCjWrE=
X-Gm-Gg: ASbGncsfYc0CW21n/S0Kx3evqI2rV62mFHIZ0hEnS1JwCqJhLW1xKBQEvQInYRFr7Ax
	mC+coPorWlYqfOMVFAbXbq0j4pKdeG0vMIPJjzG+sIkyVshOehTFDJCuuj2qutsm1iLFaCQHNjg
	F+G5FmLagvnv1qEB2h3gqEY3k0+usC5GO7V5OfBGK7HwjlDxQtPQTsKD1TIRl17eQcUNjM9KGDO
	3+V3pV04M0NFy60hVdulIKmXyYf0hoB/VZ14vQBfM19V6AllQp8sD8ghF39
X-Google-Smtp-Source: AGHT+IHcZ8geORYZfcAOhaP4e5wNjNO0Gognc1doxkDe33xVdFGfTwi/f8CSeVlvYQomzgVuLkYgEckkFRAMMV40rwM=
X-Received: by 2002:a05:6000:2282:b0:415:15eb:216f with SMTP id
 ffacd0b85a97d-425577761d4mr3304483f8f.2.1759327388947; Wed, 01 Oct 2025
 07:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
 <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
 <aN0JVRynHxqKy4lw@krava> <aN0d6PAFg5UTKuOc@krava>
In-Reply-To: <aN0d6PAFg5UTKuOc@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 07:02:55 -0700
X-Gm-Features: AS18NWCzb--1QBSTth2j8WJmtwVSU5P7iFrYwWq0nkHPar-l6o_r9wpK9l4rlxA
Message-ID: <CAADnVQKEKLPvy5etjRvF12hbi4cgZrnXvx6tEfu9aRF4eZv+Ew@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 6.18
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jakub Kicinski <kuba@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:26=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Oct 01, 2025 at 12:58:29PM +0200, Jiri Olsa wrote:
> > On Tue, Sep 30, 2025 at 07:09:43PM -0700, Linus Torvalds wrote:
> > > [ Jiri added to participants ]
> > >
> > > On Sun, 28 Sept 2025 at 08:46, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > Note, there is a trivial conflict between tip and bpf-next trees:
> > > > in kernel/events/uprobes.c between commit:
> > > >   4363264111e12 ("uprobe: Do not emulate/sstep original instruction=
 when ip is changed")
> > > > from the bpf-next tree and commit:
> > > >   ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
> > > > from the tip tree:
> > > > https://lore.kernel.org/all/aNVMR5rjA2geHNLn@sirena.org.uk/
> > > > since Jiri's two separate uprobe/bpf related patch series landed
> > > > in different trees. One was mostly uprobe. Another was mostly bpf.
> > >
> > > So the conflict isn't complicated and I did it the way linux-next did
> > > it, but honestly, the placement of that arch_uprobe_optimize() thing
> > > isn't obvious.
> > >
> > > My first reaction was to put it before the instruction_pointer()
> > > check, because it seems like whatever rewriting the arch wants to do
> > > might as well be done regardless.
> > >
> > > It's very confusing how it's sometimes skipped, and sometimes not
> > > skipped. For example. if the uprobe is skipped because of
> > > single-stepping disabling it, the arch optimization still *will* be
> > > done, because the "skip_sstep()" test is done after - but other
> > > skipping tests are done before.
> > >
> > > Jiri, it would be good to just add a note about when that optimizatio=
n
> > > is done and when not done. Because as-is, it's very confusing.
> > >
> > > The answer may well be "it doesn't matter, semantics are the same" (I
> > > suspect that _is_ the answer), but even so that current ordering is
> > > just confusing when it sometimes goes through that
> > > arch_uprobe_optimize() and sometimes skips it.
> >
> > yes, either way will work fine, but perhaps the other way round to
> > first optimize and then skip uprobe if needed is less confusing
> >
> > >
> > > Side note: the conflict in the selftests was worse, and the magic to
> > > build it is not obvious. It errors out randomly with various kernel
> > > configs with useless error messages, and I eventually just gave up
> > > entirely with a
> > >
> > >    attempt to use poisoned =E2=80=98gettid=E2=80=99
> > >
> > > error.
> > >
> > >              Linus
> >
> > I ended up with changes below, should I send formal patches?
>
> I sent out the bpf selftest fixes:
>   https://lore.kernel.org/bpf/20251001122223.170830-1-jolsa@kernel.org/T/=
#t

Applied selftests fixes to make CI green(at) again.
uprobe patch should probably go via tip.

Will send bpf.git PR in a day or two with a couple more fixes.

