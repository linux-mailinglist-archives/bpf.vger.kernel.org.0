Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8BE20422A
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgFVUvF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 16:51:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728421AbgFVUvE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 16:51:04 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MKmOnd030814;
        Mon, 22 Jun 2020 13:50:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=TvEj64pqVLXA8+8GKoFxSaaqwC47RSF8b5EqAAG2HT4=;
 b=FOEuAeTL50cHUgk73PDhz8I/yC/Tojrszrx46VRXPBTO5imN7W6Sk1Sp78C/bDXDcxCt
 Y3fkDYPeaJ2O85m9R39Yu6DSiGaDL/V1/UnHx6DkYTqLXJUgcIHm4EbijHBiPjiSyGnP
 cGKbFgu2h0AtUUk206nfgYwR+Hzi3tIIaC4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31u09s17xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 13:50:49 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 13:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxUaGekzDhf5q1uQmwLPuTZ0UN04NFr9iOAUQ0fqIZJHV/VkgHKmDV+hudMgrrW1LzrOnJFqbIHB/Pzo8pqu3X/+aJmtRUBt+HnezLw2T7qFy/BMNyyJs5YXMcC2X2LUsKZBzdEGlHAKABqjX3ayu1zrXq+QC6TKpE+TCV60JENm76WnPYdDu4Cw55oCwk7GnyEoTtPhWC7PGKnrlszaUztGPHAyxu1jX72JKUQykvxHW3NqE6sfCQVvmbFPkdlvF0MqFZAkeRciD9Nj2XX3kh7OjUViDdQ8BP83E80aGYllCyADbgL5+7MPW0rwhH4GoXF25ZhMvfN9z7x+QNc8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvEj64pqVLXA8+8GKoFxSaaqwC47RSF8b5EqAAG2HT4=;
 b=b4Lt3rJ8DIIbRpvRKLlvTOpgon1jCr0N11o3POQ/xDL98kx+CXVjzCTHqbtFK6ukVspTsKo1xZqMq6ScL4j1dSZS5nvsRQFruV76+8jwhCT4Yr2wmqsXBMGAt2shFO4mbhOEu0XIl93JcoJ1XIhwvZZjeQYmFodBsJSFLgJUf3juBlEEf4445jB1KQ8dndsEx4kd6QQy61aCTJSloTlMdZGx1d1vweZMh6T72+7VN4BegnF936lQQpvVCRmss6bZcz7zeOB0wiNyP2x92eB2GCM2MkUUMvoGbXWhNy8q42nAc8TaB/2+7nJiBFgacYdTr3QH3KztemO1XDPMQiufWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvEj64pqVLXA8+8GKoFxSaaqwC47RSF8b5EqAAG2HT4=;
 b=EMytqDSFp9gDeqzWsLm0gw/UVjwINzpP0/Hu5qWPKr6yAcEYtTbrW+i87NyuGm6chj3aESLL6WJGrs/ek9//AfqV9VF2fHCgZFW+MAv4XvWlk8vbJ8gqxkvq/bXblNJRt9T60sAFpRdWPliphdcLS/JyaMWC+UB7NOxqYnGSGOs=
Received: from DM6PR15MB3580.namprd15.prod.outlook.com (2603:10b6:5:1f9::10)
 by DM6PR15MB2716.namprd15.prod.outlook.com (2603:10b6:5:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 20:50:45 +0000
Received: from DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4]) by DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4%6]) with mapi id 15.20.3109.025; Mon, 22 Jun 2020
 20:50:45 +0000
