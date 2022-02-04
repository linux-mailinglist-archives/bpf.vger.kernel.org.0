Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ABD4A9E99
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 19:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiBDSEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 13:04:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19120 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231192AbiBDSEm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 13:04:42 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214H74kQ025608;
        Fri, 4 Feb 2022 10:04:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=C+4SrL4Y8BEM+pjWlBpyXPlzA/nEdGkK/pWkFIVKzrE=;
 b=oD6JDN73yoClG2mL2vptvaP7KG8hqmKOLsrM863In2d8os0mGqbq1iQMRpVvboy9mW8b
 uTC6qeWN2A5UfSe65bhs55K8S74fsCNqIdu4cYuYhzBBaFvudPDrMhaTK3KYyuetcxLJ
 6baeWFfkNYXaI+AUFaIi9WCYbbXMU4d6ZWY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e0cvd28wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Feb 2022 10:04:39 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 10:04:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1bXn2Ul+Rss61faF750K6KksBU0KZm+ItXxh9JhPv3cPmXngvfq5w8kESZaydjg/e7FFuxSkvcO17yT+oxgDUy4lFV96wVNZdinNHct1DtTukon3Jbrc+KTNjYqroPDJS9sQPIJYcInqBpKkNg3tyWhHHQuME5+AKTAbVWS99M9pPeEUhIrpmc+t/qpFCtDd8jxx4RE4Fk9BmAsuD5I28X3vz4Qkvb+EFmXkFFFUcN0J9FqlnqS1rwJLFSUicCLhQ5eaidV75s7LIg6AVfG3dxTEjMlazBxdMb/oBV9PsOJR0gsBo5l+ICj5rS15Jry/1wTTt1yMSLKJ9gwnr1SaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+4SrL4Y8BEM+pjWlBpyXPlzA/nEdGkK/pWkFIVKzrE=;
 b=SXQ+a7nloJ4WB8b4zXSuE/fS195qFMr8vrAfyEoCQrm8UnIsnNnQv4lRhuU1jcBu8pegINW8kyHjRZ24MD46kvSuKUcu5qqFQRGC2ZJ6QvNS2SHsq9AaQ1TwjUScops/M4i8bqtqslnzJLI61mmALuMLIE3wExYx8f3gv9T//fe2uFvo9LV5w/GLdmWwGt21fqXVNTQzPm4W54Cs5gUptAJAqf/l5pv6AoZnEv5T8Qu2BlVxsQoUtSWFbjS5QScMClTruxFSFZg/++zQnU5h8yglUEEW83oseGQWXSxel1r7DZQ21aote37EvKf1eaBUa+w1U+y/djwewoH3rsXuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB4946.namprd15.prod.outlook.com (2603:10b6:a03:3c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 18:04:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 18:04:37 +0000
