Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14AF4B5E19
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 00:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiBNXOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 18:14:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBNXOr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 18:14:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC171B10FA
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 15:14:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ELiMOg014437;
        Mon, 14 Feb 2022 23:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=kFsB2FyAr2a503VISkq7n8Rvn7KaP1ZbMv6PHqSKNYw=;
 b=sSFlzOQb+WcHJqido7rULU1dLZNyqXl/9U899/iIkl8TZDQGI3WUUro39xV26u3k32uw
 hXo/cSBUFqqjkFaxKIfHtqDxpYBe0l0xPy6kt+ZZfBRNDvqyFTwjJBYBi7Iz6DorFv93
 qZmy068vg12JUJkptvIDlHXOtHWAIUgtEoxpQHmA+P2WqgmOVzOjQba3C3M0NFYJPiyC
 gefqSd58nXsIR5JeQiK9oOzubvkYPp9qnBml+0/pAoTlo7yp0EMIO6B9H7pHOH+TehKZ
 U6kzw9RV4GjlXPZIJFMSvOvK0h2tk9m7yeK6xUbT8WjIAaliqdwbyR2TgkBKzOOaBPcL 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbwtyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 23:14:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EN6SlV058800;
        Mon, 14 Feb 2022 23:14:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 3e62xdtn72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 23:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrfA+7ZZ6lRbIuMaI2/7m+k1xW2UWbvN+YXqGRQoPl31e4flyXSJN9j3nCuqzo8P5FLIJgLyRR8eDOOzhjPnLjZH6hHPhMCU94DhBax4UEOwf44/fQkWPwNWW9vWRXlOP9gfMLqIjSP7zI/V+elNS5lBQM7ROgKLCVROz089Kbe4Y7OOvPTrDLuWrdT/gK9lRFDH9fo0AAkh9y/tKDVR/sfSXNhgKKnz0FaSd6BCfIO47EaPFl85z5McrpqpN2no+sTcWmiRHiJVWxj+tAMLduLHLWSZgVc6fF6oBVCbpvPJLzKuW/3q0hmv+m/G4ZVHbzVOpmMQBzo5uTdn01W1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFsB2FyAr2a503VISkq7n8Rvn7KaP1ZbMv6PHqSKNYw=;
 b=TuT2Tdm+NFQxy6WdrBZ38p7H9ZppAvBlkPgPIMbI/NErLEVnG+wCxUEz7MHh2U+y8U1tMC5JDBniKQx7UYhtOBDjONRtFGAFh97gq4yvNyv1b3WpgiPGElafMvijsULYOPMFtqGi14pv8ZhigaJXTXbiplnF/DD6DfygBfrzTbmQow6KvWocvj1kCvm0u9yp2WI8w1IBETi6sRXuj5gmEU6WYJW3RAuuXI79ScgSy6y6auoCB1WLtGiMMkCm3M2jRd1XwRi5EcxqLjHbTentVxEzPvOYtiHoG1LeSKDW0cHn9kxRJRJxisTQrlCX2GIX3lVvYkSl2oXYGBUHayjtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFsB2FyAr2a503VISkq7n8Rvn7KaP1ZbMv6PHqSKNYw=;
 b=YSWU3/7N/8ped39kNhTWD/lyp2Y3Z4AiRI6xOk8fwXTgaViahL2dQkJmTVNZGonFtSPEBtFI/UC/TxaA41aUo+xfgiX4zP1VCOsrdBFGTGqu0fQqMRYTRkAG2yaN/X/hl2tOA4Dtxh6puEvh2qn9YCtl1sbt39XO5dqxhdKkqHs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB2716.namprd10.prod.outlook.com (2603:10b6:5:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 23:14:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931%3]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 23:14:04 +0000
Date:   Mon, 14 Feb 2022 23:13:38 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling
 selftest
