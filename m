Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285B65DAFF
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjADRLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 12:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjADRLV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 12:11:21 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DA26165
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 09:11:20 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304EpV2S014289;
        Wed, 4 Jan 2023 09:10:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=wlxkL/ySm1sCe1N1mrlJnbtDk5d334c7pZZUgSHtt2s=;
 b=GFGhcQ+t0YV1jPQFxoeo5UacwhLCcxApZ247LHJHPDd+Fp5wEhVtw81dIKxdQ3r8cIIx
 ZNVN1n0/IuD83VoqgLObttbKDRsi5mDS0uvY9qyJ8kjVWOAwRhE3kHdHU/3lBQD84CjO
 ACpF4lwFmtO9PwU8QVTb9FFtyaA2Bgt7h01Bm78WcLDMCTLAGv5AKDRVCqyweDiBDIKC
 r4wLkNpNmzhPJcbb4pwcMrmIaks7cEZVEaXZzYecg7guwADjzrXAMJDDIT7Tmz+313Ef
 WkXu07EBwlmTdcAk1xt+7zX4zDfPFOmWDO7ubWeam0jrbGw8HCL7EK0r00Th65vsCyJB LQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mvkt8jaqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 09:10:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0cAWOG8qPpAkQy5rWirEKuyNJSrfM2slgjJVsi85yfmCoQsbKyO+P+i/s/MaCMdumqtAqT55Fx9iDKOmoPCAkd8/ObAvC2Lo7lq5Nwf1BMrRRU6WmzmWUZQ7DfhPzcDq6wvqTLMVRhWAmJDRbH1jf6Jfqx74leowHFtjR9aNVRcawFp4XpPk06b0MZoY/k+jbYOMjWYVOzkzcVCh7kK5T66alNqdMb4iMnFaWfUKKlKvycBBkdNTvK36h9JORALGMPLclJ8oHksRL/89tRPn9SNw7r3XAoRt2jlzB8Or4ryCL48HKZ5M/XA9djuAy0P8UMFfxYaqEwZ306TvtAu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlxkL/ySm1sCe1N1mrlJnbtDk5d334c7pZZUgSHtt2s=;
 b=E/UDHHrU7ayfgqY4EWV4pO5VGr6fLeopOI0sEwm3LUWdTRP18K6QsW4jKkBlNvzcuLtEZ6BdQ9zvBE8mHSdP9Q7OTlguejRKsAKr9U+3OlTjjrqBQ339goOLWncYCzblCaSjyHmkB9zFck4novgdSea5L5QkY/Zzdu9nqkch56O/zLQA/STuYvCx1ItNHJbdH1oWNK1ADFz4vYpB844Q5Isy0g4iQ5UrYxU2KwVdJtgHpszxWKiXC6vhfXSGvVBHmnkR4UqIWBKZdQS3s9cYlPmPI7k3xZy1uB9nDtJlDMNeIpxYKwQpbuC/JwHn7UHCPEPnlj880SrYncLLqZAylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3749.namprd15.prod.outlook.com (2603:10b6:5:2b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 17:10:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 17:10:49 +0000
Message-ID: <41d28894-1fba-b68e-3093-f47b32a84517@meta.com>
Date:   Wed, 4 Jan 2023 09:10:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
Content-Language: en-US
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Hou Tao <houtao1@huawei.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
 <20221219041551.69344-2-xiangxia.m.yue@gmail.com>
 <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
 <CAADnVQLE+M0xEK+L8Tu7fqsjFxNFdEyFvR4q3U1f1N1tomZ2bQ@mail.gmail.com>
 <ac540d41-4ac3-4d70-39e8-722e3fb360cd@meta.com>
 <CAMDZJNV_J-LmxxzX5DMGHQLm6WyYqG2GAMHb=WZvBG_y1rUOYg@mail.gmail.com>
 <323005b1-67f6-9eec-46af-4952e133e1c4@meta.com>
 <dc658ded-719f-17bd-9166-e335a86150a6@huawei.com>
 <ff6473d8-c640-267e-c0f7-a92ce747c888@meta.com>
 <CAMDZJNWs3jSbZwbSe-U4ypMSqhjgJ=Z8AyYcz=wEzX-B4pJg7w@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAMDZJNWs3jSbZwbSe-U4ypMSqhjgJ=Z8AyYcz=wEzX-B4pJg7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3749:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c038cde-d273-45eb-e3a4-08daee76a042
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/7hHI5BrJA5xJRpVW5Cto8+xMRPPbb7yRwD7iyEb5nAt2WmPZDf4MlC7kiV9DZ+gkH82R5ZfN7W0UExmp5eSihd1ftm6AnZViF+/GfPb+kUyztkAxU7sSiwJLHN2eVn+j7t09Tu245vxbF8k2Grlr1byudqjC6DJCggefpu9DlnFD/h65OnoXz/L02yIaRlONWv8J700A2s80el8jTx9GN2wjwOfS169wCOGw+0miGltcrsYTep8IlQqxsEuzo2VwnWeLEWnfJ//pRjTu763AIrVqrlN2T5Vs380IRGLQPbWiwl3uXPh9WFZk08bhVmVaQ5i+5znwjEvG7+kkXbl5BUE4YvD/Qknmi6m3FClPVK2EFxKSExWG0CobNw47vwPNGflmXSXlfx06+RHzDXSJmoglfdWGI9GX+Yj1UP7aQ7ra5xCUMlgGdfjSSgjccBVtXZj1+F4ldVKTrokxkQA+pZXuGutziBdsN4lcDo94mD04wzFbC4qz5HLBnjqfyFIoa6Ewek6UrVmcgFEYDre+LbKhAykOMQlipbbe/Y66MlP4KXQ/D+Vl09ZjjK91NGeTLb2Mx+ANDdiu99GW7csAcJkYpyIQGmgPc3ZvhgWJYChJCzkRLGH6bvoMG9C5Ujtg2fzv0JdrBvUcdQMK3DnOcbAVwm68doOzTZ2HSsnXaZiVFnvUKdFb2i/LUGQQaVTOz9FaV4Zpx2/3kUSbsk5ln0jlNQu5mTTbTV2B5/eDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(186003)(6512007)(53546011)(38100700002)(2616005)(86362001)(83380400001)(31686004)(36756003)(31696002)(7416002)(316002)(8936002)(41300700001)(8676002)(6666004)(4326008)(5660300002)(66556008)(66946007)(66476007)(6486002)(54906003)(6506007)(110136005)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmlkNzRHZEo5NUZOcVpYamxiNk9yTXRSbVhqTERIK3FPY0swS0g2VzN6MmQv?=
 =?utf-8?B?cnNNVm1qYm9RUVR4L1B2TE9FbFhsWHh6K0UySlp4SGFuSXRRUnZEUXA1OGZK?=
 =?utf-8?B?WFlKN0N4YzFJQVo3T251YWRacy9qUXJaYUZHWURON1hwOC9lSGJpays0c1My?=
 =?utf-8?B?aWRZcm1JWnZjSXFtemxVVGJ6Z3VTV3pLQ3BNbXhPM3FZc1FNY1prY0V6TktL?=
 =?utf-8?B?RXN3MmRDNmZOZXRpTlMyQUI5T1R4V25GZGNxY05YV3FWYnhTT2kzT1A4L2ZE?=
 =?utf-8?B?TlczUSs4K0l3Njl1TzY0NktrTktldkxiU1BjTmhBWkI4dFNmOEVEa2hUdy92?=
 =?utf-8?B?ZFR0SDExaTVrQzV2alNjSFl3NzNCWm5aZ3NEU3FCcll6ZHBNaDBldWNBZUpl?=
 =?utf-8?B?dlk3QUV5TGkraWZBcDQ1N1FvQ0p4eHB1VVF2VXhSMkVKaHo2OGZtS3RrcTI5?=
 =?utf-8?B?dFVaTWszMDh4L1pJdWtweWJtVDBwWm9kMXhLaTJiQVVEYlphN3hsZjV6emgx?=
 =?utf-8?B?VEZ2RGtjQzV6bGdFa2t1dmd6dS9QdnhJK0xPREpjSW5GT3V1TUxXbG5GZmxz?=
 =?utf-8?B?OEx5ZEFsNWRoMUhRNFFkYW1JMzd1ZUxLeGNRZU9zcHM5SXZxRFFXQ0ZuMVBI?=
 =?utf-8?B?bW13RjU3Z0FEZXRtdUhpTTdoNTRHRWlmSUc5WU9LOHM3MGRGRXhrQUhSUC9q?=
 =?utf-8?B?dnZOWjNLd2ZFbDFvMUZLVEJMOFRMa2dEYTN5N2hKUm9PY2tHUlJJQ1RNTnMw?=
 =?utf-8?B?SUVXTGNSSXRURUwwM2hjbUhHZTZqcEZ0R1BlVW1pYndMY1NSL0liTlZqUmg4?=
 =?utf-8?B?U21pVngrTUdQVnN1bmIzenBHTXM3YWRvRDZoNmFjZ1JTWE1nVERTNDBBN3h3?=
 =?utf-8?B?Z2NWTlpzUWsxbGVBNUF5WUNLOXJqcURGN2FoV3NJZTVIa1I1bmxyakhLbGx6?=
 =?utf-8?B?aDNsejhpUFo0eFloSlphbGlwMk1Wa2l6OXZvWGVrZm9Nb0N3bEZTcWJZN3Fu?=
 =?utf-8?B?NEdzK1M0UXBQemJaa0NRMzJoSHhxYXFiY05MQ2dpSlVGR2oyaFJ0MmxOR084?=
 =?utf-8?B?M0ducDVHdVFUeTlEWTBGQW00Njh3OE85SFl0SmRORkRVbHJvYWt2TTZsTnhE?=
 =?utf-8?B?US9GTEhHZmFCVE5NYTNTY2xwTThVWVoyVGV0WXpLY3FPZ3ZHMEFEdUszUU0x?=
 =?utf-8?B?cmYyb0pYUWJwalBIMkxQZVE0S3RSRnh2ZjFMQ0YzdG5wbFZ1cUVOU2dMVnlF?=
 =?utf-8?B?c3BNSG1oRnRYUEdtYnF4NHpOMWhqTzYzVHVpQUFZMUhncGlUZGVCK3VucFVl?=
 =?utf-8?B?Szd1cFJudU9OcXRFcnU2cUQ4Lzg5eTV2TjF6RURxcXZ0WmwvR2FJRXluOUxr?=
 =?utf-8?B?K3RjS2lTZ1g1b0YyK2dFcFRGS3o0T240SFVpdk9vZUlSVEdOL05PVm1jYlht?=
 =?utf-8?B?Z1J4NEUxS3lpT1FpLzA1S3dTV2RvclhhQ1pISmRUUFVWd0NiUkVQV0ptdk4v?=
 =?utf-8?B?OU9WcmQwdWlYVUU5NGxwa1RvZXlGaGRRQkRkdTlSSVZMV2hIUThmQlJVNE9h?=
 =?utf-8?B?M3VUQkN4UnRITENHTjloOUNlc1RRQU5sYWg2RElTV3NUdStUUmxENXBFWUk5?=
 =?utf-8?B?K1FzckFkYTY5Ris1YUMyZWtWUjhsZ3Y5Nk9wekZvWlhpVjZjNnFnSXVHQitD?=
 =?utf-8?B?aHExZEhZaUxORWpCWmFBMzhFeVZuZFd4L2RKcktVb3VoZm04djZsTXk2TXJU?=
 =?utf-8?B?ZGhxN29VNUcwU1hTRDhqWXFCU0NLVGZzSUd2TXJOWEt4VlFJWkxxeUJjaWth?=
 =?utf-8?B?OFRYZ2gvVkpRSjE1TTJXS2FxNTFHVENTUEZJOTY1bEV5MTNqQUU2UTI1SVd5?=
 =?utf-8?B?QTk4ZXRrdmhsYkpqWEcxc21oZ3hOalV3TUVXRGI4dUNVSVlrVnQzZjZEY1N0?=
 =?utf-8?B?TFA4NmFZb1F5RTJuei9sYjB1bExKMHR3S1pnV0lhS2J0d21wWTFRQWJGZUVX?=
 =?utf-8?B?M3lsbVg5OGQzRzBRYUNydVJYSzhra0tsOGlKUVNDU2RBQTUzbzMyQThrdUl6?=
 =?utf-8?B?S1NVbTVZZTZUVkxlTm5rM1lndDZaTE8zR3d0Vm4rLzFlU3BlSnJvU2M2NjJK?=
 =?utf-8?B?S05OTHM1ejFqbkNFUXlvSm0ybWVTOUxkYnpsZDhlMjZacXNVSmxJMk1JcERJ?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c038cde-d273-45eb-e3a4-08daee76a042
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 17:10:49.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHu58zDPUeEdi9JuKgfWBCsmTGo/sAONz/oiWpYzdo1P8jFgaNs1edSDPCZSZZ2H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3749
X-Proofpoint-ORIG-GUID: ZOqdx7YSz4K1JXv6_wvv6P3C9z9l9a0u
X-Proofpoint-GUID: ZOqdx7YSz4K1JXv6_wvv6P3C9z9l9a0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/4/23 6:32 AM, Tonghao Zhang wrote:
> On Wed, Jan 4, 2023 at 4:01 PM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 1/3/23 11:51 PM, Hou Tao wrote:
>>> Hi,
>>>
>>> On 1/4/2023 3:09 PM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 1/2/23 6:40 PM, Tonghao Zhang wrote:
>>>>>     a
>>>>>
>>>>> On Thu, Dec 29, 2022 at 2:29 PM Yonghong Song <yhs@meta.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 12/28/22 2:24 PM, Alexei Starovoitov wrote:
>>>>>>> On Tue, Dec 27, 2022 at 8:43 PM Yonghong Song <yhs@meta.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/18/22 8:15 PM, xiangxia.m.yue@gmail.com wrote:
>>>>>>>>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>>>>>>>>
>>>>>>>>> This testing show how to reproduce deadlock in special case.
>>>>>>>>> We update htab map in Task and NMI context. Task can be interrupted by
>>>>>>>>> NMI, if the same map bucket was locked, there will be a deadlock.
>>>>>>>>>
>>>>>>>>> * map max_entries is 2.
>>>>>>>>> * NMI using key 4 and Task context using key 20.
>>>>>>>>> * so same bucket index but map_locked index is different.
>>>>>>>>>
>>>>>>>>> The selftest use perf to produce the NMI and fentry nmi_handle.
>>>>>>>>> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
>>>>>>>>> map syscall increase this counter in bpf_disable_instrumentation.
>>>>>>>>> Then fentry nmi_handle and update hash map will reproduce the issue.
>>> SNIP
>>>>>>>>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>>>>> b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..d394f95e97c3
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>>>>> @@ -0,0 +1,32 @@
>>>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>>>>>>>> +#include <linux/bpf.h>
>>>>>>>>> +#include <bpf/bpf_helpers.h>
>>>>>>>>> +#include <bpf/bpf_tracing.h>
>>>>>>>>> +
>>>>>>>>> +char _license[] SEC("license") = "GPL";
>>>>>>>>> +
>>>>>>>>> +struct {
>>>>>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>>>>>>>> +     __uint(max_entries, 2);
>>>>>>>>> +     __uint(map_flags, BPF_F_ZERO_SEED);
>>>>>>>>> +     __type(key, unsigned int);
>>>>>>>>> +     __type(value, unsigned int);
>>>>>>>>> +} htab SEC(".maps");
>>>>>>>>> +
>>>>>>>>> +/* nmi_handle on x86 platform. If changing keyword
>>>>>>>>> + * "static" to "inline", this prog load failed. */
>>>>>>>>> +SEC("fentry/nmi_handle")
>>>>>>>>
>>>>>>>> The above comment is not what I mean. In arch/x86/kernel/nmi.c,
>>>>>>>> we have
>>>>>>>>        static int nmi_handle(unsigned int type, struct pt_regs *regs)
>>>>>>>>        {
>>>>>>>>             ...
>>>>>>>>        }
>>>>>>>>        ...
>>>>>>>>        static noinstr void default_do_nmi(struct pt_regs *regs)
>>>>>>>>        {
>>>>>>>>             ...
>>>>>>>>             handled = nmi_handle(NMI_LOCAL, regs);
>>>>>>>>             ...
>>>>>>>>        }
>>>>>>>>
>>>>>>>> Since nmi_handle is a static function, it is possible that
>>>>>>>> the function might be inlined in default_do_nmi by the
>>>>>>>> compiler. If this happens, fentry/nmi_handle will not
>>>>>>>> be triggered and the test will pass.
>>>>>>>>
>>>>>>>> So I suggest to change the comment to
>>>>>>>>        nmi_handle() is a static function and might be
>>>>>>>>        inlined into its caller. If this happens, the
>>>>>>>>        test can still pass without previous kernel fix.
>>>>>>>
>>>>>>> It's worse than this.
>>>>>>> fentry is buggy.
>>>>>>> We shouldn't allow attaching fentry to:
>>>>>>> NOKPROBE_SYMBOL(nmi_handle);
>>>>>>
>>>>>> Okay, I see. Looks we should prevent fentry from
>>>>>> attaching any NOKPROBE_SYMBOL functions.
>>>>>>
>>>>>> BTW, I think fentry/nmi_handle can be replaced with
>>>>>> tracepoint nmi/nmi_handler. it is more reliable
>>>>> The tracepoint will not reproduce the deadlock(we have discussed v2).
>>>>> If it's not easy to complete a test for this case, should we drop this
>>>>> testcase patch? or fentry the nmi_handle and update the comments.
>>>>
>>>> could we use a softirq perf event (timer), e.g.,
>>>>
>>>>           struct perf_event_attr attr = {
>>>>                   .sample_period = 1,
>>>>                   .type = PERF_TYPE_SOFTWARE,
>>>>                   .config = PERF_COUNT_SW_CPU_CLOCK,
>>>>           };
>>>>
>>>> then you can attach function hrtimer_run_softirq (not tested) or
>>>> similar functions?
>>> The context will be a hard-irq context, right ? Because htab_lock_bucket() has
>>> already disabled hard-irq on current CPU, so the dead-lock will be impossible.
>>
>> Okay, I see. soft-irq doesn't work. The only thing it works is nmi since
>> it is non-masking.
>>
>>>>
>>>> I suspect most (if not all) functions in nmi path cannot
>>>> be kprobe'd.
>>> It seems that perf_event_nmi_handler() is also nokprobe function. However I
>>> think we could try its callees (e.g., x86_pmu_handle_irq or perf_event_overflow).
>>
>> If we can find a function in nmi handling path which is not marked as
>> nonkprobe, sure, we can use that function for fentry.
> I think perf_event_overflow is ok.
> [   93.233093]  dump_stack_lvl+0x57/0x81
> [   93.233098]  lock_acquire+0x1f4/0x29a
> [   93.233103]  ? htab_lock_bucket+0x61/0x6c
> [   93.233108]  _raw_spin_lock_irqsave+0x43/0x7f
> [   93.233111]  ? htab_lock_bucket+0x61/0x6c
> [   93.233114]  htab_lock_bucket+0x61/0x6c
> [   93.233118]  htab_map_update_elem+0x11e/0x220
> [   93.233124]  bpf_prog_df326439468c24a9_bpf_prog1+0x41/0x45
> [   93.233137]  bpf_trampoline_6442478975_0+0x48/0x1000
> [   93.233144]  perf_event_overflow+0x5/0x15
> [   93.233149]  handle_pmi_common+0x1ad/0x1f0
> [   93.233166]  intel_pmu_handle_irq+0x136/0x18a
> [   93.233170]  perf_event_nmi_handler+0x28/0x47
> [   93.233176]  nmi_handle+0xb8/0x254
> [   93.233182]  default_do_nmi+0x3d/0xf6
> [   93.233187]  exc_nmi+0xa1/0x109
> [   93.233191]  end_repeat_nmi+0x16/0x67

sounds good. I agree fentry/perf_event_overflow can be used for the test.

>>>>
>>>>>> and won't be impacted by potential NOKPROBE_SYMBOL
>>>>>> issues.
>>>>>
>>>>>
>>>>>
>>>> .
>>>
> 
> 
> 
