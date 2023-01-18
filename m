Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6E1672683
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjARSQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 13:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjARSQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 13:16:23 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD0474E9;
        Wed, 18 Jan 2023 10:16:18 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IGXFBl022557;
        Wed, 18 Jan 2023 10:15:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=FcIk0XrewpFKYvHRSYyy8mclvFGATHuKr3MjyXpBcuA=;
 b=S/LRJFnDWUQo7PuwXi9n1Yt8t9KJYtnGnqDTFyWH74Snyqax0uU+Vzwk5g3VUCka6mBZ
 MGxd/1APG45bKfSBIdOteIBozgQ0ITpXtYMg2C4cYFXUM8MrGDvOQuulMZL1ISHlerEW
 5diS8uf1WI8xhgLv7WdYOzEYiAptjz8QAZIoinh0qFfP47GcbwXKC2qCn1f8Un4e8PX0
 QkU5oCjxe1PAeLeBauvXOrX2CFRAavIaOtZrXRjHEpqO9sfci3bxljiGHzaJtYyrIYMs
 2AWd4S3bvqfQwqAH9eE1iCKJXMlyfT6OdWTJ7wZAA0uPr46UvHu4y/kOPxCfr4HrvPZq zw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5uferu3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 10:15:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzN4ZRW5OtUARZIMHwLwsnFTEAf0isY+ygCbVJ07AfHYRjX0l7Gl4CkhR+utjxkuGoc6vPj2EAJvLGjhoPJyHKg4AibijV/wcXZky6t8V6jL3/XMaJwAMrTmB+SpF8CAx1CbzYHyOYE4fFwUGjarc406uJ2Gpa91eYR/MTWaJE6yAoh0K1zpS1rc4VF1ikCuu/INXrgHVq3fgCs/y3qZyGOlpUehroy/4fddcE8vj9dXKGGatExZiUndAkfQEY3T/N6HJDddTW6hddzO5fdmG4qtCLIfbfY+KTEvSxGdqbNPY0s8kGZ0bIw9yTmHnlNkgAokCIKdE2pHt5cnPEoT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcIk0XrewpFKYvHRSYyy8mclvFGATHuKr3MjyXpBcuA=;
 b=m2l1fWDyls71zwp+T2ibjXi+D0skWCRIeY8xKZJYPD7r0pVu7cQxnVMgrod1npo3uWilGJIEZlbS4vlClrzalx+PKxbW2oSt+eXmOrvuBGBlTyFU3b2B5hZ+pw1UlluP2bZUAVhA6p5bO2X9zYotzvowf+mztOEcSPiqgJ0nuVbA0TIvsoc7x4ozN1W3X7RF138sHdNwkcGV7XcIFOqjCyTxoSf2X2Uu+YVZEZQw0mLCl3Gc/Z3QEyW9/OjQ0aZDV/b9LfCYCy+VpG19av2SI3kCvWhCNTXW4fBh7KVwN/5YCUdlJxVq0I/a/WxAjUtSbXkwmDP1BagBpTHSrIJMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB5310.namprd15.prod.outlook.com (2603:10b6:303:168::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 18 Jan
 2023 18:15:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 18:15:29 +0000
Message-ID: <eaf64a4b-85ab-bb5a-5c33-d7cd80b034e7@meta.com>
Date:   Wed, 18 Jan 2023 10:15:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] libbpf: resolve kernel function name optimization for
 kprobe
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
 <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com>
 <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
 <CAADnVQJRntdqa4uCHtTrQNAsgGS13DtNV-ue2wTdHQxiuLo_Yg@mail.gmail.com>
 <03e16727-7a0a-0e1e-e9b9-c947a64becb9@meta.com>