In-Reply-To: <20220214172747.o6xr3pfvvt7545wk@ast-mbp.dhcp.thefacebook.com>
Message-ID: <alpine.LRH.2.23.451.2202142305590.25685@MyRouter>
References: <20220211211450.2224877-1-andrii@kernel.org> <20220211211450.2224877-4-andrii@kernel.org> <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com> <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com>
 <20220212001832.2dajubav5tqwaimn@ast-mbp.dhcp.thefacebook.com> <CAEf4BzY_tQQ3sTmTwx_uFAg3Z50ckWf1MWgCy-ZR==gV65e3Mw@mail.gmail.com> <20220214172747.o6xr3pfvvt7545wk@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: TYAPR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0082a1d2-af4a-4d6a-b301-08d9f00fb166
X-MS-TrafficTypeDiagnostic: DM6PR10MB2716:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB27160541ECDCA1477358F009EF339@DM6PR10MB2716.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2InaWi6hnb5pZaZpHCV8riTUUi04AEBwCEV4vG9ilMQyM3IXK8r9uXn1Sjri1Dq1U5RbQgBuZyJITXP2j8SoraQrOvwkUthejyswTM34L7kd+Jvl+MWzEOVI6NtzJQbntMFe6mBLEJV298lSsWuDgsWbThuHd4JD2seqlojMVZ+MUNpi90HguWQToVdLYlan05cSDK2747K5kM63bbHyRAw5Gxzf+qzHrYZpLZ+xkNEN3p5ZJAq5A0GPHZwIFAWvJndQGzTIP21Tk8pFiDtfBwpgjlBBB0jX0ikJn6kWyCzcsNcMscVo3RcEZJGAtOMq/+lWAdGHkKwBsN8ZGtqmvWL0aJ4ZvlzdOeADBlyvkJ1dfen+0RToooufnJdhEnHplQrs13xBkxxp9BWoD3Eoz0XtnltJCWK9mlCYXjSlPR2Gdz1Sob/0OClgbnoepGYaTJttZd+/5R749XO0u5mgO6iZ+k8jBztAuAwBCARc5K+jUgGigcm/564HMhPmwWOb9A71i3KC3or7Urjg/W1uXKBMT6ksEsiPCwLlSwHRhpvgjbKSzLQjUoj9GE+AnXahDsAzouOsAehzb4BTg+nsinqPz6Tso2Yqn2MbXIpH2G7QkzjkIfNLj/QtkisGxoluqbL/OwUdnkUbUQ1efApIqfLL7Fdb/2ZyX2bzffB5QKh6Ykavi4jUg9/0pzlz/DQj1umewTgywVCpyfp07VWstQ3agc0jz8FIiNZVRKEm90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(4326008)(966005)(6506007)(186003)(66556008)(6486002)(66946007)(316002)(8676002)(66476007)(2906002)(6916009)(6512007)(9686003)(5660300002)(107886003)(86362001)(54906003)(83380400001)(38100700002)(33716001)(53546011)(52116002)(6666004)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ih+m6hW9kk3ssX9UyxzlQhg8W0+Wpd1DWkaWDSxBmaW589PgY9b7rMKHI3HH?=
 =?us-ascii?Q?nX1ToKMtS9L3uYeziygJ4xeJXCTYyPlLv52B3GmaHGuhP/5j5YIMDsw9FAfD?=
 =?us-ascii?Q?plr2S1nYiyxhq2mOQ4W6KJ8m1hWJWU8J3T3J4WnKSrnWxxS1zLJMVMLZkhlj?=
 =?us-ascii?Q?tZVrlhiUQ40c8wIFfzNTxEUwhO4BYojG/YwH73t5FYWG3JJGRi4NE0+wa52w?=
 =?us-ascii?Q?KIHpvgPybB5WWwJN42HPuAym/dl0kpItzjH4X3KuB5VgNde2/z+2jH0V40c/?=
 =?us-ascii?Q?GSRWJIxuFt72AK9SjvR5W2/B+eNleWcMq/8SZ5ocIVidoN4LRHX8Df9deD2D?=
 =?us-ascii?Q?ATWp8IumesneDWVTLoFY9pr3ijshvBppSoeLaraxOtZGUJswf9DlkcOVlTbu?=
 =?us-ascii?Q?JuJ15U5LvlupKCKGBWwBgD0JePd/Wp2Io/fKCxxH2FEyKEApbxRvByXjudcL?=
 =?us-ascii?Q?cdLnMtKvS0pbf/bSvaAOraWzhGrJKW8EP2WXfagP/NZELw3yDCzOyb4U9Btm?=
 =?us-ascii?Q?n2qJBfkFdLCtQdtplPvMLpD47YyO2kzvbBfAVd5iIUcC6VhGLPfjN8YKnoKU?=
 =?us-ascii?Q?PbSfHj2iY4mKHAIA1ttTeE2f+rioSj0W6qQ9v6CbE3BwLeJXTdQ+/bhaNv/U?=
 =?us-ascii?Q?GPQgqQWEzGk+THlDKG+lQp1JlGQ8Q2wKHV0xAmD/XJJZh6769psEbuiy9ceU?=
 =?us-ascii?Q?MkhD0kojWCGm1kDqD/jcoGg7BUraBmsb5goPI21kEhQLqV+XYc4vzF0+xJMF?=
 =?us-ascii?Q?HcGQqjhkxtBDjh7Ej3kEHTi+wuIGR6Vk90HFqjXDT0ZKOibwp+ecUHUOKl1R?=
 =?us-ascii?Q?2tXocjl1mZ299BrrWjOvTsCXpuN55k/707hG8FkpzK1Vgw7EDiLj2WU6Ph1B?=
 =?us-ascii?Q?pCjer9W+kNOwnC0bq+9ZpAYMmMnGSZZUqeW1AcnCOckPrQ8unPe/3GMKEbUd?=
 =?us-ascii?Q?A3Kg7bAdJUrJ+3EtdW1mJagtiCQpatcAkyB4s9e8bwQzSTy+RkbW+v5Dd8LA?=
 =?us-ascii?Q?SoReLaVBgSPg1OfU4rUIIQY4YW4nrz/a1ytWLHauHpK36q/k2xehdDsccP+9?=
 =?us-ascii?Q?zHBjIEPqMEHczvRyZGJeNZ0Urv8RSeh5AF3IlDf6EUSJouf24E437rVjMPGw?=
 =?us-ascii?Q?LZZElS/mB2MXI+8JTc8qiIw6Io9PuSYUZSn+TbzYKnHnsRs28xVL2+C7lMPu?=
 =?us-ascii?Q?IYdNwPyWlsYXB/BLRHboAywwuM5pV12DBev5YmuNKVi5CfRiWH/GyzDTr8rb?=
 =?us-ascii?Q?JYdo54BMd7gV1TdBMX3S061eLXHPe+z6TPUSxvrftqc9QQXSQWuWwGHnNF6v?=
 =?us-ascii?Q?n+/bfKtrBOAR705+izgPI05zbAyAg735byX18hiW5D2WlFxjxoGWSLAQxbI9?=
 =?us-ascii?Q?io7fmF4HNl3al0CFHKQXmsCbzk+6MhyvPD0KWRjJMK4vWfIVtov72Ra9nj36?=
 =?us-ascii?Q?jbrxpCmbJnzkvyLMEcz2FMdke/sCGGwvTpuHhY7Sx3Kh51QEArRs1EDZwWKm?=
 =?us-ascii?Q?R6eyJodqKEYPnsjyfuF1ODR4nzWxKvJB8agNWpH9R/HfZBPxgxAyxzi+0kXA?=
 =?us-ascii?Q?S86d95fGyGTqY7TnK7GYakgoXWt5uAjalRBSzkAOo4w96/nw0TCqmWFQsBCp?=
 =?us-ascii?Q?Ve5ICvF4JuzuzaeAJT9nHgyMC1lhXka4jAAD5eUOtBkF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0082a1d2-af4a-4d6a-b301-08d9f00fb166
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 23:14:04.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBwru7cIi4ZYmSvpp01LUSmwm4EkVGC4JN5fXNAWf6IWCts4LuPEkUhfKc/INFbqv/vaKxxcHVRs63qhlrqYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2716
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140132
X-Proofpoint-GUID: IcfeEg3wnPDI-oDNqxGyHw-SLcvUK-53
X-Proofpoint-ORIG-GUID: IcfeEg3wnPDI-oDNqxGyHw-SLcvUK-53
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 14 Feb 2022, Alexei Starovoitov wrote:

