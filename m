Return-Path: <bpf+bounces-32723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A4912591
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8570B21F0A
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65681155724;
	Fri, 21 Jun 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+JrUESr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE1155310
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973322; cv=none; b=j+684dl80FWo2JxpQBYV7KFivjQtZyGCs+Q0SXOduvSQoKeHHxkwPAciMSMBZ4ljGnJWIDCF4QvngEnuimM2NYsolV+WwUuaQL/XAePq5De/DY+53FF4sqtHVAznSzamlL1jJY5n6r7KrUnsKYL7rGiCpIPjUS3xM7vvsWX4sqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973322; c=relaxed/simple;
	bh=F1ll4sOIvCBXD+ONg7YMytT6dGxSUcFFkrx7rbA2UqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ce1BJ675X1ShxPA4izuz5OOq/hNdFd0bCqtenUS5T1R7o98x4+YjP3kRfa2b0kLyx8MNv9PTrdA9crED9UMr4iM6EPsIogwI0AEbznPXqM+QovzahZ0mcNV82AKS6vFaLeEk7qL1Cz0aIbcdL+Kzf1fzV/xzWNLvDw6/18TAzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+JrUESr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718973320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUOo6pncrLLfVNELGwFTwFChqLBk3YLyQi1FlWq0WU8=;
	b=U+JrUESrXLqc49siFWWjpvYqxBHHnR08oBTZu6mIT6L8gKugK9SLNVzvdEm1QJEAlTTsfP
	C1YhIFa4SnY/l6bN328YXkfurdMggOWnkHSyyelcH7JP5Uu9khiwFc4jRjzSTHfbNAgRfo
	8hYvrjNEXzR8yfHDG/yRl4oYhiGD9Zk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-PMAq3DAzOnqwaIrZoLy7Ww-1; Fri, 21 Jun 2024 08:35:18 -0400
X-MC-Unique: PMAq3DAzOnqwaIrZoLy7Ww-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-632e098ab42so36801867b3.3
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 05:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973318; x=1719578118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUOo6pncrLLfVNELGwFTwFChqLBk3YLyQi1FlWq0WU8=;
        b=jcbY3x3tgdWE885pSnEY4ibCC1II9pZyNxl5TEijPbPu7lutzbRoyKXNNUedxU3MhB
         weC7LUVzAhvgMUo2vyFiFNpQikIEQCOfi5QuXuaAjp1rtb3YtKn2JwPFRZYvL/CvqYNc
         zNc2rrdL9trx45Fr630M7CXB26cNbCMpsKncihxCvRcU+8Ts5MAq5BhVKjeb3yxJdPQA
         RgDjsyldjFqLff7VemQc9T9LcGF1nj2D3h8aOY4G9/zQ7vtJXEsP4NLHF8uSQhKYNv/O
         6iEoT5r+fFmFzUIwNUORENBeed9OTQr31FoohAkTQV1Phd7uAF28hpzPAl1iN1aKyqPX
         iVZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWBUSRcpcfFqTYk+93NfbW75BV3izZuNzA2zfTqB/82j7fB2c9V635LvEZ8rPHwi4fLHoprPJL6EobNZGOOKyE7ybf
X-Gm-Message-State: AOJu0YxXp/opZJOcFXtxBPyk6nE6zqKN+JcoyUtzvf5RJGzk3S2GYtMH
	GHGIeDLk4cS3DpDXiOw69rCnLD8nNGju6XYoaw1E44dGj73UxbxVL8Z5uD+BL7cEqLmng2w+QkJ
	jN4aSG4Ys5HjskJZ7GGBYDt07KDIMQ3Iar8tFulp6zYprKqHhlXCEcggIz/yAK/1A/H0z1hUF5v
	JmVws2yCGr93rO/rRje1JSSuXI
X-Received: by 2002:a81:7282:0:b0:615:8c1:d7ec with SMTP id 00721157ae682-63a8f5243f4mr82320797b3.33.1718973318122;
        Fri, 21 Jun 2024 05:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg4AV3dsomq7cAZlPOVhXZ/8jwkZGHBKMxRoERWq1isJ0a7oog8UYUJOo3PkY6knHJsv8OaMe5ENGVL/P/agU=
X-Received: by 2002:a81:7282:0:b0:615:8c1:d7ec with SMTP id
 00721157ae682-63a8f5243f4mr82320627b3.33.1718973317776; Fri, 21 Jun 2024
 05:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk> <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
In-Reply-To: <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
From: Samuel Dobron <sdobron@redhat.com>
Date: Fri, 21 Jun 2024 14:35:06 +0200
Message-ID: <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: Daniel Borkmann <daniel@iogearbox.net>, hawk@kernel.org
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	saeedm@nvidia.com, tariqt@nvidia.com, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hey all,

Yeah, we do tests for ELN kernels [1] on a regular basis. Since
~January of this year.

As already mentioned, mlx5 is the only driver affected by this regression.
Unfortunately, I think Jesper is actually hitting 2 regressions we noticed,
the one already mentioned by Toke, another one [0] has been reported
in early February.
Btw. issue mentioned by Toke has been moved to Jira, see [5].

Not sure all of you are able to see the content of [0], Jira says it's
RH-confidental.
So, I am not sure how much I can share without being fired :D. Anyway,
affected kernels have been released a while ago, so anyone can find it
on its own.
Basically, we detected 5% regression on XDP_DROP+mlx5 (currently, we
don't have data for any other XDP mode) in kernel-5.14 compared to
previous builds.

From tests history, I can see (most likely) the same improvement
on 6.10rc2 (from 15Mpps to 17-18Mpps), so I'd say 20% drop has been
(partially) fixed?

For earlier 6.10. kernels we don't have data due to [3] (there is regression on
XDP_DROP as well, but I believe it's turbo-boost issue, as I mentioned
in issue).
So if you want to run tests on 6.10. please see [3].

Summary XDP_DROP+mlx5@25G:
kernel       pps
<5.14        20.5M        baseline
>=5.14      19M           [0]
<6.4          19-20M      baseline for ELN kernels
>=6.4        15M           [4 and 5] (mentioned by Toke)
>=6.10      ???            [3]
>=6.10rc2 17M-18M


> It looks like this is known since March, was this ever reported to Nvidia back
> then? :/

Not sure if that's a question for me, I was told, filling an issue in
Bugzilla/Jira is where
our competences end. Who is supposed to report it to them?

> Given XDP is in the critical path for many in production, we should think about
> regular performance reporting for the different vendors for each released kernel,
> similar to here [0].

I think this might be the part of upstream kernel testing with LNST?
Maybe Jesper
knows more about that? Until then, I think, I can let you know about
new regressions we catch.

Thanks,
Sam.

[0] https://issues.redhat.com/browse/RHEL-24054
[1] https://koji.fedoraproject.org/koji/search?terms=kernel-%5Cd.*eln*&type=build&match=regexp
[2] https://koji.fedoraproject.org/koji/buildinfo?buildID=2469107
[3] https://bugzilla.redhat.com/show_bug.cgi?id=2282969
[4] https://bugzilla.redhat.com/show_bug.cgi?id=2270408
[5] https://issues.redhat.com/browse/RHEL-24054


