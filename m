Return-Path: <bpf+bounces-78826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80491D1C38A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE95E302D2F7
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E938F238D27;
	Wed, 14 Jan 2026 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTglcV4g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5E184
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360564; cv=none; b=aJcbfwOvHxM1CGHzt60tNqcmrddcy0QgarzNTg/okBJNz9ZF33/h7VkwJBoeBrXsPi1JnlupKFMhYwWXJ0MZvvoIWCKoLr3doxFLS0AMxl+UWTB4kjt6w9hbt/E9Li+a8QwQgQp7dXEURTbsmRiYwZolMhEoCuzx8xcZWgmY0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360564; c=relaxed/simple;
	bh=XqRt8Sfsn5xPmviWJUiB7z/Mb8Ay8ol4wFqzmYA/yic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0D3oNh1fqwJ/3sHmL04L+qZ2lX0L1y5wNT27D4ez0N56uOTknRCkcrl780H43lydpHe7/Brg7rogYiywZlS+gwOzYRtYDvy+5wvoYDNQf7wfmaAU3Z8ZFZlNvV0uoItK+UKERi83pKxTAY+u+cvMc3sxAFf+4OUak4fX9Mesnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTglcV4g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so10227025e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 19:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768360561; x=1768965361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOpXLkCrLaQ8bT7D8CRMu8TzVufAq8D8RacHwJ5HWZs=;
        b=dTglcV4giOPqN5qCtY+z5NpL/P9KH3tiGUiS+ZxaHMhRdKoEBvs0cUio+6dGsYDNoB
         ax9ODWkXigRaGKt/KRGlVyEsUgPBlWj552FBuuKWMPSOAZiWg3XleBtJc9gbrj06qiq9
         wPJoSMr2ZLmuocBvXlGn/9jKwahN99ooX/FOIWhA/4P6O91NTDEXHbEXcFuq6EP42s84
         Sxpi/RpRK0I8HABpQRx//4SWYPbmU668EZYO7rmyV8lB8QPmxj3HpxLJujdK/WyFLKSV
         SquUfCR3EJR3JnmkXNKdGHiXOx3Xlv8wLmiErEQitszPJKF6Kh5GZgxhJskv1EZHmwoe
         GPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768360561; x=1768965361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOpXLkCrLaQ8bT7D8CRMu8TzVufAq8D8RacHwJ5HWZs=;
        b=Sv4cUYsraB+JoOqEENQNjz9u4hgkDIl/cMJf2zFsntbiVo2JvWNK9wIo43YvH/p9xS
         BfbcyqbYDCMga5KeHPpdBu5/Yncr2+ZEuv2BKh3R5TZ9sBd54tFSMV5G+LulTqPir5zI
         FBkIrfFlSGdSvIuYzAIwL0Ggy8MSvRN5IuWTqvChwx6+obay76oEGULEr5OOPwGGIk3+
         dGX/RXsg8Vz2gd3Gxm8pXW4f3cmh6eIuuCwUlQy7P/JRxkmEBU6WMdVlLCMPsEZZS4BZ
         YW4udkqpp28tjHQfrhorSIEo7/SM733iaY3xiWjnZ4g3tlT4mEfbLBJaDgDNNxfQKJXE
         htSg==
X-Gm-Message-State: AOJu0YyXpp3JME+eMElHbJLNpCfScfugUsyygGdOh+fIjv2IQUEgF9Xc
	FA0EZ1bF74Nalidnee2J2mhbP8y4WuHecjh28qq0QqZGcpJztMw+VCXA5U3njtIkvcjl4cR77Zo
	/LQXkFX5/lQfUuFnJ0dTvZluy2nY2o5E=
X-Gm-Gg: AY/fxX5bV5YndFiI8UOSUPWiMb7K/ayEGjGvozcBo0KQTVeIlt/H7ebwx+L88tyE/Xe
	yS4VNyl3ksIP4fwbukMf7/6U4024G9FKPkLQnRfc6lA6g3vfXjTHtiYDEGk4IfOkBHDjASFYPZZ
	YycZo0fJmJNcueY18aZoJ2lnb/Qvu4LxjNElWXTR2/MdBr63r6Q/UyQ9M2L6NC/4kH086ZLZRo1
	vqrJ/8XygKt+DQPtNOK1B0YS/JAdx8iS4jWEoiuA4+9GddY+rX0GL21J/3h6gO80dLHREB4U9Z1
	7Oe6VzUAws32duSs3TlAOat4KtcI
X-Received: by 2002:a05:600c:8715:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-47ee47bbaaamr4880465e9.3.1768360561256; Tue, 13 Jan 2026
 19:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113152529.3217648-1-puranjay@kernel.org>
In-Reply-To: <20260113152529.3217648-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 19:15:50 -0800
X-Gm-Features: AZwV_QgA1Fulb83GJL6jh8nbg--f8skgD_juLKXuQPxhzhUCfevKlHnBAFkjq98
Message-ID: <CAADnVQKHAqQ4aOyBGwdPA79e9eEJWQ668r_T7YDrKCfOVDmHxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Improve linked register tracking
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 7:25=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
---------------------------------------------------------------------------=
--
> ./veristat/src/veristat -C -e file,prog,states,insns -f "insns_pct>20" fb=
_before.csv fb_after.csv
> File                                               Program           Stat=
es (A)  States (B)  States   (DIFF)  Insns (A)  Insns (B)  Insns     (DIFF)
> -------------------------------------------------  ----------------  ----=
------  ----------  ---------------  ---------  ---------  ----------------
> bpfjailer-lib-tests-bpf-dbus_test-dbus_test.bpf.o    do_parse          60=
19        7631      +1612 (+26.78%)     124809     151707  +26898 (+21.55%)
> bpfjailer-lib-tests-bpf-dbus_test-dbus_test.bpf.o    do_sendmsg        60=
20        7632      +1612 (+26.78%)     124823     151721  +26898 (+21.55%)
> third-party-scx-6.9-scheds-rust-scx_layered-bpf_    layered_runnable   12=
5         148        +23 (+18.40%)       1940       2381    +441 (+22.73%)
> third-party-scx-backports-6.9-1.0.11.1-scheds-r     layered_runnable   13=
3         155        +22 (+16.54%)       1700       2152    +452 (+26.59%)
> third-party-scx-backports-6.9-1.0.8-scheds-rust     layered_runnable   11=
4         136        +22 (+19.30%)       1499       1951    +452 (+30.15%)

This regression needs to be investigated.
Figure out which part of the diff is causing it.
Is this cpu=3Dv4 only? What cpu=3Dv3 numbers look like?

pw-bot: cr

