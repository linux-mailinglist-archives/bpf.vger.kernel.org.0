Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3DF6791D3
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 08:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjAXHVg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 02:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAXHVf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 02:21:35 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965732DE68;
        Mon, 23 Jan 2023 23:21:32 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NNax3p015801;
        Mon, 23 Jan 2023 23:18:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=S1IRP8Qknli9xUZlKH+M+Vixz8gqnOl4yfwjfkleHWg=;
 b=dlN6atqPfu6BU6s3C/t6sUga9dQmylgrfarq2iuOiomr+hr7RhCPUvavGgOY9aaa63r0
 4qInpkohJQxxlgWTq2XGHord9+bzygQubtVcOKX6xlZ7pxFqL1Uu0012ggkJOWXgqBG6
 XCLAwpasp8RRWwGSWTDU6ITiguWpUhCpkDQHnJKymR7c+j+91P5nY585VQFsJWS9bBeH
 A4l98FzwUjf4x3Xg95rIwvswhBzlW36Ln+xpswlFTNKE+oHbewRC1B5R5aQpQSgTkJZ+
 zap7nCFF7nir1yzxFNped1DbPGfL4Xrltf653m2y9CBS5aXL5QipwkeLekBFWzBk61tJ Iw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n8g8ac979-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 23:18:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rs8tGjQHxFlqg4nvcl6DrZp/v9PL80OkHzMNqShLghpZwujIFZ9WFfaF+Zsxol0DqVr+LjJs8osG9siefMfrdJr3ODIYexbgNsHrUiT3dyIfEpEMZ7R/3j3o9Jp0AiyQIEI/uJYtumeJHrYiHD0nfVypcC1MZMMEqH5vfGuRSzEHBQ6qTHlHIjK7EXjyXqks3qEjopPrTw8HU3xjQHPR0ynXJjwWb8zQhAfVaJLmmml1b6ky8m3ChTCdd7p5Fe8gYRzVs1ZrmVSaF+F8pqtca2wqf+mhw3w78kJdclqAZIfuM0s1qoXSSs7XwmygM6iM6jJfyDs5KxcOuHJcq7o2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1IRP8Qknli9xUZlKH+M+Vixz8gqnOl4yfwjfkleHWg=;
 b=klFbDN7ar9udaWSNw9CFxxap6KhU9L/DURjP2c5Yp/vcxVKWwLCxezkjA+O3lbaWLW9yby15u3CURJHXoZr9mfZrDd7CPproJWuHOERPf1gZJ7dngofjaCR9gxhftbjxUR8ZxYNP8nA524ThzI3XG45dXlXff/5bQZT6tyWwB/HyoQe4SA9qY9qhiyn5jXAXC5rNjPD0/5fxEHDuqru30up1LLX4XtCAaksrYODmbs+2Ggoq+EQo0O03H7P/0iBvDvip9Z2+7N00lwdXeXgt3s0s6YDMd1l6FDrcqFlE1DiTABU4tEDbNIpYK1a1RkbssWAoIcLyBvUwkZ5aorOVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3902.namprd15.prod.outlook.com (2603:10b6:806:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 07:18:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 07:18:26 +0000
Message-ID: <50c0ac5d-1507-5b9e-6670-8ec654c40559@meta.com>
Date:   Mon, 23 Jan 2023 23:18:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BTF, pahole and static functions (was Re: [PATCH] libbpf: resolve
 kernel function name optimization for kprobe)
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        Menglong Dong <imagedong@tencent.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
 <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com>
 <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
 <CAADnVQJRntdqa4uCHtTrQNAsgGS13DtNV-ue2wTdHQxiuLo_Yg@mail.gmail.com>
 <03e16727-7a0a-0e1e-e9b9-c947a64becb9@meta.com>
 <eaf64a4b-85ab-bb5a-5c33-d7cd80b034e7@meta.com>
 <7bfb49fb-99c1-163a-fb86-3e72369adbf6@oracle.com>
 <ac273c04-3066-dd63-934c-f62650c41f8f@meta.com>
 <22f18176-8771-41a6-4677-7cc805a07350@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <22f18176-8771-41a6-4677-7cc805a07350@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB3902:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc602c6-aa0c-495e-6060-08dafddb2f78
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAiBDlGe2sSuHdXPxSFGGRmSceFB8W8g6deFgF+7DCXcBLE7q3T7ar6qp7MHJwJcpufAK4Dp8wAdNyqww/grZhYTOWukJBA6BQCy2sUi4THtTGnq9+2C3Pf0grjSUcUk2IhIO+mO1dfJ4SUJJDb249E/j6jzgX/NkrQr7FkUQJj5/+HnCskT6OaxdRQUp/VlhhNCMD+GFJIuNTC0C3vrefhpaPde84ICTY+c179wFGM6H6YKeirjsyqhv2vOJmrJ/JWcfSb8mUVrCXqjnhy0oWr8SaXMH/kF/P/4O+4HpSEG8lRjZQuLkvqbYO6rzR/rq0wITub5luFn7b7VNNfkGFM8oz4m5YnVXZDzbO49SDD/Pbud8Z9BiOU21BsEO5K7vKZ1DuRewXgbvWxj8m0lepY0TI8d5r/UALdPjbhyqtMAB67f1g2m8tu+M8NVW6eCIBogKQc0RPsDkA6X57pZyi+NBjSTr6LHSREVZ6JwBm6Rjbmm1exKXx9vA5432cOqexepGD2cRQ/zlAXFzQCZ43+Q2uqQsblbaN9dtG7YgDRLI9QksuKOa47QoyIrWsdN3MbJ8Up6PhErchemx6AFt4K9D/s56a//hK++IduJDgOiFUgsajFjRZH9/EhgR4laRz2NjYsJT7+cFwQ0PbPg9GYwTU0MUL+I6gocB30nsiKqJEmgj9I8V7ofBydq9lwwixBhbfoxkE9LDlqlW+8axA1mJbBNdJbutr81EYVmXSQR5vN9UCQjCj9xNReJB9+lGC1V3XeCHHhYB+jjhHssP3OtX2NloLnrNzL+sCoFf++mMMtvZTDite0DDpgKcazz7NichxMzUs7Wr/p6qgPhFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(83380400001)(38100700002)(7416002)(41300700001)(86362001)(30864003)(2906002)(5660300002)(8936002)(4326008)(8676002)(6512007)(53546011)(6506007)(186003)(316002)(6666004)(66476007)(66556008)(54906003)(2616005)(110136005)(478600001)(966005)(6486002)(66946007)(31686004)(66899015)(31696002)(36756003)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2o2V1BLVWlHbWVJYjkwQk0vN0N5QjJlVUhQSGQzVTRXUE80WEhzdEhQSzgr?=
 =?utf-8?B?NytzZnRyVHpWRklaZk1kWU1Uc1Npb0txaW9UTkFpSG1HakhydUpWYnQrNjNK?=
 =?utf-8?B?TUI1MUkzVFlwU2p4dmRSZ2JKdWVFcHhNdnFpdzZ6TnpxTVZoYVIvNXBJaysr?=
 =?utf-8?B?R3F0TGY2Ukx3WHJBNURsa2Y3SW9qa2g4RDNNQ24vYmZkakM5eHorRnBsT2tr?=
 =?utf-8?B?Y2t6NkdHbjVtaWM3aTBiOGdITThYc0hNRGdOSWtESFE1eEtIcWQwK2h5RFVK?=
 =?utf-8?B?QWRXcUpBVXRFMm5rTE9qNjlrc1ZXelFhVWxvUVlPdHgyU3FkRFowR0cvSENV?=
 =?utf-8?B?ckV6SVJ5dUdpNUsvZjhuZHJoVWZyVHlPTkxNY0VxbWNWU0IxeERvdXdDSTdx?=
 =?utf-8?B?dGNDMXluSVovbFFKVWtFZnl3NS9BQjVTNTNyYlFBWFJFTnNyZkF2Y01Pc0Jl?=
 =?utf-8?B?OXlMTjdFamR6THlMYTh2UFNMNEkwY2VSQ2NzVE01VmFrSDB0YlBCZG9XWjFa?=
 =?utf-8?B?UTNvTHRYb0xXUm11RVIrZCtDTDBORjBhVEhoL1N3a2M3RU5RdVVUOXdxNnk2?=
 =?utf-8?B?Uk9LMnI5UGZHUHVhWHoreEFDNHB3ZUY1b0J5WlhuZTJpaEZpa1JmRVN3cDRE?=
 =?utf-8?B?blJpSmZ1dmpwMmlIU2NYaWp2bVNQM3V4Nnh0SGNXeGFKVFJKR2dXYWVOTkRP?=
 =?utf-8?B?RTh3MWcrRmJjZnBiL1k2a3RKWjBWOVNrcElSMkV4cGtvdEZsR3pvYTIwemN0?=
 =?utf-8?B?UWxSWnJLNHdreWc0UndjMHgrVk4rc0hNSWZncDBiVG9SeHJJL1VnS2VYbXhW?=
 =?utf-8?B?ZjNFN1hNMTI1RTUyOCtoOXZ2Rmd5SFgxdkVHdzR3THc3MUhRU3g5bk9hUGpr?=
 =?utf-8?B?cGQvQy9sL214MzU4bG9leHJJYmJuRThvcHorQlRTbW40bktRS0pDYXhrQ1FP?=
 =?utf-8?B?bS9mbTM5YzE3bGJ5bTF1c2ZjdmxBTFBYNWtlaCtsNUQ4NVhobXYzeWtxdFlv?=
 =?utf-8?B?blVxRjF3Q0M4QzNkNTlMeVh1cXVYQ1A0VGIvM0FjYktuWEFSTThyaXJ1djFG?=
 =?utf-8?B?MmQwSmg2alZSWlFyVGFQMTVjbXN2MEMzTmVxMnUvWDJlVElEdG5sZGlLZnhM?=
 =?utf-8?B?ZHlhNmZncU9tOTNlR0RxTWRwWGVtOFpDaldoRHRkZC9NMXdRMnp2b2Q5TjR6?=
 =?utf-8?B?VlhQV2dyWWVMNmQ0VEpDc0QzeG01ZTl1czRnUDFpTlB0akFsaDR4VFJRcGV5?=
 =?utf-8?B?VU5RTXVKaFMwRVFBbmJoaUlnUzZidW1TeGRZMGJpcVNGdjZxUGllYVVTZk1o?=
 =?utf-8?B?UGVPYVhpOWY2S0dneUJUR1lURFdvRlFBN0hLdEtqWVBKbk1la2FXT3F5QU1C?=
 =?utf-8?B?L1Uxd2htNGVOcU1mS05MbDFYZ0tYL2RmakNxOVlTRGdDcVJPL0JobUFsV2xX?=
 =?utf-8?B?cUVSdTBPZnEwejFhUnQ5OTBCMytlRnVaS3RqZmpsWitVWFlTdFlTZE9JbTZ6?=
 =?utf-8?B?TGMyRFNoZnhqbFRjSTVsaHV2RWx6dHpad2VDeVRYM2VhYXl5dlVISDRvSUx4?=
 =?utf-8?B?M21rYVRRdHpUamxmc3B6VlYyZFk4alBuWVVSM21lNW9PSnpOWks0L2tLZkFB?=
 =?utf-8?B?bS83dFV1RE0rYm8vRUxuc0s2Z0dkRnlHdndzTjdxckFiYWwxVU5idHdNcXp2?=
 =?utf-8?B?STFnRDBaUHkyb1o3d3J2VWVHbUJCMXJDTFQyUFBxOStZTFhrU3MyZ1RIQzNu?=
 =?utf-8?B?QmhSMHB4dndJVGkrbmoxMDh2TXo2SGdFUjV0UTVLYWw3ZlBTMGpYdFpiMmtq?=
 =?utf-8?B?d2p1STFuSGpOdXUzMnY0Z0RFczBZdTdaRWQ5NkFmTTRycTVyNTBPQ1JETm8w?=
 =?utf-8?B?ajY4aForYUJFVytINEdNaXo4MjBiSW5OZ3NiZ0tXM1dRbWRIZEhrTFhJNjla?=
 =?utf-8?B?alR0blNnUDdNUlhHeFowbHE1R0hsWnBqUFpjUkVMTHpmQVJkS1REZ3pyMjh5?=
 =?utf-8?B?WGNsT2xtT1EvdDZPaEVvNUFoTlc1YkxobExIeXRRZDZFcDF1WThMQk9KY2lP?=
 =?utf-8?B?UERHOEVURHdNV0RlZzNWUlpTQlBIT0s3SnJOKzJqSjVlSTYvYSsxZWE3Tjcr?=
 =?utf-8?B?Y0YwOFpEV1pwU3NuOERxdGY0L2pTMU9wTm1jRmNBRFZpVmMzcjhDc1RMNk9w?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc602c6-aa0c-495e-6060-08dafddb2f78
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 07:18:26.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxNh2bx0MY7sUcFHCB7OqWcvyihJ3aOfybjZFxr/6G4yROZdYAOV/7rT7+UPY46l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3902
X-Proofpoint-GUID: 8VYbikvLubY4F9NZkQHISCxdT5Fg3ydA
X-Proofpoint-ORIG-GUID: 8VYbikvLubY4F9NZkQHISCxdT5Fg3ydA
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/23/23 9:14 AM, Alan Maguire wrote:
> On 21/01/2023 05:29, Yonghong Song wrote:
>>
>>
>> On 1/20/23 5:20 AM, Alan Maguire wrote:
>>> On 18/01/2023 18:15, Yonghong Song wrote:
>>>>
>>>>
>>>> On 1/13/23 12:00 AM, Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 1/12/23 1:07 PM, Alexei Starovoitov wrote:
>>>>>> On Thu, Jan 12, 2023 at 2:20 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>
>>>>>>> On 12/01/2023 07:23, Yonghong Song wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/9/23 7:11 PM, Menglong Dong wrote:
>>>>>>>>> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
>>>>>>>>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>>>>>>>>
>>>>>>>>>>> The function name in kernel may be changed by the compiler. For example,
>>>>>>>>>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
>>>>>>>>>>>
>>>>>>>>>>> This kind optimization can happen in any kernel function. Therefor, we
>>>>>>>>>>> should conside this case.
>>>>>>>>>>>
>>>>>>>>>>> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
>>>>>>>>>>> kallsyms and check if there is a similar function end with '.xxx', and
>>>>>>>>>>> retry.
>>>>>>>>>>
>>>>>>>>>> This might produce incorrect result, so this approach won't work
>>>>>>>>>> for all .isra.0 cases. When a function name is changed from
>>>>>>>>>> <func> to <func>.isra.<num>, it is possible that compiler may have
>>>>>>>>>> make some changes to the arguments, e.g., removing one argument,
>>>>>>>>>> chaning a semantics of argument, etc. if bpf program still
>>>>>>>>>> uses the original function signature, the bpf program may
>>>>>>>>>> produce unexpected result.
>>>>>>>>>
>>>>>>>>> Oops, I wasn't aware of this part. Can we make this function disabled
>>>>>>>>> by default and offer an option to users to enable it? Such as:
>>>>>>>>>
>>>>>>>>>         bpf_object_adapt_sym(struct bpf_object *obj)
>>>>>>>>>
>>>>>>>>> In my case, kernel function rename is common, and I have to
>>>>>>>>> check all functions and do such adaptation before attaching
>>>>>>>>> my kprobe programs, which makes me can't use auto-attach.
>>>>>>>>>
>>>>>>>>> What's more, I haven't seen the arguments change so far, and
>>>>>>>>> maybe it's not a common case?
>>>>>>>>
>>>>>>>> I don't have statistics, but it happens. In general, if you
>>>>>>>> want to attach to a function like <foo>, but it has a variant
>>>>>>>> <foo>.isra.<num>, you probably should check assembly code
>>>>>>>> to ensure the parameter semantics not changed, and then
>>>>>>>> you can attach to kprobe function <foo>.isra.<num>, which
>>>>>>>> I assume current libbpf infrastructure should support it.
>>>>>>>> After you investigate all these <foo>.isra.<num> functions
>>>>>>>> and confirm their argument semantics won't change, you
>>>>>>>> could use kprobe multi to do attachment.
>>>>>>>>
>>>>>>>
>>>>>>> I crunched some numbers on this, and discovered out of ~1600
>>>>>>> .isra/.constprop functions, 76 had a missing argument. The patch series
>>>>>>> at [1] is a rough attempt to get pahole to spot these, and add
>>>>>>> BTF entries for each, where the BTF representation reflects
>>>>>>> reality by skipping optimized-out arguments. So for a function
>>>>>>> like
>>>>>>>
>>>>>>> static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
>>>>>>>                                   const struct in6_addr *gw_addr, u32 tbid,
>>>>>>>                                   int flags, struct fib6_result *res);
>>>>>>>
>>>>>>> Examining the BTF representation using pahole from [1], we see
>>>>>>>
>>>>>>> int ip6_nh_lookup_table.isra.0(struct net *net, struct fib6_config *cfg, struct in6_addr *gw_addr, u32 tbid, int flags);
>>>>>>>
>>>>>>> Comparing to the definition, we see the last parameter is missing,
>>>>>>> i.e. the "struct fib6_result *" argument is missing. The calling pattern -
>>>>>>> where the callers have a struct fib6_result on the stack and pass a pointer -
>>>>>>> is reflected in late DWARF info which shows the argument is not actually
>>>>>>> passed as a register, but can be expressed as an offset relative to the current
>>>>>>> function stack (DW_OP_fbreg).
>>>>>>>
>>>>>>> This approach howvever introduces the problem that currently the kernel
>>>>>>> doesn't  allow a "." in a function name. We can fix that, but any BTF encoding
>>>>>>> that introduced optimized functions containing a  "." would have to be opt-in
>>>>>>> via a pahole option, so we do not generate invalid vmlinux BTF for kernels
>>>>>>> without that change.
>>>>>>>
>>>>>>> An alternative approach would be to simply encode .isra functions
>>>>>>> in BTF without the .isra suffix (i.e. using "function_name" not
>>>>>>> "function_name.isra"), only doing the BTF encoding if no arguments were
>>>>>>> optimized out - i.e. if the function signature matches expectations.
>>>>>>> The 76 functions with optimized-out parameters could simply be skipped.
>>>>>>> To me that feels like the simpler approach - it avoids issues
>>>>>>> with function name BTF encoding, and with that sort of model a
>>>>>>> loose-matching kallsyms approach - like that described here - could be used
>>>>>>> for kprobes and fentry/fexit. It also fits with the DWARF representation -
>>>>>>> the .isra suffixes are not present in DWARF representations of the function,
>>>>>>> only in the symbol table and kallsyms, so perhaps BTF should follow suit
>>>>>>> and not add the suffixes. What do you think?
>>>>>>
>>>>>> Sounds like a great idea to me.
>>>>>> Addresses this issue in a clean way.
>>>>>
>>>>> Yes, the second approach seems a reasonable approach. If the number
>>>>> of parameters for the *actual* functions equals to the number
>>>>> of parameters for the defined function (abstract_origin),
>>>>> we can roughly assume the actual function signature matches
>>>>> the prototype. Although it is theoretically possible that
>>>>> compiler might change parameter types, e.g., from a
>>>>> struct pointer (struct foo *p) to a int value (p->field1).
>>>>> But this should be extremely rare and we need compiler emitting
>>>>> additional dwarf data (might through btf_decl_tag) to discover
>>>>> such cases.
>>>>
>>>
>>> Thanks! I've prototyped a solution at [1].
>>>
>>> The key problem is pahole processing compilation units separately;
>>> the issue is that for some functions, they have optimized out
>>> parameters in some compilation units but not others (NF_HOOK()
>>> does this for example).  It's a pain, especially as we want to
>>> preserve parallel BTF encoding as much as possible, so the
>>> best solution I could come up with was to save information on
>>> functions that had a suffix match in a global encoder binary
>>> tree.  Then, when we are collecting threads, they can be safely
>>> added prior to BTF merging, since at that point we have
>>> recorded if they have optimized-out parameters in any compilation
>>> unit.  There may be a better way to handle this, but I think
>>> we are stuck with comparing binary-wide to see if the
>>> parameters are consistent.  The code is (I think) careful
>>> to limit this to cases where "."-suffixed functions are found.
>>
>> I agree that for this .isra.<num> issue and later static functions
>> with different signature issue, global view is needed to make
>> proper decision.
>>
>>>
>>> In testing this however, I think there is a wider issue with
>>> BTF encoding of static functions which may require a similar global
>>> comparison mechanism.  More below...
>>>   
>>>> I checked with some compiler guys at Meta. They confirmed that clang
>>>> might have the same optimization (eliminating some function parameters
>>>> for static functions), but clang won't change function linkage name.
>>>> So that means, clang won't do static function cloning and it will
>>>> only remove function parameters if this can be applied to all call sites.
>>>>
>>>
>>> Great, that simplifies things a lot.
>>>
>>>> I checked the clang (clang16) build kernel with latest bpf-next
>>>> and didn't find a single instance that a static function's parameter
>>>> is removed.
>>>>
>>>
>>> Excellent!
>>>
>>>> Also, current libbpf kprobe API supports to pass a function address
>>>> to kernel. So user space can always do their own /proc/kallsyms search
>>>> and find func address for either regular function or function
>>>> with .isa.<num>/.constprop.<num> suffixes.
>>>
>>> Right; one way I've done this is to have a special "okprobe" section
>>> name where we support matching with a "." suffix as well as with
>>> the exact name. Might be worth adding that support to libbpf itself
>>> if the above approach lands.
>>
>> I am not sure about this. We should keep a good default to handle
>> .isra functions as we discussed earlier. If user still wants
>> to kprobe a .isra function which is filtered out by our default
>> handling, user can use addr instead, in which case, user needs
>> to check dwarf output and/or assembly to make sure they understand
>> how many arguments are actually used and how they are used.
> 
> But if we ensure BTF only encodes consistent representations of
> functions and spots optimized-out parameters, wouldn't the presence
> in BTF of an .isra function provide a guarantee parameters are not
> optimized out? Note I'm not suggesting changing "kprobe/" or "fentry/"
> semantics here, but rather having other dedicated SEC() prefixes to
> support "try for foo, but fall back to foo.isra if attach to foo fails,
> and we can find foo in BTF".

