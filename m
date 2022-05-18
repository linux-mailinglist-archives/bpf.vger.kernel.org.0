Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5864652B390
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiERHiD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiERHiC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 03:38:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60376D411F
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 00:38:00 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I0S8eD009706;
        Wed, 18 May 2022 00:35:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2zBjSmO0wZ+ayX3ibNs/5Ujq25ImbKduiv35F5g5c4U=;
 b=OOTaL+v/amG2LGtNFGn9ZdhcWrUBamMy6/+WEGn9lfSZlfU8mcTayBxeioePLx0WF2gs
 ZLkxH7h/U3BtL+WaBOh6msvBTBfO4NaoSldEdJtM24SfJ5Smh76Q/b94hER9nkIzgWlb
 CA/qV3DY881aTrVT/Q0A8lHf0myeM/iH2H0= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4p9g9nem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 00:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUQswWlHKwZxgH0bLK+c9uBXYos7OGsqfP3KQW4sZUZ1kiLlh7q9FnNPCGnPDnWE/Dvzgb3KhjYBXvbTwGX1os1HJZxdpL9KwWWLzeH7exBlRniT7dF5OJVW5GUgEBsUI7eHPqYrEXSd96EEXFCkzIjxNAVX/Ficf4nPlmOfTzrvMFP0kSmgGx9+WbYK0/8dppvAEQeYaY4Fxk1HhdJXgLusQ+h7OfWfETte8GRVNViOUBabuc/INRKrL3hLBXogsLjQ4peGKcU0LYsV/SKD6AzCbbzpqtuD+pjlTFbWbRw71NLBKtid5n3/jLTVA1nJJ3rAOQnOc9clKRkwXbtG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zBjSmO0wZ+ayX3ibNs/5Ujq25ImbKduiv35F5g5c4U=;
 b=jvt7gSZc6ofEX/GizcKZOGkDP7uu/d/3+WC1Ri//GROYYe7CXpyCRC3spaJcDbCZLKahnn/qR6kH8tNIek84eIBsgypNhg2wJGSjmj/N/9U0x/VeEa3ltAFma4Rbv+8iuZheplD81bQwoYT/BnHuySO+OiJdcNhvPXrbitFj5BXgQw+fiXqP57M1rOy1dSQJ6prGr2W2aPJqTAmfIV46hvixOSWRYfKAX3lTg2Oir9vwBhZTK9IEdJXM5IH9CAwGXh9+eAJGsdMyyYicz0qBZqxL8bXPfFZxHPIuuvtENHet9MDv9Po/9J3g7Wuw3LeRvM0tZFyWyuKqiUSuQc3Dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by PH0PR15MB5072.namprd15.prod.outlook.com (2603:10b6:510:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 07:35:35 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%8]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 07:35:35 +0000
Message-ID: <cbc4fda1-c67c-dec7-c1ad-97142c2a1fa3@fb.com>
Date:   Wed, 18 May 2022 03:35:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [RFC PATCH bpf-next 2/5] bpf: add get_reg_val helper
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Rik van Riel <riel@surriel.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, kernel-team@fb.com
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-3-davemarchevsky@fb.com>
 <20220514004121.qkbj3jgibpih3sxy@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220514004121.qkbj3jgibpih3sxy@MBP-98dd607d3435.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:208:2be::23) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a14c9aeb-8d0f-4d84-3769-08da38a0ff11
