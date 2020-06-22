Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBCB204285
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgFVVU1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 17:20:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728555AbgFVVU0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 17:20:26 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05MLJmGR029506;
        Mon, 22 Jun 2020 14:19:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vyQFJDvjk+EjHmS0BtpB/Vctu3tEKNI5t0TQPs/ucOk=;
 b=clyPQ/GhOF+a8VyxPs+30qbt4pmC1blkCCxIA16bes9Tir2+mSvWATOO+K6G6FDZBlxS
 8/ESOkvKwWR/C8brObb/yz/ZN9Tmhp3LUprvQUWnhAYy8p2XlxSqNgY4YZmrt0ey2LVo
 MC32yuDnJGN7K+Rl60e5JlkiflmXajxt4Q8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31se4njnn6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 14:19:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 14:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RejNmd/BDzBCRmgt7+w1EVk6MSX/bEO/OSGvyM1WXoBo8hBBGiH+D/4cDi9GDH7FYt/nmxUUxyKuUzIfMGdgmVGFev3bkq9LurbogwrCQ/ORoZjiKfB3WbSZZ4LSMYtu86333ZksDqG/mfT/ri0LIlMATf5FN9AyD8S9DNqpBvG+azALzAOSHLkO2Gk7SWeowxCvVzUf0N7utkb8G73BG++AZgg3wvHwIJOTfbR3WbFNl3K6GMFu3GpFGwBEScZIfhVI0xkiZq5xkzHU3bNgtEiDX9UlIHFoTmkvLLTcbk20F1r1LUBvyD0ZMDfGDOngqrHtrzPfo2rNU7xQkHrhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyQFJDvjk+EjHmS0BtpB/Vctu3tEKNI5t0TQPs/ucOk=;
 b=Q5HmljcqtBGChstRRCil19g+y5aLo+AP6TxYC2r6P0VksQ/Cz28WTO+MQLFOiZAfiHkAlayN8lFYCFLmd4l47aBNieSICB2LHgo3qwunjL9Gzy4D5GB8yHHIQz50dOassXYYqraEP/q40Z3IDIINhGEp83+LKOxq83cui5FiCwldwbH0hr5WGo8iqO7v97fXBBc+gmhF4FIc1X62CI12uLedItY7BRnUNT624ZUXgCWB4kBD7SRFKJoyjEWFPrNjKwVtPlG8KNgiB03V4/yXPmq3rBlc1QyQpe1zi0+uKjBC3heR1dszyipmxnrKDwkFmd27202y4fvjsDqgP7AR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyQFJDvjk+EjHmS0BtpB/Vctu3tEKNI5t0TQPs/ucOk=;
 b=WfNCzkpZSRk+6bLpGnj28eiOuHb1YsVftO5LAtMxMobyfTSmsrQtYbDFl6QOoWSzbivPOdVU1nkkrVLZBbJ6Ebh8RobvTqHv7Er/76+9Yz5GNIa7XH1xcdW0JhsZ00tEb6fPgbz6UMcNrw8qOz/Acu2jEjJyTYGiP9Ufc0hzC9M=
Received: from DM6PR15MB3580.namprd15.prod.outlook.com (2603:10b6:5:1f9::10)
 by DM6PR15MB2393.namprd15.prod.outlook.com (2603:10b6:5:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 21:18:57 +0000
Received: from DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4]) by DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4%6]) with mapi id 15.20.3109.025; Mon, 22 Jun 2020
 21:18:57 +0000
Date:   Mon, 22 Jun 2020 14:18:55 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 06/15] bpf: add
 bpf_skc_to_{tcp,tcp_timewait,tcp_request}_sock() helpers
Message-ID: <20200622211855.r3xlhbchanlpbhbp@kafai-mbp.dhcp.thefacebook.com>
References: <20200621055459.2629116-1-yhs@fb.com>
 <20200621055506.2629891-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621055506.2629891-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To DM6PR15MB3580.namprd15.prod.outlook.com
 (2603:10b6:5:1f9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a594) by BY3PR10CA0015.namprd10.prod.outlook.com (2603:10b6:a03:255::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 21:18:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:a594]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 356bd5ef-fd0e-4532-01e8-08d816f1dfe6
