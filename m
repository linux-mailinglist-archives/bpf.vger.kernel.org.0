Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8678F3236FF
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 06:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhBXFtA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 00:49:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36760 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230482AbhBXFs7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 00:48:59 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11O5aQd9002762;
        Tue, 23 Feb 2021 21:48:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=IllFefxTNkIn4bGPt0Xe+zleaxAu5RIKIO9swHDp6Xw=;
 b=SUBjVBl62Sp0TXkb+TQaRXjxW6ul40/LL6hZy/suGeduxjYre0oS1UxcEBA0bKFJMtLk
 QsmyMaTjGT1+yPL2HC9qK8Hv2YHwKf8t6ZgbMHbyBRphm2HfhdXkXRpPoxEJHU+wO5HV
 Hy7gGe4hquCNNtgXcpsOJBFzXL1moIKQP1M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36u0342wmp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 21:48:02 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 21:48:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koYF7nYd/EBdkw3eq045FcAercDcnqNPJiqY639mmne3VRZQuXxvlRapVFCgcj8KAdRR5unUa9hla87kHh4gxSGbBicLZF6ckXgCKi5IPGG9ccdX7cuvS+KuDBFfYfDNgsjmogoiCxmRBmj1BMyK9iscGs7Zjci/snZ9+wPqHxS6amEhzEn028PgM3B8keoZHVRAqBJTTGnsuGIxrs+XWv1Zm36yOWGKSBUwtaoiGdvuCMIYNTL12/CvupIaqIqz+G0iYt9a3aneScnJyTqJmuQFXg6tOqhjUhpLIyR33zdDabH5DaSFGN8MztMe1MTh4RliNVUyenq12GE50OgHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IllFefxTNkIn4bGPt0Xe+zleaxAu5RIKIO9swHDp6Xw=;
 b=AHfIu8oake9hGU+fVAjeGqERYhA71yXiJLFhHrFImgzRLb/JjbFFVHjH9V5na4mkcBqkNpPjJ4nIUXrDjoxtq7cO4Gt9O808lvZbFCUVZrhmhvSXim37FwckkcVogQyX4EpbHK/VfsusIYxirIvhtdtXy+lJR/peW5x4SYjH6MWkyDEdx00ZdvDCVNuapOVu8kgnQTCiqO7tjmiFSoanovTocYcBgupjxm8D3k7VFicHORs0CseuFXwPa1gzAPlnCTLlbLpGf9zhUmjTWP8LfZ7gewZbpUiTWqo0SPvXZWYNWqIsKAW4ofHz7ohV3xqO7GcQE9nK8vb190FQ38N9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2200.namprd15.prod.outlook.com (2603:10b6:a02:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 05:48:00 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3868.032; Wed, 24 Feb 2021
 05:48:00 +0000
Date:   Tue, 23 Feb 2021 21:47:57 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
Message-ID: <20210224054757.3b3zfzng2pvqhbf5@kafai-mbp.dhcp.thefacebook.com>
References: <20210223150845.1857620-1-jackmanb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210223150845.1857620-1-jackmanb@google.com>
X-Originating-IP: [2620:10d:c090:400::5:8db3]
X-ClientProxiedBy: MW4PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:303:69::22) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:8db3) by MW4PR04CA0017.namprd04.prod.outlook.com (2603:10b6:303:69::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Wed, 24 Feb 2021 05:47:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5c47e78-976d-4630-5e07-08d8d887bead
X-MS-TrafficTypeDiagnostic: BYAPR15MB2200:
X-Microsoft-Antispam-PRVS: <BYAPR15MB220077B66F2EA6D60AF7CE29D59F9@BYAPR15MB2200.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HxFzjcdnwnP46aIzeuGhqlwV5OkpZOSnPvPOXaWlk2CvCI9OubMAZeqiAhxCS8LXr+qhkKPUASBBdOAXCJRdRH4vxFg8S71Kpjm2kOZqK0MiM9nejEIBe20NAzHiec5TfHFU1utz6C4hHRyYYkBH+/pLIFkRsz9oQWKjvemoxHTxKBfoonWYewXb1LbicDJS6covTpUZMUCkymQ3YpscylHIIExxQzTif9tG3ZZLebyFEDw68p7iOLqMiNtNhV8QRTxxOJv05FHKKtVR43KqE7/GeWox2TjIS6AwVbC+HRIJ7xaKoER5htEVDXJbzxShx0U59CJjfk6627YkbNva3+YVnosSaW/L6J3h63q4MjekxhKazVbjsm4b9ziAipOVo8evDOOFaRePaTr8UBabjXiAzVxn/eRMHGpvB6ZYgYqTioJuUm6yJHR95Ng8Z0dyFZS69JMrlwdxLqew83Pk/71xVSXr1dzejZAJHC5uogUyINuERum/wdrgMK4D3xHau3ayWmMtDUXekwf8qgf3OV5HlVvys83CACJoPCBG0aiUNACPDxRhgugqoQs/PGF8fitKzANLgoGXpwp/Q0AsjyeXlh1D0AlnlFi1ZfspMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(366004)(136003)(66476007)(66946007)(66556008)(186003)(83380400001)(5660300002)(16526019)(316002)(6506007)(1076003)(54906003)(55016002)(8936002)(2906002)(8676002)(4326008)(86362001)(52116002)(7696005)(9686003)(6916009)(478600001)(17423001)(156123004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UdiNx2UtpZSUE9EiXtE+0wmmSw7gbzCDwtORO89ut0ztkCKeqSqa78QpxSux?=
 =?us-ascii?Q?9vpzriqNpO6o+JU5TZEBmXN7xXRkbpvufWDOuDDDQKwvk/oXEVCbXdsLddpD?=
 =?us-ascii?Q?8biOS7VrN7mAB7C1iDqBujaM9gbHP72lLqxW2nkoTpHkMPPPAPK3fRftoJSG?=
 =?us-ascii?Q?v6wDoRRQpi32KxEB3M70upHrx+FvJ6LvgKvVHPVaiAZgUCL76lIC6GkjDFxZ?=
 =?us-ascii?Q?QCMGkydgd6XSW7YuO9Fx92RIAYIeRA0f/VRifX/humgrb0EJ6txDEGyyKu8F?=
 =?us-ascii?Q?+I2SkqEBMqtDDPjyZUrwv55zfnKNQrfijtrPqmUrf71pAgKE2lCRUydD6YGO?=
 =?us-ascii?Q?OY3y0Sam8zlgMA9CNfebRP9yWXEdDwj5ocxZVoxo6cGPP3pniJof1ypxCgK4?=
 =?us-ascii?Q?EunfUsxydPL1Hn9s0IFRi0eJfyi1xa50YVRVjTDcJIyx0EEvQbY0ZqppduRm?=
 =?us-ascii?Q?SoWmWYlKohkNgHspMUrheTIo/RWWY4UQiIzSYp2X6fP0o6QIDFgnCSV65Xj3?=
 =?us-ascii?Q?mJHu/3Q98IgvfoqSNrPsJRTGgL18m8C5K5pBLKyBQboIwpWDhOOHHonomzqj?=
 =?us-ascii?Q?ixRYrANxXJoHZewKJiLnbaUCYLI78pc7zM0cbPOcrL2GRjjUkXiHGAO1gEIk?=
 =?us-ascii?Q?DFE3iQgz1/2wl/Dd+SjuBWZi0VjzYIa2DF1qmdC1o/tKAK68lj6DDq86Wxxj?=
 =?us-ascii?Q?s2e/0pzfmSJ32Fp13BwjdQzw+omU7+b4x+p4X+3sHiISteVwMLiMGYad9UHj?=
 =?us-ascii?Q?irx9/wItiQLwOHAeSGcRr429n/WX7OTHe9LbpHgBHC1wLrN0MbSoOWl4JoPY?=
 =?us-ascii?Q?dRFlL/zhE5A3HMYwbhbTrkRmaiaTkLVpaHPPVXpDf6uliaaD396c+gocC5Hi?=
 =?us-ascii?Q?Itb4dLhgjgYn2+SpR7uZsw21mzNbiNi+key6JaRqGW8kf39UFIbiNR84jKO6?=
 =?us-ascii?Q?YF7imeixiJEaEjheKYaYJpiN6iltCwk8SZM0sUaWbr0u/WiS5mg1YScwuJv7?=
 =?us-ascii?Q?aGUJDGuVbmlgVxKprLWEeJhUQNG6YzxzLUDftFQwQ6q4SKwhSOXiS3YIjAO7?=
 =?us-ascii?Q?FJYKfEYOUUAWY+VswkJecfuvTOYRWHe2hY1owF6QqCf91nU69STlkWTb6MaF?=
 =?us-ascii?Q?bIH7i9sw/Ey4BWcr1jTIJvx+bej7BVfzEH3q9zQKXAucSwehD57d/pHp+cdd?=
 =?us-ascii?Q?L98lABwGjs5fpDy1IaJjXkOyD5EfFhVZhp266Lnzcgw4giUx0bQqQDc7SoAg?=
 =?us-ascii?Q?Gbi4PQiR9cWGsDgjJI2sjZN7BVT6eJRvBNz20/+sPCsv7fi36jWx5QKvwyOk?=
 =?us-ascii?Q?XljkiqN6IAd0BWaDMOEFTupNk53YWreX4CYKco1IjRT+Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c47e78-976d-4630-5e07-08d8d887bead
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 05:48:00.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYXBXIB+vsnVZjwj638UVCS8bi3a+uuZ+t1Fwi7lyukNLNKO5azuuml2ZaosNbWm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_01:2021-02-23,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102240046
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 23, 2021 at 03:08:45PM +0000, Brendan Jackman wrote:
[ ... ]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0ae015ad1e05..dcf18612841b 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2342,6 +2342,10 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
>  /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
>   * analysis code and wants explicit zero extension inserted by verifier.
>   * Otherwise, return FALSE.
> + *
> + * The verifier inserts an explicit zero extension after BPF_CMPXCHGs even if
> + * you don't override this. JITs that don't want these extra insns can detect
> + * them using insn_is_zext.
>   */
>  bool __weak bpf_jit_needs_zext(void)
>  {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3d34ba492d46..ec1cbd565140 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11061,8 +11061,16 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  			 */
>  			if (WARN_ON(!(insn.imm & BPF_FETCH)))
>  				return -EINVAL;
> -			load_reg = insn.imm == BPF_CMPXCHG ? BPF_REG_0
> -							   : insn.src_reg;
> +			/* There should already be a zero-extension inserted after BPF_CMPXCHG. */
> +			if (insn.imm == BPF_CMPXCHG) {
> +				struct bpf_insn *next = &insns[adj_idx + 1];
> +
> +				if (WARN_ON(!insn_is_zext(next) || next->dst_reg != insn.src_reg))
> +					return -EINVAL;
> +				continue;
This is to avoid zext_patch again for the JITs with
bpf_jit_needs_zext() == true.

IIUC, at this point, aux[adj_idx].zext_dst == true which
means that the check_atomic() has already marked the
reg0->subreg_def properly.

> +			}
> +
> +			load_reg = insn.src_reg;
>  		} else {
>  			load_reg = insn.dst_reg;
>  		}
> @@ -11666,6 +11674,27 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>  			continue;
>  		}
> 
> +		/* BPF_CMPXCHG always loads a value into R0, therefore always
> +		 * zero-extends. However some archs' equivalent instruction only
> +		 * does this load when the comparison is successful. So here we
> +		 * add a BPF_ZEXT_REG after every 32-bit CMPXCHG, so that such
> +		 * archs' JITs don't need to deal with the issue. Archs that
> +		 * don't face this issue may use insn_is_zext to detect and skip
> +		 * the added instruction.
> +		 */
> +		if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) && insn->imm == BPF_CMPXCHG) {
> +			struct bpf_insn zext_patch[2] = { *insn, BPF_ZEXT_REG(BPF_REG_0) };
Then should this zext_patch only be done for "!bpf_jit_needs_zext()"
such that the above change in opt_subreg_zext_lo32_rnd_hi32()
becomes unnecessary?

> +
> +			new_prog = bpf_patch_insn_data(env, i + delta, zext_patch, 2);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    += 1;
> +			env->prog = prog = new_prog;
> +			insn      = new_prog->insnsi + i + delta;
> +			continue;
> +		}
> +
>  		if (insn->code != (BPF_JMP | BPF_CALL))
>  			continue;
>  		if (insn->src_reg == BPF_PSEUDO_CALL)
