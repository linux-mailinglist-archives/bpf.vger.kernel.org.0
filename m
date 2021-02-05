Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF11C3110EA
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBERev (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 12:34:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3490 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231657AbhBEP5v (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Feb 2021 10:57:51 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115HXDwG014378;
        Fri, 5 Feb 2021 09:39:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=L6knv8DPxIMs8R6PKhlEZVM1LilbMNF+xJ3B77yi6PM=;
 b=Dy1zqwpVaUMJf3qrSzy83S0xuCAeU01xkVejtSzPnQILn2D2KOtvuttPFL68oi3/IbMj
 tP6nJf1hQdWmEra54+R9e3CQh/ELQae5DgMCSlfxwKts5r/PYudS8acLtYOViZAConT7
 ft6lXeK0jJZ8W39ou/sitfVm59lwu/HvJxc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36h0s02q6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 09:39:12 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 09:39:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7FrwW9afI3SXxUO0Q5+VrKyZtqjP7bdsNFD7DC/aUnydtnCQQjmNBds4M5uwHbwvSTLq6KBgoZuHOZaaU0yAQnQlspyneMd5KCQGWd527lJIr6K4VpJ6K2sbINB0WUr4nGpR4RAXaSzp52CN/kYpGSo+PXTneQvr0iS+sTaU2jikAW2euX3RKFjIA4DqHWCpxKL11Y7v33NjRgAm6LoHMeAtQIoFT/E3lnQqqQHY03gFLg/FGr/UjsWzDEL4synb9oekmxoZEwhXLQBl6NhbaJ2PxAxx0tEv/jTBwcQQzW5wkUDDgIz/IHF9zyBxCr+wuKxUItgVfHNyoXxHzDBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6knv8DPxIMs8R6PKhlEZVM1LilbMNF+xJ3B77yi6PM=;
 b=XwlnE+FefhWJk3HIH29UEiHy4i6PNdv/Zqa9FOrDZMCYmrGaEN9m8XljuQ23A1X+3Pa4DX1rEUML3ZLzI/FccqP1sx2z7DLgSAiUGlyAef6McrVEcP/I2ILZMMNVs4aS19qRaOwMNTDd7Xr1MIPNNofXqIEHyo2hr9D5vc3oY07l1RA/Fqau6ouuoCnChTPofo715iL9w6YBQtruu/KXodbm79qMILtcBc8zzqD6bcpso1ilX4Obw4UuvrFQRbZrUrmCWJIThf9hUqOgoYbCZrY8uCvrMW57YBA03bb7VYpX03/uVyRk6obhBmGIsHWCy8Q9W0vVpphwsczh/n3vtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6knv8DPxIMs8R6PKhlEZVM1LilbMNF+xJ3B77yi6PM=;
 b=gkVh/eKghPV1Wxqa633JvusE1Ot7mOk7KIn8Pm+0V2l+AovIuTy6rdmG/TJ97yDsrvtpMqbjyXhmDZ8eignjFbBSyUP58tT0gRlWsJB5zx6xjRIidhFnFjGDTx/8SkSlzh2VXTJNX2SFtGXuRgq6mOiKyuYvgeGT5EcwwAiwCro=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2261.namprd15.prod.outlook.com (2603:10b6:a02:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 17:39:10 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Fri, 5 Feb 2021
 17:39:10 +0000
Subject: Re: [PATCH bpf-next 2/8] bpf: add bpf_for_each_map_elem() helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234829.1629159-1-yhs@fb.com>
 <20210205054939.i6rpdvhphkv7szi4@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <edc435fd-9e86-7abc-6b61-27da85e52b52@fb.com>
Date:   Fri, 5 Feb 2021 09:39:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <20210205054939.i6rpdvhphkv7szi4@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b8ac]
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11b4] (2620:10d:c090:400::5:b8ac) by MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25 via Frontend Transport; Fri, 5 Feb 2021 17:39:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 057f0406-2a55-4cd5-2608-08d8c9fcf1b9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2261E40F6A5656E694659E89D3B29@BYAPR15MB2261.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMOAi363a0TEaahD3+5SgadNN7E67YgPMb6GlxqH1rfp/Wcrf9k6PNcTpuNhPuG5cLJder3qFaBUxtpd/QdjlrPiEEMCmE+pUeCbTT4Mcl/zV+lpfrX+xdKs2bAStRl+BrL0BgGBFYNkm2bHGa3pTblPv3HYHdyxgXMt3yW6QD5wAwheTJSWQlkmtLy+RrzED/Eaxr+nVSuYBsTxaOwnArwWVAq5e+yZMIxDp8zWqgrLwH8rLWxjiIu4S4mKFj3jgpM1MtA2x35kapSQ8ysgh6QgmUYM3SELXBW8hvxpHnYZam4RUOLkXhWXj1XWx8ap1GMavYTXYRbrVG2Q7R5vJmT0pSmI4zhIsY0Pc6ZzN8XA1gb8Db+o11E/0wakoH3L+xTfmZuWuYso43QBP24qJoVwnDtRfJWkE8ywwI7cQ31/NqDsywVmtLLqy6SWxBqQKmaOEyzIR73KRYGy9tIKt4UOiB810g05JAKCvapayuSJyv3lkKWnwO8ik8ymsHu5PgIQje8wHbut3uNG3UwGSF4NrqR14yxZ7NfA24sfvqGg6g2hSoHEaenJRBR/T4+fdFfYwMSZdGyP2Yvf81ojfOlOA0Brm9I5iVDlX9ZlLLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(376002)(346002)(83380400001)(16526019)(31696002)(30864003)(186003)(66476007)(66946007)(6666004)(66556008)(478600001)(6486002)(2616005)(6916009)(54906003)(53546011)(52116002)(316002)(8936002)(8676002)(31686004)(86362001)(5660300002)(36756003)(2906002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y3Q5MUVBOWtLUFBPTXpDc0NrRDJHa3doaGZONWczYnY1ckpqdmR2L3lXUzNx?=
 =?utf-8?B?SW93eVFLUUdjeVNrd0Jib1ZxUi9HWUljSVpaWTlEaUxXZVJrZm1hL2tVejZp?=
 =?utf-8?B?OUU1Qkg4UHZtVUxhSTZUaDZYa2lpdENKb24rZ2ROSzFiKytUdDd3WWNuUk82?=
 =?utf-8?B?VCtLYWZrcFFRUEprcWFuWjRZZVZYVGdlN1k5eFVoT2JYK3BLcTRDeXMvRUh4?=
 =?utf-8?B?UjdsNVIrTXVSTlpsZWdIMnRWL0phcFpEcThibEs2Ym1VeWtDN28yTXltWnN1?=
 =?utf-8?B?OWFKVlV6Sm5Sa1RIODNVRTAyWS9zVThyeGhrbnBmc2xBWjZhY1VoNUo1QjVa?=
 =?utf-8?B?RUFVemRGQytHd0RUS0NHa1BGZHJUZG5sNk5tZHNWYVBIUkNkeTBlaVAveS9B?=
 =?utf-8?B?SHNXMm1GWE5XdG95eDRWOVdPUnArUkppaXJlcFg2TktVVEg0VzVHeHdlVzVw?=
 =?utf-8?B?VGZRVzJQMTlmYm9lN0p6RE9UQytyVHQ0bUc1UXZZTDBiVDR6ZXNaaUhYU25Q?=
 =?utf-8?B?S3ZZdEkrWk4rNFJKS09pN3U1U3dIR1Fqc0pPRGU5V1JvM1JZcDRFNDJXMmIy?=
 =?utf-8?B?ZGxJOUV2QjlrdGR3U3BjVlhXWnFQcEpyUjlqc2hITWcveXFnZm5jTjRYT2tV?=
 =?utf-8?B?WlVqQmpoNDRFSzY2dmtPellIQ09LdWhneE1BOGFJdy9lYTdJVnhlQ05wTlVq?=
 =?utf-8?B?RVowN2pJKzg0RjlwOC9kazhDSVZRZHFDbUZxZUQwbkt5aFJkQnFOemtJbEI5?=
 =?utf-8?B?Z0ZUb04vL1JtNU5wSjV0b3BNcUt3VStVUzNGSWhSTEw5dy9NdEVlZnBGaEEw?=
 =?utf-8?B?RzhqRjlocDBJNGtXUnJVUHBncFRxZGh0YnJwa2xhR0pHR3p6ajlrUmdPekZM?=
 =?utf-8?B?UzdzNnRlSnhNSkQ4SWNPRTdDSzh4U3ZTK2dnZ3JvVzFTaG00QVVVUmRJUjl4?=
 =?utf-8?B?RS80WFFUVkhzazFrbVpKY2ZwUW9YakpPOWVNbTNleU1veGFyY0I3Z3lxSGpI?=
 =?utf-8?B?ZUtJazdFZURGdDIzSzhyM3V1SnFNcC81dTdlajNqTnNLVytMWG9WTnA2ZDhZ?=
 =?utf-8?B?NklwVlk1MWx6NjRXdDVXcWQwNmxzODNxSTByM2w1VVdEZ05OSzVUclhoNFFS?=
 =?utf-8?B?TktTM2dxL09BNklGWFVRME9xYVVjNUFCeHJXY1VEWnRxSStFaGt0c09pYmlG?=
 =?utf-8?B?OXRhbThjRE0yaHZQbU52RkpzQ0ZlTEFucFc2bnd3WDJuWnJHbWRhM2FaQzVQ?=
 =?utf-8?B?QXJKMUo5NGZmYkZxbm13TzBuR0VPTTFaLzVPSmVzNVdJWlo1SWJTTnZqYWgz?=
 =?utf-8?B?Vld0L1pQbS9IRlNJWGM2WVNpTWg5M25FNXYxckxRbHFYVjRRd2xIRTBMZm8r?=
 =?utf-8?B?ZXpoalJud0NRd2ZOZFZBNlFHYUI4RUMrSzM5L1lCbjJFcGN2U3V1bnVoeGc4?=
 =?utf-8?B?ZVgwTXhDemIxNHFqUVgra21uemhQZkFpaXNiUjdQRDBqd01FdUZyWS9Zc0wv?=
 =?utf-8?B?MGFNTHZFOTUzMVY4Z3RGVFBUMjFRWGNkYTVXUm1nYzRMVURWeGxhTW85Z3c5?=
 =?utf-8?B?UDlhWGY5OENiSWpZZnczN3NUU2NWSm9JNmU4RVljdFpyTFh1Yk1XWUlCTlhE?=
 =?utf-8?B?V3ZNQ3NHemcyNy9iTk5SNWxuOFMyMjNmQjlwWHp2a0ZsZFhLcnpENmROWU84?=
 =?utf-8?B?T2xJMS93YXltVFZPaHc2NGVJRUljRjFMRkplbG5OU1R4ZW02MHBQWFNVVU5o?=
 =?utf-8?B?cGlyV3NaTFFUdCt1dCtKQnU0c3JmOVE1ZXhWT3R2MlJLTW8xcWtZNHA3NXVi?=
 =?utf-8?B?TkUzZGdSUXhiVHc1ckhVUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 057f0406-2a55-4cd5-2608-08d8c9fcf1b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 17:39:10.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmtgLXdAy9RhmTl8Wv7lKIQ3AgV2xvbnEq2ypnPn1JzFaTeqV66c2oZYC93K9lp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2261
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/21 9:49 PM, Alexei Starovoitov wrote:
> On Thu, Feb 04, 2021 at 03:48:29PM -0800, Yonghong Song wrote:
>> The bpf_for_each_map_elem() helper is introduced which
>> iterates all map elements with a callback function. The
>> helper signature looks like
>>    long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
>> and for each map element, the callback_fn will be called. For example,
>> like hashmap, the callback signature may look like
>>    long callback_fn(map, key, val, callback_ctx)
>>
>> There are two known use cases for this. One is from upstream ([1]) where
>> a for_each_map_elem helper may help implement a timeout mechanism
>> in a more generic way. Another is from our internal discussion
>> for a firewall use case where a map contains all the rules. The packet
>> data can be compared to all these rules to decide allow or deny
>> the packet.
>>
>> For array maps, users can already use a bounded loop to traverse
>> elements. Using this helper can avoid using bounded loop. For other
>> type of maps (e.g., hash maps) where bounded loop is hard or
>> impossible to use, this helper provides a convenient way to
>> operate on all elements.
>>
>> For callback_fn, besides map and map element, a callback_ctx,
>> allocated on caller stack, is also passed to the callback
>> function. This callback_ctx argument can provide additional
>> input and allow to write to caller stack for output.
> 
> The approach and implementation look great!
> Few ideas below:
> 
>> +static int check_map_elem_callback(struct bpf_verifier_env *env, int *insn_idx)
>> +{
>> +	struct bpf_verifier_state *state = env->cur_state;
>> +	struct bpf_prog_aux *aux = env->prog->aux;
>> +	struct bpf_func_state *caller, *callee;
>> +	struct bpf_map *map;
>> +	int err, subprog;
>> +
>> +	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
>> +		verbose(env, "the call stack of %d frames is too deep\n",
>> +			state->curframe + 2);
>> +		return -E2BIG;
>> +	}
>> +
>> +	caller = state->frame[state->curframe];
>> +	if (state->frame[state->curframe + 1]) {
>> +		verbose(env, "verifier bug. Frame %d already allocated\n",
>> +			state->curframe + 1);
>> +		return -EFAULT;
>> +	}
>> +
>> +	caller->with_callback_fn = true;
>> +
>> +	callee = kzalloc(sizeof(*callee), GFP_KERNEL);
>> +	if (!callee)
>> +		return -ENOMEM;
>> +	state->frame[state->curframe + 1] = callee;
>> +
>> +	/* callee cannot access r0, r6 - r9 for reading and has to write
>> +	 * into its own stack before reading from it.
>> +	 * callee can read/write into caller's stack
>> +	 */
>> +	init_func_state(env, callee,
>> +			/* remember the callsite, it will be used by bpf_exit */
>> +			*insn_idx /* callsite */,
>> +			state->curframe + 1 /* frameno within this callchain */,
>> +			subprog /* subprog number within this prog */);
>> +
>> +	/* Transfer references to the callee */
>> +	err = transfer_reference_state(callee, caller);
>> +	if (err)
>> +		return err;
>> +
>> +	subprog = caller->regs[BPF_REG_2].subprog;
>> +	if (aux->func_info && aux->func_info_aux[subprog].linkage != BTF_FUNC_STATIC) {
>> +		verbose(env, "callback function R2 not static\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	map = caller->regs[BPF_REG_1].map_ptr;
> 
> Take a look at for (i = 0; i < 5; i++)  err = check_func_arg loop and record_func_map.
> It stores the map pointer into map_ptr_state and makes sure it's unique,
> so that program doesn't try to pass two different maps into the same 'call insn'.
> It can make this function a bit more generic.
> There would be no need to hard code regs[BPF_REG_1].
> The code would take it from map_ptr_state.
> Also it will help later with optimizing
>    return map->ops->map_for_each_callback(map, callback_fn, callback_ctx, flags);
> since the map pointer will be the same the optimization (that is applied to other map
> operations) can be applied for this callback as well.

sounds good. will try this approach in the next revision.

> 
> The regs[BPF_REG_2] can be generalized a bit as well.
> It think linkage != BTF_FUNC_STATIC can be moved to early check_ld_imm phase.
> While here the check_func_arg() loop can look for PTR_TO_FUNC type,
> remeber the subprog into meta (just like map_ptr_state) and ... continues below

Yes, PTR_TO_FUNC might be used for future helpers like bpf_mod_timer() 
or bpf_for_each_task() etc. Make it more general do make sense.

> 
>> +	if (!map->ops->map_set_for_each_callback_args ||
>> +	    !map->ops->map_for_each_callback) {
>> +		verbose(env, "callback function not allowed for map R1\n");
>> +		return -ENOTSUPP;
>> +	}
>> +
>> +	/* the following is only for hashmap, different maps
>> +	 * can have different callback signatures.
>> +	 */
>> +	err = map->ops->map_set_for_each_callback_args(env, caller, callee);
>> +	if (err)
>> +		return err;
>> +
>> +	clear_caller_saved_regs(env, caller->regs);
>> +
>> +	/* only increment it after check_reg_arg() finished */
>> +	state->curframe++;
>> +
>> +	/* and go analyze first insn of the callee */
>> +	*insn_idx = env->subprog_info[subprog].start - 1;
>> +
>> +	if (env->log.level & BPF_LOG_LEVEL) {
>> +		verbose(env, "caller:\n");
>> +		print_verifier_state(env, caller);
>> +		verbose(env, "callee:\n");
>> +		print_verifier_state(env, callee);
>> +	}
>> +	return 0;
>> +}
>> +
>>   static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   {
>>   	struct bpf_verifier_state *state = env->cur_state;
>>   	struct bpf_func_state *caller, *callee;
>>   	struct bpf_reg_state *r0;
>> -	int err;
>> +	int i, err;
>>   
>>   	callee = state->frame[state->curframe];
>>   	r0 = &callee->regs[BPF_REG_0];
>> @@ -4955,7 +5090,17 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   	state->curframe--;
>>   	caller = state->frame[state->curframe];
>>   	/* return to the caller whatever r0 had in the callee */
>> -	caller->regs[BPF_REG_0] = *r0;
>> +	if (caller->with_callback_fn) {
>> +		/* reset caller saved regs, the helper calling callback_fn
>> +		 * has RET_INTEGER return types.
>> +		 */
>> +		for (i = 0; i < CALLER_SAVED_REGS; i++)
>> +			mark_reg_not_init(env, caller->regs, caller_saved[i]);
>> +		caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
>> +		mark_reg_unknown(env, caller->regs, BPF_REG_0);
> 
> this part can stay in check_helper_call().

Yes, to verify the callback function from the helper is the most
complex part in my patch set. Your above suggestions should make it
more streamlined as a better fit with existing infrastruture.
Will give a try.

> 
>> +	} else {
>> +		caller->regs[BPF_REG_0] = *r0;
>> +	}
>>   
>>   	/* Transfer references to the caller */
>>   	err = transfer_reference_state(caller, callee);
>> @@ -5091,7 +5236,8 @@ static int check_reference_leak(struct bpf_verifier_env *env)
>>   	return state->acquired_refs ? -EINVAL : 0;
>>   }
>>   
>> -static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn_idx)
>> +static int check_helper_call(struct bpf_verifier_env *env, int func_id, int *insn_idx,
>> +			     bool map_elem_callback)
>>   {
>>   	const struct bpf_func_proto *fn = NULL;
>>   	struct bpf_reg_state *regs;
>> @@ -5151,11 +5297,11 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>>   			return err;
>>   	}
>>   
>> -	err = record_func_map(env, &meta, func_id, insn_idx);
>> +	err = record_func_map(env, &meta, func_id, *insn_idx);
>>   	if (err)
>>   		return err;
>>   
>> -	err = record_func_key(env, &meta, func_id, insn_idx);
>> +	err = record_func_key(env, &meta, func_id, *insn_idx);
>>   	if (err)
>>   		return err;
>>   
>> @@ -5163,7 +5309,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>>   	 * is inferred from register state.
>>   	 */
>>   	for (i = 0; i < meta.access_size; i++) {
>> -		err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
>> +		err = check_mem_access(env, *insn_idx, meta.regno, i, BPF_B,
>>   				       BPF_WRITE, -1, false);
>>   		if (err)
>>   			return err;
>> @@ -5195,6 +5341,11 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (map_elem_callback) {
>> +		env->prog->aux->with_callback_fn = true;
>> +		return check_map_elem_callback(env, insn_idx);
> 
> Instead of returning early here.
> The check_func_arg() loop can look for PTR_TO_FUNC type.
> The allocate new callee state,
> do map_set_for_each_callback_args() here.
> and then proceed further.

ditto. Will re-organize to avoid early return here.

> 
>> +	}
>> +
>>   	/* reset caller saved regs */
>>   	for (i = 0; i < CALLER_SAVED_REGS; i++) {
>>   		mark_reg_not_init(env, regs, caller_saved[i]);
> 
> Instead of doing this loop in prepare_func_exit().
> This code can just proceed here and clear caller regs. This loop can stay as-is.
> The transfer of caller->callee would happen already.
> 
> Then there are few lines here that diff didn't show.
> They do regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG and mark_reg_unknown.
> No need to do them in prepare_func_exit().
> This function can proceed further reusing this caller regs clearing loop and r0 marking.
> 
> Then before returning from check_helper_call()
> it will do what you have in check_map_elem_callback() and it will adjust *insn_idx.
> 
> At this point caller would have regs cleared and r0=undef.
> And callee would have regs setup the way map_set_for_each_callback_args callback meant to do it.
> The only thing prepare_func_exit would need to do is to make sure that assignment:
> caller->regs[BPF_REG_0] = *r0
> doesn't happen. caller's r0 was already set to undef.
> To achieve that I think would be a bit cleaner to mark callee state instead of caller state.
> So instead of caller->with_callback_fn=true maybe callee->in_callback_fn=true ?

Agree. Will try to do normal helper return verification here
instead of a cut-down version in prepare_func_exit().

> 
>> @@ -5306,7 +5457,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>>   		/* For release_reference() */
>>   		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
>>   	} else if (is_acquire_function(func_id, meta.map_ptr)) {
>> -		int id = acquire_reference_state(env, insn_idx);
>> +		int id = acquire_reference_state(env, *insn_idx);
>>   
>>   		if (id < 0)
>>   			return id;
>> @@ -5448,6 +5599,14 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
>>   		else
>>   			*ptr_limit = -off;
>>   		return 0;
>> +	case PTR_TO_MAP_KEY:
>> +		if (mask_to_left) {
>> +			*ptr_limit = ptr_reg->umax_value + ptr_reg->off;
>> +		} else {
>> +			off = ptr_reg->smin_value + ptr_reg->off;
>> +			*ptr_limit = ptr_reg->map_ptr->key_size - off;
>> +		}
>> +		return 0;
>>   	case PTR_TO_MAP_VALUE:
>>   		if (mask_to_left) {
>>   			*ptr_limit = ptr_reg->umax_value + ptr_reg->off;
>> @@ -5614,6 +5773,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>>   		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
>>   			dst, reg_type_str[ptr_reg->type]);
>>   		return -EACCES;
>> +	case PTR_TO_MAP_KEY:
>>   	case PTR_TO_MAP_VALUE:
>>   		if (!env->allow_ptr_leaks && !known && (smin_val < 0) != (smax_val < 0)) {
>>   			verbose(env, "R%d has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root\n",
>> @@ -7818,6 +7978,12 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   		return 0;
>>   	}
>>   
>> +	if (insn->src_reg == BPF_PSEUDO_FUNC) {
>> +		dst_reg->type = PTR_TO_FUNC;
>> +		dst_reg->subprog = insn[1].imm;
> 
> Like here check for linkage==static can happen ?

will do.

> 
>> +		return 0;
>> +	}
>> +
>>   	map = env->used_maps[aux->map_index];
>>   	mark_reg_known_zero(env, regs, insn->dst_reg);
>>   	dst_reg->map_ptr = map;
>> @@ -8195,9 +8361,23 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
>>   
>>   	/* All non-branch instructions have a single fall-through edge. */
>>   	if (BPF_CLASS(insns[t].code) != BPF_JMP &&
>> -	    BPF_CLASS(insns[t].code) != BPF_JMP32)
>> +	    BPF_CLASS(insns[t].code) != BPF_JMP32 &&
>> +	    !bpf_pseudo_func(insns + t))
>>   		return push_insn(t, t + 1, FALLTHROUGH, env, false);
>>   
>> +	if (bpf_pseudo_func(insns + t)) {
>> +		ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (t + 1 < insn_cnt)
>> +			init_explored_state(env, t + 1);
>> +		init_explored_state(env, t);
>> +		ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
>> +				env, false);
>> +		return ret;
>> +	}
>> +
>>   	switch (BPF_OP(insns[t].code)) {
>>   	case BPF_EXIT:
>>   		return DONE_EXPLORING;
>> @@ -8819,6 +8999,7 @@ static bool regsafe(struct bpf_reg_state *rold, struct bpf_reg_state *rcur,
>>   			 */
>>   			return false;
>>   		}
>> +	case PTR_TO_MAP_KEY:
>>   	case PTR_TO_MAP_VALUE:
>>   		/* If the new min/max/var_off satisfy the old ones and
>>   		 * everything else matches, we are OK.
>> @@ -9646,6 +9827,8 @@ static int do_check(struct bpf_verifier_env *env)
>>   
>>   			env->jmps_processed++;
>>   			if (opcode == BPF_CALL) {
>> +				bool map_elem_callback;
>> +
>>   				if (BPF_SRC(insn->code) != BPF_K ||
>>   				    insn->off != 0 ||
>>   				    (insn->src_reg != BPF_REG_0 &&
>> @@ -9662,13 +9845,15 @@ static int do_check(struct bpf_verifier_env *env)
>>   					verbose(env, "function calls are not allowed while holding a lock\n");
>>   					return -EINVAL;
>>   				}
>> +				map_elem_callback = insn->src_reg != BPF_PSEUDO_CALL &&
>> +						   insn->imm == BPF_FUNC_for_each_map_elem;
>>   				if (insn->src_reg == BPF_PSEUDO_CALL)
>>   					err = check_func_call(env, insn, &env->insn_idx);
>>   				else
>> -					err = check_helper_call(env, insn->imm, env->insn_idx);
>> +					err = check_helper_call(env, insn->imm, &env->insn_idx,
>> +								map_elem_callback);
> 
> then hopefully this extra 'map_elem_callback' boolean won't be needed.
> Only env->insn_idx into &env->insn_idx.
> In that sense check_helper_call will become a superset of check_func_call.
> Maybe some code between them can be shared too.
> Beyond bpf_for_each_map_elem() helper other helpers might use PTR_TO_FUNC.
> I hope with this approach all of them will be handled a bit more generically.

We shouldn't use this since we have insn->imm as the helper id. Will 
remove it.

> 
>>   				if (err)
>>   					return err;
>> -
>>   			} else if (opcode == BPF_JA) {
>>   				if (BPF_SRC(insn->code) != BPF_K ||
>>   				    insn->imm != 0 ||
>> @@ -10090,6 +10275,12 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>>   				goto next_insn;
>>   			}
>>   
>> +			if (insn[0].src_reg == BPF_PSEUDO_FUNC) {
>> +				aux = &env->insn_aux_data[i];
>> +				aux->ptr_type = PTR_TO_FUNC;
>> +				goto next_insn;
>> +			}
>> +
>>   			/* In final convert_pseudo_ld_imm64() step, this is
>>   			 * converted into regular 64-bit imm load insn.
>>   			 */
>> @@ -10222,9 +10413,13 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
>>   	int insn_cnt = env->prog->len;
>>   	int i;
>>   
>> -	for (i = 0; i < insn_cnt; i++, insn++)
>> -		if (insn->code == (BPF_LD | BPF_IMM | BPF_DW))
>> -			insn->src_reg = 0;
>> +	for (i = 0; i < insn_cnt; i++, insn++) {
>> +		if (insn->code != (BPF_LD | BPF_IMM | BPF_DW))
>> +			continue;
>> +		if (insn->src_reg == BPF_PSEUDO_FUNC)
>> +			continue;
>> +		insn->src_reg = 0;
>> +	}
>>   }
>>   
>>   /* single env->prog->insni[off] instruction was replaced with the range
>> @@ -10846,6 +11041,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   		return 0;
>>   
>>   	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
>> +		if (bpf_pseudo_func(insn)) {
>> +			env->insn_aux_data[i].call_imm = insn->imm;
>> +			/* subprog is encoded in insn[1].imm */
>> +			continue;
>> +		}
>> +
>>   		if (!bpf_pseudo_call(insn))
>>   			continue;
>>   		/* Upon error here we cannot fall back to interpreter but
>> @@ -10975,6 +11176,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   	for (i = 0; i < env->subprog_cnt; i++) {
>>   		insn = func[i]->insnsi;
>>   		for (j = 0; j < func[i]->len; j++, insn++) {
>> +			if (bpf_pseudo_func(insn)) {
>> +				subprog = insn[1].imm;
>> +				insn[0].imm = (u32)(long)func[subprog]->bpf_func;
>> +				insn[1].imm = ((u64)(long)func[subprog]->bpf_func) >> 32;
>> +				continue;
>> +			}
>>   			if (!bpf_pseudo_call(insn))
>>   				continue;
>>   			subprog = insn->off;
>> @@ -11020,6 +11227,11 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   	 * later look the same as if they were interpreted only.
>>   	 */
>>   	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
>> +		if (bpf_pseudo_func(insn)) {
>> +			insn[0].imm = env->insn_aux_data[i].call_imm;
>> +			insn[1].imm = find_subprog(env, i + insn[0].imm + 1);
>> +			continue;
>> +		}
>>   		if (!bpf_pseudo_call(insn))
>>   			continue;
>>   		insn->off = env->insn_aux_data[i].call_imm;
>> @@ -11083,6 +11295,13 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>>   		verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
>>   		return -EINVAL;
>>   	}
>> +	if (env->subprog_cnt > 1 && env->prog->aux->with_callback_fn) {
> 
> Does this bool really need to be be part of 'aux'?
> There is a loop below that does if (!bpf_pseudo_call
> to fixup insns for the interpreter.
> May be add if (bpf_pseudo_func()) { return callbacks are not allowed in non-JITed }
> to the loop below as well?
> It's a trade off between memory and few extra insn.

I use this bit similar to tailcall. But agree with you that we can the 
check in below loop.

> 
>> +		/* When JIT fails the progs with callback calls
>> +		 * have to be rejected, since interpreter doesn't support them yet.
>> +		 */
>> +		verbose(env, "callbacks are not allowed in non-JITed programs\n");
>> +		return -EINVAL;
>> +	}
>>   	for (i = 0; i < prog->len; i++, insn++) {
>>   		if (!bpf_pseudo_call(insn))
>>   			continue;
> 
> to this loop.
> 
> Thanks!
> 
