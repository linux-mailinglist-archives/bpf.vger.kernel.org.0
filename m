Return-Path: <bpf+bounces-53436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7CA53F61
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 01:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB3516D90B
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 00:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3472943F;
	Thu,  6 Mar 2025 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwShUpQQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D95FC1D
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222288; cv=none; b=HDu2Qw/xh159DHi2sXYiOf0TptFti1iLISd3uIzAAhJEFdlu9WEUik1XVfuVSmULVxTtvznVxLJDfc1HlfCKIDyLlGuG7orooc1ga+rY2h5yeBaFNAwefUJ0LqVRZT2Y7vpq8l+OeMc0n11tCMSvRs4OJse/a64ax5/TKubVo1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222288; c=relaxed/simple;
	bh=Rw1kmtfqLUgDal930cblReY6nplnLaMfLPr0sxIkQ7s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=O8BtwQ2ll1t4l3ubmxquxITKeaMFp/7mXmhnWncSZvyX8R4b1OHCKStGepROwMKJ8WdXsGPYW8gNOVl4jeUJjumDF0esorBlketaFx3X7pWquHy8bfwfm+3cv4n8QtQ3ZL7YRPJx9QLF4hhRw419Gmgv++mQuJfFr9BwpvXI06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwShUpQQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c3ca86e8c3so7484285a.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 16:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222286; x=1741827086; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c/iDtRJ8gpqWGwZKHwjvAM1quDXC0ENX9NpnyYGCZxs=;
        b=dwShUpQQs/jcXEoGW4IMcEF7CCwhRX5uUOalM92YB+8MUHdVZL5QLfr04Hm+5meAZv
         ZjDKV4+YCfBbN3LbfA7NQ+VggtWycDhv6rv67hx4AcvCXGofT3XdDR10XvMFMrZ9h0GW
         ijBjsZNv1qvtjzV94Z/111sA7g5labhhYxWs7pm02bvz3a7ssrDjWUVFH4n31NxQy9MY
         FIOhvovsIZi7tcGmEZIA9Ln0AXNGhy3bu37jn5WHGhbfQw1VXwdvV+09jjfduRq4jIRb
         Apu60RbOPS6Vhjo6gveTH6J1MRrg7AkjqYJWKxVLsVvDa1oPcOdP5Dv6aLjdV3xHfozS
         idQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222286; x=1741827086;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/iDtRJ8gpqWGwZKHwjvAM1quDXC0ENX9NpnyYGCZxs=;
        b=nrsorXy6sRP+vAQWAbS2jVyoFd/kmZLCf+bANUNgd6x9C2/NK15FX4P0QKGQMS0u9L
         z1qIMu7L3mVcssMW7J+X7CPyTzFvAKK/h2ILuncuhZPvF4T6/tMNZ9Av158XCxSAu/2u
         nrGitSXkUxteqtefrob/9yb1UNaGzLJ8+sAukoP/MTaT43wA9ZxuMb6BuDTzqAPscy8Y
         da/JYGM66f3c1ktlDI+31zXRL3HixXDfCZYZ3yjPcW6HhXEW7eOlfI/+sCayG53TXwb+
         aFEFxGlKZlPTWiUD1bnKjGWA7BMxFZhn13RgyBU3OMRGBGa0tmcgnwRMWveE8D+nws3v
         BX6g==
X-Forwarded-Encrypted: i=1; AJvYcCXT3J4KNxk/vJ/f81NNhXs2p7oDPbs8f61IEhZ2jYVYKGt0rK1AcVWRs2ZF3Y3K0d3AuL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxseOA7w+gcxfFJxm9USmRyhtO2jBi7qJYLmjZMTGNO5PPiM1UP
	ZFivZ6Gm5zh8hAxNcEDpZFBxqYsATMtAYJ6NXRkMvflwD47Gh9mMzZKsp9ye3mg1fnqIeFJsw1k
	vJoUJXno22dGa/Or+cwO/o0hchn2CSw==
X-Gm-Gg: ASbGncsAB9FG3tsKasRPd0EAdAOFH7e/hIE/7YeKKBkTe1zPjCWK03Zbd4BO9uWzfZm
	Lwdv2wu/e5Sv5cPntwq/49mjdND/KTicIQHt/cj01QfbkZZbneDNrM+T+qVxTdgnC7WqWZocVcN
	POTFe7JgYHCHlN0qP6BoxvIr6eBg==
X-Google-Smtp-Source: AGHT+IFg3TpeVWJoJ9lefdsbxxc4/kDtFwyQSz2e2UmsQ4G/cn+Vr7PIN8HZkMltf5bXqgzOFXQxu1Ay7iU3Al8SveU=
X-Received: by 2002:a05:620a:2b96:b0:7c3:ccf5:363e with SMTP id
 af79cd13be357-7c3d8dd04dcmr864215485a.13.1741222285932; Wed, 05 Mar 2025
 16:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 5 Mar 2025 16:51:15 -0800
X-Gm-Features: AQ5f1JoE0SSEOZZHX1P8mVEDDQSsCZhP67qWe4OoftuqSXXb4qE0nI7QxjX0fIY
Message-ID: <CAK3+h2woEjG_N=-XzqEGaAeCmgu2eTCUc7p6bP4u8Q+DFHm-7g@mail.gmail.com>
Subject: [BUG?] loxilb tc BPF program cause Loongarch kernel hard lockup
To: oongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I have an issue recorded here [0] with kernel call trace  when I start
loxilb, the loxilb tc BPF program seems to be loaded and attached to
the network interface, but immediately it causes a loongarch kernel
hard lockup, no keyboard response. Sometimes the panic call trace
shows up in the monitor screen after I disabled kernel panic reboot
(echo 0 > /proc/sys/kernel/panic) and started loxilb.

Background: I ported open source IPFire [1] to Loongarch CPU
architecture and enabled kernel BPF features, added loxilb as LFS
(Linux from scratch) addon software, loxilb 0.9.8.3 has libbpf 1.5.0
which has loongarch support [2]. The same loxilb addon runs fine on
x86 architecture. Any clue on this?

[0]: https://github.com/vincentmli/BPFire/issues/76
[1]: https://github.com/ipfire/ipfire-2.x
[2]: https://github.com/loxilb-io/loxilb/issues/972

Vincent

