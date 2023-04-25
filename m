Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969A16EE785
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjDYSaQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 14:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYSaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 14:30:15 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4816F32
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 11:30:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PD8rdI002065;
        Tue, 25 Apr 2023 11:29:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=X73rO+geySh4XHKqmQinXrBEtCyBSEppMAm/S7cq2e8=;
 b=YpN0vi6J6B0nFyhP/h6jZZeHsoZ1JGLE1u5ZTdlbNVN5orQw/zQ4ba5+4eT60GJGAR+M
 MOuhX+Zm4+RikUGCVY1jrWJ0o7CeAM7rfazEyYsT2EF7NTY9DcDJYh5r/zdiwMgW2nZc
 /lW5wGMAfQElHd1cm8ThCqBFNfNteUcGaxUhHsOqNeQONNmLferZ9Hpmyh05d4gKYwWz
 XQoNV1iB0IoGYVFYnopALefttJ46XEsEPMrjDfVPoiPV+Z7U2ioLNC3Z7bB/VDKuTbGf
 sg8CFe0hfuBI+uBe7QSi1EIJEAsdJQQvdFim47kVcPn/UZqAyvwhFRQfi+phQQQVlQKs 7g== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q62ekpfm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 11:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPFp8bnMTEXM2zyxojOte0DoqwRqh9G9CSOG13yaaAc1T3s6LyrZKGILIa4OpSmRieGYcJi/lKcE7aYHNazj8rMOzH3sDGm1ruCK3NtldIDwt48LmNfFQ3WJZ8RF1ZZb25V2q+qlFpIn6HzeYTb8whjcSpni1TxCr0hXJzM6bmBAKO/vBw0/9hSPoVFwzCSx2HBnShi/SzIa2ZXFF8CRnwmJv5nHA659zMgh/u84uR5DswhKj3jGD2Mbr/nM/OfBAhCCSByRHn4/tZQ3DGmsnMXUesRYjXo8kv8pwWG65Vin/a5Tibf0Ti2Bsl+baY1RnINgEl5JkFfb12szc/cbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X73rO+geySh4XHKqmQinXrBEtCyBSEppMAm/S7cq2e8=;
 b=VxaGZsesSLBenzZJTHp/vS3kreCtjm/0ebUMc9WprFMdPNOCu2VIAK81mgD7v2oJ8JGrDh9t5cES6Hxem1inUo0K9+AcUMW4pHSQJ2KEYBuKKLShnWIOsH8rgwKXJ6WvWzlIE98hC3tET6SiY1FqFjUxBiEIa/mbtFsYY7gZ4kLPAvbXk8BuARTAt7KPdglk3O++8qjIYco1WCe8g+UrP7cZz2EvZXNOSzwoni9H0RbLFyKaZb/tUnrn8F7vpnzbJ+QPo2/lJJqVdvCGkorOXyV212204c4afE7u7IfQILJJ3/unB6ZnEItZ3T70EQY0yrxTXmqZ8dgniuBX9n2Jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB6298.namprd15.prod.outlook.com (2603:10b6:8:18c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 18:29:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 18:29:53 +0000
Message-ID: <9488aafe-ce2b-0bf2-8e34-6cbf42328f58@meta.com>
Date:   Tue, 25 Apr 2023 11:29:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] bpf: Make bpf_helper_defs.h c++ friendly
Content-Language: en-US
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
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAKH8qBtyTnb=N+hiHMntsRaxBYz=2KQD55gssXQfk2LFwdhLJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a71e359-4174-4452-69af-08db45bb0fc2
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ry03rmItcpF5lyaNbmdthVM2KTD1N/zWD11g67vL0oSN6aRUGNU5997KJNLilbaOwrxjM5PFb62mwqzhpeyxSqfljVY9ZXrnA7TyROF+RUz7hveviLBXjf3IWdBgSixDQYpXP4lXL5oR2XZHm8NWl09gagFMU12+bPaOwBUa/YvbSHhU/TJfda+d5EupEaNlyYIpZeEdrOFrwqP2xWRrHjehpDfn5B3sMTHgxHDqGl9ZQtmFGnJBbBTdzlKyUD0JcvIaBGCEJJbU7gPQvMM1zoLdEj1ooLhr5dMNDYSZPSlbSOWPjjxR4D3gAnp51/qQ6dWaIuIbYvn2r5HsFCM+TGesrJkz37SPLQcWWAHjeIffCY/yCKCwkZwk6IyXn6pkdk8Hng2p1i54FfhRSLYwdeqHGGieukudFlJk4lTOrBGmPKw2XEqh2sWZ/NuUjkLolf36SakJ4i3scKUg3ns70FZgs3PzFlRgwFCgo0Bu2Dvl7WZ2GYDcIMjYtDsfCqWBOmXcHuaokhZ+fflfBd7kAKYY3pvU6Mi3v1uryCKpLi+fVIOGemBKLbkQnv6LA1fB6XtHz6AWqIhsPqkLmuDjsnspeKQL8f4RO4I/hPaUfgBZnH0IHiKsiO7gK5JA0m5DXUvy/FUc+obDFM2kc4TQ8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(31696002)(86362001)(36756003)(31686004)(6486002)(53546011)(2616005)(6666004)(186003)(83380400001)(6512007)(6506007)(2906002)(478600001)(66556008)(66476007)(6916009)(4326008)(66946007)(316002)(41300700001)(7416002)(38100700002)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U01YcWd3OHFTU0haSHFHN3Jpam5PQ3RMcDczOHRYTFZaYnZiQjNKMTZDK20y?=
 =?utf-8?B?SkhJWjJ0YXFKNlV2VUZHUzVRd2pabUtOQXFGSEJMclBNdDFIMnU5TnEyOVg4?=
 =?utf-8?B?SXVIRFhzMHZRai90UGhLR0ZNYlMwSEU0dVM1Z05YTnkzMHFvRDRBeVNmVk5l?=
 =?utf-8?B?RGxCNzhYMGNPUW5wNnlUYWxCTTFzM3VBV2FZamkwV2Z0cm8vZTNkK3JVWXV3?=
 =?utf-8?B?clFMMU1aMmVyTkZyK1h5bGkzM0xPekg3YnBOQjRMTFZjK29DbVRnekVicUZB?=
 =?utf-8?B?NWNOR2hyVTZNVnB5T3hwZzR5c0FBVStlK1FpbFNxNHV4YXQxTUk4Rms2Q1pG?=
 =?utf-8?B?S0k1MUZnVDR0TnZTd1pEM3hrdnBXZjA0bGs4amYxczRmUER2d0FYeWkrOVdv?=
 =?utf-8?B?SEs1VVRkVXErYWNlMndUM3kwaWV1RjFwSWNSaEkxUjAwRDQzZHZoSXBLR1lK?=
 =?utf-8?B?SzVYazdHamtiOE5rN1k0ZWl5MG1xMSt1cnNYc0V5Qm0vQ3NGOEJvMWEzM3VT?=
 =?utf-8?B?YkxiWEpFSE9sZ3dDM1orQmRHaDVEOExaaTVDSk5zaGVQYUNZZEduaVo3V3BT?=
 =?utf-8?B?OTk1ekdsUWZ4Snk0MVFDdy9QUjFISkVRZTZtRU8wbnY1R0NIU2llTXIzR3Nv?=
 =?utf-8?B?NW5yU1R2SFFNUHkrTDN4d3ovOWhvUytjMTFzR2RLUVVjQ1dNM3pHdUgycXNR?=
 =?utf-8?B?aTZXOTlCOW1nMGtQMDNqUkVlMWdXM0tha0NFemJGOU9NVTVQNUZjaUxhcENW?=
 =?utf-8?B?aDVLV2tVTUY4L3o0cmpqdkZVc0h2eFJ0NTRVYzZiRUdDV3kwbVplU2pRNHhK?=
 =?utf-8?B?ZGpKVCtEZmNRaUcycXA4R2JKTFVXMnJlcDc2UGZmYW8xa25UVStaTGpCSWox?=
 =?utf-8?B?bmdPSzF0RFkvelNJNzI4SWk0ZHM3UWxZUHQ5d0tsSld1UjlsNWRtZTBjVk1E?=
 =?utf-8?B?YVZteXNHRUlDN01jRlIwU2p4T0YyeHhHdlpxVkwrZkFYcGFKNStqQnJwQkIv?=
 =?utf-8?B?dFJEbmlKV0dMc3ZBRHB0L3BOTXROQ3pGaml5SHd1QlI5aW1rNVNIR3JaZ3dw?=
 =?utf-8?B?UlAxZWVHNDJGZXNFV1JXTzFnWGdCUm04cndaN0dFa3NxN29FV2Zmbm9TSGlo?=
 =?utf-8?B?WGNhS3A3dXc3Q1RkT1UxblloUXBsY3FGVXZGVnVKeCtTbGZyYjh6dlB1UWpB?=
 =?utf-8?B?bjdPYVJxTzZ6YVlQTjJIT0ZQbGt2RW1mT0tMOWdoTitCTGZuNFU4TnRnOTlQ?=
 =?utf-8?B?VGJFVVZUbmFNVlpySHI1YlpmTGNnQ1poNEp3LzJJbnpETzE1bURkODVkWm93?=
 =?utf-8?B?VDlJZElXNGl2U3FGbTExTUQvVHZGaXZJL2pYNm1VTmxqelF3UUpNR2VGQUhW?=
 =?utf-8?B?NGk2K1cvcGNIamZ3TzBDbmVQTnRJYWNrTm44V3ovQ0V0WmdLeldFajRGcU1M?=
 =?utf-8?B?dlRBMm9CK0dTdVFpSXFla2pUQTV5RGd1Z0xJc0NDcm1ZWVErTkZGd0Jia1JB?=
 =?utf-8?B?UWNwSUZvZzVVdENhSy95L3ZYTW45MDc0MnR4eVZYUFZXanJGMlZHbExXQ21K?=
 =?utf-8?B?U3BqSEhpNHdyeTluTldhMUZCTjh6V2tsUnk5Y1NMSk92M1hvTG5qL3lEWGEr?=
 =?utf-8?B?dUIzODk4MjVjcmdBNi9oOUMrbjdHQzZBdm52a3pNQmo1WGZHOG5xN0lnL01H?=
 =?utf-8?B?aG5lWEQrakcyV2E0eG1FZnpjZXBlZ090UjhxS2hlU2l4Ty80QlE0dHR6c2Yr?=
 =?utf-8?B?L3ZLZGR0NFdrTGE1VzlxcmNPaEMzc1R4Y3NTbHNVV0dPQ1FaN0hyS0R1QUxk?=
 =?utf-8?B?WEcvTHVXSGZTenRVdXFoWU5YMXhZVnpSdWsrTFpodHVVdmxZMjhhZUpuRUlv?=
 =?utf-8?B?Q3J2UHJDbnh3bUJISjZMMjJkQUYvSFNtd1FqUUFBMmFaTTVXcThrc2c0aGZO?=
 =?utf-8?B?OTREcVZCMnpQUjg2amNjT0F2bXNpaUdsZFRsNGgwb0RJSk9Ubjh5SzByVCtE?=
 =?utf-8?B?Z0JRRmVMTllxNW42OERDdm93a1Fpc0UxcENkbDR6eEI0RzBnK0R3ZUsyRmRS?=
 =?utf-8?B?cXdZWHRGQWxWdFJkelFuSEJJTnJlSEE0RmQvUVBzaGFVZGdxYmFQbzhEYklx?=
 =?utf-8?B?TFBmVHluOEpvdUR2YjNhVjFhOWdDc210WU5OU2VWanRxOGhVQnFaYUoxY1Y3?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a71e359-4174-4452-69af-08db45bb0fc2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 18:29:52.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSYbW/9UsFxEOlGThewYhS/ABkUM9EJMIA0RmzYOd8HQsADi1k7OPz/vvUsupP5O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6298
