Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3D4F1C7F
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 23:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379841AbiDDV1d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379476AbiDDROI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 13:14:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47413D16
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 10:12:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234GEfbX012570;
        Mon, 4 Apr 2022 17:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=UxcbXcJTCjUigSPGwbaej0U9sA/6yYetABreEiSKtzU=;
 b=f9f7YanFPQi5UfKRs1uCUbAGgJpAOsu5dOspbOd9719GvIbEcqSZt7AQFBmvKoBjStm9
 sBJIfJY503dNrtgNWDhC5CDBse4+TREsUhTK9h3cNU8GXEiyBfdfwraIRAe8dk/wV9Gg
 i6svE3yiCIPl8H6h5zcroQEPey2vP5NY1Dk4WAO2k2uRkuXxAPIFH8dWvFB32EGJNENB
 wJRpWFC/Jq1JhIP3m81gZRltOZMK5mipAS/k+0K6Wtw07KhrYbWSAjx40fWv+kwIhXox
 51NoW497xX0cYbY47iOcyw2nDQcmKHsEAAl6gQxEHQSyj5ZqC9+P6dALWkdb2n9jOZHi og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbu7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 17:11:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234HBi3Y005627;
        Mon, 4 Apr 2022 17:11:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2tqw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 17:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGRZqzMMF4EI1c9ozEsDurImda9/OO+mM0BlAKxhTiE9QNnbPqK0s1NJ4jRq8zqb/16Fu1asF9JI070kK7HflnRphn80Eu8WhCK42UjkFDjzWdUMWkF7WOmMAfy3KA+Hy4v79HDgu8mIh0lkN9UgPoY15viQpQYZ4/y04/yttC3PSYwzt7n2b+wqgqwuXn2AgbOCQSQfndfulwijZQwf8kQ5tysqSUVp2zzLKsAnNPfau/0ZWlmzJV3HF01nTvGuJaGbQXIbA/0g2yHsK5k0CUCfcurWg7VMBKAJKsoLzLlHs+KhtD4qWyiuZoCPOheUEVWXbsOTh5+vuYoPVrIhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxcbXcJTCjUigSPGwbaej0U9sA/6yYetABreEiSKtzU=;
 b=HGINuilo6IqiPFUNw/8PmgblCO9QN50962dhOaSPZJvwT4HweoIc6Vv8b4WavUozNcrxeBEur0zjSz4m5IEskolxOdc2jY1UksCZCRSYvMex3RqbaJ3/iJS9feTn4O6YhcqYsJiU4CJPFiEXTxcpREPRpB5CZFFVi7uI4BMti7nsi5mpvhtUnaX5liCYKf4LAktsVygOiV32/QtpkVTXLzlZLU4AjCThVKev+bMAGssynTC3DaesSh1ZYCachDVbMvV81R8S2gSluIzihga+Sc/VVqZu5tpwcMpZEK7ZSA7K3jfkGvmoUb1SCKeN6tkIfhEa9PI4KdWxF8Mvww0BPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxcbXcJTCjUigSPGwbaej0U9sA/6yYetABreEiSKtzU=;
 b=Q2AWoyOqssVLCrpf6wuWIV6iZlPW3cSy1sv6zqo9Wfz4nM8bkJRF5H5jknJ7IXRE+CFzbeBOJm71vk5wacKFPrejHJmvTPXhEs8gIojrUpIhbDM6l6z1hgL+Tn1xl6i2SJgrjEU4sxlLUaQO98P2otzn89C84fDgsiZuAfMqoII=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB3916.namprd10.prod.outlook.com (2603:10b6:5:1fe::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 17:11:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::bc05:7970:d543:fd52]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::bc05:7970:d543:fd52%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 17:11:48 +0000
Date:   Mon, 4 Apr 2022 18:11:29 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Ilya Leoshkevich <iii@linux.ibm.com>
cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME
 for aarch64
