Return-Path: <bpf+bounces-54507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A35A6B201
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4206C189D18F
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07843155330;
	Fri, 21 Mar 2025 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jo/gzIlR"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB84208A7
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515872; cv=none; b=EqJBJt5GwNd98huIOkp/hpfzMt0MGs1GlpCOwU/wU+PjkyC9cJM947ex3cTWO9MCLKSrZOnK9IibWiypfkZeaptzlPNcWqWON+8Hj9t7K1awifQJpqqHX6bmuCu4fk69XCBd5SacMgcrYy5IGZavEHICIYoqMyMyG4UqEUeEj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515872; c=relaxed/simple;
	bh=vOaC/VeeCvo+vykGa1NWcE6zqeTdhHIJyDqLjfcpBlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBWmAPGGuMg/QGJzMGiVC5qNNhikglSA2s+6lI/fpLCBen6L10rCZdpvI7svdpz9JqFRewlcRCUxXMjAsGuTiMvoZfIkGf1JPpJkFMrfITzFftB8Lqo+0c2zeVQq8HBHLmVz4YZY1M/VrMzueEY0khN9j2TEtrjCu/8PMsgBZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jo/gzIlR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d9c84a4-8603-4746-953c-838c674b94b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742515858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrvAznNdhcW3AAlhE/8kd+8BrxIbqCILhCTnt/Jwlis=;
	b=Jo/gzIlRX3+056pdhMVRNfPvQl1IBEOByzrKvyINWotNML30C79yxUr6x//yVb4e3qYOFA
	rvATwvvqy1ngNQRt9blcXOtKfVtaBBubAb/mhIS+plhwVFoMTpR2Eib5jqj2/OO47ZczHF
	LA/57SMY/F1nX58qpjZoGVsUtGMNXBA=
Date: Thu, 20 Mar 2025 17:10:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 01/11] bpf: Add struct_ops context information
 to struct bpf_prog_aux
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 kuba@kernel.org, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com,
 juntong.deng@outlook.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 yepeilin.cs@gmail.com, kernel-team@meta.com
References: <20250319215358.2287371-1-ameryhung@gmail.com>
 <20250319215358.2287371-2-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250319215358.2287371-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/19/25 2:53 PM, Amery Hung wrote:
> From: Juntong Deng <juntong.deng@outlook.com>
> 
> This patch adds struct_ops context information to struct bpf_prog_aux.
> 
> This context information will be used in the kfunc filter.
> 
> Currently the added context information includes struct_ops member
> offset and a pointer to struct bpf_struct_ops.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Applied patch 1 since it is useful for other struct_ops. sched_ext is waiting 
for it.

Most of the bpf specific parts have already been landed. The discussion on other 
patches can continue in this thread for now.


