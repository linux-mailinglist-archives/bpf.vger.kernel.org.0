Return-Path: <bpf+bounces-4168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A0749497
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFCD1C20CCC
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940A910F8;
	Thu,  6 Jul 2023 04:09:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42AED7
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:09:22 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688BD1BCB
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3PMZ+I0UP2pmupyTVdhCjqarvifdsG9JRfRyro47rGVVUkLwbfgmIhPHoc+RTS+0TrDZwuQoC3ngBh5DOSM/Lp5DHNGeiodHxufZI5Up9FJ1iBKJX8If02B2tcipbMn0K9E9/KJZY3kZzaSw2UBqvGb26cG3uIDWZLbqY0SRr1xdgGneGTFI89c1+hGOaFTh0+SBHvt/6wp44DYqY4m2ictojMIlQxqW8bBsVD1v1GCXNNszNQOimWKeNBj9eJJuf7QW7gqIfqvybY8S0VD/eJ+Fonyic19t5yl2rAKlkWOdeN63W+Kn/ekuSkehOlQ2PE0w4wXjKZivFJHqJ4Nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY3Pgk1uh4FXkQ6a+2ml9sNjR4idpzfAMSUu5Wzp0tY=;
 b=icXieuQW1ol7a4sGY2tDvz8i/Tstgea4O3Uq3veqpPFbOYVb4PdLp61zhriK8UI9XtqBkMu738YFUqr59NMGT9ci82GoV++05EJfsyutgy208kZLTdS3MbTD0drPk4ADzQh7UwdXfVcXzcGoRph9yLITM8oomVXxQCvvkUyl6drmDcHO0j19q4TLl7V4SG2T8S2sY6zB8KbPxA99e7v70Dhqa1hagXSumLcFoQlfo4IO+/2Hau8h2tpu3Isj1udVM9KjSSNDT8h2hiqgwbv7SQnStj3Uuofyfu6eIHxGpMBsAZhbAlTHcIUWRT/qfXu3gg5BRJuIhmnTO7b3SAqvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY3Pgk1uh4FXkQ6a+2ml9sNjR4idpzfAMSUu5Wzp0tY=;
 b=cIiFRlodTxi8CbZ5wfU2/pGOAZi7hZQxBu8AMZI7R+fqj5fky5/GstpA+4MDlLsV9/3OANcYSn3xIFmyx+PCTrANBXDAY+seEMjKb3Q1q2csBjEH2D4//6KK+JuzMyd8yrVcSkHr4Z9Y8kUHNcYk8gbJwLqbKRU0CJp6AZW4v9tsZQLcTt8tF4gMGJXGIsBeq3MRtuW137k8fu6tu8glblkZA2/lFr83vgrRPvqYpdRdhSVuqN6QI+tfGNh++kBpROP1SyxzqCZo4pduKqbC38V1JZtkFgJ5RZTWD155EJv5g3YXCZfJCLYxaIn6eOGyDQzfK17e9sdSO4cvDNUZ/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:09:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:09:17 +0000
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
Subject: [RFC bpf-next 3/8] net: socket: run sockinit hooks
Date: Thu,  6 Jul 2023 12:08:47 +0800
Message-Id: <5f76da0bea3453db04bb07399b4b1c9ce4859e31.1688616142.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688616142.git.geliang.tang@suse.com>
References: <cover.1688616142.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 608c740e-f5ba-4537-4ac6-08db7dd6c41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dRSuJYurGFtB/5wXoJdXHEuPtuNXDwZHUjrZvJCklhJ/kmkpmJHV////+6qT2ZDNLDvph4akJHWC66OFPEwkFuzJMtS+gq3+tdr4qiRxTkJk8BGNrRfouPhLL4lQPiKMlzMWQI+YiQanoYvbZlmIqiHBYfRrS41wAOHKXeB6ZIkV/vw3BwMBraJnjAS2YI85DahOcBLMpmf8aGR49ta7G/aQD3gpOcsAg30CKLG5okQUi+k5SFUu2ad4xcg+hep+r6urY+rOohZo0Xecx9q4Rp4eQrrYcTGn2Ip/5Rtmrh6RG1sPpIzLR2HcqsoZGHj2onUl/WqW85H5lokn/AaGBJbt0eNpU+l6hWd/VYDrrpr3m6FZX6/dUmY8k/sTJAcJQ0xNMHmo+Ccfiny7Sd81gxfsE23Tw4JtMpb4cIQnvKp/b6NVk1vxGpkMzAvtgrfH50BbdyhPFLQr/2YPqjuYzNDBVQ9nHWcOoPxhTSFhV6Ap2b+6UaOyNsiIcRfndi/fr1pozxGsz9ZxVg45zdL9OkA6YoyboKXofuHYSz1R2IMQDzvGQGK+k+Cz48/iHYtjlxcsXsborPqlzuBj7sht7N64aaybNyZeC6QON214rG2+ZPhyVCXds5rMw23B/xyK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(38100700002)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(36756003)(6486002)(6512007)(6666004)(110136005)(6506007)(26005)(478600001)(86362001)(41300700001)(8936002)(8676002)(44832011)(4744005)(5660300002)(7416002)(316002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AcBj1x2O1hgkB4Rdc+hIV1R7OQhdvOeu/jh53tSDY2B2sMSAHny/O6q7HKIK?=
 =?us-ascii?Q?r6kEmZv3KeWOTOtOa1dQArNc4bZA8nOvvUWMLG5Cx5KQJ/AMxdg6jjLNQttl?=
 =?us-ascii?Q?2S5NbW/V8cTBwOxGcjjrXnXpxWm/GPq4DtFmDFNedjhb9fVrZ4qg5vCYZ2rU?=
 =?us-ascii?Q?p3SN32SpxUbiNzCMzz8LDgBDra7FAcNGatGipX21LnBGd3g2VUQAaU5OjA0s?=
 =?us-ascii?Q?yy/87pFhi0W4ckiOFERDaQhry4guz+54wMRRepWUt7wb8UiGVnoHgFspuTOA?=
 =?us-ascii?Q?bZBXWRlTtFpHar1yrPxV6iBi6sNqRMugAbb+OX1aNvjSHAMozrB3rSpJVvPp?=
 =?us-ascii?Q?mfBk07p4bswuvIgsJc1DOLpzdWEwdK2HzFbGYhzsdNRXvuVZzyfFpOlrogi0?=
 =?us-ascii?Q?p9I2E3kwQMU0LtMHK8LZ3DzDmavlNJ7r1CqfjRyygsOmI9zkzOvVwZlZY53c?=
 =?us-ascii?Q?Deef6t7kGpAOydpxDIPjeYxeDT7ML2D07y4p/Wzfu8x0oWBHZ2wa9FEoEGU9?=
 =?us-ascii?Q?SD8dBA9Hl8MHPXJ/0LLp3sDiP83zjxRUUO7K7dhHWY3Myc5CE+Y2yTJPh55s?=
 =?us-ascii?Q?8z4n7vL58NBjkx2E75c/0SF77S/sADaONVv8eyFTy7pBw7vjvp6NXEcpwSQ0?=
 =?us-ascii?Q?5+9Obz3TwZSUVkdGFqnwxm5vAX7eB8srYvBDC/ZimVcPbHwfPRt8ex+XUHwS?=
 =?us-ascii?Q?JP6d42BjHL6rf10nsUqZbh4IcNYSVh3bf8FDqKNQBgCR3ej0OHSna6dHoBXU?=
 =?us-ascii?Q?APIJaJedjdtkkVIK/nHPfPTGCU/+I7IhMj4iytB5z28rVvOQ+PIKZX38fX4B?=
 =?us-ascii?Q?4/WCmS+t+qiGKDJTrFzCeSohR6eTyS/VrGsQL9YdTTGSLeWsrU7HuUUqzkyf?=
 =?us-ascii?Q?ILWM7StCTBRAyuX/VLQBjQf202R//CCgRohw3axLda8Ks0ju0tSR/8AQ5R0U?=
 =?us-ascii?Q?3zM7IkS+lBfai8KLh3MGcUWAOvZoWSt+0iDIcNTr6G8e7IWMIwAkxNZ9qT0H?=
 =?us-ascii?Q?99WeQLFz+zuKWDz5KkAH4hf02zPQcZyTCD2w6/vK1UWsSK85/txtApH/koo3?=
 =?us-ascii?Q?blHoiEXBmGsqyJ8bMphPRHHVPOz0SulBm7rcIl++fksizqXOnNH3Zya0OrhR?=
 =?us-ascii?Q?DiAnkWJmdZhBCJVTat0VOrA9huFdkuWA9GK91NCiDP3EGj9w7s0Feyzasu6F?=
 =?us-ascii?Q?Xt7jDz9U7dfUag0XwNPcHehW9EVWrQsKy1f9xpF49j96fJmfSLlVIu19GtFd?=
 =?us-ascii?Q?E/TbTRfy4Img/uBZt2bZ2nHRoAMnoleonvnjd6zLq9PUP9ian6XgTa7joEAZ?=
 =?us-ascii?Q?Y0Lc6zeVRb3NgzFdMuWWOioT2hudph5U3sHhtbEuyaxkWAU0VoDo5k3guRPH?=
 =?us-ascii?Q?ls/Tu5RWApsBZ258niG59ibCfLbpr93GVqEpKOf4swA5wapWL3hSMEGiQB/k?=
 =?us-ascii?Q?y3ePdjInFkvbTqG2AdH9tqRxRuDzwt+v5y4eSd/lODxPDb63VnCuxnCaYQ6L?=
 =?us-ascii?Q?VBxgBbyG7rpItD2sOsKJ+TgnNMHdIB60Bn7OdOu7Ab3KrEqIpPNnoM0+Rqvd?=
 =?us-ascii?Q?WrRX045xGAypVRPqrSORcywuAx0yYEFe4y2vn5Tt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608c740e-f5ba-4537-4ac6-08db7dd6c41d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:09:17.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD22LYQOGSoDzdRnWJZVg2JXORYZPzTwz20g0jGy9nuFBSJiU93WPPsFyjsSMbesd9ZFjN/wUXaWpKfGvp7bdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The arguments of socket() need to be changed sometimes like the MPTCP
case in the next commits.

It's too late to add the BPF hooks in BPF_CGROUP_RUN_PROG_INET_SOCK()
in inet_create(). So this patch invokes BPF_CGROUP_RUN_PROG_SOCKINIT()
in __socket_create() to change the arguments.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..27b423e1800f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1469,6 +1469,12 @@ int __sock_create(struct net *net, int family, int type, int protocol,
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
-- 
2.35.3


