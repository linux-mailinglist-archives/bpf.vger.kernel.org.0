Return-Path: <bpf+bounces-57093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC2AA5502
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 21:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0CB7B9A88
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EC5275842;
	Wed, 30 Apr 2025 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBQ7Ac8x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB711E9B3A
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042471; cv=none; b=DEW8fuY2Ard10YmwLeaaEJhCH4sGmdL/8HChwD2jt/hLSTg61Nx0aGLRbUWbGK0yMPWumP2QWUI5BIiysqb1qKYWEsAqSG7BYKRXteFxQVX4v283jvJkFMMNXyWmc/rFf27r8ZwVJznSlseXRgiB2EmvpwCSeP6WiSaIp68G7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042471; c=relaxed/simple;
	bh=H28VVUk/ExW/+/Ouatzan0EVFWHTi5Ai+sTv8pCUork=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtwkXdF1Z7oEA/48lAFdG919HD6MS+KR2jKqk7CXwjTqW9WxT3IIoAXDPQKQgR9SYXhf+TAsZssjuyGG4yQ02/VrqvqYbHwYMZjvNL2XtV/C1C6PeYXyTospoVg/IZ0Mw1qJ5PY4wwKfCQ85KQx4GY4ak4zLRa48lpVDQiLJUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBQ7Ac8x; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2263428c8baso12265ad.1
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746042469; x=1746647269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNr8Kg3r4UZBA56CwG4XH/Uyr5BA6B5QBJaGOwU6Llw=;
        b=FBQ7Ac8xJgM+HRnagZQT0dPif7p5XvVxmVN8ty5SPCpkPKCradoU1Ij6LObFNPSxYN
         J3tan2AV2YL3iidBuBMzFkXXwHrSHJJfVRzOz6DcLLbz+bMTkN0K6A/Ae0ZbQX+9dpDW
         j54q8EwmGZN3Et0yRvgynDVpjJSJeKBID8lWhNHHi86FA4rRfrPzJMYX4kqorLB6EoFX
         kNb7CAQqyqhfC7AxYsM+scZ/pwsJBuHFCecdOaqh0UEAvHU7lWePRL9LmbexhMOg+ATZ
         MexOWIf5p8da758ihNpIoEP3aUDmi/4UW4V89JAJQTX9M3FPaoJJZ3U6aJzhQ4q5xkad
         ciyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746042469; x=1746647269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNr8Kg3r4UZBA56CwG4XH/Uyr5BA6B5QBJaGOwU6Llw=;
        b=vA5J98AZ/XPMiIBO6zVLOUKagBKaVWpy6tXauKv8SP1kPg2xejYUL2d2SEO8S1CJjz
         RCrRIR+fY5fKhr170eWx9UbyecBFtOEmo0VJ8RZ0y9DdAsEcMt95j3nP3A0ufOpLTlCx
         P189zXLDsGiUdtA5lfXdqkLL60JMfs2DrpFahiROJzkX83EYqp/rvkEgPAqaTDkXRba2
         ep3IPeK3hYERpWAJFo5/sCLlKfw5MKUCvpWlq4XW9pqI5mnngl1WWw+ffIVJfHL0cCxQ
         m+/pLyHaD9x/imHIEnx7hoW21V0ZGoIv9DFQscAEsPyZC+gj5wr0+uIuZdR5ErCDqEFl
         SEnw==
X-Gm-Message-State: AOJu0YyElZH2HiDCsvZMjF4K+7LpdksnwZPKF+FMqNRdzNgiSByZ8z2F
	Gog68UiRWsfHnvVeDhWM4MZ7kcylXMJLhOMKzw76DSouye1UGn5M8OWKaGNNSg==
