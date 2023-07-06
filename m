Return-Path: <bpf+bounces-4165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636B749494
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5092811DE
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9DEC6;
	Thu,  6 Jul 2023 04:09:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB4EBB
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:09:00 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C1A8F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI4q5+vC6tjzh1Dj5MvAvKZUJXqKQtA4RRSI/SvPtTIQrMCLC/0GwwxuAUoYkR5RQSK8ndXirLLuOiJTQWUySbX6M+PwmC9gAE6w7wMRvrgBJOeDPfakBwqIwGig0zpJD2Bn0EvgXAHGDPZWO1lbUvwEyxCOgZkCaQtWi1iFT0PUFUQFa7WS7canibxZDmxGB9WbKy4jRGmAaZ4Ju9K/cdmqWT+e8fPPt41gj3ML6SHhKyfzcO8i/LfsEjwrgN+JGLaNV3csEWpxPKEgYsfy6+oTJn23dn/FMMxoeD+x1PtDAubUiokoXxaN7dUR2l2P71HEqDZ8o8zK7Kpu0XfX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jJw+ZQxV86/MltNhYFwB59tjtQEYiToaplKyVHv/RU=;
 b=b4+5psYV8h39R2XieFaarmCbCLaZQCWpG5cGuLZjC0BR51QFDknvOQLEvhPPGPbAQaGbarRCxjVWP4rvbydP5w0J2jpLO9akFme8CL1GaJqzw2ZO1hM8Rr8PuJAHU17LWU8oXnlzw1Zku29JAieIB2R+T3jYKCJkuXDRPqOtQtY9ZJugu1rKqHKCpJJK/JqXj/UTMVqwTZSFCuY5fiVBW7u7UfVcjg1+CVV9muzMTagpKMp40VECo9WUcxPhUtFsbXaeeC7v89gQiLib0hPJ4YjGHP94cT3KDj/1Aor0Mecf130bcVKg74zmDrnNeToSuq8UE69CvJzq3BmPvf1/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jJw+ZQxV86/MltNhYFwB59tjtQEYiToaplKyVHv/RU=;
 b=TPfVYrsYhbkdAjmN7Sf953wkRfi14Odfziy5rJbNAKClf0jXtilbkdWc30OOL6BJ+kZkHX5l4q4SueJPNixjrWB6GjRb8w3DVRcQZSGPNPpOvBaS5Mt7uat9rF5E5mdJfn8VkxekGksJcQRFhoesrgtMvGekfb4+2T/r4UoNTJK2o0MYr+5KaujfOA97pWtBQ+yET+T4IuZs64L/LFnDKhOdOS5ZSVD8NVuLYC04r+bL/MPbFTolq9p1dQW3kYR1MZDgZU6m+t8dbJzBJ8tgmXxQhS2OVpR0A0pr3ajEzp/hRtfSzdS9QFIslbxBJGHMd3Fw3T7hneOPxtboKZHKvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:08:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:08:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [RFC bpf-next 0/8] BPF 'force to MPTCP'
