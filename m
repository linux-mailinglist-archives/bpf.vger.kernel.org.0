Return-Path: <bpf+bounces-4966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094BC75299E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 19:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284DB1C213FC
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645171F17C;
	Thu, 13 Jul 2023 17:14:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB71ED53
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 17:14:46 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A54110
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 10:14:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so1413992276.1
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689268483; x=1691860483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=plk/u2C8CQ5iUsudZn06eEmuE7SiUqV2VM9Hd9mFy/8=;
        b=T5Ai7viycvfd30einFH0GsY4KRQVGQ8leoV0/KTZ2Cvrey3mMzS82OW/A5igr6VkcO
         DaXsmczDQ/avZBrS5frn/OrBFLhoncA00Vi74G0S8IdEkSIDJOMejcKr/4zdAF4Ma9Ta
         lSag0qd5K8JMkJzZVi1qAuZkhWXhABkHI1IldlFrmbF2e6ekoMiSpPQKxLuZq4wx1u5y
         gI3tMngyfpImYWYNzv/C7JGK8zfukmy2GzWZRhuzP3aELuCPL1Ckz+AyaQ6UDIUbwIQd
         3vSur2XX78TG/65wLbtqiKpQ8AG4eWSN+0JS6M4G+gzcJi9nJK6C9t3q7GWcEMek7feI
         Vwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689268483; x=1691860483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plk/u2C8CQ5iUsudZn06eEmuE7SiUqV2VM9Hd9mFy/8=;
        b=NPKXz59kgAgy+g89/OGXMBa0Vic8D8wu55k6j9i3Zzuwa1fT+t7/gEb0sDZjJ6u4hz
         arPHPnuKKV+O3Kuw5dVhThnYYrTxnINhRUbz6ufGPHWHEGgwi34ESdtt1c08yXj/aOGc
         PcM2ZB1ZZWLTkT8raXSzbq2bZsgTb9kqTzEPQ1sRnbLe3HBKjYNYj0vxhZWzDRgTOtcY
         Lwc85wQXqYdhp5u/eRXXz09B63L9YpOIk7YUiUOYyC97P/+vdSmbg4NQXxUSquOxQ7BZ
         h3BaSrT3Bz4/LLXbaRoA4iDM6JpuHhJ7s960gEFIbMH0PumauTiwtZVRRHCHBXNt5ir4
         F4vQ==
X-Gm-Message-State: ABy/qLZ6MnWFWUciAhHe1BgQzQIZDho7t3z+wUjXJ8XVkVsRZNDTL6RQ
	z7jnr509J1b/CLnYSfSFTgs/VzA=
X-Google-Smtp-Source: APBJJlG7vTohIAhpXz+mGb0hrxPZ0HZ2JROLQPZa7cENqzmcFhO8C4iId50eQ//HZ8t6p3AwMivTwGU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:db45:0:b0:cb5:f417:c08e with SMTP id
 g66-20020a25db45000000b00cb5f417c08emr2962ybf.2.1689268483186; Thu, 13 Jul
 2023 10:14:43 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:14:41 -0700
In-Reply-To: <20230713054716.GA18806@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1688616142.git.geliang.tang@suse.com> <ZKbzs7foUw+eeNnn@google.com>
 <20230713054716.GA18806@localhost.localdomain>
