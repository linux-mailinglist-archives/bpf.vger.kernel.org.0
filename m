Return-Path: <bpf+bounces-7805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0C77CBAA
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 13:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3542814C4
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE71118D;
	Tue, 15 Aug 2023 11:28:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B07C15C;
	Tue, 15 Aug 2023 11:28:29 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE01E73;
	Tue, 15 Aug 2023 04:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFaY//nJ5OjVPctUe3QO7WMYnS4xhjSljJdhsvJjPIaBsu83/hi1zYXu6UsCSC37jSSyIfUjH5DF3J7ANysivYqfQtBDJBGva8h91Q58bf8lvDKr/SmhiVxJ1+5DeVHNWCwju6KaG6F3z8Ua+W5DRaftraSGy7X00M6bLMLBbgdcmX0vCFNyfyKqWc8Dz+6JDvlB9a/FJnKTqVZuhsj5G3+W8KlZ5vTdtV4jTxo1zXUyb/u1855c0kEbz1syvTG1ugHWzJaSz0NeOJIBrsft8Fegp3tzdabfaQMQFbKaczRVntMnmTfUWlhiKlmpVhR0gaiHEm5JKzOf6BvPvAd9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+wtIhdarff3SuqCWbE8XbzFrXnyshQpYbPYXQZiSDk=;
 b=nwKV9/NUqAiTWplDC69F+Szn0qcQME7/ZZgHKHSsE1d3lyaMJScWTQYJOADLGLZFb38NMWOssp54UlmBYaVVjiuib7QzORRiD8L4l6QjxROGHIKadpdcSsQ3E3quVonkEJQEGAzfNCk59JOSUO4iEMyOzPUBv1+hJPtJxBL61/n4C0spm0ZWhy51OXcC618qFTpx8ET/V4kxH9YC3gyFo8YJKYZy97HgHA+vNNmFRsEDYvJ+DdkqNs5kviMYD2N9E4aVnWAHepdTbxfbwCH8oTZQGM6FFv002w31TOfW78XGDI3b7OJTbt/fUyse0mb+nyMTNPvZE4pIQiv5670ScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+wtIhdarff3SuqCWbE8XbzFrXnyshQpYbPYXQZiSDk=;
 b=XKyOR3MInfFmi6DpKKRP0tlN9zrj6w3yKdZizxlWAiyjf9U0hY64pxaMhZ0cQPlycCkABrefQqnAZffprKVbmXJC8bLaq694oV5yYGBnUtTyXGLXK1xn/lqrtLYENBN8cyN3w6ObtLcOCp88DF6t0HCh91w94anlCDnoF1fYpgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB9082.eurprd04.prod.outlook.com (2603:10a6:10:2f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Tue, 15 Aug
 2023 11:28:25 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 11:28:25 +0000
Date: Tue, 15 Aug 2023 14:28:21 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
	edumazet@google.com, jiri@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in unix_release
Message-ID: <20230815112821.vs7nvsgmncv6zfbw@skbuf>
References: <0000000000008a1fbb0602d4088a@google.com>
 <20230814160303.41b383b0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814160303.41b383b0@kernel.org>
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3295f0-8786-4ab9-34d5-08db9d82bd6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A14t4Sf3vhfkohWn1HDj2+0QaYH0d8LDYYfNtVyO02c5WzWEpsTMmoAGyfjUHs4Qd7UeMDnIJm09N4i9CLMen3CFPapYTHRytPUFxBiko9f8ykUp0Pn9SOz17XJtCpX2VCfqBiyvlX5EFyuwQiRbmJIDXKnem2q7iJPOYlQG71mVy6Gkena4IdNzheEyyj8ot5Kk42B9AI87RJtWtx1u3Nt9pDeI//PH3Kjh0DKc8ujgbxFuoLwvF0Gb3yIaNwYyENp51mjN751B1FSgHHvFAfpeh+w6BJmrydyLlDnU7mM7eOX1H61vnmwt5FzLxa35vxGBdAnrr3lCP/+h7gRhkoDAf6OQoUp6m/Dv2Gp0lXRZeN+7qb1/Ll1a84xxp0VQmVZeJydpUF3XVb0SqWYBBpcYaBOguS3spIBAbIjML8H/tDmRn2nIRvQpfqvDbeA6NNUzAQiK4eADpHCXe2IVpuOFFsvNDO/X/jqAq48JKKO0ixLov+S4ai+7hImZsxpPRCmqXSH06KdAYdwML2BhK39DwcPtNuDj1wR4YtBu9qTsDHXWIihiujCTiH5M2/Nz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230029)(7916004)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199022)(1800799007)(186007)(6506007)(66946007)(41300700001)(8936002)(316002)(8676002)(66476007)(9686003)(6512007)(1076003)(26005)(478600001)(6486002)(44832011)(38100700002)(2906002)(33716001)(558084003)(66556008)(4326008)(6916009)(6666004)(7416002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eEV6Nq3PxB6usrxYaD1gZzBizuEDdO++e3xsdbfT3/M47AeESnB2WCRHfa3g?=
 =?us-ascii?Q?nK8JIeBwZszLvjQTOSpYrrtaSLSOSAuac7QSlulbp6ci95jclSbHEpSQOWMf?=
 =?us-ascii?Q?Bw1wCpeMYL/NRHiAaNutQYQPypV7DzAAYhgOC6rumm3Qb0Qk3KNFgiT5Tqdj?=
 =?us-ascii?Q?BaEnGYPLHa9PR646N9rVk23ersEIGqN06SK13mWgS6Y4/AcJlSPYbPmsXArb?=
 =?us-ascii?Q?bUuJYABhBQKRw8lFqhE+8zZBSdvc2xDKNJ47XVJ37/ciILFfS92G6OPvRzUf?=
 =?us-ascii?Q?90QLlC8seni3YKAdJr72CJnsgba0GuLoRqNYi+Yq7UYiu+NMlS+HvsIQMTTm?=
 =?us-ascii?Q?ve8ktk43OPgEKJKOMQ1L0uLbT4GlaCY2YykKq4smdOsasBsGBWZy6z1xRGB+?=
 =?us-ascii?Q?NF3J5TCKKmp4/8o3qcT1X3x2C8nwsUsgy+vTy+8eRTWqY5Ab+eKI9zaxzqCI?=
 =?us-ascii?Q?OjV/GePJwZCQXSE9+Ols9J3LZf9LlSJGOaUbyXMz3OwWyAx0GdNgoIrtb4I8?=
 =?us-ascii?Q?6IKih600dlWXzeOZLklI0nSvFhb+lgdqxFWuxf5zv71TAPpdph9dt4EYIe+w?=
 =?us-ascii?Q?vd8cTbTALL+gxRDuoT6FOqwgI3zoEbHJE8mLMrxzzgkMMVIdvaA9WyVM/i1C?=
 =?us-ascii?Q?LdGB1qAkgKvAgNfAY+Tatv7trImMC1qfcyNwATWk+CsFl6JmTF/0wHqZnL60?=
 =?us-ascii?Q?wnlRpQvklc59X0XlfVWATTJ8l5c25pE5b4eXcFp3Y0KmUkACzumDN7QuU0yg?=
 =?us-ascii?Q?x7swcNaZoZ2zomFIqUi3ZA8wv76uSBFBrW7hRqHbyZ0fqHfhamU+QBTsIeMD?=
 =?us-ascii?Q?e0fzPTfESFAce1s6Sq5Yb3Tt+2d0vXnJXbfcm+Z89wrRk0CLMD6eWbxAnBct?=
 =?us-ascii?Q?UJauaj/mRcbVlcAM6D1Tx3xkC68DjlIy8FpKIdY48CWjfXj/ocmlDhGuMcue?=
 =?us-ascii?Q?wGIa1ZUQTu8bjBhFgD9dz00hWXlHC7Oy+stdDlSQwz7HHInckDeabCrbm05d?=
 =?us-ascii?Q?Didd321zYpPcjSg+3HoNl0x28aVXO2xjl0KYxySjWsfdCPoCTIdPEs/yB5XQ?=
 =?us-ascii?Q?Lr0pN0R8k9RcsV3Vu9gf+kVmziIyHhypKupKKlstA8g8zBHmpsPpwsJmhQqf?=
 =?us-ascii?Q?4/2IKYGdCnwFmUuZczAFb1ovWjCbsMqx4FPBcSt11e2MExSwXERbMckLxqrz?=
 =?us-ascii?Q?g4KWZPSlMMSuSIFAUbbUvh7BNTE6klzrFrcVuNCAtagcsELZt1LEJvS9KiX4?=
 =?us-ascii?Q?mpdonkvpULfjn3hcXJ9/Nx2hMsfjDVrovayizpCja8VIwR4JC/HuZ9r6b8ut?=
 =?us-ascii?Q?HPUbAigRv7SCLpHZax767Qq8/p1+xhA/PfCvA9LN1cG75K9uRa4ybaN9gVHV?=
 =?us-ascii?Q?4J7ZVLynJ4pN2g2bKejkkgA5JlUiwA4UoTQ5bfysyaBnuSp3Pj/+lxWOYsgo?=
 =?us-ascii?Q?JI2w3eDv1z7AN5Bk2oV4aiuobGgujpAA255QCL91aiSG1xscNF1dpkRAfsxW?=
 =?us-ascii?Q?fm47rAFDoWiezJ3lyrkcIZU9AyeWov2RoSNF18+NKJxnuZEckCk6usO2VSn+?=
 =?us-ascii?Q?YjNsGHUXARBVl3BzUnO4uPWQBB89RpkqT68B9mAlGabHajh7KQfuBOndzE/5?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3295f0-8786-4ab9-34d5-08db9d82bd6e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:28:25.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85DYmIYsqY8U/7g+sglQssWNIqZfsqvgREP6uXxF7l/mbUCE6ej+oCXQgzEQp5+sCW1rehGuHpuhT/Iq9h7JXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 04:03:03PM -0700, Jakub Kicinski wrote:
> Hi Vladimir, any ideas for this one?
> The bisection looks pooped, FWIW, looks like a taprio inf loop.

I'm looking into it.

