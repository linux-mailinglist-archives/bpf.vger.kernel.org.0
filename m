Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3D164A591
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiLLRIg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiLLRIa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:08:30 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDEA6373
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 09:08:28 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BCG7kEw021283;
        Mon, 12 Dec 2022 09:08:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=15TrgPY7ZNe333fDWrB/uJHRDLO2+8SEEoRM3az1K7k=;
 b=TcRkHZ0GXauYQVjBbrft3nlmCtACiUnioUBRXM7ntl5diWVfd9lUcveBuTWKLKeC4RTq
 0SxHerad/oNXiIw70Oo1ScyuSg3rGQy3AwejNB8gtK6Sm3mhYNWKodP0IYEWfeHhsdI5
 9CDII2RgLa5SEgjjYR2Kztpwyo5qqQq4/j9h0jEKpSQ0S0d0CZFOtiyYxwgwuxgDLnkF
 9rFW1bNrviyK2D37pOsByRS+5dze0ZMk8AgdPk7ney2kp13JN1TqEizcoInhIuaJezkX
 OzQRW4OSaB2T5azC0MgW2wPPyvScNDLRTjfRHvUbf0cmxnZWgsmAwT8b7/2RnWlntuyR Pg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by m0001303.ppops.net (PPS) with ESMTPS id 3me4u21yxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 09:08:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ2S6iod8n8BissS8lREynFSP/sjPeKT+0bsR05ApxuNvD/SedEOVl6tWuk7rZV8P0Rjj/75OSQgsQETzvFBnoG29DBb3MJ2boBHjZCzt9TKhTobqYc+WCbuQv1lLYFkCYaDGYgZ9HRbdyqN42OnHDCxrglR4yBkLxUVaWJ/VzW1mP9ne/fVbgEaVEBjRid77yquzQpPlmTMgTI4eWAgbFwEz+q9ehC5II6zleM8PDNgrP33KYH6qlUcJ3ncWi8Kc37fiP1xRY0x6NgyRTSM9xsl/qLcfEmN1hSBOET0ecyz1waZDoBizz9nMvQ3ulZqCpgjj1FLQclsD32RDlkVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15TrgPY7ZNe333fDWrB/uJHRDLO2+8SEEoRM3az1K7k=;
 b=kW2t71tpbItoDGKA8Z2OoIsXwEL3f2c4C0gjbs5r9FXsxQBxgdgUhokcNyloLFBCRRujwUu9FcrxrpNW7w5EGawDDP5rYafvnbmCNJ020nUCnThtw73K1Vl3g0OKTcEO+1FOGCmyEpXIQugiR1fx+02xk0I0glPXdaQCQmhY8uqvrjEqXrMIT7zD/y3M2X7wqoBM/wD7ZfbkaBRWQvnDEG5yK+jlzquD5b59evfBhqkBdnQvEDI9wP93Vctur+p/4V7bfD9KfjdYajIRSb4mqq3aCkrubRZ79oQqkGmF4Ey/hwKuESSzEFZNtqNF2AtNsg3x5gg9D7QHCTt3c5ZpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by MWHPR15MB1230.namprd15.prod.outlook.com (2603:10b6:320:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 12 Dec
 2022 17:08:07 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::f462:bf61:5f19:e2e9]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::f462:bf61:5f19:e2e9%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 17:08:07 +0000