We could. I just feel this is a corner case and user have an alternative
to use address directly. This is just my opinion though.

> 
>>
>>>
>>> The bigger concern I have is in testing this I hit a problem which
>>> at first looked like a parallel BTF encoding problem, but on
>>> deeper analysis looks like a conceptual issue in how we handle
>>> static functions.
>>>
>>> To demonstrate, generate vmlinux BTF twice, once with a single thread
>>> and once with 2 threads.  We observe a different number of functions
>>> that end up in BTF for the exact same object:
>>>
>>> $ LLVM_OBJCOPY=objcopy pahole -J -j1 --btf_gen_floats --lang_exclude=rust .tmp_vmlinux.btf
>>> $ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|wc -l
>>> 57596
>>>
>>> $ LLVM_OBJCOPY=objcopy pahole -J -j2 --btf_gen_floats --lang_exclude=rust .tmp_vmlinux.btf
>>> $ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|wc -l
>>> 57714
>>>
>>> So we see 118 more functions in the latter case. Why would this differ? If we sort
>>> and strip out duplicates, we see that the cause is multiple copies of functions:
>>>
>>> $ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|awk '{print $3}'|sort|uniq|wc -l
>>> 57596
>>>
>>> Once clue is that each encoder maintains a function table of ELF symbols, and
>>> marks a symbol as generated if it has been added to BTF.  As the encoder
>>> traverses CUs, it adds to the encoder symbol table.  In a single-threaded encoding,
>>> we will see only one instance of a function in the final BTF because the first
>>> match of the binary seach of the function list will be returned.  With multiple
>>> BTF encoders however - each with its own internal representation of the symbol
>>> table - there will be multiple instances of functions added to each individual
>>> encoder's BTF fragment.  This is supposed to be okay because BTF deduplication
>>> will handle merging these.
>>>
>>> However, this does not take into account the fact that the same function name
>>> may live in different CUs as a static function with a different function signature.
>>> Could this explain the extra functions?
>>
>> Could be as you explained below. Also, the original behavior for static function with one thread seems wrong. User only find one static function
>> definition in BTF and may assume it is the one user expected. But this may not be the case since other same-name static functions may be
>> simply ignored.
>>
> 
> Right, I should have been clearer on this; the single-threaded case isn't
> right either, it just picks the first instance of a function it finds.
> 
>>>
>>> It seems to account for many of them. To take an example tcp_in_window()
>>> has two representations:
>>>
>>> 122435] FUNC_PROTO '(anon)' ret_type_id=122409 vlen=7
>>>           'ct' type_id=65074
>>>           'dir' type_id=2170
>>>           'index' type_id=6
>>>           'skb' type_id=2012
>>>           'dataoff' type_id=6
>>>           'tcph' type_id=61910
>>>           'hook_state' type_id=29004
>>> [122436] FUNC 'tcp_in_window' type_id=122435 linkage=static
>>>
>>> [66683] FUNC_PROTO '(anon)' ret_type_id=372 vlen=4
>>>           'seq' type_id=23
>>>           'end_seq' type_id=23
>>>           's_win' type_id=23
>>>           'e_win' type_id=23
>>> [66684] FUNC 'tcp_in_window' type_id=66683 linkage=static
>>>
>>> ...one from nf_conntrack_proto_tcp.c, the other from tcp_minisocks.c.
>>>
>>> This raises the conceptual problem - what do we do with such cases?
>>>   From a code perspective, it's totally fine to have conflicting static
>>> functions in different CUs, and one approach would be to retain multiple
>>> conflicting function signatures; however this is not really useful as
>>> there is no mapping from BTF function signature to site.  As a result
>>> we have no way of knowing which signature applies to which function site.
>>> So perhaps the best approach is to eliminate such inconsistent static
>>> function descriptions? The actual amount is small, ~100 functions.
>>
>> Removing these inconsistent static functions could be a simpler
>> approach.
> 
> I took that approach with
> 
> https://github.com/acmel/dwarves/commit/80eaecdb00b3d79becc2133b854593277093b115
> 
> Static functions with inconsistent prototypes are left out of
> BTF encoding. Given that the numbers here are pretty low (around
> 100 or so, not including .isra functions which have inconsistent
> prototypes due to optimizations), that seems to be the simplest
> solution for now.

