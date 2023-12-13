Return-Path: <bpf+bounces-17742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A7E81239F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43411F21663
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6E179E37;
	Wed, 13 Dec 2023 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/udpmFe"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [IPv6:2001:41d0:203:375::bd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B333C9
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:58:52 -0800 (PST)
Message-ID: <85bb2e79-5b1a-41c1-972f-9f7f185fac88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702511929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcjJcudoVFhZoBnbTd2oy3gYlnzRnT2DdGzqM7xSf0Q=;
	b=E/udpmFeOtMDg7fVKQVuCXS4tlHdXPSD5Hx+UuArcG6HyHMlzSpbu9pnMZOsJTtOzMSlxV
	+TVVQRYb9SAeQ6QcGNU3STQsgRYcPFhNSrLp6sNFEqUfZLXXYHNg+awGYa/5kdyUaiO+QN
	IWm4nGSMwEIvoEFOWb6yRyaAdDAzahQ=
Date: Wed, 13 Dec 2023 15:58:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 5/9] bpf: selftests: Add verifier tests for
 CO-RE bitfield writes
Content-Language: en-US
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: mykolal@fb.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, devel@linux-ipsec.org,
 netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org, shuah@kernel.org,
 daniel@iogearbox.net, steffen.klassert@secunet.com,
 antony.antony@secunet.com, alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev, eddyz87@gmail.com, eyal.birger@gmail.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
 <72698a1080fa565f541d5654705255984ea2a029.1702325874.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <72698a1080fa565f541d5654705255984ea2a029.1702325874.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/23 12:20 PM, Daniel Xu wrote:
> Add some tests that exercise BPF_CORE_WRITE_BITFIELD() macro. Since some
> non-trivial bit fiddling is going on, make sure various edge cases (such
> as adjacent bitfields and bitfields at the edge of structs) are
> exercised.

Hi DanielXu, I have pushed the libbpf changes (adding BPF_CORE_WRITE_BITFIELD) 
and verifier test in patch 3-5 which is useful by itself. e.g. Another patchset 
can start using it also: 
https://lore.kernel.org/bpf/8fccb066-6d17-4fa8-ba67-287042046ea4@linux.dev/

Thanks.

