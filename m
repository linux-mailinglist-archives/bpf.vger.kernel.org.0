Return-Path: <bpf+bounces-47461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8999F9986
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7A218904D3
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AA9220684;
	Fri, 20 Dec 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4rpZaog"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89E10F1;
	Fri, 20 Dec 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717312; cv=none; b=hl64OovyaRLSJfdmC0zPTau1tMqFn/ucQ72b6SLvJOkHMgP3M/ePrmgES597/DEfNDNI5N5mdYq+Y53vX9GzGShaejiswCToKb8v/CteEO+sbtM3PxoCf4MQVnnXvX4sN+uahyJ/qxvzsqBqhCyWLqHtzyqsnY4VhU6d8q8Umcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717312; c=relaxed/simple;
	bh=35l9rRgs1DErNRza6ycXPtAZ3df3oaMWWFFVeuvsD+4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=K/VW5buhsExwP97RbiJTL9p8yynzhSQ/+Z3xEf7Y7TNwA6c4y4ZPNYdu74DdsGenrSm5Ra3D9b921RmpfILrl7CVqyBqL/nLwX53VU1Jy4WxHnnr4/xgkZ9C7MPzd+cDxtbEUevOo0rrOtRMT+C+q7DoN4lA6yGNNl3A01nes84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4rpZaog; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso1676564a91.1;
        Fri, 20 Dec 2024 09:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734717310; x=1735322110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fuBMAZLNGvTIeHMQCC4Mxsre2LvLoRdbv1sMvSw46A=;
        b=l4rpZaog66ox44DmfX1P9m5Pb75GCEzf3v//P1+IzGUBz1fpXkNEIxZPLW2L2SJZCx
         PqANsXRgCzia/uhyend9SbNfYu+LyXl9btZ3eXPwZmuvme4xxX5sdNkB0xd1AqTg4bpJ
         mLO8aew+YwTTnBSrCzeN183CVv3CFMx4iRO2bhXDro2HKU9A5DNVH/9QSDf/j/jol2QW
         AhWKo33upLHtIylT/Wh4AmfDWKfdLGzGXhcN7BIwrmaA5S2rnxak3sb4OiuaN7HbXUoj
         QOnZFrMdepc58qXdOIF0SI5cjB4/TOzzAszhhigXyMOZkusOQMfilOKZ5js7uAh1rGcP
         g/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734717310; x=1735322110;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6fuBMAZLNGvTIeHMQCC4Mxsre2LvLoRdbv1sMvSw46A=;
        b=kkRizLoB1rdXuVfhGhYdCFxhWrPLNPyPeO9xEq9/7fC0ZejVdAqE398j3hqrioNU9G
         jJHhR5HQL2OPHRyZmfYfigu85m4LUxWdoPkU6Vt102RN50gJ08rPW762EEmHi2ELH97J
         NKhu9991xRU7oWLcb3IJvwaKIWBk/43C2fD31C+jPK9fnSDVUy1uRYHBlm5LpzxmWfgf
         fFKQCyHlPAJuohvNZuD6W7ITx1VW8bMcpiiRM2BU2GM3VaFyaTtA8KzB53EcYDTHVlx4
         6yc97Jx9Y1Bgp5KET3Py8AzZIAksC1Cb5lbbcxopuehMHb840D4itGqvWYpfiY6nQz2c
         s4jg==
X-Forwarded-Encrypted: i=1; AJvYcCX3DfkmSAHlgwMmOqLzM7WqNUnlmFPd7ZcR690YeiGQgr8dArXLC30HR23Qu4FPN0hUQPFZjMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaW+dxyNrs6PMiS5q33gQay0ePjJ1KAQNYmd66zAiiok76pF1c
	shMzG0rVDVrnBH54OOAnjaXmSjytHXMSemQu1k3RWG2o/igeCe57
X-Gm-Gg: ASbGncsH2p3KLpMy4/aHC0L0Vd3FtBHvkFN/vZiXzIKVGwRsLm3B4PEJ8h0Y/9BIo9v
	Kgj7Trcc7FPiJgt3HCYDCfw1zKX2IXDDngREV7l+MtMH7r6HjCXkdMAbm1qgp7/D6ZJpV5Bfyba
	5b6yF1jB0gfFfoK08rirdD21L3ERV/GNi5AQFxozZw1OdMkvDBGJ5gKOeh4VDvw+dHp01epaQBZ
	6rbRxLhR9FDiq+nu+NVNl/0UHiWsrNP6hjTk28Qd9J4Hll/3fMen84=
X-Google-Smtp-Source: AGHT+IEaCuEZ7WGpxt8CsRJXqIlOzmVgbCWImIT9I7K2e4l5EkqsSP2UDJoSh7SprKto865h5fOrJg==
X-Received: by 2002:a17:90b:534f:b0:2ee:e961:3052 with SMTP id 98e67ed59e1d1-2f452e2fe57mr5936193a91.14.1734717310480;
        Fri, 20 Dec 2024 09:55:10 -0800 (PST)
Received: from localhost ([98.97.44.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06de88sm6041522a91.39.2024.12.20.09.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:55:09 -0800 (PST)
Date: Fri, 20 Dec 2024 09:55:09 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, 
 netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, 
 Cong Wang <cong.wang@bytedance.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <6765af7db9a7_21de2208b2@john.notmuch>
In-Reply-To: <20241213034057.246437-5-xiyou.wangcong@gmail.com>
References: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
 <20241213034057.246437-5-xiyou.wangcong@gmail.com>
Subject: RE: [Patch bpf v3 4/4] selftests/bpf: Test bpf_skb_change_tail() in
 TC ingress
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Similarly to the previous test, we also need a test case to cover
> positive offsets as well, TC is an excellent hook for this.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

