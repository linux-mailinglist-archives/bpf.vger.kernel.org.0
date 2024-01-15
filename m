Return-Path: <bpf+bounces-19521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CD82D4EF
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 09:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906C71F211D2
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A7ABE45;
	Mon, 15 Jan 2024 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHuMjf56"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198287499
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so9746460e87.0
        for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 00:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705306809; x=1705911609; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=VHuMjf56jBJlL7v+9RPUoTXLrOuIslJFcSy2mSQ/IEa5x6ib2I5ss2zeyRXRTl2PwW
         Lponmyv1fhHPnHizOgHeAfsFeehbFmtnLVOm3/Um1TTlQgMRf9Mu8x2zXDvawbmNYxIh
         S4qX2ic7bLF5mqvoK2OBZcJuCiXh365EA3y0BWspHTRiMisfRx/ksMAmmIYaps1XDwun
         qvg0EXCCnakde9xE/fraZRDK8GiNCQw9cmRUq0aXlpMwzZwzZJpTWeDXKLTp7Ks2ZMTX
         Iry4T28XL8YQfGWpS6cDdcZqpI7HsG7LJvLOYEOBVOjaim49WLKBFnZwftIcYBWMlknH
         S6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705306809; x=1705911609;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=HLq5ylPC59HadvFP/Vrnd7oxAWP7uVrglPybFK/GcG0jmRn0Cf2r15hud6ePdyQgZn
         0ow7IYJiLX0mdA9KbnjKJC1LcJJzETo4i50EC5WUBl2HPgmT9nk7i8T8ovi/n7Og5Qa+
         1N8U53tbXoii5kgnQOpYJH9mYhuipxDG5a4MeiHBz0Jf3JvAEHO8aqT6zdKoEIY5znOU
         c+miUxGpG7z3uEV81i1XhAM/PSbn7s5nQzjA+ewnazEp4Ax0waKFcwq8MA7NmwcY8ZFj
         OLDnYdMyFJNNW+uzJNIF1ghMS2vIwBLJmNcR0ZkQKAwlfkuhwYCEiHLzsrN9qY3BgSEe
         bU6w==
X-Gm-Message-State: AOJu0Ywd906b2r2RSggJSfKUaUgX2wl3fKmhC0WJ6bvCpdmJEoGI9qcg
	pWrOcbEB94iS0Km+dWFYY7yhv2hRflXx8vsh7sPZuvNSqhk=
X-Google-Smtp-Source: AGHT+IHbGK4ipjy9m9Fkx1ewbQ69KhsKtzi6kTrH5DPxfl4UykVwA7Rj63/aMtQ2clUtA0uVC567MOWHglyF5vvaaUY=
X-Received: by 2002:ac2:5d6b:0:b0:50e:c8ec:8c42 with SMTP id
 h11-20020ac25d6b000000b0050ec8ec8c42mr1839311lft.130.1705306809514; Mon, 15
 Jan 2024 00:20:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: limin yin <wodeyinlimin@gmail.com>
Date: Mon, 15 Jan 2024 16:19:56 +0800
Message-ID: <CAGtS-msYNmRGDdRS6p+GwGiZd=hLNT29gOir_xfa_Wbg8=+xLw@mail.gmail.com>
Subject: unsubscribe
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"



