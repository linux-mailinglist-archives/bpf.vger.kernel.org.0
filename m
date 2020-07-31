Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E776234B6A
	for <lists+bpf@lfdr.de>; Fri, 31 Jul 2020 21:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgGaTDI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 15:03:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52060 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726925AbgGaTDI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 31 Jul 2020 15:03:08 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06VJ2iVg004350;
        Fri, 31 Jul 2020 12:02:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=IsuLpq2cXkRuiyMZrVxYpRO2191/GYejM+sI6stKf7E=;
 b=OQ8GqQ1XeqXQaiMldPb3KCS6nHn21wKxqmroQ27FJu2yLzSOKI7oSPxlXquhPqTbpWwV
 BRcdDTivQvwaYkRbOCulLCyMW7abVs4X9iKtxiTeasaAVWZpI3XTAAgC2SGCGV0OlMAU
 RLJ2o5oWgSbkSW0hWsnhkGqf2k8RXte/Ako= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 32kgmstgna-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 31 Jul 2020 12:02:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 31 Jul 2020 12:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqTxUeZzOqVu3yT/ZYWjlJ4RIub2U67bC5WN6cOe+0cm7QopfTrcKIDsWJoC9IdGqYqFsv/AK4P9dfCEEn/tp5xVBEB0UPYgyts9SavgJT+OxmRyU3hSKaClF49yaCVa5HtobMVllWiLQpODvFrKWsPRowk94GMt1IEuT0k7k/lp113uOuhANGzK+vrCE/AV4yh4OgOB68YV7b/ZiQirF8XUdaAaP0YH1jBnT68sYCLNtt3ITSpaZDHJsqTFhSGwr7UXc87Luik6tcTA6+Vkwyaul6DsaE4+PRUFgMkOo8UViamhtFglGS9iBDatZd9MBcZD4SJ83ZQgl2sJ6nSZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsuLpq2cXkRuiyMZrVxYpRO2191/GYejM+sI6stKf7E=;
 b=OwUQVMd/3FJRWjld4+2UH6qUL1aW9cQp4fn1I75OfuIB9GHfArbH/rGKiFpXMeQLh/b+QMngfRNHgOqnLt99kV6fqhEl0CTL3YlQW6lnvTrRoJ1Z+PTau0AxNCOTP9Nwu8Z7cvuq5j6e1aj0sgaXxyutGQ3mGtQfTg3ImNytabn2C21U2WRLE57qWiR7cc7P72tAEQ7bQRHQPXC4RYd6/0pj+VLvxlfTNbp0vE26tlTiMTPMgr+gOjOHsk2jDnx+0804XEjt4pIwMckQjP6JcDcZkOO6dJtbxVXruGb+nqSbnPteb7qCQGC0lmMJ1UihIwXui3ru/ENYjGvRhP0wAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsuLpq2cXkRuiyMZrVxYpRO2191/GYejM+sI6stKf7E=;
 b=KMshZP/Sh4QFT0Pi3Hzq3DZTlGPt5TCN99Fj4IFJvmPFeOJF2jJoNiXnsibItBfSuzVYleiBiSDvg0W+q77se+0e4uE2R35H09gejGk3Lo38etqbnLBvW+yigsj8jbfcr2bHz7B9jbS4gAor41y0uEOIbZHpSLUcjKAcYESSG6g=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2839.namprd15.prod.outlook.com (2603:10b6:a03:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 31 Jul
 2020 19:02:37 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 19:02:37 +0000
Date:   Fri, 31 Jul 2020 12:02:31 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v7 5/7] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200731190226.6ugmk6cnl2yortgt@kafai-mbp.dhcp.thefacebook.com>
References: <20200730140716.404558-1-kpsingh@chromium.org>
 <20200730140716.404558-6-kpsingh@chromium.org>
 <20200731010822.fctk5lawnr3p7blf@kafai-mbp.dhcp.thefacebook.com>
 <adbfc73e-bd32-d9ba-4dab-4ccc39b40fdd@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adbfc73e-bd32-d9ba-4dab-4ccc39b40fdd@chromium.org>
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:5cdc) by BYAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:a02:a8::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19 via Frontend Transport; Fri, 31 Jul 2020 19:02:36 +0000
X-Originating-IP: [2620:10d:c090:400::5:5cdc]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e570600d-c236-4403-b4d3-08d835844a03
X-MS-TrafficTypeDiagnostic: BYAPR15MB2839:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28393EBEE24A306A0AF6040ED54E0@BYAPR15MB2839.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3u+1jc+VpgYkoc9JJwzD06EkVzeQKvebI+HkxZ1inG9q4gIC2USMnd9ViYs+ShumeGS9RTqHLWWFlsuuzsxW4Y63VfP8M20X6uPUhNrZz6lLYkyq0yAL0fdsNkm93n3vKMjn2zrqa3yj96eMwcz/TaNXBouQzINk7AkqyRN5hIrjJmcUD4/zKABauN+UA+nyyCTAHSzxYv0sKGM9ohdh8i/EX3xgJ+6YdfmaOLzdh9VwG22ZcS1G/hEAUNCnbiQ49iW/JpYc8dUKLaVrV+OcLJHrs959bWBMIl69txPCdtknvzII/2kEJsDLssMFbLcGP3xrOAQs/ZMV8+3UMPeq6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39860400002)(136003)(346002)(376002)(6506007)(9686003)(6666004)(8676002)(8936002)(52116002)(7696005)(86362001)(1076003)(5660300002)(478600001)(16526019)(186003)(66476007)(83380400001)(66946007)(66556008)(54906003)(6916009)(55016002)(316002)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Wn/uP2njKMgCHw9K7Dv/UUv9iXUIvGu49UJUSjxBezGXSswCGwJ1KrjuRFIdJ//jZBjt6uOcPV0iNmraOd04AoLm6esVqQQwS28WgMeqG+IN0OpVZ/LxkO8vdG7YRJ0uaGa8zzf/gbLxVFueaLeryM80O03VBy4+po/zZyJmmsFUDjHceIoqUqT9AdXSb7YnyG/CAeVPIGCVTv8mHyNRBFMk3GF9ZTSNseFBvN1vjaG1byeE3GRhhLMgm87K3A42BMcJXUT9D31KnTEcKXIO4k5XElM+yna6EqicuxWGKNx5/7PTVi8BmEV2DuKu7tPugNYfWELu0YFiaHrAviyDS2lPOQXfCyrwS9pU7Ze9F7CbEarYa/nZ7QkZ7voyGp0TcY1RwdEN4jUsf6x7/EadwS7fHGRJ6c6twV2tm+uoLrWD6vnT4g52179+H+RiBpDUMObUS048TlWbgQmk5RRkoxcNNqvSoGNS8de2YjL66Dlt2A4TUj836V5SO02oZ6gYLj/+zLXYyuH4x4YbfCQqj+E5TfgINwKgjmbYfhFmmRPW9ChqAR06NkeGftk9Jmouf2f1UVvdD8cGPzPq1Jmrr4hRvovYwyhteykOlM79LlyeblHkWehDgu+b0Q2UQO3G7WMXVh6kLIFNr8Om6dufz5l0AtyyYmr4mDm+6BZ+Plz1U/siCLeiU3/7bJBa7AB+
X-MS-Exchange-CrossTenant-Network-Message-Id: e570600d-c236-4403-b4d3-08d835844a03
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 19:02:36.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftDnyGxDwCa62IF+6F+GZC30dLd84dWvNYLAr2O+SCtXRK9LbpuL+bQIKEIycYVj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2839
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_07:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=5 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007310141
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 31, 2020 at 02:08:55PM +0200, KP Singh wrote:
[ ... ]
> >> +const struct bpf_map_ops inode_storage_map_ops = {
> >> +	.map_alloc_check = bpf_local_storage_map_alloc_check,
> >> +	.map_alloc = inode_storage_map_alloc,
> >> +	.map_free = inode_storage_map_free,
> >> +	.map_get_next_key = notsupp_get_next_key,
> >> +	.map_lookup_elem = bpf_fd_inode_storage_lookup_elem,
> >> +	.map_update_elem = bpf_fd_inode_storage_update_elem,
> >> +	.map_delete_elem = bpf_fd_inode_storage_delete_elem,
> >> +	.map_check_btf = bpf_local_storage_map_check_btf,
> >> +	.map_btf_name = "bpf_local_storage_map",
> >> +	.map_btf_id = &sk_storage_map_btf_id,
> >> +	.map_owner_storage_ptr = inode_storage_ptr,
> >> +};
> >> +
> >> +BTF_ID_LIST(bpf_inode_storage_get_btf_ids)
> >> +BTF_ID(struct, inode)
> > The ARG_PTR_TO_BTF_ID is the second arg instead of the first
> > arg in bpf_inode_storage_get_proto.
> > Does it just happen to work here without needing BTF_ID_UNUSED?
> 
> 
> Yeah, this surprised me as to why it worked, so I did some debugging:
> 
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 9cd1428c7199..95e84bcf1a74 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -52,6 +52,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
>         switch (func_id) {
>         case BPF_FUNC_inode_storage_get:
> +               pr_err("btf_ids[0]=%d\n", bpf_inode_storage_get_proto.btf_id[0]);
> +               pr_err("btf_ids[1]=%d\n", bpf_inode_storage_get_proto.btf_id[1]);
>                 return &bpf_inode_storage_get_proto;
>         case BPF_FUNC_inode_storage_delete:
>                 return &bpf_inode_storage_delete_proto;
> 
> ./test_progs -t test_local_storage
> 
> [   21.694473] btf_ids[0]=915
> [   21.694974] btf_ids[1]=915
> 
> btf  dump file /sys/kernel/btf/vmlinux | grep "STRUCT 'inode'"
> "[915] STRUCT 'inode' size=984 vlen=48
> 
> So it seems like btf_id[0] and btf_id[1] are set to the BTF ID
> for inode. Now I think this might just be a coincidence as
> the next helper (bpf_inode_storage_delete) 
> also has a BTF argument of type inode.
It seems the next BTF_ID_LIST(bpf_inode_storage_delete_btf_ids)
is not needed because they are the same.  I think one
BTF_ID_LIST(bpf_inode_btf_ids) can be used for both helpers.

> 
> and sure enough if I call:
> 
> bpf_inode_storage_delete from my selftests program, 
> it does not load:
> 
> arg#0 type is not a struct
> Unrecognized arg#0 type PTR
> ; int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
> 0: (79) r6 = *(u64 *)(r1 +8)
> func 'bpf_lsm_inode_unlink' arg1 has btf_id 912 type STRUCT 'dentry'
> ; __u32 pid = bpf_get_current_pid_tgid() >> 32;
> 
> [...]
> 
> So, The BTF_ID_UNUSED is actually needed here. I also added a call to
> bpf_inode_storage_delete in my test to catch any issues with it.
> 
> After adding BTF_ID_UNUSED, the result is what we expect:
> 
> ./test_progs -t test_local_storage
> [   20.577223] btf_ids[0]=0
> [   20.577702] btf_ids[1]=915
> 
> Thanks for noticing this! 
> 
> - KP
> 
> > 
> >> +
> >> +const struct bpf_func_proto bpf_inode_storage_get_proto = {
> >> +	.func		= bpf_inode_storage_get,
> >> +	.gpl_only	= false,
> >> +	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
> >> +	.arg1_type	= ARG_CONST_MAP_PTR,
> >> +	.arg2_type	= ARG_PTR_TO_BTF_ID,
> >> +	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
> >> +	.arg4_type	= ARG_ANYTHING,
> >> +	.btf_id		= bpf_inode_storage_get_btf_ids,
> >> +};
> >> +
> >> +BTF_ID_LIST(bpf_inode_storage_delete_btf_ids)
> >> +BTF_ID(struct, inode)
> >> +
> >> +const struct bpf_func_proto bpf_inode_storage_delete_proto = {
> >> +	.func		= bpf_inode_storage_delete,
> >> +	.gpl_only	= false,
> >> +	.ret_type	= RET_INTEGER,
> >> +	.arg1_type	= ARG_CONST_MAP_PTR,
> >> +	.arg2_type	= ARG_PTR_TO_BTF_ID,
> >> +	.btf_id		= bpf_inode_storage_delete_btf_ids,
> >> +};
