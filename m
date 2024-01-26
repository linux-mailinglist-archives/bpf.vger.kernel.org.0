Return-Path: <bpf+bounces-20430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1A983E466
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 22:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771B1282A3D
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83183250EC;
	Fri, 26 Jan 2024 21:59:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F342554E
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306354; cv=none; b=ke9PWT6QcJapB8wsjIbqCVPmOe1A/2QLQ8tkXEhyibrYDsS2JxwBaIPL77XcBEpTEplkq07VsnDYuTnC/3bMJIVjNuJ/niuBWcVAFhHhbBpPGdjJjt0sj3CLbv43JV+ly5WWtLwkNN/ZgfAlC4UiJ8MuR9Lfmw1FpCF5aR6uMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306354; c=relaxed/simple;
	bh=8/PbABOASozf6T5nlmF1cGDS6ScBG2xwHlDh8f04m9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nS3h8A6JJZwDCAiePW46M52aILhIN/MZWCJfY/2nRs1yOFUuPS+Bs+QY5UTCKfTxICnJ/g4AENkaV/RB+qs4dJMbIJomhF+icddOcV5aPZwWBjLdo0EnhkBg4pqmuvBHeMIhkqwqnSZvMXC4zP7o7EQ/2T2NGzkfR6eCwpX8oFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783d4b3ad96so73946985a.3
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 13:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306351; x=1706911151;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/PbABOASozf6T5nlmF1cGDS6ScBG2xwHlDh8f04m9M=;
        b=IuClKMsNfwwJbz1PK26l1FqyRL6u6TeeWiu6n1C1fRXrQtAwcLYx16A2yenYSdwBk4
         qbEqbMFk9kr/AmrHuPYJBp/FS/lxlWLMPqfuVh2He0LHi25qDiS9FEQMItKxZnL5hw09
         PAsYQ7lskYZSnea0UeVdszw+b4UZwjXzdeY8iABtqB32HpAhFby5+G4tiDqtwFRarD64
         oySBVHebxxQ3oN8YFallFQ+wQPpREtFTlfTerMrA1Op2Y+v09onWKIRpzHSqamOCbvZc
         bmRYYfePyt30uwlXwCF5oY3Caq9MszsMEiQQqBXel823gv1K+D187DAIcZTu5Fv4Hnto
         OIKA==
X-Gm-Message-State: AOJu0YzrP2rv/naZzzhXoRhysO6Qp2JdJ00JLmW/G8lgSnnZXzQjMnAh
	TSn94zkMvjFSLYc+vMcbZldxKiNFvVeLkLHa3iadP9xCHE7uQuTV
X-Google-Smtp-Source: AGHT+IFZAhemmZwhkjJKkk3NzNUqYYyTEgmZBjmGIEWbGdGbKe4wLHp8Nr5JiZ4cUUShbHN5unv35w==
X-Received: by 2002:a05:620a:1262:b0:783:6be3:3517 with SMTP id b2-20020a05620a126200b007836be33517mr401121qkl.144.1706306351349;
        Fri, 26 Jan 2024 13:59:11 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id v7-20020a05620a0f0700b00783b6da58a9sm914362qkl.39.2024.01.26.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:59:10 -0800 (PST)
Date: Fri, 26 Jan 2024 15:59:08 -0600
From: David Vernet <void@manifault.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, joel@joelfernandes.org, htejun@kernel.org,
	schatzberg.dan@gmail.com, andrea.righi@canonical.com,
	davemarchevsky@meta.com, changwoo@igalia.com, julia.lawall@inria.fr,
	himadrispandya@gmail.com
Subject: [LSF/MM/BPF TOPIC] Discuss more features + use cases for sched_ext
Message-ID: <20240126215908.GA28575@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NKGsz+bk+5v6PccT"
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)


--NKGsz+bk+5v6PccT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

A few more use cases have emerged for sched_ext that are not yet
supported that I wanted to discuss in the BPF track. Specifically:

- EAS: Energy Aware Scheduling

While firmware ultimately controls the frequency of a core, the kernel
does provide frequency scaling knobs such as EPP. It could be useful for
BPF schedulers to have control over these knobs to e.g. hint that
certain cores should keep a lower frequency and operate as E cores.
This could have applications in battery-aware devices, or in other
contexts where applications have e.g. latency-sensitive
compute-intensive workloads.

- Componentized schedulers

Scheduler implementations today largely have to reinvent the wheel. For
example, if you want to implement a load balancer in rust, you need to
add the necessary fields to the BPF program for tracking load / duty
cycle, and then parse and consume them from the rust side. That's pretty
suboptimal though, as the actual load balancing algorithm itself is
essentially the exact same. The challenge here is that the feature
requires both BPF and user space components to work together. It's not
enough to ship a rust crate -- you need to also ship a BPF object file
that your program can link against. And what should the API look like on
both ends? Should rust / BPF have to call into functions to get load
balancing? Or should it be automatically packaged and implemented?

There are a lot of ways that we can approach this, and it probably
warrants discussing in some more detail.

If anybody else has ideas on things they'd like to discuss; either
sched_ext features that are missing, or scheduling ideas that we could
try to implement but just haven't yet, please feel free to share.

Thanks,
David

--NKGsz+bk+5v6PccT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbQrLAAKCRBZ5LhpZcTz
ZEzTAQCA72eNu6TX3t8Vr/J480scqt52n1QaBoV79T37jw3NqQD/dKVvwGd4H1/a
9FG/BdG57XZ7HQcCxw8fYEM7u7DylQ4=
=rmgY
-----END PGP SIGNATURE-----

--NKGsz+bk+5v6PccT--

