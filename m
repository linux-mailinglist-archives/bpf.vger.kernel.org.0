Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B1C56AE1E
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 00:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiGGWJX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 18:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGGWJW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 18:09:22 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799921F2C2
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 15:09:18 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KPi6Q031027;
        Thu, 7 Jul 2022 15:09:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gG8HP0LT1oszKMMYRn0N4PTjv1gPw8/6CuZwiQ1in24=;
 b=gw7eUx98sggihw+ymvKQ4pb2PT3+rwAvVaCe9cHOWNCVmg/QO10bupI8EGQ7wlc7CecC
 nFwSSTiT859jvqeEvXGwhEabZp/LFd7fcyNfkt/lLsey56FcHhEtKIdLiLzZUpyvlk0B
 0qbJxiOlvU4dYeo7Ny5cXZ2N1Gxh0SDk7Us= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h5nw2eyra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 15:08:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQUrzDsxjdscqKfxm9qpOWVYYnCoayatUJoHuFCMp+icKtB3yrUpF0L7s1G66adBE+PJDjgFYKYg4IKhgl/BddPOkSUM4YMLnVCHcZXlZ0IgpZzPhovc7cdEf/3xjAzdDGLfKQEE8F3Veo06oKw4jrvg9PkeGybgRxGjo5Qzw572W5pkWjvH+x70b7h+BCBBG0dASVheesMl0VqKHpfOKHNtD1K7fZY79uTCuTH9UsKiM81yAnO+49FuxlcAZwpEmju0Ciqi5YrO56bwarwjkV+35wVCIPgsL4oia0juob3sensb7VXnqgRoCIwqVlagkdpOYBR+iMKItmjR9P/ARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG8HP0LT1oszKMMYRn0N4PTjv1gPw8/6CuZwiQ1in24=;
 b=cXQwzxHltQ6nKXxInew+/AvjYPJidy211hLPAhxSsmzR5fLoZb+keirq8dsmBrvULO73D7Gdg7agT2m9iSVotuc877K+BsAknAbWSd6g1Xj9PELRBzKowL/r3zamxrUdkmVsJxGEORvUZ24zE3s4T4TyCRYv7CJOcEIzEq0TTJUP7+RQh/2bCiLGtFQJ2dMATgF0NhF9D3HlhZwaDAxLFXJFwzcfBdOYN/rysIGiSVefvkFbNFuUptux5GlQ3otQv5gP6JsPskbYAk6GyGYQJtq25+V/tXmcWi8S6x4bzw/e5Jka098fkg+jICFvbd0q/C3hh/zzXYYv0WAERMFutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB5079.namprd15.prod.outlook.com (2603:10b6:806:1de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 22:08:57 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%6]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 22:08:57 +0000
Date:   Thu, 7 Jul 2022 15:08:54 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v2] bpf: check attach_func_proto more carefully
 in check_return_code
Message-ID: <20220707220854.cbbydamsasjctxos@kafai-mbp.dhcp.thefacebook.com>
References: <20220707160233.2078550-1-sdf@google.com>
 <20220707181451.6xdtdesokuetj4ud@kafai-mbp.dhcp.thefacebook.com>
 <YscxieVQayT2cVgi@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YscxieVQayT2cVgi@google.com>
