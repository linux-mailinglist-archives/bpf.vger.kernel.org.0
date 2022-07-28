Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195385848BF
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 01:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiG1XkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiG1XkB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 19:40:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAEF79EC7
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 16:40:00 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIAsDx018102;
        Thu, 28 Jul 2022 16:39:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ON/bBVYvGV/pWAwQiQF6kBc8hJRV6GFjBDo/H4m3PlM=;
 b=Rd+NDORDW4abypBDTs6Vxx6mbPS2O+BS0ebqsgk0+ZC0bO7wKOQobWWYyRDjO8xodtVs
 5FxcmG4h7qSs87Wyg26Qi7/S+rKYV4Ylg+jvtfhATZeNufg8nwXyR26bf19m+XwgCJP0
 aNKPIB9hLt31m338WqReKWckYqfzcVKSl2c= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hk3705jq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 16:39:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2pThyKPkq14vCXHLmuSLvhuwtwM9VI9tGXbJXCuX+NSEda1/t+rRPSU+a1QJae/dplpp4a5GeCZYitAYGrddFMDghoZS8u8OopDc3WtnUBKPfbYIIxfz/qi0F/6eSiooA3b3JPlRVeXSs87Omo9yfOitoTxrWN4rSxerEGOKu3iXmce8kdOJrN6k2jE7Smio0idvysSWG8MtjAufUOOgqPmk6r82jnLue0GHiZZbLjk3pZxiaFqUv4cbvyvyvbnGMiASjHZODQbMohY/YvJ7udccLwDeHhRnd7dX/zHV+lJj92t5Dsi6y017ZR9x8EnEIoSZm7LoG11hG3unXiVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON/bBVYvGV/pWAwQiQF6kBc8hJRV6GFjBDo/H4m3PlM=;
 b=OfwrNGSVISEh/R25eagkSscAWqgialedgkV7ohwucygQ0+jikBiUILMEYD1GsNXhs5ecmqd8hZoew8ZIIVD4aqQVe21I9zy4lfkUaU3GDn3Vm04fp9oGhJrBdJ3U3KYlBb7ceiUG0H1NwoKzRtX8UKtNt2qaWn8nW+Ye+lhVHpBCf4HvIv0TcRnMgoIDx7NKyPSpkivieQ3kf49u3f4XwfWX1RSE3SmWvaI8KEe9qV/+exakHSos8C57DxbXWIGZpauCKtQfeeGSHxIHygN7z1sD5PoF67ufDcUg/OydvEx94tJfqyeTqX6xZWj15uD5g1ovswYzAROcG2hLt91ccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MN2PR15MB2655.namprd15.prod.outlook.com (2603:10b6:208:121::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 23:39:43 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::4428:3a1e:4625:3a7a]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::4428:3a1e:4625:3a7a%6]) with mapi id 15.20.5482.010; Thu, 28 Jul 2022
 23:39:43 +0000
