Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7808D647CD2
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 05:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLIEGd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 23:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLIEGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 23:06:19 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F4B4E10
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 20:06:06 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B92mVNw016832;
        Thu, 8 Dec 2022 20:05:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+TwLYkhR8Ev46r2EEfYFROGRtfmWbczwv0/nzuKA8mU=;
 b=EAZ0J3LZ9+q5754cZ13g75LjN7kSxse1SlI4+woR8dg2HQzxE20qr7wHIFP/ya1COzSb
 EGj2HEV01wE50JkISS6FLS4QIRteRR9DNqNBK6caTXDmoGWNxEe3KQvGX8+B/A1QewO8
 RRbm7fTjoicyT3FWm9ToKTFV2vmkZFGuCohu04VkS+X2fKZFlb+J461x7zs4P/i24LOP
 YGYKPNxznkQ65DuojHoTkTj9yPqcsDodY0btb5VyjjNvqVVotwcCkGor9B/hci5RUCFf
 Wr6Omruh5bFsecvsje673WxoSPKdB6Fs5GsrR/+wAcaAvIyS3iMDxJVRSyeCgKOSCvu6 wA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mbvj98eb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 20:05:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDkvZ22dmdI7pcF2AJMYVSzT/M+KgIjljprKZiucw71iYXu5qFx3ODszrbBM0Ct6XsA6FYQwdxCBAMkJMdjJLyW+3t7baVENm292yr0jRxG5wkzOBCT8Ah8oyiLvS4EojkqpiuQ+hldoptvt9iDNG0QQt80qovgNSyosc8wTVvKXeQaW9Wje7I4+BXt4iRhjV0cLKUIVRhJkgb/AySQPW6s9mxhfU3we1iGpCiF2FnlOy4UYNxImWxL36hx+cZcsvImr4s7Ikea01R1GrFAocyWsHBWKg2J7rYx/n7AJ3is2Zq3ngMHpm1WuhJKNGI2d6DqlYsjLPTcTeoE3bgIkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TwLYkhR8Ev46r2EEfYFROGRtfmWbczwv0/nzuKA8mU=;
 b=hZ5ORIZkRoh2qH/Z4aQjleei4BX3QOpT8HufN0Uc4/biL2quSq7b155ziUAvKEU4mRbk6xxkysf56FyT1yNYTmk+n9QewYsDdxPdwmUjrEOnUXu0EhFIzwa/Z25PkHQXA6pplV4qNPtwv5UZgNoOaEKa8tocgXAdGjoQlQ0Ov5b0GfEz2ngn6hN1NoRv53N2Q6SnidqukOcQeiMrpoYuDueYNSazkb3UZnFBQioSjbvQ3wesNPNv6c29iq01acq+mXmICKVz0zhNWgDEBytJlKeyf6+2Liv6lABGxWcTWg9iJpaBT/kc20PmTxPz/Mb7uUtw/lVHmeTQFhnRy3ivhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by MW4PR15MB4586.namprd15.prod.outlook.com (2603:10b6:303:107::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 9 Dec
 2022 04:05:44 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c7bf:d958:c21:f1fa]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c7bf:d958:c21:f1fa%3]) with mapi id 15.20.5880.013; Fri, 9 Dec 2022
 04:05:44 +0000