Message-ID: <ZLAxAc1/UXcbIJBo@google.com>
Subject: Re: [RFC bpf-next 0/8] BPF 'force to MPTCP'
From: Stanislav Fomichev <sdf@google.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/13, Geliang Tang wrote:
> On Thu, Jul 06, 2023 at 10:02:43AM -0700, Stanislav Fomichev wrote:
> > On 07/06, Geliang Tang wrote:
> > > As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:
> > > 
> > > "Your app can create sockets with IPPROTO_MPTCP as the proto:
> > > ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
> > > forced to create and use MPTCP sockets instead of TCP ones via the
> > > mptcpize command bundled with the mptcpd daemon."
> > > 
> > > But the mptcpize (LD_PRELOAD technique) command has some limitations
> > > [2]:
> > > 
> > >  - it doesn't work if the application is not using libc (e.g. GoLang
> > > apps)
> > >  - in some envs, it might not be easy to set env vars / change the way
> > > apps are launched, e.g. on Android
> > >  - mptcpize needs to be launched with all apps that want MPTCP: we could
> > > have more control from BPF to enable MPTCP only for some apps or all the
> > > ones of a netns or a cgroup, etc.
> > >  - it is not in BPF, we cannot talk about it at netdev conf.
> > > 
> > > So this patchset attempts to use BPF to implement functions similer to
> > > mptcpize.
> > > 
> > > The main idea is add a hook in sys_socket() to change the protocol id
> > > from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
> > > 
> > > 1. This first solution [3] is using "cgroup/sock_create":
> > > 
> > > Implement a new helper bpf_mptcpify() to change the protocol id:
> > > 
> > > +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
> > > +{
> > > +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
> > > +		sk->sk_protocol = IPPROTO_MPTCP;
> > > +		return (unsigned long)sk;
> > > +	}
> > > +
> > > +	return (unsigned long)NULL;
> > > +}
> > > +
> > > +const struct bpf_func_proto bpf_mptcpify_proto = {
> > > +	.func		= bpf_mptcpify,
> > > +	.gpl_only	= false,
> > > +	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
> > > +	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> > > +	.arg1_type	= ARG_PTR_TO_CTX,
> > > +};
> > > 
> > > Add a hook in "cgroup/sock_create" section, invoking bpf_mptcpify()
> > > helper in this hook:
> > > 
> > > +SEC("cgroup/sock_create")
> > > +int sock(struct bpf_sock *ctx)
> > > +{
> > > +	struct sock *sk;
> > > +
> > > +	if (ctx->type != SOCK_STREAM)
> > > +		return 1;
> > > +
> > > +	sk = bpf_mptcpify(ctx);
> > > +	if (!sk)
> > > +		return 1;
> > > +
> > > +	protocol = sk->sk_protocol;
> > > +	return 1;
> > > +}
> > > 
> > > But this solution doesn't work, because the sock_create section is
> > > hooked at the end of inet_create(). It's too late to change the protocol
> > > id.
> > > 
> > > 2. The second solution [4] is using "fentry":
> > > 
> > > Implement a bpf_mptcpify() helper:
> > > 
> > > +BPF_CALL_1(bpf_mptcpify, struct socket_args *, args)
> > > +{
> > > +	if (args->family == AF_INET &&
> > > +	    args->type == SOCK_STREAM &&
> > > +	    (!args->protocol || args->protocol == IPPROTO_TCP))
> > > +		args->protocol = IPPROTO_MPTCP;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +BTF_ID_LIST(bpf_mptcpify_btf_ids)
> > > +BTF_ID(struct, socket_args)
> > > +
> > > +static const struct bpf_func_proto bpf_mptcpify_proto = {
> > > +	.func		= bpf_mptcpify,
> > > +	.gpl_only	= false,
> > > +	.ret_type	= RET_INTEGER,
> > > +	.arg1_type	= ARG_PTR_TO_BTF_ID,
> > > +	.arg1_btf_id	= &bpf_mptcpify_btf_ids[0],
> > > +};
> > > 
> > > Add a new wrapper socket_create() in sys_socket() path, passing a
> > > pointer of struct socket_args (int family; int type; int protocol) to
> > > the wrapper.
> > > 
> > > +int socket_create(struct socket_args *args, struct socket **res)
> > > +{
> > > +	return sock_create(args->family, args->type, args->protocol, res);
> > > +}
> > > +EXPORT_SYMBOL(socket_create);
> > > +
> > >  /**
> > >   *	sock_create_kern - creates a socket (kernel space)
> > >   *	@net: net namespace
> > > @@ -1608,6 +1614,7 @@  EXPORT_SYMBOL(sock_create_kern);
> > >  
> > >  static struct socket *__sys_socket_create(int family, int type, int protocol)
> > >  {
> > > +	struct socket_args args = { 0 };
> > >  	struct socket *sock;
> > >  	int retval;
> > >  
> > > @@ -1621,7 +1628,10 @@  static struct socket *__sys_socket_create(int family, int type, int protocol)
> > >  		return ERR_PTR(-EINVAL);
> > >  	type &= SOCK_TYPE_MASK;
> > >  
> > > -	retval = sock_create(family, type, protocol, &sock);
> > > +	args.family = family;
> > > +	args.type = type;
> > > +	args.protocol = protocol;
> > > +	retval = socket_create(&args, &sock);
> > >  	if (retval < 0)
> > >  		return ERR_PTR(retval);
> > > 
> > > Add "fentry" hook to the newly added wrapper, invoking bpf_mptcpify()
> > > in the hook:
> > > 
> > > +SEC("fentry/socket_create")
> > > +int BPF_PROG(trace_socket_create, void *args,
> > > +		struct socket **res)
> > > +{
> > > +	bpf_mptcpify(args);
> > > +	return 0;
> > > +}
> > > 
> > > This version works. But it's just a work around version. Since the code
> > > to add a wrapper to sys_socket() is not very elegant indeed, and it
> > > shouldn't be accepted by upstream.
> > > 
> > > 3. The last solution is this patchset itself:
> > > 
> > > Introduce new program type BPF_PROG_TYPE_CGROUP_SOCKINIT and attach type
> > > BPF_CGROUP_SOCKINIT on cgroup basis.
> > > 
> > > Define BPF_CGROUP_RUN_PROG_SOCKINIT() helper, and implement
> > > __cgroup_bpf_run_sockinit() helper to run a sockinit program:
> > > 
> > > +#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol)		       \
> > > +({									       \
> > > +	int __ret = 0;							       \
> > > +	if (cgroup_bpf_enabled(CGROUP_SOCKINIT))			       \
> > > +		__ret = __cgroup_bpf_run_sockinit(family, type, protocol,      \
> > > +						  CGROUP_SOCKINIT);	       \
> > > +	__ret;								       \
> > > +})
> > > +
> > > 
> > > Invoke BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create() to change
> > > the arguments:
> > > 
> > > @@ -1469,6 +1469,12 @@  int __sock_create(struct net *net, int family, int type, int protocol,
> > >  	struct socket *sock;
> > >  	const struct net_proto_family *pf;
> > >  
> > > +	if (!kern) {
> > > +		err = BPF_CGROUP_RUN_PROG_SOCKINIT(&family, &type, &protocol);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > >  	/*
> > >  	 *      Check protocol is in range
> > >  	 */
> > > 
> > > Define BPF program in this newly added 'sockinit' SEC, so it will be
> > > hooked in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().
> > > 
> > > @@ -158,6 +158,11 @@  static struct sec_name_test tests[] = {
> > >  		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
> > >  		{0, BPF_CGROUP_SETSOCKOPT},
> > >  	},
> > > +	{
> > > +		"cgroup/sockinit",
> > > +		{0, BPF_PROG_TYPE_CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT},
> > > +		{0, BPF_CGROUP_SOCKINIT},
> > > +	},
> > >  };
> > > 
> > > +SEC("cgroup/sockinit")
> > > +int mptcpify(struct bpf_sockinit_ctx *ctx)
> > > +{
> > > +	if ((ctx->family == AF_INET || ctx->family == AF_INET6) &&
> > > +	    ctx->type == SOCK_STREAM &&
> > > +	    (!ctx->protocol || ctx->protocol == IPPROTO_TCP)) {
> > > +		ctx->protocol = IPPROTO_MPTCP;
> > > +	}
> > > +
> > > +	return 1;
> > > +}
> > > 
> > > This version is the best solution we have found so far.
> > > 
> > > [1]
> > > https://github.com/multipath-tcp/mptcp_net-next/wiki
> > > [2]
> > > https://github.com/multipath-tcp/mptcp_net-next/issues/79
> > > [3]
> > > https://patchwork.kernel.org/project/mptcp/cover/cover.1688215769.git.geliang.tang@suse.com/
> > > [4]
> > > https://patchwork.kernel.org/project/mptcp/cover/cover.1688366249.git.geliang.tang@suse.com/
> > 
> > cgroup/sock_create being weird and triggering late and only for af_inet4/6
> > was the reason we added ability to attach to lsm hooks on a per-cgroup
> > basis:
> > https://lore.kernel.org/bpf/20220628174314.1216643-1-sdf@google.com/
> > 
> > Unfortunately, using it here won't help either :-( The following
> > hook triggers early enough but doesn't allow changing the arguments (I was
> > interested only in filtering based on the arguments, not changing them):
> > 
> > LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
> > 
> > So maybe another alternative might be to change its definition to int *family,
> > int *type, int *protocol and use lsm_cgroup/socket_create to rewrite the
> 
> Thanks Stanislav, this lsm_cgroup/socket_create works. The test patch
> is attached.
> 
> > protocol? (some verifier changes might needed to make those writable)
> 
> But I got some verification errors here:
> 
>    invalid mem access 'scalar'.
> 
> I tried many times but couldn't solve it, so I simply skipped the
> verifier in the test patch (I marked TODO in front of this code).
> Could you please give me some suggestions for verification?

