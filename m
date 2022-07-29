Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E73585423
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbiG2RHR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiG2RHQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 13:07:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A9683E6
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 10:07:15 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TBpfrm032556;
        Fri, 29 Jul 2022 10:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DaT/XCGR+d4ulDgDJyXb4zbX53YexfQYczNC8mlvspA=;
 b=U870Aj+z7URoDSc7Vu8gTgLo04Ry3twE3/aGl9ToTmzytwN7YjBNmfJF0hFJd1WW9Wby
 wk5T3iYnAzAi5owGj4IPO1aOTbQxeOBFYmXMYU5jNvONHkiEyu4IpQKEFLzFlrG377AH
 x8BshsRVdxu2+dX3rzmu2Rzise/0zTACKNk= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hks0q26uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 10:06:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJpreKxFa1G0kw+2dvjR6hxapX/kuPAhSdGdOES5aJLf1Llqotmj8NeoZjgvzzGRtZSn0daYeO1bWZIgrEs7w1DOoSfFHjWxpAL193JHyUUVijfN7AO7b9OBsqjgnTURoIh+XLCiKwBb0X5PEYPSBEfh6yZaTQp8lLJ3iNZRdDKPNUU8qvCVir29w2PO74V40pbted8e/5tkZ774uas7FLaFmBxntjFCxU0aJEKE5Lby1QeA3fQNuQPOwvV4bFCvOjFfsqAjZk7Am88Gcp57PRoO23MbU5zu7OmVeCXH/JM96UrHtgrDB9esoh5gONRQua9hMup8hXlFq0yTR+ObvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaT/XCGR+d4ulDgDJyXb4zbX53YexfQYczNC8mlvspA=;
 b=FIe6xvCZBdQnLYAZZnia0U2/KGrwjS3n6VhEnidjSjM6l/BaayEwxF9pej8RgBAHzcl1d2Dihrr+Gv/nOv4CRYEhKwVBUis7XQjtqJ31QRExfKwUnii3QAuy0on8NQB1TlSaHD0Ni8l1m1xuu6wIzG2w+ZK3G7fxdDpokiEzhtwgZrcHWYLcBfivui/SWjkntK4xjL99yCvoBOxf6nctlJuN6rDhvQVYcG1sJUPXluJUXRComfmeS7YQ3KR51DCbMHIIBXCFTopwwLwySsZ5zZQKBM6hFIgPx1CBaNwxVOl+xiVPx/xxwhsoGjZH6wgH7066Um98Pn7AEkaMvY6wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4783.namprd15.prod.outlook.com (2603:10b6:510:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 17:06:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 17:06:42 +0000
Message-ID: <c1aea697-9f6a-7da7-6a01-27d03e5b7207@fb.com>
Date:   Fri, 29 Jul 2022 10:06:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next] bpftool: Mark generated skeleton headers as
 system headers
Content-Language: en-US
To:     Quentin Monnet <quentin@isovalent.com>,
        =?UTF-8?Q?J=c3=b6rn-Thorben_Hinz?= <jthinz@mailbox.tu-berlin.de>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220728165644.660530-1-jthinz@mailbox.tu-berlin.de>
 <7d4af6b4-f4da-f004-48a1-e408d8615ee8@fb.com>
 <31673eca-ec46-35b2-9172-4156d985b621@isovalent.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <31673eca-ec46-35b2-9172-4156d985b621@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be17117f-693b-4d0f-4692-08da7184b58b