In-Reply-To: <03e16727-7a0a-0e1e-e9b9-c947a64becb9@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:a03:331::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3eedd9-578f-44d4-c310-08daf97ffad1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scHKdycIy3CodMbm/u201+z3dvc6u2/+TgZ2YkfFTIKikggrQXE6Otgzw4E2atL0+MpL4blmJ49YFowYUwarXm7+Sav1pglpS7RB4aMPnvLoOZHRBqLhL75XhWnOu/MBDepTGEqGFvf+dS0aBtLfls40RWuce8h6yRZ3d7xk5bTpQ1FuEw1AO59b3a1V3isc9z/IdzPPYSvQ6FF43zrWVH17M5O4HUP/OREIP4uzCHCal+ShZN1b2k+FbAcTiPoP98t4mvDp1kBD+H43ijd9CPdL0YOiZEi4/XsSuLWX6lGFbgae1EIC6KWdSmSslP1F2pg/0asA0/TR/ZbVUR4JkFED5uVcv9YZcMNbb/2YeDmyA+qdbzACIgIFC1ewxM+Avf1Ys8FDvsUVEd0x4HBSbwm5vaaDgKLdFu0m/ah6X6R6cwHRhIAzu4VpyhOsFfGJu8cWnZ/flpOkE5JNJ6/Ixt73K168rn2HMbLmtOL/XnN8AqmTOVYEVJHMpQjqH/GQLVvoaahNULlJGNshYQM0DYifX3cChyNQ7W0/6t2ODJusIp5NcUrsvt/wbzZEzWA5mu8Iq+osh9ybO/BNI7JK8m56EZH8VTDk0l618DD6tG4+3ovM6D+a8hNXtLcpGpzQiafthjC8G1PtN3dSnFcI7BNfRfMPQWf8tKouNnbLRKKaxzFdhaI7rqNkppf2bx8pOcNe/bmPSb0Gd/NHmZTnAa43twt4nKFSdd1ca2Yadqc/ikSwY5CC9MxRAsKGtPSP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199015)(31686004)(66899015)(4326008)(36756003)(2616005)(41300700001)(186003)(6512007)(66946007)(66556008)(8676002)(53546011)(86362001)(66476007)(31696002)(5660300002)(7416002)(83380400001)(8936002)(6666004)(6506007)(478600001)(316002)(6486002)(110136005)(2906002)(54906003)(38100700002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZUUlh0Y2VFcjVWRzEzc2t1aWkyMVRkaCswVWs2ckpwdElWYloxNWozRmFu?=
 =?utf-8?B?SHZRcXZIUys5a3AxcU9lcnpRUWVHaXFTVytqSUo0NUxCU3U1dnJMQmU3T2Jk?=
 =?utf-8?B?N3JXUjJEbS9iVE93ZFZDQ0Nnb21tSEdsVFNic0FUZ0pON1dFbzFKMG0zQytI?=
 =?utf-8?B?ZUowV05INWdtYW5PVVNEOVphbS9nRFhoeEEzRlhaY29RWnpQaWZjUEhwR2gz?=
 =?utf-8?B?bGpXMkFTbjdwV0ltRlozRGtnTWhuY2pVQmMyczdSSGUvZ1hCQWMrZ1M2L1cv?=
 =?utf-8?B?WUZqWjVpMFhuVFBFblUyQlhsT3kvc3FuaStxeFhFU2xXZVpHdktZZWtSWUpa?=
 =?utf-8?B?RHQ4cW9adHJZMXpvZHpKWjZUeXVLUDF1dmozQlZURWtVUUhQRmI2cUh2cDZ5?=
 =?utf-8?B?ZmxhQk5YUVpyNWpZWk44Wi9GS081OU41RDhHRUJ5OWMzd2tEOU5FN0RFaFgr?=
 =?utf-8?B?SGV3MXgvdWV2RC9Gcitqa3VtQnJyTEMrMkRBdUU4WGIxNVZhNHMxV2orMEk1?=
 =?utf-8?B?RHNzYVd5dmk2ZEpDd2xyeSt1bmN1a0JjL2UvTlhWT2QzbS9BQkZDU2hUb3dI?=
 =?utf-8?B?QTJ3QmxmNTN6WXpaV3o2eHN2aHRDMGJveG9aMlNtdWQ2SlJGZTlKTGVSQVA2?=
 =?utf-8?B?K3N5RlNnSFh6NkRxdEJXSTZrVjFxY3ZnNENSV3NnNEpoV0xsS2wrOXQ0YkF5?=
 =?utf-8?B?alNock5lNk9kM05WcGdjWWpKUnI4aFhxOTVyZ1ZUcDNRVmVTbGNyazJiUWNK?=
 =?utf-8?B?NXg5TU1PWkV1cWU5SWo2bkFWQlBSdTh5akk4bVNDTmFmaDlmLzFPTy9NV3J6?=
 =?utf-8?B?anZIZkJVTktvMnNZdmcwNTJkYVBNRkJkdkJtZ0ViVlZMVXY1SFc2QkV1VGxt?=
 =?utf-8?B?eW5VMEN4Y2pYcUdISmQrSDZwSEJqOGV6dGdWMzZBV256Wmh4bThDbGFQZUVT?=
 =?utf-8?B?bUhJc3NMYk93OE5RYUNSQWlKT1VDYWxFR2Myb091b2wvQjFnb2l0Q05wQjVi?=
 =?utf-8?B?bUJVQ05YL0xMN0NVVXNzZWxTbm1UVm9nSXhQUklzSGQwTk8vaXo0ZVZJRXZo?=
 =?utf-8?B?R2VSdFBldG5RZm5TQlhjV1YvM0RqRTRQZ2tOdWY1b3JoV0l2OXd4MWg5SlZS?=
 =?utf-8?B?eUo3akdNR2NBOVMzYW96ZE9RY2FIb1M2ZGlTTGNERllOK2tGQ0thK1c2S2Q4?=
 =?utf-8?B?VzhyMDRZcTIvRE4ya08vWmtLNHVHdzBUKzhSa2h0TE1aTW1TYkp4K0I3eGRj?=
 =?utf-8?B?b2lTM0xaZ3lMZG1uZFZYWVRnREZHQ3pTZ3lHbU44d1NyR0ZwS1FDa09EVmZa?=
 =?utf-8?B?RE03WVQzK0NCNkRGekRUbW1RSFVNTlpwY25YVjJ2a2cyeGQvU0tpR3hwQ0xa?=
 =?utf-8?B?dFp2YWY4aURDRWwyUUlrQU9ZbGhHMXNHZ01GSlJENlI0M2JxTWtCRWY4TW1G?=
 =?utf-8?B?di80TXBYWVNuT2tER1NaVVRvM3BVOE80TFY3c1FqODk1VmxMenFhdnlDSWtU?=
 =?utf-8?B?Sk9lKzdIa0RaZUdwNmJEcGZMN2dVTms3dmRxeXhxb1J6bkxsbVBQS0lYTG5j?=
 =?utf-8?B?eCt2ajFVSEcwclFTVStZdFFUUEhyVmRySm9GY0lRdUpmcDNWd0tMd2x4VGd6?=
 =?utf-8?B?alAzd2hDRWxBeURpVDg5TXRocUVHSlV0ejU2ZjJpQVlhZXJZcVVQajg3bTVV?=
 =?utf-8?B?UUc0YWJsM2UzendDRWxSQWZvZWNiNVBzSUxYbmM3Nks3eWlOOCt3SFBSNTha?=
 =?utf-8?B?MFZEY1Q5cEtabjBhSENYMDlxK0V4eXlQOUNwMTZZTW9YYk5YYkZCcUdGSnpY?=
 =?utf-8?B?Vk91VXJFNnZnSE8rZ0tsY0VBdEt2MENSWjF1RWV4ck14RWFqaEF2cFdDY3RB?=
 =?utf-8?B?MkxBNDhtd0pBeXZiekRXVDVaOUhObUtlYUpLZ004MVdGSmJUTVdoZ3d0d0Jq?=
 =?utf-8?B?eTlxbjh5N25TWDRieVd3VGcyRXh3UDFvSzhPNmJWZEFhZkVkV2tNaGdwZUZo?=
 =?utf-8?B?ZnBtYWJhUS80TFJ0NG9USG5RZ0IxdHBsVWFuTnZTTDhOUysvR1YyNklibUFP?=
 =?utf-8?B?MEE1ZDRhclhIbGtjRlRWSkUxVWNOMXVETHBadFc1aXV0MUhkcGFjU2hiOGRj?=
 =?utf-8?B?M2czejZ1eFZWbTNuNDhqMHF4WjZDTDFIbDRUQWE4UnhkOTZuVmdZS2dPNWx6?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3eedd9-578f-44d4-c310-08daf97ffad1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 18:15:29.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK7etFUpu22PhXtYpt5ObMUoMvBv/iI2HHsDB44BJdz3c0iXmQ+E9MdbNCC2kijA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5310
X-Proofpoint-GUID: MTHW8TAXM1_Vb870sXPh8n3KWYVD7uom
X-Proofpoint-ORIG-GUID: MTHW8TAXM1_Vb870sXPh8n3KWYVD7uom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/13/23 12:00 AM, Yonghong Song wrote:
> 
> 
> On 1/12/23 1:07 PM, Alexei Starovoitov wrote:
>> On Thu, Jan 12, 2023 at 2:20 AM Alan Maguire <alan.maguire@oracle.com> 
>> wrote:
>>>
>>> On 12/01/2023 07:23, Yonghong Song wrote:
>>>>
>>>>
>>>> On 1/9/23 7:11 PM, Menglong Dong wrote:
>>>>> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
>>>>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>>>>
>>>>>>> The function name in kernel may be changed by the compiler. For 
>>>>>>> example,
>>>>>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
>>>>>>>
>>>>>>> This kind optimization can happen in any kernel function. 
>>>>>>> Therefor, we
>>>>>>> should conside this case.
>>>>>>>
>>>>>>> If we failed to attach kprobe with a '-ENOENT', then we can 
>>>>>>> lookup the
>>>>>>> kallsyms and check if there is a similar function end with 
>>>>>>> '.xxx', and
>>>>>>> retry.
>>>>>>
>>>>>> This might produce incorrect result, so this approach won't work
>>>>>> for all .isra.0 cases. When a function name is changed from
>>>>>> <func> to <func>.isra.<num>, it is possible that compiler may have
>>>>>> make some changes to the arguments, e.g., removing one argument,
>>>>>> chaning a semantics of argument, etc. if bpf program still
>>>>>> uses the original function signature, the bpf program may
>>>>>> produce unexpected result.
>>>>>
>>>>> Oops, I wasn't aware of this part. Can we make this function disabled
>>>>> by default and offer an option to users to enable it? Such as:
>>>>>
>>>>>       bpf_object_adapt_sym(struct bpf_object *obj)
>>>>>
>>>>> In my case, kernel function rename is common, and I have to
>>>>> check all functions and do such adaptation before attaching
>>>>> my kprobe programs, which makes me can't use auto-attach.
>>>>>
>>>>> What's more, I haven't seen the arguments change so far, and
>>>>> maybe it's not a common case?
>>>>
>>>> I don't have statistics, but it happens. In general, if you
>>>> want to attach to a function like <foo>, but it has a variant
>>>> <foo>.isra.<num>, you probably should check assembly code
>>>> to ensure the parameter semantics not changed, and then
>>>> you can attach to kprobe function <foo>.isra.<num>, which
>>>> I assume current libbpf infrastructure should support it.
>>>> After you investigate all these <foo>.isra.<num> functions
>>>> and confirm their argument semantics won't change, you
>>>> could use kprobe multi to do attachment.
>>>>
>>>
>>> I crunched some numbers on this, and discovered out of ~1600
>>> .isra/.constprop functions, 76 had a missing argument. The patch series
>>> at [1] is a rough attempt to get pahole to spot these, and add
>>> BTF entries for each, where the BTF representation reflects
>>> reality by skipping optimized-out arguments. So for a function
>>> like
>>>
>>> static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
>>>                                 const struct in6_addr *gw_addr, u32 
>>> tbid,
>>>                                 int flags, struct fib6_result *res);
>>>
>>> Examining the BTF representation using pahole from [1], we see
>>>
>>> int ip6_nh_lookup_table.isra.0(struct net *net, struct fib6_config 
>>> *cfg, struct in6_addr *gw_addr, u32 tbid, int flags);
>>>
>>> Comparing to the definition, we see the last parameter is missing,
>>> i.e. the "struct fib6_result *" argument is missing. The calling 
>>> pattern -
>>> where the callers have a struct fib6_result on the stack and pass a 
>>> pointer -
>>> is reflected in late DWARF info which shows the argument is not actually
>>> passed as a register, but can be expressed as an offset relative to 
>>> the current
>>> function stack (DW_OP_fbreg).
>>>
>>> This approach howvever introduces the problem that currently the kernel
>>> doesn't  allow a "." in a function name. We can fix that, but any BTF 
>>> encoding
>>> that introduced optimized functions containing a  "." would have to 
>>> be opt-in
>>> via a pahole option, so we do not generate invalid vmlinux BTF for 
>>> kernels
>>> without that change.
>>>
>>> An alternative approach would be to simply encode .isra functions
>>> in BTF without the .isra suffix (i.e. using "function_name" not
>>> "function_name.isra"), only doing the BTF encoding if no arguments were
>>> optimized out - i.e. if the function signature matches expectations.
>>> The 76 functions with optimized-out parameters could simply be skipped.
>>> To me that feels like the simpler approach - it avoids issues
>>> with function name BTF encoding, and with that sort of model a
>>> loose-matching kallsyms approach - like that described here - could 
>>> be used
>>> for kprobes and fentry/fexit. It also fits with the DWARF 
>>> representation -
>>> the .isra suffixes are not present in DWARF representations of the 
>>> function,
>>> only in the symbol table and kallsyms, so perhaps BTF should follow suit
>>> and not add the suffixes. What do you think?
>>
>> Sounds like a great idea to me.
>> Addresses this issue in a clean way.
> 
> Yes, the second approach seems a reasonable approach. If the number
> of parameters for the *actual* functions equals to the number
> of parameters for the defined function (abstract_origin),
> we can roughly assume the actual function signature matches
> the prototype. Although it is theoretically possible that
> compiler might change parameter types, e.g., from a
> struct pointer (struct foo *p) to a int value (p->field1).
> But this should be extremely rare and we need compiler emitting
> additional dwarf data (might through btf_decl_tag) to discover
> such cases.

I checked with some compiler guys at Meta. They confirmed that clang
might have the same optimization (eliminating some function parameters
for static functions), but clang won't change function linkage name.
So that means, clang won't do static function cloning and it will
only remove function parameters if this can be applied to all call sites.

I checked the clang (clang16) build kernel with latest bpf-next
and didn't find a single instance that a static function's parameter
is removed.

Also, current libbpf kprobe API supports to pass a function address
to kernel. So user space can always do their own /proc/kallsyms search
and find func address for either regular function or function
with .isa.<num>/.constprop.<num> suffixes.
