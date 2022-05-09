Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14C351F2A3
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 04:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiEICZr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 May 2022 22:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiEICZe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 22:25:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D715AA6E
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 19:21:41 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248LjiCa004558;
        Sun, 8 May 2022 19:21:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JhivwBa0CzNd/nY841IaHPD/fWIhicYV83i4z+bgPzU=;
 b=QTjlBnUx6J+zDDoFrCcXvLc/4FhFY+eZEjEsjFFWgElvLxBcnV2UvDvnjRq112rL6cRd
 Mh2Rp35IB0eaXptI8cyi+hp9QslD1CZcPkIVy4L6N7kERPMDLLyD07k+uWDdt7qNS2FM
 Ouqf7bnGG7BULudK6Y+kcw24BfmNCkWRuqw= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwmtje8kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 May 2022 19:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbD431XZHgOxwAbbFmsrz7ZPLq745IVJXUX+/RvApgHBngOcWTI1CUmxb9vKhOEln1kBKz2TpYgDv7bDPdVPolqR1kY/2s04AcG2W1YZF8uQLyCbs502L44PvavoEYq34/Vsc23KFb0V61hJM7zWxBvhemCvjEc5cQfcvtmhaDutyTwzedDzKK2fHlRQAx+YJhpONWTHfheOI4ebRIyQFpb6xidl3DiN4XpNYYtRJOBW+GA2v6b3rIIgJ7ogq7pAGrfQrM6AWdOZa9/I22zKNt5cofRgYnzCFHbBPmpE+qKiy3iSSDP2yYQSA1FQ80OAVl5bSCIkxlq7jhCAQujynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhivwBa0CzNd/nY841IaHPD/fWIhicYV83i4z+bgPzU=;
 b=SC1TSoc5HroSk7XkxfUbfrze3vJq75bktPKOgvfG8eIiR3W8lJiKmh099FD+7w4rR79glXgrIFFaIzhfP8mmRT51iQllybe8pnkP0DMcBb+cw9wvGEWQ+3JqH25c7GdzhgKFvt7tGnXt4ZoYfFu1w91yAeTFO8+r//7w3gtW8xUHIo5DimaYXNpyfJRw1A9TV7UQSthrWM7k479+ti9YSVUeK5JBw/DGibbH+msgzwm/vfNf31MTwc+1kCaOyeRPo8geIsV6JaMUqYWuiFUyRXLiRFGgOopGn2j2tg4CA/9pAlbHINZYXDVunbQstw5l7hGUfAPYqblfur3+G4lS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BY5PR15MB4787.namprd15.prod.outlook.com (2603:10b6:a03:1f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 02:21:26 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 02:21:25 +0000
