Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A2263906F
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 20:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKYT47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 14:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKYT45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 14:56:57 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B027645A03
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 11:56:56 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APGiWeU025457;
        Fri, 25 Nov 2022 11:56:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=4sagaMkOADoUz+LFt2qQk96+BvhJ4L9mxkCy2lK4Q8E=;
 b=kkYjSD5AIncm9hBHqto9Sbc/n8JcpWu6FF6G7pxR9kXW7q7KeMwVYg374uo8ifobAGaX
 trfbRcQsrVymmuIPjV469qzvUW/A+aHcbq4wfgrgJ/jzV5ybSELRCJKCh0qhpchq4vRE
 ADN1RJRfCyokCi2HaYdxq7/DDtruQ1Pyj9Gu+M25ueskqWCDzyIdxDrpY2sDOu9YW0Bl
 8JUpcWNAN+y0ZJ74NcdYjAUZlRCe0DlvffHczhO1DZ3iq2SiR+ca04cVoQ7HFPemzQOB
 9LUNesDdGaDQExvukCaHjAD/y+aO2vmy0CJw4uDCGMP7gLeeI/tIKExP3blRx6QXLzG2 iw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m2tvekq2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 11:56:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzG8ZrtuIiYGBxnvIr9xa3On8TmtmkKzKv3iftUwCf1+d4crT4JK1RwcThCwWrX/2021LGiA1CZu4FOSWgQWQ7MHv2aWaUOO3McnayG6y2R9oRGgeeU5tIF/oAWsCHYiewuw/kIlNFLeXhYd5Jxg+ZS0t4F+Df5C9yh71Kkwnu4sJEBRU6RSRfkAAfx2IdaRw1h+/0kt+xP5XyS2ruXdg0hM34sJstUUwYe+6E/xx+5TPIGL74mNoS+GZc58FjZqjtRu0ekKPR7mop03TGWXR/9/YwwOwhzGqVCr295r2jVy9nxfrvjQvsftB+7xkhg2JRi00Cc3Yuetw3txEdaocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sagaMkOADoUz+LFt2qQk96+BvhJ4L9mxkCy2lK4Q8E=;
 b=KTQMho37DObjdycqKu4q29pMGoEkvcs0S7Vgjq3o0MIVg7Hhf9aaOVt/2miYCAgIbVM3dEaqx4rbB1HgKs/kYvbU62ZhJubX1lGOW1bjbblj5uy01iq3E0qgzSpe7fThh11j5ExrWO9s3T8C4W5BaJ+7+6JTJUMSlyfeupRWJBUZYZvS4l1RuXNXblLjY4PdW0T2hVbk6chBz5irbarr8xWfVSsZ31J+LIx6tHoeporWlHUlkicaMBmveIFTnT4IIWmEVSUyQdch2LLR/00E3nS1O1cbZKm0mwhanSqQmA1OcdlqZ8diNhxBEcLG2wF5pQl+np95xmxn6OyXDkSUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2221.namprd15.prod.outlook.com (2603:10b6:805:18::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 19:56:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 19:56:36 +0000
Message-ID: <45facb0d-407f-e5be-09e5-709ca4994de6@meta.com>
Date:   Fri, 25 Nov 2022 11:56:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next] bpf: Tighten ptr_to_btf_id checks.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        yhs@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
References: <20221125183546.1964-1-alexei.starovoitov@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221125183546.1964-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:a03:80::43) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR15MB2221:EE_
X-MS-Office365-Filtering-Correlation-Id: 74459d3d-4cb5-4459-a294-08dacf1f28c9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Hb6HJ7yWkeOsF7b5LRm06dlnlQs04J8DXG8MgHJ5appeSLWwlhX53pkmVA3FyUva2Ch4nZF/T9f1dvnM8U7dPG0wn6+N1Cso+Kir/6nIfoD4It3W3s+eJwcb01lUpjK/xdE26tgYXSuTyP2lMDcdhfGEfnBhbYkVMXsCRUPapYC+IA3VvFCvcbZLPPxw3yNl5AUlmFB+hZmmH4VJ0s2GW2Jr4hnNszZEG/g1TvLH0KGrwJl+oqUMi9elgjXWWzvNMgkirIn+5vTYSEFpiSandQuIBZQP1GGI73ZFugmzYwFvyfv4Xkoilb3S/uR2BbIsrDJquigchc4pNDLA4BPzoPxwHy8NkUmlo6zdbyN2KJrztv6iggH5zuyoET0KKSkYA2XAS+3MuJTJ6W98IRrWqI15UmzO9RwdZlmgwJRe/g8mh4awvltLJ45pyWqTrhtYy0jxJiTXyxUBaKpxxiXy2GyBwOspDl4ocVeFj2clgHoKryETMfJ/b3ZkmFKlfYI9wVuhR5nDL4x8cZzDDI/wQu+Yw3TV3c8zomuvE1ybYK1Co4AQCsYDb5OlmTJIdgR2KZYoNW6j9ApSfaiZ8rXoE0cF11UWkPq3jCeCykW7d0eNT6CfPpejdJnA98cm36LTl3OJNH+wkDyI2g45uT2CkaR4ybJW0S1Ph2QbTw+xPjraF4MSgup9wqY7rmhbHV5HWWQLNtZ4a81lQ1Vhnzqa9n6y3f6MKza48MgWcsEcIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(31686004)(36756003)(86362001)(31696002)(5660300002)(41300700001)(38100700002)(2616005)(6486002)(53546011)(83380400001)(478600001)(6512007)(6506007)(66556008)(66476007)(66946007)(8936002)(8676002)(4744005)(316002)(186003)(4326008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUM4MEVyZDdLZVpWTnFwbUJZR0FnYkFTL2FtcWJUamVCM1BHT0ZaVDhKSmVh?=
 =?utf-8?B?UUhUd1dWcTFXZ3NsMFRzZVB2YnYzVzVzRUhmOEdNWldmTDZoRVQ0V0hKaEJ6?=
 =?utf-8?B?NjFIV3c0Z0trM2FPOFFiaXdiY0l2ZTJwQUV6TmtwNnAvemgrNkhRaFNITzdi?=
 =?utf-8?B?ZUExSk1iN1c4YmI0Vk53MklmdFN4UCtkdnFXNGFISFZuWjVwbUpybXMxNDYz?=
 =?utf-8?B?ZFdIT3RMalhlTk5lZ3Nud3M4MTI0VzBPcEdIUWVSVlpBL1FMSnNVZEhPenQ4?=
 =?utf-8?B?WVBFVFQwQkhRYUU1QVZzSVh6V1BwWE1wZXY5ZWJsN3F3Yk8zaVkyNzdxbUg4?=
 =?utf-8?B?OHMyQ2NwQlUrelZlNkRJamkyanhXZjVncGMrc3F1Tlo3R2tibFJnMEhvMmFR?=
 =?utf-8?B?Z2dWdlduQTNEZFRWR2lGQWZwNHlyL3p0eEhjbVh5bTdFTkFlNHQwNHV6ditv?=
 =?utf-8?B?QUt1S0FPTEQ2MEoyRm5hZDVnVkhSU1phQkZnUVMyYkwvQWhOSDFBbzI4Z1RP?=
 =?utf-8?B?ak1LMGlQQzFoem5VS0VLQnRCMnFJaDhleTJuMlprd1U1Sk9XVFZLS2JjeFZj?=
 =?utf-8?B?S3JxTmpIRTlVTUN5UW9IWjBtanFLRDZEbW8yaE14K2hmclE3VVllMzlENGVT?=
 =?utf-8?B?V1o3R3NXWThVcmxjYjAzN3ZtcTZFQ3NCOW9xMTM5V1hWdzNncERFei9lRmVM?=
 =?utf-8?B?OWxvOW9XMFAzS09nbDhEckhTOFNHTE40Zmk2VUdOR0tqN1NES1VkZlYyREs5?=
 =?utf-8?B?Y2hSV2w5M0ttWWh3bm1MVldhTDJnNmFKSW84STYwNDRmd1FEQlVmbkoxcXh1?=
 =?utf-8?B?UkZUZ1J5L1VlYnhqS01FdklrQmNSbXY4Yk90NWpqU1BFdXF6Z3VKUWFpUEZ0?=
 =?utf-8?B?SEdaTndsbnR5dzNZcEZXQ0lxM2FDcTdhMUVDUjhEeml1OWtaOVZyeDUwdGNx?=
 =?utf-8?B?T0RRWG1XWkZxeWIyaVRLWVY2b1pMUy9vUUVlZzkxeVdOL1VYcXRyelhSRzgv?=
 =?utf-8?B?UjVlSWgvdmZPcHBOZmJMWllJcjhxL1pHU2t5NUVUaUNsWmRkdUFzOUZ4VFFv?=
 =?utf-8?B?M3pVbEg0NTZWQnJpdUw4SUY2d0kzVW5KenNJQm04OENQRjhOTHN0RGJjR3g4?=
 =?utf-8?B?SElUOXlCY3VWSklhN2QzMWNHZ2Q5RjNwMlpmRDBVQ3hXZ1I1NGJxVlU5L1ZU?=
 =?utf-8?B?dUU3elpMZ0cwSldyRG92SWNROURMV2ppeUNRK2tuRXRybTQyYm5zVS9kOEJH?=
 =?utf-8?B?dlR6VlZDbDdwcThpZHNvRmRZTzNqRDFuRlVyVTA2UEh6Y2pCdGpPY2RKcXBU?=
 =?utf-8?B?L2YreExkbXhETXVWVHc1RUNZOHVRYXlabUJYSFlrOWVXZGhFQW52c3NQd09U?=
 =?utf-8?B?NzdiMUJPZjhWT2paRjNyVFk5dDBFR1ZWQ0VGT21wNVVITUh6RmRwSnVIQ2Qr?=
 =?utf-8?B?aFN4Y0RhSUxaajZtWEEyTTBJSlVGYTZMcWZzdG1rZzNKTkhZSzdBZVB6ZndL?=
 =?utf-8?B?U2ZyWTdabUs3YWw2RUFMczRaMnVwUE1vc0ZmVkF1NXZUNmRIdkpqQUZoSDR2?=
 =?utf-8?B?TWNqMkZJL3hGN2V1Tks0QjJ0VzFxb1NvOXVnNVJTY0FzZ0VnOWZrUXlaOFFN?=
 =?utf-8?B?N2JJenFKWHBBMHhFQ0hRK1ZTcktQQUYwUUNXM01qWXJ6V3QrdlVTdFJkTWgy?=
 =?utf-8?B?UTRSVVpBdjRVaTBwVW03ZlVJZkRianhtanh5L3dvaVZuTkkyZzJlWXlTcStv?=
 =?utf-8?B?ZVlTd21Od3c4VFhzYkFMUFlJbFpmZmZqLzNYNTd6UzZ4TEJZKzl4dTVyNXJo?=
 =?utf-8?B?UDFneUQ2TXlvT2o1R0xZeDlXeTFZL3JtbVNGdUQveVdpWWVqY2FUbVJydk5X?=
 =?utf-8?B?UmNhZmhjdUZ6elJ0YWFsSkpQV2ZzMGZQbjFTK2lQTklGN05iMFdteUZrTjBY?=
 =?utf-8?B?UU85RlNGcVRmMTdNTU1BT0ZJMVhlZlhxcVhqY3hhaTBuNlpCYnFENkJCdU11?=
 =?utf-8?B?QmVGYzhhaWtTbzVrd0FJeFRLRW1NZWNhVTRNUW9NMVNmZTdaWm5McFg2bzRt?=
 =?utf-8?B?bkJOS1gwTHViNXBLejRhV21KOWowVmxYeEtMZnE5eW1MNDdQU2JmTkkvelAy?=
 =?utf-8?B?dnVIOFhXaDVsMFUyUlM4RXA1aUlLcUlZaEVWMDZaWENmZmpGeDBjdGhOMitI?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74459d3d-4cb5-4459-a294-08dacf1f28c9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 19:56:36.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhvaTjT5JA/sIPCXxQOlA+hqVqixnGVf9q9LuXtnKsw1YRoEKsVQbWmhxgc5lV0Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2221
X-Proofpoint-ORIG-GUID: XsxKtWLNV0Y47dMBDSU_6XL4p0aJtecT
X-Proofpoint-GUID: XsxKtWLNV0Y47dMBDSU_6XL4p0aJtecT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_10,2022-11-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/25/22 10:35 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The networking programs typically don't require CAP_PERFMON, but through kfuncs
> like bpf_cast_to_kern_ctx() they can access memory through PTR_TO_BTF_ID. In
> such case enforce CAP_PERFMON. Also make sure that those programs are GPL if
> they access kernel data structures. All kfuncs require GPL anyway.
> 
> Also remove allow_ptr_to_map_access. It's the same as allow_ptr_leaks and
> different name for the same check only causes confusion.
> 
> Fixes: fd264ca02094 ("bpf: Add a kfunc to type cast from bpf uapi ctx to kernel ctx")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
