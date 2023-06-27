Return-Path: <bpf+bounces-3537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D9D73F3D3
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 07:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F2A1C2099B
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 05:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827B1399;
	Tue, 27 Jun 2023 05:03:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68828EDA
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 05:03:22 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3FFE52
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 22:03:20 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R1ag3e009931;
	Mon, 26 Jun 2023 22:03:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=LrDlo2amqwHO13V3cfr4eSQ6yPd7LfYqaa9f+8OS2hE=;
 b=gCxTLHUSizgHkmV25ry0FqOWf66wR9dT78cAhszhYuGDN+/do8OMAeLiT6EepEYG0U64
 QQZ9Pl2SmjOKtd1fevb2ccruztwH6lqK/0kMjINx39IfCIWbv5EZgIo/hha9R6fLnn3S
 50yCbjIyvwjwSRG23ioVqnOUW5uiVkzr36F7sPDZDcNsbzL1LanZJv1RgnRtCWG3Tg2p
 fBt2pPGiFs/RaROhLbhGcquZerRXnxpZiqisQOc5pBvox8V/5TgSGPXXbpysGa2NnJe+
 qWjYNAsM7BCR8rc1R9zTz7uB0bFqjNxfL3Ly1tfhCzltQPF0dYsj666YNNEudruiIcM/ Xw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rfp8f9abf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jun 2023 22:03:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHG7x/00gy6oEZg+jQsyvb9FaCD7VZzWH2dYGwpECONV3x5wf7mOyJ1r9fwHGnqjbwR5sdhFIrpqtaqvIa2NS8J/rNiYmbx114LIJ6AKu3HbTwURXjdTiEE87rNXoCwpZA/Lz16f8P092+jFS4FPhCcSEqEipd2d50cioTk4B6XH4fpLSVWfWA+HfXj2x/6GSv+oV6ThMGY2UBdL2txIdRMTsckEhrsWRthcXTJPLHsPpFCQCnO85fE5NdBqHrZXCssnZRdiRRzi/8DIlr05eDg1KChlbQsQzuIy8DqCtlsCBQPM+dSnFr5OajoXzb6kCT5ov9G2XBAZ9KWGi56b6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrDlo2amqwHO13V3cfr4eSQ6yPd7LfYqaa9f+8OS2hE=;
 b=EZK+cmTFKZnLTVfp1xbCQqD00PoUkQOZswWQwClAtudCgKLs+NPk6Zdd34qa5/jQ8PEaahlmEVOWRkj8AAbMeA5I8dx2vZHCOGOAMoFxiEQ9xO8/z7ewPenvlIqG1dw1K3xaBBQ0QAhteuajJcbPchrwy2K2T7zLC1JW+NXSY9BqWgEskQuFIbaesqbFNh+BNJitcEnH+PWeq21UkcnImkYLbkPNgNNakghmvI9jlplL9GdmY2QCBNeAlqep8f5wIlxNFyzHtijgkhP/PGKqlrgiRuDxgSlGRa97QWDZieJg8yImjQuSEOQWBKotZv8YWMlJgX6UDFVvhJSAIUu4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA3PR15MB5678.namprd15.prod.outlook.com (2603:10b6:806:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 05:02:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 05:02:58 +0000
Message-ID: <9f0553a9-3dc9-8035-05e7-dd6fb53dc3b7@meta.com>
Date: Mon, 26 Jun 2023 22:02:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Resolve modifiers when walking structs
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org
References: <20230626212522.2414485-1-sdf@google.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230626212522.2414485-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA3PR15MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: b00b3337-25e4-4388-d37f-08db76cbc643
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G/KgcWQMiCMVe9SLQyo5LKJWx/GsvjgYitVK02WNTj9AgqM/lqag6DurZIuJgmwEMsHN4kLrHRdOV+GD3tShjwNyd3qKXr/S2+s1Idkw3jwoke3ZblULbckGi8Zri/QWAbuNoAz965VuG5hob1jIJVkOHaa/TnSrz2b1W+k+TP4TZWNSaoK2wJyL1hvflLJyw0Q++vSPU0KonKNYcpBTKJ0YgalaVOpIUOS29xRmQHBWwAUpZUYD1kTNKvJLorZfsTGk8EHnxGO553A62SsjvdAxzOU4ChKzryy0ls9UsZ46XY9VZgSCSCPZc1TQY2/Zf/Yy2f4MUeqa5zPnpVu1M1pFmb8lIn43XZvXvqDLVV+QRzzJmrcUSv8w1un370MzX/C0bIiFKyjxV2RLXsa1S8MHnhJl/ztCQGhJurhEJCAOXl0wjWO97l+JW2KhTZmhBfRj6fIafunPHA5xs/D6kD/lunVpHqyI8pRBvkte9aTPT7r9jbjpMHXMIoybc+hq8zma4HcfjNNMJzvLTDZYZ/4hxl4uk4A2qf2X1YmlksWb9DQBEm0mT2lkuSQ3RPvE866n6AtYTH4Fo6kblxUMgZ3zsqV84Z2H0YwmQ75dNoOJ/isq/4JP286WXNlsCi2CEy+2tgbnJGNfV+gXyZ13Rw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(38100700002)(31696002)(86362001)(6506007)(53546011)(5660300002)(7416002)(66556008)(66476007)(6512007)(66946007)(2616005)(186003)(2906002)(478600001)(8676002)(4326008)(316002)(6666004)(8936002)(6486002)(41300700001)(558084003)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TityajRlU1dETGt1Y2U5NzVmOEw0QVc0d2xwZGZTcW5oYXBySHNCZENiSmhk?=
 =?utf-8?B?d0tzYnJIWmhQL1dibEZWazlySkd6djFxQVFDY3grOWZBSGRlMW1tTmRsZFZO?=
 =?utf-8?B?Z0pzWER1RjFPSDQ0MjJKS0cyU1RYU0FXcG9uUEZsL2NRR3FBdTRWZTd0bUo2?=
 =?utf-8?B?bU4zbDlKMXdtVlhjUGVaNmlRVmcxejhmck03M0Z0Z2JRaU1UV0ZuRk96N2JT?=
 =?utf-8?B?T2MrZ0JOY29tM1pCUXdrMVE1RGw0ZkJsT3VESENSYUZpTERMT01EKzQxQ2FG?=
 =?utf-8?B?NGkrcnYyekt1RUFBTnp5NHlyYzJaQmlLTXpwb0RpdDJoZkFUU1RkdEUxcHcr?=
 =?utf-8?B?Y1c4MXdnSmlKSnQ1SUY4bjdQcERpZVd5b1NlL3RUSDVhVC9nV0s1dU95dUNZ?=
 =?utf-8?B?eTV5UE9WR01hSHJkaThMR3RVOTVHRWgycFZSSU1wcFUyVGZnZHIrZ0dNU1o0?=
 =?utf-8?B?YUNWb0pVU1FKSmlPVW5Help2Z1FmV1NwYUhLSmFGam9IY25IbndHcktyNVd2?=
 =?utf-8?B?SGRaeXRBWjAzWGp1SlFFSGF3NnlHSjZHMmpPamE0MkF6cE1jQlIxOHBmWDRt?=
 =?utf-8?B?em1KYnYySEhvYWhITDcxVWRXK2NZd0l3OWRBK20zc2dOWGpLQUNRVkFiTzdO?=
 =?utf-8?B?aXNvVUQybDhrRHJiZW9HWStqcG9mOEpsWXMrWWJMWXUvdGlWWjlYNXVCNjRG?=
 =?utf-8?B?RUxHU3hPVkgveUFHM2VyeVlDRnBvek5NUVo0VnVrRUJIOFVzTmRZekdiU3BH?=
 =?utf-8?B?MHBZQWRJNm56V2VPZDZaYmkzMms3U0cvMnRzclF6TTRnOEhCOGJ1UUxSRVI5?=
 =?utf-8?B?eVBZOGU4M0dDQ240Zy9UQ0N1OXJEL0NpWVZ6c1lNbHhraE5HbEFoK0tnZnJQ?=
 =?utf-8?B?NHQvSWdDR0NNdVNDbzNJZ3hZSGNUV0V0YlJOUDJKTDVnMm9XOGQ5cDBmL3VQ?=
 =?utf-8?B?WGkyZ3ovSlZwRkdnbURRdjNlNkNDUTlpVEptbHczSWF6T0xWeDU2cEZsNXYw?=
 =?utf-8?B?Yk9pQ3d5VW5lRzNNV1V1akhjeGtFLzgvelZjd29EM0xHVUJDT0kycjlYZlp2?=
 =?utf-8?B?L0hEbm1Tdk9VK1V6SkM4SHJYQ2cyTmI4Vnp2SS9UYVk5MmVsSVBUNi95YWFR?=
 =?utf-8?B?ZGdWUGdRRU0vSVppSUJTa2RLUis2YzllN1QzUitLL3VNYzcxbkt1NWhsSHR5?=
 =?utf-8?B?UlVSQkgrWTF3TnNpNEx6eUZKcFBacjhBUUl4dkdpdVVsdFhiUmIvempRZUhh?=
 =?utf-8?B?RnhITmw3OVk3OTF0Z25WTmZqN0FybnBiZXpSc0VmYkt3TUpsNWFIS0U3NElP?=
 =?utf-8?B?Y1dxaWVVMlplYXoveWx5bklsQmN0dGl1T211MmVzYi9PdE1LTHdWYng5M2s4?=
 =?utf-8?B?QzBGYW9JRTNPNVdEWWl3b1ZjMVp0SHV6Q21zNFNhNDFiS0Z1b0MzdDVaaTJh?=
 =?utf-8?B?NHVXZ0JRbWZQYTR4a2J4ZkdnRWpNT1FjVTA1TjRndzg1S2Z6NmU1WGFrVUlL?=
 =?utf-8?B?QnphdEgvQk9LSEdqU29tNGFlU2xaaFZqUEQ4aEswOXZRVDRrZFVBN3BXb0Zn?=
 =?utf-8?B?VzhWVzNYSWkrMjdKWmJZT2NyS1NOK3pkR2hHR2VXNThYMUhub1ZJNG0vNHdi?=
 =?utf-8?B?S3BkelZCczJ6dzJDNjNXZzRnblA0c3FMdjFHcy9yVXk4Y3BGQ0V4Q1hrWUk0?=
 =?utf-8?B?K3llMEtNMWQ4OFkxWFV1Z2dOd2l1MnMrQmREbHJMUHlnUFZyWnVvSG1WaENu?=
 =?utf-8?B?a0UzUWdVcnN6YTI5STdRTHFQMXVVc2p5WUQzVnBlS1UxdjJZeFg0VXpsampx?=
 =?utf-8?B?Wnl6VGdURWR2ZXpEa2o4QU4rQndqdWVDRWZOOGxra1hzVnludVJQb0FNd0c0?=
 =?utf-8?B?VnZKN3hCV0hVdTJRNmNzUDB5SzJqZXpsMTVqcVF5QnlaTlR1V1ZtQ0FiTS9B?=
 =?utf-8?B?MFE0YW4rSWdpWnZaZW5ZbnlJZFdJSHp2QUZsQjh4L2g2Q1A4eDF1bWlvdWts?=
 =?utf-8?B?UkZrSFlhNGJQbjVYclZsVVVtR0hYbUEvZzdZZmJhS0ltcUFhVldxR3lzWFpz?=
 =?utf-8?B?V1k3a3ZuZXJhLzBCS2E0Q2JuTkRKTWlGUWZwNkpiTkM2cTZEdytZYjhNTGtv?=
 =?utf-8?B?eGVtVjJiRXFEYVhPMVMwVHVQQ3lsTHQ2c0JERG9nOHNPdUhqeVhCTExaRkZ3?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00b3337-25e4-4388-d37f-08db76cbc643
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 05:02:58.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJwnNfuu7OmZP6NXjsL5bx1v1iSqgcqxielCmS1jDJWE7uHGgUo37xc/3je+vHr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5678
X-Proofpoint-GUID: bDR7PikT6R2FMsAWK6frbeB7a6f5kbvS
X-Proofpoint-ORIG-GUID: bDR7PikT6R2FMsAWK6frbeB7a6f5kbvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_02,2023-06-26_03,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/26/23 2:25 PM, Stanislav Fomichev wrote:
> It is impossible to use skb_frag_t in the tracing program.
> Resolve typedefs when walking structs.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>

