Return-Path: <bpf+bounces-36189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A65943ACC
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 02:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE6C1F228E8
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9B42A99;
	Thu,  1 Aug 2024 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQ9v3e+K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A039FEF
	for <bpf@vger.kernel.org>; Thu,  1 Aug 2024 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471083; cv=none; b=fnH3Pw/09ubNdHS2y09JE4P/+e0ajpSBLLwZPp5KBrh9KcEGAhMtnP42etujntbtxgt62pLkBBgIA8RYrXLDP1DfLIWfpbrvPk4MHSWkyvKfQI/K2SvN+MYzEKpct1aRKQcDFULRJMyDGyRvIb0tUjW1cOJwwQk5Y2zGdGH7htM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471083; c=relaxed/simple;
	bh=JDp3oA6q51NW0osNy7KYnN5e5T2nMMzqxmko3rrIitk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqUlNSktbjrTyx2hLMc7n+CI/5VW4b9p7H7rg1HC780T01WUfpi8jinQPRPU9Iv2MIusNhaxRpnQu/DFlDcmS+2SO9z4Xb5m+P0WnMZtUOWObv73RkR/hWLFnOsYriZ2kxGUnRWO+d3sZtLnmyEtyG+0rmwKzIVqRTRHXeiWoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQ9v3e+K; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc4fccdd78so46099425ad.2
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722471080; x=1723075880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ykGtNKdNRZb1v3zByuHMxhXYlIfNfaZqSr0IlMqotc=;
        b=eQ9v3e+K73vhI6aTaXMF+zdI0BJy5N7ifa8UqgD/JIr+mznEr4BRG4pSnsqT+f1OxC
         DLwKTf/hyf0FgsYHumcz3lvyuNT7EkooQ9fxU1i65G2zHYnyrdD47+bKTfBI5sbzYjB3
         dXpHfSunGvSNLpL+VRrKUUfeRt93EUoc8OtfpgzCzB1Uhknb6f9G6d9nE1xzzaS9SgRV
         /yEwZl4Ige55QQZ6k1kllwOEy1Dk+f0quDnMwXEH3MzCu4U5HMShPhW/qwteKrts9x3r
         1rdhAo6y2uZmeldyyILrAYDm6Aio8VLKOi1zUTp0HhUvLMwo07v0o76yQ6oBRN8pnzs/
         2NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722471080; x=1723075880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ykGtNKdNRZb1v3zByuHMxhXYlIfNfaZqSr0IlMqotc=;
        b=qMsVxsT5UhfI7y9Kos6OM2/bhXoDHCTi926zR5Y5fOPS5n9OJ7NoZPFvhtjRoC32dc
         ka9HFggKGPX7RrDi4GWeve3Y1jptjBJx/C3xu/GXU1UISIdSAZCrovM4VrrIWfPv9dos
         C+N+SOCNIbCaipUZ91CNSWSD4JI9JbhP5kU/J0nskXwo6lvE8+C7jpNIdt5iVWAo3wrb
         tywc+2vgpYxLMx3GBglW2KP6HKsXaD6xqtk7/8kcBJRf8+LTB2p7LtxtdnTY9Ady/4Jp
         xFlhMYI1WLM0WlmpUu8QwY3FLvvZcG8RR229drP2n1vTNLtTeaxA8GokMzall5tXJqqn
         zrvA==
X-Forwarded-Encrypted: i=1; AJvYcCUp2yHMKFZDTMRuLs+ardWIKF+4VZphitXp8Lq7TwDYUEFAnuy4qnyDaoQZEoQGiZMRdA0dA5P7Vdl6cYycWPeC8Ebr
X-Gm-Message-State: AOJu0YxE+h3+vngAqNbXXYGRBPUwEA96NBVtHY0ygocHs8gCyZKl/w4y
	/LrcOtvc3wygpj4CCAI1SvABbYCa9+xkTkWkYBqglV3F4wGNBSEzfuHMbWKF8g==
X-Google-Smtp-Source: AGHT+IE85Cm6HucMJ70o1P3kblupqvykVuM0BjLKJChkrtOK1yLJlnX/y/vMQK+YMZq/kQJRKDUptA==
X-Received: by 2002:a17:902:f68a:b0:1fb:55da:c3d with SMTP id d9443c01a7336-1ff4cecbc43mr11074835ad.25.1722471079711;
        Wed, 31 Jul 2024 17:11:19 -0700 (PDT)
Received: from google.com (132.111.125.34.bc.googleusercontent.com. [34.125.111.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fff8sm126376395ad.53.2024.07.31.17.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 17:11:19 -0700 (PDT)
Date: Thu, 1 Aug 2024 00:11:15 +0000
From: Peilin Ye <yepeilin@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
Message-ID: <ZqrSo_-57HPff0YU@google.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
 <CAADnVQLLjPe3cnb7RSqHHVAP=4W1mbwTz1OFKq51=TR0utyaJQ@mail.gmail.com>
 <87c8159d-602b-470c-a46c-87f5fd853a23@linux.dev>
 <ZqqiQQWRnz7H93Hc@google.com>
 <7a658007-31d8-4725-bdea-e8abdde7ce50@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a658007-31d8-4725-bdea-e8abdde7ce50@linux.dev>

Hi Yonghong,

On Wed, Jul 31, 2024 at 04:17:36PM -0700, Yonghong Song wrote:
> On 7/31/24 1:44 PM, Peilin Ye wrote:
> > Thanks for confirming!  Would you mind if I fix it myself?  It may
> > affect some of the BPF code that we will be running on ARM, so we would
> > like to get it fixed sooner.  Also, I would love to gain some
> > experience in LLVM development!
> 
> Peilin, when I saw your email, I have almost done with the change.
> The below is the llvm patch:
>   https://github.com/llvm/llvm-project/pull/101428

Wow, that is really fast!  Thanks for the quick fix.

> Please help take a look. You are certainly welcome to do llvm
> related work. Just respond earlier to mention you intend to do
> a particular llvm patch and we are happy for you to contribute
> and will help when you have any questions.

Sure!  I'll look into that PR.

Thanks,
Peilin Ye


