Return-Path: <bpf+bounces-32411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B190D744
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5758428AEDE
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321628371;
	Tue, 18 Jun 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmfbfbdc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6012E6D;
	Tue, 18 Jun 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724502; cv=none; b=imALUoW1EK66F5D9cfgML5uM4AhYFY4I7h2buhTkczTdAoO/n6go0DIDW/MlUxspetTS2+VO3A6lAWmkmIAybXBEkuK7zMcEX8GXQBhXifITaK7jTeAbMtR8EV1dKdsHYiFz0tXXki8UL8ynV0XH0cFIY2d20BuiRpGDDGaXbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724502; c=relaxed/simple;
	bh=Z8brNb0UmRffjhY8z+FJmR6f8ssOvuO9AA7e7e8+juE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aLEG+IDYoG4mdPx9aeNnm32nddvFLsN0dbDfIXB/VBH/rHK6bWvnqtDvIzaOmm7YAhTwyeihvvETaXYSkD/5zDhoASicKSB4akim0phs7ctqGCoJaPqchU9YWtytfcTyWxrPPdQnLtwI0o2dTnANzui/8GUZTO9nE5o6jp01+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lmfbfbdc; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48e56ae9ac7so760340137.3;
        Tue, 18 Jun 2024 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718724500; x=1719329300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X0N/Z6EO2C6EKp1on721ixPAyB/CEJd+GsCppMWjXn0=;
        b=Lmfbfbdc7Juseo71/7V5B7Aw5mz4FiOEbNGVR+DSgab6VvpTuEH0LBYet9gsormmnK
         dL2SG5szqHchzMpJ0NatcIjSOfVHkhRgtqOdeRtVIsoxPkEcWKw5z+y0iH+ih4zVLgdm
         y2X4NeGXplxZQk+e+5w/05wm+ZXgMY5UqxpbSQ0MnjimzGxTekrvOSiA6FCTfunfV5tT
         Q8aDogQ8nb5cx2PjSuwJQ3xCemfonYwO+uARNsGLAt6i7pkh0UjqggdVYzq5EM3jRCVh
         hysjs4RSHs6UR0V/k5+GjCIDvtv3Dp8Q3B04MoaXIqI7fHPoV0m6rBH99xu/oraV9oeo
         OvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724500; x=1719329300;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0N/Z6EO2C6EKp1on721ixPAyB/CEJd+GsCppMWjXn0=;
        b=sJcbEK21CXv7+2MAAyDlXzeusOEQaUNpqgZ1iwt6HuRXqgEoCJzo/Sv9eEq733BV5x
         p2f8v+hOAKJV1mPUZ0bEp9rl8bjOT2rtxCIqCn9ZljrpRMD4y1BmgMk2fagXhwe943MT
         DEYybXFni7+n+OQVt5JpoUa8LbxlcJL34cG99+zNdxrOTDFfAzI9+IiDG3poiZJG/bp/
         k/YKX/xw9TBsfqN4dSK/FRM2R6E2Bt6kpKU6qdYYKqo5Pv/x0G6Cgjn0w1bnqKaqUO4N
         jXtzpmscqS8L66MCAxNYkvbeuHTQeig053viwRRtXjWF7Ia9PaP+3dwKNs9liXWsyh5a
         7ksQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPQXo3m6THyRjPwGLJePkfN97EBfHlhFc5msH5urlCbssQxxpROEmMy1JZU5pUXvnHpT0NKqBr33Z3D/bSu58gTx8d+HAA
X-Gm-Message-State: AOJu0YycAQ5tO5raoTxUM+qn64ZPMA4WxdJXHB5wk0ALKmUdrehz1e3A
	jSKv/7u8WY0+iWahFdIE2LNxUsWTkAfBuD/+vXi+eyYWntJb5u7BNpHkTP5UaCPfSd9l7SlU9JL
	O2EraeRkB8nIMzGMW5iDpMu6Tx4kkUBb2l/s=
X-Google-Smtp-Source: AGHT+IFbSVcqgS4btHnol0tuRLfqmEjUNC10jWYSjPV0JKtJKc6WDnG/fGz+311oF5+3ZLOngFMZuMFzHah7GP1nLmk=
X-Received: by 2002:a67:f64c:0:b0:48d:afab:12eb with SMTP id
 ada2fe7eead31-48f12fc967amr50666137.6.1718724500015; Tue, 18 Jun 2024
 08:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastiano Miano <mianosebastiano@gmail.com>
Date: Tue, 18 Jun 2024 17:28:09 +0200
Message-ID: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
Subject: XDP Performance Regression in recent kernel versions
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, hawk@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I have been conducting some basic experiments with XDP and have
observed a significant performance regression in recent kernel
versions compared to v5.15.

My setup is the following:
- Hardware: Two machines connected back-to-back with 100G Mellanox
ConnectX-6 Dx.
- DUT: 2x16 core Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz.
- Software: xdp-bench program from [1] running on the DUT in both DROP
and TX modes.
- Traffic generator: Pktgen-DPDK sending traffic with a single 64B UDP
flow at ~130Mpps.
- Tests: Single core, HT disabled

Results:

Kernel version |-------| XDP_DROP |--------|   XDP_TX  |
5.15                                30Mpps                  16.1Mpps
6.2                                21.3Mpps                 14.1Mpps
6.5                                19.9Mpps                  8.6Mpps
bpf-next (6.10-rc2)        22.1Mpps                 9.2Mpps

I repeated the experiments multiple times and consistently obtained
similar results.
Are you aware of any performance regressions in recent kernel versions
that could explain these results?

[1] https://github.com/xdp-project/xdp-tools

