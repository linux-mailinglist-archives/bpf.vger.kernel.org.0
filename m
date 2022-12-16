Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B582064E6D3
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 06:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiLPFGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 00:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLPFGl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 00:06:41 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C574F49B4C;
        Thu, 15 Dec 2022 21:06:40 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG4YBFL017442;
        Thu, 15 Dec 2022 21:06:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=TMEK4veVCtb34RKdn8QTQmuK0Gx3r352nY9SeWBsqcQ=;
 b=M1k3rHVzF5bfeIL6Bqzh9eOERzX//xP/Zf/0Dz+ho3FqB+yb4oppzCMTTZ/PzIO9kDpS
 ABWhUutgcLiQI7wF+uhhDZ6olbVIA8eaXB+nkgcadfg/yIUQR89G91YeksLxj9BS3zlJ
 sGOjS6C0OOX9AxFnhc456moI4F0yAyYM8bHe2VqJ+/2QVC2ypR6AEOQaAUWV5zSnHqWB
 Nz8tMjENZH/rbJY5kJvogXsCR5HBdjWqw5lGyfo+DNbZ97vouN6keCvhVz24lBOb/r4z
 jvoksL7dJBpwQwWcckGVeoG3WIIEtHJEPXa8MCuCd1a6uwSGESv+hxt0BaZGfS2zHSu3 CA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mg3hhwx8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 21:06:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDk85GJKvSQKs7XQ0JDMP4PVoR9cdn5OCaO4Y/MrzRZhNdXlIhsPkC++JtkymNVuNpiul7DOHh7GUEZiu2uw5K2b4XZpeLao/D7vhy9mqhd0h2BW9+VwQpOYZQzIGUCHjHOx6+veOsDRhMXBqSJfsHVRGT3kwg4HYnIPkarJuBBNF8JkqLt6U+gtTiToK9q6T+x2GHUJ/7/FP//cCg5ORMeWBdR79H5ahZWUnUGU9mOd6KvShGNyMocPWuIzMVk/l1QGr4ar/468bTpQaTmrhs6EUJS3tksy57rL89I2xWmDEMZzcftbGaVJoRjnE99NVbq4+YvWob4jJrBnk9jKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMEK4veVCtb34RKdn8QTQmuK0Gx3r352nY9SeWBsqcQ=;
 b=A1Iv5mzOKxiMoEwI14dPXCjNSy4KzwUig3dXrznmnUKTWkI86cW0nToj95CjjGHVuY58Y1DW9y+lmRBI2LQPnPYUVOcesbdsp0Yht1e8wolO3Rb329RVHM/erKiLP4WKCWNSPxRUZgN2uPmpcaPqOFgZ+UY51uK/kXeP5dJ9B85kWMGY2VFUKDhabhIaBaiyg+Qgb0ebtTx1JHpBwYATqC0uWNNnAxRAwM0WA3ZqVQKacx5wVWjAhGHvN0GFyOxv/h4EDrO21vaKuqxI/keQ3QqlfJqNsK2K9p2L9Rn3jWBZ9n+w9T0PIdtVj3f4lmsxG/RiN7cmroH+ffHiUfmkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1450.namprd15.prod.outlook.com (2603:10b6:3:d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 05:06:20 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 05:06:20 +0000
Message-ID: <0fc1e9bd-e70b-28a2-bc09-629414a619b0@meta.com>
Date:   Thu, 15 Dec 2022 21:06:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next v2] bpf: btf: limit logging of ignored BTF
 mismatches
