Return-Path: <bpf+bounces-7966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777FD77F1AE
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 10:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E7D1C212D8
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEE2DDC1;
	Thu, 17 Aug 2023 08:01:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C74CA58
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:01:19 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B5BA6
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:01:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H2mXDX028527;
	Thu, 17 Aug 2023 08:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-03-30;
 bh=0gz8YdKG52LqGvZHqM6n6UdxLOlGk1W+6PFgJAQYlus=;
 b=06QCf6zqBjRtZr44QalYihuJtoyA6KGqvNgQjsN0nFaiCkqfXpA57sEoHFCP3chdcEdU
 qTz6AD731IJk6Z0kJ4I/bi1axHK8xC/uZ4fwO1b1rBh9YDKzZM2jkaVZc8T1h11jIrLK
 7RaAj6obv7mq/GlLJWq9E1VpKugHEydsiHCKQdDwvJpDO+dXS9ASJ9rrVzkJ+eSAdF11
 vYZc2v9uviTwDd8PAOjrxpIA14SmuZ0S/QZtL3Hx4ikoIv+7GIHWM9QWbFPg5JEmBD0b
 GfHP8s4DK8ibOna5JUYNQhHAGpO8+UFzf0JbrJlukHo7yBw0u49s0zBVhZSPahaHkTHM Aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c8tn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Aug 2023 08:01:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37H80TZ7003759;
	Thu, 17 Aug 2023 08:01:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexyma03q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Aug 2023 08:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4FaT4FBp97cjZk2L5XM+l7NKiJSuShZUOtHeqOnqYn6+sFCUgv2YfDyHcJqCVD0elbvd2JdAgHtCL3d1tOQ9GydEwmfe/L7OInl9vgLX50ORd2UIVkQs5tCeaUuVbLTPBv7/iLfW4YvxDU1TpebOhN9+7E7END0dCnAJjeIjfzBRaPrs+itkhL6QhursD3Vb3Y0E//1KR9geMrGihNrq/VHcughTbyqvlXl5I4JkmrPvPYEuHZcSCthObE+E6a9jQVb7s4E/17E3I7uRHJpSJx8PkwP3VAUzVyejnETgbevb9j9qSjmYhnneO5c9N4taYby3YV74Z7HoDKm5VF86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gz8YdKG52LqGvZHqM6n6UdxLOlGk1W+6PFgJAQYlus=;
 b=CC69/IW0mVljCI8zBxHPz6fOlP70WlqhBvwWpVnp5S0unlEvP9xe9zgDx7zyQkDtWBq7GjXMz2HX8QfWcc6nL6JYrDWzuH4k07qU3qgZap7dyfKH/5rojPixeeTeH7jFy/CmlE8wSJeKRPk3YSUD0Rx5VvFHxGQ7KyMdupkkUiWh++hgWNbfbF+oman8pmcHs3ta6ch6YNa3Vn9tgkM61uYnffvSAE5GsXPqNy8aVJM4+NZkfah/D7cO0WZ7BjW4Zs16JgxNUYvP5Tft3yk70AXrwy8zh3NRIkcUOS7b0J3TDT6IyWo5zCefkxrjajRF/pFZsy0OdGVEBc0jrHCE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gz8YdKG52LqGvZHqM6n6UdxLOlGk1W+6PFgJAQYlus=;
 b=nEk3dIWceJTOUg5Uv69XdYYTMcAxlr2gwzOlWyrGY9xWSbsU5kukOhhKVS3OvtFy1d+kg307dr4VM4ZBjtyf8dr9i2QLeBgEtrMYCv25z2b5YR3z2FyPh8TQJioVIhYUs29QHogrLCZjv0BTWGRi57p+YsEuwNaZgoxuHJxvsq8=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM6PR10MB4235.namprd10.prod.outlook.com (2603:10b6:5:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 08:01:12 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f%5]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 08:01:12 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: Masks and overflow of signed immediates in BPF instructions
In-Reply-To: <bbd86b4e-89ea-8e60-883e-f348117483b4@linux.dev> (Yonghong Song's
	message of "Wed, 16 Aug 2023 09:22:09 -0700")
Message-ID: <878raa14rc.fsf@oracle.com>
References: <877cpwgzgh.fsf@oracle.com>
	<ab4264da-7c73-e7c5-334d-ed61c9fdd241@linux.dev>
	<87leec44v1.fsf@oracle.com> <87wmxv2ut4.fsf@oracle.com>
	<bbd86b4e-89ea-8e60-883e-f348117483b4@linux.dev>