Message-ID: <d99ef512-5c1a-0763-c780-d7f37087c23c@fb.com>
Date:   Sun, 8 May 2022 22:21:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 06/12] selftests/bpf: Fix selftests failure
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190033.2579182-1-yhs@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220501190033.2579182-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:32b::17) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1bb76f8-93f1-4530-3db9-08da31629e43
X-MS-TrafficTypeDiagnostic: BY5PR15MB4787:EE_
X-Microsoft-Antispam-PRVS: <BY5PR15MB47870E78D79DE250A869B402A0C69@BY5PR15MB4787.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmnhQiTGCAF+izXkLPVfE7kvIXpyTY/qD4+QoPJ45MprHShszPXkndxdXY336WSW9vXP81UlaeR4dABjWeAkx+TCQEuqAD4dVahU8nS9RinKqeCFe+Dis+1QAKmi7tu9HV+JjHVAwTDa/BaIOO8jeWtw+C2UHIrGGQoCLF0ekC5TjQ1eTi7ri/OkMQF7WDcvaz6A8ebCjxF/qh1vhUAqbWWtvegemWTYzifbrsjBpLWX4+Vd9g8US839WIctD3jHDKV4rgUjvSKYIFIlX/zW/HZcnkXxuVUN2LOA6jUxNIaSD2zYRkv2k00/rZcbgTqdeWSjhH7FODvjOavXxhvG/74dBxyfVt1ybJk5hGVgtc7Qo+vuS66sMEeiDOPEQYtcIPapjJlv+cC/R26kc8R1O+lfOaWsGxhbPfFalYzOLrrBb23tVqlUWTrisNiTq/xQWC19gXEaliSYZrZWNve7KfQvLJ8YHKdLU7lKOJFCVdrfM7RH3J6GQ/Hxbvcr2zZPTxqAHcGsGtGmVMWNwLmvwjPQ/9E9VJIEhbkSCzEnpx1QtBOB1Qzi1/vKm7pjfn1t11lFkWi7bG0tMedXcUyZ0M2+N9Q2Oi6kCMj5uqrQAGUmT3cxo4fPu1An/WpwAQT8x0AAz8vvPJzUPovfegWP6nj6tc0p5ZCSNsPBcxARLnkQsgfGaifX2ICvrDl3Cqpb3ylomEuqOTsoOuwdyoJh8x4PHO3VzqOX/wnxjBhqDeTaWKvnE2kYIM4qx6Kk28FI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31696002)(36756003)(8936002)(316002)(66946007)(66556008)(54906003)(4326008)(66476007)(8676002)(31686004)(38100700002)(53546011)(6512007)(6486002)(508600001)(2906002)(5660300002)(186003)(86362001)(6506007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVlNNDBTTFFPU3lLajZLWFZ2anFIcXpXSEY2VFJ4U1FkRi91ZURLRytDVkRY?=
 =?utf-8?B?Z0Z5OUd4aWkyaFRuZ3ZTM05sempOVldzSTdRMnZmWDdGcVlqckJFeXVvdytU?=
 =?utf-8?B?bzRnMTFvWE1CTGFoci9CZVhKWmNad21mUHFPNXM4TWlVbS8xcHRpRTRuV1A3?=
 =?utf-8?B?YkhxTVJHYkJSb0FUUmVlVVdwdm9ENDBOTmVjUnlpVzkzSytRSWY1bE5jSnBV?=
 =?utf-8?B?aHdoa250ZXVDenpCNGRiUEJ3OGEzSExTL0tpZmJQelJQc2xWdnJlR0VTbTQw?=
 =?utf-8?B?KzVJM0NXV3ZIMUwxOHMxc3VBWm5YOTFSZTZzb0hrMlk2SlhMZm1ZbzNiSU1M?=
 =?utf-8?B?S3pwRUJiUkJPNnFidzNHYWlZSlNOTkxuUTk1djduRmlBZHFGZEo0MEd0YWxv?=
 =?utf-8?B?TytaNVdXRkkzR0l0UzlYWEIxeEV1Mi9MbWwxS01tQlhZclpLMmw5ZWVTWnVk?=
 =?utf-8?B?bGRPUm1JT2V3WFlocmtEb0tTbFgyYXdHUmN3TUZUT25nODh5elFsdVNiczJi?=
 =?utf-8?B?Um1kN2dNVHQxc0ZuVUNnWVE1eVkxUlFMMkRhV1UxM0RsNzZYZUM2TlZmRUIx?=
 =?utf-8?B?Njh1UVF5ckxFNElZa1VaWnJPQWprUm1kV1VyUG04NXVWNEhkMTN4dEduL1Er?=
 =?utf-8?B?cjQ3cmRCb0UwdllwMjA0L3o5d0t0cFErZEZlZGRpZEdhWldwbzBDMjE1c3FW?=
 =?utf-8?B?THphaHM5SitUcTJjNTZtRENZNkNJTGl2SDIyT3QrK1haMG1GL2tJL1AyRXlw?=
 =?utf-8?B?ZFE3QkdGWU5lSm8zcnppY280NHR0MW9IZTQ2Q2hWUHFiS2F4QmdHK3pPWGJG?=
 =?utf-8?B?Zk1Ia1k1QzRqZTJJclE5SGx3M1htVDJ4V2FhcnkxcWpCOUxxdWhBMG1NUDNt?=
 =?utf-8?B?Zkh6KzdRN0xDMFpGUjUwUGFjRllZN1RLd1lnUjhiVVphcnVOVzMrdzl5V0ZF?=
 =?utf-8?B?eTc4UG5mVUtXRFZnL0JxOGpHQWphOGxveDZqanRSeDFHWFRCOVNYYkloNmp1?=
 =?utf-8?B?UGJHdDFyT2pFUEZUQmpKQ1BnU0FwSWhJVEFNdXZXOXRNM3lHbysrZ2YxVmJp?=
 =?utf-8?B?NkdCM1lVK2pzb1pHRjBQS25xbVZyZXpIdnhseHJqZ2loNHlXUnU4aGVNOVoy?=
 =?utf-8?B?cUxSbEwrZ1hjQ0djalBMVkVNelJxSUVQTzRkOHZzMklJYWtZbXJidE1UekJT?=
 =?utf-8?B?R2ZORzVEVkgzSm42SEw0VDRMMDZWWExJZW83bVlSSFdleE5hNnl4Q0FDa09h?=
 =?utf-8?B?VExUbE8xSzV0RVhjd00zY3N6MEpiVDJSQi9XbGI5eVNLNDJ4VHNSZXZGcEhv?=
 =?utf-8?B?bXFaekZoSC9PMXhkQWFOT2Z6QWk1QUROVXZTRmk3d2NORG53em1oMmp0cCtm?=
 =?utf-8?B?RCszVDNFRDNEYy9QUzJRNk9tVWtIaEphb3ZHR0E0RU5nbVlxaXM1RmRQTUM2?=
 =?utf-8?B?THJrMHVOK0VtU1lvZVJOVEhWQU5UYjdBSk5PT0N2aUVrZlEvUklLVnlwVFVr?=
 =?utf-8?B?UkFOZ1ZxRzdKV1BmdklYSyt3dGdPRngwNXo3anNVanM1WTVmNGZzZmxPeXIz?=
 =?utf-8?B?dzBGcW12UDNta3JjZS9HOGZ6VDI4UzltSmlrcjNuRDNlUkM0RDNyZjBOYmNh?=
 =?utf-8?B?TVN6U2R0NUpNY2F5K3dsOXgzOWxsZkx5eURFK2RkZGkyenRoOVdYNjNHWVFt?=
 =?utf-8?B?TXA3U0dMMEYvU0cvVjVRR1pnWXU4TWoyMmZZUWlQK2ZWdnYxL3JibmRyMzFr?=
 =?utf-8?B?WEdhcjJoVmN1QVNYcnc0YnAzUG9lSDhSK3JweXQwWkxjOGdmazRibG1rdjNv?=
 =?utf-8?B?ZCtRUEI0K2FaMW9xM0lhSHkvV0ZDMjZ4dzBrdDN6NmIrdk1ibUxzblFoVXpm?=
 =?utf-8?B?Y0FvTTJRcm5TbUp5R1hDV3NNSXdRdjhUdXl0dWp1RlJ0SW9LcHF4UXlxeWZO?=
 =?utf-8?B?WXZqQldzY0I5SnM5ekIrajF5ME9Na2hIcGxHY0UxWUpHSGkvbTQ2bTZ5S0cz?=
 =?utf-8?B?ZC9HZ1VtTjJUWW5PNzRrS2ZHY2RyQXdzNFR6bzl0bjQyRFVENWIrK1RiM3pm?=
 =?utf-8?B?Mk9PaUFkZ0ppbG54S2V1eVI0blRMR1pjK1E2aXIyajQ2R3YzZE9ia2NFMGxS?=
 =?utf-8?B?aFVXU3cxNURsQmxHdDFPeGM0ZDlhOG9NVmgxMjBNZ25xL20xa1c5SG5KSmRR?=
 =?utf-8?B?YU5VZGNzczUrOTdBYksydTJLdk81clFjc3Rvbk5tRmQ2cE5xeWpzT0I2aER0?=
 =?utf-8?B?dlRaTStMZGJTRmY4YXRJOFh3ZVk3eU9NT0txdGlLcnJHcC9TY0lDZGt2cFBq?=
 =?utf-8?B?eUxlb0Z3QS9MNFJ3RXA3N1U3ZkpJdFFqMWg5T09PeGZnbU81V2ZqUUdBbFI0?=
 =?utf-8?Q?uuaCrmr+UXOh/bFjfo9wMjDsojCI0XFx7Qq1o?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bb76f8-93f1-4530-3db9-08da31629e43
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 02:21:25.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6n2+UkE4ewaluEuPsYBrHrpPQKGd+8pzbOiXS0kz2f4FFDK8yhbqKG/JoEEgYt2EQUrf0VTHS53WVJCG9VHZsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4787
X-Proofpoint-GUID: 58rQaYN6XrVkDw4FVrCVNIXk9D0w_xO1
X-Proofpoint-ORIG-GUID: 58rQaYN6XrVkDw4FVrCVNIXk9D0w_xO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/1/22 3:00 PM, Yonghong Song wrote:   
> The kflag is supported now for BTF_KIND_ENUM.
> So remove the test which tests verifier failure
> due to existence of kflag.
> 
> With enum64 support in kernel and libbpf,
> selftest btf_dump/btf_dump failed with
> no-enum64 support llvm for the following
> enum definition:
>  enum e2 {
>         C = 100,
>         D = 4294967295,
>         E = 0,
>  };
> 
> With the no-enum64 support llvm, the signedness is
> 'signed' by default, and D (4294967295 = 0xffffffff)
> will print as -1. With enum64 support llvm, the signedness
> is 'unsigned' and the value of D will print as 4294967295.

To confirm my understanding, this signedness-by-default change is for _printing
btf in c format only_ and doesn't correspond to any difference in interpretation
, since all BTF enums before addition of new kflag were assumed to be signed,
and new kflag's default value is signed as well.

> To support both old and new compilers, this patch
> changed the value to 268435455 = 0xfffffff which works
> with both enum64 or non-enum64 support llvm.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Aside from the general question, for changes in this patch:

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
