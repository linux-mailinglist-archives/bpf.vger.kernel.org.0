Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4544D65CD7E
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 08:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjADHKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 02:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjADHJ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 02:09:59 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BEC17592
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 23:09:57 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3046miAS006220;
        Tue, 3 Jan 2023 23:09:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=n359tVvlXPtM4jZj3hgZ7BvTfwZd1PoN0TAxIYWFG5w=;
 b=CKXG9sDwX/mqot3JdU1eTocojCtd6CuSbzy3lkDPW14Chk4lXVI4/tC7buGSUtiVhZEG
 H5Tm3knGvOeBWO/QKeisf3VMhb2oijrstabe1obhWmQeN8EnnA/dLEtrOWXDZoMCDI4k
 OhYaACAsIKLATR+FM2a0HylEgeLCSYSAb3vf38iHjwe7fjMDPUhQnJgT5ywlKcVaF2ie
 fZuY9XBPUhQXunLKhJ33VubQZvjGvPW3ckIYjOiV8x/edU3L/jAFvIG6BhwUDfdb9EmU
 Yq8pHvSfojEFpV2vEUX0J9YO9z01Y2IQKWMQoRAZdmS5okq5vlRyhxR4kEw1d+61MVN6 gg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mvvt8jhfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 23:09:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwUkTEaTCZM9nBrYmZ9FlLmjZQTJe9QRCMW2fiqnXYFIFYA/2/UfmsZ57Zh0kAS9z1cG9qHa4aIkKCHw4JVwESSZU+1EdSkXLd7vF6N2Sk8oS9ZuFGqOIT6bpUz9yxLgHBI8ewBPZraOt3PfiZ+euzZNy1fix3oxOw0NSFnq4J0SDfftknUc6xS6RktAzh/kxohT9tquIje20KfFmZH4ZiOfdhOSs50boSnWintvOniu+Y9QpgyVh+RnpPfQ+bbnrb3wUxT7vgvEaPKEDlr9Fuki3VLKejrOt/zRQFhr9FWI+bTDvqrJuA9jhWD3NKGEKEDq7NbtLskDw8pYFH9WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n359tVvlXPtM4jZj3hgZ7BvTfwZd1PoN0TAxIYWFG5w=;
 b=LakxSbYAdveG0KKNvwKBEEf3yeH318BsAlQo9bK2Q3wH6+8l94orNPO/UuSRPWBC9bw7+iPLBCOw9AX8djvQegVC9AUMCBihGfKMjASC9UI7UbNnV/36mfk103NCuF4cXyGQX7ntlQovgbnYrKrAUe11iLcn6XzM7UIccg7cUQk/xBbLk4KgHe+qE9UmHxu0xU3mSjOXNnvgVRf/opectOczRxwPhEx5AHpQxESDfYeCeaMLEHT0fPCl6pUMkAj9TAIjrPw6gSn2w6pwjupgln4+1OLgRdtLlBvBpSRMU9d6UqKrzIouCdN5Yw2mx1oYI8rISR0hJ1bedDLfs7ir/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4627.namprd15.prod.outlook.com (2603:10b6:806:19e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 07:09:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 07:09:25 +0000
Message-ID: <323005b1-67f6-9eec-46af-4952e133e1c4@meta.com>
Date:   Tue, 3 Jan 2023 23:09:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
Content-Language: en-US
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
 <20221219041551.69344-2-xiangxia.m.yue@gmail.com>
 <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
 <CAADnVQLE+M0xEK+L8Tu7fqsjFxNFdEyFvR4q3U1f1N1tomZ2bQ@mail.gmail.com>
 <ac540d41-4ac3-4d70-39e8-722e3fb360cd@meta.com>
 <CAMDZJNV_J-LmxxzX5DMGHQLm6WyYqG2GAMHb=WZvBG_y1rUOYg@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAMDZJNV_J-LmxxzX5DMGHQLm6WyYqG2GAMHb=WZvBG_y1rUOYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0109.namprd05.prod.outlook.com
 (2603:10b6:a03:334::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fecdb47-c75a-435b-3eef-08daee229d06
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3ojfJ6S+dM4P9IA+ZqiysJa3XllT18oZX5SlHX2t0jFXxiMsHqSAF++dGBAq6S/WjcV8dNNG9GTS/j9cDmCRYwjzpCWWN9ADhZnwzbHz7ZSF2oUZYS9B4bFfqVEg+Bu9gcyr21Z1Bx6c5iX00LcUoC5izFN6MShKeU/OUTTPuT24jdwgbwCuO9Eh/pvyoar4URLtyHowRhkEOxetwtOtjMjQ3dg559eeXmnzfGVHqKtFVAme+s+UZeX5Xbhm6OyLMz2gUody/UcfozNxZVHJLCZPvLrHIoyNe/o3//Ju/rR85S86vfAeU0ktL2g2PhK/ghdqUAOobn64RaSEm3D2yT64UrU8TMGPryS7+vNDjcE9YKqZOhDBQhnGT3DrXCSFXquQjPahRWPHT9TViUDgMEGSpR+XJhhQ7G3grSUgSlgEoc+YKsxnz/C8P5b1Y6eeH9sZjvM4bMY6ACi6KmpK+GOE2cUuaosnqzDg4tFZ6sWeAbNTAJtzP86RBp/z3771A0QW21hjJHdBtpbnQtxaAnbkdNt9+KuB1nuEpiC/TVCAkiRpXaGhra/lW3hVp/ZvDTGBqJcaSnRU7jEC2WOMsWso68uv3eJCrSHKl+vz0Vn5toiyGoS7MsZO17ujQZPvdJmznurSlbu7j62bSap7RVCSz+mvcLaNuSIneMhjrW1svCrmoT5TaPCklM5/JUTeQVcDILSjLPpTTtIgDFVUmlbgNPeecE8thdz/abvK4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(7416002)(5660300002)(2906002)(8936002)(41300700001)(4326008)(478600001)(8676002)(316002)(66476007)(54906003)(66946007)(6916009)(66556008)(6486002)(31686004)(6512007)(6506007)(83380400001)(186003)(38100700002)(53546011)(2616005)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkN0RFBDZ3dVZlI1MkFSTmdIbjljZE4vM2w0S1lMaEdhakNyL0pJQlhJZGhV?=
 =?utf-8?B?b25uTGVSN2N1VGdmNmFXTzgxbHpCcnNsUC9QQ2pQVkxiZFNpV3VDNzFlbCtQ?=
 =?utf-8?B?ak1DVUlZRWVISWxySkxlaDBxUHFtYzlUVnVoWjJVQUpwcmxBOEx6VWNHTy8w?=
 =?utf-8?B?WHRYblgrYWk4Q0RvNGE0Z3g0a3d5UEc5dGpiWWFEQ1BZeW0vdEpzazUrZDlh?=
 =?utf-8?B?aURjNlc1aXJSOGVjWmY0TUY4aWh1SVc2Nzg1dC9RcnZPM1hDZ1hNWmRUalJw?=
 =?utf-8?B?cXdMRW1vTEwvRFhhM2Nhc0E5MmdPazdEdkVydFVrbzR6cTNNZVMzUGk4ZmpP?=
 =?utf-8?B?RmRiQkhjQU5ZN3M3Ym9ZcWJhcitvKzhSaFdiYnZHeVRrSGEwTUw2cmpxR1My?=
 =?utf-8?B?eFJlZmUvdVBINFd1c29GOTFrUkYrQ1BFYkgzMjYxZWp3ZHUvbHpwUGkrSWVN?=
 =?utf-8?B?a0N1cmFSZ096WCtFeTdFVlVWKzk0QTAvSDBxUGN5UTFzcEJhZmhDT3lkb2Js?=
 =?utf-8?B?RFhEUWJSbkx3UEVkRFg4aVVqVjFDQVFmQmhhL3Qxby9wK3E2RDZVb2JMcTkx?=
 =?utf-8?B?dTl0MHpoVWk4cFFuWjArVmg0bkc2bUZOcGpoN0NCeFpXY3R0Rk1KaHpWRWpt?=
 =?utf-8?B?SGVvTXMwTmozbHhvMUJJZGFxQmFiLytiNk9oME9ZdXhqT1p2TW1LV29nc3pI?=
 =?utf-8?B?NGNlZ1g3aGJjUnlrSUU5YU9pUE0vNVBpR2Q3R0xCR0g5T0FhU0tqaUMvZmJa?=
 =?utf-8?B?UXJPR3Q5eDdDZGZha1hBcFJCSjVHSFVGeUk3OXFJV29rTnVHSldIK0RXREN0?=
 =?utf-8?B?ZlFFTVhUa2ZiV3FlWVVnclYzNHBZY0I5Slh4OEVzSHNYeVpvNTJOTnprTkY1?=
 =?utf-8?B?RkJUV0kwQzIvanpnbVAwcnFLcFhlVWhpRDdXLzZIeFFuOVhKeFd1ejhmeHlt?=
 =?utf-8?B?WXduZlJMNTdPTnpDa2VtYjFMaERhN3JPOXZFcU1ZbW9IRnJRNzFNZWp0RUxW?=
 =?utf-8?B?YlJLZGNQVXozMVpseEtjWW5mWTk3R1dPSUV2UU55NE9wSVRFeXVnVlpTWFJQ?=
 =?utf-8?B?UkRhL1lNSW9lTndzK3FGMG83UnkyZyttUGNMdyt1NVdDK2I4MEdPUkY2UThi?=
 =?utf-8?B?cC9tV2ZQT1dHT3RTNU1SbFo3N2xBSk5PN2FNMlJhcVJsU0FJMWhERWx6a2dE?=
 =?utf-8?B?MGxlbjBxbmNBMFgrakQzdy9iUEphTTR6ZnRSNmt2ejNYLzRCRWg4Y2FzdjBY?=
 =?utf-8?B?b3g1Y1QxSmFDWWUzNis5bDc5R3ovS21TTnRTZ1laRVRFVC9PRkFsVGNLRlpG?=
 =?utf-8?B?ZEx3c3Vlcm11TkIvV25Pb1VlcXhuUno1ZjFmOU5IMndoOVYycHBUTW12a3lW?=
 =?utf-8?B?OUllT0ROdTF2WkhHekd4cUUrTjM0U3lOU0pPRkxLUEp0bi9rUUh0MUhNUVBD?=
 =?utf-8?B?dXdlS2N4MG5lM0crMW81OHdsamVuUDg5eEQzS0orcnNsODRCdXNGZVR0NFBQ?=
 =?utf-8?B?ZkE0cEN4dnNhNVhLaTFPM2syUHJ2NXRaZWd2NFZpTHR3SWJ3dDhkalErL3R2?=
 =?utf-8?B?dUt2dUgxR1RNZHh3QndRNWM4VUwvL3VLZ2lVMk01QUpjSHpYQ1NFcVl2S3RU?=
 =?utf-8?B?L3pSMy9oSkRVT1JUUGlLMDlJU0orZWJMMkdIbEVIeXd6dldtN0tKYXNENHVu?=
 =?utf-8?B?czZMSFhIT3lVNjljRkp0d2haY0szVm9nTk9XZC83S1lPaXMxRzhHWlZ6V0Ry?=
 =?utf-8?B?cUZpQTJIK1dTSUpVNEhIRkU3dS83VW9vZ01PU1RmaGFqWnoxbDdTZEF0ZSt4?=
 =?utf-8?B?M0RwUFc3bmF0dUdoL2hkeXR1YU9DSzNLdFlpUEc1Q3BLSzNoVGEwdWgvWWVU?=
 =?utf-8?B?Tm5zdzM2cmFlRGxreStiaUVmTVQ1WnBMaytVYUt6TC9wT0M3TlRiNzNxcjln?=
 =?utf-8?B?VnhHek01SDRjNDRUMEJLV1BNN09wSmtkSWxnTVdvT0VwdEVqK1dlNlhDVmhX?=
 =?utf-8?B?M3NBVG5pbVNuZjVFbzQ1V3BnZmRnZ2hKaTVMMll1QzFRRjNIZHdvd2srb01B?=
 =?utf-8?B?TE1SV0czSnpMYzZlOFdJZkx2VFF6SFRrUCsyc0xqcklHYkZvOVQ3SktlUEhh?=
 =?utf-8?B?M2NBOUxRRUZYM0EyVGUyYWUxaXpSekpSZFV0NU16d2tHWEo2NkFmbVpGOFAy?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fecdb47-c75a-435b-3eef-08daee229d06
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 07:09:25.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o56/R9z4c4M5sUkAVLriZ5dofpExzutJZgHneavJHOB9KN3ntiUL+zJlRAP5ML/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4627
X-Proofpoint-GUID: IIuX0lu8nuRnUTSt-5L8-gClMkbBsN4-
X-Proofpoint-ORIG-GUID: IIuX0lu8nuRnUTSt-5L8-gClMkbBsN4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_04,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/2/23 6:40 PM, Tonghao Zhang wrote:
>   a
> 
> On Thu, Dec 29, 2022 at 2:29 PM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 12/28/22 2:24 PM, Alexei Starovoitov wrote:
>>> On Tue, Dec 27, 2022 at 8:43 PM Yonghong Song <yhs@meta.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/18/22 8:15 PM, xiangxia.m.yue@gmail.com wrote:
>>>>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>>>>
>>>>> This testing show how to reproduce deadlock in special case.
>>>>> We update htab map in Task and NMI context. Task can be interrupted by
>>>>> NMI, if the same map bucket was locked, there will be a deadlock.
>>>>>
>>>>> * map max_entries is 2.
>>>>> * NMI using key 4 and Task context using key 20.
>>>>> * so same bucket index but map_locked index is different.
>>>>>
>>>>> The selftest use perf to produce the NMI and fentry nmi_handle.
>>>>> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
>>>>> map syscall increase this counter in bpf_disable_instrumentation.
>>>>> Then fentry nmi_handle and update hash map will reproduce the issue.
>>>>>
>>>>> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>>>> Cc: Song Liu <song@kernel.org>
>>>>> Cc: Yonghong Song <yhs@fb.com>
>>>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>>>> Cc: KP Singh <kpsingh@kernel.org>
>>>>> Cc: Stanislav Fomichev <sdf@google.com>
>>>>> Cc: Hao Luo <haoluo@google.com>
>>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>>> Cc: Hou Tao <houtao1@huawei.com>
>>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>>> ---
>>>>>     tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>>>>>     tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>>>>>     .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
>>>>>     .../selftests/bpf/progs/htab_deadlock.c       | 32 ++++++++
>>>>>     4 files changed, 109 insertions(+)
>>>>>     create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>>>>     create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
>>>>> index 99cc33c51eaa..87e8fc9c9df2 100644
>>>>> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
>>>>> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
>>>>> @@ -24,6 +24,7 @@ fexit_test                                       # fexit_attach unexpected error
>>>>>     get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
>>>>>     get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
>>>>>     htab_update/reenter_update
>>>>> +htab_deadlock                                    # failed to find kernel BTF type ID of 'nmi_handle': -3 (trampoline)
>>>>>     kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
>>>>>     kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
>>>>>     kfunc_call/subprog_lskel                         # skel unexpected error: -2
>>>>> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
>>>>> index 585fcf73c731..735239b31050 100644
>>>>> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
>>>>> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
>>>>> @@ -26,6 +26,7 @@ get_func_args_test                   # trampoline
>>>>>     get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
>>>>>     get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
>>>>>     htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
>>>>> +htab_deadlock                            # failed to find kernel BTF type ID of 'nmi_handle': -3                       (trampoline)
>>>>>     kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
>>>>>     kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
>>>>>     kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>>>> new file mode 100644
>>>>> index 000000000000..137dce8f1346
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>>>> @@ -0,0 +1,75 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>>>> +#define _GNU_SOURCE
>>>>> +#include <pthread.h>
>>>>> +#include <sched.h>
>>>>> +#include <test_progs.h>
>>>>> +
>>>>> +#include "htab_deadlock.skel.h"
>>>>> +
>>>>> +static int perf_event_open(void)
>>>>> +{
>>>>> +     struct perf_event_attr attr = {0};
>>>>> +     int pfd;
>>>>> +
>>>>> +     /* create perf event on CPU 0 */
>>>>> +     attr.size = sizeof(attr);
>>>>> +     attr.type = PERF_TYPE_HARDWARE;
>>>>> +     attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>>>> +     attr.freq = 1;
>>>>> +     attr.sample_freq = 1000;
>>>>> +     pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>>>> +
>>>>> +     return pfd >= 0 ? pfd : -errno;
>>>>> +}
>>>>> +
>>>>> +void test_htab_deadlock(void)
>>>>> +{
>>>>> +     unsigned int val = 0, key = 20;
>>>>> +     struct bpf_link *link = NULL;
>>>>> +     struct htab_deadlock *skel;
>>>>> +     int err, i, pfd;
>>>>> +     cpu_set_t cpus;
>>>>> +
>>>>> +     skel = htab_deadlock__open_and_load();
>>>>> +     if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>>>>> +             return;
>>>>> +
>>>>> +     err = htab_deadlock__attach(skel);
>>>>> +     if (!ASSERT_OK(err, "skel_attach"))
>>>>> +             goto clean_skel;
>>>>> +
>>>>> +     /* NMI events. */
>>>>> +     pfd = perf_event_open();
>>>>> +     if (pfd < 0) {
>>>>> +             if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
>>>>> +                     printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
>>>>> +                     test__skip();
>>>>> +                     goto clean_skel;
>>>>> +             }
>>>>> +             if (!ASSERT_GE(pfd, 0, "perf_event_open"))
>>>>> +                     goto clean_skel;
>>>>> +     }
>>>>> +
>>>>> +     link = bpf_program__attach_perf_event(skel->progs.bpf_empty, pfd);
>>>>> +     if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>>>>> +             goto clean_pfd;
>>>>> +
>>>>> +     /* Pinned on CPU 0 */
>>>>> +     CPU_ZERO(&cpus);
>>>>> +     CPU_SET(0, &cpus);
>>>>> +     pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
>>>>> +
>>>>> +     /* update bpf map concurrently on CPU0 in NMI and Task context.
>>>>> +      * there should be no kernel deadlock.
>>>>> +      */
>>>>> +     for (i = 0; i < 100000; i++)
>>>>> +             bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
>>>>> +                                 &key, &val, BPF_ANY);
>>>>> +
>>>>> +     bpf_link__destroy(link);
>>>>> +clean_pfd:
>>>>> +     close(pfd);
>>>>> +clean_skel:
>>>>> +     htab_deadlock__destroy(skel);
>>>>> +}
>>>>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>> new file mode 100644
>>>>> index 000000000000..d394f95e97c3
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>> @@ -0,0 +1,32 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>>>> +#include <linux/bpf.h>
>>>>> +#include <bpf/bpf_helpers.h>
>>>>> +#include <bpf/bpf_tracing.h>
>>>>> +
>>>>> +char _license[] SEC("license") = "GPL";
>>>>> +
>>>>> +struct {
>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>>>> +     __uint(max_entries, 2);
>>>>> +     __uint(map_flags, BPF_F_ZERO_SEED);
>>>>> +     __type(key, unsigned int);
>>>>> +     __type(value, unsigned int);
>>>>> +} htab SEC(".maps");
>>>>> +
>>>>> +/* nmi_handle on x86 platform. If changing keyword
>>>>> + * "static" to "inline", this prog load failed. */
>>>>> +SEC("fentry/nmi_handle")
>>>>
>>>> The above comment is not what I mean. In arch/x86/kernel/nmi.c,
>>>> we have
>>>>      static int nmi_handle(unsigned int type, struct pt_regs *regs)
>>>>      {
>>>>           ...
>>>>      }
>>>>      ...
>>>>      static noinstr void default_do_nmi(struct pt_regs *regs)
>>>>      {
>>>>           ...
>>>>           handled = nmi_handle(NMI_LOCAL, regs);
>>>>           ...
>>>>      }
>>>>
>>>> Since nmi_handle is a static function, it is possible that
>>>> the function might be inlined in default_do_nmi by the
>>>> compiler. If this happens, fentry/nmi_handle will not
>>>> be triggered and the test will pass.
>>>>
>>>> So I suggest to change the comment to
>>>>      nmi_handle() is a static function and might be
>>>>      inlined into its caller. If this happens, the
>>>>      test can still pass without previous kernel fix.
>>>
>>> It's worse than this.
>>> fentry is buggy.
>>> We shouldn't allow attaching fentry to:
>>> NOKPROBE_SYMBOL(nmi_handle);
>>
>> Okay, I see. Looks we should prevent fentry from
>> attaching any NOKPROBE_SYMBOL functions.
>>
>> BTW, I think fentry/nmi_handle can be replaced with
>> tracepoint nmi/nmi_handler. it is more reliable
> The tracepoint will not reproduce the deadlock(we have discussed v2).
> If it's not easy to complete a test for this case, should we drop this
> testcase patch? or fentry the nmi_handle and update the comments.

could we use a softirq perf event (timer), e.g.,

         struct perf_event_attr attr = {
                 .sample_period = 1,
                 .type = PERF_TYPE_SOFTWARE,
                 .config = PERF_COUNT_SW_CPU_CLOCK,
         };

then you can attach function hrtimer_run_softirq (not tested) or
similar functions?

I suspect most (if not all) functions in nmi path cannot
be kprobe'd.

>> and won't be impacted by potential NOKPROBE_SYMBOL
>> issues.
> 
> 
> 
