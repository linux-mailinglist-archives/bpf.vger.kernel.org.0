Return-Path: <bpf+bounces-5924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C7D7631E8
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452D4281CF1
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0487DBA3B;
	Wed, 26 Jul 2023 09:25:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D97AD37
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:25:54 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D8E12C
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 02:25:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8622N010840
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=FhQOSZXTLUEV88HHxrzdUoDFoxFn9UoTf08u4lbxp7E=;
 b=zWi1x/FFATAToWz47HO6eaXLFhRfG0mcQ76+xkQbCFEJckNOsUZg5vs7r0YODxC8b5Dj
 /Ds+8cczb9skZvklxV9oLe1EjrHBZMkZOmjLLqOZOqlkbCaTaKKPwck/J6qMQH6oQsfy
 RDdujInrmkI3bTAOEgnraCtH0Sdq/rIlkZnpQaRZgbeYLJmbfHOLEwBvnXHfaPDJpYN4
 pgF4C7a/o/29UvsB0C/BT0f/0Qx4vwRBVXg1rx2KzosWMkZ9zR4PQAC4l7RHuMBfGbMJ
 ypxfl50EH/RIpnJRO9TrMV7PqwtlxheVvV5Dml4SXM8tsV3IeFbl89w+hZcSzFFOjqIF iA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nupyja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:25:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8467F011841
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:25:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j674sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD8+JQn6EvicGZQngAnhFoXOAkZu2AY8SGWuWgAeoNkluy/r11ZfQrbxAsIwMvvJCGO4iuAo9Xio6+UVgR7c2qtn7JXflgHkrrrrmaZ//YHtIAJfJxPDzOxnbYzWLg7bf3ztnKlrLbOyc1/TSx5jr+nfmReKwbhzHEB+MjyX3ZwOHs71iDcQZc2A/6S4r6acy+i8ursWi9QH7+hdaZ1FX3evKlBOAOXlw0wWO+3kz/tIVPsCdIUIybfH21iTdXC23qO+cm8JNm3gYP0PITpt9HHdcHmuakM7J+HQf27SWLYas31+eNaVw/eMU41JsJd1XiQZ7SWOjlXmfnx1pyrRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhQOSZXTLUEV88HHxrzdUoDFoxFn9UoTf08u4lbxp7E=;
 b=RwaZgaXZ87cthH6u1/HoJMDnjsyq3yZC4V9RukaHh+F6wnpFill+ZtKoOmBmQX19550KgiZGQEz3RAboVIi95ibeFqmqcFfysswmgTe0qXKJdkJZ6H2RAZNgK4GUwhGdxHPufLXUrQ32O87rl7lAHbHuVdVO4r8k9AY7Eol0u3/rl6xPiRTYfK98qJlVxy9K4PHPzPUVmOtODPaef2jvm3eTxVVKZCQon+rdX9H5zE/Hm5xrdgSqcyxYXBhS4Wqu4DFqi34212Bmyxj3PjSZXLTHsq8hrtne3sd2VG1ZXtrfjAWvxrHCXKRRkM1l+sADUEOz57FiZi09hpPFL9t+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhQOSZXTLUEV88HHxrzdUoDFoxFn9UoTf08u4lbxp7E=;
 b=AcybNqBE2cdhdl7WI+ThIk3fQRPyV11dMcCwEeqd0+9sArDfNurbvGH9FBU3zYGDrWDhAIHaqt7Y0ZpmtmAR0A+oZFeR1pRqzSVOxh2cOj/ofPKP4xhqQfVP4S+ojHssLbqWpJqYTPsXICrHOQIZxGfZpuSvkdlGW1DiaN3qzBY=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CY5PR10MB6072.namprd10.prod.outlook.com (2603:10b6:930:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 26 Jul
 2023 09:25:48 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 09:25:48 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Subject: [PATCH] bpf, docs: fix BPF_NEG entry in instruction-set.rst
Date: Wed, 26 Jul 2023 11:25:43 +0200
Message-Id: <20230726092543.6362-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::6) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CY5PR10MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e1d1dc-8955-4561-2a7c-08db8dba4c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/fYkmjQd028tBwkI46Yexmc1NJ4ZOaUpVInztx/ZYkkfKTtTMxcFbXlHWf9Nwy0FDaGszU1mOnkf2BopN95Dmr8iFcR5RkI1ks5gbF9PmG//VdvzsA9r4gQl9eigHSAJAxp6mZammEQDgyFEOxJBymRmRjA9m0baGiWNUDBopLDzezCRfR0jrE1ilgRRHGvCWKSO/Q5NvtdG/vLUk2jNGi24q3mRXDekdeDT4gJXggK+LkS0in5nMcmTqqxnzQ5urdk2CCgzYyfuzaQxTcAoMk+tQyC9N7dmdP9UWukhXfRix9++Q+5d1OyPlIl/haACw1ewCmAdddfOX+x55DrzkxjFTqLzQhS1i3g3h2nKzzO2y9PtvSEXBLTIv5QVSYyn93LM7Ujpm3fmZtRAQGKKIaRk/ZakCeZ7T++mo5FX1CXMdYj3UHA4RCgiRA7dAFRvl2dguJuwi6W0ZDqUCvF/vQik5H3md39arKGMREIgtk38dkrxyXDkBQUbbmiebaP1sP1igqTm+adm1YUF1Z0lqV9PWaxVbdRRu7ooOkKK0WLfnmnbaZMI6lQ9H+yMvlbq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(26005)(1076003)(6506007)(186003)(36756003)(4744005)(2906002)(83380400001)(2616005)(86362001)(6512007)(6486002)(6666004)(5660300002)(8936002)(8676002)(478600001)(41300700001)(66476007)(6916009)(66556008)(66946007)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K/X/2Am8XGlRtsOHt1gHpTTCE4xnR+pyvl54b8hd4ESjMl/rubq+ieMwp2/Q?=
 =?us-ascii?Q?wdsZM2Vs5USMPoAxxVW1BUiFqplCUx4XEbZUoGhCGzzOiW9mCMO9Gq8e/mRI?=
 =?us-ascii?Q?I/tpRGP9UeKNfFyAm2MIqyoUTqVLWlIjFUtgAgfL6FQ3J6d0twtf4AbpKBgw?=
 =?us-ascii?Q?oWpBnQDSEYmvy5uU6ChRAy2C81+5mR2Hi0w/5dsi4LexFBGFVWn1yAiMxztO?=
 =?us-ascii?Q?e1fDJuLXVWf5RE4a1xKOi7s1+halRA0r5nvQ5u6vzSik+Ua3QKTV60X5yCRp?=
 =?us-ascii?Q?tBj418KiiZ9MJLiJUVRoQIcyNwIdHGvjl755ob/v0wT6/JdYgfo6yRnkbgv6?=
 =?us-ascii?Q?sXXJzew7SqtkM4+Rno75WHh7UaQpVIZLEX+LFpLm46XCMXnTbhHOths9I8tX?=
 =?us-ascii?Q?4qRYykzU8oktHsAzN5YiRh/JfSNeLZn9wOcXJN8XTRemnndS+uslRWB5Ajof?=
 =?us-ascii?Q?cok1O6blnUlY54+bpn1gltukrCiJ5yTeHKLbEw/u6kzKvkAp6H+QM1nhPlmL?=
 =?us-ascii?Q?+P2syeON8XgCEtOvTms/H5TPFSzUtk1axErHb5ztjA5kxhE7uvGMM8CHC5sr?=
 =?us-ascii?Q?JgrIkD+gA6ZcNcPp36JJTPkhYsBc2ADDzPkTMEW4BFPxg56q8mygXRi32ax1?=
 =?us-ascii?Q?S121qMAtQI+/1iDGlh2Odcfd4OLBmPQwVLztPzNPz6sOPKo09X40KpoE5clT?=
 =?us-ascii?Q?4T9ILtCMpq3CfTjJt8Xue+i5N/25Kx0uyV+YZiGuqKh/LTCXMqllBshhPHWQ?=
 =?us-ascii?Q?ne8536fWnPTz0Z3NRSG8zRC4qrOwj68zVr9w53I5vQ83dfJyfhFMkvaaSUpu?=
 =?us-ascii?Q?ebJjVreYq93CVrG5J4ZQRWScVdoQwLoX/xSnF2JLHwvkeULLfwK9IkQmH1rI?=
 =?us-ascii?Q?VR/48M+LFNPo8SQZraIv3PLfjiE8CioSvCMaX7L8qgF3ZK6i1jD2VXKiQPVn?=
 =?us-ascii?Q?0s2GoXDD1rCQPuQNXtASvIJrRUtUASoxa3XEDrhp25h7vKQd4RSgLjKteSls?=
 =?us-ascii?Q?RQMqQGRIcorSHI8U97HVj2yAU/OrMGHJyGaHrLu72Qnh1UdVIAIG2P6NBg0K?=
 =?us-ascii?Q?RNtHEzkQ8kvcesY6LTuhOwts8YDYVgNnOHHnoXO4Xu/60Xnh1jrK7X2bbeE6?=
 =?us-ascii?Q?bkmhrOXe7jCn7xLFEFpaCd5ZXDZL1TCX/ChBpuVf1kQdM2MDVkPpeEt3PH84?=
 =?us-ascii?Q?0WHM/kyA7UTM48YXKbWgAoXXuVqY8p5PFdXphRbdTPFq7vuTAdR3dZ0GsyBC?=
 =?us-ascii?Q?zrwuqkL+mDw/WEeh/hK7UI6oog+jXLsnQZUYcWp9AS3TQCvGGGjXdP+xroZ6?=
 =?us-ascii?Q?jvtYl7nkeaVVe2hLnZKE7Bn3pkFA06EArwPVPaHv0WERKQUChDZwg1yxrtUc?=
 =?us-ascii?Q?K4qReQuj7egQwmvPN9IAzmwzXigtsSZvkCHRNwl5UOsOfgPzebw1/epjjvIh?=
 =?us-ascii?Q?dyJ6A2lBKHzi0nKDbqTyUNVGKUlF93Na8MCCau73bIIU3u1FlDqdURc494r+?=
 =?us-ascii?Q?UJifEmtF4PHcjSn7pRhnx5aOmt9rFJBPpkMb6n3PzJHB5NSPjRTEjvKZML4k?=
 =?us-ascii?Q?rJcUW3ROleX3LbxVcpAg6qrv5JCdoirKSfpWDr8RYau+mLXEJUHLBKlJZRlL?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	12pkExwQsdll1KWWe59NAddWH7juoyGtATLiPvUoihpgC0ENd0az0S1Iz8fUj3GH2f6IUlUy9bJZ7L62BSOpCK3lJyu4mRe6iW7iLUiuh7B2Qkz+NdnSTBSasDUfiSwl451mt/+aaeyTP8jnqS7scJpNd5hgSmjjpEA8m0Lr/36AQJg/cJl4lSZGbMJye5yWDwVBg+G0fwHQB9D0d1ylh5YkKbNxrJfe12Lc2BwsCYmAidMa1Aa2VsECFgaMyizZ73QTZNtY/BloC1akqzulltfmJjVAuLuuQBL/Kqwnc39r+0x88eQaW1PCw0SU/VvVZgmPNE6/F5baOoC5VOJDvpzoXj1LohgPqPVUzZr3FMcan4Nl15TPNbwLIsdESO6i7E7Zmqj8E/7DSHlY1BD3IXf0UdfQAe8CQqoeE3Mm5ZYIuLXIQPK3FNDyyU0wj5f6zIpGGgEBnS8bJxbLrHqXlDO4WcczMUBt9YT6bKvFwbBHq+Y6polPRmKrr+5nf5jfaz95tgQB60ly5QMVBbwPI9BV1Kl6GG1X0fA7c6vkhGdbZD9OW8Dgzxps4PL7RIVsQQ4GCuO4T0diKSk66Y9z8BnyjxPMXxTHtlDd8yjhUcNgLtIavdklIgPPqkZvQeHsdQwPcvb0DMA4+2OeKB+lhpj/5pbHOvg2tBVCYGvynb92MvQ178P6HxfMwDosmaOZnEGeKZqNcBFAtCGtd4WsIu5BePNgy5j2T+6NVvYRhdyhw4eYtf+zL4nxwRYaQS9tz9oepOWQTj9uMP4dPV/0xg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e1d1dc-8955-4561-2a7c-08db8dba4c2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 09:25:48.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAG2zZ65WTeiDaiaj3g1LsbTYkvcCJVBbinhHyiIRyTeHVk28FSPTbkw/84iJEhMe7UcvymKXMc3xrq1UmjPd3/iMuZweyH669LRmIKK4+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_03,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=970 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260083
X-Proofpoint-ORIG-GUID: _lNGooG-TTFYar84_r16vepZMqvV5HOH
X-Proofpoint-GUID: _lNGooG-TTFYar84_r16vepZMqvV5HOH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch fixes the documentation of the BPF_NEG instruction to
denote that it does not use the source register operand.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 751e657973f0..6ef5534b410a 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -165,7 +165,7 @@ BPF_OR    0x40   dst \|= src
 BPF_AND   0x50   dst &= src
 BPF_LSH   0x60   dst <<= (src & mask)
 BPF_RSH   0x70   dst >>= (src & mask)
-BPF_NEG   0x80   dst = -src
+BPF_NEG   0x80   dst = -dst
 BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
 BPF_XOR   0xa0   dst ^= src
 BPF_MOV   0xb0   dst = src
-- 
2.30.2


