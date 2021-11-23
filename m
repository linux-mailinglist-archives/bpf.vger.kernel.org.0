Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A9D459B0D
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 05:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhKWEWO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 23:22:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11036 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229947AbhKWEWN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 23:22:13 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN1AIX0032760;
        Mon, 22 Nov 2021 20:18:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SdmArS8qj3F/s5CnZw816EFz8gAx2R+jtBEQydlIhuk=;
 b=bgT4LNtdM4CBfHfokSIBfvU0m716jVvFO/g4VcD7CDyTR4EElX/BJ6ceLOsj6RlKMHec
 42RqrCupO2sDC8TUzh239gwNV8crvfsCIknjnkaUlN6LT7h6dwCODm37fDt1zJ84nvKY
 aE2P9Uc5xecW0FYRJGCcmzAtCSrVv6fRgs0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cgpcy0rmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Nov 2021 20:18:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 22 Nov 2021 20:18:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVOIo/EwNzJIPC0Qn1q6vGD8WB6ptsXz5oQfYLBEV7Ku1fdkQtKt0cn/DJYEhVVyhHYoz/s7h10/nodFjWiTwlxGkfeep2xwYbxtBKjzvEtjGbwvIXRlvXRNAlcRaZvLFKnOOc/6lxDGiY7VwAjv9fu36DeyjQLbg2ddCSER7kBCsdsI0hXAKIixfp6FlbKbmzVWcFk63J9ANO4dsLObz/KWxYxfQHHZgJhauEa01rFXCH8C+PJENEMKsCNz4FxqtZCSkBtRVbaCYcrApDPk2gYWjxzDMYYrbqg8OfyzI+kcf3A/253AOagGyMTW3zDMrtXAns6e0aXdCYiXFsN0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZReXgI+uUbPQQiHrSe86m+OQVu1GZnvpRjoLxaLJP1g=;
 b=MOOVoDr7bKNQt+ADQWaJvd5yxTwDtMDxz3bT2pLZpvzbbZmLalfJ8hyAlxedll3iKLpDcKyPcYiNz6G4WPwesxOPTkjbm5a1xt8BINbKG95o45hQT4sO2sL3oqH6zKIDsxHVH74IwhDUs8g4qbSivcGl/H6g34gk9IFouA0k5daphC6AWMFwhNFhgSaRLkn01peNyOyKdVrXb2QXZywzuRkBoBpGQP7GnxqQQmOVIHMRikWIFhwjaHPpvPN1GXsT0p7RSYC0X6fabLqdEUnd7GRAuc+td4iRdrypoQGGO91gISPBV0vbCpG+rVQ9Lf/GM/qs3oX/MH5Rc5qfkMC99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4158.namprd15.prod.outlook.com (2603:10b6:806:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 04:18:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 04:18:41 +0000
Message-ID: <190dfc25-c64f-4b79-7643-ad6b4036d6ea@fb.com>
Date:   Mon, 22 Nov 2021 20:18:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH dwarves 3/4] dwarf_loader: support btf_type_tag attribute
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20211117202214.3268824-1-yhs@fb.com>
 <20211117202229.3270304-1-yhs@fb.com>
 <CAEf4Bzbcx0ExE+TsOL4G+56KZ3dLs5vJV_y1=9_Cpt=4Y=c5uA@mail.gmail.com>
 <139df0c0-4379-b6ef-00fc-140adac17da5@fb.com>
 <CAEf4Bzazbn6A-nSxvDj44Jvf2w3JwHLC8428y=a6kWE_fOjAHA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4Bzazbn6A-nSxvDj44Jvf2w3JwHLC8428y=a6kWE_fOjAHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21e1::14f6] (2620:10d:c090:400::5:b4f1) by MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend Transport; Tue, 23 Nov 2021 04:18:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32dc0341-df14-49e5-7f5b-08d9ae3854cf