X-Proofpoint-GUID: NT-wNQTVyJReUGWebiUePsstHEfJm5VP
X-Proofpoint-ORIG-GUID: NT-wNQTVyJReUGWebiUePsstHEfJm5VP
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



On 4/25/23 11:22 AM, Stanislav Fomichev wrote:
> On Tue, Apr 25, 2023 at 11:10 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 4/25/23 10:04 AM, Stanislav Fomichev wrote:
>>> On Mon, Apr 24, 2023 at 6:56 PM Yonghong Song <yhs@meta.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/24/23 5:01 PM, Stanislav Fomichev wrote:
>>>>> From: Peng Wei <pengweiprc@google.com>
>>>>>
>>>>> Compiling C++ BPF programs with existing bpf_helper_defs.h is not
>>
>> Just curious, why you want to compile BPF programs with C++?
>> The patch looks good to me. But it would be great to know
>> some reasoning since a lot of stuff, e.g., some CORE related
>> intrinsics, not available for C++.
> 
> Can you share more? What's not available? Any pointers to the docs maybe?

Sorry, it is an attribute, instead of instrinsics.

The attribute preserve_access_index/btf_type_tag/btf_decl_tag are all C 
only.

In llvm-project/clang/include/clang/Basic/Attr.td:

def BPFPreserveAccessIndex : InheritableAttr,
                              TargetSpecificAttr<TargetBPF>  {
   let Spellings = [Clang<"preserve_access_index">];
   let Subjects = SubjectList<[Record], ErrorDiag>;
   let Documentation = [BPFPreserveAccessIndexDocs];
   let LangOpts = [COnly];
}

