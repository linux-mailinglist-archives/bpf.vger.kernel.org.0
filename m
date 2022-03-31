Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02E94ED884
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiCaLdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 07:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiCaLdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 07:33:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097116BCF6
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 04:31:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V8WVF6027875;
        Thu, 31 Mar 2022 11:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=K9m2nV1uhv6khiWh9wOL6GSAf6z4ANMGK+4FGkwL0sA=;
 b=EtGdGHUDZwZgfFpTcG7b37O77fzleWbFdXNTf5Yt75W8kpqYsmy+utKZ1KtBkhxzOaYK
 7svBgy3Z7EEKBiPlXQMAlnu5zhduukft2l5gGqgalO0LAwDyLrh3xmdFxYOjjxXGQauS
 tlx+xRpsFNr9httWuaKxOfAYMyjb+vokFnALgT12x5MtNLZ74awoOSHI2in/3jrdWxao
 nJ74Ap8WW+xZnEfC7VzOxQl7ePmITDLf8IXHeSWFBytqLNR2nl4rYh/Hy5Cd/WuQOAXw
 YZPNN0LaArhPKp3I/D6GYY+lgA+h2STQSn/nn13ak+GcIwKxpeUVCEuSv8LsFX1uzfrG Og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2m4bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 11:30:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VBBKUH032242;
        Thu, 31 Mar 2022 11:30:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s94pjba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 11:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOlGla8K/VEPh2I11sR60M/IbQWDB/D1xfpP2H1ctAKj4uV0nPDQsMsX74uLmnLWTJ06lssO7Mw/iKC1YWsXv6wYc6cRaCpB8gbG0XKJtyATk4D7nbrOxwsX2kmaEJUpe7w2zBnTrXilTqq4fZg5QjPH+4RdWDJh6+4xn2TxCZ0t5bZIxCtTUuixDRCdg+zv5Ou7jngvckhy0j//ndYfFWhE32HjrdqcB08veqM43xv6IoRf594jna8NDECOHXERnWUhUGvg4heA9IcIXgOjVhbioaHT6iy+LB/GE5lJWUM02JHTNo1cM3yijhRnXqkKWDuyhm9NpzeacOuQApaqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9m2nV1uhv6khiWh9wOL6GSAf6z4ANMGK+4FGkwL0sA=;
 b=ZF7oapDcMCaj1Yoh3SHuBkNLWZZ4sfr41m3TPIqxsYsQSEY0e4DBR+FC9sfxvKOpsSYGuhqRH5KQ54dJ5eml4DChbJJj4sTe9prFzwn2RTKdQEjLTx2kfgSSb6280bEyBXWqleouNrbB0Cd586kKVVoIBK5PxC92bF3UBIsXLxRHQEhH+CwmslIohVv0JMwok//OK4fEQ8lRXVRwfsF1cnyK9VUlNELbA4JaOHTyXf987nElTEeTN0wwIsKx6xnD57526BEKQnRlwuDAYClRpKTJEDBqYqgzPpz/D/OtQ8SuwMc3l8cxALcYUFUyhyiosusiDDMfBZ7VlEtSG9cMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9m2nV1uhv6khiWh9wOL6GSAf6z4ANMGK+4FGkwL0sA=;
 b=i7xRz0j8Yr2asSS1Y8hyHPfKmaNyD+iQXcU0SgK0Of6NxLiFlFMvnHaa0KAQZtESzMR4cKCICvwfSTGuV5effMk5OP4KG47HaXkWtzprfVc4bWFLLrWsHvyQqxwaf7iqLzvgpISxtBNZkgUhjD/88H9q9pBDodA3714if8rhI00=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN6PR10MB2558.namprd10.prod.outlook.com (2603:10b6:805:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Thu, 31 Mar
 2022 11:30:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386%4]) with mapi id 15.20.5123.020; Thu, 31 Mar 2022
 11:30:49 +0000
