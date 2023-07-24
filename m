Return-Path: <bpf+bounces-5714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B737D75F675
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EAB1C20BBD
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830926AAC;
	Mon, 24 Jul 2023 12:36:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8AB53BA
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 12:36:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE3A10C3
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 05:36:56 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6mjmA001318;
	Mon, 24 Jul 2023 12:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jnQGYHZA0votyClukmz+r6q0ZglOVrQVjss9z4XbJDI=;
 b=tapCsxelNPkGOGkC+Th0Y4j1OFRb6OdQ8F8/n3mGCsnG2VEMLhp/eSJ53j0KUCd0Nqfu
 aefg6RtqXnbWANcHis3tLEIN9SjDdWAEiYQuhIJItf3HkPBagFTXh+f+oSyubJG/5r+F
 i9Tp7fQXCfEUTy/5Aau21n6Jac4KgPZfHdzJjJauXsagnMlHBESHvXxp5bmyfWQNTSU8
 12gJcAniIx0m29s7sSFLSmUdk68LvCWYrEB/wAdzkXqcWWfGm0IUMQu7oAE+5pZtphkh
 DVRu+wwT99x0jx3nmBBLGXj89pAV3lK35Jvy3P9TUVAl7++o53X2NI4LeryJ4aCNJFdu Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d2m6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jul 2023 12:36:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OCJOQe028691;
	Mon, 24 Jul 2023 12:36:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3m121-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jul 2023 12:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i76IX4FUDqHogH5IawrBgZC6xY38dYpyJR1sD7No08u0o169KtttdMxg4BCzSzTtlsrrkHfEuKhFunV7b7iCMMi7mbW/RykwCdxr89qEON8ElZyRAq3a0/y+aoRtLNOTFNTFS/QojZn4FV3qXqJ4ju30KyU1yQaRMBhR5vvPPOfghdKsSq/rjBVd74FR7b2BEm06ZKTQHjAJ9vcl4kFTGXBLiRJEHOnCOtHb1gFcpRUvS+nSFcoqzeELS5OZ1AT72joMFrXYLgcv6y3Q1/N3NIHE2zcWXxXAa/boZUAJcYRI3fkVpDoTbK1WqaWMRiYQS/132mzNO52bswSfT8aZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnQGYHZA0votyClukmz+r6q0ZglOVrQVjss9z4XbJDI=;
 b=gsum1G1f8/mFCVnN4qBjcr2t7pyOVCVfE6NuUtu2z1PsLJV5NERHcIHoIO5QdBBgBHWvdUJLroS3RoWWo4KnJKZLEO5VUXESCW0hx2nLGYCKZV7Qs9V9mt25rH2yZKUpeJqgY6E6S74T+1mrSdEu+ZucwiMjUaF2stX4nm9kKezTQApozXDsb0DaiINrOOey+HOOfXN5cpq4f0v/ObiD3eB6LwB41QPOxJgcWORADTkJ/8Bh//7LQqLcuEvih+fTs+u/5MKkXbXNLEqOGoa2xt/Ca0xfQybe3XLaGphjo9skMwPfVT0xCr8v8cFOigL11rnAO5cAu+je/EAK0u+INg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnQGYHZA0votyClukmz+r6q0ZglOVrQVjss9z4XbJDI=;
 b=l/+7HCQpHee3adlzH4KGNkHwLuxlgg4SGhFqvGJzOGBVYuOibSGJih/N5Ia4zzXiGc8I0jA7PvUYB0H0zjnhhaBT9Rpph5BLfam120JCMW1rBRGJUZmqRGb6o7STANVdkURhIzJ4JJKDxuUMZShhcloHGHDqumNMziZcLkRXJMg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB5710.namprd10.prod.outlook.com (2603:10b6:806:231::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 12:36:52 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 12:36:51 +0000
Message-ID: <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
Date: Mon, 24 Jul 2023 13:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
To: Timofei Pushkin <pushkin.td@gmail.com>, bpf@vger.kernel.org
References: <CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e10aefc-96ad-46cf-416d-08db8c42a777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O/7/KAXq2KOV+HaHuGaX/j07cD8umFfLLGVBYelNABPC5BfUHzJbOVM9Ci4ra8wRi/+Up95bAqmV9ihc6A/nLWF4W725jUk+F3NEG3ubyL4ki5pa95VbT4o7ZOLSxBRwx5uvOLWsmTkJXg/UEDsAxtDinx1rQEYTdUARkf/DdulqKNYPe8SH/GyPWX/ZOvVXp1iAv8HzUs9Lu+y3l+BEj3JP7oLPWYezLHQo+VQomUjVSAAt+2CvNLXYbJKdVMy2umCD6TIcRpxWeypmBQDf0Nh40vvaTjc/1a+qoRRTeg933tbMRG/vfHrxt6LkJW7AjwKqB7AxICw7j3hB/TanvYh0v9l+JNBbpqXrzGMLlMF7EE5E+E1arN50tEbupa3px3XusktAxWfKnY4E/vVcbdaziiphTKlKpaX7Su5BuTN1IN4mfEdu8qiww9IXhn/DQfNA07cHxLbTJiK8DyG+XUsUX6KbrEx/ETNl1x58V8WjWdH3yOK/lRtbdAhBElZE4TZUSB0mZzDsyB6EnW0Pwu/JniMiuN7+Kf272CRw78BX5Ne+cupgvLKNfEm7ZDz95IpCfaVNKRWaPhMnstoP6lwCGJgttg0Oj0evQvMdNzL4SUd9biFFRppPXoi6VuPnXD2VQCQVTFd/d42U25ZhIA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(6512007)(6486002)(6666004)(478600001)(186003)(53546011)(2616005)(6506007)(44832011)(2906002)(41300700001)(66556008)(5660300002)(316002)(8936002)(8676002)(66946007)(66476007)(38100700002)(36756003)(31696002)(86362001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N05pRTBtM1RzOEFKSHBlcFRicFFCZmMwMFJqTms4bjRvRHc1RXVuRXBCbEN6?=
 =?utf-8?B?Yk1kdlZSTTRXRFJ4STkzS0loV1RUMTlkVlZGemEvL2JQcE80RFV5YlpLM21v?=
 =?utf-8?B?K1dXMFg5UFJ2YmVVTCtxUGJpN29TK2F2MmpSbFlwTUVCdzdFTllZdjBZaTkr?=
 =?utf-8?B?WDI1Y1RTVkJ4a0NFYWV4S3ArR0crSEl1UzIrWDhYaFhXRStZblJRaFg0MnZZ?=
 =?utf-8?B?RWRFeFVFOUFiVTJJMGJ4ZmJPSDVhR1Q2aCsyQTdYeDZxdE5xU0l4SDF5NFh5?=
 =?utf-8?B?RFM0WHNkUjcxWnpvWFl2ck9OMW1nZW41RHFpTUhRb3NmOHI3VEhjK1VDQWFk?=
 =?utf-8?B?WFZySWZNRDFUbGl6U3BSVDhrc2pYU3B5cnErRWcxdnc5MjAyUm8zcTFrTTJR?=
 =?utf-8?B?dW5VWmg5N0ZkN0NQZjF5c1pQaVBkY3pjakFwbHoraVcyWkhDZ2Zhek00SUhz?=
 =?utf-8?B?T1NrMVJwMnBqLzJROUpZc0xaTDBrekVZVElpbmZkZUVVcGk2ZHM0UDF2SjhI?=
 =?utf-8?B?bjBsQlBHL3RYbEdmR1I1T3V6bnRDQ3lDZTVhUC9SRzRXZU4xbFJPeDNQdUd5?=
 =?utf-8?B?UHRSdWR0dmZFaURQWGFTYjJuTmdFSFd1Nk5SYm5uYmFYWlg5RDRqUEtHa1Ry?=
 =?utf-8?B?UlIrTmFxWDBya1kzM2xLcWczMHlNV2x2MkVac1BQOXVLKzZQWmNUUVZQQTJo?=
 =?utf-8?B?M2FqOTRaL2hCdTlNMmV0WVZuMTRsNFpqSldMODdOVWtncFk1cGNzdlVtbm5I?=
 =?utf-8?B?NW0zSkNQOEwrV0h3akMvQjFrUnBQaW1UMzdDUHlSRjNHaUZRYXhKUm5vRVBF?=
 =?utf-8?B?eW9tQVh4aUV4MHlMd0pZRDREanloVFo0OWFBdEdaNVh2bjJHUWtMeDRYMzdv?=
 =?utf-8?B?aVUzejhRQzFwYlpublZLaGJaUjVlVllLQm5YRTVsUFl4d2VaUGdHRDc2d0ls?=
 =?utf-8?B?WEhrVDdOWnlYZXNiM21ZM1QyZCtzTlN4TGdLRkxUTXZvdUIxNGlBRzg2eXBp?=
 =?utf-8?B?clVyVkRYSDRHWG9vbkJ2UEIxSG5jeG1qemlPOU55RWg5VzFzQUJIL2g3OXZq?=
 =?utf-8?B?SVBTdVp5cXk3Rk1TZ09CeVRJb1paZE8rSk5BakV2ZUZXMXFoWW1Xc1lJWE1q?=
 =?utf-8?B?ZmdZSHdhbCt5bTNORm1EUzdqWmQ3UXIwREYyWkE5N0JMTm93aGhqemxWMWMw?=
 =?utf-8?B?c1BmNllTTVRRVDN2NzBZSGdvaG1TTmxCUmNQeitMTk5YUWdUaGVTMjZaRHY5?=
 =?utf-8?B?aXZEMDNGWElBMkhmR3Z6dUl4Rm5sWEt2UURsVzloYXlteTR4aFNiWDdvczZn?=
 =?utf-8?B?R3FkeEgwS0xzN3FYY3lVNlBDMWtiR25jRkJFYzNCY1h1THpKM1YrUSsvTFNB?=
 =?utf-8?B?WXNJNVBoRVpINW96bVpzeTlnMllLRDV4dlNqZi9LdVdaZkNhL2hNRTBYd0ow?=
 =?utf-8?B?MkVFemtQU081MUJGRWxSSGRnSXN5WUNYZmI4LythWXZPc2d0ckUydXplS1A2?=
 =?utf-8?B?eGZxU0dtcWhmbzN6Q1ZJU3ZHa0xlaGYra2taT3QyTCtpWFBpM25jS1cxLzli?=
 =?utf-8?B?ekhwTXRKUk1Zck5BaEV3emVwUHBCN3R0aEh5TmVSYlppOTZxdWQwbWJoTk1Q?=
 =?utf-8?B?eFRXKzViMG5hVmRCbTQxejdJb1cyemM2b0NyMUpZS2ZGNXpLQUxSaUtrUTZx?=
 =?utf-8?B?cUFkOW5LUFFJcEdTUnlKYXdwUDhxZkpXOFlGdXd6dy9Sd3B0cTNMTUZpWCtp?=
 =?utf-8?B?UXBLenltZVZBeEd2ZitUaC9oeXYzMHRWaWUxN2VKeGFUOUNpaURlUzVYdGl0?=
 =?utf-8?B?NUIwbUdSbHpkV3FCd3ZzN0M4T2JLVnFINzgrUkVyVHZkMFZSL3BOV0ZhU2tk?=
 =?utf-8?B?RmE3a2pwOHEyendSR0o2elluQ0xTSllDU3JvYUlYY2dkazV4L1hzTmV1eFgx?=
 =?utf-8?B?bnltRmlNZW50U0s1WVRkajNGRG1HR3FVeFdmWktrbmdNK2lEZ3BIQTFoV3Bn?=
 =?utf-8?B?YWYvWnRpekZzakJqeUpHVDBJc2RITnBlZHVXU0VSNlk0UEJCSGxXbFptQVFQ?=
 =?utf-8?B?VXFuSWsxOXhHRnFmUnpxUmRZb2lMTGU0MmIvWCt5ZzJCS1ViRklrd3Z2UDNo?=
 =?utf-8?B?OHZJdXl3eXFGR2NnMlpCM1d6b3VWenNub0V2NURhbnh1cFV1UTJuRDZWNjBP?=
 =?utf-8?Q?xbPPjgiI6qywOYQzl6xiSwc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WyGwZ8B1p+TVgfUmIO3URefxKhTvM5PJ0ZAZ4opxKGSMSbRfe1cvfUfFuUBB3FS9SfGrAxJyIim1HDGJrcUMyZGH57vz+EG3Oq/m8ktMEehPmbKQkzMGxeRCfMaxO5sbD3D8/Ja0S0MOomG7tXPN2Sh15zaIZ1bscu9OhEb7sOcPDUdtZfLUfIBjgL1FiMyZDbfR07HBi8LFwpTuWVRiqHMzxOFEclRBJVc3sXR7/1kZU4rs5rj5D3MC46bmxeh4/P4JF9RiQbblW1+moQ9xajiimXVU06eVxzgB8jlIZoTCjcSLVk/c4cM71eFHMJiaZrTvIaElddQTV7kl0ck/sbbko6ZjfY1anA7/WOpa96leW7xZLOJB8U851Tu0Za7UR/DHmThI+cZS2/JgdBDFORRJf8JM4RctHg3BMwOaumhhYdtTCJU3O5I+vnEXi+2ooElNf0fzuxjvRqRjFD8f8hhKrT4SpCxlVJvj7gi4ABZ7tJ8uXndB+aXgyQWM9v04QmOF+hM22AbR0eeRxqMJLOMPXLwttU2ODb7JBReqdw4dRYCMSvAvol2/26hgbBF4UPFMz2J6UdeVNQAki+rtizQofMM7LqYsr30YMy0p6tqNCWU1Rx1fZNFpL1+imAfhAHZJP3WtILxC/j458LjBr+HKFFmB8C7tIOIKAQaKr1bCvxxJeYkLPVAVxcATlkAlfu40iWRQXxYCERU8mii5GAkfX8snzIGR3U0D1mKkLE8ruh0JVtXUErvqiKUA5tdLOqfjuNdYufB0HBrhK8XxNmg5ZdI/2WG4myDyW43n2Vg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e10aefc-96ad-46cf-416d-08db8c42a777
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 12:36:51.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDlyWViR+Pnwc6RMTwnBgUkLLs82pc4zPVz95acDOPGfWe1uvNoLfShEhGyy3DWGX6V3tAzbtQjXHvSM8s/ufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_10,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240112
X-Proofpoint-ORIG-GUID: -5k_ZIJFwuh_tQwYqhHG1pQok0U6Opy3
X-Proofpoint-GUID: -5k_ZIJFwuh_tQwYqhHG1pQok0U6Opy3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24/07/2023 11:32, Timofei Pushkin wrote:
> Dear BPF community,
> 
> I'm developing a perf_event BPF program which reads some register
> values (frame and instruction pointers in particular) from the context
> provided to it. I found that CO-RE-enabled PT_REGS macros give results
> different from the results of the usual PT_REGS  macros. I run the
> program on the same system I compiled it on, and so I cannot
> understand why the results differ and which ones should I use?
> 
> From my tests, the results of the usual macros are the correct ones
> (e.g. I can symbolize the instruction pointers I get this way), but
> since I try to follow the CO-RE principle, it seems like I should be
> using the CO-RE-enabled variants instead.
> 
> I did some experiments and found out that it is the
> bpf_probe_read_kernel part of the CO-RE-enabled PT_REGS macros that
> change the results and not __builtin_preserve_access_index. But I
> still don't get why exactly it changes the results.
>

Can you provide the exact usage of the BPF CO-RE macros that isn't
working, and the equivalent non-CO-RE version that is? Also if you
can provide details on the platform you're running on that will
help narrow down the issue. Thanks!

Alan

> Thank you in advance,
> Timofei
> 