Date: Thu,  6 Jul 2023 12:08:44 +0800
Message-Id: <cover.1688616142.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c8baff-30ab-4725-a88c-08db7dd6b627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HMf/uZ2Khchp6q6+xPNQT+mVb2dh7X/6khxksLkqVLn6HxVeeEPE9HhHNYTOjDjVkBRKpxAK8pUgTFZNeTLQHOQAu8mR+89AO3XNTKlklCqTlr4PMi5afKWMIj7kNjDhMx/Z0XRwiRNKDCu8LtPu+TowBuNhIIZWH45o9aNUgYzgvtWLzCX6lR9WoK8NZtJObEd1H/o77alu8AIU873TOn25rlmdC4F6B4fgQCCL5rPCkbHxeaQ0ytNaUnF0cdU7z9miBj9v2U9OyviPSuxVWt2SQFU31lGbPhM/lTedlenscnuKSMBa8QT8ZsKYa2tYTv6eDwDpHP0IuPOnYAWhvLDnWTcWhg4eL3AfBcKJ0vJfd1+Bm6jI91Gm7aou591fQRxtD962DjCnuzl6eOxlWno5Ip5yv6tcZjuiS+jgug6zwKgqNvShK5NspLNGIcMnlMIzJVjmWMe5NNNT/3kAXjvyePbOnAgvhRi2YSmznu4GQelLgA49oRGUDzLPYy/UmXjTTzz31UM71TbgSR8WKNF7U+vpE3deJj68MJgAv+WCPcVL9m5Jyc5l4ZRLnBJIvSA/qUR33gqtQ8jzVLFd/n5WRM1bqJgddL20nbqZT/yxdyRoBT0I+lExynSfmmNpUVWlqNpdrp7V1d/XdkHeYtnZeZ1JASI6+AvOfLpyZk8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(38100700002)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(36756003)(6486002)(6512007)(6666004)(966005)(110136005)(6506007)(26005)(478600001)(86362001)(41300700001)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jkiH3DZvYpoiM2lwjDwDrU8k6RJkJ9n6+ubCrUjLWr7UegehzB7rzISRmba?=
 =?us-ascii?Q?8IlRCycyOqkyPZiTptlo4DX5eAwXGys6zfCNmRe4k98HLeU1MCkLavJbxa9D?=
 =?us-ascii?Q?nTtfiE/YWCWX6peLbrnlr4yUaA6sBxTh0wPoQzyGoVII6yw1KCpWfwP4i19K?=
 =?us-ascii?Q?cqwWpzn+KzsJi/Qx4J7dhLOVvtHNd9wW9xDnoRd+vtb3sV8vQj3cvd2ZoUoa?=
 =?us-ascii?Q?984GPhi/Wekb3rDuo/qcXc4Qyd7YbcHSkZxMnp5M+3fDtwkgB+Twst+/zmdI?=
 =?us-ascii?Q?xfJoNzjKzOMSd/zwF614Om6OahqsdNwC9IHcq5Bter2UE2EbhcxAo6tLsmjp?=
 =?us-ascii?Q?RZhcT7sivepb0+kxWkcJVpUtE7p04hNaCF5hxfDjrCGqCuQOMPD4hvoMq8JB?=
 =?us-ascii?Q?d6BRUZ5qvxNCs03OOaHM0yIG0pyQa1LX61Qw/Gi1wfRkM9hzehR2XKOBNC8T?=
 =?us-ascii?Q?FImlnvh/1Kwno9jefC2qlCy6Y3jyVcO9iu5BfPGzfv7JaB/Cv6Y9LvzhGc6W?=
 =?us-ascii?Q?rQFdcXQCOT8pMCUp2duJkg02CsyS+2xAjKLQwmjrpsVO2hcbGJmeQCs3DRmG?=
 =?us-ascii?Q?67Nrpp6yyKkx8vENO9x0gy1FnV5AfwoSyrsAOOumS7x3KICRThKVSVTzrPpV?=
 =?us-ascii?Q?al1mgUJ5pu9Wy+VEpJxMBT4CKAKgNCcLo0bOSzxXsnB8xvdXjSoI2GZ25aVJ?=
 =?us-ascii?Q?LJuS0VqXjsn3+1hIpqeFvho3bEglUepWC1zmpuTVNn75cxank3m7a/YwDvZy?=
 =?us-ascii?Q?D42rY13rXXixZi6Rq8F3vIJlpVyAhdanA/mzFfpkgdtXSFLMoRrmDsTSmcn3?=
 =?us-ascii?Q?XZVYcwAuepW8pGx/DenP41rRwt4fXZYVaNnwQS1YnPo6oWmn8QEX8H2gN7ZA?=
 =?us-ascii?Q?iuCvZyOLj9eunRy7pTYGdTdoT3uAh9ly+VPN2oSLMGKReGyOLkFc6tNSLBbg?=
 =?us-ascii?Q?l/9d0EPDJSpP4Kf/NWHHfzVxOXZGS9xakmWIIocDilOAf4L+sqxeVxG6iYQx?=
 =?us-ascii?Q?BnaaO2yLjOUHX5vuz79U8WNB7BJf5pxdLAlNIAzs/Fa5N1xiIbuM8iQVEF6g?=
 =?us-ascii?Q?Ote+1oo+qAouqsw5qXutXQUW6Xsn8JqUAMJnu5BYUv2+ThQpG5ovvR3joxRe?=
 =?us-ascii?Q?JaxxY3Ngz7BUigVCTvy7qrKdBlNVTfN2wgLvCwiAMwzyaniL7GGWzNxOHf+J?=
 =?us-ascii?Q?VlzewC44WCOrqEAESHuOQFKKuHmWKK4HV0xY/5ws7L+29BcIHognmaxYvH2H?=
 =?us-ascii?Q?l4cXzLbRMwcmns6b/8QfQBXrR/7J7ksOLMFys3RJwE0IeyrxX2SOTCMuU9/m?=
 =?us-ascii?Q?HRpnjj9NGixF1z2UfSF1eNEie9p8gbJ8UmpbIkdkzU4okiO73TF/foKg0nRm?=
 =?us-ascii?Q?m4OWPY5W5DplYWq/I3OiA1XX1roKTHjTI2SORWYHhXQEv8PNTmpKg1RZ9EHm?=
 =?us-ascii?Q?gtfRg21KHkTuR48X/0cEnIX8GbY4aueWkX6+xYh38P/b60p6dWLq9VmEc+am?=
 =?us-ascii?Q?KgfiQ+vWx3eKNM+m6f1Pzf9mnT57TAnr6AqmwCmXSMDXK/IDO5kxw6CqwnVj?=
 =?us-ascii?Q?/K41Bz64Hh2oU/AWsCquP3qWP9/n16PKtYyT5CD/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c8baff-30ab-4725-a88c-08db7dd6b627
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:08:54.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dd8448CtVjN2ZeVQCABXNpd2gcb2L+hDz+sIN3MuhqvL/cpbvbghdfi3BkyLdpYRjwGF7V+MQKFPNRTl444MKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:

