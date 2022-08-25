Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40615A07C2
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiHYEFB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 00:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYEFA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 00:05:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8A31AF25
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 21:04:58 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P0j4LH021418;
        Wed, 24 Aug 2022 21:04:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EzFg6BIIniOexUL+rHw+L+nmyZyAtEusH20ly7gdYOA=;
 b=ZW277+8eOdaOlrQhZ196jSL7qaf6veacqEPg7wye80AjiRIQnRa8iTzcW+So85zoaJu8
 H5qUZGCYnd+M1/9RhxJrtMPlplSGb7icnUNA7ZFKAsTQyAS8qhlYO/c6jw8U4H6oBbB6
 aGGilE62eMq+eimdubQ74LEPbSdbtidgqZI= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5bek00sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 21:04:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ddp/AhI9wRqCQcjNiRmhxMIQhKL4rdhh1s4Fjra8iROo8Vbpwuu/JCyqgLVL2VtZW2y+FINL0xcuU45COEz7knRETzLEOhWb5YnrDxh5FFNgYj/AcpRPlArhhdhaxDmugNijOM7Qy5MGqC0JyF5s8E0h8/Ce5JWad6AQdGJFEGGeRosi5JqHi+XcSC0Py2j+FWgrK8SKV9xm+q/d5L8uACkgJL+bJp7j1xtacIttmG406BD96JUu649ve62IfQIZbNPKYEyfZcSnHO0Bk+dj716tJdub9jBCFCM3kN7KqlCrzID3MffnVi80NRdMI5OHwN7mks3lsa8Z9dcyZosypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzFg6BIIniOexUL+rHw+L+nmyZyAtEusH20ly7gdYOA=;
 b=Ksi28PvMy/Op1CT0v5UztL1T6sisVARF0ft55ZoRZ3+7gJXtdxx4BD+JQ3LVslR7jKn/iq8kQcn+cUXJF+0+7+aUv+8ryD3opBwiEQ+thpJJH6e0W9T7xtjKBErPVIx32tSzCT3BDRHcSC41JZDqSkBwg8vZWg4ZyA3eOo1+BD8cIwm/+kCXZCAvz25+1wVyXB2FUOWVohyoTz8Thyn6LOYNkJKWYhHpapAlbD9SjbU69r/6EHvAyirEn8PFy4XZ0iIN5OVcCfGuMBcqLGoytM5ZdeEKZxyBWAZB102AS/6xBNMoSy/tsJfic8KcvpOW2qbXB50DGAzL2jHTeL1lqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3467.namprd15.prod.outlook.com (2603:10b6:5:171::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 04:04:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 04:04:30 +0000
Message-ID: <7de2c92f-844c-a12e-3dc4-c92821c18e3a@fb.com>
Date:   Wed, 24 Aug 2022 21:04:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct
 arguments
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220812052419.520522-1-yhs@fb.com>
 <20220812052435.523068-1-yhs@fb.com>
 <CAADnVQKvtxdSo3chBeGtv8KsoQ8drrpa7x=1sOem1kwYKr5iRw@mail.gmail.com>
 <bdb4feae-47c3-80f6-cc10-741f90c28eeb@fb.com>
 <20220818204428.whsirz2m6prikg7n@MacBook-Pro-3.local>
 <CAEf4BzZOGWFxGOD8hMH9v4gJPGv0tf5464Aa0DivDFrRhenx0Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZOGWFxGOD8hMH9v4gJPGv0tf5464Aa0DivDFrRhenx0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02ae1584-3cdf-45d9-870a-08da864ee8e9
X-MS-TrafficTypeDiagnostic: DM6PR15MB3467:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eXEeY3hpWlGzsUQ4tyBtorg8qxWCTz+g3I7qQ7LUuOSuRp4XyvaoRLKt18kJO1YfidGyI/pwlKYV0h12G4eoPvXv1VRelC7p461uRvmm7W/DTo6uIvtEiW8uWqVX9M8Mqdc1e5NO5vqV/2hCtWcSWW36ge2CPjNNXiihvhvtJwcN0Fe/v4ULVi6LM7PEFZKLBu5tnPc4ZrT6jX+1GZbx+VEIR2ueYcdlIKkUIA6I09lr7BarhFdxcLR51kogNqTM3xyesVJGvxWle5TosRe1jqc3HaTHqzbaviNsTLIgpbzLJAFoaR+Ms9TzvtDH+p26qODZ8Q96eJJSBnUQpk6Yi+z9r0sHcrFzG+qhXNOQD3UdvyUmnGRzTYD2eRzdfAUYtdtplVj6ptvIIMXXA0eapf162xBPfjue1cX2WrtkGCpgvdAVn7YnwucABiBBZQLRKDruvxKqGUiCD/F/AXlZCfwTQ2cpa5ph+joEHvbdMzZ67Ql4IH6q8KnQdnp53bOomPnfK0g0crlY9auyBcu9iklmIT5xEN5FXlVyA5OkLwJwTAqCNh1ZCUJyINfxWG1Deiszl5xLf2+hoxDBI8JDCgLVEVEnl/1kF4+YNx4JaD24zNqwkQLCO57byvltymFDrxYtOsobPapXpIssI5j4oG63LU0Ob5+uxC5qh+o3v8Mu8II+YN8nCwhi3hcvpIA0HqzhgUxqiAq0fZhYDmlb5T8bTEXYMRKWplysn693YckX9ZQOAPWGMbgW3ziBwK452zdlS2WEdceguIDU3rEnz2jSXOR6ZuXEtdccr4w7QE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(6486002)(478600001)(4326008)(5660300002)(41300700001)(66556008)(30864003)(8676002)(66476007)(38100700002)(36756003)(316002)(66946007)(8936002)(54906003)(31686004)(110136005)(2906002)(6506007)(6512007)(53546011)(86362001)(186003)(31696002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0t6NEk0TEt0QTV5S1dzVTA3VGVhaUtHSkU1d201ZHl1OUpJenVpSFZuckl4?=
 =?utf-8?B?ODFBMjNMUGZOSVlaNlkwTXlLOGI0OVRucUliaEZmNmN5ajlJVytHd1J1cWYr?=
 =?utf-8?B?TUVtUU4zWUFrNnhDRzlRWG5YcnhMaXQrRi9rR3AxQkJGRlhlWEtzWW9zYWF6?=
 =?utf-8?B?KzNTZEJOYmxZb1NiNTZIMXJkczk0bktLbHhKMFdDU0lWcFMzaE54TVQ5SnI5?=
 =?utf-8?B?OEZjVFZvbExvYlIrSTBTdHhIbUx5dzRDUTlDMnI1RFJWc0l2N2N4MWJ3Tmh2?=
 =?utf-8?B?Y0RGSkV6U0hCVkM1MzgxTGpmeHhuZE5MdjkrL25XaUVxWWcvdng0Q0NhaVlu?=
 =?utf-8?B?QTJEZm1UajlLekFxTFVEK2dNamJscENkWEw1WkZkTWkwcXhBU1V1amVpTmw4?=
 =?utf-8?B?c29paXpOSjJGRDdtVnpYYVVWZDNqUGlhK3NDeGxpV2trUlJxTXJIQXdjaGQw?=
 =?utf-8?B?a3o4UkpzT1Z2QkEwZlBHdXFzZWZBZ2s4NGZyS2dhRzVaKythcnQ3SVVWRUxN?=
 =?utf-8?B?MDFIbUNWaVh0ZXBSWTcyN1YxSHVtTHlScXRoQjZhclV5QVE0cytUUTNvbW9V?=
 =?utf-8?B?Y2QzQnBPenExcDVrNk0rSVJCb3lpRWZpMFU0bmN6dTk1N1h6V05zY1hpNmZl?=
 =?utf-8?B?a3JWaWlPN3ptZkljTEdMMGIwOXlMZGVVU0dGSjd4T1R5cGNrOG5CZi9ZNnhv?=
 =?utf-8?B?OVU3eFZmMWo2ckFQbVZMTUpWWnNZZzJoU3lNNGJXOTAwKzNxTHZPUGp1aWM2?=
 =?utf-8?B?dWZseVV1akEyYm5yM1VyN3dzMWdpLzhwNnl6RzVCcjQ2UHhzVGxVbmFzcmc0?=
 =?utf-8?B?UjdFMU9pN3FUSHU3bnJ6MjF5MFhYcGErZzM3ZDgxbERPbWlNYVBHR25hU3I5?=
 =?utf-8?B?a1I2cUl6YTlmb1FmRmlaQUQrVlZpSWpDSDdqVTUvRjJjYlQybEJVaDJBQW9E?=
 =?utf-8?B?cGJkUUZnRVZHU1A4RGlMRUhDVkVLbVNsYmtqWkZwZ0RNYkVjUGVJNHVvc1h2?=
 =?utf-8?B?dDh1ZVUwMFlaQlRtUW1vS0wrOFdEM3E1NW5Md0tKZEZ3MXlURlVFR0YyYytt?=
 =?utf-8?B?ZUk5ejdtVVZUVnFFU1hiQmFkUXphZDNMaXNRbUZ4bXhSSlJ0dDQzVjZqbFEr?=
 =?utf-8?B?VmdsLzVDZ0xRUURLeXFXME01c1JiOFQvbnZmVEhVMTNnOGhZbktYbllkbVVa?=
 =?utf-8?B?RVZ3bzZoSFpsbTFETm50Qi9pelptdTlsLzJUM2xoZ2NkdUVHc2QyaXBWVmFa?=
 =?utf-8?B?anpBNWt5N0tpcGJ3cUxYUTZhNmMyR0hrZXBlMkZlUkRlRmtuMWxTbm1kbEhK?=
 =?utf-8?B?ZzFBMXhycXFCZTBBenJsUDlSYXNFKzd1R3p1OE9sSmVaZ0NCazVDQmJ6VWdB?=
 =?utf-8?B?a3N0VXp5UTVRNFk1VzdCU29lcXBGb1VjNHlSNUU5NXpHRFJIcURacXAyeGFY?=
 =?utf-8?B?dHhjZWtabXhqVnVBZ2dUT1gvTjMvY3J0WE1KN0tZOUhzeC9jN0FSMllXZ3BY?=
 =?utf-8?B?aDhYMUMxcFhVTSs1TlNsSEpubWtxOWVyaHRpMWhjd2xmbjJoSW1LdTg3R2ND?=
 =?utf-8?B?aktEQWt2dy82Uk1lYTdOTUZOVi9WTjROd0hVMDA0WXRJdzJBZjY5aklKMWVa?=
 =?utf-8?B?b1FBQ21JREJ5QVZyRXB4RDQxQXQ5dmxENFNXbXFJMmd1VnpWZUduM29oZTFT?=
 =?utf-8?B?bzdWMGhMVG9nNHJYZGxBVktNOUpTbE5CREswZUJSWFUrMko1VHZMWGlINU5E?=
 =?utf-8?B?bWVCZVU0SW1mVlJkMVlZS3JObU11NWdjMXlJR3JLd2xKWUsrWk0rcDl3L3JR?=
 =?utf-8?B?NTQ2WU1VSUV0UFFyT00zY0MzREtkd1dUdTJZbjZzTkR4NG45YldZamc3bmEw?=
 =?utf-8?B?aTQza25ZWUNITGNaOHBxdmVoak1jNnZpcnBacVpYcGI2azBEZGhMcjBWUHc5?=
 =?utf-8?B?ZnU3R0xwbVZqN2F1NXkvTjNURndsZm8vRGhxc3F6TUQ4RElnc0UxdkZxSjJZ?=
 =?utf-8?B?TUZuUk9GZlk5ZklFUWZreVVTUEdjdmZwdjhrdGRseFdsR0M0NmNPRjZLVmxF?=
 =?utf-8?B?V0lWZWFWdldUN1ozUUZVdzVWSXE2aVI3U1VhYWplYjdCUEtxZlFjVW1Xa3Bu?=
 =?utf-8?B?WFU4R2Y2VWtINFJMaG9GZ1pvY1Y5b09wVUkveDNBTElpYXJHVFJjUjl2MlE3?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ae1584-3cdf-45d9-870a-08da864ee8e9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 04:04:30.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wQDGBOd4QPTKnxEQZB7T/XDV2j7mWqshld4trxaLrcueIhkYX1v9ng/tqrlY6tk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3467
X-Proofpoint-ORIG-GUID: lbwJfEVtHCEvWnUQD1nIgd9_1kzAsZK9
X-Proofpoint-GUID: lbwJfEVtHCEvWnUQD1nIgd9_1kzAsZK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_02,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/24/22 12:05 PM, Andrii Nakryiko wrote:
> On Thu, Aug 18, 2022 at 1:44 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Wed, Aug 17, 2022 at 09:56:23PM -0700, Yonghong Song wrote:
>>>
>>>
>>> On 8/15/22 3:44 PM, Alexei Starovoitov wrote:
>>>> On Thu, Aug 11, 2022 at 10:24 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>> In C, struct value can be passed as a function argument.
>>>>> For small structs, struct value may be passed in
>>>>> one or more registers. For trampoline based bpf programs,
>>>>> This would cause complication since one-to-one mapping between
>>>>> function argument and arch argument register is not valid
>>>>> any more.
>>>>>
>>>>> To support struct value argument and make bpf programs
>>>>> easy to write, the bpf program function parameter is
>>>>> changed from struct type to a pointer to struct type.
>>>>> The following is a simplified example.
>>>>>
>>>>> In one of later selftests, we have a bpf_testmod function:
>>>>>       struct bpf_testmod_struct_arg_2 {
>>>>>           long a;
>>>>>           long b;
>>>>>       };
>>>>>       noinline int
>>>>>       bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, int c) {
>>>>>           bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
>>>>>           return bpf_testmod_test_struct_arg_result;
>>>>>       }
>>>>>
>>>>> When a bpf program is attached to the bpf_testmod function
>>>>> bpf_testmod_test_struct_arg_2(), the bpf program may look like
>>>>>       SEC("fentry/bpf_testmod_test_struct_arg_2")
>>>>>       int BPF_PROG(test_struct_arg_3, int a, struct bpf_testmod_struct_arg_2 *b, int c)
>>>>>       {
>>>>>           t2_a = a;
>>>>>           t2_b_a = b->a;
>>>>>           t2_b_b = b->b;
>>>>>           t2_c = c;
>>>>>           return 0;
>>>>>       }
>>>>>
>>>>> Basically struct value becomes a pointer to the struct.
>>>>> The trampoline stack will be increased to store the stack values and
>>>>> the pointer to these values will be saved in the stack slot corresponding
>>>>> to that argument. For x86_64, the struct size is limited up to 16 bytes
>>>>> so the struct can fit in one or two registers. The struct size of more
>>>>> than 16 bytes is not supported now as our current use case is
>>>>> for sockptr_t in the argument. We could handle such large struct's
>>>>> in the future if we have concrete use cases.
>>>>>
>>>>> The main changes are in save_regs() and restore_regs(). The following
>>>>> illustrated the trampoline asm codes for save_regs() and restore_regs().
>>>>> save_regs():
>>>>>       /* first argument */
>>>>>       mov    DWORD PTR [rbp-0x18],edi
>>>>>       /* second argument: struct, save actual values and put the pointer to the slot */
>>>>>       lea    rax,[rbp-0x40]
>>>>>       mov    QWORD PTR [rbp-0x10],rax
>>>>>       mov    QWORD PTR [rbp-0x40],rsi
>>>>>       mov    QWORD PTR [rbp-0x38],rdx
>>>>>       /* third argument */
>>>>>       mov    DWORD PTR [rbp-0x8],esi
>>>>> restore_regs():
>>>>>       mov    edi,DWORD PTR [rbp-0x18]
>>>>>       mov    rsi,QWORD PTR [rbp-0x40]
>>>>>       mov    rdx,QWORD PTR [rbp-0x38]
>>>>>       mov    esi,DWORD PTR [rbp-0x8]
>>>>
>>>> Not sure whether it was discussed before, but
>>>> why cannot we adjust the bpf side instead?
>>>> Technically struct passing between bpf progs was never
>>>> officially supported. llvm generates something.
>>>> Probably always passes by reference, but we can adjust
>>>> that behavior without breaking any programs because
>>>> we don't have bpf libraries. Programs are fully contained
>>>> in one or few files. libbpf can do static linking, but
>>>> without any actual libraries the chance of breaking
>>>> backward compat is close to zero.
>>>
>>> Agree. At this point, we don't need to worry about
>>> compatibility between bpf program and bpf program libraries.
>>>
>>>> Can we teach llvm to pass sizeof(struct) <= 16 in
>>>> two bpf registers?
>>>
>>> Yes, we can. I just hacked llvm and was able to
>>> do that.
>>>
>>>> Then we wouldn't need to have a discrepancy between
>>>> kernel function prototype and bpf fentry prog proto.
>>>> Both will have struct by value in the same spot.
>>>> The trampoline generation will be simpler for x86 and
>>>> its runtime faster too.
>>>
>>> I tested x86 and arm64 both supports two registers
>>> for a 16 byte struct.
>>>
>>>> The other architectures that pass small structs by reference
>>>> can do a bit more work in the trampoline: copy up to 16 byte
>>>> and bpf prog side will see it as they were passed in 'registers'.
>>>> wdyt?
>>>
>>> I know systemz and Hexagon will pass by reference for any
>>> struct size >= 8 bytes. Didn't complete check others.
>>>
>>> But since x86 and arm64 supports direct value passing
>>> with two registers, we should be okay. As you mentioned,
>>> we could support systemz/hexagon style of struct passing
>>> by copying the values to the stack.
>>>
>>>
>>> But I have a problem how to define a user friendly
>>> macro like BPF_PROG for user to use.
>>>
>>> Let us say, we have a program like below:
>>> SEC("fentry/bpf_testmod_test_struct_arg_1")
>>> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a, int b,
>>> int c) {
>>> ...
>>> }
>>>
>>> We have BPF_PROG macro definition here:
>>>
>>> #define BPF_PROG(name, args...)     \
>>> name(unsigned long long *ctx);     \
>>> static __always_inline typeof(name(0))     \
>>> ____##name(unsigned long long *ctx, ##args);     \
>>> typeof(name(0)) name(unsigned long long *ctx)     \
>>> {     \
>>>          _Pragma("GCC diagnostic push")      \
>>>          _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
>>>          return ____##name(___bpf_ctx_cast(args));      \
>>>          _Pragma("GCC diagnostic pop")      \
>>> }     \
>>> static __always_inline typeof(name(0))     \
>>> ____##name(unsigned long long *ctx, ##args)
>>>
>>> Some we have static function definition
>>>
>>> int ____test_struct_arg_1(unsigned long long *ctx, struct
>>> bpf_testmod_struct_arg_2 *a, int b, int c);
>>>
>>> But the function call inside the function test_struct_arg_1()
>>> is
>>>    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2]);
>>>
>>> We have two problems here:
>>>    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
>>> does not match the static function declaration.
>>> This is not problem if everything is int/ptr type.
>>> If one of argument is structure type, we will have
>>> type conversion problem. Let us this can be resolved
>>> somehow through some hack.
>>>
>>> More importantly, because some structure may take two
>>> registers,
>>>     ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
>>> may not be correct. In my above example, if the
>>> structure size is 16 bytes,
>>> then the actual call should be
>>>     ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2], ctx[3])
>>> So we need to provide how many extra registers are needed
>>> beyond ##args in the macro. I have not tried how to
>>> resolve this but this extra information in the macro
>>> definite is not user friendly.
>>>
>>> Not sure what is the best way to handle this issue (##args is not precise
>>> and needs addition registers for >8 struct arguments).
>>
>> The kernel is using this trick to cast 8 byte structs to u64:
>> /* cast any integer, pointer, or small struct to u64 */
>> #define UINTTYPE(size) \
>>          __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
>>                     __builtin_choose_expr(size == 2, (u16)2, \
>>                     __builtin_choose_expr(size == 4, (u32)3, \
>>                     __builtin_choose_expr(size == 8, (u64)4, \
>>                                           (void)5)))))
>> #define __CAST_TO_U64(x) ({ \
>>          typeof(x) __src = (x); \
>>          UINTTYPE(sizeof(x)) __dst; \
>>          memcpy(&__dst, &__src, sizeof(__dst)); \
>>          (u64)__dst; })
>>
>> casting 16 byte struct to two u64 can be similar.
>> Ideally we would declare bpf prog as:
>> SEC("fentry/bpf_testmod_test_struct_arg_1")
>> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 a, int b, int c) {
>> note there is no '*'. It's struct by value.
> 
> Agree. So I tried to compile this:
> 
> $ git diff
> diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c
> b/tools/testing/selftests/bpf/progs/test_vmlinux.c
> index e9dfa0313d1b..dccb9ae9801f 100644
> --- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
> +++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
> @@ -15,6 +15,16 @@ bool tp_btf_called = false;
>   bool kprobe_called = false;
>   bool fentry_called = false;
> 
> +typedef struct {
> +       void *x;
> +       int t;
> +} sockptr;
> +
> +static int blah(sockptr x)
> +{
> +       return x.t;
> +}
> +
>   SEC("tp/syscalls/sys_enter_nanosleep")
>   int handle__tp(struct trace_event_raw_sys_enter *args)
>   {
> @@ -30,7 +40,14 @@ int handle__tp(struct trace_event_raw_sys_enter *args)
>                  return 0;
> 
>          tp_called = true;
> -       return 0;
> +
> +       return blah(({ union {
> +               struct { u64 x, y; } z;
> +               sockptr s;
> +               } tmp = {.z = {0, 1}};
> +
> +               tmp.s;
> +       }));
>   }
> 
>   SEC("raw_tp/sys_enter")
> 
> 
> And it compiled. So I think it's possible to do u64 to struct
> conversion using this approach.
> We'd have to define two variations of macro -- one for structs <= 8
> bytes, another for structs > 8 and <= 16 bytes. One will "consume"
> single ctx[] slot, another -- will consume both. And then each variant
> knows which other macro to refer to after itself.
> 
> A bit of macro hackery, but it should work.

Thanks for suggestion. This approach might work. Let me
give a try.

> 
> 
>> The main challenge is how to do the math in the BPF_PROG macros.
>> Currently it's doing:
>> #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
>> #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
>> #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
>> #define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (void *)ctx[3]
>>
>> The ctx[index] is one-to-one with argument position.
>> That 'index' needs to be calculated.
>> Maybe something like UINTTYPE() that applies to previous arguments?
>> #define REG_CNT(arg) \
>>          __builtin_choose_expr(sizeof(arg) == 1,  1, \
>>          __builtin_choose_expr(sizeof(arg) == 2,  1, \
>>          __builtin_choose_expr(sizeof(arg) == 4,  1, \
>>          __builtin_choose_expr(sizeof(arg) == 8,  1, \
>>          __builtin_choose_expr(sizeof(arg) == 16,  2, \
>>                                           (void)0)))))
>>
>> #define ___bpf_reg_cnt0()            0
>> #define ___bpf_reg_cnt1(x)          ___bpf_reg_cnt0() + REG_CNT(x)
>> #define ___bpf_reg_cnt2(x, args...) ___bpf_reg_cnt1(args) + REG_CNT(x)
>> #define ___bpf_reg_cnt(args...)    ___bpf_apply(___bpf_reg_cnt, ___bpf_narg(args))(args)
>>
>> This way the macro will calculate the index inside ctx[] array.
>>
>> and then inside ___bpf_ctx_castN macro use ___bpf_reg_cnt.
>> Instead of:
>> ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
>> it will be
>> ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), \
>>    __builtin_choose_expr(sizeof(x) <= 8, (void *)ctx[___bpf_reg_cnt(args)],
>>                          *(typeof(x) *) &ctx[___bpf_reg_cnt(args)])
>>
>> x - is one of the arguments.
>> args - all args before 'x'. Doing __bpf_reg_cnt on them should calculate the index.
>> *(typeof(x) *)& should type cast to struct of 16 bytes.
>>
>> Rough idea, of course.
>>
>> Another alternative is instead of:
>> #define BPF_PROG(name, args...)
>> name(unsigned long long *ctx);
>> do:
>> #define BPF_PROG(name, args...)
>> struct XX {
>>    macro inserts all 'args' here separated by ; so it becomes a proper struct
>> };
>> name(struct XX *ctx);
>>
>> and then instead of doing ___bpf_ctx_castN for each argument
>> do single cast of all of 'u64 ctx[N]' passed from fentry into 'struct XX *'.
>> The problem with this approach that small args like char, short, int needs to
>> be declared in struct XX with __align__(8).
>>
>> Both approaches may be workable?
