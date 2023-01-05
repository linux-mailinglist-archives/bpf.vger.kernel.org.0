Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12D565F3A6
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 19:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjAES0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 13:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjAES0w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 13:26:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115654D85
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 10:26:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IKduO014531;
        Thu, 5 Jan 2023 18:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=8pfIF5zgE5DdQFDVKFz31qJr+t975u08QKmkoMMNCy8=;
 b=0VYH0qs0OUknTLoq0I08S/AVHO0+daykj0ZdLY5nvOpnsR0mz8g+JOE76swmIrA8YaQq
 NgJ+znItZ8scW26S85rd5tbgTG/Y4JZWaCYFwmwh02nfrsmTrzFjiYBUAPDZ8M2BiEYt
 qEt3MCasjjxJiiiAkjiTSZ3zhhUP1bNkClIAv6WhcZpN8MzDGjmKPwkMUY3DXhUMPZb6
 2gPLcB/T2HcVQj8uOHlEhO865Vm7opsa2oIvOeLwT7tO7Ud2ZGJ3tfsxDpRjh+nofpNt
 h2PJdXLG5MRVpjuUXWzbzy+Q1daX+yU9p6wtYLdD8Z/vxorSJvros4iQYRgkdpCP5b9w ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp11k7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 18:26:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I4QYT033779;
        Thu, 5 Jan 2023 18:26:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf60rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 18:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5PonOswl8sDF5YUzh9pYq+Mm6iyNkpBVIn268Uq7kH/JJOBbtqXKXRQLccJ7K3jktyN2Iey89MU/2NrQtdoEy8u2q5dJzjdbnJ8fM5qTvv0gFMHC8+aBvIXCAHvPGOzGDJ5qhprNlMtWk0adKaiKlcFV9Ssecj+YaJH2/XN70JJWBjNPf20HAcwXGhTLEF99jaODPwJlJRdhgpxPCRL2ltHPkN1O4QoAH7ng4+qTnUiODe2fRPBsYg8uRqagSlrg4bnzJbXezBvYszU3h7WFLT4xS/N/Pt++3JjHgX77ugHuEiuG5G518eIyl6msPLnrP4GP8hIR95F8cuyvEH+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pfIF5zgE5DdQFDVKFz31qJr+t975u08QKmkoMMNCy8=;
 b=kSBlcfCu+6y2avBcaqyBQhR7r5eRnc01gpzgutOKRI4eoLmA3XxPa07FS1fQp4P0OKb5MM3E5RrhCfliAsjENF1Q5uE/cvvmCSoZeIg3PT058VfMmS699IRQDdcNGFyzzc14v2idJON60rjGK40un5T7jWrXhN/uzE3BwRdcuwK82PQZpiEgevCoI2a7D2TufORCgsbYi/VhG/FzcVnkfuAb8BMdYJxByTpafZ15TkkjTymTCayQJtmXhCIVS0iJ8LkKx3K41YHCk8dl89D6jM/y1MHWuZQdBlJDhcMmn4/riYZXAaDDJ7B9zQwTqppsGf7hbV5XqlfrQ07Kb0HLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pfIF5zgE5DdQFDVKFz31qJr+t975u08QKmkoMMNCy8=;
 b=dKIGBIHkPmA09jdNuwKdXTXtQu19UQ5+dROZMXn9MjYlnzP3p/2ZYwpFL4Ayoktb6JEew0vhVWCjYVuBTziCKQV+DRyWJ/szLuvuUcsGqeGKRuQjiS16kbP6Q5tNqXsenEsgUTKQz/yl9Y5op/+UZ9vq/g2KGpn+DADpLL0DNf0=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SA3PR10MB7070.namprd10.prod.outlook.com (2603:10b6:806:311::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 18:26:32 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 18:26:32 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf@vger.kernel.org
Cc:     david.faust@oracle.com, James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
References: <87r0w9jjoq.fsf@oracle.com>
Date:   Thu, 05 Jan 2023 19:30:42 +0100
In-Reply-To: <87r0w9jjoq.fsf@oracle.com> (Jose E. Marchesi's message of "Thu,
        05 Jan 2023 12:37:57 +0100")
Message-ID: <877cy0j0kt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SA3PR10MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1a6c44-a887-4bb5-56e1-08daef4a5ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JppRNdsLhtw5FasyKSy/oaehxbzc3A/cyVm16oE3+4e3CQa/iNCvi0fOJpqr+yHkwgG5Xv8g770B0iVnTyPWsQktqwvUhK16JArKLvDEQraAKxH55giuXgBgKIjZMFKQ+gPPvcu59ai20QgxNJE1aTGXX+cdwqRsetZY/+1fnahlLBKBzWLiUf0lAeqeF3bsXwvWes06l1rc856Ol9oTtf+69KEChLO/73+zWwR+Lij93KfD1hYtpZJsazZsrsgDEDWt38C4mkpma7Igm4TUQNXajRFur/qiuHFQK92NmsXhooWfeS2EmrXqxu+Q09mJndQnDFtFnLcN3eTZcMMWwd1zp3LKCwGao0nFqr/rszTQNdkUZSQBnZG5hMjHVblXSntdrls1BLrkVXlhiuRWxoO8Vb37bhmrjRu03+XuosFOgsXv9Eu1J/l82VoCEur7W8xh4r5oH4j2Hxukel8UBbZBGimyaoOL7KMQGqr/GpP5oRnUyoBGHAZ9vFLcfEIpuAJrbQUp15NcIizLqAn4sgnG+6Ozf/AGlDhOQ9OyDD+Cd/Jrjd+gLSgEnZPq0bjpwIKQbVFS9s+Gd78o/m7Dc9+oR04Q+T92+FnHigdzLRrD9jqlSzymUid2mRuiCOJMCNbytKfut4+z7TEk0F/M3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(83380400001)(5660300002)(8936002)(30864003)(2906002)(41300700001)(86362001)(36756003)(6916009)(186003)(26005)(66899015)(54906003)(6512007)(6666004)(107886003)(316002)(2616005)(38100700002)(6506007)(6486002)(8676002)(66946007)(66476007)(478600001)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LcP5ALs/d29VhpSiGr6Dpa61V1fmdxMn54bt8K2mnpsCsjGhDHH7QqWBoMM3?=
 =?us-ascii?Q?d7Gg4RXyRF4oClL1j+XG/4kkJs4fWTtchRY/HBIZzTLzyn3oPLKeRnYMP7WD?=
 =?us-ascii?Q?hnCcagZvW04LhsD4lCG/mEzP0QJUVS7iUBbk0e0z3L55/TT3ydXXhzaXC45z?=
 =?us-ascii?Q?lNBNTz7KGufUNQGq/pzzMTi9H0++41+KlE3Jf7nY057bVXfy+XF0HsUqK+Eb?=
 =?us-ascii?Q?YT88V0OJ60wiP98i5rd5xJCLyA+t3oKIMBsKR9ypencrbFhfMtz1ItjJzFyG?=
 =?us-ascii?Q?lF4y7X9fOXuAYjrJgqFtmHHzVzLw6eXN7iJwu1xwHkaaxxNLe9cAg6fH1DJy?=
 =?us-ascii?Q?hLuvEgF31vrwLogiP+yKxp3iFrUO0IbAa4tjnobDC/ALdSQf4pISqSHorJZA?=
 =?us-ascii?Q?ib7nIZ6O5kVSCfA6T76G9HB9etvjZ5HdeASIrzhsffnhKlIbB2Qk8fx9tG6/?=
 =?us-ascii?Q?iMEXRr/+UtXv8VUjJsEGPL0gWPrD15Bycb/Vs4w31ECZzCQYZ3rER0SDewEt?=
 =?us-ascii?Q?QAn5KABEDLmr9e93I3c3mqnXCaWoTdM98WNJlX14lFaD3xv+6oL/KR5gei6G?=
 =?us-ascii?Q?UpRHF9bT7Jw3Sjgq3N0WwK9zTfonkXAuY7YoFVqt5mOsuKYAwvE9mbgMyzIW?=
 =?us-ascii?Q?fOenEGGv9QXTPWEqqwq0CLVIw74TCYL5zGq6oyTHSt9BN0JhlTYXmnpB87M0?=
 =?us-ascii?Q?g0hYjatg9j00zegnA0rsMwXEYpmi8KJ7w/gC7dMNepU72SNLsEXej5T4wnWv?=
 =?us-ascii?Q?yh/Fv94cH6DPf8CxdrHDzB3izWlBrk1tr4HLA68Igx3rVNMiD+Ro+hYO+qLP?=
 =?us-ascii?Q?jb/HcijgY6+LG4v7P/4bN8Wso6L7lLGLEyImddZPsJnQufqewBidSuS1kkMv?=
 =?us-ascii?Q?q7o4chc48qbqHErMD5RTMKAuRBeGI3IX3sAD4qh/sP0heXn9Inc3sGJfK5jz?=
 =?us-ascii?Q?+FjBNm9uu3VJuRctqoIvQleLCx02ap59U0bTZ7hBi321e0WnjzUzM7//PhFe?=
 =?us-ascii?Q?9rc2sMNPnBWZTbSsPmir4AiOl5t1e0Ml1w7mVmnyvCUkcqoAeDrSXhK/7Ilc?=
 =?us-ascii?Q?Id7w61kulwGR5yKN0LHHo8WaYPr9f8xfK6CQXfGiY31jGAo/HyfDTk8s2GNt?=
 =?us-ascii?Q?FcubUfHif2+Z1okRUn9hW4285pffZn9jP9ZY0OGFk/32QPRCGLgqfmdk952N?=
 =?us-ascii?Q?zvsWxWw2PUgTwq8e5teX4rLStKJui93xhhGpnuKrXcyHU5+CySx5vFwsADef?=
 =?us-ascii?Q?mEVWhwwFYjwgKmigYGmKu+l51r9s67UPTXd1DWFhlsFBhJEG1dTTmg43PyGh?=
 =?us-ascii?Q?jF29eihUzlKKPrtA1GYOdEi2innDUm6nFtMfpobvAa0gP03nQ2OXglvuBpsp?=
 =?us-ascii?Q?3A3QlgPmW7ktB+41ZiioG1g3SRaTiMVqG+UaCRsHXmg7YIQcmcGypxFJrYwS?=
 =?us-ascii?Q?TuzQK+XdK8UMjOpgQKee1FUXHn2PVhZCj28pbLTXqCoKVkb/B4ZDHqW0+l5v?=
 =?us-ascii?Q?ajEfsMGQvbjMbwbayG6aUetRbHoECjMDjvrhUvTg2HBNJS3BeoSMQgxJ24Md?=
 =?us-ascii?Q?HLsY1DVuIxMWF/YR0NV/xkdTdKj873aj89SMlQBCXtlUHU9ZBS6FufOTzooB?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1K5oaAi6/XuVGfTiM94b25WP8gFEIGcF9f3itO5k8pwe9nhIkKoSkeQDn8Na8j9elwcBntcYGzyQEKjd0d0UYC076m3N/SViYKlJrnvoKdmDrJpsgNIJJNjunDT8S3Dc+p1P1xjUYu9ovtOKSexSVPugDBHHxv39h1bro9w2pK+3RD5HeP9KOhSFP23WIKkvZJgJvB2IfN10iKVk9v8Jnw52jKgf05886lIUozhSoMqK6T2ySHOUz85r22l87VON7GnGf+kaqAbCKqZwKe1Xwn6V1bxSPAiT4kmTXQiC1dS6ohvM/KDrjj96c0exAIEpniTrqPErgucR04dev49nZVFHIyfKTH5406pmGTR+wGj3CsSR/kh2aaOuXDvsDOFgukpDkHlNRK/kmSHUAObvlggkcUJeq1RxV8FdSTzcOMP2fre3DUbiiglt2LdNcO4SMLIszAR5Cyi7ZSUIAZofHz4pdz3LGnfU4er8vkbkRv7ytts/8IAxRcXlp3lXmgMhPXuaVv01cdWPgM7zXSxqDBl8YihUinCQlPyNvauPozSKonexKXMZNbilDqObDriU6eUrF7v6o67eKjVo9skLaeW7cwF37K8SDCodiz62BfKmzJU8yAjRb167bLfM/B+L1Qtxs07OO8ns80Skz+B6VkXzEhnHhh+8UrItXXmkaFmU2RTB5J7yGzYyBgUyWBIZvXitXnDN04syCPxtB//IyidJU5hlow+gv+ow3Ga5GvEru3qoHtVnh5o5zexZkSTOH0fdvz5BwQwLj7VyzqUTtkbE0YyPDM2R0623uu14lb8ITwzCO/vf/9eieHU/f1yodPxJiQsrfAfJx+Fb87t3QRYr8gEXuZsrMMuAwWQsIiH2CvxJctr7pc98Sx/NuD2I
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1a6c44-a887-4bb5-56e1-08daef4a5ee3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 18:26:32.8203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1d1fXv6ESiabbtNM/+xPtrrnJPKWQf5zIg6nzD6ovhFSHbQ8H7fWKRDwYiogR9eXOhbjrxHxEW/1SLW0QlC/8ZKTEnp+sJqbh4QyJGIv/7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_09,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050145
X-Proofpoint-GUID: Zh3BZ-MwtWrjMdPmwKy-HThYnEBEF0D2
X-Proofpoint-ORIG-GUID: Zh3BZ-MwtWrjMdPmwKy-HThYnEBEF0D2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


We agreed in the meeting to implement Solution 2 below in both GCC and
clang.

The DW_TAG_LLVM_annotation DIE number will be changed in order to make
it possible for pahole to handle the current tags.  The number of the
new tag will be shared by both GCC and clang.

Thanks everyone for the feedback.

> Hello all.
>
> Find below the notes we intend to use in today's BPF office hour to
> discuss possible solutions for the current limitations in the DWARF
> representation of the btf_type_tag C attributes, and hopefully decide on
> one so we can move forward with this.
>
> The list of suggested solutions below is of course not closed: these are
> just the ones we could think about.  Better alternatives and suggestions
> are very welcome!
>
> BTF tag support in DWARF
>
> * Current situation: annotations as children DIEs for pointees
>
>   DWARF information is structured as a tree of DIE nodes.  Nodes can
>   have attributes associated to them, as well as zero or more DIE
>   children.
>    
>   clang extends DWARF with a new tag (DIE type) =DW_TAG_LLVM_annotation=.
>   Nodes of this type are used to associate a tag name with a tag value that
>   is also a string.
>
>   Example:
>
>   :  DW_TAG_LLVM_annotation
>   :     DW_AT_name        "btf_type_tag"
>   :     DW_AT_const_value "user"
>
>   At the moment, clang generates =DW_TAG_LLVM_annotation= nodes as children
>   of =DW_TAG_pointer_type= nodes.  The intended semantic is that the
>   annotation applies to the pointed-to type.
>
>   For example (indentation reflects the parent-children tree structure):
>
>   : DW_TAG_pointer_type
>   :   DW_AT_type "int"
>   :   DW_TAG_LLVM_annotation
>   :     DW_AT_name        "btf_type_tag"
>   :     DW_AT_const_value "tag1"
>
>   The example above associates a "btf_type_tag->tag1" named annotation to the
>   type pointed by its containing pointer_type, which is "int".
>
>   This approach has the advantage that, since the new
>   =DW_TAG_LLVM_annotation= nodes are effectively used as attributes, they are
>   safely ignored by DWARF consumers that do not understand this DIE type.
>
>   But this approach also has a big caveat: types that are not pointed-to by
>   pointer types are not expressible in this design.  This obviously impacts
>   simple types such as =int= but also pointer types that are not pointees
>   themselves.
>
>   For example, it is not possible to associate the tag =__tag2= to the type
>   =int **= in this example (Note this is sparse/clang ordering.):
>
>   : int * __tag1 * __tag2 h;
>
>   - sparse
>     +  __tag1 applies to int*, __tag2 applies to int**
>     : got int *[noderef] __tag1 *[addressable] [noderef] [toplevel] __tag2 h
>   - clang
>     + According to DWARF __tag1 applies to int*, no __tag2 (??).
>     + According to BTF  __tag1 applies to int*, no __tag2 (??).
>     : DWARF
>     : 0x00000023:   DW_TAG_variable
>     :                 DW_AT_name	("h")
>     :                 DW_AT_type	(0x0000002e "int **")
>     :
>     : 0x0000002e:   DW_TAG_pointer_type
>     :                 DW_AT_type	(0x00000037 "int *")
>     :
>     : 0x00000033:     DW_TAG_LLVM_annotation
>     :                 DW_AT_name	("btf_type_tag")
>     :                 DW_AT_const_value	("tag1")
>     : BTF
>     : [1] TYPE_TAG 'tag1' type_id=3
>     : [2] PTR '(anon)' type_id=1
>     : [3] PTR '(anon)' type_id=4
>     : [4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>     : [5] VAR 'h' type_id=2, linkage=global
>     :
>     : 'h' -> ptr -> 'tag1' -> ptr -> int
>
> * A note about `void'
>
>   The DWARF specification recommends to denote the =void= C type by
>   generating a DIE with =DW_TAG_unspecified_type= and name "void".
>
>   However, both GCC and LLVM do _not_ follow this recommendation and instead
>   they denote the =void= type as the absence of a =DW_AT_type= attribute in
>   whatever containing node.
>
>   Example, for a pointer to =void=:
>
>   : 3      DW_TAG_pointer_type    [no children]
>
>   Note also that the kernel sources have sparse annotations like:
>
>   : void __user * data;
>
>   Which, using sparse ordering, means that the type which is annotated is
>   =void=.  Therefore it is very important to be able to tag the =void= basic
>   type in this design.
>
>   GDB and other DWARF consumers understand the spec-recommended way to denote
>   =void=.
>
> * Solution 1: annotations as qualifiers
>
>   A possible solution for this is to handle =DW_TAG_LLVM_annotation= the same
>   way than C type qualifiers are handled in DWARF: including them in the type
>   chain linked by =DW_AT_type= attributes.
>
>   For example:
>
>   : DW_TAG_pointer_type
>   :   DW_AT_type ("btf_type_tag")
>   :
>   : DW_TAG_LLVM_annotation
>   :   DW_AT_name        "btf_type_tag"
>   :   DW_AT_const_value "tag1"
>   :   DW_AT_type        ("int")
>   :
>   : DW_TAG_base_type
>   :   DW_AT_name ("int")
>
>   Note how now the =LLVM_annotation= has the annotated type linked by
>   =DW_AT_type=, and acts itself as a type linked from =DW_TAG_pointer_type=.
>
>   Advantages of this approach:
>
>   - It makes sense for annotations to be implemented as qualifiers, because
>     they actually qualify a target type.
>
>   - This approach is totally flexible and makes it possible to annotate any
>     type, qualified or not, pointed-to or not.
>
>   - The resulting DWARF looks like the BTF.
>
>   - It can handle annotated `void', as currently generated by GCC and
>     clang/LLVM:
>
>     :   DW_TAG_LLVM_annotation
>     :     DW_AT_name        "btf_type_tag"
>     :     DW_AT_const_value "tag1"
>     :     DW_AT_type NULL
>
>   Disadvantages of this approach:
>
>   - Implementing this is more elaborated, and it requires DWARF consumers to
>     understand this new DIE type, in order to follow the type chains in the
>     tree: =DW_TAG_LLVM_annotation= should now be expected in any =DW_AT_type=
>     reference.
>
>   - This breaks DWARF, making it very difficult to be implemented as a
>     compiler extension, and will likely require make it part of DWARF.
>
>   - This is not backwards compatible to what clang currently generates.
>
> * Solution 2: annotations as children DIEs
>
>   This approach involves keeping the =DW_TAG_LLVM_annotation= DIE, with the
>   same internal structure it has now, but associating it to the type DIE that
>   is its parent.  (Note this is not the same than being linked by a
>   =DW_AT_type= attribute like in Solution 1.)
>
>   This means that this DWARF tree:
>
>   : DW_TAG_pointer_type
>   :   DW_AT_type "int"
>   :   DW_TAG_LLVM_annotation
>   :     DW_AT_name        "btf_type_tag"
>   :     DW_AT_const_value "tag1"
>
>   Denotes an annotation that applies to the type =int*=, not the pointee type
>   =int=.
>
>   Advantages of this approach:
>
>   - This approach makes it possible to annotate any type, qualified or not,
>     pointed-to or not.
>
>   - This can easily be implemented as a compiler extension, because existing
>     DWARF consumers will happily ignore the new attributes in case they don't
>     support them;  the type chains in the tree remain the same.
>
>   - Easy to implement in GCC.
>
>   Disadvantages of this approach:
>
>   - This may result in an increased number of type nodes in the tree.  For
>     example, we may have a tagged =int*= and a non-tagged =int*=, which now
>     will have to be implemented using two different DIEs.
>    
>   - This is not backwards-compatible to what clang currently generates, in
>     the case of pointer types.
>
>   - It cannot handle annotated `void' as currently generated by GCC and
>     clang/LLVM, so for tagged =void= we would need to generate unspecified
>     types with name "void":
>
>     : DW_TAG_unspecified_type
>     :   DW_AT_name "void"
>     :   DW_TAG_LLVM_annotation
>     :     DW_AT_name        "btf_type_tag"
>     :     DW_AT_const_value "tag1"
>
>     But this should be supported by DWARF consumers, as per the DWARF spec,
>     and it is certainly recognized by GDB.
>
> * Solution 3a: annotations as set of attributes
>
>   Another possible solution is to extend DWARF with a pair of two new
>   attributes =DW_AT_annotation_tag= and =DW_AT_annotation_value=.
>
>   Annotated types will have these attributes defined.  Example:
>
>   : DW_TAG_pointer_type
>   :   DW_AT_type "int"
>   :   DW_AT_annotation_tag   "btf_type_tag"
>   :   DW_AT_annotation_value "tag1"
>
>   Note that in this example the tag applies to the pointer type, not the
>   pointee, i.e. to =int*=.
>
>   Advantages of this approach:
>
>   - This can easily be implemented as a compiler extension, because existing
>     DWARF consumers will happily ignore the new attributes in case they don't
>     support them;  the type chains in the tree remain the same.
>
>   - This is backwards compatible to what clang currently generates.
>
>   - Easy to implement in GCC.
>    
>   Disadvantages of this approach:
>
>   - This may result in an increased number of type nodes in the tree.  For
>     example, we may have a tagged =int*= and a non-tagged =int*=, which now
>     will have to be implemented using two different DIEs.
>
>   - It cannot handle annotated `void' as currently generated by GCC and
>     clang/LLVM, so for tagged =void= we would need to generate unspecified
>     types with name "void":
>
>     : DW_TAG_unspecified_type
>     :   DW_AT_name "void"
>     :   DW_AT_annotation_tag   "btf_type_tag"
>     :   DW_AT_annotation_value "tag1"
>
>     But this should be supported by DWARF consumers, as per the DWARF spec,
>     and it is certainly recognized by GDB.
>    
> * Solution 3b: annotations as single "structured" attributes
>
>   This is like 3a, but using a single attribute =DW_AT_annotation= instead of
>   two, and encoding the tag name and the tag value in the string value using
>   some convention.
>
>   For example:
>
>   : DW_TAG_pointer_type
>   :   DW_AT_type "int"
>   :   DW_AT_annotation "btf_type_tag tag1"
>
>   Meaning the tag name is "btf_type_tag" and the tag value is "tag1", using
>   the convention that a white character separates them.
>
>   Advantages over 3a:
>
>   - Using a single attribute is more robust, since it eliminates the possible
>     situation of a node having =DW_AT_annotation_tag= and not
>     =DW_AT_annotation_value=.
>
>   - It is easier to extend it, since the string stored in the
>     =DW_AT_annotation= attribute may be made as complex as desired.  Better
>     than adding more =DW_AT_annotation_FOO= attributes.
>
>   - This is backwards compatible to what clang currently generates.
>
>   - Easy to implement in GCC.
>    
>   Disadvantages over 3a:
>
>   - This requires defining conventions specifying the structure of the string
>     stored in the attribute.
>
>   - This has the danger of overzealous design: "let's store a JSON tree in
>     =DW_AT_annotation= for future extensions instead of continue bothering
>     with DWARF".
>
>   - It cannot handle annotated `void' as currently generated by GCC and
>     clang/LLVM, so for tagged =void= we would need to generate unspecified
>     types with name "void":
>
>     : DW_TAG_unspecified_type
>     :   DW_AT_name "void"
>     :   DW_AT_annotation  "btf_type_tag tag1"
>
>     But this should be supported by DWARF consumers, as per the DWARF spec,
>     and it is certainly recognized by GDB.