Message-ID: <b1698393-2bec-edb9-5adc-d076bfc2b188@meta.com>
Date:   Mon, 12 Dec 2022 09:08:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
To:     Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <cover.1670847888.git.vmalik@redhat.com>
 <d4a7235586e3ca1b667f220de7b4835a1382397c.1670847888.git.vmalik@redhat.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <d4a7235586e3ca1b667f220de7b4835a1382397c.1670847888.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2055:EE_|MWHPR15MB1230:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f738105-5b50-4306-50e7-08dadc636f6e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCZqvuvGH+xw8LEC0Li6JYec5GKIKvIyZI73du8yPnY68vlqXDHEtL3hvdwQnD94OzXzHkH6hTMJ/aszjH/xowSeM72iae3DnlnID9+zwiAYjLA8nEEBKZoJrW2P5BV1GRZ8KS8EIByZ3QpGMmbEJlzjgAcNA4TZz4uP9h+/7amj36XaZHMIRMjLRjF8hgoJPI8/0kihk1LsfnsNtXEXVWrmS6W2ysx8E93LZZF52pTYXqD6w2PdVpyTRXkvBcueUrWzNSQ3al8jI4gHxXMyILKh8qGquQhDEnwAi47UMGnq418M6fIfdoQ0RHXefYagD5S+twgYXlXVf82ltk1oGdGQotiDnJlMTNpKa0i8D6QiX4bxlOvTITAmqnaIRQz1pFFWa+qGym0zuiAwDNoZNa9KIa+inYZLJ/et2UJ/fYqltWSL0pZ/aTBLBF1xxzSrdVdAE/o5MJZpfX5PvXplT4q5Qcmw6hcRFhT+z6rNIhHrfTGey4Nw1R0CMVoVvasSawfV7l9PsnhKt17Du0ysa1AI9Gg54dl8tYY3foToEFFP34c+XEEXCep6gkGejAqlMiHpPRCbkKgB2jA8SX9xYZ2c/Fj0NDQKrmSOP6Rl4RAoFsPpceXzh24DbJTGXGVlBdLOEX42K9+ewrznmbwILayOkELzCJBjsobijZJ8gtBDh/bAww9AJorSlKjFRZEN+utdRRplYfVTkrsi3uf8K+MCJ87Nhhg51PuqFLwL1EI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(6486002)(2906002)(41300700001)(83380400001)(2616005)(186003)(478600001)(6506007)(6666004)(6512007)(53546011)(36756003)(31696002)(86362001)(5660300002)(31686004)(66476007)(66556008)(66946007)(8676002)(316002)(4326008)(54906003)(38100700002)(7416002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1luaSsvMnc2NExrNWFYekVtYUllN3NPZ09SdmZhWkVZbGRvaXo0L2RqU0w1?=
 =?utf-8?B?a2VPeVNkRitpalZwNHlUcFlnYXZwcTVXV2VJQkF6b1hUanVYUE9udmljS1Fu?=
 =?utf-8?B?dFJJaVo3TDFQSEpjL1NGRURtSm5SRlNDVzFuMzM1dXFhQ2l1dEYvQm0xL1BW?=
 =?utf-8?B?eU9Zc3lMdG82Qk15c094OFRKT24rSmZpNUYrYzJoWDFTbkxIbFVzSkwwRHVl?=
 =?utf-8?B?QTFTbUxlbER3Nk03bSs1Sk9STSt3K05qMS9yVzczVDQ3eDVpMXFsNEd0T25K?=
 =?utf-8?B?TlM4bldFTGxsMkF2ejdJbFpQcWFwZFpZTi9ZZHZFd1V0eWk1dDYxVC9vbXZq?=
 =?utf-8?B?OXFSWDc5TUNjeUxwUWcwS2xTK2NtRUV6L1JjWEdkZlMzUWdxMkFQZDUxSWFu?=
 =?utf-8?B?UlZCU2d0WFFHNXFFMUtjWUhzMHFXWlNSMk5BUVRkZkpOaERnWm9ocTRkcTRJ?=
 =?utf-8?B?VjNFdG1WSHVMaWY0aWtFQjNkMU91b3MzMlkvbC9JZVFuSi9SRHB0d2pEcTlE?=
 =?utf-8?B?M3p6K2VOSjZRbHlKTVV4KzRCNTliOWtHc0YvREMwc1pydHdITktWd2F0a1Vy?=
 =?utf-8?B?a0M0RnJOMHdUZXQxYzFqUlk5M0gxcDlDYkNBaFhoUGlGTFZZcVA5RElxa2dI?=
 =?utf-8?B?cnRXUXFXQXkydm9iZ1pXclRkdFcxb2FYNHNOSDRkUGl1aktyU2kvRUtsU3pB?=
 =?utf-8?B?cndGWURTRHNsN0ptRElHMzF5REM2alY2N3pkR3FSY1Y3eDZUR2grWTBnYXJG?=
 =?utf-8?B?U1ZSZkNwN0ZOOUlRR2gyMFlQOXpVNFVkWFFBaWgwbE1Oczk1Vzh0ZzlEdU4v?=
 =?utf-8?B?VkJrMzlkdWYxZjE2RUFyaGZzZFpGTGY4ZjBFaUhENG9FaDBkWjhRNGttUEF1?=
 =?utf-8?B?cVFZRWt0R0taWFVja3hPaDArMVFFSi9QaElsM3Y1cExvT01ObkN4UVNyVkgr?=
 =?utf-8?B?RUlhWlorTWRuUDRVREVHcytTbThjVncxL2gwTmhNKy9hbHVtRDU3dGVjaWgz?=
 =?utf-8?B?NS9kZ1IweitrUnV4aVU0b1RybDF2b2oxZkFRZ2prTDNvc0pGdTk0M3pSa1lD?=
 =?utf-8?B?N2RsTFUrMHlIMm5UbVh0M09GenU2QWpYUUg4WFlNZXZqaWszcFdCQjF0cDZ3?=
 =?utf-8?B?b3J3azlhUkpFN3JaTnhpa0JlYmk1UWVKT2IxS0xzazV1eC9kaklxZlM5akYr?=
 =?utf-8?B?SzhuQzhIU3o1NjVCV3ZDMmpSWTZhV3h2N251N1Z3T3Qvd3BlY0hmS3JXSVJr?=
 =?utf-8?B?VG1wczFFcVEwSW1aQkR5djVDTTlWelE3UjVrL1pTOU5OVkp3UUVqVVNQZ1M5?=
 =?utf-8?B?L2M0QkVteG5pa0RVSDRnd25WcFFoWHRmbTlwRk11QzVxNytUaVNpSEhpMzlD?=
 =?utf-8?B?OGRaM0xhS0w3dVhlNmF0UXBURzVyQ1VGWFBVdmRpUVF3SkxaeTdLSnlNQVVs?=
 =?utf-8?B?UlN0b1VRSmR4L3ZyazlrdVBlbmM2VU16N0FpaFFiUURiSmk4Qk5Kcm81a05E?=
 =?utf-8?B?UnJ6Ti9jWFJvNlJtTEY1cElYcjB6YVF6Z1NURUJZVXNrREFyS3MyaVY5NEJE?=
 =?utf-8?B?YVdiYlI2R1ZJR3dkTDdZZEdjSjZ2YU5oTy8vbUYxWDY0dzlWbkh4SHhIekhi?=
 =?utf-8?B?NURtMklzOHNYMlNtOFhTOHA3akFFM1NzbVFFTGM5cklaRE1DTEUwOHNUd1ZT?=
 =?utf-8?B?N1c3UitxODdXdDhFT3JuTnpBSURWUlluOXpERUhLVmJHVks5ai9WK0tHMHds?=
 =?utf-8?B?eGh2c2QwR1pWUEJiWXU5QXZoMVg3Um8xUlkyZzBicmhBZWZMS1ZZWDcvRTNK?=
 =?utf-8?B?dzJ5VGVyUHdhLzYzSE9sM2ViTVBOZ3NITFNmOXdGZi9DZmY3WXNPdll4N0VW?=
 =?utf-8?B?YmgrK2Zxb0FaUGttaG9VMDlZSTFWRC9CZWtkcm11RVN6anJ4amtkYWF6Vk11?=
 =?utf-8?B?ekdLWWw1Q2phdmJ5ZmlidFlENm11ZDhhMnVXQzBJdVZ0ZXBIUksxQ1M1Szdo?=
 =?utf-8?B?WGpDTWVxMHBheXlSWU0xOEpsNkZLOTMrKzlLVUZGTHVzWXp6dWpBTXJPNmJW?=
 =?utf-8?B?bE5KWVRnR0RyMVUxRXZlSG9SVTM1cUhRTE9YYmxseTFEQytjbWZkTU1pc2NF?=
 =?utf-8?B?STdjdW0yM3c0QU8vNnFpK3Y0a1l2RStFbFQvTE9ud2h6cWJyMzhVeFFmWXdk?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f738105-5b50-4306-50e7-08dadc636f6e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 17:08:06.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOAcb9st7QcYAIIAzR1M/8LUpzMr9JA762L1r5KHAnV/Po31xMpMOdoV2obPMMAP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1230
X-Proofpoint-ORIG-GUID: 33x71t0Se_VNMDozGEVi554cMd0Ej6aV
X-Proofpoint-GUID: 33x71t0Se_VNMDozGEVi554cMd0Ej6aV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/12/22 4:59 AM, Viktor Malik wrote:
> When attaching fentry/fexit/fmod_ret/lsm to a function located in a
> module without specifying the target program, the verifier tries to find
> the address to attach to in kallsyms. This is always done by searching
> the entire kallsyms, not respecting the module in which the function is
> located.
> 
> This approach causes an incorrect attachment address to be computed if
> the function to attach to is shadowed by a function of the same name
> located earlier in kallsyms.
> 
> Since the attachment must contain the BTF of the program to attach to,
> we may extract the module from it and search for the function address in
> the module.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>   kernel/bpf/verifier.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a5255a0dcbb6..d646c5263bc5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24,6 +24,7 @@
>   #include <linux/bpf_lsm.h>
>   #include <linux/btf_ids.h>
>   #include <linux/poison.h>
> +#include "../module/internal.h"
>   
>   #include "disasm.h"
>   
> @@ -16478,6 +16479,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>   	const char *tname;
>   	struct btf *btf;
>   	long addr = 0;
> +	struct module *mod;
>   
>   	if (!btf_id) {
>   		bpf_log(log, "Tracing programs must provide btf_id\n");
> @@ -16645,7 +16647,19 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>   			else
>   				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>   		} else {
> -			addr = kallsyms_lookup_name(tname);
> +			if (btf_is_module(btf)) {
> +				preempt_disable();
> +				mod = btf_try_get_module(btf);
> +				if (mod) {
> +					addr = find_kallsyms_symbol_value(mod, tname);
> +					module_put(mod);
> +				} else {
> +					addr = 0;
> +				}
> +				preempt_enable();

What if module is unloaded right after preempt_enabled so 'addr' becomes 
invalid? Is this a corner case we should consider?

> +			} else {
> +				addr = kallsyms_lookup_name(tname);
> +			}
>   			if (!addr) {
>   				bpf_log(log,
>   					"The address of function %s cannot be found\n",