Message-ID: <69cff1f4-b023-b064-bd47-f44e6c2b6d80@meta.com>
Date:   Thu, 8 Dec 2022 20:05:41 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf] bpf: Resolve fext program type when checking map
 compatibility
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org
References: <20221208003546.14873-1-toke@redhat.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221208003546.14873-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::34) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2055:EE_|MW4PR15MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: bece5368-26ec-49b3-4341-08dad99aa499
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7eDlBKpPVwnh0XOJTIkJVzRPRfXvwrxlJspvPYRILjmJRM5NXwYoDUBCcyUh3ghya0uX190E4TkxNSciRAfFJFc96/phOJmIGBoVqGOueZ7sDEo3S7Q/uI1+GvaApdO0/NjO+lBMUN62HirUB3lcYnlhbjRRkP8QYDD0pjZVS+mg1puPPWmt5acxRrpciOIwdSat0X3DfOEyZODH+Y1v3YcFEqwO5bYC7cxl3fy49NAvZWIjzsPUVsXLK83/x8hvlJ/hX6LYoh8r89JsrR2OOeS4ptGSN1nNCgyA0r9TC3gmTgcmHM+9B7HusIdifOc4/BdWfxDoYBcQOIoFv9zfQ+UPSSOgPwyGw1XlRuf/08tk6iTwyYWdjb0UfctZSaOqc7WKy09/5MH3fXqW7vqPWeC3XnbQvE+hHGPmWivzwMbKuO0NKU3eROmy+XwBDDYTIOkj3JkOFLVBv4C58pY76hGAd4+aABi3mWj7Z+lQHv7WOUEoj/r/sf5qAo1++s6cVQ0IOaSnRCUyN9P6bfHYiA2ImlPMfIf3AuyNOzVF11gi8r35A58Nu152QWPwZqRA5mRYpGlw6QhlrKFHhKoUJrCPTTScPjqk2mn1Mvhy1NJMt3L3Lre1T3RqnuEJfsHywspoyqr6CxJBwb9hgF1ourY1j9WYbf5lOeZuZTO2/zHxT2uZRmxeElNdr5xj2s0qYyA2u4AEOZ/0Y3yQs7fXHdA51aDIfGjC0svjHy+h/naDw6/ubNoj5PYQ+B2wF0p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(38100700002)(36756003)(921005)(5660300002)(4326008)(41300700001)(86362001)(8936002)(2906002)(7416002)(83380400001)(8676002)(31696002)(66574015)(6486002)(66556008)(2616005)(316002)(110136005)(66476007)(478600001)(31686004)(66946007)(6666004)(186003)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlVuZUtzVDZieTAzaDJpNmhWb2dEZjQyMkFNUFdZc0Z1aWttd0hLUUdXakxG?=
 =?utf-8?B?anJMVWh0VllxT0ZHOU1oOUs5Z3ZpcmdpLytuT2VrRWFwYTNSeXdVSktlTnBv?=
 =?utf-8?B?cDM3YW9vQXNUTGdzZVRvcmFGNHJWN0FaK2VNYUc2QWM3OHNOS3BiZFh0bGdx?=
 =?utf-8?B?aG0rVmxnYzJQdFV6cDNNNUgwZ0QrVFlGbVNsbWlJN3hmaVo3N0gxSWRwUTRM?=
 =?utf-8?B?ZGdEK3cxWWlRN2dWMlFMcE1TRm5HYmYrb3ZiYlJLWXk4UHpjWGN4Y2dKUlVm?=
 =?utf-8?B?TEhuRFpaK201VUUycEpEdWVqRzdUY3oxaGkxbElYdVFQTVdSb3ZiN0s2R3FD?=
 =?utf-8?B?YkJNVVRNQlc2T2szV3BMMDhEeklRNFlxRkl5TnNJZjRpcGJMMHNkZGd1MG13?=
 =?utf-8?B?OGY0M1daYWdQeTFqaFpSbW05Sm90RHgzN2lPRW9tbFd2MjAxNEhYdmlpVEVr?=
 =?utf-8?B?K2MrZFh0MlNwZG9pM1ZMRkNVTnBNdFhMekFKbVpNZGVlQXFiSXZWRUxVeHFE?=
 =?utf-8?B?L0JkWGNVT2lqU25lYWp6bHVVSEw4b0UvZC82a3p4cEZMSkQwR3lwcXZCRkpF?=
 =?utf-8?B?enVMM2hjZXJiTTltMGdmR2hLWDEwOHpXMmZHNUpZUU4ybGViQ0FycjljbXd1?=
 =?utf-8?B?S0F1b2hxc1J0aEp0QURZR0tFQXJoS1JwWTlhV3BHbGswbUh3WlRtcjMxZHo4?=
 =?utf-8?B?UC96U3BjdGh4aktQalYvTzVIMjNmQTgwaC9XemxHMEpGQmlQQ3lCYkZ5UGZT?=
 =?utf-8?B?WkIyaVF5WnNCeENDdDJIWndGdDk4SG00NVFReklPZHc3VmlSLy9LeG9rZWRO?=
 =?utf-8?B?bWlYRStWTjRCdkRsUUtPa1l3QUQvK0pYeFgwQkJQZEV6d3N1bHV5ZXpNRG4w?=
 =?utf-8?B?YVNRZWNac2pSaG90Wi9WTVpKQ1cxZW1VbFB4emVwQllYL09iR2c1bUtseTZj?=
 =?utf-8?B?MDVkRkxKbW5zbGY3ZnhjOEZ0TUVkZ0EwQVRERnRTQlRRc1BmN1J5eE9PRmZS?=
 =?utf-8?B?bk00UEx2U2M2cDNjVWZVakNwYnFrakNDaW45NnhpZnUrQ0ZhUUFTWCtrWXYv?=
 =?utf-8?B?YlhOM0xxTllFcDU5QTZNVVFMTS9vbkxoVEVveXA2dzJWZ1k3aFZkTFNrSUw2?=
 =?utf-8?B?RHljNFdSbEZOQ2l6Tmtydk1tMGtuMVdpeWpsN1FOSTN6NlkzdFBHY3BkenhE?=
 =?utf-8?B?SllQMDFCSklYa2wzTUpNWWFya3BPK3dGbGdmTVljQmdnZ0NJSzNNOWRBMjJF?=
 =?utf-8?B?SjlMQ2VqK3JOdTBtRUJpTEhMay9mckVKcWhoUkNLYlRTa1UraFY5SXFXN0Z1?=
 =?utf-8?B?TFd2Ulc4d0p6b1NLZWhUZk5mMVRpM1hLeHNHd2tXeWE2SnMxbHVOMVlkYTUz?=
 =?utf-8?B?VHJYbzhQeUVuZCtKalVJNEdrYnJ1Zjk1MDNwWktrTXlkcS9NZUNvc0J0M0Ri?=
 =?utf-8?B?K0lOczR3QWtvZFRPV1VOZFI1YzZMdENQVGppL0RBMzcxUDFZU3JRRTZ2eDFo?=
 =?utf-8?B?b1UwOXZqbi9hNmI5NDZZdUV5dEo5MEMzWEhSalpqMlFzVW1jdXhEYmdoY3Ux?=
 =?utf-8?B?a3R1RzNMemtxbllTTFNFcWY4WEVza1pRQnNTUXNDb2ZWNUoxUDRpYldZbzFO?=
 =?utf-8?B?enJERmNnWmF3dDRmbVNjaDQzWHNRdTN3R29aNEtSVnJqK0xHSTZLVnJDS01j?=
 =?utf-8?B?a3JKUU9ZY21OZnhtM2V1UkZvK2g1UytpU0lJNDU3aEFkQXFwYUF4eEE1Tkxs?=
 =?utf-8?B?bDUxNUVWQnk0M2JhNHJFQWY1RkN4Z1k0RFJpMVVISVg3dkRqbGVubWtMV3Yr?=
 =?utf-8?B?UHcwSk14V0tjU2dBZUJtNFhpU0YvMUJsWjE3VTFlQW9sVFZqRG9ROG8rWnRu?=
 =?utf-8?B?UXJWK21TY25XaGRTSDYwZU41SldIU2hIUTR0TlVuVjFZdmtMVWhiWE95blA2?=
 =?utf-8?B?RHVKOCtKTElCbitvNlp4d3Y3RVp4N0p1NUNOWERsNkMrc3FvWE4rM3pVdWlY?=
 =?utf-8?B?bVVvTWZYbXlsNkxLZ0NnNGJPUG8xbGU5VE1DczhZbVBrZm5PNW82bFY2RlUw?=
 =?utf-8?B?QXhqRHU5RzdKTkRqaU9nR3c4dE04V1g5SWZXcmhjQ29DWXd4cS8ycDNyVWFV?=
 =?utf-8?B?ZGdBTHdia29yUzZjYWNpVHEraEN5YVVWaWIyeUdRQlpTY05VQzdvbHE4SmZ1?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bece5368-26ec-49b3-4341-08dad99aa499
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 04:05:44.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTZB7b0rafUE6vepxtV49GlEjJnIhOYgOQP55Ut/5LKH+he1fQZt/QSVt+25D4n9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4586
X-Proofpoint-ORIG-GUID: 9MFwos0ZF4M9Fk5eHsU0rNcdQxDm4al-
X-Proofpoint-GUID: 9MFwos0ZF4M9Fk5eHsU0rNcdQxDm4al-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_01,2022-12-08_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/7/22 4:35 PM, Toke Høiland-Jørgensen wrote:
> The bpf_prog_map_compatible() check makes sure that BPF program types are
> not mixed inside BPF map types that can contain programs (tail call maps,
> cpumaps and devmaps). It does this by setting the fields of the map->owner
> struct to the values of the first program being checked against, and
> rejecting any subsequent programs if the values don't match.
> 
> One of the values being set in the map owner struct is the program type,
> and since the code did not resolve the prog type for fext programs, the map
> owner type would be set to PROG_TYPE_EXT and subsequent loading of programs
> of the target type into the map would fail.
> 
> This bug is seen in particular for XDP programs that are loaded as
> PROG_TYPE_EXT using libxdp; these cannot insert programs into devmaps and
> cpumaps because the check fails as described above.
> 
> Fix the bug by resolving the fext program type to its target program type
> as elsewhere in the verifier. This requires constifying the parameter of
> resolve_prog_type() to avoid a compiler warning from the new call site.
> 
> Fixes: f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Could you construct a test case for this problem?

> ---
>   include/linux/bpf_verifier.h | 2 +-
>   kernel/bpf/core.c            | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
[...]
