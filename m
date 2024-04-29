Return-Path: <bpf+bounces-28130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C508B5FD8
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A92832CB
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF308662A;
	Mon, 29 Apr 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xce7v5aP"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C683CBA
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410892; cv=none; b=Bem+NXFR8WduqN/G8+IF7pRFKfR0VDcwnAPqMfNYf/VlPlZ2kE52Ec/CAFABWeH9+OGWZgYPhKXEuanvoa+fzHJceuN3ogMyPHlXy/8kyftwv4vzmeJ+L5hduIYvUgltcLjZlFa3s5XVW2Yi0spvrdarL4q9xoVguQIPUrgoZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410892; c=relaxed/simple;
	bh=MAZjE9XDcoq2UoyMSHQ5O/M24trUzg61i7joGuCUb/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nog8Iu79IAfTKDotVjXZKJSCRR9olG+dZ4ghX4FuEHMcl0DRW4W0MSvASms7BmGZs1rc0Aq1wDpMDRYcF7bc0OHHz4frNaFBxEzO22BABbdLGzZ+0M5Dvkw2gx3FRWEI9juASHQTplNE0MGDSRF1oSRJy6re51GAuA72+u/LKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xce7v5aP; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e7e6d53-38a2-464a-ac6e-10d87184897c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714410889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAZjE9XDcoq2UoyMSHQ5O/M24trUzg61i7joGuCUb/U=;
	b=xce7v5aPOGLFts1xBsTlM1YOtUPfiHGRHD6r9XSA9cxB+Hrkky1FRb1QWduHc7sjNqEOgC
	NNlmqkFp3pr6T3O+4vwOZG1Bat4tGvvWyBii3rOqeEACkHAdUUbJurHh5Vz+jL3zvSAPOc
	B2VyQN2V+gM1YGhS7+RCTpVbBGtSV9s=
Date: Mon, 29 Apr 2024 10:14:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/1] bpf: Switch to krealloc_array()
Content-Language: en-GB
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20240429120005.3539116-1-andriy.shevchenko@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240429120005.3539116-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/29/24 5:00 AM, Andy Shevchenko wrote:
> Let the krealloc_array() copy the original data and
> check for a multiplication overflow.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


