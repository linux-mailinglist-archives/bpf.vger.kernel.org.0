Return-Path: <bpf+bounces-53737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF84FA59A3F
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A872E16C578
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5D222D7A4;
	Mon, 10 Mar 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RsyyEyvq"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0621185B62
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621399; cv=none; b=VphJzNsZG69PIafSSRdYGvr/FGTjlCpuLCOPzChhOzTYBXqepnYSowgARfFoDP5hBtUaw5dGTZurtMyD7BHkwWXmHeGq7Yxyqp4qbkvPNNH0cJnDR+FTgxgxGYWUkHaDPLg14B3E9e/zw61GqsKsvtvbRP1F18+HxLd4mpTK6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621399; c=relaxed/simple;
	bh=ozkvDiye+37e3JvU4yKG+Hkm16iaOL9zB6G8mgGzq7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCeuDlN/XKKbRp9mP3eaKMVICcLOOSg4mHlRPJzInvumWeP5k0gHXaSddLjdNXFlMfeuqgtPojpPEyFzu4iSUmT/wgrq1lXvh64V9S6O8p3PpJwxvQqQH4t+aRSW+nJLKJ/1oC9TVNvPjYNcMAMN2Uf5pg9enjL5xzA3b+UIrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RsyyEyvq; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9cd7728c-c422-4d2b-a629-795ca10b18c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741621395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozkvDiye+37e3JvU4yKG+Hkm16iaOL9zB6G8mgGzq7g=;
	b=RsyyEyvqZ+CFApKrR7VaS72TFQgPoFZowg1ICGrWYeL5ZcPkgaVMd+qwIduHiMtyVzJNDd
	5Ay7HoLMRODuo/mbN9NveHAxvmHy40myH5gmuZRnoX/Y8hiI20UDaZpv92eh6U7tlBVsT+
	SbHBQ7n0qZ4Qb2l/tUNksC9Jr+UwgOU=
Date: Mon, 10 Mar 2025 08:43:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/4] bpf: BPF token support for
 BPF_BTF_GET_FD_BY_ID
Content-Language: en-GB
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, olsajiri@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
 <20250310001319.41393-2-mykyta.yatsenko5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250310001319.41393-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/9/25 5:13 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
> allow running it from user namespace. This creates a problem when
> freplace program running from user namespace needs to query target
> program BTF.
> This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and adds
> support for BPF token that can be passed in attributes to syscall.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Yonghong Song<yonghong.song@linux.dev>


