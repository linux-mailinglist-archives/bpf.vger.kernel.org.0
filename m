Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA5413EAB
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 02:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhIVAoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 20:44:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhIVAoV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 20:44:21 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEeif019986;
        Tue, 21 Sep 2021 17:42:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DhOTISmCtEKOpIGEldHzuWcI132ZsMP9cYg94rWec/Q=;
 b=SHgNssMI9pB7topXmV9rPtuBDAM/Eyfemk+NPYLsUY7CuCybawxQBvI5Uvg785Q8Nj05
 tk8f40jQhWgdntSJOvlKCsa97Q2akOQIYUXYiiIDMtEG+ZqE7CvWzv5XH2nKR8LXwgrh
 S3Eo/zuddC/ksvffzG0HjPO7E+mOg7O/c80= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q4w14kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Sep 2021 17:42:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 17:42:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+HXx+koNMXkEqBriFeRI1T6Ax8651P7adK4EIpD6J8gtRRRw1N1BuSFxo1TFQNoTz2yL3Q4kXnnCB2sIYd2xlMuQcXhndv/dwiJ1DH9ey9Zdzv/O6s2md+WayL6lMAN2IIzDHxbktlt/t4+pRjq6bA9iHhs8wkKNHV1bkaqlSdrOkZdpqYqXsrdhEVvPiA+SNxrB3zuoLLS1O1yVkzDI3lDnEsJj4LtlZAqrk1Wbuxq4N4CUOVmh5XbX0SNPIxaozhjwq8InDvQZtZcFDaM8SuH8i/5H0pzOWN3LknWia1Q+0WK6P/qbPmZ9qWDf/wPvVwBRXW0N1CNSTh17o1jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DhOTISmCtEKOpIGEldHzuWcI132ZsMP9cYg94rWec/Q=;
 b=GTWaa810Jp+v3hjJwTUag5oBQz4BOcLxW6zET/mmvItm8r9Bw0VIuof/4xh9z5xyTomxRfdpqc+WYjjdVIlneaIj+W0Xz5MnCK6w08g1gguVtNn4kiBatID0D40o2y05TEZfOjFPwgLwdTr4/Au8m0hQ4CZ5xfg9GWmpuvo1tP7TBTjeRb7EVAHvlWvF1J7kkbIaPETbsgLBTJe67FEN8nL61v4wedy4n7Liyn5Y8qHIcF1wbrYE+9cBOokXO1BCNuFdeQZtsfhJ9eCeGTWFdLFY3p4vkSLktMHQWtUWnCFq1nUf8ZeHQMJeILujRjvrC9PbnFySfRXc0MgsoespEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB2412.namprd15.prod.outlook.com (2603:10b6:5:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 00:42:30 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 00:42:30 +0000
Message-ID: <2b9e2861-44ad-89bc-a2e9-04623f319a2a@fb.com>
Date:   Tue, 21 Sep 2021 20:42:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
From:   Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/9] libbpf: refactor internal sec_def
 handling to enable pluggability
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210920234320.3312820-1-andrii@kernel.org>
 <20210920234320.3312820-5-andrii@kernel.org>
