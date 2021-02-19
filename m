Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8C3201E6
	for <lists+bpf@lfdr.de>; Sat, 20 Feb 2021 00:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBSXhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 18:37:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229796AbhBSXhD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 18:37:03 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11JNYW9b011245;
        Fri, 19 Feb 2021 15:36:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+YMjfVS6x6kH8QW1mhl1RxxTt33XqHmcKErhvOiYUic=;
 b=olgLlU02Ehwg1YclovQbFy/BTdnIgtpkI5v2b6eTCdYm0VSD0wirryLCbq3RTeVcgSue
 HPEiHGrTvHZgaz8XNtPVDMcy13Qkq1U6wd1uacPuL2p8mUBR4Y5E7cYjKXzaaZxHPxG0
 crRvh1p1XMkhLfrXRgfjmo7TwKKohpzYxaU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36sc29w7b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Feb 2021 15:36:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Feb 2021 15:36:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsHYmG4W1Q2bLImCPmG02uzE3mVYn3C7N5mwHnJAHJjbFknxqbjfBHt1v1OKD0suBP+ryv5V1yBBfHTFWoJaGuHzZ8xDCkqd7Fh+ugiIG13f1rLMMbKgH0uMkurtO9F9F35UXXqOXrKPSfaPb6GvPNMPNMVUOE8WWBAmPkorfy2hbH9G5pQ+ZXfHKsGzH+2y0583HJ+JQJJpUKLFRDdJs3Fx51sIImmiOfT+PG9iisvGcTI3XnPTGAPbLfXA3sKmFaZ6fOlpfa80yWMBRA6cLkbPoeh0u+9X4Acte5gumPygWYoLFGxs2VYZKRnSp36v1FAIhxD3dHSN0n8HTkjN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YMjfVS6x6kH8QW1mhl1RxxTt33XqHmcKErhvOiYUic=;
 b=JQuv/oukjPoydMkkqQTYWoG4+TZ/OCxmATb3LRqxeMQFo/1gcnsnqW1bswBIgn5V4FWXHp3L67uqU+t41FfkXiiCfvezq6BVQUH24g/Xr5UcPM9etWfcc5jppK7pEEEpq1jKTaeY8opnIaXhy2MQouezqLIGUKlkAzgpCOx5mHrXoQVGrkXsNyCuXXIROqZTYpdcRAoV/kOj5uJDuLTPuQi1bIoug0pQaeYTbDx4i6N4fRZYitDpeCyKez/0nS+T1R0TXl17C9LG6NWHIR+Mf+r+aMGsT6FTSKUlSXxBx5XCV6XnBCMQ3943qwv3L5oDVHzJS8rVcmAlykiRHithzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4488.namprd15.prod.outlook.com (2603:10b6:a03:375::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Fri, 19 Feb
 2021 23:36:01 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 23:36:01 +0000
Subject: Re: [PATCH v2 bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
 <20210219022543.20893-3-iii@linux.ibm.com>
 <3503fca1-9702-97bc-5385-d36919cb50a4@fb.com>
 <0184706c7c4ba2d4a2c3a64d5bd51e5e7d65d3b5.camel@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a5dacc42-66cf-ed1b-812c-d54bf7d42c2c@fb.com>
Date:   Fri, 19 Feb 2021 15:35:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <0184706c7c4ba2d4a2c3a64d5bd51e5e7d65d3b5.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c091:480::1:fa3e]
X-ClientProxiedBy: BL1PR13CA0463.namprd13.prod.outlook.com
 (2603:10b6:208:2c4::18) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11c9::15b8] (2620:10d:c091:480::1:fa3e) by BL1PR13CA0463.namprd13.prod.outlook.com (2603:10b6:208:2c4::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.11 via Frontend Transport; Fri, 19 Feb 2021 23:35:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba628094-ce50-45ed-fd6d-08d8d52f1dd5
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4488:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB44887AB0CEE791D3E254AD0DD3849@SJ0PR15MB4488.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHVu36v59Y0jAn657fs12i6qwscM1kozhxFvbL7DH20iFD7YsrOhTWBGuEk2dBp0JarELJbvF4plYLMgvF8Gdq6IDp5L7QPaLrdJwbaYj2xNmEY0OvX4E7aFMxX2Yd7qscjTq2/620Mz2bli7TcfjmS8GJ/TyEMoUkhr6B6zWcx3urLpi6f0yOWSBfTJK4rADNy2RS+VC7pFJ8i25W3vjOlyI23Zuj+A83BCOegY52N9bnrn59vK+0loMkmB0aask2cmYVctC+w4PNmBcaV2B9mgiAbq1M69G1rSV6pqLbR4s4sXx8895W71wGtAAFxlrzGxlOl8qAIvBuBtAhdfgHv3dj9pSHLLrNgNg7MwDL5OtH24OnUw42j0C1w+PflO0MQuBtXdBH7xRm0eszoLt705bW2qLCCtJ0jJnTyd7sGdo/g+5P57Zu9zQobsBTiVW5FDDFMAVrKzQ/yzUH3YB4805JupDJVZou5TOLPYI7XP430zvwUDsDWd0TLU+KC2hRz9BXRFb2e9uUTBjW19vhm3zYg9tWiDa5HqGe1E1kRcPkRGdI+9EiHC6qqUBcKo6NThI1ZaqYfQ8RhevnZ3wQB52kqEzGzMxtM7DcYgPfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(346002)(376002)(8936002)(4326008)(66556008)(54906003)(86362001)(83380400001)(66476007)(6486002)(36756003)(478600001)(316002)(2906002)(8676002)(66946007)(110136005)(2616005)(6666004)(5660300002)(53546011)(52116002)(16526019)(31696002)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dVdDbktYSVYvWUhMbWUxdmxoMklVeWlqclp0WUluMWZWUFR6a0RCb0pxaUtn?=
 =?utf-8?B?V0ljL3krK3lhbzdXT1ZWYlpXSnhBeENmM28rY1dOcThzQmo4QWFyak4rbzc1?=
 =?utf-8?B?L1FpVEgvL0hNU1ZvbzVGY2JUU1NzSitIaDQ5Sjc3c2F5bUh4QzJVUXBnR002?=
 =?utf-8?B?dmk2NS9CNVRiZEpBVStMYTFHT1pjMjlQakJ5QVpwRENQYnF3emgyQTdjWjFY?=
 =?utf-8?B?VmNhM00xMnd1akdyeWt6SnhXUCticlJCWW16cXo3ZjV4bWYxdTVDSW92TzFD?=
 =?utf-8?B?QmxLczU5cW9lem9aZXhKS2lydDBJQlFEYWd3TFpna2U2bHd0RnNwQkhYZnpo?=
 =?utf-8?B?T2l5bzN3LzUzSXU0UUU4TUxUVDdsQVNtZTMxMnV3VU1vQktmUHRVcmFqM1J0?=
 =?utf-8?B?dlI5WWhtcjNpRzVWMlJPZjdFLzk1Z0w0ekptRk9kcDBmUVdGVHRTRHdhdGNU?=
 =?utf-8?B?Nlk0cXR1YzVlaGJuZEQ1QzlDRDRZR1RsbXoraEgrM0lvdTF1YVNQcFVYSEFo?=
 =?utf-8?B?OXNUbmxEN0tCb0ZHT093OGtxVnlndkVlQUZpdlBQdmN6Y1VDK2NQYURoUXdQ?=
 =?utf-8?B?bkwvMTBzZTNsbFJnazlBVHNMdVBlQVNJWGNvSjBzKzlObk56c2g4U051K2Ru?=
 =?utf-8?B?SEpXM2NPdmxaZ05Hdlh2NG5EdzhsWnpvYTBld05KaTR6K01vbStnRHcyK2Vy?=
 =?utf-8?B?UUQ0RmMyNnJheVZHamllaXZ3WEpEY09VQlEyMmJsTnMzUkdHRStNVWc2VzE0?=
 =?utf-8?B?eVNjZGtNTnJRa05ycnIyaGdFcGlMOENmS0RNdmkvWUV2WE5oSm8zaDNZaDlr?=
 =?utf-8?B?T09qR0ZYcUdpVXBGUWlrNE1RWWlzVjJwdGpXM3ptS3lla0VqaFN2czdVVFBE?=
 =?utf-8?B?b3dIYzJaaFYyYzRoWUgwd0lzYTNOQy9BT01kS3Q4aXhFaGtwamh5Qnh0cmZo?=
 =?utf-8?B?Z1U0RFRQNTJsdms4dVV2eEhtMGt6Rld0WWptUDNZbk11UFU5YzlaaGI5OGJ2?=
 =?utf-8?B?OEpxNUhPOUxFM3Zmb0dsZkUyZTN3M1NjNlNaT3ZmOFlyU0ZVQWg0MFJ4M2Jy?=
 =?utf-8?B?YXNlZ01SbjVpYlVESUhabkNRZmdHakxaVkljT1Z0TDBoYXUzSzFtQ0w3M0N6?=
 =?utf-8?B?MjFIc3h2T09CZUUxVHBwNUdPanhpdGEvSWxvMWI4eC9udGZFTVZyeUZZYnpM?=
 =?utf-8?B?WlQzKzVCcmk0K1hRT2Ziby90UVVqVFZ4L3hBTXlnOEZiVWkvL2FlUjRDUEZT?=
 =?utf-8?B?Q2krUGZBa2JKa2NJV1piR0FaVGZRTjQ4UkVCQS9ydzRLVi9QbCtzallxL3h6?=
 =?utf-8?B?RUhXbzBSUGlMZTFSVm41VFVjUGhlTVUveHlLWi9XVEVQTEc0ckNaVmxtdXRQ?=
 =?utf-8?B?b1AvdHNDT0gwWHBlell2NjJDeFRFSVZ6MUYrendyN1dsS0hleFNtVzFhR1g5?=
 =?utf-8?B?bG9mbWx1eE5yemtLTVNpVUU5NTBCZ2tPOXI3SE44UStWeGQwOTEvY0R2OFFO?=
 =?utf-8?B?T0FWSHVIVUVoSSt0VVE5VEVvaUR4UmFUcU1UcWdpV0lNYUxmaTY0UFdGSjVu?=
 =?utf-8?B?ZElsQjljUzE2Y05lOXM1S1RYSkpzTzMvcEMxU0ovRVNhQlZ4VDM5UGR1N0ts?=
 =?utf-8?B?c1VRSzlPWVVWaFZhZThNaS9ZdjA1QVUwYXNCSnNrZXF3bVgzQkxVUGMwT0lZ?=
 =?utf-8?B?OENvamNrakVmL2tBMFY0c2lkb004UmZYSzRkOUdmQklEc251cWlGU0JHT0xI?=
 =?utf-8?B?b2xtb1p6Z3dvZkdMMVExby9LSERIQ1ZacW9pSWUwcVRWLzF6M1ZxbDVIZ3dJ?=
 =?utf-8?B?MUNpRVFuOG9EUXJNN054UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba628094-ce50-45ed-fd6d-08d8d52f1dd5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 23:36:01.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vonbGrNyG6ypubLhi2inSgIQ9eoJ+UwrEB/vCbyTcSLe3DHKC0f9JWXKna1TYjzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4488
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190192
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/21 3:01 PM, Ilya Leoshkevich wrote:
> On Thu, 2021-02-18 at 20:22 -0800, Yonghong Song wrote:
>>
>>
>> On 2/18/21 6:25 PM, Ilya Leoshkevich wrote:
>>> The logic follows that of BTF_KIND_INT most of the time.
>>> Sanitization
>>> replaces BTF_KIND_FLOATs with BTF_KIND_TYPEDEFs pointing to
>>> equally-sized BTF_KIND_ARRAYs on older kernels.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    tools/lib/bpf/btf.c             | 44
>>> ++++++++++++++++++++++++++++++++
>>>    tools/lib/bpf/btf.h             |  8 ++++++
>>>    tools/lib/bpf/btf_dump.c        |  4 +++
>>>    tools/lib/bpf/libbpf.c          | 45
>>> ++++++++++++++++++++++++++++++++-
>>>    tools/lib/bpf/libbpf.map        |  5 ++++
>>>    tools/lib/bpf/libbpf_internal.h |  2 ++
>>>    6 files changed, 107 insertions(+), 1 deletion(-)
>>>
>> [...]
>>> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
>>> index 2f9d685bd522..5e957fcceee6 100644
>>> --- a/tools/lib/bpf/btf_dump.c
>>> +++ b/tools/lib/bpf/btf_dump.c
>>> @@ -279,6 +279,7 @@ static int btf_dump_mark_referenced(struct
>>> btf_dump *d)
>>>                  case BTF_KIND_INT:
>>>                  case BTF_KIND_ENUM:
>>>                  case BTF_KIND_FWD:
>>> +               case BTF_KIND_FLOAT:
>>>                          break;
>>>    
>>>                  case BTF_KIND_VOLATILE:
>>> @@ -453,6 +454,7 @@ static int btf_dump_order_type(struct btf_dump
>>> *d, __u32 id, bool through_ptr)
>>>    
>>>          switch (btf_kind(t)) {
>>>          case BTF_KIND_INT:
>>> +       case BTF_KIND_FLOAT:
>>>                  tstate->order_state = ORDERED;
>>>                  return 0;
>>>    
>>> @@ -1133,6 +1135,7 @@ static void btf_dump_emit_type_decl(struct
>>> btf_dump *d, __u32 id,
>>>                  case BTF_KIND_STRUCT:
>>>                  case BTF_KIND_UNION:
>>>                  case BTF_KIND_TYPEDEF:
>>> +               case BTF_KIND_FLOAT:
>>>                          goto done;
>>>                  default:
>>>                          pr_warn("unexpected type in decl chain,
>>> kind:%u, id:[%u]\n",
>>> @@ -1247,6 +1250,7 @@ static void btf_dump_emit_type_chain(struct
>>> btf_dump *d,
>>>    
>>>                  switch (kind) {
>>>                  case BTF_KIND_INT:
>>> +               case BTF_KIND_FLOAT:
>>>                          btf_dump_emit_mods(d, decls);
>>>                          name = btf_name_of(d, t->name_off);
>>>                          btf_dump_printf(d, "%s", name);
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index d43cc3f29dae..3b170066d613 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -178,6 +178,8 @@ enum kern_feature_id {
>>>          FEAT_PROG_BIND_MAP,
>>>          /* Kernel support for module BTFs */
>>>          FEAT_MODULE_BTF,
>>> +       /* BTF_KIND_FLOAT support */
>>> +       FEAT_BTF_FLOAT,
>>>          __FEAT_CNT,
>>>    };
>>>    
>>> @@ -1935,6 +1937,7 @@ static const char *btf_kind_str(const struct
>>> btf_type *t)
>>>          case BTF_KIND_FUNC_PROTO: return "func_proto";
>>>          case BTF_KIND_VAR: return "var";
>>>          case BTF_KIND_DATASEC: return "datasec";
>>> +       case BTF_KIND_FLOAT: return "float";
>>>          default: return "unknown";
>>>          }
>>>    }
>>> @@ -2384,18 +2387,22 @@ static bool btf_needs_sanitization(struct
>>> bpf_object *obj)
>>>    {
>>>          bool has_func_global =
>>> kernel_supports(FEAT_BTF_GLOBAL_FUNC);
>>>          bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
>>> +       bool has_float = kernel_supports(FEAT_BTF_FLOAT);
>>>          bool has_func = kernel_supports(FEAT_BTF_FUNC);
>>>    
>>> -       return !has_func || !has_datasec || !has_func_global;
>>> +       return !has_func || !has_datasec || !has_func_global ||
>>> !has_float;
>>>    }
>>>    
>>>    static void bpf_object__sanitize_btf(struct bpf_object *obj,
>>> struct btf *btf)
>>>    {
>>>          bool has_func_global =
>>> kernel_supports(FEAT_BTF_GLOBAL_FUNC);
>>>          bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
>>> +       bool has_float = kernel_supports(FEAT_BTF_FLOAT);
>>>          bool has_func = kernel_supports(FEAT_BTF_FUNC);
>>>          struct btf_type *t;
>>>          int i, j, vlen;
>>> +       int t_u32 = 0;
>>> +       int t_u8 = 0;
>>>    
>>>          for (i = 1; i <= btf__get_nr_types(btf); i++) {
>>>                  t = (struct btf_type *)btf__type_by_id(btf, i);
>>> @@ -2445,6 +2452,23 @@ static void bpf_object__sanitize_btf(struct
>>> bpf_object *obj, struct btf *btf)
>>>                  } else if (!has_func_global && btf_is_func(t)) {
>>>                          /* replace BTF_FUNC_GLOBAL with
>>> BTF_FUNC_STATIC */
>>>                          t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0,
>>> 0);
>>> +               } else if (!has_float && btf_is_float(t)) {
>>> +                       /* replace FLOAT with TYPEDEF(u8[]) */
>>> +                       int t_array;
>>> +                       __u32 size;
>>> +
>>> +                       size = t->size;
>>> +                       if (!t_u8)
>>> +                               t_u8 = btf__add_int(btf, "u8", 1,
>>> 0);
>>> +                       if (!t_u32)
>>> +                               t_u32 = btf__add_int(btf, "u32", 4,
>>> 0);
>>> +                       t_array = btf__add_array(btf, t_u32, t_u8,
>>> size);
>>> +
>>> +                       /* adding new types may have invalidated t
>>> */
>>> +                       t = (struct btf_type *)btf__type_by_id(btf,
>>> i);
>>> +
>>> +                       t->info = BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0,
>>> 0);
>>
>> This won't work. The typedef must have a valid name. Otherwise,
>> kernel
>> will reject it. A const char array should be okay here.
> 
> Wouldn't it reuse the old t->name? At least in my testing with v5.7
> kernel this was the case, and BTF wasn't rejected. And the original
> BTF_KIND_FLOAT always has a valid name, this is enforced in libbpf and
> in the verifier. For example:
> 
> [1] PTR '(anon)' type_id=2
> [2] STRUCT 'foo' size=4 vlen=1
> 	'bar' type_id=3 bits_offset=0
> [3] FLOAT 'float' size=4
> [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> 	'f' type_id=1
> [5] PTR '(anon)' type_id=0
> [6] FUNC 'func' type_id=4 linkage=global
> 
> becomes
> 
> [1] PTR '(anon)' type_id=2
> [2] STRUCT 'foo' size=4 vlen=1
> 	'bar' type_id=3 bits_offset=0
> [3] TYPEDEF 'float' type_id=9
> [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> 	'f' type_id=1
> [5] PTR '(anon)' type_id=0
> [6] FUNC 'func' type_id=4 linkage=global
> [7] INT 'u8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
> [8] INT 'u32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [9] ARRAY '(anon)' type_id=7 index_type_id=8 nr_elems=4

good point, the name is indeed there.

I originally also thought about using "typedef" but worried
whether new typedef may polute the existing type names.
Could you try to dump the modified BTF to a C file
and compile to see whether typedef mechanism works or not?
I tried the following code and compilation failed.

-bash-4.4$ cat t.c
typedef char * float;
-bash-4.4$ gcc -c t.c
t.c:1:16: error: expected identifier or ‘(’ before ‘float’
  typedef char * float;
                 ^
-bash-4.4$

Changing to a different name may interfere with existing types.

It may work with the kernel today because we didn't do strict type 
legality checking, but it would be still be good if we can
avoid it.

> 
