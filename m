Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9F6EE86A
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjDYTnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjDYTnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 15:43:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B57EFA
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 12:43:31 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PJJmgh008305;
        Tue, 25 Apr 2023 12:43:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=POx/wWWYLfHZNUwp4psaXD0YJaIxxh66wLlXSAnuDoQ=;
 b=k8k/hkxx4zTXLRcBGkv9LGen8zuHbbY3fxVi0NSWUak2HG8kzNoUfc4D3/TUbIK1hAXY
 czOBRnkRwh/UYayOyc23RQrAcCf7uGQdTGQw0PfyTTGm1XRkfY3tAZnLfw/EZuR8O9rd
 LyeI4WYfRVe7Yr/vOkN273LFM/AXwseBUNJOC4tyAc8Px6hjzOlrlZ97DR6FLmQnNjde
 7TcqrTh/E5839di3Sr4rs+/LNH0ch4DNmCbhHoTwczVT+mBmaDY1XCG0MLM3axCjDAxt
 jGeSTkPhZQCnivF2zKb24OlswhJB/j4eVZodzp581hF3hqH4iBZdaEjEofAgiwM+H4Pq kw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6mws84q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 12:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn1OHchExBILLsA4BbrqfdNHkF+LjSP7WCBy3O83JWDcvsHTTTgJUu4ATcWtmjWh0MVObaBNB7UGQtk+7w3gVPjKnUOQxalZSGy8QOj1DL+wKsG022lFXUocpE1VCu4ipxpfy4r+goEhdgq5gW29afJN6iLNgEHvbMY6KCRNnQlx+lZbY5mSSPioA53Obrd18W5T9nIMtel/rYvA3f7gcAe9KhnYs5DmaryJmTB/aYx/D0+pxoMjJrLxspKbuXeW4D3yGKjZk4ZmqW6rFUYT8UI/EbQ3L8poj4z5d933OfEhlqla3NB3uenmcxRdoat23duA19/BMgvBnsUGMDET8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POx/wWWYLfHZNUwp4psaXD0YJaIxxh66wLlXSAnuDoQ=;
 b=VonfOo4m7n2gneco4JcMbFdSvi3eRlht4XsU77gppJEj9clls21TYHsOiBYB07QsG8Pxbnsee0MvSZVsE6k7WKK1zAHLMzvLVRK1/KiDmnQN1ocnW6zQc3UyeeBkbqQQNPZo/pwyJLbHsifuetRcvEbQUEvQvraPGLXYwMKBSel0EAkExII4QfNqrvMSpQUZna6vFlpnDWg/TDwAUjfR90JhI3E9EFNZTJjeYhn+3PGHywuQmSnmTVtO24jZ7meFRrTu9MI4fK1EtYg51F1JdFf/E3qGuNg1tVRSH2rqOBDtZN2ZsoraiczuRjxzYP5sdk8Dqm1nOfDfLZslTp+HNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4585.namprd15.prod.outlook.com (2603:10b6:303:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 19:43:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 19:43:08 +0000
Message-ID: <d20f40ba-36af-5060-d4e0-c467d59203ef@meta.com>
Date:   Tue, 25 Apr 2023 12:43:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] bpf: Make bpf_helper_defs.h c++ friendly
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Peng Wei <pengweiprc@google.com>
References: <20230425000144.3125269-1-sdf@google.com>
 <fb24192d-b443-4e0b-df99-2a8f972cdf0a@meta.com>
 <CAKH8qBuCMk_Ct5+gwRjc3f_3Rq17D+WOV4LaSLJZpuOHU6a6kg@mail.gmail.com>
 <45aba643-7862-f615-6f6d-ff706e74a1b8@meta.com>
 <CAKH8qBtyTnb=N+hiHMntsRaxBYz=2KQD55gssXQfk2LFwdhLJQ@mail.gmail.com>
 <9488aafe-ce2b-0bf2-8e34-6cbf42328f58@meta.com>
 <CAKH8qBt9eSq9JCRu8BqzUZ_9FLJhpMsgNf56DC6n97uOwg6Tww@mail.gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAKH8qBt9eSq9JCRu8BqzUZ_9FLJhpMsgNf56DC6n97uOwg6Tww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4585:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b164c6-00f2-4460-a749-08db45c54bd3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gGmFceej62HhweYUYNjt5+vgi5b5qllXYE1sJ6Vw6+cpgbIJDAoBZ1edGLo2dPDnUsqQsAcBf+HwTTphF+mu6MkD0k+crtQ/PmRJpj2VjaeeWnYjc/UEG9na4TebM8Td+e7Yio8fnH/DIfLnOalpw6c5m5oBcUOd4KHXuCjjJGYFnlxJDl9Kvh9XVYIA4j36ciNB9wkKGqY/cnZKHNhCCoBoDfm7WeB6DQglwUk8wyuyU+uNievq2wlxVSGnlLGtAicNENqESTUIv/9szpn3tLbVhqLzY78jFHJgLpCvhFOyuF+1dkfbo617HFXJztZEZYvun+q7MzvGw3UqrrOv46GDuJ1b7ngk9CaCO/PrhMj+4rlNOqoWrGIPsyPLCHkY/BGymhQJEX83AHwV1VqDzi5k5FIfQYUh5c9L5tmrDCotr2e3Z3moJ7wFHIvY7amJ/rd3X41OLueuT4v1tVcqBWeBO4sK5UR50GMrBQYHC9AfrMjiUGFE+x7Gq6GG7FO0tMomELQ1kuURO/ert4ZLF8CLN680elc7I7C89Qbj0ZBYtBId4OJC79vk9IwV2WfuHhSp5STOQnUvChVdQLbBAd26hOGRyfnadL5vRDIyLS67QgsSUFzQWa7h81D+tYJ+wy5arIZEICTrZWwsXXw7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(53546011)(186003)(6512007)(6506007)(316002)(66476007)(66556008)(6916009)(4326008)(5660300002)(66946007)(6666004)(6486002)(31686004)(83380400001)(2616005)(31696002)(36756003)(8936002)(8676002)(2906002)(7416002)(86362001)(478600001)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFlRUi90eE5yNnFpYkxMbGM1L215aEdNWXZXRlBvSU9WbHZMUGVJekNqRmhp?=
 =?utf-8?B?dlRCOHo2MDFHcGN1T3FqQU92SHFaOFRMeENOcm5ZUmdwSFZpcGlCY3Y0OC9G?=
 =?utf-8?B?WnNYdDBiVldNRjFvVGVWV2svNnFQT3dSaVlYVnNzVkpJbG9XcHFXWTdtY20w?=
 =?utf-8?B?dHhxNHJ0TTBibHNxZG9TbmFMenM1SFA0cmpsSWZVT3pwTnlkME5sU21Obll3?=
 =?utf-8?B?UWE5blArTUlxbzhuQXQ5MktETmVpMW9sd25jZXFNRkwzWHcvQ1RGU3N4bWE5?=
 =?utf-8?B?N2xKT0R4bUEzY29nT21ZMHB5eFIyS1BmTHNONVlHUnJrL2x3ME1xbWtNNmRl?=
 =?utf-8?B?d0loRGREeDdCQVBFeGM2dXhQeVhUZVk0WVlFRmIybFNPVkZhaE1XeUFXdDh1?=
 =?utf-8?B?M2czcFUrS0JkVi9ERUE0dlo0K1JaQ1ZmV253Wk1SUVZlR2F2bFlqemZTUjVh?=
 =?utf-8?B?TDREdGluOFZybEh1Q01OSm1pU0J4NWg1bUs4WDhWdGVGM3RZQ3o3MlN1V21p?=
 =?utf-8?B?a2NFMVVGRGlEVUt4ZWlmekl0Qnc0elRZVUJ3c2VYZFVWaGEwOCt6eksyMmdr?=
 =?utf-8?B?YWptNXBEcGVRQUdKZ0xWUk9JejFWZFdlakhCV3NBRXdoYTBLWWVETllXRXE5?=
 =?utf-8?B?dTlpeHlCc2VLN3pRSTZoSDR4c216cGZOc3pDZEo3Zm50cjVVNUJVbmRObGtp?=
 =?utf-8?B?bHBJZm92eFlNenNwVWlCN0VxOGJ0TWxZbU5leWVwUVJncGU4ZFAzTU90aWhs?=
 =?utf-8?B?ZzhTTFlZUGN1YXZvclhqbXlQTU0xa1I3OE9GUkdXRUhoSUZCSWNxSDJOYW1J?=
 =?utf-8?B?aDBLeWdKOGZiaVo4WDl6NFFlUTl6RnpSVkVLd3djOVU2b2llcERndXhYVDN5?=
 =?utf-8?B?M0d3YlMzRWZoanVZUTRmYU5Fc2ZsQkdSUTc2K0pzTUdYM1hCOFl2U04vWnBs?=
 =?utf-8?B?cGF3b2tlRlA1aE9uSnJEMlJQMDAwUzVKUW94S3RHbCtGVTJnejZrZVBNUGlL?=
 =?utf-8?B?TlJjVFRqUmhSamd0NjBpWXRoVVBiNUtNanpTT3BvTGtNd2d4dTU0SEV5UUhW?=
 =?utf-8?B?WjFQS09MYnczWHVjTEM5a3V1QUJJMW9RWWZhS2g4MzRhS2dGTTd2aThYN0Nu?=
 =?utf-8?B?ZVdTNUw1aVpRMjlsNzZqMWVFSGYybnkrWGZPajVmZVJsaUlNUmQ2aUJXYWJj?=
 =?utf-8?B?TjdZenlDNHM4bTZ1bkd6VUQ5Q2lGcGdLbDZob0w1cER6TCt2RDRrbHNEeDZo?=
 =?utf-8?B?eUxXOWNVRGJJOFRTZ0dzM1NaakhlWFNhU2hLNHVCWGxaUTdTRzRyY1lZdGkv?=
 =?utf-8?B?QTB6ZFppcUduRG1TL2ZEd1RUVEFDQUI2VmhKZEs1QnUxYWRSTnJBZnF2SnZT?=
 =?utf-8?B?aU1GanlwQ0J1cDB5dDFXb1lCWGNPOGxXQ2wrYXlwaTk2RU1aa0RXeGVOMThR?=
 =?utf-8?B?aHNvOTBSMm9Zc2tFZ3h0MzF4aW95VmdHMkYxZlVld0RLcm1RejZDYzBrc013?=
 =?utf-8?B?NGMyS1hzUlYvTFJHU3NOOTFtWXppSit2YmwvWU9rUVV0NmllbDVWbVQ5WU9B?=
 =?utf-8?B?UytSejlEcldNVU4rT01qYUVEL3psQTl3S3dZVXFvSVl0NzFkTnNRYlBxbGJU?=
 =?utf-8?B?K1IwdHVGRXBOS0dYRE5tR1NzdCs1c0xXc2hHcjgxUmVuUlFCY2NZNGNaNUVi?=
 =?utf-8?B?Z2hhbnc2NEdmMzZSVnZLdHIySjZ6cllvYUh3MzZuS09Oa20xVFBqMjFvWHh3?=
 =?utf-8?B?ZU0rZmZpTlNNVTg1VTE5bERtd0cxYm92MGpZNjk2dU0rOEUwTXRibzQ3OHNW?=
 =?utf-8?B?OGk1SllTSmw5YlF3MjNzQUpjVk5EUmlML1ZNTnBzMTFGKzRCRlpjWGRTNUIw?=
 =?utf-8?B?dnp2N0syOU9ReWxHUGQxUlJvTEd3SjJMSGkxRUd5QWJRQVd4dzg0QktJSCsv?=
 =?utf-8?B?dlNqU2pjRmVSZmx3SFNjTk4wZEN5eTE3YlI2bkZUbktNN0dUNVJNbGlZclJJ?=
 =?utf-8?B?dXJYRStwMDRVNXBZR0ZiSFNnNjlZSjdIWEp0M1pUUFhobUhYcElIYTl0NVdz?=
 =?utf-8?B?QjJBb1VZQjdlMDhqTlZlaG43S1M3ZUNOaHlwSkRvY3BvKzBPSGp5Ym1XMjI3?=
 =?utf-8?B?RnZRbzZFSU0ySGJiVEdZdU1PM3YvQXpPUzMwRk1Ed1ZvMWhSNWZ4MnRYUVRK?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b164c6-00f2-4460-a749-08db45c54bd3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 19:43:08.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du+FSGtfgEAHlvrfKLOTBBe+RFo7oYGgN3pyMyJr8P7//wUrR4DnSejDH2aTi/g/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4585
