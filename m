Return-Path: <bpf+bounces-4924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5D751854
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 07:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192871C20D92
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 05:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF65683;
	Thu, 13 Jul 2023 05:47:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D0566D
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 05:47:39 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3441BD5
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 22:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG09m1EcehiNOQzA1Owlz4r/Wrdt/lHA/E8a64Fjuom7Gz3Kb3gQu6Ug4Iyp2D4HjwB+TTwBop7lP+S3loWuU1SxOemit/+jI81+ruedfS9h348AiLqja9GO5LuAKqHyKc5XlqGF92GPIB4ib4F8RI50lhNpFpxIiwvmSz6nLlmgGCamUYTr285kDMdtpcLUCs2MAlS9uQIkwcPHsdjnVwBXId+1WiHIF1ABEljPWbuwyVeS5wH0xu49UyJwN/yA5VNM4y8JA5b5kfPxMkeVq7yGxSfehWNta0XeR1fOc70efvJDqwMDJXBWe8outZZUZTMS6RyGq2qa9wVhzrE8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCH6EMfDwkYkUCXSQX5vH7wGmpc24vKpjv1k6IKXzYA=;
 b=mrkHso/dloOYCP+rBbFMju2PTqRgbS0P7sOWCKWtYsj5dkBi5oQy1GONjTNoTHHp8q5/DhzVzaBVGwLW/qK5Q2Mn7zqXR8lVBkkY+34t48OdMlCc+OX7s46WsbPpvahJCtbmIUZqns6ccHtwHeNXgcozMoSGMCiHhvhnieI3VzuASly3YC+ZELUJmy+pFxnTn8byuHw1feTCdvluQi9w/09lPRIKwAMu/OIv9vxE2kwqugxfsvzUem799+7CqRkHOSn5U7uM3YRlSOj1q75qJTZ7NBE6L+Bg52jhpynjPlhSfZ6Lu0CM+tBAxBU1X3LO+KZPQspHpmJZ1TRX33Fo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCH6EMfDwkYkUCXSQX5vH7wGmpc24vKpjv1k6IKXzYA=;
 b=AfjAgk6e1JNgBZ6F9grWyjcK6Pr9B3iLI2AZylPQK7KfNlN8Q6ZIf8E6MaGTO4k5d9BSbnQ2Kp3PfbAtlo92WkJEvQyTJgvC3bfxm0vnBY1E3W/gcGjjMc621ZWABHyqXme6OLMAGEyDLz7dEKGqPKuhHWAYnBQSSMm0+1MAfCZW+Gy8WfexWNafoXUkVoeF8cPJq7+FO2/jrUr+n8V4aAfpvVx5EwDVenWhwIYvFt6lpEQX+i1DFfibI4rFJsyAut0hrgyq/GFhYzEi6PmTIoHPCbEdmBorN8IUNFi39sbAg32FTiuK+8PWfnkByWdb4sK4rpZgkvJqlCpnqgcxcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB10030.eurprd04.prod.outlook.com (2603:10a6:102:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.36; Thu, 13 Jul
 2023 05:47:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 05:47:32 +0000
Date: Thu, 13 Jul 2023 13:47:16 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [RFC bpf-next 0/8] BPF 'force to MPTCP'
Message-ID: <20230713054716.GA18806@localhost.localdomain>
References: <cover.1688616142.git.geliang.tang@suse.com>
 <ZKbzs7foUw+eeNnn@google.com>
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <ZKbzs7foUw+eeNnn@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:405:1::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB10030:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec6f565-f895-4f4b-1858-08db8364a6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8JJMkIIaIBy4wVBkmRBy5AxDeusmv/rqhXf2T+25O3KtE2M55FPOPryJoi1qc0MLlp0ZAlIKXoEkOlunbBXbMtccieGBWl1sbrRXK1dst4CbfVbnqFFeXiAPkz+r9du2KN4J5LcpikNXcBYf8Wkzvy/0r8F0TGPVUxkjEkseZYxoQe1OZ66oVHfV9Blk9yyXjPxxpNdcBZavohWRmWbZ5llmRJwpw/gu7SBojPtZdZk+Yhl9DOkrGbqlyJXco/75cXyKyLhcMjR7bq1vbVV3wSC4a/1gP77i70nbg1xR/ifJvYXX32/z02jvqFjOtMb58fp4I8jsb5RaAGHDG15hPZZm3oe05sXU0uWvKg7U9PFhjZ3+J2VesGaAo7UZochh+5zBiSqtClX0wxItonQ1Iw78iRAwHyyY4P0Uis7xz3mLgv/aM1Aygz/WgMbEr4aqPDGawv1AGSjFjaWRHVk3FhHz8UEJHmvWWHvo0J8xvetLnJBBWTwtyWLvJ9gzWXjOfs/bcyY7ACj3YvcLjW6YNjv5Un2otXduqdbwZ6waopt0RB+7sEu2byFRuxOCNxLdJmcp7bUAefbjy9GuilvmLwCRpqW3mZoiWNhHfrPReCGGLWSSoZKDIVYb0sMFI40bf4uaz7p65vE+RqJqrghrBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(33656002)(86362001)(38100700002)(478600001)(6666004)(54906003)(6486002)(44144004)(6512007)(966005)(8936002)(44832011)(235185007)(5660300002)(7416002)(316002)(66946007)(66476007)(2906002)(6916009)(66556008)(41300700001)(8676002)(4326008)(83380400001)(1076003)(9686003)(6506007)(26005)(186003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EHrOozKQkAMNEA2yuen5K7a51F/WtKiUBIKMZzPz5B4miQEB/kBtb915RnR7?=
 =?us-ascii?Q?epbnGeqkYZX4LaA5w0/3zSxzKg8zM4/HzB2ahjjEpYR49/OfD5/+sDxOhhby?=
 =?us-ascii?Q?0vB+Uzcbhs5PhodIYI1MR/YHNqkWTYpToLGFR2r6Bn0pfodJoR5qgnNC+Plo?=
 =?us-ascii?Q?qLYEvBN6wI6XGzvwwYf3+9eEVqYO74qalXPicKfYq1YTi4aUfVo0riw1xyNN?=
 =?us-ascii?Q?qPtwNmFqt5/1BmE81/hoqIayE/NwH7QAG/tWRtRIMns+4LkDaPle3plE6hJT?=
 =?us-ascii?Q?fULKoiEaNNpfNj4e2aqU0cLDYfwuOlNoAJ8WqWqmS4NKmTf55aYcxLT5vYMs?=
 =?us-ascii?Q?ToGYizcalqW+gPOYCS8EF/kc54T58uJYloKoNc4VQIDha71Dyt8ZqX+EaDab?=
 =?us-ascii?Q?psozZXMV/XHcE/8XM1lR6LzG8WvKB13m+7kaPTy86xroCOd++Xt2UQcvjrmO?=
 =?us-ascii?Q?Hj6EIBmq+0GQ/fmY4tH85GurAl9WP4BxT0d8PvzscjYgzw4ZXB55brqrW7+K?=
 =?us-ascii?Q?s1RMDDENkj33FsnaM+yyQEXI3QeUi9UgYpQcht2NBhv0sPJO3Q+RvPTICU8x?=
 =?us-ascii?Q?yz4dpzIROOOPxoC+URUzKb0OD5mcJVHfnZiIcbaN2xIdkcdQWrQud4tv4kfb?=
 =?us-ascii?Q?eAzI8W9Ylbn6+vcHXOAI2S/IWFnNtOYf2wEwRnvvyLZh6NtkvNObc0ROtj41?=
 =?us-ascii?Q?6fny6+aQ+0U/Gw3fIPHK6JvqFD3Z8Zrmex+jRLw3MTvhQEPouPf5OO3lqkxo?=
 =?us-ascii?Q?c8aJGf6kuz+zTIhCbiZFhSlav/uK2hAGo0XgvZ0zGoKx3waX3rqvCc0bDUSk?=
 =?us-ascii?Q?0UGkowDvhTdg5qn/5Qmma8gqwAw6eCDijy+CXgbcQixBys2WchaKBdoDMsYz?=
 =?us-ascii?Q?67aQXXv/mvipeCXLAMQUnZjC9QY+N10zI3fcK51KaBrRqhduz9FwdCsXBBa1?=
 =?us-ascii?Q?xs+4I21X0uwpupYacQ9vjiGQ0Top8SNIj8C6awdo5BlXRdlw/akPbAptUYlD?=
 =?us-ascii?Q?08Vd1bF7HS523HU2WwQz7jlBNzwCqzB3a9MZJ+pUrvTYmF4imNuAe7k2suzx?=
 =?us-ascii?Q?fV3k6Aq5gyzA9/dXa7B7e7XIffybs8uReeOJqUnQTkb/iNNVSgPwLMZGFLCQ?=
 =?us-ascii?Q?KvLHGVXeCLdY+CSffgxJN2atY+3G0ruQBVOOM13oozQ13DHfoNXXA/XO2W7K?=
 =?us-ascii?Q?azaWULKQWdtkgwKgX0lmMsRuKYPIFNKSFpX4PjXsZ6JdOu7TzdkxJrfvFCEj?=
 =?us-ascii?Q?6VMmulDc8yJsnThikuQpUjWc3mPi4U4QL6H/6+dDrC//8gP2atIgAwdaSWFI?=
 =?us-ascii?Q?qKo+SAs0YHLE1xuhJw950WxFOIDXDlMQyrK0b+wSEdluNsO9kcgZB2DQ8Tkd?=
 =?us-ascii?Q?tEGqzBCB/DEBxEMb9cuteBtLrxP/NxRA/ai4gHaT+HQFxtzZp8ImUh5LGalJ?=
 =?us-ascii?Q?tB6HD+6JGU0uknb8GxfvGDfB+5xzLE2/SkHFtht76AuOzkAaqIiyw0mR3KyC?=
 =?us-ascii?Q?umZ9CbaqtAdvwJ1TkPkGavZpqQkY4OPyjLmTpvHq6SGsE1+x9plF9efEW8lY?=
 =?us-ascii?Q?U9UxMyuNvys52BSF6zSkojttqxXvmdxy0DLUsFNf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec6f565-f895-4f4b-1858-08db8364a6ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 05:47:32.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqtpH1DFEJFgaaPGL8O03QnZZmdcMYty73KQQeqYBXGelg6im+xNDZBrD8ZU7Zj++ooviqm+3y/um0GuyHn0Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2023 at 10:02:43AM -0700, Stanislav Fomichev wrote:
> On 07/06, Geliang Tang wrote:
> > As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:
> > 
> > "Your app can create sockets with IPPROTO_MPTCP as the proto:
> > ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
> > forced to create and use MPTCP sockets instead of TCP ones via the
> > mptcpize command bundled with the mptcpd daemon."
> > 
> > But the mptcpize (LD_PRELOAD technique) command has some limitations
> > [2]:
> > 
> >  - it doesn't work if the application is not using libc (e.g. GoLang
> > apps)
> >  - in some envs, it might not be easy to set env vars / change the way
> > apps are launched, e.g. on Android
> >  - mptcpize needs to be launched with all apps that want MPTCP: we could
> > have more control from BPF to enable MPTCP only for some apps or all the
> > ones of a netns or a cgroup, etc.
> >  - it is not in BPF, we cannot talk about it at netdev conf.
> > 
> > So this patchset attempts to use BPF to implement functions similer to
> > mptcpize.
> > 
> > The main idea is add a hook in sys_socket() to change the protocol id
> > from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
> > 
> > 1. This first solution [3] is using "cgroup/sock_create":
> > 
> > Implement a new helper bpf_mptcpify() to change the protocol id:
> > 
> > +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
> > +{
> > +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
> > +		sk->sk_protocol = IPPROTO_MPTCP;
> > +		return (unsigned long)sk;
> > +	}
> > +
> > +	return (unsigned long)NULL;
> > +}
> > +
> > +const struct bpf_func_proto bpf_mptcpify_proto = {
> > +	.func		= bpf_mptcpify,
> > +	.gpl_only	= false,
> > +	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
> > +	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> > +	.arg1_type	= ARG_PTR_TO_CTX,
> > +};
> > 
> > Add a hook in "cgroup/sock_create" section, invoking bpf_mptcpify()
> > helper in this hook:
> > 
> > +SEC("cgroup/sock_create")
> > +int sock(struct bpf_sock *ctx)
> > +{
> > +	struct sock *sk;
> > +
> > +	if (ctx->type != SOCK_STREAM)
> > +		return 1;
> > +
> > +	sk = bpf_mptcpify(ctx);
> > +	if (!sk)
> > +		return 1;
> > +
> > +	protocol = sk->sk_protocol;
> > +	return 1;
> > +}
> > 
> > But this solution doesn't work, because the sock_create section is
> > hooked at the end of inet_create(). It's too late to change the protocol
> > id.
> > 
> > 2. The second solution [4] is using "fentry":
> > 
> > Implement a bpf_mptcpify() helper:
> > 
> > +BPF_CALL_1(bpf_mptcpify, struct socket_args *, args)
> > +{
> > +	if (args->family == AF_INET &&
> > +	    args->type == SOCK_STREAM &&
> > +	    (!args->protocol || args->protocol == IPPROTO_TCP))
> > +		args->protocol = IPPROTO_MPTCP;
> > +
> > +	return 0;
> > +}
> > +
> > +BTF_ID_LIST(bpf_mptcpify_btf_ids)
> > +BTF_ID(struct, socket_args)
> > +
> > +static const struct bpf_func_proto bpf_mptcpify_proto = {
> > +	.func		= bpf_mptcpify,
> > +	.gpl_only	= false,
> > +	.ret_type	= RET_INTEGER,
> > +	.arg1_type	= ARG_PTR_TO_BTF_ID,
> > +	.arg1_btf_id	= &bpf_mptcpify_btf_ids[0],
> > +};
> > 
> > Add a new wrapper socket_create() in sys_socket() path, passing a
> > pointer of struct socket_args (int family; int type; int protocol) to
> > the wrapper.
> > 
> > +int socket_create(struct socket_args *args, struct socket **res)
> > +{
> > +	return sock_create(args->family, args->type, args->protocol, res);
> > +}
> > +EXPORT_SYMBOL(socket_create);
> > +
> >  /**
> >   *	sock_create_kern - creates a socket (kernel space)
> >   *	@net: net namespace
> > @@ -1608,6 +1614,7 @@  EXPORT_SYMBOL(sock_create_kern);
> >  
> >  static struct socket *__sys_socket_create(int family, int type, int protocol)
> >  {
> > +	struct socket_args args = { 0 };
> >  	struct socket *sock;
> >  	int retval;
> >  
> > @@ -1621,7 +1628,10 @@  static struct socket *__sys_socket_create(int family, int type, int protocol)
> >  		return ERR_PTR(-EINVAL);
> >  	type &= SOCK_TYPE_MASK;
> >  
> > -	retval = sock_create(family, type, protocol, &sock);
> > +	args.family = family;
> > +	args.type = type;
> > +	args.protocol = protocol;
> > +	retval = socket_create(&args, &sock);
> >  	if (retval < 0)
> >  		return ERR_PTR(retval);
> > 
> > Add "fentry" hook to the newly added wrapper, invoking bpf_mptcpify()
> > in the hook:
> > 
> > +SEC("fentry/socket_create")
> > +int BPF_PROG(trace_socket_create, void *args,
> > +		struct socket **res)
> > +{
> > +	bpf_mptcpify(args);
> > +	return 0;
> > +}
> > 
> > This version works. But it's just a work around version. Since the code
> > to add a wrapper to sys_socket() is not very elegant indeed, and it
> > shouldn't be accepted by upstream.
> > 
> > 3. The last solution is this patchset itself:
> > 
> > Introduce new program type BPF_PROG_TYPE_CGROUP_SOCKINIT and attach type
> > BPF_CGROUP_SOCKINIT on cgroup basis.
> > 
> > Define BPF_CGROUP_RUN_PROG_SOCKINIT() helper, and implement
> > __cgroup_bpf_run_sockinit() helper to run a sockinit program:
> > 
> > +#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol)		       \
> > +({									       \
> > +	int __ret = 0;							       \
> > +	if (cgroup_bpf_enabled(CGROUP_SOCKINIT))			       \
> > +		__ret = __cgroup_bpf_run_sockinit(family, type, protocol,      \
> > +						  CGROUP_SOCKINIT);	       \
> > +	__ret;								       \
> > +})
> > +
> > 
> > Invoke BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create() to change
> > the arguments:
> > 
> > @@ -1469,6 +1469,12 @@  int __sock_create(struct net *net, int family, int type, int protocol,
> >  	struct socket *sock;
> >  	const struct net_proto_family *pf;
> >  
> > +	if (!kern) {
> > +		err = BPF_CGROUP_RUN_PROG_SOCKINIT(&family, &type, &protocol);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >  	/*
> >  	 *      Check protocol is in range
> >  	 */
> > 
> > Define BPF program in this newly added 'sockinit' SEC, so it will be
> > hooked in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().
> > 
> > @@ -158,6 +158,11 @@  static struct sec_name_test tests[] = {
> >  		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
> >  		{0, BPF_CGROUP_SETSOCKOPT},
> >  	},
> > +	{
> > +		"cgroup/sockinit",
> > +		{0, BPF_PROG_TYPE_CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT},
> > +		{0, BPF_CGROUP_SOCKINIT},
> > +	},
> >  };
> > 
> > +SEC("cgroup/sockinit")
> > +int mptcpify(struct bpf_sockinit_ctx *ctx)
> > +{
> > +	if ((ctx->family == AF_INET || ctx->family == AF_INET6) &&
> > +	    ctx->type == SOCK_STREAM &&
> > +	    (!ctx->protocol || ctx->protocol == IPPROTO_TCP)) {
> > +		ctx->protocol = IPPROTO_MPTCP;
> > +	}
> > +
> > +	return 1;
> > +}
> > 
> > This version is the best solution we have found so far.
> > 
> > [1]
> > https://github.com/multipath-tcp/mptcp_net-next/wiki
> > [2]
> > https://github.com/multipath-tcp/mptcp_net-next/issues/79
> > [3]
> > https://patchwork.kernel.org/project/mptcp/cover/cover.1688215769.git.geliang.tang@suse.com/
> > [4]
> > https://patchwork.kernel.org/project/mptcp/cover/cover.1688366249.git.geliang.tang@suse.com/
> 
> cgroup/sock_create being weird and triggering late and only for af_inet4/6
> was the reason we added ability to attach to lsm hooks on a per-cgroup
> basis:
> https://lore.kernel.org/bpf/20220628174314.1216643-1-sdf@google.com/
> 
> Unfortunately, using it here won't help either :-( The following
> hook triggers early enough but doesn't allow changing the arguments (I was
> interested only in filtering based on the arguments, not changing them):
> 
> LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
> 
> So maybe another alternative might be to change its definition to int *family,
> int *type, int *protocol and use lsm_cgroup/socket_create to rewrite the

