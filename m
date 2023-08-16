Return-Path: <bpf+bounces-7925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246977E929
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 20:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CA81C210B7
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C117730;
	Wed, 16 Aug 2023 18:59:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC217726
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 18:59:27 +0000 (UTC)
Received: from out-49.mta1.migadu.com (out-49.mta1.migadu.com [IPv6:2001:41d0:203:375::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F5D2701
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 11:59:25 -0700 (PDT)
Message-ID: <3590084f-bc61-b2c7-ed1b-dd4caa85fdcd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692212362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCFj1wUEPbKCUAicOTDsxyUO5WEYUOvgrXDS/ukJ/vw=;
	b=pVduOOAy3dw3c4iuelYrt3xow2jG7+SQcWBUGfqv58WAu6NkLuNcB3VtXyyrEGaRv549MB
	ppQQsVgUAivt2n09prjT8L27YETLhN/YnQrzxWne4u//uOPeyx4qZiZqV/FNKIyzfzL9jj
	lkpc3ZHx2YYM6kTZCPi0DdwbLph1aLY=
Date: Wed, 16 Aug 2023 11:59:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v14 4/4] selftests/bpf: Add mptcpify test
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Florent Revest <revest@chromium.org>, Brendan Jackman
 <jackmanb@chromium.org>, Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
References: <cover.1692147782.git.geliang.tang@suse.com>
 <364e72f307e7bb38382ec7442c182d76298a9c41.1692147782.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <364e72f307e7bb38382ec7442c182d76298a9c41.1692147782.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/23 6:11 PM, Geliang Tang wrote:
> Implement a new test program mptcpify: if the family is AF_INET or
> AF_INET6, the type is SOCK_STREAM, and the protocol ID is 0 or
> IPPROTO_TCP, set it to IPPROTO_MPTCP. It will be hooked in
> update_socket_protocol().
> 
> Extend the MPTCP test base, add a selftest test_mptcpify() for the
> mptcpify case. Open and load the mptcpify test prog to mptcpify the
> TCP sockets dynamically, then use start_server() and connect_to_fd()
> to create a TCP socket, but actually what's created is an MPTCP
> socket, which can be verified through 'getsockopt(SOL_PROTOCOL)'
> and 'getsockopt(MPTCP_INFO)'.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>   .../testing/selftests/bpf/prog_tests/mptcp.c  | 116 ++++++++++++++++++
>   tools/testing/selftests/bpf/progs/mptcpify.c  |  20 +++
>   2 files changed, 136 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 3d3999067e27..68ebf9735e16 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -2,13 +2,30 @@
>   /* Copyright (c) 2020, Tessares SA. */
>   /* Copyright (c) 2022, SUSE. */
>   
> +#include <linux/mptcp.h>
bpf CI failed 
(https://github.com/kernel-patches/bpf/actions/runs/5882006207/job/15951617063):

   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/mptcp.c:5:10: fatal 
error: 'linux/mptcp.h' file not found
   #include <linux/mptcp.h>

I fixed that by copying the 'struct mptcp_info' but renamed to 'struct 
__mptcp_info' just in case any fallout in the future.

My environment also does not have SOL_MPTCP, so I do an ifndef for it also.

> +#include <netinet/in.h>
>   #include <test_progs.h>
>   #include "cgroup_helpers.h"
>   #include "network_helpers.h"
>   #include "mptcp_sock.skel.h"
> +#include "mptcpify.skel.h"
>   
>   #define NS_TEST "mptcp_ns"
>   
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +
> +#ifndef MPTCP_INFO
> +#define MPTCP_INFO		1
> +#endif
> +#ifndef MPTCP_INFO_FLAG_FALLBACK
> +#define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)

I have to add '#include <linux/const.h>' for the _BITUL() here also....

The set is applied. Please follow up if I make mistake on those fixes.