Content-Language: en-US
In-Reply-To: <20210920234320.3312820-5-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:2d::48) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::12b6] (2620:10d:c091:480::1:d228) by BL0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:208:2d::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 00:42:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d746a0-775c-4e52-b1f0-08d97d61dbd3
X-MS-TrafficTypeDiagnostic: DM6PR15MB2412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB24120E40534D4B9E9D80B761A0A29@DM6PR15MB2412.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: br/sEDa5VBHslEudz9fJKpudncagmwL1838K0qr8Cx5uWNFNP1t8EM1Zphnv/EY4N2zrzgTWoij4RAOOwswqNbZvUYb3tb9z5wP5A4zILBvTfb2Zxzl+AvQGjGqKE25yQhhqJ+VqHwQT0GBpm0Pu+CutvbRiFdb/H8VN2Ex/Ckh5iLCS9cfuU4n8m81//XlVxfMTwdz0Z2j3r9sKXwu7H8XXiG+gBZYcxlr8oyaToR8pERNhV4o2R2J5ct+bjIpYT+9yJ24xDA9zbResI4PqLj4P8MyHWA7DMwHW0WmM6duxpYrcakzgujjlhoeug7KuUDoCj4EjUOTj5GOcWgsZrPWMZfhyBnUoWNiIerym0Cw0tGrKNFrSX2OzG7/yp450sfr2Ig747ZRcQJ2fvWJ4fIvuWYvlFjNnJYiyY6VuUwxJIFYwjHyhGBr2CDq0M/5SYjtDJ4rmCh+iuDHNv5PFYyPGW+YB/YFRrbDE+Cnt5l9BzyD5l1MIAzZvcQF1g5uN38oC/07A17ygM9LAJD6RQM6d4KXxKpDKSyOgSnsQe1mFwhds04HslaBgwrdm9fiTq/fhbX0ndFMS35SBpEKxDPJTbQpAIQy6AGDRvHHLev4hsF5PVuht1JwaeHllnBRYihtIdiuhsklKVIrcxsN7n62l37knDOzcEXc03bISVMt1ZXz/iCCaAKjqiOZXck6bEfx3OwQrtMOGAxHI7P8OXgk4Mc0ynC8uXCkHMF5qJu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(53546011)(5660300002)(6486002)(4326008)(508600001)(31686004)(66946007)(316002)(66556008)(66476007)(36756003)(31696002)(38100700002)(8676002)(8936002)(86362001)(2616005)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpadjU0ZXg5ZnRXVWwwci9ldm5NRTF0VmRjMy8xNDlEekx4WTM4UFZueEM2?=
 =?utf-8?B?VlYwUm1hQjRQdXVSajdCbUJMcXZTWFZ0bXU5cnVHSnhLOC9LMU5GcitJNHdW?=
 =?utf-8?B?UEZCamVlODl0SzA0Qk5PMTBURUtSbG9ER29CZXlndkk1UG9VZTRzbmtWblBM?=
 =?utf-8?B?a01yV1lndTFGeVJvWUQxQVc1ZlI2cm1aRU9BVUNyaUIzdFpVSUMxRGNUTVBD?=
 =?utf-8?B?Q3ZSWWFURng2dHJQZ1h1WnZEb2ppbHpJaHBHZ2VJQTVpOFQ2WlJPeVFDREtz?=
 =?utf-8?B?RDdrcWtqcXhsSkg1aG1PeUtvMS9Cdm02S2ZXdTR6dzUzWU5MMFJYM3Y1dVAy?=
 =?utf-8?B?ejBrQUpGYjQ4cnJDSUdxUG9nc1lra2YxM0drbUtCN0ZFRDJ2b0pvb0dKNEx1?=
 =?utf-8?B?RGhqckFjNjRrVVYxMnpBbUFYOEdmSzV1KzNacmVFRmtFc3JTM0dqRUJtZ0VQ?=
 =?utf-8?B?L0J4VlBxaTVGaWFtZjQ1OTEzRlJiVFo5Wm52YytMNWpqa3lIa29wMTJwb21m?=
 =?utf-8?B?QjZIKzduZWM0SHZ6cVByYkJHdXJXaUF2c0drT01NMnJlS25jQXBsSlZuZXMy?=
 =?utf-8?B?OHd2MllSNHZvN1JUaFN6U1duZW1Rb0tGUWs5b29OeTI5emFwWW1RYWJ3VjVi?=
 =?utf-8?B?bWwyanEwRVh4RUNUWlJCTE5ramV5NVVkdDVaUGoyYUIzMDFPU0lUWEIyZFE3?=
 =?utf-8?B?M2JqaldZZkxEZ0xSc0JQd3Q2UnpxcDRVMXErU1FrQWJoUjM4QlQ1TTdjQWpl?=
 =?utf-8?B?TTMvclBVc2ZBNEx6Z3lTVnpRSWFYQXlJQmdyNWhURSsrbmtLaERYdEE4RVo0?=
 =?utf-8?B?K3J5Wk9JM0tEYWFtaWQxVmhhZk5tS20zMmpNR0xYYXI3OEw5RDIxdnNqUWdB?=
 =?utf-8?B?Nm9KUjNuUytMeGFuTTAvTFUweitUazlZMm1oTEZGOGgyUlYwRWZBVWs5d21p?=
 =?utf-8?B?Q1R4cjVPc1UwbG0rL1haRm1zcWFOb2pvbU5xay9HYS9EcVA2VFJKeVBYWUxR?=
 =?utf-8?B?NnNUMHMzZFV1NjhENDhlOGNZREZIVkJRc2g4MWVjcEJITFFDTEtVbFF1UmRn?=
 =?utf-8?B?c1NTR3grMlpmRlkvT1lkNVFEajFOWm9wM28rRzZDeWh4RS9pdWNKWU1lQVQ2?=
 =?utf-8?B?ejJIbGdlUHhDand0dVBtclJvU3U3eUdVR1BqK3FMZitnU1djSFMxMGdKSlU1?=
 =?utf-8?B?UVY1UEliU0xQUVptZDVmTHl5VmM1RndKRE0vc29walNaY2xnYzRnOU5TNk1r?=
 =?utf-8?B?cEU2SFdTMHkvY0ZHYUZjMUlkKzZ5ckFsdE1SVGZQbG81ei8ySGgycGx5RHdR?=
 =?utf-8?B?Y053UStHSnBISUN2a2RNVmg4aWljc25teXUvTmtkaTcrc3hTYWNEUGNEQ2Zl?=
 =?utf-8?B?K3FpYkdTd1B2MWh1N2dhMnZUOTVxWmEwU3BvUlhVMGVxaWVwdzMxaTIrcEw5?=
 =?utf-8?B?MXA3MCtSajJZSG84a0M2bnpsY2lodXFOZ0pNNW1KSk1ycWFhYXVrT1B0alNI?=
 =?utf-8?B?emg0c3c2dFhIb1NWN0tJWUNJbHE0cFYvWC93TUFscnhIQVNJS0RrZTBDbmgr?=
 =?utf-8?B?cnZ0UmZsck5mRkx3NmdrUjBVWHJ2dGdSd3NySytiWWZWM0JLUGJjNDI0M3p1?=
 =?utf-8?B?QXh5bStkSExTWlNCbG40TmovQk1haXQzeVdTUFdTSTJDWUE0RGhBSkpmMWNF?=
 =?utf-8?B?OTkxUXBtcVJiRlpZcTlZcHp0cWppeGlJQWtWVXhURHNVYU5lb2VaNWo2N0ts?=
 =?utf-8?B?M1FsdHVVeGZ2bk5GaHdlM0x6emFBMEd2RnNlZGNCRTdhSitPdkFKSXJoMGhx?=
 =?utf-8?B?K1dUZ2ZXZnRrb2hUU002UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d746a0-775c-4e52-b1f0-08d97d61dbd3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 00:42:30.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SMeHkeBxURZ3GGDerZlMvZgLi+CYufcZWCNgY5kn8hIMiFzl+T8XbmX0f2zwvrKSIWnVP9nlj2RuGqlkoswAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2412
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: AuKw4730lShANgxujqPPitCl8bhVYJZn
X-Proofpoint-ORIG-GUID: AuKw4730lShANgxujqPPitCl8bhVYJZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/21 7:43 PM, Andrii Nakryiko wrote:   
> Refactor internals of libbpf to allow adding custom SEC() handling logic
> easily from outside of libbpf. To that effect, each SEC()-handling
> registration sets mandatory program type/expected attach type for
> a given prefix and can provide three callbacks called at different
> points of BPF program lifetime:
> 
>   - init callback for right after bpf_program is initialized and
>   prog_type/expected_attach_type is set. This happens during
>   bpf_object__open() step, close to the very end of constructing
>   bpf_object, so all the libbpf APIs for querying and updating
>   bpf_program properties should be available;

