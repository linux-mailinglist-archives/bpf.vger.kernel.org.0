Return-Path: <bpf+bounces-65020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF5B1AB81
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 01:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299F2189F2A2
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7728D849;
	Mon,  4 Aug 2025 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IlN8GrRj"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD86253932
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754350996; cv=none; b=ddEN1xWuyGdCmi2C6+F2cMclEr6/13zlXmcZQY4Yyjst0CmtiWU76qo3hzJObrW9jAy9LU8/dF3kagqc2LZGVj/9GO7JC8yASAHS9U9hgXZz4FBarw+Dwd9sUSbdnItw8aoF1TB5i0UzT1hiH0cWwKfSZyUPGVfjOu0+S3LLIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754350996; c=relaxed/simple;
	bh=ks1G3FBtFkYfVPrEdKssH3saTR5ghSylFpjKlG0ezCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IG7grUt2NwneLwAMkJaxstxEYjLUS/LvRNG7XqKNGRd4iyZEbS+dP2xNYueKlhzlKea1rofGu30AHov12+8YpVzjV6djbNrmT6H4pd+j8Tp1obGcAUNsDwikmayDoLcQEO6rzyz7G4qMl7msac9Yg18sCySD1G4mEcyj+961FKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IlN8GrRj; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <573da832-260f-4fc5-8e8c-38f185e09249@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754350991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amkTw+dlLtcJRsefi7ar3Cl2bB/uyH0e+uZ0JR8NivU=;
	b=IlN8GrRjfVVkDOJOTLmOBsXqTCsvqr+1wukYj1xEwBBWzooJH1ZTE06tyhOkqBkC8DVAvn
	P44fYnkvoraXYQJrxbnndjI2CEEI9mU34l6ODnYeVbEUL28z8m1FFDjMoSnd/wuhakpR7V
	Hgp5S+mogwdXeC0I2Ok0/3DkalouNTE=
Date: Mon, 4 Aug 2025 16:43:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Add multi_st_ops that
 supports multiple instances
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com, bpf@vger.kernel.org
References: <20250731210950.3927649-1-ameryhung@gmail.com>
 <20250731210950.3927649-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250731210950.3927649-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/31/25 2:09 PM, Amery Hung wrote:
> +static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_testmod_multi_st_ops *st_ops =
> +		(struct bpf_testmod_multi_st_ops *)kdata;
> +	struct bpf_map *map;
> +	unsigned long flags;
> +	int err = 0;
> +
> +	map = bpf_struct_ops_get(kdata);

The bpf_struct_ops_get returns a map pointer and also inc_not_zero() the map 
which we know it won't fail at this point, so no check is needed.

> +
> +	spin_lock_irqsave(&multi_st_ops_lock, flags);
> +	if (multi_st_ops_find_nolock(map->id)) {
> +		pr_err("multi_st_ops(id:%d) has already been registered\n", map->id);
> +		err = -EEXIST;
> +		goto unlock;
> +	}
> +
> +	st_ops->id = map->id;
> +	hlist_add_head(&st_ops->node, &multi_st_ops_list);
> +unlock:
> +	bpf_struct_ops_put(kdata);

To get an id, it needs a get and an immediate put. No concern on the performance 
  but just feels not easy to use. e.g. For the subsystem supporting link_update, 
it will need to do this get/put twice. One on the old kdata and another on the 
new kdata. Take a look at the bpf_struct_ops_map_link_update().

To create a id->struct_ops mapping, the subsystem needs neither the map pointer 
nor incrementing the map refcnt. How about create a new helper to only return 
the id of the kdata?

Uncompiled code:

u32 bpf_struct_ops_id(const void *kdata)
{
	struct bpf_struct_ops_value *kvalue;
	struct bpf_struct_ops_map *st_map;

	kvalue = container_of(kdata, struct bpf_struct_ops_value, data);
	st_map = container_of(kvalue, struct bpf_struct_ops_map, kvalue);

	return st_map->map.id;
}

> +	spin_unlock_irqrestore(&multi_st_ops_lock, flags);
> +
> +	return err;
> +}
> +
> +static void multi_st_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_testmod_multi_st_ops *st_ops;
> +	struct bpf_map *map;
> +	unsigned long flags;
> +
> +	map = bpf_struct_ops_get(kdata);
> +
> +	spin_lock_irqsave(&multi_st_ops_lock, flags);
> +	st_ops = multi_st_ops_find_nolock(map->id);
> +	if (st_ops)
> +		hlist_del(&st_ops->node);
> +	spin_unlock_irqrestore(&multi_st_ops_lock, flags);
> +
> +	bpf_struct_ops_put(kdata);
> +}


