Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B5652540E
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357273AbiELRtj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352172AbiELRtf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 13:49:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3348A1FB543
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 10:49:35 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CH9d4Z004321;
        Thu, 12 May 2022 10:47:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=onswTp6h3Im54FXea0cwrZ5Cxy+1hPH34Fu8xSlcDI8=;
 b=e15iIatB5pqczLf7UDSCdFWBe5uqM+M86i2+QTLTtRm0gqvQDs1DYosl48HizOEVlzde
 H9dtDALQQaz5P7N1ssdjW/Yl+fJu1ivySDF2NuumvcwVmCc6YZRJpVQaNUaeZ+2gllph
 7D/gm27FQ/y7wx0yFojHf3zNGpFywKDcXe8= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g12mtj51d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 10:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmPBwQiIvEIEO8kpYlmizpFmO1Kqs0TLJ7ixZayJtMj/DxbAR+JVKt6U1PcSVYm90AGurxQYFMi7t50tWTGFha1LaKHLSlAiY6raS8yViLHza4JCa//GHlugbKfyxVj/PjB5ixZH0IylOsJt0t7vUZjHKelQLTEvvRWWv7+RL1byqZXG5uw+PMQuuwT65lmC2hNr6p+xeOcwh0D3zkDKW+OQxVvPsgsxf/IuCIPt9tbzfK1dSpxaDLQ5l3AoxUz6ETslcJVTndQ0CRj7o+9aoqH8akLSUuzTleC1Xzaq0aqHp9vwYlZIsMqMNNuFjYN332ajKD+7hxoHN0/aJ8qhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onswTp6h3Im54FXea0cwrZ5Cxy+1hPH34Fu8xSlcDI8=;
 b=nk29vqM3dNZpq/OJvXZG1Hkkc7Q1vYCLFtvav6T2nzmcLVTfCN34YHkyJh1/1zTBXbn9JO36h4NJbUB2ikgCBTUYfKPYoivPJDF9AhiYBfDLB+GxD1DhbyY0thnsNJPlkk3Vi89M/LYw4LTTRYRvXUuJJjY7DD5BdO6QJBnjISWbEH5LfyaFmwGf0BAuy2f2cPwxAWedlRoNAJarUz+/XWHu6UH14Fj8OFMzHZWefoqGzWIs+X+MiRhtD99lWdNxTMXunKcPGrWvjo5LNSbfX4hV8BIXHD8gVNyren9ztA//Dz3NDMohEraNHUni9KjbJDcWiRdyy0zlIJsRt0wuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BN8PR15MB3188.namprd15.prod.outlook.com (2603:10b6:408:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 17:47:11 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%7]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 17:47:11 +0000
Message-ID: <5ae1f223-4be4-bd48-e44f-fb4ef52d9a5b@fb.com>
Date:   Thu, 12 May 2022 13:47:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [RFC PATCH bpf-next 5/5] selftests/bpf: get_reg_val test
 exercising fxsave fetch