Date:   Thu, 28 Jul 2022 16:39:36 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726184706.954822-2-joannelkoong@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873cf07e-d1f7-4f2a-43e3-08da70f27269
X-MS-TrafficTypeDiagnostic: MN2PR15MB2655:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4ZgeKfD9YF67waDXLOuiWw4NgqTa/1tcRQhgYq3IgVdBiGciJfGet29/Rq4qVIAPY8QfytOr1k6OLfxeLSBamq5pwJ7U5NjR4erWgmtR26UzI4paP5V22ettWtEH8VcXkBbnxeRbnOdCYtTOMuN9QFmizdsUAZjVp6YX6cl0ye9RkZH/hMG7qYMOS8i4EoR5ofJM62oIOqBPXLfAs+GGKSSBBa+jSYHR82BppJ6jDwdAbWvxf6B+Qov+jGaUppuCElmcdgF1P1nnCNr13RKn9EO3xobSlxZr+zYwVWmqCepy/OqbEIPraGEDqssF57hpo14DXJsPYSmWt9xGX2TYuJ6qaR5zpHBlOYi1oG2eIok+1hhMZvBnzhjzbNApk8tMaq/xoMoaRgpxM9psgruXVBlDUfaiOUEbgswkvoyy6WUIXARcNWM5XxcyuZs9MoKRxoaC/QL8TrSxYfGjIzHHSO93qJ4Jhjlx3QM/Wwf919eUczid5iywXZBsA2jLahpUH9fti3pXvj8O+MiYgCaLb6Um89eXA52KyD35v+8yRXiTzjXJqJdDMcG+Uz32iIjEZNTsXf6ajmXrn0oAIBwOlA/PB/IiyMNgHEdBgn7J2/1NRP6s8yyg8u2Oymb0FhG4h9L00fhpMU/12hq6XDy7cZMcQmlt0C9l6x73p4oM1DUOAqdqktUVrpqDVCB0ljY9zv5DZj7o6O4h6a8aIfFR34wK212nayGqYzuWwktbL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(8676002)(4326008)(6512007)(38100700002)(9686003)(6506007)(41300700001)(2906002)(66476007)(52116002)(6666004)(5660300002)(83380400001)(8936002)(1076003)(186003)(6486002)(66946007)(66556008)(6916009)(316002)(86362001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?47WhGHljqOujy9+JPVpiqoEfn0alT/6b5YS7QQdD4PIEwTcn8aVoH/qKotfj?=
 =?us-ascii?Q?I52JnZ1ZTbaKXVa7kpkNqn2x13J2nOW/RQCqEdzv6rgVvtWo3kAAZRiVoosQ?=
 =?us-ascii?Q?qXowpm7G9hgzlSApypfLCUegwHjTiTkCNRSwvpViV/4uUNBtkK1JxApRM26a?=
 =?us-ascii?Q?end8C+HYWOxHq193KSI5Wesmebv7dmUO92Ip+8oN0BGzt0wDbIctaJTUPJQg?=
 =?us-ascii?Q?2b9ksVIHbvh6rfLtZLgAh8XiiBMF11Yap7uu49wVJ3tNSQTZRndiNyeZJCsI?=
 =?us-ascii?Q?LNdd709+qZU/H0I6L0jd+sVeSEu5cvUAP8hcALdMoiVNNAiBWyKrvcUIxQ1m?=
 =?us-ascii?Q?xVtpDsarzdbP41qBQE6ZcGUjCxLEEuTL+2m2xVdbmzUCjHGozu/uUhosnFOa?=
 =?us-ascii?Q?fntVez7owZCu+jEfr+oeprO2fKb4THwyloaSg0j66GFc2cDd2RkUsStWMqs5?=
 =?us-ascii?Q?R9o4diKMGcLatQ29oH7zjbPqiGnEXLmlUfdNdk023t66PUNb3Y2Ziu4Ezh0C?=
 =?us-ascii?Q?824n91q+KTBbSADo8Hpj1wtGmy9xrcDYxHXt/Lw/Jo4HHxsnPxeYjtaF9qdd?=
 =?us-ascii?Q?MJoOgF/9/qid052dL08RcsBLuw/rMWozvmhUgzq0Jwf7NHTcUq+ZRzNYkSH/?=
 =?us-ascii?Q?87fZRjDXRSeWtMQqR4IJaWqjsFdBRAV/ibuI9/BAxtiC/bJqQPosEryLvmfK?=
 =?us-ascii?Q?pk9M1F1z7p78RVBGb4TScog4qwk7cHffYVxsys0Y9WQNoQKSIMXzlwJaEFtZ?=
 =?us-ascii?Q?MtxEPVxSylePKIeu5dgMzmFf7uytkGGjuDirPtqYdcCOhuB1Tk/NrkUHxGox?=
 =?us-ascii?Q?mA9jNvJKI7bo9DBN146iNZBSdcYjr8OJbn+RKjXwSFxpeEUXBtvKfAp1T3yQ?=
 =?us-ascii?Q?eE3G/tJLNTTgDUnYOgS0J9x+C6l89jEhMSa6PiyPbOG+6Zybcy3cTtKOjcNN?=
 =?us-ascii?Q?+2AbZF2MSxOWdVo+/wdc/b+LNz1qe2dSo4MqCfg1IH77b+qWdD9aNXy2k5ZV?=
 =?us-ascii?Q?IpSP8rfMUnjqrzaDKfNPJTHV2ceUVCt4k/ZEfhxV2C565Zl1W5hfY9OJoijo?=
 =?us-ascii?Q?3XEjV5N/UKrTqejtFbJLbZ2F77FFMLXHCDp+aeOdbyWRhqV5cMjSXh8ESy6a?=
 =?us-ascii?Q?7z78lWN7rFHLR9uJ/Gepe9K3vNc0zmFpy2gjhQEBbOXPamexeCG8+8QOAaBt?=
 =?us-ascii?Q?pY8eXjXM046tvV3UcYvkfTCJ43lq1gq1/wcq6L1A7flUpl5o0TNbyjKRC8gb?=
 =?us-ascii?Q?m+cclTfF0I++Un6eWzU9JMYMcClnJPRNvO9v7UFr8Te2KbCJp6d7NsOvjzg1?=
 =?us-ascii?Q?Bjsae+X+rXG88lO8f69+IvXuhOkLrG4TBDetFBRIVrWCUxfBR09+MyjZMW3k?=
 =?us-ascii?Q?iz3O8PoBunBKD4t+KpEROdL3D/gpNRRJp1n/n0i3BdJbed/YFbHIJtxz/Uha?=
 =?us-ascii?Q?AmbB7MP5uYJKwUMbIaoNFFRctcHZSgBf5rDxRE88EeyQYZk+2NUTfWJ05kLz?=
 =?us-ascii?Q?ijCWu2hdaiTf+j1fnWP3MPnC1PW+3SCcZjXykwxpd19gnWa3C+oYyjIog+/r?=
 =?us-ascii?Q?ClnI10QwKI6yKLL/emJ2Zx26f0Y14DylHYm43AQb3Av63llkYNl/ftGoZVI+?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873cf07e-d1f7-4f2a-43e3-08da70f27269
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 23:39:43.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6s6WKtEAnrP7DLPH1RkgVwak06stNEhS1cn1kM8Od38b26pgVeRt6nYywXFo1VYL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2655
X-Proofpoint-GUID: pOJgZrxyefJSAcCTJru9hR1rM1nkq7cA
X-Proofpoint-ORIG-GUID: pOJgZrxyefJSAcCTJru9hR1rM1nkq7cA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 26, 2022 at 11:47:04AM -0700, Joanne Koong wrote:
> @@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
>  	if (bpf_dynptr_is_rdonly(ptr))
Is it possible to allow data slice for rdonly dynptr-skb?
and depends on the may_access_direct_pkt_data() check in the verifier.

>  		return 0;
>  
> +	type = bpf_dynptr_get_type(ptr);
> +
> +	if (type == BPF_DYNPTR_TYPE_SKB) {
> +		struct sk_buff *skb = ptr->data;
> +
> +		/* if the data is paged, the caller needs to pull it first */
> +		if (ptr->offset + offset + len > skb->len - skb->data_len)
> +			return 0;
> +
> +		return (unsigned long)(skb->data + ptr->offset + offset);
> +	}
> +
>  	return (unsigned long)(ptr->data + ptr->offset + offset);
>  }

