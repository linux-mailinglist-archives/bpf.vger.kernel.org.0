Return-Path: <bpf+bounces-53880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43670A5D695
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 07:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658113B67BE
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 06:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1A1E7C05;
	Wed, 12 Mar 2025 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE7gwOu9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32E1CEACB;
	Wed, 12 Mar 2025 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762245; cv=none; b=ddmzvITiN1SqdkJ3+7CxqJNsLIV1QF5e8octDfVCyVEWrQkfUkMPA6O2G/35LYeq/ZAGl1cosb9JI2zaKupvnOeStW7wD5kYjQ6a1YNGm+BmUsCnKrkd8t6rzEnX9xTdYUnp1Y+MqZ20Z0BoN/dT7FTuZAwbmb//eirvH3v45tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762245; c=relaxed/simple;
	bh=1O3y4wnXHULZ9moE4zVe2lLuMsEu3S4StRX0Cwq1FpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/Yc8E6TvuPrtcoJ1JxNUZx6IZCm4FRscv+6PUcq33mGtjiPm83i8niTuO4fGdOik0m9jiTzjHKeTDYM0MAQn9geVMwTpaVlj1pYf0Rf8qUenxAeqQMOPEjJnZ1kRuvSAJyt1pAyJ2MlSO2nJykNOiZtVPebkAyIil70zt/XwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE7gwOu9; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so22060195ab.2;
        Tue, 11 Mar 2025 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741762243; x=1742367043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4l1awC9HdNzL3V9KHQ7BxZG9f/uOl4UzCANyQdgLvYY=;
        b=nE7gwOu9hd4oShfjdQ28G884AMNrFDJZeBtU/DVEXCvsEpImuvBiK6WQj2tBD2/tjB
         acv2dmznhSOWfTU9Uu81OS3cPeP97d/YBgFCqIaL6BqYcfnrbYsnVNXzsLdl/IISEhL/
         i2aYnHwFKBQGcu42dU0bnYWkVh8R025IwHcGwcCR6MCz1hRoOkVk2atY0ZJ0+uRjdqYC
         3ys3l+KTw5pxYIBREUoTw8WZIhFlvJrCpZcxCMOk9pcC+YVttnG7vkB8HbiB3QGdBSu7
         LjnoA1WyW6meLhwXffzZ6eDpi/xSUvQ/bHFXPFcU/SeAC6z8l69DB7CnUhRBP31N4HWp
         s6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762243; x=1742367043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4l1awC9HdNzL3V9KHQ7BxZG9f/uOl4UzCANyQdgLvYY=;
        b=WPSrfcOow8s7bJIqpcUZ1aJcGPnkSRDpO98GOGZ4BrFplLOKta51HCTvD+bmgpv3Xv
         Prz1N9d9j6pcVJuH7BMxaHqJ0mTs3ywirTIH6WpcPm1N87rscqgHnOyfHwIg0jUaCRxd
         CkiA1BWKe2Nk3ValPgPGF/ufiknbtCBZZa17P05FMjtqrQX98mNOqLi6zbgCxnkDkGzC
         uVMQZqaw5xG94ZEKNHBFEUJAyrgLgYs5oyDpXarwy9uSu2/f70amy3gktuJYZoqKxqtt
         LV0pV4yCMb5Apx5mZP+srGcNYYHNxv+yNU65cfWW+vx2u+IcoAUi4os4o4CqtcYsB1Ii
         lWQA==
X-Forwarded-Encrypted: i=1; AJvYcCWCj71C9y0+zQzhwb6mA/QIHaezfJw/np3ZxJdPt/dwZdJXXzRNxwghIslCldrhQMUiZW8=@vger.kernel.org, AJvYcCWpT0wAVjK23XtrCpSOYBEqSjXmwhhDwmOs8+RzgtKWuOHuG4UmiVaBGjA9HMbMbJ9ZDYKEnXbR@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkEmYEkgxKNbHfFGJGjVKBRl6lzgFU144mKRcIw/dnh73A+9l
	6hmEONe1bXvkzlgnYXxe0I6AvSPVfm0m5nThl81bYrHqtAyJ0elLEyAI3G6cyLSHX/sPYWvp8+p
	c2kj6dN6gSOyf6ER3v4nTfzPq0EI=
