Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5D60C1B6
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 04:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJYC3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 22:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiJYC3A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 22:29:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC5103D94
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 19:28:59 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ONmZuZ015361;
        Mon, 24 Oct 2022 19:28:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=bQH6JvWkVFDpP8PB+YSQMIcgzRpAsK9PlM8YvNkJ+Sg=;
 b=EKwKEW+Js5z6OOsjYizoHX/zlx7RPDlOCwclZHchGjftBgupOk7KgdIOiRnzZ4vOrnt9
 VbhFNf+i3rtEY5Ewc5yMUYM9Vt4tMdzDbVecGaAjhPYpQXJ6g9gvQ+y241qIWyVK+YYZ
 fSiTxsgf0ZBcME/l0xqyqe57WoReAMBhDljWaD9yM6TEFioN4xUhQcnOWFSV6uqj+YaT
 5AY6vek8UtG+POf5ExoA24Kl59GRe828IEuQzso6eZqmR8YhfnIa0K9jm9TrUv3ayr2s
 GHSEfVsQGwmETE37zOnt9ZBtdOQXsOVEVP+eeoE4QOGh/9ba68jGY1OIDa0qcDlvawpK uw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kcdmuhhcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 19:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYk3SLZxTN9ArFvd0ysRtkaYBB3V9d5xGkueLgQKYtRHWTia7jsmo97mq0HqOkAdBLkrI2NXmnN9dnP8SjoLCB1BuurtXWHblzeTKwXsDMwx1vWFzxRPTD9Texpz0E5NgG6+97hJNQAX31Nr68UdauyvDepFO6cdMmPEZeQr3T0TAKJ2lRP3ijXE9DE5civW9XPDsM28zpb+0rt1gOjDMhwiIckUys+jJaVOa8Rq+XoymlCY/+3njdJMCedmG3N3FYVd92fEX6O8YjcvbAqGmiD9swBC/D3JG6eFKz6TF4p686oXHfa8NkgqP9i3ltzfUNVXYsI3rz0EUQzZr+BH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQH6JvWkVFDpP8PB+YSQMIcgzRpAsK9PlM8YvNkJ+Sg=;
 b=HP+qUbprhLdDPX37Aaec1Z6PRBOZJKear3fU7ak7DMK3xJMuyBsraffUceax5J4uzWG0/efcitE6n6PYnVsFn3AIC2YYxrqZZQSTEwaybnPTiocTywAN0tuO2q6ZcEU2fV4kX4jCqjXcp/N0rTcSrwKsbg29y+B7wMPt/IXI60ZUGBX53v5TYfRe6ECr9Od/us+qLohBduAcHyGNaQsRI3YbFaFmwzy20G1vsY6Qlb6UiPovf/Tjz3mfjSwhLHzxSBIHT/DhV9rO+1ayyPXsaEM8HhB/xpfhAkae5OYbgQsoDgAzGKjMmBqWCZ4FAQs1I/qeuLXQQFma/+cPs2fUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3217.namprd15.prod.outlook.com (2603:10b6:408:aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 25 Oct
 2022 02:28:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 02:28:39 +0000
Message-ID: <8f9a00c0-e4d2-5b95-e1d2-295199f180b1@meta.com>
Date:   Mon, 24 Oct 2022 19:28:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v4 2/7] bpf: Refactor inode/task/sk storage
 map_{alloc,free}() for reuse
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        bpf@vger.kernel.org
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180524.2859994-1-yhs@fb.com>
 <48042f36-792d-e8c9-3a9d-feb267a6f74d@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <48042f36-792d-e8c9-3a9d-feb267a6f74d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB3217:EE_
