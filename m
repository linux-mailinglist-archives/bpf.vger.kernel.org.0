Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52874AA23F
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbiBDVXB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 16:23:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242184AbiBDVXB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 16:23:01 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214JlqGd026858;
        Fri, 4 Feb 2022 13:22:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Rka6wKrvnSKoGZJyc++i2XuJKQuWQl2tsdczvWL516A=;
 b=aNIBC6YsQyRvBCCynZxb1XkaB0/NjZIXsp7kzSfmGMvXH6HHKc+yMAQnvmWAL1/nyq1L
 Hnn3uUoFGWXNL+Kv8ttWCWFmLlkvDSFBqFOCX1hVLslHPlp3eQhQzkr4gOzquUUH9J7q
 Ge0o0fP8AWMS/u2hzCerVFFfzKNIbtirErI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e0puaf2rf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Feb 2022 13:22:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 13:22:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHDOlMnv5UXIjRjsolqu4B8ocD9dHe7PQ4ZZCJ5PXw+xH3N9GGSf+ZmUZWQhxBanqLZwbP32TG8ThESP9Cq0dxaf3jrQJya4KTA8j8rVXb2hsc47G3ebAX12Okp3KKbWjwRZNy5hPFQ0ayCzP/u69Cm1PiE6ee7NI+sGcb4INqSWpZrxzbWa5brKS2IF1RQROKvWRqa0xYPhywFgS5un0+hkkMCP25ru8ArS6g1s+uu9JnAqdiKc9fRpgQOcdj5UKNEYdVb1Pq09I7SnxDVnotTIZ/vzgDZSoEr4aVT2whErlJwj8EzGRMZy6kUZyUQvxktyo4WcEW60HCKJuRZoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rka6wKrvnSKoGZJyc++i2XuJKQuWQl2tsdczvWL516A=;
 b=d5S1RX5AcGH5YpcYNyp5lRpSpmdgMSOGO5xt5TIoqsPhJXb+zAmWmlf5u3XWJ3pSfSceBNmyzTyagYccEeHpDbO1YOmtQiU3RmO8XXw+6oa4hTQ6+n8dDQllYqdCRFPPCf4EdODUIqtJk/IKpoLLfFWQrKv34mx88RdZpWkiIOqh1Z05N3RH7DZ2LLG640Hjg3OfKXOY/00Jjsv5U4rJW9SzmPvETQYE2ayl099aBaixtVXViZEmX03J2W9xkzBcgO+oNWCn+leJmjKv85ZDwWPcmpGMy2byJGQ1PjgaU1n9iTj2Zg67gT2KOT1wf0L2dJlW/Kl4QOnLzOn+/01rCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1767.namprd15.prod.outlook.com (2603:10b6:910:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 21:22:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 21:22:55 +0000
Message-ID: <5bc02911-9ebf-6f4a-3804-d72c405326b6@fb.com>
Date:   Fri, 4 Feb 2022 13:22:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: can't get BTF: type .rodata.cst32: not found
Content-Language: en-US
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
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAK3+h2zMRNKqA5k6FE4BG8RnJ2Tx1itVJiJGbhXaCu=v=0U47w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:303:87::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a9dce81-7855-40c4-d88f-08d9e8248279
X-MS-TrafficTypeDiagnostic: CY4PR15MB1767:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB17676BC2FAE62368C7460BFDD3299@CY4PR15MB1767.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9mrStxe+U7q8KBwmT4ZMR2Q/dpQcfdZWlT0701vfslzVmHLy60NRBVf0fxosh73HVdfkfwMbPgMD/rzXs38yYV9Cd8B8BCX4+bYgdhMHR5U3Ol1wrz1Jz8yLkiEZroRM+cZZs3F/kuCNkrfhFok5O4RcvB3qI7rtt3uD+fyxrlkBYX42hFbNJWSj1mnrcGX9Lol7hIjyp/etjDAq93K2sgQ2wh12CK+pIBhWc//Yj5F95kxitawXT79rJKh4q8vbhw943tMVfqH+DpKqqsvw2qvOSgI3tiACIEPkRkC248X4aFbpBhhs+A7bogJd33yTqGegiSvcTa1vjdjkkT2ObGwNwK2qOKl1wW1dfqnwCwa1tKEfxZOeLt7R/qlEogS0miSe7fjLvXLfw3Tplf8s2n6i2KutyLFPF7bg7z2Dn+36Y9tQiFEytIkH1ab5ZCigc54ZGnP5dSWCNWuoiOAK+t5VWUvSuiEDIG4vaCoO6OTI8garOrThXUnIS8nwzr4bd0qWIvMSOCz5KB9qK+VFo4ghjSJPjV/bpl7/XchN7GzTqu9doEEyHV//6uchH4X42NTTY8Z51Lpb6x4gJwC2IEdYSzmznGHsZbljYtgJqPqa148bDEukExZj5KVzoqq47iDOoBearFNjNgogALtJzZPpvSmtiNkFXW/d0+UQtFHvzkKbs0KDLHoDOwisNBZg5cfCzT3sZyg38DWkYqISuRRzDS0+u7PG/BqaOz6i5iSxV19Ns7AWGYAWv/9l+D7ojAkxRRCCjwjQ6k/+5gFAhvVsqkT5Uly2ZHwW5PQRBEOpmWg1T1WsnX7T+zSxZ9VXBSJv0HB1QUPn88dsFIMzpG9Vm45reM5P/lOWkvQgk/gGDRWT5Cj+cNNy4gN48LCWCZi53Dxai8UbD+ceFdYRvgTeeW1l5ueWj1tZ1Wbbp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(38100700002)(31686004)(66476007)(54906003)(2906002)(66556008)(8936002)(52116002)(36756003)(83380400001)(66946007)(186003)(4326008)(508600001)(6512007)(6486002)(31696002)(6506007)(6666004)(2616005)(86362001)(8676002)(5660300002)(966005)(53546011)(316002)(142923001)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGl2blN1SmNFK3ZUVmlZTVNoVFhjRlpFeTRoN3hjTWdiWlZ4aEFlV0QyMVh1?=
 =?utf-8?B?YlBMenF2ejh3T0VBbWliRkxjN2JpTklFQ3phaVg4UG1YZDZRUkl2YWpVKzF1?=
 =?utf-8?B?RTRRamV1VVVaOHNsVkVDV2gvVHJ6SW5WMnNZcFVGZ2IyOHJUdHdLdGE2bTY2?=
 =?utf-8?B?R1ZKeDdUZWUveDFSU25LczZWNUhnMmVLdEl2bnN0Z0hsY3B6L0RjZEZDWWJG?=
 =?utf-8?B?NHI0U2plYVQ1MGRPL0NmQlgySXc2ZFpjVE5HbUtaWUpCMUJuOGtBbE9iRmUw?=
 =?utf-8?B?c0tTQi9YaFFiSEQ2ZGdHeDFHbCt5dThVZWN3MUh2QlVNWnB2NHRRRGhlc1Qr?=
 =?utf-8?B?WFJBV1B3QUQ3aGcxamFtNWdLeGlQSGpjZG04Z0xuanF5eWx3MmpaUldiVGtO?=
 =?utf-8?B?c2ltb1JENFVlekwwcFhXa1ZScXprVnA5M0kxRWZNeVJzem92U3B2TEIxdDU0?=
 =?utf-8?B?RzZqc0NGYWlSSVE2VW9DQy8zQlV4aEdnM3pQY2MycHBwLzRkbFc5Snd1K0t5?=
 =?utf-8?B?OEVSdVhyb2twVHZqWW8vV1daTFdvdll4Tjg4RWxoN0ppbHptRWxOSlR3dit6?=
 =?utf-8?B?MWo0REFhcHVneGdza2VXbEQ4WkFJZU9YeG9JMGpLcHBCL2o1TStlK1labmZ3?=
 =?utf-8?B?a240bDZTN3cvMTJzZnBnWW9sK1JGMFg0Y0V1NzdvTWdJUUQ5UGg0cFhFQ05R?=
 =?utf-8?B?QXczVFVLMzJLam8vS1JITitJTWI3ejM1V0NVRlI5c0ZldUdTazJRaDhIdW5Q?=
 =?utf-8?B?YXp4QTliWlltVUpuMWRjdTZQVC9Pekt1SnV4KzM3R2JWcDZuaEJQRlZDVG5G?=
 =?utf-8?B?cUhTaTJwZ2NQVVBmbDNXSDBPaVdkZWNKaHc3MjUvaE4yVzZpcXVwTmpkNW51?=
 =?utf-8?B?NmlBZ2xWUnp5Tmp6OGVPMFA2YmM2c0V6SlRyc01Qa2ppVGI1QWM2VmdTbnBI?=
 =?utf-8?B?OFVjSVRDTWcvcTNJamRZclYxaFM4Q3U3RUFmc2YrZ01hcDVkK0lXSDFmRWZD?=
 =?utf-8?B?MkM5U1dMd09xSkZaT0lsOTZoaUQrNmZLVkRGZkd3eERBVlBKUjJwMEUxTisw?=
 =?utf-8?B?ZFVwdHlFR204YzYxWVVSekFuczh5cmdzSi9IMDRIUHp1ZVdUaTdkNVpMRTdm?=
 =?utf-8?B?UXRnNGc1bldjL2NlbDRSYjA1YVpDS0lzNHFaYi9wVHJGSWFOTHdZSFdYSXJR?=
 =?utf-8?B?Y3JJRkxlVkFqc1pPZ2o1RnEvVU04czl6SWFxOXNjdHEwV1pMdDFvemRicVVj?=
 =?utf-8?B?a2t3SjkwMzdyZk9rOTV6QVBKdjVBclBmMXNvdnVLVXpkM3hhRnF0STBoS29I?=
 =?utf-8?B?dU16ZzZ0aFB3eXBDNUtTemxlVXNpYVByMktnazd4ZkM3SUc3eDhwZFB3aXVp?=
 =?utf-8?B?Qm1DVVB1ajUrV2xrQ3YwaUdpZXg4VVV2VFBpNEV5Y2lpd1B3S3Z6ZEdXNmZD?=
 =?utf-8?B?OExHU3Z1bG8wU0lRYm9Gbnpyai9sWW4wT2NXbTJQVllGTko2NE1JSlJ0U3Na?=
 =?utf-8?B?bW1LUWUwY1lHT1NrRkp3a05NWWdRNnBvdWY1Y1QzeC9LK0Z1cVRGbERSaW5h?=
 =?utf-8?B?SUhZbm9SaUpEYXpsSEFMa1FUVUNFQnl1YldXb1FlMS9KcUtTdFBMOS96L2VY?=
 =?utf-8?B?c0JzeTRPRENYM0tzNVVVdUFKU2IrK3owekRVMGRGSXlRYzMrUFpPVXpJczkr?=
 =?utf-8?B?TzB2SVZOTmF3RmtRNVBLNGVHdnhYUmhVaXAyMmQxRWhRQW5UbHM3OVBlakd5?=
 =?utf-8?B?SGZSb3pvTGg5OUFKSWJzQURiUmVHbUUrZTJOYTVMbUJSOVJWMkRXQzdETk1k?=
 =?utf-8?B?Q0hLVzJvc1hoZC9rWjk3NnhvVFcrU0pJYUNHWFVYTTRZaitLOFNqWXFqZWZm?=
 =?utf-8?B?L2ttOFRUbkVoVlN4MVJEd0VVRGR3YTdRdjhaOXJEejN2a1ZOV2ZBdDFuOGxX?=
 =?utf-8?B?TkNuQlJNYzJTaittTTYrKzhpMnVjLzJ4Ti9PcUYxZHE4cUx0WHo2RG1XRFhV?=
 =?utf-8?B?WjVndzZ1amhHejhBcHpEWjFsNkRURXRBTXdVc0NaRXY3RktXVGV2SHlRTzFR?=
 =?utf-8?B?MlBFTVRqSUh6eFlpakMyVlU2VmhVQmdJaDhCaWl0bmhXVm9ENXdoVmtqaG5w?=
 =?utf-8?Q?3ighwRb27PgBVTmlnLH4wy6SD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9dce81-7855-40c4-d88f-08d9e8248279
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 21:22:55.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTZFNNSeI1/HGFq0fyjYeTGKjxB0wiXkIIAswW8GFtu9GEFF57RFaW3SRpgWAx5l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1767
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: IVeEZ1fMb-6mr9Xb2YPCCDSKVPSKoSbZ
X-Proofpoint-GUID: IVeEZ1fMb-6mr9Xb2YPCCDSKVPSKoSbZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/22 11:39 AM, Vincent Li wrote:
> On Fri, Feb 4, 2022 at 10:04 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/4/22 3:11 AM, Timo Beckers wrote:
>>> On 2/3/22 03:11, Yonghong Song wrote:
>>>>
>>>>
>>>> On 2/2/22 5:47 AM, Timo Beckers wrote:
>>>>> On 2/2/22 08:17, Yonghong Song wrote:
>>>>>>
>>>>>>
>>>>>> On 2/1/22 10:07 AM, Vincent Li wrote:
>>>>>>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
>>>>>>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> this is macro I suspected in my implementation that could cause issue with BTF
>>>>>>>>>>>
>>>>>>>>>>> #define ENABLE_VTEP 1
>>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>>>>>>>> 0x2048a90a, }
>>>>>>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>>>>>>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>>>>>>>>>>> #define VTEP_NUMS 4
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi
>>>>>>>>>>>>
>>>>>>>>>>>> While developing Cilium VTEP integration feature
>>>>>>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
>>>>>>>>>>>> that seems related to BTF and probably caused by my specific
>>>>>>>>>>>> implementation, the issue is described in
>>>>>>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know much about
>>>>>>>>>>>> BTF and not sure if my implementation is seriously flawed or just some
>>>>>>>>>>>> implementation bug or maybe not compatible with BTF. Strangely, the
>>>>>>>>>>>> issue appears related to number of VTEPs I use, no problem with 1 or 2
>>>>>>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
>>>>>>>>>>>> experts  are appreciated :-).
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks
>>>>>>>>>>>>
>>>>>>>>>>>> Vincent
>>>>>>>>>>
>>>>>>>>>> Sorry for previous top post
>>>>>>>>>>
>>>>>>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
>>>>>>>>>> differently and added " [21] .rodata.cst32     PROGBITS
>>>>>>>>>> 0000000000000000  00011e68" when  following macro exceeded 2 members
>>>>>>>>>>
>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>>>>>>> 0x2048a90a, }
>>>>>>>>>>
>>>>>>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
>>>>>>>>>> member <=2. any reason why compiler would do that?
>>>>>>>>>
>>>>>>>>> Regarding to why compiler generates .rodata.cst32, the reason is
>>>>>>>>> you have some 32-byte constants which needs to be saved somewhere.
>>>>>>>>> For example,
>>>>>>>>>
>>>>>>>>> $ cat t.c
>>>>>>>>> struct t {
>>>>>>>>>        long c[2];
>>>>>>>>>        int d[4];
>>>>>>>>> };
>>>>>>>>> struct t g;
>>>>>>>>> int test()
>>>>>>>>> {
>>>>>>>>>         struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>>>>>>>>>         g = tmp;
>>>>>>>>>         return 0;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> $ clang -target bpf -O2 -c t.c
>>>>>>>>> $ llvm-readelf -S t.o
>>>>>>>>> ...
>>>>>>>>>        [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
>>>>>>>>> 20  AM  0   0  8
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>> In the above code, if you change the struct size, say from 32 bytes to
>>>>>>>>> 40 bytes, the rodata.cst32 will go away.
>>>>>>>>
>>>>>>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then
>>>>>>>
>>>>>>> Hi Yonghong,
>>>>>>>
>>>>>>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux and
>>>>>>> stores BTF type info in btf.Spec.namedTypes, but the elf object file
>>>>>>> provided by user may have section like rodata.cst32 generated by
>>>>>>> compiler that does not have accompanying BTF type info stored in
>>>>>>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
>>>>>>> guaranteed to  have every BTF type info from application/user provided
>>>>>>> elf object file ? I guess there is no guarantee.
>>>>>>
>>>>>> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
>>>>>> rodata.cst32 needs to be emitted, the type will be encoded in bpf
>>>>>> program BTF.
>>>>>>
>>>>>> Did you actually find an issue with .rodata.cst32 section? Such a
>>>>>> section is typically generated by the compiler for initial data
>>>>>> inside the function and llvm bpf backend tries to inline the
>>>>>> values through a bunch of load instructions. So even you see
>>>>>> .rodata.cst32, typically you can safely ignore it.
>>>>>>
>>>>>>>
>>>>>>> Vincent
>>>>>>
>>>>>
>>>>> Hi Yonghong,
>>>>>
>>>>> Thanks for the reproducer. Couldn't figure out what to do with .rodata.cst32,
>>>>> since there are no symbols and no BTF info for that section.
>>>>>
>>>>> The values found in .rodata.cst32 are indeed inlined in the bytecode as you
>>>>> mentioned, so it seems like we can ignore it.
>>>>>
>>>>> Why does the compiler emit these sections? cilium/ebpf assumed up until now
>>>>> that all sections starting with '.rodata' are datasecs and must be loaded into
>>>>> the kernel, which of course needs accompanying BTF.
>>>>
>>>> The clang frontend emits these .rodata.* sections. In early days, kernel
>>>> doesn't support global data so llvm bpf backend implements an
>>>> optimization to inline these values. But llvm bpf backend didn't completely remove them as the backend doesn't have a global view
>>>> whether these .rodata.* are being used in other places or not.
>>>>
>>>> Now, llvm bpf backend has better infrastructure and we probably can
>>>> implement an IR pass to detect all uses of .rodata.*, inline these
>>>> uses, and remove the .rodata.* global variable.
>>>>
>>>> You can check relocation section of the program text. If the .rodata.*
>>>> section is referenced, you should preserve it. Otherwise, you can
>>>> ignore that .rodata.* section.
>>>>
>>>>>
>>>>> What other .rodata.* should we expect?
>>>>
>>>> Glancing through llvm code, you may see .rodata.{4,8,16,32},
>>>> .rodata.str*.
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Timo
>>>
>>> Thanks for the replies all, very insightful. We were already doing things mostly
>>> right wrt. .rodata.*, but found a few subtle bugs walking through the code again.
>>>
>>> I've gotten a hold of the ELF Vincent was trying to load, and I saw a few things
>>> that I found unusual. In his case, the values in cst32 are not inlined. Instead,
>>> this ELF has a .Lconstinit symbol pointing at the start of .rodata.cst32, and it's
>>> an STT_OBJECT with STB_LOCAL. Our relocation handler is fairly strict and requires
>>> STT_OBJECTs to be global (for supporting non-static consts).
>>
>> There are two ways to resolve the issue. First, extend the loader
>> support to handle STB_LOCAL as well. Or Second, change the code like
>>       struct t v = {1, 5, 29, ...};
>> to
>>       struct t v;
>>       __builtin_memset(&v, 0, sizeof(struct t));
>>       v.field1 = ...;
>>       v.field2 = ...;
>>
>>
>>>
>>> ---
>>> ~ llvm-readelf -ar bpf_lxc.o
>>>
>>> Symbol table '.symtab' contains 606 entries:
>>>      Num:    Value          Size Type    Bind   Vis       Ndx Name
>>>        2: 0000000000000000    32 OBJECT  LOCAL  DEFAULT    21 .Lconstinit
>>>
>>> Relocation section '.rel2/7' at offset 0x6bdf0 contains 173 entries:
>>>       Offset             Info             Type               Symbol's Value  Symbol's Name
>>> 0000000000007300  0000000200000001 R_BPF_64_64            0000000000000000 .Lconstinit
>>> ---
>>>
>>> ---
>>> ~ llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf_lxc.o
>>> warning: failed to compute relocation: R_BPF_64_64, Invalid data was encountered while parsing the file
>>> ... <2 more of these> ...
>>>
>>> Disassembly of section 2/7:
>>>
>>> 00000000000072f8 <LBB1_476>:
>>>       3679:       67 08 00 00 03 00 00 00 r8 <<= 3
>>>       3680:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
>>>                   0000000000007300:  R_BPF_64_64  .Lconstinit
>>>       3682:       0f 82 00 00 00 00 00 00 r2 += r8
>>>       3683:       79 22 00 00 00 00 00 00 r2 = *(u64 *)(r2 + 0)
>>>       3684:       7b 2a 58 ff 00 00 00 00 *(u64 *)(r10 - 168) = r2
>>>
>>> Disassembly of section .rodata.cst32:
>>>
>>> 0000000000000000 <.Lconstinit>:
>>>          0:       82 36 4c 98 2e 56 00 00 <unknown>
>>>          1:       82 36 4c 98 2e 55 00 00 <unknown>
>>> ---
>>>
>>>
>>> This symbol doesn't exist in the program. Worth noting is that the code that accesses
>>> this static data sits within a subscope, but not sure what the effect of this would be.
>>>
>>> Vincent, maybe try removing the enclosing {} to see if that changes anything?
>>>
>>> ---
>>> static __always_inline int foo(struct __ctx_buff *ctx,
>>>
>>> ... <snip> ...
>>>
>>>        {
>>>                int i;
>>>
>>>                for (i = 0; i < VTEP_NUMS; i) {
>>>                        if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
>>>                                vtep_mac = VTEP_MAC[i];
>>>                                break;
>>>                        }
>>>                }
>>>        }
>>> ---
>>>
>>> Is this perhaps something that needs to be addressed in the compiler?
>>
>> If you can give a reproducible test (with .c or .i file), I can take a
>> look at what is missing in llvm compiler and improve it.
>>
> 
> not sure if it would help, here is my step to generate the bpf_lxc.o
> object file with the .rodata.cst32
> 
> git clone https://github.com/f5devcentral/cilium.git
> cd cilium; git checkout vli-vxlan; KERNEL=54 make -C bpf
> llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf/bpf_lxc.o

Thanks. I can reproduce the issue now. Will take a look
and get back to you as soon as I got any concrete results.

> 
>>>
>>>
>>> Thanks again,
>>>
>>> Timo
