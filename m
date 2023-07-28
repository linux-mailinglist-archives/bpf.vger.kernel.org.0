Return-Path: <bpf+bounces-6255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C59C767408
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F91C209DF
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC3214F2;
	Fri, 28 Jul 2023 17:45:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FCD17FE5
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:45:35 +0000 (UTC)
Received: from out-89.mta0.migadu.com (out-89.mta0.migadu.com [IPv6:2001:41d0:1004:224b::59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC733C0F
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 10:45:31 -0700 (PDT)
Message-ID: <4cfb1cae-5c25-107f-3f0b-c9538d62bd14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690566329; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djOJ7aCL19RNXe8MF64c4n/fALjFZtWZ/lQcY9gY93c=;
	b=j5qOOAwcCkJHCY+tpKam4iLC6WF0wfvro1pvZmCS6NEVSkx+pvjP1XRnbwHnhZVY+26DhX
	Jy+eKeWSfPGnhF54abvyFS6yxO3U7CuVTz19X4u85lngnyrT9mtTuaHJGaO5vm1nn3AEqk
	XFGxmPjP/gAah8N55wYVQRaJmxGjshM=
Date: Fri, 28 Jul 2023 10:45:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [RFC bpf-next v6] bpf: Force to MPTCP
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
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
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <c0647d0d3c7158b96dec4604ba317df311c5012d.1690531142.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c0647d0d3c7158b96dec4604ba317df311c5012d.1690531142.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/28/23 12:59 AM, Geliang Tang wrote:
> As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:
> 
> "Your app can create sockets with IPPROTO_MPTCP as the proto:
> ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
> forced to create and use MPTCP sockets instead of TCP ones via the
> mptcpize command bundled with the mptcpd daemon."
> 
> But the mptcpize (LD_PRELOAD technique) command has some limitations
> [2]:
> 
>   - it doesn't work if the application is not using libc (e.g. GoLang
> apps)
>   - in some envs, it might not be easy to set env vars / change the way
> apps are launched, e.g. on Android
>   - mptcpize needs to be launched with all apps that want MPTCP: we could
> have more control from BPF to enable MPTCP only for some apps or all the
> ones of a netns or a cgroup, etc.
>   - it is not in BPF, we cannot talk about it at netdev conf.
> 
> So this patchset attempts to use BPF to implement functions similer to
> mptcpize.
> 
> The main idea is add a hook in sys_socket() to change the protocol id
> from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
> 
> [1]
> https://github.com/multipath-tcp/mptcp_net-next/wiki
> [2]
> https://github.com/multipath-tcp/mptcp_net-next/issues/79
> 
> v6:
>   - add update_socket_protocol.
> 
> v5:
>   - add bpf_mptcpify helper.
> 
> v4:
>   - use lsm_cgroup/socket_create
> 
> v3:
>   - patch 8: char cmd[128]; -> char cmd[256];
> 
> v2:
>   - Fix build selftests errors reported by CI
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>   net/mptcp/bpf.c                               |  17 +++
>   net/socket.c                                  |   6 +
>   .../testing/selftests/bpf/prog_tests/mptcp.c  | 126 ++++++++++++++++--
>   tools/testing/selftests/bpf/progs/mptcpify.c  |  26 ++++
>   4 files changed, 166 insertions(+), 9 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 5a0a84ad94af..c43aee31014d 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -12,6 +12,23 @@
>   #include <linux/bpf.h>
>   #include "protocol.h"
>   
> +#ifdef CONFIG_BPF_JIT
> +BTF_SET8_START(bpf_mptcp_fmodret_ids)
> +BTF_ID_FLAGS(func, update_socket_protocol)
> +BTF_SET8_END(bpf_mptcp_fmodret_ids)
> +
> +static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &bpf_mptcp_fmodret_ids,
> +};
> +
> +static int __init bpf_mptcp_kfunc_init(void)
> +{
> +	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> +}
> +late_initcall(bpf_mptcp_kfunc_init);
> +#endif /* CONFIG_BPF_JIT */
> +
>   struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>   {
>   	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> diff --git a/net/socket.c b/net/socket.c
> index 2b0e54b2405c..4c7b2ff711f0 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1644,11 +1644,17 @@ struct file *__sys_socket_file(int family, int type, int protocol)
>   	return sock_alloc_file(sock, flags, NULL);
>   }
>   
> +noinline int update_socket_protocol(int family, int type, int protocol)
> +{
> +	return protocol;
> +}