Date: Thu, 17 Aug 2023 10:01:06 +0200
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::11) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DM6PR10MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d52ec9-183b-4a89-f2c5-08db9ef81f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rw7nnN6hujkAJ9eWjBu+Q7rBqJwRVJsJ4XCwv/WW3ko+pRhEsJHHl1WXWs8yZVnFH1ktZ5w2dead1y1XOUiJI98i42gQCba/7OX5SmYTOnqeISYUvB988f1J4x7n7CGSRjyJB154ukV/jVkJNIvaVrW95oy/WfStS8ZFfYskqYC0AdfBTIlmj+xfhttaNDhxEtPKOpWwYf1P2RKzBXtQehlgfL0chcUNIzfmbydhe36TyFZI04Z8GRNlAAqOSNX5aL/Orp1yQ1Y5loUHR3waZeiYDayjQsxNo2zpU43DOABFWJNiA4ucKrX9zx2GWM5L/fA2pI7165VPFeao3PM4/AHnl1CLKUGB+P85yMJJibHWMqagdCYlkoftikNNOmlcYL55DeBFft88ZF8A8jtYHan/OrrXCSgsyJjiqq5fMZWEhTWLHjdn2YSVAjAkvvVcM15nk0ZWvsCsyAQa971XmOikp45lsqZn1YDEvb4jnLVvO1HG9YEZL12tIRGsCoVA78nPqHu1pUbU2iDR2E1OuwP9jJ1dLBbDFyY+LNV9ZCfbSgH3XoT2Z+U32nQ0gCUZLIOL8dOKSuzimo4poXZKx744VIdRBGTPLlXNPDg885A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(26005)(86362001)(478600001)(36756003)(6506007)(2616005)(107886003)(6666004)(6486002)(6512007)(5660300002)(41300700001)(316002)(66476007)(66556008)(66946007)(6916009)(4326008)(8676002)(8936002)(38100700002)(14773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sANxuDTFBXkaizfHoWEen6pRMVhAIKOUigR87C+txAUaBBg0B6zKc9ZG3Xgb?=
 =?us-ascii?Q?+Wmwt3hYWYPfV+b4X0G6YvmSfgKNwYZhu/XPnGf8L4fey1qeuiLzHACieD1W?=
 =?us-ascii?Q?6wQaQ3lokcyezRA/lE0qSUdPc9N/OxZILaKAd18rbkiDy/OX84oiFw045W4r?=
 =?us-ascii?Q?QbiFMhqnQIDoE9y+C8Jb5sFvjh3QBsqTv9VuVOF5cLbgUm0m94qSALLg8FYb?=
 =?us-ascii?Q?W3xDQIOh794rAaL6/TF/k4pY2xbZGiAtEHQrrnqTEYcCSZNsNniel2im/S2u?=
 =?us-ascii?Q?q2lANTHgsBFznOQAplyIJmjlQAQRmj0otzMqkx5Ej6k34yCTA7kSQ6Dk/AUW?=
 =?us-ascii?Q?f39F6o+jqFLTIZm+w7af4YKm9bO67vrkW9D011yLEfV8QtqqAD1YmLN07Q7P?=
 =?us-ascii?Q?VU48UGy7CijtlHMz1Y7/fw49raEWlurXrJg6Cbo5VP5HbcrFF5P0uvc4RWeM?=
 =?us-ascii?Q?pNv3h6y9QMeODBdTEj16nhpQmcFUiaRQHu1cefY1pMuVGfiWZAmT3RpYQl9R?=
 =?us-ascii?Q?BQE4b+wlg0a/hmyNYdedvdYsvKtog31PmxtkkaN/S7anesvEtmgXOsRodUBz?=
 =?us-ascii?Q?aNCf0duqWCvPmHhTYfiTA9fz3IsSTu+iCY4jLhge+mLBk7vavQMiNRj7NzCC?=
 =?us-ascii?Q?DB8S6vvW5wEMcB52QDauOxzLIVjdSr/oVt7fw8fkWENSKolVDolqe0nWppoE?=
 =?us-ascii?Q?ARCV9+DG2n61x7fzhDOIlCs+7louTDKY2tkL8O6Vi1mTtIMgzotL3Z0vGcVD?=
 =?us-ascii?Q?PU4lQp0BsM6l6xd1WrXOOQN1s4rH1yIa7DW/rQIO4hD8/tjxcy06Ausu3f9j?=
 =?us-ascii?Q?lAJbKY1mJWTUKw25CA4BYAX/zxO//0FWdzx6JS79bFfq4/uqYJMNDo5sdTVz?=
 =?us-ascii?Q?GA8qaMRfaoYsj50X/Npb32lkF6I0ARf5WydMA0R6gPFl5tBAFm4viJ54nS1j?=
 =?us-ascii?Q?jY5AvLJD0CAefpJcBlQ5oQuD+WdVtssAwW7+71jF4vhHuBX96Fry32+Eal2J?=
 =?us-ascii?Q?ebDH2e9hpT+teYmWA3TogTTAL8cn6f56xBRaBPZRPbYKe7R0v45KHusSrRK2?=
 =?us-ascii?Q?lpHj5oOghBYXhuE+oxSzp9i87BqJZylkvx0pecf9K98wja3yh/Cx9W8LZp7h?=
 =?us-ascii?Q?Y+RKSKHvdR1u0fgC22gaIYLHllxyZhY0/yter5ZEiuHF9p6td7PjrfUbyHuk?=
 =?us-ascii?Q?EJOcbWi74WGPle/jUU+JDyCJgpvsETUDF+r4Ro51QUq157qwvVBXL3jsGsKD?=
 =?us-ascii?Q?V8HSRcHrRPQS+FdBZ1SkziA7zRm35STfMR42fDv/pB8O2/lISdvmtSxjYGDf?=
 =?us-ascii?Q?QV08hFtLxwclFIWfWWYWybeR8L87ktsBqN6dcR26FtaudlrH8DqKwGGLFkhb?=
 =?us-ascii?Q?NTo18UgQyTAqEGmFOk+vZ9NUqSw3Nc46tEgoGxGXFPJFgq88CRHkPicwtf5l?=
 =?us-ascii?Q?ZfGaGJj89WSEp7XbTCP+piMqaRzpFRzubEIN7CceSZRMxP3Z13X69IBwAV9d?=
 =?us-ascii?Q?eHVQlaXD5CLkuFNgmpQ72it4MzSNHCqy6fwiei7Ub4I+nro77EkVjmFrBQV1?=
 =?us-ascii?Q?ybj1P1TkoR3mEbFdynGZ14blUp3LEasBMFXmERIoDSEWXF6hF0kCP/opQtPX?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9+2JS7czKgpa/6cAh9OZZQgWNB+qGfvJNhm2AZ5LY2N6e8dJs/a9n6k1E4jha23gfkbFzyBxOisi9tpaAkIoBs+FYrh6JIVpwsp9snsvhcIHSLUW/Hm48ARIGiJS0yy6+2G30r+/y/fjR1LVnj+ExeSXzSU5dQjZWO1mmS7Q4gdKE/GUiNsBVsHGijCtmfOVmmlyv7EBSSC8LPh+OC7uwaok4Xo+KmP99WCMOZIDk4UrxIYaKvNu20AEooHckcWteDTw9ALaKqSO8N+6VfiWd8n/owNhJcn/PU2SezhrPTuuV3/JkCGM/hBBuUvN05QoTyROuxYLtm/0jWcxZ+su/SChv2BGR/g0OLY8UysYfBuKVYU1kNXx3Id+HLoqgbJ76EfaO4OFw/YQfIpJHGNPrWHamoiDPx0IsjZ5ecCzrK1UOMz39MRsDSkrWne3OnT93tYEezZdXwkkV/dJ1IynnWWKWmyQz/gkFkTemf4pIs5lILW3OVD2H+3PCXHYw3OqylTSKGxS0ZtdS6ObSwY+EcCDlFWQYfbXS5OeLg8tWg39KdHs3Kzt3/ToYqEOIUd2Mbq2186CeDojPO7rvJmbKrjXaUYWgvItbIYN7+cMvxteHp2eWu76/xoZS4pUYSZVeP8XJeiP/VWHnO+sK3Q2VxQ6MNHXPpHF2fpTlCzB6R1nq8zBurLtScn73zJgfiMSJFAlFaeg76bCDLPB/oZubKLKefnbfUtpu0x1lvoXLfPKkGnGtmcEOEn4OIlz7rDXTohKdP8twhY1yAbDZ5xnd7oLoNnGZrIhCIGoQKL8/RM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d52ec9-183b-4a89-f2c5-08db9ef81f48
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 08:01:11.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjTgMIGeO4TZgbWLUsEeqMvHpKB9b3Xu3nyV46b6iq9AXIv5jZWVTRaANs+IGtU0GHZMc4G9KLHx6UB+k2VBt9BYU2upsJ6eaVQX9ANsLAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170070
X-Proofpoint-GUID: kk7VOAhCTqt4BjnL8urMCKIv6-h0w5vM
X-Proofpoint-ORIG-GUID: kk7VOAhCTqt4BjnL8urMCKIv6-h0w5vM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> [...]
> In llvm, for inline asm, 0xfffffffe, 4294967294 and -2 have the same
> 4-byte bit-wise encoding, so they will be all encoded the same
> 0xfffffffe in the actual insn.
>
> The following is an example for x86 target in llvm:
>
> $ cat t.c
> int foo() {
>   int a, b;
>
>   asm volatile("movl $0xfffffffe, %0" : "=r"(a) :);
>   asm volatile("movl $-2, %0" : "=r"(b) :);
>   return a + b;
> }
> $ clang -O2 -c t.c
> $ llvm-objdump -d t.o
>
> t.o:    file format elf64-x86-64
>
> Disassembly of section .text:
>
> 0000000000000000 <foo>:
>        0: b9 fe ff ff ff                movl    $0xfffffffe, %ecx #
>       imm = 0xFFFFFFFE
>        5: b8 fe ff ff ff                movl    $0xfffffffe, %eax #
>       imm = 0xFFFFFFFE
>        a: 01 c8                         addl    %ecx, %eax
>        c: c3                            retq
> $
>
> Whether it is 0xfffffffe or -2, the insn encoding is the same
> and disasm prints out 0xfffffffe.

Thanks for the explanation.

I have pushed the commit below to binutils that makes GAS match the llvm
assembler behavior regarding constant immediates.  With this patch there
are no more assembler errors when building the kernel bpf selftests.

Note however that there is one pending divergence in the behavior of
both assemblers when facing invalid programs where immediate operands
cannot be represented in the number of bits of the field like in:

  $ cat foo.s
  if r1 > r2 goto 0x3fff1

llvm silently truncates it to 16-bit:

  $ clang -target bpf foo.s
  $ bpf-unkonwn-none-objdump -M pseudoc -dr foo.o
  0000000000000000 <.text>:
     0:	2d 21 f1 ff 00 00 00 00 	if r1>r2 goto -15

GAS emits an error instead:

  $ as -mdialect=pseudoc foo.s
  foo.s: Assembler messages:
  foo.s:1: Error: pc-relative offset out of range, shall fit in 16 bits.

(The same happens with 32-bit immediates.)

We think the error is pertinent, and we recommend the llvm assembler to
behave the same way.

commit 5be1b787276d2adbe85ae7febc709ca517b62f08
Author: Jose E. Marchesi <jose.marchesi@oracle.com>
Date:   Thu Aug 17 09:38:37 2023 +0200

    bpf: gas: consolidate handling of immediate overflows
    
    This commit changes the BPF GAS port in order to handle immediate
    overflows the same way than the clang BPF assembler:
    
    - For an immediate field of N bits, any written number (positive or
      negative) whose two's complement encoding fit in N its is accepted.
      This means that -2 is the same than 0xffffffe.  It is up to the
      instructions to decide how to interpret the encoded value.
    
    - Immediate fields in jump instructions are no longer relaxed.
      Relaxing to jump instructions with wider range is only performed
      when expressions are involved.
    
    - The manual is updated to document this, and testsuite adapted
      accordingly.
    
    Tested in x86_64-linux-gnu host, bpf-unknown-none target.
    
    gas/ChangeLog:
    
    2023-08-17  Jose E. Marchesi  <jose.marchesi@oracle.com>
    
            * config/tc-bpf.c (check_immediate_overflow): New function.
            (encode_insn): Use check_immediate_overflow.
            (md_assemble): Do not relax instructions with
            constant disp16 fields.
            * doc/c-bpf.texi (BPF Instructions): Add note about how numerical
            literal values are interpreted for instruction immediate operands.
            * testsuite/gas/bpf/disp16-overflow.s: Adapt accordingly.
            * testsuite/gas/bpf/jump-relax-jump.s: Likewise.
            * testsuite/gas/bpf/jump-relax-jump.d: Likewise.
            * testsuite/gas/bpf/jump-relax-jump-be.d: Likewise.
            * testsuite/gas/bpf/jump-relax-ja.s: Likewise.
            * testsuite/gas/bpf/jump-relax-ja.d: Likewise.
            * testsuite/gas/bpf/jump-relax-ja-be.d: Likewise.
            * testsuite/gas/bpf/disp16-overflow-relax.l: Likewise.
            * testsuite/gas/bpf/imm32-overflow.s: Likewise.
            * testsuite/gas/bpf/disp32-overflow.s: Likewise.
            * testsuite/gas/bpf/disp16-overflow.l: Likewise.
            * testsuite/gas/bpf/disp32-overflow.l: Likewise.
            * testsuite/gas/bpf/imm32-overflow.l: Likewise.
            * testsuite/gas/bpf/offset16-overflow.l: Likewise.

