Return-Path: <bpf+bounces-2418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A868872C9CA
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51F91C20B6A
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2C01D2DB;
	Mon, 12 Jun 2023 15:22:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09B1C757
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:22:26 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545819B;
	Mon, 12 Jun 2023 08:22:25 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C6e4qn021411;
	Mon, 12 Jun 2023 08:22:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7esx2IBIFF+x6IWC+tEgOB9fCulX9ZySgvwgWy1gHug=;
 b=Mwq05S7WPe403DTL2X36NfgVDZkT6HA5ZRjDQsTNFxQ3FE2r7pVEA6oE4c9jvO5iHFLe
 S404gQEPCX6U5VceqF+u9HbmK7VCcQznDFo9zcGVUT8cSrXqNJW3CkPDzgIrkMGoQvN5
 xNw6I3T4iCjPJj+BsacPRN9BnLBJZ4JiXAxeME0RtGu40qmG/pKXRH2gAfcT+19Bm0QF
 AzoZWUeZ6SzAXxh8Jeftp6AQdnvC02EjDD0qlKdV70cGrU/06N11j4Hd5YlBhiL++mMR
 t1y85lZBK8Xjb5hxivOsgpqOgo37o1A3aNfNTIuUghcUNYqSo9T/+YCMQLUbyQ9FTbeS Kg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5x9ujv1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jun 2023 08:22:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEM+ub8nlxYjDsLYPKBvRiIRANWZM7gd8Yauzv1THwG9eNg8kyIUJyuDTWtOlu8yK3Lzo9N1NP722+ivGpfGqKvywyw6Bj3XPHdPR0zY15tJ0EHO3fnn0nC8jIK0aSr736WR0AlkOTKYYsMdVdua116f5zf3A+SNbMzDZMs/pJ6PVG7xyzYViIXFFwfj0yBEwcBTkEr0BS6DQqZswW3uwGPIMVOf8JC16nPQ01/eTNyfX/AZnXzKVQDX3WMj1/HvSNoEaqKnTww3FLLg2pt72aXI/hEylG1xIA17XqKt++Oj+gg56qNoOYICrysJFAAuJ9ySh+F/zgTxVGikfdiJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7esx2IBIFF+x6IWC+tEgOB9fCulX9ZySgvwgWy1gHug=;
 b=fl5f7nPrSDoqCXNSMVrAcJ7qo3BKyEHZNyxaaWGuc8Pz/YL1gXqpLiwatNqijVqO5leq1Ss7zHHPyRT4lqLhqtXAt4BszvhL21wifTTvBy7YYazqZ7qAf7gkgqn5eSB0DB7Tq8x/h+CaJFYRueBUEKsC/oh78B+xrbvbiq0L4fezEJVU0oQKbBEQhlfh+YVLsf2f5QJ+IXm8zp9kDGcqxDpyr29mwod+cprqicn8HfSIWCQ5a0w5x76MEMxh8T52Ac0pjxyB7nbpafGQobwGc1WxZ+DmfFn+vpwf2SvcOnFGx4iKf7wuxVb6QqKbiQt5QxryV07CAg2uxgZ2DxQuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB6067.namprd15.prod.outlook.com (2603:10b6:8:125::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 15:22:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 15:22:04 +0000
Message-ID: <6f4402cd-3f05-373c-93c3-581491fd5116@meta.com>
Date: Mon, 12 Jun 2023 08:22:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next 3/5] bpf: Replace bpf_cpumask_any* with
 bpf_cpumask_any_distribute*
