Return-Path: <bpf+bounces-12385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A127CBA5D
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 07:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BD0B2111D
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 05:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C3C2CF;
	Tue, 17 Oct 2023 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VjWwpwuU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AFC153
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:50:58 +0000 (UTC)
Received: from out-196.mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40378B0
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 22:50:56 -0700 (PDT)
Message-ID: <84d1ab6f-339f-c3f1-4dc3-69043a889b65@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697521854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdQIMczpvBNy2LwAe1oM/4fMkJsmbgfdsp6S3Tn34ro=;
	b=VjWwpwuUm8YanxpGlvGFK//Xxen2dvXhc83wRGyI4SJ9uqObnI5rfjpXB4dQoVnABHkvgn
	qt2ewfxvmxPPvBO/3MWgRuSUn9iFCFVmzYHH4pWnX6xlk3aeTUE8UPuaG0HVyc5wJ8aC1v
	DTEIv+NEULjYtg92DS1PkctynUP4KKw=
Date: Mon, 16 Oct 2023 22:50:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 11/11] selftest: bpf: Test
 BPF_SOCK_OPS_(GEN|CHECK)_SYNCOOKIE_CB.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>
References: <20231013220433.70792-1-kuniyu@amazon.com>
 <20231013220433.70792-12-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231013220433.70792-12-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> This patch adds a test for BPF_SOCK_OPS_(GEN|CHECK)_SYNCOOKIE_CB hooks.
> 
> BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook generates a hash using SipHash from
> based on 4-tuple.  The hash is split into ISN and TS.  MSS, ECN, SACK,
> and WScale are encoded into the lower 8-bits of ISN.
> 
>    ISN:
>      MSB                                   LSB
>      | 31 ... 8 | 7 6 | 5   | 4    | 3 2 1 0 |
>      | Hash_1   | MSS | ECN | SACK | WScale  |
> 
>    TS:
>      MSB                LSB
>      | 31 ... 8 | 7 ... 0 |
>      | Random   | Hash_2  |
> 
> BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB hook re-calculates the hash and validates
> the cookie.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Currently, the validator is incomplete...
> 
> If this line is changed
> 
>      skops->replylong[0] = msstab[3];
> 
> to
>      skops->replylong[0] = msstab[mssind];
> 
> , we will get the error below during make:
> 
>      GEN-SKEL [test_progs] test_tcp_syncookie.skel.h
>    ...
>    Error: failed to open BPF object file: No such file or directory

I cannot reprod. Does it have error earlier than this? GEN-SKEL is probably 
running this (make V=1 can tell):

tools/testing/selftests/bpf/tools/sbin/bpftool gen skeleton 
tools/testing/selftests/bpf/test_tcp_syncookie.bpf.linked3.o name 
test_tcp_syncookie > tools/testing/selftests/bpf/test_tcp_syncookie.skel.h

Add a "-d" to bpftool for more debug output: bpftool -d gen skeleton....


I cannot compile the patch in my environment as-is also:

In file included from progs/test_tcp_syncookie.c:6:
In file included from 
/data/users/kafai/fb-kernel/linux/tools/include/uapi/linux/tcp.h:22:
In file included from /usr/include/asm/byteorder.h:5:
In file included from /usr/include/linux/byteorder/little_endian.h:13:
/usr/include/linux/swab.h:136:8: error: unknown type name '__always_inline'
   136 | static __always_inline unsigned long __swab(const unsigned long y)

I have to add a "#include <linux/stddef.h>".


>      GEN-SKEL [test_progs-no_alu32] test_tcp_syncookie.skel.h
>    make: *** [Makefile:603: /home/ec2-user/kernel/bpf_syncookie/tools/testing/selftests/bpf/test_tcp_syncookie.skel.h] Error 254
>    make: *** Deleting file '/home/ec2-user/kernel/bpf_syncookie/tools/testing/selftests/bpf/test_tcp_syncookie.skel.h'
>    make: *** Waiting for unfinished jobs....