Yes, I am okay with this approach. This will prevent user mistaking
kprobe a wrong function and this is what we want for now.

> 
>> To really resolve this issue, BTF needs to encode more
>> information, e.g., DW_AT_low_pc, so this function can be related to a particular ksym. We could extend BTF somehow to encode this information.
>> One possible is to utilize the btf_decl_tag. For same-name static
>> functions, we could have
>>      btf_decl_tag("static_func:name:<low_pc_1>") -> foo (first static func in btf)
>>      btf_decl_tag("static_func:name:<low_pc_2>") -> foo (second static func in btf)
>> We only need to do this for static functions which have same names.
>>
>> In verifier, we could build the above relationship and establish
>>     btf_id for first foo -> low_pc_1
>>     btf_id for second foo -> low_pc_2
>> so verifier can then find the correct ksym addr for a particular
>> btf_id for 'foo'.
>>
> 
> It seems workable technically, but I wonder how much benefit it
> provides? The absolute number of static functions with conflicting

As I mentioned in the above, we can do the minimum work in the
beginning to prevent user errors. I agree that it may not be
worthwhile to support those just ~100 static functions with
more BTF types and kernel codes. Users already have alternatives.

> prototypes is small (around 100), and the usability of the above
> would be hard to get right. My suggestion would be that if we
> can ensure that BTF encoding will not encode inconsistent static
> function representations, we could potentially do something like

