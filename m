Return-Path: <bpf+bounces-58679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC7EABFE01
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C7B16BD18
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CC29CB20;
	Wed, 21 May 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjAQIjZP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAC280CE3
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860038; cv=none; b=ahD1HhV0qkVxYyjxsxcXA3MhziM+hIuDhr2OInXqgMQI2BrDTN+uL6e4g0JUZsln8dqCZtjfaPovTDkCeEa7XPy9IxWhpltSsg96ACVDkdMyA3b4ze08j/cOqTicDJ8p6mfzOXNiW61gUjbv1TfkHxg1cZKSy5/7EA6Ry/QmVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860038; c=relaxed/simple;
	bh=zbjY1wizS23vo58PabGXx/GKrU4ugGQE+QWdx9Y90HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr4KJhiqBHNLSuMR6wMeea5j6q7InUjlzjStkG38Wj6p6gxH+H+wb7TxiKwW36l8TcWgUpG8RtpOxmpVqC8Sj4Np56wG7XGdPOZ8dMs+PQy8Ns2uIWmXEN79mLsUwSoEhfhxrLF1O8rsEOT1V2GZp0l9EC7oxtTCVwqFP8Yc+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjAQIjZP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231f61dc510so1143635ad.0
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 13:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747860036; x=1748464836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8RIINbhOGI/c2NEEqIGsIubtNjwgvOZk5mJqYlzXzg=;
        b=TjAQIjZP6FCN5hWP+eyi1ayVY1f9+gOmKc9VUpQFB1MKsiVCa4YmBSbMOX5JMQ03AF
         wfp8kskeIOiDcceW6ExRJJv1kRFcjaFVeRwmg8uIZcKFddwk/X1/EZMHNUfkPUYJ+C3K
         A5nLsyjUBhhFvEDsIVrbuXXfdQs747V76LwV89j0MS1XatYC5TbtGqIPacRzFSGse2Mx
         OVeHwAnRp619ak/QZvACf6AseZPR0XhtAhz8tUKXflzvJLzoGX5yOT1QQT0nZFv+W9dA
         isWla/mge0aEsbnsAan8bsA6fgJKcbNGUIUXw3ywcfT95cH7364fZVDrhS/VDdxzJq5a
         9NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747860036; x=1748464836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8RIINbhOGI/c2NEEqIGsIubtNjwgvOZk5mJqYlzXzg=;
        b=XehxeiC62cSfsCjIq8ZhHqBCRiZZvHnWFUsw3lvbVqA+jC+yCj2LI2Fp53EwkH0yxz
         McwaNj+Q8gGHLJtFfevad1+WEdcaNsRUxX4Z8iEfJS9Bua9JfzCRWcS+R0W0hZmpGvQi
         uEeNA7n/oZ4X1WAj7UnD4BYalsN94iju2NDl0+nQtI05XH2h6pF6FaxMcrv16i9rEUvI
         Lftxf/SMpTC7QdXbIMLLIja/fyeRnuea4CzSpAH25WNq6bNnsT3r2UC8zkYspCOiqJCW
         BnwupwQKfECUDfn3cyq0ouYG/Cn0vayP+6ue9XYbF+1b36pLEaefxco4tFOe2kEQlDUy
         2doQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWdWNtuaRAq1KlgVT+g+A1Ya7fpbQIwoANOH/2V4SC/LPi/vQIqzPC8OPSK1xkxp8m7Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1ihDlX+QY1omyvpyCaSK9l/O3YH26syJ0y0lwiYZBiSpENF+
	epoEAiJwdips1X9rvlO8HikluDINwJExDqyf0/BfUTIY71O2PLNTQ1AygVIwUSeOwQ==
X-Gm-Gg: ASbGncso8G0NOaQ4zcKVvrwQRoZ+GRmYtWv3+wxmRupn5IAajFpkk+yFRZO6GetFVYU
	N7gxJCXnbup9SArSZBTp3i5jE54lkmDt3M/9OJEKfgHikSG//khdUktOZmuGh/P75mBeI663RgC
	/VTJrcSiSX3z7i8mKe9jjqaHYSMnKVnxG2UoFlckHvUVpEo7ufqZJfUpuVFALka7iDrPMk5bU38
	dpSHUx8LR04otx1L5bwcOMBh8S18UYEecCtg+1bfYM6Q89I8d8hxs03pX0BRPYdhX1YcEM3vhgX
	l69MMy02oWkOyXaEUnQ0kdSkLntuJlOOIXz0ZQYwDes73V6joMekbdKqgEaUe2uxgSWCu1Vatm8
	XcrHwuqnUIDszGNmrhI9FMnY9vYM=
X-Google-Smtp-Source: AGHT+IFWhfr8eMQeyoGAHZpfW3xBnV+hWPIDqTflQQXz1A1UZnZRmo37vQSO8OyDvOPpm/xdlB+AMQ==
X-Received: by 2002:a17:903:1b66:b0:22e:1858:fc25 with SMTP id d9443c01a7336-233d6dda119mr168815ad.9.1747860036185;
        Wed, 21 May 2025 13:40:36 -0700 (PDT)
Received: from google.com (202.108.125.34.bc.googleusercontent.com. [34.125.108.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb084cd2sm10025558a12.54.2025.05.21.13.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 13:40:35 -0700 (PDT)
Date: Wed, 21 May 2025 20:40:30 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: verifier: support BPF_LOAD_ACQ in
 insn_def_regno()
Message-ID: <aC46PuLHp6yjTBJR@google.com>
References: <20250521183911.21781-1-puranjay@kernel.org>
 <80ef5e2e-c2d9-45b7-9a48-f8c1a4767eae@gmail.com>
 <CAADnVQLgPBcRAqKfCXQwZae2jKDfp=xSFZCgzHgg-jcBTYp-yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLgPBcRAqKfCXQwZae2jKDfp=xSFZCgzHgg-jcBTYp-yw@mail.gmail.com>

On Wed, May 21, 2025 at 01:04:47PM -0700, Alexei Starovoitov wrote:
> On Wed, May 21, 2025 at 12:13 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > I'm confused, is_atomic_load_insn() is defined as:
> >
> >           return BPF_CLASS(insn->code) == BPF_STX &&
> >                  BPF_MODE(insn->code) == BPF_ATOMIC &&
> >                  insn->imm == BPF_LOAD_ACQ;
> >
> > And insn_def_regno() has the following case:
> >
> >           case BPF_STX:
> >                   if (BPF_MODE(insn->code) == BPF_ATOMIC ||
> >                       BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
> >                           if (insn->imm == BPF_CMPXCHG)
> >                                   return BPF_REG_0;
> >                           else if (insn->imm == BPF_LOAD_ACQ)
> >                                   return insn->dst_reg;
> >                           else if (insn->imm & BPF_FETCH)
> >                                   return insn->src_reg;
> >                   }
> >                   return -1;
> >
> > Why is it not triggering?
> >
> > Also, can this be tested with a BPF_F_TEST_RND_HI32 flag?
> > E.g. see verifier_scalar_ids.c:linked_regs_and_subreg_def() test case.
> 
> I suspect it was already fixed by commit
> fce7bd8e385a ("bpf/verifier: Handle BPF_LOAD_ACQ instructions in
> insn_def_regno()")

Ah, right; I did it when adding support for riscv64 (which needs_zext).
I targeted bpf-next because at that time only x86_64 and arm64 (both
!needs_zext) supported BPF_LOAD_ACQ, and didn't realize this could
affect arm32 (needs_zext).

It should've targeted bpf with a Fixes: tag instead.  Sorry for any
confusion.

Thanks,
Peilin Ye


