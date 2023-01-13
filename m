Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F79669015
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 09:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjAMIHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 03:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbjAMIGo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 03:06:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782CB72D3A
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 00:03:26 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D5NN2l017097;
        Fri, 13 Jan 2023 00:02:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=bEJXO+8eBiKZei3wmK83imKOHO6jXRZ+3nLGWB2MRks=;
 b=X9CBhz+PjpphIWip5ZveMe2B3KtK5JRpQ6W/1IwX84mFjjczU6qWZUSVGnKw65GbFcIu
 GV74mlLJSw8eqXIs1wmazHUnRU5p5xkR/kxnwnWpD9ZWchZ93z0mUYSEmihfvOQoVP1i
 OzrkP/ClF41W/FXQ3ZGOpWV8tVPJo6O6w7r3M3yGxjIcHDVpSmgpPb7l+NneyUK2MEXg
 r4DF6APm3jLW7JR3uLohOsM9Fw46amby9nUgrlceiimsBHWI0rYmPPHOXDEij2AqhbA+
 Tp5+uTcOkMTDZeXyqA7FtaHWPJG1kyQPRCLx9QbiMNtM1+SNl2Uekdxp1yQVWwmemNP5 ZQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n23bq0u3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 00:02:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPK6N0+ydvcJIcBRfzh06L66FHQCPCc3nDlrLw7awfrpmUc4zu+IBBkzBHeWIM4M8GPdeiIgfWM0qpaucG3PiVtLRXHUxWcVBv7dt9coOJAdo5vHUocowb0v41u6xyqkCChDPPakqCU+n89sU0H/V1toDW5HMspG7qZ195bz9ELNf6lllvGvjoMI+Bp34xlL3cLt0MZ1O6o/BW9XIxuroQY8ySRPARG9u1ZpliBAoF9rBoBWKjTYvF3Leqoe0jrDnZdXrlj9cUeD/y8VXkr+OwRKrul4/5WImlbJJrwQSpEh3NFbPDLwS6TQkQPBAGVR/3Ugx1O/8Yz5lvgjiYnbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEJXO+8eBiKZei3wmK83imKOHO6jXRZ+3nLGWB2MRks=;
 b=SsgEYrKhla+9isUsGGFSNUVpF5D6tpdIen8nScO8bMVz860BoY7q/YQT8SO8dY0v+rRUKChCxEXVrqAeZhxjU5nGUNaPEMCVag45dGT0o/zR+WSnNQIdRqyj+lkuGmp/6oREKjik04q2NlXpETw6Z7qw9vhKgHlVA96iQuU12//NBm3Lz5GJiPVBuD4jpIui1B3YOzM+0/RML9trU6rGTNWhaaPPApcQug2VwA5FIXqwnNHKJo60uZB3gVp0q2amjx4Bx4EKzjIijmYK5sNyW3q7oysxcRjxvvlXwYYZ90FtolpFarf8Xh0sZgHKWsyYxGah/Pu5p//jFekeekn4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4892.namprd15.prod.outlook.com (2603:10b6:303:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 08:02:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 08:02:45 +0000
