Return-Path: <bpf+bounces-52025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB0CA3CE93
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F15016B95B
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17491C6FFC;
	Thu, 20 Feb 2025 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jutKlRmR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE521B4F17;
	Thu, 20 Feb 2025 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014499; cv=none; b=M5OMiLf+0Wozes7ItFTpJT+bNQwEYju9sbb221391ZMaIdLMmQu/slmNhXTFqF1jEtOaZo0WXiWgOM1UNAmKY8zeW08p9wsCJ5nFhN3skuVs1d4y3f79c4MJ6boKWs8neqjPEwIpXijqzIePLPuXVzPHxZ6MYxj6i9CtJFxwPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014499; c=relaxed/simple;
	bh=A80EzCl/Rc6HH6mpjmLMlEM1dLPhHLf7W0jhdWpqpW0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=saSu0ORX315cWsomlv3LFN7JT0nC8jK6a+Bs934H/gHjPpYXu5lRvItbmOUcRZJFlFDadBS8Ozp2LVZw85j/+fJqsMWJUk//7Z3Bcsn51IOLz71/rFGRj4gRAxby9JU6iqKypfLtLlJ/iCdtgVYlEwzmTOb4A9ho9Xr551DTr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jutKlRmR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso800124a91.3;
        Wed, 19 Feb 2025 17:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740014497; x=1740619297; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IDsLjtFBj3deI+dVxQXARgpzZU1fDZVAfCzc3BIDOTU=;
        b=jutKlRmR8wcwMmS6aUIOcNt9OGQ7LDMTeJTSPx25b7uYZLxNKi2f6Uu2HqLiYaQ7mm
         tLVBGD1WFPCcnRvsxfxsNEdNW/tTABjeXbs2AYew2KuRiL9m2ogB+yJa3iATfa2uoTUT
         Ualm/KdlEmQ0xQcCsgC3XNxpOlPHKNbYimO184/+5KzweFBO978U8DSdztApNZ/aEBvL
         EyfMGJqL4hWD8ZgWuCFqvDyLInqoUCO+CN+c/ymK6XQ67Db2IkbwZYJSQeBJA9prUL58
         4eTxgKNR6gpqaa5YefSDz3qeFCa8DsNEasB+GBX3ny3dw3pTn7cdp3FU2jSaKgt5pR+H
         r5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014497; x=1740619297;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDsLjtFBj3deI+dVxQXARgpzZU1fDZVAfCzc3BIDOTU=;
        b=Z2a0bfOyB1i2zd6dtWCoCf6/YxbSu5KA9A6HlYrwNZFRuiWBe+bxvxCqlnllDiVtt6
         t3omjF+glNP301TZAe0eV5sbNvGei29SV/el8xklhDIp1T44sCR8zqJL87JiFzM9ZLOH
         lu23yf9GcaxtL3+f+YCBrZOfT6tcWHwN1bWzTPMof14usvt7q8ILtB7+TEgpJjd/BO2F
         n+eaW2grURYQDz1c6ltUwhkzaptm53El2604xVKBrCPO7kx48ZV+2xwZ4U+tmwDu/xsH
         ibGm506MIhgTdvAuEDL160TdrbiXEmiO23qes6zSnc+7LLpjkwkiknnGrD0HajQmQhu4
         kiZA==
X-Forwarded-Encrypted: i=1; AJvYcCUd2ChCEdsAbfXMrQ778xpWayvdYFXglBLBv/IZGg3Y5Qeo5NEsKVvtt5I9omC7B28P5OwOQk9EYbCxbo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhTLWpWSvWas6oEZKnJWkmqYKyVvznrJE1INsgxFzemb/E8T8
	IYFWmKWzGAr839zDT7A55gOVvGkuphawOzVYwFwayv0kELFKr8dt
X-Gm-Gg: ASbGncuxUGaMlhAKY0BycSe+exTFT4pscN8r/0b5tVy5s5gwggQUo5VTP7AF8j57nbQ
	d9vMkbLI0r/qzYfTo9HpqwSprs8Ly6VrzfxqYGBnWFswmkkkxR2zae1zp/hGo9qMIRhpUntp8sA
	9vhddqdN/Y3wTNaV4eq1PZJ3Z96zVnFnh8lAgGKWvbBiXl2y4LQwJrRcxMgU91bfJqUfJJRTMi+
	rE9cED/f4Xt78ZHjilhMjTMimsbsEaKGJaQ08FWcZYMn6Zl7MrSfxGi1ueyJtbpz8at0KEHmrAS
	6cR6SPxaQUpv
X-Google-Smtp-Source: AGHT+IHk9GIHf8OOYIkBRVhPLEFoCcWI13PAFtnrMzZXve0ebZLem5ph7p/HYu2/e3qv9LJ51Ex82A==
X-Received: by 2002:a17:90b:1646:b0:2fa:137f:5c61 with SMTP id 98e67ed59e1d1-2fcb5a15a04mr10720243a91.12.1740014497002;
        Wed, 19 Feb 2025 17:21:37 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536457esm110713175ad.85.2025.02.19.17.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:21:36 -0800 (PST)
Message-ID: <137eabdcb1494debd9f321ad6dc39443c084ad34.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 8/9] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
  Xu Kuohai <xukuohai@huaweicloud.com>, David Vernet <void@manifault.com>,
 Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend	 <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Jonathan Corbet	
 <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan	
 <puranjay@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens
	 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Catalin Marinas	
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Quentin Monnet	
 <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>,  Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long
 <longyingchi24s@ict.ac.cn>, Josh Don <joshdon@google.com>,  Barret Rhoden
 <brho@google.com>, Neel Natu <neelnatu@google.com>, Benjamin Segall
 <bsegall@google.com>, 	linux-kernel@vger.kernel.org
Date: Wed, 19 Feb 2025 17:21:31 -0800
In-Reply-To: <Z7aAmYi5zaVIgRKR@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
	 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
	 <6976077bc2d417169a437bc582a72defd1dec3d4.camel@gmail.com>
	 <Z6ugQ1bd0opoGRYg@google.com>
	 <1d2d919ae6848e2cf80b81ffe5f94fd31b8ea6ae.camel@gmail.com>
	 <Z6u4O930eIbAVVMZ@google.com> <Z7aAmYi5zaVIgRKR@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 01:08 +0000, Peilin Ye wrote:

[...]

> Then realized that I can't check __clang_major__ in .../prog_tests/*
> files (e.g. I was building prog_tests/verifier.c using GCC).  I think
> ideally we should do something similar to prog{,_test}s/arena_atomics.c,
> i.e. use a global bool in BPF source to indicate if we should skip this
> test, but that seems to require non-trivial changes to
> prog_tests/verifier.c?
>=20
> For the purpose of this patchset, let me keep dummy_test(), like what we
> have now in verifier_ldsx.c.

Well, that's unfortunate.
Thank you for trying.


