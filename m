Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DCC56AA49
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiGGSPR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiGGSPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 14:15:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653F27FE2
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 11:15:14 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 267EfeD6028471;
        Thu, 7 Jul 2022 11:14:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=v+/IjJ6QmibxEVITXz2LS/stv7x2SbG6GjoQnsu3wEc=;
 b=awi726n+tWtM4Dnub0fxj5sq9pNRaKpDrPnDPHSSE4ItgRmkR1XFXP2P7DoXSsV/2fz1
 2k4P06Tk9jJ4Hu5Oup9d8NkkE1PfVuhfOdU60XIf1Mw8UkvZcjmaxQweNr417Lqp2SnT
 /B3BAcaEAlsylBh7nvWlqjAWE06pM3nCp+Q= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by m0001303.ppops.net (PPS) with ESMTPS id 3h5yeqjhh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 11:14:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgmhXTy7cI37z3IKQDAV8Q9KhL1Nkc6sdyPEVgoGLNl69IpFHmD8sbYT2UtBnBc4zA9f55QmtBnyLbdBqzvd7+X1CdKhIg5Y6NhTtJWMSJ4UPrG+sx3A+2voSNt9zXN4wicmGuIg8/cJOA03jnJLyUu0T11xC7rTZiGH2be8Hr3OiYoRwMaXY4qQFT/y5c074icn3sKiLXWlRa4mCkrHrQgG3GZ2zksmmyAEzCXoGs1rFKdrq7M0VWZwJJJzV/xMk/7BO48965w62Vn2mtI5rDEA7n5eurFzrKy8ETb9AT7RXN9mjzvecZ2EnztmZE0+tPsjoUDybnYTqUwvvddUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+/IjJ6QmibxEVITXz2LS/stv7x2SbG6GjoQnsu3wEc=;
 b=SbYa54EL5Uj/FFa+7BeOOgNM9/h7qFYbCwkoq6SjHKWPJeDaFCctcSNwiVxyG2uYObVl1M9uMTpj5HhbayP5RBxgUOS7Qz8SFukvc1QtA43vl8A9W0pi0LDs6tLTs19cljjBX6kZyDRb7uRuzjOIxAGOtDUaIROrqYU1XzTtH5oxtHcLM6tKwK5Y3adn3u5y04GaffIMrOhbYbj6vjhx4oI/8RBAyO2FtmfoUFBQLxy5nw78ZSHBJEW5U3m/36TKGErdVqb7F84eLY4b27ixM+WyH/lvSyghSRfeFGOiQobpDWQkfLBiKs4yo6vpj0n3C9glmISfqSUrUbOaecUmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MN2PR15MB3599.namprd15.prod.outlook.com (2603:10b6:208:186::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 18:14:54 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%6]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 18:14:54 +0000
Date:   Thu, 7 Jul 2022 11:14:51 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v2] bpf: check attach_func_proto more carefully
 in check_return_code
