Return-Path: <bpf+bounces-51174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B707DA314A4
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E95188A776
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF9F262175;
	Tue, 11 Feb 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QT3kKEyh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129225A327
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301000; cv=none; b=XrGAdhFmm7n6Y4X+ES3/5fGxY4HfVNl/ZndsA8MDGV+1jonzvdJ6rYyEO2paEgMyATZvRR6e2F5ub/d2Xb15wqPFzE9veP8yGun/gOMdWjgw0ZdhFZH9QZKMlfv8RSZoLPwf6YkZtyjlxXbfbSWWN/psYyIupKhJnKEUpsEG91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301000; c=relaxed/simple;
	bh=erd1zJ+R61wo92ELNXvB28d/bNlj/qYeYQ+CjpxPXjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZHXu9W5e5ZfuTAnY6tpmZbWzk593ZPv53vJHDJ8bNqGMtQJkehcDBKK+tQsy6X8hEUCAdMxjzXk8i9Uug3x8k2YOxUeWdQK29gN3STr5oMjl4c3TaKCcEJVS3zkg5H8fxMIh81/NpHb2ohmtEhXwSge02802cmPX2jv9WNkuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QT3kKEyh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f72fac367so18655ad.0
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739300998; x=1739905798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsRY8DxU5oOqkirUpQpSEfLhJyGlqAVxdTEVQkM3WMs=;
        b=QT3kKEyhDou+T1BPQcCXL0UTuC0/xSUaFKjA7gaKXvEX9zYhY7jroy93AXMV5xcWMD
         MymXYsfePsBXd0xsDxKiMW5lvXzW4KbXvL5e3QvgRQNHFe6sd3qFN40TYcmFi2GU62J5
         aGT9X3GqHC0sVFFPFdyc36lIFvoLQ39TRjA9tP/35kYRHXpz/8FdgwI+WwplCUI9cl+q
         NZ0LkvlFOMe7uiv0j3KQRv3ScWpUq7tp4WsNhKxnceQZqc0IPqUds2zKz/X+Ef5s1rz0
         XF/64pRa+qULVUfEB5d2RGd4b+sFnxcnnL3Hd1pxX4tnDeHbgOZQInL+53J2jbVTiTGE
         U/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739300998; x=1739905798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsRY8DxU5oOqkirUpQpSEfLhJyGlqAVxdTEVQkM3WMs=;
        b=BYRAb1ypnSbH3JVHIb35ECnC2lZNJ5ysifLm50pJP6phWrrWpSoBHdLbtJIdKLblpV
         RFLvBfNylXziD6LerWmhCvlcET53dBqcdoXyzLR3o775jFDmedh4OppzzwuEIttunlJt
         nZx+gQdkyxI8FzHSKl7+5tccSM7iOHEcnOR5A7Vo1aEvL1UdMFboD+36pn8G2fwBWphF
         xWnLJoSHKf/ztaIaMNR5EvR4DRRoAp/wV6GzPEI+2WQ67zyasKTUPk5SR35WU3UXib41
         nT8Evl2D1TsOFYgqhuMdOmmZjtGz400MmSiOgT/ZKiz7GqhJYGV8ImbTQRwKRcnkP6ue
         tBsA==
X-Gm-Message-State: AOJu0Ywv+OJHq1WayXR+iGI71Fm0q+Md3ySu/auH7ZaJQVS6u3tmOs+L
	u1j3P45mKB7VjKo7lsNh3OooD2/9IS1lC6gnOzBzsFcpddpglOKZL8vfSkA1wg==
X-Gm-Gg: ASbGnctmH2V7TijMdiUuNSmxvSKg8iaFZfEEdVStlz/O9yduMnMOerzPQ57fP4KqSfe
	7ru6kGZkK23KwAhCkyEYqKL/BC9gLFTfUEMxlIcRj8yEUVP21Q8Qv6Gvz/000/YRTINrFTSzxUe
	Obq0joxjl/hXvJ4p2YDDXmEVllG11LBMRmQ/lVkL54Rgf1u8LM+wUp4rnzl/4Gjr3TDbR/C6fvI
	rEekZS7AfKIQ3blJJNr1bQ1UuyYrs8BKk2xSA4H44/QEgkoghYSv15ZHlpE51dV/+1NtO59eBQ/
	lOuR7E5ksdmQCFDbrjbgq13EVU4pn747NMoBsCeD8rRsrkx7pQR8tA==
X-Google-Smtp-Source: AGHT+IHrWBPLYi6iTGNBgCMLpCFlEfO8bMl8chkgcZ2hAPZ3SiDkxvI4vmDKroixqqmvdANTGecJ4w==
X-Received: by 2002:a17:903:13ce:b0:215:9ab0:402 with SMTP id d9443c01a7336-220bca6d869mr92705ad.18.1739300998169;
        Tue, 11 Feb 2025 11:09:58 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad548cc25d0sm5126832a12.5.2025.02.11.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:09:57 -0800 (PST)
Date: Tue, 11 Feb 2025 19:09:52 +0000
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
Message-ID: <Z6ugQ1bd0opoGRYg@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
 <6976077bc2d417169a437bc582a72defd1dec3d4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6976077bc2d417169a437bc582a72defd1dec3d4.camel@gmail.com>

On Mon, Feb 10, 2025 at 04:08:44PM -0800, Eduard Zingerman wrote:
> > +++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
> > @@ -0,0 +1,190 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "../../../include/linux/filter.h"
> > +#include "bpf_misc.h"
> > +
> > +#if defined(ENABLE_ATOMICS_TESTS) && defined(__TARGET_ARCH_arm64)
> 
> [...]
> 
> > +#else
> > +
> > +SEC("socket")
> > +__description("load-acquire is not supported by compiler or jit, use a dummy test")
> > +__success
> > +int dummy_test(void)
> > +{
> > +	return 0;
> > +}
> 
> Nit: why is dummy_test() necessary?

It's just to make it clear when these tests are (effectively) skipped.
Otherwise, e.g. -cpuv4 runner with LLVM-18 on x86-64 would give:

  #518     verifier_load_acquire:OK

With dummy_test(), we would see:

(FWIW, for v3 I'm planning to change __description() to the following,
since new tests no longer depend on __BPF_FEATURE_LOAD_ACQ_STORE_REL.)

  #518/1   verifier_load_acquire/Clang version < 18, or JIT does not support load-acquire; use a dummy test:OK
  #518     verifier_load_acquire:OK

Commit 147c8f4470ee ("selftests/bpf: Add unit tests for new
sign-extension load insns") did similar thing in verifier_ldsx.c.

> > +
> > +#endif
> > +
> > +char _license[] SEC("license") = "GPL";
> 
> [...]

Thanks,
Peilin Ye