Date:   Mon, 22 Jun 2020 13:50:43 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 05/15] bpf: add bpf_skc_to_tcp6_sock() helper
Message-ID: <20200622205042.a6tdcjhqhellrqul@kafai-mbp.dhcp.thefacebook.com>
References: <20200621055459.2629116-1-yhs@fb.com>
 <20200621055505.2629793-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621055505.2629793-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To DM6PR15MB3580.namprd15.prod.outlook.com
 (2603:10b6:5:1f9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a594) by BYAPR02CA0032.namprd02.prod.outlook.com (2603:10b6:a02:ee::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 20:50:44 +0000
X-Originating-IP: [2620:10d:c090:400::5:a594]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b361e25-1b22-4120-6c56-08d816edef4e
X-MS-TrafficTypeDiagnostic: DM6PR15MB2716:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB2716C051329B6B9B80424553D5970@DM6PR15MB2716.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGHoejrKQx3DMK7t+0r4U4tjFRsYk1Bkvxs08HKS4DdI/3ibrlHt/614D7Ie7nrYzy+yUIUziz/Z1JKeWsOG18Yu7CnlaMNmAgPjhxacUNiE57CreMmXnMWQEvjgFBFbdeJXDf7QW2BPJzUVnujbPadx1cabLwqEVKRaW9dlkdGik9BpIviRa7C1TAlGcENGvjlOPItJ+r+0lx9+Hbxa9luPZQ2ZT74J24O/z1+VkYclHe51AZnlQQy369CeMMxqSwp2Y65A5WoQg1ocCG3cjhwJ7AkCyuanOwKA1murgfr/hyzuF6q16cEu21J+2L++dHzlJq9v+lcXHhThBu5lpVJkGFyO/7FAPBglxgIZZIKWId8v1Gz+VapcgnAfc5MD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3580.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(6506007)(2906002)(5660300002)(54906003)(186003)(316002)(8676002)(86362001)(478600001)(4326008)(6862004)(55016002)(52116002)(66556008)(66476007)(7696005)(66946007)(9686003)(8936002)(1076003)(83380400001)(6636002)(16526019)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UUDucRhYaAPjvPwQzd1mszzdXFc+vUtWOYjnsdjsP1ln7uqORCFpdpzjpA31tP64/WdmgRbWMPM3AgOtCbO2b0gP2Pkhq+LloFHeBlY4y9dd5tSa3WfPgoCiGW9H4f3f2HAloy94Hy1eIOCV0Rxt3YMcDPSFvlk0fJ7aNkrjWfTXMf4izRd4C0NpZ3jIUXdydQaKbAEyIsHYliKgj4SDWHkNE6o2Txa/N/FJRyrvYkisigHf+OFqO6QDobf5ZleLB1hbEgn0BISIWjLVT/SF7s4HdxOtRITLLxU29CthARBJwN79nvggCreEsQIsD40vq3ovbeNDfRlX+sV304Yj5v2EdnQ05QiLeZvld6gIXL6xvaiZ2xmlUKjenvshQ1uOvH5Ctxy8grjKM2aVHrY6JkXjJgQ5NMNTaqjNiPtVDZ0kIIBnpigK3o3XsNxXymB78YTIKJpmZgHuOu9lDWBkF/WbZKlJuS9V1qsbYDQPHU+ccNmgL6+8xbJhzRMxO8xV/urx0rDiEK+TqeRxYunUXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b361e25-1b22-4120-6c56-08d816edef4e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 20:50:45.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wlpz3iE9ifps8t15f6mCiSsmWOlavp2cOYm88Hnu4LV9E4JI5rpNXLXGw9h64xrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2716
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_12:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 phishscore=0 mlxscore=0 cotscore=-2147483648 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220136
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 20, 2020 at 10:55:05PM -0700, Yonghong Song wrote:
> The helper is used in tracing programs to cast a socket
> pointer to a tcp6_sock pointer.
> The return value could be NULL if the casting is illegal.
> 
> A new helper return type RET_PTR_TO_BTF_ID_OR_NULL is added
> so the verifier is able to deduce proper return types for the helper.
> 
> Different from the previous BTF_ID based helpers,
> the bpf_skc_to_tcp6_sock() argument can be several possible
> btf_ids. More specifically, all possible socket data structures
> with sock_common appearing in the first in the memory layout.
> This patch only added socket types related to tcp and udp.
> 
> All possible argument btf_id and return value btf_id
> for helper bpf_skc_to_tcp6_sock() are pre-calculcated and
> cached. In the future, it is even possible to precompute
> these btf_id's at kernel build time.
> 

[ ... ]

> @@ -4600,7 +4609,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  	struct bpf_reg_state *regs;
>  	struct bpf_call_arg_meta meta;
>  	bool changes_data;
> -	int i, err;
> +	int i, err, ret_btf_id;
Nit.
Try to keep the rev xmas tree.
or just move "int ret_btf_id;" to the latter "else if (fn->ret_type...)"

>  
>  	/* find function prototype */
>  	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
> @@ -4644,10 +4653,12 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  	meta.func_id = func_id;
>  	/* check args */
>  	for (i = 0; i < 5; i++) {
> -		err = btf_resolve_helper_id(&env->log, fn, i);
> -		if (err > 0)
> -			meta.btf_id = err;
> -		err = check_func_arg(env, BPF_REG_1 + i, fn->arg_type[i], &meta);
> +		if (!fn->check_btf_id) {
> +			err = btf_resolve_helper_id(&env->log, fn, i);
> +			if (err > 0)
> +				meta.btf_id = err;
> +		}
> +		err = check_func_arg(env, i, &meta, fn);
>  		if (err)
>  			return err;
>  	}
> @@ -4750,6 +4761,16 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  		regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
>  		regs[BPF_REG_0].id = ++env->id_gen;
>  		regs[BPF_REG_0].mem_size = meta.mem_size;
> +	} else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL) {
> +		mark_reg_known_zero(env, regs, BPF_REG_0);
> +		regs[BPF_REG_0].type = PTR_TO_BTF_ID_OR_NULL;
> +		ret_btf_id = *fn->ret_btf_id;
> +		if (ret_btf_id == 0) {
> +			verbose(env, "invalid return type %d of func %s#%d\n",
> +				fn->ret_type, func_id_name(func_id), func_id);
> +			return -EINVAL;
> +		}
> +		regs[BPF_REG_0].btf_id = ret_btf_id;
>  	} else {
>  		verbose(env, "unknown return type %d of func %s#%d\n",
>  			fn->ret_type, func_id_name(func_id), func_id);
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index afaec7e082d9..478c10d1ec33 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1515,6 +1515,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_skb_output_proto;
>  	case BPF_FUNC_xdp_output:
>  		return &bpf_xdp_output_proto;
> +	case BPF_FUNC_skc_to_tcp6_sock:
> +		return &bpf_skc_to_tcp6_sock_proto;
>  #endif
>  	case BPF_FUNC_seq_printf:
>  		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 73395384afe2..8ca365c5bd10 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -47,6 +47,7 @@
>  #include <linux/seccomp.h>
>  #include <linux/if_vlan.h>
>  #include <linux/bpf.h>
> +#include <linux/btf.h>
>  #include <net/sch_generic.h>
>  #include <net/cls_cgroup.h>
>  #include <net/dst_metadata.h>
> @@ -9191,3 +9192,82 @@ void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog)
>  {
>  	bpf_dispatcher_change_prog(BPF_DISPATCHER_PTR(xdp), prev_prog, prog);
>  }
> +
> +/* Define a list of socket types which can be the argument for
> + * skc_to_*_sock() helpers. All these sockets should have
> + * sock_common as the first argument in its memory layout.
> + */
> +#define BPF_SOCK_CAST_TYPES \
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_INET_CONN_SOCK, "inet_connection_sock")	\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_INET_REQ_SOCK, "inet_request_sock")	\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_INET_SOCK, "inet_sock")			\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_INET_TW_SOCK, "inet_timewait_sock")	\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_REQ_SOCK, "request_sock")			\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_SOCK, "sock")				\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_SOCK_COMMON, "sock_common")		\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_TCP_SOCK, "tcp_sock")			\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_TCP_REQ_SOCK, "tcp_request_sock")		\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_TCP_TW_SOCK, "tcp_timewait_sock")		\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_TCP6_SOCK, "tcp6_sock")			\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_UDP_SOCK, "udp_sock")			\
> +	BPF_SOCK_CAST_TYPE(SOCK_CAST_UDP6_SOCK, "udp6_sock")
> +
> +enum {
> +#define BPF_SOCK_CAST_TYPE(name, str) name,
> +BPF_SOCK_CAST_TYPES
> +MAX_SOCK_CAST_TYPE,
> +#undef BPF_SOCK_CAST_TYPE
> +};
> +
> +static const char *sock_cast_types[] = {
> +#define BPF_SOCK_CAST_TYPE(name, str) str,
> +BPF_SOCK_CAST_TYPES
> +#undef BPF_SOCK_CAST_TYPE
> +};
> +
> +static int sock_cast_btf_ids[MAX_SOCK_CAST_TYPE];
Thanks for doing this.