Content-Language: en-US
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, kernel-team@fb.com
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-6-davemarchevsky@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220512074321.2090073-6-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::34) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44f4734f-ffda-4014-03af-08da343f7125
X-MS-TrafficTypeDiagnostic: BN8PR15MB3188:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB3188D117D251F9D9002BFE82A0CB9@BN8PR15MB3188.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ga0uMq+fApz4l7STk6opitzShpoGli1urglpq4sY/IRobKrE6W+AApi4BhXhbkeIa7zER8qQJn71Dy/K57z5k0IgWVFipPLK3CY45kEmXDAudOzSk0ced6dHoNUHVK75viEx6oSvgbhfOK5r9nklT9RMD5k5LRjc+piThAQbK6DHShZuAXQMO7H7dpIXnjRWO0gu4wY3zzUsKg5UeFQvVLWepYepTh8ZTkY57aAtqK4ojFA7lw1DDWOQPqprbfKDz0oFmPbrDXiEtejiZNFLEOGsqqj/xzNQjC3kldbKuVVAnmH76zkxbOt6gTap5Q46e84nTMz2K6ye1JtVn0L9F4qiCX2Qkc6SCaQ1HMEXlq6Ihr15M5K6m8d9QOKtgUqxyO+uUvdEeTsK5B4srkxY8dGGk1vXD/SXVnb00tDrU1+eE461T2gKwmBbe8xsFl7Y0/CJA+UW8yGthiQA9PLzQpHmxW7JqqV4ChHbpWarBFp5MeUuEKuhOep7yH9al4b+A7+dDYopsDfNpFP6GX97W9fOf7aDbCMEVSSChgAbuqtCtDE/YDV6qlQ6I63VmPYBJqDMI8OF/rtenvG9ICNTgRvUPh8cZjNA5o/rgQYsvHiEwg6POxxrrAzXuA9sq7dgNHEz/neYvxNNZdVWa4nUEUpMZ3DKgjXDaIcN7l9UX0zFnWfSPx71ILem7Jm93718CqMwFmm2s5Ntgn2HH6rRvnOIm+JgVEkgfe6OmfE7rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(6486002)(2906002)(86362001)(31696002)(8936002)(508600001)(6666004)(54906003)(6916009)(6506007)(6512007)(2616005)(31686004)(66556008)(38100700002)(66476007)(66946007)(8676002)(4326008)(36756003)(316002)(53546011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFl5N0hSQnBsdkxzS3QzQUVCR1RMNGVUcFJyajNXUVhGWStaYTJ4NWhMS2cz?=
 =?utf-8?B?MmpOaHZ5Uy82RElZazNGRWNxNm0yWHJJRTNKQ2ZOY1E4blRyOG1hZ0NLeG5B?=
 =?utf-8?B?SUFmeS85MDZGdFpTNk4vUHRXSjJXaUMrRXJnUy9jM1R1UUx2K0NOREg3SEdz?=
 =?utf-8?B?dnA5QTE1d3FaWlZOWmFTR3plLzZBblJmRFEvQ0tSM0NOQ21YR0s0K0pIVDdP?=
 =?utf-8?B?MjBPd0VJUUtIbEVMYm5jamNGR0hMVGh5NFBjbzhJTTlYS01ocFc4dmFwOUJL?=
 =?utf-8?B?WHRGY3hPeUZxZGw2TW5sREhEQzhnYUxjb3c2ajlEUm5Ec3VGVkNiU3RpN1BJ?=
 =?utf-8?B?ejh5cEhpYk96SHg5S1BWOWNXMHo4c2NxVzdPdTFpaHdvODRSdlJmU2oxVGY0?=
 =?utf-8?B?RUFmU0lZT0JLdWdvbW5ZcU95WFdKWU9zaE1kRzJkMzhWdy9DcXF4LzAwNy9w?=
 =?utf-8?B?REgyT1FlU1JENis2ZzNNWGE2b2JJWXZrU1hqcURTTm95NFNCTWdHMTNwUEdB?=
 =?utf-8?B?U1gxSTg4SG5HQXBJMUgvUCtaTnFWZktYRWlCRFF5YXRoTml1T2kxUzVKcml4?=
 =?utf-8?B?cjJWMTFvL3ZUdFhKRE5SWEpvd3Vnam1mODZZSzNzK1U5WWNIT0E2bFpDNGRE?=
 =?utf-8?B?TXRBZi84TU52U2l0UWVnU0pkS2ZCaHBmU0sxdkU3Y1ppQmFTQ3FRbDFNc0F5?=
 =?utf-8?B?N0dVdmVlb29Td1pBQUEzTzlyMElob3krY2daM0xCczAxcmFFa29tTFk5V016?=
 =?utf-8?B?VXZJZkpuN2wzUm9LMC9wbFUxWkJrZ1E3NThlakpTeE5XTUdubjI1RGdWdUlU?=
 =?utf-8?B?NUVnUFpIQlNZRllzaFJzUmtRUUFhejdDUG0zTUJWalBJRTFKamNwZ2prQnVr?=
 =?utf-8?B?OUJNRXAyRWNDaXV4NjN4eHpQVFp2SkVYd3BlNXFXdzllZWVQdUFNbVBSUEtM?=
 =?utf-8?B?VmNQa3A3ZjJwK0FSR01OaExlMVc4RVFOM21rcFd6bmJhVHUxajZMMkJnU3dq?=
 =?utf-8?B?b0tLdXVZaS9Ib3NCWjNsa0FoMjlua3pDUE1iaXBBTURQWDBDUTFVS25Sbmkr?=
 =?utf-8?B?a3lPQmtxbGtzc2h6bXRXcDNrSHg3OGxTQmVVSFZKbUJPSUN2NDE3djVsY25r?=
 =?utf-8?B?b0JudTNJZEhTS3JKWEVndUVueWp4MDI1U2tIV05RMldmbzJ1TEVTMDZYUEdz?=
 =?utf-8?B?VjlMaFVlUkpzUWZGcUwveE5ldXEzNG5IM1F2UXVwdHE5ZUl5V0VCL3FsYTRx?=
 =?utf-8?B?ZjZlNWlLZmplYTYxUXI1VXA5VmxuaWpDTTBsTGNGN0xOY0FNK0kxVVRubDFT?=
 =?utf-8?B?eS9UMVg2YjhLQll5eGpEd0tUei94dWl0MjcvNDVYbXMvMGNPRWZkcFEzUFV0?=
 =?utf-8?B?V3plU1ZnM0RJSmNjT1pGMzNMM0J2NG5HeDNKUDlOSEh5RTlCaTZOYTlNbk9Z?=
 =?utf-8?B?QXhyc3pLQ1NzQWlPRlNPOWxRQVZMaWRUZTJsbUJ1ZUtTZ0Q3SElOdWpaYzhZ?=
 =?utf-8?B?NkxTSWVDNzB3dEwrSEJYT1N3U3hoUEc0dXB5UnpmaDkwYlBoSGQzb1J4Y09v?=
 =?utf-8?B?OVROWmpQaHZzbERGS3c4T0srUUFiVlVTbks3SStaWU96TUlZem81YXM0MmpW?=
 =?utf-8?B?aEsvaFMzWHNwZkswKzUrbmU5b2MzV0NPMjhtaldUeFJTenpOSVlSODVjVkM1?=
 =?utf-8?B?bk8zRm9mSjZBMVJMWTFLamI5OEpWb1VmaVNPTEN4NXVCMHQyTFZXNXVXRmgr?=
 =?utf-8?B?bitVUEhrdWdIZyszMXRHVS9ZZzJjRWFDaGcrbWFjcW94MHpSTGVkdFZBMTlS?=
 =?utf-8?B?eWFJYVlXN0xtR0N3QzNBNDRMb21KU3lGamVyM3Q3TW1NTDFwUWMyTEd0UjJj?=
 =?utf-8?B?S0JvYWtqMnNTVUFuWnQ1MURCQnFSclJGSUVJcUpEQWNpZ2FIRHEremhibmJT?=
 =?utf-8?B?SEVoNE5QK2lQSXVRWEQ3UEIrS05sbHJaNU4wM0pIMFNQZHZndHJ3U1BlMXBU?=
 =?utf-8?B?QmovdEgxRFNoektCeUJnMXRoaE1wVjJ4QVloWE01YTVNcGhrUXczUTZvNG05?=
 =?utf-8?B?amxiRlRzQzY4TmMyQ1VsY2FQV3M4NXU0cEVRR0tuVzUvOHZyUjZlUVV4YmZu?=
 =?utf-8?B?M3JBbExraXFqVGI4aXVtK0NSZXZCUlVib280bXlNZDNUSjZ1bGVzWXlNR2dh?=
 =?utf-8?B?K3lHZUZMRTdzMFB4WlpqczY4R05Ob1RLRzRIMVllcG5GbTlQYWlVK1laVUlH?=
 =?utf-8?B?a1ovRFo0OW5SKzQzNlhxTm1xSlEzTWJ0YjE0dXJSQmVuQ25MZUlQd1pLYmln?=
 =?utf-8?B?ZDlRaGNSY2ExMDArSVEwZUNtN0oveG9wMitIQnhxbmpkTjBNemQ4MkVLV1Z0?=
 =?utf-8?Q?1wuDdKtqFDkP+fsFfJb4UNrHPpD/g5gTFx99P?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f4734f-ffda-4014-03af-08da343f7125
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 17:47:11.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrS2IL8x20NrdRe1k16xSfphBx7UJcFWaladDJRAiqSIrT8GPi1lAK11S3Lb/EI1wBV/a+DvbOb343yBAIvnjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3188
X-Proofpoint-GUID: dCO7HPDbuCq0Xs2MPbplsZENk6lsm-P-
X-Proofpoint-ORIG-GUID: dCO7HPDbuCq0Xs2MPbplsZENk6lsm-P-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_14,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/12/22 3:43 AM, Dave Marchevsky wrote:   
> Add a test which calls bpf_get_reg_val with an xmm reg after forcing fpu
> state save. The test program writes to %xmm10, then calls a BPF program
> which forces fpu save and calls bpf_get_reg_val. This guarantees that
> !fpregs_state_valid check will succeed, forcing bpf_get_reg_val to fetch
> %xmm10's value from task's fpu state.
> 
> A bpf_testmod_save_fpregs kfunc helper is added to bpf_testmod to enable
> 'force fpu save'. Existing bpf_dummy_ops test infra is extended to
> support calling the kfunc.
> 
> unload_bpf_testmod would often fail with -EAGAIN when running the test
> added in this patch, so a single retry w/ 20ms sleep is added.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf.h                           |  1 +
>  kernel/trace/bpf_trace.c                      |  2 +-
>  net/bpf/bpf_dummy_struct_ops.c                | 13 ++++++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 13 ++++++
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 42 +++++++++++++++++++
>  .../selftests/bpf/progs/test_urandom_usdt.c   | 24 +++++++++++
>  tools/testing/selftests/bpf/test_progs.c      |  7 ++++
>  7 files changed, 101 insertions(+), 1 deletion(-)

This series wasn't based on latest bpf-next. After rebase, this test
causes kernel panic. Investigating, but patches are still worth a
look.
