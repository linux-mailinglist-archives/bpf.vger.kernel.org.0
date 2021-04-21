Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75B5366EBF
	for <lists+bpf@lfdr.de>; Wed, 21 Apr 2021 17:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbhDUPHc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Apr 2021 11:07:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53454 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243814AbhDUPHb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Apr 2021 11:07:31 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LExnEk006985;
        Wed, 21 Apr 2021 08:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Sz5wS6k6uJ4avuWwe4WiE4JiEuwnAjPOAZDcfyhMOE8=;
 b=Ew0q9pDR7Ctu5sHhRSKcj7x9CG4TqIQgONChl4ZWrolFAXWHSpefL76dhWqiO3YSOirc
 F9+YCesczfLZFYg4t7emIi/iXJDNLJI6nhrFglNMiY2Vr10vpyvHj4rYU2pkpOsU8Yfm
 PjRWzoQxILLwjaWVtN6cAdWhQJYOV2ft5bI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3826yuc92t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 08:06:44 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 08:06:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWENQ2RuX8Epm0QSh9gu138CnQnSRIDjG9NAic4fr1NiJdiOtent6teGHueQzXbaRbIdW2YD4y0t3OcegwD/59lKlfwrxdwRAxlBgBuJV0j+eeXprwT5z5HyrmFN/14Ja4YgkVYnLaM7Bvm2TpWjqvwKQ0asulZKoOePYXjWXZwB8tKXjBxGKU5Y2Xs/ryZnuXU2m5eRqTmhPEgo4NcDQu/Q5aUepoQC8g6Dj0OKdk2qTl0NkWqrU9YjWxskCb9+Ytwl0Yf2Nzrn0jV10rAsTv/5VxHRca9k0GfU38foDFmH4DponFJcaCJGopebMuzNEC60NNjcFs6uS1gkaEgoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F5NyQ9T+BDty1Tjq0+Hf0gCGkhX8BPJzseDZk+LCCM=;
 b=hZebq2ADwG/vW5cuFOWjGgyX+iaXLOlZNzYvveImQ0+6KvTeuJMnn/oKNjClDN5luQ8B/37WTZlGcZTbwPMCJADvrvnLHgAB6v+WF8JLaUPNEAP7VGnWonnpoMOeMkcIiCYt3QjW6aNs29ejhhqXiNqHhgYs8SndLP5S/ABZAnWeDpDN4bJSAO0oz5IDyXNIX+WKtg6OZ11tTArC7FvrtW7CPh0SAcnjaWDxMrSJ8KhXdkfnSBd9NXGcQZxrpBGsf1CkFlc9mLPwA2NtAzlxfxoeiXdkbWs4T5+T3BZomIRllBVZdRkEyjXPstcsn+FiIrAG821O/Yd4yCAq3PE6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2334.namprd15.prod.outlook.com (2603:10b6:805:23::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 15:06:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 15:06:39 +0000
Subject: Re: Help with verifier failure
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210421122348.547922-1-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <94c4f7b0-c64e-e580-7d9b-a0a65e2fe33d@fb.com>
Date:   Wed, 21 Apr 2021 08:06:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210421122348.547922-1-jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:f2b4]
X-ClientProxiedBy: MWHPR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:320:31::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::137a] (2620:10d:c090:400::5:f2b4) by MWHPR18CA0027.namprd18.prod.outlook.com (2603:10b6:320:31::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 15:06:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1657e102-13fa-4dc6-4732-08d904d71099
X-MS-TrafficTypeDiagnostic: SN6PR15MB2334:
X-Microsoft-Antispam-PRVS: <SN6PR15MB233445EA006EF52F71B2D118D3479@SN6PR15MB2334.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNuZZcmRXsPIZweEJYw/kQj+dKugPl6P2qsI9U6Z8xCkboVGjmhEpll6CJ5TYs35KJSbqgX10FcXdxV3dri0vY0Go8jAfVdXHDhnqfzJrzKMQVTAdTBSoRJIR8m7subGs9Xdm1HqcVa+QJuMiEC5aXzryziO2PDn2FoCeMxPGW8m+DS1qM57p6wbu1JjfFx5IEcCvsJQSXMfO0FrJ9kTJnV1l7GppJNCm1TyOarddKPOSQF7Hr5cD2fYn2Mf0eQVo4Vplz7dbs3bXwpneUfpAMdCeqHDTA9sGvsv+CDoYB0CUajEiJAci/h2H4frt/WgFPIRJRoytdvb0c5B51vBDo/+PuqYg33a047WzIxMA/DlNsIfLCPblgFJa4410wt95OQH8ZLvQRhMwk9kF52ASYrjNRurjIRk/N7iPqGgbINEoc/tj4AE5equepznpSrDjXdnHOQ2PKCpCn4dLBus5hiGfywYnyrWp24MCUYt0O3YSlXhry4BeyOYW4R3XYuF/BPG+o+9zSwFtMaLdu6Vo/AswvBssr6Q4rYsde5Wh4Y8GIWFNVwc1jVdk0tgqHBmI361Mvs4hf7RDywhw/wmHMZWVB+c/c6c0TNInzZK4nTnjRN6/MLlLUGPa5oKss+QbjK/6hAZFYzL6T8vjkAm5/MOrH92CFQ2pBUVjEiMUF/OazGUii+3feEkngSHWyIGILjleFS1Gt5uEHNbtxy3nDG9sNLLvda87D/MUc1Qakzy61JYZ1LuTEMw151oFYhlXMWFz1lb5psfo2+pAM32H5qYPY6JMAAOP43GNJiJsxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(136003)(366004)(376002)(396003)(83380400001)(4326008)(966005)(36756003)(316002)(5660300002)(478600001)(31686004)(2616005)(8936002)(53546011)(186003)(16526019)(2906002)(86362001)(52116002)(31696002)(66946007)(8676002)(6666004)(66476007)(3480700007)(6486002)(38100700002)(66556008)(45980500001)(43740500002)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bnprVFpCY0tldkJzZkptUVpaTDRrUTdISFpPRmxhWlc3R0pZZEkwQmpIeGNt?=
 =?utf-8?B?N1NYbUZMaXJhek1ZaXJDMTQ1bFpNZVkvdENQcldRUlNBR1Z4QlNNS0M4UCtt?=
 =?utf-8?B?SnpKeVhBMUhuSkxzUnNzNzBxS2N6ZTBoSWJuMEdDVVdOcDJhUXF2OWpHVGx6?=
 =?utf-8?B?eks4S0JFbndGazJtdTlHaGlTRmxCZnJwVTg5WGF4eWorbVovak9iUTlHMDcx?=
 =?utf-8?B?enhzTnZmRmhlbjA1bHZwTXNiVDNCL2ljU1lZS3VjVFFVdTlJQ0pZY0Noc0ly?=
 =?utf-8?B?MXBzdzRqZVFqa0J2ZG5HMXM0Ym5yYW1HZVY2YVpOcnV2OG14Mk5tbG4wQ0Fi?=
 =?utf-8?B?OExoeHVXYUVCS1FGLzl2d0ZWSHh4cVlXb2pIalVqQXAyUHVGdVppZm1lV3pq?=
 =?utf-8?B?ejd0WjJ1OHdONThOWnNnUGJiMXZnKzQvZ0VjY0xKWnZYdWxOM1F5NEVrc3ox?=
 =?utf-8?B?YlZyRjlIVFViWEN3VHIwT292Lzg4QWFUY2lVUGZlUEhyUnlNNmFCVGh1dS91?=
 =?utf-8?B?K2cycDl3ZFk4eTd1aWFaMjVCOWVheGVkandJc0U3YTRoRm1sekM3L09ZRmlj?=
 =?utf-8?B?elNSQjZpcE5IaEN5clQ1SHFNZW96L29JcDNnd0tVbUVKNWpkUzhDR3JkVUFi?=
 =?utf-8?B?MzZHZVozQ3BGSGE5WFE4RmF0UktFK21FWEVOUU5BQWJvblB1TXNDWUdObWxX?=
 =?utf-8?B?OTY4bzlDaFNWYllvVHE4VWlwVEFya1ZJem1LSEFNN1lma0VwTko3MUp6ZmJU?=
 =?utf-8?B?VkNTZFp4anBVd0taTkp2ekU3d01WUkVSTmU3eHdXSXViUlJXZXdLQit3U2RL?=
 =?utf-8?B?MjZZOERVblZYWHlZbDQ1eXcxN1ZXT2VWSnpoRUs0UlZZclVZSFM3bTlkUDI5?=
 =?utf-8?B?alBkeFduaEJpOXNMaWNaTUdFWFBCdFJDUXQydTRROE9ZZUNGNGZyR3Y2aHNX?=
 =?utf-8?B?OFJHTFJyZTRGM3laY0hKeGN6MTZPMVBhWUY5QTFXQmV5U1RYZjArSU5hdVRm?=
 =?utf-8?B?VS9WbEZsWXViWVhDM3lCdzU3M05UWUhHcDFNd3hPUyt3VnlYSElYWjAwODM3?=
 =?utf-8?B?TUVYQmFhL1FXRGlKeCtsRmNzb0RkeHNUQkNBdjZ6Y0lyNzg2WXhLTnIxeUl4?=
 =?utf-8?B?N0grU2RUcEI2U216bGpYL25BYlhoR2xBeFBMUC9hVHh5YzIrTUVzWjVZWlFw?=
 =?utf-8?B?VGR1dDVQS04xQUs4d2k0aDdYWHBteVdQMFo0MnNzNWQzVXRaWG95OUZUQlFr?=
 =?utf-8?B?dEpFcVJIVkdaTzZxUllDWk9VRXFSQ2puQnFLWWFVUG1tNXNqdmxNZzIrdVds?=
 =?utf-8?B?b3VjRzVEN2VldGhOc1lZd2ZkUE5UMHNETyt6dGZreUIxTGlrMk9kOXZKcDZV?=
 =?utf-8?B?dlBQZWxlOUZqYk93ZWNoRHh4d2ZOSUtJWHlZUEplUURiRjFlbEhyeGJ3SEJt?=
 =?utf-8?B?SzArT01qeW04VEtWQXpQU3FETE1WV2NzbUhjUVJCbEF1U3RVQnpKZFB0SUhG?=
 =?utf-8?B?QXEyKy9nZHZDdnJkUVByVXdocUdGV3JSbC9vUlNDMUZxbWp3Ti9NNWNSYTRL?=
 =?utf-8?B?RGtXUXlvTStLV0p0NThqQ3p2cStJai9LWXcxSWtXUGEzSEtQWTBPZjJWSkhR?=
 =?utf-8?B?VWt3TGVrNXhCTkFsUWtTMFlnTGxkTmVOK3dpaVA0RlRaS3Z2N1B0YTVBbmww?=
 =?utf-8?B?Y2Q4L1pyc0k5QUdzcDYrcDVENlA3TXJ4ZEV6alZQZlVCRHlyZE1FSmdvQ0Vs?=
 =?utf-8?B?MldEaTlVNHlhMmRsOFpaTEN3VGFacU94Z3o4WmZoMW9XamxydHVGZmg3MTNX?=
 =?utf-8?Q?PKMONpqowKSLkWnC4Mgs8wH6RbaGYtcTrcwvE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1657e102-13fa-4dc6-4732-08d904d71099
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 15:06:39.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gnwocmCxQJG5wvRgUzKguDOhLVHcWWcVXgx9EqcruxAQhzmyIxi8Va6cn9Tdmmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2334
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 8MnXVEfosBnbExNEVOtjeHHyoh_u7Jhi
X-Proofpoint-ORIG-GUID: 8MnXVEfosBnbExNEVOtjeHHyoh_u7Jhi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/21/21 5:23 AM, Brendan Jackman wrote:
> Hi,
> 
> Recently when our internal Clang build was updated to 0e92cbd6a652 we started
> hitting a verifier issue that I can't see an easy fix for. I've narrowed it down
> to a minimal reproducer - this email is a patch to add that repro as a prog
> test (./test_progs -t example).
> 
> Here's the BPF code I get from the attached source:
> 
> 0000000000000000 <exec>:
> ; int BPF_PROG(exec, struct linux_binprm *bprm) {
>         0:       79 11 00 00 00 00 00 00 r1 = *(u64 *)(r1 + 0)
>         1:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) = r1
> ;   uint64_t args_size = bprm->argc & 0xFFFFFFF;
>         2:       61 17 58 00 00 00 00 00 r7 = *(u32 *)(r1 + 88)
>         3:       b4 01 00 00 00 00 00 00 w1 = 0
> ;   int map_key = 0;
>         4:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 4) = r1
>         5:       bf a2 00 00 00 00 00 00 r2 = r10
>         6:       07 02 00 00 fc ff ff ff r2 += -4
> ;   void *buf = bpf_map_lookup_elem(&buf_map, &map_key);
>         7:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>         9:       85 00 00 00 01 00 00 00 call 1
>        10:       7b 0a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r0
>        11:       57 07 00 00 ff ff ff 0f r7 &= 268435455
>        12:       bf 76 00 00 00 00 00 00 r6 = r7
> ;   if (!buf)
>        13:       16 07 12 00 00 00 00 00 if w7 == 0 goto +18 <LBB0_7>
>        14:       79 a1 f0 ff 00 00 00 00 r1 = *(u64 *)(r10 - 16)
>        15:       15 01 10 00 00 00 00 00 if r1 == 0 goto +16 <LBB0_7>
>        16:       b4 09 00 00 00 00 00 00 w9 = 0
>        17:       b7 01 00 00 00 10 00 00 r1 = 4096
>        18:       bf 68 00 00 00 00 00 00 r8 = r6
>        19:       05 00 0e 00 00 00 00 00 goto +14 <LBB0_3>
> 
> 00000000000000a0 <LBB0_5>:
> ;     void *src = (void *)(char *)bprm->p + offset;
>        20:       79 a1 e8 ff 00 00 00 00 r1 = *(u64 *)(r10 - 24)
>        21:       79 13 18 00 00 00 00 00 r3 = *(u64 *)(r1 + 24)
> ;     uint64_t read_size = args_size - offset;
>        22:       0f 73 00 00 00 00 00 00 r3 += r7
>        23:       07 03 00 00 00 f0 ff ff r3 += -4096
> ;     (void) bpf_probe_read_user(buf, read_size, src);
>        24:       79 a1 f0 ff 00 00 00 00 r1 = *(u64 *)(r10 - 16)
>        25:       85 00 00 00 70 00 00 00 call 112
> ;   for (int i = 0; i < 512 && offset < args_size; i++) {
>        26:       26 09 05 00 fe 01 00 00 if w9 > 510 goto +5 <LBB0_7>
>        27:       07 08 00 00 00 f0 ff ff r8 += -4096
>        28:       bf 71 00 00 00 00 00 00 r1 = r7
>        29:       07 01 00 00 00 10 00 00 r1 += 4096
>        30:       04 09 00 00 01 00 00 00 w9 += 1
> ;   for (int i = 0; i < 512 && offset < args_size; i++) {
>        31:       ad 67 02 00 00 00 00 00 if r7 < r6 goto +2 <LBB0_3>
> 
> 0000000000000100 <LBB0_7>:
> ; int BPF_PROG(exec, struct linux_binprm *bprm) {
>        32:       b4 00 00 00 00 00 00 00 w0 = 0
>        33:       95 00 00 00 00 00 00 00 exit
> 
> 0000000000000110 <LBB0_3>:
>        34:       bf 17 00 00 00 00 00 00 r7 = r1
> ;     (void) bpf_probe_read_user(buf, read_size, src);
>        35:       bc 82 00 00 00 00 00 00 w2 = w8
>        36:       a5 08 ef ff 00 10 00 00 if r8 < 4096 goto -17 <LBB0_5>
>        37:       b4 02 00 00 00 10 00 00 w2 = 4096
>        38:       05 00 ed ff 00 00 00 00 goto -19 <LBB0_5>
> 
> 
> The full log I get is at
> https://gist.githubusercontent.com/bjackman/2928c4ff4cc89545f3993bddd9d5edb2/raw/feda6d7c165d24be3ea72c3cf7045c50246abd83/gistfile1.txt ,
> but basically the verifier runs through the loop a large number of times, going
> down the true path of the `if (read_size > CHUNK_LEN)` every time. Then
> eventually it takes the false path.
> 
> In the disassembly this is basically instructions 35-37 - pseudocode:
>    w2 = w8
>    if (r8 < 4096) {
>      w2 = 4096
>    }
> 
> w2 can't exceed 4096 but the verifier doesn't seem to "backpropagate" those
> bounds from r8 (note the umax_value for R8 goes to 4095 after the branch from 36
> to 20, but R2's umax_value is still 266342399)
> 
> from 31 to 34: R0_w=inv(id=0) R1_w=inv2097152 R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 0xfffffff)) R7_w=inv2093056 R8_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) R9_w=invP511 R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
> ; int BPF_PROG(exec, struct linux_binprm *bprm) {
> 34: (bf) r7 = r1
> ; (void) bpf_probe_read_user(buf, read_size, src);
> 35: (bc) w2 = w8
> 36: (a5) if r8 < 0x1000 goto pc-17
> 
> from 36 to 20: R0_w=inv(id=0) R1_w=inv2097152 R2_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 0xfffffff)) R7_w=inv2097152 R8_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=invP511 R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
> ; void *src = (void *)(char *)bprm->p + offset;
> 20: (79) r1 = *(u64 *)(r10 -24)
> 21: (79) r3 = *(u64 *)(r1 +24)
> ; uint64_t read_size = args_size - offset;
> 22: (0f) r3 += r7
> 23: (07) r3 += -4096
> ; (void) bpf_probe_read_user(buf, read_size, src);
> 24: (79) r1 = *(u64 *)(r10 -16)
> 25: (85) call bpf_probe_read_user#112
>   R0_w=inv(id=0) R1_w=map_value(id=0,off=0,ks=4,vs=4096,imm=0) R2_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) R3_w=inv(id=0) R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 0xfffffff)) R7_w=inv2097152 R8_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=invP511 R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
>   R0_w=inv(id=0) R1_w=map_value(id=0,off=0,ks=4,vs=4096,imm=0) R2_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) R3_w=inv(id=0) R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 0xfffffff)) R7_w=inv2097152 R8_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=invP511 R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
> invalid access to map value, value_size=4096 off=0 size=266342399
> R1 min value is outside of the allowed memory range
> processed 9239 insns (limit 1000000) max_states_per_insn 4 total_states 133 peak_states 133 mark_read 2

Thanks, Brendan. Looks at least the verifier failure is triggered
by recent clang changes. I will take a look whether we could
improve verifier for such a case and whether we could improve
clang to avoid generate such codes the verifier doesn't like.
Will get back to you once I had concrete analysis.

> 
> This seems like it must be a common pitfall, any idea what we can do to fix it
> and avoid it in future? Am I misunderstanding the issue?
> 
> Cheers,
> Brendan
> 
[...]