X-MS-TrafficTypeDiagnostic: PH0PR15MB4783:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtZu23pa2aWxcE0o3rsrhT6SzbdExxs4OukFtFQGoMIEWF+CjPDVJLbwf/DHI0CrExSYwKiOI4eq2GV7NvWmx1Fnw4fVif1H8cvck6N+GjXRFlY2yQMsICElkqthsCmshtAciGT31JzO3yR+AZQU3eGk2kg8xuVX54L7IoSRUGjYoyr9z3UVoYzScmzu6ZM6be7QGIlBafqcEJVaB2UieZBQD7YgNHBL2Mg5Rtp1FMt935f0ES4Eb5YXOBD+NPR6m5eSFsdC6w1+uXnzeuzCMASg/HyfPMcZ7LKlrqS/Sjiy6RpxzYnkb2PKbL0lzB6CmIOSVAjNQzgQF0+KxgY7JFMG2nyrxPmaCFpN29X01PPrSYdkmGAedIwvUoPOrU0Buq2FD9aIoqBaPmHaNOmdta4D045z/9XV6d34YoqueiIOZ+6dC4dZjFyyQGgnII3GI7ze0rNahtTcbUPcBpayj/93PtgPywZtdoX3zus7Ns/b4NMptZOmc+4X0ogy8wMFmfVd+3LHJZU97dGmq+ga84L57V/xByTKG9Fk/Myp9e50v6S1IyGRiZ/Tf9x9wFQe/4WeT43oTntG7NDe3IKn1uKBUSR0w8Mlu1qGRRZZbeiMbokiaxq/AzYzjo952RmKZpVZa97mB7VIcuZE7ULEeSmnaGlTrKjYJbje6UdQqD4LpTSv0DCMVfwo3/7jhi1jypfj27svFJclC7emJsyJ52td5NofQl3/+WGfeXYE/MKk62xh3SKGgbDULLVXm3OVrbUjuUYcybeIuYqj8UOIwMmu+buNGXe5s2yKJq5KeWd1tU9PDSvBleDOaQZvILDUJZsGHIa/oKs2GOaTYmfEDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(86362001)(31696002)(83380400001)(36756003)(38100700002)(66556008)(66946007)(8676002)(110136005)(316002)(4326008)(54906003)(66476007)(2906002)(5660300002)(6506007)(8936002)(7416002)(6512007)(53546011)(66574015)(2616005)(186003)(478600001)(6486002)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0E4ZkdTV25SQ01YSWlIQWpaVGgzcGNtTUhibndNYVZWeWJTN1pnVXBGOGQ5?=
 =?utf-8?B?T1VpditvN1l5ZHlQanlJbDFvOGFaVkZxamQxeW16SVJXSFpXekY4cURKWGg2?=
 =?utf-8?B?MUl4SjJ0RVdHM3B2bW5NOU1JbVJNL0Nnb1U1SnpUTmNUc3hLZ2hFRVJWYkhT?=
 =?utf-8?B?UDl6Q0NTNnBjUkY0R1lmQWxCY05EWHJ1Sk5MWE5RVC9lOFpQZHlGcFpRL0FB?=
 =?utf-8?B?S3FzNlpSUkRCb29Wa25FMlp1Z1pHTWQ2UG82S1g4Sk5KQVNjRmkzRVR2VTlx?=
 =?utf-8?B?TFZqUjRxRFExYlQwYmx0aEJhaHVxZklBWmFXaTZkMWZKNzlSUDVhUk9pcFNj?=
 =?utf-8?B?c29qeUlac21lYU8wMjc1TCtmYkpNSHZObysvZldPU3FrUHRtTU9BSERhaHVV?=
 =?utf-8?B?L2NlOHd4dTRFK0ttZmliWmpnUUluM2RJblkrRkUzWUhjSUJ0MUh5RnlSVmNU?=
 =?utf-8?B?WE85WVppQ2F1QVErN0ZDWCtFZFJJL2hzSXdkTk1rZmg0Qy9lL1RlSUtKckVE?=
 =?utf-8?B?RS9iVHc3RTZjQXkrOEpTc3l3Mk9EdnhPbkhYd2JqZ1ZZam5mbkFWODg1a0dT?=
 =?utf-8?B?WUdBY2owTHBJZ0twL2RzZ3lTVC9Yb1JhTkM4YjZqb2t0dEM2WjFqQ2pCeTJU?=
 =?utf-8?B?K244WVlGOFBaZjYzVUkycUVMNDNRcmIwOUlxMCtqS0l3SHU5SkJLblJsNE1t?=
 =?utf-8?B?UGFRY0dNRVc5WWdpRVVmVWZuTExuU0cwbWJ4R1IyUmpaYjkySFFnczlhRER0?=
 =?utf-8?B?M0FmeHdZVjQyRjNrOVRTRXd1eFhhQ1BLQjM3ZVRWZG9CVDMwOFlxRnBQaGx4?=
 =?utf-8?B?UUtiVGszYlR0cEs1RVNiOXk3UjVsaTdCbkgwdUlwYW5DcXZFY1pobTYzU0Qr?=
 =?utf-8?B?Vkt0ejlMOFdmM1o2YVNueTJ0RUc1dnVHeldxdlNmc0E1VkE2eFJ2MG1tQTdo?=
 =?utf-8?B?RkFkcWRQMGZUUk40NlVzTk9kQWMzbUpIVjYwU0E4bzlyMHF1S3NkVzdQSFda?=
 =?utf-8?B?YzVJY2tTY1JSTlF1NnhPcDlaSXN2SUlYMk9lTGQxeEQ1Z0VXUGZMYUFoaFRV?=
 =?utf-8?B?bmtoKzdvcXNHMXpFUVdSbC9UOGhPYlF6WkNqNFhMU3Q0eU1KbFpHMENxUkM0?=
 =?utf-8?B?ZTY2LzdhNlF2dDR6OVpTbEJkN0cvT003bmpHdmE0dEoxZmorT1J4THNQaG5X?=
 =?utf-8?B?YURWVXBTRTFNeEsvamRUV0FYaElaMVhWa2N5cTV3dnFBcUdVR2FVTzAvUVNK?=
 =?utf-8?B?WUVTMmlHVVBNZTk5Q1BwY0QzVWx1TXF4ZlFOL2xraVQvRCsyVDZVUUVxckVq?=
 =?utf-8?B?ZEk2aTVoM0NyRTA5OWFMc1d5VWJNdUdWTzMyVzJYMXpySnFRN1ROK3U0M3Vy?=
 =?utf-8?B?elJRVHdVRitTK1Q2aUR1YTU3UVgydVVjMWY4elRmTE9IaGRkc0VOQWY3M25q?=
 =?utf-8?B?U0xwcU9xMmg0bjNnU2hiR1F4OFZKdFJrOVo5akxWZVo3a3JtNWNWZjN5NW9n?=
 =?utf-8?B?NXhjdmU5L0Fsek1VeE85U0o2c3pLOVVJUzZzNDVEcG5WK0ZOM2MzNnBTamNF?=
 =?utf-8?B?UEQ3UVJDMmZuY1pGWTRXTmhkWUQ1NDZESjFrcUNROVdNcFVJb2FwRzFXU08y?=
 =?utf-8?B?NXplNFkrMENiNEpPb0R2bGJ0Y1lZNDVGZVVvYk5wM0xHOHExeTQ5SUowWSt0?=
 =?utf-8?B?UUlJOXlLZVNZTnA5Z0JIVDRQUzVOTTRsTWkzMitySFFPdXNvVFd0K09odVNH?=
 =?utf-8?B?WXF3cjl1d3NHS0duSjlSWHp6T085QzB1ZlV2SFZBVi9ENkhJZXgvN2dIeGh4?=
 =?utf-8?B?UWcxYlQzUG9GMHRya1JlVThIbDEzM1hFRkJiK21ZazhFYTFUNXpFcVh1U2dy?=
 =?utf-8?B?TWNqTEcwaG52NiswaWpOWmxhWXBUdnJTNndubXAxNTlhR1U5VWp0WjA1TWdB?=
 =?utf-8?B?aGZOV1R0SjNSNVZ1a0xHWUN5cVBzNUlDcEZkUGkyUjFqSnlROWg5OHR2QmI1?=
 =?utf-8?B?NVVNRnNLTlBlNWlSS2NSTDcwK29LVTZnSFJNN0h3U0lYRlc2UWsxTkFNVG5v?=
 =?utf-8?B?eFJSSGlQK0prMVNUaXM0RjBzZTQ1LzlKOFRUU2tHWFl0T0hZczVPZDRKQXFz?=
 =?utf-8?B?bVpLdXd0QzdIZjQvNk81T2NpazBwSnp5alkxWkk0NGhMZGU0bXZ2Z1VDSGlZ?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be17117f-693b-4d0f-4692-08da7184b58b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 17:06:42.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ol3EDAc0cJ2cA6sEAUdyxjV1PpU7hYAInrtBdmIbLpscyRnvcZa4jTwbFaP5u5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4783