Message-ID: <790ab9fd-dbcf-4593-1634-6f706675cde2@meta.com>
Date:   Fri, 13 Jan 2023 00:02:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C
 compiler
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        david.faust@oracle.com, James Hilliard <james.hilliard1@gmail.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
 <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
 <874jt5mh2j.fsf@oracle.com>
 <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
 <20230112222719.gdxwdocfutpbxust@MacBook-Pro-6.local.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230112222719.gdxwdocfutpbxust@MacBook-Pro-6.local.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO1PR15MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 5294a617-487d-4696-a81f-08daf53c8dcb
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNIZsP9rM27R2+jsO1Dymv6rlpaMhwRDduZSbxPjWfh6fddcTJs9OWTaqXg6mWEUTd41T3uYFuUzPSQjW1Odn/bXI1HBBLYNVUQgEJR2wEBYeLm90lljjS+86altFR1eokkuOwdCPiCOy17MNUOmM7nYoACa1hqWiPGdELDyCbD4nwr1jyXKeenQe2WLFiDFTplVBtRYXUQBXfHDi2c7vJuLlZvOF8WrS4xAH5pHnTODkM3wVBclcNGmMZDtb1z6za2DdjzNzU+AMmAR9Bf9FZUDYs3oXy5f9VqwDPKkRUzFYOk78S0KovNWtmeROI5XwqOxkVVPTumR0V5nSUb/L63+uJ51hFEpEx7A610A3KwZvm/6BFYBS0+OIPpZdNd8L2B5x23HrUIhoAH/qT6VVsSiX1KU/O9g1cac+9kOwRVx/pL8tezPMy14iPfIcYks/UVot//RrcRrvTurRo/vEHRsLrPQosNfPlIZD28IsOBVxCoS99Mu8GwgiH3uiF2MRmcuqURX+vFfyMQcLDMt+EZfFXciag1jlsgEvyUbQ1qWzVpt64Ck8ih602B/YCHNIhncnGY8F56NHVcQ6CSQte4MBhuqZeiw8NYRb2+57qRXK4UJQHirv/lkAegGKDFXJia705gB9/5+Ox+lmeKgmXsU07PzZN0ttdioBw0lBVTkYsB9EIxiYC2retJJU8yeYFlZiyq/waF1T/fkioqAZW9jUvreaBDvh2/kSy2F2BE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(8936002)(7416002)(5660300002)(41300700001)(83380400001)(38100700002)(2906002)(36756003)(31696002)(86362001)(186003)(31686004)(6486002)(478600001)(6512007)(6506007)(8676002)(4326008)(66946007)(66556008)(53546011)(66476007)(316002)(2616005)(110136005)(54906003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlXVysvQnFPVDFiS05GRmZPdVlUYi9QQWNOczM2ZklrOXRiVlNjMGVaL2tQ?=
 =?utf-8?B?N21IQW5BNWpMSlRUSVlPaERFTHZaeXoxcWQ0RERteFFBYkcrN0JCZGYwRWFz?=
 =?utf-8?B?eVRZaHdxNGVnNHkyTUQ5bDcrZ1BXbDlQbjhic2NNeGc1eDVhbW9STENzWnR4?=
 =?utf-8?B?SUo3d1BvTUdkdi93MGNhOVZvNzlWYTVOWDQ2Nk90dGZyaDhSY0hVRndqeEFL?=
 =?utf-8?B?L1p3aEVXY3N1YlQ5SnVudnBUeXA2Ylh6MjdXdm0xQm90a1JObmFYMUY0Ykdo?=
 =?utf-8?B?VHBXNHVtbnZLWC9KUU0vMWRJUzJUSVE5MHdMQWZKVk45NFhzNmIzdy9weW10?=
 =?utf-8?B?VUdNTFZpcnYzd2pJaFc5T2ZjbmlrNXVsRGRLVWRmNGZIMEdlaVN3YnFhMGJC?=
 =?utf-8?B?aHBrZ3duZm1BdENvZEdFOEJaRHNxb0Z5aWpaM3I1aXkzNTdYWURzSmFhN2c4?=
 =?utf-8?B?TnVXYkJoNnE3YkxXb3RYTURSditaSnUzZjkwdmgwSS9MdFhUdG93R0lrOUl6?=
 =?utf-8?B?NWZBMUFGZUg0ekZTaFFvaFpta3VyY0RVSGJEZmRGRUJEWEZwZ2J1R2ZwYU8r?=
 =?utf-8?B?MHg0VUQ1QS9wdnBXUUpyT2x1bVphSGw1ajJSbWVzMmVlM09URmFjY2FRZVRX?=
 =?utf-8?B?bUJBY095Y2E2anY1a1phallEK1VnK09BNXZRUEtwWGdvNHVLNWpvalpFVHk2?=
 =?utf-8?B?OG9TY05hQWRLYjJEU2xiYmZQVU9OZyttdmM0ellrYXlCZHVaUm9mQWJrUjdS?=
 =?utf-8?B?QUpyd0k4WnVBQURYNTkzWmlLaUViQUNzMDRWNWx0Rno0ekJHbU9OMCtvSCtG?=
 =?utf-8?B?ZzZIUTdTQVI4UUFyMVlQKy9WQUJ4YmhPc0I0bHpFMEN0a3I2eWw5MDhNM2Fn?=
 =?utf-8?B?UlZhZzF3Q3VEWU51c0VUZlloZ2ZxMEFZa3ZWZFRSTDB2YVRoQlQ1cldocUFC?=
 =?utf-8?B?K2YxTnR6Wk15ZXZ4bDhqMFBWbDg3UkorNWhKQW1iNDNjWEVMYjFXdnhuV2VK?=
 =?utf-8?B?TzNXWkx0bmpBd3JZMWdxMkJDY2dJWmFrWCsxVjRpcVBlMWdWZUxLb25TUnZl?=
 =?utf-8?B?VWxxcnFUbDYxTlFUZ3B3amdTcmI4VytFZjZGZ3FienVwOGcrZmJ0QkFqcWNE?=
 =?utf-8?B?d0pGTVB3bkE4RVJudm1JZ2RySlVmbFFsMXB2Z2U5NHoxTTZDa3BFdXkzS3pt?=
 =?utf-8?B?ZWFlbmJJSWR3YXFVUktZSG93UUg4VlYya2dtdURHK044NG9Ic1NWa0JnUU9h?=
 =?utf-8?B?eEsxVEJUbXo3Z1V3bXlaekJKcStjOXVUeDEwTWx5cCtSYnhMQXBxV3dDbVF0?=
 =?utf-8?B?QVdnOUFBeGV3MmIwbzdSUHdzdTFWZnJjNExIME1lSzJpTXkxa3VTb29ybEZh?=
 =?utf-8?B?Mmd6aDR3NEptTzBBY2pFUkZaZFpLYjUxb1ArdTBGblRGdWtjSEEvei9kOGJs?=
 =?utf-8?B?WFl0ZFVPK3pBZ05Xc0JBcmdHc0hXc3NLNUJPOUJaNE0yb0hnWXdTbEkxQlFR?=
 =?utf-8?B?N1d5bm9jb0U2UW1naVcrV0pLUFp1bjBZeHZSVDVaeXV0VS8zMXNJWTV6VkZX?=
 =?utf-8?B?bDBsSzMzS05FOU9LRW5ZN3ZveUNOQURUR1VYZlpsVWJndzNUelJhdGUwcVlE?=
 =?utf-8?B?LzFpS3FmK1o1dVVKQ1ZOSDRqQ1lIaHNZVldvWkR1eEczZlJoYjRTYklhaWRP?=
 =?utf-8?B?b1RnNHBmOHVHbVprOEJxaUNiRk81RHBSd0taT2lBZ3ZQaS9aSW1VODcyVVZF?=
 =?utf-8?B?enRPUWRRaXJRSENGV3VsdjkrOWNMVzlqOGlIR1dvYURwZUsyNHYweXdDNyth?=
 =?utf-8?B?WWUram4yKy9Ec0JFbytVL05Zd2dyQ3I5L2loelRXN3NFMGVGZ29ZbFRwZ1NP?=
 =?utf-8?B?QUM1MUMzNmZCaTdyMEpRamh1N0IzQ0wzU1g2U3VvNjRDbmgrZitSTjlFQ3M4?=
 =?utf-8?B?dmlpaWszR0E2UWFhM0M4a2QxWXowQnVoMzE0bkFwSDRYOEtOd2gyS283eGhp?=
 =?utf-8?B?ZnFxaDRPbC9JNmV3WGovTmJCUEwycGNJbWxRL3kwVThaMHlIWUlzNE5MV2Z4?=
 =?utf-8?B?WmI0NWpsbHQ3MklvOXB4b1lkeEFaWEs2L3Ixc3dINFJhUGlnd1RXUU80OE1I?=
 =?utf-8?B?S2pEY29tbDVCdmVhcDNuNFduQ0o4aXFOTnhKVTdxR2FDT3grb3BzbjRwWVpJ?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5294a617-487d-4696-a81f-08daf53c8dcb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 08:02:45.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68LJG0BIyJ/ynA8L8K3/jICUQ6hX1CP5QlM9mxUn/23+x+0CKdwztTlyVdq0cEch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4892