def BTFDeclTag : InheritableAttr {
   let Spellings = [Clang<"btf_decl_tag">];
   let Args = [StringArgument<"BTFDeclTag">];
   let Subjects = SubjectList<[Var, Function, Record, Field, TypedefName],
                              ErrorDiag>;
   let Documentation = [BTFDeclTagDocs];
   let LangOpts = [COnly];
}

def BTFTypeTag : TypeAttr {
   let Spellings = [Clang<"btf_type_tag">];
   let Args = [StringArgument<"BTFTypeTag">];
   let Documentation = [BTFTypeTagDocs];
   let LangOpts = [COnly];
}



> 
> People here want to try to use c++ to see if templating helps with v4
> vs v6 handling.
> We have a bunch of copy-paste around this place and would like to see
> whether c++ could make it a bit more readable.
> 
>>>>> possible due to stricter C++ type conversions. C++ complains
>>>>> about (void *) type conversions:
>>>>>
>>>>> bpf_helper_defs.h:57:67: error: invalid conversion from ‘void*’ to ‘void* (*)(void*, const void*)’ [-fpermissive]
>>>>>       57 | static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>>>>          |                                                                   ^~~~~~~~~~
>>>>>          |                                                                   |
>>>>>          |                                                                   void*
>>>>>
>>>>> Extend bpf_doc.py to use proper function type instead of void.
>>>>
>>>> Could you specify what exactly the compilation command triggering the
>>>> above error?
>>>
>>> The following does it for me:
>>> clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h
>>
>> Thanks. It would be good if you add the above compilation command
>> in the commit message.
> 
> Sure, will add.
> 
>>>
>>>
>>>>>
>>>>> Before:
>>>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>>>>
>>>>> After:
>>>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *(*)(void *map, const void *key)) 1;
>>>>>
>>>>> Signed-off-by: Peng Wei <pengweiprc@google.com>
>>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>>>> ---
>>>>>     scripts/bpf_doc.py | 7 ++++++-
>>>>>     1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>>>>> index eaae2ce78381..fa21137a90e7 100755
>>>>> --- a/scripts/bpf_doc.py
>>>>> +++ b/scripts/bpf_doc.py
>>>>> @@ -827,6 +827,9 @@ COMMANDS
>>>>>                     print(' *{}{}'.format(' \t' if line else '', line))
>>>>>
>>>>>             print(' */')
>>>>> +        fptr_type = '%s%s(*)(' % (
>>>>> +            self.map_type(proto['ret_type']),
>>>>> +            ((' ' + proto['ret_star']) if proto['ret_star'] else ''))
>>>>>             print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
>>>>>                                           proto['ret_star'], proto['name']), end='')
>>>>>             comma = ''
>>>>> @@ -845,8 +848,10 @@ COMMANDS
>>>>>                     one_arg += '{}'.format(n)
>>>>>                 comma = ', '
>>>>>                 print(one_arg, end='')
>>>>> +            fptr_type += one_arg
>>>>>
>>>>> -        print(') = (void *) %d;' % helper.enum_val)
>>>>> +        fptr_type += ')'
>>>>> +        print(') = (%s) %d;' % (fptr_type, helper.enum_val))
>>>>>             print('')
>>>>>
>>>>>     ###############################################################################
