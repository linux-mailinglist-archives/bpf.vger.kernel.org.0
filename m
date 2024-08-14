Return-Path: <bpf+bounces-37212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6148D9522B2
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 21:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBE7285D44
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE5D1BE86D;
	Wed, 14 Aug 2024 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1AukOB4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B8139CFA;
	Wed, 14 Aug 2024 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663935; cv=none; b=ps25jztzdkiDUACg32I/6LNblkTqcyfBf+lxUdqX/mlZGg8vkBGnEVu7ZT+PuZOBVgCV+9RK4oQb2KsPPsFt2eZc8q9mXoHEQ5fVgPw/wtAyWMI8W7dFY+xlZhDVzpHxGfTwwM7xbwmcOW2dCk5+n4//554grUOtt1/bEBMTOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663935; c=relaxed/simple;
	bh=/ekPFoKg1Lq16yA7Gcn4ooPF35bs1836CY/NMrgINHo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XSQj0TO4aE9ekhSM/fcpPWOi2NY0jiprsPQlnwp3Vzu8yIBXEWt67tjVWv+3Mcu4Q8CQJ5Ixji6eUCveDMKVCKMnPCTPCjlew/L/TJbRGyjPbHdTPtBmSwIW6vdAboESCKOyK3QAjz5q6hsToHMnZNluRVGrosPJj7WyeOz0NC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1AukOB4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso140840f8f.3;
        Wed, 14 Aug 2024 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723663932; x=1724268732; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ekPFoKg1Lq16yA7Gcn4ooPF35bs1836CY/NMrgINHo=;
        b=b1AukOB4udU1yOMaVxObDziBL9GiBAtF9q5q0+Fy4f2mmnI1LJETkKjqu+fi/de1/x
         djuaH/gGG+kS1FdZInmTGG9YZVmvNCM+tlbOtY7Us/AkyHdzyRn2DkTdgjGvbb4xwQF6
         kxaiILIryBHQY24+fZC49+RKo6Xwb4yxHselTwBtxhkjJ8P3z0qWsGwUARnZpeOdEA8L
         rpHKbU9nXwUIvxusBReUgeFuk/Gwv1sjVA0LqoBuiIQ8yRG7AiKYzKkZP2DTl0tldvkR
         EHlXIpENiEOo3tXW6NJ+kHQXCImw6o0+qeEhFk2Yvdu2p7PlPAZ9BgsSiSEtuuXUE3nT
         +amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723663932; x=1724268732;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ekPFoKg1Lq16yA7Gcn4ooPF35bs1836CY/NMrgINHo=;
        b=Sro6qwr41hoDt9ULnxN1SDcCU9A67saLqQHQ1wCjwRn4qBkf1NbqPEUOWrXaDR4t9A
         2Gxqact6z+DDOb5/Hfqh7paKusAXneArh1T7souokI+s8/i42r8WL1FEANl7gcow783U
         TqfouUeJQgPV6tPdzs0Sx5VwJPxEX3ijdvLoCYGaO+YYjW7Yx08FLwh3INIyJJrkoGcU
         XU0HH+DzsspFn0EIQPmXzTF2BboI9zHEiWnCwFmmqP7eKSE7MTcwd7kjXABMPNSk9N3o
         3l172cefmm//HKvmtooYRz83TjpVXYVae9YENVcMiebG14Jscs0f0pkr7jdFiJJHirOY
         cq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDFlzykpBXM4EN55X3neCjYA9p+sBr612/722lDZ21RXf+BtW+qPcJ8Pv4t+MBgdOzyoo3jxHJwGup9OWK6suJcddd8eeN
X-Gm-Message-State: AOJu0Yyo+1ELvapgyzepYjZ/fd3AXZXaskotVVxA1qokzqoqShAE3azo
	RXM7IBE5fI2cU52UsMmlGMG+Stc6FiBFC40R+FHwBfgvQB6AJ8YsX+rHES9JGb5DFKQEBn9TJHm
	3GJsbKT9rgs4j1jh8C4egR9qpT8qoojlG
X-Google-Smtp-Source: AGHT+IG3UfEOhDDrsiHOSRzlGnI4pa3sRcee1hjrum1ud2LAL7Qf6bgBNwtXFerJ33fTu0ce2e8fg870CK2ydTBZbR0=
X-Received: by 2002:a05:6000:2ab:b0:362:8201:fa3 with SMTP id
 ffacd0b85a97d-371777918afmr3678979f8f.34.1723663931338; Wed, 14 Aug 2024
 12:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Aug 2024 12:32:00 -0700
Message-ID: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
Subject: bpf-next experiment
To: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

Couple years ago folks suggested that bpf-next should be
a separate pull request to increase subsystem visibility.
Back then we rejected the idea since many networking related
changes required bpf core changes. Things are different now.
bpf kfuncs can be added independently by various subsystems,
verifier additions are mainly driven by sched-ext,
so it's time to give it a shot. It's an experiment.
If things don't work out as expected we will go back to
the old model of feeding bpf trees through net/net-next trees.

So here is the plan:

1. bpf fixes go directly to Linus (skipping net tree) and
net/bpf trees are fast forwarded afterwards as usual.

2. Non-networking bpf commits land in bpf-next/master branch.
It will form bpf-next PR during the merge window.

3. Networking related commits (like XDP) land in bpf-next/net branch.
They will be PR-ed to net-next and ffwded from net-next
as we do today. All these patches will get to mainline
via net-next PR.

4. bpf-next/master and bpf-next/net branches are manually
merged into bpf-next/for-next branch.
This step achieves two objectives:
- bpf maintainers watch for conflicts between /master and /net
- Stephen Rothwell continues taking /for-next branch into linux-next
as usual

bpf CI will run tests against 4 trees (instead of 2):
bpf, bpf-next/master, bpf-next/net, bpf-next/for-next.
This is wip. Watch for more "Checks" in patchwork.

By the merge window in September we will reassess
the situation and if it's still worth doing we will
proceed with PR formed from bpf-next/master.
If not, we will PR bpf-next/master into net-next and
call it a failed experiment.

We feel that there are more positives to this process
than headaches, so fingers crossed.