> Alan,
> can you demo your "okprobe" feature based on this api?
> Any rough patches would do.

sure; see below.  Requires Andrii's v3 patches to be applied first,
and demonstrates okprobe handling for a kprobe function that exists
and one that doesn't - the important thing is skeleton attach
can succeed even when a function is missing (as it would be if
the associated module wasn't loaded).

> The "o" handling will be done in which callback?
> 

We set program type at init and do custom attach using the function
name (specified in the program section after the "okprobe" prefix).  
However we make sure to catch -ENOENT attach failures and return 0
with a NULL link so skeleton attach can proceed.

From 9bbd615b71f8f59ff743608bc86d7a2a346da2a8 Mon Sep 17 00:00:00 2001
From: Alan Maguire <alan.maguire@oracle.com>
Date: Mon, 14 Feb 2022 22:57:56 +0000
Subject: [PATCH bpf-next] selftests/bpf: demonstrate further use of custom
 SEC() handling

Register and use SEC() handling for "okprobe/" kprobe programs
(Optional kprobe) which should be attached as kprobes but
critically should not stop skeleton loading if attach fails
due to non-existence of the to-be-probed function.  This mode
of SEC() handling is useful for tracing module functions
where the module might not be loaded.

Note - this patch is based on the v3 of Andrii's section
handling patches [1] and these need to be applied for it to
apply cleanly.

[1] https://lore.kernel.org/bpf/20220211211450.2224877-1-andrii@kernel.org/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/custom_sec_handlers.c | 33 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_custom_sec_handlers.c | 17 +++++++++++
 2 files changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
index 2826452..5da1375 100644
--- a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
+++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
@@ -9,11 +9,14 @@
 #define COOKIE_CUSTOM 3
 #define COOKIE_FALLBACK 4
 #define COOKIE_KPROBE 5
+#define COOKIE_OKPROBE 6
 
 static int custom_init_prog(struct bpf_program *prog, long cookie)
 {
 	if (cookie == COOKIE_ABC1)
 		bpf_program__set_autoload(prog, false);
+	else if (cookie == COOKIE_OKPROBE)
+		bpf_program__set_type(prog, BPF_PROG_TYPE_KPROBE);
 
 	return 0;
 }
@@ -32,6 +35,8 @@ static int custom_preload_prog(struct bpf_program *prog,
 static int custom_attach_prog(const struct bpf_program *prog, long cookie,
 			      struct bpf_link **link)
 {
+	const char *func_name;
+
 	switch (cookie) {
 	case COOKIE_ABC2:
 		*link = bpf_program__attach_raw_tracepoint(prog, "sys_enter");
@@ -39,6 +44,15 @@ static int custom_attach_prog(const struct bpf_program *prog, long cookie,
 	case COOKIE_CUSTOM:
 		*link = bpf_program__attach_tracepoint(prog, "syscalls", "sys_enter_nanosleep");
 		return libbpf_get_error(*link);
+	case COOKIE_OKPROBE:
+		func_name = bpf_program__section_name(prog) + strlen("okprobe/");
+		*link = bpf_program__attach_kprobe(prog, false, func_name);
+		/* it's ok if func doesn't exist. */
+		if (libbpf_get_error(*link) == -ENOENT) {
+			*link = NULL;
+			return 0;
+		}
+		return libbpf_get_error(*link);
 	case COOKIE_KPROBE:
 	case COOKIE_FALLBACK:
 		/* no auto-attach for SEC("xyz") and SEC("kprobe") */
@@ -55,6 +69,7 @@ static int custom_attach_prog(const struct bpf_program *prog, long cookie,
 static int custom_id;
 static int fallback_id;
 static int kprobe_id;
+static int okprobe_id;
 
 __attribute__((constructor))
 static void register_sec_handlers(void)
@@ -77,10 +92,18 @@ static void register_sec_handlers(void)
 		.preload_fn = NULL,
 		.attach_fn = custom_attach_prog,
 	);
+	LIBBPF_OPTS(libbpf_prog_handler_opts, okprobe_opts,
+		.cookie = COOKIE_OKPROBE,
+		.init_fn = custom_init_prog,
+		.preload_fn = NULL,
+		.attach_fn = custom_attach_prog,
+	);
 
+	
 	abc1_id = libbpf_register_prog_handler("abc", BPF_PROG_TYPE_RAW_TRACEPOINT, 0, &abc1_opts);
 	abc2_id = libbpf_register_prog_handler("abc/", BPF_PROG_TYPE_RAW_TRACEPOINT, 0, &abc2_opts);
 	custom_id = libbpf_register_prog_handler("custom+", BPF_PROG_TYPE_TRACEPOINT, 0, &custom_opts);
+	okprobe_id = libbpf_register_prog_handler("okprobe/", BPF_PROG_TYPE_KPROBE, 0, &okprobe_opts);
 }
 
 __attribute__((destructor))
@@ -89,6 +112,7 @@ static void unregister_sec_handlers(void)
 	libbpf_unregister_prog_handler(abc1_id);
 	libbpf_unregister_prog_handler(abc2_id);
 	libbpf_unregister_prog_handler(custom_id);
+	libbpf_unregister_prog_handler(okprobe_id);
 }
 
 void test_custom_sec_handlers(void)
@@ -104,6 +128,7 @@ void test_custom_sec_handlers(void)
 	ASSERT_GT(abc1_id, 0, "abc1_id");
 	ASSERT_GT(abc2_id, 0, "abc2_id");
 	ASSERT_GT(custom_id, 0, "custom_id");
+	ASSERT_GT(okprobe_id, 0, "okprobe_id");
 
 	/* override libbpf's handle of SEC("kprobe/...") but also allow pure
 	 * SEC("kprobe") due to "kprobe+" specifier. Register it as
@@ -138,6 +163,8 @@ void test_custom_sec_handlers(void)
 	ASSERT_EQ(bpf_program__type(skel->progs.custom2), BPF_PROG_TYPE_TRACEPOINT, "custom2_type");
 	ASSERT_EQ(bpf_program__type(skel->progs.kprobe1), BPF_PROG_TYPE_TRACEPOINT, "kprobe1_type");
 	ASSERT_EQ(bpf_program__type(skel->progs.xyz), BPF_PROG_TYPE_SYSCALL, "xyz_type");
+	ASSERT_EQ(bpf_program__type(skel->progs.kprobe2), BPF_PROG_TYPE_KPROBE, "kprobe2_type");
+	ASSERT_EQ(bpf_program__type(skel->progs.kprobe3), BPF_PROG_TYPE_KPROBE, "kprobe3_type");
 
 	skel->rodata->my_pid = getpid();
 
@@ -167,6 +194,12 @@ void test_custom_sec_handlers(void)
 	ASSERT_FALSE(skel->bss->kprobe1_called, "kprobe1_called");
 	/* SEC("xyz") shouldn't be auto-attached */
 	ASSERT_FALSE(skel->bss->xyz_called, "xyz_called");
+	/* SEC("okprobe/sys_nanosleep") should be auto-attached */
+	ASSERT_TRUE(skel->bss->kprobe2_called, "kprobe2_called");
+	/* SEC("okprobe/nonexistent_function") shouldn't attach, but
+	 * this shouldn't prevent overall skeleton attach.
+	 */
+	ASSERT_FALSE(skel->bss->kprobe3_called, "kprobe3_called");
 
 cleanup:
 	test_custom_sec_handlers__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
index 4061f70..6e9e051f 100644
--- a/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
+++ b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
@@ -4,6 +4,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
 
 const volatile int my_pid;
 
@@ -12,6 +13,8 @@
 bool custom1_called;
 bool custom2_called;
 bool kprobe1_called;
+bool kprobe2_called;
+bool kprobe3_called;
 bool xyz_called;
 
 SEC("abc")
@@ -60,4 +63,18 @@ int xyz(void *ctx)
 	return 0;
 }
 
+SEC("okprobe/" SYS_PREFIX "sys_nanosleep")
+int kprobe2(void *ctx)
+{
+	kprobe2_called = true;
+	return 0;
+}
+
+SEC("okprobe/nonexistent_function")
+int kprobe3(void *ctx)
+{
+	kprobe3_called = true;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
1.8.3.1