I assume consistent static function representations means
total match of function signature (return type, func name,
parameter type, parameter name).

> the following on attach:
> 
> - a BPF program specifies "fentry/foo"
> - we find a representation of foo in BTF
> - we notice that there are multiple instances of foo in kallsyms
> - because we know BTF would not have encoded foo if these had
>    inconsistent prototypes, we can safely attach to all those
>    instances

This should work. But if we do find multiple instances of
the same function. I think it would be good if we can spend
some time find out why dedup didn't catch them.

> 
> This seems to provide the least surprise for the user; i.e.
> I attached to a function, and my program fired when it ran. If
> the function has inconsistent representations, it isn't present
> in BTF so we cannot attach safely.
> 
>>>
>>> Assuming that makes sense, the next question is how.  One approach
>>> would be at BTF deduplication time, but we have seen cases in the
>>> past where BTF did not fully deduplicate identical structures, and
>>> in such cases, multiple copies of a function are present which
>>> have multiple (but identical) parameter type descriptions. If this
>>> happens, the danger in eliminating both is we might eliminate
>>> critical kernel functions due to a type deduplication issue. One
>>> way to avoid this would be a comparison of number of parameters
>>> and (failing that) parameter names; such a comparison would not
>>> be subject to issues with identical types leading to identical
>>> function definitions. Not 100% foolproof, but would work in
>>> nearly all cases I suspect.
>>>
>>> Another approach would be to re-use the mechanics introduced to
>>> compare static functions to see if they have optimized-out
>>> parameters to compare function signatures.  So static functions
>>> paradoxically have to be stored in a global tree and compared
>>> to weed out inconsistent duplicates.  Luckily, these comparisons
>>> can be quite superficial; for the most part number of arguments
>>> suffices.
>>
>> If I understand correctly, for same-name static functions,
>> we would like compare # of parameters
>> first. If they are the same, we then compare parameter names.
>> <name>.isra.<num> functions will compare against <name> func
>> to ensure the number of parameters the same. I am not 100%
>> sure what is the difference between the above two approaches.
>> Only implementation difference, right?
>>
> 
> Right, the only question is when we eliminate the inconsistencies
> (prior to BTF dedup or during it).
> 
> We need the mechanics for comparing static functions to handle the .isra
> case, so I went with re-using that scheme to catch inconsistent static
> functions in
> 
> https://github.com/acmel/dwarves/commit/80eaecdb00b3d79becc2133b854593277093b115

I am okay with this mechanism.

> 
> Thanks!
> 
> Alan
> 
>>>
>>> What do you think is the best way forward to solve this problem?
>>> The optimization-handling code gives us a way to deal with this
>>> by postponing addition of such functions until we can guarantee
>>> consistency, and I've roughly prototyped a patch on top of [1]
>>> that works, but I think first we need to figure out what to do
>>> with such inconsistent static functions before determining how we
>>> do it.  What do folks think?
>>>
>>> Alan
>>>
>>> [1] https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:btf-optimized