Right, that's the core issue here, to add support to the verifier
to let it write into scalar pointer arguments. I don't have a good suggestion,
but we've discussed it multiple times elsewhere that maybe we
should do it :-)

Can we use some new btf_type_tag("allow_write") to annotate places
where we know that it's safe to write to them? Then we can extend
the verifier to check for this condition hopefully. Maybe other BPF
folks have better suggestions here?

We should also CC LSM people to make sure it's not a no-no to
change LSM_HOOK(s) in a way to allow changing the arguments. I'm
not sure how rigid those definitions are :-(

> Thanks,
> -Geliang

> From dd3c0ee4202e01c52534e8359450b42498cd4e40 Mon Sep 17 00:00:00 2001
> Message-Id: <dd3c0ee4202e01c52534e8359450b42498cd4e40.1689226263.git.geliang.tang@suse.com>
> From: Geliang Tang <geliang.tang@suse.com>
> Date: Sun, 2 Jul 2023 16:48:59 +0800
> Subject: [RFC bpf-next v4] bpf: Force to MPTCP
> 
> selftests/bpf: Add mptcpify program
> 
> This patch implements a new test program mptcpify: if the family is
> AF_INET or AF_INET6, the type is SOCK_STREAM, and the protocol ID is
> 0 or IPPROTO_TCP, set it to IPPROTO_MPTCP.
> 
> This is defined in a newly added 'sockinit' SEC, so it will be hooked
> in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> 
> selftests/bpf: use random netns name for mptcp
> 
> Use rand() to generate a random netns name instead of using the fixed
> name "mptcp_ns" for every test.
> 
> By doing that, we can re-launch the test even if there was an issue
> removing the previous netns or if by accident, a netns with this generic
> name already existed on the system.
> 
> Note that using a different name each will also help adding more
> subtests in future commits.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> selftests/bpf: add two mptcp netns helpers
> 
> Add two netns helpers for mptcp tests: create_netns() and
> cleanup_netns(). Use them in test_base().
> 
> These new helpers will be re-used in the following commits introducing
> new tests.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> selftests/bpf: Add mptcpify selftest
> 
> This patch extends the MPTCP test base, add a selftest test_mptcpify()
> for the mptcpify case.
> 
> Open and load the mptcpify test prog to mptcpify the TCP sockets
> dynamically, then use start_server() and connect_to_fd() to create a
> TCP socket, but actually what's created is an MPTCP socket, which can
> be verified through the outputs of 'ss' and 'nstat' commands.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/linux/lsm_hook_defs.h                 |   2 +-
>  include/linux/security.h                      |   4 +-
>  kernel/bpf/verifier.c                         |   5 +
>  net/socket.c                                  |   4 +-
>  security/apparmor/lsm.c                       |   6 +-
>  security/security.c                           |   2 +-
>  security/selinux/hooks.c                      |   4 +-
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 128 ++++++++++++++++--
>  tools/testing/selftests/bpf/progs/mptcpify.c  |  41 ++++++
>  9 files changed, 176 insertions(+), 20 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 7308a1a7599b..c2c178dfb06d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -288,7 +288,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
>  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
>  	 struct sock *newsk)
>  LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
> -LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
> +LSM_HOOK(int, 0, socket_create, int family, int type, int *protocol, int kern)
>  LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
>  	 int protocol, int kern)
>  LSM_HOOK(int, 0, socket_socketpair, struct socket *socka, struct socket *sockb)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 32828502f09e..67fd5bb91b72 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1416,7 +1416,7 @@ static inline int security_watch_key(struct key *key)
>  
>  int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
>  int security_unix_may_send(struct socket *sock,  struct socket *other);
> -int security_socket_create(int family, int type, int protocol, int kern);
> +int security_socket_create(int family, int type, int *protocol, int kern);
>  int security_socket_post_create(struct socket *sock, int family,
>  				int type, int protocol, int kern);
>  int security_socket_socketpair(struct socket *socka, struct socket *sockb);
> @@ -1482,7 +1482,7 @@ static inline int security_unix_may_send(struct socket *sock,
>  }
>  
>  static inline int security_socket_create(int family, int type,
> -					 int protocol, int kern)
> +					 int *protocol, int kern)
>  {
>  	return 0;
>  }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 81a93eeac7a0..d6503ac62f6d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6471,6 +6471,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  
>  		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
>  			mark_reg_unknown(env, regs, value_regno);
> +	} else if (base_type(reg->type) == SCALAR_VALUE) {
> +		/* TODO
> +		 * skip it to let mptcpify test run */
> +		pr_info("%s R%d invalid mem access '%s'\n",
> +			__func__, regno, reg_type_str(env, reg->type));
>  	} else {
>  		verbose(env, "R%d invalid mem access '%s'\n", regno,
>  			reg_type_str(env, reg->type));
> diff --git a/net/socket.c b/net/socket.c
> index 2b0e54b2405c..cb1df106de4a 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1328,7 +1328,7 @@ int sock_create_lite(int family, int type, int protocol, struct socket **res)
>  	int err;
>  	struct socket *sock = NULL;
>  
> -	err = security_socket_create(family, type, protocol, 1);
> +	err = security_socket_create(family, type, &protocol, 1);
>  	if (err)
>  		goto out;
>  
> @@ -1488,7 +1488,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
>  		family = PF_PACKET;
>  	}
>  
> -	err = security_socket_create(family, type, protocol, kern);
> +	err = security_socket_create(family, type, &protocol, kern);
>  	if (err)
>  		return err;
>  
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index f431251ffb91..ba1ba86771bc 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -868,7 +868,7 @@ static void apparmor_sk_clone_security(const struct sock *sk,
>  /**
>   * apparmor_socket_create - check perms before creating a new socket
>   */
> -static int apparmor_socket_create(int family, int type, int protocol, int kern)
> +static int apparmor_socket_create(int family, int type, int *protocol, int kern)
>  {
>  	struct aa_label *label;
>  	int error = 0;
> @@ -878,9 +878,9 @@ static int apparmor_socket_create(int family, int type, int protocol, int kern)
>  	label = begin_current_label_crit_section();
>  	if (!(kern || unconfined(label)))
>  		error = af_select(family,
> -				  create_perm(label, family, type, protocol),
> +				  create_perm(label, family, type, *protocol),
>  				  aa_af_perm(label, OP_CREATE, AA_MAY_CREATE,
> -					     family, type, protocol));
> +					     family, type, *protocol));
>  	end_current_label_crit_section(label);
>  
>  	return error;
> diff --git a/security/security.c b/security/security.c
> index b720424ca37d..4a8ef5d0304a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4078,7 +4078,7 @@ EXPORT_SYMBOL(security_unix_may_send);
>   *
>   * Return: Returns 0 if permission is granted.
>   */
> -int security_socket_create(int family, int type, int protocol, int kern)
> +int security_socket_create(int family, int type, int *protocol, int kern)
>  {
>  	return call_int_hook(socket_create, 0, family, type, protocol, kern);
>  }
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..4a1d65210faa 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4513,7 +4513,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
>  }
>  
>  static int selinux_socket_create(int family, int type,
> -				 int protocol, int kern)
> +				 int *protocol, int kern)
>  {
>  	const struct task_security_struct *tsec = selinux_cred(current_cred());
>  	u32 newsid;
> @@ -4523,7 +4523,7 @@ static int selinux_socket_create(int family, int type,
>  	if (kern)
>  		return 0;
>  
> -	secclass = socket_type_to_security_class(family, type, protocol);
> +	secclass = socket_type_to_security_class(family, type, *protocol);
>  	rc = socket_sockcreate_sid(tsec, secclass, &newsid);
>  	if (rc)
>  		return rc;
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index cd0c42fff7c0..93767e441e17 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -6,8 +6,9 @@
>  #include "cgroup_helpers.h"
>  #include "network_helpers.h"
>  #include "mptcp_sock.skel.h"
> +#include "mptcpify.skel.h"
>  
> -#define NS_TEST "mptcp_ns"
> +char NS_TEST[32];
>  
>  #ifndef TCP_CA_NAME_MAX
>  #define TCP_CA_NAME_MAX	16
> @@ -22,6 +23,26 @@ struct mptcp_storage {
>  	char ca_name[TCP_CA_NAME_MAX];
>  };
>  
> +static struct nstoken *create_netns(void)
> +{
> +	srand(time(NULL));
> +	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
> +	SYS(fail, "ip netns add %s", NS_TEST);
> +	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
> +
> +	return open_netns(NS_TEST);
> +fail:
> +	return NULL;
> +}
> +
> +static void cleanup_netns(struct nstoken *nstoken)
> +{
> +	if (nstoken)
> +		close_netns(nstoken);
> +
> +	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
> +}
> +
>  static int verify_tsk(int map_fd, int client_fd)
>  {
>  	int err, cfd = client_fd;
> @@ -147,11 +168,8 @@ static void test_base(void)
>  	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
>  		return;
>  
> -	SYS(fail, "ip netns add %s", NS_TEST);
> -	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
> -
> -	nstoken = open_netns(NS_TEST);
> -	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +	nstoken = create_netns();
> +	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
>  		goto fail;
>  
>  	/* without MPTCP */
> @@ -174,11 +192,101 @@ static void test_base(void)
>  	close(server_fd);
>  
>  fail:
> -	if (nstoken)
> -		close_netns(nstoken);
> +	cleanup_netns(nstoken);
> +
> +	close(cgroup_fd);
> +}
> +
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
> +	snprintf(cmd, sizeof(cmd),
> +		 "ip netns exec %s ss -tOni | grep -q '%s'",
> +		 NS_TEST, "tcp-ulp-mptcp");
> +	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
> +		err++;
> +
> +	snprintf(cmd, sizeof(cmd),
> +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
> +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
> +		 "NR==1 {next} {print $2}", "1");
> +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
> +		err++;
> +
> +	return err;
> +}
> +
> +static int run_mptcpify(int cgroup_fd)
> +{
> +	int server_fd, client_fd, prog_fd, err = 0;
> +	struct mptcpify *mptcpify_skel;
> +
> +	mptcpify_skel = mptcpify__open_and_load();
> +	if (!ASSERT_OK_PTR(mptcpify_skel, "mptcpify__open_and_load"))
> +		return -EIO;
> +
> +	prog_fd = bpf_program__fd(mptcpify_skel->progs.mptcpify);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
> +		err = -EIO;
> +		goto out;
> +	}
>  
> -	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
> +	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
> +	if (!ASSERT_OK(err, "attach alloc_prog_fd")) {
> +		err = -EIO;
> +		goto out;
> +	}
>  
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
> +	err += verify_mptcpify();
> +
> +	close(client_fd);
> +close_server:
> +	close(server_fd);
> +out:
> +	mptcpify__destroy(mptcpify_skel);
> +	return err;
> +}
> +
> +static void test_mptcpify(void)
> +{
> +	struct nstoken *nstoken = NULL;
> +	int cgroup_fd;
> +
> +	cgroup_fd = test__join_cgroup("/mptcpify");
> +	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
> +		return;
> +
> +	nstoken = create_netns();
> +	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
> +		goto fail;
> +
> +	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
> +
> +fail:
> +	cleanup_netns(nstoken);
>  	close(cgroup_fd);
>  }
>  
> @@ -186,4 +294,6 @@ void test_mptcp(void)
>  {
>  	if (test__start_subtest("base"))
>  		test_base();
> +	if (test__start_subtest("mptcpify"))
> +		test_mptcpify();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
> new file mode 100644
> index 000000000000..94aef62016fa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcpify.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023, SUSE. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_tcp_helpers.h"
> +
> +char _license[] SEC("license") = "GPL";
> +char fmt[] = "tcp=%u\n";
> +
> +#define	AF_INET		2
> +#define	AF_INET6	10
> +#define	SOCK_STREAM	1
> +#define	IPPROTO_TCP	6
> +#define	IPPROTO_MPTCP	262
> +
> +static __always_inline bool is_tcp(int family, int type, int protocol)
> +{
> +	if ((family == AF_INET || family == AF_INET6) &&
> +	    type == SOCK_STREAM &&
> +	    (!protocol || protocol == IPPROTO_TCP))
> +		return true;
> +
> +	return false;
> +}
> +
> +SEC("lsm_cgroup/socket_create")
> +int BPF_PROG(mptcpify, int family, int type, int *protocol, int kern)
> +{
> +	bool tcp;
> +
> +	if (kern)
> +		goto out;
> +
> +	tcp = is_tcp(family, type, *protocol);
> +	bpf_trace_printk(fmt, sizeof(fmt), tcp);
> +	if (tcp)
> +		*protocol = IPPROTO_MPTCP;
> +out:
> +	return 1;
> +}
> -- 
> 2.35.3
> 