Message-ID: <b33e24d0-3539-3c7c-8be0-7d9ea335b28d@fb.com>
Date:   Fri, 4 Feb 2022 10:04:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: can't get BTF: type .rodata.cst32: not found
Content-Language: en-US
To:     Timo Beckers <timo@incline.eu>,
        Vincent Li <vincent.mc.li@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
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
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <24b0f506-00f5-77b9-dff8-9a1db8aaa1c5@incline.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27173334-f6dc-47aa-d05d-08d9e808ce57
X-MS-TrafficTypeDiagnostic: BY3PR15MB4946:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB49467D64C09102ABA6307DBFD3299@BY3PR15MB4946.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBn+gv4GOa/BHVsC7rRQfoI+2hdiehyJ0UhHppujtDUmCsjdxEhvG7FUf4+7nyWMt0sSBVP+PZXgcVJE0htOlz7hhgo4U7bOespPOMqYiZ3Ff/KPxFUuYIb/ieZ14bLD6McAeg/PSgeFzfrNCEBc69wK6vyCrb8fSCt8MXfNyPalU00EEKC7Jy3z1AQngfkYeRySPB6xSHishHQ17mHw+g+Yp3ijI98IgUwmIIQsBrAWtYS8zFXUEv4R7Gzhl1xrKE1S0zd+N829oyyD7NakTUIdtwX7iRgGq0kN+t3OUKVLxEWgBbgH5oHscMQcyDNsOhSFeo/wo0tQ1gek7Y2UTYlJuk1BSoCaV0rB4ZlI0K+KrNkzr88OT3pJbXE4LSgrb85sDFumQ9IEji+NBP+6GM0/6MhUu9/AIeFTBoxVZr6sWjGIEzq9sWNb9e9BtQu3ZdqlakoHBKjkq1M4FMngHupLJw9mI3lXW7s84ev0AxJ7kgTG8OE/AzNwv6zYz/Le6QCGt+3mqi8Jw4vxnNLP0tgHg9wBrwm33IS2KwLuxZEcl2lRhEYyLgBMZCvlOW8HaCgCR1Mjy68VvyppSF+dOLTBaTtqMnYcYTlm5PLxF/y/heSSo2W0igTiLPUqrwx8sBrDydjtc/ExAi8u725iJmuE5Jbf3ahPnF1lc3HTawMxpHqhhdTPW838fYlYhbuv/AnH6z+8sfJ3t0htGbMIJ6XSgDsoYoCV5Ih2obRp5CcGFVPEn92HBNNOO65E9oES1Dyaa40gwu4FORLp10ZNR06uOlyDP7SKkS6jVwhdyqKzT6Yra0jqmvLk0qeYFaN6auYhCnVwDdD4vO4m6pqHbfQB+LswBfGnAIMwluEZ7Kvh6dHlTyU/2GZflcFlZ9XtG01tpv4+SHS0Yo2thGr01qop/EPOuKwen5VRkPY+klA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6486002)(6666004)(83380400001)(5660300002)(52116002)(186003)(53546011)(2906002)(36756003)(6506007)(2616005)(508600001)(38100700002)(66946007)(86362001)(31696002)(316002)(966005)(66556008)(66476007)(110136005)(31686004)(4326008)(8936002)(8676002)(142923001)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enc4QWU1bWltaDczSGpjckdtcWZKRXRQRDJkNFNVbWk2b0crNTg1V21OQk1B?=
 =?utf-8?B?a0tMZ25ESDlETXpncVZmM1duZmFhNmdtMnoySU8wdGQ0Ym1YYm5RclFCWGRS?=
 =?utf-8?B?REUxKzlWMHZHM1lLY1R3SnRFQmozVGdFWjRxdE1YbXZiK3RYdVd3dmY2eEtI?=
 =?utf-8?B?cmR4YnFaNm9CeDNVcytOZlR4VERzZG5hOGVlSFUwRllIMjVlSWZVNWtzdUNu?=
 =?utf-8?B?RExSMG1GR1pIUGNCTWlDdm5CcDJQV3NJT2szdndPd3ZUUkd1djl0bGRoTCtl?=
 =?utf-8?B?ekZqRlM2U2N2S0JGMHU4NEErNWxublcwT2dIVXMzVHBYOXVLbExwc05TdFlN?=
 =?utf-8?B?Tnd0MkZmZkJRL05lcDhSK1B1OEE5T1l6aGp6TFFDKzRHYjd1bTZITytzZEFB?=
 =?utf-8?B?N3dSQk01c3E0bmdpcmJ0bHYzZ2RnU0xwRDdjY05iWGJOU1dqUmJ6VXNSNEZH?=
 =?utf-8?B?OXdxU0VBT1QwUDQxV2JJWmRlZG1oZ0VteFlKZDlTNzRwUmdmR1BjQ0ZTOFo4?=
 =?utf-8?B?Tzd6YzFSSGRLNFZNZXZuelM2dmQ2MzdoTjNEUmczdGlTZlV4Tjhna2lOUHh1?=
 =?utf-8?B?K25vQjVYS2Ryb3g4YzVqVmJ6UUtvV21CWjIrYmRVZWN4eDM3Y0NLV21XUms5?=
 =?utf-8?B?VGc2Z3RUOE10QUx0cWZ0MytIWW9QODFuVCtEYm94b3VZUHk3WTZjYjJSTW8v?=
 =?utf-8?B?QVdlemgrMC9OVlVnNmt3UFpKN3hESTdzczJUSjlNQW9xd2JmS2MzZkFIVllW?=
 =?utf-8?B?bWVjVWtCdEdIM1F3T0pOZmtuUDBQNEJ6TnpEdlFjeE1YZ0tCWHVuWHB2MG9H?=
 =?utf-8?B?cUFkNzN1c2QxbVhyK3d6dXBzSDZpbWFKUGFWOFRTTWlwQ29Wd2N1YnE5cmdw?=
 =?utf-8?B?MjJwKzI3VFdkbTMySFdiREJYS1AxNmRBaXJTMDVNUHhuZUJOQURvZ2FFSEJU?=
 =?utf-8?B?UnB3WlZRa0l6UXBBeFZtaWpUL2hFdzBybzNKR2phVGZRWEtjalR1M2daQ1BX?=
 =?utf-8?B?Q1o3eVEvcDI4WXV5TDlsT1BGT0NHOVJYTzNNRjlFWlRNeHg2MHlyYU1RamRz?=
 =?utf-8?B?REFlend6S1VIU0VtanZDVVFKRDAvRHdONURhV24vTGQwQnErdHZwMjQybzRF?=
 =?utf-8?B?WW5jRWVJN0d1Y3FveHNjSVN0eFN1V0ViMDF1M2FHdEZaYjZCVTgxRDlobzdE?=
 =?utf-8?B?UHpoN1liVDkzeGFDQlUvaEhYOUpsRXBFUks0NGJ2S1VmQTJSbmUrWDBFbTJ6?=
 =?utf-8?B?ZWhzNDZPeXpEUEI0blNVZ21keWRyZmUvVzBjY3NTanFvdk1PVjlYQlM4MHlH?=
 =?utf-8?B?UFR0SXRILzJFWVI2cWRoZCtMNHlCZzg2QW1VbzFNUXdLT2pSWk9idE42di9H?=
 =?utf-8?B?b1BBM1NiaVpQTnN1Zzk5Q1BVVXd6cnJQcHpaNTRpdGNQMlppM2oyVmtTanh3?=
 =?utf-8?B?SHZnMWo3R043emZBVGdYZlJRMXg0dDlHVExmc3U3cnRrcGRWV1IrR3o3eEhS?=
 =?utf-8?B?S1dza24zaDFyaDNNWUtiVVFCamV6dC9WelpTY3hWUHBGS3BMcmpiV0JYN3V1?=
 =?utf-8?B?dS9KNHIrSnJqK3hHT2ZnM1JQOXhVRnpxT09KTk15ditqTFRwRmU4NTQ4Z1Bp?=
 =?utf-8?B?OEhwb0JzQ0xLNEE5N3doYzhtMVkzZUJFOWxZVnhTd0pJaWF5eng0MFZDQm9v?=
 =?utf-8?B?cE55bG56V0ZIQ3pYWjErV2t3OGQvWndiSjRHNTdsUzRiaWszUUUzck5DaUlE?=
 =?utf-8?B?V09mWmM4NWUvRkY5NXRuQ3Bxc2hoSHRYMjZtam5zNUtDell6SjBiTnJTZUda?=
 =?utf-8?B?Q1p0S0ZxeVlaS2RjSFFDQWIzTGdlMlJBNEc2MGQzZzJha1V5LzE4MkxCQy8x?=
 =?utf-8?B?dGkxdS96UDFFNDI2Ui9xZ2kwRnlHT1RZUnpqZnpyNHl1V1J4bUVnZ3REK3M2?=
 =?utf-8?B?K09yd0hCRGU5aEs2T3A0QUtja1MyYng2RFBNQitDbWNiNG5sdzhEbjFRbExi?=
 =?utf-8?B?RlBObkZyV1dVL1JwZjliZWQwQVZMK1ZEMkRjMURscDdsc0hUcVhFOGF2dkw1?=
 =?utf-8?B?aVpJQU5NY2NmMlo4VlhSWEl4cVNEdFJlL25mUWRWNHNYbitXa25aVXBLMitL?=
 =?utf-8?Q?KENcnGn9QzDAhvtO20SD2BId/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27173334-f6dc-47aa-d05d-08d9e808ce57
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:04:37.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugNvyiczS4jHXVIeSsYcHn4tJVZRzB4Opxv3E99sUQbfYGT3FXnob7L1otXjB5de
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4946
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: thSbt96MlbwKZyzFCg0Ww1MLWkvL0Tue
X-Proofpoint-ORIG-GUID: thSbt96MlbwKZyzFCg0Ww1MLWkvL0Tue
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/22 3:11 AM, Timo Beckers wrote:
> On 2/3/22 03:11, Yonghong Song wrote:
>>
>>
>> On 2/2/22 5:47 AM, Timo Beckers wrote:
>>> On 2/2/22 08:17, Yonghong Song wrote:
>>>>
>>>>
>>>> On 2/1/22 10:07 AM, Vincent Li wrote:
>>>>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>
>>>>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
>>>>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> this is macro I suspected in my implementation that could cause issue with BTF
>>>>>>>>>
>>>>>>>>> #define ENABLE_VTEP 1
>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>>>>>> 0x2048a90a, }
>>>>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>>>>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>>>>>>>>> #define VTEP_NUMS 4
>>>>>>>>>
>>>>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi
>>>>>>>>>>
>>>>>>>>>> While developing Cilium VTEP integration feature
>>>>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
>>>>>>>>>> that seems related to BTF and probably caused by my specific
>>>>>>>>>> implementation, the issue is described in
>>>>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know much about
>>>>>>>>>> BTF and not sure if my implementation is seriously flawed or just some
>>>>>>>>>> implementation bug or maybe not compatible with BTF. Strangely, the
>>>>>>>>>> issue appears related to number of VTEPs I use, no problem with 1 or 2
>>>>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
>>>>>>>>>> experts  are appreciated :-).
>>>>>>>>>>
>>>>>>>>>> Thanks
>>>>>>>>>>
>>>>>>>>>> Vincent
>>>>>>>>
>>>>>>>> Sorry for previous top post
>>>>>>>>
>>>>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
>>>>>>>> differently and added " [21] .rodata.cst32     PROGBITS
>>>>>>>> 0000000000000000  00011e68" when  following macro exceeded 2 members
>>>>>>>>
>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>>>>> 0x2048a90a, }
>>>>>>>>
>>>>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
>>>>>>>> member <=2. any reason why compiler would do that?
>>>>>>>
>>>>>>> Regarding to why compiler generates .rodata.cst32, the reason is
>>>>>>> you have some 32-byte constants which needs to be saved somewhere.
>>>>>>> For example,
>>>>>>>
>>>>>>> $ cat t.c
>>>>>>> struct t {
>>>>>>>       long c[2];
>>>>>>>       int d[4];
>>>>>>> };
>>>>>>> struct t g;
>>>>>>> int test()
>>>>>>> {
>>>>>>>        struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>>>>>>>        g = tmp;
>>>>>>>        return 0;
>>>>>>> }
>>>>>>>
>>>>>>> $ clang -target bpf -O2 -c t.c
>>>>>>> $ llvm-readelf -S t.o
>>>>>>> ...
>>>>>>>       [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
>>>>>>> 20  AM  0   0  8
>>>>>>> ...
>>>>>>>
>>>>>>> In the above code, if you change the struct size, say from 32 bytes to
>>>>>>> 40 bytes, the rodata.cst32 will go away.
>>>>>>
>>>>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then
>>>>>
>>>>> Hi Yonghong,
>>>>>
>>>>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux and
>>>>> stores BTF type info in btf.Spec.namedTypes, but the elf object file
>>>>> provided by user may have section like rodata.cst32 generated by
>>>>> compiler that does not have accompanying BTF type info stored in
>>>>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
>>>>> guaranteed to  have every BTF type info from application/user provided
>>>>> elf object file ? I guess there is no guarantee.
>>>>
>>>> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
>>>> rodata.cst32 needs to be emitted, the type will be encoded in bpf
>>>> program BTF.
>>>>
>>>> Did you actually find an issue with .rodata.cst32 section? Such a
>>>> section is typically generated by the compiler for initial data
>>>> inside the function and llvm bpf backend tries to inline the
>>>> values through a bunch of load instructions. So even you see
>>>> .rodata.cst32, typically you can safely ignore it.
>>>>
>>>>>
>>>>> Vincent
>>>>
>>>
>>> Hi Yonghong,
>>>
>>> Thanks for the reproducer. Couldn't figure out what to do with .rodata.cst32,
>>> since there are no symbols and no BTF info for that section.
>>>
>>> The values found in .rodata.cst32 are indeed inlined in the bytecode as you
>>> mentioned, so it seems like we can ignore it.
>>>
>>> Why does the compiler emit these sections? cilium/ebpf assumed up until now
>>> that all sections starting with '.rodata' are datasecs and must be loaded into
>>> the kernel, which of course needs accompanying BTF.
>>
>> The clang frontend emits these .rodata.* sections. In early days, kernel
>> doesn't support global data so llvm bpf backend implements an
>> optimization to inline these values. But llvm bpf backend didn't completely remove them as the backend doesn't have a global view
>> whether these .rodata.* are being used in other places or not.
>>
>> Now, llvm bpf backend has better infrastructure and we probably can
>> implement an IR pass to detect all uses of .rodata.*, inline these
>> uses, and remove the .rodata.* global variable.
>>
>> You can check relocation section of the program text. If the .rodata.*
>> section is referenced, you should preserve it. Otherwise, you can
>> ignore that .rodata.* section.
>>
>>>
>>> What other .rodata.* should we expect?
>>
>> Glancing through llvm code, you may see .rodata.{4,8,16,32},
>> .rodata.str*.
>>
>>>
>>> Thanks,
>>>
>>> Timo
> 
> Thanks for the replies all, very insightful. We were already doing things mostly
> right wrt. .rodata.*, but found a few subtle bugs walking through the code again.
> 
> I've gotten a hold of the ELF Vincent was trying to load, and I saw a few things
> that I found unusual. In his case, the values in cst32 are not inlined. Instead,
> this ELF has a .Lconstinit symbol pointing at the start of .rodata.cst32, and it's
> an STT_OBJECT with STB_LOCAL. Our relocation handler is fairly strict and requires
> STT_OBJECTs to be global (for supporting non-static consts).

There are two ways to resolve the issue. First, extend the loader 
support to handle STB_LOCAL as well. Or Second, change the code like
     struct t v = {1, 5, 29, ...};
to
     struct t v;
     __builtin_memset(&v, 0, sizeof(struct t));
     v.field1 = ...;
     v.field2 = ...;


> 
> ---
> ~ llvm-readelf -ar bpf_lxc.o
> 
> Symbol table '.symtab' contains 606 entries:
>     Num:    Value          Size Type    Bind   Vis       Ndx Name
>       2: 0000000000000000    32 OBJECT  LOCAL  DEFAULT    21 .Lconstinit
> 
> Relocation section '.rel2/7' at offset 0x6bdf0 contains 173 entries:
>      Offset             Info             Type               Symbol's Value  Symbol's Name
> 0000000000007300  0000000200000001 R_BPF_64_64            0000000000000000 .Lconstinit
> ---
> 
> ---
> ~ llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf_lxc.o
> warning: failed to compute relocation: R_BPF_64_64, Invalid data was encountered while parsing the file
> ... <2 more of these> ...
> 
> Disassembly of section 2/7:
> 
> 00000000000072f8 <LBB1_476>:
>      3679:       67 08 00 00 03 00 00 00 r8 <<= 3
>      3680:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
>                  0000000000007300:  R_BPF_64_64  .Lconstinit
>      3682:       0f 82 00 00 00 00 00 00 r2 += r8
>      3683:       79 22 00 00 00 00 00 00 r2 = *(u64 *)(r2 + 0)
>      3684:       7b 2a 58 ff 00 00 00 00 *(u64 *)(r10 - 168) = r2
> 
> Disassembly of section .rodata.cst32:
> 
> 0000000000000000 <.Lconstinit>:
>         0:       82 36 4c 98 2e 56 00 00 <unknown>
>         1:       82 36 4c 98 2e 55 00 00 <unknown>
> ---
> 
> 
> This symbol doesn't exist in the program. Worth noting is that the code that accesses
> this static data sits within a subscope, but not sure what the effect of this would be.
> 
> Vincent, maybe try removing the enclosing {} to see if that changes anything?
> 
> ---
> static __always_inline int foo(struct __ctx_buff *ctx,
> 
> ... <snip> ...
> 
> 	{
> 		int i;
> 
> 		for (i = 0; i < VTEP_NUMS; i) {
> 			if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
> 				vtep_mac = VTEP_MAC[i];
> 				break;
> 			}
> 		}
> 	}
> ---
> 
> Is this perhaps something that needs to be addressed in the compiler?

If you can give a reproducible test (with .c or .i file), I can take a 
look at what is missing in llvm compiler and improve it.

> 
> 
> Thanks again,
> 
> Timo
