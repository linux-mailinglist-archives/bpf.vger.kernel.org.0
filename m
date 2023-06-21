Return-Path: <bpf+bounces-3046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CFA738C6A
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224091C20E17
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAAA1992A;
	Wed, 21 Jun 2023 16:55:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A919900
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:55:42 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1144610C;
	Wed, 21 Jun 2023 09:55:40 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LBEw7S007052;
	Wed, 21 Jun 2023 09:55:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=suNQ1P0ycBvRSV4aTnxP1727DDPFg2lHH2tI35zApqI=;
 b=XAcX8qXN/OBKWujMlxmDZYB1lpho14wPIH7/N6us4QEmHstNiQdrk7NLUq2wDr2Dq4yn
 MjE821Csw6jP2Suka3IwzPQCyBi7ea24kUqIQ+ayu787EWDSNu1SRPIa1F5vyhvxj2up
 fOznHdOoEYU1TrhaalAMxecKTkhI5ofmZGwE/TosK83DI8TsIyR3a90aP1wI4DF2dg26
 Z7UAiD+VQt9kvAc+L8uu+GAjkLI2/eIYoCWCwUYhwy6hTjg/7RxmfcALCt5uhnhyAhe+
 3XDToo671JGX3e0ZryUAATmpprfYq9m4D7er9Q/R7CxuC7aOZ1FMw0zOXSTFf29BXCgM NQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rc05htk98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jun 2023 09:55:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdQLYWgZm7vNgeXNT6Y2Yv7iNK1nsNoIt/oDjag5LmM7vThgVgIrqKx8MZHUsEX84Pyu83BNvElGRPA7bJQ1c/rRDAZl5War7MWPDYyAi4sFCvoRRGkib6zsR8mDBwMUPEQ891R+vPkUtveNAgzDZhaIWWVYWrtZQLDIr8qKIoVMMt4nH0U20olgJihvfxGuxsEQ7f2dtjWf00jMZf71FFz0koFvuXdT7QHPGPgrp/cnHb3MI5vCKp3p9IErBQr3yn8QGeVG2RTqq22y8G9jAxpYqice8CQ7wJ8rsSNumqwE38UGRDizIalRc6dakbVw5RlYkrpSadGFn0gdFh8Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suNQ1P0ycBvRSV4aTnxP1727DDPFg2lHH2tI35zApqI=;
 b=GUEHz/0R/lVn9TgWV8H8qz7m3ivUec1AtvxtX+3+W0vrYs1cqAZrnhiiMiM0ZfGwWo2fFxTwoHJyPu+3tt7/v1x0iZrc27r+e4EzjwaTIN/8OAh0IF2VWWSmnqnlOKEv0I/3MUzf7OzvRNbygbL+y8hLr18awFfgkc3L7eND+PIrcIeJmnImRNcMq17hzxSVJB5F8GHvQnTerxIrrf7Mr+WCJIelf0nzf1CmB3Mw6aywOLhBfvWLCIJIIkENWqsThj5A6Q+UQZRvPdi6ESsW5jorOC0rwj4n116WN8i3ws8SP0qlxY1ORh1yEKinL833pM2P2mmcDUxGxcViGkQ9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3788.namprd15.prod.outlook.com (2603:10b6:303:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 16:54:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 16:54:57 +0000
Message-ID: <a850fe4e-4f67-7209-4793-731f3d88f1f0@meta.com>
Date: Wed, 21 Jun 2023 09:54:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: add testcase for TRACING
 with 6+ arguments
Content-Language: en-US
To: menglong8.dong@gmail.com, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
References: <20230619114947.1543848-1-imagedong@tencent.com>
 <20230619114947.1543848-4-imagedong@tencent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230619114947.1543848-4-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: cf25864a-61e1-4fd5-f71b-08db72783e61
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mPexQf27+nPf2qw+IW6AtbcU7Gls3tyOrR8KkCLcxTvt+zTh7sSb/1Pr6/tVDISybxVcDh9Q0Ba0K0DJ6H30S54FbiY+dxfoAZhxYiQqimnwyVftYFwrSJ9tmhHOYqhai/GSKzY/1l5NJemApetN+qmrgpPoYiaAhYxhr+lqiJ+qAYgUs7KqF46LOjn42w/qDns6hQwvqZr3FwTAy6KmRN8azOXCC6Swg6aqmEU3iB0P7cgHzj0EeN5zgc8bFI/fyfa2qK6dFrwYLpOT/SfeG3PdmJCDZqRxv04YLCj5i1PhGs++R7/rT6Wl6S8N6iqNBJ7+T9x//TxE4w/gfQp4exGevD6gyzN2ClOGgyQmWAIw3NDho8zHPJwFElT+5+bgN4XStravnle3TWUSOs04ArMPvvrm+CHQCtP0NpQ3csz0OmJnwpwQRwfxNH2xTgAvVfg5XYts/VWKrCUWBFfdXqGst6kF3uivmR8EbrVoCkgfBKHNYvR1IP+ARqQyYV8+1zK5n4HtG0V+1raixJBcEULe1XeBIThnjpYw2L5ZjE3TESkjuRu7E1bg9F5xhGrv1tbX+cMH/S1GWJaVoKUdrh2EpadRBkbnsQxyuygkSCueo7KxQJ1OdmM/ThgEH3kkGJxQU/Op+Bm4PLYIcv5CjQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(478600001)(6486002)(6666004)(186003)(53546011)(6506007)(6512007)(2906002)(66946007)(4744005)(66556008)(8936002)(66476007)(4326008)(5660300002)(8676002)(7416002)(41300700001)(316002)(38100700002)(86362001)(31696002)(36756003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2xNQUZiL29KOFp0Y2R0ZERleUhPZ1QyWGFHalBrUjMvOFdLVzk3Z2hha240?=
 =?utf-8?B?eTdLczFWRmtvZ0Z3NHNtR0ZlUnVCcXFxb21ZMXJiaHRTRE50dElVR0N4V3Q0?=
 =?utf-8?B?dTc0Q1RRL2NQVjhDU1hDb3BBWDVpSlJDd3ErbE5adnpBWjRQVjBnc1JzVFVE?=
 =?utf-8?B?Uit6S0phVko2STVpZmhIMlVZZmZWbU1tSUdRUDVET0RkYndFMGJ3eU5iVGhl?=
 =?utf-8?B?cUFIOVFTRlhuc01ONGJDSkVyZ3oxT1RXVk9ONkpGTmZyMHlLRDB4d1dGdEJP?=
 =?utf-8?B?OGZSWGpzMlZRNFM4THp2aHVlazNoNkZ6aEpzQjVtdXB1eVBzS3dmV2RTaXh5?=
 =?utf-8?B?ejlpR0MxMVhyUnBXWWxPc1JIc3o2bUJRbDNsUVQrT1Vlb1dmTWQ0MXUrSUFL?=
 =?utf-8?B?TE9jZ1RlSlZqVDkxREtwZlB5UVNNY2k1ckNObHBxV1BNRW5RYURuQm5Nencr?=
 =?utf-8?B?R2I0STcyc1lqY3ppdEhTYW10SzFCYUxLWlZhNmxORlFTZ2YzNEpIWlRvSnJX?=
 =?utf-8?B?VVAxR09MemhXRmlPZmxxRGZGd1lpSHVKL2dBeFRFUXpwUkp5RExIbUhKZTZZ?=
 =?utf-8?B?TFBuZ2drYkpLUHlENzhjT2lUdzV3QnJVTGRDS2pxaWZsMGh0c1FHektUdXF1?=
 =?utf-8?B?QXh0UzNxWUdFdGJFYVU2TUl4c3pQdlphZ0s5dVRoTW0xTkVqZWQ2WmNDR2s4?=
 =?utf-8?B?NVIzTVdmQVN5RkxQdE81RFExQytoL3V5bzQ0azlmekdoQy9XcFBzZTFNM2Zw?=
 =?utf-8?B?YTZyRCtiZlFpS3UrQ0xKbFlMdkVQRDVTLzJzLyt3Rmx5M3Z0U0dRTXRxODdl?=
 =?utf-8?B?TGhqK0xDWUlQLzBCV1M1bEYzOG5yWS8yZFljTmN1ZkVLbTI5aG1jQk9ZZGxa?=
 =?utf-8?B?TWNPQm1XZXdIa2FBajNETXU4c2pidkVjUGtwMEQxQVlKRHg1aWIwZmhMNCtw?=
 =?utf-8?B?dmM5ajVYZUFvOStzRHZrYkhjTko2UUxJb2NIaGZWdzlIc3g1YkNMcHh4bWhy?=
 =?utf-8?B?UGJLSmFQSkRIMDVicWl0QktPNWhiTXVvdDJEL2Zuc1ZDeG9McExKUTFLOU1H?=
 =?utf-8?B?ZHkvYXAzUjJSKzYwTitpZmxsTTBpVDQvNHNLNlQ3djJnRFpVak5wZUJXS0FS?=
 =?utf-8?B?YzdjelZlVmFibWl0Yk1adnN4VTBOcFhFdUlVN0psZkZUbFN0NEE1dWxQSUJz?=
 =?utf-8?B?dkRlRkRJUmo3K3MxU1FxMm4rNFJjQjJBVjZTcnc0alJWVUR5VWVSWmxTZnFx?=
 =?utf-8?B?UVVoN1lNbWdkY3doYWR2dHVyY1FtT3NLNHAyL2QzdVJYQTNZVEFYaVhBTjdW?=
 =?utf-8?B?L3ErZHkveW1CbElPUmk4NHJYWCt4bXhrbFZpbkhwcklMdUlPRFc3cW5FSVg3?=
 =?utf-8?B?b2tBV0pJN1ZIRkZNbS9sY2pnYXprcnBaZHJYMDhTbkk2d1BhOTdrdnRHamdJ?=
 =?utf-8?B?bWJjL0dSa2J4b2N5cE5QRVhVbVEyV3lmZUFOQStvaTg2SGRLZ3YzNjhkWDFN?=
 =?utf-8?B?aGdJQVgzMG5PNDR1aHRrWFl5SDFPN3Jpdm82TnhYWFJOT1l5QUt5c2sybUJB?=
 =?utf-8?B?NWlUbS9VeVV2YXAxMjAzMFFSL2owWUl4aFEyV1lFMGtXWkFITlFXcUIxWTJS?=
 =?utf-8?B?MXprS1ZXb1l5ZzNHajJSeEJVWWllaTdQZFdGNUpPVFRBaEhGM05zZnJGTWpX?=
 =?utf-8?B?bG5aUm5Mb2k1dy92ekZiSWxFcnpxV1lTbHFkclhKd0J0R2F5eW0wWTV3eFFo?=
 =?utf-8?B?TnZNQW9TdFFpUjRQOElEUUE3R1Y2T1hWNTFvcXM4TFlRK2FrSkkxb0d0YmZR?=
 =?utf-8?B?UUhVU3pkYzdFY29vc20wNDV2MVBZbG5VYzdSTWU2NFppd1RoNXIyalF3VzhW?=
 =?utf-8?B?cHkvdmtIckdIWFJBZlNOaGJzN0JacFprZEUzUlc3YjFmTWc3VHNHWVk2ZzhW?=
 =?utf-8?B?emJNVmQ3Yk5POEM5TzJiSVB5bzFvbjFSbmhwRzBzK0JKU3RpcXZ1SnRSUDR0?=
 =?utf-8?B?bXYrbm1oVFpuNWp0eXdLT013T3Z2QzVreFZTM05MUDM2YVIvRmFBT1QvU0xw?=
 =?utf-8?B?K0N1NkZ2VklKclV0VUJta21kSGllcEpseVo5bXJlY3hvKzBwNG4vbFlGeXNq?=
 =?utf-8?B?SkhVVlhBNXdvVG9MTWdqMXIxRndMSEp4YmlRTC9LNFF2WWh1emE4NzdOVVNt?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf25864a-61e1-4fd5-f71b-08db72783e61
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:54:57.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOp2DNqAn522Iibatwg5rFYNvra5hiCba/1R0gnbhoMX3R4vqE+ed3x1NuLuGgnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3788
X-Proofpoint-GUID: uFjiFVECl3_H_NDEdea20NfelUgQ2r45
X-Proofpoint-ORIG-GUID: uFjiFVECl3_H_NDEdea20NfelUgQ2r45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_10,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/19/23 4:49 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Add test9/test10 in fexit_test.c and fentry_test.c to test the fentry
> and fexit whose target function have 7/11 arguments.
> 
> Correspondingly, add bpf_testmod_fentry_test7() and
> bpf_testmod_fentry_test11() to bpf_testmod.c
> 
> Meanwhile, add bpf_modify_return_test2() to test_run.c to test the
> MODIFY_RETURN with 7 arguments.
> 
> Add bpf_testmod_test_struct_arg_7/bpf_testmod_test_struct_arg_7 in
> bpf_testmod.c to test the struct in the arguments.
> 
> And the testcases passed:
> 
> ./test_progs -t fexit
> Summary: 5/12 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t fentry
> Summary: 3/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t modify_return
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t tracing_struct
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

Acked-by: Yonghong Song <yhs@fb.com>

