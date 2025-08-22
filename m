Return-Path: <bpf+bounces-66264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E89B30BB3
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 04:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA162726A40
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 02:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC01A316C;
	Fri, 22 Aug 2025 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="SaB22Ocr"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746BE1A294
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828687; cv=none; b=FF09A+m9JVtENy7TGHDDNicxNbs8RannCQIi3b5dLVou9Wv40Ev1lJGZZGI36QqU7/k0YE8MtwCACHSwPsavpH10mWd6cAAqjw+1TkIDbOrWxCjTR1o+CetCcpGKignXFsbh32oaBkyDpngCx0YtF/fLV7IomN9RK0M1B2bICqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828687; c=relaxed/simple;
	bh=YnLSHjn6P5hfxlRuwWDxNWDDav9Fb7Q4eAPKWQKt4LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYThhr8v4nSGFaOhJuuGj82sn3wZp02Y9ijmkI10QVWl+SeXqmi1xIBsQVokzKmnz1rs4J4NIxkBxkQL6T8lc+dpMRbNJ4+y1wTZZQ3xrOnIsuYNLxpr9OU6RvkZM6dIsu9AuXaa8JVX6AazLQZAs0wZqhlhPkBwM80EtuImfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=SaB22Ocr; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [192.168.29.2] (unknown [49.47.194.55])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 530DB44C30;
	Fri, 22 Aug 2025 02:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755828682;
	bh=YnLSHjn6P5hfxlRuwWDxNWDDav9Fb7Q4eAPKWQKt4LM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SaB22OcrALiiR4ZW8HYsuKfuLDovZWImqXCmx/9H15RbMu6jE1Eg8OYshO8mIlgiL
	 q3aPJhuV1S3QMpIKFlSUiaODaD3zeN41LJNfahowN12+QZCo80gs3W/eN/QXK/tnI8
	 hP/OB1JNSVZTcvYP7UyO45Cv7WLc/umzTrN6JzWZH2mDoXF6W9mRHdMFrUvs7O99u1
	 ODGPiZVTcHEaJw4n4dSOtSYBpKg6bj/jpnNcmUqAgjQszt1gyrHUVfBD/yh1dKZjxx
	 37Xu6XSjfzCHWW1YbHxVF9skuVAMp70JDTN4EjMJG7v3Pf0fBKsjijztKYYO60dV4W
	 c650pQW32y1MQ==
Message-ID: <ba7552ae-8be7-4a6c-8fd2-2282afcd9b8b@nandakumar.co.in>
Date: Fri, 22 Aug 2025 07:41:14 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next] bpf: improve the general precision of
 tnum_mul
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
References: <20250822014754.1962075-1-nandakumar@nandakumar.co.in>
Content-Language: en-US
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <20250822014754.1962075-1-nandakumar@nandakumar.co.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've checked the three new test programs on an old kernel that has the 
current tnum_mul and a newly built one that has the proposed tnum_mul. 
verifier_mul/mul_precise results in a false positive with the current 
tnum_mul, while the program passes with the new build. While it is 
unfair to compare two kernel versions, logs indicated this is indeed a 
multiplication-related issue.

Honestly, with some effort, creating examples where the new tnum_mul 
causes issues with its imprecision should also be possible; but as as 
Eduard suggested, this was added "just to have selftests that can detect 
the change."

---

Nandakumar


