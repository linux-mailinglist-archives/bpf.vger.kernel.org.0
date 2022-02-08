Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B984AD1C2
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 07:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347775AbiBHGrm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 01:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbiBHGrg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 01:47:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067E5C0401EF
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 22:47:34 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2181MAGR026896;
        Mon, 7 Feb 2022 22:47:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Yd+9NiQPDd+/sgyBWchorRBIUk5SC5/fu0xh8ojB7CQ=;
 b=ftfjaW+CcFk9n28ilyelquKk2w4+gWGYhyiOoqL1/QWb9hrHB0Zuu63qBuct0Q+V/6PN
 +EWhCXryE4U/7mKMVOJ5JYog5PxQIJKTnlqrhmmQ+KiQ6Vl6x9AVSypYYKVWuyf58oh/
 6OuzmDnENYFexHg16riJ9VTs3qAsI6bj5mo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3ess180p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Feb 2022 22:47:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 22:47:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d16+Geb7bk2rYdhxEudhnVXLh4fcOCrEehuKQCp63olgZlV99FXAwJh9gfK987HEQj0kZzMfisir46vE6iIO+bgkbWxxeWnVqiRrRfVaa24tymPEixNB1ZCKp6Zyzz0jFlkUDGrXgg/7JRVwbo6ioWvBayt7HQIAOOl/tWoC8zRMgRjIJXNXC6x/+zE39G6Zjm3ZCLkvX2klxpQgxTJQ0gpicMlD8lzV195QiSOiWFrwUHBSbW76aPZ6UqaqIVsasXdox9YBZj0N4Subs/VWWnV9N3Ra21UJj/VtCmd0NkB+bDd3RLHhEkmzGZCCmfM4riwwFnxsfe/0HpFtaUROPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd+9NiQPDd+/sgyBWchorRBIUk5SC5/fu0xh8ojB7CQ=;
 b=lVgjgTNDfUeFN4BZb5XE1C11ZhE/qenBOvoNgWMvhOfnhax/PKXwmWHElKssa16Jfk97Fm+40/EW8gWGi4o48sngshuqROvx4Tks5ImkzhHtjFBMVidllffca6b+JEJ3jRNDzNLbCc75se05wjwqOt6y0JFvmDsoP+4ZJ/1qqUUZHZA+erUGuZ6G3BGxcg6J52J10mEg0fqqe6LkVLhuiN3iEBhcnyGGa4w4L2kig8IGTfcrAfjARsdvkw5hh9X27Mz81m1yWhv2dZpH0Ak4ljUkRolfrmi3SQN4FZ1MM6Vf6WCVeRBHyzz47Gk5YGz5mO8UOxoPMiZj/NBtDEHw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2396.namprd15.prod.outlook.com (2603:10b6:5:91::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 06:47:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:47:24 +0000
Message-ID: <a9afc769-5e6c-cdb9-7adf-90ed1a6c1974@fb.com>
Date:   Mon, 7 Feb 2022 22:47:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: can't get BTF: type .rodata.cst32: not found
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     Timo Beckers <timo@incline.eu>, bpf <bpf@vger.kernel.org>
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com>
 <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
 <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
 <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com>
 <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
 <85800d3d-d8d5-caba-e6c9-2505788d42b7@fb.com>
 <24b0f506-00f5-77b9-dff8-9a1db8aaa1c5@incline.eu>
 <b33e24d0-3539-3c7c-8be0-7d9ea335b28d@fb.com>
 <CAK3+h2zMRNKqA5k6FE4BG8RnJ2Tx1itVJiJGbhXaCu=v=0U47w@mail.gmail.com>
 <5bc02911-9ebf-6f4a-3804-d72c405326b6@fb.com>
In-Reply-To: <5bc02911-9ebf-6f4a-3804-d72c405326b6@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0e16b10-2af4-450a-864a-08d9eacedcd1
X-MS-TrafficTypeDiagnostic: DM6PR15MB2396:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB239643439BADBDCE550D46DAD32D9@DM6PR15MB2396.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8KQSmUq2lLovcwTvcQjBJeg8TXqa+cBlcrG/5c8f/0jT+CBIKJ5oSxZG+0L0RUYOUdk25xlByB46dJioWI4EcfkYrzkwZXUmFgNXIug+E1MdozdMmBWLdjFRWIpHO3c407sIR9hgbPxJ9gzw2yKWr920bHeHZRdoAO+tuhWsXCIQOGtSlYVDFEIcNR5L0wuN5flZYASlf4K3ZtacEnMebbT2Q85ePnUv14m4OX1JQx1j6KPSHK9OhaqWB/DxdZQwvnN9CmpR5ouYQs85Qlr3W9sPLJ9h+qg7dQor7VWB90Kip4bQR4XQ2ZPcwfPQF6by/g+f3lXu2PjHSPEU8Vpel0mjeP0OqSTZ7oGIRqXi+DyIH7YqO5pBv3IsFkld4hRfqC0NVZX3Ec6rB/Fa61d9wKJsgwSv9HxjN24fa1tUgfZM0JskZPssFJ+fPxivFzX/9qbS1PfO907Ke8evlUxHWwvCyyiiyuNiW+Q/iEuLoxOfVJIEc1dZEmIEWz6MWqq/pRQv6WrcrnXM9eLMDU/36OXSt2RHMzAaX+/UerwsHC0yujvNKgFW51XrpkwCSJVZuPb0s7Lt3AQRbqO6pk7kSXZ7e8RjeZm/cR+LEgtqNfxLXP5qSi8CuEVn1bWShaaNVjrmkX2UdJEU5Df2O44GubeEhK0vTif6AHxSgwwdvAhQJGSrcGLyGnNtM1saLYMlUah6IyXwfJuenET34y+Zjx9cEG2a9sbnDO6qw9TxTB+Iw2sgwYm8u7WRibDv3vm1Lg0AD7fwhoXfe3TqqYcYU3SSgDFshdvpzOOyAR2d2yONyIqEUxtT8WhOXX1yaVF+6++bgXuthK+kgQ5loi078inYvGpwCJUGLMLA4YpTUCoIYnIt2370+1TrV1OhCka0cRVn/gjixbLgiQQlvMFbXgVtFoyduqQzUKXukT8Kl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(86362001)(6666004)(966005)(6486002)(6512007)(6506007)(8676002)(31686004)(8936002)(508600001)(66476007)(4326008)(52116002)(66556008)(83380400001)(53546011)(54906003)(5660300002)(316002)(36756003)(6916009)(2616005)(30864003)(186003)(66946007)(38100700002)(2906002)(142923001)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFh0REV1WmgyQnhQZjV4dzJzcEtpKzNVN2ExTjlpRHIreUVMRGJXYlpNUzBU?=
 =?utf-8?B?WndOaSt1Vll6SUlVNDhtSXUrVTJnLzg5b0hQcy9XcDYrU25jZWVDekQxYU9j?=
 =?utf-8?B?V0JjZDJOSFAyc0huZDRIa0NCNkw2WXJPSm9PL3VWWUVKR0pMZlRaS0x1Uko1?=
 =?utf-8?B?MVBxTGc2YzJBOHpvK1VVYy9RT0RrS0dEdkUrY3dCRis1V3hqLytHRG9iZldj?=
 =?utf-8?B?ZFpFSkpkbng0ZzU5bWYzU0xrT1Z0c0Q4WityMUFRL1VyKzZxRlZ0MG5abjNm?=
 =?utf-8?B?UmNtbzJFVlJKaEExamIzQk1yVW5oeFUrRlYxaHJ2OFBjdjBrNGVUUUF0MVhj?=
 =?utf-8?B?YTdOVzFNYmtQQkJZWmhicWM0NVdVVkhGazBqUXBZOGRQZXNGd0RYS1NrRDU1?=
 =?utf-8?B?dlFxM252UUpFQTU0M0lBTVVJMHFxY2wvbGVjRlBJcEN4MTF4cFlic2JKTElv?=
 =?utf-8?B?eXFmSENJc1BZT283Q05iTkhkL1Y3WDNVckMxakRCSGg0ekszN3o0V0FJUitD?=
 =?utf-8?B?NkJ1VDk2eGcwV0x3OUxNUjJZcmJ5NjYrSWpGTjdGZlNqcm9sRUYxZm91Uzds?=
 =?utf-8?B?Zll2ZXpudlJyV3RYaVc0TXV6UFM4dWJyRElQK01aZXNITSt6NXZSYkRPcmE3?=
 =?utf-8?B?QkhRYVJkYjhaZGVuemdsb1FQZktaYWhWbVBhbzBHL01LQnpNeE5KWEFUQTBD?=
 =?utf-8?B?cjA2WTVMbmF2ekU3OWVJMUVvZGV4dERoQWgzcUwyTjVtRzdOZktESWZBOGRI?=
 =?utf-8?B?Q0pGREpwY1NjMEFZM0RwcVJtQ0tIMWJCY29QaFZhais0c2FoQmcwdXhQSkxh?=
 =?utf-8?B?aDdESHVJWmZpV2VsMkNPUm5rY2tndWtiTnpjbUh6VG9OWG1WWnJsbVNRa2JZ?=
 =?utf-8?B?RXNNZHYvSkJrM25HQStFTzJtZHNCTDVkR0ZQWTRVTWFXMmEzV1gwczJYdnRE?=
 =?utf-8?B?QzFQSEZJdDkva1p6a0pEMEI5VDM4M2FyOUx6a3FHVzd2emJkR096dEdvWENQ?=
 =?utf-8?B?OTdCTkR3V25zWXdFQmJEczhiNWtkaUI4eEFTaElOMlBCTjZGMlBxTkNQSE9H?=
 =?utf-8?B?UVhNRnE4RmlrT3JwMFlYdFJSbEM5Q0h6aWF1TjR4cDFDMy9EYjdpM2huSW1a?=
 =?utf-8?B?ekVPMnNGLzg1bWtxbHNYRHFnQnR5R1c3aW5pWlJYSzZZMHdtV2FOeHdIbDUy?=
 =?utf-8?B?NGVsRkRyRzVQT29HcGQvbjRuekovTFZTcDlrZEVac0ZRK2YreUpLbnZoZElL?=
 =?utf-8?B?VU9tR3B2SXZlWDhQTGJZQ041eXJxOUlGangvOGhHMHkyY3BnaFNvb2FzMGw3?=
 =?utf-8?B?WGRkU1ZKeGhmWElKMGJqWEVUVDZVVGdVblF0UXVVMUZDSUR6TUJiN1h2SkZm?=
 =?utf-8?B?U21Rb1p0eE5ybitnTXhDRDZ1OWFraDRCNk1laXEvV2htOTBWNEc5Z1BFZ082?=
 =?utf-8?B?VDlKVXQ0U2tDWGRMMUtTa3c5ZTFLUkhQSkhZSnhET0FCUWZCZ1huOTN4TXpL?=
 =?utf-8?B?UC9ydWZEQldEYk9RS3IweHFwVmY2Ty9mM01lZFdSMng4V0daZ203K3RGL0FM?=
 =?utf-8?B?S2lNNWFGOXBPU0h5Zzlzd1BEeWt4ckw2WFVrd3pDdFFkMDJwaDlwYVBVUlV6?=
 =?utf-8?B?QmZ1dWlwaHdOQ0pKSlNJZ2gzWUVhL1AyUXk1cU9BcGhnMEErRTVtSXVkTlFZ?=
 =?utf-8?B?dFZGVitndFVmcjRDTytCdXRIWXlQRm1uNlVwUExJNk00U2k2RGszYy9XTlcw?=
 =?utf-8?B?MS9rRmIvWUgrNG5yNmpPa0VjdlFFSFFXRU9hRll4QWd0Nkh3bDltRGpoWmZW?=
 =?utf-8?B?bW5tQlhEakZVZHRwTlY2bTAvZ3VWZ2VwcllSM0FGL2VqamNQc1oxVUNXazVq?=
 =?utf-8?B?VjBtSjh6WCtNaE0rbE4xdU9qM3hsLzV6TmV1Q2tGUTVzM04welB3SzhZb3pw?=
 =?utf-8?B?eTdub2JDVzAvZjF2c3NhU3ZRa2hWaGY5Qi8xTVA0aUxES2xiUkxIK1pkNG9s?=
 =?utf-8?B?NzFCZGdxTUFqWlM4WklCQ3haNnIxQWt4bEhJczBuK211aDFSMzJJVlZQemJl?=
 =?utf-8?B?VjIraWV4b1drd0NXejA2aklSRTBJRGxtRldSWEF6MVdtMWxQK3ZRdyt6R0d3?=
 =?utf-8?Q?TOBwDFXYWAseSGZM3Jfnm082S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e16b10-2af4-450a-864a-08d9eacedcd1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:47:23.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Mas29jdqix17ZmKBODEjtkF0VG1OJyTYnrKE2TxrR9/oNS/To3BNKpv+AqxDXJG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2396
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: pkRx09xfq5jxcOQl_2skPXx7sJjbUt8t
X-Proofpoint-ORIG-GUID: pkRx09xfq5jxcOQl_2skPXx7sJjbUt8t
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_02,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080035
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/22 1:22 PM, Yonghong Song wrote:
> 
> 
> On 2/4/22 11:39 AM, Vincent Li wrote:
>> On Fri, Feb 4, 2022 at 10:04 AM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 2/4/22 3:11 AM, Timo Beckers wrote:
>>>> On 2/3/22 03:11, Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 2/2/22 5:47 AM, Timo Beckers wrote:
>>>>>> On 2/2/22 08:17, Yonghong Song wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/1/22 10:07 AM, Vincent Li wrote:
>>>>>>>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li 
>>>>>>>> <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
>>>>>>>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li 
>>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> this is macro I suspected in my implementation that could 
>>>>>>>>>>>> cause issue with BTF
>>>>>>>>>>>>
>>>>>>>>>>>> #define ENABLE_VTEP 1
>>>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 
>>>>>>>>>>>> 0x1f48a90a,
>>>>>>>>>>>> 0x2048a90a, }
>>>>>>>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>>>>>>>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>>>>>>>>>>>> #define VTEP_NUMS 4
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li 
>>>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi
>>>>>>>>>>>>>
>>>>>>>>>>>>> While developing Cilium VTEP integration feature
>>>>>>>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a 
>>>>>>>>>>>>> strange issue
>>>>>>>>>>>>> that seems related to BTF and probably caused by my specific
>>>>>>>>>>>>> implementation, the issue is described in
>>>>>>>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know 
>>>>>>>>>>>>> much about
>>>>>>>>>>>>> BTF and not sure if my implementation is seriously flawed 
>>>>>>>>>>>>> or just some
>>>>>>>>>>>>> implementation bug or maybe not compatible with BTF. 
>>>>>>>>>>>>> Strangely, the
>>>>>>>>>>>>> issue appears related to number of VTEPs I use, no problem 
>>>>>>>>>>>>> with 1 or 2
>>>>>>>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance 
>>>>>>>>>>>>> from BTF
>>>>>>>>>>>>> experts  are appreciated :-).
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks
>>>>>>>>>>>>>
>>>>>>>>>>>>> Vincent
>>>>>>>>>>>
>>>>>>>>>>> Sorry for previous top post
>>>>>>>>>>>
>>>>>>>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
>>>>>>>>>>> differently and added " [21] .rodata.cst32     PROGBITS
>>>>>>>>>>> 0000000000000000  00011e68" when  following macro exceeded 2 
>>>>>>>>>>> members
>>>>>>>>>>>
>>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 
>>>>>>>>>>> 0x1f48a90a,
>>>>>>>>>>> 0x2048a90a, }
>>>>>>>>>>>
>>>>>>>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above 
>>>>>>>>>>> VTEP_ENDPOINT
>>>>>>>>>>> member <=2. any reason why compiler would do that?
>>>>>>>>>>
>>>>>>>>>> Regarding to why compiler generates .rodata.cst32, the reason is
>>>>>>>>>> you have some 32-byte constants which needs to be saved 
>>>>>>>>>> somewhere.
>>>>>>>>>> For example,
>>>>>>>>>>
>>>>>>>>>> $ cat t.c
>>>>>>>>>> struct t {
>>>>>>>>>>        long c[2];
>>>>>>>>>>        int d[4];
>>>>>>>>>> };
>>>>>>>>>> struct t g;
>>>>>>>>>> int test()
>>>>>>>>>> {
>>>>>>>>>>         struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>>>>>>>>>>         g = tmp;
>>>>>>>>>>         return 0;
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> $ clang -target bpf -O2 -c t.c
>>>>>>>>>> $ llvm-readelf -S t.o
>>>>>>>>>> ...
>>>>>>>>>>        [ 4] .rodata.cst32     PROGBITS        0000000000000000 
>>>>>>>>>> 0000a8 000020
>>>>>>>>>> 20  AM  0   0  8
>>>>>>>>>> ...
>>>>>>>>>>
>>>>>>>>>> In the above code, if you change the struct size, say from 32 
>>>>>>>>>> bytes to
>>>>>>>>>> 40 bytes, the rodata.cst32 will go away.
>>>>>>>>>
>>>>>>>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize 
>>>>>>>>> rodata.cst32 then
>>>>>>>>
>>>>>>>> Hi Yonghong,
>>>>>>>>
>>>>>>>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux 
>>>>>>>> and
>>>>>>>> stores BTF type info in btf.Spec.namedTypes, but the elf object 
>>>>>>>> file
>>>>>>>> provided by user may have section like rodata.cst32 generated by
>>>>>>>> compiler that does not have accompanying BTF type info stored in
>>>>>>>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
>>>>>>>> guaranteed to  have every BTF type info from application/user 
>>>>>>>> provided
>>>>>>>> elf object file ? I guess there is no guarantee.
>>>>>>>
>>>>>>> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
>>>>>>> rodata.cst32 needs to be emitted, the type will be encoded in bpf
>>>>>>> program BTF.
>>>>>>>
>>>>>>> Did you actually find an issue with .rodata.cst32 section? Such a
>>>>>>> section is typically generated by the compiler for initial data
>>>>>>> inside the function and llvm bpf backend tries to inline the
>>>>>>> values through a bunch of load instructions. So even you see
>>>>>>> .rodata.cst32, typically you can safely ignore it.
>>>>>>>
>>>>>>>>
>>>>>>>> Vincent
>>>>>>>
>>>>>>
>>>>>> Hi Yonghong,
>>>>>>
>>>>>> Thanks for the reproducer. Couldn't figure out what to do with 
>>>>>> .rodata.cst32,
>>>>>> since there are no symbols and no BTF info for that section.
>>>>>>
>>>>>> The values found in .rodata.cst32 are indeed inlined in the 
>>>>>> bytecode as you
>>>>>> mentioned, so it seems like we can ignore it.
>>>>>>
>>>>>> Why does the compiler emit these sections? cilium/ebpf assumed up 
>>>>>> until now
>>>>>> that all sections starting with '.rodata' are datasecs and must be 
>>>>>> loaded into
>>>>>> the kernel, which of course needs accompanying BTF.
>>>>>
>>>>> The clang frontend emits these .rodata.* sections. In early days, 
>>>>> kernel
>>>>> doesn't support global data so llvm bpf backend implements an
>>>>> optimization to inline these values. But llvm bpf backend didn't 
>>>>> completely remove them as the backend doesn't have a global view
>>>>> whether these .rodata.* are being used in other places or not.
>>>>>
>>>>> Now, llvm bpf backend has better infrastructure and we probably can
>>>>> implement an IR pass to detect all uses of .rodata.*, inline these
>>>>> uses, and remove the .rodata.* global variable.
>>>>>
>>>>> You can check relocation section of the program text. If the .rodata.*
>>>>> section is referenced, you should preserve it. Otherwise, you can
>>>>> ignore that .rodata.* section.
>>>>>
>>>>>>
>>>>>> What other .rodata.* should we expect?
>>>>>
>>>>> Glancing through llvm code, you may see .rodata.{4,8,16,32},
>>>>> .rodata.str*.
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Timo
>>>>
>>>> Thanks for the replies all, very insightful. We were already doing 
>>>> things mostly
>>>> right wrt. .rodata.*, but found a few subtle bugs walking through 
>>>> the code again.
>>>>
>>>> I've gotten a hold of the ELF Vincent was trying to load, and I saw 
>>>> a few things
>>>> that I found unusual. In his case, the values in cst32 are not 
>>>> inlined. Instead,
>>>> this ELF has a .Lconstinit symbol pointing at the start of 
>>>> .rodata.cst32, and it's
>>>> an STT_OBJECT with STB_LOCAL. Our relocation handler is fairly 
>>>> strict and requires
>>>> STT_OBJECTs to be global (for supporting non-static consts).
>>>
>>> There are two ways to resolve the issue. First, extend the loader
>>> support to handle STB_LOCAL as well. Or Second, change the code like
>>>       struct t v = {1, 5, 29, ...};
>>> to
>>>       struct t v;
>>>       __builtin_memset(&v, 0, sizeof(struct t));
>>>       v.field1 = ...;
>>>       v.field2 = ...;
>>>
>>>
>>>>
>>>> ---
>>>> ~ llvm-readelf -ar bpf_lxc.o
>>>>
>>>> Symbol table '.symtab' contains 606 entries:
>>>>      Num:    Value          Size Type    Bind   Vis       Ndx Name
>>>>        2: 0000000000000000    32 OBJECT  LOCAL  DEFAULT    21 
>>>> .Lconstinit
>>>>
>>>> Relocation section '.rel2/7' at offset 0x6bdf0 contains 173 entries:
>>>>       Offset             Info             Type               
>>>> Symbol's Value  Symbol's Name
>>>> 0000000000007300  0000000200000001 R_BPF_64_64            
>>>> 0000000000000000 .Lconstinit
>>>> ---
>>>>
>>>> ---
>>>> ~ llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf_lxc.o
>>>> warning: failed to compute relocation: R_BPF_64_64, Invalid data was 
>>>> encountered while parsing the file
>>>> ... <2 more of these> ...
>>>>
>>>> Disassembly of section 2/7:
>>>>
>>>> 00000000000072f8 <LBB1_476>:
>>>>       3679:       67 08 00 00 03 00 00 00 r8 <<= 3
>>>>       3680:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 
>>>> = 0 ll
>>>>                   0000000000007300:  R_BPF_64_64  .Lconstinit
>>>>       3682:       0f 82 00 00 00 00 00 00 r2 += r8
>>>>       3683:       79 22 00 00 00 00 00 00 r2 = *(u64 *)(r2 + 0)
>>>>       3684:       7b 2a 58 ff 00 00 00 00 *(u64 *)(r10 - 168) = r2
>>>>
>>>> Disassembly of section .rodata.cst32:
>>>>
>>>> 0000000000000000 <.Lconstinit>:
>>>>          0:       82 36 4c 98 2e 56 00 00 <unknown>
>>>>          1:       82 36 4c 98 2e 55 00 00 <unknown>
>>>> ---
>>>>
>>>>
>>>> This symbol doesn't exist in the program. Worth noting is that the 
>>>> code that accesses
>>>> this static data sits within a subscope, but not sure what the 
>>>> effect of this would be.
>>>>
>>>> Vincent, maybe try removing the enclosing {} to see if that changes 
>>>> anything?
>>>>
>>>> ---
>>>> static __always_inline int foo(struct __ctx_buff *ctx,
>>>>
>>>> ... <snip> ...
>>>>
>>>>        {
>>>>                int i;
>>>>
>>>>                for (i = 0; i < VTEP_NUMS; i) {
>>>>                        if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
>>>>                                vtep_mac = VTEP_MAC[i];
>>>>                                break;
>>>>                        }
>>>>                }
>>>>        }
>>>> ---
>>>>
>>>> Is this perhaps something that needs to be addressed in the compiler?
>>>
>>> If you can give a reproducible test (with .c or .i file), I can take a
>>> look at what is missing in llvm compiler and improve it.
>>>
>>
>> not sure if it would help, here is my step to generate the bpf_lxc.o
>> object file with the .rodata.cst32
>>
>> git clone https://github.com/f5devcentral/cilium.git
>> cd cilium; git checkout vli-vxlan; KERNEL=54 make -C bpf
>> llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf/bpf_lxc.o
> 
> Thanks. I can reproduce the issue now. Will take a look
> and get back to you as soon as I got any concrete results.

Okay, I found the reason.

For the code,

                 for (i = 0; i < VTEP_NUMS; i++) {
                         if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
                                 vtep_mac = VTEP_MAC[i];
                                 break;
                         }
                 }