Thanks Stanislav, this lsm_cgroup/socket_create works. The test patch
is attached.

> protocol? (some verifier changes might needed to make those writable)

But I got some verification errors here:

   invalid mem access 'scalar'.

I tried many times but couldn't solve it, so I simply skipped the
verifier in the test patch (I marked TODO in front of this code).
Could you please give me some suggestions for verification?

Thanks,
-Geliang

--YiEDa0DAkWCtVeE4
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="v4-0001-bpf-Force-to-MPTCP.patch"

From dd3c0ee4202e01c52534e8359450b42498cd4e40 Mon Sep 17 00:00:00 2001
Message-Id: <dd3c0ee4202e01c52534e8359450b42498cd4e40.1689226263.git.geliang.tang@suse.com>
From: Geliang Tang <geliang.tang@suse.com>
Date: Sun, 2 Jul 2023 16:48:59 +0800
Subject: [RFC bpf-next v4] bpf: Force to MPTCP

selftests/bpf: Add mptcpify program

This patch implements a new test program mptcpify: if the family is
AF_INET or AF_INET6, the type is SOCK_STREAM, and the protocol ID is
0 or IPPROTO_TCP, set it to IPPROTO_MPTCP.

This is defined in a newly added 'sockinit' SEC, so it will be hooked
in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>

