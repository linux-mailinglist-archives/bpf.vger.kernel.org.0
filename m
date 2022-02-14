Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5514E4B4D60
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbiBNLHo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:07:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350159AbiBNLHg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:07:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A689FE2
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:36:51 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E84RSO029601;
        Mon, 14 Feb 2022 10:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MUvDdBt1Nxg3VMh+a0VXXlIVplgYaVKCIc1/Jkhkqdk=;
 b=Lhojz5MsknZPgY5eJNSqi+wLjV5I8Rb82dM7ylYlv/3NI7+KcrYLUgtG6URR2QsdkBRg
 /91KBPc1fRIGUV0Ux4/qgcxT09POHGMnisz9D7dQumX9we33jNn/ZrkjCz+YDMCkpic7
 C7uOz5ZoTbAhC9AInlnoj0zPwsnG+ROZ6SFH1LcNDBaXMmmgszGsv/RQ+Rsl7DIcWR92
 QBcOkEjwj7JjPamXbsxSkoktCdm0QosF+odfh9rD50nP9OLuxUYqYi8C6CvR2EjgxGnf
 yJN+e5LSdYP2wf2oWySuMthZSYHswnRgiuk7nOd1kfSiwopOrCIAI8qBPzD/Oyx6ptHt KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63g142au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:36:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EAUOJp069814;
        Mon, 14 Feb 2022 10:36:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3e620vrbx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLt07qSC6qH/3+wdem/iGSNjeO3jLuHPUIHAyQJabY5tYNzTnNKQNiq8IZdX4ygdawytuBjNr3CIBstd9MZ5fUrcKWQaa3qB0oilwg436uvpPY7Bx9dcJMfE9l1g/7t8BDsG6dK/YcU1/v2FdrHTpgNDGGjEzCzzSRC1f72S/ZC3oNjRf5kvn9SdGdewsvSM1hEiHSVBcWLyW9Uv8HdJxSI79tp5+Xo/hUQcm/04ZdRaBqr9c1jAQMTOE32buw4+ekOojj6WWFjelM7nG1fs9OpkEwH/fLFd4rZFMYsSLvwPw6Z7GbnHxjIqym7Lry+dg0k2PT1vU8pa8pgYz7YQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUvDdBt1Nxg3VMh+a0VXXlIVplgYaVKCIc1/Jkhkqdk=;
 b=mTk0V/yhifsuC32iEI+lDaWBCr25818nXUuRKyrhPblCWhz+Bdqf+2mefluHtBRQTGBZ36dNezbjseIURAPUuQRiJQvZ0R8BLUwjRGkArPa48WvbHBSzjSMF1UIIBz5uXqpK7RkQjaD+WhGYc7jADOpJssIS2jj91oyBKwQx1Q4jXSuTvqxWef7sMN+Eag3L8plbeoKdPZVH0JXzols536i3FNXSG0JrlepgecJuP00b1/fGTn2ASrVC8v9tMDlpzSlFGvGyCcdwOoefTrCLtQZtvRZOynXOhbFeNGC+WGF8W/qdVZzTqEKzXybrYEDx2ifQ11tWSm4kC5hSXSHN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUvDdBt1Nxg3VMh+a0VXXlIVplgYaVKCIc1/Jkhkqdk=;
 b=XM//5KS8XTQRdRg4vGm3M2yiLP/Tu2hrO1prj0qUZzs0deQZ2QMqF2hr0/05iUFbwcvcTcsnCiZQVTLhybQZhfpsHX0ot2ynEjoyhawiHFX4V0PO/qlrB8xdXJN1wFzJpALeydhLSLcT+GcXo/dsG6iCB+DeO5CpXavvulpMoQM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5439.namprd10.prod.outlook.com (2603:10b6:a03:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 10:36:31 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931%3]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 10:36:31 +0000
Date:   Mon, 14 Feb 2022 10:36:16 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling
 selftest