"Your app can create sockets with IPPROTO_MPTCP as the proto:
( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
forced to create and use MPTCP sockets instead of TCP ones via the
mptcpize command bundled with the mptcpd daemon."

But the mptcpize (LD_PRELOAD technique) command has some limitations
[2]:

 - it doesn't work if the application is not using libc (e.g. GoLang
apps)
 - in some envs, it might not be easy to set env vars / change the way
apps are launched, e.g. on Android
 - mptcpize needs to be launched with all apps that want MPTCP: we could
have more control from BPF to enable MPTCP only for some apps or all the
ones of a netns or a cgroup, etc.
 - it is not in BPF, we cannot talk about it at netdev conf.

So this patchset attempts to use BPF to implement functions similer to
mptcpize.

The main idea is add a hook in sys_socket() to change the protocol id
from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.

1. This first solution [3] is using "cgroup/sock_create":

Implement a new helper bpf_mptcpify() to change the protocol id:

+BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
+{
+	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
+		sk->sk_protocol = IPPROTO_MPTCP;
+		return (unsigned long)sk;
+	}
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_mptcpify_proto = {
+	.func		= bpf_mptcpify,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
+	.arg1_type	= ARG_PTR_TO_CTX,
+};

Add a hook in "cgroup/sock_create" section, invoking bpf_mptcpify()
helper in this hook:

+SEC("cgroup/sock_create")
+int sock(struct bpf_sock *ctx)
+{
+	struct sock *sk;
+
+	if (ctx->type != SOCK_STREAM)
+		return 1;
+
+	sk = bpf_mptcpify(ctx);
+	if (!sk)
+		return 1;
+
+	protocol = sk->sk_protocol;
+	return 1;
+}

But this solution doesn't work, because the sock_create section is
hooked at the end of inet_create(). It's too late to change the protocol
id.

2. The second solution [4] is using "fentry":

Implement a bpf_mptcpify() helper:

+BPF_CALL_1(bpf_mptcpify, struct socket_args *, args)
+{
+	if (args->family == AF_INET &&
+	    args->type == SOCK_STREAM &&
+	    (!args->protocol || args->protocol == IPPROTO_TCP))
+		args->protocol = IPPROTO_MPTCP;
+
+	return 0;
+}
+
+BTF_ID_LIST(bpf_mptcpify_btf_ids)
+BTF_ID(struct, socket_args)
+
+static const struct bpf_func_proto bpf_mptcpify_proto = {
+	.func		= bpf_mptcpify,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_mptcpify_btf_ids[0],
+};

Add a new wrapper socket_create() in sys_socket() path, passing a
pointer of struct socket_args (int family; int type; int protocol) to
the wrapper.

