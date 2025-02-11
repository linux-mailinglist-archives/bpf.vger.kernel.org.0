Return-Path: <bpf+bounces-51180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59060A316E4
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 21:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5051886809
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3130262D3B;
	Tue, 11 Feb 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVeKMY2g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC891EE7DC
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307075; cv=none; b=gkSOIcs16KBIGTR0CV7d6NSmd5rdussaWVLmvdd1sJR018h86ShOMqogaxPRE0Zoiw7zPBG3c6r177DMsyXM+cUaLi3/CdYUjtJEN81OyoTA46WbPK6GV16skNXoJevXyxApWafCJVNgTfE4k36C4peEeEl307qL5wgkp48KSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307075; c=relaxed/simple;
	bh=cN8hjohr4uZfGrxF/+5QGRtCwHHv05h3us0uD7VGO9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtsPlyurDSBoTVVCgZXE/OkB8bM4OJHU8iEbyZLBrdFLoHZ7lf6edPDrJVct25Sc2lMKmLGIs2x2palSkLLpPmpIsV8rOt584FCee+YbN9KvQnHr328wCDUlGzZrlMoTQ73tg4dXupx+FX2OHXaxmBLxg34SqodivppMor4EsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVeKMY2g; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f8c280472so975ad.1
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 12:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739307073; x=1739911873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cbp44K+2t2aI4JlVPc3K/t0BQ8ZOkIpiOPV8PBHdLU=;
        b=QVeKMY2ggy+pUOAvwXLYllgjqOD/MLCBnq5B/Iwa5F8UW+LIqGhM+BOPexvQ8lEZUk
         KKhEeoKqRYv5S9pM5RJ59VZPaQHwo216DGSw6Jc2ke1VCLjbyZTgrGlkDdrLlsWQPPhD
         Jy6+9Gz8XJhQjZizCuCy0t+sWyZ8OmjX6kM7/j+xRAwSfCgHAy7bJjh0iEq8JzgVsMKi
         CMlAMcERbpZM3p0OH0j5rg07Zn255YFE0ZWXliQ+/1LJ5K6a1Jg248ej0LhwG1UuxBNH
         99bGYhJ2y6uFTEt6vYKIkZfLxZ9JenySHlKtCPEwWDFjtb7yohUrf7EfW7JT5VyNWa/O
         LWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739307073; x=1739911873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cbp44K+2t2aI4JlVPc3K/t0BQ8ZOkIpiOPV8PBHdLU=;
        b=bldsGv20nN5lDcmOlTmVk/Tf9+OjakM/AcoKMftTJNgJtr1YdKVpyWzoMoYEt/eS4v
         B8Fqo3fsxN+dcX8ihcPoq92tcXNvRePj8TYpMN6GWGXNBGOIjATfOn9r0ls2TSmH1zqM
         Z/DthLKzwYVewt/QhITQM37Mtkl6A1MKDHhql0PWROO7nBs4BUuVnokEQr0ZwIyTt0HV
         Y347Nb5pMlxWlfyc005xk7NibRBXM6YE6Kr+hLzKNs4O8YIc9/rEJlxDHtDz80y2HLc2
         hGWdF1QMjM9HL188X0cLSSXVmOVyZ4ncN7IC+ku2jSsbJBnvAL+c7kz6HYf9VFdn1IRv
         LZjA==
X-Gm-Message-State: AOJu0Yw4rhpqXCZwb9UfJAqzJRMIJOP0XQPhNQgWEEoUoDMOUvUSd2eS
	cEdI31nM83wJz1sFZEeUxoXo1NCdri6tCvPCECANx0UZO9rWlgwuzZ3K+NAUYA==
X-Gm-Gg: ASbGncsfawpvxueMQC+QvwfavAksqt+YH3zRfRHqY7fZnNrvZNjtlofWlBaSWo+nNmh
	xuHZyCQuDFQ5bBhPgpWVmpDVfBGU8IfHs7xi8ka/h71YTB4TWMyBIGtQ+v+i9NwnVFpA35tdwxU
	MPQJMPgMFpbeJwef6XZAdq5kZrbHL2sykdiH4p0vYKA8+q3oULaOOY/cbvBbtGYYkHYSao3RqXt
	3nbn3N62sv935+0g73+y76CIGQ6nVl5ih/93S7LQB+xTKSzlbdZiXqlmaslKMJUo9wy/kIS3ICJ
	BB+9Z07WGazzC53iO94IiBx9NanrYa0o0xc8Xg9LHwTxdvp8VKPBcQ==
X-Google-Smtp-Source: AGHT+IEoYw6Xy6tdvQD2RuJDCstg+zNrGFKyrdHcKRTwJeauQbld+07Eum8Nx/l1zp9xSJyZ06hmGQ==
X-Received: by 2002:a17:903:1013:b0:216:6ecd:8950 with SMTP id d9443c01a7336-220bcea1c92mr355775ad.19.1739307072784;
        Tue, 11 Feb 2025 12:51:12 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3ff14a28sm7543706a91.14.2025.02.11.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:51:12 -0800 (PST)
Date: Tue, 11 Feb 2025 20:51:07 +0000
From: Peilin Ye <yepeilin@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
	Xu Kuohai <xukuohai@huaweicloud.com>,
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
Message-ID: <Z6u4O930eIbAVVMZ@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
 <6976077bc2d417169a437bc582a72defd1dec3d4.camel@gmail.com>
 <Z6ugQ1bd0opoGRYg@google.com>
 <1d2d919ae6848e2cf80b81ffe5f94fd31b8ea6ae.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2d919ae6848e2cf80b81ffe5f94fd31b8ea6ae.camel@gmail.com>

On Tue, Feb 11, 2025 at 12:15:25PM -0800, Eduard Zingerman wrote:
> > > Nit: why is dummy_test() necessary?
> > 
> > It's just to make it clear when these tests are (effectively) skipped.
> > Otherwise, e.g. -cpuv4 runner with LLVM-18 on x86-64 would give:
> > 
> >   #518     verifier_load_acquire:OK
> > 
> > With dummy_test(), we would see:
> > 
> > (FWIW, for v3 I'm planning to change __description() to the following,
> > since new tests no longer depend on __BPF_FEATURE_LOAD_ACQ_STORE_REL.)
> > 
> >   #518/1   verifier_load_acquire/Clang version < 18, or JIT does not support load-acquire; use a dummy test:OK
> >   #518     verifier_load_acquire:OK
> > 
> > Commit 147c8f4470ee ("selftests/bpf: Add unit tests for new
> > sign-extension load insns") did similar thing in verifier_ldsx.c.
> 
> I see, thank you for explaining.
> We do have a concept of skipped tests in the test-suite,
> but it is implemented by calling test__skip() from the prog_tests/<smth>.c.
> This would translate as something like below in prog_tests/verifier.c:
> 
> 	void test_verifier_store_release(void) {
> 	#if defined(ENABLE_ATOMICS_TESTS) && defined(__TARGET_ARCH_arm64)
> 		RUN(verifier_store_release);
> 	#else
> 		test__skip()
> 	#endif
> 	}

> The number of tests skipped is printed after tests execution.

Sounds nice!

> Up to you if you'd like to change it like that or not.

I'll do that in v3, thanks for the suggestion.

Peilin Ye