Content-Language: en-US
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
References: <20230610035053.117605-1-void@manifault.com>
 <20230610035053.117605-3-void@manifault.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230610035053.117605-3-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7a29a6-f94c-4ed6-c1a4-08db6b58c73f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GKJpl7vWjH7KCSnvyQ9z5l1o2I0u0BF9+LE0ysalvbPgZN+iKswtb7sD34vgSXPEFR5nFGGCkQYyxyBFAswKY7b9fggOvzc9CficywzPwWBYPLvCN5U/xjM/4q/689rk8BOR7H7m0IbBzkSdLbAJvdcnArv8b8dpXbVm090Ju7OX7gbyXNC3MjqWCrK/oDsWqlqRm8bIRUsqJnA66Vyqc4XMEfKYZwKouu2yBvET8MwbAPjL8uUs8QL8EkbMnd2IwTJoxN7+Z/dZ9GkbTuV6FY7+NWgxWyNFWc44H3ECCTS2KX2SSbFkUW0DIhOWViqd3hsCJW1AxlH9hFTdJcdWlxJAws+GLHZBnDJh0A8ccwv7DVov/5xXQw2ybmuL6P//xWNxfjPa5MrIf4SVmvf5cX/UX6oX0FlzaufjP1dzVq+6PMIERCn+aw8asxBigFYSyIR3yUbw0k18JsPEK9hcJyyZN6vF8I69AJePSbLqkSZlMmxNkdYRg8F664IPPKYQ0faKw+KPX/nK21ym3F+XTaiWwl8UFtwJwoolqZnyQ1d4JQfeKadqWNxavIzHPvf6v6U95x5wBC8oaamYXC74BHPJpSFL6PHlVVh2SEvh/X0ibTNyq4fG/pI6Bx2Zjx7B9qFMSojmMpfcMTLkEWV3wg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(8676002)(8936002)(186003)(2906002)(316002)(4744005)(31696002)(7416002)(86362001)(5660300002)(53546011)(4326008)(6512007)(6506007)(36756003)(66476007)(66556008)(38100700002)(66946007)(41300700001)(6486002)(478600001)(6666004)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnhNajJBTkw4cFRpRWZZY0MrTjFVNE1vcFBRRU9qb1Z5QjdhOWZxQlRNb1Qv?=
 =?utf-8?B?NTBiMmFaVDRETjEzSHRGUUFVMDAvNzJib1BucmhaSzhFdWVZWmw3UWwvL2RN?=
 =?utf-8?B?d2tzci9TOVhnVG1lamNqSmlieGp3U3ZjYys5ZGZ0L20wL0U3SHN0Q1F4aVF5?=
 =?utf-8?B?TjJ4aXZMRld5NXpia1BuOTJXbS9NWGc4UEZYeHA1T3Y2RThrVWlpT0h6Wm1G?=
 =?utf-8?B?M0Z6M3VHS0NwTlBZSm5LWUEyYnU2NkN0YXM4Rjc4UFE0eWFnaTYybC9jbkFv?=
 =?utf-8?B?NDY1OHpZblpmaThWZDN0T0RnQ1VWY1RlclVmZnAvOEJ3MnV1SlJhYjlTNEw1?=
 =?utf-8?B?WjBCSHVnL1IwVml1U0hKcE1rZXY4S21OSmhOYTRlajE4TkJNQjRTejQxcFRv?=
 =?utf-8?B?eDVndFd2MmxLWUE4OU1CNW56VTd0d0tMWmxhZEpybEhkL3VjVGhRODJ6MHpi?=
 =?utf-8?B?aGRSSE4zdjVvNlhzc2FFcUFUT2FQQzRkWDNJL0dBWXVkaHJ1Z3pKdnJjSFda?=
 =?utf-8?B?Mk9iM3FhdFRQZnU1STd1MFQ3YVg5bnduNWJoTk4wR3N2Z3lPdUhaa3RQdlJq?=
 =?utf-8?B?ejhJdXdncjRWY1ZpdVRMTWxpZzZQTERaa1F5eDFuRnEvNmRaL2dQOWJ3Ymh5?=
 =?utf-8?B?SGliTFRvVG1NZmVPYVZhN3IxU0RUc1JvV1psZjU3U3AvY3ZqekZNNVpNTCtl?=
 =?utf-8?B?YTBwNXIrR3ZZU001OTBwZ0RwazJhSDREY3FaQWJNbFNnY203TXk0STRnY0Fk?=
 =?utf-8?B?blFMWFV5d08vb3puZUdWb1Q1MnE3dUJVSEhSUkd3Qmd4SHg4UVJ6UlBRc0VX?=
 =?utf-8?B?QkFoaGY5ZFJGVzEycmQrTE1lVnpHWFZMTlh4VXhWM1Z1aW8rL29UekphZmo2?=
 =?utf-8?B?MDAyU1NvRFhQSm1PeEFoMEFEdlRDaXYzVjRSaEE4M3A3RHJWOFpibFMrd1Vx?=
 =?utf-8?B?UjEyanZ5QVBKQzNiQXlWRUkyM1VsVTJjT0d2azJaZUpRcVliWVFrQXJRV1Zy?=
 =?utf-8?B?NUNEV0t4WmRwbm5UbGtXam11ZlR2enlxdksrNHV2LzF4RnFYOUpqa1llSHYv?=
 =?utf-8?B?OENyVmIyVi82NURUaUZpR1V2ZlBselJZMTlaSEdpTWhXTFUwZUdtVHlLVGZN?=
 =?utf-8?B?RGNBUTNIMG14M05vM0NCNmtVWkxXSVBCbFdGaU43UW9BakZBR3FIZ28wMFZQ?=
 =?utf-8?B?ZUpTUkk5UUVMclh0cldURXJtTDU3ektVdnhpdW9FR2IrODhITENJWWRhQWVn?=
 =?utf-8?B?RjJ1cXVWSkxncFdLNTVFQkMrTWtTMlpqckU5OTVQd0h2em52WkRVNEllRzZn?=
 =?utf-8?B?aGZvVDlVYW5CTUt5cEh2OWV3V1htRVk2V3c1RDcrc1hDSGNjVWphZE40dnMv?=
 =?utf-8?B?NE9vMWR5bkVtTUo4OC9vdlk3MWwxTnFYY3VUWXBsTHNZWUxVclFidHQ3b1ZQ?=
 =?utf-8?B?U05majYzQUdDQk9ETnZVM3ExelpQak9wUzVBTnl0cWlIS3luUHlZWmhza3hI?=
 =?utf-8?B?NFBrV1AwcjZES3JOczkrTHVJV2pxTTUrV0dFZHZCenFFYlVvd0Zrd2lQeE1l?=
 =?utf-8?B?R3BKM0QzSXhySkZPWERyRFFrc3UvTVRkM0VodTRuUnhFRHVtWE9aVkwzanoz?=
 =?utf-8?B?eUxrQUpiWjZQLzRZeXBrNU8xZ0YwSTNIWUFhOEV3VUZzdkwxbmlybFpITjdC?=
 =?utf-8?B?MURCMnZYK3IrR2p2UnNyL1c5OGJvUEpjU3hJTmdxVHRZdDIvYnRwbzZoZWhs?=
 =?utf-8?B?ZXJGdHJDNy9HYmdvSG1uQ29zUmNKY1ZGNm5XY3puMFhHSnZhNnBXaUw0SC9N?=
 =?utf-8?B?cU42cm5vT3lUbFVOajNzN1M0T3lsY2pMaXZIL0tYZVdqbzJBN2xsWDI3TVpl?=
 =?utf-8?B?TkVUQ3NvQ0VvRHg3OVd5eEFFbXVPUWVOc25hNGtQT05xd25QS0V2L2VHNVly?=
 =?utf-8?B?UnFHMC9zd2h4eFVvVTFrNFI3Rjg1d0h0cEZMSjE5MnQrOUt2K2pZb1k4Ym5G?=
 =?utf-8?B?aGdjRThBRzIzREdLSC8vNTNpNVdsbVlVTlZWdVBrakdqQkFDSHVMNklMOTR1?=
 =?utf-8?B?RDFoN2ZHQ1BWK3c2ekROcUlqY0ZEb0FjMmlmbS9FSGZoVE00blM2SlBsTWhB?=
 =?utf-8?B?c2UwQ0tVdGpiS01WaUFBeTVhUVdIdzljeU1JWHJTZDh3dHJZekpEZHV5NUM4?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7a29a6-f94c-4ed6-c1a4-08db6b58c73f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 15:22:04.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFrxh54B6MS+8ubYCQ3j7lRcGo6POF28+B7dmpYoNKvP0sp2K6I47PiUgkiVsA6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6067
X-Proofpoint-GUID: DkmqHRpKLNRZ7CoCVl6rA-FiZP6Gr2KH
X-Proofpoint-ORIG-GUID: DkmqHRpKLNRZ7CoCVl6rA-FiZP6Gr2KH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/9/23 8:50 PM, David Vernet wrote:
> We currently export the bpf_cpumask_any() and bpf_cpumask_any_and()
> kfuncs. Intuitively, one would expect these to choose any CPU in the
> cpumask, but what they actually do is alias to cpumask_first() and
> cpmkas_first_and().
> 
> This is useless given that we already export bpf_cpumask_first() and
> bpf_cpumask_first_and(), so this patch replaces them with kfuncs that
> call cpumask_any_distribute() and cpumask_any_and_distribute(), which
> actually choose any CPU from the cpumask (or the AND of two cpumasks for
> the latter).
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yhs@fb.com>

