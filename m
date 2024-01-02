Return-Path: <bpf+bounces-18775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF99B821FBC
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CFB1F227CA
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4D14F94;
	Tue,  2 Jan 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FIoL1ipV"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D715483
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08287f7c-d0aa-4ded-a26d-34023051dd14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704214586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fnv84mGYZVndCaEEWo6/f74/azSbxen3kgYnq0gdMWo=;
	b=FIoL1ipVGorVGKYIe7+a83srw2IHdHl4I7f/HMyzF4OFk0KvYjRo8NZ2T/Zca8B9+8lTMc
	np4UgPf3eLdruzUo724YpuwofN/EFTUDMiC6VV9trRmV1q434vdl6hhKmoc9dO9kGaYY57
	XSdnzS/2WeE+6KLAzzfXl1OZnVu4ul8=
Date: Tue, 2 Jan 2024 08:56:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: test_kmod.sh fails with constant blinding
Content-Language: en-GB
To: Bram Schuur <bschuur@stackstate.com>,
 "ykaliuta@redhat.com" <ykaliuta@redhat.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "johan.almbladh@anyfinetworks.com" <johan.almbladh@anyfinetworks.com>
References: <AM0PR0202MB3412F6D0F59E5EBA0CA74747C461A@AM0PR0202MB3412.eurprd02.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <AM0PR0202MB3412F6D0F59E5EBA0CA74747C461A@AM0PR0202MB3412.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/2/24 7:11 AM, Bram Schuur wrote:
> Me and my colleague Jan-Gerd Tenberge encountered this issue in production on the 5.15, 6.1 and 6.2 kernel versions. We make a small reproducible case that might help find the root cause:
>
> simple_repo.c:
>
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
>
> SEC("socket")
> int socket__http_filter(struct __sk_buff* skb) {
>    volatile __u32 r = bpf_get_prandom_u32();
>    if (r == 0) {
>      goto done;
>    }
>
>
> #pragma clang loop unroll(full)
>    for (int i = 0; i < 12000; i++) {
>      r += 1;
>    }
>
> #pragma clang loop unroll(full)
>    for (int i = 0; i < 12000; i++) {
>      r += 1;
>    }
> done:
>    return r;
> }
>
> Looking at kernel/bpf/core.c it seems that during constant blinding every instruction which has an constant operand gets 2 additional instructions. This increases the amount of instructions between the JMP and target of the JMP cause rewrite of the JMP to fail because the offset becomes bigger than S16_MAX.

This is indeed possible as verifier might increase insn account in various cases.
-mcpu=v4 is designed to solve this problem but it is only available at 6.6 and above.

>
> Hope this helps,
>
> Bram Schuur and Jan-Gerd Tenberge
>
>

