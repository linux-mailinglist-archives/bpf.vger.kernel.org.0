Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9D61FFEA3
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 01:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgFRXbw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 19:31:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33748 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbgFRXbv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 19:31:51 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05INPnBo012912;
        Thu, 18 Jun 2020 16:31:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vZltNYfC2x/GBLdAVUMJQhD5Ie227e3InE4w0prwNWI=;
 b=VOEvka9HYPU808qJx6iqk7sDpZzzWfBJvM2ubtWgimoKNFgn2Dm0YKyIjWGstxNbNlfY
 gK/7kFtAMfNuCOxm1hiyJYCdCB3otELdDB9K/liSxNiXyN32ESRhsIk4OTzEzy3gK8r8
 BfzuLUnWgPXrCkh4oOzTL3xfB2Iyyb8wbUU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q660y2jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 16:31:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 16:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBNaZw3EZS39Jmakx2AqmjzIfBq9XVMtlfRWotojiFVC/WDUBzH3OgcUtCbSelEqCqPLsmpsKTvKdneQXpwBTLAR60t7xZHJ4gTuJ3VKmWoHM3mZh8VJAWVEFOzmLis9+MzXc1QrT3Yd8656xKvv0uqXv3BX9GGriOD/D/O/LvzMcAQc+5u60ZVSPRcE0AtnemCBcS5zBP6ab1p8Wv3IRHZwK98K7bnDRDhjcI9UhhKoAQgVUJ1gRxhjDgkV099mGVKHfgoJuURei+BAgZuFCDSbIp9QXyGCcqJsgYeVQOZqcmBz/M1S/GPXPw2G4vyu9hIceGD2YB7k4EGzC/X1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZltNYfC2x/GBLdAVUMJQhD5Ie227e3InE4w0prwNWI=;
 b=VZURYlfC6Gsrd+OMsgaqAqnvsl3Nm0CqRfgofecg24AnrgaCGBKtKa32tCXtC625sNM+sXQhzZ/dIAgNnINfZS1/SrigW2SJGiLpmyEN1gJcTTFGYoCaVgGxUgto6Hl4JV5AJZd5FHFvzWEmJtvaV/LAZ9upggxchEJhGbz/MBDtfpDGYlIamSEUJpEMH2mwKLWs9HDsagbm1qmZfCvHsmCWQ3O9N4LgVVLXN3npWatjQJ8xbRV1bEm+c0c3P4qQPIc93HygV05bvFhgr52hNNta+Ueo0L3f+gRYVUlDVnZbF0LcdYD2V58LWD/Qt++ObJj3++lFlHPl8+l0A+bonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZltNYfC2x/GBLdAVUMJQhD5Ie227e3InE4w0prwNWI=;
 b=But4tDwZ4ecUurmZY/Eg3h/6VVZvvZvb/9lV3NT+F2JD+j27Iau9Ihernd8rAnDPJhdHwmVT52VYxg5Xb7RvUDVLWqWH2w9vfSC4R3wEols6i+X77xwfs9FIAXltRbnxPbdzY1nT7No2KiW4D3sUZwuplRbl63j0W/FNE3lSn58=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Thu, 18 Jun
 2020 23:31:36 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 23:31:36 +0000
Subject: Re: [PATCH bpf-next 05/13] bpf: add bpf_skc_to_tcp6_sock() helper
To:     Martin KaFai Lau <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20200617211536.1854348-1-yhs@fb.com>
 <20200617211542.1856028-1-yhs@fb.com>
 <20200618205412.6updodfkqv2lz4pm@kafai-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <53c594a0-971e-8f18-d271-34e4f738a534@fb.com>