+int socket_create(struct socket_args *args, struct socket **res)
+{
+	return sock_create(args->family, args->type, args->protocol, res);
+}
+EXPORT_SYMBOL(socket_create);
+
 /**
  *	sock_create_kern - creates a socket (kernel space)
  *	@net: net namespace
@@ -1608,6 +1614,7 @@  EXPORT_SYMBOL(sock_create_kern);
 
 static struct socket *__sys_socket_create(int family, int type, int protocol)
 {
+	struct socket_args args = { 0 };
 	struct socket *sock;
 	int retval;
 
@@ -1621,7 +1628,10 @@  static struct socket *__sys_socket_create(int family, int type, int protocol)
 		return ERR_PTR(-EINVAL);
 	type &= SOCK_TYPE_MASK;
 
-	retval = sock_create(family, type, protocol, &sock);
+	args.family = family;
+	args.type = type;
+	args.protocol = protocol;
+	retval = socket_create(&args, &sock);
 	if (retval < 0)
 		return ERR_PTR(retval);

Add "fentry" hook to the newly added wrapper, invoking bpf_mptcpify()
in the hook:

+SEC("fentry/socket_create")
+int BPF_PROG(trace_socket_create, void *args,
+		struct socket **res)
+{
+	bpf_mptcpify(args);
+	return 0;
+}

This version works. But it's just a work around version. Since the code
to add a wrapper to sys_socket() is not very elegant indeed, and it
shouldn't be accepted by upstream.

3. The last solution is this patchset itself:

Introduce new program type BPF_PROG_TYPE_CGROUP_SOCKINIT and attach type
BPF_CGROUP_SOCKINIT on cgroup basis.

Define BPF_CGROUP_RUN_PROG_SOCKINIT() helper, and implement
__cgroup_bpf_run_sockinit() helper to run a sockinit program:

+#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol)		       \
+({									       \
+	int __ret = 0;							       \
+	if (cgroup_bpf_enabled(CGROUP_SOCKINIT))			       \
+		__ret = __cgroup_bpf_run_sockinit(family, type, protocol,      \
+						  CGROUP_SOCKINIT);	       \
+	__ret;								       \
+})
+

Invoke BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create() to change
the arguments:

@@ -1469,6 +1469,12 @@  int __sock_create(struct net *net, int family, int type, int protocol,
 	struct socket *sock;
 	const struct net_proto_family *pf;
 
+	if (!kern) {
+		err = BPF_CGROUP_RUN_PROG_SOCKINIT(&family, &type, &protocol);
+		if (err)
+			return err;
+	}
+
 	/*
 	 *      Check protocol is in range
 	 */

Define BPF program in this newly added 'sockinit' SEC, so it will be
hooked in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().

@@ -158,6 +158,11 @@  static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
 		{0, BPF_CGROUP_SETSOCKOPT},
 	},
+	{
+		"cgroup/sockinit",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT},
+		{0, BPF_CGROUP_SOCKINIT},
+	},
 };

+SEC("cgroup/sockinit")
+int mptcpify(struct bpf_sockinit_ctx *ctx)
+{
+	if ((ctx->family == AF_INET || ctx->family == AF_INET6) &&
+	    ctx->type == SOCK_STREAM &&
+	    (!ctx->protocol || ctx->protocol == IPPROTO_TCP)) {
+		ctx->protocol = IPPROTO_MPTCP;
+	}
+
+	return 1;
+}

This version is the best solution we have found so far.

[1]
https://github.com/multipath-tcp/mptcp_net-next/wiki
[2]
https://github.com/multipath-tcp/mptcp_net-next/issues/79
[3]
https://patchwork.kernel.org/project/mptcp/cover/cover.1688215769.git.geliang.tang@suse.com/
[4]
https://patchwork.kernel.org/project/mptcp/cover/cover.1688366249.git.geliang.tang@suse.com/


Geliang Tang (8):
  bpf: Add new prog type sockinit
  bpf: Run a sockinit program
  net: socket: run sockinit hooks
  libbpf: Support sockinit hook
  selftests/bpf: Add mptcpify program
  selftests/bpf: use random netns name for mptcp
  selftests/bpf: add two mptcp netns helpers
  selftests/bpf: Add mptcpify selftest

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/linux/bpf-cgroup.h                    |  14 ++
 include/linux/bpf_types.h                     |   2 +
 include/uapi/linux/bpf.h                      |   8 ++
 kernel/bpf/cgroup.c                           |  90 +++++++++++++
 kernel/bpf/syscall.c                          |   7 +
 kernel/bpf/verifier.c                         |   1 +
 net/socket.c                                  |   6 +
 tools/include/uapi/linux/bpf.h                |   8 ++
 tools/lib/bpf/libbpf.c                        |   3 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../bpf/cgroup_getset_retval_hooks.h          |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 123 ++++++++++++++++--
 .../selftests/bpf/prog_tests/section_names.c  |   5 +
 tools/testing/selftests/bpf/progs/mptcpify.c  |  26 ++++
 15 files changed, 287 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

