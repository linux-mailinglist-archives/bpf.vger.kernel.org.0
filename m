Return-Path: <bpf+bounces-42845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C88A9AB9D6
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 01:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB5FB21DB8
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486191CDFD8;
	Tue, 22 Oct 2024 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pIn2BieM"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8A15CD52
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638486; cv=none; b=mHU6bHLw40mfDle6Td/VSh7ejwxBnQGA0cV3WSqpgW6VzigCID7eefpyF/eZxhX1Ad/yj7ajRq7GU8KNqzB9P+C1GtA/Pzv00p+eqRbmZ25CEL0pYCc18Qig2qY65IOovjlvfytsDlO4DNY0UxdGKIimOyPqp39Xsttnd+v9oOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638486; c=relaxed/simple;
	bh=HwEVmd+14Qg7m+P3F3I0EvoPMWq+VHCWhblbe1BwCKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTY65DXxveRPgLn7NREZVz7LFYr7PVxB/CIMlVVjDTi6iHxvy8i+mOz4zxw3qBmB4deYKCYRicy3P5MP76dTYbNSx/vQWBGqk909I8ERyPN1tXP7idrcglu2DPzVcb5Fn+8EeagKBx+ZmEAj3aoyiuhwwoF1+jq2I/WCS1NEJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pIn2BieM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 16:07:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729638480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xjrcnL/e30DbPJqsC6F/MsDuBR8H51xexJNnjASfUQ=;
	b=pIn2BieM4mNZOGCG5/W/QFYFLa0lSoVyV1FeC+poO14SoCL7n8JT4VzjkTZiBggUAj1W/2
	segB0IttUvqJqdIfuGnDaUjSW6R7J96pi3d5ger5wi9G5MMXj/f+tKa7/99RTSUOkZiJSP
	V5/Wq8sUK7P/SxGifV+FDc7Q2ogEN1Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kui-Feng Lee <thinker.li@gmail.com>, kernel-team@meta.com, linux-mm@kvack.org
Subject: Re: [PATCH v5 bpf-next 06/12] bpf: Add uptr support in the map_value
 of the task local storage.
Message-ID: <pu7v27kmibjeqmmom3xbkcgq5w3okk5bgfrponpcmioxrncq7y@3ebhucmwyxsz>
References: <20241015005008.767267-1-martin.lau@linux.dev>
 <20241015005008.767267-7-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015005008.767267-7-martin.lau@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 05:49:56PM GMT, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
[...]
> +static void unpin_uptr_kaddr(void *kaddr)
> +{
> +	if (kaddr)
> +		unpin_user_page(virt_to_page(kaddr));
> +}
> +
> +static void __bpf_obj_unpin_uptrs(struct btf_record *rec, u32 cnt, void *obj)
> +{
> +	const struct btf_field *field;
> +	void **uptr_addr;
> +	int i;
> +
> +	for (i = 0, field = rec->fields; i < cnt; i++, field++) {
> +		if (field->type != BPF_UPTR)
> +			continue;
> +
> +		uptr_addr = obj + field->offset;
> +		unpin_uptr_kaddr(*uptr_addr);
> +	}
> +}
> +
> +static void bpf_obj_unpin_uptrs(struct btf_record *rec, void *obj)
> +{
> +	if (!btf_record_has_field(rec, BPF_UPTR))
> +		return;
> +
> +	__bpf_obj_unpin_uptrs(rec, rec->cnt, obj);
> +}
> +
> +static int bpf_obj_pin_uptrs(struct btf_record *rec, void *obj)
> +{
> +	const struct btf_field *field;
> +	const struct btf_type *t;
> +	unsigned long start, end;
> +	struct page *page;
> +	void **uptr_addr;
> +	int i, err;
> +
> +	if (!btf_record_has_field(rec, BPF_UPTR))
> +		return 0;
> +
> +	for (i = 0, field = rec->fields; i < rec->cnt; i++, field++) {
> +		if (field->type != BPF_UPTR)
> +			continue;
> +
> +		uptr_addr = obj + field->offset;
> +		start = *(unsigned long *)uptr_addr;
> +		if (!start)
> +			continue;
> +
> +		t = btf_type_by_id(field->kptr.btf, field->kptr.btf_id);
> +		if (check_add_overflow(start, t->size, &end)) {
> +			err = -EFAULT;
> +			goto unpin_all;
> +		}
> +
> +		/* The uptr's struct cannot span across two pages */
> +		if ((start & PAGE_MASK) != (end & PAGE_MASK)) {
> +			err = -EOPNOTSUPP;
> +			goto unpin_all;
> +		}
> +
> +		err = pin_user_pages_fast(start, 1, FOLL_LONGTERM | FOLL_WRITE, &page);
> +		if (err != 1)
> +			goto unpin_all;
> +
> +		*uptr_addr = page_address(page) + offset_in_page(start);

Please use kmap(page) instead of page_address(page) and then you will
need to kunmap(kptr) on the unpin side.


