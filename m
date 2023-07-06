Return-Path: <bpf+bounces-4184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62867496BA
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CA628124D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2315AF;
	Thu,  6 Jul 2023 07:47:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE8139A
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:47:40 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB01BDC
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnt6VKD1dmzpObP8JTs/einCDtL91ecFSewF7Gi+yDjd3w/aBQwsAFQtzIZu2RkT6DxLKMWztQpKJZtEOyhQPiZ2Opsw14plWwtMnrE4Af23Im+V+8x6iF85DQdL56q61eDJroThqFhr6xgGsL2GpkbryJJfKRmbhTK/cxjY5iq6u2BtQlzsmelxN3YkbBDyStGRkbaZ6lvwZ+BrLCqtgWVoeYH0KUCohKVevbLMeJXSfXVwGQ66z2nFg+D20uMKUo2G2W4AMVMKyt7NOE2x+644HgODUFl8CWdSMD9TRvP6LOn9+ovkci8HXJB/NKLqO5mKgeLvxLAPufHp1h02Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9am9MFrskc8XHyAsmHYxGp0omd3hW+Q7MCO/QA9uKE=;
 b=krwIXDrrt0ANeVU822sGLPF+Npl1SXNPmo7nXwqLfAbCTAoBues+nGqikRqOcE9g3/a9EinOEndzsLuiEooGn1+bsiuzGi5OdKzjOuNKoEs0hgtjjhM7oe/NGKyD1izQn6iE8/LlGiFjEnh3VgfyHPzyesCzTzV774bAqx7Zwjhjkg7vd7DmyX1ObXWs8vmJvBY3RGebP0cpl8dfTXLIRdG/79+hYonRoFBdECvLq5dh5EIgVEwZvW4S2KhzEPCb7nlLkbePTa26gqsn4pSW2onr6Lix1/01otxULeUNAsXQE2zFyOEqsBAhesnu+bDzdViXuygBJEz8IIyuSKPLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9am9MFrskc8XHyAsmHYxGp0omd3hW+Q7MCO/QA9uKE=;
 b=V+jXlzE+fjdTrUKZacKbak6qg74hqIALiK0vM2byp6KJhqY5FWAXabxhM+i6flHSm5bFQi9rYMJONHUrb7qapceKwLFT3C/Q5eA2SpT+P21I/Go0JDZy0uhC+RdATQDzTCzfkUtzGXrQu7UQznU6nhA/1/xKBOgbzhogMpcxqbTKwY1tqnU6VprdSQnyiGQ1Hc4cJEP5sqOZDqBmIqDvmVpAwLrHca/fP5sNYO7A3fnw/DtcR3jaImCdlD0OVBQI1nmcz5Mfmbuaoz/szpU6yI1UXi7cmgaZMcRkxhYj9CEIVVx/O7t0iz2lYYUOVjPvfyiYSMfiVlQ5VAPdqdpFZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:47:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:47:34 +0000
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
Subject: [RFC bpf-next v2 0/8] BPF 'force to MPTCP'
Date: Thu,  6 Jul 2023 15:47:24 +0800
Message-Id: <cover.1688629124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: ff45d070-3fb5-4bed-d6d0-08db7df5428a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uf3Vf5yJY7jaTieBf0WeWm8+FCdOS2Zsz9PhfSwNopE73q0gzN8KFpPUxlGyhy6lDoV8wzYCqaoQ9gW8CbJ494/jmd5Yj3m8HuzEQx6ehel5mXkAB2aPFyevkvar+px9CchjsH9EDvgQXguGNZubJyhiISbEA/npC5Gf+++W3U2+TmrOYKa5bXFiqvsitkYirG3Hya3PetUQGSA1bWpypV6RkL0pap112Vs30x7YXSXzv77Ee+wGOVcB9zCj2X0GgmlA9LRTw1p/NEhB3zwUkSFjKXvaK4ArG+GMGWzGJ0Gd86aUdXpDQwoNjqzLc3z0VhoO8n9ZLJ9j4aq76RqRouZrj6tqDSX3UAbhVqbH80owLnGrbu2T3Df9zrCW25AmWjF37c4pyhgYuqJFRSHrFnt/8uVSw5czlvd9LT+MW5pIJts/JzNZsZOgWAkH3MEMCfU4EU73ly1FEV1x93UqIq9I95RIsIOpGiu+C9MTUt7KWng57Yd+WjD50keS/acemlTPsTDn6/XiUppfXIiymbBXaSQrx+Tb8xshT59hVDH21gWG4BJpbDFTTgsBnNyAQRtDnkdR39AYA8AALdS7pACPh1UkgL/cgRIy4DtxXJyUftd1oRU5X4sWUOL/6r2udpiHXL+4dPfAYeCfqTTFJHc8+S/CzYuXvvtcAXTe8Cs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(6666004)(41300700001)(7416002)(5660300002)(110136005)(36756003)(2906002)(44832011)(8936002)(316002)(8676002)(6486002)(66476007)(66946007)(4326008)(66556008)(6512007)(478600001)(86362001)(38100700002)(186003)(2616005)(921005)(83380400001)(966005)(26005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3hJQUhpU3ZiTnRWZFcwOVdMcUlhd3V2dTNOZWpZcTlnckxkYmJqcU52SlVj?=
 =?utf-8?B?QmtvemxYWCtGZ1c1ajArbTV3QnpjQUdYYTVTM0FVNFRrUnN1ckUzT0dRMWl3?=
 =?utf-8?B?T2lPbzZOdCtCR3MvK21yYW8rZ01zdHlwR3BXSWlidVREbVZMSyttNGZnQ1hO?=
 =?utf-8?B?SU43ZWpOazZaeVFoSTNCc2J5ZEl6TllOZHJRYmRmaTY3Tzc4TzlQeWM1cXlT?=
 =?utf-8?B?NTdwalZNYUVKOGJJbEdJbHF3a1JhWk1VdFBxa0dsSHFWQUh1cFhkNmtMQWpM?=
 =?utf-8?B?N3dWem0vVEFXQy94UmwyZWRWK1ZaUGluS05BallsUEMwQSsxbWN6bXkxTTN2?=
 =?utf-8?B?MWFnbDVOanJZMEVybnVqcXhHOE1hUDlHRUxNY2R4bElJSmQ0ODZqWEJxZzFC?=
 =?utf-8?B?NmxybDFwbDdpTUFKQWhBdHFld3AyTW5BY3QxY3kxU2k4TnRoV3VwdmNqcjVk?=
 =?utf-8?B?RVBnNllUN0ZpTFREem1TN2Uvc1dFcEtaQk5DNi9FQzZEdy9iVWV6d3NVa2gv?=
 =?utf-8?B?aGEzTDV3b0g5VXFmcnhOd1BBWUV3a0IzT3ZFaTlWVWwrbE91dGZGQnBoTkVM?=
 =?utf-8?B?RFpDc2w1VDVjTHdxK1ZOV1FxNE94T3VIU1B4dU1DS3RqMmZpbWJXM2Y2RUQx?=
 =?utf-8?B?bEV1MXhzMEpSREVTanUreGwwTzVlSE9mNi9wb0ZDWUZjL0VUOUp2c0lkbGJj?=
 =?utf-8?B?V05KUXBNM3FyM3pKN3ErZHlBWXZSVE5RcEFNQjU2NERTUEdjUnRxSEJaVFZS?=
 =?utf-8?B?Z2xCK1hJcEVFZFFGMmRFNkpLZVJaWU1VTUxpaUdyVkZOWERmODhGT3RvbXkw?=
 =?utf-8?B?ZUMzbVo4Y3F4elBKblNaYmVVK3NVZnRGNzdoK2txbHlhOWg3Vml6RmJKdVN4?=
 =?utf-8?B?clFJRUJZLzhETTFXOVdXK0pCdHp5V1hhZ2dDODZDemgwdnFNV0pKOFFrZjVM?=
 =?utf-8?B?R2hjZm9ybnBxSVNmMWwrSG1tNlk0U1VNYmJUSVAwYSt4ZEkydnhvYW1kWTRJ?=
 =?utf-8?B?aDd1bVhCUk96UUh4NmZGQ3V2bkVZNm1vaHpyUzdKS3lyZ3hwNDBHV05YeTQy?=
 =?utf-8?B?Zmw4NmpOV1JLYW5GNlVCRDVpVU5WaHBhVXY2SENqNHNlOGxaZGpvMjBNd1Z0?=
 =?utf-8?B?Skl0R0JncWNQVjF4ZDJrNG52ZDh1SWVFUzF3Undka3U0VUpzcTdCUFN5VEl2?=
 =?utf-8?B?TkVWSW5pakEvckVHMHRvNlc3UTdjVVVaY09kaEtYU1ZTSVFzTmZZT0pTc252?=
 =?utf-8?B?b0ordTNoRytna0lFbnp5QkUwZmMvTStTMnhnZDlRTlUrbkZRRHR5d0s1M2Rp?=
 =?utf-8?B?bkJvVHZ3T2hQc1lNY3d3KytuditKTWE2MURIZXdhTDBCczBqNGVDd0d3TFRw?=
 =?utf-8?B?MFhLRTl4WGNBRWlsSnk3RElTNlpCdmxZbDZMdXRBWHY4QjlLcitKQzVPdzZi?=
 =?utf-8?B?bFI0bzhtMGpuMVBDZ0FWUUJWQ0ZTUDdsclFLUXE2SUpFK0t2L3BlczFwVkdQ?=
 =?utf-8?B?SFEyK3FDRHNJNnMvb1RJKzJwQWFtS3pWdlIzUWloR09UTVRtTUFGVW5lZHFI?=
 =?utf-8?B?RUszaFFYcUtyYXB0NDloQ0J0WG41VVh2ZDZuWThKektKd3ZVaERWM1pRM3ow?=
 =?utf-8?B?dlFNOEp5ckcxcjVxZVcwZUcvcFhFMXlSYThwSWVMNGpSUzNWcWxJZzJXejBI?=
 =?utf-8?B?ZlhmNU4yM2l1VTJCT3ZOL21tM2JIWWpKRzNaazlRSWJScER2SUc0MXdkQUVU?=
 =?utf-8?B?V2VJbTlEUDFWUWZBRVFEVDJZZW5KcjVhRkw3RklQWWI0ZmI2QjRRaTNRM2Q5?=
 =?utf-8?B?SnBIQVBhK2hxeHIweHNqZ29VVHNaRHRneXNwNTFQNnQ1QlppZk1TM0MrQk1P?=
 =?utf-8?B?Lzh4eWtDWVhicDRPeWJJM08vWFkvQUYvLzZVTVRxbkx4eDF3cmlYYTRRR1p4?=
 =?utf-8?B?ZnZJSmpCaHNJOVZYeDRlVmR3WWw3RGpDVTlDL3JETlRwbVM1YVYycDQzandy?=
 =?utf-8?B?VWxFYWViM3hyQUhBWGFsV1JNSTY2KzZJMEJyeDVBb3BFQzFoNi9kZWRaVmxj?=
 =?utf-8?B?Tm5talFIaWl4aXA1S2huZE1jVk9BSWZ3Mkd3Z3RFZ0I2UGJBc0Nja28ycHRm?=
 =?utf-8?Q?QYx28Upg753Z5mgdqcAxzdRCc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff45d070-3fb5-4bed-d6d0-08db7df5428a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:47:34.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CbciAkroLyRhcrNcRJ8r0yHMWet4cEgYkl77tjRdRJmlTQwsAHgnspuzV5zvZGEtF8dHQSdfmLZFFf/FSHXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
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

v2:

 - Fix build selftests errors reported by CI:

     /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/mptcp.c:218:2: note: ‘snprintf’ output between 102 and 133 bytes into a destination of size 128
    218 |  snprintf(cmd, sizeof(cmd),
        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
    219 |    "ip netns exec %s nstat -asz MPTcpExtMPCapableSYNACKRX | \
        |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    220 |    awk 'NR==1 {next} {print $2}' | \
        |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    221 |    grep -q 1", NS_TEST);
        |    ~~~~~~~~~~~~~~~~~~~~

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