X-Proofpoint-GUID: suY1LKcMYxFF95rvMR3Of-XGd95eBwMF
X-Proofpoint-ORIG-GUID: suY1LKcMYxFF95rvMR3Of-XGd95eBwMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_03,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/12/23 2:27 PM, Alexei Starovoitov wrote:
> On Thu, Jan 05, 2023 at 02:07:05PM +0200, Eduard Zingerman wrote:
>> On Thu, 2023-01-05 at 11:06 +0100, Jose E. Marchesi wrote:
>>>> On Sat, Dec 31, 2022 at 8:31 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>>
>>>>> BPF has two documented (non-atomic) memory store instructions:
>>>>>
>>>>> BPF_STX: *(size *) (dst_reg + off) = src_reg
>>>>> BPF_ST : *(size *) (dst_reg + off) = imm32
>>>>>
>>>>> Currently LLVM BPF back-end does not emit BPF_ST instruction and does
>>>>> not allow one to be specified as inline assembly.
>>>>>
>>>>> Recently I've been exploring ways to port some of the verifier test
>>>>> cases from tools/testing/selftests/bpf/verifier/*.c to use inline assembly
>>>>> and machinery provided in tools/testing/selftests/bpf/test_loader.c
>>>>> (which should hopefully simplify tests maintenance).
>>>>> The BPF_ST instruction is popular in these tests: used in 52 of 94 files.
>>>>>
>>>>> While it is possible to adjust LLVM to only support BPF_ST for inline
>>>>> assembly blocks it seems a bit wasteful. This patch-set contains a set
>>>>> of changes to verifier necessary in case when LLVM is allowed to
>>>>> freely emit BPF_ST instructions (source code is available here [1]).
>>>>
>>>> Would we gate LLVM's emitting of BPF_ST for C code behind some new
>>>> cpu=v4? What is the benefit for compiler to start automatically emit
>>>> such instructions? Such thinking about logistics, if there isn't much
>>>> benefit, as BPF application owner I wouldn't bother enabling this
>>>> behavior risking regressions on old kernels that don't have these
>>>> changes.
>>>
>>> Hmm, GCC happily generates BPF_ST instructions:
>>>
>>>    $ echo 'int v; void foo () {  v = 666; }' | bpf-unknown-none-gcc -O2 -xc -S -o foo.s -
>>>    $ cat foo.s
>>>          .file	"<stdin>"
>>>          .text
>>>          .align	3
>>>          .global	foo
>>>          .type	foo, @function
>>>    foo:
>>>          lddw	%r0,v
>>>          stw	[%r0+0],666
>>>          exit
>>>          .size	foo, .-foo
>>>          .global	v
>>>          .type	v, @object
>>>          .lcomm	v,4,4
>>>          .ident	"GCC: (GNU) 12.0.0 20211206 (experimental)"
>>>
>>> Been doing that since October 2019, I think before the cpu versioning
>>> mechanism was got in place?
>>>
>>> We weren't aware this was problematic.  Does the verifier reject such
>>> instructions?
>>
>> Interesting, do BPF selftests generated by GCC pass the same way they
>> do if generated by clang?
>>
>> I had to do the following changes to the verifier to make the
>> selftests pass when BPF_ST instruction is allowed for selection:
>>
>> - patch #1 in this patchset: track values of constants written to
>>    stack using BPF_ST. Currently these are tracked imprecisely, unlike
>>    the writes using BPF_STX, e.g.:
>>    
>>      fp[-8] = 42;   currently verifier assumes that fp[-8]=mmmmmmmm
>>                     after such instruction, where m stands for "misc",
>>                     just a note that something is written at fp[-8].
>>                     
>>      r1 = 42;       verifier tracks r1=42 after this instruction.
>>      fp[-8] = r1;   verifier tracks fp[-8]=42 after this instruction.
>>
>>    So the patch makes both cases equivalent.
>>    
>> - patch #3 in this patchset: adjusts verifier.c:convert_ctx_access()
>>    to operate on BPF_ST alongside BPF_STX.
>>    
>>    Context parameters for some BPF programs types are "fake" data
>>    structures. The verifier matches all BPF_STX and BPF_LDX
>>    instructions that operate on pointers to such contexts and rewrites
>>    these instructions. It might change an offset or add another layer
>>    of indirection, etc. E.g. see filter.c:bpf_convert_ctx_access().
>>    (This also implies that verifier forbids writes to non-constant
>>     offsets inside such structures).
>>     
>>    So the patch extends this logic to also handle BPF_ST.
> 
> The patch 3 is necessary to land before llvm starts generating 'st' for ctx access.
> That's clear, but I'm missing why patch 1 is necessary.
> Sure, it's making the verifier understand scalar spills with 'st' and
> makes 'st' equivalent to 'stx', but I'm missing why it's necessary.
> What kind of programs fail to be verified when llvm starts generating 'st' ?
> 
> Regarind -mcpu=v4.
> I think we need to add all of our upcoming instructions as a single flag.
> Otherwise we'll have -mcpu=v5,v6,v7 and full combinations of them.
> 
> -mcpu=v4 could mean:
> - ST
> - sign extending loads
> - sign extend a register
> - 32-bit JA
> - proper bswap insns: bswap16, bswap32, bswap64
> 
> The sign and 32-bit JA we've discussed earlier.
> The bswap was on my wish list forever.
> The existing TO_LE, TO_BE insns are really odd from compiler pov.
> The compiler should translate bswap IR op into proper bswap insn
> just like it does on all cpus.
> 
> Maybe add SDIV to -mcpu=v4 as well?

Right, we should add these insns in llvm17 with -mcpu=v4, so we
can keep the number of cpu generations minimum.

