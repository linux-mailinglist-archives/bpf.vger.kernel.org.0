Return-Path: <bpf+bounces-7063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13802770CC1
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 02:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441231C215D8
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 00:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E3515BC;
	Sat,  5 Aug 2023 00:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A41381
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 00:40:23 +0000 (UTC)
Received: from out-96.mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E66D4EE0
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 17:40:20 -0700 (PDT)
Message-ID: <adb657e4-5f8a-6ecc-ac29-8168f4ca2ed9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691196018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tx4PIylCl9DQLUqlVHfva86omqX7eBYd3AzAD/mghWY=;
	b=i/vD4fWReijjUK9556DPqLzrJ8Zwky2dJOnf5Ik5fhl82vx3zINv6/O8QZAUxzOyv7I2/X
	5p32Hn9q1ImMZuTlsvr4+c6oWKvMGWdwr8EXx84ncXcpXtiVfWcgA3d3aIaJp6iXAHirpF
	vdLc7G7eykmRsJmg2HtIRUj6PPWFNHk=
Date: Fri, 4 Aug 2023 17:40:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 5/5] selftests/bpf: Add mptcpify test
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
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
References: <cover.1691125344.git.geliang.tang@suse.com>
 <1effb0a793140532be749aebbd7912798245745e.1691125344.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <1effb0a793140532be749aebbd7912798245745e.1691125344.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/3/23 10:07 PM, Geliang Tang wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 3dc0ba2e7590..e6aafb4cfa8e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -6,6 +6,7 @@
>   #include "cgroup_helpers.h"
>   #include "network_helpers.h"
>   #include "mptcp_sock.skel.h"
> +#include "mptcpify.skel.h"
>   
>   char NS_TEST[32];
>   
> @@ -185,8 +186,105 @@ static void test_base(void)
>   	close(cgroup_fd);
>   }
>   
> +static void send_byte(int fd)
> +{
> +	char b = 0x55;
> +
> +	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
> +}
> +
> +static int verify_mptcpify(void)
> +{
> +	char cmd[256];
> +	int err = 0;
> +
> +	/* Output of ss:
> +	 *
> +	 * ESTAB 0      0          127.0.0.1:44180    127.0.0.1:42225 cubic
> +	 * ... tcp-ulp-mptcp flags:Mmec ...
> +	 */
> +	snprintf(cmd, sizeof(cmd),
> +		 "ip netns exec %s ss -tOni | grep -q '%s'",
> +		 NS_TEST, "tcp-ulp-mptcp");
> +	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
> +		err++;
> +
> +	/* Output of nstat:
> +	 *
> +	 * #kernel
> +	 * MPTcpExtMPCapableSYNACKRX       1                  0.0
> +	 */
> +	snprintf(cmd, sizeof(cmd),
> +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
> +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
> +		 "NR==1 {next} {print $2}", "1");
> +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
> +		err++;

The idea is to confirm the protocol has been changed. Is it more direct to use 
getsockopt(SO_PROTOCOL) on the created fd(s)?

> +
> +	return err;
> +}
> +
> +static int run_mptcpify(int cgroup_fd)
> +{
> +	int server_fd, client_fd, err = 0;
> +	struct mptcpify *mptcpify_skel;
> +
> +	mptcpify_skel = mptcpify__open_and_load();
> +	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
> +		return -EIO;

Although the return value does not matter much, -EIO looks weird for the error 
from mptcpify__open_and_load(). May be 'return libbpf_get_error(mptcpify_skel);'

--
pw-bot: cr

> +
> +	err = mptcpify__attach(mptcpify_skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto out;
> +
> +	/* without MPTCP */
> +	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_server")) {
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
> +		err = -EIO;
> +		goto close_server;
> +	}
> +
> +	send_byte(client_fd);
> +	err = verify_mptcpify();
> +
> +	close(client_fd);
> +close_server:
> +	close(server_fd);
> +out:
> +	mptcpify__destroy(mptcpify_skel);
> +	return err;
> +}
> +


