Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E24A6C37
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 08:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiBBHRt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 02:17:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236152AbiBBHRa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 02:17:30 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2121ftaO019089;
        Tue, 1 Feb 2022 23:17:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0wO+iNZQyuxohmNgUcRPWkrOKzLxL71V8uH3D3c9qng=;
 b=Mry9nplc60zlDvlp+PxL0w73iUJYZjD3RBIefHgvs43BLhxjIVnc14gL3ynCLK/88IXM
 DMbVTfHuySY9cww+3zfgrOoIsgo57TuXQE55U4wIcYBfjwUXksHdeTEm4GPeOoz/39ek
 jZAWfIJLwWKItXLK9t79KhOjYbuCjuyEtZk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dybqp2u4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 23:17:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 23:17:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmDW1D+zOmy8LuQ43L8d9k5NM2AjF4K/LXCMzTnU/cm5UNHceyd97wc56QbKxUWc41tCFZc+xyZ/0sIWQwo3jsJE0/2Uqt6lKa1kBmYAXB5Chag3h53x2Dn5WrQeFZvTnn7xNlQO3q+LiZaEkgqub2Uxvzn0L+CtW+F8ecEVtBvv7lvFo+3czZFvYbNgrHhQGIAZs4tuAI4CMXdFSauUlRYkY9LtnBNhG4bsvDUSb7VNgykkjcQPBvEnYAL93vL+2ffUODT2CReKyrUTypTVYg23GrXoDVj2dWqjnveR65kigbmwWbk1CIJvTDew3RAd0+3lZ6A0P5WfvJsMKt3hEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wO+iNZQyuxohmNgUcRPWkrOKzLxL71V8uH3D3c9qng=;
 b=YmqYK8YoJZaEm61q7WsYteApnWiq4Ezri6UaVZhoazjTAs4LBC75fBFlZB2hZI0T8uDa2RcqoPqwL0mJQc63Zn1Y+xCYkhyAfHqceSPCBMxQ5nREHerhwxcoxlZ3jjNbUPcsa7KbeQYc9wGNCc1DA3raZaVlMMq+lR/R87+knLtSmoJJ7jj5wRVnqElrFyNjQGUVQO/9t302cn30C6kjVddsb0gCG+vw+si8md0gn8SUVb8L//cZ7sVLc8Cn+OJpPOmRiObt0fsN3tpAHmBjaDFuwUuLikuA2TWNCoO0X8pvae5xZ5uKSNWem0H6Rr2xkDFzhNBkItdGC2PHBquCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3892.namprd15.prod.outlook.com (2603:10b6:208:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 07:17:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 07:17:26 +0000
Message-ID: <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com>
Date:   Tue, 1 Feb 2022 23:17:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: can't get BTF: type .rodata.cst32: not found
Content-Language: en-US
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com>
 <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
 <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:300:ae::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c626045a-335a-43cf-5e7d-08d9e61c10cf