Message-ID: <20220707181451.6xdtdesokuetj4ud@kafai-mbp.dhcp.thefacebook.com>
References: <20220707160233.2078550-1-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707160233.2078550-1-sdf@google.com>
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 457ff17d-c691-4643-a9cb-08da60449795
X-MS-TrafficTypeDiagnostic: MN2PR15MB3599:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+A2Zhg4V9kbB5D2ktmRxrDSzN9iLjuRBQBFmUS0+hkMz0Az4VBpnU7SBFoBKV/CeVvvSUII4UNR98wKMg7/8xho1rzSCUwLl28OP820xXT8Kz8/YDADBwvpkhMfI/gHmVKpdvLTLP1GcNXf/z+1VLWG0iyZB9b56em9yp1Qf0OAyYXWr38ECN4bVo/kMo/E1vutZ5ndO1zMa5XJdRwoneMCi9gmh0jdPRJ6S9OurVcjSaSbGwf7QryHWDzyAb+j3evRI4Y7IQCqrifUEZdtdVVXEAObkS3dJ1GkaPiPpRFa+Im9bZTUk9GBWt6eERoOwvB+Rp7jE3l/bVZWjrelNoeWOAWsiaW7CW6iKm8iF3aWy3+nCLbESTqUftOi2Gf8gZRikwXURhO7ax9ZQXHW0t3I3MO7vYc1kQLfk5nuYmXoM24dTUgmyV0drMAjNRHkx8xIxAWWyhNYp1tMKH57sQ11q2iAWa2hqo7owudi/DSb7mtbOQoJro+rLjijoBvu7Q1k/RJVX4T5k2He6kPhzDyijW/d3ajNtVBKVmHiBrZkNmaKvIVh0CM8AXdypH1bG+Z7tkjqSFdq9blwNJolMnC2mS9buyDpt3SNv5osy43pJo2jjrOBHSa5nS6SZ4MlFYQLNR8imCOyR6mY2iZ2WAWmk8lSxKHlnI+AzAP8G5KZ9hmTOZBR/kHNq7ExIiQ7CAKR2T4Kgrg4zFf+sjpNvIa/irtDrs55tKBbHaO64d+p4sPkacz/JAk3iOirMzLU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(41300700001)(2906002)(6666004)(7416002)(186003)(6916009)(83380400001)(5660300002)(8676002)(1076003)(6512007)(8936002)(66946007)(4326008)(316002)(66476007)(66556008)(38100700002)(478600001)(6506007)(9686003)(86362001)(52116002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S3+fJCG4tQ0Y9/VTV3pSMCSZuuXtI6D8+qsWn0vL0l3oOXegSByxRqXBnVFu?=
 =?us-ascii?Q?IQDmYcbS1AoXdHBWz793CmQsiciOenfwgbTkCDo/8EyQDKTUpdt55QOTYCvu?=
 =?us-ascii?Q?trUFpMWpYYQWcTWVv48yWzxoBn8OuIqIHELl3bxoUIjzIl1PSlhicIpRVJ4Y?=
 =?us-ascii?Q?7J6StvJQ9Ct3c+uBzgGjk18N34qo0Idl9kDleFX+bwfixc+moGhonfoZ09V9?=
 =?us-ascii?Q?uDXJ5hsMBQMuP4m3jVR+3CDgRsabxzDl71vULnQyUqmvf9Y3KhlWH1EFiAGd?=
 =?us-ascii?Q?KokhjSSn2feXSI+ACYvrxADIG7hsfYDG3wd6PFjQTK07VxzwUFuY/X2JbWl8?=
 =?us-ascii?Q?eof7bNNTWNubD7YTFMkxjRUjzGw3rd+TG8A+puM7rcz0FliwLCTwvHLv1/pZ?=
 =?us-ascii?Q?vlKA4MOsSXl7KzLtbyJb+BEh1MP0Z7MmfXLxVNXkx03gXMXBzgD8d+dq6hsu?=
 =?us-ascii?Q?FCpmZB9Jdbzfoeunz2PeYtuS1iPcyUKg7zPk1ofWh7nwX5WBFaEU77+zh+9a?=
 =?us-ascii?Q?hbFF5BnSV+5daAufeH/uWWxMo23NZ4zWGzD0sFwaYX5t0Bbc5uxnrEye9l7z?=
 =?us-ascii?Q?g1XR8phkHaMu0B6neb5lPY7GU8uDFfYoZZECuiUOHjEJDY9fOSQHofpUZaMp?=
 =?us-ascii?Q?paxamJPaek8mwsQqdbx/uQRfjXOu17YXXKGClcau7V2b6I3+pvg65994swV+?=
 =?us-ascii?Q?qCOucpPCn9cBLir7daDVdvJqVwoZjN+OccqBPnJT0GSbEPrJzQYx2gEAy32c?=
 =?us-ascii?Q?Oq69Ta45LQvmbxQEttW56DBa+yGw4QKO/RyUrON9It9Vln9/mZhKrF+McHsa?=
 =?us-ascii?Q?2NcZNk+N44eDCpwNyMEqjBHDUrE00R+Fgw/kgBSS/OzTOLOEicHOq+f3RMHV?=
 =?us-ascii?Q?MMwIc17+I24OzEhPZHTz0zz1YxmcOyp00NKO6jwRs2Fv4IVxK2UqaVMLQoM/?=
 =?us-ascii?Q?hakUp9DF4ibLVKLtJKgerC3DsJ67hYKM5xuqxMTddFyBonePwHKWo+BUbCkJ?=
 =?us-ascii?Q?91jARtoi2oxVGar4SxDkXzam+MgIDff8/LGkFRgajaIpA947J6Wvk9iM/7O4?=
 =?us-ascii?Q?ijd1DPgiw3pvqXyS3qlQiKKVNl0wWUVoNXhbOwbPvkFSyOgI32u3xqOqteJW?=
 =?us-ascii?Q?IiozcpttB8/v55YLcUbwkIh1Opu0QyY95z1b9kLDBc0OuliAD6A1PkkvKTyb?=
 =?us-ascii?Q?os8X1TIIAA8GzMnxX7zqjBd7HL7O/mCsIxsFSBv2muIUnrVtjUYEd7Bgq3Hc?=
 =?us-ascii?Q?7t9hhZ3t0lDfOZ3lJwI9oIqaMMnlOhqlj94OZFOa1FnBN+0JRMUjJIX5cIgp?=
 =?us-ascii?Q?flHzxwTELu5uCzVa/Ly0y9gLJRCPiUGt6iMORL/hTaxpViiWgmhW4W9VqeQA?=
 =?us-ascii?Q?ttH+8b1g7VUPabzOEXV2CieNY4o+bCiO6HdIP/EcJPjabNYzrZzDxg8y/86N?=
 =?us-ascii?Q?VNNn++lI19eQ791YxdpzErBdm0BEcgBJy3R9dAR69io4pwKetTK+yPUb53rO?=
 =?us-ascii?Q?ub309yzaad/AxBcZUhB0jvRa/WFPHFmhfpFTRAYecZED1+6sytziPMZwaNOK?=
 =?us-ascii?Q?RXREO/mR30F0P/EtIKQGjAtGAiMlpDhCFbqZHtpcHYsFtUGyHMmjvFN6dnsl?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457ff17d-c691-4643-a9cb-08da60449795
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 18:14:54.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhBqAruLPlAxEaOa6KrWC8tSU3+eitok12BIA+itkzUzdxZ9XR9e/2caROagGMMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3599
X-Proofpoint-ORIG-GUID: EJG2zABtNd48PENGM2eWJzMIGtV54UO5
X-Proofpoint-GUID: EJG2zABtNd48PENGM2eWJzMIGtV54UO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_15,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 07, 2022 at 09:02:33AM -0700, Stanislav Fomichev wrote:
> Syzkaller reports the following crash:
> RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
> RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
> RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610
> 
> With the following reproducer:
> bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3, &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"], &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)
> 
> Because we don't enforce expected_attach_type for XDP programs,
> we end up in hitting 'if (prog->expected_attach_type == BPF_LSM_CGROUP'
> part in check_return_code and follow up with testing
> `prog->aux->attach_func_proto->type`, but `prog->aux->attach_func_proto`
> is NULL.
> 
> Add explicit prog_type check for the "Note, BPF_LSM_CGROUP that
> attach ..." condition. Also, don't skip return code check for
> LSM/STRUCT_OPS.
> 
> The above actually brings an issue with existing selftest which
> tries to return EPERM from void inet_csk_clone. Fix the
> test (and move called_socket_clone to make sure it's not
> incremented in case of an error) and add a new one to explicitly
> verify this condition.
> 
> v2:
> - Martin: don't add new helper, check prog_type instead
> - Martin: check expected_attach_type as well at the function entry
> - Update selftest to verify this condition
> 
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> Reported-by: syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  kernel/bpf/verifier.c                              |  2 ++
>  .../testing/selftests/bpf/prog_tests/lsm_cgroup.c  | 12 ++++++++++++
>  tools/testing/selftests/bpf/progs/lsm_cgroup.c     | 12 ++++++------
>  .../selftests/bpf/progs/lsm_cgroup_nonvoid.c       | 14 ++++++++++++++
>  4 files changed, 34 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_cgroup_nonvoid.c
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3ec6b05f05..2bc1e7252778 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10445,6 +10445,7 @@ static int check_return_code(struct bpf_verifier_env *env)
>  
>  	/* LSM and struct_ops func-ptr's return type could be "void" */
>  	if (!is_subprog &&
> +	    prog->expected_attach_type != BPF_LSM_CGROUP &&
BPF_PROG_TYPE_STRUCT_OPS also uses the expected_attach_type,
so the expected_attach_type check should only be done for LSM prog alone.
Others lgtm.
	      
>  	    (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
>  	     prog_type == BPF_PROG_TYPE_LSM) &&
>  	    !prog->aux->attach_func_proto->type)
> @@ -10572,6 +10573,7 @@ static int check_return_code(struct bpf_verifier_env *env)
>  	if (!tnum_in(range, reg->var_off)) {
>  		verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
>  		if (prog->expected_attach_type == BPF_LSM_CGROUP &&
> +		    prog_type == BPF_PROG_TYPE_LSM &&
>  		    !prog->aux->attach_func_proto->type)
>  			verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
>  		return -EINVAL;
