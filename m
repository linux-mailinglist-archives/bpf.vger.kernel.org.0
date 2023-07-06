Return-Path: <bpf+bounces-4199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B309749759
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B547C28129E
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF12C1FC4;
	Thu,  6 Jul 2023 08:19:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AC1FB5
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:19:48 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C4810F7
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnIv0irHdNs03WaGt0Dj/5H/JCvryTLzBSZ+jY1tY0T+bUmnXU330xyHbciPyciNSlvf4Bd0goj2pCb7wvcp2egbyxR6OIRo29jQaGRtLQK9deLPiG8Bo3OPNnqPeG1fc+hZFVJNh+EtYu4cqGFTHX7VhmX/02tNrDURuXBs+2GKrxwn11RiFceqNrlToLcoRrmcscroBq10J0FkWpR+EzCMPgwlFtRuUwh1FspJl1WHDE9aOFieVwasvy1QMaqnZw+uMCC4S0yY9uNuzQzS7olV7AzwR9p3OAZHDAEAgtCVRkVISnQ/WDH1FF7CyHDaDHFFv0Jjaqoe/jIHo1RMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1RmfYMQGcA2me8GN4cxwZgq+C+HsJzhHuoX1CcFGRE=;
 b=USBIJD256mOFmJrUtybaBzWrukGcc2PGZSbNBGVgAnoHkV2EnWh8vxVhwZkn8pNjmaSbaM6TfxD4/D2sFlP1hWAq1HN5aYCiuP5e5Qm6ZsqXJG/DzaUa7IAAlSUgR6wT1sAJJTcaVDEb6ustaALZAB5jjPYlP86XWCOAmaiKoLU75HL8wiij2oQ3j148/LQETAAPb2BnDDsQQMbmuXbs8KTFnu17eqj5TJyLwKyb95ep0O0tu0N4rWQgJQJwoso8sltVzrl8Bwe0l7ZzFC/X79h3azHclQSEivHNKFPuRqYT+SZLOSRMGK6KXTnHcYnCkzDHGvGg+u/HQpNXif1Vdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1RmfYMQGcA2me8GN4cxwZgq+C+HsJzhHuoX1CcFGRE=;
 b=VVOtMmojizmRT/sewAqrQpwe7jeUNkGLoVxTPlk5gBX4kGu/dGwA2WpLfEmesld2CHMkxGcFLlUCN/oksEOwSDsg/A4UNBOwY0hIttCxj9siCtfO1qaHmJ9FWa2ESCOdgajFhzsuu/WCH6lNsBcbxXFT+XulribkfBeY1bGjz2NHVU7JpTeZp+m0H8Sb2CFeTslwMkK4roB4jFWZ+c9ZIxmeB0BoHOLlD79J9r7+fJ+OJbco4JrAt+ZkFLd5dFfumwrkDqV4zJQ+UXGoisPliR8NAXhKrkLRDVbKm+F+ilhF47CI0CBkZUvz5X5Qkv8dPqo5a4gsFsHSJR86U57UqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:19:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:19:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [RFC bpf-next v3 0/8] BPF 'force to MPTCP'
