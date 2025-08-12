Return-Path: <bpf+bounces-65423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A1B2281A
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 15:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D2B1BC3B63
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A6E25949A;
	Tue, 12 Aug 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Q60uJaTs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C678F54
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004153; cv=none; b=K9mIas4Tga7AdVhEY4FxDtJHLqFlbuBoPf6exH/DIOo69saEsoT3l6XCBlrAz3GrUFMZPwLAjHxs7ByE83mPTaRiBT4EyosiaXHl4tZKbV/SLgQnVsLXD0DMQIP3Q7Fsghc0CPNa8Tl8fp38W+kzw8bZY4S2Lu0NbbWxxrPds40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004153; c=relaxed/simple;
	bh=MAomTme2JM325tkXeqcrCAovhqZxr09aQ6wqQb8gykQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=f0wwDvC0oFSTmXU+ZaOdB2tOmNpSlDBNUNlEsbHcL1e4i3huG6goX8ZoRzCnoTRMdNbqi0v3tnUG6VhjhplPoY5tHr/tCU0kAbAdi4NiiE8cdGp1exJHtHdAObZ/SkDSwF1mBFvAi/DCZ/QNB4r7c/e+FgUU6owlflNo7b5ZgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Q60uJaTs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9139aa446so34235f8f.0
        for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755004150; x=1755608950; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAomTme2JM325tkXeqcrCAovhqZxr09aQ6wqQb8gykQ=;
        b=Q60uJaTsOOF5ebIfW/00Rg/iFfp/UJrgpzi7fKjwp6OTaKkDLybCBw0oecXEA//Rp+
         OEhGcYLbgYkbIM3Jqdd4mWxKCBxkFpCG1laSD0Ws++cxWdon7EBiOWhUdlOpynHq+MJw
         FW1Xadq1WVL9LjDYEeJdAftoZBH5to/rZTxpgeifgSEqvdaOJC/yjeZpGUk48lB4IVbR
         BAEEnH7+gqXVnBBjJ4kOMSk4X34BVW79dYiOzTs+TxWDT5PeiZUfU8nDacTUFgmgsTta
         getoB0iBHzEY7ytHu6DFxcWuzzNNpccBdWZyeffW5MZEt4YlhZG3RpisIgbexcViP4oo
         lLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004150; x=1755608950;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MAomTme2JM325tkXeqcrCAovhqZxr09aQ6wqQb8gykQ=;
        b=IvedcahZ2aoS2/kHWV03PbX8oYC0M3EKczsng4BKVvXtPEqQldobg5CuPgVuXc18xJ
         +RcW6520YTRCO5zlgG6V1rP9tcD5c7itN2JxM1iU3z079qQNvAL7RLgA9oxOg+KLVqdS
         yxE4AtpSn6z6bmRmYctR0jEz6VCG2ne/2HQqdU5Ut5kg2b1/DZpc33J7RK/OTO/OGyXC
         lXfYm+BPFNHuG8OmJyVawAzTRrNTGhyAvf+Iz4VQB8Exdm2BNDxPPdYbjcG/AO5jOhHU
         7lQsH/Z9WMchNjjDyDLeVdp8VKtCJoCePMbzcLx2laE5toiXBiWwqFIkSt33Iz60f3SJ
         queg==
X-Forwarded-Encrypted: i=1; AJvYcCXA2awBdsqw5aTdKHoObYYab8v0x+mIgXCoarkw2Px2uIHKIbD9T+yzWlFqovFdPhtj1X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5x/3OB3xGz+4tVDagVuYdVI5FLR1htMqD20rI1VAia638B1M
	6ynD7OoIiwZH2eN6qdwB5BWgUUxi2ojGas62Nv5h+GHVxxFSFESFLJAcba8LwzrzSTU=
X-Gm-Gg: ASbGncuNQVMJpIl5wZq3OxWTMq3HKdFgoo2vyegNWlHUuSyy7ofcN4EGlIGyEW9nXcw
	4tNTYTXJYzANoS1v0sBtIp6Lx5Q3m0j9BwXDqyivG43/7eXgkHMBGo509jVJ9ZOJ6J0mVfJyP4b
	hrZsLYnbqSqvCGcxaPKd9Xn2mrZLUb95+h345IAKP7pIJP/tVHUJr0OeqKaiuUi0GZSZRx179sS
	TXCwskVTP3JFgZP73n2332uUxq2ZZjwreqn60h7ZC35yq6RRNvtClpFutQldsAypMFzse6vydYx
	Rea6KRizKvGnnxXOThYA+i0HNY31L4EkK1LOEojkM/+LHkKKxOqYytqnNh1sqbCwKAPcN2BTPz6
	YuS1sg6Phb2i2qZQeUhWRjZ6CE5SRJw==
X-Google-Smtp-Source: AGHT+IFCL0S2fG+7EvsWvlnJgkjJOc9wFOS6dc1oCWSwvbA7urqknr0ZeJjmy9NTqLN0RG30vSqL/A==
X-Received: by 2002:a05:6000:1785:b0:3b7:948a:137b with SMTP id ffacd0b85a97d-3b9147c2a32mr526638f8f.11.1755004150288;
        Tue, 12 Aug 2025 06:09:10 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c338c7dsm44458535f8f.0.2025.08.12.06.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 15:09:09 +0200
Message-Id: <DC0H1RZKZ3QR.82P8JXIL5NBJ@ventanamicro.com>
Subject: Re: [PATCH 0/2] riscv, bpf: fix reads of thread_info.cpu
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Puranjay Mohan" <puranjay@kernel.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Ghiti" <alex@ghiti.fr>, <bpf@vger.kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
 <1fdaa939-d26c-454a-a722-7d0a590557b7@ghiti.fr>
In-Reply-To: <1fdaa939-d26c-454a-a722-7d0a590557b7@ghiti.fr>

2025-08-12T13:37:16+02:00, Alexandre Ghiti <alex@ghiti.fr>:
> @Radim: This is the third similar bug, did you check all assembly code=20
> (and bpf) to make sure we don't have anymore left or should I?

I looked at load/store instructions, including bpf, and focussed on
patterns where we access non-xlen sized data through an offset.

(Nothing else popped up, but I mostly used grep and cscope as I don't
 know of any semantic tool, so my confidence levels are low.)

