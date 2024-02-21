Return-Path: <bpf+bounces-22433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E028085E36A
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB4B285A69
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA857FBD2;
	Wed, 21 Feb 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mfya7Drt"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916D1C20
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533134; cv=none; b=BxYT+5lQaIMgFrz1deirDnUmSs9+TN1SnHQlS6IEdD8mZcW8j6JunUFRYAc80wIcc0uu19+22bR74L3nnvWvV8yqR71hjU7Ng7ddFauJB24cQnCRo26Fl5kSqoND/7nADmii41NUhXIpszl37hWpvGN9gF5LFT4k67DkouWNd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533134; c=relaxed/simple;
	bh=/hQbMToF7wqGZAgpgp1VO4EDwuBEjPOBsF3lNacAOPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTPBevEDLa4/J6H7yoKpKbYZyquns1Ursh5r8FlLPfdkjhHQEGMg9QOsKBxI90SFMBSy6tnGKY+e5CVpLxPw86plvTilbo0gMpymrPRReesuxqLjOtZj/4F6zlgRi4GRcBnEORE6UO4YZu/KPKrbxmw3wXyIiiNsAUx9pMTGf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mfya7Drt; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96df18fa-6ce6-412e-bab9-5ca8fb7b0e6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708533130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRWM2NEtbfOTOKEhH7g1vyTfB0g8Nl18yJ3b4/JRSSA=;
	b=Mfya7DrtzNPuSQBNkmbWUtvdaV1WLNxHbOyzjYZ52zWlce2sQ9X/J7nZo6J/IfUZknqHUc
	67Vx09CZmaJpViehjxejcduDcYKqqYgNFxy7+Q+tw5/3ceFJOnKgJlXxj9B/ZZbjkSFqcy
	go8p4gtMBrdQl3FBne2S6qm7kaggEL8=
Date: Wed, 21 Feb 2024 08:32:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Compiled BPF and toolchains
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
References: <87frxm2hwx.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87frxm2hwx.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/21/24 3:09 AM, Jose E. Marchesi wrote:
> The discussions we had last year in LSFMMBPF about BPF support in GCC
> were very useful, and led to more and better interactions between the
> BPF GCC maintainers, the BPF clang maintainers and the rest of the BPF
> community.  This helped a lot to achieve better convergence with clang.
>
> We think it would be good to repeat the experience this year with a
> session where we could discuss particular topics related to compiled BPF
> in general, like the toolchain requirements introduced by the new
> features being proposed for BPF (such as supporting segmented stacks,

It will be shadow stack, as suggested by Alexei, in order to
maintain the current seemless support for stack backtracing.

> just to mention a recent one) and how to better support these in both
> GCC and clang.

Another topic worth gcc involvement is potential compiler support for 
static key in bpf programs. 
https://lore.kernel.org/bpf/CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com/ 