Date: Thu,  6 Jul 2023 16:19:39 +0800
Message-Id: <cover.1688631200.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: a2488d45-b935-410c-7684-08db7df9c039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	amb9VCWuLQ2xhpys724zacGtIEGHVYHRL0DvKcxD4pkd3W/wyfejzWdk16wkkKkFCtJsIPt7WebteIJHbepd0gKxwHVzxj1On0pbjZv8ayw3Xuc+jOcyzq4czOM7MJk3O9t8wJP87FFB5OeTAp5Zw+0aiFX9i6xmdgXcexjO5ofXioMEiFUCfbk71qCUtilGtrsIPs2KIDU5GwZoy49iv0OynG4FdVXJ9iw+jM1fSaOWiQX5SFCrexPnbHUg9/tE6TtN3IiLrFA1KHb20IKIfrtaP/PVpYg3kRssl9MvillxGgjKl7A/ycDofVysMo9L0H6DaNiXnG6R9JKxTiW4PzdM3RUR9caeWFBV5R1TPfa+DNSxXAizry8OixL76IFe1eISsoS2omGPJoUd5516QgmbH0hEKB6m7jczxyCo9ebjYaTbSYkqK3BDDZsQ1muzRgozu09UDEkBj/Dj2XVm7DUSqXuo/ddAfj6X9kxAqp0JF3pNwBUpSpSzB97Nt9TcPgwmOxLxyYt84YFE/Sm9qfKcylek4+jEKkbRi/mzRQKarwZNhb4NYDZYZS0Yz5H43SRMHlRpseICR6jS2qs6LPZ4yAr+JgEhfnRzuugwmnGGyHSmgDS/u+7GNGH9jWi1mkeUdIbRMF4j8tWltXv67kqiGZbDrSCJdR2Mj8vFyf8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(7416002)(8936002)(8676002)(44832011)(83380400001)(41300700001)(5660300002)(2906002)(316002)(2616005)(66946007)(38100700002)(26005)(110136005)(4326008)(921005)(66476007)(66556008)(6512007)(86362001)(186003)(478600001)(6506007)(6666004)(36756003)(6486002)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blRxdGxjUmc4TlNER1lNU3hpdTVyODRUbXZER1JaTGZqR3kzQUpaditUTjVO?=
 =?utf-8?B?SHdDdEtqOWV0a2ZGbWZXRzJGc25TNWpBcnVSb29SUXdxWmRMb2V1N0xEVGdE?=
 =?utf-8?B?UG5mM3ZSQXVNOTV4NzcxK0IrNUVLL01XQTFOV1lKb28vaGVMOURzbVZTZjR6?=
 =?utf-8?B?ZVI3S3RWMXR4RFJ5RzUyeFhaQk9xcy83MWJhQllCeC84YUxpTmVIZHBJUUlH?=
 =?utf-8?B?MER6clYvWWQyY0FQMmtlUm5NT1R0Q1IvaGk3cTlYZVN0RGV2ZEVSSkhGZDJX?=
 =?utf-8?B?dm5jNTQ3cDhTOUpBc1NJeEdLRHRsR1FRdHlzeVlVQ3lDWEFzUGlNUU1BdHdp?=
 =?utf-8?B?SXFOendzNTdjVEtqRVRZZTJ1enQyRjJDOHpSNExZeXBRdEMvOTNhaXJKR2k4?=
 =?utf-8?B?R0JrODkyQ0hHK0RSV2d2QjBCYTVQSlZGV3krY1ZBVEhYakdORW0zUlJvbkFP?=
 =?utf-8?B?anhOZTRnSWFBUGFMVkY3dGl2QnVWVitGcStKb2g0d25Nb3grKy9MSXFNWkwy?=
 =?utf-8?B?UHpEV2lqa2NRUU9VRWU5cXcxY1pCK0s1N1g0eWorMXl1M0dZVHlkMTFWZHNB?=
 =?utf-8?B?VXNFcGZNUS9HTHVvbUpuakh1TVk4aVhJdW5hVlhKaitNYWx2emdidEsyVmNv?=
 =?utf-8?B?VVJvbzBWcTNsNWFyWmxaZGFRWlpGRGs2YnpWKzkvUjJHajdZa3BlcVBJemYr?=
 =?utf-8?B?T0JOZUtxcXhZeUt3WTJ4c1VacDMxQ1F2RFJ4SnUxdWtvN21uOHVhbXFtdkhx?=
 =?utf-8?B?QmlHMlZ0MTNUS2lsY1NvT09vaGFvZCttbnpnMWdOUHY5N292ZDJ3OGdnOE9j?=
 =?utf-8?B?cjVUQmZvNXlWU1NBZzZBeUJHSHJQckRWc21YQXBCanErN21nMHk5dEVBd0Fl?=
 =?utf-8?B?akZCV3JmcklWclFUZDV1cDlVOUdYMjRDN25kRkZ3dkNwR09XU1Z4WktMLzJl?=
 =?utf-8?B?YzhndXV3WEdHUWpZVFJScFpmN3JuR2FSWFE2Z1RRMDIvWTFnem0vR0RKNFpL?=
 =?utf-8?B?YS9QbUNSYWN4dWIvMnJtNGFDWnJMa25XRjZzUDYwS3NUZEptNWgxVUI3QU5M?=
 =?utf-8?B?ZnBTekw3MnVrL3FvU2JKRjFmbGxEUFFISHdXT0gvZGpKbW94K254aGJrQ0NF?=
 =?utf-8?B?SitTMmNxNFBybGV2MUhIR0JmWGdSMXdPQmhNUlpjeFZycGJsUG83cWozcy9T?=
 =?utf-8?B?OEJGUE10dW1wNlRmeHozNE9ZQVZkdVZTc2lpbkh5MHliT3ZPU2hzUkhIZVRQ?=
 =?utf-8?B?QTFsVVNJMmJlNXBZY2VxZ2gxVUdweFNkWUZCQ08vYWtEcno4dTVNYStVVVY0?=
 =?utf-8?B?NHh1QUdFamoxdzQvbjk2R2RoME5IY1M2YmVMWDN6U3laVVFOK1BSZDJSWGJy?=
 =?utf-8?B?TFFwbStOcHY3aG5WMkUvdzNBQVpTeENOSGFNVHdRb1hVZm5lUDY1Z3RRa0F1?=
 =?utf-8?B?dFdZZzdkaFA4cm1ITndmd1VIOHJsVU5ORVFiWnBDVnpDV0ZEK0ZhcFB5clNk?=
 =?utf-8?B?SjIwOElFcGM4YnNPVk1IUmZKblpUNlB4cU5vM0dobXpCZ2ZPaS8wQURxem5y?=
 =?utf-8?B?L3pXSjdrU0ppV3BzNExJdkZFQ0F6YldwbVhKUnp5WjhXZlZvVW9ObEF0S3Jw?=
 =?utf-8?B?bEpoR05xMVE3eTFUK3pjWjQyNC9KQStza1lTREV5UXJGMTBtbjhrSzhXOWdL?=
 =?utf-8?B?cVR4a2JvanRjL0swRHZVSUtycHFDalgwQTBCejBJNTJhUTEzSWhzVXRYMDda?=
 =?utf-8?B?ZFgwMUFDSjRIYkNvYTdlOVBOeVZSbWNuMkZBTGhzVG1xUmhCY0ZCemNWSkFO?=
 =?utf-8?B?ODZkY3N3UVltVGxpeld1MFhEclNYNWlHaU9NRlk0SG5PaUJuQnB4OGIrWXp1?=
 =?utf-8?B?Y3ZLMEFoNG0zN2dpUUJsUDVPZUw5N2JYdzRTdXZiQmRhdmt6dGF4MkE0Rlk0?=
 =?utf-8?B?djc1NkZCV0ZSSFF4T1F6NG4waXZWb0pkL0I2c3BYNitWa3JTQm1FQXM2bDcw?=
 =?utf-8?B?aXp1d1dFSlNxM2Y0YkVKamlNOGJ6cUhuTWM2M0hkVXRmWTBWT2xDKzhqL0ND?=
 =?utf-8?B?cE1ta3pmRjBURTNYVzh2U2plYThBSmRLcWNXaG9YaW43c082SXJXVlpWcFpm?=
 =?utf-8?Q?G0rmz/zuaDG+u9ONXhzJABsOQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2488d45-b935-410c-7684-08db7df9c039
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:19:43.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvW+Oo59IP/7gMDnQ5ybAVvmRdKPiiYKfsIe2PqFkosUEZjZ464ka5JLxk8oTbfh05GM94Eon0OLpkkwUlaI7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897
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

v3:
 - patch 8: char cmd[128]; -> char cmd[256];
 Fix build selftests errors:
  /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/mptcp.c:218:2: note: ‘snprintf’ output between 98 and 129 bytes into a destination of size 128

v2:

 - Fix build selftests errors reported by CI:

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79


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