X-Proofpoint-GUID: T2BqqI9Lq090tJ6qwXAbV0Ov8j_OZgtd
X-Proofpoint-ORIG-GUID: T2BqqI9Lq090tJ6qwXAbV0Ov8j_OZgtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_17,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/22 3:12 AM, Quentin Monnet wrote:
> On 28/07/2022 19:25, Yonghong Song wrote:
>>
>>
>> On 7/28/22 9:56 AM, Jörn-Thorben Hinz wrote:
>>> Hi,
>>>
>>> after compiling a skeleton-using program with -pedantic once and
>>> stumbling across a tiniest incorrectness in skeletons with it[1], I was
>>> debating whether it makes sense to suppress warnings from skeleton
>>> headers.
>>>
>>> Happy about comments about this. This change might be too suppressive
>>> towards warnings and maybe ignoring only -Woverlength-strings directly
>>> in OBJ_NAME__elf_bytes() be a better idea. Or keep all warnings from
>>> skeletons available as-is to have them more visible in and around
>>> bpftool’s development.
>>
>> This is my 2cents. As you mentioned, skeleton file are per program
>> and not in system header file directory. I would like not to mark
>> these header files as system files. Since different program will
>> generate different skeleton headers, suppressing warnings
>> will prevent from catching potential issues in certain cases.
>>
>> Also, since the warning is triggered by extra user flags like -pedantic
>> when building bpftool, user can also add -Wno-overlength-strings
>> in the extra user flags.
> 
> I agree with Yonghong, I don't think it's a good idea to mark the whole
> file as a system header. I would maybe consider the other solution where
> we can disable the warning locally in the skeleton, just around
> OBJ_NAME__elf_bytes() as you suggested. Although I suppose we'd need
> several pragmas if we want to silence it for GCC and clang, for example?
> It looks like your patch was only addressing GCC?

Quentin, "#pragma GCC system_header" also works for clang. Basically
clang implemented system_header pragma identical to gcc counterpart.

> 
> Thanks for the contribution,
> Quentin
