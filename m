Return-Path: <bpf+bounces-5858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C927621D8
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486621C20F5A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E98263B6;
	Tue, 25 Jul 2023 18:57:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC11D2FD
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 18:57:06 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B55F121
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 11:57:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PFsJe9006527;
	Tue, 25 Jul 2023 18:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=II6WuLDyOdQO+FbEKM5u7OYYyeKCMjSr+zwxCINPNCs=;
 b=UjtS/PqGMy3/DwUdcyMq66zhkjvwcRL7yB1n6wYdsE4WWCVqNctcXdoqPn2DzfuecP7O
 xkMvCAGd4irkEkil41d+6gmSZgEQjExZr1Rzs+hq8WwExqMUmeAVvBoQHm6o8ccsjaJJ
 J4u3IfzvKEOKXOvXfK+RVJr8N2v+OQ9VZy64cxH8PwHsa0hoZidvp9hwt2bo3Y217BCn
 +tPEunuJfy/LhQ33VTB8DBsAAAsDd/1xuKJob81OYb7QVzq54YLTjnTJ9IUiHDfYldaa
 vPz7v4j6fx+sqsn44JwNiW3ns9pnJe8f3dCz9SzFVAtSZsFoWHn4i/7mVXau5lLnb+u1 dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nunsht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 18:56:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PHuukE030404;
	Tue, 25 Jul 2023 18:56:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jbfhv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 18:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UodMf3MhHHpKjK2FBHXznPPjgm5cYOBWo/V+9AGFy8E+w1ai31mcHDVnVejkZPlLvTII80NaiJF63optZpX8z3iSylIGqt0+ewlWbGaV13v/merT3V0jfeoTiZzQ7UVpEY67fL29rIpb7HOJN05J9/rbV+cjA+U9bJeJvCWDWZ2Fm3GaXWg4IoF/ejZat0GcUXPKFGRt+CVQnP642t0/pqISdSiMuN/Rc6ixCY5OoFzaa7H5u+C5J5l67IJuJOYd/gNfl3ao8FCUkGPbdYY9nAhQgi0z8SfV3bNIuhYVqGdLGw1I65PiHnXebkC8jNWwAC08DUe9ICy9bdIUzz+nqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II6WuLDyOdQO+FbEKM5u7OYYyeKCMjSr+zwxCINPNCs=;
 b=QZ0HUTIkG0A/BuA6dkmSCZ0YgK9CjI2Pj+x6cbFdFuMGsJvR1yS717xLL2UR1rCh5eXvZhElIc5r+XWC+5BHaKePKjwWOzRmmTHASS7IjeDhko1yBe2YF4wU170MceJU0VOUIrrfvaiWE5C9wMR/DZLNBb7n9SwDT2+tqSMMa4XSYYpMpmLoCEj68X39zfluU3R6JMeUZYtsTfgPXEkhqTETXpfBTPFmUwiD5FJdn7iDE2cWvw2jShKR1iypXYGrXiabuXYPvw4m6CuZvndF/2z+K7hw3OkyX/JcPWEdfH8Qv6IRy0jr/m64hVOoBtCubjByMDoA3xtFgRD97+Bf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II6WuLDyOdQO+FbEKM5u7OYYyeKCMjSr+zwxCINPNCs=;
 b=hqfu2A7lDz0h0iBPQaKO93QpksqJRTO70Q9FTp1kzGwuntKM6BEzdxEnpPiNriH8cLqTbIg3hz+fzLqUNIHjv3cUmdijWU9FYouRgmOPMhUJkbsUOUiMkhWEqwDUfDXi2+u9WrM7EmLvlMAGj6gjWCoryrkKHBA9UBdpCT9m7rU=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH8PR10MB6315.namprd10.prod.outlook.com (2603:10b6:510:1ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 18:56:54 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 18:56:54 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Subject: Re: Register encoding in assembly for load/store instructions
In-Reply-To: <5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev> (Yonghong Song's
	message of "Tue, 25 Jul 2023 11:47:35 -0700")
References: <87ila7dhmp.fsf@oracle.com>
	<5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev>
Date: Tue, 25 Jul 2023 20:56:44 +0200
Message-ID: <87o7jzbz0z.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|PH8PR10MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: d162498b-1677-46c0-4142-08db8d40e9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OyILzhgH7pGahB9iHnKdTPUwm85JtNK4RSwIScAvamkS0zmZbqwbJt8J/tjN+bOkUBZwqXkyfjwQO5oSC880Dxaj2KPdddjgh9AXulMZg3cpM/pKIccRHlzXojXlGU72YHeVBPNL9UeAVGT4r4/DvRsiKXqQseK98XBv0aeF5T0n4yxbwBpWI/Ir7kGW5J7BT79tCEOsNBYjGnb9hwLkYkHvj8L0BPPT8CqDYT0ED5glMhRx3YMRNUthLpcR5EesTf8KzpZV2LJTbzh4YgCkCqjw4lNKzUPMjNSq0AbgsmWRhavt3zTMcPKUY3I1hg0UkoWjobnfmTipLdI2kxHWOZPNMBLaVxRllFy4IoLLoD17X1bojYJ+OyqZy4bKnsNTV+EiXNEEUbersgj2BIN+oChMa/BnTI/4BxK1X8GQtTNMceTfKVEmAIe6WM1rLJOqtXQyuylYcU9eGZfgdFHvqn2ECK+WOObck/UYVGhe0XKk4sSnJll6IpHZHYNdq16gcgfUt5l82sFJ3WARjNicVw8BRBa717MQqkh8CN7cB1cbXX+WnEPChMGZlMKlFXEu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(38100700002)(26005)(86362001)(6506007)(53546011)(186003)(2616005)(83380400001)(6512007)(6666004)(6486002)(66556008)(4326008)(6916009)(66946007)(66476007)(316002)(41300700001)(5660300002)(478600001)(8936002)(8676002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S00yvEvIDjqpMyu+dgEoNAghEaI2n+Svf8WKlWiBCCUMV6N+KR8y6Gu/XU4e?=
 =?us-ascii?Q?1xkrW2jRMRW3r6Kwg8Mep5dHYPlP86z9pB+F8/VUtbKXaiQwrrI8I6s9bePf?=
 =?us-ascii?Q?HG5j70JVUfBcpefnrB065qJgAawMqYx8LniGwRoX9iIextolMCBifvDcb6CY?=
 =?us-ascii?Q?a7LEhyoWNA/0SPY/9idIwupJdLPFdOlZhj/QZBXJs6mKGsW15beO2d/DxWIl?=
 =?us-ascii?Q?VY/CM4qucaEfRmbSBNWEcDKUr98rhLQyRBWaaO2T/cvFmhLyzgP54fvTZBC1?=
 =?us-ascii?Q?6Fck4HkB590scxP9mOLmh0hIGCZOsWevfcy7rNLsagn/ehX0lDUxXZam1Dfh?=
 =?us-ascii?Q?vpRsu4jO9jc8BGP60Ghx3DxKzAuIBAkOUxU2W0tuh97qkd8nJWUSBZiS7++f?=
 =?us-ascii?Q?VF2FqemZf4adoVXCoPCjfY2hksPfDgp59pMtHUn9dAuqdLe5fKHO6wPyP4Xu?=
 =?us-ascii?Q?Uhd++LRXeriNUBlirOaeU4573/hVDhvOVpmf7wWe1qL1kk4eif5N/U4IzMr2?=
 =?us-ascii?Q?UAHV4nKXp4kk9Nt2+/Vj7yiFxEfoSMPVnwGCKlmYlyO+zRU+rpXPr006Edoj?=
 =?us-ascii?Q?sqi+AvD/pQBzChu36hbEwfbtkWnmYH1SgsQIvzL0R5PcRwSyHdOpf62K63YX?=
 =?us-ascii?Q?+g9zq6xA6D7Dg/ffOsDlmtIs0v3789YfBlyR8JzGsuCB7yLJwQLzU2o2GTou?=
 =?us-ascii?Q?g2SYYpitDS6pehP837RhSvW/Pdwh4B4+DRCEI+QgrFeXKZCra7+HSmcd/yGr?=
 =?us-ascii?Q?U9KNfsggCBYPF7dZiTmt+7/fbeKI1jNeZeoz3sAdzcVD1E96TddiL0+RlqR7?=
 =?us-ascii?Q?50zuGzTtgzr8aCCGTHsFmV0lFg33x+Gf1Hc9vGlnSRRDVXv+Zu6ONe1ksn8x?=
 =?us-ascii?Q?BC7h0N6JQx8y5Xo7sRWPDy9mHmCnRocelzz3EWgjluEdQQPkiImxkX3lc+Yy?=
 =?us-ascii?Q?BjErXHT4gUyvTcNzndwZnVO0bWx0r0O9HSA7xZpEY77kHQydHJzW8Ng+337t?=
 =?us-ascii?Q?zz7QWozlQgzgem5tJoFr6/sJkVxS/Bn/2grvMOXiq6/jOM3vuD42Dd9IwdOW?=
 =?us-ascii?Q?wa5zkOlHBb39EGykNyacyjOCXP9v3sBZepmLgca8ENiw8g12C7KdrPMY1GKT?=
 =?us-ascii?Q?b99ezWQhHeJy2RTv0Ak9AHqKNzhtGjVg1ZraykMpXQHfDWGwgvozoxzqPRB2?=
 =?us-ascii?Q?ySvqSztivY8+Z1oKVlQjJ24L+ju3XrdVplWji/FZ5oSZjquXblkHQhrIiEXJ?=
 =?us-ascii?Q?J34Vhf2EQD9YM/bEAunmvgQphVwW1J95G3Cqgv87wZJ9HOnAofes3A3YIfAg?=
 =?us-ascii?Q?guFp+PpDMNtsJ84xEfQ9xJG6yZTcWoTHvPkX0B1n99bVERrCAbQ3CLu2j2aV?=
 =?us-ascii?Q?98lJP5ycuP5wCKfDEya1LfDApLw6DJQrvVah2T5QgB8DUUTJrf3x2m5G2qKU?=
 =?us-ascii?Q?FLwM6ZAf1w4ghGU2BMx7Xf2+SDnQA4b5fWMF/Do3TOsrJMBBixISxpCrK33a?=
 =?us-ascii?Q?SOFbO9r/MbEF7+BhuS+DKSRJgjdWOZnj4FRvlp6wJgtDRRgjlmd0r3FgTGOl?=
 =?us-ascii?Q?2CdEQW/dG55EjUGF6sgAaP1VMXT8kmwyJkD3C77M/bqYcFUF4Vy1e399YNWt?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xbZF85xT+a44wTu1DjFy52THcq2qWhsbDpJm8OPTpwA4pweHsif7f54zfbTKFVXTP3uMMKBV2zs743KX6QuRp+BkDeolb4cpBReCtAmZ/w6ZNH9qUxhuKk6L/FSGsmMY1bVM0/RsLR3I47flniqsumyngkLzoY6PdPKg+V/M3IkUO6kMswLpKMxDmxgAQzDr9wzebke9iCmBWPkbYinfxbzmfVpoODmmYJ14jX0JXUVbGoS2N4juQ00X+Oa2QCZsTBoJSEiWv+ohq4jpAkaX9QTxKBy1E8asWoU8S8D37cnmAmY8m/2wOPZHTvqOVnnoOOx3v1k2LDOr7DHhL8V6E+/LLdrCCZS63CGZQUVuOcd48r6+pwJNXudF2yn4GaqqD3bhTK2pwZOBHN9mokm9cwcjIm1Z43+riOQm9b2VwCQ9MDi1+ssZwGp+OrH4GUEa5LeqAqp905inxavXy4rawoWVeUiUykIUrWFXlamGNHTkwozG3cQiuwBBAMwEZO8Nrzru+HH6YZC+57afC66hPAFvjhpOAR4LNwRod7bMUg62n72o8yCyacZm8t/v2xVtVK7OVSLT60o+9H3kCIMm+64S4OA3s6Fyg9q/yfFEqRAeenS6r99n4PKloE2GR+Mb6nVTBMVc3kprlq0F24wtSSxJmfy+MlpeAUnsyi1PLcs0m8UiIDPOCBhSbp8ci5Yky1Fi7e7grfsLQhxGzz7gy6PZkg2ikheApyp/M2cdeSQXwM6dKwAs5aSgP3LFPH3pHwXGegnqRsPMMRS5kedCj7NOlRbidi8nmSzNc3XmOcsdwEt1D0pcrJCQVhYjgC6c
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d162498b-1677-46c0-4142-08db8d40e9be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 18:56:54.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP85nGeAm+wZN9AL8yLf24niyy6k0mjuTcht1RtzRsO3gzEo600FscU1RP86qrGBp8YjA41K770BlOHxru4yVH0LHGmdzFDHQbIQveEUQ1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=984 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250162
X-Proofpoint-ORIG-GUID: 304MBOxfp6ayfrUxb74OTWLSQGm9O-R6
X-Proofpoint-GUID: 304MBOxfp6ayfrUxb74OTWLSQGm9O-R6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On 7/25/23 10:29 AM, Jose E. Marchesi wrote:
>> Hello Yonghong.
>> We have noticed that the llvm disassembler uses different notations
>> for
>> registers in load and store instructions, depending somehow on the width
>> of the data being loaded or stored.
>> For example, this is an excerpt from the assembler-disassembler.s
>> test
>> file in llvm:
>>    // Note: For the group below w1 is used as a destination for
>> sizes u8, u16, u32.
>>    //       This is disassembler quirk, but is technically not wrong, as there are
>>    //       no different encodings for 'r1 = load' vs 'w1 = load'.
>>    //
>>    // CHECK: 71 21 2a 00 00 00 00 00	w1 = *(u8 *)(r2 + 0x2a)
>>    // CHECK: 69 21 2a 00 00 00 00 00	w1 = *(u16 *)(r2 + 0x2a)
>>    // CHECK: 61 21 2a 00 00 00 00 00	w1 = *(u32 *)(r2 + 0x2a)
>>    // CHECK: 79 21 2a 00 00 00 00 00	r1 = *(u64 *)(r2 + 0x2a)
>>    r1 = *(u8*)(r2 + 42)
>>    r1 = *(u16*)(r2 + 42)
>>    r1 = *(u32*)(r2 + 42)
>>    r1 = *(u64*)(r2 + 42)
>> The comment there clarifies that the usage of wN instead of rN in
>> the
>> u8, u16 and u32 cases is a "disassembler quirk".
>> Anyway, the problem is that it seems that `clang -S' actually emits
>> these forms with wN.
>> Is that intended?
>
> Yes, this is intended since alu32 mode is enabled where
> w* registers are used for 8/16/32 bit load.

So then why suppporting 'r1 = 8948 8*9r2 + 0x2a)'?  The mode is still
alu32 mode.  Isn't the u{8,16,32} part enough to discriminate?

> Note that for newer sign-extended loads, even at alu32 mode,
> only r* register is used since the sign-extension extends
> upto 64 bits for all variants (8/16/32).

Yes we noticed that :)

>
>
>
>> 