X-MS-TrafficTypeDiagnostic: BLAPR15MB3892:EE_
X-Microsoft-Antispam-PRVS: <BLAPR15MB3892D01A41238A5DCA240E65D3279@BLAPR15MB3892.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eduL4LTFlUoq86tXW4UHulUIkttCXkqEUmNmHysmYb/Ijq+V3ZfZjfy+pV7kYtsWMzXPRvvEIIPYY4K4arT0l/bEP5KxYrY80yoor7i8fgpUXS0fZ4e0x85z6GWbvPHrwH0tGo9S/CKnQHL1tfS0gK0+yWPiMes0pOTVGliwZ+Z6gaA3pARHJnQ+14Ebhczj1d4a3vMzSBVPddRqCulg1SeQ/0jn7H1Y7kvuEQ040tMy8XHUO7G63lgiZPD++n6mOhDfJYbNRuqj2DnPFT20pl+58ehxpZMrV5pBq6OAzns90xQIk6nPxLjZz/i7NxL6XYfJIRcNkgypmq1BvPc1MzcJnADseBi+f+p8UlRY+UcJk0YaU7OXfM6iglplGEb8zpkG/RrWXv7xF7a1316gUCqSHP9lpZaNPUdg0l4vuqPpYSu53tZVuDD6pVzBoZvuFJpxIoCya+HUCyECnNDLMPE+GR6/gdtiVGaq91ZYpMXR9oVAMJoLI796g5VM4ZfZsZf4eRdEJ8NpWnGKVE+HfP51c1n+wUgt5IuNW0o+LmazA66drTNSKZZKxpJofEr5ijxgY8sGTmYvOVk95xdQKU+lulZrJ1TXGWed3fVQnrx6MT5KKYWNmViAEt4r1qj7Spr5eqx1Xf/rz2xAH30geCOvDaj+Y7UWhuL7s8f4VcJbvKGw7Zz1Gcl3pfX9Qy735OjbrqFHcdqRMNEBCZv+6KLlksdtP31vgeMK2Mlf+S6RwcS3lkre8hBSHzyoCVlQb+U/6imQoEYkhSY67RfPb/wr2WRkWxcuCYj9tSxoiur53XnVd3H7rQ4QA6kUTUT0J//PTqzHnUGTXfQBkpUZ+sxHAwtxrvO/OIl+2Azj02tU7xs36YzMT6nlTMw/bKDF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(5660300002)(36756003)(31686004)(83380400001)(508600001)(8676002)(66476007)(66556008)(186003)(2616005)(52116002)(6666004)(86362001)(31696002)(6512007)(6506007)(53546011)(2906002)(966005)(6486002)(8936002)(38100700002)(4326008)(66946007)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUt1WGtTWDV1UjQ2d251R0xtU25ZcDAxY0ZoYkRlVmluS1d2VXEzbDhNcURr?=
 =?utf-8?B?RW5aaEMyQXRVK0xVTTAxR3F0b2pTenNmNWR5YTBvUzFLdjdSR2paZkNEck42?=
 =?utf-8?B?TDhCM0FsMTAyWG52bFZnZ1dveURjZ09vN3F3ODRxSjBuaGJXenZTNU9tY0th?=
 =?utf-8?B?bTdlaEZ2V0xFRlZRaUZvWDh0Unl1cCs4NjNwVVZVUGcwcGFmeTJDMGFGQnJN?=
 =?utf-8?B?TjQwL01oUVNaSkhNUjQ3czgwZ296V3ZpMUszQUs3ZmtVLzVTNFRveFp6K0pW?=
 =?utf-8?B?aXdlUS9GWjVtUHFSSkdGRHMzUHJqcGh3UlNUUFEyQzdDTHBEdU5OclQxc0FL?=
 =?utf-8?B?WHdJdFA4KzUza2dLbVBub08wVHFxQUpXM0RWVnlGdCtIL3BXcDFtUUo4Ujlr?=
 =?utf-8?B?K2xUTmx5SEdQcy9VQURVUjlhZUhCOE0zcTZHMDR5RHRzQXRCNFJ1R1M1aWs4?=
 =?utf-8?B?SlFiTW5Qcm5GK0tTV1VlNVAwdGtwdnZUZFd3am5NMWdMRXJlSGdKK1NCTE5o?=
 =?utf-8?B?NkhSaElJNDFmYVRIcnNHUUNVbk90aFBhUHcvMHFxYjRtbFB3RkZ2K0tnZkRS?=
 =?utf-8?B?WStjd1ZCNzFna2hrUStXWW1kR2h4aXRzNi9zRXRtbXV0YjA0bVhzc1Q2bVc3?=
 =?utf-8?B?NFYxbnVoS2dmMWhhckRpUTZUR1AyUEJqbGl3WWQvRHAzVlNmSnZyd1FNalhW?=
 =?utf-8?B?OUU3VHdkWmhIMjV4Qnl0Z3d4b1lSOUl2VlhuVWRWeGZ1Vm9XMktFanlmSmFo?=
 =?utf-8?B?M0VxbU9lTzBpeHA4Lzd3a3BLY2hNbXZPZVBFTFp5cVFwTFNZc2h5REdxRUw5?=
 =?utf-8?B?UzNReWFqSTZDOGJJWGROZWY5dFZxK21ZT1dyMWIvL3k1ejJkeVluRVcxNjhr?=
 =?utf-8?B?aWw1bWZqT1BPTTBKY20wVHEyb01PZHhCVEkzMnc1WHY0aTBuUWxoV241TE1W?=
 =?utf-8?B?V1h5M3FOWldXWldNTWkvRHhlaUJLc3BMUitEMkc0Y09BSUhhdjBoTC84N1Ro?=
 =?utf-8?B?MEVSSURLenBxL051dUhmbG8xUXVQZzBXVG5veklMc280dVdpajFUTEoxRCtz?=
 =?utf-8?B?enk5OXExSUZoWGJ0UVRobmh3TlAxTklCVnhBS3FsVmJiSTlYUTkwWkVLVGdv?=
 =?utf-8?B?a1d2eWNjRC9ybGEvbURJZE16MDVhdFQvTnJyRzc1ZFhuQ3ZOU2VQZjEzL0tt?=
 =?utf-8?B?QkhBcUdsUkUybmlSYVduUTBPNGI3TWdJNnN0eXRVUkR6S0VTdUpGVzNLa3VR?=
 =?utf-8?B?cWd2bDVBM1V5RnVzVUd4T2RrbkR0d3FpQjIranRTTmIwWFhZT2FaQmR4WDFP?=
 =?utf-8?B?dWdqWjFscy9OVy9lTkJtRy84dHpIbFN4T242TXZQcmFnQklVeXpFOXNEeEZH?=
 =?utf-8?B?WDVmRXNYdWI3SFd2RDUwZ004Y2RndFJMRm1XdFVzK3VtOXZPcmRrUDRTMXRL?=
 =?utf-8?B?MzNrbUNPZFJidlh1a3BqQkZOZFJEUlhYd2w3SlUvTERCWlRCN1h2cVVvSUxi?=
 =?utf-8?B?U21NeDlHR2ZTdmdReUp4bEdocUt5OEcxR2tiNHdKdW5kV3h1Q1hnMmMvYlVp?=
 =?utf-8?B?YU11WWtuNC9SeVpnUCt6NUNhMGQ5VmtubmdzNmIxR3hGYnlQd0NTV0VQVVcw?=
 =?utf-8?B?K2FrSmJFU0x2V0hUeHVpRFRvek5QRUE5UWRWWEovTEZaN0RNOWl1eHc0SU9B?=
 =?utf-8?B?SlJybFJPZzgyb2VsSU9kRkVKK3dzOUJCTXNldW5wU3A4enF2RzdxZ2gxNTZB?=
 =?utf-8?B?VExSZ2EwQXVaQXpEYWt3UUxTdzk4VkgyKzRKTHo4emNYMVFNa0w4c3hTQzVu?=
 =?utf-8?B?bE9KZ3BWL2hZQmVhOXhqNTYyRGpzc0RyOXNnZ3Q0WVlRdFVLZDJxOC9DaEFi?=
 =?utf-8?B?WUhER0FnRk55eEpGSU03amxPdm9xQnMzM3pZcHpUeDlMK0lQTVJSRVZqdHBY?=
 =?utf-8?B?eXBpQ2t2enMrUWdoM1EyQzRaakp5ZFMrLzhJUzdBRE9acy9HOFpDVG1IUjNy?=
 =?utf-8?B?T05NL1pmbFh2aGxyc0I3NWZDK3NiSjJoanJCdEhVc1JEMkYxeW9lSmw3R21B?=
 =?utf-8?B?d3dCUXNFb1dhUUVtMlVjeWxISjdjcmF0bDBLaThLNzVjMENLWXhkR3FudHh2?=
 =?utf-8?Q?D5XgTPRhvxeHb9Q8Xqt5OoW80?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c626045a-335a-43cf-5e7d-08d9e61c10cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 07:17:26.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z3Fz7hMzDssxtvLl1g72HXuXDhMWkl/9UR/L87Oj7gBk9yPKjLpw8M50KdDY5fb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3892
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: fTrLIyG83Qm9adxHLF6sNZJJu3yOcLqK
X-Proofpoint-ORIG-GUID: fTrLIyG83Qm9adxHLF6sNZJJu3yOcLqK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_02,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020036
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/1/22 10:07 AM, Vincent Li wrote:
> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>
>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 1/25/22 12:32 PM, Vincent Li wrote:
>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>
>>>>> this is macro I suspected in my implementation that could cause issue with BTF
>>>>>
>>>>> #define ENABLE_VTEP 1
>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>> 0x2048a90a, }
>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>>>>> #define VTEP_NUMS 4
>>>>>
>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>
>>>>>> Hi
>>>>>>
>>>>>> While developing Cilium VTEP integration feature
>>>>>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
>>>>>> that seems related to BTF and probably caused by my specific
>>>>>> implementation, the issue is described in
>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know much about
>>>>>> BTF and not sure if my implementation is seriously flawed or just some
>>>>>> implementation bug or maybe not compatible with BTF. Strangely, the
>>>>>> issue appears related to number of VTEPs I use, no problem with 1 or 2
>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
>>>>>> experts  are appreciated :-).
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Vincent
>>>>
>>>> Sorry for previous top post
>>>>
>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
>>>> differently and added " [21] .rodata.cst32     PROGBITS
>>>> 0000000000000000  00011e68" when  following macro exceeded 2 members
>>>>
>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>> 0x2048a90a, }
>>>>
>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
>>>> member <=2. any reason why compiler would do that?
>>>
>>> Regarding to why compiler generates .rodata.cst32, the reason is
>>> you have some 32-byte constants which needs to be saved somewhere.
>>> For example,
>>>
>>> $ cat t.c
>>> struct t {
>>>     long c[2];
>>>     int d[4];
>>> };
>>> struct t g;
>>> int test()
>>> {
>>>      struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>>>      g = tmp;
>>>      return 0;
>>> }
>>>
>>> $ clang -target bpf -O2 -c t.c
>>> $ llvm-readelf -S t.o
>>> ...
>>>     [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
>>> 20  AM  0   0  8
>>> ...
>>>
>>> In the above code, if you change the struct size, say from 32 bytes to
>>> 40 bytes, the rodata.cst32 will go away.
>>
>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then
> 
> Hi Yonghong,
> 
> Here is a follow-up question, it looks cilium/ebpf parse vmlinux and
> stores BTF type info in btf.Spec.namedTypes, but the elf object file
> provided by user may have section like rodata.cst32 generated by
> compiler that does not have accompanying BTF type info stored in
> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
> guaranteed to  have every BTF type info from application/user provided
> elf object file ? I guess there is no guarantee.

vmlinux holds kernel types. rodata.cst32 holds data. If the type of
rodata.cst32 needs to be emitted, the type will be encoded in bpf
program BTF.

Did you actually find an issue with .rodata.cst32 section? Such a
section is typically generated by the compiler for initial data
inside the function and llvm bpf backend tries to inline the
values through a bunch of load instructions. So even you see
.rodata.cst32, typically you can safely ignore it.

> 
> Vincent
