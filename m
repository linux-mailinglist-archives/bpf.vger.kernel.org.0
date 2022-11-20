Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBBF6315D7
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiKTTZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:25:05 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412292DAA1
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:25:04 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AKB11T5017576;
        Sun, 20 Nov 2022 11:24:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=e2IO0pjsd5V+mklXjIY1LqxPkEYJ8nSFPEFgvuPn7eI=;
 b=e0oyRMc4ghHd1bJfjtpPCuMcATEC+aVLu7HilqBFqKFpAv7fqzlyPX7RJTR/sOloQ9I/
 VRmlj3tCDBskkRBgih6eK+RfgVx9Z5EcPWb+/94aVAiPj5mkwSryrtRLULdggpdu0Iuc
 SeOeGPQuTFCbg2j5llhV6A+JKSg/kswRtjQHewMvpmpJz3/B5OjoyNfNnMIodzT74LOa
 N8aEIvtQCxVqCqFLQLFuTHFLG63fjwWPJJjxAZVQAs7u+8nx5jbaIbWxCzac5RdKrSoR
 Ynus3xupbGVubUAbNnqaXyzpD2PoqI6H3Awxxn/GK8xcinSbeIfxztDi9+83sO3bzNp7 3g== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxyb977tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Nov 2022 11:24:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3mM7m1lmQpfV7U1lhVWjtUtudq9Qm3JHL/ZMdN4Zb/T/BN9ax3V8Bve1Acjx0WVa1ZqFKb+0udkqLJuN1YZ9ayhUKQlik4reOXZf00PO99wVjK1AzLeifbfTwMYRY5ewt+O4wUk5VlQMnMgKyGqRUDuGrzszCQMcPv/QzyMrVyCpi7uqtbUaSxNsjAKJv9VIsvLZdkVzkySzqgPaNUYK9/3sgljiSdjbHs/ltxcq3DlxxzucGz18MPtcxwhKR5L11soVA6S+5e3jjrjfHhZpS+2kMaej4eOpmGND5FNyfJaNozFLw13F+aNnPpt1VuviLHUx2vY/6527/mKt6RE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2IO0pjsd5V+mklXjIY1LqxPkEYJ8nSFPEFgvuPn7eI=;
 b=XC84RrPnF+MvR5hK7c5ffeEJ4VPZcVTRTN0ZGWsRehYV+4celFDjLNb3vYvwg3Vx+3CNEAeF5WQwfH20LbYxy0eqKIlSRJsiarTEIfHCQfAfAKX2EyyRgRqPAGWQGTU8TuFygOhSFYrqDnoyvMHh0rF4s5Kl2zFcHSqqqH8WeIRLvd0dWVR+R+xsLrn18F7+N+TAkAtKesx6azeMLWqt7mYHGYW6BVfnAcF6y15f/W4xG5vEC6d4ZFFV/XJPMgyhTsjTor+wPur2XkF2IZvKHr7R5AXA/aQNrgfoxVRLCER/0LRynV+iVi4AL1IoDEmIXvMeTNnP2pt5hpbE6Q/fMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5504.namprd15.prod.outlook.com (2603:10b6:8:88::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Sun, 20 Nov 2022 19:24:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Sun, 20 Nov 2022
 19:24:46 +0000
Message-ID: <e5aac610-fedc-efb9-249a-83855b806ba6@meta.com>
Date:   Sun, 20 Nov 2022 11:24:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Add a kfunc to type cast from bpf
 uapi ctx to kernel ctx
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221120161511.831691-1-yhs@fb.com>
 <20221120161522.833411-1-yhs@fb.com>
 <20221120183324.vlgassj34isouosg@macbook-pro-5.dhcp.thefacebook.com>
 <0703ccef-cb2e-3903-fe4d-e907b1b8ceea@meta.com>
 <20221120191047.nt7zsgsbvocbgjyh@macbook-pro-5.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221120191047.nt7zsgsbvocbgjyh@macbook-pro-5.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: 68286562-49b4-4276-b4d1-08dacb2ce288
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5v5J/wp3NViOKVwcoAwC1GZdWVcvyAIF04XYHQdjaAh/A+MynmMUNYCqZhCFNd/fvToSe7rc+Pf1AWgnOL5d/g961sF+6CLbPmOh9pWPWrxV9Xr1UO+EMC0D6zf8NJsQN5XDV86zkWPsyRA9xc7qu3VQDGgXa8WV2gehxinesHAcbHawdgZVha0AUzL5kaJzDrLsXug4U89zwUeiA0Y9DJWxZQC51keq/AHg7RTShc9mbWAAevoNaPw6rA1suUqWjgwkcmCHjINktEUU9QzLNhfrcKWYBhbAmd2r8c15rmd0GBcUUeuOfzEkVPEbix1xk0jk7uFQ4WQxZonJsgQ1aFwyL3/0PytJyAzKSb2+xQ4SEUaMgaRyFbImLpDtpMWzGvM3hxYZT2z5v+vdn9nLf0FMgF5wCMI1LJi8O1SR1Irx/evOb+KtG6rw/1svUpsFwwk/k2G2a0StTILx3tPzPbBOBJ5227F5UwI7ocbnuaQRA7yWL57biSOMYftUS2wXNYqzt1cB6fJNiz9Z0zNkq8I/31a6ur0ImiUIXJZhiQ4Roa021Yb0cviIbxszytDqRa0e6W1qGVWy62pYYgN62k+NOLfuA65tkIgvOLYIz03ghv5ETAN4ZaAw+5A2/akWDqwuIbc70T6N1+LXjJuXIC8lTbDoGUlihkfit3NkleLJ8i5pqXzk5L8I2x4PfXh9BC4frIj/Hq1OMkqwL+cc7ZVX0U5iyQAO53zGhIS8u2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(5660300002)(31696002)(86362001)(6506007)(6512007)(6916009)(54906003)(2616005)(66946007)(83380400001)(2906002)(66556008)(36756003)(66899015)(4326008)(8676002)(316002)(66476007)(41300700001)(8936002)(53546011)(186003)(31686004)(38100700002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFsUWMwa2RUQXVIVlpYOS92T2pLNVhRRkNCU1hKcVc2Y2lqNytsV1N0eElo?=
 =?utf-8?B?Q0RyaDJwU1MxVmVjNW90dTRCMjdJREtXM1lPNXhnSFppb3RMRm1NUFh6bHhN?=
 =?utf-8?B?R3JiVVJ2V3A2a2JLa0RVQnN2NjhvZmhGcjM0QTgwU09qMENZcytlYnd0a05E?=
 =?utf-8?B?dlhGeTBiN0YzSW16U0lxaXU2TFFXNVpOMUlhbnRySXN6dWtHbmxleUYwU3dH?=
 =?utf-8?B?UmRlVWNlQmViVVJ6RWlJandJZXNQVGNzdXNZaERXcEx3OGlqQmNBeWMwWVBT?=
 =?utf-8?B?VWgxdUNacW1GVHhwdXM2K0trc250eTBoeWJMUVVFOGRJNm1NOEc5Wm4rZnN4?=
 =?utf-8?B?YlJkenRXL3hUVTc5ajZpdWZzc3BDVXZjeTljb2FWeTFBN0xWcG1Bdmlzd2Y5?=
 =?utf-8?B?dzhTdmtpSVFaUTJrZmg5bXF6dEhnaGNBV3lUaEJ4S1g3UWxEaXU5NnVrSnNj?=
 =?utf-8?B?eEcvVWp5SUU0SGpkRGdmeCtmeFMxRHRNODNtNGV1MU16RUQ0U2dDd3JLTTF2?=
 =?utf-8?B?cXdEWDJZTjVNZWlTS2UyY255WkNpQXNPUThsQ2tsd1Q2RHFMZ0NWV1FtcXVD?=
 =?utf-8?B?YUpwc3M2WkhpU2ZyNVJ2YUdhK0RiS2F3WnF5TlBOZjRmRGFhbVNTMWdteEF4?=
 =?utf-8?B?OXgrQ3ViZitRbk5xTEVYQ0VhSTFsOFhYM1BneXpGVUg1ckR1ZGpGTUM3VUdq?=
 =?utf-8?B?WDVxNksvUittaW1SV3VNN1BhQU5kVnZCRUxnRkJRU1UrakxGRE1BNjc2TXZR?=
 =?utf-8?B?dEtHR041WUNZMEpvdC9sazVuVUFBdmx6UmN1Y0JReElGcFhSMEZWWXpTMlBo?=
 =?utf-8?B?M05OdkE3SXlWNytZcWVnVktWMXduYlhjcUFIVjVDcGpQLzhNVVJtU3JML2tU?=
 =?utf-8?B?OU9EaEE3VndBWXUrdjQ3UFNCZytoaytSbnI3OWtuVXVHSVJkV1JOTndtZ0Fw?=
 =?utf-8?B?bWN6aHhYRVdpdCtwbnVseER1Q3h4aXF3bm1CbFdxZ0Q4dmg0ZU8zK2xwY1My?=
 =?utf-8?B?WlRhQ3p6d0dyZjljNWk5ME13Z1Q3S1VKeklUVGZGYVNtL2FXQ0tneFo2UHBN?=
 =?utf-8?B?aUQ1N3hiY2djUUZJd2NJQ3BCd3pBMzFkTndudU1ldUd5ZTY4QXdKQlJ2WjJ5?=
 =?utf-8?B?V0FOK3FJWFlWOTZ5aXRkSGl6MkFMQnBQd1k5RGFnRnA0SjZIZE51SkFKMFJu?=
 =?utf-8?B?a3A4QTFrcUdpcEVOeGFkVkFhM0ZoNHZtRy9zQ2V4d3lyM0EvUmNUNXhDaWVs?=
 =?utf-8?B?VkRuanZmYldpNnd1bFkyRGw3U0V5TThuTHFZYjB2T0xLdGRmbGxZZm5wZHlo?=
 =?utf-8?B?dTFtNllxZy9mZ3dzb1pQZmp3TVRuZC9DUmdOL1k2SFZlR1k3eUdiTU52aU9W?=
 =?utf-8?B?NlZWaWc3dmZPQ0JoNkhHb2UxaVhiSkhVWjZjUENmU3I2RFVidXM2SFV6cktn?=
 =?utf-8?B?NDZNejR3V1B1d2gvMzRzR3ZtcW9pVnlVNWR4UmthTHBVQVFVa0FvQys4Y0JH?=
 =?utf-8?B?bVN2OFh6d3ozVDJBOGxjQWFMQ1ovRUM1MXNXTXNTV1c4WFVkaml4aXEyaEZm?=
 =?utf-8?B?VDRnR3FzeWhUdk80Mm5FKytFQ2M1NHhWOWEvaitkaGpQUU5UWEtLeVlZVzhU?=
 =?utf-8?B?VFNFY3pGVTVDdERPNkluanlTYjlidTJzcURYNmVXdlNvb01pRlROamthMGN4?=
 =?utf-8?B?ZmpFVnhCVExOYS9SUERoQ3hNMWZRTXdxb0FEa2lWMkQ2OTBwOGg1QzdKcEtx?=
 =?utf-8?B?NVJYUWl2cjJhNEF3NFZBMDRjVzZpWnVVTGgycG1ZVnhQMldQK0xyUW9vb05l?=
 =?utf-8?B?b0pVUlBYbE9vc1phdlhhaHA4Ymx3c2lvVXB2SGZGT2R5OERCTG1SeFpJUjdV?=
 =?utf-8?B?aldtUVVSNkx2ZUlub29PdHdKSWxLejlvKzBrYW5CZFlxQStJajIyOURLdnRC?=
 =?utf-8?B?OFJNQWNVdE56ejVjVGJDd3RUcTltWmRsYlN3TW5MaFN6TFhPUXhJek9nNFVv?=
 =?utf-8?B?TWo3bHRkdy9iczgyd254ZWF5Ky93VnZuVlppNWsxMnowNTFHaFZwR2h0cFU4?=
 =?utf-8?B?Y01LaWUwNzdkd3AwUERBbFdNQTFhbUJ4R0EyRlJ6YSt2U3Z5U3lXM3V3M1lE?=
 =?utf-8?B?MFJ0cC8wSlZjYU1kanh4VGJNbElBNklMRjd0QXB1OUVMcGtBU2Jnd1QrRSti?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68286562-49b4-4276-b4d1-08dacb2ce288
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 19:24:46.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Tn1YIrFfREdAlao5GHwdX7lvSfZKb+FNPO73bRL7k5vygZVTugIUURrSD5KnOiU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5504
X-Proofpoint-GUID: 36Agan77Zp24hHKhMUacNxqlhOlWqZiW
X-Proofpoint-ORIG-GUID: 36Agan77Zp24hHKhMUacNxqlhOlWqZiW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/22 11:10 AM, Alexei Starovoitov wrote:
> On Sun, Nov 20, 2022 at 10:55:54AM -0800, Yonghong Song wrote:
>>
>>
>> On 11/20/22 10:33 AM, Alexei Starovoitov wrote:
>>> On Sun, Nov 20, 2022 at 08:15:22AM -0800, Yonghong Song wrote:
>>>> Implement bpf_cast_to_kern_ctx() kfunc which does a type cast
>>>> of a uapi ctx object to the corresponding kernel ctx. Previously
>>>> if users want to access some data available in kctx but not
>>>> in uapi ctx, bpf_probe_read_kernel() helper is needed.
>>>> The introduction of bpf_cast_to_kern_ctx() allows direct
>>>> memory access which makes code simpler and easier to understand.
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    include/linux/btf.h   |  5 +++++
>>>>    kernel/bpf/btf.c      | 25 +++++++++++++++++++++++++
>>>>    kernel/bpf/helpers.c  |  6 ++++++
>>>>    kernel/bpf/verifier.c | 21 +++++++++++++++++++++
>>>>    4 files changed, 57 insertions(+)
>>>>
>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>> index d5b26380a60f..4b5d799f5d02 100644
>>>> --- a/include/linux/btf.h
>>>> +++ b/include/linux/btf.h
>>>> @@ -470,6 +470,7 @@ const struct btf_member *
>>>>    btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>>>>    		      const struct btf_type *t, enum bpf_prog_type prog_type,
>>>>    		      int arg);
>>>> +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
>>>>    bool btf_types_are_same(const struct btf *btf1, u32 id1,
>>>>    			const struct btf *btf2, u32 id2);
>>>>    #else
>>>> @@ -514,6 +515,10 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>>>>    {
>>>>    	return NULL;
>>>>    }
>>>> +static inline int get_kern_ctx_btf_id(struct bpf_verifier_log *log,
>>>> +				      enum bpf_prog_type prog_type) {
>>>> +	return -EINVAL;
>>>> +}
>>>>    static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
>>>>    				      const struct btf *btf2, u32 id2)
>>>>    {
>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>> index 0a3abbe56c5d..bef1b6cfe6b8 100644
>>>> --- a/kernel/bpf/btf.c
>>>> +++ b/kernel/bpf/btf.c
>>>> @@ -5603,6 +5603,31 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
>>>>    	return kern_ctx_type->type;
>>>>    }
>>>> +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type)
>>>> +{
>>>> +	const struct btf_member *kctx_member;
>>>> +	const struct btf_type *conv_struct;
>>>> +	const struct btf_type *kctx_type;
>>>> +	u32 kctx_type_id;
>>>> +
>>>> +	conv_struct = bpf_ctx_convert.t;
>>>> +	if (!conv_struct) {
>>>> +		bpf_log(log, "btf_vmlinux is malformed\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>
>>> If we get to this point this internal pointer would be already checked.
>>> No need to check it again. Just use it.
>>
>> This is probably not true.
>>
>> Currently, conv_struct is tested in function btf_get_prog_ctx_type() which
>> is called by get_kfunc_ptr_arg_type().
>>
>> const struct btf_member *
>> btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>>                        const struct btf_type *t, enum bpf_prog_type
>> prog_type,
>>                        int arg)
>> {
>>          const struct btf_type *conv_struct;
>>          const struct btf_type *ctx_struct;
>>          const struct btf_member *ctx_type;
>>          const char *tname, *ctx_tname;
>>
>>          conv_struct = bpf_ctx_convert.t;
>>          if (!conv_struct) {
>>                  bpf_log(log, "btf_vmlinux is malformed\n");
>>                  return NULL;
>>          }
>> 	...
>> }
>>
>> In get_kfunc_ptr_arg_type(),
>>
>> ...
>>
>>          /* In this function, we verify the kfunc's BTF as per the argument
>> type,
>>           * leaving the rest of the verification with respect to the register
>>           * type to our caller. When a set of conditions hold in the BTF type
>> of
>>           * arguments, we resolve it to a known kfunc_ptr_arg_type.
>>           */
>>          if (btf_get_prog_ctx_type(&env->log, meta->btf, t,
>> resolve_prog_type(env->prog), argno))
>>                  return KF_ARG_PTR_TO_CTX;
>>
>> Note that if bpf_ctx_convert.t is NULL, btf_get_prog_ctx_type() simply
>> returns NULL and the logic simply follows through.
> 
> Right. It will return NULL and the code further won't see KF_ARG_PTR_TO_CTX
> and will not call get_kern_ctx_btf_id().
> So it still looks to me that the check can be dropped.
> 
>> Should we actually add a NULL checking for bpf_ctx_convert.t in
>> bpf_parse_vmlinux?
> 
> Ideally yes, but right now CONFIG_DEBUG_INFO_BTF can be enabled
> independently and I'm afraid btf_get_prog_ctx_type() can be called
> via btf_translate_to_vmlinux() even when btf_vmlinux == NULL.
> So bpf_ctx_convert.t == NULL at that point
> because btf_parse_vmlinux wasn't called.

Okay, I see. btf_get_prog_ctx_type() could be called even when vmlinux 
btf is not parsed yet. But get_kfunc_ptr_arg_type() should already
have vmlinux parsed properly. So for bpf_cast_to_kern_ctx handling,
bpf_ctx_convert.t should not be NULL.

Will drop the error checking in the next revision.

> 
>>
>> ...
>>          err = btf_check_type_tags(env, btf, 1);
>>          if (err)
>>                  goto errout;
>>
>>          /* btf_parse_vmlinux() runs under bpf_verifier_lock */
>>          bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
>>
>>          bpf_struct_ops_init(btf, log);
>> ...
>>
