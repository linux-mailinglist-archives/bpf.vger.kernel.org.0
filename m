Return-Path: <bpf+bounces-22743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BD7868417
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 23:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7ECD1C22D72
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B8135418;
	Mon, 26 Feb 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="na6CGz9Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8455133998
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988241; cv=none; b=ewHtEm3u2kPYCNkLUOm7uFQNZ9ZA4Lvuer88tGv/U979znF5f9No1YYFEDBWSP/t2FjdBT9U89G0gcWgPr8t8s2M6YJeedUJ4OxQa5T5dXqF+CLYbTp8ErHs+d8G9MaNw+5GdHaqnq2e9Rm0NxEsZMwNoxfJKxYxZWOXGcigMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988241; c=relaxed/simple;
	bh=H+CFdeYqck5aymV5rKRp7XciMZfT+C71Qb0bj9f/Wf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SboEHqmYJwf0RUUQUIDNwBkL06c6YFPFeThMoQz1eke3U074pkb1kpCkaY8SgqTftJ8ZlqGRyfs417PgZyWOVkVT8Nmol7sJluNJogFD+A14eHK7xFPqmZ8vC+o4k3hRjfEGYfzT8NJbbaGsDOoQ3tBJzBxTTPYVSjd1/+c1uec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=na6CGz9Y; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d8d82e5-c55a-4f6f-ba92-3d169daedc8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708988236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rkki+md6n4ydSlDMqwoQEgH2XHsjb3uqE05aGL27yGU=;
	b=na6CGz9Y4Pp/l+gk+QoUDhuiO+hFQ3fz2p4b9VvUjp49/yqWi37lo872EAVXbiu6AW/Iu2
	wfrrMRVM6EECi5rhkqRfE7oUP7Vx6ZHwZp5O9LBqP51ROVE4gQAR1wrwqYkLQje/xAZgO1
	j4O3ZbwZJwoYmNa8r1LyZRmcUGVGRIA=
Date: Mon, 26 Feb 2024 14:57:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/6] libbpf: Convert st_ops->data to shadow
 type.
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 quentin@isovalent.com
References: <20240222222624.1163754-1-thinker.li@gmail.com>
 <20240222222624.1163754-4-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240222222624.1163754-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/22/24 2:26 PM, thinker.li@gmail.com wrote:
> +/* Convert the data of a struct_ops map to shadow type.
> + *
> + * The function pointers are replaced with the pointers of bpf_program in
> + * st_ops->progs[].
> + */
> +static void struct_ops_convert_shadow(struct bpf_map *map,
> +				      const struct btf_type *t)
> +{
> +	struct btf *btf = map->obj->btf;
> +	struct bpf_struct_ops *st_ops = map->st_ops;
> +	const struct btf_member *m;
> +	const struct btf_type *mtype;
> +	char *data;
> +	int i;
> +
> +	data = st_ops->data;
> +
> +	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
> +		mtype = skip_mods_and_typedefs(btf, m->type, NULL);
> +
> +		if (btf_kind(mtype) != BTF_KIND_PTR)
> +			continue;
> +		if (!resolve_func_ptr(btf, m->type, NULL))
> +			continue;
> +
> +		*((struct bpf_program **)(data + m->offset / 8)) =
> +			st_ops->progs[i];

This is to initialize the bpf_program pointer in the st_ops->data.
Can this be done directly at the bpf_object__collect_st_ops_relos()?

> +	}
> +}
> +


