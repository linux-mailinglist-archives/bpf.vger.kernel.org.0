Return-Path: <bpf+bounces-50661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1C5A2A6A7
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 12:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBA168B1E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6053122CBF0;
	Thu,  6 Feb 2025 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCS7N+S6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BD22CBC8
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839472; cv=none; b=n/G/+JDi/Y6NTNI3DcFY6eTyx8DGI+Deq3zpG4Kz3x6eQoV+AxCI0bdjJxLpOCbgkBelZzHtg4dxv7u/0YeWgvDcnExfHOA+TT+EDwKGSxHw9p1O/+ytPy4naljdNBNEHI8TBid16m0HMVdfhGIbwK27qY+M8Pk8JvKjdOw+cPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839472; c=relaxed/simple;
	bh=ah5qm0TemI3h+BGp+up/iQdxqJa3uqof/ENSPHOD0Uk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cSh5SjevKxD6/1ezJWRIbM5LCMbQzp02GrnuUVbZUDzHD/qSNNeXazBFZWVpvCfjf5w4UK3q6WtyBjyypTnUvcmQeHlov43BpT0pZpFHH04QtZfVARnbjyuLejZE1QCtnl3CCbP4qhZwo1PU5eQdyzhrNKmt8jWtqzVu9DLfnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCS7N+S6; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5dce27a72e8so1817993a12.2
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 02:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839469; x=1739444269; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BaM5X2eYg87TMZIOg+US0h+3jIdbkfPtV2ds+ZtM0xg=;
        b=PCS7N+S6aqoOkMYlqNskII2GGw59k+ns88yX1XAATg3d7V3KqByUQAONalCnZZ/6W+
         UYekVwAlxB7ZETNw+X8WRP+EJ/hZykWDLesxw87Iodp8fN8/1mrATYD8gv8TR4AVORzQ
         +B6PlnSYXkMNru4Dv3akU3isDsCQmBZ9xYb/MUC6zr2frXYA/LSnCFgF8/Ia+iUbl+Xy
         5aLeuvoVHyIEO1jk1QHhykkwQpQp5qZiMDk1YHhPPKd/lTh8oudQLLSvKzhi9/k78ylP
         0FJyIISTlHDgSEceTux+wcNtQ50ozDCbiQpoPt24cQ2DXJOpnSoqMM1dhO7VS+45GI2C
         fDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839470; x=1739444270;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BaM5X2eYg87TMZIOg+US0h+3jIdbkfPtV2ds+ZtM0xg=;
        b=hGIX8NRCYGFKCT/hadylfMPIt5f2+wnM8FQ64RddkFo7kxDql4R/G4RGJKfIAI1Zcf
         ICqGucPQMfc7tn3lmpoIOiTWXeQ9xSHRd6SEvilVrhFrqsVR1b8Oe0XZDf462PyPg8We
         bzf52gGIucEZV3Efn2KyO2bPBYvKeARtOHgx8gTXvK+iB87diW2OO54bOZaurtfpIGDF
         wPOzWTi1rYRroRpWwqVFRoSSOQq8ylsGpafGItoEwUd4eyAVCVxvzE3M7PqDXKFN/2D6
         06YTS+NaM3V4g1UftK7ypUggomJjWYY2KXZMGcnqfWTjeDugeLxN6IWlhdeTgSa0UqT1
         wMVw==
X-Forwarded-Encrypted: i=1; AJvYcCWYL8ZROSyJgtjVWTZWx4ml9D2GwD8E51GkSGw8iqYTspqfvDN1mmZ5XgXR+TIgoFmDZDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7T+8IMrPKCorzSyQADYWNdcfq9dkKCbpAZDUMsIm+xCrsL2v
	0w+NLMRF9olosqRDF5FNAmS8CXELJrby6tMaQofuN6Kws7ycPpTWxlV5F5HUPEySA1BSdMeKxW6
	wC5tn/dDepk5azUzTzseuXpv84KA=
X-Gm-Gg: ASbGnctcc2ISc2lKWdoc57xkomhOyP6sKdvOi+zHHcAj0ElXrKSDcWfBgpEd8PZ8ADs
	b7V3c78SdhQXl/UKae2BdtVvU28bff40hXOUzmC//M5gKS7vSIiR7PCLBySuWLU57WQ0PiIJk+n
	k=
X-Google-Smtp-Source: AGHT+IGTsVKfqbLJED3+TMDIemAKmvccHmPRlDXmLb/2VvvT1Lrnwl54HE3WUojDAQthHj6dUd0iseT3vb2eNVZs8Ro=
X-Received: by 2002:a05:6402:2390:b0:5de:3722:b68f with SMTP id
 4fb4d7f45d1cf-5de3722b888mr146425a12.16.1738839469366; Thu, 06 Feb 2025
 02:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 6 Feb 2025 11:57:13 +0100
X-Gm-Features: AWEUYZmoGNVK-hRSnSrtmAQEyqEAJEst8-18uUivqA0TxHoreMMh_9Gh5vInOrM
Message-ID: <CAP01T77Whm95kbcYc7s4mJK40LkXS1NoCY9F3FCNaYJ=qAVzuw@mail.gmail.com>
Subject: Locking and synchronization in BPF
To: lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to propose a session on locking and synchronization in
BPF programs. We will discuss recent changes and how locking and
synchronization primitives should evolve to support more diverse use
cases.

The adoption of BPF arenas has introduced some new challenges. We need
primitives that allow proper synchronization between BPF programs
running in the kernel, and applications running in user space. Data
structures written for BPF arenas are shared across the user-kernel
boundary, and current synchronization mechanisms fall short in
addressing all needs.

With the resilient queued spin locks series [0], we've taken a step
towards more flexible and safe locking. Introduction of these spin
locks allow us to relax constraints in BPF programs, however, to
permit more complicated logic in critical sections, and enable locks
in more program types, additional work and analysis is necessary.

Some relevant discussion topics include:
* Relaxing verifier restrictions for current spin lock usage.
* BPF arena spin lock implementation.
* Holding locks across user-kernel boundaries, and associated challenges.
* Allowing user space readers to act as RCU readers, and BPF program
in the kernel as the writer, or vice-versa.
* Potentially sharing locks between the kernel and BPF programs, for
mutating kernel data structures.

  [0]: https://lore.kernel.org/bpf/20250206105435.2159977-1-memxor@gmail.com