X-Gm-Gg: ASbGncsLH3kuO/z0KLOIbWeAPKKbdjr501fFMmImf2tkHukr/lFsxvBvXBltmBFoaIj
	LuKMI0rOyPD+3aci0skKxBGjvcAHAAD/XvyWbvDYmJvx8et3Zh47JUQD32HVazlZglo2wdVsXJn
	CmM5gtXsMIIYB31hbM8UMx58uv
X-Google-Smtp-Source: AGHT+IGxdQef8yNytsrlfShpLILL/nnbQ0lNHLsVCyBh4ca1BWEo0gYTEPEkumbOAMHnXkCYINCYJlbxe7/1g6tiZhU=
X-Received: by 2002:a05:6e02:180c:b0:3d4:276:9a1b with SMTP id
 e9e14a558f8ab-3d441a06d98mr195166545ab.16.1741762242795; Tue, 11 Mar 2025
 23:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
 <80e745a45391cb8bb60b49978c0a9af5f51bec183f01a7b8f300992a4b14aa6f@mail.kernel.org>
 <CAL+tcoD8TAWT-_mU8wMT3zt-Thh5ZVfmBear5m=G4MbCbBS9XA@mail.gmail.com>
 <5e9fc094-8baf-4b67-b58e-dae5ff9ce350@linux.dev> <c6aec870-5c13-4d84-bca2-3b77513071b7@linux.dev>
In-Reply-To: <c6aec870-5c13-4d84-bca2-3b77513071b7@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 12 Mar 2025 07:50:06 +0100
X-Gm-Features: AQ5f1Jpvsh3fS80wc1IinFIwxXrFOHdGKYQJhyoKhxQFAYbF8922vaT1L8_PnVM
Message-ID: <CAL+tcoB7ZaYYyYsvR2QwAh8twEkoKjwn-gFZzsY3xM0VSsNJVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] tcp: add some RTO MIN and DELACK MAX
 {bpf_}set/getsockopt supports
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bot+bpf-ci@kernel.org, kernel-ci@meta.com, andrii@kernel.org, 
	daniel@iogearbox.net, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:44=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 3/11/25 11:39 AM, Martin KaFai Lau wrote:
> > On 3/11/25 4:07 AM, Jason Xing wrote:
> >> On Tue, Mar 11, 2025 at 10:26=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote=
:
> >>>
> >>> Dear patch submitter,
> >>>
> >>> CI has tested the following submission:
> >>> Status:     FAILURE
> >>> Name:       [bpf-next,v2,0/6] tcp: add some RTO MIN and DELACK MAX {b=
pf_}set/
> >>> getsockopt supports
> >>> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?
> >>> series=3D942617&state=3D*
> >>> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/137842=
14269
> >>>
> >>> Failed jobs:
> >>> test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions=
/
> >>> runs/13784214269/job/38548852334
> >>> test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bp=
f/
> >>> actions/runs/13784214269/job/38548853075
> >>> test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/
> >>> runs/13784214269/job/38548829871
> >>> test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/=
actions/
> >>> runs/13784214269/job/38548830246
> >>
> >> I see https://netdev.bots.linux.dev/static/nipa/942617/apply/desc that
> >
> > It cannot apply, so it applied to bpf-next/net.
> >
> > I just confirmed by first checking this:
> > https://github.com/kernel-patches/bpf/pulls
> >
> > then find your patches and figure out bpf-net_base:
> > https://github.com/kernel-patches/bpf/pull/8649
> >
> >> says the patch can not be applied. Could it be possible that CI
> >> applied it on the wrong branch? I targeted the net branch.
> >>
> >> I have no clue this series is affecting the following tests
> >
> > The test is changing the exact same test setget_sockopt and it failed, =
so it
> > should be suspicious enough to look at the details of the bpf CI report=
.
> >
> > The report said it failed in aarch64 and s390 but x86 seems to be fine.
> > When the test failed, it pretty much failed on all tests. It looks like=
 some of
> > the new set/getsockopt checks failed in these two archs. A blind guess =
is the
> > jiffies part.
>
> and forgot to mention that you can run bpf CI before posting. This may be=
 easier
> to test other archs. Take a look at Documentation/bpf/bpf_devel_QA.rst. T=
he
> section "How do I run BPF CI on my changes before sending them out for re=
view?"

Thanks for the pointer.

Let me try one patch by one patch. Having checked the series itself, I
still have no clue. You said jiffies part. What is that? Could you
please point out a file name or configuration so that I can follow you
and then do some tests?

Thanks,
Jason

