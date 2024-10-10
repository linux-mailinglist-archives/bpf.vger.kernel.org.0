Return-Path: <bpf+bounces-41513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695BA9979EE
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998071C210A9
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0217C9E;
	Thu, 10 Oct 2024 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUT9rb+G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76416BE68
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522012; cv=none; b=PIHhWkTBt97dRy4xVJvUxlBuw65CiPFmA+6XOxdibcK8VuQ1fbYrk4iaPJW6FzDrdOGXvGIf9NsOL/+GgQN3nPh02UAUC47BQEwR+lLmtFxYycyrZOwsiFlIfP3fGPJzD622nALpnTo4mh/MCTMsKMz5YWYQJaEoY/8+QWnr38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522012; c=relaxed/simple;
	bh=WAYA+L+gdxMlUHtnGUOYpqglVjVIR86RgLyK4d522QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTwOs0P+LmnV744ZRxJPM2agGYzPjLtSG+lCL3ShMVKCq4zz8Tu8H0OiQ1UonV9RQnbIjidhV9XVFiTv21JJg7pAeuot56JmYkbzLoKeUzCWIVAmT3q+uzrFFiQcvA8H/MMynHi4tTO3Xh4cnMq0AnME7kl9MvHBP2GjPwveIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUT9rb+G; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4612da0fso504478f8f.0
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728522009; x=1729126809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCoL1ugQDSTDf6JG4bNNALmoop9Ss/zCwf9cZ9ooT5U=;
        b=hUT9rb+GxERRPaE6SoTg+8o90PI+o8VmnmgDjafZAtwWQiRemFRQieoQPBt776liwn
         hjzmLiw36rkMapR3xh43aKVK38LLSkbDAAhHmvlmUFz08o7OFiMzX+i+7U/sTKNQnvRW
         pmwqo9jhkmPsykWh9m9Lu9HRBNEqQ/6o+nRJ/bLbxhQ6tVSHIZJHbqe+wVZTmZMWMxAJ
         4R1TqQLM+/kLmX4f8rHXKlTr1VyD80btIoMsk8Zry+6qVP6ceHm1ZdKpmNaCR+JyMdDW
         3KRfEA6cqXO6qjS7dmrer67BkqoDSFnULEnHKCz4c5pYSjUcRi4bZgvwviqkIFEpBmZW
         9jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728522009; x=1729126809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCoL1ugQDSTDf6JG4bNNALmoop9Ss/zCwf9cZ9ooT5U=;
        b=D2QAddciexSA9qeU0GdRaJC7dS99WO06S4k4Gl9lJwTwNNrsvpdmWSdc3skJM5BiFH
         1mRztC0yupeHw6AjwsrGXfvzmtD0VpRI/bhGwramcTbsqZjBcvc6mB3HViYt1cohaeO1
         VtvwpFLZvvS9Ur5ZFhjtcteS7EPaSBYXAXd4oCnCgV2HLwuo/zoCk2u6pYbRKEtM4Hgg
         9fVQjo5sFdRyZt9buBUXYMt6gHe6fAAlVNeKxug46TdCIhGAbXe175X08YUgKUSjKibV
         JosgjxY1M0R8Zh1o2rek4Q5p0r+xdrNa3q8cidZ8Ot4UgTW2Nk2x6TFiFd5FPkmwkIbu
         6GqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw4s/T6tifiNec8bXfmSbmYlRUz80ubyNfSLSnNoIDxkLtG9nyD+cDMsUkmsUaM3ssXWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JmbcX7+81ahW11p3d1C2Bv+XKQ+4ZJlThnNDeqD9/XoEXzGY
	eSv/6oueSKghbt9DZ7brkrYbDilT8qmV7V0dxW2OdF8i6e6s/qbznFQpo6WErpuyPAj6ADsU4Zh
	AU3kQxWGSoIGCSu/cX/8LEIiH6n2geQ==
X-Google-Smtp-Source: AGHT+IFphMrOtTlj/hrQFDIc1ZXYzn3rQIgwFJ3hBf9zuaT+wzeJLBOhQAU+3E2DZsFCxQmzxJQJZ2txLpEmeon09A0=
X-Received: by 2002:a5d:5c85:0:b0:374:adf1:9232 with SMTP id
 ffacd0b85a97d-37d4818f6e1mr961148f8f.19.1728522008706; Wed, 09 Oct 2024
 18:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008161333.33469-1-leon.hwang@linux.dev> <20241008161333.33469-4-leon.hwang@linux.dev>
 <e8ca8f6d618a446a3e7ab28f4f36ab7e1e814432.camel@gmail.com> <0b803ca1-bf7d-4ecd-8585-aac3b97b6167@linux.dev>
In-Reply-To: <0b803ca1-bf7d-4ecd-8585-aac3b97b6167@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 17:59:57 -0700
Message-ID: <CAADnVQK2SP0JeL+kRMEvLQGjq4GgBAUtUyVjjzDJ0dRSqWeDFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Add cases to test tailcall
 in freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com, 
	kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 11:05=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 9/10/24 13:04, Eduard Zingerman wrote:
> > On Wed, 2024-10-09 at 00:13 +0800, Leon Hwang wrote:
> >> cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
> >> 335/27  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_1:OK
> >> 335/28  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_2:OK
> >> 335     tailcalls:OK
> >> Summary: 1/28 PASSED, 0 SKIPPED, 0 FAILED
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >
> > Tbh, I don't think these tests are necessary.
> > Patch #2 already covers changes in patch #1.
> >
> > [...]
> >
>
> You are right.
>
> I should provide the commit message to tell the reason why to add these
> two test cases:
>
> In order to confirm tailcall in freplace is OK and won't be broken by
> patch of preventing tailcall infinite loop caused by freplace or other
> patches in the future, add two test cases to confirm that freplace is OK
> to tail call itself or other freplace prog, even if the target prog of
> freplace is a subprog and the subprog is called many times in its caller.

Not following.
What's the point of adding more tests when patch 2 covers the cases already=
?

