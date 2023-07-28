Return-Path: <bpf+bounces-6230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247747672DB
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD5F1C20CEA
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48096154B2;
	Fri, 28 Jul 2023 17:07:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCA154A2
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:07:02 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151891FCD
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 10:06:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4ZVN018446;
	Fri, 28 Jul 2023 17:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MOHbbpCr3cRwx/1A/G8WBA8HMV0CFJEi31D5XecdZ5A=;
 b=KQc04O6StG9Bt/X9f5n0OuZh2xPkEIv84eahKGMWfxY+CcLUeV9RYZGkT1A0YU8VYly4
 qthKbziW7QuT/t4nQQvwjbrAUg5o8Awm5eBAeTe+WDkR9e9HdzoV/og3St+6EGxH4nla
 6ruEqmq1Pvsj7Zvi0s2CyV0WVq3PNJK4sbKfOFnCC9k4xBalf3K7A0KKdMzPk0rWYhFW
 Svk7qEkGk8OhIAp0sjx6LG1mJ+SvRuN/VTF0eE2qQ510Lph2zMZCfaOh/u4g3ZHAE5h3
 TLKN2MHUIxoH0AYbCEAey5TV2LwTJAaU9z4uBE9wbShO9D/nu0UOh6UDPUhNgCePjmoO Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3vbq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jul 2023 17:06:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SGpLFt030405;
	Fri, 28 Jul 2023 17:06:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jfmq1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jul 2023 17:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSn6YurJMg5vVVaWE2RVdzhLDS6ZRsnZYDk82PGE8XAS61jY61a7DIfpWSFs2UsKnKjP9fIq2P7IOKIYFcJ+I9FF1yBpzaa9rWgvp9/3A28FfrbllfrVQYem/g+G995XJuShA16RBYunHhNImzY6OzaOQoeLSeY0cIHBxs8LG/IWdivM7PqbXQxqbtO85GdBw6sRxeUn+s9X77VtHnWHpeJTOU+rJgKgG36MSBnlkpylz0bioU1P89ihsfy1DNwBiODUiOBb473eL2DLyWEC3FU8y/AyH+/OfXmha33ghJfy5fu5jftX1BHGnLGr0DGKhfLT60SefC/4TjWT0mC14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOHbbpCr3cRwx/1A/G8WBA8HMV0CFJEi31D5XecdZ5A=;
 b=lHBxN0um4rQwciCyhzPgS8X5duUoEcTmnAE7Ph1GAIb55dLKOOQZTNV8l0ylc2dZb80yVjSg4OULZ9cwT6742kJFpH4Ps/dcb9Q/4dxjxDeviHcNxBSlUQ2Yqc0F+jhq76V4wT/sXqWftSUeSoJMpbsIE9zy83Aw/k2FvzxHjbQZ26KR9MIok3qGwjdEniXJ/lQwrfX8oZRcp1OiUPuJst+fenvn80rY0ZneABgBE5AhIRKOfumQj6dbMUmqlFhy00d5sm1fspIvJH9uaXxkoRVcbdMJUpDp/poH7AM/92caEU1PSuxOKuT0Po96JCXDfh4WK/7T+fN1XNa3OEKn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOHbbpCr3cRwx/1A/G8WBA8HMV0CFJEi31D5XecdZ5A=;
 b=R6fdBxv6JexZNzeoxD2KMRN84YG0TM6WZmD1UGaiFvXixwgXvE3GaGeymVRfg+wvXHJF8MB54Nk6T25RgGCmKcx8DkaMSBKQwYTF0lrtYuPKZl0SjpMBp7XKVVfeVrcuzxSh6zHihXMQDWLRY7uUQxRVDOYGgwW0qvF0D9WOxds=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BLAPR10MB4945.namprd10.prod.outlook.com (2603:10b6:208:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34; Fri, 28 Jul
 2023 17:06:55 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 17:06:55 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Subject: Re: GCC and binutils support for BPF V4 instructions
In-Reply-To: <CAADnVQLG7WY9BthOQTDQ6UkszJo5HDiGSjKO+jMKaJ+02G90QA@mail.gmail.com>
	(Alexei Starovoitov's message of "Fri, 28 Jul 2023 09:47:16 -0700")
References: <878rb0yonc.fsf@oracle.com>
	<CAADnVQLG7WY9BthOQTDQ6UkszJo5HDiGSjKO+jMKaJ+02G90QA@mail.gmail.com>
Date: Fri, 28 Jul 2023 19:06:49 +0200
Message-ID: <871qgsynh2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::18) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|BLAPR10MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1287a937-0996-4d33-aadf-08db8f8d0bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	j9pKBMDhp1jUIO40EM4L84BO1RQ0OtLJ6AQqW/bgWGJ92hO1wgioG7iHfmlMOhXCAKeEFLsAsp5HahJYMzzBM7DiY42JDus3oBwY1rynjAG1joW6IQWdSDVtHWH9DSFuUj/T1PrYagkmOVgO6Wfn/ZbNSagYFiqcdHGlKFEG4DG+s5T7aWcA6bwrTHTZCseysaudqEF/jjhVMTfUlhsue5/Y/l7aMWcR4KKL9J+eHhMpHqmWR5TBsv2PuB43Pxz7dOXCDOAVqciF6hPvkH64CN6i1sO/N1i4I37UC98Bj3GRV6oj1lsjUn7nx4ABG/9gKn59fY4kECvoLzvLYQMHZtQjTQZv3aE7J5LVfO/QnVU9v/VewopjE81f7pcOe+bje/iEq0vBsEt3HpTO8Wa1cAzcE0l7dnuhH0wjGA7uQnTZE3P+FjByPTQbWVg3l+P4mXe6dQ7G3oboN7Uqndln/z+hDKvmmM/BBTIENagtnC5EFXFczqa6jxVpe20HGB1nfLxvxeDxyoK01m6bEY+b5r4PiYXf/iqzvza/bsytk+s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(83380400001)(36756003)(2906002)(86362001)(2616005)(38100700002)(41300700001)(316002)(6916009)(6512007)(966005)(4326008)(26005)(8936002)(8676002)(6486002)(66946007)(66556008)(66476007)(478600001)(6666004)(186003)(5660300002)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2NNS25CdFVPOCtMaHp4QkVYTVpCTEFZaFo5cG9LRWgyZEtGMCtDOGE2Lzk2?=
 =?utf-8?B?NkVRa0NBdmQ0eFZoY2lFUm44ajc5THphRFAxMWZ3bkhUNUs4NmFuT29ZeGxX?=
 =?utf-8?B?QnBKanB5OVdqT0FMK2pJYWM1L0ZzQlptSTZmZG5lZkhiUVBMSGJqRVZIS3do?=
 =?utf-8?B?M25NZGNzNzZ3Q09qbytCNjgvNFdWY2hwbHpTU3JnKzMwQjRBN0tiV3pTUDJh?=
 =?utf-8?B?NXZBVnU5bDRSYlFFYWhqRVVWOC9DOWRTVzVzMmZCd3dlbEZERjl2eDhZMVhv?=
 =?utf-8?B?TzJreUJUQy95cmhJL0JYbVJlb1NqZ1paWmhpOU1WNDh4K0xVUmY1NVc1enFN?=
 =?utf-8?B?bnZJZXF3Y1I4RDdYd0d5cVZtR1BtVWN2TXVFZndiaDdPTldGQWpjNmJ1NUh0?=
 =?utf-8?B?ajVsVWYxbEhGNTBENkI5cCt6ZE9DOTFEVkFmWVdsdVhTRForMHV0eWF6ZzQ3?=
 =?utf-8?B?Vk9wZHJ2R05TS0Q4WWIrcjE5bFVCdzZzTnV0YU41Um1mQmo4MVpZZVZTSE92?=
 =?utf-8?B?T0RoU01aUE01bmhzVWlmSVppSjZobTg4YUxRbWtwM1h4NXg2NzFmbm5uN00y?=
 =?utf-8?B?SGZqUDViTUtRcEwxVzl3VzlEWVZTWkx4MkdyVUlKSnJtZi9nbDBPVG1lS2VI?=
 =?utf-8?B?dzA4dmQ2ZTBTb2Y3NC9oL3NXUkNMN1BHVU1odkxtcGpqZktWWVZsRWJiTjND?=
 =?utf-8?B?Z3JHVEdSYk1uNEoxOUw0NzJpNmtIZm4yV1luQUI1bGx4TGQ2RW1TOXZ1d1ll?=
 =?utf-8?B?R0NaTzM1dm5QWVY2bUQzMlBaTXJEUWQ1REFINTVEVmpRRkh4dG4xRG94aDZm?=
 =?utf-8?B?amdubnRSZklwOGU4Y2NRUUdFSkp0aUhDcmhmSkZyZk00QXM1dnAzNUdVRTJn?=
 =?utf-8?B?Qjl6emtYQ0RocDRjQWFVd2xWamtNZW5RL2Nqa3E4eEVPd2J2ZTBqc1dGYzhu?=
 =?utf-8?B?SUlVYk9DaU9WdEtsZWNvRTV0QjhJK1hUUDY3ZWl3cjg0NlZQUXRBalNxLzQz?=
 =?utf-8?B?dnd6SUJBcDlmQlJGM3dWQmxUcHlOdmhNRHNZcUxwekt6K3kvOTlzZ2d2TGph?=
 =?utf-8?B?VnBPQXVFVHphcFpVdVZmL2xVYzNxN1R3TGdPOWdIbkwxRC9ld0RyUEJoUUYv?=
 =?utf-8?B?QmZXTlNiUlc4RzBScm9JWnRONlpFOWpPQ1JSRHRtMDNQSUJPR1V5RC9hZkxQ?=
 =?utf-8?B?cDlpMXh1ODg5czFZVlJING1RazkwT1pFd0lESFB6MGk2UXJqbnZRYmhoUG8r?=
 =?utf-8?B?aFNBVS8rL3VkdGJBQmNsVEJyUW1aYWNycGIreHI1VENpQWwrV1hyYWJpYUds?=
 =?utf-8?B?aS9oZm5MajlXYS82aVZzVU0xZ05mZWxSb2MxT3I3M0xwNHRzdDFkUUJrZUdC?=
 =?utf-8?B?SFc1ajZuZjFjQmNlVmJDQ01FUm52UmtLU0szd3AzWkN0QlRsUzJEeEVYdnVO?=
 =?utf-8?B?ekYzL0hVK2VVNTUzZTQ0dzh5cTZndU5vM3RXZ2JhbkZUYTNsMFRzSTMyNThp?=
 =?utf-8?B?VlJGQmlydVFIUW5SajdTYWl0bFpxOGV2VTNuZmg5QUc4ekxmeXNnZnQ4ZDAz?=
 =?utf-8?B?SmV6OUhpYzJON1dSWUlFMzc2Y21TSk5VbnZnSldQVDJPYTFLWUtnazJWU3Rs?=
 =?utf-8?B?MUtFdk9adEdtWXhhZjZKNDQxbFZrQXQrM3BkV2RSNk56UlFnMDFGTHRHalBP?=
 =?utf-8?B?ZkpsUVJpZjlaZkkxSWZlUGhEMi94dERuNWsyWC9Ed3czWW1CbGlwL2VuV0Mr?=
 =?utf-8?B?RFB6cU5JNzBndTZES1VXMFhXSk1uNnBwcTNUam45dUV0d1M4QTdyc3pqZk1X?=
 =?utf-8?B?SHlSeU84N0JuOURycFdLYkRMbllEZnQwT0ZJWlBKZjRzMDhmTHEwaTRwMTR5?=
 =?utf-8?B?OW9ncW1TU2RWWC8wTjRzL1dDSUorZzE5VTdNV0dmclY0VkI0cFdPRUFqOENp?=
 =?utf-8?B?MkFQQ0owdFNPTzd4U0VjWmJ4UitNRTQ1cXFTQmN1bzB0SVNkODAwVlZGZ1Ex?=
 =?utf-8?B?aEprSFA2emg1UVpvSGYrUFV4MURYQTRlZHIxakkva1J0OGM4cVliYlVJOU8z?=
 =?utf-8?B?MERhSkk3Yk9UYkJnWXFrZUtzdXk5NjFSZEJ1Nk5aMDFibWg3bGlER2R2Ly8z?=
 =?utf-8?B?NzdTVmFKT21VY01yb1Q1dDkvZmExRHlPVTNPazZveXRBRzYySms1ejJsT2Qr?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aglaP3UKI5tNZzi61qHuc9rn33NT7jnMfSRngycogw23y2TJsBxO37GsyE2lY6sTrKbqf28uzYnLa0uZHbmj5DY4J+gz8mqxkrxAC7O5111gaDyGxZQMRL0AypmBKXxqPmGsNjed8Wgr+upfRPS0tz01rYcV80riQVgZCkwDWKWk0dG4fDFuwJ/AJNtV2yjuYQYjhtlryrb7q3tTRbZcWEzZ+QJPxU0XfhW78Ll5+c/0xydaWkzuzk0orOQTrUGR03DDElHlRK3ihzDrMQ11qGe0a5oOJI21QmJnf6tDedbnPcXgEnlSTvCqcb0V0xl7VRcFhvWznZO2Y44yg3BRLXqjIcxJzJqi8cBxNVvL8ZeI+boOGXbFpdH+H9kU8laZbGbui33zfczQXFZr+cR7r9hZJhIrgPD6N7Z0rHrE/Qa7vvrBQxMix7JbYHVjYermotiumGbDVBkZ8MqlsOFwp5YFAX5AUd/akGgW5rAKg8Ix6Xbv5HuS26ikUBybcgansNOdcgtS7LfaJuJGfrIuJb0rqHK4iOrW1NCH/euheNQSHgFymGczh4tW5KDwxkOa63IGQ9L5zG9LaWZmAYl65UjjEOKTV4dmsva68YQ3SZaAAU9bzgOCJBj+0rgxE/GveG+ai4+iigB52gas1L2gmWhWXsbfoiyv1IqJ/hYHF+Wht2EdKXBxRL0zRWdQvadAmJiaJwzx8CFspGMDUOuDa4GoLP3OvQQ7rhXIAn3zTZbXOuXRvXXbnY7DVqCoHsBHtOmNr7i7jAs673ZcrIEixjtcaQtx0lC0iOeXDFkdkSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1287a937-0996-4d33-aadf-08db8f8d0bda
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:06:55.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyBzPTjkPvx0yrbgU5WmW5BD0oUnJoPRkU/LIIrFrl8AlMRa15b48Au3NvNxMZ/nbUaR+Jk+6MXG2cGf0R8BBlV4ZZhF3hovtMrkKkAAvhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280155
X-Proofpoint-GUID: bCokHst87MVAbHrecfs7UoL64fMBY0TQ
X-Proofpoint-ORIG-GUID: bCokHst87MVAbHrecfs7UoL64fMBY0TQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Fri, Jul 28, 2023 at 9:41=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> Hello.
>>
>> Just a heads up regarding the new BPF V4 instructions and their support
>> in the GNU Toolchain.
>
> Awesome. Thanks for the update!
>
>> V4 sdiv/smod instructions
>>
>>   Binutils has been updated to use the V4 encoding of these
>>   instructions, which used to be part of the xbpf testing dialect used
>>   in GCC.  GCC generates these instructions for signed division when
>>   -mcpu=3Dv4 or higher.
>
> With sdiv/smod implemented do you still have a need for xbpf flag?
> Anything still missing or you can start using -mcpu=3Dv4 in gcc selftests
> and remove xbpf completely?

Just `call %r' (what the clang disassembler calls callx.)

>> So I think we are done with this.  Please let us know if these
>> instructions ever change.
>
> Fingers crossed, they will never change.
> How far are we from running bpf selftests with gcc?

We are getting there, but not quite yet.
See https://gcc.gnu.org/wiki/BPFBackEnd where we track our work.

(The CO-RE builtins entry is basically done, but we are still polishing
 the details before sending the patch to GCC upstream.)
=20