You need to add __weak attribute to the above function, otherwise,
although compiler will not inline this function, it may still poke
into this function and if the function body is simply enough, it will
"inline" it like in this case. Adding a '__weak' attribute can
prevent this.

The following is a snipet of asm code from a clang build kernel.

ffffffff8206a280 <update_socket_protocol>:
ffffffff8206a280: f3 0f 1e fa           endbr64
ffffffff8206a284: 0f 1f 44 00 00        nopl    (%rax,%rax)
ffffffff8206a289: 89 d0                 movl    %edx, %eax
ffffffff8206a28b: c3                    retq
ffffffff8206a28c: 0f 1f 40 00           nopl    (%rax)

ffffffff8206a290 <__sys_socket>:
ffffffff8206a290: f3 0f 1e fa           endbr64
ffffffff8206a294: 0f 1f 44 00 00        nopl    (%rax,%rax)
ffffffff8206a299: 55                    pushq   %rbp
ffffffff8206a29a: 41 57                 pushq   %r15
ffffffff8206a29c: 41 56                 pushq   %r14
ffffffff8206a29e: 41 54                 pushq   %r12
ffffffff8206a2a0: 53                    pushq   %rbx
ffffffff8206a2a1: 50                    pushq   %rax
ffffffff8206a2a2: f7 c6 f0 f7 f7 ff     testl   $0xfff7f7f0, %esi 
# imm = 0xFFF7F7F0
ffffffff8206a2a8: 74 0c                 je      0xffffffff8206a2b6 
<__sys_socket+0x26>
ffffffff8206a2aa: 49 c7 c6 ea ff ff ff  movq    $-0x16, %r14
ffffffff8206a2b1: e9 a5 00 00 00        jmp     0xffffffff8206a35b 
<__sys_socket+0xcb>
ffffffff8206a2b6: 89 d3                 movl    %edx, %ebx
ffffffff8206a2b8: 89 f5                 movl    %esi, %ebp
ffffffff8206a2ba: 41 89 fe              movl    %edi, %r14d
ffffffff8206a2bd: 41 89 f7              movl    %esi, %r15d
ffffffff8206a2c0: 41 83 e7 0f           andl    $0xf, %r15d
ffffffff8206a2c4: 65 4c 8b 25 74 e9 fc 7d       movq 
%gs:0x7dfce974(%rip), %r12
ffffffff8206a2cc: 49 8d bc 24 b0 07 00 00       leaq    0x7b0(%r12), %rdi
ffffffff8206a2d4: e8 a7 49 41 ff        callq   0xffffffff8147ec80 
<__asan_load8_noabort>
ffffffff8206a2d9: 4d 8b a4 24 b0 07 00 00       movq    0x7b0(%r12), %r12
ffffffff8206a2e1: 49 8d 7c 24 28        leaq    0x28(%r12), %rdi
ffffffff8206a2e6: e8 95 49 41 ff        callq   0xffffffff8147ec80 
<__asan_load8_noabort>
ffffffff8206a2eb: 49 8b 7c 24 28        movq    0x28(%r12), %rdi
ffffffff8206a2f0: 49 89 e0              movq    %rsp, %r8
ffffffff8206a2f3: 44 89 f6              movl    %r14d, %esi
ffffffff8206a2f6: 44 89 fa              movl    %r15d, %edx
ffffffff8206a2f9: 89 d9                 movl    %ebx, %ecx
ffffffff8206a2fb: 45 31 c9              xorl    %r9d, %r9d
ffffffff8206a2fe: e8 1d fa ff ff        callq   0xffffffff82069d20 
<__sock_create>

update_socket_protocol() is still there but its content
has been inlined.

Also, do you need a prototype for this global function?
See kernel/cgroup/rstat.c for an example to use
'__diag_*' to avoid a prototype.

> +
>   int __sys_socket(int family, int type, int protocol)
>   {
>   	struct socket *sock;
>   	int flags;
>   
> +	protocol = update_socket_protocol(family, type, protocol);
>   	sock = __sys_socket_create(family, type, protocol);
>   	if (IS_ERR(sock))
>   		return PTR_ERR(sock);
[...]

