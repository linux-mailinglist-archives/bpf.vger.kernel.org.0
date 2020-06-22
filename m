Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70965204348
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgFVWFS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 18:05:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730858AbgFVWFR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 18:05:17 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MM51eX015500;
        Mon, 22 Jun 2020 15:05:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=N1V8us746JW8EZCz7J77heX9tVqDaqnaafLpFEkXKWk=;
 b=jQBo9la8/q8asiFp4KYZZ7tIOiayapj86uE5l8zHplAURrna39X6Lb0oAZD3lXhtazgV
 XzxPpC8/eNFFl1csh9ISDhk91avXSC9D6GEkpiuFT3qyLM5oTVZBi69lBMiz/vvaMIm1
 LvHWI49UD/FsRWd/FHaVlc60FjruOOWQ1v0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31t25bqv6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 15:05:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 15:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCyTgUcUBATRHO28bJ7d9+YMi9uw8n7DKZL53iwZXQgUb/tRLKABNHsOExTsObuBUw3O5+qtb88FdIoSCjUPFlYOIv5KC6qeSD5Vug6fLU5Xo41ViZjhWEVQzp1WhqYfFeQdMVeyeKEYfFmYaefPvxfRu1S465CF/a25dQPc6ybHkq3KbUj/5OnPSJL3PgKOhsARjKE/WxgQXFi6NeP/3xMGXHtPJS87lGB/7+oJZ6dUXZqjj4UVjkV97RyKPI22NB6KU5JLmdeMDTimfSul77ZSYxSLWz9eERYLCQynnowHkdK4PxkUCCvoNitEnkI9XTMi39TDGakJ2J52zJ5wcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1V8us746JW8EZCz7J77heX9tVqDaqnaafLpFEkXKWk=;
 b=F6iXTsKGzpCdYYVeIz3dE5fE6Jf+wPVPESxwND1+rah3PlQ7Nz7vhyKscLY9sttUE+s0rH/vKDzBZI5M9kJEGjT/Ubu1n9rxT12pJcY5jwfx4cAYMXvl23QiFF1doBuaCGKVQGIj5wGYlHuhMKagBEGKmq3Thq6oU3aAwF6fbs79oVtwwisc/024DCKRNXwzAc2sykef2Spaw7q8NEsYuFlo73IRxlj9q3lW2+tskjAGdsssDf06Qb8sN6QSYJklwP3Pp18JkymouEzzuphqk+R5N8fA8ytxPZuEVLnjtbIVcjbLs2/H7g2DSTLGhp1VbG/lJ1Ik+h1a5H3feeNeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1V8us746JW8EZCz7J77heX9tVqDaqnaafLpFEkXKWk=;
 b=SSlKMDtM3W9ccN0jGlMhiZMhR8bvknmk5g4BghYZDH6hJjSveZGgvNH4WKEp//tNAGaCHFzjw4U3Wi/TZxaw0KpfY2FPrHtFFplPkcvE2apbgt5Kv+3hgZpenJgiYEU/LTaUpOBFtn8YJiY8eIOMZTrASJtl079yumzNCvBOxMo=
Received: from DM6PR15MB3580.namprd15.prod.outlook.com (2603:10b6:5:1f9::10)
 by DM5PR15MB1418.namprd15.prod.outlook.com (2603:10b6:3:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 22:05:03 +0000
Received: from DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4]) by DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4%6]) with mapi id 15.20.3109.025; Mon, 22 Jun 2020
 22:05:03 +0000
Date:   Mon, 22 Jun 2020 15:05:00 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 09/15] bpf: add bpf_skc_to_udp6_sock() helper
Message-ID: <20200622220500.kame4gedylspaakl@kafai-mbp.dhcp.thefacebook.com>
References: <20200621055459.2629116-1-yhs@fb.com>
 <20200621055510.2630175-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621055510.2630175-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BY5PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:a03:167::22) To DM6PR15MB3580.namprd15.prod.outlook.com
 (2603:10b6:5:1f9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a594) by BY5PR17CA0045.namprd17.prod.outlook.com (2603:10b6:a03:167::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 22:05:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:a594]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26f0e791-34a9-4c57-22e2-08d816f850a7
