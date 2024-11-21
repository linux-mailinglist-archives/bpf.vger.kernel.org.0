Return-Path: <bpf+bounces-45412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361259D53ED
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 21:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B924AB23F51
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF51C2337;
	Thu, 21 Nov 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtGtruM/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DC1BF58
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220640; cv=none; b=efgxgcAzDOWh3U9G1fzsTr8i6XpVQxhvLaF/YVdw6b8yDYXHDv7zE3zXcGBZXnSaLfAoIVZ9zr0ikQHXEXxamqR+J4IGgmrOI+A9K3C2EDQBKL2p5jkrdsmZerA0GB4THzNwXfGQRmc0IB0bo6id0lCz+CNc+StfkvxcWX2x3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220640; c=relaxed/simple;
	bh=kvOEFeJYI+wr3NQaQmzQlYaw1aXCj/ks+IiE+3t8RiE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkBLR+EqW3CHYYa6xK7bBF7Y5/U34Cj7CYm3HPZLX8SwZ5JbxKUPloE8hp5GbErY+pR5ExotSGOjN93ID0GL8YB/cRXIBO/cGE+XaQrT1rOH37Fbjboz6jSBFtvWEjyS0cPec2yoyqZpZl7A1LNRvV5luVQY/DCTqsl2y0AC8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtGtruM/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21145812538so10624605ad.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 12:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732220638; x=1732825438; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kvOEFeJYI+wr3NQaQmzQlYaw1aXCj/ks+IiE+3t8RiE=;
        b=LtGtruM/2MCmQR7NXo1L6qlzVfaRZTiRjsILkHs55ps+vucfZHJzVM6Ib4rUDEo9hx
         6TvKO9rTQBfDKmrAirN+yEGA2qbOBiyQeMuFc5pw0i+nDtk/qkEVFi5mzfOL1jMeIsCw
         aOLfofVsvqHQYw5luUYG+8Y6V3keAIIjYOk1aIbfcOsQ6GE9SnjyMK7VQ0F9twjhJxjV
         d0IyI3kC60A3ifNiHsONkeYD1i586l23PKu5bBTPyDp+fOVsEejM9ul6EXI2A4yn/6fQ
         ffQQsLhNxQ+YoFjijGtX7Orf4bdOrPA9tnEfX9QC44dklF1GwJ2lBxMlSfD/O3g8EMvI
         04Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732220638; x=1732825438;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvOEFeJYI+wr3NQaQmzQlYaw1aXCj/ks+IiE+3t8RiE=;
        b=o4GvQt/ykqoxU0U+27A7GPZ3/MHxSS+oQFgUM+UhbYulB3s1XHA7QDH/xO+jbmZ/vR
         dduvPmnfwb9CdPWbLoLnqg8MzVB5K4j2FeQmP0rL7MwsoiHEu0E5jcMW8+Fd2b2UdaF7
         creZD1f4e8tEREutOLk/KitpVUGDz5ULxqYDAt4Gs47MQiUi+x0cSwsHSRGkH/77AolV
         slNErnq8I6s4dbrH0OR/H5K8k0ivszErIfRrOGeT2Yt8p7rTPLVg7b90pSyAsPmRDAjz
         8geHJQ2MBBje8X+W7dLXNLQR8cMih4UaqEyHXSmxO3rPQYTZ6h16ezb00vYferVTxdme
         /jgA==
X-Forwarded-Encrypted: i=1; AJvYcCVw6+1q8t3Fp8oXBKYmAgoMHvPknk1WqjhVO8UMd14dO/6SQ8j4VdobQOTTycpDaUzU5Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QDcWP9kOhcF4e4knHwNmR2CiXTHJPkc3NNJ+tbH6Rl6rDfAD
	DqCj0y80+clIf3wtlnnRaWhDHLWkoMW1tUyUAMGGC67IgIQl4r3p
X-Gm-Gg: ASbGncuWk0zBQXnL9q+amJkocvDtZPOrWEoXWZR8HEnRi+peBH+dw5YtG/FmCjqrvFp
	bwgVKLVf1IXeGewsrzFcoaLRY2+qrp3qToArd1yXc8mt2wugkCfZrEN6EyDJ+sCDWs3xQC7So8/
	Ox+bdJqb8pyvVkErRp5wMck9cfdE3Uxudi4tJT5t94y1hNsrvZW59MMT+wlfZbCxYBF5D+3GHI6
	NmWgKENI32Mf/J1dqcdkBntHx8rfnnS2lDVGvnh1oZ82ao=
X-Google-Smtp-Source: AGHT+IHihRknYdR0oGNyooa4g04M3oZIxjXwznnvcQtyRAehqInVxi8iyfouHCPVNQD5VXfBFKduyg==
X-Received: by 2002:a17:902:e5cb:b0:212:10e3:7671 with SMTP id d9443c01a7336-2129fce2fcdmr1444165ad.4.1732220638527;
        Thu, 21 Nov 2024 12:23:58 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8d449sm2446155ad.28.2024.11.21.12.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:23:58 -0800 (PST)
Message-ID: <9ef6bac0d6200246680cee1268165bc69944e981.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/7] selftests/bpf: Expand coverage of
 preempt tests to sleepable kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@fb.com
Date: Thu, 21 Nov 2024 12:23:53 -0800
In-Reply-To: <20241121005329.408873-7-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-7-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> For preemption-related kfuncs, we don't test their interaction with
> sleepable kfuncs (we do test helpers) even though the verifier has
> code to protect against such a pattern. Expand coverage of the selftest
> to include this case.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


