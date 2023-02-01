Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197EF686108
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 08:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBAHzW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 02:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjBAHzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 02:55:20 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A90AEC41
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 23:55:14 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114etDn019881;
        Tue, 31 Jan 2023 23:54:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=JHzTIeCqCvY3htEpnG3Y9C8srxxhVZfRiCinCCTmYdM=;
 b=FPpSuiInLburYV188snDlUHybOPYZiPanUJQcM0jCTiKuGYGZhm59w8dyzPLVDchEdbn
 DvyrYdx8z8I/5LsQhU9wEULC2KqLH0SFi3bt92mjjxNmAa6/m53lQG37KOtAXuhM5kal
 25spqadIPPYaHZ0Q1tHdzoeVgwhnJtVZpgIB31mTCIb5YOgBbiwZhIB/pSusB1X7picI
 ZaLoZLadpyyXF4auY4WVDwP3fv+V2cGzKcsrKLYTFLgcz9Dc60kVW9vF6XeLMyqDZamz
 xcW9BoW6quYmX/JNvGg1TNa1CR6HMNDRA5eaUPJokcdxkmcJVBRDD4BXtmGJSiG2zAGA 9Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nex69gcrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 23:54:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDWonfSMOhOSIYqpApYkp1fGNgDDXKM783Aur8ZFiKT5TwhgCDPzVgr3+SOSe3/5oFvtFVX5TyU5gM2mU15S3nCTP6/toBWZNxU18crE7WrPDQYC1cXSfPfZynUiPVHgkkeBYpGt2M/xFxpZSzEgBWWqjbjvwE7Y8teda+5s+s0gczp22znAHxgC6XnZv0+ko4cJbtPj83FZJrtniqwVtQAmuI4YhthrGDZ8dgABAjVMMF9VlJnPTSH1QIwQF4+XpxJevEqeTxhdFDQw5D0nIkN/kYp4psCFIMzzt68JKEn95HfCQllwAVMDeSXmbO7t4Yu5JPCWAi6Jz5RL0gmfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHzTIeCqCvY3htEpnG3Y9C8srxxhVZfRiCinCCTmYdM=;
 b=FhICgKLHiVejMirUzHils0smV7wUAk7jzOyZJEt7RKYUVN/76bYQ71zu4GrAD1xPBeljuPOlqX+fUafHCeuKOyN9LjyTV/1oCwp1LhcvVX/n9NEvj98IehjlzfmiVHE13pY4vkqk3Z0XOWxUKjc/IHeIHaZ/4VJqkG5E/f1BUfKcK7IaJznj+Iu0RM5x8t91gq/fzmBA9vqNBCPKcl2hVLvlVZ5TZtrKRzXWnE6BhUBL1GoeYqfA4U2Cm3sW1tUbbZqieJt2VrT0cFIFJ+If4xXOyphK2zju3NbHILToGGBYt0/gLpTM0IWSfdXdnbEhaHaFxaPeZSuDEf6aZ1CUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4061.namprd15.prod.outlook.com (2603:10b6:806:8d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 07:54:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 07:54:47 +0000
Message-ID: <53aa0122-5233-35a9-d1b7-0c5503cc8023@meta.com>
Date:   Tue, 31 Jan 2023 23:54:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [Lsf-pc] LSF/MM/BPF activity proposal: Compiled BPF
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     lsf-pc@lists.linuxfoundation.org, ndesaulniers@google.com,
        david.faust@oracle.com, elena.zannoni@oracle.com,
        James Hilliard <james.hilliard1@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <87edrbhq3k.fsf@oracle.com>
 <cb0532ae-3500-6caf-7e84-c9ed0763c49d@iogearbox.net>
 <87h6w6cndd.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87h6w6cndd.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0057.namprd08.prod.outlook.com
 (2603:10b6:a03:117::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: d59db109-6eec-4012-d445-08db042996e7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QW26aapeqvjhn9koeAYXBE8drBs9FATIeoZfIKyKRz/ePPgO72Onken3qt622GsoIZDbt59X7drIj+ew77J77DER6Fja6fYaivPX5Bbee/ZjDYD9bdD7piSaU6ZBzHbQDALb6fZYAm8/UjMhEVZqk94nCBWdfzVHSPWCx1qZEi5aq0QOrirZARxN+rP1JzuHkATvWOC6K9y05+pRPscUJ193LCBP6AG9V26zXF8d/qIxtHiKZTItXyAxbqK8k6UgDCeYBdjsdudUfBVCYLA9utw4MwcrmmiguL81vZyDP3tTeKJv8kMdcKA5nOdgQw+xG1y6aMl1RyK8R2YXDZATojQhTrITmGoi9Y3kF5afY3B6QER6JVQzYfQE9XuPeshybyBDOHsgY0lD8bsgSFx4UN8B4uNwZANJWMaO7l/Ht73nu6P04SuIL2lasUiNEUEJ4BW0KC76uW0+fWcMwjeXgByy2kMKB4hSrxM+oIOAjTSOgbUOE7ARwruzO2IyHq87qdAAVM5ZLgpmwvYCSvGr5M5ZT99J74t+p2DlykL4vK+I4Nwea/zD6HGxDxqJZWps6nVIatwPlcC8/tydIYQyeUiMcbUNC6jmUnWofYipHYAt0Bk397DXuYP9n3cev51RQd1fb17EqxcT6KOlu2wWXOFFoxbVOT93YyQmCes80v/dez3HygY7TvwTnUyXcSW+w1YGrJEDh+BwqI73sIxghDJXkRnqPDzvKbtpjpIHslw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199018)(478600001)(6486002)(6506007)(53546011)(2906002)(186003)(66476007)(8936002)(6666004)(8676002)(41300700001)(4326008)(66556008)(316002)(5660300002)(2616005)(54906003)(110136005)(83380400001)(38100700002)(86362001)(66946007)(6512007)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWxiYU01Z3dqaDlBMTZoVmNUVzlFUlNvb010dnZzZWNNMitKYnZaS1A2c2VN?=
 =?utf-8?B?ZW9yWjI5L29KVGtvaWI2OHpOUzI3MEdiclA4VFJ0KzdERWhmeHhEV21EODAy?=
 =?utf-8?B?UUt2RWt5djZJWlJUOTg1L0U4U3dOMzNIQlhMdmNYby8ydnh0cEI5NlRTbXZJ?=
 =?utf-8?B?c0VFbnppSFkxS25hNDhnWG45Y05EYklwRTF5RnJqaURpYTdCYnhZQjBCamNG?=
 =?utf-8?B?cW9KdlJUTFM5Zklyc0FVdGF6aFN1QThiRXZzRnNmWXFqWTlEV0R0MGpDV3FR?=
 =?utf-8?B?L29EdzdzSjVrSTlCcG9lcEVFbXhXMTRZS3FQOW1NRGNab3hpNWJpZ2ZmdWpV?=
 =?utf-8?B?VEI2R2Ivbjd2bkhVNFhIUWxYanJKaEhoRUQycng0SEwxcVFkQ2lLSHFkdGQ5?=
 =?utf-8?B?Vkp1T0ZqRnRkaUxhUVN4Z092UnBxTmprQk9RaWJQcWM3bXlzQjllK212ZTFS?=
 =?utf-8?B?akJKTitFSEVtK05HN25KVUVkdXBic2JydGhxSVRVMkdaVXZ1UFFNd2I3OHhQ?=
 =?utf-8?B?alNSWWlHSFEwbWtOdFdNKzlnS1lPNXlNd0J3dEtNOXE2RWNwK0tocU52ZXZW?=
 =?utf-8?B?ekJ3dDFXVXcwUFY2eUZwTS9PbnJYL0dhQjE1RVRjcUpvTjJFVkJweFJEd3JK?=
 =?utf-8?B?U04wMVFEUU8rVFB0NEkvdmlUZDlhNHVYU3BQd243dy84VEpQcHhFQkx2RDdT?=
 =?utf-8?B?WDJ1Z1ZuZUJ3enhXUXVPRXRsYWRoejFiYVRWdlcvUXg3R005NGcxMUtEeUdt?=
 =?utf-8?B?MDhiQ0FITnFKb2RFQktDa1RqZndPTG8rWnRhejVuTFY4VTFxWnY5SUpYL1FN?=
 =?utf-8?B?Mis3OVZTUEpMS2VuWVk0S1ZUMkkyQ25jTUV2RG0xNHN0SFN4YzFLOFZhVW1C?=
 =?utf-8?B?aDdrWitlR2NFZzdSbVdDaWRkNzZZZ0ZaNEY3MitNY0paWTBrelZNMFRFMEc5?=
 =?utf-8?B?eXU1VGdBM1p0WitONzdWa2lHdGZKR3NDd1JXcXlPVWVYTklNeFZYbWhUOGpi?=
 =?utf-8?B?cVZiNlV2Zk54T0xYcUpxdnRaWmg0T05ENUpzcitIQThiMU9HRWZZSVJKOXFL?=
 =?utf-8?B?aWY3dmEwb295bklhdm5oK2pjTlBLSndCOVJNU3Z4R3c4eVlPYjREdWhqSjVI?=
 =?utf-8?B?WEtXdzcrWkYvQ3R1Sk81UmNhRGdsanpCMEFra2IxdHVlU3dhWkx2Z0NkK0g2?=
 =?utf-8?B?NzR1cjcwVC9GcXd6TlgwUEZZOFVSOHU1bWtzVlgxQ3UzMW5nYllEc3B5UUIy?=
 =?utf-8?B?OTl5c01RaDZZOTc0dGNablZ3WUlyNnNOdEc5OWp6TDJaRHZKZ29PUXF4V2V5?=
 =?utf-8?B?ZTV1a3hhQjZOOFR0NUpxMEVNcExqWjJPeDJFRUFzQ2VSQWRMUXdIbzNINUZO?=
 =?utf-8?B?aWVpSXJFcXBkTStLRWVGazlPSDZBVFJMczBOcDlUL1hYTXYwZFB3cDFjZ3NV?=
 =?utf-8?B?QVdiRTZ4U2JVWE13NDhnL3EwNy9BZzFQZHNON1haenVXRXZQbjRVN2pPMUw5?=
 =?utf-8?B?Slc0dE1QTExiR1YxaStmYjZOYUx1Z3Q0bTU4SDhEdTBoNzZ0UytnaCtsdyts?=
 =?utf-8?B?Y1YvWHAzNTJCcDZnSTF5a1VxRlZBNUxhSDBlM24rUU5OWjlBWGJPU0N2SmRC?=
 =?utf-8?B?aDN4Z2JDQUVCUVZzbEoxLzNGR0hHQk90bnR5SWl4ajVsVGZiK1lLSDFJZTJq?=
 =?utf-8?B?clFTcElhTm1kZ3NxR3U0b0ZNOTZRY2x6a25GajRoZm1ETm9DOFJITkYvbVhw?=
 =?utf-8?B?WEhCU1ZUK1R0QWlUZm02OE5kTTJ1TDM5TC9BK0M1VUVQaDJoNWpXYXNNaDYz?=
 =?utf-8?B?Z0dJbHA2VHUySE0zYVNhakpxZHdIdjFOY0ZKdC9CcUYwWkxOU1AzUkFtbjFJ?=
 =?utf-8?B?bTdJVHM1ZHRKNUJjNVYydjVzNDN3cTdSMldYZlAyZWVKczVVdkRYb0dtNWhi?=
 =?utf-8?B?M1I4RHJJU1hLVnprZFRXdlFnZlYzZzIzNVB3ak9sSUU0OERLc1hRd0Q4UDBy?=
 =?utf-8?B?Rk0wMjFxNGFXcGs0OWdUWHN4T2ZXMzBHaVlDNytmMmM3akVwZHNBcW1henBK?=
 =?utf-8?B?Tjc2VW9uS201S0NXK0VCRzNYQTRIMjdIeG9PVTF6cWNEMWVtL282a1lQNGFC?=
 =?utf-8?B?em1heTNqbmVjY3BaQlVDVjJ0TUFXczg2R2xTNFVCMzd0V0RiQ25TNHRqMHlS?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59db109-6eec-4012-d445-08db042996e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:54:47.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnYcRj3mVfNJotz6tkz+0kdlCLQ+vAIPKO9Wzj2EzKtPqSyCJyUkktsi8WPiR/k6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4061
X-Proofpoint-ORIG-GUID: bbSytJe0bsABFxOHPJcdirkyIIdEbgAm
X-Proofpoint-GUID: bbSytJe0bsABFxOHPJcdirkyIIdEbgAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_03,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/31/23 3:09 PM, Jose E. Marchesi wrote:
> 
>> On 1/30/23 6:47 PM, Jose E. Marchesi wrote:
>>> Hello.
>>> We would like to suggest to the LSF/MM/BPF organization to have a
>>> working session on "compiled BPF", i.e. on the part of BPF that involves
>>> compilers and linkers.  This mainly involves the two mainstream
>>> compilers that target BPF: clang and GCC, but other BPF toolchains are
>>> slowly appearing (like the Rust compiler) and that makes it even more
>>> important to consolidate compiled BPF.
>>> Examples of topics to cover are the covergence of the support in
>>> both
>>> clang/llvm and GCC, several aspects of the ABI that need to be
>>> discussed/clarified/decided in order to avoid undefined compiler
>>> behavior and divergences, issues related to the BPF standarization, and
>>> suggestions on how to lift some of the existing limitations impacting
>>> BPF C programs.
>>> The goal is to reach agreements about particular things, document
>>> the
>>> agreements, stick to them, and a clear plan to implement whatever is
>>> needed in the respective compilers/tools.
>>> Potential participants in case the activity takes place:
>>> - Both David Faust (GNU toolchain, BPF port hacker) and myself (GNU
>>>     toolchain, BPF port maintainer) are willing to attend the event,
>>>     prepare discussion material, organize and participate in the
>>>     discussions.
>>> - Nick Desaulniers (LLVM maintainer) is also interested in attending
>>> and
>>>     participating, provided other compromises he has in May don't get in
>>>     the way.
>>
>> Plus Yonghong Song with regards to LLVM BPF backend.
> 
> Indeed, it would make very little sense for the whole thing to happen
> without him.  I just didn't want to speak for him (I consulted with both
> David and Nick before sending the proposal) ;)

Sounds good to me. We can continue to discuss all possible divergences
in the mailing list and discuss/resolve the remaining in LSF/MM/BPF
conference.

> 
>>
>>> - More? (Please add yourself to this list by replying to this email in
>>>     case you are interested.)
>>> Would the BPF community and the LSF/MM/BPF organization be
>>> interested in
>>> having such an activity?
>>
>> Yes, we can definitely add this to the agenda for the BPF track. This sounds
>> very reasonable to me!
>>
>> Thanks Jose!
> 
> Awesome :)
> Thanks to you!