X-MS-Office365-Filtering-Correlation-Id: 054baa69-f55b-412f-e785-08dab630a086
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbyAMsD1ms21j5xTSQ7x+9y1JHWxdMNGPgoPvUPntGPUl4ibILQy3aZwVRNDwviUH6x3uVHtQcoUsO5/AinIz2tacJbKq+6OzzUU9PcxOpCOPr1CbaKFAE9n0HEzqF2Jw53JdYmmtWs38OoIaxHhpV0BM/CuoqH48GJWsL3fV+Xxw2pJ1poYWs6G3gZiklh/8pC7Zts3hh3wvB0ic2b3PCjXlHVHHqmDQrF+y5D4D4JTNSx8ZkjakYVpFJgr3DZ5H6C8ID8haulC0IqJYDA3hRwqsWR1D8yhcBPUg6g7KWKNH0py13QQ0BFOLnQdVjIjf6qMZvbkeit+VJPcsqHWucJHwXB1VvvVKOjgJ9A6axmGNHzgmwQxjTQv9vgHB/BQJCpfnKJj9Ulbu5FYBm/JAxmfdN1IUYESXOctoHwcYBjznWtdc3MJG+7X4Xt6mhK5twEvnDo6lvw4bXf+kotBQ/d6m6PWKSUEr1/u53XH5OFA4Gl17jo8MWMy+JM4Xfj5RebM3JHXGhIxgmM97JhPIAFcfVIyXhMj1FtWEtNkibNVDI/X2B+LJ+sqLcdEGzZV2KM4FmevJKTmArJtvA5kRD20i/3iIfIfAwBOMlZpvAY6BLC9yWxUXhkdOECRN86OV3y4ugkvosTzQXYbRI/OcgxDwUfW3VZ4nairFXEl+dBm36Asi2gRxrwaLvgW8UoWf4xjb2Z6K84+tbJKSoQvfdx8geIhbe0EbDZ3n+Xbpz05gaRtimtQ4i83WwlkNbJ//DOOSH84ZQHl0zo97p9ScIguDlhQ9ltQ0TfurCPdF4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(66556008)(66476007)(8676002)(4326008)(66946007)(2906002)(2616005)(31696002)(6486002)(186003)(6666004)(86362001)(6512007)(6506007)(478600001)(53546011)(36756003)(316002)(54906003)(110136005)(8936002)(31686004)(38100700002)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0NPTktXa0tqSmlGSFk1Wk5vZXlIeEV5clZyeWl5T1hKbUVEcFhTTFhCcFA1?=
 =?utf-8?B?L2dlbUk4dlFKVlRWM2dpeGUzSEhzSWNQR1V6YXNhMklPMzNkRU1ZVkJ4bmlX?=
 =?utf-8?B?UGMydW5YT3k1KzAwTWZidm05L28wUXlrMm10Lyt2a25Ea25ZNXBaYVBPTElx?=
 =?utf-8?B?NGV1MFRDOXN1UjM1QzR6QTN0SEtER1gydUcwaWRnclJ3RjRQSkdjR2hYYzVl?=
 =?utf-8?B?K2NvZ2JQdXNWeEJZN1RlMThISC9QbHVncmpmY25JNHBxZTJHUlJrZFZwS2l3?=
 =?utf-8?B?aVBKbUIxdGZsMHJzQjRsdFpjWjNuNFR2dVVOU0RaQVorUFZtQTFLSWRsM2pw?=
 =?utf-8?B?bnBxa3AxOTVuYXo3am54M0I4dWVvSjZhR3ZBUGZidG1IWkpOZUVVVm8wekFM?=
 =?utf-8?B?S1hhTVVjZVZFMVJrSnhsWXNzckpwWEJmYlc4bDRPQS9lY3JMb3FvTGo5Q0Nu?=
 =?utf-8?B?M1JoZW81Vk9qYVpoZ1pJdDZFUzI4Ykk1L0JQR3ZsSkVRcEtsM05KcDJYSTR3?=
 =?utf-8?B?MzNGaXV3b3J4MjhzdnIxTndycEQ3aURlR29xenRWV2NobW5OQnJNR1l5NnFT?=
 =?utf-8?B?QzJtRngvRlEvdGQrUDdweThkdWJPN3N2STgxMWpjbytmczR0OUttMlRIS1pT?=
 =?utf-8?B?aVZzZEVNU3A0NHRkdjhYZXk2eXFGTUF5N2ptSFk4TGFJTmdBWEhhU2c4VmZ0?=
 =?utf-8?B?WkRoYm9CVEZjWmFFNVpQem5aUDgzdHM4TWhZUHlGbXorRXdYM3ZnTXNRUnVy?=
 =?utf-8?B?eExBeC9FdUhZYTlmblFhc2x1cytMSUlMZUZxVTlLNTV2ZSszR1JsdEdaU2Zs?=
 =?utf-8?B?SGZQQmsvUjdIMFhDVXRsdkRDa2pPTGhjUHNYcDdncm1BaUJEMHRDN3BrZEli?=
 =?utf-8?B?eDBUWHR2ZHFGNVVhbDN1WUsvOElUZitnY2U3SjVpUUErR0Zpc2J5VEZoRXJH?=
 =?utf-8?B?elAzcU95TGtzSzdIZ1JIVlk2c3ZCeFhEWHRCaUl5OWFKWHczR1JFTjdEUTFL?=
 =?utf-8?B?RUtuUTJGbFF1aUc1akdHNVpTZk5GeUpUWklwcEw4N3haSnVheVBkWTVjWW1Z?=
 =?utf-8?B?VHNDNG1DMVNDSU1PVHUrR0VyR1VKSTZQdUdOUHUrRFRzYmdQaUtRc1N3RXY4?=
 =?utf-8?B?Z3FEMld1SXRQNGRvUkRSbmFyZERLckJ5MWdGU01ib0ZvWmxGUkIwaWR6Sm5o?=
 =?utf-8?B?eHVFWjNnWEIybElDZHgxeDhXckNWTU5QUzV2cTF4QkpKaXBCUGpONnhKMy9V?=
 =?utf-8?B?SDFFVXdBUXZsVUNuaExzNzVCSmNoRkVmTjdTSTJVbk5EeEYycm03NUV5SGhB?=
 =?utf-8?B?aTMyaS9ZWXMvRmdkOEQ1aGw2VE04akQxeDF1K3Q0UWZaYTBKZGZFa1g4aHBI?=
 =?utf-8?B?ekg3MVNEd0cwWUUyelQrRkg0U1B6M2VkanNMSk5PTUF3VzdxUVEzaDVMd0Nt?=
 =?utf-8?B?SnJRdENsSitvQUphOFJVenhLTTZNak1Rdndkb2JhdGc5Z0IvanZUbllJSkpI?=
 =?utf-8?B?ZGdFdkp2VzRjZGx2SjRhVTdPSG9YcVV2cGVRb3Z0dkFhYlZzMVdmckN5cWc5?=
 =?utf-8?B?eDkzN0gxOXVLN2xXMDRzWG5DandQb24rVEZ2MzRTZnhpdk5vME9LVVZVd0Vx?=
 =?utf-8?B?MFhnZjRNVDMzYTE2MER5QU4wdHVqRllMYUNyR1JuTXNKb1JIZmNaZmVnbVRL?=
 =?utf-8?B?S2I3bGg1b3daTlBZSTlpNFlmeFBobzdCZk5qY1h6OVRyYmNGUURydEd4TFJL?=
 =?utf-8?B?OCtmL1B5bENYaVdxLyt3RENObjE0VUhqNXZRRFBHUlVXVUk1OEdrSi93SWFE?=
 =?utf-8?B?ck9sVHNmNTF6Z1kyTjdqMWZ5NElVcTRMbmQ3VlNzTmpvajVsTHlNM3Q5V2tn?=
 =?utf-8?B?RmN2aStvakN6QkNGUVVuSGxGVGp5em9FR0U2eUYzVm03aEVZNzFYQ1BsdUM2?=
 =?utf-8?B?aE8ybTNWajUvaVJuSFl2VFFqQW1CRnY0a0djaUEzMk9QU25WeVQyYllmWldE?=
 =?utf-8?B?Z201OWw3eVlrNjhwdzU2TzdNSlVpQXUxT3ZQS3dES3E0bDNDTm1pS08yWEty?=
 =?utf-8?B?SzdvUllGeXVTdXJ5R2ZWNzhia3dVOU4xTFV2WGZtdXV2YXRSL2hnOWR3cXhF?=
 =?utf-8?B?TXlRT1FVQ3Jjamx6YWQvYnZneXBNdWJmamxUQ01mWGZ3U3FQb0FsTkJWTVp0?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054baa69-f55b-412f-e785-08dab630a086
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 02:28:39.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJKmqR81/AMfDuxr4/LDI3N1XhHnRrQssrFXMd+pbHlejl2RaBH53ftIGgG4jP/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3217
X-Proofpoint-GUID: b8Qcnj2CvlQLbs3_Wukfo9FB8EA_Zj3T
X-Proofpoint-ORIG-GUID: b8Qcnj2CvlQLbs3_Wukfo9FB8EA_Zj3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_09,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/24/22 1:34 PM, Martin KaFai Lau wrote:
> On 10/23/22 11:05 AM, Yonghong Song wrote
>> -void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
>> -                int __percpu *busy_counter)
>> +static void __bpf_local_storage_map_free(struct bpf_local_storage_map 
>> *smap,
>> +                     int __percpu *busy_counter)
> 
> nit.
> 
> This map_free does not look like it requires a separate "__" version 
> since it is not reused.  probably just put everything into the 
> bpf_local_storage_map_free() instead?