I think they can be reused outside of casting in the future, e.g. bpf_tcp_ca.c.
If you respin, do you mind to remove the "_cast_" and "_CAST_".
May be naming it to BTF_SOCK_TYPE_xxx, btf_sock_ids?

[ ... ]

> +BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
> +{
> +     /* tcp6_sock type is not generated in dwarf and hence btf,
> +      * trigger an explicit type generation here.
> +      */
> +     BTF_TYPE_EMIT(struct tcp6_sock);
> +     if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP &&
> +         sk->sk_family == AF_INET6)
IS_ENABLED(CONFIG_IPV6) just came to my mind.  I think
it should be fine without checking it to keep the #if macro
to minimal.  No sk should be in AF_INET6 in that case.

> +             return (unsigned long)sk;
> +
> +     return (unsigned long)NULL;
> +}
> +
> +> +const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto = {
> +	.func			= bpf_skc_to_tcp6_sock,
> +	.gpl_only		= true,
s/true/false/  With that,

Acked-by: Martin KaFai Lau <kafai@fb.com>

> +	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
> +	.arg1_type		= ARG_PTR_TO_BTF_ID,
> +	.check_btf_id		= check_arg_btf_id,
> +	.ret_btf_id		= &sock_cast_btf_ids[SOCK_CAST_TCP6_SOCK],
> +};
