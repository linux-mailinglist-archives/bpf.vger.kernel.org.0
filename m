Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA1326269C
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 07:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgIIFIX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 01:08:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44460 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgIIFIS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 01:08:18 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08955x4h032296;
        Tue, 8 Sep 2020 22:08:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3Ir4im/HjJs04a0zb2WDmSEdBfqiLWdH3+oOzQMq6Iw=;
 b=aQ/vkAwmZfE51Ru4nFFZT8vIWPzrcIhVgatDgLpmRzlxoWUXKpspjQwtsp7XtjDu89uE
 egmQmsCLNOUj7pRuZk9d/AZciloFVeUbmYjPPjvDSbf9a3plkM+OgAbAT1NFOcA0i4gp
 5Rd/aM15AnT/7eE2ZJHKToTmW/2XcGPVTU8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33ct69nf52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Sep 2020 22:08:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Sep 2020 22:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzsBvKSMLp8+g3P8aD2VsAIDLRCP2s41+csq4ZdZ81DVJuJkWB8bTv9vjSJd6IGHgnoDgaDUcXkXzOFSkEGaAvrwERyc6JniPhKWi+OTCJFtByfhFVIA65WTxA/5vMtXTD7QiIroxg492W4LoWg5SqyAb2eTgMh+1waywMS0JZK3jE1gu1S8LNJWoi2apq7kw8T7lmiEKbhB9LYYlIqRhxgWCi22hfPLd8uGPlj4DxicvNZ5Snhi1F+QNRey6GghmT1EHsg+G4qdUnEf5qvePARguiNYyb/vR5SA0LAV68jeVDCRf8fCDmS7Vtc5ccGOTOuxiQfQTWCJk9Vd2KmzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ir4im/HjJs04a0zb2WDmSEdBfqiLWdH3+oOzQMq6Iw=;
 b=UW1LuOCl8U+FFU+EDYGppWm0EdyHaFZEAHU3S9eX1UN5ToZcsXUBDQFX429iG/fcUqX9yXJkJWr7NtzhZkMRlDK8E+mN6x1gpnfsh+sP1wwQybFVKGTjUoTSxoGRznReZ17+qb/l6g5IDn73iDQMBTZiuNWMlmiWUXuR7pUdp5Qb+PG3uA66b1zTI/QHTG4yotLT0dhEyTuRt9yE/E5ic0MZBsNSZX6yaP9Fe+ccCgGYxV+SXQz2WBI/w17f9+17iXuQDGQ0bkIIKBFeaF/UCEetloMj+WU4ksa2FV44+NOUSDVMFlt07iACpRV5zZ87XVc34Zz/rZUxiZo8M8UrRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ir4im/HjJs04a0zb2WDmSEdBfqiLWdH3+oOzQMq6Iw=;
 b=U5O41mk8JiUDcaZyjYPDJ1bRXZFKIKPpsyXwrlagUgdsrvlcy8XaBQPiA4U70WCuHJjCGMi6af16mcRLHoq4pJ9Hzbw+wzsLF8kgu5jFN1cHY0qWm9qH0aVPqgT5OV7+PO4T1E+O8T38v0AcvpA64jHtsajVWJ723R4czfhjdsc=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 05:07:59 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 05:07:59 +0000
Date:   Tue, 8 Sep 2020 22:07:54 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <jakub@cloudflare.com>, <john.fastabend@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v4 1/7] bpf: Allow passing BTF pointers as
 PTR_TO_SOCK_COMMON
Message-ID: <20200909050754.vuxrdxsgi4shfmya@kafai-mbp>
References: <20200907144701.44867-1-lmb@cloudflare.com>
 <20200907144701.44867-2-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907144701.44867-2-lmb@cloudflare.com>
