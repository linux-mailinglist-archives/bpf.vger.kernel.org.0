Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC90C4CE72E
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 22:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiCEVRG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 16:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCEVRF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 16:17:05 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24852E58
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 13:16:15 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 225AbXtB014923;
        Sat, 5 Mar 2022 13:15:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ISF5GD2VhYtCiI7vwK8Q6wd4KsYK+ciE9HLw0AJJjFA=;
 b=lmeldql84TpuV19HuM3vGOzFGJLRI791+p56Kn05Ygewr/PnzpADR7vx1clbkjnB6RkN
 ub6lr6G8kyoZvo/1bKFSoAaLCOokp4pAGGR2Csn0g5E1NNrYmhv8ct/OwzyR44/yHRxN
 9i/CQUM3j4IP4siA3ftenPA8BLJrH7OuX3M= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3em690t1yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Mar 2022 13:15:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMfRm/NJ8ggWtjsPD2GlSoChWQbCOxJ4wdcbFQZN2W7m/i3Rd3cL0yJ8DVY7wWa+kAwKVQXL5foZ4na/ilxTq8YUhcx2cCRm1v/RqP67nevAoC38BXaS4i73zDc0X2D2/UuzT4EdqmWv01QZZ92aCy78Z7Kh/LCtXT6N1/E604mYHEh68Bk/sHZRN0S/MUEmmnBoJxh6vyr4/T36VReV6nRAU56dgA/YoN9UTU7J4kIzBFuGnIAu1ooshV/hzqjngKNPFTYOq0mPGkHfO/sosReoPdnqyi3/7Azbs8Aak2XmpEc7335581L8Z5I8g7uIsjvJiYunOnCZwJk69506Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISF5GD2VhYtCiI7vwK8Q6wd4KsYK+ciE9HLw0AJJjFA=;
 b=L5lPlvWT7SC04BKxLCR/kDrfNHA2BQPQdoqOY7fbtorIae620+OlPEbEMwdGHNOHymVzAFGkJO+bRFUArjWMpxG/FhlgjDGqnJKinRmBsqx4DaHy7C7bB5msNn+YiCgjYuj4iJTP3y7PGHyM+zvSnj2cmfWhU4T9PdShX84uhQD1eQlq0deGfZ/pDGn7nl+2eEwJARk4ziOFR/Th6cqE9hdGUN7gWPAxS9y6I2AYGLJ0xAYwZWq/ioR5TGThsoFldXPr3gCz7O4PiRHhkD/pxDwP0QqoFQEDNoDZXOKQQlckjA3OQ9+RdlsOez/rscdX1iOK2ejD5/gmBhVVcwL3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5331.namprd15.prod.outlook.com (2603:10b6:8:5e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Sat, 5 Mar 2022 21:15:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.029; Sat, 5 Mar 2022
 21:15:58 +0000
Message-ID: <a86734ae-69f4-6eee-0eb7-951e56d3d357@fb.com>
Date:   Sat, 5 Mar 2022 13:15:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 3/4] bpf: Reject programs that try to load
 __percpu memory.
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     acme@kernel.org, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
References: <20220304191657.981240-1-haoluo@google.com>
 <20220304191657.981240-4-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220304191657.981240-4-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:300:95::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88ac0411-9307-4c31-6539-08d9feed57ab
