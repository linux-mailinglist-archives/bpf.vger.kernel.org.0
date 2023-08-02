Return-Path: <bpf+bounces-6700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE976CC6A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43931C2127F
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7462C7461;
	Wed,  2 Aug 2023 12:15:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE3187A
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:15:09 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC02126
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 05:15:07 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RG9nQ4434zNm6f;
	Wed,  2 Aug 2023 20:11:38 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 20:15:04 +0800
Message-ID: <18523477-e984-3295-c9ad-33e6c7b76a70@huawei.com>
Date: Wed, 2 Aug 2023 20:15:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 bpf] selftests/bpf: fix static assert compilation issue
 for test_cls_*.c
To: Alan Maguire <alan.maguire@oracle.com>, <yhs@fb.com>, <ast@kernel.org>,
	<andrii@kernel.org>
CC: <martin.lau@linux.dev>, <song@kernel.org>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <mykolal@fb.com>, <bpf@vger.kernel.org>, Colm Harrington
	<colm.harrington@oracle.com>
References: <20230802073906.3197480-1-alan.maguire@oracle.com>
Content-Language: en-US
From: Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20230802073906.3197480-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/8/2 15:39, Alan Maguire 写道:
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
>
> ---
> Changes since v1:
>
> - simplified to restore offsetof() definition in test_cls_redirect.h,
>    and added explanatory comment (Yonghong)
> ---
>   tools/testing/selftests/bpf/progs/test_cls_redirect.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
> index 76eab0aacba0..233b089d1fba 100644
> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
> @@ -12,6 +12,15 @@
>   #include <linux/ipv6.h>
>   #include <linux/udp.h>
>   
> +/* offsetof() is used in static asserts, and the libbpf-redefined CO-RE
> + * friendly version breaks compilation for older clang versions <= 15
> + * when invoked in a static assert.  Restore original here.
> + */
> +#ifdef offsetof
> +#undef offsetof
> +#define offsetof(type, member) __builtin_offsetof(type, member)
> +#endif
> +

Oh, I just hit this too, and It's work for me.

Tested-by: Yipeng Zou <zouyipeng@huawei.com>

>   struct gre_base_hdr {
>   	uint16_t flags;
>   	uint16_t protocol;

-- 
Regards,
Yipeng Zou


