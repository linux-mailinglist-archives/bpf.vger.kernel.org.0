Return-Path: <bpf+bounces-52016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A177AA3CE6E
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E583A1893D3D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367E135A53;
	Thu, 20 Feb 2025 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ejkXvjZg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D723A0
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013729; cv=none; b=lbeBDHp/7vxue3aNqafyYDAEPH6mDHKBzaPpkc9e51HSMVjRPbxhASqxTp9O+O5idomHOt3XgBI0OfESkolz6xb0u1e1EJGMYARtzLC5CjTl+MMEK2B5jShzvAaZQKqGFkn6twHrnwKOlnb0d9a7jS0X9g9DkIA93OILV5mW5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013729; c=relaxed/simple;
	bh=eyw0JcW/CqNobLrXjUl4G9RFciMPmuTS7MsI0U8C2Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU9+wM1QiFs31xV1vziPI8waoTF9l90l8toVDjDxceWTu+glvuuk2PDq8LPNk6EXR7XDIGNOdbO1ssD5oE/jiFCElROIst6hKTmqBVgiS08v7iPqK8Q4393R1fTk5apXe+ilJWdeRLWKzhtNtNHVFcBTNTE81s96ugU7BZbSQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ejkXvjZg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2212222d4cdso69085ad.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 17:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740013728; x=1740618528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqlTouY13+ElHVb0g8qWT8IbN9r+Hv7TBtx53gmJZ+A=;
        b=ejkXvjZgzJokc4agSufBGJTq/KnMWOvB9oQ3huu5drwnlj2tOqmTIIg7l+N2Ob2/vx
         HyItYJmURw9rEmbR5/Tyt7cKGdezicphyH0wqHC3gei+YmAebhXAMjUmJfw9Wrkls9Ik
         +H6wRbcqZVSukWFCvPK0jVZy+nVmB8/6uP74msbQhkdtzt+uB0h2+8g2hXFzD0wRZqRD
         QvjDsPcLENFeN3ueWP+PNLljh12/yk75SIV0X66XYx3h14B287gIIw9peVzCiX19b/rV
         4iHPbbtR+58cXRRhPOJfMcUcuOaXGd2Eam6xJ1/ea2ftJr/PqoF08rPcrUQJQJXkyQxi
         i3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013728; x=1740618528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqlTouY13+ElHVb0g8qWT8IbN9r+Hv7TBtx53gmJZ+A=;
        b=YNUwlf0i8XMTzR2Wmw47m9f/uMR0OVYjaYaFEkwkQSpEooBwD6TnRzkoyCe86QFA2N
         DUWy0LMfdnq79qEh6vemXlZc4CXlBnUxZvZ0MgmfChLYN/C0ONwEGCnreeioRsOS8WSS
         IhpzuVuu7N+4jyiMrOYvX9+fb+GhkJp2SZQwAWsDEJb5r5bOJyrcStAZBPKNdroHlASy
         uDwaqee3uiHa4/qsjDJGtNVQOrF8cXyU/d5La1py93mJO5o1NvjB4PTb8FTqcFUTtraf
         94CWkO4LGfBIGCGxywlOAQxxyHpDUpkeiZZO4JHsBwpDsMArHP6lZN5G9SdNvB0u4af6
         LtkA==
X-Gm-Message-State: AOJu0YzsYib0rD1/5gQ+QdTXu0nSBl0fj48tnJtBAqFIbIP/N9x/eRoh
	uPbT08rGd0unpLEaKFTRkBkovREkuisciA1MVkLru4F2BT/mpfI1O+VMiEAYsQ==
X-Gm-Gg: ASbGnctgRtZb+tpY2D/o3ecYRcsZQ88dXjDFn6LziPzJUuBEIMRYoc+wXndyY0vAYpZ
	bSydlFxOik4SXK3kMxTkiNh4n+4If/9of6yVSsvo6oDO3/IKxs7V5w3592TFPts57lbr80UK1Xd
	93w0RWYxgi/gJx3z29i0a8jV4w+2+3mbrwUDwZsz6LktyTKpR+ChGAx44WmnLKmTsoSPQcmWBL5
	18DVKC+d4HaK6u26qLgaO2RtocF4yfpPyT280wK6NKbD5n7Z54fTsujegwsJJW+byiCSWMm5hlM
	TkruBcdoXfCCDlW+haS3ndMPFSslGe6MELQsXBrLjfFrV3UQ8w9orA==
X-Google-Smtp-Source: AGHT+IHBCZai8rbFA4Rqq1UVJMpTYpXlGgtVYKfEUQXi147oPGSC9aAN6/e5rjvXREapJcLK8L3TrQ==
X-Received: by 2002:a17:902:d4cc:b0:21a:87e8:3897 with SMTP id d9443c01a7336-2218db4ed75mr1293055ad.4.1740013727466;
        Wed, 19 Feb 2025 17:08:47 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366882sm111350425ad.95.2025.02.19.17.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:08:46 -0800 (PST)
Date: Thu, 20 Feb 2025 01:08:41 +0000
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
Message-ID: <Z7aAmYi5zaVIgRKR@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
 <6976077bc2d417169a437bc582a72defd1dec3d4.camel@gmail.com>
 <Z6ugQ1bd0opoGRYg@google.com>
 <1d2d919ae6848e2cf80b81ffe5f94fd31b8ea6ae.camel@gmail.com>
 <Z6u4O930eIbAVVMZ@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6u4O930eIbAVVMZ@google.com>

On Tue, Feb 11, 2025 at 08:51:07PM +0000, Peilin Ye wrote:
> > > > Nit: why is dummy_test() necessary?
> > > 
> > > It's just to make it clear when these tests are (effectively) skipped.

<...>

> > > Commit 147c8f4470ee ("selftests/bpf: Add unit tests for new
> > > sign-extension load insns") did similar thing in verifier_ldsx.c.
> > 
> > I see, thank you for explaining.
> > We do have a concept of skipped tests in the test-suite,
> > but it is implemented by calling test__skip() from the prog_tests/<smth>.c.
> > This would translate as something like below in prog_tests/verifier.c:
> > 
> > 	void test_verifier_store_release(void) {
> > 	#if defined(ENABLE_ATOMICS_TESTS) && defined(__TARGET_ARCH_arm64)
> > 		RUN(verifier_store_release);
> > 	#else
> > 		test__skip()
> > 	#endif
> > 	}
> 
> > The number of tests skipped is printed after tests execution.

I tried:

  void test_verifier_load_acquire(void)
  {
  #if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) && defined(__aarch64__)
          RUN(verifier_load_acquire);
  #else
          printf("%s:SKIP: Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support load-acquire\n",
                 __func__);
          test__skip();
  #endif
  }

Then realized that I can't check __clang_major__ in .../prog_tests/*
files (e.g. I was building prog_tests/verifier.c using GCC).  I think
ideally we should do something similar to prog{,_test}s/arena_atomics.c,
i.e. use a global bool in BPF source to indicate if we should skip this
test, but that seems to require non-trivial changes to
prog_tests/verifier.c?

For the purpose of this patchset, let me keep dummy_test(), like what we
have now in verifier_ldsx.c.

Thanks,
Peilin Ye