X-MS-TrafficTypeDiagnostic: DM4PR15MB5331:EE_
X-Microsoft-Antispam-PRVS: <DM4PR15MB5331360FA9AD1AD0A8611699D3069@DM4PR15MB5331.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbNvYpIqnzjcD4VrEXIr7zSqXAmKA7Rk44fF6PlbMj6E74YUsRe5ZjFu2Rz0u23uaSPh0nPW0EglLor9tMlZSfAC8mdxC91GiWGg9RHYsbWYBBtl3IQVX6w+u52zsBO+w8i1kzb/+jDe7cgGGG6c6X20MUn2gd3Q3Ivx+ckC1ORUkUzAv0R8ABGvNqsHDRBTJx31cGdqL6IIKwTefKOT0i2Il1sxg4+DdyrOB7XGxZZJ6vLjQ74e1/uthRHhhP31XyhNR8sH2AbYhmeY1fhUIlqP3m2fW4WnDxm0oJVBf9EUhUdNZLEk/ldQK4FfDHWMgVruEaCGthNf1b0Yee3WKVJ+BgpnuGBn/TynDEz2KbiGkZ9968h+sVQQXNfn3swpG2Zmh6c2BZ1eI1ajDQ+iZ7NPgWlJs9IXThqZI+yK/EaJz1/VPWe50main8vx4GvUJfKOi2ZbBB2GV2mgnXQadAsC9R8SMr1IpWnirESQ1/jAIKG7X/7UnkCbDYi+KUHbhq6NrChuNs+ZRfMXENaudjDhKN9a9gAyo8O7Yuw+1wgU/YOtvQvlJ1aWJcefEphB3W+ODjhtJVNhPE9gFj+xT7tJlxEDitFwe3vwn91hj4M1TCzsJadHHc4lm2PwvdpM/AuOYX5eQAwLOgt9J7yIhD8FzDg5imb/mMrnirPGYPai003+DcKsWfrSpmYrTnle0OwpmQxgtZR+YtbTwSjdDDe7nCvMYA1sTCMUVvuQCRQrELbScCHeaka3ZhRacFShaGGQq/n6jjJXU1ZbH5BXTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(8676002)(66556008)(66476007)(4326008)(66946007)(6506007)(52116002)(53546011)(6486002)(86362001)(508600001)(316002)(31696002)(110136005)(83380400001)(2616005)(38100700002)(6512007)(186003)(2906002)(5660300002)(36756003)(31686004)(8936002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk13SXBUc1ViVU85YVc5cldrOFZDckxGb2hCMVBvRUtGSDFCM3hkS04xajc4?=
 =?utf-8?B?eGVzeHBERTY3UGo3Ym13bWYyd1FNMHZXVXI5bXNiSWo5cHErOVZZaEJZKzlh?=
 =?utf-8?B?a0ZqaUEySWdIZ2JzK0czMCttRjgwU3lHb09WRUp5QWgwTStBZnByOC9xM25L?=
 =?utf-8?B?YUtVbFVGVE1EZkhnYWZLZjRYOXc4VWtPbkJZQTArWnczenluNTVRb3NvRC84?=
 =?utf-8?B?MTk0UHlXajdtcUZHbXNqZkJGeUxHYW50MGZyYUM4R094dERVR2ZnNHdJVjN2?=
 =?utf-8?B?Z1RYOE5WbWpqWFRCV0ZpWlNVaVVQRjcxVkE4ZXdTcGlkZ010V1pTa2ROcmRR?=
 =?utf-8?B?ZXNLV1V5MGdxeVh1NGtFUllybFRLblpxdTJKZHc2Mk1jWEtOc3JlSHhEclgy?=
 =?utf-8?B?Z2gvaWhwWUhxcVFEK2RhVkpvQ1hXSnM3dmNHL0NzRWdFeGgvR0Z0Wm9EdHMz?=
 =?utf-8?B?VExMVmprQ3FVQ29rUnduay9TejRNNTdDSDVWL1p4TmJPcDU5UHVEQmlmSWtm?=
 =?utf-8?B?NDJteFhFVUFDd2g5ZkFvQTc3NzJnNjQ5K3JndEVsN1hsckNvR3N2blYwYm1H?=
 =?utf-8?B?aHhlNjhYQVZxUWdieUVHQVM1V08zSUV1c1FVWlBUQWpjck1meFhiQ0Vadlpt?=
 =?utf-8?B?dDhpbDAraWVEbXV4a1d1ZEE0U04xR3ppNXpwOXpnZ3YvTWFZUE91Y3k0WkF5?=
 =?utf-8?B?MXRhUFNTTDcxMUJ2K1hoVEtEVTYyeFdnOGo5UlV4dVo2cVdYdjEzSE5iRWxt?=
 =?utf-8?B?NWZrV0NYMXZDcHhpcHZKemp3WnI3YXpvU3FZaHU2aHdncVhVd0swcU8xNzF1?=
 =?utf-8?B?V0Y2N3l4NXc1Sy9hcnlnWWpTNVMra2p6Q0tiejBUUS8weU9NRXhqZHhFNDFL?=
 =?utf-8?B?S0o4OEJzUFlYNC8wMzh4cFZXQVpFdTY0SWxxckx4UXprWTB2ZlJ5RzdSRnlO?=
 =?utf-8?B?eFJLdmJmeHBWKzFldXNXdVRGMkRCTU1IUWNObklZNUt5K01aQXFDSnlKQjJk?=
 =?utf-8?B?cmlnY1JoNUJ2NGh5cm5qZHNiSmZZS2U1RzBjbjNBYThpRm10SnNvRkJ6RlJQ?=
 =?utf-8?B?RHQrZzdGRzY1TVVSUWdCcU0yemowWUFXRWoveHV3UG9LRzF6c1F0ZnVDU1FM?=
 =?utf-8?B?Y0lVTDlpR3dUVy85bC9CSDlYQytjbjViVUw2bUNBd1dmcFVHY2dZdSswaDFK?=
 =?utf-8?B?Q0tDSDhabjhPMVM3MXNZVHhkTlQvVU56d0JMcUJkRmxuL0hJeXpCZU1qQ1FJ?=
 =?utf-8?B?dlp1Z2pNZFhKclVDNFF1SnljQ2QyZllvKzE3UlNXU3VOMkdZMFBlSEMzZDMr?=
 =?utf-8?B?d3hNcVYvdDRaSDVwSnRrOEpYSGhoWTd1eXhabUZRNDdKTU9aR0pRSmFhUndx?=
 =?utf-8?B?ZkFNMUsrdjhxdDF1SW5CcG9DZFZaYnBVa2Ixb1BuRUcyN0Q0Ylp6L1VqZDF6?=
 =?utf-8?B?dXN5Q2c1NW91T2V1NGR1VGZ5SkxQU2RNSUVJZjA0NWRrcEJhRVZwVGZnWTNZ?=
 =?utf-8?B?Vmc0bjYwNFJ4by82aHVPeW03dTI5Z1hkWmZ5U2JEZW1KbnRNMUJrZUpnMXl4?=
 =?utf-8?B?YVl6NDNkdTdka3JOQTlVUVZHZGFFUmpaZG4wQWhueENPOUNiTnl2RjlXRjNG?=
 =?utf-8?B?cU9zRW1OWTl3Nkc1bHJ0cXFndU9LOXZqeHA1Tzl4ZmxNWk1hYitnSjM2N3dB?=
 =?utf-8?B?aVdUdWxSTUFvVDREN0s2cXNjTTE2ZUthNUh5NXE1RHdodnRoY3NpWkNvNmg1?=
 =?utf-8?B?K0dJc3JzbHBNV2V2dTIrL3lRZ2dwWjc4d2Zlb242UjdLZyt3Q0NvcnpwUmNv?=
 =?utf-8?B?emU2QnFvSmJLc050eWwxUVJkMTJ0QXZxREJkSjVIWWhoRFdLeVRxTkN3SkYz?=
 =?utf-8?B?SC9yQnZnQlZZSW1vVFhxZERabXloMldRb3FRV2FnUkhRZFVZVXVaRzN4R0c0?=
 =?utf-8?B?SzBoM3dicEI2QXJCclRxNTVlSEVaZ0RCVTF3MEkyeG8yU2NJR3V6VlFKSXZz?=
 =?utf-8?B?dDMwVkJGWUd3b1dBM05ESG0zUUo5VzRoeDZ3dGZUZGhyZmIvSjBLVllXa21B?=
 =?utf-8?B?WWhvb3V4ZTlNRmxlTXQyOTRVVExpcXB0a1RnVWs3bTRoMWpVY2pJWFdzMWhL?=
 =?utf-8?B?ckNHSlhQMVBKZEM1YWJFaVZITUgwUWgrVUdMYkNOZ1FwSnd0eExaMmJKbkp6?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ac0411-9307-4c31-6539-08d9feed57ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 21:15:58.3065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08lfdSHA3q14o7SDKF12hLLA1qFomjCIoORn3B4b3aZZKp/A4KMcZgD6cUPEaNGn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5331
X-Proofpoint-GUID: WNILIL_tBm6DHhVyJ3cVSGLG7pqTxoI9
X-Proofpoint-ORIG-GUID: WNILIL_tBm6DHhVyJ3cVSGLG7pqTxoI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-05_08,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/4/22 11:16 AM, Hao Luo wrote:
> With the introduction of the btf_type_tag "percpu", we can add a
> MEM_PERCPU to identify those pointers that point to percpu memory.
> The ability of differetiating percpu pointers from regular memory
> pointers have two benefits:
> 
>   1. It forbids unexpected use of percpu pointers, such as direct loads.
>      In kernel, there are special functions used for accessing percpu
>      memory. Directly loading percpu memory is meaningless. We already
>      have BPF helpers like bpf_per_cpu_ptr() and bpf_this_cpu_ptr() that
>      wrap the kernel percpu functions. So we can now convert percpu
>      pointers into regular pointers in a safe way.
> 
>   2. Previously, bpf_per_cpu_ptr() and bpf_this_cpu_ptr() only work on
>      PTR_TO_PERCPU_BTF_ID, a special reg_type which describes static
>      percpu variables in kernel (we rely on pahole to encode them into
>      vmlinux BTF). Now, since we can identify __percpu tagged pointers,
>      we can also identify dynamically allocated percpu memory as well.
>      It means we can use bpf_xxx_cpu_ptr() on dynamic percpu memory.
>      This would be very convenient when accessing fields like
>      "cgroup->rstat_cpu".
> 
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Hao Luo <haoluo@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