Date:   Thu, 31 Mar 2022 12:30:37 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next 1/7] libbpf: add BPF-side of USDT support
In-Reply-To: <20220325052941.3526715-2-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2203311230280.16879@MyRouter>
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-2-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LNXP265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c342bce9-3dd8-42d7-cf28-08da1309e7b5
X-MS-TrafficTypeDiagnostic: SN6PR10MB2558:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB255841AE7E804CE0F88EA126EFE19@SN6PR10MB2558.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUoS2F4TR+JjuFYgofWPegzE8DBOeWCbFSi1wIHQs2poDQXIldvb5jwXfW5W3OwaDCuXVyeMdOJcq3ZCBvrJ3ykqibZLwNuxltN499RSlP/RzVlVg/SS2fObG9dKh24CvYOuQvlGZPDRsq4W2KWX99XNK54CMug5xYqKwFYKP9xAmUk2tp5Rp34G6dGnd15TUtqx4Ya6ZXouRe5pX5a/XD2tlXgakem2DCDmJBVL3IVkl3XM6LkM14ixJFzWjvjQJPAQ3HGPaRg58zUCQ6ps4Nt69Dvg2j/XiCmPYWzoE3MzIYrsyD9EbXGM3t+PFTUxoCxSa4ozzyUOPoSFovDymCyk6ZcnAK3yFHdDP8JIIema3JGw8UizQ3RBcNQEy9htYi3HyEQGgUWu7Gok2ArCUqNog4+3rWSblPT7AeTGHndBlxkDGpQc+gF513lvivpXVb5bL8SGzqQ9fDMyhFMb0qI+OAu7jUL9/QdWt5cdxuY6ywqledYcQNRdoef6eiMn7UxuWbRixKiZepIVTLnXbnwx/X8IF9WYfEffcH0E9+cEj0GdttNjNj3CTYGFHfnp1CraPt5GYK0k9NL6bpdN1xoos+0iP0UYAC5xO4+JdQ7aFHIYNn1kYTvW6f8R5A83PH5M95ckXb58QTX2G+g2NnnxxYh+LDkO2noxWxLWziTiGCA+Z8osTId6nrn4PkcwP+lZpz9qLjjM5+lrMBlLVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(54906003)(6916009)(33716001)(186003)(8676002)(4326008)(66476007)(6666004)(38100700002)(52116002)(6506007)(66556008)(66946007)(8936002)(6512007)(9686003)(6486002)(83380400001)(5660300002)(316002)(2906002)(30864003)(508600001)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KDUhliyTSU732elO0yAflWksnmBeV2Oc9BIpRtY3XgEae0E/Hr5TgVpYQHsm?=
 =?us-ascii?Q?BWj4/KdoCZ0mynhghNzl8LH6VVKVpTUCZMCZASyokTZrIGZRELL9TUFef0EB?=
 =?us-ascii?Q?Bq9ZC/7pYJRBy1dmsUdIMtR8WENjvbTjGCiL0DkzqfAuDQycnDK1MO8PKlfm?=
 =?us-ascii?Q?zTelOIVaqLF2n9Jc6GwR9RDAroFDkbcq8u5QlHzmQSBGQRgVF1j3eE03Wp7o?=
 =?us-ascii?Q?I7wrQA3jIHSPWKoXeog9ypo9BMroUjij6lZgGYoWlpqKG48rXlHO09+WAfvl?=
 =?us-ascii?Q?3bX8j3T7sWT9634e6uqelFNdqC9jZ5q6OaGBFAb73s1ylYb7Qv/Huqd1Ynk6?=
 =?us-ascii?Q?4yLj0b4wZe2SXDlNpCDCqPriETFuihSCdN+qbndWgsLIYnQSnO0hkkPxJ5Qh?=
 =?us-ascii?Q?OE6Z96M/Fj+KUldw1w6gYDpl/kFzMOgB81r4FQ0j+iTh46e3t1CmDExRNO5A?=
 =?us-ascii?Q?URtm2fyMZagIKbAXXg4L1+FqINFakOHPMeth8GCA7V3U1c0XZMc31tK6KoRt?=
 =?us-ascii?Q?QedM53pOFu/tQg9VU93Ylwh20/IaRtR54gw1IvMTrqeOSAYPE4jPagzXJB6v?=
 =?us-ascii?Q?FDAqPcJEj7cmqTfdO0zyOIHqagPpJFTukVdv0mihsva1kKjqCRtwBMnVKeqj?=
 =?us-ascii?Q?pbSG10+7C1QlYgA2F8I3vpgv8IK8R3lAPwJzywec0D6y3VkZYptRkuDgkpCE?=
 =?us-ascii?Q?YdEBIHetFxgg8gud9/uguews919MQegsjSz7+qn3CDECbWxy+Z3+rliZz+20?=
 =?us-ascii?Q?PL/yHVYZcAVKq4OET2Z3ENyeGEtebkDQdDhRP5aFFN68I92GFuqepIrWC+1C?=
 =?us-ascii?Q?brrrv4nzR0D2j9Mk/tmCmIzsBiSb8d7gTx9fcVyUddBEIB5ISHpyGG8MJVbj?=
 =?us-ascii?Q?998hxWQuevX60SMj2jaUEvJ9hdXolksLU6NQ0JglihlcnMC2naAEt3BTAt+E?=
 =?us-ascii?Q?SF0jGcV+S06jsNJiqhXZIiLGtHX8sB34YLX3ruYPKPshhQxgmcE0rNCZCxyJ?=
 =?us-ascii?Q?MY9m7+MjrktzZyJpiwscm8nWeJJsqP4q75gBxbHqQxi2wCnQKbIw8CnUNSUX?=
 =?us-ascii?Q?B2XIII8FrL6iLlOHTURbALQ9EWZx9AmqkQu5FdGhWM/T59TN19JiwyNyKq92?=
 =?us-ascii?Q?qVW92M8xMpJBnr7go2Vxgm16nvCwCJyQ12motbOmpzQED7jzhrLmF82kyx7p?=
 =?us-ascii?Q?O12+r6DWKKMgBCPGJpMkQQyngNeSbjYFbEm50f0ckCNdz6nZeOCc4ANhXuPN?=
 =?us-ascii?Q?YYS4H05yvsqJjWcQhEpi608ZrmAyYcneVGPa2yBzmIL8oDyluUn+MdWd75Hc?=
 =?us-ascii?Q?G2QvhKVgdg2tbr30TJXJIa6HSJlkvS99MaozC82GIKoZM168BF7nnCUWJG3R?=
 =?us-ascii?Q?fQ86q8Ge9J45UaoYdz58Gz9oz7jlN2R2AIk754DrekObi9s8AsDhwWc61BX7?=
 =?us-ascii?Q?imbNp6aDcHI0bs5RxnbjJFmWUX10RKimwlj/5lQgAo5IYQwhAUfxdfGeKsQU?=
 =?us-ascii?Q?SIANhaIipS0Xc2Nv4CLbqxzJjn+a3yxyG8OCQ5v43dcJ5/bI6hqtFC8Jhtqt?=
 =?us-ascii?Q?kw9CQdOc2z1y/8+ZGfomSgw3VtFZpnLuGe7beuBbCp1XFWVPKFG+hsOLusUM?=
 =?us-ascii?Q?fID8dyaWZTLq65TDSnnBcSng/1ZhAUxlD2fKl+olbTmWTEvw1SxO25+std2t?=
 =?us-ascii?Q?Yppmk7xvbbPGwTGB6RifnSOm6najsIdf2F4hGL0O3zmzHyk1S68RqJhoq57d?=
 =?us-ascii?Q?8YvOUhGErq5r/Mw8Px4rKJX+aW7Mdie/Dn8iC86k8OxgB8RodZZP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c342bce9-3dd8-42d7-cf28-08da1309e7b5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 11:30:49.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHNhMqio9pd2QLtg0s2ezpRBDfQCptuG8hFlQS2N5TDwzGlgodItJcWF8D+LNO3AHeo3DGQmXXDUR0GjrvIHUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2558
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_04:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310063
X-Proofpoint-ORIG-GUID: KMHTWzaPo7EyQHpFU90PnNbZz7OgHGQ_
X-Proofpoint-GUID: KMHTWzaPo7EyQHpFU90PnNbZz7OgHGQ_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Mar 2022, Andrii Nakryiko wrote:

