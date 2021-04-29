Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211DB36ED6F
	for <lists+bpf@lfdr.de>; Thu, 29 Apr 2021 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhD2Pcv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Apr 2021 11:32:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3962 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233770AbhD2Pcv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Apr 2021 11:32:51 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13TFKdtZ031114;
        Thu, 29 Apr 2021 08:32:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GQYGy6oYARujD9s25sf5GUtIQfT7e7uoyBAdWM03j3o=;
 b=UKpnVqsuhjKyVBawNthL1CrqokcXAYzm8R5F3NnBep2YTSfQELl30t2o0OVvwqiRLE1i
 KxnEJfAo8BPT7p+AxETuocyqS576QcJB5JcgKK5UtHmxZs8gPV62j/OvSKfPz+eLmCsX
 ZXk7TkOWHrwIFc4txT77CrvwLYSvuK0C7tQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3872re1h6p-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 08:32:02 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 08:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEXgikRWWAJKBNFR5L3HcdSUCTusFHOyOBZ3i4qK/KKIyPgPGx3U+h78OknQsGPQE7HO2EPyDNpBHNtHm3vTdjmhROW3j/en0no5ZbvxXFXz3TlOH2lbj+6gto5w2imxXLS19dA6tIUTDZCB5OTkYrshfsFRhJ2wA5IxQ6/iqXrS3WGFMCyLEi3lDy0Cg/LZgW+QiUsNPsaMkttT0g91CP/90stw2FsHzvJ8eet0kHOYm5+zq5FFy2yhBu6wAEWgFFPpEM6UB5uwIrF8igITAgaHp8shRKoEoub06wJjQj/ef0JYM8wD9vcVr1pKjRhdE+2ZsCtZnHb9CI26MN0oPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQYGy6oYARujD9s25sf5GUtIQfT7e7uoyBAdWM03j3o=;
 b=AlXwX7JTadAf3lwU342hivmO5XYeeE8dH1mknKMbq6SWp3zqgztfn7z3Kkr8G+3OOebAZIzP1vTfUNuuylifChHdDPhHpBuOYBOyruA4GjKDbAWQYG8ujM29D6nYM4NSqy5mT/4PA/2GUqoAQQf6IGoz6LJoNb9daIpXKwYO4qarampu+KdPxXc3URhw2v+iIEMk9Am5J4FNoiu0WzN5Qde4T3kvk3c89MybGU3wY4PkeL2Uq4mTAIje342qO3LChrP59bx1CySl3AlfP9Nr6VqelsHoO2yqldWfg/pvC9R3/PhFDDeDLiZ6eap8wkj390MrTsq+Qhq+1EMwo7USwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4737.namprd15.prod.outlook.com (2603:10b6:806:19c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 15:31:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.4087.026; Thu, 29 Apr 2021
 15:31:59 +0000
Subject: Re: CO-RE: Weird immediate for bpf_core_field_exists
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     bpf <bpf@vger.kernel.org>
References: <CACAyw99n-cMEtVst7aK-3BfHb99GMEChmRLCvhrjsRpHhPrtvA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <eb912b37-d64b-a9e9-7010-7f7da3015479@fb.com>
Date:   Thu, 29 Apr 2021 08:31:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <CACAyw99n-cMEtVst7aK-3BfHb99GMEChmRLCvhrjsRpHhPrtvA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f0c4]
X-ClientProxiedBy: MWHPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:300:116::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::137d] (2620:10d:c090:400::5:f0c4) by MWHPR07CA0007.namprd07.prod.outlook.com (2603:10b6:300:116::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 15:31:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58534c1c-583f-4571-824a-08d90b23edc5
X-MS-TrafficTypeDiagnostic: SA1PR15MB4737:
X-Microsoft-Antispam-PRVS: <SA1PR15MB47374A2ACACB15F69689E498D35F9@SA1PR15MB4737.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3iHMIxhqc8AgSUouKDnd8AedyN5oCvX44dtGCmpYDKCu9dnAjYJSp8xChVh0sHrMWzqXrqt6zsVda47NYhWJ7x4PnGAi+jnIe1L9no8bqngDA2wX9tmogQlFkmt01npXwdwIdEfewqS+JiR14YtX9mxd1mb7ufJouWHDkFRhKmaEQOcwVuD0hLqJV3yc6Cdv088gd9Da5Y2ovaFg9/SXxPsixVCKXeb7zSVBNkq4adwqWka8622qgaPcHGGgefyLJ5ywQEiqAdjdDxbGNzS4mfmGxjLMT8bZdjs89fD/MHMRdl63Z9YMP8cVg9fcB5XHcgsVemOstpZY+Q4qcAejd1PLRTStqUhFshiQNprhR8hHvLOLfkXnXaTLeoU90VpE8SxFfH7xUQUmri+YIF5P+ZVnx6B3lfg2IKKUc8jwhJFPC/F0cQ2O8b0apQH1yvRikh7WNWgEtYWqf0BrtPrdVegXHFCoZWm5s72rUBbWoSgowRFZSQ6kpmdlhCnT0NJlhsam75vMtwuE4pk5iAiXXCTD9jt4akMp+cxkzy/g/ImAtNxBsta95VgM/KbfUb4ZE+5o8P4fSoUKn/wbbqvOvxpa82Lm7KWDobxMYNUEXrK46AybH5pXAWC1gbeNFCLHQfSXXuYItacSRvYLoUpthlRVMn2tRF9e6DJWAloyuTAr0rUCZrwv45FGzddjYYqvWeR7jrDyCfVJZ7xqDS9Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39850400004)(346002)(396003)(2906002)(6486002)(38100700002)(110136005)(316002)(5660300002)(36756003)(83380400001)(186003)(86362001)(8936002)(478600001)(52116002)(2616005)(16526019)(66556008)(66946007)(66476007)(31696002)(53546011)(4326008)(31686004)(6666004)(8676002)(14773001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SG5HWHZRVXA3Mnh5UVFZUEZXam5vQ3dmVFYrV0Rjdk1nMUlSdWFidXZBMzRi?=
 =?utf-8?B?M3Y1d1BZSWF1cTdKVGl1TnU4bTJSNDF5dGdBbTNRNysvSlFBUVE1bUdMZ1lG?=
 =?utf-8?B?cVRMWWE4UGdIUWljMCtiaHpudklQVVUxUXZQS2FmNno5M2huNThmcThsOEZs?=
 =?utf-8?B?ZWFjOEQ4ZE5ZV3BNNXhRSEJ2SDR6YzVFaFVNMmJiakZRdW9HVkNyVGZVVzBi?=
 =?utf-8?B?cU1VOVk0K1NZd3ZQOTQ3ZHM0UVIraGJER043QVUyZ1JHWW9hVDNzamgwV1Bu?=
 =?utf-8?B?MFFKYjk4aTl1aWhkVkRTZHIyUVEwRGlsYzFXa1ZSWWhra0RoamdNRnJjeXdE?=
 =?utf-8?B?byttcWxiZE1lU25nWFpkMWJuRHVqS3dMNHZmWXVMcEhTK3lESlF5NHExSGlk?=
 =?utf-8?B?cHh4WktVYmFYSmRrOFVhYzVSUUk2TTdWdXk0QlBWL3pTSUVoNnZZSjNzTTRB?=
 =?utf-8?B?eXZRcVZKSnVtdm5OMlhXUG1manZGNzcyN0F5cnd6NGw5emkrNk9zU0VuYko5?=
 =?utf-8?B?RmtaR084Yk1uUTlRS2Q1L0JScTNZTDllWkxldHBveEE1TmZFQmI4Zno2cFJG?=
 =?utf-8?B?UDRBMXd6RmhnbjNLNVFHN3gvZ1JXZ3laRDV6TG5VYmNQUFVvU2hGL0s2RnFy?=
 =?utf-8?B?bGNvUUFXWVhxVTRTQ2RnMUdzZU9FWTZlZnpuUmFGT3BUeWREaWhpMGdkbmFu?=
 =?utf-8?B?cE1YN3VPejZxT251eWlaVGowRDVmNXJiSkZQK2ovdjNFTjZPSnFFdGtYZVJO?=
 =?utf-8?B?TGp6bTJhVEZLRXQyYnJ4S2p3c1FWVGdmZll6Y2FRMGFEaml4ZGVrcGlNZ1ZL?=
 =?utf-8?B?VGNtVjMwR0R1MzVMYUoveUphZGxRMEhLK0hCRGQ0MmFXdHowY0RKR2hmbFRE?=
 =?utf-8?B?MWI2amlzS2dweTBNUVMzdTc1clNiMmt4TVAvSW5Ga1NXcVhQQTBuYTkwb3ZY?=
 =?utf-8?B?VnlEKzBjOUFyNzlMMVRKbUF5TGdpcjFHUVp6OGplZXVTK3EzQ3haZFZOVEkr?=
 =?utf-8?B?NUg0Zk8zVFJ0S3lqL3J1b21yeXFxaGllYXE3RWg2QkhybjhoVlVsd2lxd1NI?=
 =?utf-8?B?bWlWbDFUTDFnZGtTUVNnUmMzdDVOVTdpaDZiRHMxT3NPbDV6QStTZTV0ekNo?=
 =?utf-8?B?QWl6Q3VLZzhjdFZIVVduUDIwbHVuNWFqRjhFY1RBVWF3RGdYS2VUeWJoS095?=
 =?utf-8?B?VTFxV3pHSDBybXBiaEZxU1lvKytsWE9uWnJYNGtJcGlBUGtwRm5BWkZyUm0x?=
 =?utf-8?B?MWtYS3dHNlkwNnFYZTNvZXNFUG1rMmNTMU11S3g0NHFGU3ZLOURHeFlsK0lu?=
 =?utf-8?B?am5rMHdPd3V2dTlXR1paanpUQzg2ZlBERWw2ZmhUUHJILy9NNjBCaGM2dngx?=
 =?utf-8?B?OVJGTG1RQm5RR3RLRENIUFBSa1BlZkErU3hRU3ZMbWhxMThIdlh3RHM1VG5W?=
 =?utf-8?B?aWxPVXpFeUMxdWhuQVRINmY5U2RnU21EWUhXZFFnL09uOVdiVDMwRkdhZXNR?=
 =?utf-8?B?bzhTOTlFTzhmVEtRdWx2cnFoMU1IOUtiZ1dUY1JHTFJhOFgyU0l2N1RtenVj?=
 =?utf-8?B?SUpObUxZS1ozQmxZQ0krTGZEcm04RHQ0bllPaDN6QnB4d3pyVUJNeG82WVVm?=
 =?utf-8?B?dkprOHdUTkJSSlAxRllCc2NhbFZsNzZ0LzA4WEJnRm1rVUUxK2VyZWlENVlt?=
 =?utf-8?B?eHh2UzlqT2NSUXVWQzN1TjRKaWtPbkJsdFJlOXdIK0E2T3JGRjcrSGF5VGxs?=
 =?utf-8?B?bjJEQkRBenZKbFVCV1hEbVRhaXlhVGpZVzNBdVc1dUgrd1F5ek5seWxDT1JL?=
 =?utf-8?B?a2hHbWtlOWpUTlJYM3Iwdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58534c1c-583f-4571-824a-08d90b23edc5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 15:31:59.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNn42MhiY0Rust2NetNUpV6al9DmjrYaRSaAbbQniBU4ZyYUHtaP6pM/cZ4syUNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4737
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ePp8f5_V-GzmPXMpKZNFxre15FUobYDi
X-Proofpoint-ORIG-GUID: ePp8f5_V-GzmPXMpKZNFxre15FUobYDi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_07:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/29/21 3:29 AM, Lorenz Bauer wrote:
> Hi Andrii and Yonghong,
> 
> This is probably a case of me holding it wrong, but I figured I would
> share this nonetheless. Given the following C:
> 
> struct s {
>      int _1;
>      char _2;
> };
> 
> typedef struct s s_t;
> 
> union u {
>      int *_1;
>      char *_2;
> };
> 
> __section("socket_filter/fields") int fields() {
>      struct t {
>          union {
>              s_t s[10];
>          };
>          struct {
>              union u u;
>          };
>      } bar;
>      return bpf_core_field_exists((&bar)[1]);
> }
> 
> clang-12 generates the following instructions:
> 
> 0000000000000000 <fields>:
> ;     return bpf_core_field_exists((&bar)[1]);
>         0:    b7 00 00 00 58 00 00 00    r0 = 88
>         1:    95 00 00 00 00 00 00 00    exit
> 
> The weird bit is that the immediate for instruction 0 isn't 1 but 88.
> Coincidentally sizeof(bar) is also 88 bytes.

Thanks for the reporting. This is a compiler issue which didn't handle
invalid case nicely. The following is an explanation.

After macro expansion,
   bpf_core_field_exists((&bar)[1]);
is actually
   __builtin_preserve_field_info((&bar)[1], BPF_FIELD_EXISTS);

For BPF_FIELD_EXISTS, the first argument should be a field access.
But in the above, we got an array access, (&bar)[1], internally,
the compiler keeps track of the offset from the base address, and
this offset is used for most other builtin kinds like
FIELD_BYPE_OFFSET etc.

For relative to &bar, (&bar)[1] has an offset 88. In your
particular case, the code never went inside the routine to
generate correct "patch_imm" (i.e., r0 = <patch_imm> in the above)
since we didn't get a field access. So we got a wrong result.

I will fix this in the compiler by issuing an error so people
can correct their usage. Thanks for reporting!

> 
> $ clang-12 --version
> Ubuntu clang version
> 12.0.0-++20210126113614+510b3d4b3e02-1~exp1~20210126104320.178
> 
> I've tried clang-13 as well, same result.
> 
> Best,
> Lorenz
> 