X-MS-TrafficTypeDiagnostic: DM6PR15MB2393:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB239377BE059931AC325B36BFD5970@DM6PR15MB2393.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIvosp7vAyubYzP8cuZTUo4oFDC67PEVXKGOd5IZPmfNZIhDYJvMCn9Z+jqG5HrjP+//fkntO40OEb3PitaEpST92HYqG7mpEN1CqvfYNRZ+i5iquXHobE/ZDL++PP1JZr1FOeaP9LSi9eiXSJcwFErxWX2/wEOaRgRRNzyOCuis10gpgE/W4ImAIBl4EPgS+LNHtmVPMY7GAzBLVJX3Xv4pwclv5NB7iPpIKdstNMYJWVjv+7zAWH3LIG66xzJf2WfKicbA/SVwp9Blf88PKeof+4EeIzEiYdd+dmQ7QcLXLLZdHjFx/GCLynI3UT7PJJzjnNKA18dxuDNgACCt/aECvGgd5vD+HCYr9IdbqSStDIxQTAjYd4NSyp1330BC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3580.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39860400002)(366004)(396003)(6636002)(86362001)(8936002)(1076003)(5660300002)(8676002)(66476007)(83380400001)(66556008)(66946007)(6506007)(186003)(6862004)(4326008)(16526019)(9686003)(55016002)(2906002)(478600001)(52116002)(316002)(7696005)(54906003)(142933001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5DSoO5UNsOgQGQwH6fWu1MGsGgM8teBNi3GTttjlbDWJQ+hVz+hdPk6JEHx5ANtdMlLPs4WkHxQMHcuaBVOyv/u7MWfAOznhE9VmfYuQQDr1a3wxljdhm8bMiygyS7DcxYzn9QOyUr+glA2c7BVGlNQT2+UYPF/c3salP5UIbFzgM+gYN218XZB15XyLE+Zz1+KpaJNVpo0lWSSZt58Kc6I8ytJnw15hL/Q32LvX19hgvScWriYFDy91rB3nBp2VBAHkTHmKoAb5IMgaQX7OJC023AYALIGyV5EXaLd4SMprpWsQ3GbY4ODNoFYwnTH9++pPClxs2x6+4MwALfebrDFzLW1JdT1BRe4mjaseOm0vPb+XSpZHs1FoJWfZ6VfThryhIgapJrxAnqQDLUG4H3aEFZKyhY7Az/8+3w1Ova74pP7MZpJ+M2sCOkaie4uKA/uVWkUbrrHZ/Qrkx5GitSBDw3GkLZdgw7SHZJeSYK+Acn/7jGZzYO+aJ5z3y0hEscr6gTzgKEtPRvzlPtdHmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 356bd5ef-fd0e-4532-01e8-08d816f1dfe6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 21:18:57.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zK0v4BtnX1/LYGkartlXGBZhjbLT9vWpqn1BMP8XQwKlsuf7SLyOhZufbT8aHG0q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2393
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_12:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 cotscore=-2147483648 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220138
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 20, 2020 at 10:55:06PM -0700, Yonghong Song wrote:
> Three more helpers are added to cast a sock_common pointer to
> an tcp_sock, tcp_timewait_sock or a tcp_request_sock for
> tracing programs.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h            |  3 ++
>  include/uapi/linux/bpf.h       | 23 ++++++++++++++-
>  kernel/trace/bpf_trace.c       |  6 ++++
>  net/core/filter.c              | 51 ++++++++++++++++++++++++++++++++++
>  scripts/bpf_helpers_doc.py     |  6 ++++
>  tools/include/uapi/linux/bpf.h | 23 ++++++++++++++-
>  6 files changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0c658f78e939..b17e682454e5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1637,6 +1637,9 @@ extern const struct bpf_func_proto bpf_ringbuf_submit_proto;
>  extern const struct bpf_func_proto bpf_ringbuf_discard_proto;
>  extern const struct bpf_func_proto bpf_ringbuf_query_proto;
>  extern const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto;
> +extern const struct bpf_func_proto bpf_skc_to_tcp_sock_proto;
> +extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
> +extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
>  
>  const struct bpf_func_proto *bpf_tracing_func_proto(
>  	enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 394fcba27b6a..e256417d94c2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3258,6 +3258,24 @@ union bpf_attr {
>   *		Dynamically cast a *sk* pointer to a *tcp6_sock* pointer.
>   *	Return
>   *		*sk* if casting is valid, or NULL otherwise.
> + *
> + * struct tcp_sock *bpf_skc_to_tcp_sock(void *sk)
> + *	Description
> + *		Dynamically cast a *sk* pointer to a *tcp_sock* pointer.
> + *	Return
> + *		*sk* if casting is valid, or NULL otherwise.
> + *
> + * struct tcp_timewait_sock *bpf_skc_to_tcp_timewait_sock(void *sk)
> + * 	Description
> + *		Dynamically cast a *sk* pointer to a *tcp_timewait_sock* pointer.
> + *	Return
> + *		*sk* if casting is valid, or NULL otherwise.
> + *
> + * struct tcp_request_sock *bpf_skc_to_tcp_request_sock(void *sk)
> + * 	Description
> + *		Dynamically cast a *sk* pointer to a *tcp_request_sock* pointer.
> + *	Return
> + *		*sk* if casting is valid, or NULL otherwise.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -3396,7 +3414,10 @@ union bpf_attr {
>  	FN(ringbuf_discard),		\
>  	FN(ringbuf_query),		\
>  	FN(csum_level),			\
> -	FN(skc_to_tcp6_sock),
> +	FN(skc_to_tcp6_sock),		\
> +	FN(skc_to_tcp_sock),		\
> +	FN(skc_to_tcp_timewait_sock),	\
> +	FN(skc_to_tcp_request_sock),
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>   * function eBPF program intends to call
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 478c10d1ec33..de5fbe66e1ca 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1517,6 +1517,12 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_xdp_output_proto;
>  	case BPF_FUNC_skc_to_tcp6_sock:
>  		return &bpf_skc_to_tcp6_sock_proto;
> +	case BPF_FUNC_skc_to_tcp_sock:
> +		return &bpf_skc_to_tcp_sock_proto;
> +	case BPF_FUNC_skc_to_tcp_timewait_sock:
> +		return &bpf_skc_to_tcp_timewait_sock_proto;
> +	case BPF_FUNC_skc_to_tcp_request_sock:
> +		return &bpf_skc_to_tcp_request_sock_proto;
>  #endif
>  	case BPF_FUNC_seq_printf:
>  		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8ca365c5bd10..d26ce3b5e3d5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9271,3 +9271,54 @@ const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto = {
>  	.check_btf_id		= check_arg_btf_id,
>  	.ret_btf_id		= &sock_cast_btf_ids[SOCK_CAST_TCP6_SOCK],
>  };
> +
> +BPF_CALL_1(bpf_skc_to_tcp_sock, struct sock *, sk)
> +{
> +	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
> +		return (unsigned long)sk;
> +
> +	return (unsigned long)NULL;
> +}
> +
> +const struct bpf_func_proto bpf_skc_to_tcp_sock_proto = {
> +	.func			= bpf_skc_to_tcp_sock,
> +	.gpl_only		= true,
s/true/false/
and for other bpf_func_proto below.

> +	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
> +	.arg1_type		= ARG_PTR_TO_BTF_ID,
> +	.check_btf_id		= check_arg_btf_id,
> +	.ret_btf_id		= &sock_cast_btf_ids[SOCK_CAST_TCP_SOCK],
> +};
> +
> +BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
> +{
> +	if (sk->sk_state == TCP_TIME_WAIT)
Not sure if checking TCP_TIME_WAIT can guarantee a tcp_timewait_sock.
dccp seems to have the same state aliased to DCCP_TIME_WAIT.
The same goes for the TCP_NEW_SYN_RECV check.

may be checking sk->sk_prot instead?

> +		return (unsigned long)sk;
> +
> +	return (unsigned long)NULL;
> +}
> +
> +const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto = {
> +	.func			= bpf_skc_to_tcp_timewait_sock,
> +	.gpl_only		= true,
> +	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
> +	.arg1_type		= ARG_PTR_TO_BTF_ID,
> +	.check_btf_id		= check_arg_btf_id,
> +	.ret_btf_id		= &sock_cast_btf_ids[SOCK_CAST_TCP_TW_SOCK],
> +};
> +
> +BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
> +{
> +	if (sk->sk_state == TCP_NEW_SYN_RECV)
> +		return (unsigned long)sk;
> +
> +	return (unsigned long)NULL;
> +}
> +
> +const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto = {
> +	.func			= bpf_skc_to_tcp_request_sock,
> +	.gpl_only		= true,
> +	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
> +	.arg1_type		= ARG_PTR_TO_BTF_ID,
> +	.check_btf_id		= check_arg_btf_id,
> +	.ret_btf_id		= &sock_cast_btf_ids[SOCK_CAST_TCP_REQ_SOCK],
> +};