The compiler transformed to something like

i = 0; if (tunnerl_endpoint == VTEP_ENDPOINT[0]) goto end;
i = 1; if (tunnerl_endpoint == VTEP_ENDPOINT[1]) goto end;
i = 2; if (tunnerl_endpoint == VTEP_ENDPOINT[2]) goto end;
i = 3; if (tunnerl_endpoint == VTEP_ENDPOINT[3]) goto end;

end:
    vtep_mac = VTEP_MAC[i];

The compiler cannot inline VTEP_MAC[i] since 'i' is not
a constant. Hence later we have a memory load from
a non-global .rodata section.

As I mentioned earlier, there are two options to fix the issue.
First is for cilium to track and handle non-global .rodata
sections. And the second you can apply the below code change,

diff --git a/bpf/node_config.h b/bpf/node_config.h
index 9783e44548..b80dd2b27b 100644
--- a/bpf/node_config.h
+++ b/bpf/node_config.h
@@ -176,15 +176,15 @@ DEFINE_IPV6(HOST_IP, 0xbe, 0xef, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x1, 0x0, 0x0, 0xa, 0x
  #endif

  #ifdef ENABLE_VTEP
-#define VTEP_ENDPOINT (__u32[]){0xeb48a90a, 0xec48a90a, 0xed48a90a, 
0xee48a90a, }
+#define VTEP_NUMS 4
+__u32 VTEP_ENDPOINT[VTEP_NUMS] = {0xeb48a90a, 0xec48a90a, 0xed48a90a, 
0xee48a90a};
  /* HEX representation of VTEP IP
   * 10.169.72.235, 10.169.72.236, 10.169.72.237, 10.169.72.238
   */
-#define VTEP_MAC (__u64[]){0x562e984c3682, 0x552e984c3682, 
0x542e984c3682, 0x532e984c3682}
+__u64 VTEP_MAC[VTEP_NUMS] = {0x562e984c3682, 0x552e984c3682, 
0x542e984c3682, 0x532e984c3682};
  /* VTEP MAC address
   * 82:36:4c:89:2e:56, 82:36:4c:89:2e:55, 82:36:4c:89:2e:54, 
82:36:4c:89:2e:53
   */
-#define VTEP_NUMS 4
  #endif

  /* It appears that we can support around the below number of prefixes 
in an

> 
>>
>>>>
>>>>
>>>> Thanks again,
>>>>
>>>> Timo