In-Reply-To: <20220404142101.27900-1-iii@linux.ibm.com>
Message-ID: <alpine.LRH.2.23.451.2204041807500.23052@MyRouter>
References: <20220404142101.27900-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO2P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76b5875f-27b5-47a3-08c7-08da165e3412
X-MS-TrafficTypeDiagnostic: DM6PR10MB3916:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3916941C54B2F6EF70938486EFE59@DM6PR10MB3916.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgGm2y/ESzw5ipFQRfEG3U2ITSd6bi+Y1/VMUbuHi1EPH7XzEIa1u/mMxlza+R9DPpNTAgDKbbPcTqLA+/LcG6tWcR5iEktJ11zf86Fs2N//jPJ+ii7oAj1k4rpNV3YbV9qtkzdRGAQdq5c54cerljo+XnpeHxiwmRclNCw9EDGDFwrRwddFM+/XUabSMlyggNLdHSmokBLYeBAuJ91EvduBJgT/HUNxldJwq6kljz+XchFkSXQRd6shFK5gJdP8wdBkBDYGsHjAyFEMQ700vNIHf5/l1xdXYxf/Ud4Y+fHDEVzhxmQzuqIrUYrbjeoqYo+wC/tIuu/G9AtVJ3VxD6paMgALdTJLnYJcqrxkWLqnDK9jGnfAhLK5HXDtNdmenCB8Nv0BYQZH97ERoKxsxBNVyRJGx1YpHZ38uNylQf98H3hYrvkPKGmpB/G1taGHFypu7GrTTInf0weZa4scSVpiAJZWHb+sv3FMRNQBhlWKRXO5CBXaVo8rUmZUGRvj/5Hyd2/lDcabpbHBnNvSe3f86bmGZFyXF6zzZZsBsud66mxIikOpt3dEKGxtj3IrOfOSr6Ehc8VyrMCSyvCZA0zTlG4ZgPKCWT1hAkvo3E+JNe1fBpkSNbATHTyW/9ykzijcla6i394gqS2NvZCyFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(6486002)(38100700002)(66476007)(66556008)(66946007)(8676002)(33716001)(4326008)(2906002)(5660300002)(8936002)(6666004)(6512007)(6506007)(86362001)(9686003)(316002)(6916009)(54906003)(186003)(52116002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMIj+4BR7ktGmnosBoetv5p6s5WWOMSnIB9RKmFRVAtKBfd76M8eS+aHr5aU?=
 =?us-ascii?Q?U5AQkgtVnJK3QL+I69wilBrLqstGxFvWosgC4BtLadDGbLCuC5LDUWs/2djL?=
 =?us-ascii?Q?vc09lptKEnARlZYRv6L/sd34fY96DAsjY8CtIBaRSEOaygJ80H34hcBDHsia?=
 =?us-ascii?Q?HqCR8jnEs5zMx2noD/aAexy8B+GIUR5yjM9RKQE2P5IkC9b2GafbHQfCFhDx?=
 =?us-ascii?Q?a45SyxZd+DL/oM8/NP7IwVamXQxHGQdJ29HjZyVoH9LW0Z6K3xr0h+ar9eys?=
 =?us-ascii?Q?IkZLhhVkZPhEkvvzrcCHeYUOPJMqRSY8EPcUkUGAiEKrVH/eVlvBvvhUx/Xy?=
 =?us-ascii?Q?kyF//PwkiM6k0t8UveLpNomaPPXGwc1203bzA3f5RmqFc/ayJha110xBhd+j?=
 =?us-ascii?Q?vTN+yFNNS8fu6P37A+FZGgJN0aq2JrxeLirev+w+5ayWT8zYYIWRGwLi/Te+?=
 =?us-ascii?Q?gB6n2CqfTYkXv/gd7qVC7iHDZ6jf/cwjhTxWOdmOGhhIkIYJpmrfyqUykmNS?=
 =?us-ascii?Q?TAkj8qXSzNNrgSjzo0k1XncXO5aL5NJmGt4+e2aVtMucnmhSr0P2454KAPhU?=
 =?us-ascii?Q?ZOE4Cww5Mj18+eU4p3YPWC4QWuUyvsdSy7zGm64ftsjZIUWz6GMhrbFPG31d?=
 =?us-ascii?Q?5oq2BnVyjAR+m3NI2RsHE0BW2RQqIjaYYZ2sAb0Q3r3QcKZJlUdg4JkIXanT?=
 =?us-ascii?Q?WiC5ci83aZOeNEUNX7BPnq4rtZUFiOHMh0LVcQDw4pHs25t9r+I2l0OFnp7r?=
 =?us-ascii?Q?BNRwX31atezIhoEIMnhUuFK9BVJwXprEq2HSkB6uaYe4dN+SF7NhHFDFU+/f?=
 =?us-ascii?Q?pF4MNVSeS+GoTRtUTJS4JRB04NuJtDiPFdKYWRTU7wiKKDzm35oszaS8Fs10?=
 =?us-ascii?Q?4KUBaJjVHbI+iyosgB1ekFmbZiB3Z2YldBF/mMCiawIIaNhgvS+QNuS9C5w1?=
 =?us-ascii?Q?5P1c+MmWyTZh4ymQkrEV+KgdMiOrbwvEWOq1X78w5p37RnbeZX42hYCyi0Pl?=
 =?us-ascii?Q?EQUYY4OfFlxwxIkiNRus6VZ9CZ53o233asIeqCOlsiFpj1MJtCgjF+lvJiRN?=
 =?us-ascii?Q?zzVdHEBHNXXTIrdZ+dx85POWtzRJD7sv56S/VJzlQKXKlrYKyJFjPyImk7ZW?=
 =?us-ascii?Q?PkRtL/UQ5CYNcN38DllL4Bj1BjHgRPTEJ4LgMl539wwWvJfKR7+2+nM9X+4s?=
 =?us-ascii?Q?Err20xjJUUiWPvlJcAKZTbZltKy8Ll5YG8UPTTZ2JDX2yeN7+S6/v3zGGUNG?=
 =?us-ascii?Q?4fIdTRhXVj2bWF7jSquvIsB2YU7vQCVfgUrQwvhhvlFLRt0tdn2JATCfROPM?=
 =?us-ascii?Q?6gCTn2RqvgyCsDxEnWdm6EIZwcN2sEjbfT3F3jiGdwRolTZMOluvSn0eLj6w?=
 =?us-ascii?Q?WuGM7t3ty1nsD5EL427DPa4Cpcn9fl/UylIJ92mlobccfMSvVGBtWf/3F99s?=
 =?us-ascii?Q?mSBPF4Y8EUMlsJpyP7cpo+tf5GO6vvP1eKxHnc2n79jbkqcbzjIhWWd5Qur0?=
 =?us-ascii?Q?XBxo6vADbxnUt4TYPmFGuFbvoYpLi5j7ln/hOm4FDMV5+ilUzNIFFMvXL/hW?=
 =?us-ascii?Q?/rjA8pCM2cvCU/PgCDgs6ocHgwja0bGvz+L83A9cckRtmGWmNbrgp/oj9CCa?=
 =?us-ascii?Q?4XRL0uNJMworY4gVtNoALfgrC0WstV46Aj9fAzgtVr6an2/nKnLgkscDZfka?=
 =?us-ascii?Q?5fqwE5HuW8glqr5p0jGTYdT57o4LL8znTjU49oSj33yMT20/W5ie8PPCOrGE?=
 =?us-ascii?Q?ucAlFjdVESdLpdQ6vFlz66BCPzoE6huT0LHYNMZ62oXBgr2OUsjM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b5875f-27b5-47a3-08c7-08da165e3412
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 17:11:48.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbtG5l/I6YJ7zA45TM5wgGwyoCCnvMH5OHQvGd65msj0hP084KZpTOmiOhgYhkKSqQNZL14f69r4HBywIAoh/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3916
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040098
X-Proofpoint-ORIG-GUID: 7lBrBbMwGZAgA0-ERmT5X51-R6h5rdbY
X-Proofpoint-GUID: 7lBrBbMwGZAgA0-ERmT5X51-R6h5rdbY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 4 Apr 2022, Ilya Leoshkevich wrote:

> attach_probe selftest fails on aarch64 with `failed to create kprobe
> 'sys_nanosleep+0x0' perf event: No such file or directory`. This is
> because, like on several other architectures, nanosleep has a prefix.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks for adding this! I'm seeing a clean test pass on aarch64 now:

Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/test_progs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 93c1ff705533..eec4c7385b14 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -332,6 +332,8 @@ int trigger_module_test_write(int write_sz);
>  #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
>  #elif defined(__s390x__)
>  #define SYS_NANOSLEEP_KPROBE_NAME "__s390x_sys_nanosleep"
> +#elif defined(__aarch64__)
> +#define SYS_NANOSLEEP_KPROBE_NAME "__arm64_sys_nanosleep"
>  #else
>  #define SYS_NANOSLEEP_KPROBE_NAME "sys_nanosleep"
>  #endif
> -- 
> 2.35.1
> 
> 
