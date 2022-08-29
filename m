Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A775A557A
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 22:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiH2UVJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 16:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiH2UVI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 16:21:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5CD80F78;
        Mon, 29 Aug 2022 13:21:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKGEC7008979;
        Mon, 29 Aug 2022 20:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=2wtMeEaegg7JOQIE45uP3v7T2qtd4JTk8EZ0QJyEL+Y=;
 b=Wt0YlD9Tb9Ct4KAEr2/V9jZbSJYulnO9SihsTvBDQ904y7VBLOQw5nVIGxPM1y/FJi7B
 bezSYl4uR5X3FY8/ITeOII/0bIoD5mToufwdLR/4QxWoZZy0V80Yk3B6QiVns0VTwf4M
 M1MHBVgYvyZZ9DpA4I1BMc0Amh5SU4jU6we8OyBjGkd3LrRF4FQfeNXuS0BPVLD5YaXu
 kxv0XouRFnbuO8noOxzAPJL3b66zuFUnsLHF9PBHiStM6TjV3IbXuV/88wiv8dvECjKY
 eBuHt3oAMsZPuG3N1L1RzLHDoJ63FC+7kW9ltxu1vOmTHv1A1q3owEK+uLE9twUJub1r 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pbve67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 20:20:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27THOrZB003505;
        Mon, 29 Aug 2022 20:20:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q36nyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 20:20:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI7qb+WoNhav1NNYa1pmZ+ppzLUhEZqhOaO0P/vLO317ZXswfI+vL8ATNm6K0XTGZ25o4eFoTjSH7+kOhnd8dxQzUBGj2789+E3eJW8kw5qE/vGCYM0RMjzJE7kwog3TT0vLlPIvIdJL8BxMR+WNvj4Shv87ECp96Wa1ws9o15c2vFMTyTNcOErEv5KY9JQIVZyVSC/G39wZbCn5sX20XaT5PGghd3p8X5Vuyk+rCFrtzyyFSBIQcLvm6IWPXN8KIhpwG6eQemeMbVjvRmNC10u/vlfQU7MG3pUC1bmvFL7FUQ5yt23tq8PQEEhb8qzrSKNq7pquKMa/lLA/i27dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wtMeEaegg7JOQIE45uP3v7T2qtd4JTk8EZ0QJyEL+Y=;
 b=GXsMsIDF7vL8A2X7jtmjgxVFqIiUG4fgdDY/sh6fcXIjB9vezfaqrxDaiRkCLfGaDwBxyKOOCvDNh+ZxaGdb0Q+mABkpgYrdJYLeZROQaSkOB9vW7DIuJwNKStqkTMVYV1qaNcuBW46mv/0aVdafUkKLQO4xNNpU8rOibdDBrdlvJjJ12YlPIlbdwUH/q6qIk2YBjParG+aKh1d5rW3BYc9zF+omqSwZ0PNtcKRsp14+TIBvWhGWhZYAXt56r+QEDllNc3xBH4WlexxlnsQz4FynByITvLVXrJZ3z3Bt3AWOJgQ0vPCTjgxYY3+mXKmi+03xMPC03fzFkz9ioDoKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wtMeEaegg7JOQIE45uP3v7T2qtd4JTk8EZ0QJyEL+Y=;
 b=YgZ2DV3kKvm+xLWwU68xLAaWkgvBIX21TK97k11wzbGyvSnk2PH+jZgsrI4vfkO7jON9csx21Cm6tkwlxhsPawDUfmGDrhSRTsMjDT2SZYwwe0eCIzvnBK/+BMMmwEWvo/o3yWDqSb91uFbbvduGwta52m3n/dNcC+APFIMonAI=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH0PR10MB5659.namprd10.prod.outlook.com (2603:10b6:510:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 20:20:28 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3151:a4b3:aec3:b3dc]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3151:a4b3:aec3:b3dc%7]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 20:20:28 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] libbpf: add GCC support for bpf_tail_call_static
