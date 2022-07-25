Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA158044B
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 21:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiGYTKy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 15:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiGYTKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 15:10:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A704DF79
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 12:10:45 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PI5Y4r009407;
        Mon, 25 Jul 2022 12:10:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=l+MdJk++g4vijobE6PHIQR+i+kF2gYYPmVoi+r3VUPc=;
 b=S7swgn7rMuEqmHPEMqavrtfmMaFSa9t5sXgK0lfGdv0ECtXVWYH5NWkdXmV1n2ZJfyjU
 NhY/ShJ2QDaUMybithYo6lrTGwf2gM4IhmfJ+Oh71+7vbqO4C4SAp8ccLQd1eHrvyhoc
 ge4WfxkHlZ6fw0uYWubKedk8z7pPpx7DUfw= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hge3qkb46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 12:10:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPT5+adgjTfKZQVVNwKz0lS/tNJxetcBPGWiCJVZg6/T5HqDFDYfd69Y2S0IpnBIcYVeOvM41ydlPjC5N7/4PnUPV1UvVvLsQiGzXSkunQ+jx2hyno+Ggo9mlV7u0fcZnzv2g6801KvHTtEUPbtiCwxqLpGgEkbJVUr2ouNX8STI9rk56MmdYFmVv3MyrPBUPb+p/SN24/CERtRBx/s1vA1umGYJIeurbU7d4XCalsa/cpTbHN6w36VhPGemIBh1Z/L9l+UdYZewqQax54gXv0kRSGlWP+GhK3QKcEwCpOsIDTqLX2nv5p1QW92bI66v7cp9jAeDT+W7RflTBf0qVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+MdJk++g4vijobE6PHIQR+i+kF2gYYPmVoi+r3VUPc=;
 b=AtRlLXPYAgk45qRRi+b00DViXtGA3TF9KxWrZDOPV4WwQPuuAJWrapzooGvlcWEv/BzqnAfGcihAKdOTy4FV0P6IxDnuzO62kFDavNKJYdMdKykgpw0ZgwHfCuhrRwhnE18eb5Tx0/KKVlREeL6x6grqB8hX5f23vFO4m0Yu4hjYiiGgTL+TxwabYzO7hGBiA21KKVGjHurOU1RQV+VHWct7npWQb1GxdCILfv5h+TZ+ITUkQYQhS+Nn8XLSbzf/S2kgcq1X1xX4gOFBEkqnLgWZQe8HJr66OzBArXjQuMw2Gbx0qRJ2zM/KVXmnFWzbtmHkWVVQg5/F8eI3K1aibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by CY4PR15MB1606.namprd15.prod.outlook.com (2603:10b6:903:13a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 19:10:27 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 19:10:27 +0000
Date:   Mon, 25 Jul 2022 12:10:23 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, jolsa@kernel.org, haoluo@google.com,
        andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
Message-ID: <20220725191023.qxfna7whgllffekt@kafai-mbp.dhcp.thefacebook.com>
References: <20220722175807.4038317-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722175807.4038317-1-joannelkoong@gmail.com>
X-ClientProxiedBy: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 781e4885-e310-4248-340b-08da6e715551
X-MS-TrafficTypeDiagnostic: CY4PR15MB1606:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbXZ32vQyrkJCmek2nEQ/pfxhDv1ZNyEWwJlaSvpTZ5hMofS8CZa9nW4MWmzvtUcFIdUf9IvRL1iLM0UFkvtRXi78JDyt9llgXl+49IegbeYmFP5k2n+aCnPTgcEMP0oEAqiUUaBZ3mX2GsfIyxBhmyNurHqGmWF0qwUd63opphxV7mKwf21TuE7EtrjcrTSMiG9kGiMsIkw7nmcUjsWQrGGM8U6pTKTby3/lbbLEHav44BtW4koQeIXlxLCBI7jOcTz1qzmoMHz+EFvUDSu0sbBzvP0LwDCBxWurBiakVq5ZEKSjFb3bCYpX7GLpv42NqPb8pD6V94o++Lt8CD+b4zBC438IrFeRiTm3ZAj47LOb3u1VYgVW7focKT5vekyTNv0D3/BuMf3eyFlqR1C6t8KSIykEmSFqwrOw395oV4TcP01Oprc7VLbVzDFzUgyG7nccH9LXeI4+ZJ/u8x0ETB7tYLx/3RjpDp90scvfw+15DbXz3p8rYbk8z+3ZOHwiOQU1HOAopwCbmdexCFzhm3qArai3zmrZerx/ZOE5gQTmO8jxh/tMgcKH6WjNiHnsjLe63Dy6oht6k8WZFqXEEOYh3m3b3idqBa1xpPV0bb1cWLeeW0QrZkbXoyttFmfslcg4Rpuc9TPkXg+9nMmSGt6NsqH6BKavpgIJGALn3YegoFvEO5U7NrYvqhNj88lfZa8m4HNeojnStFsSNT/9j3cd4dS+kSgowBgAR6csy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(86362001)(8936002)(52116002)(9686003)(1076003)(83380400001)(186003)(6512007)(6506007)(41300700001)(316002)(6916009)(6486002)(8676002)(5660300002)(38100700002)(66946007)(4326008)(66556008)(66476007)(478600001)(6666004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hbh1oXid3VIryZW5wJhHBUs5UvqyVz8qOv/O45eRF0Zq8fJUM/0/PWQ7aelT?=
 =?us-ascii?Q?5M60UuEaUApyT791T3p0xx2Ll47k82c7ssCZ78NHVHvTwe/Y9HOH6sUjvdQm?=
 =?us-ascii?Q?XBLBNu7j9QT6ZpvhvJCPqhoFk6p1oeMup/UNcnLerKpEGt9+LAwNfnmviR8C?=
 =?us-ascii?Q?0RGgFDI1qy/e/cGogOrGtcOSQQWT+tfi4Lo1AdF086nZe3/QY7WU6i4OOKmF?=
 =?us-ascii?Q?SQoVSz0vf0/GcLQ+ymB+/XIZi/FEEwz1KkLDse5MTf40ssxKNTdjf/cDdLty?=
 =?us-ascii?Q?Em8s6/CP5PrgSaq/LjE+Zwe5PIyiGIQci6tcuJ3c3a8txpfjMwrBXr7FzPBS?=
 =?us-ascii?Q?Zns838VbuOW1zdRZIIgnHzjI5P2S8f5D6xCmj7Cyb+fU/iG/jbUsObASfG+Q?=
 =?us-ascii?Q?KkNKi+sATrNtKwadi/9X0DJCfSGYF2D3Ry50N8as/9N/PitGzi0j5CF3Gw9r?=
 =?us-ascii?Q?x6e7BsPRCA98re5LTCQYdmU6iCR5QC/RaRSgmXLubrSCCdYGjmlq0OoaOFYy?=
 =?us-ascii?Q?Fzk7/YR0znEcSCQnqMyWnBG6bCE0baujYqVg7H6P4II02iiFdgXHAX0ttglS?=
 =?us-ascii?Q?vYRE8BO8jKf4Q/O8aF7OgDJonsN88eQO7bIujqNVeTWtzPl7TaJ0+oY5Otbx?=
 =?us-ascii?Q?iEHu/x8leqBxxAlfjnNBnziZKmP5ln1PezcanKQUhfpTPykA/h7TNCkUy000?=
 =?us-ascii?Q?gRwimiGvTwrkcZF7lbjgF6MayTS2f2udcvlfjV6emkpmUEUgy3q5L8UqccqN?=
 =?us-ascii?Q?uNdBYWJGmod2GMo4bo07zIuwpm8/x3LQI4eQVwHAlFPy75YbnrusD9vIc05Q?=
 =?us-ascii?Q?gAf7U4Rh9VSC9toy1jRTn3IdDjBA2nl5JEMVMlyL9A8YCCgUVsMOXLO+yzGq?=
 =?us-ascii?Q?vbpq4k1U9TKOUyKlnRELiOiPjzF52orxM95TKsyJ4KMEa4rvReOU6NHSJXQl?=
 =?us-ascii?Q?uCrptr4kiTKXIi6OUK970KEAh2XQvOLdueQBEPz6kAMZkxzlFjEJPW++dGFw?=
 =?us-ascii?Q?VqTvlME9OFL82BzCkwzdq+um29ev7sVFaJPDI/I+Bu4uD4Kd8Sf7u0fwhDBI?=
 =?us-ascii?Q?fwdkSQa6oC41zj3mHFqepx0TonAOyJ3aaM9d7UPoXLBXaq9oOIvkYjW1Z3qW?=
 =?us-ascii?Q?nXMTIHmuw8fAWRVdiZb5Z4vAbjWdxt8dvoITjvftxZNLZYVsL308hw3CWqrl?=
 =?us-ascii?Q?TXuedfxVvdMqVLpuPduB/LPvlsEvDID9J0pGphDcCWvjIuwLMB/8pnO6VLem?=
 =?us-ascii?Q?vwrwlGPnrOq0MGG2tGabRGSxqGlOIh9Iivx4Tztfc50Lq67hFnt1V1aduLf8?=
 =?us-ascii?Q?2q0kgYGrNhVDDnUGExbDorNRScnp32Dqm6ngY+lAMa5NGP6YWg+SQXLuM20T?=
 =?us-ascii?Q?IZzV4dvPSoKoKDz/1dJz71DkPBxZyHPT6tPghWI+xDWG0fa019OE+SUM1NDO?=
 =?us-ascii?Q?MZ36VYBTAE1hXAR/5nPlPx4riybYzGy3+q9sunrx5QBSDjsFNQKSkEooE8BU?=
 =?us-ascii?Q?MAuD7IsVI6Tubz+ykwr9BpcaGb1BijbQKLPunZT+MHlaG39X7mNf4heVZpI7?=
 =?us-ascii?Q?+o9QR0jwMBU5i0khtE+IfiXwb26NXxIWyQcJenqI82gVdbPYnwqS+V2OiZwn?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781e4885-e310-4248-340b-08da6e715551
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 19:10:27.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/ajagPYZY4hlsSY76zWYPrWIcuegUGxlmbGIRRQ1J7b3E1/PYqHkCkF8fo6E3GD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1606
X-Proofpoint-GUID: J7QAASxjtHy3o-6oxpS0lfE8nBVqFCv8
X-Proofpoint-ORIG-GUID: J7QAASxjtHy3o-6oxpS0lfE8nBVqFCv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 10:58:06AM -0700, Joanne Koong wrote:
> When a data slice is obtained from a dynptr (through the bpf_dynptr_data API),
> the ref obj id of the dynptr must be found and then associated with the data
> slice.
> 
> The ref obj id of the dynptr must be found *before* the caller saved regs are
> reset. Without this fix, the ref obj id tracking is not correct for
> dynptrs that are at an offset from the frame pointer.
> 
> Please also note that the data slice's ref obj id must be assigned after the
> ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
> zero-marked.
> 
> Fixes: 34d4ef5775f776ec4b0d53a02d588bf3195cada6 ("bpf: Add dynptr data slices");
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/verifier.c | 62 ++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c59c3df0fea6..29987b2ea26f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5830,7 +5830,8 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
>  
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
> -			  const struct bpf_func_proto *fn)
> +			  const struct bpf_func_proto *fn,
> +			  int func_id)
>  {
>  	u32 regno = BPF_REG_1 + arg;
>  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> @@ -6040,23 +6041,33 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			}
>  
>  			meta->uninit_dynptr_regno = regno;
> -		} else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> -			const char *err_extra = "";
> +		} else {
> +			if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> +				const char *err_extra = "";
>  
> -			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> -			case DYNPTR_TYPE_LOCAL:
> -				err_extra = "local ";
> -				break;
> -			case DYNPTR_TYPE_RINGBUF:
> -				err_extra = "ringbuf ";
> -				break;
> -			default:
> -				break;
> -			}
> +				switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> +				case DYNPTR_TYPE_LOCAL:
> +					err_extra = "local ";
> +					break;
> +				case DYNPTR_TYPE_RINGBUF:
> +					err_extra = "ringbuf ";
> +					break;
> +				default:
> +					break;
> +				}
>  
> -			verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> -				err_extra, arg + 1);
> -			return -EINVAL;
> +				verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> +					err_extra, arg + 1);
> +				return -EINVAL;
> +			}
> +			if (func_id == BPF_FUNC_dynptr_data) {
> +				if (meta->ref_obj_id) {
> +					verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
If 'func_id == BPF_FUNC_dynptr_data' is not checked first,
this verbose (or the earlier one in the 'if (reg->ref_obj_id) {...}')
may be hit for the bpf_dynptr_write helper?

Overall lgtm.

Acked-by: Martin KaFai Lau <kafai@fb.com>


> +					return -EFAULT;
> +				}
> +				/* Find the id of the dynptr we're tracking the reference of */
> +				meta->ref_obj_id = stack_slot_get_id(env, reg);
> +			}
>  		}
>  		break;
>  	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
> @@ -7227,7 +7238,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	meta.func_id = func_id;
>  	/* check args */
>  	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> -		err = check_func_arg(env, i, &meta, fn);
> +		err = check_func_arg(env, i, &meta, fn, func_id);
>  		if (err)
>  			return err;
>  	}
> @@ -7457,7 +7468,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	if (type_may_be_null(regs[BPF_REG_0].type))
>  		regs[BPF_REG_0].id = ++env->id_gen;
>  
> -	if (is_ptr_cast_function(func_id)) {
> +	if (is_ptr_cast_function(func_id) || func_id == BPF_FUNC_dynptr_data) {
>  		/* For release_reference() */
>  		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
>  	} else if (is_acquire_function(func_id, meta.map_ptr)) {
