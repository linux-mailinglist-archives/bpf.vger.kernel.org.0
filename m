Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8861FFCF5
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgFRUyf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 16:54:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56322 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgFRUye (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 16:54:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IKpl5T023163;
        Thu, 18 Jun 2020 13:54:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=jcAdi6QQuGWrGpMph/bMTmcbAKTh5jdwp2mzo+1sg4s=;
 b=jK8vQVtHXi0Uv/eFeX6MFFR15ijfb6q2yCZ9NXpknRcC2KDQJiAnIAG97UKEEl+aCxj1
 OntTbxs67dUQ0go/R3BjdK11KIXk8Ko3/TxAZNsmORhqZKpYgaDq4KkYeaBWIiITRdjX
 PHml8wiBX/fCqBnzOxh5cWBD1BHQQG2/qRU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q660xebc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 13:54:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 13:54:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjMxIuvUxDKxTdLL5mAOyXfSxf4j0G3mzmjkeJhyD3nwxf4ZbRyHtIKCmgZo5r40zsuas5r4t4Q2eT059Un02WfA4n36m1B/gc69kwAphqKH5/tT06rtwVaslIl5mh2aAFHXYaBWQ5/IlkILh9+a18YF4qHMMw0IBvKrgkht1sj7MpflzEpCiMJvkaEUMJoeIHAeoU3t+6o3VxventqL6eJj0wQ81BliStVBOCTibAqbDBs9y0rO2r+PcBhayBmPO/GvIIGfynIeGlClTGwtWeFSpBxbq0JQy14loJIxq99am241et19Xn7Z54rRJ8VD3UXIKrX71NSfrlptZ3HPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcAdi6QQuGWrGpMph/bMTmcbAKTh5jdwp2mzo+1sg4s=;
 b=C5oILCNvqjr5zqbySdoN4nWZFEZn0qMEtRm15k3rB64UhKo8j4IVxuMxcpSO3JoTCqGpp0Wm607a8wOWLpWXHDaLVUsOZa+QFtWd8VSC4im9ItPPRvr57lt4XEiVHpYYhG3aYmTiHON3b7rqS6rW2h/J+SUBsWZKBKb3k2A8LERUbX8d6MzOz1nBVLl4LDFn21BJqUE8YKwKCgNp6WYxLED+wDeAkq/2GKlCJTYkeG/kEujZGmE6/wElN5+3l7p1pwPCAbkEcHdcrjZBVNs6g2UVzvr9mXfO0rxLWJVdM6OQWslt0Vu2DSimysJglNq9lvVsltGoTqUSx2pO8qEWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcAdi6QQuGWrGpMph/bMTmcbAKTh5jdwp2mzo+1sg4s=;
 b=M9q91BykIm8QO4UKwdmZs7xyL6P40ngLc6IDOp9GJT22d+wkf+JBgO3aosQ9dOrEI9zvdc3tJ6KKhYJkcyz8V1UYgT9Uvpw42PDwAuV3OESf61cNwVYJwO8WkAklW5nYn3W7sFW/QPysI/xEm2jyoOFEIxMuJWUzQl5IE5M74OU=
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2200.namprd15.prod.outlook.com (2603:10b6:a02:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 20:54:16 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 20:54:16 +0000
Date:   Thu, 18 Jun 2020 13:54:12 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 05/13] bpf: add bpf_skc_to_tcp6_sock() helper
Message-ID: <20200618205412.6updodfkqv2lz4pm@kafai-mbp.dhcp.thefacebook.com>
References: <20200617211536.1854348-1-yhs@fb.com>
 <20200617211542.1856028-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617211542.1856028-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: SN4PR0701CA0036.namprd07.prod.outlook.com
 (2603:10b6:803:2d::30) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:d71) by SN4PR0701CA0036.namprd07.prod.outlook.com (2603:10b6:803:2d::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 20:54:14 +0000
X-Originating-IP: [2620:10d:c090:400::5:d71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2329d84e-db63-446d-b8fc-08d813c9c30c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2200B1A2D7BF2AF520227F42D59B0@BYAPR15MB2200.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvV3Hb3bAY2XNEGLdRyMNyE3q5ipK6cV2jhNNLoRIC4J9Oim46Soigx5Vgg7iKlZyaiaPUdZykNlqhLWRJt4TLz7Z0IHmMqNCwVpEqMaYshsG0wHOZou1F50dUsq7Z1kAzM4b30BLnx5B3ZmXLvN8kvnVCPiMXeawxo7XGRbohm7M1cTnhtsdNrLNU7/YapLTFNyPBrdUQLyB6TWVwDSST0grSgoyYczmjcwihBjf4b1dbbmJEq+307NUDrKr99T6BYbZPT9pTgFUvkirrdlSfWR4nbeRtEPVn3U2Mhc7IMfsr8Lt32CVuk3JTd8Qi98ggcz2VN7w8MDYS9bmba/aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(376002)(136003)(396003)(346002)(6862004)(4326008)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6636002)(8936002)(1076003)(16526019)(66946007)(52116002)(7696005)(478600001)(186003)(316002)(9686003)(55016002)(66476007)(66556008)(54906003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0zESpeaVzSN76iLj/rhmX4WEcj/BLOBmFyQ5bxO1Alpo8BdvxKYXLinow4iwxjhRvrK2JCpOIfH6YPt5dbnyI/p20A/dIe1ITxyuEZdxOe/1zvdZ3bKPO5Azc3WDLIGPELvTxMb2mF5jtkFOwNYRzV6d80Ke8+dRM9UtEBRMNv3LFHQUSSeLGQLBLg/c0NNhaH+T/kOpj+LdCH4fH7b6ygmcbj3UKHaoEHja51fHaj3APbuhjPAKz7mmtj77JZ8pi1Eh86vmYKRg1qiQWPwaCZA386bW2MtcJoeF5xjzzWYsb5iqwJGV9o9jJWzibDlF59XTlNm2eHAn43mOo0DU2uxq8+3XaWdvIfvl8mpQ2UJwgXhVdPWdrBMrWjkqzW93odElelamNFdciRp0qRRaB5WPYJSioNLAwJPEk+MbwnVyrCnWxHY/RQI1UzKIqHpnI33QveDbe86jLUOmZSUVPtDfw8JiL+ZwRD57K1csMcwlnegSUZ5cIwb6sw+dFjIpAkVHGP721GNJ+0hXyuxOJA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2329d84e-db63-446d-b8fc-08d813c9c30c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 20:54:16.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCZ5SCHsAGlHmsUuIrWYmjdB/i4W5WwuAdo0QJyUHIUZWsQZlnKmXCPTaAo5QEI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180160
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 02:15:42PM -0700, Yonghong Song wrote:
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

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 07052d44bca1..e455aa09039b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -261,6 +261,7 @@ enum bpf_return_type {
>  	RET_PTR_TO_TCP_SOCK_OR_NULL,	/* returns a pointer to a tcp_sock or NULL */
>  	RET_PTR_TO_SOCK_COMMON_OR_NULL,	/* returns a pointer to a sock_common or NULL */
>  	RET_PTR_TO_ALLOC_MEM_OR_NULL,	/* returns a pointer to dynamically allocated memory or NULL */
> +	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
>  };
>  
>  /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF programs
> @@ -283,6 +284,10 @@ struct bpf_func_proto {
>  		enum bpf_arg_type arg_type[5];
>  	};
>  	int *btf_id; /* BTF ids of arguments */
> +	bool (*check_btf_id)(u32 btf_id, u32 arg); /* If the argument could match
> +						    * more than one btf id's.
> +						    */
> +	int *ret_btf_id; /* return value btf_id */
>  };
>  
>  /* bpf_context is intentionally undefined structure. Pointer to bpf_context is
> @@ -1196,6 +1201,10 @@ bool bpf_link_is_iter(struct bpf_link *link);
>  struct bpf_prog *bpf_iter_get_info(struct bpf_iter_meta *meta, bool in_stop);
>  int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx);
>  
> +void init_sock_cast_types(struct btf *btf);
CONFIG_NET may not be set.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 34cde841ab68..22d90d47befa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3735,10 +3735,12 @@ static int int_ptr_type_to_size(enum bpf_arg_type type)
>  	return -EINVAL;
>  }
>  
> -static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
> +static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  enum bpf_arg_type arg_type,
> -			  struct bpf_call_arg_meta *meta)
> +			  struct bpf_call_arg_meta *meta,
> +			  const struct bpf_func_proto *fn)
>  {
> +	u32 regno = BPF_REG_1 + arg;
>  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>  	enum bpf_reg_type expected_type, type = reg->type;
>  	int err = 0;
> @@ -3820,9 +3822,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
>  		expected_type = PTR_TO_BTF_ID;
>  		if (type != expected_type)
>  			goto err_type;
> -		if (reg->btf_id != meta->btf_id) {
> -			verbose(env, "Helper has type %s got %s in R%d\n",
> -				kernel_type_name(meta->btf_id),
> +		if (!fn->check_btf_id) {
> +			if (reg->btf_id != meta->btf_id) {
> +				verbose(env, "Helper has type %s got %s in R%d\n",
> +					kernel_type_name(meta->btf_id),
> +					kernel_type_name(reg->btf_id), regno);
> +
> +				return -EACCES;
> +			}
> +		} else if (!fn->check_btf_id(reg->btf_id, arg + 1)) {
Why arg "+ 1"?

> +			verbose(env, "Helper does not support %s in R%d\n",
>  				kernel_type_name(reg->btf_id), regno);
>  
>  			return -EACCES;
> @@ -4600,7 +4609,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  	struct bpf_reg_state *regs;
>  	struct bpf_call_arg_meta meta;
>  	bool changes_data;
> -	int i, err;
> +	int i, err, ret_btf_id;
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
> +		err = check_func_arg(env, i, fn->arg_type[i], &meta, fn);
Nit. Since it is passing fn and i, may be skip passing
fn->arg_type[i] altogether?

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
> +		if (ret_btf_id < 0) {
If btf_vmlinux is not available, is ret_btf_id == 0?

> +			verbose(env, "invalid return type %d of func %s#%d\n",
> +				fn->ret_type, func_id_name(func_id), func_id);
> +			return err;
Is err correctly set at this point?

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
> index 73395384afe2..faf6feedd78e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9191,3 +9191,72 @@ void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog)
>  {
>  	bpf_dispatcher_change_prog(BPF_DISPATCHER_PTR(xdp), prev_prog, prog);
>  }
> +
> +/* Define a list of socket types which can be the argument for
> + * skc_to_*_sock() helpers. All these sockets should have
> + * sock_common as the first argument in its memory layout.
> + */
> +static const char *sock_cast_types[] = {
> +	"inet_connection_sock",
> +	"inet_request_sock",
> +	"inet_sock",
> +	"inet_timewait_sock",
> +	"request_sock",
> +	"sock",
> +	"sock_common",
> +	"tcp_sock",
> +	"tcp_request_sock",
> +	"tcp_timewait_sock",
> +	"tcp6_sock",
> +	"udp_sock",
> +	"udp6_sock",
> +};
> +
> +static int sock_cast_btf_ids[ARRAY_SIZE(sock_cast_types)];
> +
> +static bool check_arg_btf_id(u32 btf_id, u32 arg)
> +{
> +	int i;
> +
> +	/* only one argument, no need to check arg */
> +	for (i = 0; i < ARRAY_SIZE(sock_cast_btf_ids); i++)
> +		if (sock_cast_btf_ids[i] == btf_id)
> +			return true;
> +	return false;
> +}
> +
> +BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
> +{
> +	/* add an explicit cast to struct tcp6_sock to force
> +	 * debug_info type generation for it.
> +	 */
> +	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP &&
> +	    sk->sk_family == AF_INET6)
> +		return (unsigned long)(struct tcp6_sock *)sk;
> +
> +	return (unsigned long)NULL;
> +}
> +
> +static int bpf_skc_to_tcp6_sock_ret_btf_id;
> +const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto = {
> +	.func			= bpf_skc_to_tcp6_sock,
> +	.gpl_only		= true,
> +	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
> +	.arg1_type		= ARG_PTR_TO_BTF_ID,
> +	.check_btf_id		= check_arg_btf_id,
> +	.ret_btf_id		= &bpf_skc_to_tcp6_sock_ret_btf_id,
> +};
> +
> +void init_sock_cast_types(struct btf *btf)
> +{
> +	char *ret_type_name;
> +
> +	/* find all possible argument btf_id's for socket cast helpers */
> +	find_array_of_btf_ids(btf, sock_cast_types, sock_cast_btf_ids,
> +			      ARRAY_SIZE(sock_cast_types));
> +
> +	/* find return btf_id */
> +	ret_type_name = "tcp6_sock";
> +	find_array_of_btf_ids(btf, &ret_type_name,
> +			      &bpf_skc_to_tcp6_sock_ret_btf_id, 1);
Instead of re-finding tcp6_sock/tcp_sock/request_sock...etc,
can the sock_cast_btf_ids[] be reused?
