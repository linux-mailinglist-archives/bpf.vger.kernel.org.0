Return-Path: <bpf+bounces-65365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EFCB2128D
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A2C1886498
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C629BD8A;
	Mon, 11 Aug 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq9cMaM1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156D311C23;
	Mon, 11 Aug 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930865; cv=none; b=GaSWOga8EykkyCk504hjDAtR2NqKxtBA80TJ6xVuexbMeYPb2Xo0vvEQv32f6u/QC0LwsIb5AsrDALF1ns7O5dzyimOevUwKNnQLHZcvGszFrdskPnzP3+sY7VSP58N1fPf3yaL/8eTNul4McNFq20kq1/kWk1OKZT9T50lxM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930865; c=relaxed/simple;
	bh=9OscKaOEISphy/0bykprhN667piw88GuPtzAhiRy2xo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fs6UqdJPRJIfr8C5VOgDrBS9Q9tGwg9UU3W0aoUAVoqZCgEI+YFnRPP3BrljNdvj/yJqyL1kN5LlkG9xTk0nqLzXzjRdVx/4yBL60YBy4IdXsE1n83OUoNys/QWn+V/6/57hgUptroYrNgW7PeIR7gr+k2qkW6QTAh/cJJ1Dz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq9cMaM1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32138e0d9adso3890075a91.2;
        Mon, 11 Aug 2025 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754930863; x=1755535663; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OscKaOEISphy/0bykprhN667piw88GuPtzAhiRy2xo=;
        b=Eq9cMaM1vVmHslcxIq3r6Ka11ZXpoVDm9184t9Cn3FhVJTS+zE4eAF2SnD22q4eGT4
         FboEmc+x5mJjPat8G55JBXANwFESZbOtk+ei8iGp2Nl8Lf5jbXWZxzFA19d9OHAUChtD
         TRYs2fp2XaWu57AURH57lsfmM05781GxwonRW7HgsA9DbMAM45aWQtJdawcAM8jpzYjD
         +HpevfDbJDDiq/qMZFbSSMdjHukkErm4oiqcFiRkXD1nmJyd44jcCSAv1FJDiEpHZ/5G
         t5kSLb/XBTUuZPIBlnl5gYfG0Rvlet37yACnpiB9j50LX+hirFwRR9U0j33J+BDeHkkp
         uthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754930863; x=1755535663;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OscKaOEISphy/0bykprhN667piw88GuPtzAhiRy2xo=;
        b=uvthUXBKq2+PnKTPoA+CcuGIkARfKDpcFnuhFQLJirrZI7YxpmXzSMBlL5S9NiQVPV
         +iwiPl2I/WI1VF2wfEM6QADe+zZXGpnhBfrmWGoJ756xDILwyiVaSEuQF5xl0OeBZHQ9
         tJM61KobiijxcS5FW/5WsUN3GyOu/YXvJ22AmxQ4V7F8dxT5qzgFQ+5cvrkfdrrWgzk7
         rnChY4qXyd3p2DVDgnWUA4M8poWDQGwGWC3HHNDJ2MhFnTbGxTUYrI9BFH7WwjxuzTh6
         ysvNbTpKyQdXg1C4yDGnc2VqNMRrf3kH6MhQhpcaRHhOhopGKVf4NoLuHP34KPjD1y/L
         3RRg==
X-Forwarded-Encrypted: i=1; AJvYcCVrkCJq4Gihc3QcqzEudLSq39bT7HLoxYhuDT/wC2gRSsW6r/VB3V6DHy+w9ZzbhXn7/DU=@vger.kernel.org, AJvYcCX2JqdDLPcjlv3E3F8Giee0Otvlwuj5X+vjoHedrweY/sxbxltzvwcPw5UX6I2Z6Sg17o1uoiexQjcwR2+R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52T4h0vj6gTTxUzs8YsMS65hWcdD0taTPQodDnAtZHfBpIieZ
	w95PWS+HatZHNmsK6CM9dh4MJARa4y1inWpk/7rln3is1kOhwYg0pKz1
X-Gm-Gg: ASbGncsZtKu3trjx0QRGoSmh3umVixjHMRnsS6tXeW6saw3u/nCbsCQiiTbflr+2blk
	r9bL0BIxfhm52+hPoIgdGlobvNY4iHRcHYw0lE6XNAwd/iyFieB4Ffnta4GzUllT8WXadidLCqh
	mK/nsMLfIIxOGnmYRAZbXKpv6TDcmSlqiV8JtwaEiXzLfiITG5CkJVW6BtaTMJq3dH/9YNpgLEl
	cAIRl+RsQU2lTq9afaqHejIh57UtkOKt9fZ5IzHlMDcnk+tVsrdXv5bJcANdzAJwILie6bn1jj9
	Zy6AI5TVLMfynjiHeR+rvzKDYvApwrL1WEB6e9X2fL1AvvMWKgtBkXjK2z24SnD9RCviV+fgxJq
	KnxkTdCpcqPU8Rc8FDrPa8EG24DUdRm9hJzdp/g==
X-Google-Smtp-Source: AGHT+IFXmypjhxtcs9a07HJqO/HbOQbPX16Pgd3GjsfSAhgk3vbL/M4/0BuIfNruQvA1r66jZqwCuw==
X-Received: by 2002:a17:90b:530f:b0:31e:fac5:5d3f with SMTP id 98e67ed59e1d1-32183b3f09cmr20894679a91.16.1754930863325;
        Mon, 11 Aug 2025 09:47:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::17? ([2620:10d:c090:600::1:56e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm32057111a91.10.2025.08.11.09.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:47:42 -0700 (PDT)
Message-ID: <5cdd264d324de1b78f4fc3768cc20a3ee79336d1.camel@gmail.com>
Subject: Re: [PATCH] bpf: replace kvfree with kfree for kzalloc memory
From: Eduard Zingerman <eddyz87@gmail.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2025 09:47:41 -0700
In-Reply-To: <d106b3c7-6afb-4e55-b2cc-0354f5db4bde@vivo.com>
References: <20250811123949.552885-1-rongqianfeng@vivo.com>
	 <d106b3c7-6afb-4e55-b2cc-0354f5db4bde@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 21:15 +0800, Qianfeng Rong wrote:
> Hi all,
>=20
> Sorry, please ignore this patch, because I found that there are still a=
=20
> lot of mixed uses of kfree and kvfree in kernel/bpf/verifier.c. Best=20
> regards, Qianfeng

Using kvfree() in this position was sloppy on my side,
thank you for noticing this.