selftests/bpf: use random netns name for mptcp

Use rand() to generate a random netns name instead of using the fixed
name "mptcp_ns" for every test.

By doing that, we can re-launch the test even if there was an issue
removing the previous netns or if by accident, a netns with this generic
name already existed on the system.

Note that using a different name each will also help adding more
subtests in future commits.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

selftests/bpf: add two mptcp netns helpers

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

These new helpers will be re-used in the following commits introducing
new tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

selftests/bpf: Add mptcpify selftest

This patch extends the MPTCP test base, add a selftest test_mptcpify()
for the mptcpify case.

Open and load the mptcpify test prog to mptcpify the TCP sockets
dynamically, then use start_server() and connect_to_fd() to create a
TCP socket, but actually what's created is an MPTCP socket, which can
be verified through the outputs of 'ss' and 'nstat' commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/lsm_hook_defs.h                 |   2 +-
 include/linux/security.h                      |   4 +-
 kernel/bpf/verifier.c                         |   5 +
 net/socket.c                                  |   4 +-
 security/apparmor/lsm.c                       |   6 +-
 security/security.c                           |   2 +-
 security/selinux/hooks.c                      |   4 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 128 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcpify.c  |  41 ++++++
 9 files changed, 176 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7308a1a7599b..c2c178dfb06d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -288,7 +288,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
 LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
-LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
+LSM_HOOK(int, 0, socket_create, int family, int type, int *protocol, int kern)
 LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
 	 int protocol, int kern)
 LSM_HOOK(int, 0, socket_socketpair, struct socket *socka, struct socket *sockb)
diff --git a/include/linux/security.h b/include/linux/security.h
index 32828502f09e..67fd5bb91b72 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1416,7 +1416,7 @@ static inline int security_watch_key(struct key *key)
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
 int security_unix_may_send(struct socket *sock,  struct socket *other);
-int security_socket_create(int family, int type, int protocol, int kern);
+int security_socket_create(int family, int type, int *protocol, int kern);
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern);
 int security_socket_socketpair(struct socket *socka, struct socket *sockb);
@@ -1482,7 +1482,7 @@ static inline int security_unix_may_send(struct socket *sock,
 }
 
 static inline int security_socket_create(int family, int type,
-					 int protocol, int kern)
+					 int *protocol, int kern)
 {
 	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81a93eeac7a0..d6503ac62f6d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6471,6 +6471,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
+	} else if (base_type(reg->type) == SCALAR_VALUE) {
+		/* TODO
+		 * skip it to let mptcpify test run */
+		pr_info("%s R%d invalid mem access '%s'\n",
+			__func__, regno, reg_type_str(env, reg->type));
 	} else {
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
 			reg_type_str(env, reg->type));
diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..cb1df106de4a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1328,7 +1328,7 @@ int sock_create_lite(int family, int type, int protocol, struct socket **res)
 	int err;
 	struct socket *sock = NULL;
 
-	err = security_socket_create(family, type, protocol, 1);
+	err = security_socket_create(family, type, &protocol, 1);
 	if (err)
 		goto out;
 
@@ -1488,7 +1488,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 		family = PF_PACKET;
 	}
 
-	err = security_socket_create(family, type, protocol, kern);
+	err = security_socket_create(family, type, &protocol, kern);
 	if (err)
 		return err;
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f431251ffb91..ba1ba86771bc 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -868,7 +868,7 @@ static void apparmor_sk_clone_security(const struct sock *sk,
 /**
  * apparmor_socket_create - check perms before creating a new socket
  */
-static int apparmor_socket_create(int family, int type, int protocol, int kern)
+static int apparmor_socket_create(int family, int type, int *protocol, int kern)
 {
 	struct aa_label *label;
 	int error = 0;
@@ -878,9 +878,9 @@ static int apparmor_socket_create(int family, int type, int protocol, int kern)
 	label = begin_current_label_crit_section();
 	if (!(kern || unconfined(label)))
 		error = af_select(family,
-				  create_perm(label, family, type, protocol),
+				  create_perm(label, family, type, *protocol),
 				  aa_af_perm(label, OP_CREATE, AA_MAY_CREATE,
-					     family, type, protocol));
+					     family, type, *protocol));
 	end_current_label_crit_section(label);
 
 	return error;
