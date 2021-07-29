Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F063DA9B7
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhG2RJr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 13:09:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1042 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhG2RJq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Jul 2021 13:09:46 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TH3nsQ003425;
        Thu, 29 Jul 2021 10:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SSs5UeJcKZmWj+iYX0gh7rXZJWKZqotKBlojNuHWURE=;
 b=MCRGX1Le+0miLNizx/l7xlqx3RNAKsYZqZl2A+dtCcxc66pkPQGROxdbgUUlza96Nk/h
 NJUTLYlkNTx9r8Af99dVcRxPksNC4RB6gptSd3CDwi8VAscTz+7EYuxh7mzE5J96W+s3
 pzGxGDOEdTnVioeukf/GtxtsqGN6EtXSHI8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3bu9f5cf-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 10:09:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTb6nKxz7MI0Co6enaNw8erLbMFX1sGegFsZEAvz6LFJ5qqUdE3gVTxKtyBGi0EwOs7KRAmgJ+tOguQIhn/iXYgMxSfvb7kIIRvaPwCNPxCn9g6FW1yXYSQjdWn122BDrz+MBTnNoBK1v2KnW4eh2h/MnbnqxOSFBCMzl2osTItExhW6mb+MAY4FJX5A/f+y/WVExL2fRLigpBUjUWLlHWCMh25IVhIy6hHgs97YVL/n5HVRtKQUDnhintQ8UzXwUi/yxDgeUk4Hq6riIBOPK895GxbENLW9LAwdoUXVrs5tXfvRY10kG0h+vGa3gwndHvCRSgrJ/vimtuLaLCKtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSs5UeJcKZmWj+iYX0gh7rXZJWKZqotKBlojNuHWURE=;
 b=Cjz06m/9N4KF1N8Jr+K9j6JKAq5pVg3NbdwWuyw7Kiu3TO99YEqXCZFGkiA7cV4GB+xQzLQ0UOxZrnzk56u+1KBiAVGI6zZQrc0EHMoWKPmrO9XI5DsBZ8MZJCDSew1qUk6TkyQaUwyU9Y3SWdv6AKZg5mU3TItam9X6XJJfo0R0o866YzqUNG3dFzkrm+2SOODDTdDE9vXid9Y93Ft/8jnl86hq1gUwvEq6nArEOil/53dJJ8EkXy/4h/bNZmc81d1ha5B6h7FzCAfJbISnn8P0rTrk+BPo74SICcZJqdLOUcVFh7NWDhPP3ckDkJUOfZ7sVbQXjRX3e6ZVENiDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3917.namprd15.prod.outlook.com (2603:10b6:806:87::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 17:09:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 17:09:14 +0000
Subject: Re: [PATCH v2 bpf-next 03/14] bpf: refactor perf_event_set_bpf_prog()
 to use struct bpf_prog input
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-4-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9379ec59-4abc-b607-6560-8c52348b31cb@fb.com>
Date:   Thu, 29 Jul 2021 10:09:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210726161211.925206-4-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::11d1] (2620:10d:c090:400::5:81b5) by BYAPR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:40::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 17:09:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eab17457-32cd-4a39-9b6a-08d952b397ac
X-MS-TrafficTypeDiagnostic: SA0PR15MB3917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3917C13BDD30F8E2C1470671D3EB9@SA0PR15MB3917.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcu/abA0hSh2DTmjrNQl245gOB20bnql2SnfW9zzwjbZ1IZSH6HVK9NdBrfXmyDzReEwKJc3ZrjPL5Y3zH7g+Uj7wcOtLWVHbqniIIJ+k95hWfEriOClnPDaAT1TNrEmJW6cjYH8hu+szjopY9A6d53NJFd7MglxALVCqi/zHDn2csImhxPeS8p4rFoUIQQnCWePdI8A4JBnkWL9JCVAagQwSYnoMCUNoTm4IE4SSREsVLZsoMKne+OCKlNTdrAP9y/d8iVAMQfY3OwAqvgaWU5NexEZdsDlc05hdw6vMnibXt90avLJSQ/y1awdmbP5CKO2Qu0x5Nznjorh12Tyan52OGLYfYlV+Sa4m7ebA8Ld+4B/eI7Jhj/LiTqB94KcjdpnQANPQ8Li30K6XWkw/VABPBiT0zBcGEgJT08PER9tkk4UncDcV3NPet6Datytx8de/qS1ehD9w2pxTfv27YBQtNyMa1yRpO66GgREc1elBZ16u45W5vJea+CHHD4M/uxJOLPp4nMGA6i62D2ZMgzGrpqmkAKJpXeCte0SP4wuXwoGrheMGSGk2FieHPOffBferebmLL+a5CDbvz3HQIVu3RH43acVNp5fx2Vm8gbVQ5jx7LithoZsynb+suNShO+1BjpnVYiXIld+sLumuatOmja9D4PZEoE0iJxJFV+Al1JuqsGN/V7VXt492T/qZ2ACbuLZyK7K6CJhXcpJnCWRwiicOKYT3zuF9xJW9gU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(5660300002)(478600001)(31686004)(4326008)(4744005)(2616005)(186003)(86362001)(38100700002)(66476007)(66556008)(53546011)(8676002)(52116002)(6486002)(2906002)(316002)(66946007)(31696002)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGwrbDhxcGZRQ0dLNG9WTzRKMFFaQUt4WTZ4NmR0Y08vN1NIQXNZSEVSaFoz?=
 =?utf-8?B?V1gxd2ZwR1BIa1ZxUXhtNFJZTUd3NTJ4SGx2azhjQ0x1YldCQjg1YS8vMXRa?=
 =?utf-8?B?bTlPNWlSaWllUmdYQUIvbDduS1VQSXF1ZTd1Qy9jZHJGcjV0U1RCdnkrYXpG?=
 =?utf-8?B?V1F3M011cjQ5RVZxN0ZZc3N0L1JYTUZVLy9GZU9qNjdENEw0aTNlbTc1enhw?=
 =?utf-8?B?SzNZNGVYWVdqb3J3UHhpcXRVOXM5MmxYUFAzb0ZoVmN1UjhUbE5xSkoyUE1Q?=
 =?utf-8?B?T3JncUh6T0V3V1hsbjE5R0dsZWdoT1d5VUZIdzdEZEExUUczK1I0dTBzcnZI?=
 =?utf-8?B?ZDFsbktiUDJCMkR5QlhQd1lEYzlNdmZlaE55MldsenRzZVlldi85VTkzdkxY?=
 =?utf-8?B?YWlQNllqNHdjUDl6MVo0Z2dUZThES2xGYjNXdEFyWElUaDlETTJzaFFKcmVZ?=
 =?utf-8?B?Vms5RFhNV2VaZzA1dkpVbzcxT3Blc25YUW1kb1BoVFZLZThEeCtEOXVHR3BD?=
 =?utf-8?B?aWlPM1QxekM1OWR1RitkY0RPWHV2Vy9vNWMybkgreWwvNFhqVitxNythamsw?=
 =?utf-8?B?Sm5LelJYZ0lOeGEyVzlORkJTZmp5SDVUaFNjL0dqOXBpT25Xb0RkUTdpSEVx?=
 =?utf-8?B?SlVKaFJ2aDlMODNPL3VDSHdiUXRMUkd5ejdiSUt5dWJkRXhLWCtyek9uRktr?=
 =?utf-8?B?elRsYnpBczVNY1pFNk04Z2l3elNwbWpVZzdmd2EyMUgyTmRncjc3WUl6dnky?=
 =?utf-8?B?cTdLNyswa2lrMk1GNnRLV2VTMFdwRXlQdkhRL3hQa0V0QWNuQ2tLcUtTQUQ4?=
 =?utf-8?B?dC9UT1pibzhrN0VzWnRpU1E1cmpjRTR1K21pSit4b2VVMjNZb2VUYUlIZVh5?=
 =?utf-8?B?a2w0SndBMmRlbE55ZXFmdW5ZN1FoYnQ3bWQ3ZnBYUVRDOWYxbFJoY29DN1VW?=
 =?utf-8?B?cUYxN3F0NVFhZGxUZlU3b0s0QlpxVjV2ODAvYmptZlA1dHNZL21NdHhMR0ox?=
 =?utf-8?B?TVMzR1pPY2VVeGRtTDNvY3lJS0NTcXRRQkltRTVaazE1MVFDSVRBVGxzaUpv?=
 =?utf-8?B?TVF5ZU4zeWNLaTR5YWtYOHRRc1VMemNIa3BWa1BxNFY2Y0JHa2VYRFJQSXRt?=
 =?utf-8?B?UHBqZjRBeWt4TXNjSVd3QmVlOExJbndTMVZkenZwaFFvTVIvdWRhWi8rb3h4?=
 =?utf-8?B?SEdKcm1yaHdjN0ZVNUhkVHdXOG05Q0V0SWFrK1dmdzU4dFNMTVRXaGJjTTEw?=
 =?utf-8?B?RDZLUmJrVXpaQVZMdkNyNHJ0dWJYbTF2bWNRYmJVNWdwZ1VHQ25UUURuWVdR?=
 =?utf-8?B?TWFjSHM3Z3RObEZQR014Zk1FbXpob2ticVJCM1lPQjBCUEd4MTk3ZXB1WmZH?=
 =?utf-8?B?aUZCckdkQjBncFNqZWFvMys4K1BoOTNMeTdDVXdDd21OSW5jenFrejJ5b3VN?=
 =?utf-8?B?dGVSRzM5Qk5tV1VpUkNsQ2dFaTk0NW0wRUxEY09kbkRFTlFqR0k2clEva0xF?=
 =?utf-8?B?RmVEeXZmOTJrWEFGUDdhdkVPYlhKRnVQb3JRQSs0SlM0Z2pqakc5b2RyTUE1?=
 =?utf-8?B?cncwREI5OFBKRko5eGt4T1hHLzduZjlEOEt5NjQxaGQ5RytWUXRna2dzNUdF?=
 =?utf-8?B?MlBRQ0M0WkMvbTBRMDkyUC84S1phTFJwTFNUUHRVZFpYQlFXZHBjRzlxVXJS?=
 =?utf-8?B?bTBXc0U2Wi9wc3JzQ0RmZXVXYjlkbFE5VHROSVVQQXRuMWE0MmV1Y05qUmdR?=
 =?utf-8?B?TjA2Zmp5R0NjYk9mSCsyalE2LzFER2psVnc4ZmFHcTNJeVdtN0x2Um5GYjFy?=
 =?utf-8?Q?NhV7FrnPgIA4R1Fio4WQuLMjiq8RQycDSxvFs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eab17457-32cd-4a39-9b6a-08d952b397ac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 17:09:14.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+WPYXUB0Bw/ZsiW5mdc4tXLqagM51/zkWPacfTlwMvYKtYc5UZgUyZSUGdmZdyH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3917
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: RBSMwsxPv3gqm7YYfcZ8lPx_CQLKA5RW
X-Proofpoint-GUID: RBSMwsxPv3gqm7YYfcZ8lPx_CQLKA5RW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_14:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107290107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
> Make internal perf_event_set_bpf_prog() use struct bpf_prog pointer as an
> input argument, which makes it easier to re-use for other internal uses
> (coming up for BPF link in the next patch). BPF program FD is not as
> convenient and in some cases it's not available. So switch to struct bpf_prog,
> move out refcounting outside and let caller do bpf_prog_put() in case of an
> error. This follows the approach of most of the other BPF internal functions.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