References: <20220829195349.706672-1-james.hilliard1@gmail.com>
Date:   Mon, 29 Aug 2022 22:19:52 +0200
In-Reply-To: <20220829195349.706672-1-james.hilliard1@gmail.com> (James
        Hilliard's message of "Mon, 29 Aug 2022 13:53:49 -0600")
Message-ID: <87czcissyf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0129.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::8) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ff2009-c897-47af-e9d5-08da89fbe9cd
X-MS-TrafficTypeDiagnostic: PH0PR10MB5659:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UXE7E0wqntHonYV4GbTLQEVGm+h4Nwoiq3+7OmEW7Rpb9suXcrrU9iqBRq2FsqfKm7zLC1Mcl+x73q19ul5EKE53blF3l9wME23BWhidKz/x/i05W8w+HVlhaVDKMsXkvMsKKIovyagYYUM5fb/4O8V3hojBDpTDzr9XbDZgaOmFvE53piBJrYYunM34y3clbqs+QfxVnmeBqfqRE9DcYZTACkDVd45LX5X640yLjovQdmURwAV2COPvNR2iAIiIe+L1oNYwG15AQkOMiveHY61kCX7bDdjlWiyaFjBNukBSs84SaGLFay5NNnolFRdE220vb1elrAihbCtysZZV3OzB9etln6BHU0uAM11JTVPClHz6wi/y2xIj71Dix73l2B0COMoDukK9OT61ZIDoUVztqqN2fjS/u68H2kcjMbTvYorJTtMIqU5QthFtXc89v85xQpflB6xP01koDz3f+fUHPpimjVfkap3CVGvUbzzKYMVtAOu9k/1CkFPyZxQuhPd4XXiojtAadqWsLgfrnv5mOU7ovtf78960/yDb99t6+LT9aw6yasOASMJVVKVrLTMCrxCz+WcaZRmSjz63qOGbzDgXbdo1FFhw3lCVrPKO3wEsjMlkujCnpbkl5SalLHaIlcnw6UKtMB29+xOynJB5KT7B4gmuDIxyME+08/1lM9X8MSBYgPeq6gAQ/ocXlal7AFMpJlbboU3z8dI3KcPagfBKsgIZmm+6iv5Gwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(376002)(396003)(366004)(4326008)(8676002)(66476007)(316002)(6916009)(54906003)(7416002)(5660300002)(2906002)(38100700002)(66946007)(66556008)(8936002)(86362001)(36756003)(6512007)(6506007)(6666004)(26005)(966005)(41300700001)(478600001)(6486002)(2616005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R7jXE07/luzRIA9FpUhFgardtSUC21Tg8yMOoiszJoQqUiyyvbsMPcBXjeTQ?=
 =?us-ascii?Q?1FysZimegE1UDssPh1/l7Q7Q4lbG5+JMwS+6bvIAcncC+3w0mOwZtJmgXthl?=
 =?us-ascii?Q?yG4+86C6fimgCVv1+LyqOWTfVcF9fOkvyO+qN9NRM+JgeZ00bV6AB/c4OPnS?=
 =?us-ascii?Q?CrZIVlITRZrZNTQvpE6/pTQUbzrQ0b9u50aqBG9/JmonX7JZRW1krs2YwBfW?=
 =?us-ascii?Q?bMIzF8D1s6GSgcdz9jSwseop6o5KXUMk6syxgFEcuEPWZT5PkhwaWjGPoFjK?=
 =?us-ascii?Q?o8uOUd+rtW2a+fJ58f4Znb5RKNcmrkyOtbzUG+iiB81uQ8yl34kSiBvVtxNz?=
 =?us-ascii?Q?6bXLGZAnVY1oqCxRJzmJ+kgimWFyv6aP4ev2xFIwQF3pIQTjQAx+xgFQdDpi?=
 =?us-ascii?Q?Z+qVhNqb3wfMW8EtE3lm2G9u9+vqYHtOtgLDA1YGDZgUtcyMmonO+O0ulR5a?=
 =?us-ascii?Q?8URnNncaH/lt3td1lhmJC/SY/k+sBU6pPe2iOggqZGm+M9A27SAwVB0Gfcl6?=
 =?us-ascii?Q?7UK3qVKDr0t9zPMuuBcRGlu4XGL8qD+4PM1k5pRr1/MQ950bo7Ol6gN827PK?=
 =?us-ascii?Q?VxyPZm5zdmHWxqEcr14pFdaEJqEweSAO2zZFSNwkQSG0ZmGRYsI30+20lJwB?=
 =?us-ascii?Q?DvAevCfz34rPVSea28V+vqX7Qv0nbV/FNb9h7u84n8ptsHvNXiiY2CChwjOk?=
 =?us-ascii?Q?EoNVl0xz74EnTMn2L+1KXMrsz/U6YKFoW+2UtY0ms45AvGSMQIgvsVpBtQ8p?=
 =?us-ascii?Q?3/5NN2tBT9YkUgITZDyAzKKGfc5rvNR8H6sZASF89gvxWn0yl4QRVrNnIHZ6?=
 =?us-ascii?Q?DjsHeR8Q5n5gk4StH0jgYWN9dB5ipZ2XsnsnFsoVDvxN1GEIj3M4nD6aU/xz?=
 =?us-ascii?Q?ay8n7xoATNlzwDgWL2ghCRnPiYjwxP5sjEjmI4cpUG72oz9h7ul5KeIKMMAN?=
 =?us-ascii?Q?4NgouP7ZJVNXf/9pu4kV1L+HBL/wRqa0bE3yVv3n4rrR7BR1J0r9lIJBbfTH?=
 =?us-ascii?Q?3AQaIFsLl4EllzNNa+2CKVBC5d0hivmvImRv+/JHMd8aQwBifKZF3QbStrrT?=
 =?us-ascii?Q?NnUvC0X3DY/VgTJ7+5op+ZsrGU0JXq9DQAwY+2zgwcTpnMGVPlhbFFzsQhB0?=
 =?us-ascii?Q?WBy3jQH2ChYXHFFIIe9O+2k2Z7iL0A/O3Gnndog/TCpYbjM+SqC1TW6mpMOj?=
 =?us-ascii?Q?IdoIBDUh/Lo/ooOzcNU/6n0gX3DRevlgs+alcLee56AAtBa5gDSa2mDwsVOL?=
 =?us-ascii?Q?tyjlTxkW5GfSTmmQOzWiK/HfQvBnVswXMhC92Bd7J6w0uZDCOVXDCOtbMMEq?=
 =?us-ascii?Q?E2oBCltcUd0w/0vUqcDl4VZtg12iH+2/LnTaaRr7/HIO0qRNYOZ141RWg/c4?=
 =?us-ascii?Q?BeWH7bWn9VFKvo06kER+apoQJYOkPVucT8W35GsKVzMamcNck4INnHf8vFMA?=
 =?us-ascii?Q?JsDf5dvmPnmuXAXDhKDkgr8RIHz+h7rr1+YgiaOhA1qptXEzgB/9WtDvKMm9?=
 =?us-ascii?Q?rE+mglNivrakX73ptG/Ol0BozOajoAMFQcLl9KijZhCkrUVc6ofSVqNNPMlI?=
 =?us-ascii?Q?XBno2zbVkKqovO8AfOa1qukbaSKBGtmaWvj27yWVLcmV9Atdra73VUCDVBt5?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ff2009-c897-47af-e9d5-08da89fbe9cd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 20:20:28.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0rPFSdNx6RL8dQUzXhfBB3eCEmUF5OduGChRy2uK/fHxrcW4+NN4FzMApTEdNdksHQpBBoBVsK/afQx1ASbvsQecB2mSk50K5vql4xrd2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290092
X-Proofpoint-ORIG-GUID: NAEVj3NZ5SaFkUK-0GSldK97P3DMgyy2
X-Proofpoint-GUID: NAEVj3NZ5SaFkUK-0GSldK97P3DMgyy2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi James.

> The bpf_tail_call_static function is currently not defined unless
> using clang >= 8.
>
> To support bpf_tail_call_static on GCC we can check if __clang__ is
> not defined to enable bpf_tail_call_static.
>
> We also need to check for the GCC style __BPF__ in addition to __bpf__
> for this to work as GCC does not define __bpf__.

No need for that complication.  I just pushed a patch to GCC that makes
it define __bpf__ as a target macro, in addition to __BPF__, like LLVM
does.

https://gcc.gnu.org/pipermail/gcc-patches/2022-August/600534.html

> We need to use GCC assembly syntax when the compiler does not define
> __clang__ as LLVM inline assembly is not fully compatible with GCC.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  tools/lib/bpf/bpf_helpers.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 7349b16b8e2f..a0650b840cda 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -131,7 +131,7 @@
>  /*
>   * Helper function to perform a tail call with a constant/immediate map slot.
>   */
> -#if __clang_major__ >= 8 && defined(__bpf__)
> +#if (!defined(__clang__) || __clang_major__ >= 8) && (defined(__bpf__) || defined(__BPF__))
>  static __always_inline void
>  bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>  {
> @@ -139,8 +139,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>  		__bpf_unreachable();
>  
>  	/*
> -	 * Provide a hard guarantee that LLVM won't optimize setting r2 (map
> -	 * pointer) and r3 (constant map index) from _different paths_ ending
> +	 * Provide a hard guarantee that the compiler won't optimize setting r2
> +	 * (map pointer) and r3 (constant map index) from _different paths_ ending
>  	 * up at the _same_ call insn as otherwise we won't be able to use the
>  	 * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
>  	 * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
> @@ -148,12 +148,19 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>  	 *
>  	 * Note on clobber list: we need to stay in-line with BPF calling
>  	 * convention, so even if we don't end up using r0, r4, r5, we need
> -	 * to mark them as clobber so that LLVM doesn't end up using them
> -	 * before / after the call.
> +	 * to mark them as clobber so that the compiler doesn't end up using
> +	 * them before / after the call.
>  	 */
> -	asm volatile("r1 = %[ctx]\n\t"
> +	asm volatile(
> +#ifdef __clang__
> +		     "r1 = %[ctx]\n\t"
>  		     "r2 = %[map]\n\t"
>  		     "r3 = %[slot]\n\t"
> +#else
> +		     "mov %%r1,%[ctx]\n\t"
> +		     "mov %%r2,%[map]\n\t"
> +		     "mov %%r3,%[slot]\n\t"
> +#endif
>  		     "call 12"
>  		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>  		     : "r0", "r1", "r2", "r3", "r4", "r5");
