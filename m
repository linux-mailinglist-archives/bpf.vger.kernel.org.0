Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0708425F0F3
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 00:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIFWlC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Sep 2020 18:41:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41474 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgIFWk6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 6 Sep 2020 18:40:58 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 086MegNU020990;
        Sun, 6 Sep 2020 15:40:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=h3ZkudP0/W+pAsVvNqAnFbYl1DZAbLGMrejlAfGvwcc=;
 b=Ls7vuBFNMdT9VxXB5UMzCnZrJc6Uc/MCZwI/bsYKbQWTTYbK38Lq+icFU04P+9IJKuEr
 T/qDoHrkvj+CPycwh/pspPp2G0nJLuynBxp2S5bH+cnCozZPYgL7e2vSYA9wl6vTWU/f
 ZlGHkwYwE/pHso/tn9A32lBfj3gQmk/3QT4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33c8dw51dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 06 Sep 2020 15:40:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 6 Sep 2020 15:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INEzP17/SkTxcNNZmchLfrVoxVXF+PWd0IhVtSNTZ5RnGkmzwOQ8wrEqxnqURRFg5gpkn1r2KzvYQ8jWxQl80pBFsBms9QIh7QWpiecseywEp1lvCdt02flu2x9THzLXmaifr6n7s6yFgOYsUPbjVeiFgJYb5N2XSacZraMOZxma89D/By+aFxCWbcH9Q6HofMIREQVJWkopS3dE+TmGT9IP/F2ZBk1ZIB2mMAoevQ0SW5zFZ+vhKASiSoPYUoG5mw49TVNnS/AbRDjagAtMNsjE6jBOUJ3dFZl6sxPgEo/ZoqseBtUABG35LA7vKRQH+BcE4/WibdVJDT57Wrr3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3ZkudP0/W+pAsVvNqAnFbYl1DZAbLGMrejlAfGvwcc=;
 b=BVoUzWKhKHpVsZ2c+wql3EWzAreHNfAk0O9yNgL0dKfaF11Qt6vvEo2xKxruHNs2bpxKjv7eY++h6zWvM1MuG1BJHTzrTYUuK5A+snSqJDpjdGjvOv/LaO/ExgT5tUYLhay3ysTeRfmgEV/JgRMWhNSx7fwpYiv7tlQVIrpZZFb/apKt3/ptzaWiG6QCdXOOeKZug/EZNhHDCGtYjPVosztrOovS8bdfT83qP6iqDtTtT38ttXmUBoaVqCWmvWd97c8wMPhsoF1UOvGeb4SstMJDYz/felZKPn+KqYb55hjkCN3npsUTcfxTEEG0Pb5CsF++l6G+Mb+W+EpgcaZjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3ZkudP0/W+pAsVvNqAnFbYl1DZAbLGMrejlAfGvwcc=;
 b=WIPDT+WrH2wEBqPgo89SDfFAw+Yg0B2PfqydA+8is7SQyJmkVLZfOkIU7q6a1dAarED4N/HjJFVaipfTB618rHw5/v/B92JMdXC/KGZ8fKNOC4Ky7w5tiWsoQv7mv51VohOZkWAhTviUYYgVE/4FVedJQw9/Oo1oGNICbzCPQ+8=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3255.namprd15.prod.outlook.com (2603:10b6:a03:107::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Sun, 6 Sep
 2020 22:40:14 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3348.019; Sun, 6 Sep 2020
 22:40:14 +0000
Date:   Sun, 6 Sep 2020 15:40:08 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <jakub@cloudflare.com>, <john.fastabend@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Allow passing BTF pointers as
 PTR_TO_SOCKET
Message-ID: <20200906224008.fph4frjkkegs6w3b@kafai-mbp.dhcp.thefacebook.com>
References: <20200904095904.612390-1-lmb@cloudflare.com>
 <20200904095904.612390-2-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904095904.612390-2-lmb@cloudflare.com>
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:1a4) by BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Sun, 6 Sep 2020 22:40:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:1a4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b47ea23-07d4-4142-d655-08d852b5d1d8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3255D6AE7D3CF15B3C92D714D52B0@BYAPR15MB3255.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVr0WAe87+mSUMFy8EXvHESDserz55OkyYkDQpbtk9J3C4SMoj9OivQErgQ3CvGK09kZmZl8cxKd5FF0y0pPQ0xMEFqsK/4+vsR7eAS24xvOW4sqjP2uyz7sDJFmJphg26UHqFTSN6J73BwcO154ra87cdr+kdmqO2Hz3DMtUx6yNpj9GpO+TZVg9y6yW/pArYTdCZgyiZMXYYuQM8XPwKW6DeR3NczOEHr0EmUJlM8H1zRu9RgcfdFuRdWLPLgZdTY4J5HsPbw7bSarfxywkP9btJCBKwix1W0O2om9xUyB7Fxz5MR+F5RXVOrhSUOm1oqYJ5GuIAj+vAfZQIa8B3puRfGmNA43A0DCB5NFgTpTU3FBt482uzUPl+Wq0k/1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(1076003)(8936002)(8676002)(5660300002)(2906002)(6916009)(6506007)(9686003)(4326008)(66476007)(52116002)(7696005)(66556008)(316002)(66946007)(186003)(55016002)(16526019)(6666004)(83380400001)(478600001)(86362001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /yKJENvEgTrr1w4HY6180bPyFcyYBKCYwY3uIO0SzcjGnSfQb5cbx08IzIwmvJ1uPX80N0gxFAVqc1CpQdTE003dmz9WFAIwrtMlAzFwmIDh6oZJ37/b8bPQef+dx50jrz9KrJ3QUkH4FZGQXobwPGparxYfxZHjLIuYN7EAQpKls1LsOUvnaxXSG3ZJ4XCYMqe2iswF64ha9pz6oKFWzkNfx1aUGmb7sq+b0eux16ShcI+bQbdv0ejHVSFgTtDe7Ik7ucY2g8HLtaGmUMl2rK088pHIESkOKtmjm+yBX7jHMS732rGSnTV+AomIohb+LpAIfq/GpAOBNYKzuR9wVhhidcDNeeNmpFGE8dczEgJztCwinLaae/0lf0wRoOPssty88Crz0TQAe7Z2CZEwyZHqf9YpivG4Hw5n0tT3qvsa+prlvAacq5Yi/0Edjk/Mh+kctWicU34V3JjIqucUfWV7m0em4V7Upjoh/fQaRUeJGUL9Z0n9irSdlfvAULHUgjI2d5ulGyydP0vnVCI1B6Ty805ysaaRGDgRP5cJkBfXnQDpA+67YGrcuDPCi5fsjSEIvKkVpB3Ahj6ylP/x751qsRmBVJL/AvIumq1TRcWKYTKlA6R/SPrkapcEQaEPUvCLgSCLxR9PCZ2n3HhnzTfC7JFCOnIlHAVgTWgzEn8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b47ea23-07d4-4142-d655-08d852b5d1d8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2020 22:40:14.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djcy4iwnfdd4DM504WP55eaDrlLUbVonoigwr0WDDcgCK4eUsjEhK2Ia+Fm70YiC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3255
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-06_18:2020-09-04,2020-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009060233
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 04, 2020 at 10:58:59AM +0100, Lorenz Bauer wrote:
> Tracing programs can derive struct sock pointers from a variety
> of sources, e.g. a bpf_iter for sk_storage maps receives one as
> part of the context. It's desirable to be able to pass these to
> functions that expect PTR_TO_SOCKET. For example, it enables us
> to insert such a socket into a sockmap via map_elem_update.
> 
> Teach the verifier that a PTR_TO_BTF_ID for a struct sock is
> equivalent to PTR_TO_SOCKET. There is one hazard here:
> bpf_sk_release also takes a PTR_TO_SOCKET, but expects it to be
> refcounted. Since this isn't the case for pointers derived from
> BTF we must prevent them from being passed to the function.
> Luckily, we can simply check that the ref_obj_id is not zero
> in release_reference, and return an error otherwise.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  kernel/bpf/verifier.c | 61 +++++++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b4e9c56b8b32..509754c3aa7d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3908,6 +3908,9 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +BTF_ID_LIST(btf_fullsock_ids)
> +BTF_ID(struct, sock)
It may be fine for the sockmap iter case to treat the "struct sock" BTF_ID
as a fullsock (i.e. PTR_TO_SOCKET).

This is a generic verifier change though.  For tracing, it is not always the
case.  It cannot always assume that the "struct sock *" in the function being
traced is always a fullsock.

Currently, the func_proto taking ARG_PTR_TO_SOCKET can safely
assume it must be a fullsock.  If it is allowed to also take BTF_ID
"struct sock" in verification time,  I think the sk_fullsock()
check in runtime is needed and this check should be pretty
cheap to do.

> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
>  			  const struct bpf_func_proto *fn)
> @@ -4000,37 +4003,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		expected_type = PTR_TO_SOCKET;
>  		if (!(register_is_null(reg) &&
>  		      arg_type == ARG_PTR_TO_SOCKET_OR_NULL)) {
> -			if (type != expected_type)
> +			if (type != expected_type &&
> +			    type != PTR_TO_BTF_ID)
>  				goto err_type;
>  		}
> +		meta->btf_id = btf_fullsock_ids[0];
>  	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
> -		bool ids_match = false;
> -
>  		expected_type = PTR_TO_BTF_ID;
>  		if (type != expected_type)
>  			goto err_type;
> -		if (!fn->check_btf_id) {
> -			if (reg->btf_id != meta->btf_id) {
> -				ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> -								 meta->btf_id);
> -				if (!ids_match) {
> -					verbose(env, "Helper has type %s got %s in R%d\n",
> -						kernel_type_name(meta->btf_id),
> -						kernel_type_name(reg->btf_id), regno);
> -					return -EACCES;
> -				}
> -			}
> -		} else if (!fn->check_btf_id(reg->btf_id, arg)) {
> -			verbose(env, "Helper does not support %s in R%d\n",
> -				kernel_type_name(reg->btf_id), regno);
> -
> -			return -EACCES;
> -		}
> -		if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
> -			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
> -				regno);
> -			return -EACCES;
> -		}
>  	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
>  		if (meta->func_id == BPF_FUNC_spin_lock) {
>  			if (process_spin_lock(env, regno, true))
> @@ -4085,6 +4066,33 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		return -EFAULT;
>  	}
>  
> +	if (type == PTR_TO_BTF_ID) {
> +		bool ids_match = false;
> +
> +		if (!fn->check_btf_id) {
> +			if (reg->btf_id != meta->btf_id) {
> +				ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> +								 meta->btf_id);
> +				if (!ids_match) {
> +					verbose(env, "Helper has type %s got %s in R%d\n",
> +						kernel_type_name(meta->btf_id),
> +						kernel_type_name(reg->btf_id), regno);
> +					return -EACCES;
> +				}
> +			}
> +		} else if (!fn->check_btf_id(reg->btf_id, arg)) {
> +			verbose(env, "Helper does not support %s in R%d\n",
> +				kernel_type_name(reg->btf_id), regno);
> +
> +			return -EACCES;
> +		}
> +		if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
> +			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
> +				regno);
> +			return -EACCES;
> +		}
> +	}
> +
>  	if (arg_type == ARG_CONST_MAP_PTR) {
>  		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
>  		meta->map_ptr = reg->map_ptr;
> @@ -4561,6 +4569,9 @@ static int release_reference(struct bpf_verifier_env *env,
>  	int err;
>  	int i;
>  
> +	if (!ref_obj_id)
> +		return -EINVAL;
hmm...... Is it sure this is needed?  If it was, it seems there was
an existing bug in release_reference_state() below which could not catch
the case where "bpf_sk_release()" is called on a pointer that has no
reference acquired before.

Can you write a verifier test to demonstrate the issue?

> +
>  	err = release_reference_state(cur_func(env), ref_obj_id);
>  	if (err)
>  		return err;
> -- 
> 2.25.1
> 
