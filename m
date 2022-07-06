Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC0567E3B
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 08:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGFGMc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 02:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFGMb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 02:12:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EAE13DEB;
        Tue,  5 Jul 2022 23:12:30 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 265JJHus022707;
        Tue, 5 Jul 2022 23:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=l/Ec9x86Vhk0IiHKM8smdeyCwgnmOfXb+6c+XlHO9Oc=;
 b=UOv7aOi64iRPTjpDnRwdiY7jdeRxbcCZJeybDBm+VUFiGo8qs6dcSpzyc12ZEwy7AIfQ
 5RwKoPnNPKh569GTI1oSHge0q8LdkZ0V/OmHMykeQBiZm4NowqV66TVnWBgmpG52yz2q
 iP7xR/c39d283ZkBlBE4aA1Tb6NctT6yL9o= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by m0001303.ppops.net (PPS) with ESMTPS id 3h4ubnk528-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 23:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GofvTiNfDX0As5IaBPp6lDhUwNfa01KsgJl+80egvX1x8PxBclKbl8qECBRr673CRHDNupqb+ruRkWSKMLkJAr4WzAZlTZCAbZ1p8Cem5CK3PGQH49jH2qjxgDpQcM8ZWChMi6hI6mWO0EzP5bk9FNzg3qlmTrMwahd2J5rBiiC1lEcbDWvFj+KQ54o2psFy7Of4dF1Uy0z0WiPzJ76NLg3LORwrw3Sy3+SgYc79TUdpa45nHpczF3Gl3iQZrPMgr8OjxGq4mKMHNDYOSNmzKaqAUF4Vglk6d17eLaJOtWwpCJUeesHlQ5b3+x5zEiAJJmzsys2ef+mJBKo9R9RK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/Ec9x86Vhk0IiHKM8smdeyCwgnmOfXb+6c+XlHO9Oc=;
 b=NfTuNnmI2d8gYOqPTiroVYBPyCV8lVAIsNHeHTOzLboQEXPKRL5x54pur9YLj8ZtZ+acDWuMALxBa3TYFPH7O70e9qkEnTUfOzt4J68P4HE+hI5xwr2nND9BiZY7f6d8IxMKPPz63/JEqAefGGP7+TLG65WVJOJdxlIQIxwZnvLGMGBz5m37d0Va4tOfOzii+0jxNDYqfpLX8SzHO0yg65+1fgO2Qe9LCJ6bxHFyV1GVg/6AVIwVVXxoeShZPkdFk0ruap41Jq0/8k2m84H4ZIH3IrHPlS63J2OuOjYw0aCzeCmjgF2vSlzMrckUJrGvguyz8EuqfGchk40jpcZioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW2PR1501MB2043.namprd15.prod.outlook.com (2603:10b6:302:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22; Wed, 6 Jul
 2022 06:12:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 06:12:06 +0000
Message-ID: <3efda195-2d1a-2207-62c1-759a53ece20d@fb.com>
Date:   Tue, 5 Jul 2022 23:12:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: add a ksym BPF iterator
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Vernet <void@manifault.com>, swboyd@chromium.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Kenny Yu <kennyyu@fb.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <1656942916-13491-1-git-send-email-alan.maguire@oracle.com>
 <1656942916-13491-2-git-send-email-alan.maguire@oracle.com>
 <CAADnVQKvtoBkCEBNcwKp1dp9_OPy9CtLD=QqscMQQJdoUf7OkQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQKvtoBkCEBNcwKp1dp9_OPy9CtLD=QqscMQQJdoUf7OkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee95b001-5fce-4d17-11a5-08da5f1673a0
X-MS-TrafficTypeDiagnostic: MW2PR1501MB2043:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNhizv2XWebjNBTkYDVKg0Cks7aVq7dNxIvmFrST9pZq/C2XXUwuI50/q7yWUD63/spL/HDK7blYagZq0k8g+XpICvnJSgN3ivk3efnmf/awXDgT3+2/6ThoKev4fgw6w3ZEQvtC6I+vILFq495edgrchRYaIgdGqIh41kKYXmRx5bF8hDcHNEGMeHzuwJbMAYepuK6wtFRHXoqtNNC4x8Bz7ML7CXBIPSH4o1Zh0h+m6dI6YtMSWtvHsEit25fdO/aCl3K/vRErAZ6PEeEpUy6MAp0JB8mEv3qAup3bJ4MWVcZnk9EB40QnKMevR8aS5Dfl9lwklmlUvL0fWXAFGJCvohKIf1WgX4bQFSp0eK2JHzRyRPDrN4j0CmjZ2dirJxBA7e193m42UZXzezk/bZqIvKUuL5oVuNNMSwOWHP4Cj4Zm5uuu0/AgX2ksowqdt9R/OGqnl/du54r0Y/hoEBLo8imO3DdL3a1q/ppQFA7qI7Cq3k5HGS9EfoInd/PNUUWPD0hxEtLPu/J54xT9Tl2fnDrnRuxwp1cynLpHZbWRyK8Tkb7MhqtLAoV9CsyaGAykTUFV2rt60pkBDiuFeg3/smFPWvzghNfM3+az/6kZaTy5GL0OqTqY+uKPb39Uf1tvWFeyvMt73qsO9VJM0b4mmyak7RhM3h+VnPxtASN3Th2qZUbp2etEENoSkJ6IDj4K+0uuw2ddbV71mzU/MekfHpaWTzg9oGmGK989xhICtUJtqovaDt3nfc2GezQr00AOdldrU4qvSCfGtIvJlYDM6at4HwoeVgnWWbbnHByO6g4euCNmGrlrh0Wb2MsdHiqqRj83TtWCFmLFy3M/7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(2906002)(41300700001)(2616005)(6666004)(38100700002)(316002)(31686004)(36756003)(53546011)(110136005)(54906003)(6506007)(6512007)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(31696002)(478600001)(186003)(83380400001)(7416002)(6486002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZPcUt5NEhhM3RqWG9NVENMZ1ZmS1BBUENxMzM4bHYveTVTNHBKaDFNWDk4?=
 =?utf-8?B?QmNYZkl1djh5QSt5SWJnZ2tzZmNicEp5amI3VjhEUGd5dGloUkppOXJ6SEs1?=
 =?utf-8?B?THMxSG5KYWcwRUpGRy80ZThKQ05CQXlVOURLTUZlbEYxZXdPWTl5dVdDSkxR?=
 =?utf-8?B?aXVQcnRHOWVCRk5YZENid0JtbVZsbnArL05heWtSWWhJYVpKL0k0LzdFMGpF?=
 =?utf-8?B?aW9ISFV4OE1ReUJ5VnVzUHdHdVZvcEU5TjFyRTB5aEJyQnJpQS9LQU1Wckc0?=
 =?utf-8?B?TjRQYVQyZTlKMU1xelU5TjMvRmhoN0MrZkVDL1A3NkR1ZDhEOGVzR250eTdi?=
 =?utf-8?B?YVRBNzMwa2RGOXBaSDliM3hPTm9zaGlMQzZ0UXNZY0h3Z2htbmhJWG5ya0hT?=
 =?utf-8?B?c0ltQWtUTFJabXFRUm9STWViWUkxTVNaaFp1RmNyNGVKUWJnTytST250TVg1?=
 =?utf-8?B?dTZaeVVEZDBwVCtKRkZ0a2ptZHkyZ0swYUFDOGtid0lQWC9FemR2aUxtcG8v?=
 =?utf-8?B?cTZkTjlKQndJUFg0NmZCMTdrakcwWHRweFhQaDU5S3JxNlc2Q2F0MFpZd3cy?=
 =?utf-8?B?eWNxZFQvcTJadlY2ajJsMldEbVEyR0pnd0ZKS2xEa1ZXQ01JZ2laa2VqRFRF?=
 =?utf-8?B?bEhYZVVabzlzR1JoU1RHWkZlWHhoSjVhK2JWSGVicXdIeURnMkJQcXh2dTFa?=
 =?utf-8?B?S21RbWZqdUFjQXZnRGR0YUpwR0g4cW9pVGc0VjRJZzJ1WTZOUU9lUHgwaG9s?=
 =?utf-8?B?Z0M2T0p0NlhFekYvWGo3Nk1wdG5qQmduSEZBS3Ryek5jMEg2WklNMGtrbEkw?=
 =?utf-8?B?OUowZUdkNWNNbGxHS2N1dEtYSFh5V0drMGZEWi9rc0wzOUVmazVUQjNsakpM?=
 =?utf-8?B?NVJqYkFCY2d2dVBjTE81UUVKK1JJTmgzall2Y1V2dlQ4NXpmaVdjN0xGcFhH?=
 =?utf-8?B?Z014WXZSdGRVZ0RBVDQ1UHdXNmtXV1FHQWdmYUcyMHhCWGlTeDBuOWhLcnlt?=
 =?utf-8?B?Zmp4MEE1eVh3VGI5QTFZRjVlM0VFY1dHVG5URjhKU3NqSVdJWkNQaDN5dFRH?=
 =?utf-8?B?ZGgvUHpTWk5teXNtVjNtc1JxV3pkRjdJZ2R5d2J6V1ZQK1dWaXd1SGk1SWVX?=
 =?utf-8?B?MklMdEVieU93ejhTMzN6Tm9CLytsQVpBbzVuTHI1bE9SdmhVUUUrRURheVVy?=
 =?utf-8?B?SHFITWRqYTZBN0wwZzRqdHpiZlE4TnEzeUFqM085QS9RcW95Y0xkSFpyWk5m?=
 =?utf-8?B?VkJLb1lQMkl3N3VIZmRCNTJMbm5pbmhvdXVoVXNkVnpIOEQrSG1aMXk1aFl1?=
 =?utf-8?B?T1hPS28xbnVNblExWjdWSGd1eXVkT1hZTWtaRS9TUkQ1alhTaWtyUTh5N1VG?=
 =?utf-8?B?ekJJanlNZXhFY21qUGI0UEozT3hENnpsdXlzd0Z0OFdjeGEzRkJqUWZpNGEr?=
 =?utf-8?B?TVgvVzZ4b21iMzBZRHI1T3Rqak4vNFN0WElqeldxeFdzUFhyMk8veTQxZTdq?=
 =?utf-8?B?b1dacGNTYldtb25KMm1Ma0JkMERFbklGRDQxMHovY1JPNy9tWmlPK3hVVG50?=
 =?utf-8?B?ZUxpNmxDbW9mWVZyRlZ6ZXJaNXhxaDBHbjd4dVBkVXBvZm1Sa2FRaFIybEN0?=
 =?utf-8?B?S2tqQkZSSmlya3dEZUlsTTRhejVMcklXZUFsNkZaS2dQWjBtM0hXY01yS3BG?=
 =?utf-8?B?c1FPZERBNnhJcldFWXRWTFczYi9CVC9mTlBVaGIwYnBWY01wZFQ2dWF3UmhW?=
 =?utf-8?B?aGNLR3IreE5BOXpqOGxRWFc5Nkw3ejY2NWg0VXJ1dUludjh6Qm9nSDZOSjdw?=
 =?utf-8?B?cmpZbzFwUVZoOU1FOVQxM2FtRkh0Z2lFK21jUlBqM2NhRndnNWRPWThZYmV6?=
 =?utf-8?B?L0loSVMvY2YzWTJBRWpvalJnNWpVWkxsOFYxSjV1RVQ2SFhvUHd0NFlRZlVW?=
 =?utf-8?B?aEZEaXBjUFhmRHFVT1laQjhHckhCYmo2VmdVMVR6eXZzRllTc2tiQXE1RXpo?=
 =?utf-8?B?OFpta2hLVStOa1pqSnVNMHZ5eCthNEN4Y2JSRW1UakNjTm5CMmVwYm14dFBn?=
 =?utf-8?B?czhZdWw1UUQxM0pVY3B0dFJLNFZ2U0hMMUR3N2FYQm9vSjJHbklZQmVaT0Z4?=
 =?utf-8?Q?iIw0/L6+4322XTmrzJmF53tb2?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee95b001-5fce-4d17-11a5-08da5f1673a0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 06:12:06.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XQW/E1DSzKFeYJXa53S2oLCQRaEHwSk5U3893jSqRcrARp4wyK/IEP/MER8g4hj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2043
X-Proofpoint-GUID: 9LJS0bD5uc0i6li9Q31giRx6OfoFnfo8
X-Proofpoint-ORIG-GUID: 9LJS0bD5uc0i6li9Q31giRx6OfoFnfo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_02,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/5/22 9:19 PM, Alexei Starovoitov wrote:
> On Mon, Jul 4, 2022 at 6:55 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>   static inline int kallsyms_for_perf(void)
>>   {
>>   #ifdef CONFIG_PERF_EVENTS
>> @@ -885,6 +967,18 @@ const char *kdb_walk_kallsyms(loff_t *pos)
>>   static int __init kallsyms_init(void)
>>   {
>>          proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
>> +#if defined(CONFIG_BPF_SYSCALL)
>> +       {
>> +               int ret;
>> +
>> +               ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
>> +               ret = bpf_iter_reg_target(&ksym_iter_reg_info);
>> +               if (ret) {
>> +                       pr_warn("Warning: could not register bpf ksym iterator: %d\n", ret);
>> +                       return ret;
>> +               }
>> +       }
>> +#endif
> 
> The ifdef-s inside the function body are not pretty.
> I feel the v2 version was cleaner.
> static void __init bpf_ksym_iter_register()
> were only missing late_initcall(bpf_ksym_iter_register);
> to make it single #ifdef CONFIG_BPF_SYSCALL for everything.
> wdyt?

Okay, a separate function is good too. Also agree with Alexei
that a separate init call bpf_ksym_iter_register() is needed
since we need late_initcall(...) instead of device_initcall(...)
to be consistent with other bpf_iter's.
