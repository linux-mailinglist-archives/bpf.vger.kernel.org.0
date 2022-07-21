Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88957D228
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 19:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiGURCm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 13:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGURCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 13:02:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F72642AD5
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 10:02:40 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LG8cLH019156;
        Thu, 21 Jul 2022 10:02:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tBPkPZktzkqKfaxvBXtL82JUsK+iMEWVKsIg4t5DOlQ=;
 b=jxVOgOCsB3W1i+j3IDjK9iLlAhrekJvirp+qU9PlnemOrnUHQ8PZ+Y9YJBGTqHf0EbCV
 oxa7EbwBkQzm7WFcLWwbRi/okKVpCUAq3qdPwqIsk27BSOsYLhOcU9rt6BFi32X6UEB0
 HHjtBJJggsl32ald869kc2VZFUmDsx7SKnY= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hf6jjsx98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 10:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN7Eb7sVT/tttRy7izO/3I6SwV3Sbo8G11JmdpAts6rRpVrN9XtxRMpG3fK3fIEfnuZ5QjIgtZ1gDSjloEj57M8KDhkQOt4VOQTEEAKBj7BJOw8rSMfRbA38ZikKxXbDp9wwcM7kFJyde8ky0jejAAetgDGk7axkuV1E8Oag5E0n8886pm4CnELBEUZQMJxxXymWar76ROw1Gwigcb+28Kzyd/dXzL7CJT6BmEojczhpusFfsnsXCaf79QQDH33pU+PZn2h3qDgTVQbJz8Ww7wtDzsLsELvTRO9yJGrGQfJtGG+OwLTpyFPtpMqUNgr9XMQLNv1dw7e9E5qusa/cLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBPkPZktzkqKfaxvBXtL82JUsK+iMEWVKsIg4t5DOlQ=;
 b=VBdtnfKmyIZGo8bpVjGcOhbEF5KVfoLH8Tb+IygDSeBW8IscEQg1592otRzyCq3l9nRycFLfkuL/i1PG7ZPxuGwvWxHCYI3Qiw3ZDYVFEGXGIjiwtm1fIkSuH1BjBfl2nwpxki3gUasfsLpp+6YvWkkLhWNfm+S8x/v7lXnIDbwgokIIJvkvGi8gvgPumPwLEyKMJXlx1qGWVjnYVPQBbgbUyeLxt7t4lqx9BAY93csaGSpAS9REYCaCOi3B13H3dftY8kOEvWE/WyCOK0t7wbbdOz9rcGB17B98GxcZM3+NeNzww5O1YjJIqw4QAqGut78aS0kQgn3PcNMUa7nOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB2549.namprd15.prod.outlook.com (2603:10b6:a03:15c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 17:02:23 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%9]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 17:02:22 +0000
