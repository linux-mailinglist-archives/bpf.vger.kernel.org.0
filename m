Return-Path: <bpf+bounces-64187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A08B0F83F
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA76C17A3BB
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB4C1F91C5;
	Wed, 23 Jul 2025 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dz9TIFLN"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599B1F541E
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288671; cv=none; b=VMbCC7BBTJDymESb4dNi3JLDAfG2ZrM40whVZ4NntpFzSGGcuIJtpuXVbtyL7zp26orEYQMzBzDJk+2DTeS34uUTvA9KZhmY+vbDuMkluzsTuvw9d038Pj9wym12YdpFozmQkNuktqdd0BO8/LPnxZWTjX1vCK+a2i5qkIlVCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288671; c=relaxed/simple;
	bh=Qqa7WHVPTXx3eZOksO4x9mDerLpqCGJt8uIf4LEocVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jH5Q+A5IK9/uNn+/Xm6DrIRiJlAhsE7y9wUjrJaXB4GWvEtjciYWr1H+KeD4wBkKkaFqZv9nDny9tUiY+0wlVSoNFxFurI4W+lYZFXkKYT1ymGA7E75uShiVLj3JTWH8Z9b8ad65dyHDyvPX3EdTrWQnRlgj1HyiDMHVWg8uAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dz9TIFLN; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <86524322-ebf3-41db-a1ed-9d22c67deb6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753288657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqa7WHVPTXx3eZOksO4x9mDerLpqCGJt8uIf4LEocVk=;
	b=Dz9TIFLN9NaWNFVUUg82yKzkucwVayysGvJPpd7n/fKVSZigyHfhE6mk0/2jTCFZ1gR6IP
	fUuoVLBW0VyqXEwlJ89RQG9ATZp4+jzYc4HFRPK6xlhONbX0iCJkXKte314oUchsEMaAbM
	Z2byzO9iXEbpz+SrJp55vy8TGzhgyCk=
Date: Wed, 23 Jul 2025 09:37:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Add log for attaching tracing
 programs to functions in deny list
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 laoar.shao@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
References: <20250722153434.20571-1-kafai.wan@linux.dev>
 <20250722153434.20571-3-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250722153434.20571-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/22/25 8:34 AM, KaFai Wan wrote:
> Show the rejected function name when attaching tracing programs to
> functions in deny list.
>
> With this change, we know why tracing programs can't attach to functions
> like migrate_disable() from log.
>
> $ ./fentry
> libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
> libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
> Attaching tracing programs to function 'migrate_disable' is rejected.
>
> Suggested-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


