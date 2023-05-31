Return-Path: <bpf+bounces-1490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02B87176B1
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 08:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCDE2813A4
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 06:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFDD63D3;
	Wed, 31 May 2023 06:09:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB164A3E
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 06:09:10 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10DB9F;
	Tue, 30 May 2023 23:09:06 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UGZuOb011807;
	Tue, 30 May 2023 23:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=/bg3st2m2RfBZgSF21C6frsqiRRoDOI2uQ5lo1PIRXo=;
 b=YK5qtLn90AHm7a98xQ/Da6rGM1D505UKryAiXqc+FH2eNdlAUDGkbiuB+Gjz9f4zlqS9
 QZ0bDTMDOcJhRQ2heA9rS5q78EXfn2Lteq1xFrwPp5cmKItnDmThyya5DOxYo3r8jgck
 Ps9wJj4tE8ESxcM9M0YBa6T7B+S1Yz2BJLc5St08uyZcDskVkShEsxczuPhIWTlUalIb
 pvJ6adxUCGw+XsjaKHxuWCZfUoH2Z1sgUPIyAH/x9XhHkh6aPagGFe6zQP5zJLNHGGp4
 CU/sJWMNOjHWi8EhbMe4Vko7tGQFnnFOjuhGanl2JgApNbH3WC7ahu+YJso/xNqfCqiq Ig== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qw7mjger8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 May 2023 23:08:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwGN0qNWel91h/1ipmQp3BXDHwDEYLlwPp0meJH6oz6o+Sy/v+Q49scqaI+oddZ297GrwGi6QQiVcgGuXg+lo2NWLh9dIzll5CXmg4V5HWbpZLivWdYRMPa0LHWEh69j2O9QPKsqOd99ey6W88rdwRVsb7jB8j5M9hBUB2Ke0/8rKIRLiignDvlgQvv6I3znRZE88syYtsayxEcwZErwxIlibelWJUI8HzrNWT2iyjD7HbvsrGbL4aiL4YH9hJCxUlBJfk41DVPAsUtXGNmzTytGnmBzaCY18yHIvuQZ5sPPEnunqDnuPFqmF+MmAuZFeie1XKYKA4imxpTQA5nqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bg3st2m2RfBZgSF21C6frsqiRRoDOI2uQ5lo1PIRXo=;
 b=OiMcj76yt+1HI6netNlXaLzesqEsAeyvjt7ljOijC6eEEun7RAs9VfGfnMumd+X1D4aOwKUIF8K25wYc15eXNm8kp7HMFB7k+JlUIaQv4GFzyABtNMLB5w45mqS7KTUtPuXPxeQADCmzYRIGY5ioYUSOgccsX+25hvfo3iZDkl4kH+rLDwwOrTLhx5TOpMmS03UG2EneLLyYGPUgbMVmF3Q2BCCIY3Pb4Kk+qoARRCT8lv7oBApwZaGoxpPCrMAVYzHgczpTkgTYJomav6D2nuGYI//HCDohCiL8nqEHCX5V2eyHssmOo+ueLg/mrvgpUrY7zHO8+0wyDPEvAPqjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH3PR15MB6213.namprd15.prod.outlook.com (2603:10b6:610:159::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:08:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:08:42 +0000