> Add BPF-side implementation of libbpf-provided USDT support. This
> consists of single header library, usdt.bpf.h, which is meant to be used
> from user's BPF-side source code. This header is added to the list of
> installed libbpf header, along bpf_helpers.h and others.
>

<snip>

Some suggestions below, but nothing major.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
 
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> new file mode 100644
> index 000000000000..8ee084b2e6b5
> --- /dev/null
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -0,0 +1,228 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#ifndef __USDT_BPF_H__
> +#define __USDT_BPF_H__
> +
> +#include <linux/errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +/* Below types and maps are internal implementation details of libpf's USDT
> + * support and are subjects to change. Also, usdt_xxx() API helpers should be
> + * considered an unstable API as well and might be adjusted based on user
> + * feedback from using libbpf's USDT support in production.
> + */
> +
> +/* User can override BPF_USDT_MAX_SPEC_CNT to change default size of internal
> + * map that keeps track of USDT argument specifications. This might be
> + * necessary if there are a lot of USDT attachments.
> + */
> +#ifndef BPF_USDT_MAX_SPEC_CNT
> +#define BPF_USDT_MAX_SPEC_CNT 256
> +#endif
> +/* User can override BPF_USDT_MAX_IP_CNT to change default size of internal
> + * map that keeps track of IP (memory address) mapping to USDT argument
> + * specification.
> + * Note, if kernel supports BPF cookies, this map is not used and could be
> + * resized all the way to 1 to save a bit of memory.
> + */
> +#ifndef BPF_USDT_MAX_IP_CNT
> +#define BPF_USDT_MAX_IP_CNT 1024
> +#endif

