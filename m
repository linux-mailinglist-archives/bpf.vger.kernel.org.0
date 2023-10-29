Return-Path: <bpf+bounces-13580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11B7DAD3A
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 17:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0258628149F
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DF1CA79;
	Sun, 29 Oct 2023 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pky5CiI3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A502591
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 16:37:34 +0000 (UTC)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E7BA
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 09:37:32 -0700 (PDT)
Message-ID: <62c447c4-e96d-436d-a212-2cb93c7711d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698597450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtQ9kxVmNeTjxGIX7SeF0rvvEnlDfX50pY9meTNAPQ0=;
	b=pky5CiI3l/efBfqGi5zmasDFInOAo80Rc8M8Hx/PbM8qx1owKTRJJwnohWU1Dqtk97OhlG
	XNNMwV6fYSNTmGHkvm2IT1Gxz99tbiNS1iLB3sXoH+zMDpzhTjNZO/akn3D2Q29FAoUp4+
	MWAGyT0EPsJbGAxUnLlyqwkgYx3gEGY=
Date: Sun, 29 Oct 2023 09:37:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix test_maps' use of
 bpf_map_create_opts
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20231029011509.2479232-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231029011509.2479232-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/28/23 6:15 PM, Andrii Nakryiko wrote:
> Use LIBBPF_OPTS() macro to properly initialize bpf_map_create_opts in
> test_maps' tests.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