Message-ID: <c920ff12-8674-0847-3486-35e63fdb546c@meta.com>
Date: Tue, 30 May 2023 23:08:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] bpf/tests: Use struct_size()
Content-Language: en-US
To: Su Hui <suhui@nfschina.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20230531043251.989312-1-suhui@nfschina.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230531043251.989312-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0184.namprd05.prod.outlook.com
 (2603:10b6:a03:330::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH3PR15MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 53530790-0f43-4eb4-fb47-08db619d7c50
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4geBexDk/IKsPFmuDlXiSiBA2Uy0sVKsfd6ecP20824DDBkxSnEe4iFKMNK3POO19TsGzNVoDneJ1PaYvMHWdUrDu6lxlmwi6IkE1jK3inQAp/wqF4oqlCoQmwEohALhA6Kv2q8PmqtD1uqEFO3X2X9pveKTn6dXh1p4uujHFd5uOZArKyOlvMrpvYE++NqIV0dbRqsELT3x05YULt5z0F+a5VoZhYHHx79UNtpod6eXThCmivCjAC5bhXwZvuOi171/403LFQfs62fLWOmS4wqSizQJBL95ZwjiNWt2IPo5YQkaFZ+ecOWxoGoSGy8chg8AwZ9x5l6lX9Fb5CKYeLK1jkcJj9n2ywC5Qn8QNvFgb1xydVD7WdaeCHTdArcwWuXDeSamRpN0flztcqhqxZJZylRvAitLZjOOKDSUcmzeCR7JGzvzTPbFGXpnKNYby9rr5Av7JPudlKsvpdsV0Jge+8GLh9dsrl/+jc/2FFeBPqsr7HLdl0HVMDqzhEqswcCZj3SU/FL6HA/yvVuIuijdPgRR33JLvTr8U9KdtPFsdIdn6wJ6nOsSlUnKwQgJvMLDO0QQ0dGBHOJovD0W/qxWooa3jZctMC310PixbvldRvUu+cYwThbNV8zas9FNlQVFPcuNjaVDNH1RMdTw5LmoLZt4FpWH6j/ietE/vvI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(558084003)(31696002)(86362001)(110136005)(4326008)(478600001)(316002)(66476007)(66946007)(66556008)(36756003)(6666004)(6486002)(5660300002)(8676002)(8936002)(7416002)(41300700001)(2906002)(38100700002)(921005)(2616005)(186003)(53546011)(6506007)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YnZ2MEVFdFMyN2QzUVk0VHhlZUl6djBqRG5CYVB0dkY1a1Jvd1hrVm5vQTJq?=
 =?utf-8?B?a25NQzUyTUoydk1wL2tLbEVLSEtxQi83NFk3VDZhcnNkRFRIZFR3dDM3cC8z?=
 =?utf-8?B?UkMrTlJDZ241NXBZVTc0RU5qQy9aNkpyOGdzNE9IcXNiOFh5VUxsQmFHZ0Jp?=
 =?utf-8?B?cTZBYmo4R3lwMFlmSktGQllNTUVRS0dNOUhGanA3cFNPS1RQQ1NURFcxY2hQ?=
 =?utf-8?B?Nk5lZm8wK2lxUEpZWklGMmFYVWpCUVl5ZjhKd21iMGZtV2NiRDVFQWYyOFUx?=
 =?utf-8?B?MkVQRllFYkhOL1lkWlRDR1VsdHNJNkFlNWNXUk83ZjBzV1hhcFdXT2VxZmlL?=
 =?utf-8?B?NTNBRU5QVWw1ZDMxQnJKTWhtM2lFYmNqNnhUYTNCTjJ3dnYxZmRFR1NPZDNx?=
 =?utf-8?B?d0pTOE16QUZlVnlOUEEzbStBNU1BSjVTQWFySG1ZTFNYcVlBTEIxdVVZS3VF?=
 =?utf-8?B?RFZpaXlCWG45Z3BKVjZlc0hlZW9WZWpxT012UFdYZ01HYXI5NWVxZ0RSdUww?=
 =?utf-8?B?Q0JWb3AwN2wwemZoNk5TRHF0VE0waDZMcWZzTDhzVXVESHN5RHpRVzh1TnRY?=
 =?utf-8?B?cS85VllPTVQ4UWs5dlJOOHkvb1VSOGQ5UUMrQ2s5UG93R05hdHZHbUszVGVw?=
 =?utf-8?B?cjZwUGkwaFQwRVhyNUZtaHBFaFppVXA2SzM5eTdHc2lLdCtLTlV0Q25oZ1FN?=
 =?utf-8?B?dnIxSDhxTVk1UnJWNHA3czkrL0RjVnBSU2laa1pVSW1zWVNva2RDU2R1Wk93?=
 =?utf-8?B?R0xJYnJGNzBYMmJrRjF2U2I4Z0V4L2pKRVErOWsrTXZqZlV4d1I3cDUvTFdr?=
 =?utf-8?B?aEt2U2o5bktEWmtjVHRSRzFQUzJQdTlvZ0RsTTRxeSt4ZG1QdnBTTnVuOWgy?=
 =?utf-8?B?alRzUGw2ejNhSUVOWjVjWU9WQjBLRm5qR0NTaEpaV0pWWmkvNHhxZFRHUU5M?=
 =?utf-8?B?WDBpaGlDN0ZzUXRIWFdKeW5JTHpVQjZiODlIS25WOGFka0RtdWZyUFRNa3VY?=
 =?utf-8?B?M1VMdTRVd0tKald4UWNZM3JlMURNZ1pLbWd5Rm1VUWZXc04wR1M4eXZ5dUZX?=
 =?utf-8?B?VlFCNk56YlNhNnErUU5hZ0hSTmVudkUyNGpnc2J5eDZnclorejR5cjJTRWw0?=
 =?utf-8?B?VEtxNWkvSmthaTdOay9lTVpGQzNxR2hxV2cxNmhoZHdmR0x6cXNYSUNITjJo?=
 =?utf-8?B?bmU5WWhsdjVFQllyVzlFRjNBcWpTa0FFOW9GZ2JqNkdpU1dsUWxFUlNyODc0?=
 =?utf-8?B?Tkt5WGJlRDk0eTcvZWxQZUt0NXQzN0FZdnJtMVVkN1ZTQkJBSTFjSi9haWJG?=
 =?utf-8?B?Yk1zZGgrUFMwVTM5UUdyVk5kQWV1aXpmVTduMElRSmhHM2t6TkZXbDZHaEVk?=
 =?utf-8?B?dVFic3dXeGczc0dCckNoR3ZRR3pQQ0U2ZDVtcmYzQVUySzdxWElTU3VYUG56?=
 =?utf-8?B?Smx3QmN2WG5OY1UyMHVlcy8xOGdxRWVsckdKVGVmVmtnOWZiYUpzcVlzVHhD?=
 =?utf-8?B?c0ZEeW5HMmlCZHZkc3A5am4xSXUwQzcvS0dRbFZVNEJzTU9PRHdRSEx6WUhr?=
 =?utf-8?B?OWVnZ014Z2hlcUNnRkhxL2pFLzRRNDZ5c3pxNmhBZ2xBRzhtcUk5ZHdtZzR5?=
 =?utf-8?B?bnR1clRyQXNoY21nQ3VUOGVmaTdWelA5K20wbFZwTGdraFB4U1h1ZmdxbSt6?=
 =?utf-8?B?ajZMelJYUWFDYmpIRlM0MnBNbS9lR3B5dmR5R0c4Y00xVG85NTRVdGtXTlZw?=
 =?utf-8?B?UDV3Ri9KZWNPRzZLOU5CelNMc0lEekVwNjNaeXNLdnVQOG11dndTd0NxaGpx?=
 =?utf-8?B?c3pFMDZveWVtaElLWVB1NkZPMDVEQXRGc0dKKzZhMHAxdUVPUkFIOWlrbElZ?=
 =?utf-8?B?ZURVb3dBZWpFMWo5QmwvdlBwbHdtNDRZYmhUeFZIMExOQnplOTdraHY5STha?=
 =?utf-8?B?ekc1TjlBRWNHT3BaTFpyWTQ4VmwwU3BQRThWUC9pUHc4TEt2cDljTGUwWHZn?=
 =?utf-8?B?bzhoWEFPQUhsblByUjRRRVFVNkhUdjIvUU41cEtxYzhMMFYzK1Q2RWhHYWZY?=
 =?utf-8?B?OVQ4OFdQS2plTmlreWNCK2VNWFpiOS82TjJUazVBL3lVejU0UG8vMEg0YTJu?=
 =?utf-8?B?Zk1rK2dsQTdvM0Y1R3F0ek9henJWOVNZYXFtNk5DVFN3djRVSkhtMURZNG9F?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53530790-0f43-4eb4-fb47-08db619d7c50
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:08:42.8070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRUDfOTBzynOYPIFlE0AulHqPY91nJdZrUhHJkmaMvqLI7MAl4SIIJfzET5uOB/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6213
X-Proofpoint-ORIG-GUID: vkREIp9Onc81-7MAXgA7NiNkmuzuCb9d
X-Proofpoint-GUID: vkREIp9Onc81-7MAXgA7NiNkmuzuCb9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_02,2023-05-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/30/23 9:32 PM, Su Hui wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more informative.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Acked-by: Yonghong Song <yhs@fb.com>

