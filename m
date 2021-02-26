Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3003266B7
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhBZSJT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 13:09:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13172 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbhBZSJO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 13:09:14 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QI4H5n030477;
        Fri, 26 Feb 2021 10:08:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cbpcUwoBzSbQ6s2AWEV9M2HKJ5enTV1JjE/mFWUdqJM=;
 b=dBMdF1oAibdIMSdlw0i1NqdyBd+Fanp4aWD8UOKuAiPcckyNPqkutPsrDD4xglLKiqEF
 CMVLBsPScG9y46YdmmMw5m0mNEyDJq+frfV9AIdENkaiM1UYmaBjWJvEYraPDLYtVUu+
 NomcdlhLyo+++G7bak9hSphtqpceRn/0hCI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36xqsw43xd-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Feb 2021 10:08:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 10:08:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0/HwkYbM1PS6pYRfvFLOMI/N6mf9CIxQhbIEn82LUJGlOCjEBiJrVCToNrAO5SaBkbjJr/cihfGnm1dG1PcLPFiy0u6hNMR2HopcKgEKcDXVjNhIQOzqg187q9tzKEQb6jqmsdU7Ka0cqWh8V9DbFepF77LdGkYNzr23v6GVXjsdsy2EdZQuuZ+va/Gn+cY/tFL4hZL4sAlZg4uCxcYYrhECc7wsDbiDoBaFcDf9qPTassdpkN2UniAjT6yobuOJ8+N3LxTpMpeE813zelsIYO2YBBdfqKKOUSp7nGy3lBf3O+V4AKts4C5RCpvz1y53nDJWCscbSlV2EfxfdLgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbpcUwoBzSbQ6s2AWEV9M2HKJ5enTV1JjE/mFWUdqJM=;
 b=Y3vemXyK7bSO/H2uRI5b0gPYjEg3RlGNa7H78FeAZ5BuUQ6Ew0hq9CR61idNUhhyq35bi4g4r+hcfJhNHZxOmjjeEfQmghkUPfSSleTgdPSHdJN3a1du1sp8I7DViv+r5J8G9L/RfAG7HyqoFXnoroY3y7LJsyKm1N/U/BqqswAkgDch12u4J3mY4dtV3p8roKWwsiIRosVkFMDD+GSXDW/4qh1+kIndW/LYa/KcMDdClctiIGuyB37jIUPs6tUZBgXvgcpHkW1RJWLwpCfHTy1SB2aFsgq1ZzIzaKr9ANt+xXbFe2ZyZsFJ9o7GEbg4rIQ1adqEUzRP5GFZoKSK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2461.namprd15.prod.outlook.com (2603:10b6:805:24::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 18:08:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 18:08:27 +0000
Subject: Re: Enum relocations against zero values
To:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <CACAyw9-XZ4XqNP1MZxC1i7+zntVAivopkgRgc4yXaNtD8QcADw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <05c0e4ff-3d93-00c8-b81b-9758c90deca8@fb.com>
Date:   Fri, 26 Feb 2021 10:08:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CACAyw9-XZ4XqNP1MZxC1i7+zntVAivopkgRgc4yXaNtD8QcADw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:9651]
X-ClientProxiedBy: BL0PR02CA0114.namprd02.prod.outlook.com
 (2603:10b6:208:35::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:9651) by BL0PR02CA0114.namprd02.prod.outlook.com (2603:10b6:208:35::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 18:08:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61f1cce-f0fb-4449-d276-08d8da8183b7
X-MS-TrafficTypeDiagnostic: SN6PR15MB2461:
X-Microsoft-Antispam-PRVS: <SN6PR15MB24611E1F6A6601642D0EDBA4D39D9@SN6PR15MB2461.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: so5xoSWbreYSfg9fpOxbOe/wO1XTSA5ugaZ5z35IOfJu+Tt97x5Zp/mxuv4Mrtwly4n7Pt/fme0/KYrhDfxwSjfMx/HKLYUi2KmtiE9tW6ufGidvM7qEw+u5ufccH5SL91e8ZnB0kd2hsN5xpOcx4e/5ZVLJCLoGBBFagCenMsCXR996MCesbPf9HGBYJgCH5+3/44QUN6RFVUSa4x6u/q8rVvl/g6ilYcy0uE4xCcr75Yls97inLGUGN0mjSLYON4iZ6ZGiyUuQY7TcF55lYXzvKYOOsJ4I11W90aUKpXpbLz2jEquLTMnlki+VaDk+rLzvnVGQjYnxMsXaqvw7D/XprXBxDpMzZRcpyBO5QykzTviR7Aqg2szrkDlHodjR5kFAeQrbwe/xzErV6a/zlTNkKTi+6zQl1o00utZroPo1HAG4F+ITIMPXGLDOrw+14LMXu44pizdPJ5oqAHSXRyXJxr8NWgBWjp5tDdFEWkC4TrBIElsRTzovWCD5pUoptIgVJgjTPyKMhUcsCOM6sDy/pC4Ecgvtx3rsz7+gPEEL9eTJIMsBvk1jEmpWNiG49mFUjPuXpWXYdUeaaFDUHMTIhecupLwYkCjJQWnTpbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39860400002)(52116002)(5660300002)(36756003)(53546011)(2906002)(16526019)(186003)(8936002)(8676002)(2616005)(110136005)(478600001)(6666004)(31686004)(6486002)(66556008)(86362001)(66476007)(31696002)(66946007)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?REtnUndXcGJidEcwNzJlemNIWVMzWCs2WXYwUXBPT2RsT1E2WjZIWDY3bFcw?=
 =?utf-8?B?WVNSaU9SNTR4dnRHdUNKaFA5NlRkL2ZBUjBlTG1WeVFSelNrQ1hXTldGYklv?=
 =?utf-8?B?TnQrbE9jQ3UwNWZzd2pmOGI1bnNYWHhvdHBubWFrK2VhSXJVM003VG0wdXhI?=
 =?utf-8?B?S3hkc1pXR0IrbEE5OVE1ai9hT1BQS2Y0d2lnam5yMG9rb1RHZzIvcjNRYytv?=
 =?utf-8?B?b1ZpaTk3LzRld2dOWUZvVStkdSswWTk2SmgyKzlxTHRjMU5ZTnJ1V3NzODNa?=
 =?utf-8?B?Zlh6ZnBwaC80aXhVeDJHMTNYZXVUcytMMXhMNE9wbFRENXFDYU1aQVphMlRR?=
 =?utf-8?B?alhVWXdCZjRQdEM0NzYvc0FCc1g3a1ZqMmVFUmNEWkR5aTZoQzN4OW9RL0Ir?=
 =?utf-8?B?MDZSeERmeDRYcWZVWEFVU2pNekg4Q1ZpZ1Nxc1llNENEc2U4T2xuNTZjd216?=
 =?utf-8?B?RUFNaXNockQ3Vy84azlGc0RIVVBYMm1VYkNVSkcydW5VZG5oUFk1aGNtb1R6?=
 =?utf-8?B?SExzVUdoVEVlc2k5MnNCU0tZTlRUSWk4VDZXUlF0UnRnUkRWUFlRMVVmaHgr?=
 =?utf-8?B?NnJ3cFE0bDVWKzV6dmVqRUVlSjN6ODhFdU5ReHVGUGFBeU4vMTZGVmduWFJ0?=
 =?utf-8?B?aGVhQm8yWjJsVUFoeU5QcXYzMHU0Y29jdmd4V3N0SDZ0YmMxRzhRN2p4MVIr?=
 =?utf-8?B?T3lMSDFKcnBTbGdTbVMrOGRGd2hEdEV5VmlOMSs5MDZqZ1lhaVdMS28rQXEx?=
 =?utf-8?B?MTdtekRBVDFZQjZCUEFlM05IYVlEWk1TanZVN2JPLyt4RGtSNVBObUd6YUEy?=
 =?utf-8?B?bGRkcjczQ3pJR052YjQrYngvSnZiU2d1REtvM0xoK2NjaVRLaDhHZCtLVTZx?=
 =?utf-8?B?Q1pQVGpCdGxRdGNuNTFqWkhNTTBkd1o4WHNWYkM1eDNIWi9ONlJyZkZrOUlO?=
 =?utf-8?B?c2p2a29ucEFUSG4rWEZobmdTYlJxbThwZHFvd3kxVGJ0L2FsNERuN2I5QzRr?=
 =?utf-8?B?OEwyV0hGRk1hbUVFWTZvbFg1ODgwd0ZMa2VXR2RZUkhvYmFyZHZVbTJJbVJK?=
 =?utf-8?B?R2VaMUhJdlRtNlZQZm1WOHZPM3EzNjdxeWlYeGRJSTdRdk16ckk2eXNHS2pV?=
 =?utf-8?B?MjduR3hUMzRndi85SXMvdzA0QWR6c3YrSnQ4azdncm53TG9RY0wrbkxMc2xi?=
 =?utf-8?B?aFRUL0JQOUg1elcveGROd1ZqTE9WeW00bC9mK3hCa2VtbW1Jdm9Zc1dYbmF3?=
 =?utf-8?B?c3J0YzhZQzhYSnMyM2RlTkMvRmcwQURkMlBib2pQcldIbVBJMFNla3NBL2JK?=
 =?utf-8?B?d05BU3J0Q0crUnY3SklvUU9hamdRN3dQQVg3V0Y5YVphbElnSk94SmZMS3pQ?=
 =?utf-8?B?bHBPcytvcVp1M0xicFQvQTYzdllxKzhzM2RKQStmZHM5RnZYNnl4d2NvclBa?=
 =?utf-8?B?cFVQSUlRRUZQc0JDekxHU1dVNFdMTzNndlEyVmdOd3YzelJyelRxc3FDYTI0?=
 =?utf-8?B?NWZ1OVJhTTFEZjFmckhYM01CbFh1WHg2TndkSGoxNDhwaWdzOGpJeXR4UGtW?=
 =?utf-8?B?N1J2WTBrWEFrMkRuNTdIOHFQTFZXZnNSV1NaWGJ6b2tiNEJVdEh4M2kwQytp?=
 =?utf-8?B?K2lDNVlMWnNaRXFIOGlyVUNRS3A2UjhmdlNPNHF6TkZEYlJicVZYOG1MT0ZP?=
 =?utf-8?B?S2F6ZVdidTlaSUpMeEhvVkFCcHJqOHdicFBOM3YrMU1WWWs1VHpWNU5welM2?=
 =?utf-8?B?Qy9ady9vL0FqeUpDZHN4UGRLWHFNd29rQmMwVXJJekNsNGljaWlsU25VVlRL?=
 =?utf-8?Q?xW68Fha4UTxf3W9XxpWRj6AgeYQ0wZqeeI4NI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d61f1cce-f0fb-4449-d276-08d8da8183b7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 18:08:26.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efWJOlU/+wnYLbzhLeLwVaat6xTMzN6Re6w4mrduzTvtqxCEj/168Qi1B4lUjUTR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2461
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/26/21 9:47 AM, Lorenz Bauer wrote:
> Hi Andrii and Yonghong,
> 
> I'm playing around with enum CO-RE relocations, and hit the following snag:
> 
>      enum e { TWO };
>      bpf_core_enum_value_exists(enum e, TWO);
> 
> Compiling this with clang-12
> (12.0.0-++20210225092616+e0e6b1e39e7e-1~exp1~20210225083321.50) gives
> me the following:
> 
> internal/btf/testdata/relocs.c:66:2: error:
> __builtin_preserve_enum_value argument 1 invalid
>          enum_value_exists(enum e, TWO);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> internal/btf/testdata/relocs.c:53:8: note: expanded from macro
> 'enum_value_exists'
>                  if (!bpf_core_enum_value_exists(t, v)) { \
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> internal/btf/testdata/bpf_core_read.h:168:32: note: expanded from
> macro 'bpf_core_enum_value_exists'
>          __builtin_preserve_enum_value(*(typeof(enum_type)
> *)enum_value, BPF_ENUMVAL_EXISTS)
>                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Andrii can comment on MACRO failures.

> 
> Changing the definition of the enum to
> 
>      enum e { TWO = 1 }
> 
> compiles successfully. I get the same result for any enum value that
> is zero. Is this expected?

IIRC, libbpf will try to do relocation against vmlinux BTF.
So here, "enum e" probably does not exist in vmlinux BTF, so
the builtin will return 0. You can try some enum type
existing in vmlinux BTF to see what happens.

> 
> Best
> Lorenz
> 
