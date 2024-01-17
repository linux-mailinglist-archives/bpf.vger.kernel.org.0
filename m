Return-Path: <bpf+bounces-19738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A23830B7F
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 17:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E488B2875DE
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F16224DC;
	Wed, 17 Jan 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W91UD7y/"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CD22EE0
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510362; cv=none; b=VQutZjlK6nzp+/x9Or+27oQ6yJRywa4oQRKlT1LOBumae+ijWHUVWIu19+hGSO8JV0DvHQsLnXC3u8+NLfHd3KyP6ShrRH0ZwmPu02lTLz7F33fvfJMK8RbAOpNkHs7DUiX70W2paBpCYWGCsf53fp+K4SLxOCwIDmjCbJZA0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510362; c=relaxed/simple;
	bh=+uZuQJSxNEqXrZBIQuESXpf+O5fwBxF859i6EAY8HHQ=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=mvWgFsoiu0kqsnWj5LqppiipGx+rZDiL+lo4suLDjy9mSMQv54tHO5LguMfrg0Z+jRXpOS/R8q74rwAe0GzFpiRhdIRqy2vYxSKGumNmqC6GR+0/obbGJDVCa7P8MMPW1J+elc7klErDTpJ4PhSJDdCF3TI95n83q0XbL1FQpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W91UD7y/; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6ea10f5-0643-4a82-a59a-aca1ff639fb5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705510359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+uZuQJSxNEqXrZBIQuESXpf+O5fwBxF859i6EAY8HHQ=;
	b=W91UD7y/JobJ5/lKQI9ar2WUmRHT3Ij1pQZCoTHApIWGYeEDWCVYTsR4okaxfRArtRbCGj
	N+ngIjkaXpm5VnDn36/GnO3lTjxRJAW2rAGG9E4WiGbYCnjbg5mRUMNTMjbdbce31mM5z6
	A0LV1jjWDSOMaL9utzp3aCt4oQFAsKA=
Date: Wed, 17 Jan 2024 08:52:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v5 1/2] libbpf: Apply map_set_def_max_entries() for
 inner_maps on creation
Content-Language: en-GB
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240117130619.9403-1-conquistador@yandex-team.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240117130619.9403-1-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/17/24 5:06 AM, Andrey Grafin wrote:
> This patch allows to auto create BPF_MAP_TYPE_ARRAY_OF_MAPS and
> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY
> by bpf_object__load().
>
> Previous behaviour created a zero filled btf_map_def for inner maps and
> tried to use it for a map creation but the linux kernel forbids to create
> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.
>
> Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>

If the previous patch has been ack'ed, and the current version
is the same or only has minor change compared to previous version,
you can carry previous Ack. This will save maintainer and reviewer's
time.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