Content-Language: en-US
To:     Connor O'Brien <connoro@google.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221215005315.186787-1-connoro@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221215005315.186787-1-connoro@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1450:EE_
X-MS-Office365-Filtering-Correlation-Id: db42ae19-dcc6-46bc-8a31-08dadf234512
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gr9DTvIQWqeqC61c2+FHXr6hq4+QqctifMAggkqYYnAZZ6prRUcJTHmVp+e3tTz3+rFkzwbrAi2gYuiQ76fWI2L5hw0O2mD6K4pBguA5ejUjImtj8477lIMfHRYDfhZTtN5G7zLU/YBSeGytJfe6XhiVqfQU9oN19E9Ft/q0SZ/8SZzP/plfiz6yOgGwJCRKmCUG0MYoSuX4U6mXxIbXxM4BJ6BwaOE2081hvNGJxvA7ajykqfoNt0hrDN0fJhFIY+df26MhOWiaYK2JJt7mNSRZez+jntyrNhQtG3YW9QazXL+v587E+4dP/beoW7Y4K4I19bUDQoO37XRzOFRhsBzzIlEWyE1jPVgernP7qjnDQMj5l9TB98OxfG112fEjqb49ecwSUjYb/MNuyDZFdgQ1w3IrUmMXUHhWG44oTDecmqAMSAxW97JcF6asmMYqqlaAmm9b2qEHjO6zzvt7/Ges/2nAScZx8FkbzdsPWnhS8Vuz6LAdFwDbZzhH3gy9LdP2EhDUPXzgHuGyuH32KzTZZPbmFtBra4tslQ5xEOF+iILgQE1MJqcdkOnNfarYJOmKQmhSU8ULarbM4CMjbUotzKEUTYRx7kvRgxAXVQ47M7x9hVvKtLj2BKDs9SRPbGE5qwc6B8uXOVq2UQoYVsv7WojCb4GBya8B1J97ZLpPgqUkXQWH8k/WgYpNjFuQrkiSFdJo8KzYPmYdAyOR9ARIz5TFK3fMIHHtNZ3neCYPCe7VVFc9LQosD8RMqXc2XfHtF8X7L8yCzBPSnXBbpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199015)(36756003)(31686004)(38100700002)(2906002)(8676002)(66476007)(4326008)(66556008)(66946007)(7416002)(5660300002)(83380400001)(31696002)(8936002)(86362001)(966005)(6486002)(478600001)(316002)(54906003)(41300700001)(6512007)(2616005)(6506007)(53546011)(186003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZjQ3NRYnY2dHFYNzVjK3dZanRNRXlxbFpNcFVvOHU0and4djBCTU5BZGxF?=
 =?utf-8?B?b004L0NtUENpanpzTzVoUFdibndQNGxwUHFxMU5Jazl1QklHSEViSFcrWHZU?=
 =?utf-8?B?ak1lWHlRWWN3WGI2aWV1eWp6RkczWllWVnFJOU1UeEdhY3BCWjdpODE3L0Qy?=
 =?utf-8?B?SUFkYW1Wb2xsTTRtQ2tIZjZTOFZrd0JIVDJNU21ZUHFEVXExbzlraUpQaHNt?=
 =?utf-8?B?NHozczlwdHFReWNTZWZDRzZPWnRCOVdFZG0wSU1xQVVwRnRBZXRSZVo5RFhx?=
 =?utf-8?B?Q21MMHloMVlzUlN1OUVRNFp6ME0wMUthNytVOGQ2UVdSQWt0RUUwR1FoZnBF?=
 =?utf-8?B?KzlmZW5iWUZtR0ZlY0wyMDQrU21BSEROOTVqZzVkbnVFNmd2dWZGeEl0eUkz?=
 =?utf-8?B?V1d4MGVsbGZiQkUyanM4OHR3d1E2NlM5clBtVkwwUWFmOHhhNWNWeitNM1ZQ?=
 =?utf-8?B?SUxETVdBRkJCOUNtdmtjVjFVa2l1TnhxeUhtZmFNY20wczVjQVRCNXFsM3F1?=
 =?utf-8?B?Y09acGdCajVad29qS2tYMVVob1BiTWxsT1l3eTdUMTl4cHBRenRSRUJGM2sz?=
 =?utf-8?B?Y3JlTGUveENQeHFacTFHbXNSbUU2VlRHRS9obnlaY0NjL3lVNi9aRmk5cDZQ?=
 =?utf-8?B?N25LYWFPeVZQVGkzWldWQVBNVFhPNEFiVW9FRHJTWXpDNWtjQ1dNUTduRjI1?=
 =?utf-8?B?Sm5VWTJYcWVmd25XMklYZE5QTTJ3S0JxN0l6Y0ViRW9kVTNpeFFYM2c5QXFh?=
 =?utf-8?B?eG8zOSs2RFB1K3Nvak1Za2tPcHM3bTV1bnFKZUExQWtVZTNxRExXZ2R0cnhX?=
 =?utf-8?B?dzFNbUtiY3BKVE5nNi9TWUJzRDY5UXZMUTU5MXF4NUZkTGJRWmQxckViWUJS?=
 =?utf-8?B?L2QybFFjQzMzT3l2dk9iaE5NWjBCZjJINmdsdGJUWndkOEtzK0ZIeCtCQmgz?=
 =?utf-8?B?Y2hSSUNMM2JUQU9NTXZkOHgvdGhsQkVLcmxKSWdaM1h3V2RyYkpMd0diSEM0?=
 =?utf-8?B?c3A2QmFwR201ZWNHZFhZSmQvdmlTWnJRY1BSUHRNdnQyM3ZQYkxDVFE4VFR1?=
 =?utf-8?B?L09iKy9FWGY4dGMrV3dibUlkSU9idlRqTlBsMG9mdXEwN0NlUGZHMi9yTkQ2?=
 =?utf-8?B?RVZYRFlzNEhRWi85a3hmZVFjQ21mUXBocTBScFRCTUJpd1oycVd0eVB6ZW4r?=
 =?utf-8?B?b3hkU2hGVnFycGUyVEtHY1lPNDl1RCs2TTg2dSt2QTlqeFI3OXRsZkE1Q1g2?=
 =?utf-8?B?Z1dhVkxsaHhMbHlBMGh2bDFGWmlYZWxUZXJRMWpETldhNjF6czVwR1JzZXRu?=
 =?utf-8?B?Q1NvL05OMWlSa1p4SHJ6WURhVEoxdjhzc29WdStzY2xlcG5Da0JyNXZnNGlS?=
 =?utf-8?B?K2IwMVZPcEU2RHl0U3dvR1FialVyYWpHbEhXQi9yVUQvWGFOWWI3MEhmL1RJ?=
 =?utf-8?B?dVVEc1lkVFpyOVBYU29Db051Y0RlbzFtUG1ocnJ2UUI5Zm5VWm5RNkw2U0pK?=
 =?utf-8?B?SnhNSjh4QzRWalVsZzJXQ09HOUo2VTJwT3BLbVcrRzN2bndwaGVVMmxhb2hD?=
 =?utf-8?B?YjBwR1JmSFZMd0xrREdhemJoeVRtQ3B2Y3diS3dwTEVhZ2o5TEdDTkpXVlNY?=
 =?utf-8?B?TFNPMUhnQitvVURGb0wwMlhHdmdVbkpOdDY2OXRuY1dEcG5FUWhXSURuMEFv?=
 =?utf-8?B?ZVBXTTlFeklWU3JHQXN2N1dKamlpZks3ZEJmY1U3K1N1UjFVazE5Q2pzUHlY?=
 =?utf-8?B?UUNicVVBZGo4UWVORHBNaDZNdVRRK0daRm9WYXIzV1BWWGpERWg2RU12cEZx?=
 =?utf-8?B?QzI2Zk1kdXpqYS93S1hPNzJCS0tNSFEza0YxQjN1UVRYRk8yRUltTEVjK0I5?=
 =?utf-8?B?NFl3dHNtdTV6UmE2QWJNWitVK3hnNFRMV0xSYlpjQWRiU3YvTWlBUWZUclQ2?=
 =?utf-8?B?WXdWSkY5VURrVVFxUVpOQjhNQU5nOTFWbFllRVhGREVZYUd1Ullzb04rSHZv?=
 =?utf-8?B?bDVNY0RxWVFJbU5maTZzd25RQ0htb09kZ1pJT0pQWDlPV1JYS2pEU0xXNEdZ?=
 =?utf-8?B?TkUrTndjTUQ5cWMxQ0Z1S3haOG8xUkhRR3YySWE0RlFjeHY1cXB4aGpRdjVn?=
 =?utf-8?B?MEJrZkVUcGI4ek5aR0x2QktRMlpqazNndmJIUXFsOW5sMnVNTFdKZVRVMTla?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db42ae19-dcc6-46bc-8a31-08dadf234512
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 05:06:20.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcZy+S0li8GgoDSLr99hdHkQy1BFrzdwDYrUgrQmh5MWp9Wsf2c4IiLshgZyXCyn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1450
X-Proofpoint-GUID: 1Y0aHOfnMnIUUnQkmu3DMx_ryU3Afejq
X-Proofpoint-ORIG-GUID: 1Y0aHOfnMnIUUnQkmu3DMx_ryU3Afejq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_02,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/14/22 4:53 PM, Connor O'Brien wrote:
> Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
> mismatches are expected and module loading should proceed
> anyway. Logging with pr_warn() on every one of these "benign"
> mismatches creates unnecessary noise when many such modules are
> loaded. Instead, handle this case with a single log warning that BTF
> info may be unavailable.
> 
> Mismatches also result in calls to __btf_verifier_log() via
> __btf_verifier_log_type() or btf_verifier_log_member(), adding several
> additional lines of logging per mismatched module. Add checks to these
> paths to skip logging for module BTF mismatches in the "allow
> mismatch" case.
> 
> All existing logging behavior is preserved in the default
> CONFIG_MODULE_ALLOW_BTF_MISMATCH=n case.
> 
> Signed-off-by: Connor O'Brien <connoro@google.com>

Ack with a few nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v2:
> - Use pr_warn_once instead of skipping logging entirely
> - Also skip btf verifier logs for ignored mismatches
> 
> v1: https://lore.kernel.org/bpf/20221109024155.2810410-1-connoro@google.com/
> ---
>   kernel/bpf/btf.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f7dd8af06413..16b959b49595 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1404,6 +1404,13 @@ __printf(4, 5) static void __btf_verifier_log_type(struct btf_verifier_env *env,
>   	if (log->level == BPF_LOG_KERNEL && !fmt)
>   		return;
>   
> +	/*
> +	 * Skip logging when loading module BTF with mismatches permitted
> +	 */

Just use one line for the above comment.

> +	if (env->btf->base_btf && env->btf->kernel_btf &&
> +	    IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
> +		return;

I believe env->btf->base_btf alone is enough to test it should be a 
module btf. If env->btf->base_btf is true, env->btf->kernel_btf should
also be true. The other way is not true, env->btf->kernel_btf is true,
the btf could be vmlinux (env->btf->base_btf == NULL) or be a module.

> +
>   	__btf_verifier_log(log, "[%u] %s %s%s",
>   			   env->log_type_id,
>   			   btf_type_str(t),
> @@ -1443,6 +1450,14 @@ static void btf_verifier_log_member(struct btf_verifier_env *env,
>   
>   	if (log->level == BPF_LOG_KERNEL && !fmt)
>   		return;
> +
> +	/*
> +	 * Skip logging when loading module BTF with mismatches permitted
> +	 */

Same, just use one line for the above comments.

> +	if (env->btf->base_btf && env->btf->kernel_btf &&
> +	    IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
> +		return;
> +
>   	/* The CHECK_META phase already did a btf dump.
>   	 *
>   	 * If member is logged again, it must hit an error in
> @@ -7260,11 +7275,14 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>   		}
>   		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
>   		if (IS_ERR(btf)) {
> -			pr_warn("failed to validate module [%s] BTF: %ld\n",
> -				mod->name, PTR_ERR(btf));
>   			kfree(btf_mod);
> -			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
> +			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
> +				pr_warn("failed to validate module [%s] BTF: %ld\n",
> +					mod->name, PTR_ERR(btf));
>   				err = PTR_ERR(btf);
> +			} else {
> +				pr_warn_once("Kernel module BTF mismatch detected, BTF debug info may be unavailable for some modules\n");
> +			}
>   			goto out;
>   		}
>   		err = btf_alloc_id(btf);