might be no harm to just make this default to a reasonable multiple of 
BPF_USDT_MAX_SPEC_CNT; i.e. n specs X m possible sites. Would allow users
to simply override the MAX_SPEC_CNT in most cases too.

> +/* We use BPF CO-RE to detect support for BPF cookie from BPF side. This is
> + * the only dependency on CO-RE, so if it's undesirable, user can override
> + * BPF_USDT_HAS_BPF_COOKIE to specify whether to BPF cookie is supported or not.
> + */
> +#ifndef BPF_USDT_HAS_BPF_COOKIE
> +#define BPF_USDT_HAS_BPF_COOKIE \
> +	bpf_core_enum_value_exists(enum bpf_func_id___usdt, BPF_FUNC_get_attach_cookie___usdt)
> +#endif
> +
> +enum __bpf_usdt_arg_type {
> +	BPF_USDT_ARG_CONST,
> +	BPF_USDT_ARG_REG,
> +	BPF_USDT_ARG_REG_DEREF,
> +};
> +
> +struct __bpf_usdt_arg_spec {
> +	__u64 val_off;
> +	enum __bpf_usdt_arg_type arg_type;
> +	short reg_off;
> +	bool arg_signed;
> +	char arg_bitshift;

would be no harm having a small comment here or below where the 
bitshifting is done like "for arg sizes less than 8 bytes, this tells
us how many bits to shift to left then right to
remove the unused bits, giving correct arg value".

> +};
> +
> +/* should match USDT_MAX_ARG_CNT in usdt.c exactly */
> +#define BPF_USDT_MAX_ARG_CNT 12
> +struct __bpf_usdt_spec {
> +	struct __bpf_usdt_arg_spec args[BPF_USDT_MAX_ARG_CNT];
> +	__u64 usdt_cookie;
> +	short arg_cnt;
> +};
> +
> +__weak struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
> +	__type(key, int);
> +	__type(value, struct __bpf_usdt_spec);
> +} __bpf_usdt_specs SEC(".maps");
> +
> +__weak struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, BPF_USDT_MAX_IP_CNT);
> +	__type(key, long);
> +	__type(value, struct __bpf_usdt_spec);
> +} __bpf_usdt_specs_ip_to_id SEC(".maps");
> +
> +/* don't rely on user's BPF code to have latest definition of bpf_func_id */
> +enum bpf_func_id___usdt {
> +	BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
> +};
> +
> +static inline int __bpf_usdt_spec_id(struct pt_regs *ctx)
> +{
> +	if (!BPF_USDT_HAS_BPF_COOKIE) {
> +		long ip = PT_REGS_IP(ctx);

Trying to sort of the permutations of features, I _think_ is it possible 
the user has CO-RE support, but the clang version doesn't support the
push of the preserve_access_index attribute? Would it be feasible to
do an explicit "PT_REGS_IP_CORE(ctx);" here?

> +		int *spec_id_ptr;
> +
> +		spec_id_ptr = bpf_map_lookup_elem(&__bpf_usdt_specs_ip_to_id, &ip);
> +		return spec_id_ptr ? *spec_id_ptr : -ESRCH;
> +	}
> +
> +	return bpf_get_attach_cookie(ctx);

should we grab the result in a u64 and handle the 0 case here - 
meaning "not specified" - and return -ESRCH?

> +}
> +
> +/* Return number of USDT arguments defined for currently traced USDT. */
> +__hidden __weak
> +int bpf_usdt_arg_cnt(struct pt_regs *ctx)
> +{
> +	struct __bpf_usdt_spec *spec;
> +	int spec_id;
> +
> +	spec_id = __bpf_usdt_spec_id(ctx);
> +	if (spec_id < 0)
> +		return -EINVAL;

spec_id can be 0 for the "cookie not set" case (see above).

should we pass through the error value from __bpf_usdt_spec_id()? Looking
above it's either -ESRCH or 0, but if we catch the 0 case as above we 
could just pass through the error value.
 
> +
> +	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> +	if (!spec)
> +		return -EINVAL;
> +

should this be -ESRCH? we know from the above we had a valid
spec_id.

> +	return spec->arg_cnt;
> +}

