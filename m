Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DBC5951BF
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 07:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiHPFNs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 01:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiHPFN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 01:13:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50C3EA89B
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 14:28:26 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIbxSA030411;
        Mon, 15 Aug 2022 14:27:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=D0u+8Ls58hOI3CXb9uwhmMbWJpcPpaQQQuvaBpxOv2I=;
 b=kHN+gVL3kVGZf2QWMe4b0VOnk08L7aikFDKiHLCLIczy5eq9ROE9QJWZyH18m9p5AXVV
 AMRuTxneg0AEme6Y84AZEln+7xwZiU4Gyz5MtGvXoSCcSSRYaUXcZg6q3hU9f45eKxuO
 /pFrVsRSYPAdek5ZuU4LO0hI4QSQh3YfZTQ= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hykr1v8nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:27:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThCpga8I+mx5ThJG/qvhrVyRyRmWkSOIo7FMT5ze3R8lAzIqGHvU60NJJm/KEZl0Be34sq7s7Leb141AEmIJXX0V/shBt1lJkFJN3fRArR5MKsr3ldOVofvydAeR4LO6hf9u8LSVUeUFtIKmgYo1jhG4PKWO2oY3qsVxtX395eTmVf4lHxZKBtiix3aTcZsQ3hBwOmUz1XKXFiHcrTEI5QjulZDAh+A2R9SuUwdX4F76GZg54su+HNdH72L0RqW+0ZHFH//g5XPGC128vjUKCluPVlzNvlDcgnKR+0ni2emAjRUkBpmJYYiFVOsFGzgVvMlX+Wn8Q5zmEL0xEzpX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0u+8Ls58hOI3CXb9uwhmMbWJpcPpaQQQuvaBpxOv2I=;
 b=B/7oNdefguRWRYMhcv2pYfY0xHnG/+pQbcjTGG6dCryMGwBwPXZCUsN4Qhp9QRJYgAFc/bjj2eaIlUQzH93qB0TtFC15T0+D9xFA4VlcUULOKQwTuGeW8eGLKrVtsUCSFOA9dYrB6yejt74WDSJTKjaLVA6+BkJbD5cT/A980HdbLdn6OXUUXqmhp249lyTMBVSvCBQq1oZmOCPhsj94+d0vxTdrleXvsFayvS4c+oHguzCF0EOCC1+ZFCCveLGlTaui7C0g+lWsW8239B6NYVh1EogxZlVGEmcgy1UHh8JDSP7wXhe0H1k6tNCByXf3/efvLag+v3QDYTEwyiKmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MN2PR15MB2944.namprd15.prod.outlook.com (2603:10b6:208:f8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 21:26:50 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 21:26:50 +0000
Date:   Mon, 15 Aug 2022 14:26:47 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next 1/3] bpf: introduce
 cgroup_{common,current}_func_proto
