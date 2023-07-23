Return-Path: <bpf+bounces-5688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC9B75E46C
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 21:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988821C2098E
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E439B46BA;
	Sun, 23 Jul 2023 19:15:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA132F51
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 19:15:16 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624031B2
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 12:15:15 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJCLbH031120;
	Sun, 23 Jul 2023 19:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=KormH09VPO7akCc36cpicbq8cuWpEM3toRrZKBUZzjs=;
 b=2K8Vi0gFDYOF1SbzhEgh9iFx+ClgUkEvPzpM8DO5CE3j1nG3c1CYCxBQoZ7nwplR/W18
 yRUIjww+O3JdE0WJ2d+4rjuWPPpIzpuG5VKvUwLvQ3Q5PkxYONOsqAr7sNA1nZnRSlRu
 fj8vmQ/j19pxGeqVgq4U4+ENM4lwcG8u9rksXkx6eKtWWuR9X5CmOggyRcHu+xmy1HU3
 nFa1PSjm89bm3ii3mTZb18PU8EyC6Ir5FrIlRiC8rDXE8YAKtbR/rlXrkl16NF8BOxF+
 FDR+h1k3sAiAajf0ATlXHF3CmzIy5xgBT5qULssfO8gsU4RavZA/EDRhb0fltluzvByg Mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtsfgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jul 2023 19:14:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NF0ZxM040878;
	Sun, 23 Jul 2023 19:14:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j362b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jul 2023 19:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYh91Mghsn/2IC8TDr6lz2Y7ClPD4ONWdp3ES9Zr07K4Bum1v48S5S//G8c0j6ECAycHTojpKWRCfYPmRptyFNylHrwjTOQ2UBCFqX2iTE73QxyZDJS17p18MgHD5GXYbgK1cyyY5jpS01dcPLynKlFtF+TkhlswcOwqp1BZZ3FttzWVNZdNpqYnyX+nx8PZBxj/c1pvU6HfzS4VxQTnACPuljpSqCzCgjz++Wt/5QhHLOIwNxMqqhtqr2AE+MtsNQNSk6gC4dz18zF/kWNUKNMNyRTWlvwBvWmoJhTTnJ6/rIDu4TNLiXGwhnsUZ2hmARsDxRglGcIkNSyOQ2L4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KormH09VPO7akCc36cpicbq8cuWpEM3toRrZKBUZzjs=;
 b=SYXC2m3XaY0u19M0j9mGdBh8vYnxD7VHca38cGSkQI9xTFtmljZabXt+S46iEaFLZcVGqv/zGRMghpjtJzLL0aF21KomDwyeU9nLiYudEfT9sdDI8hGoMrfDEop5LZVTQp1/hB71UI7IERyZTVUo0dO+QkM24lf/li/OZv+TEN3IZd26ofD5SmFmkpstySJ7RLJcGZt7FUUOr7gHyAYsIEEEfldSiAUroyvkgcE3HyY3M7U5lKC/KKMbB9PRqbzPy330bfSJHxODCjF7Ga4J37vU+0dCSF5J08RmhKJ4X/irJqSdvgq/zFP9AchU3rF9eKVV1AsdGFzZu4qiExI5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KormH09VPO7akCc36cpicbq8cuWpEM3toRrZKBUZzjs=;
 b=lH2BkaEuFdOmamziLro2/7dn3LRq6SX7454ktvphXWQ9B1gpe+ItuOoFn0vR/Nix9JvXZIE0bZ0aAyURDg3DhKI41fCiPRXGk1M7cIXN+6sbOeit3Kh57JT/fSHyHUCjuRanRqT8CfFTtCz7xSB23EKHc+XN4vmQoRfcRtsjZw4=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH3PR10MB7282.namprd10.prod.outlook.com (2603:10b6:610:12c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 19:14:53 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c%4]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 19:14:52 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Subject: Re: Encoding of V4 32-bit JA