X-MS-TrafficTypeDiagnostic: SN7PR15MB4158:
X-Microsoft-Antispam-PRVS: <SN7PR15MB4158F38DF0A9109685D698A4D3609@SN7PR15MB4158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCQu6JWTi++tBVzkhEeOx5PrtKPI34vOLW3REFdvF8/i8sF7Qy4sEP/Engn6ND6T1G8LQwcyH6seUgycCxKUh1XB0zO3lsySfeUexqh6jYxju+cIOpjr2d9oqoZ7UIonGL/XMKqKW0Y/I+e+EmAzEwgKqUKFawuIZdc48DVjE101+yAW9uEzrGmDIdhz/Ep+cs1OzEILiQ4cxzZvbc8I/c1eSGU3uRZo30T1xoXLUv4hzqAnjcGg0MnPtArzX32BRG+GqSHLccNvv6qfN6Cb1kNOFiQ0GXOx+HGW1RsYmcSnycu81vbHdj+Om5PHy6MtYEXwB/zRsTAX3p7BLq/QoCS4P6vmdo8z8VmkMFh6QQqB7EOy1AJJzvLItxoJ4Z3HPxRkNICQHrg3oUK0PWJUny2Wyc4YcBGIdrbSqABACZR1f2AxmEJGvOCDCC9W9srbjMUJy0KH+MIZFgeOyYXzBsAMlnff+bC5smq+JN1w2S9sGCOm8OR58kfvgvNDXbymJfps/4on++e57pNKPMZUdT/yj9nIDjmFb+X3g/DPFH9oQdIqkhNJhlcbCVf/MxJxgJ+NvSFr29QaAWivhMZLhP+C5ytM/HVZ7+OL9MiEaFrtkzIaMXxDElYmAfFaWEXqkBSmeYeeicRRqoz7NoYGSNB0r5Ey5VdK2ZP7nXYnUHOuBr3vw/cKjcGCvS9UxrsdMS032s9ofZfzcH7G5/8ITvk1Zc5fSqH+1ZmT6f5R+YHisYQvvxt/U/JBIEd4BaycdIkjvb1wUiueXn/HEpzEjOrWv459hnDHI3mYxJ8meLlHwAFVFAaxQN0LzdYPUAE8CVJhY8fU78+ZQwl4wdj8vxRrprMKSlBmHHfRbM9UXE29+MyGxKMMRlL8yNMEwWXr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(316002)(6486002)(38100700002)(53546011)(31696002)(36756003)(186003)(83380400001)(31686004)(8676002)(2906002)(4326008)(5660300002)(54906003)(86362001)(66946007)(66476007)(966005)(2616005)(8936002)(52116002)(66556008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amg1N2pHeXNqZXBzMEl6aFBXMzE0WU1Ob0lpZ09XSW9ZQW9OMTlRVHdyRlZJ?=
 =?utf-8?B?bW10K3hBR2RETFEySTNoZ2RObXZZRUNmS05jb3pUMWx0Q0lURjNZYytQNFdo?=
 =?utf-8?B?L1VvOXVoYXFNNXFoNG03NU9VSkF0d0FXZ2hiWDE3cWI0K1dUb1hYdmQ5c0FW?=
 =?utf-8?B?RzJBUUswUlcrZHpCWjYwQmc2UWJNYXdRVWs1amN6d0xzQU14VHBNUWdJTmZM?=
 =?utf-8?B?cTdPcTNScHpYcTdKcGh2Zm1nZ1RFNGw0b0tBcks2elhiVnJyRDFCN2x5ekJm?=
 =?utf-8?B?ZkF5OGZWRWVWQkpMVHRELzV6NFE3RktNbWNORTJOMHVTNnN1V2tYSG1BZUFP?=
 =?utf-8?B?N2VxMGtKOUs3RUZPbVRWbkh1Z3hHc0pTSlJLVUxnejJRbTUwcUpVTXlUSW5I?=
 =?utf-8?B?RzNjMGd5ZUc4YTVOdnp6RzViQjFqa1ZXSGF0aHJ5dzV4RzQvTHpxVGJ3V0NE?=
 =?utf-8?B?cWZhZExGbVhKL2RkVlc3SEJOZXFyVS9Mcy82NkR2dTJXL25Jckc0cHJObFZV?=
 =?utf-8?B?UkRiWWI1UDN2L203elB3QXA2RzlWNjZTSzNhNUV2dTMxTGNyNUVxSXIrVUlz?=
 =?utf-8?B?bnN1aXQxdEhQZTlGVkQ1aHV0STYzRzVOVGkvWkdBdHZySTl5Rjl5cmNNOTBQ?=
 =?utf-8?B?MTl3TDZHWlhBYmlvcUk3a04xMnJicGpRUitBSEtBWUN4VXh3eE5Bc2NzbDlr?=
 =?utf-8?B?UHQ2REw3U1psc2FGekwxY0taUUR2d0dXN1AxdWJTMUcrbS9jRUZ5QXkzc1Rx?=
 =?utf-8?B?dkU4UzB5d3l1V09zVm1RT1EzclovaGRPZTZ1RTVRbGRHb1pYYkNKSDlXQ0Nr?=
 =?utf-8?B?U0Niek5TYkVtZjE1WXJrTm14RXlqY1E1NjY4b2lod2Y3a3FvY0IvNmVvUVor?=
 =?utf-8?B?YnZObGpOLzBFK0JSNktDVkgwNTdHaFEydFo3c0lEcjdTMkppdG9obGZ1N0RX?=
 =?utf-8?B?cG41cDNzanptUE1ZK3VRSWVabmIydTcxV3R1L1BEUlQ1d0c0U05Ia1pkNWpa?=
 =?utf-8?B?SzVmUm5MSXlHSXFyaTUrWmdHemFBZ2pBaGFudGJYdDc2VlltbG9GU1E0SFo0?=
 =?utf-8?B?eDhZN2hyY2VSb2tHRmhLUHhyZWhhc2FyUmJISFRqbExROUlId0E3VDc3NE5X?=
 =?utf-8?B?VGFMc2E0dTNYNDNDUGdKWWsyaU5rMWZIMUo1aUNrTDBIRGY5UnV0emNNWHJi?=
 =?utf-8?B?RisxZ1pDNTVJSzROTlY1dXdDaU5SQlpJcEZSNm5TUUlvZU84bTJWb3d2V0pZ?=
 =?utf-8?B?WGpZbzR2NHliNVRNaWZGVFRGZ2NuekNaYlFhVjE0dHpUUkFQaXBoUjR3TzFD?=
 =?utf-8?B?eGE5dlZabFhmK3ZnZGZIaldlNVAzekVyNCtKajJ1Zkl4Z0Y3MERnS2ZpbVd5?=
 =?utf-8?B?T2tBMmRrM2V1UDZaZGh4MVlEcFJhL25UM3M0dXlNNHpBUkVZYkdHZmRleGdS?=
 =?utf-8?B?L0dWY3ExVVdFdHJuQUZ0SUVhN0ZzdG1YZyt3ZmQ2aHVNUjNnNkN4Mk5nOGha?=
 =?utf-8?B?Q0JmeEI5dmU1d0p1dnVaSVZyTUN6UER6ZG9xVWdGVW5ocWdiemhSZ3NDWjVW?=
 =?utf-8?B?NzZ4amNFVERVYVNEd1Qwb1ByUFpqUDdBQTkxUE0yUTNYQVNaWE9tY0IvN3U0?=
 =?utf-8?B?bnhmR0hNcllCZXR4UlNKS0RxK1ZPdzZIVmI1L3c1TGE3L0EvaERIMHI2RGhw?=
 =?utf-8?B?WlVVTk5DMnprTWJIKzFoSTlmK085cThyeGhvQkVaMmlmdW9Ic2VpYVFZS3Ev?=
 =?utf-8?B?b1RKVGdXZGRKNS9keWFNNG9BSkdGUG90WVEwTnpUNEF5TFA0MVhWWFJMUjJR?=
 =?utf-8?B?OW42a0NJVTVDeFlDbTNuYStiSU5mTE45aHZjaEk1djBVOUpnaFo4TWxpUTZJ?=
 =?utf-8?B?dThJenRGK04remJXTHJSQ2Ixc1hqK2tKZnBKZlZMUmV2N1k2cXdnSmc2aW5x?=
 =?utf-8?B?WVUrRFc2SHM2blpla0VmN0JqK245SHcwRmRXcndyaWkwSHpsdlFZTWxTWE1m?=
 =?utf-8?B?MTVXa2JzcllEWHlYUGxiUkEwa2FjWU5KVng1bWNHNGhrb0ZZY1BGSXRIN3Fz?=
 =?utf-8?B?cFpZV0NLSDdyYVlRcDlsUkhpRDFtZ2kvYld4bi9sa1gzNFUzakVYQ1UyK1hz?=
 =?utf-8?B?YitjV3g1Zm1MTUpSS0NoQ3EzUUNhaytWZ2w4MTZxOTVuZGV5NFM2anF3S3Jm?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dc0341-df14-49e5-7f5b-08d9ae3854cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 04:18:41.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/kEmUyoe/+OO06c36HlF4Ck3/EgQbnjXMj4zbUm0YzJZNEgoDG/lIMi+rqJySFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4158
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 5WVgcyhEMkjKFCBejqK0wSzxLTZPcDcm
X-Proofpoint-GUID: 5WVgcyhEMkjKFCBejqK0wSzxLTZPcDcm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_01,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/22/21 7:45 PM, Andrii Nakryiko wrote:
> On Mon, Nov 22, 2021 at 7:32 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 11/22/21 5:52 PM, Andrii Nakryiko wrote:
>>> On Wed, Nov 17, 2021 at 12:25 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
>>>> added support for btf_type_tag attributes. The following is
>>>> an example:
>>>>     [$ ~] cat t.c
>>>>     #define __tag1 __attribute__((btf_type_tag("tag1")))
>>>>     #define __tag2 __attribute__((btf_type_tag("tag2")))
>>>>     int __tag1 * __tag1 __tag2 *g __attribute__((section(".data..percpu")));
>>>>     [$ ~] clang -O2 -g -c t.c
>>>>     [$ ~] llvm-dwarfdump --debug-info t.o
>>>>     t.o:    file format elf64-x86-64
>>>>     ...
>>>>     0x0000001e:   DW_TAG_variable
>>>>                     DW_AT_name      ("g")
>>>>                     DW_AT_type      (0x00000033 "int **")
>>>>                     DW_AT_external  (true)
>>>>                     DW_AT_decl_file ("/home/yhs/t.c")
>>>>                     DW_AT_decl_line (3)
>>>>                     DW_AT_location  (DW_OP_addr 0x0)
>>>>     0x00000033:   DW_TAG_pointer_type
>>>>                     DW_AT_type      (0x0000004b "int *")
>>>>     0x00000038:     DW_TAG_LLVM_annotation
>>>>                       DW_AT_name    ("btf_type_tag")
>>>>                       DW_AT_const_value     ("tag1")
>>>>     0x00000041:     DW_TAG_LLVM_annotation
>>>>                       DW_AT_name    ("btf_type_tag")
>>>>                       DW_AT_const_value     ("tag2")
>>>>     0x0000004a:     NULL
>>>>     0x0000004b:   DW_TAG_pointer_type
>>>>                     DW_AT_type      (0x0000005a "int")
>>>>     0x00000050:     DW_TAG_LLVM_annotation
>>>>                       DW_AT_name    ("btf_type_tag")
>>>>                       DW_AT_const_value     ("tag1")
>>>>     0x00000059:     NULL
>>>>     0x0000005a:   DW_TAG_base_type
>>>>                     DW_AT_name      ("int")
>>>>                     DW_AT_encoding  (DW_ATE_signed)
>>>>                     DW_AT_byte_size (0x04)
>>>>     0x00000061:   NULL
>>>>
>>>>   From the above example, you can see that DW_TAG_pointer_type
>>>> may contain one or more DW_TAG_LLVM_annotation btf_type_tag tags.
>>>> If DW_TAG_LLVM_annotation tags are present inside
>>>> DW_TAG_pointer_type, for BTF encoding, pahole will need
>>>> to follow [3] to generate a type chain like
>>>>     var -> ptr -> tag2 -> tag1 -> ptr -> tag1 -> int
>>>>
>>>> This patch implemented dwarf_loader support. If a pointer type
>>>> contains DW_TAG_LLVM_annotation tags, a new type
>>>> btf_type_tag_ptr_type will be created which will store
>>>> the pointer tag itself and all DW_TAG_LLVM_annotation tags.
>>>> During recoding stage, the type chain will be formed properly
>>>> based on the above example.
>>>>
>>>> An option "--skip_encoding_btf_type_tag" is added to disable
>>>> this new functionality.
>>>>
>>>>     [1] https://reviews.llvm.org/D111199
>>>>     [2] https://reviews.llvm.org/D113222
>>>>     [3] https://reviews.llvm.org/D113496
>>>> ---
>>>>    dwarf_loader.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++--
>>>>    dwarves.h      |  33 +++++++++++++-
>>>>    pahole.c       |   8 ++++
>>>>    3 files changed, 153 insertions(+), 4 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> +
>>>> +static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
>>>> +                                              struct conf_load *conf)
>>>> +{
>>>> +       struct btf_type_tag_ptr_type *tag = NULL;
>>>> +       struct btf_type_tag_type *annot;
>>>> +       Dwarf_Die *cdie, child;
>>>> +       const char *name;
>>>> +       uint32_t id;
>>>> +
>>>> +       /* If no child tags or skipping btf_type_tag encoding, just create a new tag
>>>> +        * and return
>>>> +        */
>>>> +       if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0 ||
>>>> +           conf->skip_encoding_btf_type_tag)
>>>> +               return tag__new(die, cu);
>>>> +
>>>> +       /* Otherwise, check DW_TAG_LLVM_annotation child tags */
>>>> +       cdie = &child;
>>>> +       do {
>>>> +               if (dwarf_tag(cdie) == DW_TAG_LLVM_annotation) {
>>>
>>> nit: inverting the condition and doing continue would reduce nestedness level
>>
>> good point. Will send another revision.
>>
>>>
>>>> +                       /* Only check btf_type_tag annotations */
>>>> +                       name = attr_string(cdie, DW_AT_name, conf);
>>>> +                       if (strcmp(name, "btf_type_tag") != 0)
>>>> +                               continue;
>>>> +
>>>> +                       if (tag == NULL) {
>>>> +                               /* Create a btf_type_tag_ptr type. */
>>>> +                               tag = die__create_new_btf_type_tag_ptr_type(die, cu);
>>>> +                               if (!tag)
>>>> +                                       return NULL;
>>>> +                       }
>>>> +
>>>> +                       /* Create a btf_type_tag type for this annotation. */
>>>> +                       annot = die__create_new_btf_type_tag_type(cdie, cu, conf);
>>>> +                       if (annot == NULL)
>>>> +                               return NULL;
>>>> +
>>>> +                       if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
>>>> +                               return NULL;
>>>> +
>>>> +                       struct dwarf_tag *dtag = annot->tag.priv;
>>>> +                       dtag->small_id = id;
>>>> +                       cu__hash(cu, &annot->tag);
>>>> +
>>>> +                       /* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
>>>> +                        * the tag->tags contains tag3 -> tag2 -> tag1.
>>>> +                        */
>>>> +                       list_add(&annot->node, &tag->tags);
>>>> +               }
>>>> +       } while (dwarf_siblingof(cdie, cdie) == 0);
>>>> +
>>>> +       return tag ? &tag->tag : tag__new(die, cu);
>>>> +}
>>>> +
>>>>    static struct tag *die__create_new_ptr_to_member_type(Dwarf_Die *die,
>>>>                                                         struct cu *cu)
>>>>    {
>>>> @@ -1903,12 +1985,13 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
>>>>           case DW_TAG_const_type:
>>>>           case DW_TAG_imported_declaration:
>>>>           case DW_TAG_imported_module:
>>>> -       case DW_TAG_pointer_type:
>>>>           case DW_TAG_reference_type:
>>>>           case DW_TAG_restrict_type:
>>>>           case DW_TAG_unspecified_type:
>>>>           case DW_TAG_volatile_type:
>>>>                   tag = die__create_new_tag(die, cu);             break;
>>>> +       case DW_TAG_pointer_type:
>>>> +               tag = die__create_new_pointer_tag(die, cu, conf);       break;
>>>>           case DW_TAG_ptr_to_member_type:
>>>>                   tag = die__create_new_ptr_to_member_type(die, cu); break;
>>>>           case DW_TAG_enumeration_type:
>>>> @@ -2192,6 +2275,26 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
>>>>           }
>>>>    }
>>>>
>>>> +static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type *tag,
>>>> +                                             uint32_t pointee_type)
>>>> +{
>>>> +       struct btf_type_tag_type *annot;
>>>> +       struct dwarf_tag *annot_dtag;
>>>> +       struct tag *prev_tag;
>>>> +
>>>> +       /* If tag->tags contains tag3 -> tag2 -> tag1, the final type chain
>>>> +        * looks like:
>>>> +        *   pointer -> tag3 -> tag2 -> tag1 -> pointee
>>>> +        */
>>>
>>> is the comment accurate or the final one should have looked like
>>> pointer -> tag1 -> tag2 -> tag3 -> pointee? Basically, trying to
>>> understand if the final BTF represents the source-level order of tags
>>> or not?
>>
>> The comment is accurate. Given source like
>>      int tag1 tag2 tag3 *p;
>> the final type chain is
>>      p -> tag3 -> tag2 -> tag1 -> int
>>
>> basically it means
>>      - '*' applies to "int tag1 tag2 tag3"
>>      - tag3 applies to "int tag1 tag2"
>>      - tag2 applies to "int tag1"
>>      - tag1 applies to "int"
>>
>> This also makes final source code (format c) easier as
>> we can do
>>      emit for "tag3 -> tag2 -> tag1 -> int"
>>      emit '*'
>>
>> For 'tag3 -> tag2 -> tag1 -> int":
>>      emit for "tag2 -> tag1 -> int"
>>      emit tag3
>>
>> Eventually we can get the source code like
>>      int tag1 tag2 tag3 *p
>> and this matches the user/kernel code.
> 
> It would be great to add that as a comment somewhere here, it's very
> hard to make this inference just from the code.

Will add detailed comments in next pahole revision and will also
add them in the next kernel btf_type_tag patch set.

> 
>>
>>>
>>>> +       prev_tag = &tag->tag;
>>>> +       list_for_each_entry(annot, &tag->tags, node) {
>>>> +               annot_dtag = annot->tag.priv;
>>>> +               prev_tag->type = annot_dtag->small_id;
>>>> +               prev_tag = &annot->tag;
>>>> +       }
>>>> +       prev_tag->type = pointee_type;
>>>> +}
>>>> +
>>>
>>> [...]
>>>