X-ClientProxiedBy: BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:d222) by BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 05:07:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:d222]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 281017ea-b899-4a67-6ad0-08d8547e5249
X-MS-TrafficTypeDiagnostic: BYAPR15MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB32088403ACC11ABC4DF00760D5260@BYAPR15MB3208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1cVWx+tG+30NgUdj44qMSbBiPn3lNfFX0G2JD1sjcQYgrJgDVPpfsVFiA9JC6AcnIS4gwMihrPnCFsv+DAKbNHm9JoEUfzrJMpuff4TCcAQxS2KMPPazJdPKvSH1AFsdQhYenGHkPFfmi2aUzq5fFZZ01Y+KNURrNmiBnJsQmOW3dQD5gM0tBuKmeHp/MxnfIpPkMPJe2JbJXkwRWj31N/gbAfkNhS8Koxk1mUC4G8TYwtAWQ+l1OqU9kKYmYvQKKmD/SYc+eBXMXdyLEIzxH+tsC1y5Smzl/rJR3Ci5TKSZqOQyMjGFAkSlEsTZsU2UYta69/jwueZr34erxU/IzkSUKtxx7wJzAykMspxRwnjhpeZCzyJ2gl8DuJFNqu2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(6916009)(478600001)(6666004)(9686003)(1076003)(8676002)(55016002)(8936002)(186003)(16526019)(83380400001)(5660300002)(52116002)(33716001)(2906002)(86362001)(66946007)(4326008)(6496006)(66556008)(316002)(66476007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7BG9k7vfrXRQ9jFUE13C0rGbAxnC+oIxW1qRDfFc8n6nwggHz8hOrYx8nudwi909hd1sqPD3rmayLfKyb6C18LbjXsSX02At//fjXeosZ9mhaEi7ogqQstuhaegEtTF9GxG0w0yeOrgOQ5U7x1AE2bixaDVjgLr6MfwjcEMQ8fYov6CS13eG3vM9C8Woymb3V7fnX3oXkK8B+uE2TW9Tyir3D+BbzUfjktAiALv3sXiD/6VxyTDLlNMhBAiJUgV4gUM/jsWDGgX2bNgLF0vylUCZYT9pxPHRmTka0lyArFwUGi136WWLG60LqNN6mn8ga/tiqEDs4SLzUlPRy4ow8/F/8ne9giIJtAXzyW9LUqtOgybwL5b0QrK0PWH/Yb7N+nUkqjgxsTLbzm9M/TgYquEV1KrJNcyFI/N34haiatJ3oVKHhljzkmcAu4MJRlRww9wHLk79aJXLJuqPgJiVB373pefxFQOqKMh5QTaWFo95n8fX3U0qa2L5KqrCgcKp/mgQO692SN8IMHJJa1bygiF1l6x50MZNb33rhPhrvZXL9LyWJyVfAb2iD2o2+bZ2Cz+qwVMMlSBlB8KghrYjCNmqCoh1wJBIRfnjhIwy1YcH0WZhbK56aYChAdsimz1rPiqZGbxOHyOe5gqaKxGPo3E1mTxeUaFsPRY1VX9ZSMo=
X-MS-Exchange-CrossTenant-Network-Message-Id: 281017ea-b899-4a67-6ad0-08d8547e5249
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 05:07:59.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs74SWRVzCY9KTcl98hlX3PguslhsOdYrg9Ue9+7EzpUrBbgpsefdUSfrPDjIb3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_02:2020-09-08,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 07, 2020 at 03:46:55PM +0100, Lorenz Bauer wrote:
> Tracing programs can derive struct sock pointers from a variety
> of sources, e.g. a bpf_iter for sk_storage maps receives one as
> part of the context. It's desirable to be able to pass these to
> functions that expect PTR_TO_SOCK_COMMON. For example, it enables us
> to insert such a socket into a sockmap via map_elem_update.
> 
> Note that we can't use struct sock* in cases where a function
> expects PTR_TO_SOCKET: not all struct sock* that a tracing program
> may derive are indeed for a full socket, code must check the
> socket state instead.
> 
> Teach the verifier that a PTR_TO_BTF_ID for a struct sock is
> equivalent to PTR_TO_SOCK_COMMON. There is one hazard here:
> bpf_sk_release also takes a PTR_TO_SOCK_COMMON, but expects it to be
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
> index b4e9c56b8b32..f1f45ce42d60 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3908,6 +3908,9 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +BTF_ID_LIST(btf_sock_common_ids)
> +BTF_ID(struct, sock)
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
>  			  const struct bpf_func_proto *fn)
> @@ -3984,7 +3987,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  	} else if (arg_type == ARG_PTR_TO_SOCK_COMMON) {
>  		expected_type = PTR_TO_SOCK_COMMON;
>  		/* Any sk pointer can be ARG_PTR_TO_SOCK_COMMON */
> -		if (!type_is_sk_pointer(type))
> +		if (!type_is_sk_pointer(type) &&
> +		    type != PTR_TO_BTF_ID)
>  			goto err_type;
>  		if (reg->ref_obj_id) {
>  			if (meta->ref_obj_id) {
> @@ -3995,6 +3999,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			}
>  			meta->ref_obj_id = reg->ref_obj_id;
>  		}
> +		meta->btf_id = btf_sock_common_ids[0];
>  	} else if (arg_type == ARG_PTR_TO_SOCKET ||
>  		   arg_type == ARG_PTR_TO_SOCKET_OR_NULL) {
>  		expected_type = PTR_TO_SOCKET;
> @@ -4004,33 +4009,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  				goto err_type;
>  		}
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
Same comment as in v3.  This is not needed.
