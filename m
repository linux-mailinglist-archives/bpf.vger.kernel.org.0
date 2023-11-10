Return-Path: <bpf+bounces-14674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122BD7E76B8
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4239B1C20CF5
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E0AA51;
	Fri, 10 Nov 2023 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MeXEaCse"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85A10EE
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:40:13 +0000 (UTC)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6A547B9
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:40:13 -0800 (PST)
Message-ID: <30c577d9-ac4d-8cb9-bd59-44feaff01896@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699580411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKMt2UMEUn1a9Xhm3Qjjnik8PQkgf5RiUdRjP+TpHoM=;
	b=MeXEaCseJo3wpgspdAEggDNKckZk5Cft/JblYR3tQ9cTIUKfKtnVaOerAmAWnw5vvUQ00d
	Zm0960IjCuL/XCpXh69MWVmWERJFAiuau1pvDIA/icHNFUx067NNKsnhG+vWGKa2VTWdUH
	Lr0HQm6GDjkhhPd+QM9+nhbz+akbN90=
Date: Thu, 9 Nov 2023 17:40:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v11 05/13] bpf: make struct_ops_map support btfs
 other than btf_vmlinux.
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-6-thinker.li@gmail.com>
Content-Language: en-US
In-Reply-To: <20231106201252.1568931-6-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Once new struct_ops can be registered from modules, btf_vmlinux is not

s/not/no/ longer the only ...

> longer the only btf tht struct_ops_map would face.  st_map should remember

s/tht/that/ (?)

> what btf it should use to get type information.