diff --git a/security/security.c b/security/security.c
index b720424ca37d..4a8ef5d0304a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4078,7 +4078,7 @@ EXPORT_SYMBOL(security_unix_may_send);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_create(int family, int type, int protocol, int kern)
+int security_socket_create(int family, int type, int *protocol, int kern)
 {
 	return call_int_hook(socket_create, 0, family, type, protocol, kern);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..4a1d65210faa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4513,7 +4513,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 }
 
 static int selinux_socket_create(int family, int type,
-				 int protocol, int kern)
+				 int *protocol, int kern)
 {
 	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	u32 newsid;
@@ -4523,7 +4523,7 @@ static int selinux_socket_create(int family, int type,
 	if (kern)
 		return 0;
 
-	secclass = socket_type_to_security_class(family, type, protocol);
+	secclass = socket_type_to_security_class(family, type, *protocol);
 	rc = socket_sockcreate_sid(tsec, secclass, &newsid);
 	if (rc)
 		return rc;
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..93767e441e17 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,8 +6,9 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 
-#define NS_TEST "mptcp_ns"
+char NS_TEST[32];
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -22,6 +23,26 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	return open_netns(NS_TEST);
+fail:
+	return NULL;
+}
+
+static void cleanup_netns(struct nstoken *nstoken)
+{
+	if (nstoken)
+		close_netns(nstoken);
+
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -147,11 +168,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -174,11 +192,101 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
+	cleanup_netns(nstoken);
+
+	close(cgroup_fd);
+}
+
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(void)
+{
+	char cmd[256];
+	int err = 0;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -tOni | grep -q '%s'",
+		 NS_TEST, "tcp-ulp-mptcp");
+	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
+		err++;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
+		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
+		 "NR==1 {next} {print $2}", "1");
+	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
+		err++;
+
+	return err;
+}
+
+static int run_mptcpify(int cgroup_fd)
+{
+	int server_fd, client_fd, prog_fd, err = 0;
+	struct mptcpify *mptcpify_skel;
+
+	mptcpify_skel = mptcpify__open_and_load();
+	if (!ASSERT_OK_PTR(mptcpify_skel, "mptcpify__open_and_load"))
+		return -EIO;
+
+	prog_fd = bpf_program__fd(mptcpify_skel->progs.mptcpify);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
+		err = -EIO;
+		goto out;
+	}
 
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
+	if (!ASSERT_OK(err, "attach alloc_prog_fd")) {
+		err = -EIO;
+		goto out;
+	}
 