X-Proofpoint-GUID: y7EjiRsPNR1Yxwc1yL0FDZPX-mlxSVbz
X-Proofpoint-ORIG-GUID: y7EjiRsPNR1Yxwc1yL0FDZPX-mlxSVbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/25/23 11:35 AM, Stanislav Fomichev wrote:
> On Tue, Apr 25, 2023 at 11:29 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 4/25/23 11:22 AM, Stanislav Fomichev wrote:
>>> On Tue, Apr 25, 2023 at 11:10 AM Yonghong Song <yhs@meta.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/25/23 10:04 AM, Stanislav Fomichev wrote:
>>>>> On Mon, Apr 24, 2023 at 6:56 PM Yonghong Song <yhs@meta.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 4/24/23 5:01 PM, Stanislav Fomichev wrote:
>>>>>>> From: Peng Wei <pengweiprc@google.com>
>>>>>>>
>>>>>>> Compiling C++ BPF programs with existing bpf_helper_defs.h is not
>>>>
>>>> Just curious, why you want to compile BPF programs with C++?
>>>> The patch looks good to me. But it would be great to know
>>>> some reasoning since a lot of stuff, e.g., some CORE related
>>>> intrinsics, not available for C++.
>>>
>>> Can you share more? What's not available? Any pointers to the docs maybe?
>>
>> Sorry, it is an attribute, instead of instrinsics.
>>
>> The attribute preserve_access_index/btf_type_tag/btf_decl_tag are all C
>> only.
> 
> Interesting, thanks! I don't think we use btf_type_tag/btf_decl_tag in
> the program we want to try c++, but losing preserve_access_index might
> be unfortunate :-( But we'll see..
> Btw, any reason these are explicitly opted out from c++? Doesn't seem
> like there is anything c-specific in them?

Initial use case is C only. If we say to support C++, we will
need to add attribute processing codes in various other places
(member functions, templates, other c++ constructs, etc.)
to convert these attributes to proper debuginfo. There are no use
cases for this, so we didn't do it in the first place.

> The c++ we are talking about here is mostly "c with classes +
> templates"; no polymorphism / inheritance.
> 
>> In llvm-project/clang/include/clang/Basic/Attr.td:
>>
>> def BPFPreserveAccessIndex : InheritableAttr,
>>                                TargetSpecificAttr<TargetBPF>  {
>>     let Spellings = [Clang<"preserve_access_index">];
>>     let Subjects = SubjectList<[Record], ErrorDiag>;
>>     let Documentation = [BPFPreserveAccessIndexDocs];
>>     let LangOpts = [COnly];
>> }
>>
>> def BTFDeclTag : InheritableAttr {
>>     let Spellings = [Clang<"btf_decl_tag">];
>>     let Args = [StringArgument<"BTFDeclTag">];
>>     let Subjects = SubjectList<[Var, Function, Record, Field, TypedefName],
>>                                ErrorDiag>;
>>     let Documentation = [BTFDeclTagDocs];
>>     let LangOpts = [COnly];
>> }
>>
>> def BTFTypeTag : TypeAttr {
>>     let Spellings = [Clang<"btf_type_tag">];
>>     let Args = [StringArgument<"BTFTypeTag">];
>>     let Documentation = [BTFTypeTagDocs];
>>     let LangOpts = [COnly];
>> }
>>
>>
>>
>>>
>>> People here want to try to use c++ to see if templating helps with v4
>>> vs v6 handling.
>>> We have a bunch of copy-paste around this place and would like to see
>>> whether c++ could make it a bit more readable.
>>>
>>>>>>> possible due to stricter C++ type conversions. C++ complains
>>>>>>> about (void *) type conversions:
>>>>>>>
>>>>>>> bpf_helper_defs.h:57:67: error: invalid conversion from ‘void*’ to ‘void* (*)(void*, const void*)’ [-fpermissive]
>>>>>>>        57 | static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>>>>>>           |                                                                   ^~~~~~~~~~
>>>>>>>           |                                                                   |
>>>>>>>           |                                                                   void*
>>>>>>>
>>>>>>> Extend bpf_doc.py to use proper function type instead of void.
>>>>>>
>>>>>> Could you specify what exactly the compilation command triggering the
>>>>>> above error?
>>>>>
>>>>> The following does it for me:
>>>>> clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h
>>>>
>>>> Thanks. It would be good if you add the above compilation command
>>>> in the commit message.
>>>
>>> Sure, will add.
>>>
>>>>>
>>>>>
>>>>>>>
>>>>>>> Before:
>>>>>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>>>>>>
>>>>>>> After:
>>>>>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *(*)(void *map, const void *key)) 1;
>>>>>>>
>>>>>>> Signed-off-by: Peng Wei <pengweiprc@google.com>
>>>>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>>>>>> ---
>>>>>>>      scripts/bpf_doc.py | 7 ++++++-
>>>>>>>      1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>>>>>>> index eaae2ce78381..fa21137a90e7 100755
>>>>>>> --- a/scripts/bpf_doc.py
>>>>>>> +++ b/scripts/bpf_doc.py
>>>>>>> @@ -827,6 +827,9 @@ COMMANDS
>>>>>>>                      print(' *{}{}'.format(' \t' if line else '', line))
>>>>>>>
>>>>>>>              print(' */')
>>>>>>> +        fptr_type = '%s%s(*)(' % (
>>>>>>> +            self.map_type(proto['ret_type']),
>>>>>>> +            ((' ' + proto['ret_star']) if proto['ret_star'] else ''))
>>>>>>>              print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
>>>>>>>                                            proto['ret_star'], proto['name']), end='')
>>>>>>>              comma = ''
>>>>>>> @@ -845,8 +848,10 @@ COMMANDS
>>>>>>>                      one_arg += '{}'.format(n)
>>>>>>>                  comma = ', '
>>>>>>>                  print(one_arg, end='')
>>>>>>> +            fptr_type += one_arg
>>>>>>>
>>>>>>> -        print(') = (void *) %d;' % helper.enum_val)
>>>>>>> +        fptr_type += ')'
>>>>>>> +        print(') = (%s) %d;' % (fptr_type, helper.enum_val))
>>>>>>>              print('')
>>>>>>>
>>>>>>>      ###############################################################################