[ ... ]

> -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +static void stack_slot_get_dynptr_info(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +				       struct bpf_call_arg_meta *meta)
>  {
>  	struct bpf_func_state *state = func(env, reg);
>  	int spi = get_spi(reg->off);
>  
> -	return state->stack[spi].spilled_ptr.id;
> +	meta->ref_obj_id = state->stack[spi].spilled_ptr.id;
> +	meta->type = state->stack[spi].spilled_ptr.dynptr.type;
>  }
>  
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> @@ -6052,6 +6057,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  				case DYNPTR_TYPE_RINGBUF:
>  					err_extra = "ringbuf ";
>  					break;
> +				case DYNPTR_TYPE_SKB:
> +					err_extra = "skb ";
> +					break;
>  				default:
>  					break;
>  				}
> @@ -6065,8 +6073,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  					verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
>  					return -EFAULT;
>  				}
> -				/* Find the id of the dynptr we're tracking the reference of */
> -				meta->ref_obj_id = stack_slot_get_id(env, reg);
> +				/* Find the id and the type of the dynptr we're tracking
> +				 * the reference of.
> +				 */
> +				stack_slot_get_dynptr_info(env, reg, meta);
>  			}
>  		}
>  		break;
> @@ -7406,7 +7416,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
>  	} else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
> -		regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> +		if (func_id == BPF_FUNC_dynptr_data &&
> +		    meta.type == BPF_DYNPTR_TYPE_SKB)
> +			regs[BPF_REG_0].type = PTR_TO_PACKET | ret_flag;
> +		else
> +			regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
>  		regs[BPF_REG_0].mem_size = meta.mem_size;
check_packet_access() uses range.
It took me a while to figure range and mem_size is in union.
Mentioning here in case someone has similar question.

>  	} else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
>  		const struct btf_type *t;
> @@ -14132,6 +14146,25 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			goto patch_call_imm;
>  		}
>  
> +		if (insn->imm == BPF_FUNC_dynptr_from_skb) {
> +			if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE))
> +				insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, true);
> +			else
> +				insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, false);
> +			insn_buf[1] = *insn;
> +			cnt = 2;
> +
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta += cnt - 1;
> +			env->prog = new_prog;
> +			prog = new_prog;
> +			insn = new_prog->insnsi + i + delta;
> +			goto patch_call_imm;
> +		}
Have you considered to reject bpf_dynptr_write()
at prog load time?