Date:   Thu, 21 Jul 2022 10:02:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
Message-ID: <20220721170221.jlcvzcxfyrnrmyyc@kafai-mbp.dhcp.thefacebook.com>
References: <20220721024821.251231-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721024821.251231-1-joannelkoong@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0da01e2d-7242-48ce-f3e2-08da6b3ac79b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2549:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yhb3CLw6RTnr7GTEkAEZych91JQb0KeJcaA3ayrK8+OXqL7AlbR0p96uKhVjVtdpVz4pTI3GwzW2RgHk05ce3P040eth7dCoePv7A+YsD+gkJZquAbH/S1fPcGJBWkrS8GDSQQvCqPQVf7Zq51X0GfKfH3Ic80moM22QFAUpw+sEidVk1HTWMSOxBNfQ7qvqYjer3aulc4ptsitxIqhWGRR97XH2Wq8mXqiqI3wkm2aGdAYR3B9fpzea1aPDmd3bDjisxKsIxhF/kW8mzsCvcnkkqF45knGJJFiS9Vq39wLFNua8hdzBx1pzSmkP/HJjjt/erxXpElnyPeYpSuvHGYv4ZuQG+2s591LM6UDQHpjmf+lVTmZorcdf8TX2lgyt97OiaT/tDpj8kDpkvELJqIg4vXoFYEyRNVUTYKFCI6/ulDT43Jps9x2M7a+U78HWsnGeuKdZFqLGdHdH5ycO9JyQ13DsEFHsO3DhpdDnExX4C6GUj9O9AYuZG7wosUZODbkLL5p835ndcf46uhBm978Rm93tQcG3yvVSTuX6PgsjaEpJzj3H37xgdSdajKzArhZ5b8nC5eAsWxR1uJnTRGZrKGGVXswBdTZL2tVSAMP+FPWnACxutc9eFVH9Av22FR75xLMfCmvJpY3z/IRxPToFF5248SGau+vdAGWd17GQSOy7aqJ9Wx2eKrbwRosmv6Zl/Luy9veWKOcu0DUvwOQqi/b7PleDduoQtnzzeGg7hQPQlGgAKy3ngOJr/Toe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(316002)(6916009)(83380400001)(66476007)(66556008)(8676002)(38100700002)(66946007)(4326008)(186003)(478600001)(5660300002)(6512007)(9686003)(6486002)(8936002)(41300700001)(2906002)(3716004)(6506007)(1076003)(52116002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whPLWnWQdvDQRBNhRj0PH7QydRcGwZOWDTMKjWPg4jPgIFVVGBTbWNl/xtQe?=
 =?us-ascii?Q?/XKGb5BeC4u1/93LFD4nzFitARw9gDgsMyGPSIRecnCfUoDCs/4nrN+eG3ck?=
 =?us-ascii?Q?8vOm5nxRrY0sWAq/o5Uh2yM/EZ6su1IiEd1VQFi+D9sasb4t4LsERCZOIuP0?=
 =?us-ascii?Q?6SOZzM+NzdGHjJQlIFlwWrqXY/kwa0kojCa9ytW+D1b8qY6gzmLfQV13WtpX?=
 =?us-ascii?Q?IQ09dvhnE11GL7688eariojfajle1uu6h62Mh//dKrCmw4Fy5aDrgJXl/GXu?=
 =?us-ascii?Q?DfOMu1zPJsdTvIeLlhQ0spM7KHWV7ftebeDweJp+U+brSFfzjryfRKVocTZp?=
 =?us-ascii?Q?ONUaurOxLiJocFoyAQI/bCmEpQsyuS52rUwy8rVjDw8Lj4jqkUyTWj+LXIP1?=
 =?us-ascii?Q?7kkh7OMoFdhnOWVZEE2kVgPlVGkNcQE0TGG5PynUI7e6/catnbjRl/MZs3nX?=
 =?us-ascii?Q?W+O2wCVFjTuR+AYzf45X5G0jl7Mb4gJntGIs8lZstVq+FVpjSu6bA08dLVze?=
 =?us-ascii?Q?TkJt3sjBqc1iTlomP5U3BvDheyam52dD7j169X5E17ZojcMSvRWRCgXH2sYG?=
 =?us-ascii?Q?lcdJxWtOdhir0DUFBbmjtViAk4vBw6UEKlj3dZpJqP6uD07K9ty6jWtiMHI5?=
 =?us-ascii?Q?Vjr6VgvXZ6S67B4nFh1W1MUcGD4s98KLnh6KBqmS7YBhbqhl0rJ6eXWnCEfB?=
 =?us-ascii?Q?EVvK1QXQItDOHUrl+Wm90z4LKJfPjLW8iffbvf0/AAzwAIA/9jzjmBaMQesd?=
 =?us-ascii?Q?d34rE3iWUZxjqzdg8BOXahIHDNSwfY/A0Nor1DLdrW+e/x6NsYns/wRHrVwN?=
 =?us-ascii?Q?mUo+2cLkLp+/xq+i15Nuu1Ibe6U90UQpEocjFj08fr/wPf7JXiYHUosE128W?=
 =?us-ascii?Q?fQnEglvF1Q1xjcogGDmL1n6DmLrUAe9/4fzSEDo7PaItGwi/VNunDKonKq1K?=
 =?us-ascii?Q?rV7sTOhnzTbPNOc6Cv99xsd1wbI1jewFwwzry1yTjXKQgQN6ZsK5w5stutWc?=
 =?us-ascii?Q?CIFB7jOlvJYUccmbQtOGmm6Pm+AWgPKdlzFX+8/t2TrnFAsCIQeHV2iwEflV?=
 =?us-ascii?Q?l8ICwBEeiEexyFWloUZPY7ASOLo7cysswJCzDzwOreTvTOBGdkgNV+0TCv/S?=
 =?us-ascii?Q?uBIVw7jDeP0KxME5xiboEo+jKQAJdkOM/MR+3AblksWHCNiOu/XFyS+eqWDJ?=
 =?us-ascii?Q?x0Q1wHoPLG8Sb8DQCnKAnddaYGOWU3PWPUFj6be28ociwXWvszUd83vn2ZgK?=
 =?us-ascii?Q?d4bBgps877lSQue0n7UqrkqjlvLAhFTH+RIhgtm/5Lw22eaS9ltPVXbxjawG?=
 =?us-ascii?Q?fbdc8bUOMuPG2loJNG1KoGFB/J0M63aY+raXOwKWqvBDx7UWgONYtb7aPgc4?=
 =?us-ascii?Q?LCFOGIFXZbMZN+AYWlAVIe5JoAX0Uz2ffss6ND3VL10zL7BvZfDNwaUyd4gK?=
 =?us-ascii?Q?obzIgW7vy5+iOCVqfOFvYdbbRTPcdM+PGPgsHYitcaI3NrYrWYBiEFCBJmLW?=
 =?us-ascii?Q?xCRAt8Vcw4lLvyP5Gt+54cy0q4g5kpv83nXveK6FM/6l/8DoxMYb0aFsnKbS?=
 =?us-ascii?Q?eRCQKlFKqFzG0sx2wWK59npsqMoUsRGmvcyIJ3L5vcyfRNKIh/Qf1138AL2Y?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da01e2d-7242-48ce-f3e2-08da6b3ac79b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 17:02:22.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noESk9k9lXRMIEc6zYCrthTk3oistc2jE77tMp/hkGNsq0uHdNXeuIzNf6RfWi6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2549
X-Proofpoint-GUID: _69WEEQW2zE5vlOOqF7fiNKD4UB2xnT5
X-Proofpoint-ORIG-GUID: _69WEEQW2zE5vlOOqF7fiNKD4UB2xnT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_23,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 07:48:20PM -0700, Joanne Koong wrote:
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
> Fixes: 34d4ef5775f7("bpf: Add dynptr data slices");
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/verifier.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c59c3df0fea6..00f9b5a77734 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7341,6 +7341,22 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			}
>  		}
>  		break;
> +	case BPF_FUNC_dynptr_data:
> +		/* Find the id of the dynptr we're tracking the reference of.
> +		 * We must do this before we reset caller saved regs.
> +		 *
> +		 * Please note as well that meta.ref_obj_id after the check_func_arg() calls doesn't
> +		 * already contain the dynptr ref obj id, since dynptrs are stored on the stack.
> +		 */
> +		for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> +			if (arg_type_is_dynptr(fn->arg_type[i])) {
> +				if (meta.ref_obj_id) {
> +					verbose(env, "verifier internal error: multiple refcounted args in func\n");
> +					return -EFAULT;
> +				}
> +				meta.ref_obj_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
check_func_arg() is setting meta->ref_obj_id for each arg.
Can this meta.ref_obj_id assignment be done in check_func_arg()
instead of looping all args again here.

> +			}
> +		}
>  	}
>  
>  	if (err)
> @@ -7470,20 +7486,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		/* For release_reference() */
>  		regs[BPF_REG_0].ref_obj_id = id;
>  	} else if (func_id == BPF_FUNC_dynptr_data) {
> -		int dynptr_id = 0, i;
> -
> -		/* Find the id of the dynptr we're acquiring a reference to */
> -		for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> -			if (arg_type_is_dynptr(fn->arg_type[i])) {
> -				if (dynptr_id) {
> -					verbose(env, "verifier internal error: multiple dynptr args in func\n");
> -					return -EFAULT;
> -				}
> -				dynptr_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> -			}
> -		}
>  		/* For release_reference() */
> -		regs[BPF_REG_0].ref_obj_id = dynptr_id;
> +		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
nit. This will be the same as the earlier is_ptr_cast_function().
Merge the if statements ?

>  	}
>  
>  	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
> -- 
> 2.30.2
> 
