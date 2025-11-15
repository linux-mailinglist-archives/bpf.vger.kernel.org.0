Return-Path: <bpf+bounces-74636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87076C5FEEB
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C7358AE5
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B8321A447;
	Sat, 15 Nov 2025 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFW/A+y9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B461E5B78
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175221; cv=none; b=nYrVjjmQKRkV2+hadqthBnUTeydfVYGdpRm7j8URBXrEcd5vAFIVa9WQZ4tvTiKDOLnzs9GDVxPhDT+65DpYh4kMaYEgV4TBD5dH9mEUL/FQEXQHMpaluVO6ffdwASHM2pS2+MVDNDOz6P6/qgfb7NACaqrYOrYGUzcQvgJKF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175221; c=relaxed/simple;
	bh=JHRpvV2XgrLYyQmipsJi9kiQ+VZEyR/EbZ/FbuqtryU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDaapVkj4J5Nf/JCXL5Vi7xlDzhKrVvW73gJjb+sm5We23WIwAp9k2semDNR/PXu274PisglA/mItblTOVTBtFQawonhNjyrL446wN/QesonA9VoRoROAhiJvlHcxqA3p1+3JJzJPswHlMCx6TxqgEqgi1Ihi/KJWkzyKwuc6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFW/A+y9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so2866053b3a.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763175219; x=1763780019; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JHRpvV2XgrLYyQmipsJi9kiQ+VZEyR/EbZ/FbuqtryU=;
        b=KFW/A+y9gPMuDD831dbt+ThssWDofTsd1pOyL/mOogNweMIlKWD1cRIZQStWRj9C71
         mvr7ZefZa0WX7UvtfJQ3Vm7pG8hFBwFezGCd+H/spiG6vUxqJcIdKdDSjvcM9Ts5MjnQ
         wJEHPwznpepgiPUXmr2lko4+UhBn/QqZjjHmcRk6vLmiuosr9GsxCktqUztf2wD4ZXvo
         9rr8jXZjYjG/l003Mz+rGbOuP4LPecakjoypfNY1X77RKn/zDG0aHzuCgUKqoJsB0MGA
         lE4NjKLhti7mwOHW3Qw+KbnyPh6le95crvz5+UfQReLWo2xJJebwHBIoIpOIPBb7WI6q
         +zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763175219; x=1763780019;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHRpvV2XgrLYyQmipsJi9kiQ+VZEyR/EbZ/FbuqtryU=;
        b=OkrwStGlarUsnd+Ngrzvdr4bu9G8gsbZCMp+5rCfaNSV3HI4i7fzRLkwVHJB67mSXy
         vEJJKQbwwMdHpRPzAhrH3ON3lePNAPfqN1PtW+6X7m5aY9Q05HqA1rsq8OJlZO5pIFbr
         5fz15xtvXwEUI0X4qWurh7mz+atEfwP8QYPaOWpOGgmDAjrE/FR5Bqh5xvYY0VOpnajk
         au5EBIpBCVGoDdae+a/XhjKmB2Kt9LKRiNn5+bYxIt1jLStDViaFHVzv1CeGAyuwxBpF
         NDSGY8x/15r0i5IWUUnnjPCAXW4t8Hgg3cZkdV8SlcJVFbGL3cuLEZJ8rR2teKanJc4c
         YEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2/vzxOOJX8eAovqexEAR7A5bWo6q8qHpvXLQ2tOSqgJd0MNv+sL9pWvCzng/ap3aBy1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/O/IA5V7sM4AnH+qBSuacrxxGOT8y3MqggSFuaJL14GhtvV5
	qiKsWbv5/Q5sDNd1Ucqou2CFtiA/q/WQ188DHJhu0gDZsqf5I42VkF1q
X-Gm-Gg: ASbGncsIDH33xLfZcxau5Qc3a9KZKRXJwxoW1Ieul8bX1K9Vwa0I3j/G2fn9aOpC37+
	gbxFqlcMv5xf6TgeNUmUS0PMbHQTcJufu4d0mLGv7u0X0Imo9pzVwAHnfy75A0tGu3z2EEXKhVn
	kQfRodbKHFbUM7tpAOq4Ie7yXvS85VgODfP3pwWP98/HkKYSO8xgtRtiLM1Ud0FWHuZ5BAkhHYe
	iBSoR1lD3j5SA9xOD7/ePvFtehgtFmo5mH1eqlgidr8iImIrqRnlC4H5ks0I43lqxGfHnuhP3hJ
	UnLbFC5y84Podrg6VFipzD+rxqC0AgWuNwufVju7UIfUd0mJC7UBlXtUEPYjlbdphX3ZNo163n/
	ply2biQg6QW41ld0I7K6tIbTlUYasifoPw3nAXbvxcBahpe5zta6UfYXpWE2FBjZKIb5x6aR/pQ
	==
X-Google-Smtp-Source: AGHT+IGqLK6fKVk7TxYNVbE/4a/8cW4xU4x0iCU5MnIe3UPvzfQQgDQ0/MEjdZlJ1GmIYkI0CmiXjA==
X-Received: by 2002:a05:6a00:2446:b0:781:c54:4d12 with SMTP id d2e1a72fcca58-7ba3a3c2997mr6203413b3a.13.1763175219025;
        Fri, 14 Nov 2025 18:53:39 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9251c99aasm6612007b3a.28.2025.11.14.18.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 18:53:38 -0800 (PST)
Message-ID: <efbc3058fd300150b4f4a95a90790e737020dab4.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for s>>=31 and
 s>>=63
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sunhao.th@gmail.com, kernel-team@fb.com
Date: Fri, 14 Nov 2025 18:53:36 -0800
In-Reply-To: <20251115022611.64898-3-alexei.starovoitov@gmail.com>
References: <20251115022611.64898-1-alexei.starovoitov@gmail.com>
	 <20251115022611.64898-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 18:26 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add tests for special arithmetic shift right.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