X-MS-TrafficTypeDiagnostic: PH0PR15MB5072:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB50723C8F3A3DC8296ACEF950A0D19@PH0PR15MB5072.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lVr4bRQyrsjhx5iOq8h41dfBzb+J2jl8X6izI63f/vNahqwVgLI2eHRsW6NsKa7sDJPoMw/f7s9p5p7fyjukPRRSJX6eTNgELKR7Hz5LKzsG4zOZB+9NRLTfa+ch4HZiYO+IVCeU/zt7FUCLEHeDY5chueRo5bj7V+KHFWAVrU7L8jyrk5CSLQrPGB7jm4V3JJ9szLXuqF848wXRIUCcj8UONeA3w2KccNOIHpWkGKGyOF32JNJsZ3j7hTRho2KnNlU5wz4bjdOrrKOUYagR+HrD1zK+vzZQJDxC+LtJzN5jmaMQnBteDRgWUQPeqPzskR/6xhDfvirnrHmpZoFaw2wWc87TiCyptBT8MbGa4Qu6XgZGqAax9+4lChQI4BvGpMLqevUQx7sVquf/7mkZp6bOVF/71qWhvbpWkAQMO4ZBjQpYeTIYQGcRx4w9h7l+kdpb45dj0YVMGZZHp3pde1CFxxl5QZqKje1+zj5u9HMBj790pKdsJFMRmE/AVPofSjOlTFDLx1LPQpvTqhfP3FilkScMLuFpkZXfrGbvn1c9XEzag+Sp7MfwrdyEfMUo2+lD5JUkTMcbu/Ls2XmgEM6An3t83Gb3IjIDc1v6eGrr6MMwdUGxh5HjajGGq8BhdSt7zgia2WiTbL3SmdPbV4rTL2n/cqt5P/LWNl2L4A6fTCP1Wz8DGjGPe1T9b93gKY+FGi5cckJ1wThzLEQnZwcLHibyZqhx6LsPTOS4wo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(110136005)(38100700002)(83380400001)(2616005)(5660300002)(4326008)(31686004)(2906002)(8936002)(6512007)(66476007)(53546011)(6506007)(8676002)(54906003)(86362001)(31696002)(66556008)(6666004)(66946007)(316002)(36756003)(6486002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVFmOVk3NnoveU9qZEJpUDZGQVY1WENZeXdBWk5BV01aZFM4dDZ2WlVrMkJ6?=
 =?utf-8?B?UzFXb0pYMmcrTG40RHdUb0k2ajBVeWNxNnVQd052dVVtS0FMU0pXNGJUdnd0?=
 =?utf-8?B?WHpiakJvZTdhQjFOdUdGbE5oMDQ1em9JSVZqQ0trQ0hCSGV1MHJESGdOOGdH?=
 =?utf-8?B?MGRoTHY5c0tFbDFiUGFUYThtaEYzYlo2Z0lqUUhnUFlmMWMvbjJkTSs5QzVM?=
 =?utf-8?B?b0I0cm5ZcEU5dkU2VmxSUzFTemZ0K08vcWE2bHBYcUs3alBDRzd2UFVneG1r?=
 =?utf-8?B?TURJQUJmVkRKeGEreStqd2RZYzd3SzBxMmU1Nm42Si9tSS9WV3AwN1FaN0RV?=
 =?utf-8?B?S0J5RnpHcERoVlNENGdHQ3FRd1JQbmdWR2hNOEhYbVlYNlFTMU5Ddk83UG02?=
 =?utf-8?B?UTRFTEJGbTJUMi9QT3lQVlhHOXV5MkE3R3l3V0FUSFdDYzA4Tk1pZWdJTWpM?=
 =?utf-8?B?K3cxMThQTjFnRUdmbFB6OXdWd2xLU3hVRm1lQ0IvV2YwdkJmdk9vSHRHWGJO?=
 =?utf-8?B?RTVpWXpLQ1NiZ0kwUkxlQ3RRTW96K3Z6N3laTjNla3MweXlPOG8zV0pLclpx?=
 =?utf-8?B?S2RLRWRvbys4RE02UEt0dmxtc2t0MW1HNjJRK1phYm1nS25lcmNaSUY4VUM0?=
 =?utf-8?B?RitzUXBTbHV5eW9mOG5oNlZuOHpqSjh2UDc5RFRTTTJCWEltSXFJWFlpNUxU?=
 =?utf-8?B?aTh2V2xGN3ZuaWU3ME9MMndFTklmb1ZERlYvT0NQV1JicmZrVUtySmltcERs?=
 =?utf-8?B?RmFQN0lRS3k4Z3B2VkYvNFJxeFJPc3lwalU2SytKN0NzOFFMRTJYRmMrWGJn?=
 =?utf-8?B?VFAyTXJ5M09vN2JuUlJkTGNLckNzV1BLMEpWRDVhYWNSbGZhQThCTmVaNnJM?=
 =?utf-8?B?R3JpSDB4NzgvTU03eXUwdXVDakNzMWpyZUMrZ0xOSll6dktCNHY3MTI0RkNG?=
 =?utf-8?B?N0VGT21PN283NTg1cUNsZWtON2ZMelNTNVZNdGtSOHNpVFdvNnlTR3hNUHVi?=
 =?utf-8?B?T1QzUDFUOUY5SjBjOE5sdzNRK0tYcHdZdWxZQlkrQUJpc214OGlTdVM4S2dy?=
 =?utf-8?B?QnV3V3BSS01jY2htQXlJMVBTKzFLUHh0V2hIbTgyL0xxampQWENqbS8weWFr?=
 =?utf-8?B?TXBTMkpkd1A0UHFtcVMyVjJEQVRoTTZLVHIxVjdQWnk4d1pSUHEySStJN2pE?=
 =?utf-8?B?b3RObXR6Q1IyZ3l0dTIxbTBPVmRQdjM0OUcyL3Y5TDVOdy96RmtQTVJlSFlv?=
 =?utf-8?B?STlxRDJBWjAyWmhUQ2hXek1GTHFwZXdkN2NJV2tiamxuRURoR0Z5RGpMNURK?=
 =?utf-8?B?cnhtYTV5ZVFVS0RlNUQ1U2FjblBmelpWQlY3SzU3T3BXYy96dWQreWlHN08y?=
 =?utf-8?B?UmhLY0dNaWF5TUFsUDIrNTBVVmEvUEM3OHFkd2VtSWtjbWl6ZlpXV3YweFIr?=
 =?utf-8?B?YXd2aHF4SUVUMlBycm5adncwQUdmSi95MGdZRlhEUUdmNTdZMEVvVzZ4L0NH?=
 =?utf-8?B?aEVkd3d2a2drejdrSk5DeWtMY1o3N2NzRm4zdk1RczM3TldUckhPbkticHlL?=
 =?utf-8?B?YU9QL0cxMkUwNU1JNVV5NWFQNERja3pZeVFMMDhnSWs3TGdFbkpIVjFyTDFP?=
 =?utf-8?B?QVhZQzNUNmV6eU56NVNLSDlRUno0UmRlcVQxbmNRZkRCMmZLU2JQKzVGeXhr?=
 =?utf-8?B?WmFBaDhFWEZhRTFVUmR6aGUrWW5FdmNlbXhxeWY5OTJhV2RBZW96YTFYdGMx?=
 =?utf-8?B?MzZmeXNoejJUaEFLL3F5VmxtbWpaSHdoVlBRV2JUTU5Zbmxra3pKT2VmTURp?=
 =?utf-8?B?d1VpVEdRcERqNnR2YndtOWU1MDR1bFFYTncvU0NxOVdWTGQ5cktMazRkVm1H?=
 =?utf-8?B?eCtzMk5ZZkpSU2lqUnFSMlE4WU5wekI4Y0hLRzhYa2JsVjZtREFKam41S216?=
 =?utf-8?B?MWppUytFUDM3MnNEalJqdHI3SUFKdWpjQkV1dHROUWJVMXJGejZBRXp6ZktJ?=
 =?utf-8?B?d2dMREVvcUF4OTJDbTY5bmtUTXByS2MvZm9UUytpaUFnbkNOUHA0OUowSC9O?=
 =?utf-8?B?dW1uMkNKNFlyUEJlMUdlNUc1TEMvTjM0Zm5UZTgzcFZaRFF6enRYZHNMMWNB?=
 =?utf-8?B?S0tEZXVLQUdlS0hSZVFINVNYLzdVM0FyRUNzMGQ0dHo0ek0rWG5IWUIrY0xE?=
 =?utf-8?B?Y09VSEtxTG1tWk9UcW5qNml5MkRMbkRVcUViVlJJR1M0VTJ3YVRQZGhTb0Nn?=
 =?utf-8?B?a0laMDlISkdVOE9UT3Zod3VkWktwTmhsS3lJMWRxUFhYK1VxYXh1V3I0a2d5?=
 =?utf-8?B?UG5lRElkbWlIRVdrTHBVays1N09Dakc1Ni9wQWZjRGZROXRWcXR0S1NWdUww?=
 =?utf-8?Q?EhqNCkm7ZtGeYgdQSg3gNvFyi8oqIk7d2TZx+?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14c9aeb-8d0f-4d84-3769-08da38a0ff11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 07:35:35.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXg0k6OVv8alt5ez5BB930dJegzd8qphvq8E464u/srJdtHX9t7eGhD6HvDGydxh8daOd/dM5Ol97Qj1b13sQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5072
X-Proofpoint-ORIG-GUID: kmrkh1B8Fe2oiGjOc0dEGK-AKPZ_Ua7M
X-Proofpoint-GUID: kmrkh1B8Fe2oiGjOc0dEGK-AKPZ_Ua7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_02,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/13/22 8:41 PM, Alexei Starovoitov wrote:   
> On Thu, May 12, 2022 at 12:43:18AM -0700, Dave Marchevsky wrote:
>> Add a helper which reads the value of specified register into memory.
>>
>> Currently, bpf programs only have access to general-purpose registers
>> via struct pt_regs. Other registers, like SSE regs %xmm0-15, are
>> inaccessible, which makes some tracing usecases impossible. For example,
>> User Statically-Defined Tracing (USDT) probes may use SSE registers to
>> pass their arguments on x86. While this patch adds support for %xmm0-15
>> only, the helper is meant to be generic enough to support fetching any
>> reg.
>>
>> A useful "value of register" definition for bpf programs is "value of
>> register before control transfer to kernel". pt_regs gives us this
>> currently, so it's the default behavior of the new helper. Fetching the
>> actual _current_ reg value is possible, though, by passing
>> BPF_GETREG_F_CURRENT flag as part of input.
>>
>> For SSE regs we try to avoid digging around in task's fpu state by first
>> reading _current_ value, then checking to see if the state of cpu's
>> floating point regs matches task's view of them. If so, we can just
>> return _current_ value.
>>
>> Further usecases which are straightforward to support, but
>> unimplemented:
>>   * using the helper to fetch general-purpose register value.
>>   currently-unused pt_regs parameter exists for this reason.
>>
>>   * fetching rdtsc (w/ BPF_GETREG_F_CURRENT)
>>
>>   * other architectures. s390 specifically might benefit from similar
>>   fpu reg fetching as USDT library was recently updated to support that
>>   architecture.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  include/uapi/linux/bpf.h       |  40 +++++++++
>>  kernel/trace/bpf_trace.c       | 148 +++++++++++++++++++++++++++++++++
>>  kernel/trace/bpf_trace.h       |   1 +
>>  tools/include/uapi/linux/bpf.h |  40 +++++++++
>>  4 files changed, 229 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 444fe6f1cf35..3ef8f683ed9e 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5154,6 +5154,18 @@ union bpf_attr {
>>   *		if not NULL, is a reference which must be released using its
>>   *		corresponding release function, or moved into a BPF map before
>>   *		program exit.
>> + *
>> + * long bpf_get_reg_val(void *dst, u32 size, u64 getreg_spec, struct pt_regs *regs, struct task_struct *tsk)
>> + *	Description
>> + *		Store the value of a SSE register specified by *getreg_spec*
>> + *		into memory region of size *size* specified by *dst*. *getreg_spec*
>> + *		is a combination of BPF_GETREG enum AND BPF_GETREG_F flag e.g.
>> + *		(BPF_GETREG_X86_XMM0 << 32) | BPF_GETREG_F_CURRENT.*
>> + *	Return
>> + *		0 on success
>> + *		**-ENOENT** if the system architecture does not have requested reg
>> + *		**-EINVAL** if *getreg_spec* is invalid
>> + *		**-EINVAL** if *size* != bytes necessary to store requested reg val
>>   */
>>  #define __BPF_FUNC_MAPPER(FN)		\
>>  	FN(unspec),			\
>> @@ -5351,6 +5363,7 @@ union bpf_attr {
>>  	FN(skb_set_tstamp),		\
>>  	FN(ima_file_hash),		\
>>  	FN(kptr_xchg),			\
>> +	FN(get_reg_val),		\
>>  	/* */
>>  
>>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>> @@ -6318,6 +6331,33 @@ struct bpf_perf_event_value {
>>  	__u64 running;
>>  };
>>  
>> +/* bpf_get_reg_val register enum */
>> +enum {
>> +	BPF_GETREG_X86_XMM0 = 0,
>> +	BPF_GETREG_X86_XMM1,
>> +	BPF_GETREG_X86_XMM2,
>> +	BPF_GETREG_X86_XMM3,
>> +	BPF_GETREG_X86_XMM4,
>> +	BPF_GETREG_X86_XMM5,
>> +	BPF_GETREG_X86_XMM6,
>> +	BPF_GETREG_X86_XMM7,
>> +	BPF_GETREG_X86_XMM8,
>> +	BPF_GETREG_X86_XMM9,
>> +	BPF_GETREG_X86_XMM10,
>> +	BPF_GETREG_X86_XMM11,
>> +	BPF_GETREG_X86_XMM12,
>> +	BPF_GETREG_X86_XMM13,
>> +	BPF_GETREG_X86_XMM14,
>> +	BPF_GETREG_X86_XMM15,
>> +	__MAX_BPF_GETREG,
>> +};
> 
> Can we do BPF_GETREG_X86_XMM plus number instead?
> Enumerating every possible register will take quite some space in uapi
> and bpf progs probably won't be using these enum values directly anyway.
> usdt spec will have something like "xmm5" as a string.

Works for me. I was doing something like that originally, Andrii preferred it
this way. I didn't have strong feeling either way at the time, but your "will
take space in uapi" argument is compelling.

> 
>> +
>> +/* bpf_get_reg_val flags */
>> +enum {
>> +	BPF_GETREG_F_NONE = 0,
>> +	BPF_GETREG_F_CURRENT = (1U << 0),
>> +};
>> +
>>  enum {
>>  	BPF_DEVCG_ACC_MKNOD	= (1ULL << 0),
>>  	BPF_DEVCG_ACC_READ	= (1ULL << 1),
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index f15b826f9899..0de7d6b3af5b 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -28,6 +28,10 @@
>>  
>>  #include <asm/tlb.h>
>>  
>> +#ifdef CONFIG_X86
>> +#include <asm/fpu/context.h>
>> +#endif
>> +
>>  #include "trace_probe.h"
>>  #include "trace.h"
>>  
>> @@ -1166,6 +1170,148 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
>>  	.arg1_type	= ARG_PTR_TO_CTX,
>>  };
>>  
>> +#define XMM_REG_SZ 16
>> +
>> +#define __xmm_space_off(regno)				\
>> +	case BPF_GETREG_X86_XMM ## regno:		\
>> +		xmm_space_off = regno * 16;		\
>> +		break;
>> +
>> +static long getreg_read_xmm_fxsave(u32 reg, struct task_struct *tsk,
>> +				   void *data)
>> +{
>> +	struct fxregs_state *fxsave;
>> +	u32 xmm_space_off;
>> +
>> +	switch (reg) {
>> +	__xmm_space_off(0);
>> +	__xmm_space_off(1);
>> +	__xmm_space_off(2);
>> +	__xmm_space_off(3);
>> +	__xmm_space_off(4);
>> +	__xmm_space_off(5);
>> +	__xmm_space_off(6);
>> +	__xmm_space_off(7);
>> +#ifdef	CONFIG_X86_64
>> +	__xmm_space_off(8);
>> +	__xmm_space_off(9);
>> +	__xmm_space_off(10);
>> +	__xmm_space_off(11);
>> +	__xmm_space_off(12);
>> +	__xmm_space_off(13);
>> +	__xmm_space_off(14);
>> +	__xmm_space_off(15);
>> +#endif
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	fxsave = &tsk->thread.fpu.fpstate->regs.fxsave;
>> +	memcpy(data, (void *)&fxsave->xmm_space + xmm_space_off, XMM_REG_SZ);
>> +	return 0;
> 
> It's all arch specific.
> This one and majority of other functions should probably go
> into arch/x86/net/bpf_jit_comp.c? instead of generic code.
> bpf_trace.c doesn't fit.
> 
> Try to avoid all ifdef-s. It's a red flag.

Will move these.

> 
>> +static long bpf_read_sse_reg(u32 reg, u32 flags, struct task_struct *tsk,
>> +			     void *data)
>> +{
>> +#ifdef CONFIG_X86
>> +	unsigned long irq_flags;
>> +	long err;
>> +
>> +	switch (reg) {
>> +	__bpf_sse_read(0);
>> +	__bpf_sse_read(1);
>> +	__bpf_sse_read(2);
>> +	__bpf_sse_read(3);
>> +	__bpf_sse_read(4);
>> +	__bpf_sse_read(5);
>> +	__bpf_sse_read(6);
>> +	__bpf_sse_read(7);
>> +#ifdef CONFIG_X86_64
>> +	__bpf_sse_read(8);
>> +	__bpf_sse_read(9);
>> +	__bpf_sse_read(10);
>> +	__bpf_sse_read(11);
>> +	__bpf_sse_read(12);
>> +	__bpf_sse_read(13);
>> +	__bpf_sse_read(14);
>> +	__bpf_sse_read(15);
>> +#endif /* CONFIG_X86_64 */
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (flags & BPF_GETREG_F_CURRENT)
>> +		return 0;
>> +
>> +	if (!fpregs_state_valid(&tsk->thread.fpu, smp_processor_id())) {
>> +		local_irq_save(irq_flags);
> 
> why disable irqs?

An irq can use those regs, which requires calling kernel_fpu_begin + 
kernel_fpu_end to ensure registers are restored before returning to userspace.
So for a sleepable program an irq might come and overwrite fxsave state.

Actually, now I'm not sure if it's necessary. kernel_fpu_begin_mask impl has:

  if (!(current->flags & PF_KTHREAD) &&
      !test_thread_flag(TIF_NEED_FPU_LOAD)) {
    set_thread_flag(TIF_NEED_FPU_LOAD);
    save_fpregs_to_fpstate(&current->thread.fpu);
  }
  __cpu_invalidate_fpregs_state();

So for the above scenario, the handler, which only tries to read fxsave if 
!fpregs_state_valid, should only ever read fxsave if TIF_NEED_FPU_LOAD is set,
and save_fpregs_to_fpstate will never execute.

Rik, can you confirm my logic here? We talked previously about disabling
interrupts being necessary, but I may be misremembering.

IIUC TIF_NEED_FPU_LOAD exists to provide this kind of optimization. If it's 
unset and we're returning to user, then we don't need to restore regs, if it's
already set and we're getting ready to do something with fpregs in the kernel,
we don't need to save regs. If we can rely on this, maybe can avoid disabling
irqs?

> 
>> +		err = getreg_read_xmm_fxsave(reg, tsk, data);
>> +		local_irq_restore(irq_flags);
>> +		return err;
>> +	}
> 
> What is the use case to read other task regs?

I don't have a clear one, will remove.
