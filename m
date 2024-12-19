Return-Path: <bpf+bounces-47292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994A9F71C4
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 02:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8663F1888152
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B970806;
	Thu, 19 Dec 2024 01:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rff/IFqt"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1511E4BE
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571747; cv=none; b=BUO/TTU2TNb7NbvqYM9mqIumQ/fWqoPeQgcBQWO+ZYIP8aquShDmGdTlcGltiovSHvXhU+Yv8/qoxgQHjJL6CrkAbOCJl76OKNpWIygitb9rj5B7WxSdnp79t9FeZFreoMWUnPhBArfpFZ2UI7cQfgnBuiJgniWrJjwpda9/AyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571747; c=relaxed/simple;
	bh=ERB/InqNrOwq09Op/Lx2uBq1k/yU0va4/fl+tLa/WCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGZDYlAvOk653rSVNpLFG4A0pXbMbn2vQabHkMJ8W2fEDTBOY9wn5/mo0QGprLA7u+NxcZF7UpLuP3iwotDY/gxkL0n1sJ4CD2KMXugQOXdkoHlglOtx2+hZ28g8YOla7xKeC5zTHelDERJVfDjXW9Yy0vT8vk4mLMk/z7GPo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rff/IFqt; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2397f348-9d7f-4ea4-bf95-ed1452fa2156@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734571740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERB/InqNrOwq09Op/Lx2uBq1k/yU0va4/fl+tLa/WCI=;
	b=rff/IFqtZnRgpx/XATu9tsuV9CDaJ39WIn+PvEMsGkOjlmqbz9qmVxBlJ4lwe2IlIudjaF
	E8mpLFtGYwaNnkksnuaF9mo45eB0ZZyvvxUXQLX5qeu7NOgv5gfRhqoeGUES7hkeO7A8Sa
	3/NdUznyhtCGktMzouIbuj3Fsl/iSDo=
Date: Wed, 18 Dec 2024 17:28:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Fix compilation error in
 get_uprobe_offset()
Content-Language: en-GB
To: Jerome Marchand <jmarchan@redhat.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241218175724.578884-1-jmarchan@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241218175724.578884-1-jmarchan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 12/18/24 9:57 AM, Jerome Marchand wrote:
> In get_uprobe_offset(), the call to procmap_query() use the constant
> PROCMAP_QUERY_VMA_EXECUTABLE, even if PROCMAP_QUERY is not defined.
>
> Define PROCMAP_QUERY_VMA_EXECUTABLE when PROCMAP_QUERY isn't.
>
> Fixes: 4e9e07603ecd ("selftests/bpf: make use of PROCMAP_QUERY ioctl if available")
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