also, since in every case (I think) that we call __bpf_usdt_spec_id()
we co on to look up the spec in the map, would it be easier to
combine both operations and have

struct __bpf_usdt_spec * __bpf_usdt_spec(struct pt_regs *ctx);

?

> +
> +/* Fetch USDT argument *arg* (zero-indexed) and put its value into *res.
> + * Returns 0 on success; negative error, otherwise.
> + * On error *res is guaranteed to be set to zero.
> + */
> +__hidden __weak
> +int bpf_usdt_arg(struct pt_regs *ctx, int arg, long *res)
> +{
> +	struct __bpf_usdt_spec *spec;
> +	struct __bpf_usdt_arg_spec *arg_spec;
> +	unsigned long val;
> +	int err, spec_id;
> +
> +	*res = 0;
> +
> +	spec_id = __bpf_usdt_spec_id(ctx);
> +	if (spec_id < 0)
> +		return -ESRCH;
> +
> +	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> +	if (!spec)
> +		return -ESRCH;
> +
> +	if (arg >= spec->arg_cnt)
> +		return -ENOENT;
> +

I'm surprised you didn't need to check for negative values or a hard 
upper bound for the arg index here (to keep the verifier happy for
the later array indexing using arg). Any dangers that an older
LLVM+clang would generate code that might get tripped up on
verification with this?

> +	arg_spec = &spec->args[arg];
> +	switch (arg_spec->arg_type) {
> +	case BPF_USDT_ARG_CONST:
> +		val = arg_spec->val_off;
> +		break;
> +	case BPF_USDT_ARG_REG:
> +		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +		if (err)
> +			return err;
> +		break;
> +	case BPF_USDT_ARG_REG_DEREF:
> +		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +		if (err)
> +			return err;
> +		err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
> +		if (err)
> +			return err;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	val <<= arg_spec->arg_bitshift;
> +	if (arg_spec->arg_signed)
> +		val = ((long)val) >> arg_spec->arg_bitshift;
> +	else
> +		val = val >> arg_spec->arg_bitshift;
> +	*res = val;
> +	return 0;
> +}
> +
> +/* Retrieve user-specified cookie value provided during attach as
> + * bpf_usdt_opts.usdt_cookie. This serves the same purpose as BPF cookie
> + * returned by bpf_get_attach_cookie(). Libbpf's support for USDT is itself
> + * utilizaing BPF cookies internally, so user can't use BPF cookie directly
> + * for USDT programs and has to use bpf_usdt_cookie() API instead.
> + */
> +__hidden __weak
> +long bpf_usdt_cookie(struct pt_regs *ctx)
> +{
> +	struct __bpf_usdt_spec *spec;
> +	int spec_id;
> +
> +	spec_id = __bpf_usdt_spec_id(ctx);
> +	if (spec_id < 0)
> +		return 0;
> +
> +	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> +	if (!spec)
> +		return 0;
> +
> +	return spec->usdt_cookie;
> +}
> +
> +/* we rely on ___bpf_apply() and ___bpf_narg() macros already defined in bpf_tracing.h */
> +#define ___bpf_usdt_args0() ctx
> +#define ___bpf_usdt_args1(x) ___bpf_usdt_args0(), ({ long _x; bpf_usdt_arg(ctx, 0, &_x); (void *)_x; })
> +#define ___bpf_usdt_args2(x, args...) ___bpf_usdt_args1(args), ({ long _x; bpf_usdt_arg(ctx, 1, &_x); (void *)_x; })
> +#define ___bpf_usdt_args3(x, args...) ___bpf_usdt_args2(args), ({ long _x; bpf_usdt_arg(ctx, 2, &_x); (void *)_x; })
> +#define ___bpf_usdt_args4(x, args...) ___bpf_usdt_args3(args), ({ long _x; bpf_usdt_arg(ctx, 3, &_x); (void *)_x; })
> +#define ___bpf_usdt_args5(x, args...) ___bpf_usdt_args4(args), ({ long _x; bpf_usdt_arg(ctx, 4, &_x); (void *)_x; })
> +#define ___bpf_usdt_args6(x, args...) ___bpf_usdt_args5(args), ({ long _x; bpf_usdt_arg(ctx, 5, &_x); (void *)_x; })
> +#define ___bpf_usdt_args7(x, args...) ___bpf_usdt_args6(args), ({ long _x; bpf_usdt_arg(ctx, 6, &_x); (void *)_x; })
> +#define ___bpf_usdt_args8(x, args...) ___bpf_usdt_args7(args), ({ long _x; bpf_usdt_arg(ctx, 7, &_x); (void *)_x; })
> +#define ___bpf_usdt_args9(x, args...) ___bpf_usdt_args8(args), ({ long _x; bpf_usdt_arg(ctx, 8, &_x); (void *)_x; })
> +#define ___bpf_usdt_args10(x, args...) ___bpf_usdt_args9(args), ({ long _x; bpf_usdt_arg(ctx, 9, &_x); (void *)_x; })
> +#define ___bpf_usdt_args11(x, args...) ___bpf_usdt_args10(args), ({ long _x; bpf_usdt_arg(ctx, 10, &_x); (void *)_x; })
> +#define ___bpf_usdt_args12(x, args...) ___bpf_usdt_args11(args), ({ long _x; bpf_usdt_arg(ctx, 11, &_x); (void *)_x; })
> +#define ___bpf_usdt_args(args...) ___bpf_apply(___bpf_usdt_args, ___bpf_narg(args))(args)
> +
> +/*
> + * BPF_USDT serves the same purpose for USDT handlers as BPF_PROG for
> + * tp_btf/fentry/fexit BPF programs and BPF_KPROBE for kprobes.
> + * Original struct pt_regs * context is preserved as 'ctx' argument.
> + */
> +#define BPF_USDT(name, args...)						    \
> +name(struct pt_regs *ctx);						    \
> +static __attribute__((always_inline)) typeof(name(0))			    \
> +____##name(struct pt_regs *ctx, ##args);				    \
> +typeof(name(0)) name(struct pt_regs *ctx)				    \
> +{									    \
> +        _Pragma("GCC diagnostic push")					    \
> +        _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
> +        return ____##name(___bpf_usdt_args(args));			    \
> +        _Pragma("GCC diagnostic pop")					    \
> +}									    \
> +static __attribute__((always_inline)) typeof(name(0))			    \
> +____##name(struct pt_regs *ctx, ##args)
> +
> +#endif /* __USDT_BPF_H__ */
> -- 
> 2.30.2
> 
> 