Date:   Thu, 18 Jun 2020 16:31:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200618205412.6updodfkqv2lz4pm@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::11f0] (2620:10d:c090:400::5:8794) by BYAPR07CA0053.namprd07.prod.outlook.com (2603:10b6:a03:60::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 23:31:35 +0000
X-Originating-IP: [2620:10d:c090:400::5:8794]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c334e4-faed-47c5-23db-08d813dfbdee
X-MS-TrafficTypeDiagnostic: BYAPR15MB2695:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB26950FC75E05428094178176D39B0@BYAPR15MB2695.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpWb8usnzeZp9CJhqaLxBndoO9ujJEC7OIGNCrGHk2wawIJn8xSp+QZ6CfXgCGDG29XZcWnz+RxPjcXy8JrqdY/IZSnjRbWBqrekS5Nd1/EhyYa0cOxzIYyaUDOTNgT8AeO+hoikMSkXh6fPn0UOJ3UBCd4MhFNZ38Zpui+j3UTHWYRPPcjxbHrciMkWDOb9EeIP2Ps4BfQZegcP8o7cRwk1S9v/+10TWYM6Y+kXXXzzOIm18Jb9cjfXazXKFjdFPPDoeCLeMYz2hlyKteGIAqOJf52lMqENw4r1gHKlb6i8GFdVc2iEbqtesFZ8cyPPAxW+iX0Ghxnxct5it/5Wx6LqzTE6lj5lDRpGCT/zgxerq3xu/TJKv4rnCpqXc74m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(39860400002)(136003)(396003)(66946007)(31696002)(54906003)(86362001)(2616005)(316002)(36756003)(66556008)(37006003)(478600001)(5660300002)(66476007)(6636002)(8936002)(16526019)(186003)(31686004)(83380400001)(4326008)(6486002)(53546011)(52116002)(8676002)(2906002)(6862004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bI4S3nRJYv64CXSRzAhE+QRRh2s/lMvfprcpedhnxFBRfoSMp5blgoYzYwXcRMUvEA9BeVWkaOTlVUaT2UhFZ6F170W0dkkeDE+o9Gzc50RbM9d5E1T53fAZXkOxsRUydBhDt/RVJ1dLGMbX6Xyu4SgSIe9XcD8rWFn7xFatm+n4gwZX4ikJdwAU4xHnwf7S9lcG/Vv+PARI2PC1TffDQJlzTFPAtWCYdZoQa1ut/sEIxNEeYYTPBBjx+WRv8SEvDCxt+M6AKVv48YafWU9ORQJoqZ0qx5EPcworXU6R/i81u5+MROoETs5Tpcr7+dN4pL1JsLEQIOYvsMrHcNrVEIsdMj+e5cY8cjQPuNbwPQ7k5IDZ86M+5uWPdJ80Fv90bO8IKucXB1BOFAOyd8suAhF2HKeST4/PPWdf8y2mZmvd7i2ny20W7yvyeVQppplTdj5iqpbK6Jjjs+jGiZw26t0llS9y53kdKmMK7gTg2L31voVh0TQkWvT2xMNnW6in4e5PGDmLtbBCN1HkfYKK6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c334e4-faed-47c5-23db-08d813dfbdee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 23:31:35.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXRTchq6tLTKkZ5ZuECCvtC/zMkkXTYi0IA26pMFE/I+QqtIOTJszE9e4uJhUqKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180180
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 6/18/20 1:54 PM, Martin KaFai Lau wrote:
> On Wed, Jun 17, 2020 at 02:15:42PM -0700, Yonghong Song wrote:
>> The helper is used in tracing programs to cast a socket
>> pointer to a tcp6_sock pointer.
>> The return value could be NULL if the casting is illegal.
>>
>> A new helper return type RET_PTR_TO_BTF_ID_OR_NULL is added
>> so the verifier is able to deduce proper return types for the helper.
>>
>> Different from the previous BTF_ID based helpers,
>> the bpf_skc_to_tcp6_sock() argument can be several possible
>> btf_ids. More specifically, all possible socket data structures
>> with sock_common appearing in the first in the memory layout.
>> This patch only added socket types related to tcp and udp.
>>
>> All possible argument btf_id and return value btf_id
>> for helper bpf_skc_to_tcp6_sock() are pre-calculcated and
>> cached. In the future, it is even possible to precompute
>> these btf_id's at kernel build time.
>>
> [ ... ]
>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 07052d44bca1..e455aa09039b 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -261,6 +261,7 @@ enum bpf_return_type {
>>   	RET_PTR_TO_TCP_SOCK_OR_NULL,	/* returns a pointer to a tcp_sock or NULL */
>>   	RET_PTR_TO_SOCK_COMMON_OR_NULL,	/* returns a pointer to a sock_common or NULL */
>>   	RET_PTR_TO_ALLOC_MEM_OR_NULL,	/* returns a pointer to dynamically allocated memory or NULL */
>> +	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
>>   };
>>   
>>   /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF programs
>> @@ -283,6 +284,10 @@ struct bpf_func_proto {
>>   		enum bpf_arg_type arg_type[5];
>>   	};
>>   	int *btf_id; /* BTF ids of arguments */
>> +	bool (*check_btf_id)(u32 btf_id, u32 arg); /* If the argument could match
>> +						    * more than one btf id's.
>> +						    */
>> +	int *ret_btf_id; /* return value btf_id */
>>   };
>>   
>>   /* bpf_context is intentionally undefined structure. Pointer to bpf_context is
>> @@ -1196,6 +1201,10 @@ bool bpf_link_is_iter(struct bpf_link *link);
>>   struct bpf_prog *bpf_iter_get_info(struct bpf_iter_meta *meta, bool in_stop);
>>   int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx);
>>   
>> +void init_sock_cast_types(struct btf *btf);
> CONFIG_NET may not be set.

Good catch, will add proper config guard in the next revision.


>
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 34cde841ab68..22d90d47befa 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3735,10 +3735,12 @@ static int int_ptr_type_to_size(enum bpf_arg_type type)
>>   	return -EINVAL;
>>   }
>>   
>> -static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
>> +static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>   			  enum bpf_arg_type arg_type,
>> -			  struct bpf_call_arg_meta *meta)
>> +			  struct bpf_call_arg_meta *meta,
>> +			  const struct bpf_func_proto *fn)
>>   {
>> +	u32 regno = BPF_REG_1 + arg;
>>   	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>>   	enum bpf_reg_type expected_type, type = reg->type;
>>   	int err = 0;
>> @@ -3820,9 +3822,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
>>   		expected_type = PTR_TO_BTF_ID;
>>   		if (type != expected_type)
>>   			goto err_type;
>> -		if (reg->btf_id != meta->btf_id) {
>> -			verbose(env, "Helper has type %s got %s in R%d\n",
>> -				kernel_type_name(meta->btf_id),
>> +		if (!fn->check_btf_id) {
>> +			if (reg->btf_id != meta->btf_id) {
>> +				verbose(env, "Helper has type %s got %s in R%d\n",
>> +					kernel_type_name(meta->btf_id),
>> +					kernel_type_name(reg->btf_id), regno);
>> +
>> +				return -EACCES;
>> +			}
>> +		} else if (!fn->check_btf_id(reg->btf_id, arg + 1)) {
> Why arg "+ 1"?

In verifier, arg starts from 0 (arguments 0 - 4). In func_proto, we have 
ARG1 - ARG5.

That is why I add one here. I think I can just use 0-4 range for arg 
parameter, it should be fine.

>
>> +			verbose(env, "Helper does not support %s in R%d\n",
>>   				kernel_type_name(reg->btf_id), regno);
>>   
>>   			return -EACCES;
>> @@ -4600,7 +4609,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>>   	struct bpf_reg_state *regs;
>>   	struct bpf_call_arg_meta meta;
>>   	bool changes_data;
>> -	int i, err;
>> +	int i, err, ret_btf_id;
>>   
>>   	/* find function prototype */
>>   	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
>> @@ -4644,10 +4653,12 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>>   	meta.func_id = func_id;
>>   	/* check args */
>>   	for (i = 0; i < 5; i++) {
>> -		err = btf_resolve_helper_id(&env->log, fn, i);
>> -		if (err > 0)
>> -			meta.btf_id = err;
>> -		err = check_func_arg(env, BPF_REG_1 + i, fn->arg_type[i], &meta);
>> +		if (!fn->check_btf_id) {
>> +			err = btf_resolve_helper_id(&env->log, fn, i);
>> +			if (err > 0)
>> +				meta.btf_id = err;
>> +		}
>> +		err = check_func_arg(env, i, fn->arg_type[i], &meta, fn);
> Nit. Since it is passing fn and i, may be skip passing
> fn->arg_type[i] altogether?
Make sense, will do.
>
>>   		if (err)
>>   			return err;
>>   	}
>> @@ -4750,6 +4761,16 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>>   		regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
>>   		regs[BPF_REG_0].id = ++env->id_gen;
>>   		regs[BPF_REG_0].mem_size = meta.mem_size;
>> +	} else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL) {
>> +		mark_reg_known_zero(env, regs, BPF_REG_0);
>> +		regs[BPF_REG_0].type = PTR_TO_BTF_ID_OR_NULL;
>> +		ret_btf_id = *fn->ret_btf_id;
>> +		if (ret_btf_id < 0) {
> If btf_vmlinux is not available, is ret_btf_id == 0?

Yes, it is a global variable. Will change it to <= 0.

>
>> +			verbose(env, "invalid return type %d of func %s#%d\n",
>> +				fn->ret_type, func_id_name(func_id), func_id);
>> +			return err;
> Is err correctly set at this point?

Typo, I mean return ret_btf_id. In Jiri's d_path patch, the btf_id are 
all non-negative values.

I may adopt the same convention in the next revision to make future 
conversion easier.

>
>> +		}
>> +		regs[BPF_REG_0].btf_id = ret_btf_id;
>>   	} else {
>>   		verbose(env, "unknown return type %d of func %s#%d\n",
>>   			fn->ret_type, func_id_name(func_id), func_id);
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index afaec7e082d9..478c10d1ec33 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1515,6 +1515,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>   		return &bpf_skb_output_proto;
>>   	case BPF_FUNC_xdp_output:
>>   		return &bpf_xdp_output_proto;
>> +	case BPF_FUNC_skc_to_tcp6_sock:
>> +		return &bpf_skc_to_tcp6_sock_proto;
>>   #endif
>>   	case BPF_FUNC_seq_printf:
>>   		return prog->expected_attach_type == BPF_TRACE_ITER ?
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 73395384afe2..faf6feedd78e 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -9191,3 +9191,72 @@ void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog)
>>   {
>>   	bpf_dispatcher_change_prog(BPF_DISPATCHER_PTR(xdp), prev_prog, prog);
>>   }
>> +
>> +/* Define a list of socket types which can be the argument for
>> + * skc_to_*_sock() helpers. All these sockets should have
>> + * sock_common as the first argument in its memory layout.
>> + */
>> +static const char *sock_cast_types[] = {
>> +	"inet_connection_sock",
>> +	"inet_request_sock",
>> +	"inet_sock",
>> +	"inet_timewait_sock",
>> +	"request_sock",
>> +	"sock",
>> +	"sock_common",
>> +	"tcp_sock",
>> +	"tcp_request_sock",
>> +	"tcp_timewait_sock",
>> +	"tcp6_sock",
>> +	"udp_sock",
>> +	"udp6_sock",
>> +};
>> +
>> +static int sock_cast_btf_ids[ARRAY_SIZE(sock_cast_types)];
>> +
>> +static bool check_arg_btf_id(u32 btf_id, u32 arg)
>> +{
>> +	int i;
>> +
>> +	/* only one argument, no need to check arg */
>> +	for (i = 0; i < ARRAY_SIZE(sock_cast_btf_ids); i++)
>> +		if (sock_cast_btf_ids[i] == btf_id)
>> +			return true;
>> +	return false;
>> +}
>> +
>> +BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
>> +{
>> +	/* add an explicit cast to struct tcp6_sock to force
>> +	 * debug_info type generation for it.
>> +	 */
>> +	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP &&
>> +	    sk->sk_family == AF_INET6)
>> +		return (unsigned long)(struct tcp6_sock *)sk;
>> +
>> +	return (unsigned long)NULL;
>> +}
>> +
>> +static int bpf_skc_to_tcp6_sock_ret_btf_id;
>> +const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto = {
>> +	.func			= bpf_skc_to_tcp6_sock,
>> +	.gpl_only		= true,
>> +	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
>> +	.arg1_type		= ARG_PTR_TO_BTF_ID,
>> +	.check_btf_id		= check_arg_btf_id,
>> +	.ret_btf_id		= &bpf_skc_to_tcp6_sock_ret_btf_id,
>> +};
>> +
>> +void init_sock_cast_types(struct btf *btf)
>> +{
>> +	char *ret_type_name;
>> +
>> +	/* find all possible argument btf_id's for socket cast helpers */
>> +	find_array_of_btf_ids(btf, sock_cast_types, sock_cast_btf_ids,
>> +			      ARRAY_SIZE(sock_cast_types));
>> +
>> +	/* find return btf_id */
>> +	ret_type_name = "tcp6_sock";
>> +	find_array_of_btf_ids(btf, &ret_type_name,
>> +			      &bpf_skc_to_tcp6_sock_ret_btf_id, 1);
> Instead of re-finding tcp6_sock/tcp_sock/request_sock...etc,
> can the sock_cast_btf_ids[] be reused?
Actually, yes, we can. Will do.
