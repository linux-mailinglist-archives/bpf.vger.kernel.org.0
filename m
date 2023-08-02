Return-Path: <bpf+bounces-6716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103AE76CFA5
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8E1281E0B
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF979F5;
	Wed,  2 Aug 2023 14:08:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D07488
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 14:08:28 +0000 (UTC)
Received: from out-98.mta1.migadu.com (out-98.mta1.migadu.com [IPv6:2001:41d0:203:375::62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBDD30F2
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 07:08:04 -0700 (PDT)
Message-ID: <ae5ef31e-5ab2-4f92-a0a6-6ca0628f2556@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690985278; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRngxUAYurYerunoRcKtbFQSSyZ8n66ovg2G5jee04k=;
	b=jn1JoiiwwIJKW1fBKbwVDDdxxPyBGuFVHKui0w7yUEszxYpcHN4O2+CVQbxeJyta3XdTTt
	NHUBRIm277ahFdfNTmcgHtqno7MD1PQHlTIcYtpR9n33GG099EMODwl5lhP8llBA4nV7Ix
	81dNuzECTfk4Jf0OBRIyhkBsYnv0qsg=
Date: Wed, 2 Aug 2023 07:07:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf] selftests/bpf: fix static assert compilation issue
 for test_cls_*.c
Content-Language: en-US
To: Alan Maguire <alan.maguire@oracle.com>, yhs@fb.com, ast@kernel.org,
 andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, bpf@vger.kernel.org,
 Colm Harrington <colm.harrington@oracle.com>
References: <20230802073906.3197480-1-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230802073906.3197480-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/2/23 12:39 AM, Alan Maguire wrote:
> commit bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to work with CO-RE")
> 
> ...was backported to stable trees such as 5.15. The problem is that with older
> LLVM/clang (14/15) - which is often used for older kernels - we see compilation
> failures in BPF selftests now:
> 
> In file included from progs/test_cls_redirect_subprogs.c:2:
> progs/test_cls_redirect.c:90:2: error: static assertion expression is not an integral constant expression
>          sizeof(flow_ports_t) !=
>          ^~~~~~~~~~~~~~~~~~~~~~~
> progs/test_cls_redirect.c:91:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
>                  offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>                  ^
> progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
>          (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>           ^
> tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
>                                   ^
> In file included from progs/test_cls_redirect_subprogs.c:2:
> progs/test_cls_redirect.c:95:2: error: static assertion expression is not an integral constant expression
>          sizeof(flow_ports_t) !=
>          ^~~~~~~~~~~~~~~~~~~~~~~
> progs/test_cls_redirect.c:96:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
>                  offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>                  ^
> progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
>          (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>           ^
> tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
>                                   ^
> 2 errors generated.
> make: *** [Makefile:594: tools/testing/selftests/bpf/test_cls_redirect_subprogs.bpf.o] Error 1
> 
> The problem is the new offsetof() does not play nice with static asserts.
> Given that the context is a static assert (and CO-RE relocation is not
> needed at compile time), offsetof() usage can be replaced by restoring
> the original offsetof() definition as __builtin_offsetof().
> 
> Fixes: bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to work with CO-RE")
> Reported-by: Colm Harrington <colm.harrington@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

