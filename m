Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF04620C9
	for <lists+bpf@lfdr.de>; Mon, 29 Nov 2021 20:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbhK2TrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 14:47:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4180 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236353AbhK2TpM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Nov 2021 14:45:12 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATIl8qp004319;
        Mon, 29 Nov 2021 11:41:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sUyNombQvGbh5Xi/MWFgQt/o30hMKNtUjXodAz48gBQ=;
 b=NAQ0BrtSSUoT/H5zotALAid21tHzVBzmOTQ+OkmoULvEImffY6XTKtK3J0/mFGxE/WWt
 ED6xi9CXin1mD0ppkBOUHXuGxyo8kKBJthZrKg1/NPRILatgLQoaigedCZWVMM8SBPIJ
 KfH9Tah7tipi6RMelGVILzrsRLdIaca+tiM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cmyfmjyu3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Nov 2021 11:41:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 11:41:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9LmudoWlfmb6Xpi56Hm0ujNrtAqLTv2cl2+FdKrcE4fsZK2eEaLKEQCg2dQwIdbEBzq5bOu/uh4LJTSf566Id4VSQ8XaeejmNVynBzaHvlePt5rEAhMrke19w+jijCB0kIKZQIhsnuopRlLcagbgIq3KJA016613SXe3ZiQSvaTwgu6UVGju+GHbct7zeTNcGUsARt7gGD93Hmztije1/DYMrfZxb8KxFpPvqNJFIId1H9XY9aPwUVYrM3VU9SYakFXf+oF+jis/vicCXPhZblAJc0yVda2hZZ+PHf+ysQ/zh7eWq78bRr5HJDdHFB3fX592t8taQy9wVamUTE2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUyNombQvGbh5Xi/MWFgQt/o30hMKNtUjXodAz48gBQ=;
 b=bm/aQ1mppe5bmTRo4MBWg6kV4doMjakU4AZpzSrZuq9sEFEfWWPRJL1AwhiWWPN2izSWLjeecOYFN7TUQDuXhqM95CNFXPorTy68d48s1i1S3bhXMbnFb1IVR9FYd8Ml/hOLasiepD4z5zBVt3gnkTlyTu+1SG6F/nrCz2OD3dWk6RZOA1kNENRysBUCRRxB1gJe4aEd/aZPsDO/56NuOSnjoDIIok8lhqiPvhUPkfA+vCIMDT6A0lwh+vUZSHFplx+b2LWIEqOgiJl4ZkLudpzLrROpH2oeDe/04c/vFROdavFBJRSdHwGUu5JOtlg+uOvInMQkH18pe/qmpvKFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB5013.namprd15.prod.outlook.com (2603:10b6:806:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Mon, 29 Nov
 2021 19:41:34 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 19:41:34 +0000
Message-ID: <00185053-c2e2-2b9c-5042-b162e5b406f9@fb.com>
Date:   Mon, 29 Nov 2021 11:41:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop
 benchmark
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
 <20211123183409.3599979-5-joannekoong@fb.com> <87y25ebry1.fsf@toke.dk>
 <3eaa1a93-c3f1-830a-b711-117b27102cc5@fb.com> <87r1b5btl0.fsf@toke.dk>
 <CAEf4BzbB6utDjOJLZzwbBEoAgdO774=PX8O9dWeZJRzM2kdxaQ@mail.gmail.com>
 <87lf1db4gh.fsf@toke.dk> <5d363ea7-16c6-b8e8-b6ee-11cbe9bf1cf2@fb.com>
 <87ee74bh8k.fsf@toke.dk>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <87ee74bh8k.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c083:1409:25:469d:91d7:d5f8] (2620:10d:c090:500::7699) by MW4PR04CA0038.namprd04.prod.outlook.com (2603:10b6:303:6a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend Transport; Mon, 29 Nov 2021 19:41:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbcc7d66-94d9-4498-327d-08d9b3703fab
X-MS-TrafficTypeDiagnostic: SA1PR15MB5013:
X-Microsoft-Antispam-PRVS: <SA1PR15MB50132250FBF61CABDD64F972D2669@SA1PR15MB5013.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPeWJvOV00ah/ddNzt40bP9TsBopEzt3RsMp6QK/5Pw2MeAnkTY4+FKdxJxXNq0BoB9fwSB/7On+oYaXBzb0N3AbrVQKyf4aKwkdW4MDDVC7TFfVi2g7h0IUAGUg6rsJ8MiYPY7xMglVR84MBpkDVFOobrEK785mEyBnTUW+bKO96qUVvFdEls10H2oN/nC6FmdhEJ1+uvKV3eAmqoN+f8Sj2Jrwp2t+FR+8lZ/A6v0jiwyEGaU0Q+uFYV/mDmYgwDJYX1VE939zaDIrgg8lLgdKRCKmCzRnlUYNv+DNveVZDiTocFuBh2c3RHeRlks9nnfvbiP8XFD6ZM/M3bR5k+8UeowiLdxukXSccOEhtrqbitM4F7D8A/p6PL2ubEOy54m7eRDQz/C+S4rYK1yhmXcfaUZVIL9Xm8Ipfbo8og8w77tDFoOCoQzgWwW4/+w4Zdx04VhMaHTiKWBthRrSA942bUDH071LiEaC1gGzKrt8NjHaFWm19PkuSs4wtfOfNMK96qhdugQ21LmH+lf/qE4+4iehtC3M7K/iLznGws7yImyGk7Ymslsz5u93Y9NcEKK4BZWvPDLxWXcI7gKXshMO5QjSqMfTmoB+/n3bmsJJQWaiTv/JzSNioTah3iGYy+okIocQexPF0BTMglhrj5f0JZS1EgoV1cdn3VHhv7R9I//ti9RJjFpfYa8NjMM4K9zROK4M5q9O/mgugx8TjuwWmiSEOZVUCEkA7zinJVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(31686004)(36756003)(83380400001)(53546011)(66556008)(508600001)(5660300002)(8676002)(66476007)(6486002)(86362001)(4326008)(2616005)(8936002)(316002)(110136005)(54906003)(66574015)(31696002)(2906002)(186003)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0w1ZlpDRktpMmtlUEx0ZnIyK3M3eEl5Q05JM2VxeERtMXZXM2swbHptOVVz?=
 =?utf-8?B?KzJMTjdNVGFoWlVWdnpEcVFjVllXNSs4amovVDJtSG1qNXVVUHYySlRVM0l0?=
 =?utf-8?B?dnFMMzFYVWhTeVgwb3RQL2ZVY3hQUkpxQmh1bXQybU9CajQ4N09wOVo1VmM4?=
 =?utf-8?B?YXAwR0tqOUhJeUxIQ3hJMWMrNTJhbHcwQTFxY2FtWDFmV1BjMEJ5UCtzWXVB?=
 =?utf-8?B?QkdyV3F6N1lTRTFHQWNVSEl6UDdyd2xyY0ZIYnprU1lEVWZYQVhKQUVwMk9U?=
 =?utf-8?B?Tm1sSk84Zzl5Vk5FWmNZQkp0ZzhIZkxRMUZhRzZheFpvUFlxYnRDbHhSandO?=
 =?utf-8?B?ckZLYkwza2pGeWpiVnMzRVlDUUpJbnptMjZJd3pZaTdlQzMrWEplVE95bXBp?=
 =?utf-8?B?SFRuMTV0NXRNL0hxQVN3SStjNnNrdzg1NFpRdStyT25hMmR4TFRITUVPejVX?=
 =?utf-8?B?Rktia0FieG1WZ1Y3QXR4REg5YzgzTEs5RzV1MWFiSlI4UmRVZzFlc2tSV3Nw?=
 =?utf-8?B?WGIyMFRWek1zODY5SHdpSmlQWU9wWUtGc1BPWGNxQ2ZaMUVlZE5wSnpWNVpj?=
 =?utf-8?B?SFNCenh5WHI4ckZCK1VqSEU5WXF1SGJvRmNIbjJvOTVaZDZBY0FzWjNxWkpy?=
 =?utf-8?B?NGgrVk1PQWl5Nm9qZmdHYkt4MzVHTmVuS09RaldQYkhoQ3h6NW9KckQ5Ymxy?=
 =?utf-8?B?NVN5K3ovaTk5N2gyMi9IVzVKdWxXd3dsMWxJbkxoa3JuTHkyeFpRQlZwOVR2?=
 =?utf-8?B?VDNMeStLVHRhK01PYXZlOHMzNnNsbWR0WEJwaFAxUTlqUjN2amM2NnhMTXg5?=
 =?utf-8?B?WVZSbTZlRjEyblZqUVdmaXJqUWdvY3lPWE1ZczJyY2FWMXQ2dm4zb0x2SUl0?=
 =?utf-8?B?OFBkVFVSRi8xOU9PS2dLUUFEazVMVytMMTQzUHpzMXpiZitTWmluYUtlV2tt?=
 =?utf-8?B?VFEzbE1HV3gzS2k5L3dvdVVTS25kakVNY1Vkd1B5MnZoaDF6VFBzQk5GSkI4?=
 =?utf-8?B?ajJESnQyYzVEeTBWSndCejVlVXRrbTFIOFY3MEZDSlVWS2Y2ell0dUxDZDRo?=
 =?utf-8?B?R3Z5TDZ1MFhMVSttaUtqTDZmcUJoY01xNFkxbWJpUllzQjJ1aHFjeHltbTI2?=
 =?utf-8?B?ZklvWTdRUFJOM1BnOWN2dWkyN2RoVmpPNFBJR1FXa05qOXg2bU4xTjdPbXdX?=
 =?utf-8?B?Z25JMzZoRmtMUDMvZk12ZDRpVFplOUZuSmVkMW94MHRVelBzZkpUVElKeHBD?=
 =?utf-8?B?YzYxVjEwbFR5V1RIYlBiZG1qZC94VU5nK2lmdWE4SWRuMW9PTEtUYnAxVThv?=
 =?utf-8?B?YldVd3FYSDZmNkdpWEk1KzU2OWkwK3I1d0dzS00wYk1aUThwQ2Z0c0tTdld6?=
 =?utf-8?B?cm5CM2hMODBXbFJiTDYyVWZXc1lrdG42aWM0WkFTc05aSTNMSlpHcWdKUEI3?=
 =?utf-8?B?T1E3Y1RGWUQrWXZJNnRUUWpaNWdZTTVkblVUMlA5Nm1CZy9ZajQzVkMyY3Za?=
 =?utf-8?B?Q3ZjOGl3SDBEZkxXRjRDSVdqQ2t6ZDd3MHJ2c0NUV3REV21iUHFNRkxvWEtk?=
 =?utf-8?B?VlJYcHdCTG9Fb3FoYlNMQzZ0TFdZRldYRzM5R3JyRVJZZFBsQVRBM2xVOXAx?=
 =?utf-8?B?MnhqNDhxbDBpMW5rcW95OWVJUkZzNkJKQWZHd2toWEVnc1U2Q2M2NDE0WGlP?=
 =?utf-8?B?c3RwOFZVWEcxRHlKYnJjbVlGSnNYbGtDaGVFME9MaDZYZ3c4bm5Rekh2NHRF?=
 =?utf-8?B?VEdDV3BTdGFoV2ZoMGhzVHRqanZOekY5aDNSdk0rRVNRMmFKak4xSDJyTmNV?=
 =?utf-8?B?MnFGTjBoZW5Ybi9yUE9kSDBuWUhrcGNNOTlaVWl6amgzd0dOZU5YUm5BcGtJ?=
 =?utf-8?B?c3o5QVFGU2VkbWpreWplTVc2RnU4a1k3T0drOTNnb0xCS2ZwYmJYSUpKeDlE?=
 =?utf-8?B?MlhZenJyWk5hWm8waExlZzZJYzF0MHRqSnNab245ayt1dk9lWFZhVkpWY1M5?=
 =?utf-8?B?dExOV0tXajcrZE5vVnJJNUNaQ0ZVSEFYNTRJdFV6S0VFVFBDK3pQOUNVR1FB?=
 =?utf-8?B?RjNoRDByYjY1SS9RTklYQzRaUGJORkZUMkp3ODFEcVFkV1ptRExIckR4N3Uz?=
 =?utf-8?B?T2dqdjNZOURnajdMN1IvSVZNdUFxaE9QeFlDLytQTk03RnFscEwzSStyM0dJ?=
 =?utf-8?Q?Wtpb8MwNSB80ul9WGsRUo4zP8bxt3lqkqAsna3BltV1I?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcc7d66-94d9-4498-327d-08d9b3703fab
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:41:33.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhzKNtdOBKn5BMxdTAdTe+pB+s4TOoLRLQuEYIxZcx/8p4vUGkcqVgbI+86PgUsMVwPH7/etPhkt+jx2tBskzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5013
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: rTsXdXEs7U5JBCbqD2uwVM0_OsiY03ud
X-Proofpoint-ORIG-GUID: rTsXdXEs7U5JBCbqD2uwVM0_OsiY03ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_11,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111290091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/25/21 3:35 AM, Toke Høiland-Jørgensen wrote:

> Joanne Koong <joannekoong@fb.com> writes:
>
>> On 11/24/21 1:59 PM, Toke Høiland-Jørgensen wrote:
>>
>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>>
>>>> On Wed, Nov 24, 2021 at 4:56 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>> Joanne Koong <joannekoong@fb.com> writes:
>>>>>
>>>>>> On 11/23/21 11:19 AM, Toke Høiland-Jørgensen wrote:
>>>>>>
>>>>>>> Joanne Koong <joannekoong@fb.com> writes:
>>>>>>>
>>>>>>>> Add benchmark to measure the throughput and latency of the bpf_loop
>>>>>>>> call.
>>>>>>>>
>>>>>>>> Testing this on qemu on my dev machine on 1 thread, the data is
>>>>>>>> as follows:
>>>>>>>>
>>>>>>>>            nr_loops: 1
>>>>>>>> bpf_loop - throughput: 43.350 ± 0.864 M ops/s, latency: 23.068 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 10
>>>>>>>> bpf_loop - throughput: 69.586 ± 1.722 M ops/s, latency: 14.371 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 100
>>>>>>>> bpf_loop - throughput: 72.046 ± 1.352 M ops/s, latency: 13.880 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 500
>>>>>>>> bpf_loop - throughput: 71.677 ± 1.316 M ops/s, latency: 13.951 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 1000
>>>>>>>> bpf_loop - throughput: 69.435 ± 1.219 M ops/s, latency: 14.402 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 5000
>>>>>>>> bpf_loop - throughput: 72.624 ± 1.162 M ops/s, latency: 13.770 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 10000
>>>>>>>> bpf_loop - throughput: 75.417 ± 1.446 M ops/s, latency: 13.260 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 50000
>>>>>>>> bpf_loop - throughput: 77.400 ± 2.214 M ops/s, latency: 12.920 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 100000
>>>>>>>> bpf_loop - throughput: 78.636 ± 2.107 M ops/s, latency: 12.717 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 500000
>>>>>>>> bpf_loop - throughput: 76.909 ± 2.035 M ops/s, latency: 13.002 ns/op
>>>>>>>>
>>>>>>>>            nr_loops: 1000000
>>>>>>>> bpf_loop - throughput: 77.636 ± 1.748 M ops/s, latency: 12.881 ns/op
>>>>>>>>
>>>>>>>>    From this data, we can see that the latency per loop decreases as the
>>>>>>>> number of loops increases. On this particular machine, each loop had an
>>>>>>>> overhead of about ~13 ns, and we were able to run ~70 million loops
>>>>>>>> per second.
>>>>>>> The latency figures are great, thanks! I assume these numbers are with
>>>>>>> retpolines enabled? Otherwise 12ns seems a bit much... Or is this
>>>>>>> because of qemu?
>>>>>> I just tested it on a machine (without retpoline enabled) that runs on
>>>>>> actual
>>>>>> hardware and here is what I found:
>>>>>>
>>>>>>                nr_loops: 1
>>>>>>        bpf_loop - throughput: 46.780 ± 0.064 M ops/s, latency: 21.377 ns/op
>>>>>>
>>>>>>                nr_loops: 10
>>>>>>        bpf_loop - throughput: 198.519 ± 0.155 M ops/s, latency: 5.037 ns/op
>>>>>>
>>>>>>                nr_loops: 100
>>>>>>        bpf_loop - throughput: 247.448 ± 0.305 M ops/s, latency: 4.041 ns/op
>>>>>>
>>>>>>                nr_loops: 500
>>>>>>        bpf_loop - throughput: 260.839 ± 0.380 M ops/s, latency: 3.834 ns/op
>>>>>>
>>>>>>                nr_loops: 1000
>>>>>>        bpf_loop - throughput: 262.806 ± 0.629 M ops/s, latency: 3.805 ns/op
>>>>>>
>>>>>>                nr_loops: 5000
>>>>>>        bpf_loop - throughput: 264.211 ± 1.508 M ops/s, latency: 3.785 ns/op
>>>>>>
>>>>>>                nr_loops: 10000
>>>>>>        bpf_loop - throughput: 265.366 ± 3.054 M ops/s, latency: 3.768 ns/op
>>>>>>
>>>>>>                nr_loops: 50000
>>>>>>        bpf_loop - throughput: 235.986 ± 20.205 M ops/s, latency: 4.238 ns/op
>>>>>>
>>>>>>                nr_loops: 100000
>>>>>>        bpf_loop - throughput: 264.482 ± 0.279 M ops/s, latency: 3.781 ns/op
>>>>>>
>>>>>>                nr_loops: 500000
>>>>>>        bpf_loop - throughput: 309.773 ± 87.713 M ops/s, latency: 3.228 ns/op
>>>>>>
>>>>>>                nr_loops: 1000000
>>>>>>        bpf_loop - throughput: 262.818 ± 4.143 M ops/s, latency: 3.805 ns/op
>>>>>>
>>>>>> The latency is about ~4ns / loop.
>>>>>>
>>>>>> I will update the commit message in v3 with these new numbers as well.
>>>>> Right, awesome, thank you for the additional test. This is closer to
>>>>> what I would expect: on the hardware I'm usually testing on, a function
>>>>> call takes ~1.5ns, but the difference might just be the hardware, or
>>>>> because these are indirect calls.
>>>>>
>>>>> Another comparison just occurred to me (but it's totally OK if you don't
>>>>> want to add any more benchmarks):
>>>>>
>>>>> The difference between a program that does:
>>>>>
>>>>> bpf_loop(nr_loops, empty_callback, NULL, 0);
>>>>>
>>>>> and
>>>>>
>>>>> for (i = 0; i < nr_loops; i++)
>>>>>     empty_callback();
>>>> You are basically trying to measure the overhead of bpf_loop() helper
>>>> call itself, because other than that it should be identical.
>>> No, I'm trying to measure the difference between the indirect call in
>>> the helper, and the direct call from the BPF program. Should be minor
>>> without retpolines, and somewhat higher where they are enabled...
>>>
>>>> We can estimate that already from the numbers Joanne posted above:
>>>>
>>>>                nr_loops: 1
>>>>         bpf_loop - throughput: 46.780 ± 0.064 M ops/s, latency: 21.377 ns/op
>>>>                nr_loops: 1000
>>>>         bpf_loop - throughput: 262.806 ± 0.629 M ops/s, latency: 3.805 ns/op
>>>>
>>>> nr_loops:1 is bpf_loop() overhead and one static callback call.
>>>> bpf_loop()'s own overhead will be in the ballpark of 21.4 - 3.8 =
>>>> 17.6ns. I don't think we need yet another benchmark just for this.
>>> That seems really high, though? The helper is a pretty simple function,
>>> and the call to it should just be JIT'ed into a single regular function
>>> call, right? So why the order-of-magnitude difference?
>> I think the overhead of triggering the bpf program from the userspace
>> benchmarking program is also contributing to this. When nr_loops = 1, we
>> have to do the context switch between userspace + kernel per every 1000
>> loops;
>> this overhead also contributes to the latency numbers above
> Right okay. But then that data point is not really measuring what it's
> purporting to measure? That's a bit misleading, so maybe better to leave
> it out entirely?
Sure, I will leave this nr_loops = 1 datapoint out in v3 of this 
patchset :)
The overhead of triggering the bpf program from the userspace benchmarks
is present in every datapoint, but for nr_loops = 1, it's especially 
emphasized
since this overhead is per 1000 loops whereas for other datapoints, it is
per every 1000 * nr_loops.
> -Toke
>