X-ClientProxiedBy: SJ0PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::8) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a7781b5-0308-4bd7-6083-08da606549e3
X-MS-TrafficTypeDiagnostic: SA1PR15MB5079:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbRECl6lSIYTjLDHIUl3fbOVhxEp9sUBPxdWVfkR1IAG2h2JK3utSQ2heE0GS5MyBBj0OWRxKJwhfw7wMXLlbg933FvLKDMnaOsM8c47u4Yn11xD4xse/HzTBNdR9fPofzyR5FTTFqWRSjeaIRsXozWfLNIZsfn5pA6U3Masj1Pu+IXu19IgX8gMX1v/3SftR3J9o0YsbZXEWByL32UxYCvj3pkw5UkFUI3RzSOa6/q8EvPxYyAL8OlrTsGByH+yItCXfUwkRQ0OSBYb6S+KVwac6pRzxJmVZ6/Jrit2FMArPBmGI2RAQssUM6AZIZTRGjQlIlSBmjvBVDtQywOnFJZmB6mr/W3U6x1qm5qVxNbY1Tbd5u1t/xhlnwG5bZBDYeIn6GvatGJXXnROO4bZW1HGm/fLNIvTLQD82fHD9ZaHbCz8S3kJT9KSJ3opmpfM23gU4TsEJeNz94sPugqY5DHKhyVb3HBHnbvFPuTCiaIqXoCHIOPMQDuQ2atMp0hiJkHmGboAYB/gWMvTH5exLC/Fq7mZrDldfjBqnmjICN83k1BAZTpP73Wpy1yAas1OBBp2BeMJk1kefaKDT05k/Cxwz1OCCtf4SNrZDr4z8a/IKPyat0oTBILl5sb7Xzg1GAQLdomUfkwuNRlBCc/LEVFCmaOdAUKoyz+YFFVC6J4an9CNqwq/jxgAdy7nrbF+29itD0y35pVpNpK530OgdLdD0fNaB3FfXkFMrdQobJoS/uK/JSzoHYWt7F/HLenT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(52116002)(66946007)(6916009)(316002)(478600001)(6486002)(86362001)(6512007)(6506007)(6666004)(9686003)(41300700001)(66476007)(38100700002)(4326008)(8676002)(66556008)(186003)(1076003)(3716004)(83380400001)(5660300002)(8936002)(7416002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?idCO35xthQYLYWESf7FsFwE8WFf9sWqIf9YExx0tKzueTeeMSeGijeV6f66O?=
 =?us-ascii?Q?+5HPB0pCJNBJ8e8i3qSM3dKv9D39BBxMekr6QARoLq4xaQKLioRa/j77T8iy?=
 =?us-ascii?Q?esoCM+MuMgtu5rBn1hUpaEgOAletYgAU6Wiyo/v/bjnqFwG3zxfrhXRi2FW6?=
 =?us-ascii?Q?DmUP7Ryoe0SPqzAkkRBfYuUADxTCWJ69ccyk1Em8ZbvZVfLQn5Zzh0KnOGck?=
 =?us-ascii?Q?efa8wQTtHth8n06Ufn1qhe7Jh8v+NoWB26nUJrfHw3ogh5z+1ClzUGcTmso5?=
 =?us-ascii?Q?TrElK9uBO5cdsfsg0/FywncdojkQJKYtFUTDXUF9ribjNN+/IZu2cWvH/oL8?=
 =?us-ascii?Q?o//ajFbm8HjypWlTl3aEWA4YbENeIZZbNZpDk3q6VCweb49BzI5A1hlFK8rT?=
 =?us-ascii?Q?IHJSZNvNXQab0Q3ZD6ITTndPIuWMTK0BhjdkEI25LIa4UZU1ufVt1cJvn1St?=
 =?us-ascii?Q?0rEBXXwn7BHQdy8DU1DwwGUhotm71JXiqL21m7PnQlIDTUEq4QVRKN3YuF0x?=
 =?us-ascii?Q?1LCQqCLNOCytKyATNifTLdyJr6qnZbFmyqF2tNwvMoQtesNF84G7scBNiTgU?=
 =?us-ascii?Q?d/Dt7Pao4qs76aLIMuvIHzBOKxlPagel9Pn4Tr97lUMnhnlfJNLZQ+zRHTg+?=
 =?us-ascii?Q?TBEiglMfovrg4ra4qmFxKuXSs8wO1IyonhJncW5qV5GJc+riY95KowubWwwX?=
 =?us-ascii?Q?j6lCCQtplcmD8+vpCnMF48cTovbnX1EfG/RhVx/kPWmrzXXeHuk5Vip9tiCa?=
 =?us-ascii?Q?4HDHHMBFOdIqe1VHbCy4qAu7BgeDxldu8h2Lu7aSdZP7oJW9UFwrMQqtiB91?=
 =?us-ascii?Q?EgvO+3dIr1atiTSUH7JmhSbuRIeAOAaCUxzUaAEedvY4GfPZc2GSAT1WhjQz?=
 =?us-ascii?Q?9oZQl/UwGu/8cnUrpH9AGLWpmCt3WcTguE9Bjyni9KPR78OZzqmuZmif1q3y?=
 =?us-ascii?Q?TKyGX4L44lNaKaaLWMhv4AAS284zqbcsjdb2IK4055R25ziBA6L53CV6qmLH?=
 =?us-ascii?Q?uEP4XyXISNYUKoALWWPymfuqzDKNWklJ0XesaJo40k1e2RzbpkTjStgQlza0?=
 =?us-ascii?Q?elRv/XyOcUebDo5J86JjvD6Hv97cGqkpDUyXXXjUkUqTDDGcYiMKxfGfXsFp?=
 =?us-ascii?Q?pXHtgdoKKptYztZNjDiUqaA5jBO53XLTBqiQtuN0ssEAJGLfgzHgzjQGPRCI?=
 =?us-ascii?Q?U03LsaR70KPHLDJVl6PLTuA/O0a4VeyHQJHLZV3EVIQTMSbDDSepORRTAPpL?=
 =?us-ascii?Q?KXYblcY2WL6O+hAVLz4TPsHxHw0+SdsGHGRporiLQt9akrf/fhi8VYjsOiuE?=
 =?us-ascii?Q?9K0gxvEywfEFLfu7mZbNMfL1bkWL6TriSiYHauRPHkh3w3Gia7ZYUixjZk+Y?=
 =?us-ascii?Q?k3ynPikptHqWC5S3fJHVSRvOykw8qaBT3lkXtwklFQzBke8gHuR8KnDUKwq+?=
 =?us-ascii?Q?wip5faS78ofen2AELVpjLp4MRs6YIKYHNb0+XdWZHj3wVybVYkOcXzN2K6V6?=
 =?us-ascii?Q?zV/FdqqXL+i0/gL8fJSct27QNdTdAAFuYoEX4LwMg3y+MGthU5r3kqrmIcwv?=
 =?us-ascii?Q?rjkxHSmRucjN2VTd0gKisM2hBANnzj7BpbIJcsZt4f11UYGc28jj84VBDZmA?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7781b5-0308-4bd7-6083-08da606549e3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 22:08:57.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDQHz2ntwbdpwtU+bASkoD1WvpfZg4keFXmqvhGmmsTWzXSKAhxKsilGOIKbXyzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5079
X-Proofpoint-GUID: 7QIa0hDpNbsWj98JXdUUFt4cYmEM-cNd
X-Proofpoint-ORIG-GUID: 7QIa0hDpNbsWj98JXdUUFt4cYmEM-cNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_17,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 07, 2022 at 12:18:33PM -0700, sdf@google.com wrote:
> On 07/07, Martin KaFai Lau wrote:
> > On Thu, Jul 07, 2022 at 09:02:33AM -0700, Stanislav Fomichev wrote:
> > > Syzkaller reports the following crash:
> > > RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
> > > RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
> > > RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610
> > >
> > > With the following reproducer:
> > > bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3,
> > &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"],
> > &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b,
> > 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)
> > >
> > > Because we don't enforce expected_attach_type for XDP programs,
> > > we end up in hitting 'if (prog->expected_attach_type == BPF_LSM_CGROUP'
> > > part in check_return_code and follow up with testing
> > > `prog->aux->attach_func_proto->type`, but `prog->aux->attach_func_proto`
> > > is NULL.
> > >
> > > Add explicit prog_type check for the "Note, BPF_LSM_CGROUP that
> > > attach ..." condition. Also, don't skip return code check for
> > > LSM/STRUCT_OPS.
> > >
> > > The above actually brings an issue with existing selftest which
> > > tries to return EPERM from void inet_csk_clone. Fix the
> > > test (and move called_socket_clone to make sure it's not
> > > incremented in case of an error) and add a new one to explicitly
> > > verify this condition.
> > >
> > > v2:
> > > - Martin: don't add new helper, check prog_type instead
> > > - Martin: check expected_attach_type as well at the function entry
> > > - Update selftest to verify this condition
> > >
> > > Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> > > Reported-by: syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  kernel/bpf/verifier.c                              |  2 ++
> > >  .../testing/selftests/bpf/prog_tests/lsm_cgroup.c  | 12 ++++++++++++
> > >  tools/testing/selftests/bpf/progs/lsm_cgroup.c     | 12 ++++++------
> > >  .../selftests/bpf/progs/lsm_cgroup_nonvoid.c       | 14 ++++++++++++++
> > >  4 files changed, 34 insertions(+), 6 deletions(-)
> > >  create mode 100644
> > tools/testing/selftests/bpf/progs/lsm_cgroup_nonvoid.c
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index df3ec6b05f05..2bc1e7252778 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -10445,6 +10445,7 @@ static int check_return_code(struct
> > bpf_verifier_env *env)
> > >
> > >  	/* LSM and struct_ops func-ptr's return type could be "void" */
> > >  	if (!is_subprog &&
> > > +	    prog->expected_attach_type != BPF_LSM_CGROUP &&
> > BPF_PROG_TYPE_STRUCT_OPS also uses the expected_attach_type,
> > so the expected_attach_type check should only be done for LSM prog alone.
> > Others lgtm.
> 
> In this case, something like the following should be sufficient?
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2bc1e7252778..6702a5fc12e6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10445,11 +10445,13 @@ static int check_return_code(struct
> bpf_verifier_env *env)
> 
>  	/* LSM and struct_ops func-ptr's return type could be "void" */
>  	if (!is_subprog &&
> -	    prog->expected_attach_type != BPF_LSM_CGROUP &&
> -	    (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> -	     prog_type == BPF_PROG_TYPE_LSM) &&
> -	    !prog->aux->attach_func_proto->type)
> -		return 0;
> +	    !prog->aux->attach_func_proto->type) {
prog_type check has to be done first since prog->aux->attach_func_proto
depends on the prog_type.

How about a small tweak on top of yours ?

	/* LSM and struct_ops func-ptr's return type could be "void" */
	if (!is_subprog) {
		switch (prog_type) {
		case BPF_PROG_TYPE_LSM:
			if (prog->expected_attach_type == BPF_LSM_CGROUP)
				/* cgroup prog needs to return 0 or 1 */
				break;
			fallthrough;
		case BPF_PROG_TYPE_STRUCT_OPS:
			if (!prog->aux->attach_func_proto->type)
				return 0;
			break;
		default:
			break;
		}
	}
	    
> +		if (prog_type == BPF_PROG_TYPE_STRUCT_OPS)
> +			return 0;
> +		if (prog_type == BPF_PROG_TYPE_LSM &&
> +		    prog->expected_attach_type != BPF_LSM_CGROUP)
> +			return 0;
> +	}
> 
>  	/* eBPF calling convention is such that R0 is used
>  	 * to return the value from eBPF program.
> 
> > >  	    (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> > >  	     prog_type == BPF_PROG_TYPE_LSM) &&
> > >  	    !prog->aux->attach_func_proto->type)
> > > @@ -10572,6 +10573,7 @@ static int check_return_code(struct
> > bpf_verifier_env *env)
> > >  	if (!tnum_in(range, reg->var_off)) {
> > >  		verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
> > >  		if (prog->expected_attach_type == BPF_LSM_CGROUP &&
> > > +		    prog_type == BPF_PROG_TYPE_LSM &&
> > >  		    !prog->aux->attach_func_proto->type)
> > >  			verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks
> > can't modify return value!\n");
> > >  		return -EINVAL;
