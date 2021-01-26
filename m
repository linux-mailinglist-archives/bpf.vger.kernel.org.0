Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC54305B4D
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 13:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314030AbhAZWzQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:55:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30892 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730844AbhAZVBQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Jan 2021 16:01:16 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QKxGgu025905;
        Tue, 26 Jan 2021 13:00:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6lMxe9skVfNPxILBxpT9y3Se+tkkXCyjx1n/iMIl8Rk=;
 b=WbN1/dlGGFijsvMOq2US6xfXJW/0O65ki0lDl1zFCNhUNYdreL++U/l53HNE4zaQZqrn
 Lp/7Bxlhg3eC2dIomjYRUo2YO49ugxRWk9MeExeN2g36aV9GAPFifTgGVcZSTTRF2hsz
 xFNz+XK8qQ4tZvW+NFWieCGsu6Ry6RgvZHE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36950a6psa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Jan 2021 13:00:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 13:00:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+jNdfNMEAvw7/ayZpK5zlRarwQ5OvoKE2z+cW7rG3Rmh+GxPbJE8fiTuhpReCzov5bnErkG4RmqucW7jEQWfYYPqWdyl91yKi4V6bdgF+wjUmGMIWoUAqR1M7DuxOTUZEdyHepHK/PzOv2uv5yXxXSBqun5dQUJbOLUfMDl0v2bwQTxQivwW8rvyH3XqDIrdRWK0jF2lDwt5/aW6+0WiSl3fyuJ60jGfSUnFjIoLjAT+XYcTDDK1hWj80UQW3SGQrcCpuGrbtVv5HqMjyH9L1N9n6PPly/u9/sqxx3QGMoTDrfyUS0jr5oHPFAr7OFxuVKGcbn0C57kwChSpwBe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lMxe9skVfNPxILBxpT9y3Se+tkkXCyjx1n/iMIl8Rk=;
 b=HaXKEcu+D+mjPK4uIp+ogYoKJDUZAjtex7wino6G+1vkPVVhpNljiHG2tOztm3N7Wy925JtI6SWl6RuNK6iGuN7RcKB2C0kuFCs72uav0U9OoyAKXgN/bgB0Z9hlxraTBjNRbt2ePK4x23+CkqmRb9Rh7LMiP97ZoD1hmo+2/y7O1QtfvdYgBuplKHjNFC9iqUaMbDGLlMUK8SU1Oq60Cm63nhP5lhR1KJMwtu4sZBm5YagwFlVKJiTSXU0gk1eDBusy50u5X+HpBs4lKCAlYcGLiC7K8fbelOXsec7mVR5SRp5/CjT5eLeLfL9vd+6wE8DubbTpRuBgDRibgAJJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lMxe9skVfNPxILBxpT9y3Se+tkkXCyjx1n/iMIl8Rk=;
 b=NH1l9wPek6qK9sTjFDl2kDabbeGe0pdqnPYRpsuF4YkDK5dPRPCs9zWB0arE4uba+RRGv61w/DNx/Zb+NBiF+wjD4Q/qEyie4Y2B8SUvAtWSmbHuX6sVVKfh0u0rN1IzJDAUD74rVMljqSTwZQCMF+ijowDIUcOBNfFa9j8Bs8c=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2456.namprd15.prod.outlook.com (2603:10b6:a02:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 21:00:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 21:00:08 +0000
Subject: Re: [PATCH bpf-next 2/3] bpf: Add size arg to build_id_parse function
To:     Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210114134044.1418404-1-jolsa@kernel.org>
 <20210114134044.1418404-3-jolsa@kernel.org>
 <19f16729-96d6-cc8e-5bd5-c3f5940365d4@fb.com>
 <20210114200120.GF1416940@krava>
 <d90fd73f-b9a6-c436-f8ae-0833ce3926ef@fb.com>
 <20210114220234.GA1456269@krava>
 <5043cef5-eda7-4373-dcb5-546f6192e1a9@fb.com>
 <CAADnVQLkM7+1+wzg=s8+zdKwYnmBRgvVK7K-qivu_a9mvaK7Yg@mail.gmail.com>
 <20210126205236.GD120879@krava>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9490aa32-ad01-4a55-c2a0-e688226ecc71@fb.com>
Date:   Tue, 26 Jan 2021 13:00:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210126205236.GD120879@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:c70]
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1246] (2620:10d:c090:400::5:c70) by BYAPR07CA0009.namprd07.prod.outlook.com (2603:10b6:a02:bc::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 21:00:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3d39aa7-3002-48a9-fa40-08d8c23d5d10
X-MS-TrafficTypeDiagnostic: BYAPR15MB2456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB245671C2BA720FFC7B26BBD1D3BC9@BYAPR15MB2456.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbqDG6ucT6dodlMfeQeZHjW5OxU/4tagAZ06G6Dirz3eP94XLT1bWqpoJKCixGLr5f023qWYmofj8ZCsJGce8wuuBerMQs0WLBZpOF063cBseJ+C0EB9d+aCb6iDEM/aB5Qp73E6qO67Yg5aQAlHj+NdYyZpUBiQrnaKsmeM/qQ0PMDeKOUkyJWMSrau3003EhHkwOxfMVRc3MSneEZG1Nh4SdgpnPngtbmoDvvNn7UpzLbVt5pLOnubKqRAROQcdnn1MmnAazluBFRgaEa0aMlEhgpu/dhGl1yv/0TQZ7j+RkXtIxDYZB1FVr200YJeqMFSEjT9BNwP7l2yqgQwtlsEQ4IGdH0YZfJpslRVcxEc8RZYJ2WzdImw90M7UFT7fVif/lyg46KRkgkCMvyYeEGW4YG5bM1FFPPxygvfpwhinvAp3a6YN13SmpZSGeVH29Qd5NdlGENltR6QsMt0pb+CLuAQRQdUOMItM68p5lf1WEgi9ARLcMnKtoQOcj+wB8j+AcWJLYDyoebsVvhxK75iE6Vd+znwUz6qiM6+p+j4ObrMZSbrcpdEPBANpg4OX0u5wn0NIdw4LpGsVaJhcGBUm/SRBJH9UXi+aPOqde8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(39860400002)(366004)(8936002)(53546011)(4326008)(16526019)(31696002)(2616005)(2906002)(6486002)(31686004)(316002)(186003)(66946007)(110136005)(54906003)(5660300002)(8676002)(52116002)(83380400001)(7416002)(36756003)(86362001)(478600001)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QW51YmZhY1JhdWhXNEdKUDBhcHVlN0N6ak5BeUcyRGNtNU51ODRUL2JNSlFl?=
 =?utf-8?B?OVBFRUJKRi96dEJieVdiMzFabjBkQUVPdU92MTZZeHRrRzczeGNYc3QrdGQ1?=
 =?utf-8?B?dnBqNXdlaFA2Y2xqdGRxRGJ4WHQ1eHRtMmkzSmJheS9FQ3lYaEFnVjBIVlBV?=
 =?utf-8?B?bWdneldrTlNzUkN5YTBoSm9KV0pnUWo4UWtnTzRKcUFzNnZrZ3Zja21UcWN3?=
 =?utf-8?B?K2V0bFpBa0lXLzJmVkFVaFNHNFd3WkRMc1NsL1NFS2U1SWkxTVNabkxycVhl?=
 =?utf-8?B?YjFxdnJ5WWZsZlZqb3BzanZSQitiOVdJRDVULzVtQmJYWkZMRHFoWVRuRHo0?=
 =?utf-8?B?aVc5ekwvOVBjTjBiYXByNmlNcldaUjlEN1pwMjVldXF2TVFtTFk0eTlGc1lo?=
 =?utf-8?B?NVVBZytwRkZGN0w2Qk0xQUNpZ1BnUXpZbFpOZkg5QlIwamNYbDBFR1BkNVE3?=
 =?utf-8?B?VGFEZ3JFT2xpcHBZTExlK0M3eU1EbmNMNEhHSUE4VS83ZUVHSTcveTBLNmNr?=
 =?utf-8?B?QmJZSWEzdURHTG50ZVZUUzh5RmJJYlg4N21zWGRBVWpNYzNtNG80QmJhNDFx?=
 =?utf-8?B?NnB3SFRpRE0zOFhaREswd2dPK2NOZVR4TzJjcUQvMW5zdEZpVFZOcmtkbHlP?=
 =?utf-8?B?QjFNU0loa0xndGZPL1N2M2R5NDBGTllZMXM0OFBTRmJHUmZrSGkwNHVsYnJY?=
 =?utf-8?B?QnI0bmdMUTRmZ0FqQ3VVNngvODBSNjVKenVTVkZBbzlCeSs5Z3FmVjRHTUNm?=
 =?utf-8?B?NnB6dWNRU25lVm1PVVRJUWZiTlFqa0ltQVJTT1FQQ2NWQTVkT0RjM1BzdmtD?=
 =?utf-8?B?VythMTNIUW5mblpTdkg5ZGJacW9kZGFMYThmc2svZ1dHdDA0eUdGb05MQ3dq?=
 =?utf-8?B?eFlsbzErYWN0MFpHMG5rNENYVEZ3Yk5qTWlMdm53Y0prSTV4RVZzRXJWbkox?=
 =?utf-8?B?V2VtMUh2NEdpL1htaTJvbVo3dnA2blJmdXF0YzFld3A4eEVrTmFQOTN2UUs1?=
 =?utf-8?B?SThFd2JHWTVuOG1kNW1zTUlSSTRCRmh3b3BSQUVRak56NERnRWdUWWNwRjJU?=
 =?utf-8?B?Mk1tanYvbHZjRlJXdTdmYTRjRHAxbGRrOTRWS2NXUGVGMjRUM0Ivd2V3VHA4?=
 =?utf-8?B?ODlLbWZTZnozMXNQS2h2cCt4TkViRkJwaGhLZ3lCU2V0N1lZQm1Ia3ZlQkhW?=
 =?utf-8?B?bzFaZkxWamVvQXorYmt1S3RxTVRzNFVYTmZBWFpzZDZmbVkzd2JHMWJPZjV2?=
 =?utf-8?B?aVRnRHBUbzVJUW5CdGFhcmVmNStWaHpOS1BKMU1OcVVsRVY2UERoem5CWHdk?=
 =?utf-8?B?ZnJsV2ZsTldzNnA2Z04wOVFPcktYb1FQSDhGTW14Z2hBNS9HbHp6bnFpM2sz?=
 =?utf-8?B?VGRPQVhvcm1yY0xwcXRiaGczVW0rbHJ6ZVFPVjVVdk45WUN2L0pzVkdyUHVJ?=
 =?utf-8?B?azNtcE5tYVNIaWtVd1BadUQ2SVhQdnFaZEdBVWRDMXZkUGRlbFhHUGZGN1lO?=
 =?utf-8?Q?oA2U9Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d39aa7-3002-48a9-fa40-08d8c23d5d10
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 21:00:08.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vejVjcmaSj/KQqttAvSPlEYsckGcbupqTy0dAyQR+gGQyoGk39KD06a9T9ryFFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2456
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_11:2021-01-26,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/26/21 12:52 PM, Jiri Olsa wrote:
> On Thu, Jan 14, 2021 at 07:47:20PM -0800, Alexei Starovoitov wrote:
>> On Thu, Jan 14, 2021 at 3:44 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 1/14/21 2:02 PM, Jiri Olsa wrote:
>>>> On Thu, Jan 14, 2021 at 01:05:33PM -0800, Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 1/14/21 12:01 PM, Jiri Olsa wrote:
>>>>>> On Thu, Jan 14, 2021 at 10:56:33AM -0800, Yonghong Song wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 1/14/21 5:40 AM, Jiri Olsa wrote:
>>>>>>>> It's possible to have other build id types (other than default SHA1).
>>>>>>>> Currently there's also ld support for MD5 build id.
>>>>>>>
>>>>>>> Currently, bpf build_id based stackmap does not returns the size of
>>>>>>> the build_id. Did you see an issue here? I guess user space can check
>>>>>>> the length of non-zero bits of the build id to decide what kind of
>>>>>>> type it is, right?
>>>>>>
>>>>>> you can have zero bytes in the build id hash, so you need to get the size
>>>>>>
>>>>>> I never saw MD5 being used in practise just SHA1, but we added the
>>>>>> size to be complete and make sure we'll fit with build id, because
>>>>>> there's only limited space in mmap2 event
>>>>>
>>>>> I am asking to check whether we should extend uapi struct
>>>>> bpf_stack_build_id to include build_id_size as well. I guess
>>>>> we can delay this until a real use case.
>>>>
>>>> right, we can try make some MD5 build id binaries and check if it
>>>> explodes with some bcc tools, but I don't expect that.. I'll try
>>>> to find some time for that
>>>
>>> Thanks. We may have issues on bcc side. For build_id collected in
>>> kernel, bcc always generates a length-20 string. But for user
>>> binaries, the build_id string length is equal to actual size of
>>> the build_id. They may not match (MD5 length is 16).
>>> The fix is probably to append '0's (up to length 20) for user
>>> binary build_id's.
>>>
>>> I guess MD5 is very seldom used. I will wait if you can reproduce
>>> the issue and then we might fix it.
>>
>> Indeed.
>> Jiri, please check whether md5 is really an issue.
>> Sounds like we have to do something on the kernel side.
>> Hopefully zero padding will be enough.
>> I would prefer to avoid extending uapi struct to cover rare case.
> 
> build_id_parse is already doing the zero padding, so we are ok
> 
> I tried several bcc tools over perf bench with md5 buildid and
> the results looked ok

Great. Thanks for confirmation!

> 
> jirka
> 