Do you have a usecase in mind that would set this? USDT? 

>   - pre-load callback is called right before BPF_PROG_LOAD command is
>   called in the kernel. This callbacks has ability to set both
>   bpf_program properties, as well as program load attributes, overriding
>   and augmenting the standard libbpf handling of them;

[...]

> @@ -6094,6 +6100,44 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
>  	return 0;
>  }
>  
> +static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd, int *btf_type_id);
> +
> +/* this is called as prog->sec_def->preload_fn for libbpf-supported sec_defs */
> +static int libbpf_preload_prog(struct bpf_program *prog,
> +			       struct bpf_prog_load_params *attr, long cookie)
> +{
> +	/* old kernels might not support specifying expected_attach_type */
> +	if (prog->sec_def->is_exp_attach_type_optional &&
> +	    !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
> +		attr->expected_attach_type = 0;
> +
> +	if (prog->sec_def->is_sleepable)
> +		attr->prog_flags |= BPF_F_SLEEPABLE;
> +
> +	if ((prog->type == BPF_PROG_TYPE_TRACING ||
> +	     prog->type == BPF_PROG_TYPE_LSM ||
> +	     prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
> +		int btf_obj_fd = 0, btf_type_id = 0, err;
> +
> +		err = libbpf_find_attach_btf_id(prog, &btf_obj_fd, &btf_type_id);
> +		if (err)
> +			return err;
> +
> +		/* cache resolved BTF FD and BTF type ID in the prog */
> +		prog->attach_btf_obj_fd = btf_obj_fd;
> +		prog->attach_btf_id = btf_type_id;
> +
> +		/* but by now libbpf common logic is not utilizing
> +		 * prog->atach_btf_obj_fd/prog->attach_btf_id anymore because
> +		 * this callback is called after attrs were populated by
> +		 * libbpf, so this callback has to update attr explicitly here
> +		 */
> +		attr->attach_btf_obj_fd = btf_obj_fd;
> +		attr->attach_btf_id = btf_type_id;
> +	}
> +	return 0;
> +}
> +
We talked on VC about some general approach questions I had here, will
summarize. Discussion touched on changes in patches 5 and 6 as well. I thought 
the pulling of these chunks into libbpf_preload_prog made sense, but wondered
whether some of this prog-type specific functionality would also be useful to
"average" custom sec_def writer even if it's not considered 'standard libbpf
handling', e.g. custom sec_def writer whose SEC produces a PROG_TYPE_TRACING
is likely to want the find_attach_btf_id niceness as well. So perhaps something
like the ability to chain the callbacks so that sec_def writer can use libbpf's
would be useful.

Your response was that you explicitly wanted to avoid doing this because this
would result in libbpf's callbacks becoming part of the API and stability 
requirements following from that. Furthermore, you don't anticipate libbpf's
preload callback becoming very complicated and expect that the average 
custom sec_def writer will be familiar enough with libbpf to be able to pull
out whatever they need.

Response made sense to me, LGTM

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
