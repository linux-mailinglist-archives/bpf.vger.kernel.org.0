Return-Path: <bpf+bounces-47372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026979F8815
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 23:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A47188C427
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143691D2B2A;
	Thu, 19 Dec 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sb6wvgt1"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F21BBBCF
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648514; cv=none; b=IZpz8p5UDNN4sZQkeGSobDo+a2tpXo4GvXtDq4TgUzWGSu4XBwkkOgbLeP/BFt5McRn405tgvvABHXmd1DnWKwsl7i7ZXAbCagtrWB1E1s4f8J9ycWhpG+cy7UwXxZkW+5VRlQGx+STKvy1c1BwfvhOJOl70q75EzpGOn2vhxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648514; c=relaxed/simple;
	bh=bVLivMjyvvwnY1UYTPJNC34WHGsS7Sk7aRFNrajpuqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZDhat70e6dAq6KXTtvWfY7S5U5Y5W0+FcqoSE6yMJCWmf/dkdjDE5dQcvLAOiw69Nwo+2hwqDGXCRNsooDqUPl+66yKjVe0JDyHgBJcrjiz7ZgGeRlOXPJWRKvL8RGJ6BUSRA2reRNsUMdZv/DeBBKXlCxzI+103xUoJbuPOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sb6wvgt1; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bfa40af2-e726-477a-bab2-7abebfdd6384@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734648499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSsuDssCmx2sxK0P8EgA2+wWZ55+lycFjf0EWg5cyj4=;
	b=Sb6wvgt1trpADBnHEqCoMlIKT5o93qDL/6I1Zw4YY6xSEFqo1VlWn01LxBMaGTjRI2al6O
	82KBtrFqb5TyAwf8GnQ5QMunX286Xzhp7W61mRW3hBV7gI9F+ZXFD1C0eUBe53fsmsgbpP
	bJ1njh+UV8sqX1Jh1BnbZuWbvaF54Sw=
Date: Thu, 19 Dec 2024 14:48:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/5] net/smc: bpf: register smc_ops info
 struct_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-4-alibuda@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241218024422.23423-4-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/17/24 6:44 PM, D. Wythe wrote:
> +static int smc_bpf_ops_check_member(const struct btf_type *t,
> +				    const struct btf_member *member,
> +				    const struct bpf_prog *prog)
> +{
> +	u32 moff = __btf_member_bit_offset(t, member) / 8;
> +
> +	switch (moff) {
> +	case offsetof(struct smc_ops, name):
> +	case offsetof(struct smc_ops, flags):
> +	case offsetof(struct smc_ops, set_option):
> +	case offsetof(struct smc_ops, set_option_cond):
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

The whole smc_bpf_ops_check_member() should not be needed.