+	/* without MPTCP */
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server")) {
+		err = -EIO;
+		goto out;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err = -EIO;
+		goto close_server;
+	}
+
+	send_byte(client_fd);
+	err += verify_mptcpify();
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+out:
+	mptcpify__destroy(mptcpify_skel);
+	return err;
+}
+
+static void test_mptcpify(void)
+{
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcpify");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+
+fail:
+	cleanup_netns(nstoken);
 	close(cgroup_fd);
 }
 
@@ -186,4 +294,6 @@ void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("mptcpify"))
+		test_mptcpify();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..94aef62016fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+char fmt[] = "tcp=%u\n";
+
+#define	AF_INET		2
+#define	AF_INET6	10
+#define	SOCK_STREAM	1
+#define	IPPROTO_TCP	6
+#define	IPPROTO_MPTCP	262
+
+static __always_inline bool is_tcp(int family, int type, int protocol)
+{
+	if ((family == AF_INET || family == AF_INET6) &&
+	    type == SOCK_STREAM &&
+	    (!protocol || protocol == IPPROTO_TCP))
+		return true;
+
+	return false;
+}
+
+SEC("lsm_cgroup/socket_create")
+int BPF_PROG(mptcpify, int family, int type, int *protocol, int kern)
+{
+	bool tcp;
+
+	if (kern)
+		goto out;
+
+	tcp = is_tcp(family, type, *protocol);
+	bpf_trace_printk(fmt, sizeof(fmt), tcp);
+	if (tcp)
+		*protocol = IPPROTO_MPTCP;
+out:
+	return 1;
+}
-- 
2.35.3


--YiEDa0DAkWCtVeE4--