In-Reply-To: <32dc8c48803ff047266ee396fed3ccc9f7f0147e.camel@gmail.com>
	(Eduard Zingerman's message of "Sun, 23 Jul 2023 20:10:15 +0300")
References: <87a5vp6xvl.fsf@oracle.com>
	<32dc8c48803ff047266ee396fed3ccc9f7f0147e.camel@gmail.com>
Date: Sun, 23 Jul 2023 21:14:46 +0200
Message-ID: <878rb6qw2h.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH3PR10MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cf95d0-f68e-4456-08bc-08db8bb1175f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U5eVwu6CemE0ZflWqoT3aFWIGxFISZFgcl5TkRujtcnPABwYNsDlAOsCxpBk8dD8xGetn6RXanWpOgU/3+VMx0mVlp8l+AaDXI8p47w9R2yfRRvnORFTs1UcYgvS7EZbro6Y0rBujYNE5e4l5cWG0/jmrXbOdf6BJoqahpASWWtsS0y3mP5VrZhMfxOxVdwSUj0hMrNPacs5MY03FPiuXYPKYA23Z1sGwvagFdpybB4GW2LS9k9Yv4sC9k+4Q6IA9BGzDOawO+GPzZFH79cIGaFdekzpCAVITS0aEQiIOKnN/Hrd0E1R2I3xlrac19ACj0+XWdWaQnTRPB/+ATCffHJdz5OT0eQLiEX84zWGWmZDcHQPNwTP8kqFxde7JQa5dFtx9SphB2cSeS5R4oNknRK0Mx7SzssqLOo1KeQpKcT+HRQda6PU6+DioUNF6/65Sdun8OO8g+YUYHerliFzmObH4Oo5ucIKKgujnXrrY1mNHYo8M5KxaSDMqmIJJcWZcfDhcM56th9o4+nMhibLUhX2OevaBGxY7uLB1E8WdvI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(6666004)(6512007)(966005)(6486002)(478600001)(2616005)(186003)(6506007)(2906002)(316002)(41300700001)(66946007)(4326008)(66476007)(6916009)(66556008)(5660300002)(8676002)(8936002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ns4MkGOsRHiTTSuofnQkDvh03mBSD7yDJWO3xKCHwO8fxSBTdayb1J0Ei+DL?=
 =?us-ascii?Q?2oP36Y+CqhZ7S5rCFE8D24Zx6APUEULfkeCQvDnH7GFIVl/lJZCrC+kF+bJ9?=
 =?us-ascii?Q?YuLkaeglGvQ9LEJh/iRXr4G1npnAqM95pCf+8ZFuFslytVv9yRZAbtvvTCGO?=
 =?us-ascii?Q?roDzhyTAYyyOSWLzL90+RxSwBZs/J2BUIzHyfM1gncrW7et3d2jXshAKfX/T?=
 =?us-ascii?Q?e3gT1w3edLV60a6S1TxRjDmSx5mwKaVdrnC3r8PhYc2wulAh+FUS53eKPKHk?=
 =?us-ascii?Q?pPIFEX+oG363Q1VtcBaMH4UlCiKdNzYDwQZO6DTsA/xqZYcNaPsUvVXC4pNH?=
 =?us-ascii?Q?yZuPyEzHTKeflZ8FgldZbD+7NRr8InbMi5BrLYaQXL4DtERPqug4GOxP5kDi?=
 =?us-ascii?Q?2CgeuGEQ8NyBbZ0652tYQbu8DlnnEVLJY81Bjb4UnOZpiNRTZotYpgyp+MYM?=
 =?us-ascii?Q?IMHdH2y3PIgxnjZCvKX3Gto37I8sYDqB5yr2DcicN67kLMpH2sQNDfbjiebY?=
 =?us-ascii?Q?2jBAI3Q2dUJr66kcsOWuLe8PevGqS6kfPVLSm3iLTEEipThUll4uTERR6XtY?=
 =?us-ascii?Q?02cfgRxnEYWkVM0FcJiY15QCWucYbuXEjQRWR1BQbmaSQRyO1kVBA4mhyoFa?=
 =?us-ascii?Q?TJcX/tJE1FogKUY7YTuPYd9/Et4AxEJUvY0wvaCLR4vIoY4ciJiiCngXMPOT?=
 =?us-ascii?Q?p7L8AvGeUBSxlFEnwwgg8QP65diyxiCFwju7xAdGMxp3gsFcdvecpynSaYzs?=
 =?us-ascii?Q?7RoO1L52tNmy/jzKkay4f1AIAUvV37gkRsW1nj+mq6HsanCKd/h0rUsoenak?=
 =?us-ascii?Q?u9IqoDI73980Ay2pPNIB/VKYN0NmzinB3nGfDGn7J1odKxskSHe9U2TBqQCu?=
 =?us-ascii?Q?JcdkIaT59I0Xd1AJVOU681xZXuABINKYDE2tI9zetobSSbRRwFP18iGbOCSC?=
 =?us-ascii?Q?WHb0eo1++f2JiKRTF7minPYMlKBdmGdQoNl7PLo/8f9h0kaVHRRxiUz1NVeg?=
 =?us-ascii?Q?SXltPrBSmsty2i0AL4EJI/C/EyHCqBrK2BV9aMSsj3UzKVRZM4dNA179+rZd?=
 =?us-ascii?Q?fc2CiCN/In2K3wcoiE3Zqpyzn0H53VYmB9YaJOzc8UP9CeF5U3fLFowzgesi?=
 =?us-ascii?Q?1b3n3+VrSTz4YnowWXZia31mSPzba/X0SpLRb9Vaagv9Z/EFrBY/AOvtxGYe?=
 =?us-ascii?Q?uF8DBwXRlaRn9erCryDrnHMxKESvSzqppt45DpAfGMVEkaC2z4pPrjORtg20?=
 =?us-ascii?Q?c7gGeqc3KajRaue1hOOi0wXAS45ADR6cGX8CLecjVx33dPzZ08pm42Bxat5v?=
 =?us-ascii?Q?2FkeDqgrYvrfJgyocq70cJ0jvpbxquQPsU4i1/zT/mMgnrnqf5khVv952HGO?=
 =?us-ascii?Q?YK8Q19zCCZvyRIEMUA29SmPsyT8WYE5CKyJT9MS0Y1+0pahpb3JaZSSC3FJ2?=
 =?us-ascii?Q?mOhjQvq89neBR0+MYDHpVJuFzxf78fgG/UadKcSmVCMEAh7DM2Ts238wy93M?=
 =?us-ascii?Q?BUQptEsEP6azckIL018EJQCwJfge5RWIoD3aMrdOXMWf4SObvPcEpPyOd18J?=
 =?us-ascii?Q?a7IsGAPtpc73fz5TYn6IKR0UR2ZETdxXg7SjX1PVOa81nyvdIve6O3SRNQ33?=
 =?us-ascii?Q?PqqGKlznrI2e+h1PPSPI7jGjGg2bKHeBBL7i0JjNk+MpbHca/qUtCR2MWd1G?=
 =?us-ascii?Q?3wQxpQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/3FVGT76nSemYkfeUtVXvRC86RhguJ95kpqrwv0Jb3kp5BPd8ZS3vNDmbrs4OVPAtpw1nMeVbej9Rz9ybLO2DPTGFPWyUfqGgCuih1a+erSMEYmxtpy965RQFeWnE30TsjwUP1wkgqobz5q3SZFJodhryoqeOGbr6vSyrtVmGZb6W/DrLKSTAt9WdE8SlXogMvZCt4rSlNhNuiV/Bx/43wPrsIw0rSUhnKy8QoOYKTCAJdwAkvdlYoc0W/vBASTWqzvyMgdsdLRsZ5mGoNN7dgHjrYre+4U1B5pYMAwquPYERrIfCbkdNSUc7wyEnaVJPP2JZUBuZExxkpKcLs8XDf/pTRCrRecuF1KwDmF96eZ8H9/gVLSHbN5T/1en8KrGyQK7L3WA4GuDbXIl4rUPBuifOxC/Bh9DbdfVnpJiftxxrFfxmc425R4siTnGMlNg4WWwzbK8Iv/uD84ltIQvxLGk3g784OZKcUHWGyL+6H4+iUbRwLdOR5oYnCrgrW6ZKKj7EvPGfMFiXq9SRRQ5EL9jyOLdzMrTuGBinNxZpHlcWPKMi6Q3E3EZ3LbnU1iJNbFVRGDYQTiOGR99aeuWS3BXTNQdi5+KNuDcan2FESD1BRl8p072YRcLQzWQUzmmI7sOhSPLTzJnbWQbr1ZR1VFk4b5ryj5EYDEFnN9ngZNVHZI68dyKcJno+aOx5BVxYwq0Rz3tX6yE2zDX2EeRgFxWVECYS2mPz6mwRUqap128JRV8/Hi1uO8ViL6SjzUG0IenLSZUdK73Il2mFH5hidZRZi6OFO4X3+TOYyKNY4jih8evhfk3mfOjZdkIV96E
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cf95d0-f68e-4456-08bc-08db8bb1175f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 19:14:52.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AEN08uf1UP1hBnwFWbEm9ztGKvKW5zAzcKKXB3QtYf1U+5GMqLrf1mwg7fqTXqSnesBTXRaeliCZ+hhGdaNW1AbYPswii85uyDVeeukP2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=884
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230180
X-Proofpoint-ORIG-GUID: SDFjCESlOV7sgQ8sLo2YSNlyqThM6UB2
X-Proofpoint-GUID: SDFjCESlOV7sgQ8sLo2YSNlyqThM6UB2
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Fri, 2023-07-21 at 18:19 +0200, Jose E. Marchesi wrote:
>> Hi Yonghong.
>> 
>> This is from the v4 instructions proposal:
>> 
>>     ========  =====  =========================  ============
>>     code      value  description                notes
>>     ========  =====  =========================  ============
>>     BPF_JA    0x00   PC += imm                  BPF_JMP32 only
>> 
>> Is this instruction using source 1 instead of 0?  Otherwise, it would
>> have exactly the same encoding than the V3< JA instruction.  Is that
>> what is intended?
>> 
>> TIA.
>> 
>
> Hi Jose,
>
> I think that assumption is that `BPF_JMP32 | BPF_JA` is currently free:
> - documentation [1] implies that only `BPF_JMP` should be used for `BPF_JA`
>   (see "notes" column for the first line)
> - BPF verifier rejects `BPF_JMP32 | BPF_JA`
> - clang always generates `BPF_JMP | BPF_JA`

Makes sense, thanks for the info.

Do you know the precise pseudo-c assembly syntax to use for this
instruction?

> Thanks,
> Eduard
>
> [1] https://www.kernel.org/doc/html/latest/bpf/instruction-set.html#jump-instructions