In-Reply-To: <20220211211450.2224877-4-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2202141035540.9032@MyRouter>
References: <20220211211450.2224877-1-andrii@kernel.org> <20220211211450.2224877-4-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 467a0d7a-209c-4030-0ea2-08d9efa5dd5d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5439:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5439DDB71DAEF8D6A1137752EF339@SJ0PR10MB5439.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZUk5StvMyQ5qPFPmOCqN6lDWrRKFrmhAjFwzALPo2nClyIYKB1XQr6FF9w09x/iFJ2JanQyKY+FSoCoBEem5PMVOxxW6TP0/+AE20ie5l3/IAlZbAqv3+uT2XV2ccLU41Kzx0cJiI7suyWcK0zm3/9+F7VhNqyLd7QnGheSQi+7sDbo2HsRYzoLtTtJvOtNDYJeZlVwtsZpMGDNaJP3UnssJMjTPAIzz7wOtgX2WZQPf2UFcG0jwLSfyI4cQJS8PHbXWxXDajLdk2Oa8zH/+6p0lFyrBvVFKOkiSbpiE9WQCbIFE906fihjjHExXk4ZuIcW2xCfT4zL7KNaYrt+7q+cptzQBvfB8bR6we5riVkjVKWmEpSs9Gkn0sktxY5cMlmQ+UikMBour+ff27n+JilOSSW0uFyXww5SsWv/7nL4ciFJpCsDPzzsEoaQjG1R3ocnGF6ya0LdEdeelQP8eNDojknjf2DvrLOS6aa0Nh8ndKuvmzRLb44bOGN9Cd12LMNh6dwujF4t42EI8x1q1CAulpA0WSD84V+8jS05baBNs0wHrnZ3mMARztgKKaeEknMt/aeO69Q2ioOqypVOqbFtr3ROKLs62NZdxZ/2bbOg9kg3iatNyYsNZr2au6dN7zs7BtTROJRhv+P04aGYag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(6666004)(6916009)(38100700002)(33716001)(86362001)(8936002)(6512007)(186003)(83380400001)(9686003)(5660300002)(2906002)(107886003)(508600001)(4326008)(6486002)(8676002)(44832011)(52116002)(316002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzXzt3+bPbNM79AXMODidHXTw5JdoUZ2KpQemY6oV+DXd3OFEXYLYCUn5pVz?=
 =?us-ascii?Q?GQKrBH8z3WLuJkNpAclj0FneE9ieYvOhExbfiooGKVmCdYM46PyHKPxwkOMl?=
 =?us-ascii?Q?1RerdC/E5f7yN3Eo066iU7vHmbt7BaDis05hO9jydSQmReGCqWIMqvfRgeDb?=
 =?us-ascii?Q?KW+dOrVH79saqrxdPvvErbTMXqvdHKQBiuPRUfA+5my6sw35PKlGfCrXTVyr?=
 =?us-ascii?Q?6MeNxCiBvwWi4S3wxjtI51Hj4ezNjPZ+d4fc73vm6Tb9RlTRAUvNKy8KLrc/?=
 =?us-ascii?Q?sPuVW2R7MH3lO6EAmGlSStZntnoeOmBqb45d4YP5KZ5dlPwG3Xh7qazXP+vj?=
 =?us-ascii?Q?2bRvWRmZLUVWIXJzG5EKfIMpfIfYNb32zHUlJ2y0ZTJrtWgTCjjqYIP3NNhE?=
 =?us-ascii?Q?P7+5K9bu+UCjlL/Sb0GDmjsT8RuGzIrk5rd/I3qq1pvxr3S1y839ocvH58Tr?=
 =?us-ascii?Q?mx0qQMKWd4qeSmcU971iLn+sdJ9GgljGll3Dx3VQ1Meq/fRBsEyUEeovAe77?=
 =?us-ascii?Q?79KXDYbIrGLDpZZ8LxilbJzBAtW1pRPGAH0IdBbDHWP32yUVLEXSuUYdcTYY?=
 =?us-ascii?Q?WVCthFln3QYH++pSG/sIAGkINNqklrbe/T6VxsFrE5B6xpGq5wK3Hy1rfjuM?=
 =?us-ascii?Q?Cu1bOP5FqqS6BBjrpKihKdZWEJqW/4w6O7uT8olrkaIGypMKN3Gg+RbvsZb8?=
 =?us-ascii?Q?STU+DH49VL/l2o5zB/XL2SquDqo6/a41/Zs3ovlK9orRnmoWCu2Hr7OD7X+b?=
 =?us-ascii?Q?MGFw9SrdhOVn20KdK6J5+e+UeZQ7zy2np/OqfqybwHxntAtyiEwWL9B1Xsf7?=
 =?us-ascii?Q?40257sUB+uTuNVWNjMFTwtPcYoqeszG2tfEAkINw2mLF6aeFVHGjGjsJQ9Pe?=
 =?us-ascii?Q?oacVJQ/MGlgRqk2XDDS124FF46DP8/JsfOJyOvpULXq+TUNuWNoeWHkSKQ0E?=
 =?us-ascii?Q?lwgh0UuNYiGsDHQeiFYVSyzPp5KL5hKiKGRcx3AY3OGFQJvjtxlKtRMEFivU?=
 =?us-ascii?Q?Uff2R2tkEGnd/97sF3IW/NAIoqneh9TzEBiO30CzbSyJWFIk9rLiIDguTkvY?=
 =?us-ascii?Q?5GkUEll5JDByir1fiammjZCNcvYmhP94pEkn2e4BTztiLz4gx7A3M0xvsCPv?=
 =?us-ascii?Q?6csHlx6uEWuOzaGyGk0dv3kYobYk+3AkLNbVcmcwxTY6QruflxoDLmN7US7l?=
 =?us-ascii?Q?0SLX9+rt9RcoUbSFBiKvShe29O7ypd85nfGMDzU1XAwIDpvw0I/Zzv77pJAK?=
 =?us-ascii?Q?M778S/xvUJ/gFOT5t6m8xmn+mVhJSE/WvAdIntyoRbKmDR5eq6PEbCB162LH?=
 =?us-ascii?Q?7cwQIQCnXBpcDebCYazjFOQEy2j94DOwKcs8s5PDwpD/27+UW14Xi6slPkKO?=
 =?us-ascii?Q?EQkEhdsB7d9bDC+cbTtwZPHYVnPTeP5/CS6uh/NGGYi+sIOu10THXCQXO21O?=
 =?us-ascii?Q?SmzcA43EnBsGZtcyKFq98puXyv/Y2pKTp6Sbf6yhHhzH1a+JhtgNIN4LwG3c?=
 =?us-ascii?Q?Zg8YuVLEGRuXlj6snCO1gzN9XCpDr4jN2EhVnfHO0O2oobYaa6ASdbOiZBa+?=
 =?us-ascii?Q?XxGokYrJOQRaLgMwljfkK2ftybriVidcEM7igxNZgcmCuntF2UMgETStrD6i?=
 =?us-ascii?Q?meiEC/blxZzzVC3nNVA6PVtCe2u/7t0tdro1fMUK5CB4doQF4evyu13EX0K+?=
 =?us-ascii?Q?3lKOVA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467a0d7a-209c-4030-0ea2-08d9efa5dd5d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:36:31.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+0ZRKGm5madQE7Eqk9/5rQbT8nqIcFQMYuN35dECfAt6368b4GHrnRArVI/uc5r54iiP0pBRjWeyJXfbjerxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5439
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140064
X-Proofpoint-GUID: C8gSrEjp2V93KRbHwDsPUPutdE6kWBYQ
X-Proofpoint-ORIG-GUID: C8gSrEjp2V93KRbHwDsPUPutdE6kWBYQ
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 11 Feb 2022, Andrii Nakryiko wrote:

> Add a selftest validating various aspects of libbpf's handling of custom
> SEC() handlers. It also demonstrates how libraries can ensure very early
> callbacks registration and unregistration using
> __attribute__((constructor))/__attribute__((destructor)) functions.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for adding the additional tests, looks great!

> ---
>  .../bpf/prog_tests/custom_sec_handlers.c      | 176 ++++++++++++++++++
>  .../bpf/progs/test_custom_sec_handlers.c      |  63 +++++++
>  2 files changed, 239 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> new file mode 100644
> index 000000000000..28264528280d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Facebook */
> +
> +#include <test_progs.h>
> +#include "test_custom_sec_handlers.skel.h"
> +
> +#define COOKIE_ABC1 1
> +#define COOKIE_ABC2 2
> +#define COOKIE_CUSTOM 3
> +#define COOKIE_FALLBACK 4
> +#define COOKIE_KPROBE 5
> +
> +static int custom_init_prog(struct bpf_program *prog, long cookie)
> +{
> +	if (cookie == COOKIE_ABC1)
> +		bpf_program__set_autoload(prog, false);
> +
> +	return 0;
> +}
> +
> +static int custom_preload_prog(struct bpf_program *prog,
> +			       struct bpf_prog_load_opts *opts, long cookie)
> +{
> +	if (cookie == COOKIE_FALLBACK)
> +		opts->prog_flags |= BPF_F_SLEEPABLE;
> +	else if (cookie == COOKIE_ABC1)
> +		ASSERT_FALSE(true, "unexpected preload for abc");
> +
> +	return 0;
> +}
> +
> +static int custom_attach_prog(const struct bpf_program *prog, long cookie,
> +			      struct bpf_link **link)
> +{
> +	switch (cookie) {
> +	case COOKIE_ABC2:
> +		*link = bpf_program__attach_raw_tracepoint(prog, "sys_enter");
> +		return libbpf_get_error(*link);
> +	case COOKIE_CUSTOM:
> +		*link = bpf_program__attach_tracepoint(prog, "syscalls", "sys_enter_nanosleep");
> +		return libbpf_get_error(*link);
> +	case COOKIE_KPROBE:
> +	case COOKIE_FALLBACK:
> +		/* no auto-attach for SEC("xyz") and SEC("kprobe") */
> +		*link = NULL;
> +		return 0;
> +	default:
> +		ASSERT_FALSE(true, "unexpected cookie");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int abc1_id;
> +static int abc2_id;
> +static int custom_id;
> +static int fallback_id;
> +static int kprobe_id;
> +
> +__attribute__((constructor))
> +static void register_sec_handlers(void)
> +{
> +	LIBBPF_OPTS(libbpf_prog_handler_opts, abc1_opts,
> +		.cookie = COOKIE_ABC1,
> +		.init_fn = custom_init_prog,
> +		.preload_fn = custom_preload_prog,
> +		.attach_fn = NULL,
> +	);
> +	LIBBPF_OPTS(libbpf_prog_handler_opts, abc2_opts,
> +		.cookie = COOKIE_ABC2,
> +		.init_fn = custom_init_prog,
> +		.preload_fn = custom_preload_prog,
> +		.attach_fn = custom_attach_prog,
> +	);
> +	LIBBPF_OPTS(libbpf_prog_handler_opts, custom_opts,
> +		.cookie = COOKIE_CUSTOM,
> +		.init_fn = NULL,
> +		.preload_fn = NULL,
> +		.attach_fn = custom_attach_prog,
> +	);
> +
> +	abc1_id = libbpf_register_prog_handler("abc", BPF_PROG_TYPE_RAW_TRACEPOINT, 0, &abc1_opts);
> +	abc2_id = libbpf_register_prog_handler("abc/", BPF_PROG_TYPE_RAW_TRACEPOINT, 0, &abc2_opts);
> +	custom_id = libbpf_register_prog_handler("custom+", BPF_PROG_TYPE_TRACEPOINT, 0, &custom_opts);
> +}
> +
> +__attribute__((destructor))
> +static void unregister_sec_handlers(void)
> +{
> +	libbpf_unregister_prog_handler(abc1_id);
> +	libbpf_unregister_prog_handler(abc2_id);
> +	libbpf_unregister_prog_handler(custom_id);
> +}
> +
> +void test_custom_sec_handlers(void)
> +{
> +	LIBBPF_OPTS(libbpf_prog_handler_opts, opts,
> +		.init_fn = custom_init_prog,
> +		.preload_fn = custom_preload_prog,
> +		.attach_fn = custom_attach_prog,
> +	);
> +	struct test_custom_sec_handlers* skel;
> +	int err;
> +
> +	ASSERT_GT(abc1_id, 0, "abc1_id");
> +	ASSERT_GT(abc2_id, 0, "abc2_id");
> +	ASSERT_GT(custom_id, 0, "custom_id");
> +
> +	/* override libbpf's handle of SEC("kprobe/...") but also allow pure
> +	 * SEC("kprobe") due to "kprobe+" specifier. Register it as
> +	 * TRACEPOINT, just for fun.
> +	 */
> +	opts.cookie = COOKIE_KPROBE;
> +	kprobe_id = libbpf_register_prog_handler("kprobe+", BPF_PROG_TYPE_TRACEPOINT, 0, &opts);
> +	/* fallback treats everything as BPF_PROG_TYPE_SYSCALL program to test
> +	 * setting custom BPF_F_SLEEPABLE bit in preload handler
> +	 */
> +	opts.cookie = COOKIE_FALLBACK;
> +	fallback_id = libbpf_register_prog_handler(NULL, BPF_PROG_TYPE_SYSCALL, 0, &opts);
> +
> +	if (!ASSERT_GT(fallback_id, 0, "fallback_id") /* || !ASSERT_GT(kprobe_id, 0, "kprobe_id")*/) {
> +		if (fallback_id > 0)
> +			libbpf_unregister_prog_handler(fallback_id);
> +		if (kprobe_id > 0)
> +			libbpf_unregister_prog_handler(kprobe_id);
> +		return;
> +	}
> +
> +	/* open skeleton and validate assumptions */
> +	skel = test_custom_sec_handlers__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	ASSERT_EQ(bpf_program__type(skel->progs.abc1), BPF_PROG_TYPE_RAW_TRACEPOINT, "abc1_type");
> +	ASSERT_FALSE(bpf_program__autoload(skel->progs.abc1), "abc1_autoload");
> +
> +	ASSERT_EQ(bpf_program__type(skel->progs.abc2), BPF_PROG_TYPE_RAW_TRACEPOINT, "abc2_type");
> +	ASSERT_EQ(bpf_program__type(skel->progs.custom1), BPF_PROG_TYPE_TRACEPOINT, "custom1_type");
> +	ASSERT_EQ(bpf_program__type(skel->progs.custom2), BPF_PROG_TYPE_TRACEPOINT, "custom2_type");
> +	ASSERT_EQ(bpf_program__type(skel->progs.kprobe1), BPF_PROG_TYPE_TRACEPOINT, "kprobe1_type");
> +	ASSERT_EQ(bpf_program__type(skel->progs.xyz), BPF_PROG_TYPE_SYSCALL, "xyz_type");
> +
> +	skel->rodata->my_pid = getpid();
> +
> +	/* now attempt to load everything */
> +	err = test_custom_sec_handlers__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	/* now try to auto-attach everything */
> +	err = test_custom_sec_handlers__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	skel->links.xyz = bpf_program__attach(skel->progs.kprobe1);
> +	ASSERT_EQ(errno, EOPNOTSUPP, "xyz_attach_err");
> +	ASSERT_ERR_PTR(skel->links.xyz, "xyz_attach");
> +
> +	/* trigger programs */
> +	usleep(1);
> +
> +	/* SEC("abc") is set to not auto-loaded */
> +	ASSERT_FALSE(skel->bss->abc1_called, "abc1_called");
> +	ASSERT_TRUE(skel->bss->abc2_called, "abc2_called");
> +	ASSERT_TRUE(skel->bss->custom1_called, "custom1_called");
> +	ASSERT_TRUE(skel->bss->custom2_called, "custom2_called");
> +	/* SEC("kprobe") shouldn't be auto-attached */
> +	ASSERT_FALSE(skel->bss->kprobe1_called, "kprobe1_called");
> +	/* SEC("xyz") shouldn't be auto-attached */
> +	ASSERT_FALSE(skel->bss->xyz_called, "xyz_called");
> +
> +cleanup:
> +	test_custom_sec_handlers__destroy(skel);
> +
> +	ASSERT_OK(libbpf_unregister_prog_handler(fallback_id), "unregister_fallback");
> +	ASSERT_OK(libbpf_unregister_prog_handler(kprobe_id), "unregister_kprobe");
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> new file mode 100644
> index 000000000000..4061f701ca50
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Facebook */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +const volatile int my_pid;
> +
> +bool abc1_called;
> +bool abc2_called;
> +bool custom1_called;
> +bool custom2_called;
> +bool kprobe1_called;
> +bool xyz_called;
> +
> +SEC("abc")
> +int abc1(void *ctx)
> +{
> +	abc1_called = true;
> +	return 0;
> +}
> +
> +SEC("abc/whatever")
> +int abc2(void *ctx)
> +{
> +	abc2_called = true;
> +	return 0;
> +}
> +
> +SEC("custom")
> +int custom1(void *ctx)
> +{
> +	custom1_called = true;
> +	return 0;
> +}
> +
> +SEC("custom/something")
> +int custom2(void *ctx)
> +{
> +	custom2_called = true;
> +	return 0;
> +}
> +
> +SEC("kprobe")
> +int kprobe1(void *ctx)
> +{
> +	kprobe1_called = true;
> +	return 0;
> +}
> +
> +SEC("xyz/blah")
> +int xyz(void *ctx)
> +{
> +	int whatever;
> +
> +	/* use sleepable helper, custom handler should set sleepable flag */
> +	bpf_copy_from_user(&whatever, sizeof(whatever), NULL);
> +	xyz_called = true;
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.30.2
> 
> 
