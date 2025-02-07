Return-Path: <bpf+bounces-50820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5425CA2D1BE
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 00:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E99B3AD38F
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 23:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B01D07BA;
	Fri,  7 Feb 2025 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mhh5H7HR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BC176AB5
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972081; cv=none; b=dIF1P+1ciLdnxX8oVvyVRb/SWQxATOGTyQBKoWOPhV6MrxARmSmUFc/M+xz/8uEifkrWdAyAhVesGWwLUvtVhIN9vAUZ7zL323qMaoI33k6cXa9E27aT+2/cej+NcMoI5T9nFAFsVVfix2HRcI30Pv+zjX+q3ldeRCRHdBNiSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972081; c=relaxed/simple;
	bh=shAKf8HDZQUbG9SwfPO2sGuIkzperBWdFL+n/R0QvFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMXgdF6pdPDWTZzuQJIfcObbjBGolp2gJS940IBTmxTIpGmt55YQu+CZcoqkukxQkcz7XFDu7GDh7Ui5JDJtyTUVx/3H+ELB1NzFJyJcsv5tQj2RrDPVMaSYvKuJSlfsSde67icnDK0d1ROTpZePms0MimYSseQq4Eu5Nkjgg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mhh5H7HR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21625b4f978so52495ad.0
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 15:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738972079; x=1739576879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iwNqxyXX+1eY/JvvBpbWmyKCAKiA/P8z+kIxPWpe8U=;
        b=Mhh5H7HRsDBnf1vmTVu5+xTJHlCnNX3//A7ki9P3xPvxp/Yg28LnsTK13QJdBSy9/n
         LK9qByB2SdAGEoEwE2QSltz12YB4IhlbCb8L+14HJYIBkPE4ntjsc/YqpT5roMHkZhAu
         TJRsJxY2NGFnXQfws8suNbAKDbJkZAcZLcOb082ulU6io2ml/cDTltRPNU+sIkdFILZP
         ny5ijs2YP7riQNRDf40oVmJSK+ttRCy8WFB7aB5UQ8DhA4RL7ylZPOUuDi1wAICfR3eP
         grtCaUcNxxjoX9H5IHNEuRzvtzH0RyWPcsMWXNAJvZw+Hzr04G2vhpgCwgAoED8+qjcy
         fqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738972079; x=1739576879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iwNqxyXX+1eY/JvvBpbWmyKCAKiA/P8z+kIxPWpe8U=;
        b=A1eUKg3mnKRfdECahLHa2P19K+iVfKME2N6dtSCSLk4xg2oLcu0jZuWYXfLcKQiIGh
         lTV58vfmu76wQW6LESGjJv5HNfBX3WkiaINHF/VxtFXwddANX40lMfYK3PhQ8UsyXnGT
         8SVRxM7FFkc+wR3HhwW8ICctz8rGh4n7miTZ9bbyc5jXOKUM9EoLINZHG7qf2FMnHZEc
         hnSZIO3ynD/j2Z6rdN0XQzQRt/W2g8lq0qWzWuqTq/J8I9mu3sPcuI054PsP24OJHvXg
         SNh/RXHIH7wz1UBd8bmdeTdYVBwH4cLs1eQa9yGOoQTGn6S1mXGPcoG9K16VkOcH9mj+
         4r9w==
X-Gm-Message-State: AOJu0Yxq6T+0clHCCqTbRS2iXReBHS3iAbSWJFQgfwZPvZnEYv/aFlzT
	aaCgqO73wlNb4ZvLhX6mTr5Mk3MI3gyYXQXIJBBguw4Za7A4Pju2b0hQKI56Tblvjr6/Q5TDyw1
	I4vSl
X-Gm-Gg: ASbGncsiXR6xm0nfV1pylQ1hnmEtVbk8bOezcgWsFOulk2pTHePr0a1Fobx7g6p1ggK
	Rm3cxMZgX8V1UNqu/XOgzN9DodbYdhXXAVzco1aHTFTL3057YS584NVVVNYlI9Q0Zo73GM6uvZ0
	ahOpn3QKhKEJbPO4ngFOnLqt30JKPKPMJ3E8I++5toJ6a5+lOAlRZdsKvSQU4Djf1tZSaL+vS4u
	uzvLUqJH7UJ137zRIIR8EjNmeHrraN4uYGFizIW5EyD9p5wBSBQJDJdX1q0cyLj449J6IpfKmF5
	bXsAOjB507M0+4UxF+QOEbItTzcbOD5SlXJngEo6pmIByEAVet1jIA==
X-Google-Smtp-Source: AGHT+IGONo3dtPJJjK/HmC8+ldNbaKs09fGFZfiee4cJhRCwYYSr1ACZHZYbwAWDerUtnX53vOlO4Q==
X-Received: by 2002:a17:903:19e7:b0:21f:2828:dc82 with SMTP id d9443c01a7336-21f69defa27mr932095ad.2.1738972079145;
        Fri, 07 Feb 2025 15:47:59 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c16180sm3560862b3a.129.2025.02.07.15.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 15:47:58 -0800 (PST)
Date: Fri, 7 Feb 2025 23:47:53 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 8/9] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
Message-ID: <Z6abqWVQRAFHAUZm@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>

On Fri, Feb 07, 2025 at 02:06:29AM +0000, Peilin Ye wrote:
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "../../../include/linux/filter.h"
> +#include "bpf_misc.h"
> +
> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__TARGET_ARCH_arm64)
> +
> +SEC("socket")
> +__description("load-acquire, 8-bit")
> +__success __success_unpriv __retval(0x12)
> +__naked void load_acquire_8(void)
> +{
> +	asm volatile (
> +	"*(u8 *)(r10 - 1) = 0x12;"
                            ~~~~
I realized that I am using STORE_imm<> instructions in load-acquire
tests, and llvm-17 -mcpu=v3 cannot build them.

Can be fixed by simply doing e.g. the following instead:

        "r1 = 0x12;"
	"*(u8 *)(r10 - 1) = r1;"

> +	".8byte %[load_acquire_insn];" // w0 = load_acquire((u8 *)(r10 - 1));
> +	"exit;"
> +	:
> +	: __imm_insn(load_acquire_insn,
> +		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_10, -1))
> +	: __clobber_all);
> +}

Thanks,
Peilin Ye


