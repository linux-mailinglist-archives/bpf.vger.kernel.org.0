Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D958DD01
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245099AbiHIRWF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245085AbiHIRWE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:22:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADBB237E9
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 10:22:03 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 279H9Ja8007038;
        Tue, 9 Aug 2022 10:21:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=45QKrhz8zEu6NyfMWNF06CwOdlpr8LrzDRL7VjGgEFs=;
 b=Gza5VrCdErnDAfGc3UO8cn/zn0bfPaQjD2QVM3vRRb/xeGTA/py+kMyjtXhzbanLsocA
 +JLuj/GgPnhi9FVC51rfdt/0PiSRXg8PtCoWHakf/xheHs6caZc21YpOmbQIDDgs+8in
 TGynPa6sa9Sd/vLfOOwQsi9sRD2kKAo0tBE= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by m0001303.ppops.net (PPS) with ESMTPS id 3huhydc8x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 10:21:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtU1hswi3/3HSE3TnNSSm+E2pHvI4RRNepHgoXX8mO4jiVy7l+X08YCAZa/w1nwNhxyan36+6jUNHJiZ7d5IS2XAZBULk558t4gQPwvV9VTNyg3TDUOlhXXbhF9Tk8xJaj9jmKb3UUTgHokKqimfC1CtDijgWFuJVCtjS3Qb+VnHdQxxo3NHNuWKC8kiCdGav4hhOPuBblp53r5SlTw4HIcAKIXO8IMnNfdOFxcR0y6Jw+s4l6UF8C3FunkZ9HhBWBzVbGRlQLoBS+iKwwuBWZYUQcENSXe/LAMILfZ9ZgXKUwgNim1rnSYgwjJrKjQ6lJbYfW/eC2Qiu2o9SiyYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45QKrhz8zEu6NyfMWNF06CwOdlpr8LrzDRL7VjGgEFs=;
 b=UVnCn8NkI+rPk2Mbi9XvyOxaNjtlZaUkNu12HKpV4RJx9FNqJ7+Vw6GiJKw1kvc6yAhCtQHPpDEUWyDMn9gvMQmUmFYAQdxMflBarEjQ/oI++1JXZYSVYrqKEXaeHqIOoaNnRUPZHq6vlpBRTg8XXw3bDcdBPZM3sGibmBGfB9005v31czZse3hJgOkC73ouIiWSRTgKE0exemRLBNT0oOizrK7ELe9QD7j/Fixp3MC36pu03bCu/c7vRaldU/SuoMFcHRPeUkjodwGQHFLFqe5xNqeeMnGUfxCUtVNgDXMgwVaUoO+W3L3mvwYuefeKol0Xh2thKA1WWVK9A7VUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1147.namprd15.prod.outlook.com (2603:10b6:3:bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 17:21:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 17:21:41 +0000
Message-ID: <ae74f476-be27-162a-e004-7bc112505473@fb.com>
Date:   Tue, 9 Aug 2022 10:21:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Perform necessary sign/zero extension
 for kfunc return values
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220807175111.4178812-1-yhs@fb.com>
 <20220807175121.4179410-1-yhs@fb.com>
 <CAADnVQK__BPkmgsjuLmBxZ3a=kDTA_cGR8oWLCvjLVDYYW6hfw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQK__BPkmgsjuLmBxZ3a=kDTA_cGR8oWLCvjLVDYYW6hfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:a03:255::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f592ae1-7902-4b34-3adf-08da7a2ba04b
X-MS-TrafficTypeDiagnostic: DM5PR15MB1147:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXxNFIN55uMl9X5pFIImn07fCaD59PJlFhPHna4/eQUsQxHmelcQgaW3p6sXwXr9uvhhFFi6IbP5hpmEMap+lQ7wOwJOTK2cWmwX8ajkRx2n6q8EqhgFHqwXCACEQGWOk2SlnOCwffStkqBcSwz7j/68IZVOgo7RKvhHIDAtqbixSjmDmxdlh/8qhuskKOROH0geWl6F1C1OTxZJ6A+EdtIQqgavFwD+VT9zFhY1F21TOTXk2XOEgKoEgVUdI9T/P2wvMK/3TuMtSiMyoNfE2P0gdmPYNCaQdzRk8sRGRPxgkyFPK0EuYUboPzNoOApE6uEXfVSoz/KZFIPEuF/xy/c8SHXF0AiIb9z5zQ8LSas9G+EgKv0bqzEhnHIAovKAKU3EgQNolQeUfPtwkhNennOzg0esiv0cEqPWpBPeFb0wC3LyjDLMqLAyErkNjf49vTvrlY9GBXmtMfx2liHLdthsLpm1hkjol5fWrjxWDrfl9PjwiMMy1mrMjsBEIfnOZMl16D8yi5DuwtgXBVFVvaiod8K1NSJz1GeRToaYgA+kwSKQzJU0IrgLHBiJw3xu1SmySwG6Zpuj2FkMXDdzNTXN+Vlue6F5SA4k00Ogcm/ALoVIjQprcf9ojOXLWyhaVWAGFtjDcEgv2NLa64y3bcHtY36vRxrA90CGUlJn0OCR3rMOZyWemXzEMQFUXMfhcz61AgC5O1XyGjMCfEP/PpWv8edVLB2aXwoBK49JgcUpuf2LRcivOlLBBF24EU/QxQEzwWZepLHvYMbbHZL95EB1G+eQYN3wnNvWlYw2BJ1j5BAy3wkZyK/mwAMnK5DV4kMxRtta+vUWUXk48wuR1xyBQJ4uATy9/cZSIxvoSr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(66946007)(8676002)(4326008)(2906002)(66476007)(66556008)(966005)(478600001)(36756003)(6916009)(54906003)(316002)(53546011)(6486002)(31696002)(38100700002)(41300700001)(6512007)(6506007)(86362001)(8936002)(5660300002)(31686004)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkRwMWpabmVPL3ZiaHpvRzVrSUFPV0N1M2VrY04rZ2xiOUV4VVEyaCtRQ0xj?=
 =?utf-8?B?QlZDRFhWMXN5bnQ5TFlhaDUxSzhHd280UC9HMC9FZTNjQm9FbHlRcjk1MVVF?=
 =?utf-8?B?WGdYNkdXZHA5eEhVcVpPbmVFb3Z3cjRERWlvMllMcExxU1VycVlxQXB4NEx1?=
 =?utf-8?B?Qy95VzVmdUdiZ0J0VEg0Q05RdkNmL0dUS09sSGxiaVhFYmV4ZWo3NGtKWlNS?=
 =?utf-8?B?SnRmN1I2dUZ6a2hOOGhqR0lQWjJpaU11dHdGY2tBYzV0VVhyc09za3VVbjA3?=
 =?utf-8?B?bzZjVmNiRkVETlBMSDhTbTRsbVArRjhJZk9aS3FyaXMySTVqd3JucEpjalZV?=
 =?utf-8?B?d1NVNldjc0lxQXRtWWlMQUkzRVRjMkFBakpDWVo3NEVoU29Fbit1SHA3bmFE?=
 =?utf-8?B?Q1JubXYxWnliejdnVmdFVnhLR3hiS29pRFgwWkk5YkFseG5HQmlnNHRWN1RM?=
 =?utf-8?B?bTZPUlNmeVhPSlFyR05SQjFCc3NEKzFGdThDdis1SnEzak5jWjNKWG12eGFw?=
 =?utf-8?B?N0FUZ09RN3dDMWxvRGRIM1VJVWRiN2U3OXVEUEVHR2ZrN3lvbUR3Q1ZTTVYw?=
 =?utf-8?B?eUdUWFpueFBiU09xMHJMNG5BcmtvRXlGUmc5U3ZrdWVxWEI1MXYvOE1FK2pT?=
 =?utf-8?B?S04zNXUweFBnbkI3YU5vRVVka1I0ZFVhSnZuaVhsSmoyWkNuOU1YU21IOEZ0?=
 =?utf-8?B?a3Z4TXFUdU5xbU1HQVhnWkRYOEVWWnJFM05EYTRYMm1NUUlnb211MWQ3VlZz?=
 =?utf-8?B?VTBWQ0hwL24wNXdodms5cDdsbFFQVHFxZVgrdmFRYzlqMWdiaTM0SHpOMlNB?=
 =?utf-8?B?THpZSm1ESWs4VEpCUzRWbXlSMlBDMjVYRVRUMGZ3Y0lTc0FydEUrU0NUNEN2?=
 =?utf-8?B?djJBanJnaWNVVzJmZ1JTeURwbDI3eUY0RVZSc3VNdzhyUVJSZ1ovVnhrTVpE?=
 =?utf-8?B?cW8rc2YyeTZjUmE0S21yZEpPdllqd283dnI0U1A5ZWpqMEhOeEg0WHJDVEl2?=
 =?utf-8?B?aGw2RjQ0NGprS0xUUHg3RnpkQ2paWmhKUVFSb2xaczExNmt6cHQvYXQ5MHdv?=
 =?utf-8?B?ZDdvUFhaSm9ZY0ZBUVRpR2trcUJNblZqWmltb0lsN05DQlZVdlI1S3hnSEh3?=
 =?utf-8?B?bVVpTGpkaU5RM0ZXTW1ob2JCdXFVMUlQekp3WElUaGtzeWJQWFlXdnYxNlBN?=
 =?utf-8?B?U2F0ZTJJaDFWSHEveGtFWWhXTHZxYlYvWnoyQjNNQXNOaHZiemJraU5TdXZL?=
 =?utf-8?B?dUxnL2VSdEd5VE1vQlNWR3RjNFJwdGRXSzFTTmJ2bHZ0QktOT1ZuallOLzZn?=
 =?utf-8?B?cEYzaW4rK1MrMFozL0dCUXp0RGkzdlVBOEQzYWdiUXFHNkcxNTR0OHhSWlNk?=
 =?utf-8?B?NUF4YjJGaVlXcTNjaVQybm9NeWJoa3cranRnYUtSRXVyTGI1dHNweTIyc2tC?=
 =?utf-8?B?TUJYSGdoRE90OU5xN0VDY2Y4cllVNnhpVkZPSk9KdkpQYlY2S3pDS2FUTUFG?=
 =?utf-8?B?ZW5lSXk4WVdUMVM0cGJPaEZ0bTQ0ZWRUUERQMWYwUmVjdHNkUDhUT01vQmJq?=
 =?utf-8?B?Y3Z1RlFvb3ptaXhHKzFBUVZCaVJwYTM1RlVpSkgyOGk0OXMxMlJnUE1CV21P?=
 =?utf-8?B?S3FPK1VNTnYyNXljWXV1UGxXTVBseUxERkdYcURYZWg0L25mU2cyWElOK002?=
 =?utf-8?B?cWJ3UG1DRWNxeXZPemduTXlzNWRybG1UVUZ1T09QbUdGZDl2M0F6N3FPR01I?=
 =?utf-8?B?L0ZPcUxVQ1RJVExqcEhQMFg0aWkzUk1sL2s1L1BXZXdNOWlvQU0weDUwMkxX?=
 =?utf-8?B?bjk4OHY5SHBKcWNIM24xd0hLOEJ0Rm4wNStnZ0hhMmR6cEU0SHU1MlhlQndN?=
 =?utf-8?B?QnFYY21lZjRPemkwTWVDRTMvTTVDNmpQWmdzeUUzODUrcmRNY0VqMS9nWVFl?=
 =?utf-8?B?Lzkwc1NHNWtUUHBsdDJRR1RXeXljdjJwUkJ1NnNaN0xrZlJpSVBrb3VPeGtv?=
 =?utf-8?B?c1U0aVVBUzI1M01yUXJmbVBSSStRQ3FZcTJ6R2VQUFdNb3BXZ0RUTGdsUmZI?=
 =?utf-8?B?bTgyeE9jaWJaM0RVZEY3cXRPbFVHYm1xRGd6L1JOMnc1ODIrbWJFZ1haNzhF?=
 =?utf-8?B?akFSZEhxS1pHZXNCSTg3S2trc01ubGNrN1c3djVnUk1LN2pwMkxQT1Zha2Jw?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f592ae1-7902-4b34-3adf-08da7a2ba04b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 17:21:41.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqU/8KDVBGJFIOH90m5ftpN15YgCSMi/T6W3oUvWnel7NRhveKxnGzcR8u3Wetb9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1147
X-Proofpoint-GUID: 1BowvoBiL3_KJ7CZRAXO79vmZIV1lvbT
X-Proofpoint-ORIG-GUID: 1BowvoBiL3_KJ7CZRAXO79vmZIV1lvbT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/9/22 10:02 AM, Alexei Starovoitov wrote:
> On Sun, Aug 7, 2022 at 10:51 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Tejun reported a bpf program kfunc return value mis-handling which
>> may cause incorrect result. The following is an example to show
>> the problem.
>>    $ cat t.c
>>    unsigned char bar();
>>    int foo() {
>>          if (bar() != 10) return 0; else return 1;
>>    }
>>    $ clang -target bpf -O2 -c t.c
>>    $ llvm-objdump -d t.o
>>    ...
>>    0000000000000000 <foo>:
>>         0:       85 10 00 00 ff ff ff ff call -1
>>         1:       bf 01 00 00 00 00 00 00 r1 = r0
>>         2:       b7 00 00 00 01 00 00 00 r0 = 1
>>         3:       15 01 01 00 0a 00 00 00 if r1 == 10 goto +1 <LBB0_2>
>>         4:       b7 00 00 00 00 00 00 00 r0 = 0
>>
>>    0000000000000028 <LBB0_2>:
>>         5:       95 00 00 00 00 00 00 00 exit
>>    $
>>
>> In the above example, the return type for bar() is 'unsigned char'.
>> But in the disassembly code, the whole register 'r1' is used to
>> compare to 10 without truncating upper 56 bits.
>>
>> If function bar() is implemented as a bpf function, everything
>> should be okay since bpf ABI will make sure the caller do
>> proper truncation of upper 56 bits.
>>
>> But if function bar() is implemented as a non-bpf kfunc,
>> there could a mismatch between bar() implementation and bpf program.
>> For example, if the host arch is x86_64, the bar() function
>> may just put the return value in lower 8-bit subregister and all
>> upper 56 bits could contain garbage. This is not a problem
>> if bar() is called in x86_64 context as the caller will use
>> %al to get the value.
>>
>> But this could be a problem if bar() is called in bpf context
>> and there is a mismatch expectation between bpf and native architecture.
>> Currently, bpf programs use the default llvm ABI ([1], function
>> isPromotableIntegerTypeForABI()) such that if an integer type size
>> is less than int type size, it is assumed proper sign or zero
>> extension has been done to the return value. There will be a problem
>> if the kfunc return value type is u8/s8/u16/s16.
>>
>> This patch intends to address this issue by doing proper sign or zero
>> extension for the kfunc return value before it is used later.
>>
>>   [1] https://github.com/llvm/llvm-project/blob/main/clang/lib/CodeGen/TargetInfo.cpp
>>
>> Reported-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h   |  2 ++
>>   kernel/bpf/btf.c      |  9 +++++++++
>>   kernel/bpf/verifier.c | 35 +++++++++++++++++++++++++++++++++--
>>   3 files changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 20c26aed7896..b6f6bb1b707d 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -727,6 +727,8 @@ enum bpf_cgroup_storage_type {
>>   #define MAX_BPF_FUNC_REG_ARGS 5
>>
>>   struct btf_func_model {
>> +       u8 ret_integer:1;
>> +       u8 ret_integer_signed:1;
>>          u8 ret_size;
>>          u8 nr_args;
>>          u8 arg_size[MAX_BPF_FUNC_ARGS];
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 8119dc3994db..f30a02018701 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -5897,6 +5897,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>>          u32 i, nargs;
>>          int ret;
>>
>> +       m->ret_integer = false;
>>          if (!func) {
>>                  /* BTF function prototype doesn't match the verifier types.
>>                   * Fall back to MAX_BPF_FUNC_REG_ARGS u64 args.
>> @@ -5923,6 +5924,14 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>>                  return -EINVAL;
>>          }
>>          m->ret_size = ret;
>> +       if (btf_type_is_int(t)) {
>> +               m->ret_integer = true;
>> +               /* BTF_INT_BOOL is considered as unsigned */
>> +               if (BTF_INT_ENCODING(btf_type_int(t)) == BTF_INT_SIGNED)
>> +                       m->ret_integer_signed = true;
>> +               else
>> +                       m->ret_integer_signed = false;
>> +       }
>>
>>          for (i = 0; i < nargs; i++) {
>>                  if (i == nargs - 1 && args[i].type == 0) {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 096fdac70165..684f8606f341 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13834,8 +13834,9 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>>   }
>>
>>   static int fixup_kfunc_call(struct bpf_verifier_env *env,
>> -                           struct bpf_insn *insn)
>> +                           struct bpf_insn *insn, struct bpf_insn *insn_buf, int *cnt)
>>   {
>> +       u8 ret_size, shift_cnt, rshift_opcode;
>>          const struct bpf_kfunc_desc *desc;
>>
>>          if (!insn->imm) {
>> @@ -13855,6 +13856,26 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
>>
>>          insn->imm = desc->imm;
>>
>> +       *cnt = 0;
>> +       ret_size = desc->func_model.ret_size;
>> +
>> +       /* If the kfunc return type is an integer and the type size is one byte or two
>> +        * bytes, currently llvm/bpf assumes proper sign/zero extension has been done
>> +        * in the caller. But such an asumption may not hold for non-bpf architectures.
>> +        * For example, for x86_64, if the return type is 'u8', it is possible that only
>> +        * %al register is set properly and upper 56 bits of %rax register may contain
>> +        * garbage. To resolve this case, Let us do a necessary truncation to zero-out
>> +        * or properly sign-extend upper 56 bits.
>> +        */
>> +       if (desc->func_model.ret_integer && ret_size < sizeof(int)) {
> 
> Few questions...
> Do we really need 'ret_integer' here?
> and is it x86 specific?
> afaik only x86 has 8 and 16-bit subregisters.
> On all other archs the hw cannot write such quantities into
> a register and don't touch the upper bits.
> At the same time such return values from kfunc are rare.
> I don't think we have such a case in the current set of kfuncs.
> So being safe than sorry is a reasonable trade off and
> gating by x86 only is unnecessary.
> So how about just if (ret_size < sizeof(int)) here?

good questions. yes, we don't need ret_integer here with the
current code base.

I added ret_integer because my kfunc struct argument/return value
support work (in RFC stage). In that case, we could have
a 1-byte or 2-bytes structure as return value in which case,
we should not do sign/extension. With checking ret_integer,
we can avoid the churn later.

But it is not clear whether we will support kfunc return struct
as we don't have a request so far. So I will remove ret_integer
in the next revision.

> 
>> +               shift_cnt = (sizeof(u64) - ret_size) * 8;
>> +               rshift_opcode = desc->func_model.ret_integer_signed ? BPF_ARSH : BPF_RSH;
>> +               insn_buf[0] = *insn;
>> +               insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, shift_cnt);
>> +               insn_buf[2] = BPF_ALU64_IMM(rshift_opcode, BPF_REG_0, shift_cnt);
>> +               *cnt = 3;
>> +       }
>> +
>>          return 0;
>>   }
>>
>> @@ -13996,9 +14017,19 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                  if (insn->src_reg == BPF_PSEUDO_CALL)
>>                          continue;
>>                  if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>> -                       ret = fixup_kfunc_call(env, insn);
>> +                       ret = fixup_kfunc_call(env, insn, insn_buf, &cnt);
>>                          if (ret)
>>                                  return ret;
>> +                       if (cnt == 0)
>> +                               continue;
>> +
>> +                       new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>> +                       if (!new_prog)
>> +                               return -ENOMEM;
>> +
>> +                       delta    += cnt - 1;
>> +                       env->prog = prog = new_prog;
>> +                       insn      = new_prog->insnsi + i + delta;
>>                          continue;
>>                  }
>>
>> --
>> 2.30.2
>>