X-Gm-Gg: ASbGncvkkoVKen7SMAPhlP8i+XVI/0+VkALu6+SqeytFHD5QgZ0UOnSWsNM+mwKgB/Z
	WIjMuzq+ESMpuDd6R1ZhXlGy7KLB67Dh0zm9OKFzywqoVD6hSpvViRXBpyzpeX4ZxB3DD32j4nD
	ywpZl7vJlDvOBEd/ggTPVg/nTNvxm2t2jqxtzXQK6rpddq+1MgQtkRHjavwerUAkbgy6h/wov5V
	FgY6qt2hEm4PKnpBFRV6OAI14XcUT/hpzB4XSvWiPm2sMEXTbW3eOELiv2lXVsdEH7fdBs0ZHeU
	a+Or9lI9AiipVhwBn7NSEjimxfL+etjeT+TDgYJs+1qhwWg2d4LLb7tXCxYQhNX6K37rZTylBRf
	CHfM9Cg==
X-Google-Smtp-Source: AGHT+IH2TuyKzc1Iq5glMDPOiIwnbifKoV0qMDMryB4x+Nm2jsiVHc5eh24FTz34ZDVgFDvKOsrbMA==
X-Received: by 2002:a17:903:18e:b0:215:42a3:e844 with SMTP id d9443c01a7336-22e0401a6f0mr449465ad.17.1746042468434;
        Wed, 30 Apr 2025 12:47:48 -0700 (PDT)
Received: from google.com (202.108.125.34.bc.googleusercontent.com. [34.125.108.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102548sm126503325ad.168.2025.04.30.12.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:47:47 -0700 (PDT)
Date: Wed, 30 Apr 2025 19:47:42 +0000
From: Peilin Ye <yepeilin@google.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Andrea Parri <parri.andrea@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>
Subject: Re: [PATCH bpf-next 0/8] bpf, riscv64: Support load-acquire and
 store-release instructions
Message-ID: <aBJ-Xq8Aks4xHw3b@google.com>
References: <cover.1745970908.git.yepeilin@google.com>
 <e6805e47-befa-427f-a73f-2dba92adf059@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6805e47-befa-427f-a73f-2dba92adf059@huawei.com>

Hi Lehui,

On Wed, Apr 30, 2025 at 11:56:03AM +0800, Pu Lehui wrote:
> On 2025/4/30 8:48, Peilin Ye wrote:
> > Andrea Parri (2):
> >    bpf, riscv64: Introduce emit_load_*() and emit_store_*()
> >    bpf, riscv64: Support load-acquire and store-release instructions
> > 
> > Peilin Ye (6):
> >    bpf/verifier: Handle BPF_LOAD_ACQ instructions in insn_def_regno()
> >    bpf, riscv64: Skip redundant zext instruction after load-acquire
> >    selftests/bpf: Use CAN_USE_LOAD_ACQ_STORE_REL when appropriate
> >    selftests/bpf: Avoid passing out-of-range values to __retval()
> >    selftests/bpf: Verify zero-extension behavior in load-acquire tests
> >    selftests/bpf: Enable non-arena load-acquire/store-release selftests
> >      for riscv64
> > 
> >   arch/riscv/net/bpf_jit.h                      |  15 +
> >   arch/riscv/net/bpf_jit_comp64.c               | 334 ++++++++++++------
> >   arch/riscv/net/bpf_jit_core.c                 |   3 +-
> >   kernel/bpf/verifier.c                         |  11 +-
> >   tools/testing/selftests/bpf/progs/bpf_misc.h  |   5 +-
> >   .../bpf/progs/verifier_load_acquire.c         |  48 ++-
> >   .../selftests/bpf/progs/verifier_precision.c  |   5 +-
> >   .../bpf/progs/verifier_store_release.c        |  39 +-
> >   8 files changed, 314 insertions(+), 146 deletions(-)
> 
> Hi Peilin, good to see the implementation of load-acquire and store-release
> instructions on RV64! But I'm about to start my vacation, so I'll test it
> once I'm back.

Thanks for the reviews, and have a great vacation!

Peilin Ye


