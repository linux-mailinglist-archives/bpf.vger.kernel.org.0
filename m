Return-Path: <bpf+bounces-51179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C5A3167B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 21:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A12188A388
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A61E47CC;
	Tue, 11 Feb 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBCcojcs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6999C26562D;
	Tue, 11 Feb 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304933; cv=none; b=pRB7Hgq467G6/KdfddK8vYYoGSbAg3deFm6alkzphFbuSGuVpItIwJO+e+bv1D+GxsvVw8PIiep/zX9aoF4agmXIQSybw4E8CO5/KRtuiZ+UqM8qK3QzP+HXyvicEH8sRlrmWfhujZ0+r1BG2t1dQMGzvH8zQfgBkmymZmByLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304933; c=relaxed/simple;
	bh=dcg9RpGPxYp5XRUaiEsUnrNrF/psnZ/GP6iQ3+Ue6DU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g8mEYNXQdtJkS6t9wzM0YD6fDXrSNKc+BxKqyQHmGKe78s7Q53w6HonXmh8aZ29zTn/nup4G+UG5rbBMxQpDOlcjn6uYUTEjScc3m/P+QblBJguXNwQYEB2bsktzSI356VuI0+mBx9Pl+lEH1spZiYljAGnMQ5jTWqn58o1eI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBCcojcs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f49bd087cso82270835ad.0;
        Tue, 11 Feb 2025 12:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739304932; x=1739909732; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hKXkzixeQgbhFTp23RVq91vCGlv0JVX+RKV3xjdQZxE=;
        b=iBCcojcsfgAfkfxXRSmLcn4EExNXKdLwmHRWZQNfl79glfBOSPKiHg1hZ+DWZJNsVt
         FAdtVelJ7/r3FouL2cTJBmgxahLzVRJvrAaU8KcE6YSSO5ZlSiwu2BdkrvRgLn4U+zLN
         /m6ufo0qTCr0urMS1gt1B+KEuGtsFgrQN4L3rmwnT9m0fwVaPkKOOj6UCNS83zw0OJGg
         lBN5k4z5LH5lpMrVzwhSAcq1PzNm919G3Qjcz2wzjR9B5W3b2bhwN3ce7/kDr1rwPvm/
         5lrDdYLP/h8hc8BJuwBbmbQH8H5lM5Nuzvg4a+o0SAqJbXwWc8jlaUsMK0kZSBRKZAJ0
         IGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739304932; x=1739909732;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKXkzixeQgbhFTp23RVq91vCGlv0JVX+RKV3xjdQZxE=;
        b=uhOEfIKK7GY49C8PFc2ItbQXmIlZwcOwllfQ2P+ThxdNltlj1TMPKOKmOT2RK289JZ
         dmWwb12FCaciX7SkcPMpCL9KS5Ko0hX9i8c3sCrWO0vygQSe2hJqz7i60Ybvl3bkA6wI
         t56xgNpLuHTqaG8X5Dn0mvdI2EIOzy8PTptWQHTgmFfn6TGuink0UPzOvrBVI20hcIam
         lNQSgpkQmBlG5Kryr9IEJR/e5kvwFret4gm6xEXwbxeRkJyim5OGBwFzvMxvl3Gh4xWJ
         k4ZBvoOQ+ozXYRRsoV8wDdU5HS07oqqoxm9MsPO21Kwj1JoPj6/HIbFdP0T80+uebEQS
         NBJg==
X-Forwarded-Encrypted: i=1; AJvYcCVuCbstPw52g9jqZTyy0hVIftkndJTY8+TsxNfqN33lfyA57uT785KMP/2m80GnB4pLbKP0tPHBOtotcm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgEJlJKO50pPYFlD5hgdpO/BxVZGMxf6ot9twoq3HPC83kFK9
	tMedCXUMtsZpHPL6QPAyrT0CI5FZHq7cvWTqVD9HjcQhuVZ4mU8/
X-Gm-Gg: ASbGnctQHxZllS3IJawrK/kk8XIDv48UM1b0zjh+gvLG2U8FlwvL0/LUUeuwl2EPoA4
	I1PSNMDMd+cBg5KV8D4tPq5CpikUj8+sdPI1GXb0t/jEa2k/xqAXaWURLdQ3Z/dAc5PRSz6HNfZ
	Vkicm0Sl2c57mxNzduA8XsyqgEdXHzyZ2SU187VTJxPyLlEi+s8be0C3K8YD0nB1a+qiPFbLfVv
	1Le5O2RlPGiE7xds1URpfCYBmGeeQZNQblXYO0afJ6BtlfugDMhvZwOxHaX8oaiJv+itNtK5SiR
	+HwjysB/TyLI
X-Google-Smtp-Source: AGHT+IG1vKfAChOkwTPX9+7chsiPwIaH1WH3GP1697y38/vBbGAmUv8F5DHIC9pOxmAOp53ppBWSlg==
X-Received: by 2002:a17:902:ce06:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-220bbae21e6mr10376505ad.12.1739304931600;
        Tue, 11 Feb 2025 12:15:31 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d529sm101333785ad.145.2025.02.11.12.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:15:30 -0800 (PST)
Message-ID: <1d2d919ae6848e2cf80b81ffe5f94fd31b8ea6ae.camel@gmail.com>
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
Date: Tue, 11 Feb 2025 12:15:25 -0800
In-Reply-To: <Z6ugQ1bd0opoGRYg@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
	 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
	 <6976077bc2d417169a437bc582a72defd1dec3d4.camel@gmail.com>
	 <Z6ugQ1bd0opoGRYg@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-11 at 19:09 +0000, Peilin Ye wrote:

[...]

> > Nit: why is dummy_test() necessary?
>=20
> It's just to make it clear when these tests are (effectively) skipped.
> Otherwise, e.g. -cpuv4 runner with LLVM-18 on x86-64 would give:
>=20
>   #518     verifier_load_acquire:OK
>=20
> With dummy_test(), we would see:
>=20
> (FWIW, for v3 I'm planning to change __description() to the following,
> since new tests no longer depend on __BPF_FEATURE_LOAD_ACQ_STORE_REL.)
>=20
>   #518/1   verifier_load_acquire/Clang version < 18, or JIT does not supp=
ort load-acquire; use a dummy test:OK
>   #518     verifier_load_acquire:OK
>=20
> Commit 147c8f4470ee ("selftests/bpf: Add unit tests for new
> sign-extension load insns") did similar thing in verifier_ldsx.c.

I see, thank you for explaining.
We do have a concept of skipped tests in the test-suite,
but it is implemented by calling test__skip() from the prog_tests/<smth>.c.
This would translate as something like below in prog_tests/verifier.c:

	void test_verifier_store_release(void) {
	#if defined(ENABLE_ATOMICS_TESTS) && defined(__TARGET_ARCH_arm64)
		RUN(verifier_store_release);
	#else
		test__skip()
	#endif
	}

The number of tests skipped is printed after tests execution.
Up to you if you'd like to change it like that or not.