Okay, will inline __bpf_local_storage_map_free() into
bpf_local_storage_map_free().

> 
>>   {
>>       struct bpf_local_storage_elem *selem;
>>       struct bpf_local_storage_map_bucket *b;
>> @@ -613,7 +613,7 @@ int bpf_local_storage_map_alloc_check(union 
>> bpf_attr *attr)
>>       return 0;
>>   }
>> -struct bpf_local_storage_map *bpf_local_storage_map_alloc(union 
>> bpf_attr *attr)
>> +static struct bpf_local_storage_map 
>> *__bpf_local_storage_map_alloc(union bpf_attr *attr)
>>   {
>>       struct bpf_local_storage_map *smap;
>>       unsigned int i;
>> @@ -663,3 +663,28 @@ int bpf_local_storage_map_check_btf(const struct 
>> bpf_map *map,
>>       return 0;
>>   }
> 
> [ ... ]
> 
>> +void bpf_local_storage_map_free(struct bpf_map *map,
>> +                struct bpf_local_storage_cache *cache,
>> +                int __percpu *busy_counter)
>> +{
>> +    struct bpf_local_storage_map *smap;
>> +
>> +    smap = (struct bpf_local_storage_map *)map;
>> +    bpf_local_storage_cache_idx_free(cache, smap->cache_idx);
>> +    __bpf_local_storage_map_free(smap, busy_counter);
>> +}
> 