Message-ID: <20220815212647.6wddh5spdl2l554v@kafai-mbp>
References: <20220812190241.3544528-1-sdf@google.com>
 <20220812190241.3544528-2-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812190241.3544528-2-sdf@google.com>
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51ee6c64-80de-4b53-a5bb-08da7f04dd61
X-MS-TrafficTypeDiagnostic: MN2PR15MB2944:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zndTycb0I+C5js4asI72nrmBaEmFp5ysvTHPNqLadrKlwYC65heU25w1tCUetDKSE8YvdWZRbXWNa5v/klmkHxZLaacxNKKJusFLtVPfpGEUi6wY5LN3Qb/KF/jBJX2blHKhXVf8Gy7pmbJqOK9l/dUzYzziVCXtY7UDht32InkGBhRLSWRZhRDTHxu5D/+P2UvBLzQGtHgum64shz7O3h3wR/UaIDHisPV71UyoN06nBO04CQRtMjt7DA8Gh7m0aWD7pY6EC6ILkuuYLWH0PhuYar3JFDOPh4wQd+V62U0TygCMemRcmm4+esiKaITk3b7+YUxIbEy5Ub9U9R12tbkoecFLsJMd4Mdia8W6Xy/H6iy6RYdeRwSZPAZo4pvPJQ95rTVG0l7uaaPZ0c/gTXktMLIdNNGvHTYdVovzXrhe6CAr3byhERIUQh5Q3XG9sgeE5KuF2j7DJ7SH2WK7yrq8zePhVziNyjV4Jp4lFr7XFykDvAgOi8M24fN952rOcCzKMN5/TTYd7LaGrZMLq6epN6nc+Y2j4eiIimVjWJq7zO9RYmcZ66mzNcGdun3VgOc8Vzk4VTQvIXTc+nrQ6DpkFiZQdWLMSj2AXAWBMbU1g5bKQvB7/ei+s+b5J2v2qAQUueUinPZ6zh0iXOb5smBzQDiOozwBskJG2Di4PHA8CcCQYlkASzQDcz9yQntP5Yku4pdfDIl0ayceZZWdtgUzK/86aTf7gw1mnkrW4uEu9LwsXcl3R1VpSwVqSQC9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(8676002)(66556008)(66946007)(86362001)(6916009)(4326008)(38100700002)(66476007)(8936002)(478600001)(6506007)(6666004)(6486002)(1076003)(41300700001)(52116002)(6512007)(316002)(2906002)(7416002)(33716001)(9686003)(5660300002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T7CWx+q/jpNe7J3vIRv3ymkIQySgxMQb9leExf0up8q7kVZNtIL5DtJ6D2uj?=
 =?us-ascii?Q?fvRJPVBgTUaNHt8vjpDs+NsA4SekIrxz0ed/avRJ+xekaa3iKQEKifwnx5B/?=
 =?us-ascii?Q?XyZbirW3qbc4XfixV2sPvD2GAJUD+pxhuEbuz9IPvX0ZrJxX+bk4MAMz7KEK?=
 =?us-ascii?Q?UVpWTEraJCpbjtcKa3MRcBaGzX04SCEVG4Op6SG8YIXbluV5dhmabtzDV54i?=
 =?us-ascii?Q?IRea91Okrhgh0gI7IgKl5+epBXoKIMhOVwEF6PUheWpxexXhxeKyi6x3t/RA?=
 =?us-ascii?Q?aSi8k0GviwO8oZpyJPiICTWetSta3cIToGdBEhiCIn1XOAbjAi6RbE831ip6?=
 =?us-ascii?Q?37Wm3LQkUBg2LvP/G/fxOvTGKVkfDisRIo/pvVBERv/Kk53A0CRIhY0BpeQf?=
 =?us-ascii?Q?aM6twZcEO14UeYhxAEo2WGiI0up9/+1jo+uGXrlwf1XCJTbpoLL385Alm/uB?=
 =?us-ascii?Q?GSDsJ4TOyhbCcy61GyJLqVbNCCtFSX8hVxl1uyEM231dgmDTH+FA5Mua5x3i?=
 =?us-ascii?Q?VjPCEk7Haak+O1wekjxYJ5s7nFlj1eFVEDrfnjQtEJajd2hVzgXzULfR5GJX?=
 =?us-ascii?Q?6GsPBpC499IDq81r3Mol4BhD7rC/gsDCMpYF8b48GwFc5uJ849DRrg8IHwas?=
 =?us-ascii?Q?GtLV7XKhkJw3cq+9OOP7UtO+vCNK3Dce+LEP+KW67d8WKpUBtedfgTg2StlM?=
 =?us-ascii?Q?qevKpm21TIXY9Si5fES17rH74Dccxjkbdewd61hpLlWntSJI2BEqJCgpX5R3?=
 =?us-ascii?Q?KW0eYB8v4opEXP0p9ZtAehCg/Xxd2gDJLTBpciZtxSHZsPjxC0psGpDWoTa3?=
 =?us-ascii?Q?/sc+tgm4fWN2QrWFWxDVWcMG359j5gcbemtqklzVIkfF9CADha+HkhlzBiwx?=
 =?us-ascii?Q?4qc3noaIMVSut8HBubVfWH8iTF3CMX/vkuH7Z5W+0ZLO8BapwWAMnjMc0PSo?=
 =?us-ascii?Q?Z92Vb6obvV8PI3knDgdreNV9uG2QtyAO4THXi3Y3EvWolkuQG1eR6vVlwXmw?=
 =?us-ascii?Q?3S17ds7aMJFBWTVB8yWQKkJEE7e2hoa69Mtt8bdalu4RtEZHSfmN/Q6TLicw?=
 =?us-ascii?Q?GLrxIa7gMc3NzNnex0iT+6Lt3FXsqxw4+avaNCrPwraVHBMIpvglgZIhl6vH?=
 =?us-ascii?Q?MElw+5SJyJYAU1KpqdMDfoYREVIbu2OauBVsVe3+OYzZxvxPFi9/GTC9A7fQ?=
 =?us-ascii?Q?UM1D2rxDJdoHPL18YqVxkHs3jtazGcvyen/SmQHLViu1r6G8mhSP05maw9Zk?=
 =?us-ascii?Q?6G3/+v44jKEOZOK3gT4pAfEQwzR9gj46ozI4RDlCqtYQBWyria4AWcx7+ehs?=
 =?us-ascii?Q?8lg+Gov0XETBHq8Cp7U/mOgAGvSYdrDvV5uuglaf0jRElwnkxIhrMvRJiJNx?=
 =?us-ascii?Q?fyS3UXQYeqAMYWY/oGNhwKp3tn/V6PHi99mC1fy8+c35aCD5h6uwOqyFnxhu?=
 =?us-ascii?Q?Ow3dgmmFWHzN+I55m89hcZ/X7DRx0Ts0h5aq1VQom3Nvz2z5JJKf1nI5Kf6/?=
 =?us-ascii?Q?V4OHCc7zQd68Aa/sVBIGTK65mTtvBG3TAzAzXnBI1BnVvcxmcNrl3qbE7LFn?=
 =?us-ascii?Q?OjfAd+DanOH/rE95ZTLeOsmjRHZyr0EyFQaDOFWojtCxHdskmwkwAt/lw8Iz?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ee6c64-80de-4b53-a5bb-08da7f04dd61
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 21:26:50.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6cFyHcU4dpv93hK6MAK4QWHJthsxGBcRtt07Dwq73uA3d0lONxlIPCkT5MFSi5L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2944
X-Proofpoint-GUID: GlxpQ3-0hIcpMU-8aR5NzrLlcJBH7beO
X-Proofpoint-ORIG-GUID: GlxpQ3-0hIcpMU-8aR5NzrLlcJBH7beO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 12, 2022 at 12:02:39PM -0700, Stanislav Fomichev wrote:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 3c1b9bbcf971..de7d2fabb06d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -429,7 +429,6 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
>  };
>  
>  #ifdef CONFIG_CGROUP_BPF
> -
>  BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>  {
>  	/* flags argument is not used now,
> @@ -460,7 +459,37 @@ const struct bpf_func_proto bpf_get_local_storage_proto = {
>  	.arg1_type	= ARG_CONST_MAP_PTR,
>  	.arg2_type	= ARG_ANYTHING,
>  };
> -#endif
> +
> +BPF_CALL_0(bpf_get_retval)
> +{
> +	struct bpf_cg_run_ctx *ctx =
> +		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> +
> +	return ctx->retval;
> +}
> +
> +const struct bpf_func_proto bpf_get_retval_proto = {
> +	.func		= bpf_get_retval,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +};
> +
> +BPF_CALL_1(bpf_set_retval, int, retval)
> +{
> +	struct bpf_cg_run_ctx *ctx =
> +		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> +
> +	ctx->retval = retval;
> +	return 0;
> +}
> +
> +const struct bpf_func_proto bpf_set_retval_proto = {
> +	.func		= bpf_set_retval,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_ANYTHING,
> +};
> +#endif /* CONFIG_CGROUP_BPF */
>  
>  #define BPF_STRTOX_BASE_MASK 0x1F
>  
> @@ -1726,6 +1755,40 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>  	}
>  }
>  
> +/* Common helpers for cgroup hooks. */
> +const struct bpf_func_proto *
> +cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	switch (func_id) {
> +#ifdef CONFIG_CGROUP_BPF
> +	case BPF_FUNC_get_local_storage:
> +		return &bpf_get_local_storage_proto;
> +	case BPF_FUNC_get_retval:
> +		return &bpf_get_retval_proto;
> +	case BPF_FUNC_set_retval:
> +		return &bpf_set_retval_proto;
> +#endif
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +/* Common helpers for cgroup hooks with valid process context. */
> +const struct bpf_func_proto *
> +cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	switch (func_id) {
> +#ifdef CONFIG_CGROUPS
> +	case BPF_FUNC_get_current_uid_gid:
> +		return &bpf_get_current_uid_gid_proto;
> +	case BPF_FUNC_get_current_cgroup_id:
> +		return &bpf_get_current_cgroup_id_proto;
> +#endif
> +	default:
> +		return NULL;
> +	}
> +}
Does it make sense to move all these changes to kernel/bpf/cgroup.c
instead such that there is no need to do 'ifdef CONFIG_CGROUPS*'.
bpf_get_local_storage probably needs to move to kernel/bpf/cgroup.c
also.
