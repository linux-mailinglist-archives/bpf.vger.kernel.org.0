Return-Path: <bpf+bounces-37808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCCC95AA2D
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDD21C22AE6
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741D6F2EA;
	Thu, 22 Aug 2024 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AtoddckQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C5200AE
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289839; cv=none; b=HC4ZTDWpcpIfT/2F+zqOWCz859ttdHV042euctAnV8ymmsHKKeZE1VsTmkYI2XtzkVLhUCidvZXSX3Ar7XmNpnVofN3VFRXLiy0vcXK4uwKZKMbK3iP50URWNjLi7OU60FbqXkMPjDzM3lenm7Iv1A+qOpBvJtom0PqFUWPeTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289839; c=relaxed/simple;
	bh=sLTA1jiM4KpagzNucb/fOlP3L5JzZW/7DFegM7+ZkG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dza+fLnBsHBSaCZ1UHw7n1j+A7zAA9WK8nSrpSbdv7RB4Aj3Qiv1PArz52p7twPcb/Xm1MfeFs7vU0xYjiohC9noqhcLAfT1m5bohbo+n4Q/WWr88WZ1T2gga2BJ2uxixZP/I5ukNmBc9IvOUzLGsz4cECMwAdlv0IArSXAT08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AtoddckQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <937e36c2-5789-4fc3-834f-1e482ba563f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724289835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLTA1jiM4KpagzNucb/fOlP3L5JzZW/7DFegM7+ZkG8=;
	b=AtoddckQU2kKrSPHnauTIPv+s7ik9vfyvX7NmnYGEgbemuJAW7KKzsNh/4zlFzNgd2c36Z
	w7936KtcYq6MRSgSKPMLHh8ZDYtuFp0t0iUh+Jga7eKQhXO0U9XO6yWhHq9uH7d12fhvWe
	yBZDoC63H4jCyK/UwQoDaqM/Zry03kU=
Date: Wed, 21 Aug 2024 18:23:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/5] bpf: allow bpf_fastcall for
 bpf_cast_to_kern_ctx and bpf_rdonly_cast
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, jose.marchesi@oracle.com
References: <20240817015140.1039351-1-eddyz87@gmail.com>
 <20240817015140.1039351-5-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240817015140.1039351-5-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/16/24 6:51 PM, Eduard Zingerman wrote:
> do_misc_fixups() relaces bpf_cast_to_kern_ctx() and bpf_rdonly_cast()
> by a single instruction "r0 = r1". This follows bpf_fastcall contract.
> This commit allows bpf_fastcall pattern rewrite for these two
> functions in order to use them in bpf_fastcall selftests.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>