X-MS-TrafficTypeDiagnostic: DM5PR15MB1418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR15MB14185FD3DD83EAB52C880F84D5970@DM5PR15MB1418.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1z9sr8bP6ssAPHmbfghtKtDzsUl+R1S2kKxWQvOy3RxTn9YywPgTzwkP5ILiYRIXbPtDKzLNZlaE81vIkCsRJScnxFIXNtwd7NQ8Yc2bnQivSEkqCgaAi+/YITCVk5QSFDR/t+DJ8m4eAcoacb0MJMv8B/74Lna0eTm59e46ytEnZw9ZtxnPcv3IVL1NqqHBGCb8aq6KnGYk9oDYo+SOxvTWJx6NcCOq9yp9WVJXEwxhgP7j9KrEgq48xbDPYOqHbHlaJnbK+Qvv3lG/Jyie67B0k4kmHkzlEOCgXAKZphMSnpz3O4HNc5gNSyR1C6Lk0FmJpiIL6G7/QYMOjxzXoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3580.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(5660300002)(54906003)(9686003)(1076003)(86362001)(478600001)(66556008)(66476007)(6636002)(316002)(2906002)(83380400001)(66946007)(52116002)(55016002)(16526019)(186003)(7696005)(6506007)(8936002)(8676002)(6862004)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: r+kNHtAm3AakxAlr+ZkD8aSLMP6um20mHWozACmqMsJUkyMY/YPqAk3OkFXZdd2DDq4ZkR+2cm8w6NdNqnj4/ef0se/iclm8heb2f7H4KGvIQr3i3L3o2n4+iaLBCexvtYXlK1NVc9zelGeS2ukkZZA0XeKLWnrlv9KXXc7Hv+gb4qLD1k1i+RwLeuesitdkKOrbIWFMecDRypxAc4mHEPG7la0P+j23GTKb7MdC3DqnhmvHqOoZKXfGdPDLfYGUpxWbpWKQkKCkYdvyoci3JQyTROgv4ftWvXynno7YvuGNnOLD5FuwBNtVghuVkvUFDWdUGohTOWkSjqhVSNZ/xYrhoHJ6o46XupKPcCiIMpysBKFsc9Fvd7q1WY1ClH+6ZKhJ3OWb5l9KMYe9PQY5JccNw3rzZEJ5cK/A89HKmGGV71pIXNSOwcBfBmIPbC5/nvJxF5dq+0TYDjFQbzKItIImBxe9tMAhUDGdHam02ugvXCXfK39bK2zd4+VkaCQOJxone663+ZJPcB4VuHRO6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f0e791-34a9-4c57-22e2-08d816f850a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 22:05:03.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32ZfcwMxh6bxaAsDBi8Ly51BetPUm6qJ+KN6z0U45gUoFn7RVMoac4q/EyEwBTv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1418
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_15:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 impostorscore=0 cotscore=-2147483648 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 20, 2020 at 10:55:10PM -0700, Yonghong Song wrote:
> The helper is used in tracing programs to cast a socket
> pointer to a udp6_sock pointer.
> The return value could be NULL if the casting is illegal.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  9 ++++++++-
>  kernel/trace/bpf_trace.c       |  2 ++
>  net/core/filter.c              | 22 ++++++++++++++++++++++
>  scripts/bpf_helpers_doc.py     |  2 ++
>  tools/include/uapi/linux/bpf.h |  9 ++++++++-
>  6 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b17e682454e5..378b6748a8ec 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1640,6 +1640,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto;
>  extern const struct bpf_func_proto bpf_skc_to_tcp_sock_proto;
>  extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
>  extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
> +extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
>  
>  const struct bpf_func_proto *bpf_tracing_func_proto(
>  	enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e256417d94c2..3f4b12c5c563 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3276,6 +3276,12 @@ union bpf_attr {
>   *		Dynamically cast a *sk* pointer to a *tcp_request_sock* pointer.
>   *	Return
>   *		*sk* if casting is valid, or NULL otherwise.
> + *
> + * struct udp6_sock *bpf_skc_to_udp6_sock(void *sk)
> + * 	Description
> + *		Dynamically cast a *sk* pointer to a *udp6_sock* pointer.
> + *	Return
> + *		*sk* if casting is valid, or NULL otherwise.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -3417,7 +3423,8 @@ union bpf_attr {
>  	FN(skc_to_tcp6_sock),		\
>  	FN(skc_to_tcp_sock),		\
>  	FN(skc_to_tcp_timewait_sock),	\
> -	FN(skc_to_tcp_request_sock),
> +	FN(skc_to_tcp_request_sock),	\
> +	FN(skc_to_udp6_sock),
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>   * function eBPF program intends to call
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index de5fbe66e1ca..d10ab16c4a2f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1523,6 +1523,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_skc_to_tcp_timewait_sock_proto;
>  	case BPF_FUNC_skc_to_tcp_request_sock:
>  		return &bpf_skc_to_tcp_request_sock_proto;
> +	case BPF_FUNC_skc_to_udp6_sock:
> +		return &bpf_skc_to_udp6_sock_proto;
>  #endif
>  	case BPF_FUNC_seq_printf:
>  		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index d26ce3b5e3d5..4ecdadc4aee9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9322,3 +9322,25 @@ const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto = {
>  	.check_btf_id		= check_arg_btf_id,
>  	.ret_btf_id		= &sock_cast_btf_ids[SOCK_CAST_TCP_REQ_SOCK],
>  };
> +
> +BPF_CALL_1(bpf_skc_to_udp6_sock, struct sock *, sk)
> +{
> +	/* udp6_sock type is not generated in dwarf and hence btf,
> +	 * trigger an explicit type generation here.
> +	 */
> +	BTF_TYPE_EMIT(struct udp6_sock);
> +	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_UDP &&
> +	    sk->sk_family == AF_INET6)
> +		return (unsigned long)sk;
> +
> +	return (unsigned long)NULL;
> +}
> +
> +const struct bpf_func_proto bpf_skc_to_udp6_sock_proto = {
> +	.func			= bpf_skc_to_udp6_sock,
> +	.gpl_only		= true,
Same gpl_only change is needed.

Acked-by: Martin KaFai Lau <kafai@fb.com>
